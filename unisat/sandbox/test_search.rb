####
# to run use:
#   $ ruby -I ./lib sandbox/test_search.rb

require 'unisat'


Unisat.cache_dir = './tmp/unisat'


CHROME_PATH = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
Unisat::Puppeteer.chrome_path = CHROME_PATH


Unisat::Puppeteer.search( 'diyphunks' )  
Unisat::Puppeteer.search( 'orangepixels' )  

puts "bye"
