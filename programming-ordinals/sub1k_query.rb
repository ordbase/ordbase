#####
#  query ordsub1k.db  (sqlite database with first thousand ordinal inscriptions)

$LOAD_PATH.unshift( "../ordlite/lib" )

require 'ordlite'


require 'active_support/number_helper'
include ActiveSupport::NumberHelper   ## e.g. number_to_human_size


OrdDb.connect( adapter:  'sqlite3',
               database: './ordsub1k.db' )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   1000 inscribe(s)
#=>   1000 blob(s)


######
## query for ten biggest (by bytes) inscriptions 

Inscribe.order( 'bytes DESC' ).limit(10).each do |rec|
    print "#{number_to_human_size(rec.bytes)} (#{rec.bytes} bytes) - "
    print "Inscribe №#{rec.num} (#{rec.content_type}) - "
    print "#{rec.date} - #{rec.fee} fee in sats"
    print "\n"
end

######
##  query for all content types and group by count (descending)

pp Inscribe.group( 'content_type' ).order( Arel.sql( 'COUNT(*) DESC, content_type')).count


puts "bye"