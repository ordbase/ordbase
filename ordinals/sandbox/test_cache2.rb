$LOAD_PATH.unshift( "./lib" )
require 'ordinals'



cache = Ordinals::Cache.new( '../../ordinals.cache/inscription' )
cache.stats

puts "bye"
