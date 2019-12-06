# get departing flight cities and store temperature of that on every hour
every 1.hour do
  rake "vienna_airport:get_departing_flight"
end
