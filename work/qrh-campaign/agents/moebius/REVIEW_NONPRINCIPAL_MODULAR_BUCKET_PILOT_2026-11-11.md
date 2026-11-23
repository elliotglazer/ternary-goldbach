# Review of the nonprincipal modular bucket pilot

2026-11-11. **PASS for the four fixed coefficient inputs. No correction required.** Independent higher-precision calculations reproduce all 32 unit signed buckets and all 10 matching-parity primitive-character contractions. The modular words, principal roots, exact characteristic phases, and both families of tail bounds pass the checks below.

This is external coefficient evidence. It is not an L-value, contour, winding, zero count, family spectrum, or Lean result.

## Frozen inputs and independent artifacts

Producer files in `../zero-sum/`:

* `NONPRINCIPAL_MODULAR_BUCKET_PILOT_2026-11-11.md`, SHA256 `67B8600CE22CBCEA5C18AC9B969746A93901D694C3B54CD244425A443F6B8448`.
* `nonprincipal_modular_bucket_pilot_20261111.py`, SHA256 `C214A9AE38D15A1F66ADE45CF697C422F8C8282253254A2D012035BBA937845F`.
* Its JSON receipt, SHA256 `FA310110205329FBD0E7D2710AF8267ED28E1C24320CEB7B4AE86E24486F126F`.

The independent script `review_nonprincipal_bucket_pilot_20261111.py` has SHA256 `C78B662CAB3705144E4C689DF433590D0D5E6C676974D1E9C3B8989F8CA44832`. Its JSON receipt has SHA256 `D7F32755F8FEF90C4242E2304ACFE9A71EE5C9E376DD48494C68A706B6724673`.

The script uses 224-bit balls, direct progression sums through |n|<=1024, and a second reduced characteristic sum through |k|<=20. The producer used 192 bits, |n|<=512 and |k|<=16. The independent run completed with status `PASS_INDEPENDENT_MODULAR_BUCKET_PILOT_ONLY`, checking 32 buckets, 10 primitive contractions, 16 modular word steps, 160 exact phase-trace entries, and all nine stored analytic-tail balls. It also independently encloses every stored 33-term finite characteristic sum.

Root separately reported a successful read-only producer replay with exact agreement in every non-timing receipt field. My checks do not depend on substituting that replay for the alternate calculations. No producer file was edited.

The inherited paper input is `integration/NONPRINCIPAL_THETA_MODULAR_BUCKETS_2026-11-11.md`, hash `2EADB0ACEE2B3C8275D9C8CFA815E4E3E7CC39C3CB0EBA0A86763A4877F74F09`, with independent review `FB6A7BD014A4417CD4D3AD2460C0785EDE3838226AA6F9013248863FB3135E70`. Both were read completely and their hashes are checked by the independent script. They identify the pinned Mathlib two-variable theta and its first-variable derivative, rather than a classical theta2 constant or an unproved scalar modular law for each bucket.

## Exact inputs and signed-bucket identity

The four cases are (c,H,r)=(5,64,0), (8,64,0), (5,1024,1/8), (8,1024,1/8). The input is

`b=pi/4-1/(H+1)`, `z=exp(2(r+ib))`, `tau=i c z`.

The independent calculation instead encloses the identical input by

`z=exp(2r)[sin(2/(H+1))+i cos(2/(H+1))]`.

This avoids subtraction of nearby phases and uses separate real sine and cosine evaluations. The resulting z and tau balls are contained in the corresponding producer balls. Their real and imaginary positivity conditions are certified.

Reindexing n=R+ck gives exactly

`B_(R,a)(z)=c^a H_a[R/c,0](i c z)`.

There is no extra factor c in the even channel. Both a=0 and a=1 are checked for all four units of each modulus, hence eight buckets per input. The experiment does not claim to compute nonunit buckets or to implement the alternative mixed finite-vector modular transformation.

## Modular words, roots, and phases

The independently replayed words are:

| c,H | Word, where T(n) subtracts n |
|---|---|
| 5,64 | T(-5), S, T(0) |
| 8,64 | T(-8), S, T(0) |
| 5,1024 | T(-6), S, T(2), S, T(-3) |
| 8,1024 | T(-10), S, T(4), S, T(2) |

Every translated ball satisfies |Re(tau)|<3/5. Before each inversion, Im(tau)<1/2 is certified; after it, the imaginary part increases by more than 100/61. Every terminal ball satisfies Im(tau)>2/5. The independent script also composes the exact integer matrices, checks determinant one after every step, and compares the resulting fractional-linear action with the interval trajectory. The matrix is only a check on the argument transformation; it does not replace the ordered root factors.

At S, the root input w=-i tau has positive real part. Instead of using the producer's complex square-root call, the independent calculation constructs

`u=sqrt((sqrt(Re(w)^2+Im(w)^2)+Re(w))/2)`,

`sqrt(w)=u+i Im(w)/(2u)`.

Since u>0 this is the principal root. All root inputs, roots, inverse-root factors, and v=-1/tau factors are enclosed in their stored producer balls. The even common factor multiplies by 1/sqrt(-i tau); the odd one also multiplies by v. In particular the odd factor has the required minus sign. No global square-root replacement or unstated branch choice occurs.

