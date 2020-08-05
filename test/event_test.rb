require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'

class EventTest <  Minitest::Test
  def setup 
    @event = Event.new("South Pearl Street Farmers Market")    
  end

  def test_it_exists
    assert_instance_of Event, @event
  end
end