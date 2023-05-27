####
# to run use:
#    $ sandbox/export.rb

require 'pixelart'




data = read_json( './ordibots.json' )
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