
module OrdDb
    module Model
  
  class Inscribe < ActiveRecord::Base
    has_one :blob, foreign_key: 'id'
    has_one :collection    ## optional (auto-added via og/orc-721 deploy)
    has_one :generative, foreign_key: 'id'   ## optional (auto-added via og/orc-721 deploy)

    ## convernience helper
    ##  forward to blob.content
    ##    blob.content - encoding is BINARY (ASCII-7BIT)
    ##    blob.text    - force_encoding is UTF-8 (return a copy)
    def content() blob.content; end
    def text() blob.text; end


    ################################
    ### scope like helpers
    def self.deploys 
      where_clause =<<SQL 
content LIKE '%deploy%' 
AND (   content LIKE '%orc-721%' 
     OR content LIKE '%og%')
SQL

       joins(:blob).where( where_clause ).order( 'num' )
    end

    def self.deploys_by( slug: )
             where_clause =<<SQL 
content LIKE '%deploy%' 
AND (   content LIKE '%orc-721%' 
     OR content LIKE '%og%')
AND content LIKE '%#{slug}%'     
SQL

      joins(:blob).where( where_clause ).order( 'num' )
    end

    def self.mints 
      where_clause =<<SQL 
content LIKE '%mint%' 
AND (   content LIKE '%orc-721%' 
     OR content LIKE '%og%')
SQL

       joins(:blob).where( where_clause ).order( 'num' )
    end

    def self.mints_by( slug: ) 
      where_clause =<<SQL 
content LIKE '%mint%' 
AND (   content LIKE '%orc-721%' 
     OR content LIKE '%og%')
AND content LIKE '%#{slug}%'     
SQL

       joins(:blob).where( where_clause ).order( 'num' )
    end


   def self.largest
      order( 'bytes DESC' )
   end
   class << self
      alias_method :biggest, :largest
   end

   def self.content_type_counts
       group( 'content_type' ).order( Arel.sql( 'COUNT(*) DESC, content_type')).count
   end

   def self.text
      ## note: for now include:
      ##   - text/plain (all variants)
      ##   - text/json (all variants)
      ##   - text/markdown
      where( content_type: 
               ['text/plain',
                'text/plain;charset=utf-8',
                'text/markdown',
                'application/json',
               ]
           )
   end
   def self.png() where( content_type: 'image/png' ); end

###
## add support for ordinals.com api txt (headers format) 


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
  