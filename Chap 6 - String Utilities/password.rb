
unless ARGV[0]
  puts "You need to include a password to test."
  puts "Usage: ruby password.rb mySuperSecretPassword"
  exit
end

password = ARGV[0]
word = password.split(//)
letters = Hash.new(0.0)
set_size = 96                 #Mixed upper and lower case alphabet plus numbers and common symbols.
#62 for alphaNumeric, 26 for only lowercase or only uppercase, 10 for only digits

word.each do |i|              #Count how many instances of each element there are within the array
  letters[i] += 1.0
end

letters.keys.each do |j|      #Calculate the probability of the next letter being chosen
  letters[j] /= word.length
end

entropy =  -1 * letters.keys.inject(0.to_f) do |sum, k|     #Entropy calculation using NAT and Shannon Entropy formula
  sum + (letters[k] * (Math.log(letters[k])/Math.log(2.to_f)))
end

combinations = 96 ** password.length          #calculate the possibilities for a given password of a finite length
   
days = combinations.to_f / (10000000 * 86400) # assuming 10,000,000 tries per second / 86,400 seconds per day

years = days / 365                            #convert days to years
  
puts "\nThe entropy value is: #{entropy}"
puts "\nAnd it will take ~ #{days <365 ? "#{days.to_i } days" : "#{years.to_i} years"} to brute force the password"
	
	