require 'socket'
require 'digest/sha1'

priv_key = OpenSSL::PKey::RSA.new(1024)
pub_key = priv_key.public_key

host = ARGV[0] || 'localhost'
port = (ARGV[1] || 8887).to_i

#Start a listening TCP server on the ip address of host and port
server = TCPServer.new(host, port)

#If a connection is madge, send the public key and wait for data
while session = server.accept
  begin
    puts "Connection made...sending public key.\n\n"
    puts pub_key
    session.print pub_key
    puts "Public key sent, waiting on data...\n\n"
        
    temp = session.recv(10000)
    puts "Received data..."
        
    msg = priv_key.private_decrypt(temp)
  rescue => e
    puts "Something terrible happened while receiving and decrypting."
    puts e
  end
    
  #Split the message sent by the client
  command = msg.split("*")
    
  serv_hash = command[0]
  nix_app = command[1]
  win_app = command[2]
  file = command[3]

  #Execute message from client based on the server platform
  if Digest::SHA1.hexdigest("#{nix_app}*#{win_app}*#{file}")==serv_hash
    puts "Message integrity confirmed..."
    if RUBY_PLATFORM.include?('mswin32')
      puts "Executing windows command: #{win_app} #{file}"
      `#{win_app} #{file}`
      exit
    else
      puts "Executing Linux command: #{nix_app} #{file}"
      `#{nix_app} #{file}`
      exit
    end
  else
    puts "The message could not be validated!"
  end
  exit
end