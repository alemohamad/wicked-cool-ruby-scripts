# == Synopsis
# 
#  file_security: encrypts and decrypts files, demonstrates encryption algorithms
# 
# 
# == Usage
# 
# encryption [OPTIONS] ... FILE
# 
# -h, --help:
#   show help
# 
# --encrypt key, -e key
#    encrypt file with password
# 
# --decrypt key, -d key
#    decrypt file with password
# 
# FILE: The file that you want to encrypt/decrypt

require 'getoptlong'
require 'rdoc/ri/ri_paths'
require 'rdoc/usage'
require 'crypt/blowfish'

def encrypt(file, pass)
  c = "Encrypted_#{file}"
            
  if File.exists?(c)
    puts "\nFile already exists."
    exit
  end
    
  begin
    # initialize the encryption method using the user input key
    blowfish = Crypt::Blowfish.new(pass)
    blowfish.encrypt_file(file.to_str, c)
    # encrypt the file
    puts "\nEncryption SUCCESS!"
  rescue Exception => e
    puts "An error occurred during encryption: \n #{e}"
  end
end

def decrypt(file, pass)
  p = "Decrypted_#{file}"

  if File.exists?(p)
    puts "\nFile already exists."
    exit
  end

  begin
    # initialize the decryption method using the user input key
    blowfish = Crypt::Blowfish.new(pass)
    blowfish.decrypt_file(file.to_str, p)
    # decrypt the file
    puts "\nDecryption SUCCESS!"
  rescue Exception => e
    puts "An error occurred during decryption: \n #{e}"
  end
end

#define all command line arguments here
opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
  [ '--encrypt', '-e', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--decrypt', '-d', GetoptLong::REQUIRED_ARGUMENT ]
)

unless ARGV[0]
  puts "\nYou did not include a filename (try --help)"
  exit
end

filename = ARGV[-1].chomp

#add cases for different command line arguments
opts.each do |opt, arg|
  case opt
  when '--help'
    RDoc::usage
  when '--encrypt'
    encrypt(filename, arg)
  when '--decrypt'
    decrypt(filename, arg)
  else
    RDoc::usage
  end
end