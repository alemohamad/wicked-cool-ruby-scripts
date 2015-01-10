require 'English'

unless ARGV[0] && ARGV[1]
	puts "\nYou need to include a value to search for."
	puts "Usage: ruby ruby_grep.rb \"value_to_search\" '**/*'"
	exit
end

pattern = ARGV[0]
glob = ARGV[1]     # has to be single-quoted on the command-line

Dir[glob].each do |file|
  next unless File.file?(file)   # skip directories, links, etc.
  File.open(file, "rb") do |f|
    f.each_line do |line|
      puts "#{File.expand_path(file)}: #{$INPUT_LINE_NUMBER}: #{line}" if line.include?(pattern) #Watch the if at the end of the line
    end
  end
end