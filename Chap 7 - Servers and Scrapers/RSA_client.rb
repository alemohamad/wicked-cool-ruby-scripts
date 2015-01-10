require 'socket'
require 'digest/sha1'

begin
  print "Starting client......"
  client = TCPSocket.new('localhost', 8887)

  puts "connected!\n\n"

  temp = nil
  #get server public encryption key
  5.times do
    temp << client.gets
  end

  puts "Received public 1024 RSA key!\n\n"
  public_key = OpenSSL::PKey::RSA.new(temp)
  
  #Construct message to send
  msg = 'mpg123*"C:\Program Files\Windows Media Player\mplayer2.exe"*ruby.mp3'
  sha1 = Digest::SHA1.hexdigest(msg)

  command = public_key.public_encrypt("#{sha1}*#{msg}")
  print "Sending the command...."

  #send the message
  client.send(command,0)

  puts "sent!"
rescue => e
  puts "Something terrible happened..."
  puts e
  retry
end

client.close