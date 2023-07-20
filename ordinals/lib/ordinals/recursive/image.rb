###
# helpers for recursive images (in .SVG)


class RecursiveImage
  def initialize( width, height )
     @width  = width
     @height = height 

     @recursions = []
  end

  def add( obj ) @recursions << obj; end
  alias_method :<<, :add

  def count() @recursions.size; end
  alias_method :size, :count   ## add size alias (confusing if starting with 0?) - why? why not?
 
  def width() @width; end
  def height() @height; end


  def to_svg( format=:standalone )
       buf = ''
     
  if [:standalone].include?( format.downcase.to_sym )
        buf +=<<TXT
<svg
  xmlns="http://www.w3.org/2000/svg"
  width="100%" height="100%"
  viewBox="0 0 #{width} #{height}">
TXT
  else  ## assume :inline/:embed or such
      ## todo/check:  add px e.g. 100 => 100px - why? why not?
       buf +=<<TXT
  <svg width="#{width}" height="#{height}">
TXT
    end

@recursions.each_with_index do |recursion,i|
    id, opts =  recursion.is_a?( Array )? recursion : [recursion, {}]

    pixelate = opts.has_key?(:pixelate) ? opts[:pixelate]
                                        : false
                               
    style = pixelate ? %Q[style="image-rendering: pixelated;"] : ''

    ## note: assumes spritesheet has tile of same size as image itself!!!!
    spritesheet = opts[:spritesheet]
    if spritesheet
        num = opts[:num] || opts[:tile]
        spritesheet_width = spritesheet[0] 
        tile_cols = spritesheet_width/width
        y,x = num.divmod( tile_cols ) 
      
buf += <<TXT 
    <svg viewBox="#{x*width} #{y*height} #{width} #{height}">
      <image href="/content/#{id}"
        #{style} />
    </svg>
TXT
    else
buf += <<TXT 
   <image href="/content/#{id}"
     #{style} />
TXT
    end
end

       buf += <<TXT
</svg>
TXT
      buf
  end # method to_svg
end # class RecursiveImage


