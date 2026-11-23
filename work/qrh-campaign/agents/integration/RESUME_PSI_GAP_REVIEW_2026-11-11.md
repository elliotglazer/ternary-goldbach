# Independent finite psi-gap review

The corrected conditional grid argument passes the checks below. The original fixed-precision logarithm issue has been repaired by allowing `1e-7`-wide boxes and recomputing the uncertainty budget. Final corrected hashes and replay acceptance are recorded at the end; the earlier review is retained to explain the correction. The grid covers every integer from `A=10^9` through `B=1600000000000000`, including both endpoints, provided its theta checkpoint inequalities are actually certified and the reviewed unconditional P6 argument is formalized. The script does not compute or certify the missing prime data. No Lean compilation or axiom audit was performed in this review.

Reviewed frozen proposal `prime-estimates/RESUME_PSI_FINITE_GAP_2026-11-11.md`, SHA256 `A927C5E16BAB75DCCD3C0927CA5E66D855F0189865D697D39B69F669EAA29E37`, and its scalar script `resume_psi_finite_gap_20261111.py`, SHA256 `11640F2EC5E24D5DF6B090ABDE4729E8819AFB48616640E484A28FFBCAE74596`. Source pin is `23b2d68ca344203d4384e0aff7affa4ec034bef9`. These hashes bind the version before the precision correction was requested.

## Exact grid and all-integer coverage

The proposed recursion is `a[0]=A`, `a[j+1]=min(B,a[j]+floor(a[j]/6000))`, stopping on reaching B. Independently regenerating it as `min(B,floor(6001*a[j]/6000))` produces the same 85,721 windows and 85,722 endpoints. The SHA256 of the decimal endpoints, each followed by a newline, is

`18315e7fd513e3c15c9714a8d7421e0235f979638ded5a6f0feb7c494ea227d1`.

Every step is positive, each upper endpoint is the next lower endpoint, and `6000*(b-a)<=a`. The final shortened window ends exactly at B. Therefore these closed windows cover every integer `A<=n<=B`. Either use closed intervals throughout, or use half-open intervals and handle B by its checkpoint. A verifier must not omit the final endpoint merely because the original sieve's public theorem uses a strict cutoff.

## Theta interpolation and prime powers

The requested checkpoint property is `|theta(a)-a|<=a/24000` at every grid endpoint. For `a<=n<=b`, monotonicity and nonnegativity give

`theta(a)<=theta(n)<=theta(b)` and `0<=NP(n)`,

where `psiN(n)=thetaN(n)+NP(n)` is the exact source identity `Prelim/LambdaMu.lean:61`. `thetaN` at line 59 and `SmallTab.thS` at `Prelim/SmallPsiTable.lean:249` have identical prime-sum definitions over `Icc 1 n`.

The proposed use of P6 is valid. The reviewed paper replacement gives `NP(n)<1.4262*sqrt(n)` for all positive n. Since `31622^2<10^9<=n`,

`NP(n)/n < 1.4262/31622 < 17/360000`.

This uses the new unconditional replacement of P6, not the existing production theorem's `Fact PlattGRH`. Its implementation remains a dependency. It does not presume the psi envelope being proved, so this transport has no circularity.

Consequently the upper error is at most

`theta(b)+NP(n)-n <= (b-a)+(1/24000+17/360000)*b`

`<= [1/6000+(1/24000+17/360000)*(1+1/6000)]*a`

`= (17251/67500000)*a < a/3600 <= n/3600`.

The lower error is at most

`n-psiN(n)<=b-theta(a)<=(1/6000+1/24000)*a=a/4800<n/3600`.

The independent script checks both affine endpoint inequalities on every generated window, not just one representative width. The upper margin is `1499/67500000`, and the lower margin is `1/14400`. For `n<=B<exp(36)`, positivity of `log n` yields `n/3600<.01*n/log n`. Thus the desired absolute envelope follows for every integer in the finite interval. No interpolation of psi itself and no information about the locations of primes within a window is necessary once both theta endpoint bounds have been certified.

## Existing source seed at exactly 1e9

The public `SieveTab.sieve_table3`, `Prelim/PsiSieveMain.lean:28160`, has a strict upper cutoff. The stronger internal declaration `SieveTab.stg2813` at line 28149 contains, as its second component,

`InvT 1000000000 999967635190289132 999970323068320645`.

`InvT` at `Prelim/PsiSieve.lean:418` means exactly

`tlo/SmallTab.S <= SmallTab.thS(m) <= thi/SmallTab.S`,

and `SmallTab.S=10^9` at `Prelim/SmallPsiTable.lean:216`. This gives the claimed theta interval

`[999967635.190289132, 999970323.068320645]`

at the integer `10^9` itself. Both endpoints lie strictly inside `A +/- A/24000`; the independent rational check verifies both margins. This extraction does not require proving `10^9` composite or extending the strict public theorem by continuity. The exact source invariant already contains the endpoint.

The displayed stage has no `Fact PlattGRH` binder and advances the finite sieve chain through `outerT3_spec` and `resEqT_spec`. This is source-level evidence of the finite theorem's role, not a new transitive kernel-axiom check of its compiled artifact. Such validation must be performed before a formal closure claim.

## Junction with the analytic tail

Independent exact Taylor bounds certify `exp(35)<B<exp(36)`. The author's comparisons using the existing source bounds `2.7<exp(1)<2.7182818286` are also valid. The interval `[A,B]` therefore overlaps the conditional Gaussian-strip tail starting at `exp(35)`. There is no rounding gap between the natural finite endpoint and the real analytic threshold.

