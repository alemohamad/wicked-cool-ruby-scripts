
#Needed IP utilities
class IP
  def initialize(ip)
    @ip = ip
  end
    
  #convert ip address to string
  def to_s
    @ip
  end
    
  #compare two ip addresses
  def==(other)
    to_s==other.to_s
  end
    
  #generate ips
  def succ
    return @ip if @ip == "255.255.255.255"
    parts = @ip.split('.').reverse
    parts.each_with_index do |part,i|
      if part.to_i < 255
        part.succ!
        break
      elsif part == "255"
        part.replace("0") unless i == 3
      else
        raise ArgumentError, "Invalid number #{part} in IP address"
      end
    end
    parts.reverse.join('.')
  end
    
  def succ!
    @ip.replace(succ)
  end
end

print "Input Starting IP Address: "
start_ip = gets.strip 

print "Input Ending IP Address: "
end_ip = gets.strip

i = IP.new(start_ip)

ofile = File.open("ips.txt", "w")
ofile.puts i.succ! until i == end_ip
ofile.close