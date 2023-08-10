##############
## try a unisat search via script (possible?)
##
##  note: plain request results in "empty shell"
##           inscriptions get fetch "delayed" via js/json


require 'cocos'

def get( src )
    res = Webclient.get( src )
 
    if res.status.ok?
      res
    else
      ## todo/fix: raise exception here!!!!
      puts "!! ERROR - HTTP #{res.status.code} #{res.status.message} - failed web request >#{src}<; sorry"
      exit 1
    end
end



url = 'https://unisat.io/search?q=.bixel&type=text&p=22'


res = get( url )
puts res.text


INSCRIBE_ID_RX = %r{
    inscription/(?<id>[a-fi0-9]+)
   }ix


ids = []
page = res.text  ### assumes utf-8 for now
page.scan( INSCRIBE_ID_RX ) do |_|
  m = Regexp.last_match
  ids << m[:id]
end       
puts "   #{ids.size} inscribe id(s)"
#=> 0 inscribe id(s)

puts "bye"
