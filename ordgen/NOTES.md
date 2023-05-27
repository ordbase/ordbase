#  Generative BRC-721 Notes

- <https://github.com/jerryfane/generative-brc-721>
- analytics (dune) dashboard <https://dune.com/j543/generative-brc-721>



## Examples

### 10000 (?) Ordibots

- ordibots <https://www.ord.io/8326719>   1st inscription no. 8_326_719 on May 21, 2023 by Jerry Fanelli
  - <https://ordinals.com/inscription/b7205d40f3b1b1486567f0d6e53ff2812983db4c03ad7d3606812cd150c64802i0>
  - <https://ordinals.com/content/b7205d40f3b1b1486567f0d6e53ff2812983db4c03ad7d3606812cd150c64802i0>




## Ideas

How to improve the format

- do you (really) need trait category and trait keys?
  use arrays to simplify - bonus - makes the order deterministic (object order is unordered)

``` json
 "trait_types": [
        "background",
        "accessories",
        "body",
        "belly",
        "face"
    ],
    "traits": {
        "background": {
            "blue": {
                "name": "Blue",
                "base64": "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQMAAABJtOi3AAAAA1BMVEVkhZa3PARZAAAAC0lEQVR4AWMY5AAAAKAAAVQqnscAAAAASUVORK5CYII="
            },
            "bitcoin-orange": {
                "name": "Bitcoin Orange",
                "base64": "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQMAAABJtOi3AAAAA1BMVEX3kh03gNzOAAAAC0lEQVR4AWMY5AAAAKAAAVQqnscAAAAASUVORK5CYII="
            },
            ...
```

becomes

``` json
"traits": [
    ["background", [
         { "name": "Blue",
           "base64": "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQMAAABJtOi3AAAAA1BMVEVkhZa3PARZAAAAC0lEQVR4AWMY5AAAAKAAAVQqnscAAAAASUVORK5CYII="
          },
          { "name": "Bitcoin Orange",
            "base64": "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQMAAABJtOi3AAAAA1BMVEX3kh03gNzOAAAAC0lEQVR4AWMY5AAAAKAAAVQqnscAAAAASUVORK5CYII="
          },
          ...
```





