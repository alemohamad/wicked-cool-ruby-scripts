unless ARGV[0]
  puts "\n\n\nYou need to specify a filename:  massEdit.rb <filename>\n\n\n"	
  exit
end

name = ARGV[0]
x=0

#Iterate directory and rename files
Dir['*.[Jj][Pp]*[Gg]'].each do |pic|
  new_name = "#{name}_#{"%.2d" % x+=1}#{File.extname(pic)}"
  puts "Renaming #{pic} ---> #{new_name}"
  File.rename(pic, new_name)
end