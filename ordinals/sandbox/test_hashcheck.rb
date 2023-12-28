#################################
# to run use:
#
#  $ ruby sandbox/test_hashcheck.rb

$LOAD_PATH.unshift( "./lib" )
require 'ordinals'


# monkes21 no. 0
hash = 'e7e1525e710c8eb81ab0faf35fe2d271e2659317d5789acf899d062b62795c17'    

data = Ordinalsbot.hashcheck( hash )
pp data




puts "bye"

__END__

