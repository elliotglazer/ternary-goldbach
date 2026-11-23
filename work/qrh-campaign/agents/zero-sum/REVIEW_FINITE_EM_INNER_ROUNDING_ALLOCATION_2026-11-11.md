# Independent review of the finite-EM inner-rounding allocation

2026-11-11. PASS for the specified paper schedule and exact scalar bounds. No correction requested. The new elementary rounding gates preserve the accepted output interfaces. No elementary value, phase, model, transform, certificate instance or Lean proof was computed in this review.

## 1. Frozen inputs and independent checks

The reviewed author files are under `work/qrh-campaign/agents/major-constants/`:

| File | SHA256 |
| --- | --- |
| `FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md` | `60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9` |
| `finite_em_inner_rounding_allocation_20261111.py` | `660A180424D4209E3DC588524C256144E2B9E9A1FD6B39A0913D3FDC0A7DE343` |
| `finite_em_inner_rounding_allocation_20261111.json` | `DBBB6A94FF1D74EB86347830E65F559B27DC3596B92F74DC676CABE5C3A1CB99` |

I read the complete note and script and rechecked its unchanged outer contract against `FINITE_EM_RATIONAL_ELEMENTARY_BUDGET_2026-11-11.md`, SHA `50D1FFB0385A0F2FCE3BA9EF3BBB4FFD3BAC5A0103E95A8329E79A25D524A541`. The old exact-polynomial denominator issue was reviewed in `zero-sum/REVIEW_FINITE_EM_RATIONAL_PROOF_COST_DESIGN_2026-11-11.md`, SHA `022C335200DCD43E6E9639E978F122F5619199B3EBCC2B98F7B997C1328C8D8E`.

The independent checker `zero-sum/review_finite_em_inner_rounding_20261111.py`, SHA `B06762ADDC9EC1A547CC60CE47D06543801D3E9AD7EBA369773DB2FA1EA5E5B6`, passed 2,872 exact checks. Its receipt has SHA `5D101EEA32914A900A9F927BAFDF31F4636FCDA36CF702973FE3CC497586673A`. It verifies pins, reconstructs the scalar errors by closed formulas, checks normalized coefficient identities, all 512 exponential-update denominator bounds and all 1,025 rational atanh reductions. It imports no evaluator and neither executes the author script nor changes its receipt.

## 2. Normalized exponential Horner and the four squares

The recurrence starts with the exact terminal value V_512=1. Backward substitution gives

```
V_k=sum_(j=0..512-k) k!/(k+j)! * z^j.
```

Thus V_0 is exactly the 513-term exponential polynomial, not a polynomial of degree 513. There are 512 rounded affine updates. An error injected at update k is multiplied on its path to V_0 by z^k/k!, so the sum of errors is at most

```
delta*sum_(k=0..511) |z|^k/k! <= exp(|z|)*delta.
```

The suffix version has denominators `(k+1)...(k+j)>=j!`, which gives the same exp(R) bound and justifies the stated intermediate magnitude bound. These are absolute error bounds; no relative-conditioning or cancellation assumption enters.

For the real exponential, |z|<=1/2. The chosen bound 3 delta is conservative. Set `t=2*(1/2)^513/513!`. After k rounded squares, the exact recurrence gives

```
e_k <= 3^k*t + [3*3^k+(3^k-1)/2]*delta.
```

All five stage values are below one. The true comparison exponentials have nonpositive real exponent, so magnitude at most one. This supplies the hypothesis for `(2+e)e+delta<=3e+delta` at each step. At k=4 the bound is exactly `81*t+283*delta<eta`. No square gate is omitted.

For the reduced imaginary input, |r|<4. The inherited source exponential-tail theorem applies with n=513 because 4/514<1/2. The extra rounding cost is below 81 delta. The pi uncertainty contributes the old `2^13*eta` because the same certified reduction integer satisfies |k|<2^12. The exact reduced angle and its rational center are not identified.

The cis approximation has norm below two. If A is the true real exponential and C the true cis, then

```
|Ahat*Chat-A*C| <= |Ahat-A|*|Chat|+|A|*|Chat-C|.
```

Using |A|<=1 and the final complex gate gives the claimed `2*e4+ecis+eta<2^16*eta<epsilon`. The primitive is still evaluated at the exact rational input supplied by the outer plan. Error from replacing an actual log by its canonical center remains a separate outer input error.

## 3. Logs, raw log-2 reuse and Machin

