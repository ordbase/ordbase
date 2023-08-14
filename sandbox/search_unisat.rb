##############
## try a unisat search via script (possible?))
##
##  note: plain request results in "empty shell"
##           inscriptions get fetch "delayed" via js/json
##
##  let's try puppeteer (google chrome)


$LOAD_PATH.unshift( "./unisat/lib" )
require 'unisat'


Unisat.cache_dir = './tmp/unisat'


CHROME_PATH = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
Unisat::Puppeteer.chrome_path = CHROME_PATH


## 32 inscribes x 32 pages = 1024 inscribes
## Unisat::Puppeteer.search( 'biixel', limit: 35 )  
recs = Unisat::Puppeteer.search( 'biixel', offset: 35, limit: 1 ) #, force: true )  
puts "  #{recs.size} inscribe(s)"
pp recs[0,2]

recs = Unisat::Puppeteer.search( 'bixel', offset: 1, limit: 3 )  
puts "  #{recs.size} inscribe(s)"
pp recs[0,2]


recs = Unisat::Puppeteer.search( 'diyphunks' )  
puts "  #{recs.size} inscribe(s)"
pp recs[0,2]

recs = Unisat::Puppeteer.search( 'orangepixels' )  
puts "  #{recs.size} inscribe(s)"
pp recs[0,2]


puts "bye"

