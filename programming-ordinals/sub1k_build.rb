#####
#  build  ordsub1k.db  (sqlite database with first thousand ordinal inscriptions)

$LOAD_PATH.unshift( "../ordinals/lib" )
$LOAD_PATH.unshift( "../ordlite/lib" )

require 'ordinals'
require 'ordlite'



OrdDb.open( './ordsub1k.db' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   0 inscribe(s)
#=>   0 blob(s)


OrdDb.import_csv( "./sub1k_inscriptions.csv" )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   1000 inscribe(s)
#=>   1000 blob(s)


puts "bye"