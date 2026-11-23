# Independent review of the fixed finite-EM rational proof cost design

2026-11-11. PASS at paper, exact-scalar and saved-data inventory scope, with two nonblocking cost qualifications below. No mathematical correction is required. I did not evaluate logarithms, exponentials, models or transforms, import an evaluator, run the author script, or build Lean. The frozen author files remain unchanged.

## 1. Pins and independent checks

The reviewed files under `work/qrh-campaign/agents/independent-feasibility/` are:

| File | SHA256 |
| --- | --- |
| `FINITE_EM_RATIONAL_PROOF_COST_DESIGN_2026-11-11.md` | `19DB61735647D0267954692733C2CF045B977D540A4CF55B5DBDB1145EE82CB8` |
| `finite_em_rational_cost_inventory_20261111.py` | `B638E79245CADF189561F81D37393369A5A7D527628410C2462BA58386B35CB9` |
| `finite_em_rational_cost_inventory_20261111.json` | `58FBCA32FBC3D472649EA4B3E31C6C9EB864408A83082346789F3E1FCD6B0782` |

I read the full author note and script, the frozen rational-checker blueprint, the elementary error budget, and the accepted finite-EM vertical batching formulas. I independently reconstructed the arithmetic and representation arguments rather than treating the inventory receipt as their proof.

My standard-library checker is `zero-sum/review_finite_em_rational_cost_20261111.py`, SHA256 `C882B9648913A03BE83DCE16EC118736B80A650E96C6AB57030F68258B2DDDE6`. Its receipt is `zero-sum/review_finite_em_rational_cost_20261111.json`, SHA256 `2342162969282436CBA9388DBF3C79E126373B89919E534E774C42A42459161E`. It exited 0 with 484 exact checks. It reads saved JSON, verifies pins and sizes, reconstructs ordinary Bernoulli factors by their rational recurrence, checks denominator divisibility and bit lengths, and verifies integer counts and rational error inequalities. It calls no elementary or special function and executes no author code.

## 2. The two conclusions remain distinct

The source expression is the same complete entire finite g from the accepted EM route. Its head is multiplied by s-1; its full correction contains the half term, all 16 signed Bernoulli terms and the additional B term giving B^(1-s). Its coefficients are normalized derivatives in complex s. None of these changes under the direct route.

A direct-g certificate can prove the actual 128 coefficient-square memberships and the same 17 actual-zeta images without proving the saved bin, moment or transform claims. These internal claims are not hypotheses of the actual-image theorem. Calling this a certificate of the saved batching computation would be incorrect, and the author explicitly declines that claim. If batch-record acceptance is promised, all its additional finite obligations remain.

The j=7 first slice preserves the correct center, complete last panel and endpoint ownership. Its successful future check would establish only that slice, not the other seven models. The recommendation to start with direct g is a reasonable engineering choice based on the smaller list of mathematical interfaces; it is not a proved optimum, measured verifier improvement or evidence of a Lean/MM0 ratio.

The source adapter and elementary soundness still need formal implementation, and immutable saved-box containment still needs a successful closed check. A sufficient new accuracy budget cannot establish containment in an arbitrary old square without that comparison.

## 3. Common denominators and representation bounds

For this exact grid, J=8, Delta=-1/8 and L=32 give

```
rhat_n = -loghat(n) - q_n*pihat/2.
```

With baseline phase, log and pi centers on a common grid 2^-b, each residual coordinate has denominator dividing 2^(b+1). Thus the h,m moment summand has denominator dividing

```
2^(b*(1+h+m)+m) h! m!.
```

This denominator is common to every n at those orders. Adding 1,024 terms does not multiply 1,024 unrelated denominators. A common denominator for all h<16,m<24 is `2^(39b+23)*15!*23!`. I checked divisibility for all 384 pairs and independently recovered its 40,113-bit size at b=1025. With a uniform summand magnitude bound, summation can add up to ten numerator bits and still requires all its additions. Temporary cross-products and GCD work in an unsuitable rational representation are separate implementation costs, not necessary exponential denominator growth in N.

The FFT bounds also follow the actual named gates. After a g=513 grid gate, multiplication by a b=1025 grid twiddle, addition and division by two have denominator dividing 2^(g+b+1). The next gate resets the denominator to the g grid. Without those gates, five stages instead have exponent g+5(b+1), not one new factor for every butterfly. The exact j/8 Horner sum has denominator dividing 2^(g+3*23) before its factor 32. The direct phase/log product denominator `2^(g+15b)*15!` is valid for the stated gated phase-reuse schedule; it is not asserted for an arbitrary elementary phase representation.

For corrections, D_c=10000 clears every center coordinate. Each length-at-most-31 rising polynomial therefore has coefficients with denominator dividing D_c^31. I independently generated all ordinary Bernoulli numbers through order 32 and matched every saved factor `[B_(2m)/(2m)!]*1025^(1-2m)`. The least common multiple D_f of their denominators has 443 bits. Consequently

```
D_R=lcm(2,D_c^31*D_f),
D_Q=D_c*D_R,
D_E=2^(15b)*15!
```

are valid common denominators for the rational correction polynomial, its multiplication by s-1 and addition of B, and the retained logarithmic exponential coefficients. Convolution needs D_Q*D_E, not a product of sixteen unrelated denominators. A fresh phase adds 2^b; a gated reused phase adds 2^g. The resulting bit counts 855, 869, 15,416 and 17,309 match independently. The phase-grid change removes exactly 512 bits from that sufficient denominator. Final gated assembly has denominator dividing D_c*2^g before its final gate.

