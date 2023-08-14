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
                    limit: 1,
                    force: false )

   opts = {}
   opts[:headless]        = false
   opts[:executable_path] = chrome_path  if chrome_path   ## add only if set (default is nil)


  ::Puppeteer.launch( **opts ) do |browser|

    page = browser.new_page
 
    limit.times do |i|
      count = offset+i

      page_url  = "https://unisat.io/search?q=#{q}&type=text&p=#{count}"
      print page_url
     
      ## check if already in cache
      if force == false && cache.exist?( q, offset: count )
        print "...in cache\n"
        next 
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

 
      ## print pagination 
      page.wait_for_selector('ul.ant-pagination')
      el =  page.query_selector("ul.ant-pagination")
      puts
      puts el.evaluate("el => el.innerText")
      #=> 1 ••• 32 33 34 35

      
      ## get search results (32 inscribes per page)
      page.wait_for_selector('div.sats-list')
      el =  page.query_selector("div.sats-list")
  
      html = el.evaluate("el => el.innerHTML")
      # puts
      # puts html
   
      cache.add_page( html, q, 
                            offset: count )
    end

    puts "sleeping 2 secs before shutdown..."
    sleep( 2 )
  end
end  # method search  
end # module Puppeteer
end # module Unisat



## add alternate name alias - why? why not?
UniSat = Unisat



puts Unisat.banner