

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

    res = Webclient.get( src )

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
