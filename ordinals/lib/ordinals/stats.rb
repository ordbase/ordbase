

class InscriptionStats

  TITLE_RX = /^(Inscription|Shibescription)[ ]+(?<ord>[0-9]+)$/
  BYTES_RX = /^(?<bytes>[0-9]+)[ ]+bytes$/

  def initialize
    @stats = {
      count: 0,
      ord: { '<100'   => 0,
             '<1000'  => 0,
             '<10000' => 0,
             '<100000' => 0,
             '<1000000' => 0,
             'min' => nil,
             'max' => nil, },
      type: Hash.new(0),
      bytes:  {  '<100'  => 0,
                 '<1000' => 0,
                 '<10000' => 0,
                 '<100000' => 0,
                 '<1000000' => 0,
                 'min' => nil,
                 'max' => nil, },
    }

    @days = Hash.new(0)
  end

  def size()  @stats[:count]; end



  def update( data )
    data = JSON.parse( data)   if data.is_a?( String )

    @stats[ :count ] += 1


    ord = nil
    if m=TITLE_RX.match( data['title'] )
        ord = m[:ord].to_i(10)
    else
        puts "!! ERROR - cannot find ord in inscription title; sorry"
        pp data
        exit 1
    end

    if     ord < 100     then  @stats[:ord]['<100'] += 1
    elsif  ord < 1000    then  @stats[:ord]['<1000'] += 1
    elsif  ord < 10000   then  @stats[:ord]['<10000'] += 1
    elsif  ord < 100000  then  @stats[:ord]['<100000'] += 1
    elsif  ord < 1000000 then  @stats[:ord]['<1000000'] += 1
    else
      puts "!! ERROR ord out-of-bounds"
      exit 1
    end

    ## update min/max
    @stats[:ord]['min'] = ord   if ord < (@stats[:ord]['min'] || 9999999)
    @stats[:ord]['max'] = ord   if ord > (@stats[:ord]['max'] || -1)


    bytes = nil
    if m=BYTES_RX.match( data['content length'] )
        bytes = m[:bytes].to_i(10)
    else
        puts "!! ERROR - cannot find bytes in inscription content length; sorry"
        pp data
        exit 1
    end

    if     bytes < 100     then  @stats[:bytes]['<100'] += 1
    elsif  bytes < 1000    then  @stats[:bytes]['<1000'] += 1
    elsif  bytes < 10000   then  @stats[:bytes]['<10000'] += 1
    elsif  bytes < 100000  then  @stats[:bytes]['<100000'] += 1
    elsif  bytes < 1000000 then  @stats[:bytes]['<1000000'] += 1
    else
      puts "!! ERROR bytes (content-length) out-of-bounds"
      exit 1
    end

    ## update min/max
    @stats[:bytes]['min'] = bytes   if bytes < (@stats[:bytes]['min'] || 9999999)
    @stats[:bytes]['max'] = bytes   if bytes > (@stats[:bytes]['max'] || -1)


    type = data['content type']

    @stats[:type][ type ] += 1

    ## "timestamp"=>"2023-02-05 01:45:22 UTC",
    ts = Time.strptime( data['timestamp'], '%Y-%m-%d %H:%M:%S' )

    @days[ ts.strftime('%Y-%m-%d') ] +=1
  end  # method update


  def data   ## rename to model or such - why? why not?
     ## sort days
     days = @days.sort {|l,r|  l[0] <=> r[0] }
     ## add to stats
     @stats[:days] = {}
     days.each {|k,v| @stats[:days][k] = v }
     @stats
  end

=begin
{:count=>101,
 :ord=>{"<1000"=>0, "<10000"=>0, "<100000"=>101, "<1000000"=>0, "min"=>14343, "max"=>42901},
 :type=>{"image/png"=>101},
 :bytes=>{"<100"=>0, "<1000"=>101, "<10000"=>0, "<100000"=>0, "<1000000"=>0, "min"=>274, "max"=>512},
 :days=>{"2023-02-22"=>10, "2023-02-25"=>17, "2023-02-26"=>74}}
=end

  def format   ## rename to pretty_print or such - why? why not?
     stat = data

     buf = String.new('')
     buf << "#{stat[:count]} inscription(s)\n"

     buf << "- from ##{stat[:ord]['min']} to ##{stat[:ord]['max']} (min. to max.)\n"
     buf << "     - <100 => #{stat[:ord]['<100']}\n"          if stat[:ord]["<100"] > 0
     buf << "     - <1000 => #{stat[:ord]['<1000']}\n"        if stat[:ord]["<1000"] > 0
     buf << "     - <10000 => #{stat[:ord]['<10000']}\n"      if stat[:ord]["<10000"] > 0
     buf << "     - <100000 => #{stat[:ord]['<100000']}\n"    if stat[:ord]["<100000"] > 0
     buf << "     - <1000000 => #{stat[:ord]['<1000000']}\n"  if stat[:ord]["<1000000"] > 0

     buf << "- format(s)\n"
     stat[:type].each do |k,v|
        buf << "     - #{k} => #{v}\n"
     end

     buf << "- day(s)\n"
     stat[:days].each do |k,v|
       buf << "     - #{k} => #{v}\n"
     end

     buf
  end

end  ## class InscriptionStats


