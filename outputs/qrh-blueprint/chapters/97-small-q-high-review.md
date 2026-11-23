# Independent small-denominator high-twist review

Verdict: PASS as a conditional paper and exact scalar certificate. No mathematical defect was found in either high-twist rectangle or its overlap with the stated finite-zero prefixes. Both exact replays matched every field of the frozen producer JSON. This is not a Lean proof, a finite spectral certificate, or a completed Platt-free minor-arc theorem.

The primary rectangle suffices for the remaining reduced denominators Q=2,3 under the sharper finite-family profile. The second rectangle also validates the independent backup using the older transform bound 4. Both profiles retain the same unresolved uniform finite `beta<=111/200` assertion and genuine global QRH. They are not applications of the alternative weighted spectral condition.

## Frozen artifacts and replay

Paths in this table are relative to `work/qrh-campaign/agents`.

| Input | SHA256 |
|---|---|
| `moebius/RESUME_SMALL_Q_HIGH_2026-11-11.md` | `ccf603c0a6cd5fce9d0ad35bd0bf92b3ac3509d6e6c44ea4ccb361c7462faaf2` |
| `moebius/resume_small_q_high_certificate.py` | `384548e16140cb18ba6964cb805c391b476864c68ee36ce1f1c902c85e05faa3` |
| `moebius/resume_small_q_high_certificate.json` | `6f9ffe0269e0da8f9afc9e7dacad42840c4e521505b6f7855dbd1fc5f2664fee` |
| `zero-sum/resume_base_gap_finite_family_20261111.json` | `be725be94d16589c47e4f2387559b994bba8f75a008121d100930313935cfb7a` |

The finite-family derivation inspected for normalization and the primary joins is `zero-sum/RESUME_BASE_GAP_FINITE_FAMILY_2026-11-11.md`, SHA256 `09340d4135d7e895e6f3fda660de9a7f773a91ff41f3b88fc125c814884d5e74`. Source references below are relative to `work/ternary-goldbach/TernaryGoldbach`, campaign pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

`resume_small_q_high_review_20261111.py` independently executes the producer with all writes redirected into this review directory, checks equality of the entire saved JSON, and verifies that the four frozen inputs remain unchanged. It then recomputes the Q=2,3 finite-prefix bounds and all 19 backup joins from exact fractions. It exited zero. The replay JSON and log, plus a review JSON containing hashes and the join budgets, are retained beside this note. No Lean was run and no canonical source was edited.

## Phase, denominator, and smoothing normalization

The original rational modulus is m, and the reduced denominator of `2 alpha` is `Q=m/gcd(m,2)`. Write `alpha=a/m+d/y`, `Delta=2d`, and `u=Q*|Delta|`. If m is odd, then m=Q. If m is even, then m=2Q. Thus Q=2 arises from original modulus 4; Q=3 arises from original modulus 3 or 6. The character expansion for the finite branch uses the original modulus, while Approx2 for the raw branch uses the reduced Q.

The parity-specific arc radii give `1200000/49<=u<1200000` in both cases. One must retain these radii from the proof of `BaseGap2.gap_point`; its relaxed exposed conclusion alone loses a factor two for even original modulus. The finite Mellin twist is `|d|=u/(2Q)` at scale y, with no further division by 49.

`etaStar(t)=etaU(49t)` yields `S_etaStar(alpha,49y)=sum Lambda(n)etaU(n/y)e(n alpha)`. For the eta2 convolution, `z=wy` and the Approx2 twist is `delta_z=w*Delta`. Therefore

`delta0(delta_z)*Q = max(2Q,wu/4)`.

On both new rectangles, `.02<=w<=8` and `u>=300000` imply `wu/4>=1500>2Q` for every Q<=39. The simplification `t=wu/4` is exact. There is no residual Q factor missing from the twist parameter or from the Gaussian integration measure.

## Source coefficients, including odd Q

I checked the actual statements of `FirstChoiceTypeI1.typeI1_first:227`, `FirstChoiceTypeI2c.typeI2_first:16`, `FirstChoiceTypeII.typeII_first:329`, and `Assembly.norm_S_le_parts:64`. Summing their right sides and dividing by z gives exactly the producer's raw envelope with `f=Q/phi(Q)`:

`sqrt((f/t)*(C*(log t+.002)+log(4t)/2)*(.30214 log t+.7468))`

`+2.5257/sqrt(t)+13.2*f/t+2*(16.267 log t+24.42)/t`

`+3.77*z^(-1/6)+3*log(z)/z`.

The constants satisfy `13.2=2*(3.8+2.8)`, `16.267=1+15.267`, `24.42=2.96+21.46`, and `3.77=.014+.556+3.2`. The assembly residue is retained.

The earlier Type I expressions contain `2Q/phi(2Q)`. The conversion to the displayed coefficient is already justified by `FirstChoiceTypeI1.xphi_le:104`, using `minInv<=2/delta0` and `phi(Q)<=phi(2Q)`. It does not use equality of the two ratios. In particular:

| Q | Q/phi(Q) | 2Q/phi(2Q) |
|---:|---:|---:|
| 2 | 2 | 2 |
| 3 | 3/2 | 3 |

Thus the Fmax=2 substitution is valid for Q=3 despite its Type I ratio being 3. The script records both ratios for all Q from 2 through 39. Every one has reduced ratio at most 15/4. No incorrect even-denominator identity is being reused for odd Q.

The three first-choice estimates retain their original analytic inputs and source `Fact PlattGRH` dependency until the campaign's replacement proofs are supplied. This audit validates their scalar consequences, not an unconditional invocation of those source theorems.

## All source domains and monotonicities

