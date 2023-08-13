### download biixel ordinals metadata & content
###   into cache; to run use:
##
##   $ ruby sandbox/download.rb


require 'ordinals'


cache = Ordinals::Cache.new( './tmp/inscription' )
cache.add_csv( './biixel.csv' )


puts "bye"