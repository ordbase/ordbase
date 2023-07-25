###
## add (database) import machinery to cache

module Ordinals
class Cache
   Inscribe = OrdDb::Model::Inscribe
   Blob     = OrdDb::Model::Blob

def import_all  
   paths = _find_meta
   puts "  #{paths.size} inscribe metaddatafile(s) found"
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
        rec = Inscribe.create_from_cache( data )
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
         rec = Blob.create( id: id,
                           content: content )
      end
    end
    puts
end

def import( id )
   data = read( id )
   rec = Inscribe.find_by( id: id )
   if rec 
      # skip - already in db
   else
      rec = Inscribe.create_from_cache( data )
   end
end


end  # class Cache
end  # module Ordinals 