These bounds concern centers in a declared exact-rational schedule. A different interval-endpoint or inner-rounding schedule needs its own bound and error proof. The author retains that restriction.

Two cost qualifications are important:

* The table's elementary complex-phase row counts main and B phases. Batch twiddle certificates and the shared pi/log setup are additional. In particular, 1,024+8 is not a total count of all elementary exponential/cis work for the batch route. The author confirmed this intended reading.
* The denominator `d^512*512!` is a sufficient common denominator for the 513-term exponential polynomial before later exact squarings and products. It is not an upper bound on all elementary-leaf intermediates. Exact squarings can enlarge it further. The author confirmed this reading too. The note correctly leaves elementary witness representation and its actual bit cost open.

Neither qualification changes a denominator formula or an accuracy estimate. They prevent the tables from being interpreted as a complete bit-operation or proof-size forecast.

## 4. The new direct phase-reuse accuracy argument

This is a substantive new sufficient bound, and I checked it separately from the operation counts. Write epsilon=2^-512. Since the selected real part is positive and n>=1, the actual baseline magnitude is at most one. The actual height step has magnitude exactly one. The reviewed elementary estimates give baseline error below 2^13 epsilon; its extra named gate gives e_0<=8193 epsilon. The step has total error below 2 epsilon, including its log-input uncertainty. With one additional gate after a product,

```
e_(j+1) <= (1+2 epsilon)e_j + 3 epsilon.
```

The factor multiplying e_j accounts for the approximate step's magnitude. The 3 epsilon term consists of its error against an actual baseline of norm at most one plus the product gate. No approximate unit-modulus claim is made. I iterated the rational inequality independently and verified e_j<2^15 epsilon for every j=0,...,7.

The normalized log-power bounds from the elementary budget are `|Ahat_h|<=2^45` and `|Ahat_h-A_h|<2^46 epsilon`. Telescoping the phase/log product therefore gives

```
term error <(2^15*2^45+2^46)epsilon <2^61 epsilon.
```

Summing 1,024 terms and adding the completed-sum gate gives less than 2^72 epsilon. These are absolute errors at the exact source expressions; shared input uncertainty is not assumed independent.

For the B correction, the exact rational Q polynomial has coefficient l1 norm below 2^48. The truncated log-exponential array has l1 norm below 2^13 and perturbation below 2^13 epsilon. The actual phase magnitude is at most one. Hence the full correction error, including its gate, is at most

```
2^48*(2^15*2^13+2^13)epsilon + epsilon <2^78 epsilon.
```

This includes the half term and the B pole-cancellation term because Q is the full polynomial. Finally, multiplication by s_j-1, addition of the previous normalized jet, correction and gate are bounded by

```
2002*2^72 epsilon + 2^78 epsilon + epsilon
 <2^84 epsilon =2^-428 <2^-53.
```

The h=0 previous-jet term is zero. Direct evaluation has no residual time-bin Taylor tail to add. All estimates assume exact rational algebra between the named gates. They do not justify rounding after every multiplication under the same budget. They prove sufficient attainable accuracy for that proposed construction, not the future production of witnesses or the inclusion of its results in every old target.

## 5. Counts and saved data

The independently reconstructed counts match the declared padded schedules. The batch has 393,216 moment contributions, 376,832 residual recurrences, 30,720 normalized butterflies and 61,440 butterfly additions. Its exact-Horner gate count is 74,112; using all rounded affine Horner steps gives 77,184. The direct-reuse route has 2,050 baseline/step certificates, 7,175 height recurrences, 131,072 main contributions and 8,584 named gates. The correction/assembly upper count 7,488 and 255 image Horner products are consistent with the accepted finite-EM schedule.

Baseline phase gates in the direct count are separate from their elementary leaf certificates; step leaf construction is also charged separately. These numbers compare declared arithmetic units, not equal-cost operations. The direct fresh-phase column deliberately uses a less-shared log-power schedule. Neither it nor the direct-reuse column is a universal lower bound.

I checked saved-data byte sizes, the compact full target size 68,025 bytes, j=7 target size 10,799 bytes, and the 1,920 nonzero/10,368 zero moment claims. The five recorded bin ranges match the saved receipt. This checks their stored partition, not their transcendental bin inequalities. Those still require the elementary certificates in an actual batch proof.

The fixed target subsets, existing JSON sizes and common-denominator bit lengths do not determine future certificate bytes, peak memory or kernel reduction cost. A streaming numerical schedule also does not prove a proof checker discards old dependencies. The author's separation of numerical working state, certificate DAG sharing and verifier computation is necessary and retained.

## 6. Verdict and next boundary

The note is accepted as a source-faithful symbolic comparison and a sufficient direct-phase error design. It supplies a useful alternative for proving the same actual-image statement while leaving batch-record certification explicit. No function enclosures, fresh elementary witnesses, typed target import, kernel acceptance, production throughput or system-to-system speed comparison were established by this review.

The consequential next step is to choose and prove the exact rational elementary and gate representation for one fixed j=7 actual-image certificate, then produce and check its immutable-target containment. If batch-record acceptance remains part of the promised result, its bins, all moments and consumed transforms must receive their separate proofs. The present operation counts do not decide which representation is practical.
