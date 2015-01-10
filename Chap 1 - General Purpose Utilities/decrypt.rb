require 'crypt/blowfish'

unless ARGV[0]
  puts "Usage: ruby decrypt.rb <Encrypted_filename.ext>"
  puts "Example: ruby decrypt.rb Encrypted_secret.stuff"
  exit
end

#take in the file name to decrypt as an argument
filename = ARGV[0].chomp
puts "Decrypting #{filename}."
p = "Decrypted_#{filename}"

if File.exists?(p)
  puts "File already exists."
  exit
end

#User specifies the original key from 1-56 bytes (or guesses)
print 'Enter your encryption key: '
kee = gets.chomp

begin
  #initialize the decryption method using the user input key  
  blowfish = Crypt::Blowfish.new(kee)
  blowfish.decrypt_file(filename.to_str, p)
  #decrypt the file  
  puts 'Decryption SUCCESS!'
rescue Exception => e
  puts "An error occurred during decryption: \n #{e}."
end
