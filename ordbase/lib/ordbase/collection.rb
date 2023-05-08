
module Ordinals


class Collection
  attr_reader :slug,
              :width, :height,
              :sources


  def initialize( slug )
      @slug = slug

      ## read config if present
      config_path = "./#{@slug}/collection.yml"
      if File.exist?( config_path )
        config = read_yaml( config_path )
        pp config

        @width, @height = _parse_dimension( config['format'] )

        ## note: allow multiple source formats / dimensions
        ### e.g. convert   512x512 into  [ [512,512] ]
        ##
        source = config['source']
        source = [source]  unless source.is_a?( Array )
        @sources = source.map { |dimension| _parse_dimension( dimension ) }
      end
  end


def ordinals
   @ordinals ||= begin
                     recs = read_csv( "./#{@slug}/ordinals.csv" )
                     puts "  #{recs.size} record(s)"
                     recs
                 end
   @ordinals
end

def count() ordinals.size; end
alias_method :size, :count



def each_ordinal( &block )
  ordinals.each_with_index do |rec, i|   ## pass along hash rec for now - why? why not?
    block.call( rec, i )
  end
end

## add each_source_image or each_token_image or each_original_image or such - why? why not??



def each_image( &block )
  each_ordinal do |rec, i|
    id   = rec['id']
    num  = rec.has_key?('num') ? rec['num'].to_i(10) : i+1

    path = "./#{@slug}/#{@width}x#{@height}/#{num}.png"
    img = Image.read( path )

    block.call( img, num )
  end
end



def image_dir()  "./#{@slug}/token-i";  end



## e.g. convert dimension (width x height) "24x24" or "24 x 24" to  [24,24]
def _parse_dimension( str )
    str.split( /x/i ).map { |str| str.strip.to_i }
end


def pixelate
  each_ordinal do |rec, i|
    id   = rec['id']
    num  = rec.has_key?('num') ? rec['num'].to_i(10) : i+1

    outpath = "./#{@slug}/#{@width}x#{@height}/#{num}.png"
    next if File.exist?( outpath )

    path = "#{image_dir}/#{num}.png"
    puts "==> reading #{path}..."

    img = Image.read( path )
    puts "   #{img.width}x#{img.height}"

    ## check for source images
    if !@sources.include?( [img.width, img.height] )
      puts "  !! ERROR - unexpected image size; sorry - expected:"
      pp @sources
      exit 1
    end

    ## check for special case   source == format!!
    if [img.width,img.height] == [@width,@height]
      puts "   note: saving image as is - no downsampling"
      img.save( outpath )
    else
      steps_x = Image.calc_sample_steps( img.width, @width )
      steps_y = Image.calc_sample_steps( img.height, @height )

      img = img.sample( steps_x, steps_y )
      img.save( outpath )
    end
  end
end


def _count_to_grid( count )
  cols, rows = case count
               when    10 then   [5,   2]
               when    12 then   [4,   3]
               when    15 then   [5,   3]
               when    20 then   [5,   4]
               when    40 then   [10,  4]
               when    50 then   [10,  5]
               when    69 then   [10,  7]
               when    80 then   [10,  8]
               when    88 then   [10,  9]
               when 98,99 then   [10,  10]
               when   100 then   [10,  10]
               when   101 then   [11,  10]
               when   111 then   [11,  11]
               when   130 then   [10,  13]
               when   150 then   [10,  15]
               when   512 then   [20,  26]
               else
                   raise ArgumentError, "sorry - unknown composite count #{count} for now"
               end

  [cols,rows]
end

def make_composite( limit: nil )

  composite_count =  limit ? limit : count

  cols, rows = _count_to_grid( composite_count )

  composite = ImageComposite.new( cols, rows,
                                  width:  @width,
                                  height: @height )


  image_count = 0
  each_image do |img, num|
    puts "==> #{num}"
    composite << img

    image_count += 1
    break   if image_count >= composite_count
  end


   composite.save( "./#{@slug}/tmp/#{@slug}.png" )
end



def convert_images
  Image.convert( image_dir, from: 'jpg',
                            to:   'png' )

  Image.convert( image_dir, from: 'gif',
                            to:   'png' )

  Image.convert( image_dir, from: 'webp',
                            to:   'png' )
end



