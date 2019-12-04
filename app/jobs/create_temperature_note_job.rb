require 'forecast_io'

class CreateTemperatureNoteJob < ApplicationJob
  queue_as :default

  def perform(_args)
    ForecastIO.api_key = Rails.application.secrets.forecast_io_key

    Destination.all.each do |dest|
      current_time = DateTime.now
      # get temperature record of 'destination'
      forecast = ForecastIO.forecast(dest.latitude, dest.longitude,
                                     time: current_time.to_i,
                                     params: { units: 'si' })['currently']

      # create temperature note for destination
      TemperatureNote.create!(destination: dest.city_name,
                              time: current_time,
                              temperature: forecast.temperature,
                              note: '')
      # need to add note
    end
  end
end
