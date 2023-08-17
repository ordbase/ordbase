### download biixel ordinals metadata & content
###   into cache
###  and add to dabase; to run use:
##
##   $ ruby sandbox/download.rb


require 'ordlite'


cache = Ordinals::Cache.new( './tmp/inscription' )
cache.add_csv( './biixel.csv' )


OrdDb.open( './ord.db' )
cache.import_all

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"


puts "bye"
