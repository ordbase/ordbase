# Bixel  - Bitcoin Ordinal Inscription Pixel (Image) Protocol


## V1 / Chapter 1 / OG   - 7x7 canvas / 10 colors

- 7x7 canvas (=49 pixels)
- 10 colors (0-9)
  - 0 => #434a41 
  - 1 => #689579 
  - 2 => #cdd995 
  - 3 => #e7debf 
  - 4 => #e5cc7c 
  - 5 => #f1b31f 
  - 6 => #e99248 
  - 7 => #da4c27 
  - 8 => #dac8c6 
  - 9 => #547d8e
  

Example - .bixel (at inscribe no. 21964036)

```
3113113111111311303011111111117777711111131111333.bixel 
```


Let's use the pixelart machinery to generate the (bitmap) image 
from the paint by number spec.


``` ruby
require 'pixelart'

## step 1 - define the paint by number color mapping
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

## step 2 - generate the bitmap image / parse the spec
img = Image.parse( '3113113111111311303011111111117777711111131111333'
                   colors: COLORS,
                   width: 7, 
                   height: 7 ) 
img.save( "./bixel1.png" )
img.zoom(8).save( "./bixel1@8x.png" )
```

Voila!

![](i/bixel1.png)

in 8x

![](i/bixel1@8x.png)


Bonus:  Let's define a ready-to-use Bixel Image class.

```ruby
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
  class Image < Pixelart::Image
     def self.parse( pixels )
        super( pixels, colors: COLORS, 
                       width: 7,
                       height: 7)
     end
  end # class Image
end # module Bixel
```


and let's retry:

``` ruby
img = Bixel::Image.parse( '3113113111111311303011111111117777711111131111333' ) 
img.save( "./bixel1.png" )
img.zoom(8).save( "./bixel1@8x.png" )
```

Voila!

![](i/bixel1.png)

in 8x

![](i/bixel1@8x.png)





To be continued...





## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.



## Questions? Comments?

Join us in the [Ordgen / ORC-721 discord (chat server)](https://discord.gg/dDhvHKjm2t). Yes you can.
Your questions and commetary welcome.


Or post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.
