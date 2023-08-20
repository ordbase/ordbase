###
# to run use
#
#  $ ruby ./search_relays.rb


##
#
#  search for "relay" - to find sns relay registrations
#    https://unisat.io/search?q=%22relay%22&type=text&p=1
#
#   https://docs.satsnames.org/sats-names/relay-examples


$LOAD_PATH.unshift( "../unisat/lib" )
require 'unisat'


## Unisat.cache_dir = './tmp/unisat'


CHROME_PATH = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
Unisat::Puppeteer.chrome_path = CHROME_PATH


## note: search with enclosing double quotes!! e.g. "relay"
recs = Unisat::Puppeteer.search( '"relay"' )    
puts "  #{recs.size} inscribe(s)"
pp recs[0,2]



puts "bye"

