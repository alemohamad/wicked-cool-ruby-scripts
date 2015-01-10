#Print rules of the game
puts "\n\nWelcome to Rock, Paper, Scissor."
puts "This is a game of chance, the computer randomly picks one of three choices."
puts "\nRock beats Scissor, but is beaten by Paper."
puts "Scissors beats Paper, but are beaten by Rock."
puts "Paper beats Rock, but is beaten by Scissor."
#Print welcome message
puts "r for Rock"
puts "s for Scissor"
puts "p for Paper\n"
print "\nEnter one of the above to play: "


#randomly get computer input --> some modulus of three
computer = "rsp"[rand(3)].chr

    
#Get user input, declare winner
player = $stdin.gets.chomp.downcase

case [player, computer]
when ['p','r'], ['s','p'], ['r','s']
  puts "\n\nYou win!"
when ['r','r'], ['p','p'], ['s','s']
  puts "\n\nYou tied!"
else
  puts "\n\nYou lose!"
end

puts "The computer chose: #{computer}"

puts "Press <Enter> to continue."
$stdin.gets