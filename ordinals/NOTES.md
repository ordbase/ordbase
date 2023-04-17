# Notes


Add more metadata to ordinals:
-   Ordinal Number       e.g. 82878
-   Content              e.g. image/png
-   Inscription (link)   e.g. 04f74199556e57dfa99e00d3e211fcd034a5023dfba6779f3e0c7a8c573744f1i0
-   Output Value         e.g. 0.0001
-   Minted At            e.g. 2023-02-14 09:22
-   Minted Block         e.g. 776478
-   Size (Bytes)         e.g. 25874
-   V-Size               e.g. 6539
-   Fee (sats)           e.g. 45773
-   Sats Fee / V-Byte    e.g. 7
-   Minter (Receiver)    e.g. bc1pvqsqeuep4wcjm84gexnyj772ddp9rx0yu34nx4264n7qfrhxepqsrczh4w


or from ordinals.com:
-  id   e.g. 04f74199556e57dfa99e00d3e211fcd034a5023dfba6779f3e0c7a8c573744f1i0
-  address  e.g. bc1pvqsqeuep4wcjm84gexnyj772ddp9rx0yu34nx4264n7qfrhxepqsrczh4w
-  output value   e.g. 10000   -- satoshis??
-  sat  e.g. 1924960231340701  - https://ordinals.com/sat/1924960231340701
-  preview  e.g. https://ordinals.com/preview/04f74199556e57dfa99e00d3e211fcd034a5023dfba6779f3e0c7a8c573744f1i0
-  content e.g. https://ordinals.com/content/04f74199556e57dfa99e00d3e211fcd034a5023dfba6779f3e0c7a8c573744f1i0
- content length  e.g. 25474 bytes
- content type  e.g. image/png
- timestamp  e.g. 2023-02-14 09:22:42 UTC
- genesis height  e.g. 776478
- genesis fee  e.g. 45773
- genesis transaction e.g. 04f74199556e57dfa99e00d3e211fcd034a5023dfba6779f3e0c7a8c573744f1
- location e.g. 04f74199556e57dfa99e00d3e211fcd034a5023dfba6779f3e0c7a8c573744f1:0:0
- output e.g. 04f74199556e57dfa99e00d3e211fcd034a5023dfba6779f3e0c7a8c573744f1:0
- offset e.g. 0








source - https://dune.com/queries/1984002/3279993

```
SELECT
    --types to hex here https://dune.com/queries/1981638?d=11
    --uncaught types filtering here https://dune.com/queries/1981648?d=11
    row_number() OVER (order by t.block_height asc, t.index asc) as ordinal_number
    , case when lower(hex) LIKE '%0063036f726401010a696d6167652f6a706567%' then 'image/jpeg'
        when lower(hex) LIKE '%0063036f7264010109696d6167652f706e67%' then 'image/png'
        when lower(hex) LIKE '%0063036f7264010109696d6167652f676966%' then 'image/gif'
        when lower(hex) LIKE '%0063036f726401010a696d6167652f77656270%' then 'image/webp'
        when lower(hex) LIKE '%0063036f726401010d696d6167652f7376672b786d6c%' then 'image/svg+xml'

        when lower(hex) LIKE '%0063036f726401010a696d6167652f61766966%' then 'image/avif'
        when lower(hex) LIKE '%0063036f726401010a766964656f2f7765626d%' then 'video/webm'
        when lower(hex) LIKE '%0063036f7264010109766964656f2f6d7034%' then 'video/mp4'

        when lower(hex) LIKE '%0063036f726401010f6170706c69636174696f6e2f706466%' then 'application/pdf'
        when lower(hex) LIKE '%0063036f72640101196170706c69636174696f6e2f7067702d7369676e6174757265%' then 'application/pgp-signature'
        when lower(hex) LIKE '%0063036f72640101106170706c69636174696f6e2f6a736f6e%' then 'application/json'
        when lower(hex) LIKE '%0063036f72640101146170706c69636174696f6e2f657075622b7a6970%' then 'application/epub+zip'

        when lower(hex) LIKE '%0063036f726401010a617564696f2f6d706567%' then 'audio/mpeg'
        when lower(hex) LIKE '%0063036f726401010a617564696f2f6d696469%' then 'audio/midi'
        when lower(hex) LIKE '%0063036f7264010109617564696f2f6d6f64%' then 'audio/mod'

        when lower(hex) LIKE '%0063036f7264010117746578742f68746d6c3b636861727365743d7574662d38%' then 'text/html;charset=utf-8'
        when lower(hex) LIKE '%0063036f7264010118746578742f706c61696e3b636861727365743d7574662d38%' then 'text/plain;charset=utf-8'
        when lower(hex) LIKE '%0063036f726401010f746578742f6a617661736372697074%' then 'text/javascript'
        when lower(hex) LIKE '%c0063036f726401010d746578742f6d61726b646f776e%' then 'text/markdown'

        when lower(hex) LIKE '%0063036f72640101116d6f64656c2f676c74662d62696e617279%' then 'model/gltf-binary'
        else 'other'
        end as content_type
    , concat('<a href="https://ordinals.com/inscription/', substr(t.id,3) || 'i0', '" target = "_blank">'
        , substr(t.id,3) || 'i0'
        , '</a>') as inscription
    , output_value
    , t.block_time as mint_time
    , t.block_height
    , t.size
    , t.virtual_size
    , t.fee*1e8 as fee
    , t.fee*1e8/t.virtual_size as sat_per_vbyte
    , t.output[1].script_pub_key.address as minter_address
    , t.index
    , t.id as tx_id
FROM bitcoin.transactions t
where t.block_height > 767429
AND t.hex LIKE '%0063036f726401%' -- OP_FALSE (0x00) OP_IF (0x63) OP_PUSHBYTES3 (0x03) "ord" (0x6f7264) OP_1 (0x01) https://docs.ordinals.com/inscriptions.html
-- AND t.input[1].witness_data[2] LIKE '%0063036f726401%' AND t.input[1].type = 'witness_v1_taproot' thenthis doesn't wwhenk because of array length checks
order by ordinal_number desc
```


## ordinals apis


- <https://ordapi.xyz/>




