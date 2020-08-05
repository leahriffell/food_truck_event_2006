class Event 
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
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
end