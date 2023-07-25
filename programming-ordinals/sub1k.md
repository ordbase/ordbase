

[« Programming (Bitcoin) Ordinals - Step-by-Step Book / Guide](./)



# Sub 1k - Inside The First Thousand Ordinal Inscriptions


Let's explore the first thousand ordinal inscriptions 
from [inscription  №0](https://ordinals.com/inscription/6fb976ab49dcec017f1e201e84395983204ae1a7c2abf7ced0a85d692e442799i0)
to [inscription №999](https://ordinals.com/inscription/48b74ff588de917d4fe4ae2310a7c5c5ec566aece16425d9bc401ed5fd00800ai0).


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


OrdDb.open( './ordsub1k.db' )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   0 inscribe(s)
#=>   0 blob(s)


## import listed inscripiton ids (fetch via ordinals.com api)
OrdDb.import_csv( "./sub1k_inscriptions.csv" )

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


OrdDb.open( './ordsub1k.db' )

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
pp Inscribe.content_type_counts
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




## Bonus - Let's export (save as ...) all inscriptions content blobs

Let's export (save as ...) all inscription content blobs
to local files with (mime) content types mapped
to file extensions (e.g. `image/png` to `.png`, `text/plain` to `.txt`, and so on)
and use the the inscription number as its filename 
(for easy sorting padded with eight zeros e.g. `0` to `00000000`, `1` to `00000001`) ...


``` ruby
require 'ordlite'

OrdDb.open( './ordsub1k.db' )

Inscribe.all.each do |rec|
  print "==> exporting no. #{rec.num} "
  print ">#{rec.content_type}< #{number_to_human_size(rec.bytes)} (#{rec.bytes} bytes) " 
  print "to >#{rec.export_path}<..."
  print "\n"
  rec.export   ## gets saved to ./tmp/<num>.<ext> by default
end
```

resulting in:

```
==> exporting no. 0 >image/png< 793 Bytes (793 bytes) to >./tmp/00000000.png<...
==> exporting no. 1 >image/png< 19.8 KB (20266 bytes) to >./tmp/00000001.png<...
==> exporting no. 2 >image/gif< 9.15 KB (9371 bytes) to >./tmp/00000002.gif<...
==> exporting no. 3 >image/png< 321 Bytes (321 bytes) to >./tmp/00000003.png<...
==> exporting no. 4 >image/png< 208 Bytes (208 bytes) to >./tmp/00000004.png<...
==> exporting no. 5 >text/plain;charset=utf-8< 185 Bytes (185 bytes) to >./tmp/00000005.txt<...
==> exporting no. 6 >image/png< 5.34 KB (5466 bytes) to >./tmp/00000006.png<...
==> exporting no. 7 >text/html;charset=utf-8< 625 Bytes (625 bytes) to >./tmp/00000007.html<...
==> exporting no. 8 >image/png< 27.8 KB (28431 bytes) to >./tmp/00000008.png<...
==> exporting no. 9 >image/webp< 33.3 KB (34140 bytes) to >./tmp/00000009.webp<...
...
==> exporting no. 998 >text/plain;charset=utf-8< 5 Bytes (5 bytes) to >./tmp/00000998.txt<...
==> exporting no. 999 >image/png< 39.4 KB (40384 bytes) to >./tmp/00000999.png<...
```


or if you look in your `./tmp` directory (depending on your operating system):

![](i/export-preview.png)






## Questions? Comments?

Join us in the [Ordgen / ORC-721 discord (chat server)](https://discord.gg/dDhvHKjm2t). Yes you can.
Your questions and commetary welcome.


Or post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.

