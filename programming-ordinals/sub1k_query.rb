#####
#  query ordsub1k.db  (sqlite database with first thousand ordinal inscriptions)

$LOAD_PATH.unshift( "../ordlite/lib" )
require 'ordlite'




OrdDb.open( './ordsub1k.db' )


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
    print "#{rec.date} - #{rec.fee} fee in sats"
    print "\n"
end

######
##  query for all content types and group by count (descending)

pp Inscribe.content_type_counts


puts "bye"