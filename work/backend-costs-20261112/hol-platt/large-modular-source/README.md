# Exact modular evaluation of one stored Taylor polynomial

Let z=r/v be the original exact displacement with |z|≤1/4. The script cancels gcd(1024,c) in both r and v for the whole cell. Let P(x)=∑C_j x^j be one stored coordinate after alignment to grid 94, d its degree, D=v^d and N=D P(r/v). For each residue choose m=Bv−r. Since Bv and r agree modulo m, D P(B) and N agree modulo m, term by term. This identity needs no modular inverse.

Choose H=2 max |C_j|+1. The geometric sum bounds |N| by (4/3)D max |C_j|. Select a common power of two B so every m exceeds (2H+1)D. Consequently 0≤N+HD+floor(D/2)<m. Precompute X=D P(B)+HD+floor(D/2). The nearest grid94 center, with ties toward positive infinity, is floor((X mod m)/D)−H. The same X serves the entire cell. The construction also works at d=0.

Independent native Horner evaluation matched 202,130 complex values across six actual conductor and height combinations. This covers all reduced residues at height index 1 for conductors 131071 and 265800 and two original cells in each of four high cases. The stock kernel compared *all* centers within one selected cell per case. The six comparisons covered 423 complex values in total (two coordinates per value). There are seven interleaved trials per method and cell. The numbers below are median CPU microseconds per complex value, measured after statement preparation.

| Conductor | Height index | Complex values | Direct Horner | Modular with constants built inside the kernel |
| ---: | ---: | ---: | ---: | ---: |
| 131071 | 1 | 128 | 16.59 | 14.75 |
| 265800 | 1 | 68 | 17.32 | 14.85 |
| 131072 | 6337 | 64 | 26.84 | 19.39 |
| 131072 | 6400 | 64 | 28.45 | 19.02 |
| 131068 | 6337 | 52 | 34.60 | 23.10 |
| 100004 | 6400 | 47 | 34.23 | 22.72 |

The two ordinary high conductors matter. The power-of-two conductor has an unusually small reduced denominator. Literal modular constants took up to 92 µs per output on the ordinary high cells. Building the constants inside the checker avoided that cost. The comparison verifies concrete integer instances. The general modular identity above still needs a HOL theorem. Input admission, production of coefficient rows, other heights and the downstream transform require separate accounting. [HOL run](run02.log) · [Native comparisons and hashes](native.json)
