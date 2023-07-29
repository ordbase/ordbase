####
# to run use:
#    $ ruby export.rb

require 'pixelart'



##
##  blooming flower (gen-brc721)
# inscribe no. 17707699
##   see https://ordinals.com/inscription/1a1427e31c91566fe7fb47d7f5c1b2130bea31219a08e1de794d45512319ee61i0

data = read_json( './blooming-flower.json' )
pp data

slug = data['slug']


data['traits'].each do |category_name, h|

  puts "==> #{category_name} - #{h.size} record(s)..."

  h.each_with_index do |(name, h), i|

     puts "   #{i} - #{name} (#{h['name']}):"
     base64 = h['base64']

     path = "./tmp/#{slug}/#{category_name}/#{i}_#{name}"
     puts path

     img = Image.parse_base64( base64 )
     img.save( path+".png" )
     img.zoom(8).save( path+"@8x.png" )
  end
end


puts "bye"