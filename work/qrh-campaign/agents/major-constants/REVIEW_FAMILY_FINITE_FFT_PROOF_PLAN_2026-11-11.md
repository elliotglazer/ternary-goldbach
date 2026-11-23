# Independent review of the finite family FFT proof plan

2026-11-11. **PASS as finite algebra, deterministic error analysis, and a fixed-Hcert scalar design.** No correction is required. This does not certify an actual coefficient packet, transform trace, sign, zero count, runtime, or Lean implementation. I ran no FFT, twiddle table, L-function evaluation, build, or scan, and changed no frozen author file.

## Frozen inputs and source inspection

Reviewed `moebius/FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md`, SHA256 `6E303D60C855E2CAD444EBC4EB3B1A3BD192D9BEAFAE0448F3F6D63CD9CDAC2E`; its scalar script has SHA `A7D160D81FAB8D1EEC287FF0380FCC11A528C1CF682428D529EB939A03943EF6`, and its receipt SHA is `135E736D19975DB598AE2F49EE540CB8E0570E28CE04E013280BE1E600EFB184`. All three hashes were checked. I read the script but did not execute it, since doing so rewrites its frozen receipt.

The reviewed analytic predecessor is `zero-sum/FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md`, SHA `E7D5CD24F5FAA6B75ED5E1167F3165EACBD7BCA7FEDF73D521C6B74BD04776EF`, with independent review `moebius/REVIEW_FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md`, SHA `A1B71C24E818CD5628C7A5F5B24105E19BDF5FC4840CCFC47239CAB435A85B33`. I checked its fixed example: the coefficient envelope `|G(x)|<=10^8`, time-alias bound, frequency-tail bound, and common Gaussian-series cutoff are indeed the inputs used in the new finite plan. I did not re-prove that entire analytic predecessor in this review.

In pinned Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, I inspected `Analysis/Fourier/ZMod.lean:114`, `invDFT_apply`. It is exactly `(N:Complex)^(-1)` times the sum with `stdAddChar(j*k)`, whose convention in that file is `exp(2*pi*i*j*k/N)`. The new algorithm's positive exponent and normalization agree. This supplies the intended library target, not a proof that an arbitrary external FFT library implements it.

## Exact indexing and stage invariant

Here N is a positive power of two; the fixed protocol gives N>=1028, so the centered even-size indexing has no N=1 exception. The map `j(k)=k` for `k<N/2`, and `j(k)=k-N` otherwise, is a bijection onto the integer block `[-N/2,N/2-1]`. The negative Nyquist coefficient is included exactly once. For integer m, changing j by N changes the phase by `exp(2*pi*i*m)=1`; no extra phase accompanies this permutation.

I reconstructed the stage induction explicitly. Let ell denote the **target stage**, put `h=d-ell`, `m=2^ell`, and let b be its block label. The two input subblocks from stage ell-1 have base indices

```
rev_(h+1)(2b)   = rev_h(b),
rev_(h+1)(2b+1) = rev_h(b)+2^h.
```

Their strides are `2^(h+1)`. Therefore their entries correspond respectively to the even and odd j terms in

```
(1/m) sum_(j=0..m-1)
  a_(rev_h(b)+2^h*j) * exp(2*pi*i*j*r/m).
```

The preceding subblock phase `exp(2*pi*i*j*r/(m/2))` is the even-j phase. Multiplying the odd block by `exp(2*pi*i*r/m)` gives the odd-j phase. For output r+m/2 the even phases are unchanged and the odd phases acquire a minus sign. Simultaneous butterflies with the factor 1/2 thus give exactly both outputs and the normalization 1/m. The base ell=0 is the bit-reversed input; ell=d gives one block and the desired inverse DFT in ordinary output order.

The binary-reversal identities follow by writing the h binary digits of b: appending a low zero or one before reversal puts that bit at position h. No numerical transform test is needed for this induction. The author text's stage notation is interpreted with ell as the target stage in this step, as the displayed subblock identities require.

The final scale is correct. At `t_m=m*P/N`, the finite Fourier inversion sum is `omega*sum_j C_j*exp(2*pi*i*j*m/N)`. A normalized inverse DFT divides by N, so its output must be multiplied by `s_fft=omega*N`. Negative integer time labels use residues modulo N. Only the finite transform is periodic in that label; the proof does not assert periodicity of F or off-grid coverage.

## Independent deterministic error derivation

The exact rational centers are the reference input for the arithmetic algorithm. Bit reversal is an exact permutation, so arithmetic E0=0. The difference between the exact transforms of the true coefficients and their centers is separately bounded by `(1/N)*sum r_j`. After output scaling this is `omega*sum r_j`. It need not be amplified by twiddle errors, because the proof compares to the exact center transform in a separate triangle-inequality term.

All ideal normalized intermediate entries have norm at most `B=max|a_k|`, by the exact invariant or convexity of each butterfly. At one stage, with actual unit twiddle zeta and center zetahat satisfying `|zetahat-zeta|<=delta`, write

```
zetahat*vhat - zeta*v
  = zetahat*(vhat-v) + (zetahat-zeta)*v.
```

Since `|zetahat|<=1+delta`, the butterfly's output error is at most

```
(1+delta/2)*Eprev + delta*B/2 + rho.
```

