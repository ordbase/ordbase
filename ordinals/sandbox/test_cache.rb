$LOAD_PATH.unshift( "./lib" )
require 'ordinals'



## calculate some statis

base_dir = "../../ordinals.cache"

# chain = 'btc'
chain = 'ltc'
# chain = 'doge'
datasets = Dir.glob( "#{base_dir}/#{chain}/*.json" )

puts "  #{datasets.size} inscription(s)"


stats = InscriptionStats.new

datasets.each do |path|
  data = read_json( path )

  stats.update( data )
end

pp stats.data

puts "  bye"
