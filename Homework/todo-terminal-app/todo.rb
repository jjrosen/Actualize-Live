tasks = []
while true
  system "clear"
  tasks.each do |task|
    puts task
  end
  puts "[A]dd, [T]oggle, [D]elete, [Q]uit"
  input = gets.chomp.downcase
  if input == "a"
    puts "What is the task?"
    input_task = gets.chomp
    tasks.push([input_task])
  elsif input == "q"
    puts "Goodbye :)"
    return
  end
end