####
# to run use:
#   $ ruby -I ./lib sandbox/test_search.rb

require 'ordlite'


OrdDb.connect( adapter:  'sqlite3',
               database: './ord.db' )



puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"


## text/plain or application/json or ??
inscribes = Inscribe.text
puts "  #{inscribes.size} text inscribe(s)"

## images
inscribes = Inscribe.png
puts "  #{inscribes.size} png inscribe(s)"

inscribes = Inscribe.gif
puts "  #{inscribes.size} text inscribe(s)"

inscribes = Inscribe.jpg
puts "  #{inscribes.size} jpg/jpeg inscribe(s)"

inscribes = Inscribe.jpeg
puts "  #{inscribes.size} jpg/jpeg inscribe(s)"

inscribes = Inscribe.webp
puts "  #{inscribes.size} webp inscribe(s)"

inscribes = Inscribe.svg
puts "  #{inscribes.size} svg inscribe(s)"


inscribes = Inscribe.image
puts "  #{inscribes.size} image inscribe(s)"

inscribes = Inscribe.html
puts "  #{inscribes.size} html inscribe(s)"

inscribes = Inscribe.js
puts "  #{inscribes.size} js inscribe(s)"


inscribes = Inscribe.search( 'diypunks')
puts "  #{inscribes.size} diypunks inscribe(s)"

inscribes = Inscribe.search( 'mint')
puts "  #{inscribes.size} mint inscribe(s)"

inscribes = Inscribe.search( 'deploy')
puts "  #{inscribes.size} deploy inscribe(s)"




puts "bye"