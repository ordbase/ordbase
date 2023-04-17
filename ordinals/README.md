# ordinals

ordinals gem - ordinals (inscription) api wrapper & helpers for Bitcoin, Litcoin, Dogecoin & co.


* home  :: [github.com/pixelartexchange/artbase](https://github.com/pixelartexchange/artbase)
* bugs  :: [github.com/pixelartexchange/artbase/issues](https://github.com/pixelartexchange/artbase/issues)
* gem   :: [rubygems.org/gems/ordinals](https://rubygems.org/gems/ordinals)
* rdoc  :: [rubydoc.info/gems/ordinals](http://rubydoc.info/gems/ordinals)


## Usage


For now ordinal inscription api queries are supported on
- Bitcoin  (via <https://ordinals.com>)
- Litecoin (via <https://ordinalslite.com>) and
- Dogecoin (via <https://doginals.com>)


Let's start querying for bitcoin (btc) ordinal inscriptions:

``` ruby
require 'ordinals'


# get the inscription binary blob / data by id
#  e.g. GET https://ordinals.com/content/c41021cb11dce003e6a20a3420cf5954a1d104a1fe314393b915a62f020dcd0ai0...

id = 'c41021cb11dce003e6a20a3420cf5954a1d104a1fe314393b915a62f020dcd0ai0'
content = Ordinals.content( id )
pp content
#=> #<Ordinals::Api::Content:0x000001a1352df938
#      @data="RIFF\xF8\v\x00\x00WEBPVP8 \xEC\v\x00\x00...",
#      @length=3072,
#      @type="image/png">

# get the inscription meta data by id
#  e.g.  https://ordinals.com/inscription/c41021cb11dce003e6a20a3420cf5954a1d104a1fe314393b915a62f020dcd0ai0...
data = Ordinals.inscription( id )
pp data
#=> {"title"=>"Inscription 133993",
#    "id"=>"c41021cb11dce003e6a20a3420cf5954a1d104a1fe314393b915a62f020dcd0ai0",
#    "address"=>"bc1pyncs638hxfhaqjvnedw2lyc2jta6zuvr9erj6m9cwlghp6qqwvhqeq574l",
#    "output value"=>"9667",
#    "sat"=>"1391087135005306",
#    "preview"=>"link",
#    "content"=>"link",
#    "content length"=>"3072 bytes",
#    "content type"=>"image/png",
#    "timestamp"=>"2023-02-18 03:02:18 UTC",
#    "genesis height"=>"777099",
#    "genesis fee"=>"1814",
#    "genesis transaction"=>"c41021cb11dce003e6a20a3420cf5954a1d104a1fe314393b915a62f020dcd0a",
#    "location"=>"6a57dedb854c9bcac3fd2daab1172dd9a45f24c366dd8db33fe80557f11c6b39:22:0",
#    "output"=>"6a57dedb854c9bcac3fd2daab1172dd9a45f24c366dd8db33fe80557f11c6b39:22",
#    "offset"=>"0"}
```


Let's try querying for litecoin (ltc) ordinal inscriptions:

``` ruby
Ordinals.chain = :ltc


# get the inscription binary blob / data by id
#  e.g. GET https://ordinalslite.com/inscription/f2b6adf7b2d0f128fb14817ff37f5f36e9176b17571e20c49871875553f937b4i0...

id = 'f2b6adf7b2d0f128fb14817ff37f5f36e9176b17571e20c49871875553f937b4i0'
content = Ordinals.content( id )
pp content
#=> #<Ordinals::Api::Content:0x000001a1357fd6e0
#      @data="\x89PNG\r\n\x1A\n\x00\x00\x00...",
#      @length=816,
#      @type="image/png">


# get the inscription meta data by id
#  e.g GET https://ordinalslite.com/inscription/f2b6adf7b2d0f128fb14817ff37f5f36e9176b17571e20c49871875553f937b4i0...
data = Ordinals.inscription( id )
pp data
#=> {"title"=>"Inscription 642",
#    "id"=>"f2b6adf7b2d0f128fb14817ff37f5f36e9176b17571e20c49871875553f937b4i0",
#    "address"=>"LSDz4fM4mLFyAZVoDuKyMHYq3af6cSZGSY",
#    "output value"=>"9878",
#    "preview"=>"link",
#    "content"=>"link",
#    "content length"=>"816 bytes",
#    "content type"=>"image/png",
#    "timestamp"=>"2023-02-21 05:29:33 UTC",
#    "genesis height"=>"2426201",
#    "genesis fee"=>"361",
#    "genesis transaction"=>"f2b6adf7b2d0f128fb14817ff37f5f36e9176b17571e20c49871875553f937b4",
#    "location"=>"6802c71b49f18aab91d0b363762b24afb1bf00c4820a5f782de6dd1b1cfbd68a:0:0",
#    "output"=>"6802c71b49f18aab91d0b363762b24afb1bf00c4820a5f782de6dd1b1cfbd68a:0",
#    "offset"=>"0"}
```

That's it for now.



## Bonus: Ordinal Pixel Art Collections


See the [**Ordinals (Pixel Art) Sandbox (& Cache)**](https://github.com/pixelartexchange/ordinals.sandbox)
for collections incl. Ordinal Punks & Phunks (24×24), Bitcoin Punks (24×24), Ordinal Mini Doges (24×24), Ordinal Doggies (32×32),
Extra Ordinal Women (32×32), Ordinal Penguins (35×35),
Ordinal Birds (42×42), Bitcoin Bears (48×48) and much more.

Add your sandbox or "right-clicker" ordinal backup / archive / gallery here. Yes, you can.




## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.


