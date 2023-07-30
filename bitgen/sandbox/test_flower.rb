####
# to run use:
#   $ ruby -I ./lib sandbox/test_flower.rb

require 'bitgen'

cat = Bitgen::Catalog.read( './blooming-flower.json' )

pp cat.name
pp cat.slug
pp cat.dim
pp cat.width
pp cat.height
pp cat.categories

puts
puts cat.cheat

## cat.export

puts "bye"