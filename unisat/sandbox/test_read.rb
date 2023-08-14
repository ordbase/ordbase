####
# to run use:
#   $ ruby -I ./lib sandbox/test_read.rb

require 'unisat'


cache = Unisat::Cache.new( './tmp/unisat' )

recs = cache.read( 'biixel' )
pp recs[0,2] 
puts "   #{recs.size} record(s)" 

recs = cache.read( 'bixel' )
pp recs[0,2] 
puts "   #{recs.size} record(s)" 

puts "bye"
