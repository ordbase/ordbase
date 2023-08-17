
require 'pixelart'

require_relative 'bixel'


puts "#{Bixel::COLORS.size} bixel colors:"
pp Bixel::COLORS

Bixel::COLORS.each do |name,hex|
  bar = Image.new( 24, 24, hex )
  bar.save( "./tmp/color#{name}.png" )
end

puts "#{Biixel::COLORS.size} biixel colors:"
pp Biixel::COLORS

Biixel::COLORS.each do |name,hex|
    bar = Image.new( 24, 24, hex )
    bar.save( "./tmp/color#{name}.png" )
end
  

puts "bye"