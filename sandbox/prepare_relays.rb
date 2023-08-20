require 'ordlite'
require 'rb_json5'   ## add json5 support (see https://github.com/taichi-ishitani/rb_json5)

OrdDb.open( './ordbase.db' )

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"

inscribes = Inscribe.search( 'relay' )
puts "  #{inscribes.size} relay inscribe candidate(s)"
#=> 1 relay inscribe candidate(s)

module Sats
  def self.parse_relay( txt )
       errors = []
       ###  1) check for valid json
       h = nil
       begin
         ## h = JSON.parse( txt )
         h = RbJSON5.parse( txt )
         ## puts "   OK - json parse"
       ## rescue JSON::ParserError => ex
       rescue RbJSON5::ParseError => ex
         msg = "json parse -- #{ex.message}"
         errors << msg
       end

       if h
         ['p','op','name','relay'].each do |key|
            if h.has_key?( key )
               ## continue
            else
               msg = "protocol format -- required key '#{key}' not found in inscribe text"
               errors << msg
               ## puts "   !! ERROR - #{msg}"
            end
         end    
       end

       ## 3) check for protocol values
      if errors.size == 0
        value = h['p']
        if value != 'sns'
          msg = "protocol format -- expected value 'sns' for key 'p'; got '#{value}'"
          errors << msg
        end
      end

      if errors.size == 0
        value = h['op']
        if value != 'reg'
          msg = "protocol format -- expected value 'reg' for key 'op'; got '#{value}'"
          errors << msg
        end
      end

      name_rx = /[0-9a-zA-Z₿$]+\.[a-z]+/
      if errors.size == 0
        value = h['name']
        if name_rx.match( value ).nil?
          msg = "protocol format -- expected value to match pattern for key 'name'; got '#{value}'"
          puts msg
          errors << msg
        end
      end


      if errors.size > 0
         puts "==> #{errors.size} error(s):"
         errors.each_with_index do |error,i|
            puts "   #{i+1}: #{error}"
         end
         puts
         puts txt
      end

      ## note: return nil if errors
      errors.size > 0 ? nil : h
  end
end  # module Sats 


relays = []

inscribes.each do |inscribe|
  data = Sats.parse_relay( inscribe.text )
  if data
    relays << data
  else
    ## error
  end
end


puts "  #{relays.size} relay(s)"

##
## prepare stats
stat = {}
relays.each do |h|
   subdomain, domain = h['name'].split( '.' )
   item = stat[ domain ] ||= []
   item << subdomain 
end
pp stat


### export

recs = relays.reduce([]) {|recs,h| recs << [h['name'],h['relay']]; recs }
pp recs

puts "bye"


buf = ''
buf << "name, id\n"
recs.each do |values|
    buf << values.join( ', ' )
    buf << "\n"
end

write_text( './tmp/relays.csv', buf )


__END__

"js"=>["jquery"],
 "land"=>["1", "2"],
 "bts"=>["hello"],
 "movies"=>["watch"],
 "game"=>["snake", "dogepunks", "breakout", "2048"],
 "paper"=>["cypherpunk", "bitcoin"],
 "joelle"=>["flieka"],
 "com"=>["lasvegas"]}