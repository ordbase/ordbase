#####
#  build  ordpunks.db  (sqlite database with 100 ordinal punk inscriptions)

$LOAD_PATH.unshift( "../ordinals/lib" )
$LOAD_PATH.unshift( "../ordlite/lib" )


require 'ordlite'



OrdDb.open( './ord.db' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
puts "  #{Collection.count} collection(s)"
puts "  #{Factory.count} factories"



pp Inscribe.counts_by_day
pp Inscribe.counts_by_month

puts
pp Inscribe.counts_by_block

puts
pp Inscribe.counts_by_block_with_timestamp


puts
pp Inscribe.counts_by_hour

col = Collection.first
pp col
pp col.inscribes.counts_by_hour

puts Inscribe.sub1k.count
puts Inscribe.sub2k.count
puts Inscribe.sub1m.count


puts "bye"