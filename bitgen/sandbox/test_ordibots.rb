####
# to run use:
#   $ ruby -I ./lib sandbox/test_ordibots.rb

require 'bitgen'

cat = Bitgen::Catalog.read( './ordibots.json' )

pp cat.name
pp cat.slug
pp cat.dim
pp cat.width
pp cat.height
pp cat.categories

puts
puts cat.cheat

cat.export

puts "bye"

