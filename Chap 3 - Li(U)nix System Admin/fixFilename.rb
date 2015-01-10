#!/usr/bin/ruby

unless ARGV[0]
  puts "Usage: ruby fixFilname.rb <filename.ext>"
  puts "Example: ruby fixFilename.rb \'How to (make) 20% more on $500.pdf\'"
  exit
end

old_filename = ARGV[0]

unless File.exist?(old_filename)
  puts "#{old_filename} does not exist.  Please try again."
  exit
end

name = File.basename(old_filename, ".*")
ext = File.extname(old_filename)

#Hash of bad chars for filenames, modify as needed
replacements = {  /;/ => "-",
  /\s/ => "_",
  /\'\`/ => "=",
  /\&/ => "_and_",
  /\$/ => "dollar_",
  /%/ => "_percent",
  /[\(\)\[\]<>]/ => ""
}  

#Go through each file
replacements.each do |orig, fix|
  name.gsub!(orig,fix)
end

#Rename the bad file name to a good file name
File.rename(old_filename, name + ext)

#Oh yeah, let the user know what's up
puts "#{old_filename} ---> #{name + ext}"