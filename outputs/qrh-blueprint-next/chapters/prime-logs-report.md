# Exact arithmetic ledger for the finite theta chain

Date: 2026-11-11. This is a research specification, not Lean source or an author-approved declaration. No Lean build, prime generation, canonical edit, or change to frozen data was made. All source locations below refer to `work/ternary-goldbach/TernaryGoldbach` at commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

The completed dataset has 6,439 transitions from `A=10^9` to `B=5*10^9`. Each transition has an externally verified prime count, an explicit logarithm box at its right endpoint, and a scaled theta interval. The count proofs remain a separate uncompleted Lean task. This ledger specifies the arithmetic needed after those counts have been proved. It does not turn supplied counts into assumptions on the eventual public psi theorem.

## Source declarations and carriers

| Existing source | Exact role |
| --- | --- |
| `Prelim/SmallPsiTable.lean:216`, `SmallTab.S` | Scale `S=1000000000` |
| `Prelim/SmallPsiTable.lean:249`, `SmallTab.thS` | `thS(n) = sum_{p in Icc 1 n, Prime p} log p` |
| `Prelim/PsiSieve.lean:412`, `SieveTab.thS_sub` | Theta increment equals the prime log sum on `Ioc a b`, assuming `a<=b` |
| `Prelim/PsiSieve.lean:418`, `SieveTab.InvT` | `L/S <= thS(n) <= U/S`, with natural state numerators |
| `Prelim/SmallPsi.lean:21`, `Small.T12` | Rational Taylor polynomial with indices `0..11` |
| `Prelim/SmallPsi.lean:24`, `Small.ELpow` | `(27182818283/10^10)^q` |
| `Prelim/SmallPsi.lean:27`, `Small.chkStep` | Strict upper-log test through an exponential lower bound |
| `Prelim/SmallPsi.lean:56`, `Small.T12_le_exp` | Polynomial is at most `exp(f)` for `f>=0` |
| `Prelim/SmallPsi.lean:60`, `Small.ELpow_le` | Exponential integer-part lower bound |
| `Prelim/SmallPsi.lean:69`, `Small.log_lt_of_chk` | Successful `chkStep u S 1 x` implies `log x < u/S` |
| `Prelim/SmallMertens.lean:17`, `Small.EHpow` | `(27182818286/10^10)^q` |
| `Prelim/SmallMertens.lean:20`, `Small.T12up` | `T12(f)+13*f^12/(12*12!)` |
| `Prelim/SmallMertens.lean:23`, `Small.chkLow` | Weak lower-log test through an exponential upper bound |
| `Prelim/SmallMertens.lean:26`, `Small.EHpow_ge` | Exponential integer-part upper bound |
| `Prelim/SmallMertens.lean:34`, `Small.exp_le_T12up` | Upper Taylor estimate on `0<=f<=1` |
| `Prelim/SmallMertens.lean:45`, `Small.le_log_of_chk` | Successful `chkLow ell S x` implies `ell/S <= log x` |
| `Prelim/PsiSieve3.lean:233`, `SieveTab.outerT3_spec` | Existing proof of the exact cardinality/log-to-theta update; copy the small update argument, not its old range or `RtT` wrapper |
| `Prelim/PsiSieveMain.lean:28149`, `SieveTab.stg2813` | Already proved theta and log seed at exactly `10^9` |
| `Helfgott/NonPrime.lean:23`, `Helfgott.psi` | Natural-number Chebyshev psi, a sum on `range (n+1)` |
| `Helfgott/NonPrime.lean:27`, `Helfgott.theta` | Natural-number prime part of that sum |
| `Explicit/PsiSandwich.lean:82`, `Explicit.psiR` | Existing real wrapper `psiR(v)=Helfgott.psi(floor(v))` |
| `Prelim/ThetaExplicit.lean:33,42`, `theta_eq`, `psiR_nat` | Identifies theta with `thS`; specializes the real psi wrapper to natural arguments |

The numerical source modules already prove the logarithm implications. Reusing their declarations requires no new series convergence theorem. The current `ThetaExplicit` module has broad imports and other conditional theorems, but the two carrier identities listed here have no `PlattGRH` premise. Their proof bodies are elementary. Any eventual import narrowing must preserve their exact identities and is separate from this specification.

## The logarithm certificate, including the series tail

For a natural numerator `c` and positive denominator `S`, write `c=q*S+r` using Euclidean division, with `0<=r<S`. Put `f=r/S`. Then `c/S=q+f` exactly; there is no approximation in separating the integer and fractional parts.

