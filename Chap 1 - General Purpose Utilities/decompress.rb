require 'zip/zip'
require 'fileutils'

unless ARGV[0]
  puts "Usage: ruby decompress.rb <zipfilename.zip>"
  puts "Example: ruby decompress.rb myfile.zip"
  exit
end

archive = ARGV[0].chomp

if File.exists?(archive)  
  print "Enter path to save files to (\'.\' for same directory): "
  extract_dir = gets.chomp
  begin
    #Open the existing zip file
    Zip::ZipFile::open(archive) do |zipfile|
      zipfile.each do |f|
        #start extracting each file
        path = File.join(extract_dir, f.name)
        FileUtils.mkdir_p(File.dirname(path))
        zipfile.extract(f, path) 
      end
    end
  rescue Exception => e
    #If the script blows up, then we should probably be somewhere in this region
    puts "An error occurred during decompression: \n #{e}."
  end
else
  puts "\n\nArchive could not be found."
end