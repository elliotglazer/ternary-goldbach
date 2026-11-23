# Independent review of the four-point modular theta pilot

2026-11-11. **PASS at the stated external coefficient-evaluation scope.** I read the complete frozen report and implementation, checked the transformation and tail formulas against the accepted source plan, and independently evaluated all four points. No correction to the producer's mathematical or numerical claim is required. This is not a Lean proof, a verified arithmetic checker, or a spectral certificate.

## Frozen evidence

Paths below are relative to `work/qrh-campaign/agents/`.

| File | SHA256 |
|---|---|
| `prime-estimates/PRINCIPAL_THETA_MODULAR_PILOT_2026-11-11.md` | `F0833712D50FBE36BDC8E29173A277CCBDC2C0CBAF4A1F7CA86F4F80B28E752D` |
| `prime-estimates/principal_theta_modular_pilot_20261111.py` | `EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14` |
| `prime-estimates/principal_theta_modular_pilot_20261111.json` | `C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF` |
| `integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md` | `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D` |
| `audit/REVIEW_PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md` | `9C2C4348EC29A5C3B4ACD6221CFE96F011C191395877E3654FC69DD81C7987ED` |
| `independent-feasibility/review_principal_theta_modular_pilot_20261111.py` | `60B92C3B84B988FC7AB2FB45AB114798C55A4F392A9282F6D7CDD26F1AD75E1C` |
| `independent-feasibility/review_principal_theta_modular_pilot_20261111.json` | `B59E3833AF032AC1A99789E8349DB8729C2187B1175F60205D9BFFCCA6771411` |

The independent script asserts all five producer/source pins. Its completed final run exited zero, with 2,069 rational-box containment checks and 2,061 raw binary-endpoint containment checks. Negative controls rejected a negated P value, an exchanged first/second derivative, and the opposite square-root branch. These controls supplement the formula review; they do not prove general checker soundness.

## Exact inputs, transformations, and derivatives

The four inputs are exactly `T in {1000000,60343058}`, `r in {0,1/8}`, `eta=1/(T+1)`, and `w=r+i(pi/4-eta)`. The stable expression `tau=exp(2r)*(-cos(2eta)+i*sin(2eta))` equals `i*exp(2w)`. Here the real parts are explicitly nonnegative. No general exact sign test for an arbitrary computable real part is assumed.

For each producer word I independently recomputed every input/output point from the exact initial expression, rather than treating a displayed midpoint as the next exact point. All translations satisfy the strict real-part condition. Every S step has positive imaginary part below 1/2, and its imaginary part increases by more than 100/61. Each terminal point has imaginary part above 2/5. The producer's floating nearest-integer proposal therefore carries no unchecked mathematical decision.

Translation reconstructs the old value at `z+n`: theta2 gains `exp(pi*i*n/4)`, while odd n exchanges theta3 and theta4. The same constant factor applies to all derivative orders. The independent eighth-root construction uses `sqrt(1/2)` in place of the producer's `1/sqrt(2)`.

For S, `A=1/sqrt(-i*tau)` uses the square root with positive real part. Since `Re(-i*tau)=Im(tau)>0`, the positive real root u and `v=Im(-i*tau)/(2u)` give the actual principal branch. I checked every stored z, norm, u, v, root, and A enclosure, including their compact binary endpoints. The type permutation is theta2/theta4 exchange, with theta3 fixed.

Differentiating `A*g(-1/tau)` gives

```
A*g,
A*(-g/(2*tau) + g'/tau^2),
A*(3*g/(4*tau^2) - 3*g'/tau^3 + g''/tau^4).
```

Indeed `A'/A=-1/(2*tau)`, `A''/A=3/(4*tau^2)`, and the inner derivatives are `1/tau^2` and `-2/tau^3`. The g-prime contribution in the second derivative is therefore -3, not -2. The implementation reverses the word, uses the point before each S, and uses ordinary derivatives rather than factorial-normalized coefficients. All retained reverse-stage jets and final jets were checked independently.

Finally, inserting `tau=i*exp(2w)` into `exp(w/2)*(6*tau*theta3'+4*tau^2*theta3'')` gives precisely the accepted kernel coefficients `-12*pi*n^2*exp(5w/2)` and `8*pi^2*n^4*exp(9w/2)`. There is no omitted factor of two or changed xi normalization.

## Reduced series and independent words

The producer retains integer pairs 1 through 20 and half-integer pairs 1/2 through 39/2. I checked all 160 pair records, every derivative term in them, their finite sums, and the correct central term for theta3/theta4 only. The theta4 signs alternate with the integer index. No zero-frequency term is inserted into theta2.

