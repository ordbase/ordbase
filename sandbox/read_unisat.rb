$LOAD_PATH.unshift( "./unisat/lib" )
require 'unisat'


cache = Unisat::Cache.new( './tmp/unisat' )


recs = cache.read( 'biixel' )   
puts "  #{recs.size} inscribe(s)"
pp recs[0,2]

recs = cache.read( 'bixel' )  
puts "  #{recs.size} inscribe(s)"
pp recs[0,2]


recs = cache.read( 'diyphunks' )  
puts "  #{recs.size} inscribe(s)"
pp recs[0,2]

recs = cache.read( 'orangepixels' )  
puts "  #{recs.size} inscribe(s)"
pp recs[0,2]



puts "bye"
