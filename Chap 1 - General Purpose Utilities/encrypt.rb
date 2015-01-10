'crypt/blowfish'

unless ARGV[0]
  puts "Usage: ruby encrypt.rb <filename.ext>"
  puts "Example: ruby encrypt.rb secret.stuff"
  exit
end

#take in the file name to encrypt as an argument
filename = ARGV[0].chomp
puts filename
c = "Encrypted_#{filename}."
   
if File.exists?(c)
  puts "File already exists."
  exit
end
    
#User specifies a key from 1-56 bytes 
#(Don't forget this or your stuff is history)
print 'Enter your encryption key (1-56 bytes): '
kee = gets.chomp
    
begin
  #initialize the encryption method using the user input key
  blowfish = Crypt::Blowfish.new(kee)
  blowfish.encrypt_file(filename.to_str, c)
  #encrypt the file
  puts 'Encryption SUCCESS!'
rescue Exception => e
  puts "An error occurred during encryption: \n #{e}."
end
