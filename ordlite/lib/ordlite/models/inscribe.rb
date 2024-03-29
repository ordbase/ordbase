
module OrdDb
    module Model
  
  class Inscribe < ActiveRecord::Base
    has_one :blob, foreign_key: 'id'
 
    has_one :factory     ## optional (auto-added via og/orc-721 deploy)
    has_one :generative, foreign_key: 'id'   ## optional (auto-added via og/orc-721 deploy)

    ## convernience helper
    ##  forward to blob.content
    ##    blob.content - encoding is BINARY (ASCII-7BIT)
    ##    blob.text    - force_encoding is UTF-8 (return a copy)
    def content() blob.content; end
    def text() blob.text; end


    ################################
    ### scope like helpers
    def self.png() where( content_type: 'image/png' ); end
    def self.gif() where( content_type: 'image/gif' ); end
    def self.jpg() where( content_type: 'image/jpeg' ); end
    def self.webp() where( content_type: 'image/webp' ); end
    def self.svg()  where( content_type: 'image/svg+xml' ); end
    def self.avif() where( content_type: 'image/avif' ); end

    class << self
       alias_method :jpeg, :jpg
    end     

    def self.image  
         ## change to/or add alias e.g. image/images - why? why not
        where( content_type: [
            'image/png',
            'image/jpeg',
            'image/gif',
            'image/webp',
            'image/svg+xml',
            'image/avif',
            ])
    end

    def self.html
        where( content_type: [
           'text/html;charset=utf-8',
           'text/html',
          ])
    end

    def self.js
        where( content_type: [
           'text/javascript',
           'application/javascript',
          ])
    end

     class << self
        alias_method :javascript, :js
     end     
 
    def self.text
        ## change to/or add alias e.g. text/texts - why? why not
        ## include html or svg in text-only inscription - why? why not?
        ##  include markdown in text-only inscription - why? why not?
        ##   make content_type lower case with lower() - why? why not?
        where( content_type: [
                  'text/plain',
                  'text/plain;charset=utf-8',
                  'text/plain;charset=us-ascii',
                  'application/json',
             ])
    end
        
    def self.search( q )   ## "full-text" search helper
        ##  rename to text_search - why? why not?        
        ## auto-sort by num - why? why not?
        joins(:blob).text.where( "content LIKE '%#{q}%'" ).order('num')
    end
    
    

    def self.deploys 
      where_clause =<<SQL 
content LIKE '%deploy%' 
AND (   content LIKE '%orc-721%' 
     OR content LIKE '%og%')
SQL

       joins(:blob).text.where( where_clause ).order( 'num' )
    end

    def self.deploys_by( slug: )
             where_clause =<<SQL 
content LIKE '%deploy%' 
AND (   content LIKE '%orc-721%' 
     OR content LIKE '%og%')
AND content LIKE '%#{slug}%'     
SQL

      joins(:blob).text.where( where_clause ).order( 'num' )
    end

    def self.mints 
      where_clause =<<SQL 
content LIKE '%mint%' 
AND (   content LIKE '%orc-721%' 
     OR content LIKE '%og%')
SQL

       joins(:blob).text.where( where_clause ).order( 'num' )
    end

    def self.mints_by( slug: ) 
      where_clause =<<SQL 
content LIKE '%mint%' 
AND (   content LIKE '%orc-721%' 
     OR content LIKE '%og%')
AND content LIKE '%#{slug}%'     
SQL

       joins(:blob).text.where( where_clause ).order( 'num' )
    end

    
   def self.sub1k()  where( 'num < 1000' ); end
   def self.sub2k()  where( 'num < 2000' ); end
   def self.sub10k()  where( 'num < 10000' ); end
   def self.sub20k()  where( 'num < 20000' ); end
   def self.sub100k()  where( 'num < 100000' ); end
   def self.sub1m()  where( 'num < 1000000' ); end
   def self.sub2m()  where( 'num < 2000000' ); end
   def self.sub10m()  where( 'num < 10000000' ); end
   def self.sub20m()  where( 'num < 20000000' ); end
   def self.sub21m()  where( 'num < 21000000' ); end
 

   def self.largest
      order( 'bytes DESC' )
   end

   def self.address_counts
       group( 'address' )
        .order( Arel.sql( 'COUNT(*) DESC')).count
   end 

   def self.block_counts
       group( 'block' )
        .order( 'block').count
   end 
   
   def self.block_with_timestamp_counts
       group( Arel.sql( "block || ' @ ' || date" ))
        .order( Arel.sql( "block || ' @ ' || date" ) ).count
   end

   def self.content_type_counts
       group( 'content_type' )
       .order( Arel.sql( 'COUNT(*) DESC, content_type')).count
   end


   def self.date_counts
       ## note: strftime is SQLite specific/only!!!
      group( Arel.sql("strftime('%Y-%m-%d', date)"))
        .order( Arel.sql("strftime('%Y-%m-%d', date)")).count
   end

   def self.month_counts
      ## note: strftime is SQLite specific/only!!!
      group( Arel.sql("strftime('%Y-%m', date)"))
       .order( Arel.sql("strftime('%Y-%m', date)")).count
   end

   def self.hour_counts
      ## note: strftime is SQLite specific/only!!!
       group( Arel.sql("strftime('%Y-%m-%d %Hh', date)"))
       .order( Arel.sql("strftime('%Y-%m-%d %Hh', date)")).count
   end


   class << self
      alias_method :biggest, :largest
      alias_method :counts_by_address,      :address_counts
      alias_method :counts_by_content_type, :content_type_counts
      alias_method :counts_by_date,         :date_counts
      alias_method :counts_by_day,          :date_counts
      alias_method :counts_by_month,        :month_counts
      alias_method :counts_by_hour,        :hour_counts
      alias_method :counts_by_block,        :block_counts
      alias_method :counts_by_block_with_timestamp,  :block_with_timestamp_counts
   end