This proves the author's recurrence for either sign. Iteration gives its product-sum formula with factors from the later stages. It remains valid for arbitrary nonnegative stage bounds and does not use d<=36. The alternative per-entry disk formula also checks: expanding instead with exact zeta gives radius `(ru+rv+delta*|vhat|)/2+rho`. These are two valid deterministic estimates; neither assumes independent rounding errors or assumes the rounded twiddle is itself unit.

For the final scale and product, expansion gives

```
|V-s_fft*Y| <= s_fft*Ed + delta_scale*(B+Ed) + rho_final.
```

The coefficient envelope and proposed radii imply `B<100000001`. This use of B is conditional on genuine coefficient enclosure packets or a direct proof of the center norm bound; the paper does not claim the packets exist already. The shared phase, pi enclosure, and reused character values may introduce correlations, but none affects these pointwise bounds.

## Twiddle construction and outward rounding

Componentwise `floor(2^180*q)/2^180` has absolute error below `2^-180` for every signed rational q. Using the sum of component errors bounds the complex norm by `2^-179`. Floor inequalities can be checked exactly by integer cross multiplication. A floating implementation receives no automatic permission to use this bound.

The 50-term alternating arctangent polynomial has terms j=0,...,49, hence last degree 99 and first omitted degree 101. Integrating the exact finite geometric remainder gives the stated `x^101/101` bound for `0<=x<=1`. Machin's identity has the correct factors 16 and -4. For its branch check, `4*atan(1/5)-atan(1/239)` is positive by monotonicity and below `4/5<pi/2`; its tangent is exactly 1, so it equals pi/4. The intermediate double-angle denominators are nonzero because the angles stay in this same first-quadrant range.

The pi-center error is therefore the stated rational `e_pi`. My independent scalar checker bounds the author's 50-term center between short two/three-term alternating enclosures rather than recomputing all its terms; these prove `3<pi_hat<22/7`.

For a stage twiddle, `0<=r<mlen/2` gives `0<=theta_hat<pi_hat<22/7`. The polynomial includes degrees 0 through 64; its first omitted term has degree 65. Every subsequent absolute-term ratio is at most `(22/7)/66<1`. Thus the geometric tail in the author note is valid without an omitted factor `exp(22/7)`. The angular error is at most e_pi, because `2*r/mlen<1`, and the real-axis exponential Lipschitz bound transports it directly to the complex unit exponential. Adding the polynomial and dyadic-rounding errors proves delta=`10^-52`. No numerical twiddle evaluation or actual table is needed to prove this uniform construction.

The scale center uses real rounding, so its last error is `2^-180`, not the complex `2^-179`. Since `2*N/P<16`, its pi error is at most `16*e_pi`; the sum is below delta. The final complex product is rounded separately, as required. These expressions use rational P; arbitrary nonrational height inputs would need an additional verified enclosure rather than pretending P is exact rational data.

## Fixed Hcert example: scope and exact budget

This example assumes **c>1**, `T=Hcert(c)>=1`, and `c*T<=10^8`, with P=257*T and N the least power of two at least 4P. Minimality gives `4P<=N<8P`, hence

```
8*pi <= omega*N < 16*pi < 51,
X=omega*N/2 >=4*pi>12.
```

The same P leaves the time-alias bound unchanged. Increasing N to the next power of two preserves the frequency-tail proof because it only needs the lower bound X>12 and omega<1. It also changes the retained-frequency aggregate multiplier to 51, which the note includes explicitly. None of these inequalities justifies using the earlier multiplier 26.

Since c is an integer greater than 1, `T<=5*10^7`, so `N<102800000000<2^37`. Because N itself is a power of two, `d<=36`. This cap is valid for this fixed Hcert example only. In particular it must not be carried into an arbitrary enlarged verification/Turing height without a new bound. The general stage recurrence remains available in that setting, but its numerical specialization must be recomputed.

With delta=`10^-52`, `Bstar=100000001`, the finite product factor is below 2. Indeed `(1+delta/2)^36<=1/(1-18*delta)<2`, using binomial coefficients bounded by `36^j`. Thus

```
Ed <=36*(Bstar+2)*delta=:Estar<1,
Efinite<51*Estar+(Bstar+1)*delta+delta<10^-40.
```

My independent script also computes the exact rational 36-stage product-sum recurrence and verifies it is below the coarse Estar; no transform is executed. The complete ledger

```
10^-30 + 10^-75 + 51*10^-119 + 51*10^-50 + 10^-40 < 2*10^-30
```

checks exactly. Each summand has a distinct source: time alias, omitted frequencies, retained-coefficient series tail, coefficient arithmetic enclosure, and transform/scale arithmetic. No term is hidden in another bound or discarded by cancellation.

## Evidence and open obligations

The independent `major-constants/review_finite_fft_scalar_20261111.py` writes a new receipt beside itself. It checks 16 strict rational inequalities plus the exact Machin tangent identity. It imports none of the author's scalar code, evaluates no FFT or L-value, and generates no twiddle table. These arithmetic checks corroborate the constants; the exact stage invariant and analytic exponential/arctangent bounds are paper proofs above.

The conclusion is limited to the stated finite algorithm and packet contract. Actual source-bound coefficient packets, character/root-phase enclosures, a checked stage trace, permutation correctness for an implementation, final interval outputs, Lean terms, and any successful sign mesh remain absent. Hashes identify those artifacts when produced; hashes alone will not prove their arithmetic or analytic semantics. The principal conductor-one row is outside this nonprincipal transform protocol. No claim about complete-family runtime or spectral truth follows from this review.
