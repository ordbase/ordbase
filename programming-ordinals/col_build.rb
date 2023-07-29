#####
#  build  ord.db  (sqlite database with sample collection inscriptions)

$LOAD_PATH.unshift( "../ordinals/lib" )
$LOAD_PATH.unshift( "../ordlite/lib" )


require 'ordlite'



OrdDb.open( './ord.db' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
puts "  #{Collection.count} collection(s)"
#=>   0 inscribe(s)
#=>   0 blob(s)
#=>   0 collection(s)


# sample 1
OrdDb.import_collection( "./meta/ordinalpunks.json" )

# sample 2
OrdDb.import_collection_csv( "./meta/shrooms_inscriptions.csv",
                              name: 'Bitcoin Shrooms'  )

# sample 3
OrdDb.import_collection_inscriptions( "./meta/diypunks_inscriptions.json",
                                        name: 'D.I.Y. Punks' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
puts "  #{Collection.count} collection(s)"


puts "bye"