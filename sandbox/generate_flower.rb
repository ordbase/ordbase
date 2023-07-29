####
# to run use:
#    $ ruby generate.rb

require 'pixelart'




def read_attributes( path )
  data = read_json( path  )
  # pp data

  attributes = {}
  data['traits'].each do |category_name, h|
    puts "==> #{category_name} - #{h.size} record(s)..."

    h.each_with_index do |(name, h), i|
       puts "   #{i} - #{name} (#{h['name']}):"

       img = Image.parse_base64(  h['base64'] )

       cat = attributes[ category_name ] ||= {}
       cat[ name ] = img
    end
  end

  attributes
end




ATTRIBUTES = read_attributes( './blooming-flower.json' )


def generate( **kwargs )
   img = nil
   kwargs.each do |category, name|
      cat = ATTRIBUTES[category.to_s]
      attribute = cat[name.to_s]

      if attribute.nil?
        puts "!! WARN - attribute >#{name}< in >#{category}< not found; sorry"
        puts "  availbable options in #{category}:"
        pp  cat.keys
      end

      img = Image.new( attribute.width, attribute.height )  if img.nil?

      img.compose!( attribute )
   end
   img
end


##
##  80x80px
## - background
## - window
## - table
## - ornaments
## - flowerpot
## - rose

flower = generate( background: 'new-moon',
                window: 'simple-yellow',
                table: 'metal',
                flowerpot: 'ceramics-red',
                rose: 'bud-red',
                )

flower.save( "./tmp/flower1.png" )
flower.zoom( 4 ).save( "./tmp/flower1@4x.png" )


flower = generate( background: 'autumn',
                window: 'sliding-yellow',
                table: 'wood',
                flowerpot: 'ceramics-blue',
                rose: 'bud-white',
                )

flower.save( "./tmp/flower2.png" )
flower.zoom( 4 ).save( "./tmp/flower2@4x.png" )


flower = generate(  flowerpot: 'ceramics-red',
                    rose: 'bud-red',
                )

flower.save( "./tmp/flower1a.png" )
flower.zoom( 4 ).save( "./tmp/flower1a@4x.png" )


flower = generate( flowerpot: 'ceramics-blue',
                   rose: 'bud-white',
                  )

flower.save( "./tmp/flower2a.png" )
flower.zoom( 4 ).save( "./tmp/flower2a@4x.png" )



puts "bye"