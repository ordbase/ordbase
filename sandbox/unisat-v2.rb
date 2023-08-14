##############
## try a unisat search via script (possible?))
##
##  note: plain request results in "empty shell"
##           inscriptions get fetch "delayed" via js/json
##
##  let's try puppeteer (google chrome)


$LOAD_PATH.unshift( "./unisat/lib" )
require 'unisat'




CHROME_PATH = 'C:\Program Files\Google\Chrome\Application\chrome.exe'

Unisat::Puppeteer.chrome_path = CHROME_PATH
Unisat::Puppeteer.cache_dir = './tmp/unisat'


## 32 inscribes x 32 pages = 1024 inscribes
## Unisat::Puppeteer.search( 'biixel', limit: 35 )  
Unisat::Puppeteer.search( 'biixel', offset: 35, limit: 3, force: true )  


puts "bye"

