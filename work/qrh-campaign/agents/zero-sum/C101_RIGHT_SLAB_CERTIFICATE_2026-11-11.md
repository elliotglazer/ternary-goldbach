# One conductor-101 character: complete right-slab certificate

2026-11-11. **PASS for the stated external single-character slab certificate.** All four sides are certified nonvanishing and their closed image polygon has exact winding zero. This packet concerns one fixed actual character on one fixed rectangle. It does not certify an initial height interval, Hcert(101), any other character or the full family. No Lean build, dependency change or frozen-file edit is used.

## Character and exact domain

The character was selected before any evaluations in this experiment. It is label k=1 from the accepted conductor-101 block:

\[
 \chi_1(2^j\bmod101)=\exp(2\pi i j/100),\quad 0\le j<100,
 \qquad \chi_1(0)=0.
\]

The positive exponential convention, generator 2 and label are unchanged. The pinned code checks primality of 101, bijectivity of the generator's 100 powers and 2^50=-1 mod101. This is a nonprincipal, primitive, odd, nonreal character. Its inverse has label 99 and is not silently substituted. The actual function is the uncompleted continued Dirichlet L-function L(s,chi_1), without a root phase, gamma factor or extra s-1 factor.

The requested rectangle is exactly

\[
 [111/200,2]+i[7999/8,8001/8]
   =[.555,2]+i[999.875,1000.125].
\]

The previous accepted packet certified only the left vertical line segment, for all 99 characters. This experiment recomputes the selected character's boundary and includes all four sides. It does not infer the three new sides from the old line certificate.

## Pinned evaluator and source bridge

The script checks the SHA256 of `c101_cauchy_alpha_block_20261111.py`, then executes only its definition/table prefix before the original run starts. It reuses the explicit EM, alpha-grid and elementary interval functions; it never invokes the old all-character experiment. That prefix contains no builtin zeta, Hurwitz, L-function or zero oracle.

Pinned predecessor artifacts:

* `C101_CAUCHY_ALPHA_BLOCK_2026-11-11.md`: `4F73C1FA9C8D8C1C5ECCD22DB0348FCAC52108C126B840E5BC419FCD9968BF5B`.
* `c101_cauchy_alpha_block_20261111.py`: `FD75DAC17AF6735E9A5AE72E5A47096592609D2371CD5A65643B544F5B8F4E11`.
* `c101_cauchy_alpha_block_20261111.json`: `087C2577D42CFB22CA9BA2E0E00D17BD9C5C9585C4BAB854920A3E26131E2F84`.
* `../moebius/C101_CAUCHY_ALPHA_REVIEW_2026-11-11.md`: `A27762CDE69D0E903A515487F4192F4B48AAD25F508EBE80E128A0C5FC8A2B4E`.

The scalar input is the entire common-pole-deflated Hurwitz expression obtained by explicit Euler--Maclaurin. The nonprincipal combination is

\[
 101^{-s}\sum_{j=0}^{99}\exp(2\pi i j/100)
       [\zeta(s,a_j/101)-1/(s-1)],\qquad a_j=2^j\bmod101.
\]

It equals L(s,chi_1) first in Re(s)>1 by absolute convergence and the exact zero sum of character values, and then throughout the plane by analytic continuation. This does not identify an individual deflated Hurwitz value at s=1 with Mathlib's different totalization convention. The common correction cancels in the actual character sum.

The retained scalar parameters are EM N=512, M=40, 160-bit ball arithmetic, alpha shift A=16, 16 alpha cells and 32 coefficients per cell. At shifted index k, the EM error is bounded using sigma_floor+k, where sigma_floor=61/200. For B=N+alpha, it is

\[
 \frac{4|(s+k)_{80}|B^{1-(61/200+k)-80}}
 {6^{80}(61/200+k+79)}.
\]

All finite sums, Pochhammer factors, exponentials, logs, common-pole terms and their arithmetic errors are carried as balls. The real-alpha Taylor error is bounded by the retained exact rational

\[
 E=\frac{2\prod_{j=0}^{31}(1002+j)}{512^{32}32!}<10^{-25}.
\]

It is added to each alpha evaluation before applying the character sum. The mathematical justification of these enclosures is the one checked in the predecessor review; the new domains below explicitly satisfy its assumptions.

## Six disks and new domain checks

Let x_j=111/200+j(289/1200), j=0,...,6, and let c_j=(x_j+x_(j+1))/2+1000i. The six centers are rational and fixed independently of any evaluated values. At each center use

\[
 R=1/2,\quad \rho=1/4,\quad r=1/5,\quad m=64.
\]

The first center has real part 1621/2400. Therefore the outer disk's least possible real part is 421/2400>11/200, and the sample circle's least real part is 1021/2400>61/200. The last center is less than 2. On every sample circle, |s|<=|c_j|+1/4<1001+1/4<1002, because Re(c_j)<=2 and Im(c_j)=1000. Thus both the old EM floor and the old alpha numerator bound are valid without extrapolation.

Every outer disk lies in Re(s)>11/200 and has |s|<1003. The actual source theorem `TernaryGoldbach/Explicit/LGrowth.lean`, `norm_LFunction_le`, gives

\[
 |L(s,\chi_1)|\le102|s|/\Re s
 <102(1003)/(11/200)<2,000,000=M.
\]

This bound is for the actual continued L-function. It is not asserted for a finite EM approximation. EM is used solely to enclose actual sample values; the Cauchy model is then a model of actual L.

For each horizontal piece, the displacement from its center has real part at most 289/2400 and imaginary part exactly 1/8. The exact inequality

