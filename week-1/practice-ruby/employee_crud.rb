require "sqlite3"
require "tty-table"

db = SQLite3::Database.open "employee.db"
#creating a table called employees if one doesn't exist already with variables for info
db.execute "CREATE TABLE IF NOT EXISTS employees(id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, salary INTEGER, active INTEGER)"

while true
  system "clear"
  results = db.query "SELECT * FROM employees"
  #make a header using an array of names of reac piece of info
  header = ["id", "first_name", "last_name", "salary", "active"]
  rows = results.to_a
  table = TTY::Table.new header, rows
  puts "EMPLOYEES (#{rows.length} total)"
  puts table.render(:unicode)
  puts
  #these are the choices given for the data system
  print "[C]reate [R]ead [U]pdate [D]elete [Q]uit: "
  input_choice = gets.chomp.downcase
  # this is the if function that figures out what to do based on what the user input
  # each array is a avriable called the id number
  if input_choice == "c"
    print "First name: "
    input_first_name = gets.chomp
    print "Last name: "
    input_last_name = gets.chomp
    print "Salary: "
    input_salary = gets.chomp.to_i
    #this is the costum code that is basicly a push method to add the the employee database
    db.execute "INSERT INTO employees (first_name, last_name, salary, active) VALUES (?, ?, ?, ?)", [input_first_name, input_last_name, input_salary, 1]
  elsif input_choice == "r"
    print "Employee id: "
    input_id = gets.chomp.to_i
    #input do choose which employee you want to look at
    results = db.query "SELECT * FROM employees WHERE id = ?", input_id
    first_result = results.next
    puts "Id: #{first_result[0]}"
    puts "First name: #{first_result[1]}"
    puts "Last name: #{first_result[2]}"
    puts "Salary: #{first_result[3]}"
    puts "Active: #{first_result[4]}"
    puts
    print "Press enter to continue"
    gets.chomp
    #? how do you get the terminal to delete the info that was prnted above??
  elsif input_choice == "u"
    print "Employee id: "
    input_id = gets.chomp.to_i
    print "Update active status (true or false): "
    input_active = gets.chomp
    if input_active == "true"
      input_active = 1
    else                       # the way the code is written you can only update the 
      input_active = 0         # staus of their employment but not their name or salary
    end
    db.execute "UPDATE employees SET active = ? WHERE id = ?", [input_active, input_id]
  elsif input_choice == "d"
    puts "Delete employee"
    print "Enter employee id: "
    input_id = gets.chomp.to_i
    #tells which ID to delete
    db.execute "DELETE FROM employees WHERE id = ?", input_id
  elsif input_choice == "q"
    #earases all the data written and says goodbye
    system "clear"
    puts "Goodbye!"
    return
  else
    puts "Invalid choice"
    print "Press enter to continue"
    gets.chomp
  end
end