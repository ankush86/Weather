class DestinationService

  def initialize(data)
    @data = data
  end

  def create_city_record
    city_names = []
    # Get destination city names
    @data.css('.detail-table__cell.text-uppercase.fdabf-td2 .visible-xs').each { |dest| city_names << dest.text }

    city_names.each do |city|
      unless Destination.all.map(&:city_name).include? city
        # Create city record with coordinate
        create_destination(city)
      end
    end
    create_temperature_notes(city_names)
  end

  private

  def create_destination(city)
    coordinate = get_coordinate(city)
    if coordinate.present?
      lat = coordinate[:lat]
      lon = coordinate[:lon]

      Destination.create(city_name: city, latitude: lat, longitude: lon)
      puts "create record for #{city}"
    else
      puts "Not get coordinate of #{city}"
    end
  end

  def get_coordinate(city)
    result = Geocoder.search(city).first
    sleep(10)
    if result.present?
      lat = result.data['lat']
      lon = result.data['lon']
      { lat: lat, lon: lon }
    end
  end

  def create_temperature_notes(city_names)
    # Get newly destination of flight
    new_destinations = Destination.where(city_name: city_names)
    # Create temperature record of that
    CityTemperatureService.new(new_destinations).create_temperature_note
  end
end
