require 'zip/zip'

#Check for provided file to compress
unless ARGV[0]
  puts "Usage: ruby compress.rb <filename.ext>"
  puts "Example: ruby compress.rb myfile.exe"
  exit
end

file = ARGV[0].chomp

if File.exists?(file)
  print "Enter zip filename:"
  zip = "#{gets.chomp}.zip"
  #Createa a Zip object to put compressed data in
  Zip::ZipFile.open(zip, true) do |zipfile|   
    begin
      puts "#{file} is being added to the archive."
      #add a file to the zip object
      zipfile.add(file,file)
    rescue Exception => e
      puts "Error adding to zipfile: \n #{e}."
    end
  end
else
  puts "\nFile could not be found."
end