The T phase update is `-n alpha(alpha-1)/2` in turns, and beta changes by `n(alpha-1/2)`. Expanding the summand leaves an integer-even exponent n k(k+1), confirming the sign. The S update adds alpha beta and replaces the pair by (beta,-alpha). The odd-channel source derivative has its value terms cancel, leaving exactly the v moment factor.

After each step, centering alpha and beta adds `alpha_new*q0` turns, where q0 is the removed integer from beta. This is the correct elliptic phase; the removed alpha integer contributes no additional noninteger phase. The independent rational replay matches every stored label, integer shift and phase, and checks that characteristic denominators divide 2c. Nonzero terminal beta values remain in the additive phase. They are never silently reset to zero.

## Reduced-series and direct-progression enclosures

At the reduced argument, the Gaussian coefficient exceeds gamma=6/5. Centered characteristics imply that each omitted shifted index has magnitude at least N+1/2. The common even/odd tail

`2 exp(-gamma u^2/2)/(1-exp(-gamma(2u+1)/2))`, with `u=N+1/2`,

is valid for both moments. The odd bound uses `t exp(-gamma t^2/2)<=1`; the remaining Gaussian terms form a dominated geometric progression. This is a bound for a complex norm error. The square added to the interval sum contains its disk.

I recomputed the producer's N=16 tail and all eight producer direct-tail bounds at 224 bits. Each lies inside the stored ball. The quoted `E_red<2.286e-71`, multiplier norms below 194, and reconstructed analytic tail below 4.435e-69 all check. Multiplication by the actual interval common factors, phase, and c^a retains root/input/arithmetic uncertainty as well as that analytic tail. The new N=20 reconstruction is contained in each producer modular bucket.

For an independent direct tail, use the weaker rational lower bound

`d0=3/[c(H+1)] < pi Re(z)/c`.

It follows from r>=0 and `sin(u)>=u/2` for u=2/(H+1)<=1. The independent script also checks the strict inequality against its input ball. With J=1024, the successive absolute positive-tail ratio is at most

`rho_a=((J+2)/(J+1))^a exp(-d0(2J+3)) < 1`.

Thus `E_a=(J+1)^a exp(-d0(J+1)^2)/(1-rho_a)` bounds the full omitted positive tail. Twice that amount safely bounds each signed residue tail, without assuming equidistribution. A positive character sum needs only E_a because its character values have norm at most one.

The independent finite sum enumerates each actual progression n=R+ck with |n|<=1024, retaining the sign of n in the odd moment. Real amplitude and phase evaluations implement exp(-pi n^2 z/c). All 32 resulting enclosures are contained in their producer direct-sum enclosures. Each new direct enclosure overlaps the new modular enclosure, and the norm of the entire difference ball is less than 1e-50.

The producer's stronger d0=9/[2c(H+1)] is valid too: `sin(u)>=u-u^3/6>=3u/4` on the stated interval. Its largest positive-tail bound is below 2.266e-60 as claimed. Independent agreement is supplementary evidence. Correctness of both enclosures rests on the exact identities, rigorous tails, and interval arithmetic, not on overlap alone.

## Actual characters and the factor one-half

For c=5, I independently enumerate the unit powers of 2 and the four characters `chi_k(2^j)=i^(kj)`. Every multiplication-table identity passes. The nonprincipal labels k=1,2,3 have conductor 5; their parities are k modulo two. Labels 1 and 3 are nonreal inverses, while label 2 is real and even.

For c=8, the unit coordinates are `7^u 5^v`, with u,v in {0,1}. The characters have phase `(k u+l v)/2`. Exact unit-fiber checks at every divisor give conductor 8 precisely for labels (0,1) and (1,1); (1,0) has conductor 4 and (0,0) conductor 1. This checks actual factorization through smaller unit groups rather than relying on a presumed number of primitive labels. Values on nonunits are zero.

For matching parity `chi(-1)=(-1)^a`, the negative n terms in the signed contraction equal the positive terms. Since chi(0)=0 here,

`sum_R chi(R) B_(R,a)=2 sum_[n>=1] chi(n)n^a exp(-pi n^2 z/c)`.

The factor one-half is therefore applied after character contraction, not to each positive residue bucket. It is also separate from every DFT normalization; no FFT is executed in this pilot.

All ten matching-parity contractions were independently recomputed using both the new modular buckets and direct positive sums. Their enclosures are contained in the respective producer enclosures, overlap each other, and have difference-ball norm below 1e-50. Opposite-parity signed contractions contain zero, consistently with the exact cancellation identity, and are not reused to evaluate positive theta sums. No same-input complex-conjugacy shortcut is used for the two nonreal c=5 labels.

## Scope and reproduction

Run the independent check with:

```
work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/moebius/review_nonprincipal_bucket_pilot_20261111.py
```

The completed run took less than a second of reported shell wall time. It used elementary ball arithmetic only, including real square roots, exponentials, sine and cosine. There is no builtin theta, zeta or L-function oracle. Runtime at these four tiny coefficient cases says nothing about production throughput.

The approved domain is exactly the four fixed z inputs, all unit signed buckets in their two parity channels, and the ten listed primitive contractions. The modular word is verified on each input enclosure, not on an untested parameter panel. Source wrappers, formal interval-engine verification, all-height coefficient generation, contour coverage, and spectral evidence remain separate obligations. No Lean/Lake build, dependency change, canonical edit, contour, or spectral scan was performed.
