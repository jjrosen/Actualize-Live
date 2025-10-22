# # food_ary = []
# # index = 1

# # while index <= 5

# #   puts "Give me your #{index} favorite food:"

# #   food = gets.chomp
# #   food_ary.push(food)
# #   index = index + 1

# # end

# # # p food_ary

# # Now, instead of printing out the array, output 5 separate lines of each food, with the prefix, “I love”. For example:

#  food_ary = []
# index = 1

# while index <= 5

#   puts "Give me your #{index} favorite food:"

#   food = gets.chomp
#   food_love = "I love #{food}"
#   food_ary.push(food_love)
#   index = index + 1

# end
# number = 0
# while number < food_ary.length
#   p food_ary[number]
#   number = number + 1
# end




# Translate the following into ruby code. Run the program to make sure it works:

# Sam enjoys cooking. Make an array with recipe names to represent the different recipes Sam can cook.
# Sally speaks many languages. Make an array with language names to represent the languages Sally can speak.
# If Sam can cook more than 10 recipes and Sally speaks more than 5 languages, they should date. Based on the above arrays, print out a message describing whether or not they should date.
# If Sam can make crepes or Sally can speak French, they should marry. Based on the above arrays, print out a message describing whether or not they should marry.

sam_recipies = ["chicken", "taost", "pizza", "pancakes"]
sally_languages = ["english", "french", "spanish", "russian"]
if sam_recipies.length > 10 && sally_languages.length > 5
  puts "they should date"
else
  puts "They shouldn't date"
end

index1 = 0
while index1 < sam_recipies.length
  if sam_recipies[index1] == "crepes"
   puts "they should get married"
  end
  index1 += 1
end

index2 = 0
while index2 < sally_languages.length
  if sally_languages[index2] == "french"
    puts "they should get married"
  end
  index2 += 1
end