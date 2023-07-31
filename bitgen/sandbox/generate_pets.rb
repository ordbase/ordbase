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

pet.save( "./tmp/pet1.png" )


pet = gen.generate( background: 'twilight',
                    pets: 'rabbit',
                    stuff: 'rainbow',
                    eyes: 'mask'
                  )

pet.save( "./tmp/pet2.png" )


pet = gen.generate( pets: 'monkey',
                    eyes: 'normal'
                )

pet.save( "./tmp/pet1a.png" )


pet = gen.generate( pets: 'rabbit',
                    eyes: 'mask'
                  )

pet.save( "./tmp/pet2a.png" )

puts "bye"
