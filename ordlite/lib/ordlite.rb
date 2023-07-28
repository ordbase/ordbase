
require_relative 'ordlite/base'





## add convenience helpers
##  use require 'ordlite/base' if you do NOT want automagic aliases


Inscribe   = OrdDb::Model::Inscribe
Blob       = OrdDb::Model::Blob
Collection = OrdDb::Model::Collection
Factory    = OrdDb::Model::Factory
Generative = OrdDb::Model::Generative


require 'active_support/number_helper'
include ActiveSupport::NumberHelper   ## e.g. number_to_human_size


