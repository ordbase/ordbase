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



## todo/
##   filter out unconfirmed - why? why not?

paths = Dir.glob( "./tmp/unisat2/biixel/*.html" )
puts "   #{paths.size} page(s)"

paths.each do |path|
  txt = read_text( path )

  data = parse_page( txt )
  puts "   #{data.size} inscribe(s)"

  basename = File.basename( path, File.extname( path ))
  write_json( "./tmp/unisat/biixel/#{basename}.json" , data )
end


puts "bye"