Let

`T(f) = sum_{j=0}^{11} f^j/j!`.

For `f>=0`, all omitted exponential terms are nonnegative, so `T(f)<=exp(f)`. On `0<=f<=1`, the omitted series starting with `f^12/12!` has successive term ratios at most `1/13`. Thus

`exp(f) <= T(f) + (13/12)*(f^12/12!)`.

The source proves this upper estimate through `Real.exp_bound` rather than a new geometric-series argument. Its precise coefficient is `13/(12*12!)`. Do not replace it by `1/12!` or truncate after degree 11 without a tail.

The existing `Real.exp_one_gt_d9` and `Real.exp_one_lt_d9` give

`27182818283/10^10 < exp(1) < 27182818286/10^10`.

Raising these nonnegative quantities to `q` and multiplying by the fractional-part estimates bounds `exp(c/S)`. Consequently, for `x>0`:

* `chkLow ell S x = true` means `EHpow(q)*T12up(r/S) <= x` and proves `ell/S <= log x`.
* `chkStep u S 1 x = true` means `x < ELpow(q)*T12(r/S)` and proves `log x < u/S`.

The upper check's third argument is **1**, not the endpoint `x`. Otherwise it would prove an upper bound on `log x` multiplied by the wrong factor. The lower check is weak and the upper check is strict. The theta recurrence may weaken the strict upper result to a weak bound.

No inference from a rounded floating-point logarithm is accepted. The integer numerators are merely proposed data until these Boolean inequalities are checked. The completed data uses denominator `10^9`, with log widths at most 100 numerator units. A one-unit enclosure is not required and is not claimed. Candidate generation may use arbitrary hints; acceptance depends only on exact arithmetic.

## Equivalent natural-number log checker

This gives a smaller arithmetic interface if rational normalization becomes inconvenient. It introduces no new analytic estimate. A new algebraic bridge would prove equivalence to the two existing source checks.

Write `F=11!` and define the natural homogeneous polynomial

`P(r,S) = sum_{j=0}^{11} (11!/j!)*r^j*S^(11-j)`.

Each factorial quotient is integral. Direct expansion gives

`T12(r/S) = P(r,S)/(F*S^11)`

and

`T12up(r/S) = (144*S*P(r,S)+13*r^12)/(144*F*S^12)`.

The factor 144 is `12*12!/11!`. All denominators are positive when `S>0`. For `q=c/S` and `r=c%S`, the denominator-cleared checks are therefore exactly:

**Lower log check at numerator `ell`:**

`27182818286^q * (144*S*P(r,S)+13*r^12) <= x * 10^(10*q) * 144*F*S^12`.

**Upper log check at numerator `u`:**

`x * 10^(10*q) * F*S^11 < 27182818283^q * P(r,S)`.

Here `q,r` are recomputed from the respective lower or upper numerator. A Horner representation of `P` is also exact: start with `1`, then for `j=10,9,...,0`, replace the accumulator by `r*acc+(11!/j!)*S^(11-j)`. The new audit checks that this result equals the independent expanded sum at every numerator. A future Lean bridge needs only finite polynomial identities, factorial arithmetic through 12, positive-denominator multiplication, and the existing log-soundness theorems. Directly using `chkLow` and `chkStep` remains the simplest source reuse; no performance preference is claimed.

## One transition and its complete soundness argument

The semantic state is `(a,L,U,ell,u)` with all five fields natural, `a>=1`, and the invariant

`L/S <= thS(a) <= U/S`, and `ell/S <= log a <= u/S`.

A proposed row supplies the right endpoint `b`, the count `c`, its log box `(ell',u')`, and claimed next theta numerators `(L',U')`. The smallest arithmetic step checker verifies:

1. `b=min(B,a+a/4000)` using natural division, and `a<b<=B`.
2. Both log checks at `b`, using `(ell',u')` as above.
3. `L'=L+c*ell` and `U'=U+c*u'` exactly.
4. `b*(S-S/10000)<=L'` and `U'<=b*(S+S/10000)`.

A separately proved theorem must identify `c` with the cardinality of the primes in `Ioc a b`. This count is obtained by the subcell proof architecture, including adjacency, exact endpoints, and summing the subcell cardinalities. An external `count_verified=true` field is not such a theorem. The generic transition theorem may take the actual cardinality equality as an internal premise; the concrete final theorem must discharge every such premise.

