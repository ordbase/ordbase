#####
#  build  ordpunks.db  (sqlite database with 100 ordinal punk inscriptions)

$LOAD_PATH.unshift( "../ordinals/lib" )
$LOAD_PATH.unshift( "../ordlite/lib" )


require 'ordlite'



OrdDb.open( './ord.db' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
puts "  #{Collection.count} collection(s)"
puts "  #{Factory.count} factories"
puts

puts "  #{Inscribe.sub1k.count}  sub1k(s) - below 1000"
puts "  #{Inscribe.sub2k.count}  sub2k(s) - below 2000"
puts "  #{Inscribe.sub10k.count}  sub10k(s) - below 10_000"
puts "  #{Inscribe.sub20k.count}  sub20k(s) - below 20_000"
puts "  #{Inscribe.sub100k.count}  sub100k(s) - below 100_000"
puts "  #{Inscribe.sub1m.count}  sub1m(s) - below 1_000_000"
puts "  #{Inscribe.sub10m.count}  sub10m(s) - below 10_000_000"
puts "  #{Inscribe.sub20m.count}  sub10m(s) - below 20_000_000"
puts "  #{Inscribe.sub21m.count}  sub10m(s) - below 21_000_000"
puts

pp Inscribe.counts_by_content_type


def dump_collection( col )
  puts "==> #{col.name} (max. #{col.max ? col.max : '?'})"
  pp col

  inscribes = col.inscribes
  puts "  #{inscribes.size} inscribe(s)"

  max = inscribes.maximum( 'num' )
  min = inscribes.minimum( 'num' )

  puts "    range no. #{min} to no. #{max}"

  pp inscribes.counts_by_day
  pp inscribes.counts_by_month
  pp inscribes.counts_by_hour
 
  puts
  pp inscribes.counts_by_block

  puts
  pp inscribes.counts_by_block_with_timestamp

  puts
  pp inscribes.counts_by_hour

  # puts
  # pp inscribes.counts_by_address
end


Collection.all.each do |col|
    dump_collection( col )
end



## test sql
puts
puts Inscribe.select('address, COUNT(*)')
        .group( 'address' )
        .order( Arel.sql( 'COUNT(*) DESC')).to_sql
#=> SELECT address, COUNT(*) 
#   FROM "inscribes" 
#   GROUP BY "inscribes"."address" 
#   ORDER BY COUNT(*) DESC
#

puts "bye"