#################################
# to run use:
#
#  $ ruby sandbox/test_api.rb

$LOAD_PATH.unshift( "./lib" )
require 'ordinals'


id = 'c41021cb11dce003e6a20a3420cf5954a1d104a1fe314393b915a62f020dcd0ai0'

data = Ordinals.inscription( id )
pp data

content = Ordinals.content( id )
pp content


data = Ordinals.inscription( 21_000_000 )
pp data

content = Ordinals.content( 21_000_000 )
pp content


data = Ordinals.inscription( 0 )
pp data

data = Ordinals.inscription( 99 )
pp data

data = Ordinals.inscription( 100 )
pp data



## try litecoin / ltc
Ordinals.chain = :ltc
id = 'f2b6adf7b2d0f128fb14817ff37f5f36e9176b17571e20c49871875553f937b4i0'
content = Ordinals.content( id )
pp content


data = Ordinals.inscription( id )
pp data


content = Ordinals.content( 0 )
pp content

data = Ordinals.inscription( 0 )
pp data



puts "bye"

__END__

Ordinals.chain = :ltc
ids = Ordinals.inscription_ids( offset: 199 )
pp ids
ids = Ordinals.inscription_ids( offset: 299 )
pp ids
