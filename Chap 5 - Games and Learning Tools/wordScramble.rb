unless ARGV[0] and File.exists?(ARGV[0])        #can also use /usr/share/dict/words
  puts "\n\nUsage: is wordScramble.rb <word.file>\n\n"
  exit
end

#Set the number of tries, modify as needed
tries = 10
guess = nil

words = File.readlines(ARGV[0])
mystery_word = words[rand(words.size)].chomp

#Randomly scramble the word
scramble_word = mystery_word.split(//).sort_by{rand}.join
scramble_word.downcase!

puts "\n\n\nThe scrambled word is:  #{scramble_word}."

puts "Guess the word..."

puts "You have #{tries} guesses left."

guess = $stdin.gets.chomp.downcase

#process guesses
while guess =~ /[^Qq]/
  if tries == 0
    puts "\n\nNice try, but the word is: #{mystery_word}."
    exit
  elsif guess != mystery_word.downcase
    puts "\nYour guess was incorrect.  #{tries-=1} left..."
    puts "\nThe scrambled word is:  #{scramble_word}."
    guess = $stdin.gets.chomp.downcase
  else
    puts "\n\n\nYou got it, great job!\n\n"
    puts "Press <Enter> to continue."
    $stdin.gets
    exit
  end
end


