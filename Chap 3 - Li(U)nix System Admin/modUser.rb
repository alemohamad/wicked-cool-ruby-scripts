#!/usr/bin/env ruby

#Using the command 'useradd' with various arguments

print "Enter the username to modify: "
user_name = gets.chomp

#Determine how many groups the account will belong to
print "Would you like to add this account to any groups [y/n]? "
gresult = gets.chomp
if (gresults == 'y' || gresults == 'Y')
  #Add the groups to the user
  print "\nEnter primary group: "
  gname = gets.chomp
  mod_user = "-g #{gname} "
 
  while gname
    print "\nEnter next group: "
    gname = gets.chomp
    break if gname.empty?
    add_user << "-G #{gname} "
  end
end


#Define which program will start when the user logs in
print "Would you like to change the starting shell [y/n]? "
sresult = gets.chomp
if (sresults == 'y' || sresults == 'Y')
    puts "\n\n\n[1] Bourne Again Shell (bash)"
    puts "[2] Korn Shell (ksh)"
    puts "[3] Z Shell (zsh)"
    puts "[4] C Shell (csh)"
    print "Which shell would you like? "

    sh_num = gets.chomp.to_i
    shell = case sh_num
        when 1 then '/bin/bash'
        when 2 then '/bin/ksh'
        when 3 then '/bin/zsh'
        when 4 then '/bin/csh'
        else '/bin/bash'
    end
    mod_user << "-s ${shell} "
end

#Define home directory
print "Would you like to change the home directory [y/n]? "
  dresult = gets.chomp
if (dresults == 'y' || dresults == 'Y')
  print "Enter new directory: "
  dir = gets.chomp
  mod_user << "-d #{dir} "
end

#Define new Login
print "Would you like to change the login name [y/n]? "
lresult = gets.chomp
if (lresults == 'y' || lresults == 'Y')
    print "Enter new login: "
    name = gets.chomp"
mod_user << "-l #{name}"
end

#Modify user and look at return value
if('usermod #{mod_user}')
puts "\n\nSuccessfully modified: #{user_name}\n"
else
puts "\n\nUnable to modify: #{user_name}\n"
end

