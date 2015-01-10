require 'RMagick'           #included because we'll be manipulating images
require 'ftools'            #included because we'll be creating directories
include Magick              #Too lazy to write Magick:: in front of every RMagick method

photos_row = 4
table_border = 1
html_rows = 1

#Make all the directories
File.makedirs("gallery/thumbs", "gallery/resize")
output = File.new("gallery/index.html","w+b")

output.puts <<EOF
<html>
    <head>
        <title>My Photos</title>
    </head>
    <body bgcolor="#d0d0d0">
        <h1>Welcome To My Photo Gallery</h1>
        <table border=#{table_border}>
EOF

Dir['*.[Jj][Pp]*[Gg]'].each do |pic|
  #create the thumbnail
  thumb = Image.read(pic)[0]
  thumb.change_geometry!('150x150') do |cols, rows, img|
    thumb.resize!(cols, rows)
  end
  if File.exists?("gallery/thumbs/th_#{pic}")
    puts "Could not write file th_#{pic}, thumbnail already exists.  Renaming to new_th_#{pic}"
    thumb.write "gallery/thumbs/new_th_#{pic}"
  else
    thumb.write "gallery/thumbs/th_#{pic}"
  end

  #resize the picture
  resize = Image.read(pic)[0]
  resize.change_geometry!('800x600') do |cols, rows, img|
    resize.resize!(cols, rows)
  end
  if File.exists?("gallery/resize/resize_#{pic}")
    puts "Could not write file resize_#{pic}, resized image already exists.  Renaming to new_resize_#{pic}"
    resize.write("gallery/resize/new_resize_#{pic}")
  else
    resize.write("gallery/resize/resize_#{pic}")
  end
    
  if html_rows % photos_row == 1
    output.puts "\n<tr>"
  end
    
  output.puts <<EOF
        <td><a href="resize/resize_#{pic}/" title="#{pic}" target="_blank"><img src="thumbs/th_#{pic}" alt="#{pic}"/></a></td>
EOF
        
  if html_rows % photos_row == 0
    output.puts "</tr>"
  end
  html_rows+=1
end

unless html_rows % photos_row == 1
  output.puts "</tr>"
end

output.puts "</body>\n</html>"
output.puts "<!-- Courtesy of No Starch Press: Wicked Cool Ruby Scripts -->"
output.close
