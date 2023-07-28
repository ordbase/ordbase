module OrdDb
    module Model
  
  class Collection < ActiveRecord::Base    
    has_many :items, -> { order('pos') }
    has_many :inscribes, :through => :items                    
  end  # class Collection
  
    end # module Model
end # module OrdDb
