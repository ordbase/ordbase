
module OrdDb


class  Cache   

   Inscribe = Model::Inscribe
   Blob     = Model::Blob

def initialize( dir='.' )
    @dir = dir
end



###
# todo/fix: move  read_headers upstream to cocos!!!!
##
#  note: key only supports a-z0-9 AND dash(-)
#    no underscore(_) or dot(.)
#
#  follow HTTP headers and domain names format
##

HEADER_RX = /\A(?<key>[a-z][a-z0-9-]*)
                 :
                 [ ]*
               (?<value>.+?)    ## non-greedy
              \z
             /x

def read_headers( path )
  txt = read_text( path )
  h = {}
  txt.each_line do |line|
    line = line.strip
    ## skip empty and comment lines
    next if line.empty? || line.start_with?( '#' )

    if m=HEADER_RX.match(line)
      key   = m[:key]
      value = m[:value]
      
      h[key] = value
   else 
      puts "!! ERROR - parse error - no header pattern match for:"
      puts line
      exit 1
   end
  end
  h
end



def _find_blobs
   ## note:  *.{txt,json,png} will also include *.meta.txt
   ###            CANNOT use, thus, try *i?.*
   Dir.glob( "#{@dir}/**/*i?.{txt,json,png}" )
end

def _find_meta
   Dir.glob( "#{@dir}/**/*.meta.txt" ) 
end

def stats
   paths = _find_meta
   puts "  #{paths.size} inscribe metadatafile(s) found"

   paths = _find_blobs
   puts "  #{paths.size} inscribe blob(s) found"
end


def import_all   
   paths = _find_meta
   puts "  #{paths.size} inscribe metadatafile(s) found"

   paths.each_with_index do |path, i|
     ## puts "==> inscribe #{i+1}/#{paths.size}..."
     data = _read_inscribe( path )
     
     id = data['id']

     ## skip if exists (use update later - why? why not?)
     rec = Inscribe.find_by( id: id )
     if rec 
      ## skip - already in db
        print '.'
     else
        print " #{id}"  #  NEW - add / insert into db"
        Inscribe.create_from_cache( data )
     end
   end
   puts


   paths = _find_blobs
   puts "  #{paths.size} inscribe blob(s) found"

   paths.each_with_index do |path, i|
      ## puts "==> blob #{i+1}/#{paths.size}..."
      content = read_blob( path )
      id      = File.basename( File.dirname(path)) + 
                File.basename( path, File.extname( path ))
  
      rec = Blob.find_by( id: id )
      if rec
        ## skip - already in db
        print '.'
      else
         print " #{id}"   # NEW - add / insert into db"
         Blob.create( id: id,
                      content: content )
      end
    end
    puts
end


def import( id )
   data = read( id )  
   rec = Inscribe.create_from_cache( data )
   rec
end

def read( id )
   _read_inscribe( "#{@dir}/#{id[0,2]}/#{id[2..-1]}.meta.txt" ) 
end

def _read_inscribe( path )
   read_headers( path ) 
end


end # class Cache
end # module OrdDb


