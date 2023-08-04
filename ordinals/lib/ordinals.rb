require 'cocos'

## note: add nokogiri for api (html parsing)
require 'nokogiri'



### todo/fix:
###   move upstream  - read_headers

##
#  note: key only supports a-z0-9 AND dash(-)
#    no underscore(_) or dot(.)
#
#  follow HTTP headers and domain names format
##

HEADER_RX = /\A(?<key>[a-z][a-z0-9-]*)
                 :
                 [ ]*
               (?<value>.+?)    ## non-greedy
              \z
             /x


def read_headers( path )
  txt = read_text( path )
  h = {}
  txt.each_line do |line|
    line = line.strip
    ## skip empty and comment lines
    next if line.empty? || line.start_with?( '#' )

    if m=HEADER_RX.match(line)
      key   = m[:key]
      value = m[:value]
      
      h[key] = value
   else 
      puts "!! ERROR - parse error - no header pattern match for:"
      puts line
      exit 1
   end
  end
  h
end





module Ordinals
  class Configuration

    #######################
    ## accessors
    def chain=(value)
        if value.is_a?( String ) || value.is_a?( Symbol )
            case value.downcase.to_s
            when 'btc', 'bitcoin', 'bitcon'
               @chain  = 'btc'
               @client = Ordinals::Api.bitcoin
            when 'ltc', 'litecoin', 'litecon'
               @chain = 'ltc'
               @client = Ordinals::Api.litecoin
            when 'doge', 'dogecoin', 'dogecon'
               @chain = 'doge'
               @client = Ordinals::Api.dogecoin
            else
              raise ArgumentError, "unknown chain - expected btc | ltc | doge; got #{value}"
            end
        else
            raise ArgumentError, "only string or symbol supported for now; sorry - got: #{value.inspect} : #{value.class.name}"
        end
    end

    def chain
      ## note - default to btc/bitcon if not set
      self.chain = 'btc'   unless defined?( @chain )
      @chain
    end

    ## note: read-only for now - why? why not?
    def client
      ## note - default to btc/bitcon if not set
      self.chain = 'btc'   unless defined?( @client )
      @client
    end

    def delay_in_s 
      ## note - default to 1 (sec) if not set
      self.delay_in_s = 1   unless defined?( @delay_in_s )
      @delay_in_s
    end  
    def delay_in_s=(value) @delay_in_s = value; end
    alias_method :sleep,  :delay_in_s   ## add sleep alias (or wait) - why? why not?
    alias_method :sleep=, :delay_in_s=
  end # class Configuration


  ## lets you use
  ##   Ordinals.configure do |config|
  ##      config.chain = :btc
  ##   end
  def self.configure() yield( config ); end
  def self.config()    @config ||= Configuration.new;  end

  ##  add some convenience shortcut helpers (no config. required) - why? why not?
  def self.client()      config.client; end
  def self.chain()       config.chain; end
  def self.chain=(value) config.chain = value; end


  def self.btc?()     config.chain == 'btc'; end
  def self.ltc?()     config.chain == 'ltc'; end
  def self.doge?()    config.chain == 'doge'; end
  class << self
    alias_method :bitcoin?, :btc?
    alias_method :bitcon?,  :btc?

    alias_method :litecoin?, :ltc?
    alias_method :litecon?,  :ltc?

    alias_method :dogecoin?, :doge?
    alias_method :dogecon?,  :doge?
  end


  ###################
  ### more convenience shortcuts
  def self.inscription( num_or_id )             client.inscription( num_or_id ); end
  def self.content( num_or_id )                 client.content( num_or_id );     end

  def self.inscription_ids( offset: )    client.inscription_ids( offset: offset ); end
  def self.sub10k_ids()                  client.sub10k_ids; end
end  # module Ordinals




## our own code
require_relative 'ordinals/version'
require_relative 'ordinals/api'

require_relative 'ordinals/cache'
require_relative 'ordinals/sandbox'   ## (blob) "flat" content cache by inscribe id (./content)
require_relative 'ordinals/stats'


### add recursive image helpers
require_relative 'ordinals/recursive/image'
require_relative 'ordinals/recursive/composite'
require_relative 'ordinals/recursive/generator'


## add conveniecen shortcuts/alias - why? why not?
RcsvImage          = RecursiveImage
RcsvImageComposite = RecursiveImageComposite



# say hello
puts Ordinals.banner     ## if defined?($RUBYCOCOS_DEBUG) && $RUBCOCOS_DEBUG
