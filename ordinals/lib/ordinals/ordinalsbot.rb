

module Ordinalsbot

class Api   ## change/rename Api to Client - why? why not?
  def self.instance    ## use ordinals or bitcoin or ??? - why? why not?
    @instance ||= new
    @instance
  end
    

  def initialize 
    @base      = 'https://api2.ordinalsbot.com'
    @requests  = 0  ## count requests (for delay_in_s sleeping/throttling)
  end

  
##
# docu here -> https://docs.ordinalsbot.com/api/search-inscriptions
#
#  Search for an existing Image or File
#   Use this endpoint to check if a certain image was inscribed before. 
#   We call this a "hash check".
#
#   note: Image Search is done by hashing the image file 
#    and checking against previous inscriptions' hashes.
#   To use this endpoint you need to sha256 hash the image file content. 
#
#   Results array will be sorted by ascending block height.
#   Pagination parameters are the same as text search
#
#   query parameters:
#   hash -  String - sha256 hash of an image buffer in hex
#
#  headers:
#   x-api-key - String  - API Key Required if domain is not on allowlist


  def hashcheck( hash )
    src = "#{@base}/search?hash=#{hash}"
    data = get_json( src )
    data
  end


  def get_json( src )
    @requests += 1

    ## fix-fix-fix: hard coded delay for now
    delay_in_s = 1    # 0.5 

    if @requests > 1 && delay_in_s
      puts "request no. #{@requests}@#{@base}; sleeping #{delay_in_s} sec(s)..."
      sleep( delay_in_s )
    end


   ## get api key
    api_key = ENV['ORDINALSBOT_API'] || ENV['ORDINALSBOT_API_KEY']
    if api_key.nil?
      puts "!! ERROR - no ordinalsbot api key found in env; sorry"
      exit 1
    end

    res = Webclient.get( src,
                         headers: { 'x-api-key' => api_key } )

    ## tod/fix - check for content-type (application/json) too - why? why not? 
    if res.status.ok? && res.text.index( "{" )
      data = res.json
      data
    else
       ## todo/fix: raise exception here!!!!
       puts res.text
       puts "!! ERROR - #{res.status.code} - #{res.status.message} - failed web request >#{src}<; sorry"
       exit 1
    end
  end 
end  # class Api 

##
##  add convenience alias
API = Api



###
##  add convenience helpers

def self.hashcheck( hash )
     Api.instance.hashcheck( hash )
end

end  # module Ordinalsbot
