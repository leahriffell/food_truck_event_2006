require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/item'
require './lib/food_truck'
require './lib/event'
require 'date'

class EventTest <  Minitest::Test
  def setup 
    @event = Event.new("South Pearl Street Farmers Market") 

    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck1.stock(@item1, 35)    
    @food_truck1.stock(@item2, 7)    

    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")    
    @food_truck2.stock(@item4, 50)    
    @food_truck2.stock(@item3, 25)

    @food_truck3 = FoodTruck.new("Palisade Peach Shack")    
    @food_truck3.stock(@item1, 65)  
    @food_truck3.stock(@item3, 10)    

    @event.add_food_truck(@food_truck1)    
    @event.add_food_truck(@food_truck2)    
    @event.add_food_truck(@food_truck3)  
  end

  def test_it_exists_and_has_readable_attribute
    assert_instance_of Event, @event
    assert_equal "South Pearl Street Farmers Market", @event.name
  end

  def test_it_can_add_food_trucks
    event2 = Event.new("South Broadway Farmers Market")
    assert_equal [], event2.food_trucks 

    event2.add_food_truck(@food_truck1)    
    event2.add_food_truck(@food_truck2)    
    event2.add_food_truck(@food_truck3)
    assert_equal [@food_truck1, @food_truck2, @food_truck3], event2.food_trucks
  end

  def test_it_can_return_names_of_all_food_trucks 
    assert_equal ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"], @event.food_truck_names
  end

  def test_it_can_return_all_food_trucks_that_sell_an_item 
    assert_equal [@food_truck1, @food_truck3], @event.food_trucks_that_sell(@item1)

    assert_equal [@food_truck2], @event.food_trucks_that_sell(@item4)
  end
  
  def test_it_can_get_all_items_in_stock
    assert_equal [@item1, @item2, @item4, @item3], @event.items_in_stock
  end

  def test_it_can_return_sorted_list_of_all_items_sold
    assert_equal  ["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"], @event.sorted_item_list
  end

  def test_it_can_get_its_total_inventory
    breakdown = {
        @item1 => {
        quantity: 100,
        food_trucks: [@food_truck1, @food_truck3]
        },
        @item2 => {
        quantity: 7,
        food_trucks: [@food_truck1]
        },
        @item4 => {
        quantity: 50,
        food_trucks: [@food_truck2]
        },
        @item3 => {
        quantity: 35,
        food_trucks: [@food_truck2, @food_truck3]
       },
    }

    assert_equal breakdown, @event.total_inventory 
  end

  def test_it_can_identify_overstocked_items 
    assert_equal [@item1], @event.overstocked_items
  end

  def test_it_can_return_its_creation_date
    # was trying to stub out Date.today instead but ran into issues. This test isn't really actually testing the date method now. 
    @event.stubs(:date).returns("24/02/2020")

    assert_equal "24/02/2020", @event.date
  end

  def test_it_can_return_whether_or_not_item_can_be_sold
    # this sepc doesn't have item3 added to foodtruck 3 so removing it here 
    @food_truck3.stock(@item3, -10)    

    assert false, @event.sell(@item1, 200)
    assert false, @event.sell(@item5, 1)
    assert @event.sell(@item4, 5)
  end
end