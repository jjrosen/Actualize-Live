item1 = {name: "Hammer", price: 10, aisle: 5}
item2 = {name: "Screwdriver", price: 8, aisle: 3}
item3 = {name: "Wrench", price: 6, aisle: 2}
item4 = {"name" => "nail", "price" => 1, "aisle" => 1}
item5 = {:name => "Ladder", :price => 20, :aisle => 7}


puts "You can find the #{item1[:name]}s in aisle #{item1[:aisle]} and they cost $#{item1[:price]}."



class Item
  attr_reader :name, :price, :aisle
  attr_writer :name, :price, :aisle
  def initialize(input)
    @name = input[:name]
    @price = input[:price]
    @aisle = input[:aisle]
  end
  def discount
    @price = @price * 0.8
  end
end

item_1 = Item.new({name: "Hammer",price: 8,aisle: 2})
item_2 = Item.new({price: 9, name: "Screwdriver",aisle: 1})

puts item_1.name
puts item_1.price
puts item_1.aisle

puts item_2.price = 7
pp item_2
puts item_1.discount