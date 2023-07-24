

[« Programming (Bitcoin) Ordinals - Step-by-Step Book / Guide](./)



# Sub 1k - Inside The First Thousand Ordinal Inscriptions


Let's explore the first thousand ordinal inscriptions 
from [inscription  №0](6fb976ab49dcec017f1e201e84395983204ae1a7c2abf7ced0a85d692e442799i0)
to [inscription №999](48b74ff588de917d4fe4ae2310a7c5c5ec566aece16425d9bc401ed5fd00800ai0).


## Step 0:  Let's build the sub1k (SQL) database (ordlite / sqlite)

Let's setup and build from scratch / zero 
a single-file SQLite database (e.g. `òrdsub1k.db`) with
the first thousand ordinal inscriptions, 
that is, all metadata and (content) blobs, that is, images or text or audio or whatever.

To fetch the inscription metadata and content blobs
let's use the ordinals.com api wrapper / client, that is,
the [ordinals gem](https://github.com/ordbase/ordbase/tree/master/ordinals). 

To setup and build the SQL schema / tables
and insert (& update) all database records let's use
the ordinals sqlite database helpers & machinery, that is, the [ordlite gem](https://github.com/ordbase/ordbase/tree/master/ordlite).


Let's get started:

``` ruby
require 'ordinals'
require 'ordlite'


OrdDb.connect( adapter:  'sqlite3',
               database: './ordsub1k.db' )

## build schema if database new/empty
OrdDb.auto_migrate!

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   0 inscribe(s)
#=>   0 blob(s)


recs = read_csv( "./sub1k_inscriptions.csv" )
puts "  #{recs.size} inscribe id(s)"
#=>  1000 inscribe id(s) 


recs.each_with_index do |rec,i|
  id = rec['id']
  puts "==> #{i} @ #{id}..."

  ## check if inscription / inscribe is already in db?
  inscribe = Inscribe.find_by( id: id )
  if inscribe  ## already in db; dump record
    pp inscribe
  else         ## fetch via ordinals.com api and update db
     data = Ordinals.inscription( id )
     pp data
     Inscribe.create_from_api( data )
     sleep( 1 )   ## delay in seconds (before next request) 
  end

  ## check if (content) blob is already in db?
  blob = Blob.find_by( id: id )
  if blob    ## already in db; do nothing
  else       ## fetch via ordinals.com api and update db
     content = Ordinals.content( id )
     puts "  content-type: #{content.type}"
     puts "  content-length: #{content.length}"
    
     Blob.create( id: id, content: content.data )
     sleep( 1 )   ## delay in seconds (before next request) 
  end
end

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   1000 inscribe(s)
#=>   1000 blob(s)
```

Show time! Let's run the [`sub1k_build` script](sub1k_build.rb) and 
once
all 1000×2, that is, 2000 web (api) requests are processed 
you will have a copy of all sub1k ordinal inscriptions with all metadata and content blobs in a single-file SQLite database (about 40 MB).



## Let's query and analyze the sub1k inscriptions via SQL


Let's try a test run ...

``` ruby
require 'ordlite'


OrdDb.connect( adapter:  'sqlite3',
               database: './ordsub1k.db' )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   1000 inscribe(s)
#=>   1000 blob(s)
```


Let's query for the ten biggest (by bytes) inscriptions 
(and pretty print the result):

```ruby
Inscribe.order( 'bytes DESC' ).limit(10).each do |rec|
    print "#{number_to_human_size(rec.bytes)} (#{rec.bytes} bytes) - "
    print "Inscribe №#{rec.num} (#{rec.content_type}) - "
    print "#{rec.date} - #{rec.fee} fee in sats"
    print "\n"
end
```

or in vanilla SQL:

``` sql
     SELECT * 
      FROM inscribes 
  ORDER BY bytes DESC 
     LIMIT 10
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


Let's query for all content types and group by count (descending) and dump the results:


```ruby
pp Inscribe.group( 'content_type' ).order( Arel.sql( 'COUNT(*) DESC, content_type')).count
```

or in vanilla SQL:

```sql
   SELECT content_type, COUNT(*) 
     FROM inscribes 
 GROUP BY content_type
 ORDER BY COUNT(*) DESC, content_type
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


To be continued...




## Questions? Comments?

Join us in the [Ordgen / ORC-721 discord (chat server)](https://discord.gg/dDhvHKjm2t). Yes you can.
Your questions and commetary welcome.


Or post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.

