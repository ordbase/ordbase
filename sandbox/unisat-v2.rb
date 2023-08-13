##############
## try a unisat search via script (possible?))
##
##  note: plain request results in "empty shell"
##           inscriptions get fetch "delayed" via js/json
##
##  let's try puppeteer (google chrome)


require 'cocos'
require 'puppeteer-ruby'


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

def self.chrome_path
  @chrome_path
end



def self.search( q, offset: 1, 
                    limit: 1,
                    force: false )

   opts = {}
   opts[:headless]        = false
   opts[:executable_path] = chrome_path  if chrome_path   ## add only if set (default is nil)

   wait_in_s = 10

  ::Puppeteer.launch( **opts ) do |browser|

    page = browser.new_page
 
    limit.times do |i|
      count = offset+i

      page_url  = "https://unisat.io/search?q=#{q}&type=text&p=#{count}"
      puts page_url
     
      ## check if already in cache
      outpath = "./tmp/unisat/#{q}/#{count}.html"
      next if force == false && File.exist?( outpath )

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
      puts
      puts html
   
      write_text( outpath, html )
    end

    puts "sleeping 2 secs befor shutdown..."
    sleep( 2 )
  end
end  # method search


end # module Puppeteer
end # module Unisat



CHROME_PATH = 'C:\Program Files\Google\Chrome\Application\chrome.exe'

Unisat::Puppeteer.chrome_path = CHROME_PATH

## 32 inscribes x 32 pages = 1024 inscribes
Unisat::Puppeteer.search( 'biixel', limit: 35 )  
Unisat::Puppeteer.search( 'biixel', offset: 35, force: true )  


puts "bye"

