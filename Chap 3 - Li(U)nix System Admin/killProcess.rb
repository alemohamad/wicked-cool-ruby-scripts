#!/usr/bin/ruby

max_time = 300
ps_list = `ps h -eo cputime, pcpu, pid, user, cmd`

#Get a list of processes
list = ps_list.split(/\n/)

#Check each process
list.each do |p|
  process = p.split
  process[0] =~ /(\d+):(\d+):(\d+)/
  cpu_time = $1*3600 + $2*60 + $3
  next if cpu_time < $max_time
  next if process[3] == "root" or process[3] == "postfix"
  next if process[4] == "kdeinit"
	
  begin
    print "Would you like to kill: #{process[4]} (y/n)? "
    if gets.downcase == "y"
      #can use :SIGTERM if you're feeling especially angry
      Process.kill :TERM,process[2]	
    end
  rescue
    puts "Couldn't kill the process...check permission."
    retry
  end
end
