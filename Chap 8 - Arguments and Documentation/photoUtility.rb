# == Synopsis
# 
#  photo_utility: manipulate images to resize, watermark, or make a web photo album
# 
# 
# == Usage
# 
# photo_utility [OPTIONS] ... IMAGE
# 
# -h, --help
#   show help
# 
# --bw, -b
#    convert an image to black and white
# 
# --gallery, -g
#    create a web photo album. Enter "temp" for IMAGE when using this option
# 
# --info, -i
#    extract the photo information
# 
# --resize size, -r size
#    resize a file to a specific dimension
# 
# --watermark text, -w text
#    watermark an image with the text supplied
# 
# IMAGE: The photo you want to manipulate

require 'getoptlong'
require 'rdoc/ri/ri_paths'
require 'rdoc/usage'
require 'RMagick'
require 'exifr'
require 'ftools'
include EXIFR
include Magick

#convert image to Black and White
def bw(file)
  new_img = "bw_#{file}"
  img = Image.read(file).first

  img = img.quantize(256, GRAYColorspace)

  if File.exists?(new_img)
    puts "Could not write file, image name already exists"
    exit
  end
                
  img.write(new_img)
end

#create a web photo gallery
def gallery()
  photos_row = 4
  table_border = 1
  html_rows = 1

  # Make all the directories
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
    # create the thumbnail
    thumb = Image.read(pic)[0]
    thumb.change_geometry!('150x150') do |cols, rows, img|
      thumb.resize!(cols, rows)
    end
    if File.exists?("gallery/thumbs/th_#{pic}")
      puts "Could not write file th_#{pic}, thumbnail already exists.  Renaming to new_th_#{pic}"
      thumb.write "gallery/thumbs/new_th_#{pic}"
    else
      # #Write them to a seperate folder if you wish to get organized...or you
      # could just sort by filename
      thumb.write "gallery/thumbs/th_#{pic}"
    end

    # resize the picture
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
end

#Get image information
def info(file)
  info = JPEG.new(file)

  File.open("info_#{File.basename(file)}.txt", "w") do |output|
    output.puts info.exif.to_hash.map{ |k,v| "#{k}:  #{v}"}
  end
end

#resize image
def resize(file, arg)
  size = arg.chomp
  img = Image.read(file).first
  width = nil
  height = nil
            
  img.change_geometry!("#{size}x#{size}") do |cols, rows, img|
    img.resize!(cols, rows)
    width = cols
    height = rows
  end

  file_name = "#{width}x#{height}_#{file}"

  if File.exists?(file_name)
    puts "File already exists.  Unable to write file"
    exit
  end

  img.write(file_name)
end

#add watermark to image
def watermark(file, arg)
  text = arg.chomp
  img = Image.read(file).first
  new_img = "wm_#{file}"

  if File.exists?(new_img)
    puts "Image already exists.  Unable to create file."
    exit
  end

  watermark = Image.new(600, 50)

  watermark_text = Draw.new
  watermark_text.annotate(watermark, 0,0,0,0, text) do
    watermark_text.gravity = CenterGravity
    self.pointsize = 50
    self.font_family = "Arial"			#If you have a fancy curly font you can substitute here
    self.font_weight = BoldWeight
    self.stroke = "none"
  end

  watermark.rotate!(45)
  watermark = watermark.shade(true, 310, 30)
  img.composite!(watermark, SouthWestGravity, HardLightCompositeOp)		#Bottom-Left Marking
  watermark.rotate!(-90)
  img.composite!(watermark, NorthWestGravity, HardLightCompositeOp)		#Top-Left Marking
  watermark.rotate!(90)
  img.composite!(watermark, NorthEastGravity, HardLightCompositeOp)		#Top-Right Marking
  watermark.rotate!(-90)
  img.composite!(watermark, SouthEastGravity, HardLightCompositeOp)		#Bottom-Right Marking

  puts "Writing #{new_img}"
  img.write(new_img)
end

#define command line arguments
opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
  [ '--black', '-b', GetoptLong::NO_ARGUMENT ],
  [ '--gallery', '-g', GetoptLong::NO_ARGUMENT ],
  [ '--info', '-i', GetoptLong::NO_ARGUMENT ],
  [ '--resize', '-r', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--watermark', '-w', GetoptLong::REQUIRED_ARGUMENT ]
)

filename = ARGV[-1].chomp

#add case statements for each command line argument defined above
opts.each do |opt, arg|
  case opt
  when '--help'
    RDoc::usage
  when '--black'
    bw(filename)
  when '--gallery'
    gallery()
  when '--info'
    info(filename)
  when '--resize'
    resize(filename, arg)
  when '--watermark'
    watermark(filename, arg)
  else
    RDoc::usage
  end
end