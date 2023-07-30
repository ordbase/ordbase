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



## Genesis

Jerry the Martian -<https://twitter.com/0xJerry543>

about:



> 1/ Good moring, I want to introduce a proposal for a new Ordinals standard
> called "Generative BRC-721" for Ordinals Collection,
> which I'll call here Non-Fungible Ordinals (NFOs).
>
> It's still WIP and I'm excited to get your feedback to improve it.
>
> Full details at <https://github.com/jerryfane/generative-brc-721>
>
>
> 2/ Let's start with the problem at hand: Network fees and block space usage. With the current state of things, creating on-chain NFOs is often inefficient and costly. It's about time we optimize this process to make NFOs more accessible and sustainable.
>
> 3/ Generative BRC-721: This proposed standard aims to make NFOs more efficient by optimizing network usage and ensuring that every piece of art remains on-chain. It does so through a two-step process: Deployment and Minting.
>
> 4/ Here's how it works: Deployment involves establishing your art's base traits and attributes on-chain. It is essentially the 'blueprint' of your artwork. Next comes Minting, which allows you to actually mint the unique NFO based on its traits.
>
> 5/ The 'magic': with Gen-BRC721 users will inscribe text instead of images, but this text is an exact representation of the image. You can retrieve the image completely from on-chain data. This reduction in data size brings down inscription costs significantly.
>
> 6/ An example - "OrdiBots". By adopting the Generative BRC-721 standard, this collection cuts down block space usage by over 55% without compromising the diversity and uniqueness of the NFOs.
>  image <https://twitter.com/0xJerry543/status/1660771245787435009/photo/1>
>
>
> 7/ For Front-ends a small adaptation will be necessary to bring these new NFOs to life. When a "gen-brc-721" inscription pops up, it simply means the image can be re-created using on-chain data. It's a minor tweak for a massive upgrade.
>
> 8/ For those interested in tracking the progress of the gen-brc-721 standard, you can monitor current inscriptions using this Dune Analytics dashboard: https://dune.com/j543/generative-brc-721. It's a great way to stay updated on the growth of this proposal
>
> 9/ For those interested in providing suggestions or are interested in putting the gen-brc-721 proposal to the test, join the discussion on Discord: https://discord.com/channels/987504378242007100/1110244410542788679.
>
> Looking forward to your insights!



----

Here are some feedback that I've received so far:

1/ It's been suggested that we should consider incorporating a type constraint in the base64 data, such as distinguishing between png, bmp, and gif.

2/ There are concerns that the resulting hash function may vary based on the type of GPU acceleration being utilized. This needs further verification, and I'll definitely look into it.

3/ The possibility of excluding the hash from the mint operation has also been pointed out. While this could significantly reduce the size of the mint operation, we need to assess the potential advantages and drawbacks.

4/ Lastly, a point was raised that anyone can freely mint any NFT from the given collection. This is indeed the case. It's ultimately up to the collection creators to decide which inscriptions they wish to include in their collection. These can be minted by anyone, requiring the creators to develop an on-chain listener to track the list of mints for their collection. Alternatively, they could choose to only include the mints originating from a specific website, such as Luminex.

Feel free to keep the feedback coming. All these points are highly valuable and will surely contribute to improving the proposed standard.



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





