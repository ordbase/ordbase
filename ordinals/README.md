# ordinals

ordinals gem - ordinals (inscription) api wrapper & helpers for Bitcoin, Litcoin, Dogecoin & co.


* home  :: [github.com/ordbase/ordbase](https://github.com/ordbase/ordbase)
* bugs  :: [github.com/ordbase/ordbase/issues](https://github.com/ordbase/ordbase/issues)
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
#    "content-length"=>"3072 bytes",
#    "content-type"=>"image/png",
#    "timestamp"=>"2023-02-18 03:02:18 UTC",
#    "genesis-height"=>"777099",
#    "genesis-fee"=>"1814",
#    "genesis-transaction"=>"c41021cb11dce003e6a20a3420cf5954a1d104a1fe314393b915a62f020dcd0a",
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
#    "output-value"=>"9878",
#    "content-length"=>"816 bytes",
#    "content-type"=>"image/png",
#    "timestamp"=>"2023-02-21 05:29:33 UTC",
#    "genesis-height"=>"2426201",
#    "genesis-fee"=>"361",
#    "genesis-transaction"=>"f2b6adf7b2d0f128fb14817ff37f5f36e9176b17571e20c49871875553f937b4",
#    "location"=>"6802c71b49f18aab91d0b363762b24afb1bf00c4820a5f782de6dd1b1cfbd68a:0:0",
#    "output"=>"6802c71b49f18aab91d0b363762b24afb1bf00c4820a5f782de6dd1b1cfbd68a:0",
#    "offset"=>"0"}
```

That's it.


### Bonus - Recursive Images  - Generate .SVG Inscriptions

Ordinal helper classes for generating recursive images include:
- `RecursiveImage`
- `RecursiveImageComposite`
- `RecursiveGenerator`


#### Sample No 1 - (Recursive) D.I.Y. Martians - Aliens Vol. 2


```ruby
require 'ordinals'

## 50 .PNG "one-by-one" images - each 24×24px
inscribes = [
    '0829dc471f8bb92a971dfdfb00a71c016b833c8f1d5f39dcb15aa5535d08fc15i0',
    '9482552ec759b76577b28923741eb4bfc7770cead528755bf8fa44196ae9318ci0',
    '5b8eb4a05f13fffc49f824f457fb080b67e4fdc312fbbf2f804cef59e6d5fad2i0',
    '85e0efd6cc2801ab7e1fe28e23110441348ca40481599f880c571ff4f69f066fi0',
    '7953ccb6614a41e7b4c4ed2a2b112b52feda387de92de2c1a314f03d5da41955i0',
    '2f1219924cfa01f9816581e8a39e201f15e19ab447e852ff9b43b13fa7b0c75di0',
    'e60f597ec41c50e823ea382c101dfc2f30c13a927222be3b73cedd88bd1b9237i0',
    '5ce9f89ad571e5380baa5b5ee387f08ea313421e7e54662b3899d411c39321ddi0',
    '3459b14a4fcb7bce1df0465abc711b556caba6f7b42d4f925f1ddf830be47125i0',
    '1355524a2aab576e069bac91227b0e52d227d65d84c5535377d3a0ea4e44d470i0',
    'a6b4b81f69e8c217db24f0a71954195d67ced49a819b67a4daf9f3ca7fa1b971i0',
    '83827ec13cb55a35fe3adca5acf67caf943c3bd6810f8fa893b067e8015c8f19i0',
    '5b1e638c050318bec23f17b8b7758ccf13945e422516da6c722c67ae5ed4e26di0',
    '5dcf96b13e5762d5a288d8bee36deb933fe192a55475199fe9a39ae29dd16853i0',
    '5760ce05009e94a750a7245cac994fa9ffd388eadc757929ac17737811455429i0',
    '0bd902941392ea138adb7db30cecdf5bc09a92c80e3e1bc3ecdf3c2d0abf6631i0',
    '7c2fd41b52624ddb1ba11fe1c6d95475f2e42c4b53d6aaf6a16a09064acebe38i0',
    '0f473c9dcd14e3f43a6599b038d810eac16bc6394edcfcf6b32f8df992ab6791i0',
    'd32c50c23693a028e2381d6f756746a9ff684f2028edf694ab7b1b6cde78e2cdi0',
    'd61fc2a89ecc6ae65cf91cdfac9edc37fd60c38621dac211f3a70891ef79b69ai0',
    '680e2ee8cad86aa174b4f3373d733370c9a6fc4230b9708d520a0f6bcb8e72a6i0',
    '56d3f4f661b2b4a9fc17755171d7cf4da74e570614b6b45de0cc87a809c3eb3ci0',
    'fe4321178bd841e52fdeb72ce4456c5b7596c0d611b19da15ba75ec63b5314cai0',
    'eddc1242f0fd290e130332e046897ad41dce1e7e112df48ecf2168e43172d383i0',
    'a2110fb4afaa29bc70bcfac445f750ecb5e81777e8d080be2d2b07eb030ba0ffi0',
    'c1277df4b986067b2a3f006d717b7f6d042896840c8b592e5a8b9ff22444b08fi0',
    '722dfdc90a67ff7eb892d13393a8a5b360b8a109f3d809600919684a600ff60ei0',
    'a0d11e78978a9dd5f1d891b71f06bd2d411c08372eba1f23e8b0722474388130i0',
    '2c2d812754b9374ffb699173da7f6d476af138a99906b66b8453cc4343305167i0',
    '964c52312f1db9025695b181d5f631292d29bec63ff9587138a589cb5ff8c26di0',
    '545fd4d45d2f6d732d48accc082f72b67a00d19f88517320f814bf1fe827c816i0',
    '72fe7ebda802852f499dca865ec22ac43eacfcf4796d761969ae8358791e943ci0',
    '4db2e931b5cd489d8007d111d20ab97d84161b84c8f7ff3038e1afe79567b9afi0',
    '4869c9bb7cf23e68ad94da5b1e9de1feff1ebdcaf9a08fccca5f1887dd40e239i0',
    '06136a5b4fb585069ef6265a0fde3baf67ee914b9f784d2c951f3a8187800d54i0',
    '8043604c7c96a5a43a97e251b246102ca40c0203431ff21bd26f23330dfa554ci0',
    '92e7f48454546718f98103d7464d954033adbee21855f06584be06faa3e291ddi0',
    'a01012b213ed425c5d4038bc36016f19f4f342ca052ff9bf6971672164e1a402i0',
    '87d89d290ebde5d5b7aa75b4c8d0359515e25ea1542bc0646dc3f5b0b2fc55fdi0',
    'aab67a4269ca0bda649fe341bd88c862aba2e9bf6e0826b9dfa5c4ba8fe62c2di0',
    '189b02ffc8aac68a45102e9837a1ca92e422bf5544d9011a863626cf6b0abeeai0',
    '43e93e43f2dac75b141baaa5b08df440e0b6ec5755577a9554a7af6540447bb7i0',
    '39d774f7d7514371c88bc4f939346f6b23000c9892ac4ae8ea36c76694e3b842i0',
    'b268b2acccd6b04680c2aa3130863ffbaa450f6870f100af678428cd07212ef6i0',
    'ac810c9098681e100964166b7510d1ac371c147861b0ae2a862da3a8b8256037i0',
    '4b9f880df07b072a4147a62acdd0881d024d14da6d84174db9b5ac555b71b346i0',
    '014ad6ed6297bc4ed624b2856e036c6bde115d51eb7200b14e3b3413ad53db08i0',
    'e139b5b0649186772cbf044bb8d3c5e43b77e3cf0472008ce2aaf52966c921eci0',
    '6eb271ad3fdd15cc2ec34dda462e71aaa8a7ef7e306cfd189931ef37216a9c60i0',
    '47cb34f1d73371df0b27ca0a259927fa80e2b2d9ee0e1d487fca5c9029b67b49i0',  
]

diymartians = RecursiveGenerator.new( 24, 24, 
                                      inscribes: inscribes )


[
  '41 0 39 37 23 8',
  '44 1 10 23',
  '46 3 21 15',
  '47 2 39 26 37',
  '47 4 39 20 33 35 36',
  '41 0 32 35 13 36',
  '44 6 16 28 37 34 35',
  '41 0 10 33 34 35 36 8 7',
  '48 2 33 8 34 35 37 14',
  '49 3 21 14 35 34 35 37 18 14',
].each_with_index do |spec,i|
    img = diymartians.generate( spec )
    write_text( "./diymartian#{i}.svg", img.to_svg )
end
```

resulting in (hosted on ordtest - Ordinals (Recursive) Testing Sandbox):

- <https://ordtest.github.io/diymartian0.svg>    - d.i.y. martian no. 0
- <https://ordtest.github.io/diymartian1.svg>    - d.i.y. martian no. 1
- <https://ordtest.github.io/diymartian2.svg> 
- <https://ordtest.github.io/diymartian3.svg> 
- <https://ordtest.github.io/diymartian4.svg> 
- <https://ordtest.github.io/diymartian5.svg> 
- <https://ordtest.github.io/diymartian6.svg> 
- <https://ordtest.github.io/diymartian7.svg> 
- <https://ordtest.github.io/diymartian8.svg> 
- <https://ordtest.github.io/diymartian9.svg> 


Tip:  If you select "show source" in the "right-click" menu in your web browser you will see the "magic" recursive .SVG source text.



#### Sample No 2 - (Recursive) D.I.Y. Maxi Biz (Punks)

```ruby
require 'ordinals'

## all-in-one spritesheet .PNG image 240×216px (10×9 grid - 24×24px each)  
inscribes = [
    ['ad56d4f242677ac334844002f1c27b9b636ba71f68590cdc0cc5a2cbce080990i0', { width: 240, height: 216 }],
]

diymaxibiz = RecursiveGenerator.new( 24, 24, 
                                      inscribes: inscribes )


[
   '87 6 25 41 74 59',
   '87 6 25 41 74',
   '87 6 25 41',
   '84 13 68 33 73',
   '87 12 21 38 46 73',
   '84 14 66 35 73',
   '84 11 35 69 72',
   '84 1 44 73 40',
   '87 3 40 43 73',
   '87 83 77',
].each_with_index do |spec,i|
    img = diymaxibiz.generate( spec )
    write_text( "./diymaxibiz#{i}.svg", img.to_svg )
end
```

resulting in (hosted on ordtest - Ordinals (Recursive) Testing Sandbox):

- <https://ordtest.github.io/diymaxibiz0.svg>
- <https://ordtest.github.io/diymaxibiz1.svg>
- <https://ordtest.github.io/diymaxibiz2.svg>
- <https://ordtest.github.io/diymaxibiz3.svg>
- <https://ordtest.github.io/diymaxibiz4.svg>
- <https://ordtest.github.io/diymaxibiz5.svg>
- <https://ordtest.github.io/diymaxibiz6.svg>
- <https://ordtest.github.io/diymaxibiz7.svg>
- <https://ordtest.github.io/diymaxibiz8.svg>
- <https://ordtest.github.io/diymaxibiz9.svg>



#### Sample No 3 - All-In-One 100 Ordinal Punks Composite

_100 recursions each 96×96px in 10×10 grid_

```ruby
require 'ordinals'


composite = RecursiveImageComposite.new( 10, 10, width: 96,
                                                 height: 96 )

data = read_json( "./ordinalpunks.json" )
puts "  #{data['items'].size} inscribe(s)"

data['items'].each do |rec|
   id      = rec['inscription_id']
   comment = rec['name'] 

   composite << [id, {pixelate: true,
                      comment:  comment}]
end

write_text( "./ordinalpunks.svg", composite.to_svg )
```

resulting in (hosted on ordtest - Ordinals (Recursive) Testing Sandbox):

-  <https://ordtest.github.io/ordinalpunks.svg>



#### Sample No 4 - Nine D.I.Y. Punks Composite

_9 recursions each 24×24px in 3×3 grid_

```ruby
require 'ordinals'

## all-in-one spritesheet .PNG image 240×144px (10×6 grid - 24×24px each)
inscribes = [
    ['cf5df319bbe23fa3d012e5ee0810700c8e82aebff41164246f0d87d7b60a9903i0', { width: 240, height: 144 }],
]

diypunks = RecursiveGenerator.new( 24, 24, 
                                    inscribes: inscribes )


composite = RecursiveImageComposite.new( 3, 3, width: 24,
                                               height: 24)

[
  '59 0',  
  '59 1',  
  '59 2',  
  '59 3',  
  '59 4',  
  '59 5',  
  '59 6',  
  '59 7',  
  '59 8',  
].each do |spec|
    img = diypunks.generate( spec )
    composite << img
end

write_text( "./diypunks.svg", composite.to_svg )
```

resulting in (hosted on ordtest - Ordinals (Recursive) Testing Sandbox):

-  <https://ordtest.github.io/diypunks.svg> 




## Appendix: Ordinal Pixel Art Collections


See the [**Ordinals (Pixel Art) Sandbox (& Cache)**](https://github.com/ordbase/ordinals.sandbox)
for collections incl. Ordinal Punks & Phunks (24×24), Bitcoin Punks (24×24), Ordinal Mini Doges (24×24), Ordinal Doggies (32×32),
Extra Ordinal Women (32×32), Ordinal Penguins (35×35),
Ordinal Birds (42×42), Bitcoin Bears (48×48) and much more.

Add your sandbox or "right-clicker" ordinal backup / archive / gallery here. Yes, you can.




## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.





## Questions? Comments?

Join us in the [Ordgen / ORC-721 discord (chat server)](https://discord.gg/dDhvHKjm2t). Yes you can.
Your questions and commetary welcome.


Or post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.


