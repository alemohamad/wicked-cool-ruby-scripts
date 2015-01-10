if ARGV.size != 2
  puts "Usage: ruby fileSplit.rb <filename.ext> <size_of_pieces_in_Bytes>"
  puts "Example: ruby fileSplit.rb myfile.txt 10"
  exit
end

filename = ARGV[0]
size_of_split = ARGV[1]

#Make sure the file exists that we want to split
if File.exists?(filename)
  file = File.open(filename, "r")
  size = size_of_split.to_i
    
  puts "The file is #{File.size(filename)} bytes."
    
  #Calculate the right number of pieces to split the file
  temp = File.size(filename).divmod(size)
  pieces = temp[0]
  extra = temp[1]
    
  puts "\nSplitting the file into #{pieces} (#{size} byte) pieces and 1 (#{extra} byte) piece."
    
  #Start breaking the file down
  pieces.times do |n|
    f = File.open("#{filename}.rsplit#{n}", "w")
    f.puts file.read(size)
  end
   
  #Write out one last peice
  e = File.open("#{filename}.rsplit#{pieces}", "w")
  e.puts file.read(extra)
else
  puts "\n\nFile does NOT exist, please check filename."
end
