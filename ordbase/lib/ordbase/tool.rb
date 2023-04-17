module Ordinals
class Tool

  def self.main( args=ARGV )
    puts "==> welcome to the ordbase tool with args:"
    pp args

    options = {
              }

    parser = OptionParser.new do |opts|
      opts.on( "--doge", "--dogecoin", "Use Dogecoin / DOGE") do
        ## switch to doge
        Ordinals.config.chain = :doge
      end
      opts.on( "--ltc", "--litecoin", "Use Litecoin / LTC") do
          ## switch to ltc
          Ordinals.config.chain = :ltc
      end
      opts.on( "--btc", "--bitcoin", "Use Bitcoin / BTC") do
          ## switch to btc  (default)
          Ordinals.config.chain = :btc
      end

      opts.on("--limit NUM", Integer,
             "Limit collection (default: ∞)") do |num|
         options[ :limit]  = num
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    parser.parse!( args )
    puts "options:"
    pp options

    puts "args:"
    pp args

    if args.size < 1
      puts "!! ERROR - no collection found - use <collection> <command>..."
      puts ""
      exit
    end

    slug             = args[0]
    command          = args[1] || 'image'

    if ['m', 'meta'].include?( command )
      do_download_meta( slug )
    elsif ['stat', 'stats'].include?( command )
      do_dump_stats( slug )
    elsif ['i','img', 'image'].include?( command )
      do_download_images( slug )
    elsif ['conv','convert'].include?( command )
      do_convert_images( slug )
    elsif ['fix'].include?( command )
      do_fix_images( slug )
    elsif ['px','pix', 'pixelate' ].include?( command )
      do_pixelate( slug )
    elsif ['comp','composite' ].include?( command )
      if options.has_key?( :limit )
        do_make_composite( slug, limit: options[:limit] )
      else
        do_make_composite( slug )
      end
    else
      puts "!! ERROR - unknown command >#{command}<, sorry"
    end

    puts "bye"
  end


  def self.do_dump_stats( slug )
    puts "==> dump inscription stats for collection >#{slug}<..."

    col = Collection.new( slug )
    col.dump_stats
  end

  def self.do_download_meta( slug )
    puts "==> download meta for collection >#{slug}<..."

    col = Collection.new( slug )
    col.download_meta
  end

  def self.do_download_images( slug )
    puts "==> download images for collection >#{slug}<..."

    col = Collection.new( slug )
    col.download_images
  end


  def self.do_convert_images( slug )
    puts "==> convert images for collection >#{slug}<..."

    col = Collection.new( slug )
    col.convert_images
  end

  def self.do_fix_images( slug )
    puts "==> fix images for collection >#{slug}<..."

    col = Collection.new( slug )
    col.fix_images
  end


  def self.do_pixelate( slug )
    puts "==> downsample / pixelate images for collection >#{slug}<..."

    col = Collection.new( slug )
    col.pixelate
  end

  def self.do_make_composite( slug, limit: nil )
    puts "==> make composite for collection >#{slug}<..."

    col = Collection.new( slug )
    col.make_composite( limit: limit )
  end

end  # class Tool
end   # module Ordinals
