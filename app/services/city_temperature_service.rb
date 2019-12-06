require 'forecast_io'

class CityTemperatureService
  def initialize(destinations)
    ForecastIO.api_key = Rails.application.secrets.forecast_io_key
    @destinations = destinations
    @current_time = DateTime.now
  end

  def create_temperature_note
    @destinations.each do |dest|
      # get data to table for cache 1 hour
      forecast = get_temperature_record(dest)
      city = dest.city_name
      temp = forecast.temperature

      sleep 5
      puts "Creating TemperatureNote for #{city}"
      dest.temperature_notes.create!(time: @current_time,
                                     temperature: temp,
                                     note: get_note(city, temp))
    end
  end

  private

  def get_temperature_record(dest)
    ForecastIO.forecast(dest.latitude, dest.longitude,
                        time: @current_time.to_i,
                        params: { units: 'si' })['currently']
  end

  def get_note(_city, temp)
    if temp > 25
      "Let's go for a pint"
    elsif temp < 5
      '!Que frio!'
    else
      'Its wonderful day'
    end
  end
end
