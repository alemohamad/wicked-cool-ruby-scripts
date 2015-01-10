require 'RMagick'
include Magick

#Dimisions based on an image 3072x2048

unless ARGV[0] and File.exists?(ARGV[0])
  puts "\n\n\nYou need to specify a filename:  watermark.rb <filename>\n\n\n"	
  exit
end

img = Image.read(ARGV[0]).first
new_img = "wm_#{ARGV[0]}"

if File.exists?(new_img)
  puts "Image already exists.  Unable to create file."
  exit
end

watermark = Image.new(600, 50)

watermark_text = Draw.new
watermark_text.annotate(watermark, 0,0,0,0, "Pics by No Starch") do
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