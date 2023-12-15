

module Hiro

class Api   ## change/rename Api to Client - why? why not?
  def self.instance    ## use ordinals or bitcoin or ??? - why? why not?
    @instance ||= new
    @instance
  end
    

  def initialize 
    @base      = 'https://api.hiro.so/ordinals/v1'
    @requests  = 0  ## count requests (for delay_in_s sleeping/throttling)
  end

### todo/fix -- add status api call !!!  
=begin
  {"server_version"=>"ordinals-api v2.0.1-beta.2 (beta:0692f02)",
   "status"=>"ready",
   "block_height"=>819782,
   "max_inscription_number"=>46080354,
   "max_cursed_inscription_number"=>-228015}
=end
 
##
##  If your rate limits fall under 50 RPM, 
##  and you prefer unauthenticated access, 
## no further action is required. 
##
##  note: use a sleep_in_s for 1 second for now


  def list( from_number:, offset: nil )
    src = "#{@base}/inscriptions"

    src += "?from_number=#{from_number}" 
    src += "&offset=#{offset}"   if offset
    src += "&order=asc"    ## lowest numbers first!!!
    src += "&order_by=number"
    src += '&limit=60'   ## note: max. limit is 60
  

    data = nil
    loop do
      data = get_json( src )

      if data.has_key?( 'results' )   ## assume it's ok with results
        # puts "  #{data['results'].size} result(s)"

        # print "limit: ", data["limit"]
        # print " offset: ", data["offset"]
        # print " total: ",  data["total"]
        # print "\n"
        break
      else
         pp data
         puts "!! ERROR ???"
         puts "  retry..."   
         next
      end
    end
    
    data
  end  # method list


  def get_json( src )
    @requests += 1

    ## fix-fix-fix: hard coded delay for now
    delay_in_s = 1    # 0.5 

    if @requests > 1 && delay_in_s
      puts "request no. #{@requests}@#{@base}; sleeping #{delay_in_s} sec(s)..."
      sleep( delay_in_s )
    end

    res = nil
    loop do 
      res = Webclient.get( src )

      ## !! ERROR - 429 - Too Many Requests
      if res.status.code == 429
         puts "!! too many requests"
         puts "   sleep 11 secs"
         sleep( 11 )
      ##   522: Connection timed out
      elsif res.status.code == 522
         puts "!! connection timed out"
         puts "   sleep 11 secs"
         sleep( 11 )
      else
         break
      end
    end        

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

def self.list( from_number:, offset: nil )
     Api.instance.list( from_number: from_number, 
                             offset: offset  )
end

end  # module Hiro
