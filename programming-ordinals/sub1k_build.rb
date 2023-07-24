#####
#  build  ordsub1k.db  (sqlite database with first thousand ordinal inscriptions)

$LOAD_PATH.unshift( "../ordinals/lib" )
$LOAD_PATH.unshift( "../ordlite/lib" )

require 'ordinals'
require 'ordlite'



OrdDb.connect( adapter:  'sqlite3',
               database: './ordsub1k.db' )

## build schema if database new/empty
OrdDb.auto_migrate!


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   0 inscribe(s)
#=>   0 blob(s)


recs = read_csv( "./sub1k_inscriptions.csv" )
puts "  #{recs.size} inscribe id(s)"
#=>  1000 inscribe id(s) 


recs.each_with_index do |rec,i|
  id = rec['id']
  puts "==> #{i} @ #{id}..."

  ## check if inscription / inscribe is already in db?
  inscribe = Inscribe.find_by( id: id )
  if inscribe  ## already in db; dump record
    pp inscribe
  else         ## fetch via ordinals.com api and update db
     data = Ordinals.inscription( id )
     pp data
     Inscribe.create_from_api( data )
     sleep( 1 )   ## delay in seconds (before next request) 
  end

  ## check if (content) blob is already in db?
  blob = Blob.find_by( id: id )
  if blob    ## already in db; do nothing
  else       ## fetch via ordinals.com api and update db
     content = Ordinals.content( id )
     puts "  content-type: #{content.type}"
     puts "  content-length: #{content.length}"
    
     Blob.create( id: id, content: content.data )
     sleep( 1 )   ## delay in seconds (before next request) 
  end
end


puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>   1000 inscribe(s)
#=>   1000 blob(s)


puts "bye"