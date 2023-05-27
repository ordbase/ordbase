#  Generative BRC-721 Notes

- <https://github.com/jerryfane/generative-brc-721>
- analytics (dune) dashboard <https://dune.com/j543/generative-brc-721>



## Examples

### 10000 (?) Ordibots

- ordibots <https://www.ord.io/8326719>   inscription no. 8326719





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





