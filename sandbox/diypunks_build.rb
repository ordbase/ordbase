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


OrdDb.import_collection_inscriptions( "./diypunks.json",
                                       name: 'D.I.Y. Punks',
                                       content: false )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
puts "  #{Collection.count} collection(s)"
puts "  #{Factory.count} factories"


puts "bye"