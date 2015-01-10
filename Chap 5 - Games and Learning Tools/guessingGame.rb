puts "\nWelcome to the number-guessing game!\n\n\n\n"
print "What difficulty level would you like (low, medium, or hard): "
level = gets.chomp
puts "Enter 'q' to quit.\n\n\n"
min = 1

#Levels for game difficulty degree
case level
when "low"
  max = 10
when "medium"
  max = 100
when "hard"
  max = 1000
else
  max = 10
end

#Let the user know the number range
puts "The magic number is between #{min} and #{max}.\n\n"
magic_number = rand(max)+1

print "What is your guess? "
guess = gets.chomp

#process guesses
while guess =~ /\d/
  case guess.to_i
  when 0...magic_number
    puts "Too Low, try again.\n\n"
  when magic_number
    puts "\n\n\nYou guessed it!!!\nThe magic number was #{magic_number}.\n\n\n"
    print "Press the 'enter' key to continue."
    gets
    exit
  else
    puts "Too High, try again.\n\n"
  end
  print "What is your guess? "
  guess = gets.chomp
end

puts "Invalid entry, you lose."