Let `Q=(Ioc a b).filter Nat.Prime`. The source `thS_sub` gives

`thS(b)-thS(a) = sum_{p in Q} log p`.

For `p in Q`, positivity and `a<p<=b` imply

`ell/S <= log a <= log p <= log b <= u'/S`.

Summing and using `Q.card=c` yields

`c*ell/S <= thS(b)-thS(a) <= c*u'/S`.

Adding the old theta interval proves `InvT b (L+c*ell) (U+c*u')`. The current left lower logarithm is essential: replacing it with the newly checked right lower logarithm would generally be unsound. The right upper logarithm is essential on the upper side. No theta quantity is rounded or divided with truncation during these updates; multiplication and addition occur at the common scale before casting to the reals.

The new real log bounds follow from the source checker theorems. This proves the next state invariant. Since `S/10000=100000` exactly, step 4 translates to `abs(thS(b)-b)<=b/10000` without rounding. Implement step 4 as the two comparisons shown. Do not test whether a natural subtraction such as `L'-b*(S-S/10000)` is nonnegative: truncated natural subtraction would hide a failure.

The grid constraint and checkpoint comparisons are useful arithmetic invariants, but log widths, serialized state values, and a hash chain are not necessary mathematical hypotheses. They can be checked for bookkeeping. Reject a row if any count equality, log check, state equality, adjacency, or checkpoint comparison is missing. A successful row must carry proof, not just an asserted Boolean from external software.

## Rounding and the older optional log-chain path

`SmallPsiTable.log_chain_lo` at line 438 and `log_chain_hi` at line 459 prove, for `a>=1` and `G>=0`,

* lower numerator `ell + floor(S*G/(a+G))`;
* upper numerator `u + ceil(S*G/a)`, represented as `u+(S*G+a-1)/a`.

These follow from `G/(a+G) <= log(a+G)-log a <= G/a`. The lower increment rounds down and the upper increment rounds up. Their correctness is already proved, but the completed dataset uses explicitly checked boxes at every endpoint, so this alternative path is unnecessary. In particular, the old `outerT3` convention that a zero lower numerator selects a log-chain update should not be copied into the new data checker. Every row here has an explicit log certificate.

## Seed, composition, and the endpoint

The source theorem `stg2813` has four conjuncts. Use `.2.1` for `InvT` and `.2.2.1`, `.2.2.2` for the two logarithm bounds. The initial state is

`a=1000000000`,

`L=999967635190289132`, `U=999970323068320645`,

`ell=20723265833`, `u=20723265841`, `S=1000000000`.

This is a theorem at exactly `10^9`, even though the earlier `RtT` interval in the first conjunct has a strict upper endpoint. No limiting argument or extrapolation is needed. The seed also satisfies the new relative checkpoint inequalities by direct integer comparison.

Induct over the 6,439 transitions, or compose bounded blocks of such transitions. Each block imports the previous proved endpoint state and exports its final state plus every internal checkpoint bound. Adjacent state equality must include the endpoint, both theta numerators, and both log numerators. Retaining only the final state would not prove that every intermediate checkpoint passed. This arithmetic composition should consume exported count equalities, never recompute the sieve.

The last window is clipped by `min(B,...)`; its width is positive, but need not equal `floor(a/4000)`. The final state is

`a=B=5000000000`, `L=4999882220821805278`, `U=4999930929840072558`.

The closed intervals `[a_i,a_{i+1}]` cover all of `[A,B]`. Their shared endpoints cause no ambiguity because the checkpoint bounds agree there. In particular, `B` is covered by the finite result, and the proposed analytic estimate begins at `B`; the junction has overlap, not a gap.

## Real interpolation and the finite prime-power dependency

Write `ThetaR(v)=thS(floor(v))` as notation in this ledger, and use the existing `psiR` definition. The underlying theta and psi functions are on natural numbers. For real `v` in a grid interval with natural endpoints `a<=v<=b`, one has `a<=floor(v)<=b`. This gives `thS(a)<=ThetaR(v)<=thS(b)` by monotonicity of the nonnegative prime log sum.

The prime-power estimate needed here is only

`0 <= Helfgott.psi(N)-thS(N) < 1.4262*sqrt(N)`

