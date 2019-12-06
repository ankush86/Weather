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
      sleep 5
      puts "Creating TemperatureNote for #{dest.city_name}"
      dest.temperature_notes.create!(time: current_time,
                                     temperature: forecast.temperature,
                                     note: '') # need to add note
    end
  end

  def get_temperature_record(dest)
    ForecastIO.forecast(dest.latitude, dest.longitude,
                        time: @current_time.to_i,
                        params: { units: 'si' })['currently']
  end
end
