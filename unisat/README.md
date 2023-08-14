# UniSat.io Lite Helpers for Full-Text Search in Bitcoin Ordinal Inscriptions

unisat - unisat.io lite helpers for full-text search in bitcoin ordinal inscriptions 


* home  :: [github.com/ordbase/unisat](https://github.com/ordbase/unisat)
* bugs  :: [github.com/ordbase/unisat/issues](https://github.com/ordbase/unisat/issues)
* gem   :: [rubygems.org/gems/unisat](https://rubygems.org/gems/unisat)
* rdoc  :: [rubydoc.info/gems/unisat](http://rubydoc.info/gems/unisat)



##  Usage

Note: If you full-text search on UniSat.io by trying to fetch a "static" web page
with a script you will NOT the get the results BUT end-up with an "empty-shell"
because the inscriptions get fetched "delayed" via js/json.
To work-around use puppeteer to automate the google chrome browser with your scripts.


Let's full-text search in bitcoin ordinal inscriptions for "diyphunks".

```ruby
require 'unisat'

## Step 0:  Configure  the file path to your local google chrome browser 
##             required by puppeeter.
Unisat::Puppeteer.chrome_path = "your/path/to/chrome/here"

## Step 1:  
recs = Unisat::Puppeteer.search( 'diyphunks' )  
puts "  #{recs.size} inscribe(s)"
#=> 21 inscribe(s)

pp recs
#=>[{"id"=>"09e3c57879b0a30239b088468277d009f838111d254eb22f35a9b2a31b77a5d4i0",
#    "num"=>"13418851",
#    "date"=>"24.6.2023, 22:41:33",
#    "address"=>"bc1pmgu...quyqrah",
#    "text"=> "og deploy diyphunks↵name: D.I.Y. Phunks↵max: 100↵dim: ..."},
#   {"id"=>"54a448aad17203e322b3d421d91c12e1e4c1b1ca46ef2849e52774aeb7a3bd3bi0",
#    "num"=>"13418907",
#    "date"=>"24.6.2023, 22:45:20",
#    "address"=>"bc1pmgu...quyqrah",
#    "text"=>"og mint diyphunks 5 57 38"},
#    ...]
```

That's it.

Let's full-text search in bitcoin ordinal inscriptions for "orangepixels"
to try the "magic" pagination 
auto-adding pages with 32 results each.

Note: If you want to use your own page (starting) offset (default is 1) 
and limit (default is none), 
use the optional `òffset` and `limit` keyword parameters.

``` ruby
recs = Unisat::Puppeteer.search( 'orangepixels' )  
puts "  #{recs.size} inscribe(s)"
#=> 101 inscribe(s)

pp recs
#=> [{"id"=>"429915c362dacc2b1f7d4a5f7d929ee04e52298c35a7fe9c4e5a29580691b364i0",
#     "num"=>"13070954",
#     "date"=>"21.6.2023, 20:15:12",
#     "address"=>"bc1qjhu...5lla3hj",
#     "text"=>"{↵    \"p\": \"orc-721\",↵    \"op\": \"deploy\",..."},
#    {"id"=>"157fdb5ebe82c12cefb6d48356d79bf5646e267980a2234294a8a330a4234be7i0",
#     "num"=>"13074990",
#     "date"=>"21.6.2023, 21:18:02",
#     "address"=>"bc1qjhu...5lla3hj",
#     "text"=>"{↵   \"p\":\"orc-721\",↵   \"op\":\"mint\",..."},
#    ...]
```


Note:  For now all results get "automagically" cached in `unisat/` indexd 
by query (key) and pages.   Example:

```
/unisat
  /diyphunks
     1.json
  /orangepixels
     1.json
     2.json
     3.json
     4.json
```


That's it.



## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Join us in the [Ordgen / ORC-721 discord (chat server)](https://discord.gg/dDhvHKjm2t). Yes you can.
Your questions and commetary welcome.


Or post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.
