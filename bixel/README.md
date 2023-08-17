# Bixel  - Bitcoin Ordinal Inscription Pixel (Image) Protocol


## V1 / Chapter 1 / OG   - 7x7 canvas / 10 colors

- 7x7 canvas (=49 pixels)
- 10 colors (0-9)
  - ![](i/color0.png) 0 => #434a41
  - ![](i/color1.png) 1 => #689579
  - ![](i/color2.png) 2 => #cdd995
  - ![](i/color3.png) 3 => #e7debf 
  - ![](i/color4.png) 4 => #e5cc7c
  - ![](i/color5.png) 5 => #f1b31f
  - ![](i/color6.png) 6 => #e99248
  - ![](i/color7.png) 7 => #da4c27
  - ![](i/color8.png) 8 => #dac8c6
  - ![](i/color9.png) 9 => #547d8e
  

Example - .bixel no. 10 (at inscribe no. 21964036)

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
img.save( "./bixel10.png" )
img.zoom(8).save( "./bixel10@8x.png" )
```

Voila!

![](i/bixel10.png)

in 8x

![](i/bixel10@8x.png)


Bonus:  Let's define a ready-to-use Bixel Image class.

```ruby
module Bixel
  # 7x7 canvas (49 pixels) -  10 colors (0-9)
  WIDTH  = 7
  HEIGHT = 7      
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
                       width:  WIDTH,
                       height: HEIGHT)
     end
  end # class Image
end # module Bixel
```


and let's retry:

``` ruby
img = Bixel::Image.parse( '3113113111111311303011111111117777711111131111333' ) 
img.save( "./bixel10.png" )
img.zoom(8).save( "./bixel10@8x.png" )
```

Voila!

![](i/bixel10.png)

in 8x

![](i/bixel10@8x.png)



Let's try some more.
[Search for bixel](https://unisat.io/search?q=bixel&type=text) via unisat.


```ruby
bixels = [
  [32,'0060000066660000600600066600006006006666000060000'],  # Bixel #32 - Inscribe #22140448
  [43,'0055500055555055050555555555550005606555600066600'],  # Bixel #43 - Inscribe #22140536
  [50,'9994999984548994575499845489988488998818899991999'],  # Bixel #50 - Inscribe #22140557
  [86,'8899988889998899999998888888889898888878888999998'],  # Bixel #86 - Inscribe #22141494
  [90,'0000000000100000110000001000000100000111000000000'],  # Bixel #90 - Inscribe #22141738
  [153,'0777777077777707777770777777077777707700000770000'], # Bixel #153 - Inscribe #22159765
  [163,'3795793951116551010177117119311111333101333311133'], # Bixel #163 - Inscribe #22159775
  [298,'0000000077077007070700700070007070000070000000000'], # Bixel #298 - Inscribe #22160168
  [405,'7777777777777775777575757575577577557777755777775'], # Bixel #405 - Inscribe #22160379
  [432,'0033300033333030030033003003333033303333300030300'], # Bixel #432 - Inscribe #22160466
]

bixels.each do |num,spec|
  img = Bixel::Image.parse( spec ) 
  img.save( "./bixel#{num}.png" )
  img.zoom(8).save( "./bixel#{num}@8x.png" )
