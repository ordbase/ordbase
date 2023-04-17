# ordbase

ordbase gem - "right-clicker" (off-chain) ordinals (pixel art) command-line tool, machinery & helpers for Bitcoin, Litcoin, Dogecoin & co.


* home  :: [github.com/pixelartexchange/artbase](https://github.com/pixelartexchange/artbase)
* bugs  :: [github.com/pixelartexchange/artbase/issues](https://github.com/pixelartexchange/artbase/issues)
* gem   :: [rubygems.org/gems/ordbase](https://rubygems.org/gems/ordbase)
* rdoc  :: [rubydoc.info/gems/ordbase](http://rubydoc.info/gems/ordbase)



## Command-Line Usage

Let's use the 100 Ordinal Punks collection to try out the
`ordbase` command-line tool shipping with the ordbase package.

Tip: New to Ordinal Punks? For some background see [**Awesome 100 Ordinal Punks (Anno 2023) Notes - 24×24 Pixel Art on the (Bitcoin) Blockchain »**](https://github.com/cryptopunksnotdead/cryptopunks/tree/master/awesome-ordinalpunks)


### Step 0:   Prepare A Tabular Dataset (List) Of All Ordinals w/ ID

For now a manual step - prepare a list of all ordinals with id in the comma-separated values (.csv) tabular dataset format.
Example - [ordinalpunks/ordinals.csv](https://github.com/pixelartexchange/ordinals.sandbox/blob/master/ordinalpunks/ordinals.csv):

``` csv
num, id
1, 96d87d7e59d75ebc0e6144b09fdd96355fcdaa86fd098d64c46f19a424012bbei0
2, acda637db995df796b35035fd978cc1a947f1e6fd5215968da88b7e38a7e4b37i0
3, 0406654dffdd01a49794bd8531bf33721986cc7c6546f871962adee921a39a9di0
4, 2fe9bb034f60db694701acb23a76c3d7d5aba4328dbd315764f6ee406ba41786i0
5, dcfa240f2681d1e4a8948120a3a64567262e3c78d5497cb4e97351bfa836b638i0
6, 16df62c86321895df2b93236d103c935015ed77e189485be649ce2c7e6ac8a4ei0
7, 81e8d9159b8e9a27c692a5bb3ba18ca037757e94e975b53e175eaaeb2c52f15ai0
8, c2e15fe87c4b1fd61de65f2804858e6d1152b6316bcb9c2b39b69c9c21638f5di0
9, 3ed569f3a92ade9f1b47031eb2db2045e7dee3e00787954a88c67ed2ad9854bbi0
...
```


### Step 1:  Download All Pixel Art Images Via Ordinals.com

Use

```
$ ordbase ordinalpunks image   # or
$ ordbase ordinalpunks img
```

to download all images via the ordinals.com (web) service.
All images get stored in the (temporary) `token-i/` directory.
Resulting in:

```
/ordinalpunks
   ordinals.csv
   /token-i
     1.png
     2.png
     3.png
     ...
```

![](https://github.com/pixelartexchange/artbase/raw/master/ordbase/i/1.png)
![](https://github.com/pixelartexchange/artbase/raw/master/ordbase/i/2.png)
![](https://github.com/pixelartexchange/artbase/raw/master/ordbase/i/3.png)
![](https://github.com/pixelartexchange/artbase/raw/master/ordbase/i/4.png)
![](https://github.com/pixelartexchange/artbase/raw/master/ordbase/i/5.png)
![](https://github.com/pixelartexchange/artbase/raw/master/ordbase/i/6.png)
...




### Step 2:  Downsample ("Pixelate")  All Pixel Art Images

Note: Most pixel art collections upload / inscribe images with a zoom.
The ordinal punks, for example, use a 8x zoom factor for the 24×24px originals, thus,
resulting in 192×192px.


Add a ["artbase-compatible"](https://github.com/pixelartexchange/artbase) collection configuration file to lists the source format(s)
and the minimal true pixel format.
Example - [ordinalpunks/collection.yml](https://github.com/pixelartexchange/ordinals.sandbox/blob/master/ordinalpunks/collection.yml):

``` yaml
slug:       ordinalpunks
count:      100
format:     24x24
source:     192x192
offset:     1
```

Use

```
$ ordbase ordinalpunks pixelate   # or
$ ordbase ordinalpunks px
```

to downsample ("pixelate") all images
in the (temporary) `token-i/` directory.
Resulting in a `24x24`/ directory with all images
in the "minimal" `24x24` format:

```
/ordinalpunks
   ordinals.csv
   collections.yml
   /24x24
     1.png
     2.png
     3.png
     ...
```

![](https://github.com/pixelartexchange/ordinals.sandbox/raw/master/ordinalpunks/24x24/1.png)
![](https://github.com/pixelartexchange/ordinals.sandbox/raw/master/ordinalpunks/24x24/2.png)
![](https://github.com/pixelartexchange/ordinals.sandbox/raw/master/ordinalpunks/24x24/3.png)
![](https://github.com/pixelartexchange/ordinals.sandbox/raw/master/ordinalpunks/24x24/4.png)
![](https://github.com/pixelartexchange/ordinals.sandbox/raw/master/ordinalpunks/24x24/5.png)
![](https://github.com/pixelartexchange/ordinals.sandbox/raw/master/ordinalpunks/24x24/6.png)
...



### Bonus: Step 3:  Make An All-In-One Collect'Em All Composite Image


Use

```
$ ordbase ordinalpunks composite   # or
$ ordbase ordinalpunks comp
```

to make an all-in-one image composite for the complete collection.
Resulting in `/tmp/ordinalpunks.png` (~11kb).


![](https://github.com/pixelartexchange/ordinals.sandbox/raw/master/i/ordinalpunks.png)


That's it for now.




## Bonus:  More Ordinal Pixel Art Collections


See the [**Ordinals (Pixel Art) Sandbox (& Cache)**](https://github.com/pixelartexchange/ordinals.sandbox)
for more collections incl. Bitcoin Punks (24×24), Ordinal Mini Doges (24×24),
Extra Ordinal Women (32×32), Ordinal Penguins (35×35),
Ordinal Birds (42×42), Bitcoin Bears (48×48) and much more.

Add your sandbox or "right-clicker" ordinal backup / archive / gallery here. Yes, you can.



## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.


