require 'nokogiri'
require 'open-uri'

namespace :vienna_airport do
  desc "TODO"
  task get_departing_flight: :environment do

    # Fetch and parse HTML document
    base_url = 'https://www.viennaairport.com/passagiere/ankunft__abflug/abfluege'
    response = HTTParty.get(base_url)
    page = Nokogiri::HTML(response.body)

    # get title of header with CSS
    record = page.css('.main-page-header.no-icon-md.icon-depart')
    title = record.text

    ## need to fetch record of destination and store in model `Destination`
    ## Use Geocoder to get latitude, longitude (it will use in forecast to get temperature)
    # result = Geocoder.search(city)
    # sleep(10)
    # if result.present?
    #   lat = result.first.data["lat"]
    #   lon = result.first.data["lon"]

    #   Destination.create(city_name: city, latitude: lat, longitude: lon)
    #   puts "create record for #{city}"
    # end
  end
end
