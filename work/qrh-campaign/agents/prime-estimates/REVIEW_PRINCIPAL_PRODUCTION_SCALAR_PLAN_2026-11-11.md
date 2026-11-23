# Independent review of the two-height scalar allocation

2026-11-11. **PASS as a conditional paper parameter allocation with independently checked exact scalar arithmetic.** No defect remains in the frozen version. This is not acceptance of production node values, a nonvanishing contour, a spectral count, runtime feasibility, or a Lean theorem.

## Frozen artifacts

Paths below are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| `major-constants/PRINCIPAL_PRODUCTION_SCALAR_PLAN_2026-11-11.md` | `38A525F26578A7FCFFF6F51BD9CEF1DC495ED7788CF5B0B1FFE586F7E1BF21C5` |
| `major-constants/principal_production_scalar_plan_20261111.py` | `F8E4D883471769A606578ACD3F2BD70B0ECB3BFF5E025CD054702A75D0C3E405` |
| `major-constants/principal_production_scalar_plan_20261111.json` | `94FBF9028AE942CBEB1A59A648AEB12C0C4914BA3F6ABC282D203B04559BD294` |
| Independent script `prime-estimates/review_production_allocation_20261111.py` | `B9A2C1816E5536C0D0A759CAF687636C077D65FCB929784A320D3883F5EF4D54` |
| Independent receipt `prime-estimates/review_production_allocation_20261111.json` | `B3B18750B13C8A368336C2AE6E1873D2EF19B6BBB151CC762638922C7361C8A8` |

All hashes were read locally and matched. I read the full author note and script, the pinned Fourier and modular-substitution plans, and the general two-fifths theta-tail proof. The independent script imports no author algorithm. It computes exact A, M and D, checks a separate conservative budget, and independently reconstructs every numerical field in the author's scalar receipt, including the optional word/mode bounds. It also verifies the three analytic input hashes. It exited successfully. No node array, transcendental value, numerical evaluator, production scan, or Lean build was run. Author files were not changed.

## Domains and normalization

The row fixes one exact `b=pi/4-1/(T+1)` and uses the actual unhalved source xi through `F_b(s)=exp(-i*b*(s-1/2))*xiF(s)`. The center assumptions `.4968<=sigma<=2` and `|t|<=T` match the source bounds. With U=T+1, `r=kappa=1/(2U)`, the strip margin is positive and `cos(2(b+r))=sin(1/U)>=1/(2U)`. Both selected U are greater than two, so the cited elementary sine lower bounds also apply to the seed argument 2/U.

The work height bounds coefficient centers. The unit-disk Cauchy majorant D is uniform in imaginary part; it does not require numerical samples at height T+1. A different coefficient algorithm that actually sampled an outer circle would need its own height coverage. The note states this distinction correctly.

The node step h is rational, not assumed dyadic. The accepted integral/trapezoid formula permits any positive h, and K*h=V is exact. Dyadic output centers remain possible even though h and the exact weights are not dyadic. Separate rows have different b; their images cannot be joined into one contour without the already stated normalization adapter.

## Error ledger

The selected rows are:

| T | h | K | V | d | Node radius | Weight radius |
|---|---|---:|---:|---:|---|---|
| 1000000 | 3/125000125 | 625000625 | 15 | 19 | 2^-90 | 2^-127 |
| 60343058 | 1/3117724715 | 56119044870 | 18 | 24 | 2^-105 | 2^-154 |

The following checks independently reproduce the proof.

