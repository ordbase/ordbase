require 'json'
require 'nokogiri'


html =<<HTML
<!doctype html>
<html lang=en>
  <head>
    <meta charset=utf-8>
    <meta name=format-detection content='telephone=no'>
    <meta name=viewport content='width=device-width,initial-scale=1.0'>
    <meta property=og:title content='Inscription 407'>
    <meta property=og:image content='https://ordinals.net/static/favicon.png'>
    <meta property=twitter:card content=summary>
    <title>Inscription 407</title>
    <link rel=alternate href=/feed.xml type=application/rss+xml title='Inscription RSS Feed'>
    <link rel=stylesheet href=/static/index.css>
    <link rel=stylesheet href=/static/modern-normalize.css>
    <script src=/static/index.js defer></script>
  </head>
  <body>
  <header>
    <nav>
      <a href=/>Ordinals<sup>alpha</sup></a>
      <a href=https://docs.ordinals.com/>Handbook</a>
      <a href=https://github.com/casey/ord>Wallet</a>
      <a href=/clock>Clock</a>
      <a href=/rare.txt>rare.txt</a>
      <form action=/search method=get>
        <input type=text autocapitalize=off autocomplete=off autocorrect=off name=query spellcheck=false>
        <input type=submit value=Search>
      </form>
    </nav>
  </header>
  <main>
<h1>Inscription 407</h1>
<div class=inscription>
<a class=prev href=/inscription/f3247c255e78a659b52ac08572d1c02ccd1390b69a06c65848aafaeaf0799f40i0>❮</a>
<iframe sandbox=allow-scripts scrolling=no loading=lazy src=/preview/acda637db995df796b35035fd978cc1a947f1e6fd5215968da88b7e38a7e4b37i0></iframe>
<a class=next href=/inscription/fdb0ba70f4989a33a8bb2b5284b264ef23c17ed7389fdd606ecf134e8af7b9edi0>❯</a>
</div>
<dl>
  <dt>id</dt>
  <dd class=monospace>acda637db995df796b35035fd978cc1a947f1e6fd5215968da88b7e38a7e4b37i0</dd>
  <dt>address</dt>
  <dd class=monospace>bc1qx3scwushtwenxtxlnjet4x2w5vg35etdtse5u0</dd>
  <dt>output value</dt>
  <dd>8020</dd>
  <dt>sat</dt>
  <dd><a href=/sat/1883186433806857>1883186433806857</a></dd>
  <dt>preview</dt>
  <dd><a href=/preview/acda637db995df796b35035fd978cc1a947f1e6fd5215968da88b7e38a7e4b37i0>link</a></dd>
  <dt>content</dt>
  <dd><a href=/content/acda637db995df796b35035fd978cc1a947f1e6fd5215968da88b7e38a7e4b37i0>link</a></dd>
  <dt>content length</dt>
  <dd>529 bytes</dd>
  <dt>content type</dt>
  <dd>image/png</dd>
  <dt>timestamp</dt>
  <dd><time>2023-01-31 19:34:47 UTC</time></dd>
  <dt>genesis height</dt>
  <dd><a href=/block/774489>774489</a></dd>
  <dt>genesis fee</dt>
  <dd>5340</dd>
  <dt>genesis transaction</dt>
  <dd><a class=monospace href=/tx/acda637db995df796b35035fd978cc1a947f1e6fd5215968da88b7e38a7e4b37>acda637db995df796b35035fd978cc1a947f1e6fd5215968da88b7e38a7e4b37</a></dd>
  <dt>location</dt>
  <dd class=monospace>6630ff2153985504b180fc16721d559a4cecdc66f4be6acf33509ec2100c0aa5:0:0</dd>
  <dt>output</dt>
  <dd><a class=monospace href=/output/6630ff2153985504b180fc16721d559a4cecdc66f4be6acf33509ec2100c0aa5:0>6630ff2153985504b180fc16721d559a4cecdc66f4be6acf33509ec2100c0aa5:0</a></dd>
  <dt>offset</dt>
  <dd>0</dd>
</dl>

  </main>
  </body>
</html>
HTML


def parse_page( html )
  doc = Nokogiri::HTML( html )

  items = []

  title = doc.css( 'head title' )
  items << ['title', title.text]


  dls = doc.css( 'body dl' )
  dls[0].css( 'dt,dd' ).each do |el|
     if el.name == 'dt'
          items << [el.text]
     elsif el.name == 'dd'
          items[-1] << el.text
     else
       puts "!! ERROR - unexpected tag; expected dd|dl; got: #{el.name}"
       exit 1
     end
  end
  items

  ## convert to hash
  ##   and check for duplicate
  data = {}
  items.each do |k,v|
      k = k.strip
      v = v.strip
      if data.has_key?( k )
         puts "!! ERROR - duplicate key >#{k}< in:"
         pp items
         exit 1
      end
      data[ k ] = v
  end
  data
end


data =  parse_page( html )

## pp data

puts JSON.pretty_generate( data )


puts "bye"