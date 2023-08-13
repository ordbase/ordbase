require 'cocos'
require 'nokogiri'




def parse_page( html )
  doc = Nokogiri::HTML( html )

  items = []


  sats = doc.css( '.item-container' )
  sats.each_with_index do |el,i|
    puts "==> sat ##{i+1}..."

    h = {}
#    <a href="https://ordinals.com/inscription/
#    9613d44f53a1245bf34f43820163bb3064a5715c19f0d6c767a14d1b49f46614i0" 
#    target="_blank" rel="noreferrer" class="sats-item  ">
    a = el.at( 'a.sats-item' )
    h['href'] = a['href']

    name = el.at( '.name' )
    h['name'] = name.text

    num = el.at( '.num' )
    h['num'] = num.text

    address = el.at( '.address' )
    h['address'] = address.text

    date = el.at( '.date' )
    h['date'] = date.text
    pp h
    items << h
  end


  items
end


html = read_text( "./tmp/unisat/biixel/35.html" )


data =  parse_page( html )

## pp data

puts JSON.pretty_generate( data )


puts "bye"