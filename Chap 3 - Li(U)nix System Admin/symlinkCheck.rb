#!/usr/bin/ruby

unless File.directory?(ARGV[0])
  puts "Not a valid directory...\nCheck path and try again.\n\n"
  exit
end

#Open a directory
Dir.open(ARGV[0]) do |adir|
  #Check each file for symlink-ness and validity
  adir.each do |afile|
    next unless FileTest.symlink?(afile)
    next if File.file?(afile)
    #Report to user
    puts "Bad Link: #{File.expand_path(afile)}"
  end
end
