#################################
# to run use:
#
#  $ ruby sandbox/test_doge.rb

$LOAD_PATH.unshift( "./lib" )
require 'ordinals'


## try dogecoin / doge
Ordinals.chain = :doge


id = '8f7219639800fdddd510f35bcda52471828ded43753b1d2a42f2a054d006edd8i0'

data = Ordinals.inscription( id )
pp data

content = Ordinals.content( id )
pp content


data = Ordinals.inscription( 0 )
pp data

content = Ordinals.content( 0 )
pp content


ids = Ordinals.inscription_ids( offset: 199 )
pp ids


puts "bye"