The analytic-tail note remains conditional on the actual finite spectral assertion, genuine global QRH, and its described mass/explicit-formula bridges. This review only checks the endpoint junction; it does not turn those hypotheses into established theorems.

## Reproducibility and limits

The count-to-theta recurrence itself is correct. A count on `(a,b]` times a lower enclosure for `log a` is a lower bound for the interval's theta increment; multiplying by an upper enclosure for `log b` gives the upper bound. This treats both prime endpoints correctly. The width estimate also correctly separates uncertainty from centering: a narrow enclosure alone does not show that it lies inside `a +/- a/24000`.

The precision issue concerns the claim that the current source APIs support width at most `1/D` for `D=10^9`. `SmallMertens.EHpow` fixes the upper base at `2.7182818286`; `SmallPsi.ELpow` fixes the lower base at `2.7182818283`. At integer exponential parts 20 through 35 their accumulated logarithmic gap alone is greater than `2e-9`, before the degree-12 remainder is included. The checkers are sound but their fixed approximation errors cannot be removed by increasing the denominator of the candidate rational log bounds.

I replayed the exact source expressions `EHpow*T12up` and `ELpow*T12` with Fraction arithmetic. At A the nearest successful fixed-denominator bounds are `20723265835/1e9` and `20723265839/1e9`, width `4e-9`; at B they are `35008780022/1e9` and `35008780027/1e9`, width `5e-9`. The floating logarithm only selects a search neighborhood. Acceptance is exact rational arithmetic, and within that neighborhood the tests are monotone in the rational argument. These checks demonstrate the failure of the asserted direct `1e-9` implementation at the endpoints.

A conservative repair is to allow each certified log box width `1e-7`, still with denominator `1e9`. The total added uncertainty is then bounded by

`[1.387/120000+2e-7]*x`,

instead of the original `[1.387/120000+2e-9]*x`. This follows from `sum c_i <= theta(x)/log A <=1.387*x/20` and each bucket's log variation at most `1/6000+2e-7`. Adding the initial bracket width, divided by A for the worst relative contribution, remains strictly below the allowed full width `1/12000`. The independent script checks that inequality. Every proposed log box must still pass its source checker. This review has checked two endpoint boxes, not generated all 85,722 boxes. The required theta centering tests remain missing regardless of precision.

The alternate prime-power identity is correct for the finite range: `NP(N)=sum_{k=2}^{50}theta(floor(N^(1/k)))`, since `2^50<=B<2^51`. Integer roots require exact power comparisons. The maximum square root is 40,000,000, so the auxiliary root arguments lie below the finite source cutoff. Using this identity would need a separate checker and budget; the reviewed interpolation above uses P6 instead.

The proposal correctly states the limit of `PsiSieve3.cnt3_spec` at line 166: `W<=32768`, `31622<=n`, and `n+W<1000014129`. It cannot verify the new grid directly. Its number `48,828,094,483` for a hypothetical extension using 32,768-wide blocks is arithmetically correct, but does not provide the extension. The optional external prime-count algorithm discussion is an engineering direction, not an input to this proof review; no external algorithm or its complexity theorem was validated here.

`resume_psi_gap_review_20261111.py` independently reconstructs the full grid, checks every window's integer constraints and both affine bounds, checks the source seed rationals, and proves the exponential junction using rational Taylor enclosures. It also replays the author's scalar code before its print/write footer, so it does not overwrite the author's artifacts. The run exited 0 and wrote `resume_psi_gap_review_20261111.json`.

The missing finite data are substantive. The script's 85,722 endpoints are not 85,722 evaluated theta values. Counts or equivalent certificates covering every intervening prime interval still must be generated, checked against actual primality, and accumulated with outward logarithm bounds. The existing small-prime sieve cannot be applied beyond its stated square-root/base-prime domain without a proved generalized checker. Neither estimated prime counts nor the script's grid and scalar checks discharge this obligation.

## Final corrected version accepted

The author separated `D_seed=10^9` from the logarithm-width scale `D_log=10^7`, retained the exact original theta seed, and made clear that log endpoints may use a finer denominator. The revised wording only claims soundness when each existing log check succeeds; it no longer claims that the full collection has succeeded. The revised JSON explicitly records `log_boxes_certified=false` and `missing_new_window_counts=85721`.

I verified the following file hashes and reran the corrected computation read-only, comparing its complete output object to the saved JSON:

- `prime-estimates/RESUME_PSI_FINITE_GAP_2026-11-11.md`: `2C2D0ED866EAE332B8DAE17CD20DD4E1755F59B5894E9B74347E508326D42F88`.
- `prime-estimates/resume_psi_finite_gap_20261111.py`: `543F5C69D814BB46AB02B47DA8E8D138F64AF01AAEE7141321441911525FE4D5`.
- `prime-estimates/resume_psi_finite_gap_20261111.json`: `FE6ACFDB6F225F708C57B2C236B557B427BF0D8C5DA4894D03B6DABCB9FAF79E`.

The independent review script exited 0 again. In addition to the unchanged full-grid, interpolation, P6, seed, and exponential-junction checks, it verifies the revised added-width coefficient `1411/120000000` and seed-plus-width coefficient `43338634094539/(3*10^18)`, strictly below `1/12000`. The correction is accepted for this conditional certificate design. All 85,721 new prime counts, the complete logarithm-box table, the theta centering checks, and the eventual Lean implementation remain unverified. This acceptance is not a proof of the finite psi envelope.
