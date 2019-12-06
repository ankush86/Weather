# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - 2.6.3

* Rails version - 6.0.1

* DataBase - Postgresql

* Run `rake "vienna_airport:get_departing_flight"`
    It will Scrape data to airport website and store city, temperature in Database.

* Service :
    FlightDepartureService : Scraping the Airport website and return page.
    DestinationService : Create destination city and get coordinate and store in Database.
    CityTemperatureService : Get `forecast` of destination city and store in Database.

* Model :
    Destination : It store destination `city` and its coordinate (get via geocoder).
                  Coordinate require to get forecast.

    TemperatureNote : It store destination `city`, its `temperature` and `note`.

* Caching :
    For caching HTML page of Airport website, we use `file_store` at path "/tmp/cache"

* Tesing - Using Rails MiniTest
