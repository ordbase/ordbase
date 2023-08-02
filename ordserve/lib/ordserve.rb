
## pull-in web service support
require 'sinatra/base'    ## note: using the "modular" style
require 'webrick'

## more 3rd party gems
require 'ordinals'   ## incl. cocos


## our own code
require_relative 'ordserve/version'    # note: let version always go first
require_relative 'ordserve/service'



class Ordserve     ## note: Ordserve is Sinatra::Base
  def self.main( argv=ARGV )
     puts 'hello from main with args:'
     pp argv

     path = argv[0] || './content'

     puts "  using content_folder: >#{path}<"

     ## note: let's you use  latter settings.content_folder (resulting in path)
     set( :content_folder, File.expand_path(path))

  #####
  # fix/todo:
  ##   use differnt port ??
  ##
  ##  use --local  for host e.g. 127.0.0.1  insteaod of 0.0.0.0 ???

 #   puts 'before Puma.run app'
 #   require 'rack/handler/puma'
 #   Rack::Handler::Puma.run ProfilepicService, :Port => 3000, :Host => '0.0.0.0'
 #   puts 'after Puma.run app'

 # use webrick for now - why? why not?
     puts 'before WEBrick.run service'
     Rack::Handler::WEBrick.run Ordserve, :Port => 3000, :Host => '127.0.0.1'
     puts 'after WEBrick.run service'

    puts 'bye'
  end
end


####
# convenience aliases / shortcuts / alternate spellings
#    add OrdService / Ordservice too - why? why not?
OrdServe        = Ordserve
OrdServer       = Ordserve
Ordserver       = Ordserve


puts Ordinals::Module::Ordserve.banner    # say hello
