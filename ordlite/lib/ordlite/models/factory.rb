
module OrdDb
    module Model
  
  class Factory < ActiveRecord::Base
    self.table_name = 'factories' ## non-standard plural (factory/factories)

    belongs_to :inscribe
    
    has_many :inscriberefs, -> { order('pos') }  ## join table (use habtm - why? why not?)
    has_many :layers, :through => :inscriberefs,  
                      :source => :inscribe  

    has_many :generatives
    has_many :inscribes, :through => :generatives                    
  end  # class Factory
  
    end # module Model
end # module OrdDb
  