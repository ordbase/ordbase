#####
#  query ordsub1k.db  (sqlite database with first thousand ordinal inscriptions)

$LOAD_PATH.unshift( "../ordlite/lib" )
require 'ordlite'


OrdDb.open( './ordsub1k.db' )


## get snake game (no. 142) in "The Basics" series - 
## a basic html & js game collection (no. 1147)
##
## how-to play - length of the snake grows when eating an apple
inscribe = Inscribe.find_by( num: 142 )
write_text( "../docs/snake.html", inscribe.text )

## get tetris game (no. 145) in "The Basics" series - 
inscribe = Inscribe.find_by( num: 145 )
write_text( "../docs/tetris.html", inscribe.text )



puts "bye"