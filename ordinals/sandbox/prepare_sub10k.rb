#################################
# to run use:
#
#  $ ruby sandbox/prepare_sub10k.rb

$LOAD_PATH.unshift( "./lib" )
require 'ordinals'


chains = ['btc', 'ltc']
chains.each do |chain|
    Ordinals.chain = chain
    ids = Ordinals.sub10k_ids
    
    ##
    ## save as .csv tabular dataset
    buf = "id\n"
    ids.each { |id| buf << "#{id}\n" }
    
    write_text( "./tmp/sub10k_inscriptions.#{chain}.csv", buf )
end

puts "bye"
