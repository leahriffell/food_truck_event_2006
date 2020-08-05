require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'

class FoodTruckTest <  Minitest::Test
  def setup 
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  def test_it_exists_and_has_readable_attributes
    assert_instance_of FoodTruck, @food_truck
    assert_equal "Rocky Mountain Pies", @food_truck.name
  end
end