The uniform tail follows from `pi*Im(tau)>6/5`, `pi^j<4^j`, and

```
x^(2j)*exp(-alpha*x^2/2) <= (2j/alpha)^j,  j=1,2.
```

For j=0 the bound is one. The first omitted half-integer is 41/2; the first omitted integer is larger. For nonnegative integer k, `(u+k)^2 >= u^2+(2u+1)*k`, which yields the producer's geometric denominator. The factor two includes both signs. The error disc can safely be enlarged to a coordinate box with the same radius. All reduced and direct tail bounds, including their binary fields, passed independent recomputation.

I separately used 384-bit elementary arithmetic, a rational Machin enclosure for pi, and a reduction targeting terminal imaginary part above 3/4. This uses translations with real part below 51/100 and inversions below imaginary part 4/5. These overlapping conditions are valid on every executed step. The reduced independent series uses 24 pairs and alpha=2. A separate replay of the producer's own word uses 32 pairs and alpha=6/5, allowing comparison at every producer stage.

The two r=0 independent words finish with translation -1 instead of the producer's 0. Both choices are valid at the exact half-integer real part. At `T=60343058,r=1/8`, the independent word adds an S and a translation -1 to the producer word. The remaining r=1/8 word agrees. Thus the comparison is not merely a repeat with identical modular branch choices.

The pi enclosure uses 100 alternating atan terms at 1/5 and 40 at 1/239 in `pi=16*atan(1/5)-4*atan(1/239)`. Both even truncations have the next-term remainder with the appropriate sign. Its enclosure lies inside the producer's pi interval. No independent call to a theta, zeta, Gamma, or pi value oracle is made.

## All four direct comparisons

I independently evaluated the original P-series at every input, using 8,215 positive frequencies at T=1000000 and 63,477 at T=60343058. Both r values use these conservative cutoffs, for 143,384 direct frequency evaluations in total. The producer uses the different cutoffs 8,165, 7,206, 63,427, and 55,974.

For the independent tail put `alpha=6/(T+1)`. Since `sin(2eta)>=2eta-(2eta)^3/6` and pi>3.14, the script verifies `pi*Re(exp(2w))>alpha`. On `0<=r<=1/8`, the absolute kernel coefficients are bounded by 256 and 96, using pi<4 and `exp(9/16)<2`. The latter follows from a positive Taylor sum with a geometric bound after the quadratic term, checked rationally in the script. Splitting the Gaussian gives the tail bound

```
(4096/alpha^2 + 192/alpha)
  * exp(-alpha*(N+1)^2/2)
  / (1-exp(-alpha*(2*(N+1)+1)/2)).
```

This accounts for the n^4 and n^2 factors explicitly. The direct finite sum is evaluated term by term with the original kernel coefficients. It does not obtain its values from modular reconstruction or a special-function routine.

All four direct intervals overlap both independent modular intervals and lie inside the producer's displayed P boxes. The independently reconstructed true-value enclosures also lie inside the producer's finer binary P boxes and its direct P/jet boxes. At r=0, my conservative direct tail is wider than the raw modular interval. I therefore do not claim that the entire direct interval is contained in that finer binary interval. Agreement is a diagnostic; the actual enclosure justification is the formula and tail proof on each route.

## Serialization, runtime, and acceptance limits

The outward multiples of 2^-128 are valid readable enclosures, including at the exponentially small r=0 values. These boxes do not assert vanishing. They must not replace the finer internal values in a precision-sensitive arithmetic replay. The parallel endpoints `mantissa*2^exponent` preserve the original dyadics compactly. I checked them directly with arbitrary exponents, without converting exponentially tiny values into enormous rational denominators or floating zeros.

The independent final run took 0.6794989 seconds internally, including source-pin checks, all four modular comparisons, all four direct sums, and the negative controls. This excludes process startup and final JSON serialization. The producer's recorded 0.4368671 seconds likewise excludes its subsequent serialization. These bounded measurements do not establish a cost for a Fourier grid, uniform panels, xi evaluation, a contour, or a complete zero certificate.

Both implementations still use the same external Arb arithmetic backend for elementary operations. The alternative pi construction, words, precision, cutoffs, and direct-kernel assembly reduce algorithmic dependence, but they do not independently verify that backend. The interval recipes, classical theta source adapters, branch and derivative identities, and serialization-composition theorem still require formal implementation. Neither this pilot nor this review supplies any zero, zero count, nonvanishing panel, or new final-root premise. No Lean/Lake build, full scan, dependency installation, or canonical/frozen producer edit was performed.
