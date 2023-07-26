$LOAD_PATH.unshift( "../ordlite/lib" )
require 'ordlite'




OrdDb.open( './ordsub1k.db' )



inscribe = Inscribe.find_by( num: 580 )
puts inscribe.blob.content
puts
pp inscribe.blob.content
puts
puts inscribe.blob.text
puts
puts inscribe.text

puts "bye"