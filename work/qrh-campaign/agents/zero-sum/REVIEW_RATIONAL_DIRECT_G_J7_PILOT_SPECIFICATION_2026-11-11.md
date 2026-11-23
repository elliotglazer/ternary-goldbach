# Independent paper review of the rational direct-g j7 pilot

2026-11-11. PASS for the frozen paper specification. No mathematical repair requested. This verdict does not authorize execution and supplies no numerical evidence. I wrote no evaluator or scalar program and computed no elementary values, coefficients, transforms or models for this review.

Reviewed author file: `major-constants/RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md`, SHA256 `8AE42550658C25548352161EBBB8A1FDCBC967F7E32772C9D2FF1826AAACEEC2`. Paths in this review are relative to `work/qrh-campaign/agents/`.

I read the complete specification against its accepted inner-rounding, outer elementary, finite-g and checker-blueprint inputs. The independent forward-series method is new to this specification; its error proof is checked below rather than inferred from the producer's Horner proof.

## 1. Fixed target and full source function

The unchanged target is `integration/small_em_batch_candidate_20261111_01.json`, SHA `2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E`. The specification fixes all sixteen entries of g_jets[7], panels[7] and canonical endpoints[7],[8]. Its center is

```
c=629/1250+i*31985/16.
```

The full vertical panel c+i[-1/16,1/16] has height interval [1999,15993/8]. Both endpoints are owned by model 7. No singleton value, earlier center or sampled subset replaces this interval.

The source expression includes the full head, half term, sixteen signed Bernoulli terms and the B pole-cancellation term. N=1024, B=1025, M=16 and K=16 remain fixed. The highest retained correction rising factorial has length 31; the actual EM remainder has length 32. The supplied coefficients are complex-s derivatives divided by h!, with no extra vertical i^h factor. The previous-jet term in the product by s-1 is present, and its h=0 case is zero.

Direct evaluation establishes the same actual coefficient and image claims without establishing the old bins, moments or FFT records. The specification keeps those conclusions separate. It introduces neither a time-residual truncation nor its error into the direct route.

## 2. Producer accuracy

The producer uses the previously reviewed inner Horner scheme, including the raw internal log2 cache, canonical grid 2^-1025, eta=2^-1024 and epsilon=2^-512. The actual phase exp(-c log n) includes both the rational-input exponential error and the actual-log perturbation. Its published radius 2^13 epsilon includes the latter; epsilon alone would not do so.

For an individual head summand, the inherited normalized-log-power bounds give error at most

```
(2^13*2^45+2^46)*epsilon <2^59*epsilon.
```

Summing 1024 terms and adding one permitted completed-head gate yields error below 2^70 epsilon. The complete B correction has the inherited exact Q norm and exponential coefficient bounds, so its error is below 2^78 epsilon. Multiplication by c-1, the previous-jet term and the final gate remain below the stated 2^84 epsilon. Thus the published fresh G radius 2^-420 is wider than the proved error 2^-428. It is an additional enclosure, not a replacement for the old coordinate square of halfwidth 2^-52.

The proof assumes exact rational algebra between the named gates. It does not justify arbitrary rounding in the head powers, rising polynomials or convolutions. Every one of the 1025 logs and 1025 actual phases is required, with n=1 handled by its exact identities and B retained separately.

## 3. Independent forward exponential

The independent method uses deltaI=2^-1080, etaI=2^-1056 and epsilonI=2^-544, with its own fixed grids. Its mathematical targets are unchanged.

For the forward exponential term recurrence, the error obeys

```
e_j <= (R/j)e_(j-1)+deltaI, e_0=0.
```

The error injected at an earlier term is multiplied by a power of R divided by a product of consecutive positive integers. That product is at least the factorial of its length. Consequently each e_j is at most exp(R) deltaI. The accumulator receives all 512 nonconstant term errors and 512 new sum gates. Its polynomial error is therefore at most

```
512*(exp(R)+1)*deltaI.
```

This is not the smaller Horner error exp(R) deltaI. The specification correctly uses 2048 deltaI for R=1/2 and 41984 deltaI for R=4, from exp(1/2)<3 and exp(4)<81.

For the real part, write `t=2*(1/2)^513/513!`. Four rounded squares produce

```
81*(t+2048*deltaI)+40*deltaI
=81*t+165928*deltaI.
```

The coefficient 40 is 1+3+9+27. All earlier errors are bounded by the final positive bound, which is below etaI and hence below one; the use of square amplification at most three is justified throughout. The true intermediate exponentials have nonpositive real exponent and magnitude at most one.

