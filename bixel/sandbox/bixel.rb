
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

# .bixel no. 10 (at inscribe no. 21964036)  
img = Bixel::Image.parse( '3113113111111311303011111111117777711111131111333' ) 
img.save( "./tmp/bixel10.png" )
img.zoom(8).save( "./tmp/bixel10@8x.png" )



module Biixel
  # 10x10 canvas (100 pixels)
  #   21 colors (A-U)

COLORS = {
  A: '#88b2c4',
  B: '#547d8e',
  C: '#dac8c6', 
  D: '#7c7587',
  E: '#e3a18d', 
  F: '#da4c27',
  G: '#f1b31f',
  H: '#e99248',
  I: '#87c687', 
  J: '#529055',
  K: '#a08454', 
  L: '#966946',
  M: '#e7debf', 
  N: '#afa78a',
  O: '#d2fae0', 
  P: '#f7e382',
  Q: '#9aaf89', 
  R: '#e5cc7c',
  S: '#fff',
  T: '#d7e5e5',
  U: '#000'
}
  WIDTH  = 10
  HEIGHT = 10

  class Image < Pixelart::Image
    def self.parse( pixels )
      super( pixels, colors: COLORS, 
                     width:  WIDTH,
                     height: HEIGHT)
    end
  end # class Image
end  # module Biixel


pp Biixel::COLORS


# .biixel (at inscribe no. 22237694)
img = Biixel::Image.parse( 'UGGLBBBBBLUHGHLBBBLHBLHGHLBBHGBBLHGGGGGHBBLGGGGGGGDDHSUGGGSUDGHUUGGGUUDFFGGGLGGGDFFHGLHLGHDDLHHHHHHH' )
img.save( "./tmp/biixel1.png" )
img.zoom(8).save( "./tmp/biixel1@8x.png" )



bixels = [
  # Bixel #32 - Inscription #22140448
  [32,'0060000066660000600600066600006006006666000060000'],
  # Bixel #43 - Inscription #22140536
  [43,'0055500055555055050555555555550005606555600066600'],
  # Bixel #50 - Inscription #22140557
  [50,'9994999984548994575499845489988488998818899991999'],
  # Bixel #86 - Inscription #22141494
  [86,'8899988889998899999998888888889898888878888999998'],
  # Bixel #90 - Inscription #22141738
  [90,'0000000000100000110000001000000100000111000000000'],
  # Bixel #153 - Inscription #22159765
  [153,'0777777077777707777770777777077777707700000770000'],
  # Bixel #163 - Inscription #22159775
  [163,'3795793951116551010177117119311111333101333311133'],
  # Bixel #298 - Inscription #22160168
  [298,'0000000077077007070700700070007070000070000000000'],
  # Bixel #405 - Inscription #22160379
  [405,'7777777777777775777575757575577577557777755777775'],
  # Bixel #432 - Inscription #22160466
  [432,'0033300033333030030033003003333033303333300030300'],
]

bixels.each do |num,spec|
  img = Bixel::Image.parse( spec ) 
  img.save( "./tmp/bixel#{num}.png" )
  img.zoom(8).save( "./tmp/bixel#{num}@8x.png" )
end

puts "bye"