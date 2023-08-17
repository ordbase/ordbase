
require 'pixelart'

require_relative 'bixel'


puts "#{Bixel::COLORS.size} bixel colors:"
pp Bixel::COLORS

Bixel::COLORS.each do |name,hex|
  bar = Image.new( 24, 24, hex )
  bar.save( "./tmp/color#{name}.png" )
  color = Color.parse( hex )
  print "#{name} " 
  print Color.fmt( color )
  print "\n"
end

puts "#{Biixel::COLORS.size} biixel colors:"
pp Biixel::COLORS

Biixel::COLORS.each do |name,hex|
    bar = Image.new( 24, 24, hex )
    bar.save( "./tmp/color#{name}.png" )
    color = Color.parse( hex )
    print "#{name} " 
    print Color.fmt( color )
    print "\n"
end
  

puts "bye"