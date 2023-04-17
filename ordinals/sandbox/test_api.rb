#################################
# to run use:
#
#  $ ruby sandbox/test_api.rb

$LOAD_PATH.unshift( "./lib" )
require 'ordinals'


id = 'c41021cb11dce003e6a20a3420cf5954a1d104a1fe314393b915a62f020dcd0ai0'
content = Ordinals.client.content( id )
pp content


data = Ordinals.client.inscription( id )
pp data


## try litecoin / ltc
Ordinals.config.chain = :ltc
id = 'f2b6adf7b2d0f128fb14817ff37f5f36e9176b17571e20c49871875553f937b4i0'
content = Ordinals.client.content( id )
pp content


data = Ordinals.client.inscription( id )
pp data



puts "bye"