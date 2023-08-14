module Unisat
###
##  todo: use a config block in the future - why? why not?
def self.cache_dir=( dir ) @cache = Cache.new( dir ); end 
def self.cache()  @cache ||= Cache.new( './unisat' ); end


def self.parse_page( html )
    doc = Nokogiri::HTML( html )
  
    items = [] 
  
    sats = doc.css( '.item-container' )
    sats.each_with_index do |el,i|
      puts "==> sat ##{i+1}/#{sats.size}..."
  
      h = {}
  #    <a href="https://ordinals.com/inscription/
  #    9613d44f53a1245bf34f43820163bb3064a5715c19f0d6c767a14d1b49f46614i0" 
  #    target="_blank" rel="noreferrer" class="sats-item  ">
      a = el.at( 'a.sats-item' )
      h['href'] = a['href']
  
      name = el.at( '.name' )
      h['name'] = name.text
  
      num = el.at( '.num' )
      h['num'] = num.text
  
      address = el.at( '.address' )
      h['address'] = address.text
  
      date = el.at( '.date' )
      h['date'] = date.text
      ##pp h
      
      items << h
    end  
    items
end  # method _parse_page
  

class Cache
  def initialize( dir )
    @dir = dir
  end

  ## todo:
  ## - add offset: nil, limit: nil  - why? why not?
  def read( key ) 
      recs = []

     paths = Dir.glob( "#{@dir}/#{key}/*.json" )
     puts "   #{paths.size} page(s) in cache"

     paths.each_with_index do |path,i|
       results = read_json( path )
       puts "==> #{i+1}/#{paths.size} - #{results.size} inscribe(s) in >#{path}<..."

       results.each do |h|
           date = h['date']  # note: might include unconfirmed!!!
          ##  always "auto-magically" filter out unconfirmed for now 
          if date == 'unconfirmed'
             puts "  !! INFO - skipping unconfirmed inscribe"
             next
          end

          ## todo/fix:
          ##  reformat date here/parse
          ##   and change to iso e.g. 2023-12-24 17:18 or such - why? why not!!!!


          ## id -- split href by / and get last part (is id)
          id  = h['href'].split( '/')[-1] 
          ## num -- remove/ strip leadingnumber sign (#)  
          num = h['num'].sub( '#', '' )  
          recs << { 
             'id'      => id,
             'num'     => num,
             'date'    => date,
             'address' => h['address'],
             'text'    => h['name'],  ## change name to text
          }
       end
      end
      puts "   #{recs.size} inscribe(s) - total"
      recs
  end # method read


  def exist?( key, offset: )
    outpath = "#{@dir}/#{key}/#{offset}.json"
    File.exist?( outpath )
  end

  def add_page( page, key, offset: )
     data = Unisat.parse_page( page )

     ## note: only write if results > 0
     if data.size > 0
        outpath = "#{@dir}/#{key}/#{offset}.json"
        write_json( outpath, data )   
     else
        puts "!! WARN - no results found in page #{offset} for key >#{key}<"
     end
  end
end  # class Cache
end   # module Unisat
