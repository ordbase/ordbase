####
# to run use:
#   $ ruby -I ./lib sandbox/test_importer.rb

require 'ordlite'



OrdDb.setup_in_memory_db



## case 1 - single id
OrdDb.import( '0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5ci0' )

## case 2 - array of ids
OrdDb.import( ['0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5ci0',
               '0a5813053f3c6bae54f39adf38e3b260c34d530304b7fc2e95eb7871e14a9790i0'
              ] )

## case 3 - empty array
OrdDb.import( [] )

## case 4 - array of records (hash with id keys)
OrdDb.import( [{'id' => '0a3a4dbf6630338bc4df8e36bd081f8f7d2dee9441131cb03a18d43eb4882d5ci0'},
               {'id' => '0a5813053f3c6bae54f39adf38e3b260c34d530304b7fc2e95eb7871e14a9790i0'},
              ] )


              
## case 1 - single num(ber)
OrdDb.import( 0 )   ## inscription number 0

## case 2 - array of num(ber)s
OrdDb.import( [0,1] )   ## inscription numbers 0 & 1

OrdDb.import( [{ 'num' => 0},
               { 'num' =>  1},] )   ## inscription numbers 0 & 1

OrdDb.import( [{ 'num' => '0'},
               { 'num' => '1'},] )   ## inscription numbers 0 & 1


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"


puts "bye"