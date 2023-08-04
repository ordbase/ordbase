#####
#  build  ordsub1k.ltc.db  (sqlite database with first thousand ordinal inscriptions in litecoin/ltc)

$LOAD_PATH.unshift( "../ordinals/lib" )
$LOAD_PATH.unshift( "../ordlite/lib" )


require 'ordlite'



OrdDb.open( './ordsub1k.ltc.db' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   0 inscribe(s)
#=>   0 blob(s)


Ordinals.chain = :ltc 
OrdDb.import_csv( "./meta/sub1k_inscriptions.ltc.csv" )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   1000 inscribe(s)
#=>   1000 blob(s)


puts "bye"