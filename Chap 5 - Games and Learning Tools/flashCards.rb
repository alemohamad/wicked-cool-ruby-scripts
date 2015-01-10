unless ARGV[0]
  puts "\n\nUsage: is flashCards.rb <file>\n\n"
  exit
end

flash = []

card = Struct.new(:question, :answer)

#Open flash card file
File.open(ARGV[0], "rb").each do |line|
  if line =~ /(.*)\s{3,10}(.*)/
    flash << card.new($1.strip, $2.strip)
  end
end


#randomly get a flash card
flash.replace(flash.sort_by { rand })

#present the flash cards to the user to learn something
until flash.empty?
  drill = flash.pop
  print "#{drill.question}? "
  guess = $stdin.gets.chomp

  if guess.downcase == drill.answer.downcase
    puts "\n\nCorrect -- The answer is: #{drill.answer}\n\n\n"
  else
    puts "\n\nWRONG -- The answer is: #{drill.answer}\n\n\n"
  end
end