On the central convolution interval, `z>=2e23`, so `T=z^(1/3)>58000000`. Consequently `T>6e6`, `Q<=39<T/6`, and `Q<3T^2/4`. The phase error satisfies `wu<=9600000<4T/3`, which is exactly the remaining Approx2 inequality at approximation bound `3T^2/4`. Coprimality and the integer phase identity come from the parity reduction. The first-choice `V1<=9T/2<=T^3/4` supplies the extra assembly hypothesis. Thus the smaller lower convolution cutoff .02 has been accounted for in every size condition.

The raw bound increases with f, since its only f-dependent terms are a positive multiple of `sqrt(f)` and `13.2*f/t`. It is therefore safe to use Fmax=2 or 15/4 without any monotonicity claim about phi itself.

For monotonicity in u, fix z and set `ell=log t`, `a=.5*log(4t)`, `v=log(9*z^(1/3)/(2.004*t))`, and `C=log(1+a/v)`. The whole rectangle has `ell>6` and `v>4`. One direct bound, independently of the producer's equivalent argument, is

`C'/C <= .5/a+1/v <=1/ell+1/v`.

It follows from `log(1+r)>=r/(1+r)`, with derivatives in ell. The first positive bracket `A=C*(ell+.002)+a` has `A'/A<=2/ell+1/v`; the second bracket has logarithmic derivative at most `1/ell`. Thus the logarithmic derivative of their product divided by t is at most `3/ell+1/v-1<0`. This proves monotonicity with the actual varying C. The remaining terms involving t decrease separately. The entire high interval is therefore bounded by its lower endpoint u=300000 or u=600000.

Within each w bin, C decreases with z and increases with t. Its upper bound at `z=w_lo*y,t=t_max` can therefore be frozen. With C frozen, the leading product divided by t decreases because its logarithmic derivative is at most `2/ell-1<0`. Evaluating all other t-dependent terms at t_min is safe.

The all-scale coordinate `r=1/(log(y)/3+log(9/601200))` maps every finite y>=10^25 into the checked compact interval. Adding r=0 only adds a limiting endpoint. For each bin the denominator `1+hr*r` stays positive; the script checks this even when hr is negative. The function `r/(1+hr*r)` is increasing there. Thus upper r endpoints bound the raw integrand and lower r endpoints bound the increasing ghat allowance. All 32 cells are genuine interval comparisons, not samples of y.

## Integration and exact margins

The 399 bins cover `[.02,8]` without a gap. Their mass is the integral of `w^2*exp(-w^2/2)`, as required after division of the convolution estimate by y. The previously reviewed Simpson enclosure has fourth-derivative allowance 84 and error `84*h^5/2880`. This follows from the derivative polynomial `w^6-14w^4+39w^2-12` and its Gaussian maxima. Positive Taylor lower sums give upward exponential mass bounds. Both omitted tails use the elementary coefficient 17, with total

`17*.02^3/3+17*(65/8)*1e-13`.

The independent exact replay reproduced all 64 scale cells and the following minimum positive gaps:

| Ratio cap | High interval | Minimum gap | Scale cell |
|---:|---:|---:|---:|
| 2 | 300000<=u<=1200000 | .001018323773 | 4 |
| 15/4 | 600000<=u<=1200000 | .005696694314 | 10 |

The lower allowance is the reviewed all-y affine-in-R lower bound for the actual `ghatY(y,150000)`. The diagnostic floating script does not participate in these acceptance comparisons.

## Primary and backup joins

For the sharper finite profile, the actual etaU moment interpolation gives `|F_U|<13/8` on the reflected finite strip `[.445,.555]`. This is a different constant from the ratio cap Fmax. The inspected finite-family formula, including Gauss weights and removal errors, gives closed prefixes:

| Q | Finite prefix endpoint | High start | Overlap length |
|---:|---:|---:|---:|
| 2 | 972954 | 300000 | 672954 |
| 3 | 1068377 | 300000 | 768377 |

I recomputed each endpoint budget exactly from the family formula, checked it is at most `.04712`, and checked that increasing the integer endpoint by one fails this particular bound. This verifies the recorded prefixes rather than merely comparing two table labels. At Q=2 the Gauss weight is exactly one and the principal Fourier coefficient vanishes. At Q=3 the weight upper bound encloses `(1+sqrt(3))/2` and the principal coefficient is one half; original moduli 3 and 6 have the same relevant magnitudes. These normalizations agree with the original-modulus reconstruction.

The finite height `H(Q,U)=max(250,ceil(242U/(7Q)))` and count `ceil(400*(2H/3.48+2))` are monotone in U. Therefore each accepted integer prefix bounds every real u below that endpoint in the gap. The endpoint is included. The high interval also includes its start, so there is no missing real or integer boundary.

As an independent backup, the older transform cap 4 leaves 20 denominators, including Q=1. The already reviewed q1 hybrid handles that denominator. I recomputed the other 19 endpoint budgets and their budgets at the assigned high start. Every one passes and every overlap is nonnegative. Thus the two high rectangles also fit the older finite-family profile without relying on the sharper interpolation. The script deliberately keeps this backup ledger separate from the primary Q=2,3 joins.

The full finite-family enumeration and its spectral/analytic bridges remain separately reviewed inputs. This bounded audit establishes compatibility and the high-band scalar implications; it does not certify actual zero locations or claim that all 150000 denominator theorems have been formalized. The genuine global QRH provider, uniform finite .555 certificate, Type I/II producer replacements, analytic interval-integration lemmas, and formal source adapters remain explicit proof obligations. The unrelated prime/Möbius envelope gap `[1e9,exp(35))` is unaffected.
