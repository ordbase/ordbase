#####
#  build  ordpunks.db  (sqlite database with 100 ordinal punk inscriptions)

$LOAD_PATH.unshift( "../ordinals/lib" )
$LOAD_PATH.unshift( "../ordlite/lib" )


require 'ordlite'



OrdDb.open( './ordpunks.db' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   0 inscribe(s)
#=>   0 blob(s)


OrdDb.import_collection( "./ordinalpunks.json" )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   100 inscribe(s)
#=>   100 blob(s)


puts "bye"