####
# to run use:
#   $ ruby -I ./lib sandbox/test_more.rb

require 'bitgen'


###
# 690 Ordinals Egg (60x60)  @ inscribe no. 10265255 - May 31st, 2023 
# see <https://ordinals.com/inscription/15e0a8e0a6adde4388f14d6385db7ac63d55acb1c5a5b67aa4f8de3d5ad5dacci0> 
#
# 10 000 Unemployed Artist (24x24) @ inscribe no. 11673452 - June 13th, 2023 
# see <https://ordinals.com/inscription/c11e21e4ac155b88d8cc4cb7e11d8c4f66112e95cac04c4cb14e9361d93aac16i0>


deploys = [
  'ordinalsegg',
  'unemployedartist'  
]


deploys.each do |slug|
    puts "==>  #{slug}..."
    cat = Bitgen::Catalog.read( "./#{slug}.json" )

    pp cat.name
    pp cat.slug
    pp cat.dim
    pp cat.width
    pp cat.height
    pp cat.categories

    puts
    puts cat.cheat

    cat.export
end


puts "bye"