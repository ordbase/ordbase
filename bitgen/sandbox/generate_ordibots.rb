####
# to run use:
#   $ ruby -I ./lib sandbox/generate_ordibots.rb

require 'bitgen'

gen = Bitgen::Generator.read( './ordibots.json' )



bot = gen.generate( accessories: 'antenna',
                body: 'gold-oval',
                belly: 'chess',
                face: 'happy'
                )

bot.save( "./tmp/bot1.png" )
bot.zoom( 4 ).save( "./tmp/bot1@4x.png" )


bot = gen.generate( background: 'bitcoin-orange',
                accessories: 'rainbow',
                body: 'standard-square',
                belly: 'empty',
                face: 'unimpressed'
                )

bot.save( "./tmp/bot2.png" )
bot.zoom( 4 ).save( "./tmp/bot2@4x.png" )



bot = gen.generate( background: 'bitcoin-orange',
                accessories: 'rainbow',
                body: 'black-and-white-triangular',
                belly: 'square',
                face: 'happy'
                )

bot.save( "./tmp/bot3.png" )
bot.zoom( 4 ).save( "./tmp/bot3@4x.png" )

puts "bye"