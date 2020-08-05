class Event 
  attr_reader :name, :food_trucks, :date

  def initialize(name)
    @name = name
    @food_trucks = []
    @date = Date.today
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck 
  end

  def food_truck_names 
    @food_trucks.map { |truck| truck.name }
  end

  def food_trucks_that_sell(item)
    @food_trucks.select { |truck| truck.inventory.include?(item) }
  end

  def items_in_stock
    items = []
    @food_trucks.map do |truck|
      truck.inventory.map do |inventory|  
        items << inventory[0]
      end
    end.flatten
    items.uniq
  end

  def sorted_item_list
    items_in_stock.map { |item| item.name }.sort
  end

  def total_inventory
    items_in_stock.reduce({}) do |result, item|
      result[item] = {
        quantity: @food_trucks.sum {|truck| truck.check_stock(item)},
        food_trucks: food_trucks_that_sell(item)
      }
      result
    end
  end

  def overstocked_items
    total_inventory.select do |key, value|
      value[:quantity] > 50 && value[:food_trucks].size > 1
    end.keys
  end
  
  def date
    @date.strftime("%e/%m/%Y")
  end

  def sell(item, quantity)
    if total_inventory[item] == nil
      # require 'pry'; binding.pry
      false 
    else 
      total_inventory[item][:quantity] >= quantity
    end
  end
end