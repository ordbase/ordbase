require 'ordinals'


Ordinals.chain = :ltc

ids = []

[99,199,299,399,499,599,699,799,899,999].each_with_index do |offset|
    ids += Ordinals.inscription_ids( offset: offset )
end
puts
puts "   #{ids.size} inscribe id(s)"

##
## save as .csv tabular dataset
buf = "id\n"
ids.each { |id| buf << "#{id}\n" }

write_text( "./tmp/sub1k_inscriptions.ltc.csv", buf )


puts "bye"
