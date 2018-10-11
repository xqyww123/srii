# srii

TODO: Write a description here

## Installation

TODO: Write installation instructions here

## Usage

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Cryptography

The program use a special digital signature algorithm satisfying a property called [Publicly Key-Homomorphic](https://eprint.iacr.org/2016/792.pdf) investigated by David Derler and Daniel Slamanig.
According to their paper, the program adopts the [Boneh–Lynn–Shacham signature scheme (BLS)](https://www.iacr.org/archive/asiacrypt2001/22480516.pdf) over bilinear elliptical curve, which satisfy *Perfect Public Adaptabilit*.
And the curve we used is [BLS12-381](https://z.cash/blog/new-snark-curve/), investigated by *Zcash* team.

### Legality and Disclaimer

The SRII is an open source program, and the code is published under the open source license. However, the algorithm it used could be patented.
So any user of the program is only granted the right to the code and the program but no any related algorithm or library.
And we **DO NOT GRANT ANY RIGHT TO THE PATENTED AND THE COPYRIGHTED**.
To use the SRII program, user need to acquire a authorization of patented algorithm and copyright library, or modify the code to avoid the usage of them.

In future, we may make a update to avoid patents and copyrights, to make the program really free.


The legal status of algorithms and libraries are listed here:

**Open source or free of patents**

- **BLS12-381 curve** is free of patents and open source, for the broader crypto community, announced by Zcash team in their [blog](https://z.cash/blog/cultivating-sapling-faster-zksnarks/).
- **relic-toolkit** : [Apache-2.0 OR LGPL-2.1](https://github.com/relic-toolkit/relic/blob/master/LICENSE)

**Patented or copyrighted**

- **Boneh–Lynn–Shacham signature scheme** : [US7587605B1](https://patents.google.com/patent/US7587605), priority date: 2004-03-19


## Contributing

1. Fork it (<https://github.com/xqyww123/srii/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [xqyww123](https://github.com/xqyww123) Shirotsu Essential - creator, maintainer

The program uses an elliptical curve based Boneh–Lynn–Shacham digital signature implemented in [relic-toolkit](https://github.com/relic-toolkit/relic), an Efficient LIbrary for Cryptography, by D. F. Aranha and C. P. L. Gouvea. Really appreciate the toolkit.
