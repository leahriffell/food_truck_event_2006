require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'
require './lib/event'

class EventTest <  Minitest::Test
  def setup 
    @event = Event.new("South Pearl Street Farmers Market")    
  end

  def test_it_exists_and_has_readable_attribute
    assert_instance_of Event, @event
    assert_equal "South Pearl Street Farmers Market", @event.name
  end
end