for natural `10^9<=N<=5*10^9`. Thus this finite-envelope proof does not require the global P6 tail. The reviewed finite repair below `10^12` suffices. Its actual source dependencies are `LambdaMu.nonprime_sum_le4:589`, the finite psi table through `10^6`, `Small.psi_lt_small_700:12`, and the finite psi/theta identity `PsiTwoSided.thS_add_ppS:65`. The current production `LambdaMu.nonprime_mid:678` and `nonprime_small:751` still have `PlattGRH` binders, so calling them unchanged would not remove the dependency.

The full finite repair is in `RESUME_PRIMES_2026-11-11.md`, section B, and the uncompiled scratch scripts in `../moebius/FiniteBoundary.lean`. It replaces those binders' uses with the existing finite table and elementary estimates. For `10^6<=N<10^12`, put `w=N^(1/12)>=3.162`; the bound reduces to `w^6+1.03883*w^4+9.39643*w^3 < 1.4262*w^6`. The corresponding polynomial has positive value at `3.162` and positive derivative thereafter. This is reviewed paper mathematics, not a newly proved Lean theorem. Only this finite repair, not its global large-N continuation, is a necessary input here.

For `v>=A`, applying that bound to `N=floor(v)` and using `sqrt(N)<=sqrt(v)` gives

`0 <= psiR(v)-ThetaR(v) <= 17*v/360000`.

Indeed `sqrt(v)>=sqrt(10^9)>31622`, and the exact comparison `14262*360000 < 17*10000*31622` proves `1.4262/31622 < 17/360000`. The floor is at least `10^9`, so it stays inside the finite prime-power range. No unit correction is needed here.

Let `h=1/4000`, `e=1/10000`, and `k=17/360000`. Since `b<=a*(1+h)`, the two sides of the psi error satisfy

`v-psiR(v) <= (h+e)*a = 7*a/20000`,

`psiR(v)-v <= (h+(e+k)*(1+h))*a = 572053*a/1440000000`.

For the first inequality use `psiR(v)>=ThetaR(v)>=thS(a)>=(1-e)*a`. For the second use `psiR(v)<=ThetaR(v)+k*v<=thS(b)+k*b<=(1+e+k)*b` and `v>=a`. This explains both signs and why the upper expression uses the right endpoint. Both coefficients are strictly smaller than `1/2300`. Since `v>=a`, we get `abs(psiR(v)-v)<v/2300`.

Finally, `0<log(v)<23` on `[A,B]`: positivity follows from `A>1`, and the exact integer inequality `27^23>B*10^23`, together with `exp(1)>2.7`, gives `B<exp(23)`. Hence

`abs(psiR(v)-v) < .01*v/log(v)` for every real `A<=v<=B`.

Specializing to natural `v` and using `psiR_nat` gives the required integer envelope. This finite result does not validate the independent spectral hypotheses needed above `B`.

## New audit evidence and remaining proof work

The new script `resume_psi_log_recurrence_integer_audit_20261111.py` uses only integer arithmetic, Euclidean division, factorials through 11, and integer comparisons. It reads existing data without generating primes. Unlike the earlier full validator's `Fraction` evaluation of `T12`, this audit clears the denominators symbolically and evaluates the homogeneous polynomial in both Horner and expanded forms.

The saved JSON reports PASS for all 6,440 log endpoints including the source seed, or 12,880 inequalities, and all 6,439 recurrence updates. The largest comparison operand has 1,155 bits. It verifies all serialized rational theta values by cross-multiplication, all scaled updates, the 125,271 subcell boundaries and count sums, and the endpoint and interpolation arithmetic. The smallest lower checkpoint margin is `63519486670203/10^9` at index 14; the smallest upper margin is `121697722610142/10^9` at index 415. These agree with the prior full validation. The exact output records an input hash manifest and a digest of the normalized transition records.

This adds an independent arithmetic representation of the log checker and state recurrence. It is not an independent proof of the supplied counts, the source seed theorem, the P6 repair, or any Lean theorem. The independent full prime recount remains documented separately. The seed's logs and relative centering were rechecked arithmetically; its theta enclosure still comes from `stg2813`.

The remaining new generic Lean work is small in mathematical scope: an optional integer-log-check equivalence, a count-parametric theta-update lemma, relative checkpoint extraction, bounded transition composition with coverage, and the floor-based interpolation lemma. Every count and log certificate then needs an actual kernel check. The finite P6 repair needs its own proof. No declaration is frozen here; no new axiom, result hypothesis, or unverified external computation is accepted as a replacement. Build resource feasibility remains unmeasured.
