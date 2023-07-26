
module OrdDb
    module Model
  
  class Blob < ActiveRecord::Base
    belongs_to :inscribe, foreign_key: 'id'

    def text
       content.force_encoding(Encoding::UTF_8)
    end
  end  # class Blob
  
    end # module Model
end # module OrdDb
  