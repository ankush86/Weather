require 'nokogiri'
require 'watir'
require 'open-uri'

class FlightDepartureService
  def initialize(base_url)
    @base_url = base_url
  end

  def web_page_data
    # open site
    browser = Watir::Browser.new
    browser.goto @base_url
    sleep 10

    # get site data
    Nokogiri::HTML(browser.html)
  end
end
