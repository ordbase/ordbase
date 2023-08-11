
$LOAD_PATH.unshift( "../../pixelart/pixelart/lib" )
require 'pixelart'



module Bixel
  # 7x7 canvas (49 pixels)
  #   10 colors (0-9)
  COLORS = {
        '0': '#434a41', 
        '1': '#689579', 
        '2': '#cdd995', 
        '3': '#e7debf', 
        '4': '#e5cc7c', 
        '5': '#f1b31f', 
        '6': '#e99248', 
        '7': '#da4c27', 
        '8': '#dac8c6', 
        '9': '#547d8e'
  } 
  WIDTH  = 7
  HEIGHT = 7         
end # module Bixel


# .bixel (at inscribe no. 21964036)
img = Image.parse( '3113113111111311303011111111117777711111131111333',
                   colors: Bixel::COLORS,
                   width:  Bixel::WIDTH,
                   height: Bixel::HEIGHT ) 
img.save( "./tmp/bixel1a.png" )
img.zoom(8).save( "./tmp/bixel1a@8x.png" )




module Bixel
  class Image < Pixelart::Image
    def self.parse( pixels )
      super( pixels, colors: COLORS, 
                     width: WIDTH,
                     height: HEIGHT)
    end
  end # class Image
end # module Bixel

# .bixel (at inscribe no. 21964036)
img = Bixel::Image.parse( '3113113111111311303011111111117777711111131111333' ) 
img.save( "./tmp/bixel1.png" )
img.zoom(8).save( "./tmp/bixel1@8x.png" )



puts "bye"