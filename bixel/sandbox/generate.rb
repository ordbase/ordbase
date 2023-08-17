
require 'pixelart'

require_relative 'bixel'


###############
# Bixel OG

# .bixel (at inscribe no. 21964036)
img = Image.parse( '3113113111111311303011111111117777711111131111333',
                   colors: Bixel::COLORS,
                   width:  Bixel::WIDTH,
                   height: Bixel::HEIGHT ) 
img.save( "./tmp/bixel1a.png" )
img.zoom(8).save( "./tmp/bixel1a@8x.png" )



# .bixel no. 10 (at inscribe no. 21964036)  
img = Bixel::Image.parse( '3113113111111311303011111111117777711111131111333' ) 
img.save( "./tmp/bixel10.png" )
img.zoom(8).save( "./tmp/bixel10@8x.png" )



###############
# Biixel v2

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
