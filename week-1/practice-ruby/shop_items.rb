require "sqlite3"
require "tty-table"

db = SQLite3::Database.open "store.db"
db.execute "CREATE TABLE IF NOT EXISTS store_items(id INTEGER PRIMARY KEY, item_name TEXT, item_price INTEGER, aisle INTEGER, available INTEGER)"

while true
  system "clear"
  results = db.query "SELECT * FROM store_items"
  header = ["id", "item_name", "item_price", "aisle", "available"]
  rows = results.to_a
  table = TTY::Table.new header, rows
  puts "STORE ITEMS (#{rows.length} total)"
  puts table.render(:unicode)
  puts
  print "[C]reate [R]ead [U]pdate [D]elete [Q]uit: "
  input_choice = gets.chomp.downcase
  if input_choice == "c"
    print "Item Name: "
    input_item_name = gets.chomp
    print "Item Price: "
    input_item_price = gets.chomp.to_i
    print "Aisle: "
    input_aisle = gets.chomp.to_i
    db.execute "INSERT INTO store_items (item_name, item_price, aisle, available) VALUES (?, ?, ?, ?)", [input_item_name, input_item_price, input_aisle, 1]
    elsif input_choice == "r"
    print "Item id: "
    input_id = gets.chomp.to_i
    results = db.query "SELECT * FROM store_items WHERE id = ?", input_id
    first_result = results.next
    puts "Id: #{first_result[0]}"
    puts "Item: #{first_result[1]}"
    puts "Price: #{first_result[2]}"
    puts "aisle: #{first_result[3]}"
    puts "Availability: #{first_result[4]}"
    puts
    print "Press enter to continue"
    gets.chomp
    elsif input_choice == "u"
    print "Item id: "
    input_id = gets.chomp.to_i
    print "Update availability status (true or false): "
    input_available = gets.chomp
    if input_available == "true"
      input_available = 1
    else                      
      input_available = 0     
    end
    db.execute "UPDATE store_items SET available = ? WHERE id = ?", [input_available, input_id]
    elsif input_choice == "d"
    puts "Delete Item"
    print "Enter Item id: "
    input_id = gets.chomp.to_i
    db.execute "DELETE FROM store_items WHERE id = ?", input_id
    elsif input_choice == "q"
    system "clear"
    puts "Goodbye!"
    return
  else
    puts "Invalid choice"
    print "Press enter to continue"
    gets.chomp
  end
end