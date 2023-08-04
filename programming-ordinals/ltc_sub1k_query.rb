#####
#  query ordsub1k.ltc.db  (sqlite database with first thousand ordinal litecoin inscriptions)

$LOAD_PATH.unshift( "../ordlite/lib" )
require 'ordlite'



OrdDb.open( './ordsub1k.ltc.db' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   1000 inscribe(s)
#=>   1000 blob(s)




######
## query for ten biggest (by bytes) inscriptions 

Inscribe.biggest.limit(10).each do |rec|
    print "#{number_to_human_size(rec.bytes)} (#{rec.bytes} bytes) - "
    print "Inscribe №#{rec.num} (#{rec.content_type}) - "
    print "#{rec.date} - #{rec.fee} fee in litoshis"
    print "\n"
end

puts
pp Inscribe.date_counts  ## count_by_date/day


######
##  query for all content types and group by count (descending)

puts
pp Inscribe.content_type_counts   ##  count_by_content_type




inscribes = Inscribe.text 
puts "  #{inscribes.size} text inscribe(s)"
#=> 16 text inscribe(s)


inscribes.each_with_index do |rec, i|
  puts "==> [#{i+1}/#{inscribes.size}] text inscribe №#{rec.num} (#{rec.content_type} - #{rec.bytes} bytes):"
  puts  rec.text
  puts
end


## get mimble wimble whitpaper (no. 0) pdf document
inscribe = Inscribe.find_by( num: 0 )
write_blob( "./tmp/mimblewimble.pdf", inscribe.content )


puts "bye"

