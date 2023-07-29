module OrdDb
    module Model
  
  class Collection < ActiveRecord::Base    
    has_many :items   
    ##  -> { order('pos') }
    ##   note: default_scope (order)
    ##      will break all count queries and more
    ##      thus - no "magic" - always sort if pos order required!!!
    has_many :inscribes, :through => :items                    
  end  # class Collection
  
    end # module Model
end # module OrdDb
