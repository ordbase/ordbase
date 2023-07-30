require 'pixelart'


module Bitgen

class Catalog   ## change/rename to Spritesheet / Atlas / Deploy or such - why? why not?
  def self.read( path )
    data = read_json( path  )
    # pp data
  
    meta = {
       'slug' => data['slug'],
       'name' => data['name'],
       'dim'  => data['dim'] 
    }
   
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

  
    new( meta: meta,
         attributes: attributes )
  end

  def initialize( meta: {},
                  attributes: {} )
    @meta = meta
    @attributes = attributes
  end

  def name() @meta['name']; end
  def slug() @meta['slug']; end
  
  def dim()  @meta['dim']; end
  def width()  @meta['dim'] ? @meta['dim'][0] : nil; end
  def height()  @meta['dim'] ? @meta['dim'][1] : nil; end


  def categories()  @attributes.keys; end
  def [](name) @attributes[name]; end

  def cheat  ## print cheat sheet   
    buf = '' 
    @attributes.each_with_index do |(category_name, cat),i|
        buf << "#{i} - #{category_name} (#{cat.size})\n"
        cat.each_with_index do |(attribute_name, _),j|
            buf << "    #{j} - #{attribute_name}\n"
        end
    end
    buf
  end

  def export
    @attributes.each_with_index do |(category_name, cat),i|
      puts "==> #{category_name} - #{cat.size} record(s)..."
      cat.each_with_index do |(attribute_name, img), j|
        puts "   #{j} - #{attribute_name} (#{img.width}x#{img.height})"
    
        path = "./tmp/#{slug}/#{i}_#{category_name}/#{j}_#{attribute_name}"
        puts path

        img.save( path+".png" )
        img.zoom(8).save( path+"@8x.png" )
      end
    end
  end # method export
end  # class Catalog



class Generator
  def self.read( path )
    catalog = Catalog.read( path )
    new( catalog )
  end

  attr_reader :catalog

  def initialize( catalog )
    @catalog = catalog
  end

  def generate( **kwargs )
    img = nil
    kwargs.each do |category, name|
       cat = @catalog[ category.to_s] 
       attribute_img = cat[name.to_s]
 
       if attribute_img.nil?
         puts "!! WARN - attribute >#{name}< in >#{category}< not found; sorry"
         puts "  availbable options in #{category}:"
         pp cat.keys
       end
 
       img = Image.new( attribute_img.width, attribute_img.height )  if img.nil?

       img.compose!( attribute_img )
    end
    img
 end  # method generate

  ################
  ## more convenience helpers
  def cheat() @catalog.cheat; end

end  # class Generator

end # module Bitgen





