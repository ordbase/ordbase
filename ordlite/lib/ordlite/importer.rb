module OrdDb

class Importer
   Inscribe   =  Model::Inscribe
   Blob       =  Model::Blob
   Collection =  Model::Collection 



def import_collection_csv( path,
                                name:,
                                content: true )
## or use
##  import_collection( format: 'csv') - why? why not?
   recs = read_csv( path )
   puts "  #{recs.size} inscribe id(s)"

   col = Collection.find_by( name: name )
   if col && col.items.count > 0
     puts "!! WARN - collection already in db; delete first to reimport"
     return     
   elsif col
     ## do nothing; (re)use collection record; add items
   else
     col = Collection.create(
            name:  name
            ## max:   recs.size   ## auto-add max - why? why not?
          )
   end

 recs.each_with_index do |rec,i|
    id   = rec['id']
    name = rec['name'] || rec['title']
    puts "==> #{i+1}/#{recs.size} >#{name}< @ #{id}..."

    col.items.create( pos: i,
                      inscribe_id: id,
                      name: name )

    _import( id, content: content )
 end
end


def import_collection_inscriptions( path, 
                                         name:, 
                                         content: true )
   recs = read_json( path )
   puts "  #{recs.size} inscribe id(s)"

   col = Collection.find_by( name: name )
   if col && col.items.count > 0
     puts "!! WARN - collection already in db; delete first to reimport"
     return     
   elsif col
      ## do nothing; (re)use collection record; add items
   else
     col = Model::Collection.create(
        name:  name  
        ## max:   recs.size   ## auto-add max - why? why not?
      )
   end

   recs.each_with_index do |rec,i|
      id   = rec['id']
      meta = rec['meta']
      name = meta['name']
      puts "==> #{i+1}/#{recs.size} >#{name}< @ #{id}..."
 
      col.items.create( pos: i,
                        inscribe_id: id,
                        name: name )

     _import( id, content: content ) 
   end
end


def import_collection( path, content: true )
   data = read_json( path )

   meta =  data['collection']
   pp meta

   name = meta['name']

   col = Collection.find_by( name: name )
   if col
     puts "!! WARN - collection already in db; delete first to reimport"
     return     
   end
   
   col = Collection.create(
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

     _import( id, content: content )
   end
end


def import_csv( path, content: true )
    recs = read_csv( path )
    puts "  #{recs.size} inscribe id(s)"
    #=>  1000 inscribe id(s) 
     
    recs.each_with_index do |rec,i|
      id = rec['id']
      puts "==> #{i+1}/#{rec.size} @ #{id}..."
    
      _import( id, content: content )
    end  
end # method import_csv

def import( id_or_ids, content: true )
   if id_or_ids.is_a?( String )
      id = id_or_ids
     _import( id, content: content )
   else  ## assume array
      ids = id_or_ids
      ids.each do |id|
         _import( id, content: content )
      end
   end
end 

def _import( id, content: true )
   ## check if inscription / inscribe is already in db?
   inscribe = Inscribe.find_by( id: id )
   if inscribe  ## already in db; dump record
     ## pp inscribe
   else         ## fetch via ordinals.com api and update db
      data = Ordinals.inscription( id )

      pp data
      Inscribe.create_from_api( data )
   end

   if content
     ## check if (content) blob is already in db?
     blob = Blob.find_by( id: id )
     if blob    ## already in db; do nothing
     else       ## fetch via ordinals.com api and update db
        content = Ordinals.content( id )

        puts "  content-type: #{content.type}"
        puts "  content-length: #{content.length}"
     
        Blob.create( id: id, content: content.data )
     end
   end              
end

end  # class Importer



###
## convenience helpers

def self.importer   ## "default" importer
   @importer ||= Importer.new 
end

def self.import_csv( path, content: true )
   importer.import_csv( path, content: content )
end


def self.import_collection( path, content: true )
   importer.import_collection( path, content: content )
end

def self.import_collection_inscriptions( path, 
          name:, 
          content: true )
   importer.import_collection_inscriptions( path, 
          name: name, 
          content: content )
end

def self.import_collection_csv( path,
          name:,
          content: true )
    importer.import_collection_csv( path,
           name: name,
           content: content )
end


module Model 
class Inscribe
   def self.import( id_or_ids, content: true )
       OrdDb.importer.import( id_or_ids, content: content )
   end
end  # class Inscribe
end # module Model 


end  # module OrdDb
