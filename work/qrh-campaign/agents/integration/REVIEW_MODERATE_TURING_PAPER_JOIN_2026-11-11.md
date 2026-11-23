# Review of the moderate Turing paper join

2026-11-11. PASS at assembly scope, with no correction requested. Reviewed root `work/qrh-blueprint/MODERATE_TURING_PAPER_JOIN_2026-11-11.md`, SHA256 `5FDBD0B075D26AC73C0D86223CE33EB56FD667C638DD2AC0EBDCDC0C27C44921`.

This review checks the match between the already reviewed producer and consumer. It does not reattribute the finite-resolvent proof review to this reviewer. `independent_feasibility` reviewed that producer; I separately reviewed the quantitative implication. No analytic values, builds, source edits or new declaration occurred.

## Completion and exact interface

The producer uses `f(s)=c^((s+e)/2)*completedLFunction(chi,s)` for the actual parity e. On Re(s)>0, the source Gamma factor is `GammaR(s+e)=pi^(-(s+e)/2)*Gamma((s+e)/2)`. This follows directly from Mathlib `Gamma/Deligne.lean:45` and the even/odd Gamma-factor definitions in `LSeries/DirichletContinuation.lean:205–215`, together with the completed/usual relation at 258–259.

Hence the producer's f is `(c/pi)^((s+e)/2)*Gamma((s+e)/2)*L(s,chi)`. Compared with the consumer convention using conductor power `(c/pi)^(s/2)`, the exact ratio is the positive constant `(c/pi)^(e/2)`. It cancels from f'/f and from the unit-shift norm ratio. The parity shift inside Gamma remains; the quantitative review covers both e=0 and e=1. At Gamma poles the function is the entire source completion, not a totalized pointwise Gamma product.

The producer's reviewed export matches (F): for each fixed conductor, every compact disk centered at 1/2 and every positive epsilon receive one finite complete zero carrier with true orders and a real residual bound uniform over all nonzero points in that disk. The set can depend on the disk and epsilon. It need not be a numerical zero list. Possible central zeros are included through exact local factorization; the nonzero anchor is 2. The producer review explicitly checks uniformity near removed zeros, same-character reflection and the nonprincipal/open-strip zero carrier. No RH or central-nonvanishing premise is added.

The join correctly incorporates the producer review's radius-zero qualification. Replacing radius M by max(M,1) preserves the requested bound on the original disk and makes the working radius positive. Alternatively the non-strict contour inequality suffices. The horizontal consumer already uses a disk containing [1/2,5/2]+it in its interior, so it has positive radius. No strict inequality at a zero radius is needed.

The finite-factor consumer then yields `ratio_integral>=-4 Re(f'/f)(3/2+it)-5epsilon`; letting epsilon tend to zero is valid because the actual integral and derivative do not vary with the finite approximant. Exact orders make the quotient nonzero near the segment. The optional infinite resolvent export is unnecessary, as the join states.

## Quantitative and status composition

The previously reviewed quantitative implication gives the lower bound `I(t)>-12.493-1.5Z_t`; the unchanged upper bound is `I(t)<3.434+.75Z_t`. Canonical Littlewood with its fixed Euler-log convention and exceptional-endpoint treatment gives `[15.927+2.25Z_top]/pi`. At Z_top<=18 the numerator is 56.427<56.52=18*3.14<18pi. No extra parity constant enters I or S. The allowance applies to each channel; the count upper bound retains two allowances even for a real character.

The inherited `J(5/4)<148/125` remains reviewed paper/external interval evidence. This join neither converts it into a kernel certificate nor removes its analytic and checker obligations. Likewise source availability and accepted paper arguments do not establish imported compatibility or transitive axiom closure. The formal completion, finite-residue, exact-order, Gamma, Littlewood and closed-count adapters remain explicit. No final Goldbach premise changes.

The finite-RH example is accurately conditional: b18,h25,D<=1/2 gives reserve 3/50 and 320 additional step-5/64 indices; b30.25,h50 gives 29/100 and 640 indices. D changes with h. Neither interval width is guaranteed to succeed. The actual seed extension, sign/phase/interpolation evidence and count inequalities remain absent, and exact-count/list/head-moment consumers retain their stronger acceptance gates.

I also read the cited payoff note. Its less-than-2.1% statement concerns only halving h50's incremental transform contribution in the fixed nonnegative category-price model. It is not a whole-proof bound or timing forecast. The join preserves those qualifications and does not adopt b9. It is therefore sound to list b18 as another reviewed paper option while retaining the local b30.25 route as an alternative.

## Frozen references and review attribution

All six artifact hashes in the root join's evidence table were independently checked against disk. They are:

| Artifact | SHA256 |
|---|---|
| prime-estimates/GENERAL_COMPLETED_L_REAL_RESOLVENT_SOURCE_ROUTE_2026-11-11.md | 45B41467F5C57AB991088874D32B1163211709CAE4D9577D300E363F37D7317B |
| independent-feasibility/REVIEW_GENERAL_COMPLETED_L_REAL_RESOLVENT_SOURCE_ROUTE_2026-11-11.md | 45A360EFE4BB85EDB9741E94A5D3E8568083DDBA86A8C421FA246A245C5D7D02 |
| major-constants/TURING_MODERATE_ALLOWANCE_PROOF_PATH_2026-11-11.md | A480D72440F4A5D2C2BF539EB6D3C152428772060A7BFAF35582BCCDB525707D |
| integration/REVIEW_TURING_MODERATE_ALLOWANCE_PROOF_PATH_2026-11-11.md | 9CAADE7892BE7D6F5A860225016F1D345B2A6BB1E8122177055431FCCBFEA36C |
| integration/review_moderate_turing_scalars_20261111.py | 94CA0FE59EAD53260F3774A55C3E7C14791E8BD4A372E10E094A49ED5B2B5316 |
| integration/review_moderate_turing_scalars_20261111.json | DF420D1AC4AB341A58E5385CC3E803B5A5AF57AE075AB4449E340B1A0650D49F |

Agent paths are relative to `work/qrh-campaign/agents`. The root payoff note is `work/qrh-blueprint/TURING_RESEARCH_PAYOFF_2026-11-11.md`, SHA256 `68517C2DA892F3CCA8D26F1E4BD7FBBD37271B97BC50B8BE5B0BA2DC91E9CB75`. This assembly review adds no computation or proof of the underlying resolvent producer. Its independent producer review remains the second row above.
