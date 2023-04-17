

module Ordinals


class Api   ## change/rename Api to Client - why? why not?
  def self.litecoin
    ## @litecoin ||= new( 'https://litecoin.earlyordies.com' )
    @litecoin ||= new( 'https://ordinalslite.com' )
    @litecoin
  end

  def self.bitcoin
    @bitcoin ||= new( 'https://ordinals.com' )
    @bitcoin
  end
  ## todo:  add ltc and btc alias - why? why not?

  def self.dogecoin
    ## note: "doginals" call inscriptions
    ##                     shibescriptions
    @dogecoin ||= new( 'https://doginals.com', inscription: 'shibescription' )
    @dogecoin
  end


  def initialize( base, inscription: 'inscription' )
    @base        = base
    @inscription = inscription
  end


###
# use a struct-like content class - why? why not?
class Content
  attr_reader :data,
              :type,
              :length
  def initialize( data, type, length )
    @data   = data
    @type   = type
    @length = length
  end

  alias_method :blob, :data
end  ## (nested) class Content



  def content( id )
     src = "#{@base}/content/#{id}"
     res = get( src )

     content_type   = res.content_type
     content_length = res.content_length

     ## note - content_length -- returns an integer (number)
     ## puts "content_length:"
     ## print content_length.inspect
     ## print " - #{content_length.class.name}\n"

     content = Content.new(
                    res.blob,
                    content_type,
                    content_length )
     content
  end


=begin
<dl>
  <dt>id</dt>
  <dd class=monospace>d026ac5994f698dba475681359b6c29d6d39a895484b95e06b7ae49921d80df2i0</dd>
  <dt>address</dt>
  <dd class=monospace>bc1pqapcyswesvccgqsmuncd96ylghs9juthqeshdr8smmh9w7azn8zsghjjar</dd>
  <dt>output value</dt>
  <dd>10000</dd>
  <dt>sat</dt>
  <dd><a href=/sat/1320953397332258>1320953397332258</a></dd>
  <dt>preview</dt>
  <dd><a href=/preview/d026ac5994f698dba475681359b6c29d6d39a895484b95e06b7ae49921d80df2i0>link</a></dd>
  <dt>content</dt>
  <dd><a href=/content/d026ac5994f698dba475681359b6c29d6d39a895484b95e06b7ae49921d80df2i0>link</a></dd>
  <dt>content length</dt>
  <dd>71997 bytes</dd>
  <dt>content type</dt>
  <dd>text/plain;charset=utf-8</dd>
  <dt>timestamp</dt>
  <dd><time>2023-02-11 21:39:00 UTC</time></dd>
  <dt>genesis height</dt>
  <dd><a href=/block/776090>776090</a></dd>
  <dt>genesis fee</dt>
  <dd>273630</dd>
  <dt>genesis transaction</dt>
  <dd><a class=monospace href=/tx/d026ac5994f698dba475681359b6c29d6d39a895484b95e06b7ae49921d80df2>d026ac5994f698dba475681359b6c29d6d39a895484b95e06b7ae49921d80df2</a></dd>
  <dt>location</dt>
  <dd class=monospace>d026ac5994f698dba475681359b6c29d6d39a895484b95e06b7ae49921d80df2:0:0</dd>
  <dt>output</dt>
  <dd><a class=monospace href=/output/d026ac5994f698dba475681359b6c29d6d39a895484b95e06b7ae49921d80df2:0>d026ac5994f698dba475681359b6c29d6d39a895484b95e06b7ae49921d80df2:0</a></dd>
  <dt>offset</dt>
  <dd>0</dd>
</dl>

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



<title>Inscription 407</title>

id =
 genesis transaction + offset ???

genesis transaction: acda637db995df796b35035fd978cc1a947f1e6fd5215968da88b7e38a7e4b37
id:                  acda637db995df796b35035fd978cc1a947f1e6fd5215968da88b7e38a7e4b37i0
address:      bc1qx3scwushtwenxtxlnjet4x2w5vg35etdtse5u0
output value: 8020
sat:          1883186433806857
content length: 529 bytes
content type:  image/png
timestamp: 2023-01-31 19:34:47 UTC
genesis height: 774489
genesis fee:  5340
genesis transaction: acda637db995df796b35035fd978cc1a947f1e6fd5215968da88b7e38a7e4b37>acda637db995df796b35035fd978cc1a947f1e6fd5215968da88b7e38a7e4b37
location: 6630ff2153985504b180fc16721d559a4cecdc66f4be6acf33509ec2100c0aa5:0:0
output:   6630ff2153985504b180fc16721d559a4cecdc66f4be6acf33509ec2100c0aa5:0
offset: 0

=end

  def inscription( id )
    src = "#{@base}/#{@inscription}/#{id}"
    res = get( src )

    data = _parse_inscription( res.text )
    data
  end


  def _parse_inscription( html )
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


  def get( src )
    res = Webclient.get( src )
    if res.status.ok?
      res
    else
      puts "!! ERROR - HTTP #{res.status.code} #{res.status.message} - failed web request >#{src}<; sorry"
      exit 1
    end
  end
end  # class Api

##
##  add convenience alias
API = Api

end   ## module Ordinals