\[
 (289/2400)^2+(1/8)^2<(1/5)^2
\]

puts the complete horizontal piece in the target disk. The left and right vertical sides similarly lie in the first and last disks. Disk convexity covers each segment between its checked endpoints.

## Actual-function Cauchy enclosure

At center c_j, the 64 exact sample points are c_j+rho*omega_l, with omega_l=exp(2*pi*i*l/64). Explicit EM/alpha balls enclose each value of actual L there. Character and circle roots use elementary exponential ball enclosures with the displayed positive signs.

The polynomial coefficients are enclosed by the direct finite sums

\[
 b_n=\frac1{64}\sum_{l=0}^{63}L(c_j+\rho\omega_l)\omega_l^{-n},
 \qquad 0\le n<64.
\]

The model is sum b_n((s-c_j)/rho)^n. Cauchy's estimate and exact root orthogonality give the uniform disk error

\[
 A=\frac{M}{1-r/R}
 \left((r/R)^{64}+\frac{(\rho/R)^{64}}{1-(\rho/R)^{64}}\right)
 <2\cdot10^{-13}.
\]

The script evaluates A as an exact rational, carries the interval coefficient errors, and adds a square enclosure of the analytic error disk to each Horner evaluation. In particular, enclosing an entire segment in its complex coordinate box followed by ball Horner evaluation covers every point of that segment. Acceptance is not based on endpoint samples.

## Closed polygon and zero count

The producer traverses the bottom six pieces rightwards, the right side upwards, the top six pieces leftwards and the left side downwards. Adaptive subdivisions preserve that orientation and cover the exact original sides. Shared rational source vertices receive a single shared dyadic image vertex, chosen from a point enclosure's midpoint and reused thereafter.

Every accepted panel must satisfy two conditions for a recorded coordinate/sign: its entire actual-function enclosure lies in the corresponding strict half-plane, and both of its stored dyadic image vertices lie in that same half-plane. The dyadic vertices need not equal the actual function values. At a shared endpoint, the actual value and the stored vertex lie in both adjacent panels' half-planes. Endpoint connector segments therefore lie in the intersection, and the panelwise homotopies glue to a closed homotopy avoiding zero.

The replay checks exact source-side membership and direction, complete adjacency and closure, exact perimeter, every regenerated whole-panel inequality, and shared dyadic image vertices. The exact image-polygon winding uses half-open positive-ray crossings. The accepted generic bridge is `../major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md` (SHA256 `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B`) and its independent review (SHA256 `F75647007C294E13132B984A0F6241B516D5113D789AECA922B4DA265A5E73F0`).

Since this nonprincipal L-function is entire, the argument principle identifies the winding with its number of interior zeros, with multiplicity and no pole subtraction. Whole-boundary nonvanishing also covers the closed rectangle edges. A winding of zero therefore proves nonvanishing throughout the stated closed slab under these external analytic and arithmetic contracts.

## Reproduction and limits

The new files are `c101_right_slab_20261111.py/json`. Running the script produces a new receipt; `--replay` instead reads the existing receipt, regenerates the six models and rechecks its panels and winding without rewriting it. The script verifies the predecessor evaluator hash before using its definitions. It imposes a 540-second internal computation limit, 10,000 panel calls and depth 20. These limits do not expand or shrink the requested domain. A failure records `INCOMPLETE`; acceptance requires the explicit pass status and all checks.

Only the new producer, receipt and this note are written. The full sample vectors and coefficient balls are regenerated rather than stored, so this is not yet a small standalone proof object. Python/FLINT arithmetic, the analytic EM/Cauchy adapters and the polygon-to-source bridge are external, not Lean-kernel-checked.

## Completed run and frozen artifacts

The producer exited with code zero and status `PASS_EXTERNAL_SINGLE_CHARACTER_SLAB`. It constructed all six models, accepted 16 boundary panels from 18 panel calls, and computed exact winding zero. Its verification routine then rechecked every recorded panel, the shared polygon and its count against the generated models before the receipt was written.

| Quantity | Measured result |
|---|---:|
| Actual L sample enclosures | 384 |
| Cauchy models | 6 |
| Accepted full boundary panels | 16 |
| Panel calls | 18 |
| Exact winding | 0 |
| Model construction times | 17.13–18.43 seconds each |
| Producer internal elapsed time | 107.44255 seconds |
| Largest sample real-plus-imaginary radius, diagnostic | 1.211e-24 upper rounded |
| Receipt size | 15,275 bytes |

The timer starts after loading the pinned definition/table prefix and ends before the final cached-model replay and file serialization. It is a bounded single-run measurement, not production throughput. The process finished normally within the authorized computation budget. No second full sample run was started by the producer; the independent reviewer can use different EM and Cauchy parameters.

Frozen new files:

* `c101_right_slab_20261111.py`: SHA256 `8CCFDD54A75E0A71B88959EA8B2DC762DB46D630B47CABE31E3526570D4C9B9F`.
* `c101_right_slab_20261111.json`: SHA256 `FA01A922E0BDDDF2104A268938AE6C76323D51DA2B48536B17708BC6D7A3ADC2`.

From the repository root, read-only replay is:

```powershell
& work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/c101_right_slab_20261111.py --replay
```

The result exercises the direct contour fallback on an actual L-function, rather than a synthetic polynomial. It establishes only that this one closed slab contains no zero of this one character, under the stated external enclosure and winding contracts. The intervals below 999.875 and above 1000.125, the negative-ordinate channel, and every other character remain outside its scope. In particular, this is not a certificate for all zeros through Hcert, and is not a replacement for the full-family spectral evidence.