end
```

resulting in:


![](i/bixel32.png)
![](i/bixel43.png)
![](i/bixel50.png)
![](i/bixel86.png)
![](i/bixel90.png)
![](i/bixel153.png)
![](i/bixel163.png)
![](i/bixel298.png)
![](i/bixel405.png)
![](i/bixel432.png)

in 8x

![](i/bixel32@8x.png)
![](i/bixel43@8x.png)
![](i/bixel50@8x.png)
![](i/bixel86@8x.png)
![](i/bixel90@8x.png)
![](i/bixel153@8x.png)
![](i/bixel163@8x.png)
![](i/bixel298@8x.png)
![](i/bixel405@8x.png)
![](i/bixel432@8x.png)






## V2 / Chapter 2   - 10x10 canvas / 21 colors

- 10x10 canvas (=100 pixels)
- 21 colors (A-U)
  - ![](i/colorA.png) A => #88b2c4
  - ![](i/colorB.png) B => #547d8e
  - ![](i/colorC.png) C => #dac8c6
  - ![](i/colorD.png) D => #7c7587
  - ![](i/colorE.png) E => #e3a18d
  - ![](i/colorF.png) F => #da4c27
  - ![](i/colorG.png) G => #f1b31f
  - ![](i/colorH.png) H => #e99248
  - ![](i/colorI.png) I => #87c687
  - ![](i/colorJ.png) J => #529055
  - ![](i/colorK.png) K => #a08454
  - ![](i/colorL.png) L => #966946
  - ![](i/colorM.png) M => #e7debf
  - ![](i/colorN.png) N => #afa78a
  - ![](i/colorO.png) O => #d2fae0
  - ![](i/colorP.png) P => #f7e382
  - ![](i/colorQ.png) Q => #9aaf89
  - ![](i/colorR.png) R => #e5cc7c
  - ![](i/colorS.png) S => #fff
  - ![](i/colorT.png) T => #d7e5e5
  - ![](i/colorU.png) U => #000



Example - .biixel (at inscribe no. 22237694)

```
UGGLBBBBBLUHGHLBBBLHBLHGHLBBHGBBLHGGGGGHBBLGGGGGGGDDHSUGGGSUDGHUUGGGUUDFFGGGLGGGDFFHGLHLGHDDLHHHHHHH.biixel 
```


Let's use the pixelart machinery to generate the (bitmap) image 
from the paint by letter spec.

Step 1 - let's define a read-to-use Biixel Image class:

``` ruby
module Biixel    
  # 10x10 canvas (100 pixels) - 21 colors (A-U)
  WIDTH  = 10
  HEIGHT = 10
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
    U: '#000' }

  class Image < Pixelart::Image
    def self.parse( pixels )
      super( pixels, colors: COLORS, 
                     width:  WIDTH,
                     height: HEIGHT)
    end
  end # class Image
end  # module Biixel
```


and step 2 - let's generate the bitmap image / parse the spec:

```ruby
img = Biixel::Image.parse( 'UGGLBBBBBLUHGHLBBBLHBLHGHLBBHGBBLHGGGGGHBBLGGGGGGGDDHSUGGGSUDGHUUGGGUUDFFGGGLGGGDFFHGLHLGHDDLHHHHHHH' )
img.save( "./biixel1.png" )
img.zoom(8).save( "./biixel1@8x.png" )

```

Voila!

![](i/biixel1.png)

in 8x

![](i/biixel1@8x.png)




Let's try some more.
[Search for biixel](https://unisat.io/search?q=biixel&type=text) via unisat.

Let's prepare an (SQL) database with 1000+ inscriptions
matching the 'biixel' full-text search (on unisat)
with all inscribe ids listed in [biixel.csv](biixel.csv).

Let's download the inscriptions (metadata & content) 
via ordinals.com to a local cache (in `/inscription`)
and than import into single-file SQLite database (`ord.db`).

``` ruby
require 'ordlite'

cache = Ordinals::Cache.new( './inscription' )
cache.add_csv( './biixel.csv' )

OrdDb.open( './ord.db' )
cache.import_all

puts
puts "  #{Inscribe.count} inscribe(s)"
puts "  #{Blob.count} blob(s)"
#=>  1024 inscribe(s)
#=>  1024 blob(s)
```



Now let's query for the .biixel inscriptions 
and validate the candidates to filter out broken mints
not matching the pattern `[A-U]{100}.biixel`.


``` ruby
require 'ordlite'

OrdDb.open( './ord.db' )

inscribes = Inscribe.joins( :blob )
                   .where( 'content LIKE ?', '%.biixel%' )
                   .order( 'num' )
                   
puts
puts "  #{inscribes.size} inscribe(s) - unconfirmed candidates"


## validate / filter-out false positives
BIIXEL_RX =  /\A
               [A-U]{100}
               \.biixel
               \z/x

inscribes = inscribes.select do |inscribe|
                if BIXXEL_RX.match( inscribe.text.strip )
                    true
                else  
                    puts "!! WARN - expected [A-U]{100}.biixel inscribe no. #{inscribe.num} @ #{inscribe.date}; got:"
                    puts "  >#{inscribe.text}<"
                    false  
                end
             end

