####
# to run use:
#   $ ruby -I ./lib sandbox/generate_pets.rb

require 'bitgen'

gen = Bitgen::Generator.read( './satoshipets.json' )



pet = gen.generate( background: 'aube',
                    pets: 'monkey',
                    stuff: 'star',
                    eyes: 'normal'
                )

# (down)sample from 630x630px to 45x45px (14x zoom e.g. 14x45px=630px)                
steps = Image.calc_sample_steps( 630, 45 )              
pet = pet.sample( steps )
pet.save( "./tmp/pet1.png" )
pet.zoom(4).save( "./tmp/pet1@4x.png" )


pet = gen.generate( background: 'twilight',
                    pets: 'rabbit',
                    stuff: 'rainbow',
                    eyes: 'mask'
                  )

pet = pet.sample( steps )
pet.save( "./tmp/pet2.png" )
pet.zoom(4).save( "./tmp/pet2@4x.png" )


pet = gen.generate( pets: 'monkey',
                    eyes: 'normal'
                )

pet = pet.sample( steps )
pet.save( "./tmp/pet1a.png" )
pet.zoom(4).save( "./tmp/pet1a@4x.png" )


pet = gen.generate( pets: 'rabbit',
                    eyes: 'mask'
                  )

pet = pet.sample( steps )
pet.save( "./tmp/pet2a.png" )
pet.zoom(4).save( "./tmp/pet2a@4x.png" )

puts "bye"
