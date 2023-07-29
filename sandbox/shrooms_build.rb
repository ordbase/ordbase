#####
#  build  ordpunks.db  (sqlite database with 100 ordinal punk inscriptions)

$LOAD_PATH.unshift( "../ordinals/lib" )
$LOAD_PATH.unshift( "../ordlite/lib" )


require 'ordlite'



OrdDb.open( './ord.db' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
puts "  #{Collection.count} collections(s)"


OrdDb.import_collection_csv( "../programming-ordinals/shrooms_inscriptions.csv",
              name: 'Bitcoin Shrooms',
              content: false )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
puts "  #{Collection.count} collections(s)"


puts "bye"