puts
puts "  #{inscribes.size} inscribe(s) - validated"
```

resulting in

```
 1023 inscribe(s) - unconfirmed candidates

!! WARN - expected [A-U]{100}.biixel inscribe no. 22238685 @ 2023-08-08 23:38:58 UTC; got:
  >SUSUSUSUSUUSUSUSUSUUUUSUSUSUUUUUUSUSUUUUUUUUSUUUUUUUUUUSUUUUUUUUSUSUUUUUUSUSUSUUUUSUSUSUSUUSUSUSUSUS.biixel
   FUFUFUFUFUUFUFUFUFUUUUFUFUFUUUUUUFUFUUUUUUUUFUUUUUUUUUUFUUUUUUUUFUFUUUUUUFUFUFUUUUFUFUFUFUUFUFUFUFUF.biixel
   GUGUGUGUGUUGUGUGUGUUUUGUGUGUUUUUUGUGUUUUUUUUGUUUUUUUUUUGUUUUUUUUGUGUUUUUUGUGUGUUUUGUGUGUGUUGUGUGUGUG.biixel
   AUAUAUAUAUUAUAUAUAUUUUAUAUAUUUUUUAUAUUUUUUUUAUUUUUUUUUUAUUUUUUUUAUAUUUUUUAUAUAUUUUAUAUAUAUUAUAUAUAUA.biixel
   UAAAAAAAAUAUAAAAAAUAAAUAAAAUAAAAAUAAUAAAAAAAUUAAAAAAAAUUAAAAAAAUAAUAAAAAUAAAAUAAAUAAAAAAUAUAAAAAAAAU.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22238686 @ 2023-08-08 23:38:58 UTC; got:
  >biixelFAAAAAAAAFAFAAAAAAFAAAFAAAAFAAAAAFAAFAAAAAAAFFAAAAAAAAFFAAAAAAAFAAFAAAAAFAAAAFAAAFAAAAAAFAFAAAAAAAAF.biixel
   AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGGGGAAAJJAGAAAAAAJAJGAGGFFFJAJGAAGFAFJAJGGGGFFFJJAAAAAAAAAAAAAAAAAAAAA.biixel
   AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGGGGAAAUUAGAAAAAAUAUGAGGFFFUAUGAAGFAFUAUGGGGFFFUUAAAAAAAAAAAAAAAAAAAAA.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22238748 @ 2023-08-09 00:32:25 UTC; got:
  >lFDOBCGAHIEDOBCGAHIEIOBCGAHIEIHBCGAHIEIHACGAHIEIHAGGAHIEIHAGCAHIEIHAGCBHIEIHAGCBOIEIHAGCBODEIHAGCBODF.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22238957 @ 2023-08-09 00:51:29 UTC; got:
  >啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊 啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22250952 @ 2023-08-09 03:05:25 UTC; got:
  >SSSSSSSSSSSSJJQJJSSSSSJJJJJJJSSSGGGGGGSSSSGGBGBFFFSSGGGGGGSSSSGFFFFGSSSSGGGGGGSSSSSGGGSSSSSSSGGGSSSS.biixel
   SSSSSSSSSSSSBBABBBSSSBBBBBBBSSSSIIIIIISSSSIIUIUISSSSIIIIIISSSSIFFFFISSSSIIIIIISSSSSIIISSSSSSSIIISSSS.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22291179 @ 2023-08-09 03:57:53 UTC; got:
  >WXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZWXYZ.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22345638 @ 2023-08-09 08:00:09 UTC; got:
  >ABJILPEFQMNCDGHRSTUOVWKXYTZBCJKLDFAGMQROPHNTSVWUXEIYLZCJDBLKFAPGMQHSORNTVWIUZXJYLCZBCJKLDFAGMQROPARH.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22348229 @ 2023-08-09 08:21:55 UTC; got:
  >PUSHFORCHANGEADVENTURESBRINGPERSPECTIVESRESISTTHEOLDSTANDFIRMBELIEVEANDEMBRACEBITCOINORDINALS.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22350766 @ 2023-08-09 08:37:31 UTC; got:
  >FUCKERSINSCHOOLTELLINGMEALWAYSINTHEBARBERSHOPCHIEFKEEFAINTBOUTTHISCHIEFAINTBOUTTHATMYBOYABDONFUCKING.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22350767 @ 2023-08-09 08:37:31 UTC; got:
  >TRAPPINOUTTHEBANDOoTRAPPINOUTTHEBANDOoTRAPPINOUTTHEBANDOoTRAPPINOUTTHEBANDOoTRAPPINOUTTHEBANDOoTRAPP.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22350768 @ 2023-08-09 08:37:31 UTC; got:
  >FUCKGARYGENSLERFUCKGARYGENSLERFUCKGARYGENSLERFUCKGARYGENSLERFUCKGARYGENSLERFUCKGARYGENSLERFUCKTHESEC.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22350786 @ 2023-08-09 08:37:31 UTC; got:
  >THISISTHEPSYOPTHISISTHEPSYOPTHISISTHEPSYOPTHISISTHEPSYOPTHISISTHEPSYOPTHISISTHEPSYOPTHISISTHEPSYOPTH.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22351383 @ 2023-08-09 09:05:43 UTC; got:
  >LEADTHEWAYINANERAOFCRISISRESISTTHEOLDSTANDFIRMPROMOTECHANGEANDTRUSTEMBRACEBITCOINORDINALSFIGHTBACKGO.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22395842 @ 2023-08-09 11:33:44 UTC; got:
  >SATOSHINAKAMOTOSPARKSFIATSLOCKBITCOINSNEWARTBECOMESTHEMONETARYSPARKFIATLOCKSJUMPTOTHEBITCOINLIFERAFT.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22454744 @ 2023-08-09 17:07:40 UTC; got:
  >BSSPBSSSSABSSSGSBSSSSSSAABSSSSHSSABSSSPSSSSBSSGSSSSSSSSSSSSSSSHSSSSBPSSSSSBB.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22550033 @ 2023-08-10 10:09:15 UTC; got:
  >AAARAATAAAAAOAAAAQAAAFAAAAAAHAAAAAAAAAAA.biixel<
