###
# to run use
#
#  $ ruby sandbox/import_relays.rb


$LOAD_PATH.unshift( "../unisat/lib" )
require 'unisat'
require 'ordlite'


cache = Unisat::Cache.new( './unisat' )


recs = cache.read( '"relay"' )   
puts "  #{recs.size} inscribe(s)"
pp recs[0,2]


OrdDb.open( './ordbase.db' )
OrdDb.import( recs )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"

puts "bye"
