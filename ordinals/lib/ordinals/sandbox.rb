

module Ordinals
class Sandbox
   def initialize( dir='./content' )
      @dir   = dir
      @force      = false
      @delay_in_s = 0.5  ## wait 0.5s before next (possible) request
      @requests = 0
   end   


   def exist?( id )   ### add alias for different name(s) - why? why not?
     path = "#{@dir}/#{id}"
     File.exist?( path )
   end

   def read( id )
     path = "#{@dir}/#{id}"
     read_blob( path )
   end

   def add( id )
      path = "#{@dir}/#{id}"
      if !@force && File.exist?( path )
         ## puts "  in sandbox"
      else
        sleep( @delay_in_s )   if @delay_in_s && @requests > 0 
        
        ## note: save text as blob - byte-by-byte as is  (might be corrupt text)
        content = Ordinals.content( id )
        ## pp content
        #=> #<Ordinals::Api::Content:0x000001a1352df938
        #      @data="RIFF\xF8\v\x00\x00WEBPVP8 \xEC\v\x00\x00...",
        #      @length=3072,
        #      @type="image/png"
  
        ## puts "data:"
        ## puts content.data
        write_blob( path, content.data )
        @requests += 1
      end
   end


   def add_csv( path )
      recs = read_csv( path )
      puts "  #{recs.size} record(s)"
 
      recs.each_with_index do |rec,i|
        id = rec['id']
        puts "==> #{i+1}/#{recs.size} - #{id}..."
        add( id )
      end
   end

   def add_collection( path )
      data = read_json( path )
      puts "  #{data['items'].size} record(s)"

      data['items'].each_with_index do |rec,i|
        name = rec['name']
        id   = rec['inscription_id']
        puts "==> #{i+1}/#{data['items'].size} - #{name} @ #{id}..."
        add( id )
      end
   end


   
   ID_RX = /[a-f0-9]{64}i[0-9]/x

   def _find_ids( values )
      values.select { |val| val.is_a?(String) && ID_RX.match(val) }      
   end

   def add_data( obj )
      if obj.is_a?( Array )
         recs = obj
         puts "  #{recs.size} record(s)"
         recs.each_with_index do |rec,i|
              if rec.is_a?( String )
                  id = rec
                  puts "==> #{i+1}/#{recs.size} #{id}..."
                  add( id ) 
              else  ## assume array of strings for now
                  values = rec
                print "==> #{i+1}/#{recs.size} "
                ids = _find_ids( values )
                if ids.size == 1
                  id = ids[0]
                  puts " #{id}..."
                  add( id )
                else 
                  puts
                  if ids.empty?
                    puts "!! ERROR - no inscribe id found in data row:"
                  else
                    puts "!! ERROR - more than one (that is, #{ids.size}) inscribe id found in data row:"
                  end
                  pp values
                  exit 1
                end
              end
         end        
      else
        ## todo/fix: raise ArgumentError - why? why not?
        puts "!! ERROR - sorry"
        exit 1
      end
   end

 # todo/add  
 #  def add_html( path )
 #  end


   def add_dir( rootdir )
      ## glob for **.csv and **.html
      datasets = Dir.glob( "#{rootdir}/**/*.csv" )
      datasets.each do |path|
         add_csv( path )
      end
   end
end  ## class Sandbox
end  ## module Ordinals