For the atanh polynomial the exact backward recurrence has coefficient ratio t^2<=1/9. The 512 affine gate errors therefore sum to at most 9 delta/8. Multiplication by 2t<=2/3 and one more gate give 7 delta/4. The analytic omitted-series tail remains the accepted one.

The internal log2 center must be the delta-grid result before final eta-scale rounding. With k<=10, exact assembly of k times that internal center plus the internal reduced-log center gives error at most

```
Tlog+11*(7*delta/4)+eta/2<eta.
```

Using a previously canonical-rounded log2 in this formula would not have this bound. The author explicitly keeps the two cache entries distinct. Log1 is selected by the exact integer input and stays exactly zero. The old domain checks for the remaining log centers continue to hold because the total error remains below eta.

For each alternating Machin polynomial the absolute recurrence ratio is at most 1/25. Its 256 affine errors sum to 25 delta/24. Multiplication by |t|<=1/5 and the final inner gate give 29 delta/24. The signed combination itself uses coefficients 16 and -4; the absolute weights sum to 20 only in the error bound. Exact combination followed by the canonical real gate gives

```
Tpi+(145/6)*delta+eta/2<eta.
```

No additional uncharged combination gate appears in either calculation. All final canonical centers remain on the old grid 2^-1025. Thus the previous moment, FFT and complete-correction interface remains applicable without substituting new error tolerances.

## 4. The denominator bounds apply to the declared operations

I checked the argument bounds from the fixed rational pilot rather than assuming they hold for arbitrary primitive inputs. The real center coordinate is 629/1250, and the imaginary coordinates have denominator 16. A canonical log has denominator dividing 2^1025. After the real part is divided by 16, its denominator divides `625*2^1030`. The imaginary phase has denominator dividing 2^1029. Subtracting the exact integer multiple of canonical pi does not increase that bound. Twiddle arguments and the smaller height-step arguments also divide this common denominator.

Let `d=625*2^1030` and let the inner grid denominator be 2^1041. An exponential affine update has coordinate denominator dividing `d*2^1041*(k+1)`. Bounding k+1 by 512 gives the stated 2,090-bit upper bound. This maximum product need not be a common divisor for all k; the author says so. After a gate the coordinate denominator again divides 2^1041, so the 512 updates do not accumulate the unrounded d^512 factorial denominator.

The exact atanh argument is generally nondyadic. For n<=1025 its reduced denominator is at most 2049. I checked every exact rational reduction and the maximum 2049. Squaring the argument and adding 1/(2k+1) gives the safe product bound `2049^2*2^1041*1023`, with 1,073 bits. This includes the rational odd coefficient denominator. The final multiply and exact log assembly have the smaller claimed bounds.

For Machin, the maximum argument denominator is 239 and the maximum odd coefficient is 511. The resulting bound has 1,066 bits. Real squaring and the exact final real-times-complex product have denominators dividing 2^2082, hence 2,083 bits. Both factors of that final product really are inner-grid centers at this stage.

These are reduced-coordinate or sufficient common-denominator bounds immediately before named gates. They do not bound every raw numerator or auxiliary multiplication in a chosen implementation. In particular, an unreduced cross-multiplication routine can use larger integers. The author retains this distinction, the finite magnitude bounds, and the separate scalar inequalities involving 513!. The result addresses elementary-leaf growth; it does not change the larger exact moment or correction denominators from the cost note.

## 5. Counts, scope and verdict

The gate counts are consistent with the recurrences: each reduced log has 512 affine gates and one multiply gate; each Machin component has 256 affine gates and one multiply gate; a generic complex exponential has 512 real Horner gates, four real-square gates and 512 cis Horner gates, followed by its existing canonical complex gate. This does not include all arithmetic comparisons, scalar witnesses or outer computation. Exact special cases may save work only with their input identities checked.

This is a valid replacement for the old exact inner polynomial schedule at the specified fixed inputs. The introduced rounding errors are all charged, and the final log/pi/exp interfaces are preserved. It shows that the earlier very large unrounded elementary-polynomial denominator is avoidable. It does not show that every arithmetic operation can be rounded arbitrarily, that all integer operands are under 2,100 bits, or that a full certificate is faster or smaller.

A future implementation must prove the finite Horner identities and gate soundness, check actual signed rounding witnesses, preserve the raw log2 cache contract, and establish full containment in the immutable target boxes. None of those finite instances or Lean proofs has been produced here. No execution authorization, spectral claim or new root premise follows from this review.
