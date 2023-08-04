#####
#  query ordsub1k.ltc.db  (sqlite database with first thousand ordinal litecoin inscriptions)

$LOAD_PATH.unshift( "../ordlite/lib" )
require 'ordlite'

require 'pixelart'


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
  # write_blob( "./i/pepelangelo#{i+1}.jpg", inscribe.content )
end   

##
# export all (sub1k) (ordinal?) punk images

nums = [
    458, 459, 
    460, 461, 462, 463, 464, 465, 466, 467, 468, 469,
    470, 471, 472, 473, 474, 475, 476, 477, 478, 
    487, 488, 489, 
    490, 491, 492, 493, 494, 495, 496, 497, 498, 499,
    500, 501, 502, 503, 504, 505, 506, 507, 508, 509,
    510, 511, 512, 513, 514, 515, 516, 517, 518, 519,
    520, 521, 522, 523, 
    531, 532, 533, 534, 535, 536, 537, 538, 539,
    540, 541, 542, 548, 549, 
    550, 551, 552, 553, 554, 555, 556, 557, 558, 559,
    560, 561, 562, 563, 564, 565, 566, 567, 568, 569,
    570, 571, 
    580, 581, 582, 583, 584, 585,  
]

puts "  #{nums.size} punk(s)"
#=>  100 punk(s) 



nums.each_with_index do |num, i|
    inscribe = Inscribe.find_by( num: num )
    write_blob( "./i/punk#{i+1}.png", inscribe.content )
end   

composite = ImageComposite.new( 10, 10, width: 24,
                                        height: 24 )

nums.each_with_index do |num, i|
    composite << Image.read( "./i/punk#{i+1}.png" ) 
end

composite.save( "./i/punks.png" )
composite.zoom(4).save( "./i/punks@4x.png" )


puts "bye"