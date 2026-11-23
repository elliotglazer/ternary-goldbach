# Independent conductor-three major-arc review

2026-11-11. Bounded research/source audit against `work/ternary-goldbach`, baseline `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Reviewed `major-constants/RESUME_MAJOR_2026-11-11.md` and `resume_major_c3_20261111.py`. No Lean build or canonical edit. The conditional conductor-three argument passes this review. Its finite nonvanishing premise and analytic bridges remain unproved.

## Exact inducing-modulus normalization

There is one primitive character of conductor 3. It is real, nonprincipal and odd, so inversion leaves it unchanged and no pole term is subtracted from its primitive residual.

The source exact Gauss identity gives squared norm 3 precisely at levels q=3r with r squarefree and coprime to 3. In particular, every supporting q is squarefree. Pairing odd q=r and even q=2r with the same odd squarefree r gives two copies with equal phi and equal twist window. In Aplus the Fourier/main weight contributes phi(q)^(-2) and the spectral energy contributes 3/phi(q). Therefore the exact arithmetic step weight is

`W3(delta)=6 sum_{r odd squarefree<=150000, 3|r, |delta|<=600000/r} phi(r)^(-3)`.

Its support is [-200000,200000]. For r=3s with gcd(s,3)=1, phi(r)=2phi(s), giving the coefficient 3/4. Enlarging to the finite Euler product over allowed odd primes, multiplying by the missing p=3 factor 9/8, and applying the previously derived 32/27 product bound yields exactly `(3/4)*(32/27)/(9/8)=64/81`. The elementary bound behind 32/27 follows from the injective p-1=2m substitution, sum m^-3<=5/4, and product(1+a_i)<=1/(1-sum a_i). No prime-density input is needed.

This calculation includes every supporting inducing modulus, not only q=3 and 6. It has no extra conductor square-root saving. U(delta) already uses star scale delta/49, so no additional 49 is missing from the dimensionless Aplus block.

## Finite zero information and translated mass

The new required finite theorem is nonvanishing for `16/25<Re(s)<=7/8`, `|Im(s)|<=14,000,000`. Together with the global reflected 7/8 strip it bounds every low nontrivial zero by beta<=16/25. Equality at the left edge is allowed; equality at the height cutoff belongs to the low set. The tail starts strictly above that height.

For the odd completed function Lambda3, the conductor logarithm is negative at q=3 and the logarithmic-derivative gamma argument at s=2+it is 3/2+it/2. The digamma-series correction has decreasing summands `v^2/[(n+3/2)((n+3/2)^2+v^2)]`. Its first-term-plus-integral bound is `2/3+.5log(1+v^2/(3/2)^2)`. Recurrence and the half-argument value give psi(3/2)<1; thus the displayed completed-function upper bound `2+.5log(1+|t|/2)` is safe.

The positive finite-zero mass inequality requires the genuine completed-L symmetric logarithmic-derivative expansion with true multiplicities. It is mathematically appropriate for this real character, but the zeta-only `xi_partial_approx` cannot be instantiated to prove it. The note correctly leaves this Dirichlet analytic bridge open. It must include the gamma-factor cancellations and functional-equation symmetry rather than use the raw L logarithmic derivative as a positive-zero identity.

With that bridge, the .26 lower weight per zero in a 3.48 window gives fewer than 39 zeros including multiplicity in the stated height range. The total count bound 320 million, Gram row bound `16401112/7569<2200`, and all-phase Schur argument agree with the earlier reviewed actual-smoothing Gram construction. The real part beta+beta'-1 lies in [-3/4,3/4]. Multiplying the full low-sum norm by 1.2534 is valid; no entrywise weighted-Gram sign assertion is used.

The exponent is correct: twice beta-1 at beta=16/25 is -18/25. Consequently the sufficient majorant decreases for every x>=4.9e26. The exact scalar tests establish weighted low norm below .00031 and unweighted low norm below .00025. The alternative density moment D3 has the correct denominator `1.2534^2*2200`.

The Jensen fallback uses the actual Dirichlet growth polynomial, a 2.7 disk containing the full 3.48 strip window, at most 156 zeros per window, total below 1.3 billion and Gram row below 8800. Its stronger beta<=3/5 requirement gives exponent -4/5 and the same weighted .00031 allocation. This fallback avoids the new completed-L mass identity, but still requires the smoothing Gram bridge and its own unproved finite rectangle.

## Actual smoothing tail and explicit-formula terms

I checked `ZeroSums.BP`, `ExplicitBoundGen.polyDatum_L/VgL`, `EtaPlusMellin.norm_mellin_fP_tail` and `norm_mellin_fP_zero`, and the source 4.4-window constants. BP3 and kappa=11 are the appropriate Dirichlet quantities. They are not the zeta polynomial and exponent.

The tail threshold `200+max(10*pi*|delta|,50)<=14m` holds throughout |delta|<=200000. The shift by the actual bandlimit 200 is retained. The u>=22.2 reduction, EA and EB upper bounds, both geometric ratios and the 37-million count-sum allowance give coefficient sum below 3e-11. QRH then supplies the normalized x^(-1/8) factor. The bounded interval has length 400000, so multiplying by its square-root upper bound 633 and by 1.2534 produces the claimed weighted tail below 1.2e-11.

The contour has unnormalized x^(-1/2), hence normalized x^(-3/2). The VgL substitution uses DN3<20, Kv<105394 and thP>=1e-6. Dropping the harmless reciprocal 2pi only enlarges the upper bound. The source zero-at-zero Mellin bound is `Cg*300*(2aH)<39000`, and the BP3 Jensen bound supplies multiplicity below 50. After normalization this term is at most 50*39000/x, distinct from the contour. The combined weighted allowance below 1e-14 is safe. No unproved odd-parity zero-at-zero shortcut is being used.

The finite low estimate is full-line Plancherel, while the high estimate is only on the actual bounded twist interval. This separation is valid. The common good-height limit and Fatou still need formal measurability and limit bridges, but the bounds are uniform in the outer finite rectangle.

## Coprime transfer and final conductor-three caps

`ArcChars.coprime_split` bounds removed coefficients for every q<=300000 at the required x. Multiplication by character values of norm at most one gives the same 1e-15 normalized difference between the primitive sum and its induced coprime sum. This is an extension of the coefficient argument, not a literal invocation of the untwisted `norm_S_sub_coprime_le` as a character theorem. The note makes that distinction correctly.

Applying `|z+d|^2<=1.01|z|^2+101|d|^2` separately at each modulus, then summing, yields exactly the stated all-inducing upper expression. The replay value is

`12132625940082776143921003 / 158203125000000000000000000000000 <8e-8`.

For the nonprincipal energy N, the single lift has weight 3/phi(q)<=3/2, and there are at most 300000 moduli. Every supporting window is within [-200000,200000]. The unweighted low norm plus the tiny remainders and individual coprime correction is below .000251, so the crude bound `300000*(3/2)*.000251^2<.029` is valid. This N bound neither proves the full N<=1.23 target nor controls a mixed fourth moment.

## Caveat and status

The certificate-design sentence proposing a left edge strictly above 16/25 “together with a limit” requires a sequence or uniform family of certified rectangles approaching 16/25. One shifted finite rectangle leaves an uncovered real-part interval and does not prove F3. The explicitly proposed closed rectangle with left edge 16/25 is a sufficient stronger target and avoids that issue. This caveat was sent to the author; it does not affect the conditional estimates reviewed above.

I ran the exact script to completion, exit zero, including the Jensen fallback and N-block checks. Its JSON and printed tables are scalar evidence only. No actual zeros or nonvanishing rectangle were certified. The mathematical completed-L bridge, actual-smoothing Gram theorem, finite rectangle or sufficient density moment, carrier conversions and consuming Lean proofs remain open. All other conductors and Astar/Cross remain untouched.

Reviewed report SHA256: `AB386F8CF21CE4FE2B5B0BF7E31BDF44310AB82B0CF4ECC84FC6B7C12EEE42BC`.

Reviewed script SHA256: `93D8B70B0B281C7A17672EBE480E3F5C0DB97DAE6FBD0DFE82834FEDF57A528E`.

No new draft anchor, sorry, canonical import or sealed declaration was introduced by this review.
