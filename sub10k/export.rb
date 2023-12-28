#####
#  query ordsub10k.db  
#     (sqlite database with first 10000 ordinal inscriptions)

$LOAD_PATH.unshift( "../ordlite/lib" )
require 'ordlite'




OrdDb.open( './ordsub10k.db' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   10000 inscribe(s)
#=>   10000 blob(s)


## try to export inscribes

Inscribe.all.each do |rec|
    print "==> exporting inscribe №#{rec.num} "
    print ">#{rec.content_type}< #{number_to_human_size(rec.bytes)} (#{rec.bytes} bytes) " 
    print "to >#{rec.export_path}<..."
    print "\n"
    rec.export   ## gets saved to ./tmp/<num>.<ext>
end


puts "bye"