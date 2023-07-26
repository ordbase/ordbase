$LOAD_PATH.unshift( "../ordlite/lib" )
require 'ordlite'




OrdDb.open( './ordsub1k.db' )


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   1000 inscribe(s)
#=>   1000 blob(s)



inscribes = Inscribe.text 
puts "  #{inscribes.size} text inscribe(s)"
#=> 112 text inscribe(s)

buf = ''

inscribes.each_with_index do |rec, i|
  puts "==> [#{i+1}/#{inscribes.size}] text inscribe №#{rec.num} (#{rec.content_type} - #{rec.bytes} bytes):"
  puts  rec.text
  puts

  ## note: add to buffer to write to disk 
  buf << "==> [#{i+1}/#{inscribes.size}] text inscribe №#{rec.num} (#{rec.content_type} - #{rec.bytes} bytes):\n"
  buf << rec.text
  buf << "\n\n"
end

## todo/fix:
##  check if write_text has problem with \r
##    \r doubles newlines - why? why not?

write_text( "./sub1k.txt", buf.gsub(/\r/, '') )

puts "bye"

