class DestinationService

  def initialize(data)
    @data = data
  end

  def create_city_record
    city_names = []
    # get destination city names
    @data.css('.detail-table__cell.text-uppercase.fdabf-td2 .visible-xs').each { |dest| city_names << dest.text }

    city_names.each do |city|
      unless Destination.all.map(&:city_name).include? city
        # get coordinate of city
        result = Geocoder.search(city).first
        sleep(10)
        if result.present?
          lat = result.data['lat']
          lon = result.data['lon']

          Destination.create(city_name: city, latitude: lat, longitude: lon)
          puts "create record for #{city}"
        else
          puts "Not get coordinate of #{city}"
        end
      end
    end
  end
end
