links = Array.new
orphans = Array.new
dir_array = [Dir.getwd]
#Read in links validator output slightly modified

unless File.readable?("links.txt")
  puts "File is not readable."
  exit
end

File.open('links.txt', 'rb') do |lv|
  lv.each_line do |line|
    links << line.chomp
  end
end
#Index all files (just looking at html in this case)

begin       			#Start the loop
  p = dir_array.shift   	#remove one item from directory array 
  Dir.chdir(p)            	#change to new directory to search
    
  #for each file in the dir, compute md5 sum and add to new hash
  Dir.foreach(p) do |filename|
    #go to next folder if '.' or '..'
    next if filename == '.' or filename == '..'     
    #if not a directory, then process file
    if !File::directory?(filename)      		
      orphans << p + File::SEPARATOR + filename
    else
      #if not a file, put the directories into array for later
      dir_array << p + File::SEPARATOR + filename      
    end
  end
end while !dir_array.empty?  #THIS PART INDEXES ALL FILES IN THE DIRECTORIES


orphans -= links


#Output remaining links
#Files that are left in array are orphaned and don't have a link
File.open("orphans.txt", "wb") do |o|
  o.puts orphans
end
