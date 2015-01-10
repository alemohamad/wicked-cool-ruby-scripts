if ARGV.size != 1
  puts "Usage: ruby filejoin.rb <filename.ext>"
  puts "Example: ruby fileJoin.rb myfile.txt"
  exit
end
    
file = ARGV[0]
piece = 0
orig_file = "New.#{file}"

if File.exists?("#{file}.rsplit#{piece}")
  #If the pieces exist, grab them and start putting them together
  ofile = File.open(orig_file, "w")
  while File.exists?("#{file}.rsplit#{piece}")   
    puts "Reading File: #{file}.rsplit#{piece}"                
    ofile << File.open("#{file}.rsplit#{piece}","r").read.chomp
    piece+=1
  end
  ofile.close
  puts "\nSUCCESS!  File reconstructed."
else 
  #Whoops!
  puts "\n\nCould not find #{file}.rsplit#{piece}."
end
