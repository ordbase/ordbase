####
# to run use:
#    $ ruby ordibots/generate.rb

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




ATTRIBUTES = read_attributes( './ordibots/ordibots.json' )


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
# note: for now cannot use key more than once (e.g. accessories, 'antenna',
##                                                  accessories: 'rainbow')

bot = generate( accessories: 'antenna',
                body: 'gold-oval',
                belly: 'chess',
                face: 'happy',
                )

bot.save( "./tmp/bot1.png" )
bot.zoom( 4 ).save( "./tmp/bot1@4x.png" )


bot = generate( background: 'bitcoin-orange',
                accessories: 'rainbow',
                body: 'standard-square',
                belly: 'empty',
                face: 'unimpressed'
                )

bot.save( "./tmp/bot2.png" )
bot.zoom( 4 ).save( "./tmp/bot2@4x.png" )



bot = generate( background: 'bitcoin-orange',
                accessories: 'rainbow',
                body: 'black-and-white-triangular',
                belly: 'square',
                face: 'happy'
                )

bot.save( "./tmp/bot3.png" )
bot.zoom( 4 ).save( "./tmp/bot3@4x.png" )

puts "bye"