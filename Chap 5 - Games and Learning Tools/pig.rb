#http://en.wikipedia.org/wiki/Pig_%28dice%29
#Variation would be to add a second die, and ensure neither shows a 1

#output instructions to players
puts "\n\n\n\n\n\n\nWelcome to the game PIG!"
puts "\n----INSTRUCTIONS----"
puts "The object of the game is to reach 100 points."
puts "*** Be careful, if you roll a 1 you lose your ***"
puts "*** turn and any points you may have received. ***"
puts "\nGood Luck!"

puts "\n\nPress <Enter> to continue..."
gets


#Initialize scores
player1 = 0
player2 = 0
turn_total = 0
turn = true
d1 = rand(6)+1

#player 1 starts
puts "\n\n\n\n---Player 1 Roll---"
puts "Press <Enter> to roll again or 'h' to hold."
input = gets.chomp.downcase

#Players alternate until one reaches a total score of 100
while input != 'q'
  unless input == 'h'
    if turn
      puts "\n\n\n\n---Player 1 Roll---"
      puts "Player 1's total is: #{player1}\n\n"
    else
      puts "\n\n\n\n---Player 2 Roll---"
      puts "Player 2's total is: #{player2}\n\n"
    end
    d1 = rand(6)+1
    puts "You rolled a: #{d1}\n\n"
        
    if d1 == 1
      puts "****So sorry, you receive no points and forfeit your turn.***"
      puts "Press <Enter> to continue..."
      gets
      turn_total = 0
      input = 'h'
      next
    end
        
    turn_total = turn_total+d1
    puts "Your total for this turn is: #{turn_total}"
    if turn_total >= 100
      puts "You WIN!"
      exit
    end
        
    puts "Press <Enter> to roll again or 'h' to hold."
    input = gets.chomp.downcase
  else
    if turn
      player1 = player1+turn_total
      puts "\n\nPlayer 1's total is #{player1}\n\n"
      if player1 >= 100
        puts "\n\nPlayer 1 wins!\n\n\n"
        exit
      end
      turn = false
    else
      player2 = player2+turn_total
      puts "\n\nPlayer 2's total is #{player2}"
      if player2 >= 100
        puts "\n\nPlayer 2 wins!\n\n\n"
        exit
      end
      turn = true
    end
    turn_total = 0
    input = 'other'
  end
end