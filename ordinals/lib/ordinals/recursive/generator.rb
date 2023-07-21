

class RecursiveGenerator
    def initialize( width, height,
                    pixelate: true,
                    inscribes:  )
        @width  = width
        @height = height
        @recursions  = _prepare( inscribes )
        @pixelate   = pixelate
    end

    def [](index)  ## return recursion (config) as array
      @recursions[index]
    end

    def count() @recursions.size; end
    alias_method :size, :count   ## add size alias (confusing if starting with 0?) - why? why not?
   
    def width() @width; end
    def height() @height; end
     

    def _prepare( inscribes)
         ## prepare (flatten) recursion lookup table indexed 0,1,2,3, etc.
         index = []
         inscribes.each do |rec|
            if rec.is_a?( Array )  ## assume spritesheet 
               id = rec[0]
               opts = rec[1]
               cols = opts[:width] / width
               rows = opts[:height] / height
               count = cols*rows
               count.times do |num| 
                 index << [id, {  spritesheet: [opts[:width],opts[:height]],
                                  num: num }
                          ]
               end
            else ## assume "standalone / one-by-one" inscribe
               id = rec
               index << [id, {}]  
            end
         end
        index
    end


    SEP_RX = %r{[ \t/,;*+_-]+
               }x

    def _parse( str )
        str.strip.split( SEP_RX ).map { |str| str.to_i(10) }
    end

    def generate( *args )
       g = if args.size==1 && args.is_a?( String )
              _parse( args[0] )
           else  ## assume integer numbers
              args
           end
       img = RecursiveImage.new( @width, @height )
       g.each do |num|
          id, opts = @recursions[num]
          img << [id, opts.merge( {pixelate: @pixelate} )]
       end
       img 
    end    
end # class RecursiveGenerator

