

module Bixel
  # 7x7 canvas (49 pixels)
  #   10 colors (0-9)
  COLORS = {
        '0': '#434a41', 
        '1': '#689579', 
        '2': '#cdd995', 
        '3': '#e7debf', 
        '4': '#e5cc7c', 
        '5': '#f1b31f', 
        '6': '#e99248', 
        '7': '#da4c27', 
        '8': '#dac8c6', 
        '9': '#547d8e'
  } 
  WIDTH  = 7
  HEIGHT = 7         

  MATCH_RX = /\A
              (?<spec>[0-9]{49})
               \.bixel
              \z
              /x
   def self.match( txt )  MATCH_RX.match( txt.strip ); end
   def self.valid?( txt ) match ? true : false; end


  class Image < Pixelart::Image
    def self.parse( pixels )
      super( pixels, colors: COLORS, 
                     width: WIDTH,
                     height: HEIGHT)
    end
  end # class Image
end # module Bixel




module Biixel
  # 10x10 canvas (100 pixels)
  #   21 colors (A-U)

COLORS = {
  A: '#88b2c4',
  B: '#547d8e',
  C: '#dac8c6', 
  D: '#7c7587',
  E: '#e3a18d', 
  F: '#da4c27',
  G: '#f1b31f',
  H: '#e99248',
  I: '#87c687', 
  J: '#529055',
  K: '#a08454', 
  L: '#966946',
  M: '#e7debf', 
  N: '#afa78a',
  O: '#d2fae0', 
  P: '#f7e382',
  Q: '#9aaf89', 
  R: '#e5cc7c',
  S: '#fff',
  T: '#d7e5e5',
  U: '#000'
}
  WIDTH  = 10
  HEIGHT = 10

  
  MATCH_RX = /\A
              (?<spec>[A-U]{100})
               \.biixel
              \z
              /x
   def self.match( txt )  MATCH_RX.match( txt.strip ); end
   def self.valid?( txt ) match ? true : false; end


  class Image < Pixelart::Image
    def self.parse( pixels )
      super( pixels, colors: COLORS, 
                     width:  WIDTH,
                     height: HEIGHT)
    end
  end # class Image
end  # module Biixel

