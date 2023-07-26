
$LOAD_PATH.unshift( "../ordlite/lib" )
require 'ordlite'


OrdDb.open( './ordsub1k.db' )


## get bitcoin whitpaper (no. 54) pdf document
inscribe = Inscribe.find_by( num: 54 )
write_blob( "../docs/bitcoin.pdf", inscribe.content )



puts "bye"