* The exact rational envelope satisfies `A<2^(11+3p)`, `M<2^(12+4p)` and `D<2^(13+5p)` for p=20 and 26. Retaining D rather than M for positive Taylor orders is necessary and is done correctly.
* Since `6r/h=J`, `pi>3` gives `exp(2*pi*r/h)-1>2^J-1>=2^(J-1)`. The derivative factor is `exp((T+1)r)=exp(1/2)<2`; the extra exp(r) was not lost. With J=e_D+12, each quadrature error is strictly below 1/512. The independent checker also evaluates the tighter rational bound `4D/(2^J-1)`.
* Put x=q*exp(2V). The rational lower bound q*2^(2V) exceeds 768, so the discrete derivative-tail threshold x>=2 holds. The identity `S_j=(A/q^2)(x+1)exp(-x)` is correct for positive orders. The elementary inequality `x+1<=2exp(x/2)` and `A/q^2<D` give `S_j<2Dexp(-x/2)`. The value tail obeys the same upper bound. The independently used coarser `2D*2^-384` already suffices; the author's floor of q*2^(2V)/2 yields its stated sharper receipt.
* The common node error obeys `B_j< (2V+h)*2^(5V)*e<1/512`, using `|v|^j/j!<=exp(|v|)`, `|sigma-1/2|<=3/2`, and exp(1)<4. This includes all retained orders, including j=0. The exact zero-node positive-order contribution is zero.
* The bound `|p_k|<2^87` or `2^108` follows from the true P-ball premise and `|P|<=Aexp(V/2)`. It is not inferred merely from assigning a center. With the stated signed-node bit length, summing `werr*|p_k|` gives less than 1/512.
* The product split `w(P-p)+(w-w_hat)p` accounts for all node/weight errors without an independence assumption or missing mixed term. Exact center sums on grids 2^-221 and 2^-263 have zero summation error. The actual weights and coefficients need not be dyadic.
* Four coefficient-error terms below 1/512 give a disk contribution below `(1/128)*(64/63)=1/126`. The choices `6(d+1)=e_D+7` give Cauchy remainder below 1/126. Hence the full polynomial approximation error is strictly below 1/63. This bound concerns the exact polynomial; additional numerical polynomial evaluation must charge its own error.

One draft sentence needed a rounding convention: a coordinate grid of step e/4 gives Euclidean error below e/4 when each coordinate is rounded to the nearest point, whereas arbitrary floor rounding only guarantees a larger bound. The frozen note now explicitly specifies nearest-grid rounding. Each coordinate error is at most e/8, so its Euclidean norm is at most sqrt(2)*e/8<e/4. No correction to the frozen version is requested.

## Optional modular tail

The exact initial imaginary part is at least 1/U. Each admissible S input has `|Re(t)|<3/5` and `Im(t)<1/2`, giving a height increase greater than 100/61. The author's stronger endpoint test `2*100^m>=U*61^m` reaches height greater than 1/2 after m inversions, with m=27 and 35. It therefore handles overlapping stop/S guards: no further S can pass, and refinement can certify stopping at height at least 2/5. Translations preserve height; branch and whole-box guards still require actual certificates.

At an S input, `|1/t|<=U` and `|(-it)^(-1/2)|<=U`. The row-sum bound `U*((3/4)U^2+3U^3+U^4)<5U^5<2^(3+5p)` dominates all three ordinary-jet rows. Exact translation phases have norm one. The final P reconstruction contributes less than `2^(4+9V)`. The resulting analytic amplification exponents 2920 and 4821 are correct.

The general tail uses first omitted half-integer N+1/2; integer theta3/4 tails start later. The test `(2N+1)^2>=20Mtail` with Mtail=3022 or 4938 gives common paired-mode counts 123 or 157. The amplified `384*2^-Mtail` is strictly below e/8. This is an analytic truncation allocation only. It neither controls interval uncertainty in the transport matrices nor establishes a working precision. Seed, branch, finite-series, phase, coefficient and rounding errors must occupy the remaining node budget. The frozen note makes that limitation explicit.

## Counts and final scope

The exact counts agree with the author's table, including 625000626 and 56119044871 nonnegative nodes, 20 and 25 coefficients, and 25000025020 and 2805952243525 center products per center. These heterogeneous construction counts are not runtime estimates. The optional mode and S-operation totals are bounds for this deliberately uniform recipe, not lower bounds for other evaluators or measurements of a Lean checker.

The complete scalar ledger is valid under the stated finite node and weight inequalities and the reviewed analytic interfaces. Actual enclosures for those grids, strict whole-panel margins, full contour coverage and winding, source adapters and kernel proofs remain absent. Parameter feasibility establishes none of these. The frozen plan respects that boundary and preserves both separate principal target heights.
