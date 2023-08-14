require 'cocos'

require 'puppeteer-ruby'
require 'nokogiri'


# our own code
require_relative 'unisat/version'   # always goes first
require_relative 'unisat/cache'


  

module Unisat
module Puppeteer

###
##  todo: use a config block in the future - why? why not?
def self.chrome_path=( path )
  if File.exist?( path )
    puts "** bingo! found chrome executable @ path >#{path}<"
  else
    puts "*** ERROR - sorry; cannot find chrome executable @ path >#{path}<"
    exit 1
  end

  @chrome_path = path
end

def self.chrome_path() @chrome_path; end

## use/rename to wait_in_secs - why? why not? 
def self.wait_in_s=( s ) @wait_in_s = s; end 
def self.wait_in_s() @wait_in_s ||= 10; end

## shortcut helper
def self.cache()  Unisat.cache; end  


###
# search
def self.search( q, offset: 1, 
                    force: false,
                    limit: nil )

     browser = nil
     page    = nil
     recs    = []

     print "==> searching >#{q}< starting at page #{offset}"
     print " up to #{offset+limit-1} (#{limit} pages)"   if limit && limit > 1 
     print ", force: true"  if force
     print "...\n"
 
     page_recs = nil 
     i = 0
     loop do     
      break  if limit && i >= limit                               
      count = offset+i

      page_url  = "https://unisat.io/search?q=#{q}&type=text&p=#{count}"
      print page_url
     
      ## check if already in cache
      if force == false && cache.exist?( q, 
                                         offset: count )
        print "...in cache\n"
        page_recs = cache.read_page( q, offset: count )
        recs += page_recs

        break  if limit.nil? && page_recs.size < 32  ## check for auto-limit (if less than 32 recs)
        i += 1
        next 
      end

      if browser.nil?    ## first page request? launch browser on demand
        opts = {}
        opts[:headless]        = false
        opts[:executable_path] = chrome_path  if chrome_path   ## add only if set (default is nil)
        
        browser = ::Puppeteer.launch( **opts )    
        page    = browser.new_page
      end

      print "... goto page ...\n"
      response = page.goto( page_url )
      pp response.headers

      puts "sleeping #{wait_in_s} sec(s)..."
      sleep( wait_in_s )
  
      ## print search result summary / counts
      page.wait_for_selector('div.result-notice')
      el =  page.query_selector("div.result-notice")
      puts
      puts el.evaluate("el => el.innerText")
      #=> Searched for "biixel" among 3252336 records, found 1105 results.
       
      ## get search results (32 inscribes per page)
      page.wait_for_selector('div.sats-list')
      el =  page.query_selector("div.sats-list")
  
      html = el.evaluate("el => el.innerHTML")
      # puts
      # puts html
 
      ## print pagination 
      ## note: only available if more than one page!!!
      el =  page.query_selector("ul.ant-pagination")
      if el
        puts
        puts el.evaluate("el => el.innerText")
         #=> 1 ••• 32 33 34 35
      end

      page_recs = cache.add_page( html, q, 
                                         offset: count )
      recs += page_recs

      break  if limit.nil? && page_recs.size < 32  ## check for auto-limit (if less than 32 recs)

      i += 1
    end  # loop

    if browser 
       puts "sleeping 2 secs before browser shutdown..."
       sleep( 2 )
       browser.close
    end

    recs
end  # method search  
end # module Puppeteer
end # module Unisat



## add alternate name alias - why? why not?
UniSat = Unisat



puts Unisat.banner