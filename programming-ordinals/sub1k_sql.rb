$LOAD_PATH.unshift( "../ordlite/lib" )
require 'ordlite'


OrdDb.open( './ordsub1k.db' )



puts
puts Inscribe.order( 'bytes DESC' ).limit(10).to_sql
puts


puts
puts Inscribe.select('content_type, COUNT(*)')
        .group( 'content_type' )
        .order( Arel.sql( 'COUNT(*) DESC, content_type')).to_sql
puts


puts
puts Inscribe.select( Arel.sql( "strftime('%Y-%m-%d', date) as day, COUNT(*)"))
        .group( Arel.sql( 'day' ))
        .order( Arel.sql( 'day' )).to_sql
puts



puts "bye"