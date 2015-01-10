#!/usr/bin/env ruby

#Using the command 'useradd' with various arguments

print "Enter new username: "
user_name = gets.chomp

#Add the groups to the user
print "\nEnter primary group: "
gname = gets.chomp
add_user = "-g #{gname} "
 
while gname
  print "\nEnter next group (return blank line when finished): "
  gname = gets.chomp
  break if gname.empty?
  add_user << "-G #{gname} "
end

#Define which program will start when the user logs in
puts "\n\n\n[1] Bourne Again Shell (bash)"
puts "[2] Korn Shell (ksh)"
puts "[3] Z Shell (zsh)"
puts "[4] C Shell (csh)"
print "Which shell do you prefer (default bash)? "

sh_num = gets.chomp.to_i
shell = case sh_num
when 1 then '/bin/bash'
when 2 then '/bin/ksh'
when 3 then '/bin/zsh'
when 4 then '/bin/csh'
else '/bin/bash'
end

add_user << "-s #{shell} "

#Define home directory
add_user << "-d /home/#{user_name} "

#Define starting folder
add_user << "-m #{user_name}"

#Add user to the system and look at return value
if(system("useradd #{add_user}"))
  puts "\n\nSuccessfully added: #{user_name}"
else
  puts "\n\nUnable to add: #{user_name}"
end