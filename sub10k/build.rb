#####
#  build  ordsub10k.db  (sqlite database with first 10 000 ordinal inscriptions)

$LOAD_PATH.unshift( "../ordinals/lib" )
$LOAD_PATH.unshift( "../ordlite/lib" )


require 'ordlite'



OrdDb.open( './ordsub10k.db' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   0 inscribe(s)
#=>   0 blob(s)



10.times do |num|   # auto-add inscription 0-9999
    OrdDb.import( num )
end
 

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   10000 inscribe(s)
#=>   10000 blob(s)


puts "bye"