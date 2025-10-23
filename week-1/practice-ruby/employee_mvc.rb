require "sqlite3"
require "tty-table"
# this is the fuction for the data structure
class Employee
  @@db = SQLite3::Database.open "employee.db"
  @@db.execute "CREATE TABLE IF NOT EXISTS employees(id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, salary INTEGER, active INTEGER)"

  attr_reader :id, :first_name, :last_name, :active, :salary
  attr_writer :active

  def initialize(input_options)
    @id = input_options[:id]
    @first_name = input_options[:first_name]
    @last_name = input_options[:last_name]
    @salary = input_options[:salary]
    @active = input_options[:active]
  end

  def self.create(options)
    @@db.execute "INSERT INTO employees (first_name, last_name, salary, active) VALUES (?, ?, ?, ?)",
      [options[:first_name], options[:last_name], options[:salary], options[:active]]
  end
#dont know what sgoing on here
  def self.all
    results = @@db.query "SELECT * FROM employees"
    results.map do |row|
      Employee.new(id: row[0], first_name: row[1], last_name: row[2], salary: row[3], active: row[4])
    end
  end
#this is a search methods to look thorugh the employee data array
  def self.find_by(options)
    results = @@db.query "SELECT * FROM employees WHERE id = ?", options[:id]
    first_result = results.next
    Employee.new(id: first_result[0], first_name: first_result[1], last_name: first_result[2], salary: first_result[3], active: first_result[4])
  end
#this is to update the active status
  def update(options)
    if options[:active] == "true"
      active = 1
    else
      active = 0
    end
    @@db.execute "UPDATE employees SET active = ? WHERE id = ?", [active, self.id]
  end
#delete employee data 
  def destroy
    @@db.execute "DELETE FROM employees WHERE id = ?", self.id
  end
end
#this is the visuals for the user to see
class View
  #display the employee info in a table
  def self.display_employees(employees)
    header = ["id", "first_name", "last_name", "salary", "active"]
    rows = employees.map { |employee| [employee.id, employee.first_name, employee.last_name, employee.salary, employee.active] }
    table = TTY::Table.new header, rows
    puts "EMPLOYEES (#{rows.length} total)"
    puts table.render(:unicode)
    puts
  end
#display the read command/method
  def self.display_employee(employee)
    puts "Id: #{employee.id}"
    puts "First name: #{employee.first_name}"
    puts "Last name: #{employee.last_name}"
    puts "Salary: #{employee.salary}"
    puts "Active: #{employee.active}"
    puts
    print "Press enter to continue"
    gets.chomp
  end
#display the quit command
  def self.display_exit_screen
    system "clear"
    puts "Goodbye!"
  end
#display the error message
  def self.display_error_screen
    puts "Invalid choice"
    print "Press enter to continue"
    gets.chomp
  end
#display the original options for the user to enter
  def self.get_menu_option
    print "[C]reate [R]ead [U]pdate [D]elete [Q]uit: "
    gets.chomp.downcase
  end
#display the create command
  def self.get_create_options
    print "First name: "
    input_first_name = gets.chomp
    print "Last name: "
    input_last_name = gets.chomp
    print "Salary: "
    input_salary = gets.chomp.to_i
    { first_name: input_first_name, last_name: input_last_name, salary: input_salary, active: 1 }
  end
#display the read options 
  def self.get_read_options
    print "Employee id: "
    input_id = gets.chomp.to_i
    { id: input_id }
  end
#display the update options
  def self.get_update_options
    print "Employee id: "
    input_id = gets.chomp.to_i
    print "Update active status (true or false): "
    input_active = gets.chomp
    { id: input_id, active: input_active }
  end
#display the delete command options
  def self.get_destroy_options
    puts "Delete employee"
    print "Enter employee id: "
    input_id = gets.chomp.to_i
    { id: input_id }
  end
end
#this is what runs the both classes together
class Controller
  def self.run
    while true
      system "clear"
      employees = Employee.all
      #run the veiw class method display_employees and update the employee Method class
      View.display_employees(employees)
      input_choice = View.get_menu_option
      if input_choice == "c"
        # run the Veiw method get_create_options and update the employee class
        input_options = View.get_create_options
        Employee.create(input_options)
      elsif input_choice == "r"
        #run Veiw get_read_options method and update the employee class
        input_options = View.get_read_options
        employee = Employee.find_by(input_options)
        View.display_employee(employee)
      elsif input_choice == "u"
        input_options = View.get_update_options
        employee = Employee.find_by(id: input_options[:id])
        employee.update(input_options)
      elsif input_choice == "d"
        input_options = View.get_destroy_options
        employee = Employee.find_by(input_options)
        employee.destroy
      elsif input_choice == "q"
        View.display_exit_screen
        return
      else
        View.display_error_screen
      end
    end
  end
end

Controller.run