

module OrdDb
def self.import_csv( path, content: true )
    recs = read_csv( path )
    puts "  #{recs.size} inscribe id(s)"
    #=>  1000 inscribe id(s) 
     
    recs.each_with_index do |rec,i|
      id = rec['id']
      puts "==> #{i+1}/#{rec.size} @ #{id}..."
    
      ## check if inscription / inscribe is already in db?
      inscribe = Model::Inscribe.find_by( id: id )
      if inscribe  ## already in db; dump record
        ## pp inscribe
      else         ## fetch via ordinals.com api and update db
         data = Ordinals.inscription( id )
         pp data
         Model::Inscribe.create_from_api( data )
         sleep( 1 )   ## delay in seconds (before next request) 
      end

      if content
        ## check if (content) blob is already in db?
        blob = Model::Blob.find_by( id: id )
        if blob    ## already in db; do nothing
        else       ## fetch via ordinals.com api and update db
           content = Ordinals.content( id )
           puts "  content-type: #{content.type}"
           puts "  content-length: #{content.length}"
        
           Model::Blob.create( id: id, content: content.data )
           sleep( 1 )   ## delay in seconds (before next request) 
        end
      end
    end  
end # method self.import_csv
end  # module OrdDb
