# One-coordinate Hardy-sign test at conductor 131071

At height (t=28475/64=444.921875), the 28-bit quadrant test returned a correct strict sign for 131,064 of all 131,069 primitive characters modulo 131071. Five characters needed another test. Checking the alternate projection resolved two of them. The other three also remained indeterminate for the full 28-bit score and resolved at 32 bits. This is one entire sample height of a second genuine conductor. The input was reconstructed from the local large-family pilot. The archived reference is the pilot's independent Arb sign mask.

| Precision | Initial quadrant misses | Root or phase crosses an axis | Spectrum coordinate crosses zero | Recovered by trying either coordinate | Still unresolved by either coordinate and full score |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 24 bits | 32 | 1 | 31 | 7 | 25 |
| 28 bits | 5 | 1 | 4 | 2 | 3 |
| 32 bits | 1 | 1 | 0 | 1 | 0 |

Each integer comparison uses the actual fixed-point Bluestein spectrum and the existing pilot's error allowance. Every accepted sign agreed with the archived mask. At 24 bits, the full-score gate alone missed 27, while using either strict component missed 25. Exact Hardy realness can give a sign from one oriented component even when the full-score error estimate overlaps zero. Residual uncertainty at a given precision is not evidence that the Hardy value vanishes. [Numerical receipt](cohort.json) · [Decision code](cohort.py) · [Archived full-score pilot](../large-coarse-sign/prime-131071.json)

## Phase, character, and terminal-axis evidence

The same cutoff was also tested at the other five archived heights. Across all six, the simple quadrant decision missed 136, 16 and 6 of 786,414 character-height pairs at 24, 28 and 32 bits. Trying a second certified coordinate and the full score left 107, 6 and 0 respectively. At 28 bits the fallback rate was 20.3 per million across these six heights. At each precision, all accepted signs agreed with the archived mask. The two groups of adjacent heights share the same conductor and character population. [Five further nodes](sweep.json) · [Sweep code](sweep.py)

| Grid index | Simple misses at 24 / 28 / 32 bits | Remaining after fallback at 24 / 28 / 32 bits |
| ---: | ---: | ---: |
| 1 | 10 / 1 / 1 | 9 / 0 / 0 |
| 2 | 11 / 1 / 1 | 8 / 0 / 0 |
| 3 | 21 / 3 / 1 | 17 / 2 / 0 |
| 5694 | 24 / 2 / 1 | 20 / 0 / 0 |
| 5695 | 32 / 5 / 1 | 25 / 3 / 0 |
| 5696 | 38 / 4 / 1 | 28 / 1 / 0 |

The scalar FLINT Dirichlet L-function API provided a second numerical check for three absolute modes in the final 257-point stage at grid index 5695. For modes 7, 65287 and 130567, the corresponding Conrey labels were 2187, 107178 and 22023. After multiplying by the modulus to the power s, each scalar complex interval was contained in its independently generated grid-28 spectrum box. Multiplying by the two phase enclosures reproduced each strict archived Hardy sign. [Scalar reference receipt](direct-reference.json) · [Reference check](direct_reference.py)

The unit group of the prime modulus has generator 3 and order $N=131070$. The mode convention is $\chi_k(3)=\exp(2\pi i k/N)$ for $1\le k<N$. Each such character has conductor 131071 and parity $k\bmod 2$. The unnormalized positive DFT acts on the Hurwitz values $\zeta(s,a/q)$ at the least positive residues $a=3^j\bmod q$. The pilot uses two charts to take an inverse square root of the Gauss root number and assigns conjugate phase factors to paired characters. Each of the 131,069 regenerated completed intervals contained zero in its imaginary component and had the archived strict sign in its real component. Five labels were checked against FLINT's character value on the generator. [Reconstruction code](../large-coarse-sign/prime_panel.py) · [FLINT character API](https://python-flint.readthedocs.io/en/latest/dirichlet.html)

The 257-point fixture is a final stage of the length-131070 transform. Put $m=510$, $d=257$ and $k_0=7$. For each $a<257$, the supplied input is the nearest grid-28 value to

$$
U_a=e^{2\pi i a k_0/N}\sum_{b=0}^{509} X_{257b+a}e^{2\pi i b k_0/510}.
$$

The positive 257-point transform of these values before rounding agrees within the Arb enclosures with the reference transform at mode $k_0+510v$ for each $v<257$. The file records both complex preinput coordinates, each row's absolute mode, both root and parity-factor coordinates, both direct reference spectrum coordinates and its archived Hardy sign. Each rounded coordinate is within one grid unit of the analytic value. The full ordered source and root files also carry grid-28 coordinates. [Terminal-axis fixture](axis257-grid28.tsv) · [Full Hurwitz input](input28.tsv) · [Root factors](roots28.tsv)

These measurements time no HOL kernel operations. Any cost estimate requires an independent kernel replay with its own error budget and extrapolation assumptions. The exact-realness fact used by the one-coordinate identity is a mathematical premise for applying the measured sign counts in a global proof.
