require 'ipaddr'

#Get IP and subnet mask from user
begin
  print "Enter the IP address: "
  ip = IPAddr.new gets.chomp

  print "Enter the Subnet mask: "
  subnet_mask = IPAddr.new gets.chomp

rescue Exception => e
  puts "An error occurred: #{e}\n\n"
end

#Call the mask method of ipaddr to get subnet
subnet = ip.mask(subnet_mask.to_s)

#output the subnet address
puts "Subnet address is: #{subnet}\n\n"

