require 'cocos'

offsets = [99,199,299,399,499,599,699,799,899,999]


INSCRIBE_ID_RX = %r{
                  inscription/(?<id>[a-fi0-9]+)
                 }ix

ids = []

offsets.each_with_index do |offset,i|
    url = "https://ordinals.com/inscriptions/#{offset}"
    puts "==> #{i+1}/#{offsets.size} - #{url}..."

    recs = []
    res = Webclient.get( url )
    if res.status.ok?
        page = res.text  ### assumes utf-8 for now
        page.scan( INSCRIBE_ID_RX ) do |_|
            m = Regexp.last_match
            recs << m[:id]
        end       
    else
        puts "!! ERROR: #{res.status.code} #{res.status.message}"
        exit 1
    end

    puts "   #{recs.size} inscribe id(s)"
    recs = recs.reverse  ## assume latest inscribe id is on top (reverse)
    ids += recs
    puts "   #{ids.size} inscribe id(s) - total"

    sleep( 2 )  ## sleep in 2 secs
end


puts
puts "   #{ids.size} inscribe id(s)"

##
## save as .csv tabular dataset
buf = "id\n"
ids.each { |id| buf << "#{id}\n" }

write_text( "./tmp/sub1k_inscriptions.csv", buf )


puts "bye"