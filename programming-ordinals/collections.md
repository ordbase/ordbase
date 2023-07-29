
[« Programming (Bitcoin) Ordinals - Step-by-Step Book / Guide](./)


# Collections, Collections, Collections - Inside Ordinal Punks, Bitcoin Shrooms, D.I.Y. Punks & More


Let's explore ordinal inscriptions 
from a different angle.  Let's try classic (or yes, generative) collections. 


## Collection №1 -  100 Ordinal Punks


New to Ordinal Punks? For some background see [**Awesome 100 Ordinal Punks (Anno 2023) Notes - 24×24 Pixel Art on the (Bitcoin) Blockchain »**](https://github.com/ordinalpunks/awesome-ordinalpunks)


Let's start from zero / scratch with a new database (e.g. `ord.db`)
and let's import all inscriptions. How?

Yes, ordinal punks has an official meta datafile (in .json) 
inscribed at [№592145](https://ordinals.com/inscription/a64027dabba3c5acf83068028edf4e938464ff3c6b279f0415f5c6573cf03207i0). 


Let's use a "right-click and save as" 
local copy (e.g. [ordinalpunks.json](meta/ordinalpunks.json))
to import all inscriptions - metadata and content blobs -
and bonus all collection metadata (e.g. description, max (limit/supply), item names, etc.).

```ruby
require 'ordlite'


OrdDb.open( './ord.db' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
puts "  #{Collection.count} collection(s)"
#=>   0 inscribe(s)
#=>   0 blob(s)

OrdDb.import_collection( "./meta/ordinalpunks.json" )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
puts "  #{Collection.count} collection(s)"
#=>   100 inscribe(s)
#=>   100 blob(s)
#=>   1 collection(s)
```

Yes, that's it. 
Thanks to `import_collection` you only need to stand back ten meters
and wait for some minutes to get your database updated.


Now what?
Let's try some count stat(istics) queries.

``` ruby
col = Collection.find_by( name: 'Ordinal Punks' )

inscribes = col.inscribes
puts "  #{inscribes.size} inscribe(s)"
#=> 100 inscribe(s)
```

Let's query for content types (of inscriptions):

``` ruby
pp inscribes.counts_by_content_type
```

resulting in:

```
{"image/png" => 100}
```

Let's query for min and mix inscription numbers / no.:

``` ruby
max = inscribes.maximum( 'num' )
min = inscribes.minimum( 'num' )

puts "    range no. #{min} to no. #{max}"
#=>  range no. 407 to no. 642
```

Let's query for inscriptions counts grouped by date / day:

``` ruby
pp inscribes.counts_by_day
``` 

resulting in:

```
{"2023-02-01" => 73, 
 "2023-01-31" => 27}
```

or by hour:

``` ruby
pp inscribes.counts_by_hour
``` 

resulting in:

```
{"2023-02-01 10h" => 1,
 "2023-01-31 19h" => 1,
 "2023-01-31 20h" => 2,
 "2023-01-31 21h" => 12,
 "2023-01-31 22h" => 1,
 "2023-01-31 23h" => 11,
 "2023-02-01 01h" => 3,
 "2023-02-01 02h" => 7,
 "2023-02-01 03h" => 7,
 "2023-02-01 04h" => 5,
 "2023-02-01 05h" => 4,
 "2023-02-01 14h" => 1,
 "2023-02-01 15h" => 5,
 "2023-02-01 16h" => 12,
 "2023-02-01 17h" => 13,
 "2023-02-01 18h" => 10,
 "2023-02-01 19h" => 5}
```

or by block (height) with or without timestamp:

``` ruby
pp inscribes.counts_by_block
pp inscribes.counts_by_block_with_timestamp
``` 

resulting in:

```
{774567=>1,
 774489=>1,
 774494=>1,
 774496=>1,
 774497=>6,
 774500=>3,
 774502=>3,
 774503=>1,
 774506=>5,
 774507=>1,
 774509=>5,
 774515=>1,
 774518=>1,
 774519=>1,
 774521=>1,
 774523=>1,
 774524=>5,
 774527=>2,
 774531=>5,
 774534=>1,
 774536=>2,
 774537=>2,
 774541=>4,
 774587=>1,
 774595=>5,
 774598=>5,
 774599=>4,
 774600=>3,
 774604=>2,
 774605=>3,
 774606=>4,
 774607=>4,
 774609=>3,
 774611=>3,
 774612=>3,
 774614=>1,
 774615=>2,
 774617=>2,
 774619=>1}

{"774567 @ 2023-02-01 10:17:24"=>1,
 "774489 @ 2023-01-31 19:34:47"=>1,
 "774494 @ 2023-01-31 20:23:09"=>1,
 "774496 @ 2023-01-31 20:42:21"=>1,
 "774497 @ 2023-01-31 21:08:45"=>6,
 "774500 @ 2023-01-31 21:33:58"=>3,
 "774502 @ 2023-01-31 21:58:16"=>3,
 "774503 @ 2023-01-31 22:24:06"=>1,
 "774506 @ 2023-01-31 23:04:21"=>5,
 "774507 @ 2023-01-31 23:24:36"=>1,
 "774509 @ 2023-01-31 23:40:19"=>5,
 "774515 @ 2023-02-01 01:15:25"=>1,
 "774518 @ 2023-02-01 01:36:30"=>1,
 "774519 @ 2023-02-01 01:42:29"=>1,
 "774521 @ 2023-02-01 02:01:50"=>1,
 "774523 @ 2023-02-01 02:17:58"=>1,
 "774524 @ 2023-02-01 02:49:29"=>5,
 "774527 @ 2023-02-01 03:30:11"=>2,
 "774531 @ 2023-02-01 03:55:44"=>5,
 "774534 @ 2023-02-01 04:09:38"=>1,
 "774536 @ 2023-02-01 04:29:27"=>2,
 "774537 @ 2023-02-01 04:46:11"=>2,
 "774541 @ 2023-02-01 05:16:44"=>4,
 "774587 @ 2023-02-01 14:41:52"=>1,
 "774595 @ 2023-02-01 15:54:57"=>5,
 "774598 @ 2023-02-01 16:24:14"=>5,
 "774599 @ 2023-02-01 16:32:16"=>4,
 "774600 @ 2023-02-01 16:42:58"=>3,
 "774604 @ 2023-02-01 17:12:08"=>2,
 "774605 @ 2023-02-01 17:35:29"=>3,
 "774606 @ 2023-02-01 17:40:32"=>4,
 "774607 @ 2023-02-01 17:59:12"=>4,
 "774609 @ 2023-02-01 18:13:13"=>3,
 "774611 @ 2023-02-01 18:20:16"=>3,
 "774612 @ 2023-02-01 18:33:59"=>3,
 "774614 @ 2023-02-01 18:46:46"=>1,
 "774615 @ 2023-02-01 19:13:31"=>2,
 "774617 @ 2023-02-01 19:20:24"=>2,
 "774619 @ 2023-02-01 19:27:27"=>1}
```

and so on.


## Collection №2 -  210 Bitcoin Shrooms

Let's try the Shrooms. Shrooms what!?

Ordinals trivia. The Shrooms with 208 out of 210 inscriptions¹ (plus one bonus collection metadata inscription, see [№105](https://ordinals.com/inscription/4e0ad05cbbe3cfdbedec9edb37683a8284bc60ec4ced62272703f182d67e5d70i0)) 
is the biggest sub 1k collection. 

Note 1: Shroom №186 @ [Inscription №1075](https://ordinals.com/inscription/4af5d25017a5c71d1333925ea29b79a18d36548597fc4f03e6a23f2d740547c7i0) and
Shroom №196 @ [Inscription №1074](https://ordinals.com/inscription/2807ac74213d2e9e4b86b7fc121edf7a94c66bc11a8142f851e5d7162d357333i0).


Let's use a "hand-crafted" tabular dataset (in .csv)
e.g. [shrooms_inscriptions.csv](meta/shrooms_inscriptions.csv)
to import all inscriptions - metadata and content blobs -
and bonus add a collection.

```ruby
OrdDb.import_collection_csv( "./meta/shrooms_inscriptions.csv",
                              name: 'Bitcoin Shrooms' )
```

Yes, that's it. 
Thanks to `import_collection_csv` you only need to stand back ten meters
and wait for some minutes to get your database updated.

Now what?
Let's try again some count stat(istics) queries.


``` ruby
col = Collection.find_by( name: 'Bitcoin Shrooms' )

inscribes = col.inscribes
puts "  #{inscribes.size} inscribe(s)"
#=> 210 inscribe(s)
```

Let's query for content types (of inscriptions):

``` ruby
pp inscribes.counts_by_content_type
```

resulting in:

```
{"image/png" => 210}
```

Let's query for min and mix inscription numbers / no.:

``` ruby
max = inscribes.maximum( 'num' )
min = inscribes.minimum( 'num' )

puts "    range no. #{min} to no. #{max}"
#=>  range no. 675 to no. 1075
```

Let's query for inscriptions counts grouped by date / day:

``` ruby
pp inscribes.counts_by_day
``` 

resulting in:

```
{"2023-02-02" => 210}
```

or by hour:

``` ruby
pp inscribes.counts_by_hour
``` 

resulting in:

```
{"2023-02-02 00h"=>43, 
 "2023-02-02 01h"=>124, 
 "2023-02-02 02h"=>41, 
 "2023-02-02 19h"=>2}
```

or by block (height) with or without timestamp:

``` ruby
pp inscribes.counts_by_block
pp inscribes.counts_by_block_with_timestamp
``` 

resulting in:

```
{774656=>43,
 774663=>5,
 774661=>2,
 774662=>1,
 774664=>15,
 774657=>57,
 774658=>38,
 774666=>5,
 774670=>10,
 774671=>15,
 774762=>1,
 774659=>6,
 774761=>1,
 774672=>11}

{"774656 @ 2023-02-02 00:44:05"=>43,
 "774663 @ 2023-02-02 01:30:40"=>5,
 "774661 @ 2023-02-02 01:17:54"=>2,
 "774662 @ 2023-02-02 01:27:47"=>1,
 "774664 @ 2023-02-02 01:44:23"=>15,
 "774657 @ 2023-02-02 01:00:47"=>57,
 "774658 @ 2023-02-02 01:03:02"=>38,
 "774666 @ 2023-02-02 02:06:44"=>5,
 "774670 @ 2023-02-02 02:31:41"=>10,
 "774671 @ 2023-02-02 02:34:37"=>15,
 "774762 @ 2023-02-02 19:06:48"=>1,
 "774659 @ 2023-02-02 01:08:00"=>6,
 "774761 @ 2023-02-02 19:01:04"=>1,
 "774672 @ 2023-02-02 02:49:42"=>11}
```

and so on.



## Collection №3 -  721 D.I.Y. Punks

Let's try D.I.Y. Punks - (On-Chain) Generatives! 

New to Geratives! Your Numbers! Youur Image!? 
For some background see [**Ordgen / ORC-721  »**](https://github.com/ordbase/generative-orc-721)


Let's use an auto-generated (market) dataset (in .json)
e.g. [diypunks_inscriptions.json](meta/diypunks_inscriptions.json)
to import all inscriptions - metadata and content blobs -
and bonus add a collection.

```ruby
OrdDb.import_collection_inscriptions( "./meta/diypunks_inscriptions.json",
                                        name: 'D.I.Y. Punks' )
```

Yes, that's it. 
Thanks to `import_collection_inscriptions` you only need to stand back ten meters
and wait for some minutes to get your database updated.

Now what?
Let's try again some count stat(istics) queries.


``` ruby
col = Collection.find_by( name: 'D.I.Y. Punks' )

inscribes = col.inscribes
puts "  #{inscribes.size} inscribe(s)"
#=> 721 inscribe(s)
```

Let's query for content types (of inscriptions):

``` ruby
pp inscribes.counts_by_content_type
```

resulting in:

```
{"text/plain;charset=utf-8"=>717, 
 "application/json"=>4}
```

Yes, that's text (in .json). Generatives store the dna (numbers) 
NOT the image! 


Let's query for min and mix inscription numbers / no.:

``` ruby
max = inscribes.maximum( 'num' )
min = inscribes.minimum( 'num' )

puts "    range no. #{min} to no. #{max}"
#=>   range no. 9959200 to no. 10286852
```

Let's query for inscriptions counts grouped by date / day:

``` ruby
pp inscribes.counts_by_day
``` 

resulting in:

```
{"2023-05-29" => 240, 
 "2023-05-30" => 298, 
 "2023-05-31" => 183}
```

or by hour:

``` ruby
pp inscribes.counts_by_hour
``` 

resulting in:

```
{"2023-05-29 17h"=>1,
 "2023-05-29 18h"=>1,
 "2023-05-29 19h"=>37,
 "2023-05-29 20h"=>15,
 "2023-05-29 21h"=>123,
 "2023-05-29 22h"=>8,
 "2023-05-29 23h"=>55,
 "2023-05-30 00h"=>28,
 "2023-05-30 01h"=>32,
 "2023-05-30 02h"=>23,
 "2023-05-30 03h"=>56,
 "2023-05-30 04h"=>27,
 "2023-05-30 05h"=>19,
 "2023-05-30 06h"=>58,
 "2023-05-30 07h"=>1,
 "2023-05-30 09h"=>15,
 "2023-05-30 10h"=>1,
 "2023-05-30 11h"=>2,
 "2023-05-30 12h"=>10,
 "2023-05-30 13h"=>11,
 "2023-05-30 21h"=>2,
 "2023-05-30 22h"=>1,
 "2023-05-30 23h"=>12,
 "2023-05-31 00h"=>11,
 "2023-05-31 01h"=>7,
 "2023-05-31 02h"=>12,
 "2023-05-31 04h"=>2,
 "2023-05-31 06h"=>6,
 "2023-05-31 07h"=>5,
 "2023-05-31 08h"=>68,
 "2023-05-31 09h"=>70,
 "2023-05-31 10h"=>2}
 ```

or by block (height) with or without timestamp:

``` ruby
pp inscribes.counts_by_block
pp inscribes.counts_by_block_with_timestamp
``` 

resulting in:

```
{"791978 @ 2023-05-29 17:53:55"=>1,
 "791982 @ 2023-05-29 18:09:37"=>1,
 "791989 @ 2023-05-29 19:06:49"=>21,
 "791991 @ 2023-05-29 19:13:17"=>5,
 "791996 @ 2023-05-29 19:37:16"=>9,
 "791997 @ 2023-05-29 19:41:28"=>2,
 "791998 @ 2023-05-29 20:01:16"=>11,
 "791999 @ 2023-05-29 20:00:56"=>3,
 "792001 @ 2023-05-29 20:03:58"=>1,
 "792002 @ 2023-05-29 21:01:56"=>33,
 "792003 @ 2023-05-29 21:06:34"=>32,
 "792004 @ 2023-05-29 21:19:45"=>14,
 "792005 @ 2023-05-29 21:23:31"=>7,
 "792006 @ 2023-05-29 21:24:12"=>2,
 "792007 @ 2023-05-29 21:29:17"=>24,
 "792008 @ 2023-05-29 21:31:38"=>11,
 "792009 @ 2023-05-29 22:04:04"=>4,
 "792011 @ 2023-05-29 22:57:50"=>2,
 "792012 @ 2023-05-29 22:59:48"=>2,
 "792013 @ 2023-05-29 23:03:25"=>1,
 "792014 @ 2023-05-29 23:13:47"=>10,
 "792015 @ 2023-05-29 23:15:37"=>10,
 "792017 @ 2023-05-29 23:37:03"=>4,
 "792018 @ 2023-05-29 23:47:59"=>6,
 "792019 @ 2023-05-29 23:49:13"=>14,
 "792020 @ 2023-05-29 23:51:31"=>5,
 "792021 @ 2023-05-29 23:59:41"=>5,
 "792022 @ 2023-05-30 00:06:07"=>22,
 "792023 @ 2023-05-30 00:09:00"=>5,
 "792024 @ 2023-05-30 00:14:05"=>1,
 "792028 @ 2023-05-30 01:13:42"=>5,
 "792029 @ 2023-05-30 01:33:08"=>4,
 "792030 @ 2023-05-30 01:41:52"=>3,
 "792031 @ 2023-05-30 01:44:56"=>15,
 "792033 @ 2023-05-30 01:50:40"=>3,
 "792034 @ 2023-05-30 01:53:05"=>2,
 "792035 @ 2023-05-30 02:08:43"=>13,
 "792036 @ 2023-05-30 02:31:09"=>7,
 "792037 @ 2023-05-30 02:33:57"=>3,
 "792038 @ 2023-05-30 03:03:05"=>2,
 "792040 @ 2023-05-30 03:14:15"=>50,
 "792042 @ 2023-05-30 03:28:43"=>1,
 "792043 @ 2023-05-30 03:32:32"=>2,
 "792044 @ 2023-05-30 03:33:39"=>1,
 "792045 @ 2023-05-30 04:09:54"=>1,
 "792046 @ 2023-05-30 04:19:58"=>3,
 "792047 @ 2023-05-30 04:24:48"=>4,
 "792048 @ 2023-05-30 04:49:37"=>18,
 "792050 @ 2023-05-30 04:55:19"=>1,
 "792053 @ 2023-05-30 05:08:02"=>9,
 "792054 @ 2023-05-30 05:10:15"=>1,
 "792055 @ 2023-05-30 05:12:53"=>1,
 "792056 @ 2023-05-30 05:22:31"=>1,
 "792057 @ 2023-05-30 05:35:45"=>3,
 "792058 @ 2023-05-30 05:46:13"=>1,
 "792060 @ 2023-05-30 05:56:20"=>3,
 "792061 @ 2023-05-30 06:03:33"=>24,
 "792062 @ 2023-05-30 06:09:24"=>17,
 "792063 @ 2023-05-30 06:16:14"=>3,
 "792068 @ 2023-05-30 06:36:49"=>7,
 "792070 @ 2023-05-30 06:46:38"=>7,
 "792071 @ 2023-05-30 07:05:32"=>1,
 "792082 @ 2023-05-30 09:04:26"=>1,
 "792083 @ 2023-05-30 09:20:18"=>5,
 "792084 @ 2023-05-30 09:25:47"=>9,
 "792092 @ 2023-05-30 10:59:55"=>1,
 "792098 @ 2023-05-30 11:34:49"=>2,
 "792100 @ 2023-05-30 12:08:43"=>10,
 "792109 @ 2023-05-30 13:35:52"=>11,
 "792152 @ 2023-05-30 21:43:51"=>1,
 "792155 @ 2023-05-30 21:54:01"=>1,
 "792165 @ 2023-05-30 22:49:29"=>1,
 "792169 @ 2023-05-30 23:22:51"=>5,
 "792173 @ 2023-05-30 23:34:51"=>6,
 "792174 @ 2023-05-30 23:46:09"=>1,
 "792176 @ 2023-05-31 00:23:18"=>1,
 "792177 @ 2023-05-31 00:24:57"=>3,
 "792178 @ 2023-05-31 00:38:04"=>2,
 "792179 @ 2023-05-31 00:45:07"=>5,
 "792181 @ 2023-05-31 01:14:07"=>4,
 "792183 @ 2023-05-31 01:48:20"=>2,
 "792184 @ 2023-05-31 01:51:47"=>1,
 "792185 @ 2023-05-31 02:10:47"=>2,
 "792186 @ 2023-05-31 02:29:40"=>1,
 "792187 @ 2023-05-31 02:41:41"=>9,
 "792198 @ 2023-05-31 04:36:55"=>1,
 "792199 @ 2023-05-31 04:37:14"=>1,
 "792202 @ 2023-05-31 06:04:30"=>6,
 "792211 @ 2023-05-31 07:08:35"=>5,
 "792218 @ 2023-05-31 08:13:40"=>1,
 "792222 @ 2023-05-31 08:27:58"=>17,
 "792223 @ 2023-05-31 08:30:11"=>12,
 "792224 @ 2023-05-31 08:45:34"=>35,
 "792225 @ 2023-05-31 08:46:10"=>2,
 "792226 @ 2023-05-31 08:47:34"=>1,
 "792227 @ 2023-05-31 09:03:15"=>41,
 "792228 @ 2023-05-31 09:07:04"=>24,
 "792229 @ 2023-05-31 09:18:12"=>5,
 "792233 @ 2023-05-31 10:06:40"=>2}
```

and so on.



## Questions? Comments?

Join us in the [Ordgen / ORC-721 discord (chat server)](https://discord.gg/dDhvHKjm2t). Yes you can.
Your questions and commetary welcome.


Or post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.

