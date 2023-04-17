#############################
# to run use:
#
#  $ ruby sandbox/download.rb

$LOAD_PATH.unshift( "./lib" )
require 'ordinals'



def download( recs )
  recs.each_with_index do |rec, i|
    id   = rec['id']

    chain = Ordinals.config.chain
    path = "../../ordinals.cache/#{chain}/#{id}.json"
    next if File.exist?( path )

    puts "==> downloading #{chain} inscription meta #{i} w/ id #{id}..."

    data = Ordinals.client.inscription( id )

    puts "   title:          #{data['title']}"
    puts "   content length: #{data['content length']}"
    puts "   content type:   #{data['content type']}"
    puts "   timestamp:      #{data['timestamp']}"

    write_json( path, data )

    sleep( 1.0 )  ## sleep (delay_in_s)
  end
end


Ordinals.config.chain = :ltc     # :doge

recs = read_csv( "./tmp/ordinals.#{Ordinals.config.chain}.csv" )
puts "  #{recs.size} record(s)"

download( recs )


puts "bye"