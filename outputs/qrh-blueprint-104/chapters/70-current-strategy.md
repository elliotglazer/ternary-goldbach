# Current strategy and remaining proof tasks

Research synthesis, 2026-11-11. This is the current route through the accumulated research, not a completed proof or a list of permitted assumptions. All finite zero assertions below are tasks to prove. The source remains `calr3/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

## Exact result to preserve

The large theorem must establish `TernaryGoldbachFrom (10^27)` without an analytic hypothesis. Combining it with the existing small-case proof must leave exactly `BinaryGoldbachInput`, meaning binary Goldbach through `4*10^18`, in the full theorem. Neither a new finite-RH premise nor a hypothesis asserting one of the target error bounds is an acceptable replacement for PlattGRH.

No large-case proof is currently supplied. The final source roots still have their original Platt premise. The campaign has three previously checked elementary/Mellin helpers, but no newly checked Goldbach theorem. This phase performs mathematical research and exact external arithmetic, without new Lean builds or canonical theorem edits.

## Final numerical assembly

At `x>=4.9e26`, with `y=x/49`, retain the existing circle-method decomposition. In units of `x^2/49`, the complete proposed budget is

| Contribution | Required bound |
|---|---:|
| Major arcs | at least 1.0404 |
| Absolute minor arcs | at most 1.0376 |
| Nonprime subtraction | less than .00271 |
| Positive reserve | .00009 |

The required major-energy and coprime residual targets are `8.6296<=J<=10`, `Aplus<=5e-7`, and `Astar+Cross<=9.5e-7`. The exact final budget checker verifies their numerical implication after removal corrections. It does not prove these analytic targets. The earlier error allowance that omitted nonprime subtraction is obsolete.

## Elementary replacements already complete on paper

These arguments preserve their consumer contracts and have passed independent source/mathematical review. They still require Lean implementation and exact consumer checks.

| Source obligation | Reviewed replacement | Remaining formal work |
|---|---|---|
| P2: harmonic von Mangoldt upper bound for every real x>=1 | Factorial/Abel identity, coarse Chebyshev coefficient 1.43 above integer cutoff 1e6, existing finite tables below it | Finite psi helper, carrier conversion, revised integer proof and floor wrapper |
| P3: harmonic von Mangoldt lower bound for every real x>=1 | A 45-coefficient rational floor kernel, elementary factorial remainders, and existing finite Mertens table; integer constant .739832361 below .74 | Exact kernel replay, finite rearrangement, real factorial bound and original N+1 endpoint |
| P6: nonprime von Mangoldt sum below 1.4262 sqrt(y), every y>0 | Existing prime-power decomposition; finite source tables and elementary large-range coefficient 1.412257 | Finite/middle/large proof assembly with strict endpoints |
| Sharp totient calls in the first/second Type I/II choices | Finite sharp estimate plus a common remote envelope; total layer cost below 1e-24 | All scale adapters, maximum of the two branches, convolution and terminal-layer transport |
| Separate quotient-sieve call | Coarse elementary totient estimate and finite parameter certificates | Specialized provider for the LSQuot6 consumer and exact finite replay |

The quotient-sieve repair uses `q>=2.2e10` and `R<lamQ(q)`. These are available at the production call. It does not prove the old general `LSQuot3.regionS` statement. Extracting its unconditional algebraic core and placing the specialized provider downstream of LSQuot5 avoids an import cycle.

Full P1/P4/P5/P7 remain open, but their remaining prime-distribution input now has one explicit sufficient target:

    E: for every integer v >= 1e9,
       |psiN(v) - v| <= .01 v / log(v).

The independently reviewed `PRIME_ENVELOPE_ASSEMBLY.md` derives all four original contracts from E, the reviewed P6 proof and existing finite tables. It includes the floor correction when passing to real arguments, the strict sieve endpoint at 1e9, and the signed Abel substitutions for P5/P7. E is unproved. It must be supplied by a proof, not added as a premise to Goldbach.

The independently reviewed integration argument derives the relaxed harmonic Mobius profile from E, P2 and existing finite certificates: coefficient .03 on [11815,100000001) and .10 on [100000001,infinity). The smaller arguments retain their separate finite treatment. Its exact 214-cell replay and matching infinite-tail checks pass. The new tail constant is approximately .097126813339<.10. The separate G2/Liouville adapters remain required. Thus E is a shared research target for the prime and Mobius inputs, not a claim that those inputs are now discharged.

P3's exact acceptance does not trust the floating optimizer used to discover its kernel: the independent checker reads rational coefficients only and verifies normalization, every breakpoint constraint, logarithmic constants and the complete error margin.

## Minor arcs: complete conditional base-gap coverage

The raw Type I/II theorems may be used as conditional source interfaces for numerical research. Their resulting coverage becomes unconditional only after every producer used by those interfaces has a proof.

The selected route now covers **all 150,000 reduced denominators**, every permitted twist and every y>=1e25, conditional on the same original uniform finite .555 certificate already needed for the major arcs, global QRH, the analytic bridges and the Type I/II producer replacements. This is a new route with spectral input. The earlier 78,642-denominator result remains a separate direct Type I/II route; it did not prove the finite spectrum.

Keep the original modulus m of alpha distinct from the reduced denominator q=m/gcd(m,2) of 2alpha. The parity-preserving arc extraction gives u in [1200000/49,1200000), and the actual etaU twist is d=u/(2q). The strengthened extraction must be proved directly from the major-arc cases; the exposed BaseGap2.gap_point statement deliberately loses some parity information.

For a prefix u<=U, take H(q,U)=max(250,ceil(242U/(7q))). This lies within the selected Hp(c) for every Gauss-active conductor c. Reflection gives beta in [.445,.555] there. The actual etaU Mellin moments at 0 and 1 give the uniform finite-strip transform bound 13/8. Exact Gauss weights, off-line multiplicity counts, Fourier main term, high tails, contour/zero0 terms and both coefficient-removal errors then give a pointwise bound below .044797 for every q>=4. The actual allowance is greater than .04712.

The remaining joins are independently reviewed:

| Reduced q | Finite spectral prefix, through u= | High-twist branch starts at u= |
|---:|---:|---:|
| 1 | 486477 | 190000 |
| 2 | 972954 | 300000 |
| 3 | 1068377 | 300000 |

The high branches retain the original Type I/II producers. The q=1 certificate has 128 exact scale cells and minimum margin .000338635937. The ratio-cap-2 branch for q=2,3 has 32 cells and minimum margin .001018323773. Both include all Gaussian integration bins, tails and every scale. Their closed domains overlap the finite prefixes. The root `base_gap_full_join_2026_11_11.py/.json` pins the reviewed artifacts and checks that their union leaves no denominator or twist gap.

This repairs the actual ghatY consumer; it does not establish the old stronger .0121 bound. The weighted spectral alternative and smaller-height profile have not automatically been substituted into this pointwise proof. The selected uniform .555 profile remains mandatory until a separate replacement is proved.

The relaxed smoothed-energy route, the quotient sieve, and the final nonprime reserve are separate parts of the minor-arc assembly. A denominator certificate does not prove them.

## Major arcs: global QRH plus finite weighted zero information

The global seven-eighths theorem is the proposed infinite-height input. Its source provider still needs local compilation, compatibility work and transitive type/axiom validation. The smaller 23/24 provider does not suffice for the present estimates. Reflection and true zero multiplicities need explicit source adapters.

The selected full-family route now has an independently reviewed quantitative sufficient condition. For every active primitive character of conductor c, prove that every actual nontrivial zero through height Hplus(c) has beta<=111/200=.555, counting multiplicities and both ordinate signs. Define

    qt(c) = 2c for odd c, and c for even c,
    Dc = 1200000 / qt(c),
    Hplus(c) = ceil(200 + max(1000, (704/7) Dc)),
    Hstar(c) = ceil(max(1000, (704/343) Dc)).

The maximum Hplus is 60,343,058. The active source modulus family contains 150,000 active conductors and 5,543,640,188 primitive characters, including conductor one. The uniform .555 condition through Hplus suffices for both smoothings because Hstar<=Hplus. No conductor is silently discarded. The finite assertion remains entirely unproved; global beta<=7/8 does not imply it.

The reviewed actual-smoothing Gram rows are 23000 for etaPlus and 49*102000 for etaU after the star twist rescaling. Combined with the source Jensen count, exact Gauss induction and the finite .555 strip, they give the low-zero norm bounds

    sqrt(Aplus_low) < .00007,
    sqrt(Astar_low) < .00049,
    N_low < .001,
    sqrt(Ep_low) < .0002.

The mixed proof uses genuine fourth moments: integral P_c^2<=sup(P_c)*integral P_c. Summing the resulting weighted bounds and applying Cauchy-Schwarz proves I_low<1e-8. The independently reviewed Gauss-induction operator has squared norm below 25, giving Cross_low<2.5e-7 while preserving two independent character indices and the actual arc windows.

The complete per-character remainders include high zeros, the vertical contour, the possible zero at zero, and primitive-to-coprime removal. Their joint mixed norm is below 2e-10 without assuming J<=10. This yields coprime Astar+Cross<5.001e-7, inside the required 9.5e-7 allowance; the other second-moment caps also fit. Do not add the older separate 6e-9 high-tail estimate again: high zeros are already in this joint ledger.

The independently reviewed q=1 corollary identifies its nonnegative Ep summand with the raw principal residual on [-600000,600000]. Restricting it to [-4,4] supplies a stronger local input than the old 8e-6 target. More directly, reverse Minkowski in the actual weighted principal space gives J>(2.94-.00020001-1e-9)^2>8.6296. The source Fourier energy and arithmetic weight bounds are unconditional, and this argument does not invoke the existing Platt-dependent L2 wrapper. Thus lower and upper J use the same Ep estimate on the selected branch. The earlier 2,750-cell local kernel route, the beta<=2/3 principal rectangle and the conductor-three beta<=.64 rectangle remain separate alternatives, not extra requirements.

The full-family review accepts this conditional mathematical implication and exact scalar replays. It does not prove the finite spectral assertion or the actual-smoothing analytic bridges. In particular, etaU still needs its full explicit-formula/GoodSmoothing construction. No computation-cost advantage over the original Platt verification has been demonstrated.

## What a finite certificate must establish

A list of approximate zeros is insufficient. A valid certificate needs complete counts with multiplicity, analytic nonvanishing on its contours, and an argument-principle or equivalent completeness proof. For zeta the function at the pole is the source's analytic continuation `zetaF`, not the raw pointwise product `(s-1)*zeta(s)`. For complex characters, reflection must track the conjugate character correctly.

A contour with left boundary exactly beta=b proves a stronger assertion than excluding only beta>b, because its boundary must also be nonzero. One contour with left edge strictly greater than b leaves a strip uncovered. A limiting argument requires a proved family of contours, not an informal appeal to taking a limit.

Uniformity in x must follow from a positive cell majorant or a product-space operator bound. Sampling the signed residual at the lower endpoint does not establish its value for every larger x. The finite certificate checker and its analytic error bounds must eventually be proved in Lean; successful external interval arithmetic is evidence for that replay, not its replacement.

## Next work and completion criterion

The next research tasks are to prove E over its entire range and construct the finite spectral certificates, while supplying the analytic and Lean bridges. An independently reviewed Gaussian-sandwich argument derives |psi(x)-x|<.0081*x/log(x) above exp(35), conditional on the original shared finite zeta condition and global QRH. Its exact all-scale budget is .008005031005022. It handles the changing Gaussian smoothing, both desmoothing inequalities and the high-tail transition at arbitrarily large x. The finite spectral assertion and the entire interval [1e9,exp(35)) remain separate proof obligations for that route.

The finite prime gap has a reviewed certificate design. Starting at1e9, use a_next=min(1.6e15,a+floor(a/6000)). This gives85,721 windows. Certified theta(a) within a/24000 of a at every endpoint would imply E on the entire gap by monotonicity and P6, overlapping the analytic tail. The source's internal stg2813 invariant supplies the first theta checkpoint at exactly1e9. All85,721 new counts, the complete log-box table and the remaining theta tests are still missing. The corrected log-width ceiling is1e-7; it is independent of the seed denominator1e9. A small output table does not establish cheap verification of its counts.

A separately reviewed refinement would reduce the prime-check interval to [1e9,5e9). It requires an additional complete zeta certificate through height1e6: beta in [.49,.51] and the both-sign multiplicity moment sum exp(35*max(beta-.5,0))/|rho|<=24. This finite claim is unproved. Under it, a sharper vertical integral and exact endpoint factors yield |psi(x)-x|<.00981*x/log(x) for x>=5e9, joined to the original tail at exp35. The full exact budget is .009798011781002001. This is an explicit tradeoff between stronger low-zeta data and a much smaller finite prime computation; it is not free information implied by the shared .555 condition.

The short-gap design and first external pilot have also passed independent review. The grid a_next=min(5e9,a+floor(a/4000)) has6,439 windows. The first, (1e9,1000250000], contains12,008 primes according to two independent external sieves. Its eight source-sized subcounts, rational log boxes and propagated theta checkpoint agree. The other6,438 windows remain uncomputed at this frozen checkpoint, and none of the new counts has been checked in Lean. The existing PS3 base can cover this first window after a proved height extension to31627^2; the full interval needs a complete base through70710 and generalized mask/count specifications. This is a reviewed alternative to the long finite gap, conditional on the additional low-zeta evidence above. The selected original route does not silently acquire that evidence.

A reviewed weighted alternative replaces the major-arc uniform .555 condition for c>1 by bounds on conductor-level spectral energies. One sufficient choice excludes finite zeros beyond .7 and caps counts above .54 separately in the plus and star carriers. The c=1 .555 condition is retained for psi. Product zero counts remove character ownership from the required data, but no runtime savings have been proved. This alternative has only been shown to preserve the major moment and psi inputs. It must not replace the selected uniform .555 condition in new pointwise base-gap arguments without a separate proof.

A separately reviewed smaller-height alternative uses Hplus=ceil(200+max(300,(484/7)Dc)) and Hstar=ceil(max(250,(484/343)Dc)). It preserves the .555 condition and all target caps, with a larger complete mixed remainder allowance of 3e-8. Its exact sum of primitive-character count times plus height falls from 7,549,963,670,988 to 4,187,651,193,034. This is a workload proxy, not a runtime estimate. The current primary profile remains the original one, also used by the proposed psi tail; adopting the smaller profile there requires a new high-tail check. Never combine the smaller heights with the original 2e-10 mixed remainder.

Small complete external contour pilots certify zero winding for two sample rectangles through height 20, using an explicit Euler-Maclaurin remainder. The coordinator independently reran them. These pilot rectangles do not use the new common .555 boundary. They test the evaluator and checker design; they do not supply the required full-height or whole-family certificates, and they are not Lean verification.

The implementation plan begins with the independently reviewed elementary repairs. It must preserve exact theorem types and leave unrelated conditional premises in place until their producers are proved. Later checking must inspect expanded types as well as axioms: a clean axiom list alone does not reveal an unwanted explicit or instance hypothesis.

Completion requires a connected proof of every major/minor input with the fixed final budget, no substituted analytic premise, and a complete finite-coverage join at 10^27. The current research has not met that criterion.

    DRAFT_ANCHORS: 0 created
    UNREGISTERED_SORRIES: 0 introduced
    DRAFT_IMPORT_VIOLATIONS: 0 introduced
    SEALED_THIS_TURN: 0
