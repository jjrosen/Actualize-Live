tasks = []
while true
  system "clear"
  tasks.each_with_index do |task,index|
    checkbox = task[:completed] ? "[ X ]" : "[ ]"
    puts "#{index + 1}. #{checkbox} #{task[:title]}"
  end
  puts "[A]dd, [T]oggle, [D]elete, [Q]uit"
  input = gets.chomp.downcase
  if input == "a"
    puts "What is the task?"
    input_task = gets.chomp
    tasks << {title: input_task, completed: false}
  elsif input == "t"
    puts "Which task do you want to update"
    input_toggle = gets.chomp.to_i
      #i dont know how to toggle a checkmark
  elsif input == "d"
    puts "Which task do you want to delete"
    input_delete = gets.chomp.to_i
      tasks.delete_at(input_delete - 1)
  elsif input == "q"
    puts "Goodbye :)"
    return
  end
end