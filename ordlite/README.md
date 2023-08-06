# Ordinal Inscription (SQL) Database 


ordlite - ordinals inscription (on bitcoin & co) database let's you query via sql and more


* home  :: [github.com/ordbase/ordbase](https://github.com/ordbase/ordbase)
* bugs  :: [github.com/ordbase/ordbase/issues](https://github.com/ordbase/ordbase/issues)
* gem   :: [rubygems.org/gems/ordlite](https://rubygems.org/gems/ordlite)
* rdoc  :: [rubydoc.info/gems/ordlite](http://rubydoc.info/gems/ordlite)



##  SQL Database Model

Inscribes • Blobs • Collections • Factories • Generatives


Table Inscribes

``` sql
CREATE TABLE "inscribes" (
    "id" varchar NOT NULL PRIMARY KEY, 
    "num" integer NOT NULL,
    "bytes" integer NOT NULL,
    "content_type" varchar NOT NULL,
    "date" datetime(6) NOT NULL,
    "sat" integer NOT NULL,
    "block" integer NOT NULL,
    "fee" integer NOT NULL,
    "tx" varchar NOT NULL,
    "offset" integer NOT NULL,
    "address" varchar NOT NULL,
    "output" varchar NOT NULL,
    "value" integer NOT NULL,
)
```

Table Blobs

``` sql
CREATE TABLE "blobs" (
    "id" varchar NOT NULL PRIMARY KEY, 
    "content" blob NOT NULL, 
)
```


##  Usage


### Step 0:  Setup Databae

``` ruby
require 'ordlite'

OrdDb.connect( adapter:  'sqlite3',
               database: './ord.db' )

OrdDb.create_all     # build table schema

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
puts "  #{Collection.count} collection(s)"
puts "  #{Factory.count} factories"
puts "  #{Generative.count} generative(s)"

#=>  0 inscribe(s)
#=>  0 blob(s)
#=>  0 collection(s)
#=>  0 generative(s)
```




### Example No 1 - Auto-Add (Via Ordinals.com) First Thousand Inscriptions (Sub 1k)

``` ruby
require 'ordlite'


OrdDb.open( './ord.db' )


1000.times do |num|   # auto-add inscription 0-999
   OrdDb.import( num )
end

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   1000 inscribe(s)
#=>   1000 blob(s)
```

Let's query for the ten biggest (by bytes) inscriptions 
(and pretty print the result):

```ruby
Inscribe.biggest.limit(10).each do |rec|
    print "#{number_to_human_size(rec.bytes)} (#{rec.bytes} bytes) - "
    print "Inscribe №#{rec.num} (#{rec.content_type}) - "
    print "#{rec.date} - #{rec.fee} fee in sats"
    print "\n"
end
```

resulting in:

```
3.73 MB (3915537 bytes) - Inscribe №652 (image/jpeg) - 2023-02-01 20:38:33 - 0 fee in sats
385 KB (394718 bytes) - Inscribe №978 (application/epub+zip) - 2023-02-02 06:46:04 - 109325 fee in sats
385 KB (394479 bytes) - Inscribe №546 (image/gif) - 2023-02-01 10:41:50 - 1489860 fee in sats
385 KB (394440 bytes) - Inscribe №833 (image/png) - 2023-02-02 01:13:51 - 99314 fee in sats
381 KB (389858 bytes) - Inscribe №388 (image/jpeg) - 2023-01-31 14:01:38 - 981620 fee in sats
379 KB (388417 bytes) - Inscribe №291 (image/gif) - 2023-01-30 17:58:54 - 586794 fee in sats
378 KB (386858 bytes) - Inscribe №857 (image/png) - 2023-02-02 01:17:54 - 97407 fee in sats
374 KB (383322 bytes) - Inscribe №538 (image/jpeg) - 2023-02-01 10:20:28 - 96519 fee in sats
367 KB (375414 bytes) - Inscribe №378 (image/gif) - 2023-01-31 09:47:55 - 945300 fee in sats
365 KB (373504 bytes) - Inscribe №288 (image/jpeg) - 2023-01-30 16:51:46 - 94050 fee in sats
```


Let's query for all inscriptions grouped by date (day) and dump the results:

```ruby
pp Inscribe.counts_by_date   ## or count_by_day
```

resulting in:

```
{"2022-12-14" => 1,
 "2022-12-17" => 1,
 "2022-12-19" => 1,
 "2023-01-05" => 1,
 "2023-01-10" => 1,
 "2023-01-12" => 1,
 "2023-01-13" => 2,
 "2023-01-15" => 1,
 "2023-01-16" => 1,
 "2023-01-19" => 5,
 "2023-01-20" => 3,
 "2023-01-21" => 5,
 "2023-01-22" => 34,
 "2023-01-23" => 23,
 "2023-01-24" => 4,
 "2023-01-25" => 9,
 "2023-01-26" => 12,
 "2023-01-27" => 19,
 "2023-01-28" => 16,
 "2023-01-29" => 128,
 "2023-01-30" => 82,
 "2023-01-31" => 98,
 "2023-02-01" => 220,
 "2023-02-02" => 332}
```

Let's query for all inscriptions grouped by month and dump the results:

```ruby
pp Inscribe.counts_by_month
```

resulting in:

```
{"2022-12" => 3, 
 "2023-01" => 445, 
 "2023-02" => 552}
```


Let's query for all content types and group by count (descending) and dump the results:


```ruby
pp Inscribe.counts_by_content_type
```

resulting in:

```
{"image/png" => 475,
 "image/jpeg" => 188,
 "image/webp" => 117,
 "text/plain;charset=utf-8" => 112,
 "image/svg+xml" => 62,
 "text/html;charset=utf-8" => 18,
 "image/gif" => 11,
 "audio/mpeg" => 6,
 "application/pdf" => 2,
 "image/avif" => 2,
 "video/webm" => 2,
 "application/epub+zip" => 1,
 "application/pgp-signature" => 1,
 "audio/midi" => 1,
 "audio/mod" => 1,
 "video/mp4" => 1}
```

and so on.




### Bonus:  Import (Cached) Inscription Meta Datafiles (& Content Blobs)

Let's import all cached 
inscriptions metadata datafiles (& content blobs)
from  [/ordinals.cache](https://github.com/ordbase/ordinals.cache)
into an (sql) database e.g. `ord.db`: 


``` ruby
require 'ordlite'

OrdDb.open( './ord.db' )

cache_dir = './ordinals.cache/inscription'
cache = Ordinals::Cache.new( cache_dir )
cache.import_all


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"

#=>  8505 inscribe(s)
#=>  7611 blob(s)
```


## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Join us in the [Ordgen / ORC-721 discord (chat server)](https://discord.gg/dDhvHKjm2t). Yes you can.
Your questions and commetary welcome.


Or post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.


