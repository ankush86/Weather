require 'test_helper'

class DestinationServiceTest < ActiveSupport::TestCase
  require 'nokogiri'

  data = <<-HTML
  <div class='detail-table__cell text-uppercase fdabf-td2'>
    <span class='visible-xs'>München</span>
  </div>
  <div class='detail-table__cell text-uppercase fdabf-td2'>
    <span class='visible-xs'>Bristol</span>
  </div>
  <div class='detail-table__cell text-uppercase fdabf-td2'>
    <span class='visible-xs'>New York</span>
  </div>
  HTML

  test "should create destination city and store temperature" do
    before = Destination.count

    doc = Nokogiri::HTML(data)
    reader = DestinationService.new(doc).create_city_record

    after = Destination.count
    assert_equal after, before + 3

    destination = Destination.first
    assert_not_nil(destination.latitude)
    assert_not_nil(destination.longitude)

    temperature_note = TemperatureNote.first
    assert_not_nil(temperature_note.temperature)
    assert_not_nil(temperature_note.note)
  end
end