def fix_images   ## todo - find a different names for resaving png images?
  ##  "repair" png images
  ##    starting w/
  ##  - why?
  ##
  ## verify_signature! - ChunkyPNG::SignatureMismatch:
  ##  PNG signature not found,
  ##  found     "RIFF\\xFE\\b\\x00\\x00"
  ##  instead of "\\x89PNG\\r\\n\\x1A\\n"

  Image.convert( image_dir, from: 'png',
                            to:   'png' )
end


def download_meta   ## inscription metadata
  each_ordinal do |rec, i|
    id   = rec['id']
    num  = rec.has_key?('num') ? rec['num'].to_i(10) : i+1

    chain = Ordinals.config.chain
    path = "../ordinals.cache/#{chain}/#{id}.json"
    next if File.exist?( path )

    puts "==> downloading #{chain} inscription meta #{num} w/ id #{id}..."

    data = Ordinals.client.inscription( id )

    write_json( path, data )

    sleep( 1.0 )  ## sleep (delay_in_s)
  end
end

def dump_stats
  stats = InscriptionStats.new

  each_ordinal do |rec, i|
    id   = rec['id']

    chain = Ordinals.config.chain
    path = "../ordinals.cache/#{chain}/#{id}.json"

    data = read_json( path )
    stats.update( data )
  end

  pp stats.data
  puts
  puts stats.format
end


def download_images
  each_ordinal do |rec, i|
    id   = rec['id']
    num  = rec.has_key?('num') ? rec['num'].to_i(10) : i+1

    ##  note: add gif too (for check) - add more formats - why? why not?
    next if File.exist?( "#{image_dir}/#{num}.png" ) ||
            File.exist?( "#{image_dir}/#{num}.gif" ) ||
            File.exist?( "#{image_dir}/#{num}.jpg" )


    puts "==> downloading image ##{num}..."


    content = Ordinals.client.content( id )

      puts "  content_type: #{content.type}, content_length: #{content.length}"

      format = if content.type =~ %r{image/jpeg}i
                 'jpg'
               elsif content.type =~ %r{image/png}i
                'png'
               elsif content.type =~ %r{image/gif}i
                 'gif'
               elsif content.type =~ %r{image/webp}i
                 'webp'
               else
                 puts "!! ERROR:"
                 puts " unknown image format content type: >#{content.type}<"
                 exit 1
               end

      ## save image - using b(inary) mode
      write_blob( "#{image_dir}/#{num}.#{format}", content.blob )

      sleep( 1.0 )  ## sleep (delay_in_s)
  end
end





def fix_background
  ## read config
  ##  e.g.
  ##  {"background"=>"#A5CDE6",
  ##   "alpha"=>{"#CBE2F0"=>"#DDDDDD80"}}

  config_path = "./#{@slug}/background.yml"
  config = read_yaml( config_path )
  pp config

  use_transparent = false
  bg_colors = []
  bg_map    = {}

  ###
  ## note: allow multiple colors split by space/tab/comma etc.
  if ['solid'].include?( config['background'].downcase )
     use_transparent = true   ## assume solid color background
  else
    color_sep_rx = %r{[ \t\r\n,;/-]+}
    bg_colors = config['background'].split( color_sep_rx )
    pp bg_colors

    bg_map = bg_colors.reduce({}) {|h,color| h[color] = 0x0; h }
    pp bg_map
  end

  alpha_map = config['alpha']
  pp alpha_map



  cols, rows = _count_to_grid( count )

  composite = ImageComposite.new( cols, rows,
                                  width:  @width,
                                  height: @height )


  each_image do |img, num|
    puts "==> #{num}"
    img2 =   if use_transparent
                img.transparent
              else
                img.change_colors( bg_map )
              end
    img2 =  img2.change_colors( alpha_map )  if alpha_map


   ## todo: make more generic - how???
   ## umkeku hack - if blue (change back)
   #  img2[15,10] = 0xFFE4E2FF   if img2[15,10] == 0x0


    composite << img2
  end

   composite.save( "./#{@slug}/tmp/#{@slug}-ii.png" )

   ## change transparent to
   ##  orange (#ffa500)   - was yelllow (#ffff00)
   debug_bg_map = {
     # 0x0 => 0xffa500ff
     0x0 => 0x0000ffff
   }
   composite_debug = composite.change_colors( debug_bg_map )
   ## hack - change smoke to red
   debug_alpha_map =  {
     0xdddddd80 => 0xff0000ff
    }
   composite_debug = composite_debug.change_colors( debug_alpha_map )
   composite_debug.zoom(4).save( "./#{@slug}/tmp/#{@slug}-ii_debug@4x.png" )
end



end   # class Collection
end   # module Ordinals

