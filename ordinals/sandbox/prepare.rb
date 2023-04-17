require 'cocos'


chain = 'ltc'
txt = read_text( "./sandbox/page.#{chain}.txt" )


INSCRIPTION_RX = %r{
             /(inscription|shibescription)/
                (?<id>[0-9a-f]{64}i[0-9])
              >
            }x


ids = []



txt.scan( INSCRIPTION_RX ) do |_|
  m = Regexp.last_match

  ids << m[:id].strip

end


pp ids
puts "   #{ids.size} id(s)"


recs = []
ids.each_with_index do |id, i|
   recs << [(i+1).to_s, id]
end

headers = ['num', 'id']
buf = String.new('')
buf << headers.join( ', ' )
buf << "\n"
recs.each do |values|
  buf << values.join( ', ' )
  buf << "\n"
end


write_text( "./tmp/ordinals.#{chain}.csv", buf )

puts "bye"
