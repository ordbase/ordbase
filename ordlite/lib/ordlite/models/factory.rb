
module OrdDb
    module Model
  
  class Factory < ActiveRecord::Base
    self.table_name = 'factories' ## non-standard plural (factory/factories)

    belongs_to :inscribe
    
    has_many :inscriberefs  ## join table (use habtm - why? why not?)
    ##  -> { order('pos') }
    ##   note: default_scope (order)
    ##      will break all count queries and more
    ##      thus - no "magic" - always sort if pos order required!!!
   
    has_many :layers, :through => :inscriberefs,  
                      :source => :inscribe  

    has_many :generatives
    has_many :inscribes, :through => :generatives                    
  end  # class Factory
  
    end # module Model
end # module OrdDb
  