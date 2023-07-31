####
# to run use:
#   $ ruby -I ./lib sandbox/generate_flower.rb

require 'bitgen'

gen = Bitgen::Generator.read( './blooming-flower.json' )



flower = gen.generate( background: 'new-moon',
                window: 'simple-yellow',
                table: 'metal',
                flowerpot: 'ceramics-red',
                rose: 'bud-red'
                )

flower.save( "./tmp/flower1.png" )
flower.zoom( 4 ).save( "./tmp/flower1@4x.png" )


flower = gen.generate( background: 'autumn',
                window: 'sliding-yellow',
                table: 'wood',
                flowerpot: 'ceramics-blue',
                rose: 'bud-white'
                )

flower.save( "./tmp/flower2.png" )
flower.zoom( 4 ).save( "./tmp/flower2@4x.png" )


flower = gen.generate(  flowerpot: 'ceramics-red',
                        rose: 'bud-red'
                )

flower.save( "./tmp/flower1a.png" )
flower.zoom( 4 ).save( "./tmp/flower1a@4x.png" )


flower = gen.generate( flowerpot: 'ceramics-blue',
                   rose: 'bud-white'
                  )

flower.save( "./tmp/flower2a.png" )
flower.zoom( 4 ).save( "./tmp/flower2a@4x.png" )


puts "bye"