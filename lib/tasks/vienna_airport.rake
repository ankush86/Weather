require 'nokogiri'
require 'watir'
require 'open-uri'

namespace :vienna_airport do
  desc "TODO"
  task get_departing_flight: :environment do

    # Fetch and parse HTML document
    base_url = Rails.application.secrets.scraping_website_url

    # open site
    browser = Watir::Browser.new
    browser.goto base_url
    sleep 10

    # get site data
    data = Nokogiri::HTML(browser.html)
    sleep 10

    city_names = []
    # get destination city names
    data.css('.detail-table__cell.text-uppercase.fdabf-td2 .visible-xs').each { |dest| city_names << dest.text }

    city_names.each do |city|
      # get coordinate of city
      result = Geocoder.search(city)
      sleep(10)
      if result.present?
        lat = result.first.data['lat']
        lon = result.first.data['lon']

        Destination.create(city_name: city, latitude: lat, longitude: lon)
        puts "create record for #{city}"
      end
    end
  end
end
