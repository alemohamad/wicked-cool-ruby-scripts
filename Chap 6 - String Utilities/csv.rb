require 'rubygems'
require 'faster_csv'

unless ARGV[0]
	puts "Usage: ruby csv.rb <filename.ext>"
	puts "Example: ruby csv.rb comma.seperated"
    exit
end

unless File.exist?(ARGV[0])
	puts "\nThe file could not be found, check the path"
	puts "Usage: ruby csv.rb comma.seperated"
	exit
end

file = FasterCSV.open(ARGV[0], "r")

print "Does the file include header information (y/n)? "
h = $stdin.gets.chomp

if h.downcase == 'y'
    header = file.shift                 #pop off the header information
    print header.join("\t")
    
    file.each do |line|
        puts
        print line.join("\t")
    end
else
    print "Enter header information (seperated by commas): "
    header = $stdin.gets.strip
    header = header.split(",")
    header.each do |h|
        print h + "\t"
    end
    
    file.each do |line|
        puts
        line.each do |element|
            print element + "\t"
        end
    end
end