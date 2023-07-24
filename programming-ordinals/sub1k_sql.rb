$LOAD_PATH.unshift( "../ordlite/lib" )
require 'ordlite'


OrdDb.connect( adapter:  'sqlite3',
               database: './ordsub1k.db' )



puts
puts Inscribe.order( 'bytes DESC' ).limit(10).to_sql
puts


puts
puts Inscribe.select('content_type, COUNT(*)').group( 'content_type' ).order( Arel.sql( 'COUNT(*) DESC, content_type')).to_sql
puts


puts "bye"