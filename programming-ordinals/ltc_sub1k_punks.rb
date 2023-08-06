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
    write_blob( "./tmp3/punk#{num}.png", inscribe.content )
end   

composite = ImageComposite.new( 10, 10, width: 24,
                                        height: 24 )

100.times do |i|
    composite << Image.read( "./i/punk#{i+1}.png" ) 
end

composite.save( "./i/punks.png" )
composite.zoom(4).save( "./i/punks@4x.png" )


##
# reshuffle matching bitcoin ordinal punks order
#
nums = [
    461, 459, 462, 458, 460, 464, 465, 463, 467, 466,
    476, 470, 475, 472, 478, 474, 469, 473, 477, 471, 
    468, 497, 496, 491, 488, 495, 490, 489, 487, 493,
    492, 494, 499, 498, 511, 507, 509, 506, 500, 508,                                   
    503, 504, 502, 501, 505, 510, 521, 522, 513, 512,                                          
    514, 515, 517, 518, 523, 520, 516, 519, 531, 533,                                             
    541, 536, 542, 539, 538, 532, 534, 537, 535, 540,                                             
    551, 556, 549, 554, 552, 555, 557, 550, 558, 559,                                         
    553, 548, 563, 566, 560, 562, 567, 571, 561, 570,             
    565, 569, 568, 564, 585, 580, 584, 582, 581, 583,
]

composite = ImageComposite.new( 10, 10, width: 24,
                                        height: 24 )

nums.each do |num|
    composite << Image.read( "./tmp3/punk#{num}.png" ) 
end

composite.save( "./tmp3/punks.png" )
composite.zoom(4).save( "./tmp3/punks@4x.png" )


puts "bye"