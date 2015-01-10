require 'rubygems'
require 'faster_csv'

print "CSV file to read: "
infile = gets.strip

print "What do you want to call each element: "
record_name = gets.strip

print "What do you want to title the XML document: "
title = gets.strip

print "What do you want to call the set of elements: "
set = gets.strip

file = FasterCSV.open(infile, "rb")

#pop off the header information
header = file.shift

#Create and open the XML file
File.open(File.basename(infile, ".*") + ".xml", 'wb') do |ofile|
  ofile.puts '<?xml version="1.0"?>'
  ofile.puts "<#{set}>"
  ofile.puts "\t<name>#{title}</name>"
  file.each do |record|
    ofile.puts "\t<#{record_name}>"
    for i in 0..(header.size - 1)
      ofile.puts "\t\t<#{header[i]}>#{record[i]}</#{header[i]}>"
    end
    ofile.puts "\t</#{record_name}>"
  end
  ofile.puts "</#{set}>"
end
