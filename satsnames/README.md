# Sats Names Helpers for Bitcoin Ordinal Inscription Names, Relays And More

satsnames  - sats names helpers for bitcoin ordinal inscription names, relays and more



* home  :: [github.com/ordbase/satsnames](https://github.com/ordbase/satsnames)
* bugs  :: [github.com/ordbase/satsnames/issues](https://github.com/ordbase/satsnames/issues)
* gem   :: [rubygems.org/gems/satsnames](https://rubygems.org/gems/satsnames)
* rdoc  :: [rubydoc.info/gems/satsnames](http://rubydoc.info/gems/satsnames)


## What's Sats Names?

Sats Names is a standard for writing names to bitcoin using ordinals. The goal is to build a name ecosystem for bitcoin.

More @ [docs.satsnames.org »](https://docs.satsnames.org)



##  Usage

Lookup ordinal inscription ids by name via the `Sats` helper:

``` ruby
require 'satsnames'

## let's try some name relays:
Sats[ 'bitcoin.paper']     #=> '85b10531435304cbe47d268106b58b57a4416c76573d4b50fa544432597ad670i0'
Sats[ 'cypherpunk.paper']  #=> '8277fca13d0d5ccf70b5930e351494768ae6ed6759b318b403df229318984af3i0' 
Sats[ 'snake.game' ]       #=> '315198afb24aed9bc0b68f222eb6f2e976b7ab62bac456b30f26cbb8b893ae55i0'
Sats[ 'breakout.game' ]    #=> '6cc328043c8e8837a421e2b869026363010fb10a5e50f89005187cadc429a821i0' 
Sats[ '2048.game' ]        #=> '2d7dcad13f149e82c5f2c77b003d55b3837df3710e30ed14aa3566625de28a53i0'

# and so on
```

That's it.



## Inside the  "Off-Chain" Sat Names Relay to Bitcoin Inscription Ids

Note: The (sats) name (relay) to (inscription) id mappings
are fow now stored
in datafiles in the comma-separated value (.csv) format
and split by year (e.g. 2023, 2024, ..., etc.)

Example - [config/relays.2023.csv](config/relays.2023.csv):

``` csv
name, id
bitcoin.paper, 85b10531435304cbe47d268106b58b57a4416c76573d4b50fa544432597ad670i0
cypherpunk.paper, 8277fca13d0d5ccf70b5930e351494768ae6ed6759b318b403df229318984af3i0
snake.game, 315198afb24aed9bc0b68f222eb6f2e976b7ab62bac456b30f26cbb8b893ae55i0
breakout.game, 6cc328043c8e8837a421e2b869026363010fb10a5e50f89005187cadc429a821i0
2048.game, 2d7dcad13f149e82c5f2c77b003d55b3837df3710e30ed14aa3566625de28a53i0
flieka.joelle, 2f78bcf10a94b675aa744ecb4572b93b1ab2a0fb601799c5c47ecc17d95044fdi0
...
```






## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Join us in the [Ordgen / ORC-721 discord (chat server)](https://discord.gg/dDhvHKjm2t). Yes you can.
Your questions and commetary welcome.


Or post them over at the [Help & Support](https://github.com/geraldb/help) page. Thanks.
