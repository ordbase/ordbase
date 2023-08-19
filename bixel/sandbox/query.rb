require 'ordlite'
require 'pixelart'

require_relative 'bixel'



OrdDb.open( './ord.db' )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
puts


inscribes = Inscribe.search( 'biixel' )
                
puts
puts "  #{inscribes.size} inscribe(s) - unconfirmed candidates"



## validate / filter-out false positives
inscribes = inscribes.select do |inscribe|
                if Biixel.match( inscribe.text )
                    true
                else  
                    puts "!! WARN - expected [A-U]{100}.biixel inscribe no. #{inscribe.num} @ #{inscribe.date}; got:"
                    puts "  >#{inscribe.text}<"
                    false  
                end
             end

puts
puts "  #{inscribes.size} inscribe(s) - validated"
             


##
## first hundred in 10x10 grid
composite = ImageComposite.new( 10, 10, width: Biixel::WIDTH,
                                        height: Biixel::HEIGHT )

inscribes[0,100].each do |inscribe|
    txt = inscribe.text
    spec = txt.strip.sub( '.biixel', '' )
    img = Biixel::Image.parse( spec )
    composite << img
end

composite.save( "./tmp/biixels_100.png" )
composite.zoom(4).save( "./tmp/biixels_100@4x.png" )


##
## first thousand in 20x50 grid
composite = ImageComposite.new( 20, 50, width: Biixel::WIDTH,
                                        height: Biixel::HEIGHT )

inscribes[0,1000].each do |inscribe|
    txt = inscribe.text
    spec = txt.strip.sub( '.biixel', '' )
    img = Biixel::Image.parse( spec )
    composite << img
end

composite.save( "./tmp/biixels_1000.png" )
composite.zoom(4).save( "./tmp/biixels_1000@4x.png" )

puts "bye"
