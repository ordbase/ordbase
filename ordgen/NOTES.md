#  Generative BRC-721 Notes

- <https://github.com/jerryfane/generative-brc-721>
- analytics (dune) dashboard <https://dune.com/j543/generative-brc-721>



## Examples

### 1000  Ordibots (0-999)

_The first on gen-brc-721_

- ordibots <https://www.ord.io/8326719>   1st inscription no. 8_326_719 on May 21, 2023 by Jerry Fanelli
  - <https://ordinals.com/inscription/b7205d40f3b1b1486567f0d6e53ff2812983db4c03ad7d3606812cd150c64802i0>
  - <https://ordinals.com/content/b7205d40f3b1b1486567f0d6e53ff2812983db4c03ad7d3606812cd150c64802i0>

markets:
- <https://magiceden.io/ordinals/marketplace/ordibots>




### ~~10000 (?) Bitcat~~

_The first HD PFP on brc-721_

- <https://twitter.com/bitcat_ord>

markets:
- <https://magiceden.io/ordinals/marketplace/bitcat>

not really using the gen-brc-721 protocol - instead uses ipfs off-chain ??? - double check if this is brc-721 and NOT gen-brc-721 ????


``` json
{
  "p": "brc-721",
  "op": "mint",
  "tick": "bitcat",
  "id": "7954094",
  "ipfs": "ipfs://QmbFAC5n9s65Ky96GqCrbRDVEHXxvE8vJShdbNWSD2GPTA"
}
```






## Ideas

How to improve the format

- do you (really) need trait category and trait keys?
  use arrays to simplify - bonus - makes the order deterministic (object order in json is unordered)


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





