####
# to run use:
#   $ ruby -I ./lib sandbox/generate_punks.rb

require 'bitgen'

gen = Bitgen::Generator.read( './gbrc721bitpunks.json' )


punk = gen.generate( sex: 'zombie',
                     hair: 'hoodie 0',
                     ears: 'earring 0',
                     neck: 'gold chain 0',
                     emotion: 'smile 0',
                     eyes: '3d big shades 0' )

punk.save( './tmp/punk1.png' )
punk.zoom(8).save( './tmp/punk1@8x.png' )


punk = gen.generate( sex: 'alien',
                     hair: 'cap forward 0' )

punk.save( './tmp/punk2.png' )
punk.zoom(8).save( './tmp/punk2@8x.png' )
 
punk = gen.generate( sex: 'female3',
                     hair: 'wild blonde 1',
                     neck: 'silver chain 1',
                     lips: 'black lipstick 1',
                     eyes: '3d glasses 1' )

punk.save( './tmp/punk3.png' )
punk.zoom(8).save( './tmp/punk3@8x.png' )


punk = gen.generate( sex: 'female1',
                     hair: 'wild blonde 1', 
                     ears: 'earring 1',
                     eyes: 'big shades 1' )

punk.save( './tmp/punk4.png' )
punk.zoom(8).save( './tmp/punk4@8x.png' )
                     
puts "bye"
