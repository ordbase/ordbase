

module OrdDb

def self.import_collection_csv( path,
                                name:,
                                content: true )

## or use
##  import_collection( format: 'csv') - why? why not?

   recs = read_csv( path )
   puts "  #{recs.size} inscribe id(s)"

   col = Model::Collection.find_by( name: name )
   if col
     puts "!! WARN - collection already in db; delete first to reimport"
     return     
   end

   col = Model::Collection.create(
    name:  name,
    max:   recs.size
 )

 recs.each_with_index do |rec,i|
    id   = rec['id']
    name = rec['name'] || rec['title']
    puts "==> #{i+1}/#{recs.size} >#{name}< @ #{id}..."

    col.items.create( pos: i,
                      inscribe_id: id,
                      name: name )

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
end


def self.import_collection_inscriptions( path, 
                                         name:, 
                                         content: true )
   recs = read_json( path )
   puts "  #{recs.size} inscribe id(s)"

   col = Model::Collection.find_by( name: name )
   if col
     puts "!! WARN - collection already in db; delete first to reimport"
     return     
   end


   col = Model::Collection.create(
      name:  name,
      max:   recs.size
   )

   recs.each_with_index do |rec,i|
      id   = rec['id']
      meta = rec['meta']
      name = meta['name']
      puts "==> #{i+1}/#{recs.size} >#{name}< @ #{id}..."
 
      col.items.create( pos: i,
                        inscribe_id: id,
                        name: name )

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
end



def self.import_collection( path, content: true )
   data = read_json( path )

   meta =  data['collection']
   pp meta

   name = meta['name']

   col = Model::Collection.find_by( name: name )
   if col
     puts "!! WARN - collection already in db; delete first to reimport"
     return     
   end
   
   col = Model::Collection.create(
      name:  name,
      desc:  meta['description'],
      max:   meta['max_supply']
   )

   items = data['items']
   puts "  #{items.size} inscribe id(s)"
   items.each_with_index do |rec,i|
      id   = rec['inscription_id']
      name = rec['name']
      puts "==> #{i+1}/#{items.size} @ #{id}..."
 
      col.items.create( pos: i,
                        inscribe_id: id,
                        name: name )

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
end


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
