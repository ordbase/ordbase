# Ordinal Inscription Sandbox (Testing) Server / Service

ordserve - serve-up ordinal inscription (on bitcoin & co) from a local test sandbox
 

* home  :: [github.com/ordbase/ordbase](https://github.com/ordbase/ordbase)
* bugs  :: [github.com/ordbase/ordbase/issues](https://github.com/ordbase/ordbase/issues)
* gem   :: [rubygems.org/gems/ordserve](https://rubygems.org/gems/ordserve)
* rdoc  :: [rubydoc.info/gems/ordserve](http://rubydoc.info/gems/ordserve)



## Command-Line Tool

Use the command line tool named - surprise, surpirse - `ordserve`
to run a zero-config / out-of-the-box ordinal inscription server that lets
you test recursive inscriptions with local web pages (in .SVG or .HTML).
Type:

    $ ordserve

That will start-up a (local loopback) web server running on port 3000.
Open-up up the index page in your browser to get started e.g. <http://localhost:3000/>.



Try your first recursive inscription.
Let's try a punk in the .SVG format with two recursions  - 
alien ([inscribe no. 11617799](https://ordinals.com/inscription/81ec4177e7fce4e568cc1c14366fe29deb88b0f0841eb12d4f1d0638cca68201i0))  and 
bandana ([inscribe no. 11627632](https://ordinals.com/inscription/a6b4b81f69e8c217db24f0a71954195d67ced49a819b67a4daf9f3ca7fa1b971i0)) - `punk1.svg`:

``` svg
<svg xmlns="http://www.w3.org/2000/svg"
   width="100%" height="100%"
   viewBox="0 0 24 24">
  <image href="/content/81ec4177e7fce4e568cc1c14366fe29deb88b0f0841eb12d4f1d0638cca68201i0" 
     style="image-rendering: pixelated;" />
  <image href="/content/a6b4b81f69e8c217db24f0a71954195d67ced49a819b67a4daf9f3ca7fa1b971i0" 
     style="image-rendering: pixelated;" />
</svg>
```

Now try <http://localhost:3000/punks1.svg> and 
you get the million dollar alien with bandana built from zero / scratch.
The two recursions (referenced via `/content/:id`) will get
the first-time "automagically" downloaded via the ordinals.com api 
and saved into the local `./content` directory.


Let's try a punk with three recursions - 
alien ([inscribe no. 11617799](https://ordinals.com/inscription/81ec4177e7fce4e568cc1c14366fe29deb88b0f0841eb12d4f1d0638cca68201i0)), 
cap foward ([inscribe no. 11617793](https://ordinals.com/inscription/0bd902941392ea138adb7db30cecdf5bc09a92c80e3e1bc3ecdf3c2d0abf6631i0)) and 
laser eyes ([inscribe no. 12359718](https://ordinals.com/inscription/72fe7ebda802852f499dca865ec22ac43eacfcf4796d761969ae8358791e943ci0))- `punk1a.svg`:  

``` svg
<svg xmlns="http://www.w3.org/2000/svg"
   width="100%" height="100%"
   viewBox="0 0 24 24">
  <image href="/content/81ec4177e7fce4e568cc1c14366fe29deb88b0f0841eb12d4f1d0638cca68201i0" 
     style="image-rendering: pixelated;" />
  <image href="/content/0bd902941392ea138adb7db30cecdf5bc09a92c80e3e1bc3ecdf3c2d0abf6631i0" 
     style="image-rendering: pixelated;" />
  <image href="/content/72fe7ebda802852f499dca865ec22ac43eacfcf4796d761969ae8358791e943ci0" 
     style="image-rendering: pixelated;" />
</svg>
```

Now try <http://localhost:3000/punks1a.svg> and 
you get an ultra-rare never-before-seen alien with cap foward
and laser eyes built from zero / scratch.
The three recursions (referenced via `/content/:id`) will get
the first-time "automagically" downloaded via the ordinals.com api 
and saved into `./content`. 


That's it.


Bonus - For more (recursive) samples 
see [ordtest - the public ordinals (recursive) testing sandbox »](https://github.com/ordtest/ordtest.github.io)




## Install

Just install the gem:

    $ gem install ordserve



## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Join us in the [Ordgen / ORC-721 discord (chat server)](https://discord.gg/dDhvHKjm2t). Yes you can.
Your questions and commetary welcome.


Or post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.