!! WARN - expected [A-U]{100}.biixel inscribe no. 22591201 @ 2023-08-10 20:43:31 UTC; got:
  >bixel_AAAAAAAAAAAAUUUUUUAAAUTTTTTTUAAUTUFFUTUAAUTFFFFTUAAUTTTTTTUAAAUTMMTUAAAAUTMMTUAAAAAUUUUAAAAAAAAAAAAA.biixel<

  1006 inscribe(s) - validated
```


Last but not least
let's generate the first hundred biixel fam
and the first thousand biixel fam composite all-in-one image.


``` ruby
require 'pixelart'

require_relative 'bixel'

## first hundred in 10x10 grid
composite = ImageComposite.new( 10, 10, width: Biixel::WIDTH,
                                        height: Biixel::HEIGHT )

inscribes[0,100].each do |inscribe|
    txt = inscribe.text
    spec = txt.strip.sub( '.biixel', '' )
    img = Biixel::Image.parse( spec )
    composite << img
end

composite.save( './biixels_100.png' )
composite.zoom(4).save( './biixels_100@4x.png' )


## first thousand in 20x50 grid
composite = ImageComposite.new( 20, 50, width: Biixel::WIDTH,
                                        height: Biixel::HEIGHT )

inscribes[0,1000].each do |inscribe|
    txt = inscribe.text
    spec = txt.strip.sub( '.biixel', '' )
    img = Biixel::Image.parse( spec )
    composite << img
end

composite.save( './biixels_1000.png' )
composite.zoom(4).save( './biixels_1000@4x.png' )
```

resulting in:


![](i/biixels_100.png)

in 4x

![](i/biixels_100@4x.png)


and

![](i/biixels_1000.png)

in 4x

![](i/biixels_1000@4x.png)





To be continued...





## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.



## Questions? Comments?

Join us in the [Ordgen / ORC-721 discord (chat server)](https://discord.gg/dDhvHKjm2t). Yes you can.
Your questions and commetary welcome.


Or post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.
