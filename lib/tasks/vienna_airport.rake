namespace :vienna_airport do
  desc 'Get Departing Flight City and store temperature'
  task get_departing_flight: :environment do
    # Fetch and parse HTML document
    base_url = Rails.application.secrets.scraping_website_url
    # Get data to base_url
    data = FlightDepartureService.new(base_url).web_page_data
    sleep 10

    # Create city's temperature note record in database
    DestinationService.new(data).create_city_record
  end
end
