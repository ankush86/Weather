require 'nokogiri'
require 'watir'
require 'open-uri'

class FlightDepartureService
  def initialize(base_url)
    @base_url = base_url
  end

  def web_page_data
    # For caching
    cache_page = Rails.cache.read('page')
    if cache_page.present?
      html_doc = Nokogiri::HTML(cache_page)
      page_html = html_doc
    else
      # open site
      browser = Watir::Browser.new
      browser.goto @base_url
      sleep 10
      # Get page
      page_html = Nokogiri::HTML(browser.html)
      store_page_in_cache(page_html.to_s)
    end
    page_html
  end

  def store_page_in_cache(page_html)
    Rails.cache.write('page', page_html)
  end
end
