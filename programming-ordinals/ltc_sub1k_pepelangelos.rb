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


##
# export all (sub1k) pepelangelo images

nums = [
  207, 208, 209,
  210, 211, 212, 213, 214, 215, 216, 217, 218, 219,
  220, 221, 222, 223, 224, 225, 226, 227, 228,
  236, 237, 238, 239,
  240, 241, 242, 243, 244, 245, 246, 247, 248, 249,
  250, 251, 252, 253, 254, 255, 256, 257
]

puts "  #{nums.size} pepelangelo(s)"
#=> 44 pepelangelo(s) 

nums.each_with_index do |num, i|
  inscribe = Inscribe.find_by( num: num )
  write_blob( "./tmp4/pepelangelo#{i+1}.jpg", inscribe.content )
end   


puts "bye"