
require 'cocos'


require_relative 'satsnames/version'


module Sats

class Record
  def self.directory()  Sats.directory; end

  def self.find( id )  directory.find_record( id ); end
  def self.find_by( name: ) directory.find_record_by( name: name ); end


  def self.parse( row )
     id = row['id']
     name   = row['name']

     new( id:      id,
          name:    name )
  end

  attr_reader :id, :name

  def initialize( id:,
                  name: )
     @id    = id
     @name  = name
  end
end  # class Record



class Directory
     ## let's you lookup up ethereum addresses by name
     def self.read( *paths )    ## use load - why? why not?
        dir = new
        paths.each do |path|
          rows= read_csv( path )
          dir.add_rows( rows )
        end
        dir
     end

     def initialize
       @recs          = {}   ## lookup (record) by (normalized) id
       @reverse_table = {}   ## lookup (id) by (normalized) name
     end


     def records() @recs.values; end
     def size() @recs.size; end

     def find_record( id )
       @recs[ id ]
     end

     def find_record_by( name: )
       @reverse_table[ name ]
     end


     def []( name )
        rec = find_record_by( name: name )
        rec ? rec.id : nil
     end


     def add_rows( rows )
      rows.each do |row|
        rec = Record.parse( row )
   
        ## todo/check for duplicates
        @reverse_table[ rec.name ] = rec
        @recs[rec.id] = rec
      end
    end
end  # class Directory



def self.dir
    @dir ||= Directory.read( "#{root}/config/relays.2023.csv"
                           )
 end
 class << self
    alias_method :directory, :dir
 end
 
 def self.[]( q )
   dir[ q ]
 end
end  # module Sats



puts Sats.banner  # say hello