###
## add support for ordinals.com api txt (headers format) 
##
## todo/fix: move to importer!!! - why? why not?


   def self.create_from_api( data ) create( _parse_api( data )); end
   class << self
     alias_method :create_from_cache, :create_from_api   ## add alias - why? why not?
   end

   
   def self._parse_api( data )   ## parse api json data
    ## num via title
    attributes = {
     id:  data['id'],
     num: _title_to_num( data['title'] ),
     bytes: _content_length_to_bytes( data['content-length'] ), 
     sat:  data['sat'].to_i(10),
     content_type:  data['content-type'],
     block: data['genesis-height'].to_i(10),
     fee: data['genesis-fee'].to_i(10),
     tx: data['genesis-transaction'],
     address: data['address'],
     output: data['output'],
     value: data['output-value'].to_i(10),
     offset: data['offset'].to_i(10),
     # "2023-06-01 05:00:57 UTC"
     date:  DateTime.strptime( data['timestamp'], 
                               '%Y-%m-%d %H:%M:%S %z')
   }
 
   attributes
 end
 
 
     ##  "title": "Inscription 9992615",
 TITLE_RX = /^Inscription (?<num>[0-9]+)$/i
 
 def self._title_to_num( str )
    if m=TITLE_RX.match( str )
       m[:num].to_i(10)    ## use base 10
    else
      puts "!! ERROR - no inscribe num found in title >#{str}<"
      exit 1   ## not found - raise exception - why? why not?
    end
 end
 
 CONTENT_LENGTH_RX = /^(?<num>[0-9]+) bytes$/i
 
 def self._content_length_to_bytes( str )
     if m=CONTENT_LENGTH_RX.match( str )
        m[:num].to_i(10)    ## use base 10
     else
        puts "!! ERROR - bytes found in content lenght >#{str}<"
        exit 1   ## not found - raise exception - why? why not?
     end
 end
  


 ###
 # instance methods
def extname
  ## map mime type to file extname
  ## see https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
  ##  for real-world usage, see https://dune.com/dgtl_assets/bitcoin-ordinals-analysis
  ##  https://github.com/casey/ord/blob/master/src/media.rs

   if content_type.start_with?( 'text/plain' )
      '.txt'
   elsif content_type.start_with?( 'text/markdown' )
      '.md'
   elsif content_type.start_with?( 'text/html' )
      '.html'
   elsif content_type.start_with?( 'text/javascript' ) ||
         content_type.start_with?( 'application/javascript' )
      ## note: application/javascript is considered bad practice/legacy
      '.js'
   elsif content_type.start_with?( 'image/png' )
       ## Portable Network Graphics (PNG)
      '.png'
   elsif content_type.start_with?( 'image/jpeg' )
        ##  Joint Photographic Expert Group image (JPEG) 
       '.jpg'   ## use jpeg - why? why not?
   elsif content_type.start_with?( 'image/webp' )
        ## Web Picture format (WEBP)
       '.webp'   ## note: no three-letter extension available
   elsif content_type.start_with?( 'image/svg' )
        ## Scalable Vector Graphics (SVG) 
       '.svg'
   elsif content_type.start_with?( 'image/gif' ) 
       ##  Graphics Interchange Format (GIF)
       '.gif'
   elsif content_type.start_with?( 'image/avif' )  
       ## AV1 Image File Format (AVIF)
       '.avif'
   elsif content_type.start_with?( 'application/epub' )
       '.epub'
   elsif content_type.start_with?( 'application/pdf' )
       '.pdf'
   elsif content_type.start_with?( 'application/json' )
       '.json'
   elsif content_type.start_with?( 'application/pgp-signature' )
       '.sig'
   elsif content_type.start_with?( 'audio/mpeg' )
       '.mp3'
   elsif content_type.start_with?( 'audio/midi' )
       '.midi'
   elsif content_type.start_with?( 'video/mp4' )
       '.mp4'
   elsif content_type.start_with?( 'video/webm' )
       '.wepm'
   elsif content_type.start_with?( 'audio/mod' )  
      ## is typo? possible? only one inscription in 20m?
       '.mod'   ## check/todo/fix if is .wav?? 
   else
      puts "!! ERROR - no file extension configured for content type >#{content_type}<; sorry:"
      pp self
      exit 1
   end
end

def export_path  ## default export path
   numstr = "%08d" % num   ###  e.g. 00000001  
   "./tmp/#{numstr}#{extname}" 
end
def export( path=export_path )
   if blob
     write_blob( path, blob.content )
   else
      ## todo/fix: raise exception - no content
      puts "!! ERROR - inscribe has no content (blob); sorry:"
      pp self
      exit 1
   end
end


  end  # class Inscribe
  
    end # module Model
end # module OrdDb
  