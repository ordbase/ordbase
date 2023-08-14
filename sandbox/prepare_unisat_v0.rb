require 'cocos'



## todo/
##   filter out unconfirmed - why? why not?

paths = Dir.glob( "./tmp/unisat/biixel/*.html" )
puts "   #{paths.size} page(s)"


INSCRIBE_ID_RX = %r{
                  inscription/(?<id>[a-fi0-9]+)
                 }ix


ids = []
paths.each do |path|
  txt = read_text( path )
  txt.scan( INSCRIBE_ID_RX ) do |_|
    m = Regexp.last_match
  
    ids  << m[:id]
  end
  puts "   #{ids.size} inscribe(s)"
end
ids = ids.uniq
puts "   #{ids.size} inscribe(s) - total / uniq"


buf = "id\n"
ids.each { |id| buf << "#{id}\n" }
write_text( "./tmp/unisat/biixel.csv", buf )


puts "bye"