The independent cis bound contains its analytic Taylor tail, the 41984 deltaI polynomial error and the separately certified pi-reduction error 2^13 etaI. The final product estimate uses true real-exp magnitude at most one and approximate cis magnitude below two. It therefore has the same form `2*e_real+e_cis+etaI`, below 2^16 etaI and hence epsilonI. The bound includes both term and sum roundings, four square gates and the canonical final gate.

## 4. Independent forward logs and Machin

The log power recurrence has contraction t^2<=1/9. Even if every power, including the initial one, receives a deltaI gate, its error is at most 9 deltaI/8. Each normalized term then has at most twice this power error, one division-output gate and one accumulator gate. Thus the total is bounded by

```
512*(2*(9/8)+2)*deltaI=2176*deltaI.
```

The raw internal log2 cache is retained before canonical rounding. At most eleven copies in k log2+logu give 23936 deltaI. These counts remain safe if an exact initial power or exact log1 saves operations. They do not authorize reusing an etaI-rounded log2 inside that weighted assembly.

The signed Machin power recurrence has absolute contraction at most 1/25. Its power error is at most 25 deltaI/24. Each term division and sum update add one gate, giving

```
256*(25/24+2)*deltaI=(2336/3)*deltaI.
```

The absolute weight sum of the exact coefficients 16 and -4 is 20, hence the final inner error (46720/3) deltaI. The negative sign remains part of the actual computation. The use of absolute weights only bounds its error.

The fixed truncation lengths are compatible with the tighter independent etaI. Indeed, 3^5>2^7 gives 3^1025>2^1435. Also 5^10>2^23 and 5^3>2^6 give 5^513>2^1179. The log and Machin tail prefactors are each below one, so both tails are below etaI/16. The integers 128 through 513 supply 386 factors at least 128, proving

```
513! >=2^2702,
2*4^513/513! <=2^-1675,
2*(1/2)^513/513! <=2^-3214.
```

Finally deltaI/etaI=2^-24. The log inner coefficient 23936 is below 2^15; the Machin coefficient 46720/3 is below 2^14; and 165928 is below 2^18. These bounds prove the displayed independent interfaces with room after the canonical etaI/2 or etaI gates. No elementary value evaluation is needed for these comparisons.

Repeating the direct finite-g propagation with epsilonI gives full coefficient error below 2^-460. The declared independent radius 2^-450 is therefore justified conditional on every independent rational gate and analytic tail check. Reversing the head sum and separately constructing the finite polynomial products gives a distinct calculation of the same expression; order reversal alone would not replace the independent elementary algorithm.

## 5. Independent containment and whole-panel recovery

The specification requires complete independent log and actual-phase enclosures to fit the producer's leaf records. It also requires independent G enclosures to fit every fresh producer G ball. Both jobs must separately prove coordinate containment in each immutable old G square. Overlap and matching digits do not meet those obligations.

The independent check is required in addition to deterministic reconstruction of every omitted producer gate. Neither a digest nor the independent final calculation replaces that gate replay. The compact format may omit repeated gate objects only because the frozen template and exact inputs reconstruct them. Code preflight must specify the deterministic nearest-grid tie rule; either nearest choice satisfies the error bound, but byte-reproducible replay must choose one.

For the images, both jobs use the unchanged old coefficient squares and the correct imaginary-offset interval or singleton. They add the accepted actual-point EM and finite-g Taylor pads once, then divide by the whole s-1 rectangle. The denominator norm-square has a positive lower bound at these heights. Exact four-corner interval multiplication, unary square and division are retained so the reconstruction can equal the old literal image, rather than only overlap it.

The coefficient theorem and analytic remainder bounds imply membership at every point of the closed panel. This is not sampled nonvanishing. The absence of an extra 2^-64 quotient pad is consistent with the accepted exact-rational image reconstruction. The scalar error bound is not a bound on natural image width.

## 6. Resource and proof boundary

The proposed producer and independent attempts have separate fixed launch-to-exit limits of 600 and 900 seconds. Each has 512 MiB peak working-set and 16 MiB aggregate output limits, with mandatory telemetry and no automatic restart, precision change, extra center or relaxed target. The independent job includes the full required replay and independent construction within its own cap. Missing telemetry or any incomplete required comparison cannot result in PASS.

The 65,536-bit integer limit is a fail-closed work guard, not a proven universal intermediate bound. Code preflight must enforce it without switching to approximate floating-point arithmetic. The negative controls are tied to real semantic or arithmetic checks, including full source support, Bernoulli signs, gates, tails and immutable target data; malformed flags alone are not sufficient tests.

This is a reviewable rational-only external pilot specification. It leaves actual witness generation, exact target containment, resource feasibility, implementation correctness, source-to-Lean analytic adapters and closed kernel acceptance open. It neither authorizes execution nor proves the full eight-center result, the old batching internals, a zero-free region or any additional spectral coverage.
