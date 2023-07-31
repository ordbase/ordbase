####
# to run use:
#   $ ruby -I ./lib sandbox/test_more.rb

require 'bitgen'


deploys = [
  'ordibotmrs',
  'gbrc721bitpunks',
  'ordinalsegg',
  'unemployedartist',
  'satoshipets',  
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