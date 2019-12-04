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
  end
end
