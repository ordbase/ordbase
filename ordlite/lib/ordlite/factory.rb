

class FactorySpritesheet    ## check - rename to catalog or atlas NOT spritesheet - why? why not?
  def self.read_inscribes( *inscribes, width:, 
                                       height: )
     ## map inscribes to images                                  
     images = inscribes.map {|inscribe| Pixelart::Image.blob( inscribe.content ) }
     ## puts "  #{images.size} image(s)"

     new( *images, width: width,
                   height: height)                                
  end

  def initialize( *images, width:, 
                           height: )
     @tile_width  = width
     @tile_height = height
     @tiles = []
     images.each {|img| add(img) }
  end

  def count() @tiles.size; end
  alias_method :size,       :count 
  alias_method :tile_count, :count   ## add tile_count - why? why not?
  def tile_width() @tile_width; end     ## use width  - why? why not?
  def tile_height() @tile_height; end   ## use height - why? why not?

  def tile( index )  @tiles[ index ]; end
  alias_method :[], :tile  

  def add_inscribe( inscribe ) _add( Pixelart::Image.blob( inscribe.content )); end
  def add( img )
    ## 1:1 tile; use as is
    if img.width == @tile_width && img.height == @tile_height
        @tiles << img 
    else  ## assume spritesheet??
      ## wrap into composite image
      composite = Pixelart::ImageComposite.new( img.image, width:  @tile_width,
                                                           height: @tile_height )
      cols  = img.width  / composite.tile_width
      rows  = img.height / composite.tile_height                                           
      puts "     #{composite.count} tile(s) in #{cols}x#{rows} grid"
      composite.each {|tile| @tiles << tile }
     end
  end
  alias_method :<<, :add
end  ## class Spritesheet


class FactoryGenerator
  ###################
  ## convenience setup helper(s)
  def self.read_inscribes( *inscribes, width:, 
                                       height: )                                         
        new( FactorySpritesheet.read_inscribes( *inscribes,
                                                   width: width,
                                                   height: height ))
  end
 
  def initialize( spritesheet )
    @spritesheet = spritesheet
  end
 
  def _parse( spec )
    ## for delimiter allow for now:  - why? why not?
    ##     (multiple) space ( )
    ##      command or semicolon
    spec.strip.split( %r{[ ,;/_-]+} ).map {|v| v.to_i(10) }
  end
 
  def parse( spec )
    ## convenience helper
    ##   parses g spec in various (delimited) formats
    g = _parse( spec )
    generate( *g )
  end
 
  def generate( *attributes )
    img = Pixelart::Image.new( width, height )
    attributes.each do |num|
        img.compose!( @spritesheet[ num ] )
    end
    img
  end
  alias_method :g, :generate
 
  def width()   @spritesheet.tile_width; end
  def height()  @spritesheet.tile_height; end
  def count()   @spritesheet.count; end
end  # class FactoryGenerator
 


module OrdDb
module Model
  
class Factory

## use id/slug to cache generators / spritesheets - why? why not?
def self.generators
    @generators ||= {}
end

def generator
    generators = self.class.generators
    if generators.has_key?( id )
        generators[ id ]
    else
        ## auto-add generator on first-time/hit/demand
        width, height = _parse_dimension( dim )
        inscribes = layers.to_a  ## get layer inscribe records
        generator = FactoryGenerator.read_inscribes( *inscribes,
                                                     width: width,
                                                     height: height )
        generators[ id ] = generator
        generator                         
    end
end

def generate( *attributes )  ## add g shortcut alias - why? why not?
    generator.generate( *attributes )
end


## e.g. convert dimension (width x height) "24x24" or "24 x 24" to  [24,24]
def _parse_dimension( str )
    str.split( /x/i ).map { |str| str.strip.to_i(10) }
end

end  # class Factory
end  # module Model
end  # module OrdDb