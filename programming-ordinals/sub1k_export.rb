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


## try to export inscribes

Inscribe.all.each do |rec|
    print "==> exporting no. #{rec.num} "
    print ">#{rec.content_type}< #{number_to_human_size(rec.bytes)} (#{rec.bytes} bytes) " 
    print "to >#{rec.export_path}<..."
    print "\n"
    rec.export   ## gets saved to ./tmp/<num>.<ext>
end


puts "bye"