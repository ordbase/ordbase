#####
#  query ordsub1k.db  (sqlite database with first thousand ordinal inscriptions)

$LOAD_PATH.unshift( "../ordlite/lib" )
require 'ordlite'




OrdDb.open( './ord.db' )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
puts "  #{Collection.count} collection(s)"


#######################
# sample 1
col = Collection.find_by( name: 'Ordinal Punks' )

inscribes = col.inscribes
puts "  #{inscribes.size} inscribe(s)"
#=> 100 inscribe(s)

inscribes.counts_by_content_type

max = inscribes.maximum( 'num' )
min = inscribes.minimum( 'num' )

puts "    range no. #{min} to no. #{max}"
#=>  range no. 407 to no. 642

pp inscribes.counts_by_day
pp inscribes.counts_by_hour

pp inscribes.counts_by_block
pp inscribes.counts_by_block_with_timestamp


#############################
# sample 2

col = Collection.find_by( name: 'Bitcoin Shrooms' )

inscribes = col.inscribes
puts "  #{inscribes.size} inscribe(s)"
#=> 210 inscribe(s)

pp inscribes.counts_by_content_type

max = inscribes.maximum( 'num' )
min = inscribes.minimum( 'num' )

puts "    range no. #{min} to no. #{max}"
#=>  range no. 675 to no. 1075

pp inscribes.counts_by_day
pp inscribes.counts_by_hour

pp inscribes.counts_by_block
pp inscribes.counts_by_block_with_timestamp


##############################
# sample 3

col = Collection.find_by( name: 'D.I.Y. Punks' )

inscribes = col.inscribes
puts "  #{inscribes.size} inscribe(s)"
#=> 721 inscribe(s)

pp inscribes.counts_by_content_type


max = inscribes.maximum( 'num' )
min = inscribes.minimum( 'num' )

puts "    range no. #{min} to no. #{max}"
#=>   range no. 9959200 to no. 10286852

pp inscribes.counts_by_day
pp inscribes.counts_by_hour

pp inscribes.counts_by_block
pp inscribes.counts_by_block_with_timestamp


puts "bye"