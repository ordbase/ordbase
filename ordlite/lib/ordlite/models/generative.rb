
module OrdDb
    module Model
  
  class Generative < ActiveRecord::Base
    belongs_to :inscribe, foreign_key: 'id'
    belongs_to :factory
  end  # class Generative
  
    end # module Model
end # module OrdDb
  