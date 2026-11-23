# Selected no-Platt route: source-level closure audit

Research audit against `work/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build, canonical edit, new declaration, or new allowed assumption. Source references below are relative to `TernaryGoldbach/`.

The selected blueprint has an identified replacement for every inspected Platt-dependent branch reaching the final root. This is a conditional research dependency map, not formal closure. The genuinely missing external mathematical evidence is concentrated in the original full-family finite `.555` spectral certificate and the remaining finite prime-error interval. The global 7/8 provider, substantive analytic bridges, finite replay, and final type/axiom validation are also unfinished. The new base-gap argument and its small-denominator high branches now have completed separate paper reviews, pinned below.

Use one consistent package: the ORIGINAL `Hp(c)` finite profile with `beta<=111/200`, global `beta<=7/8`, major `1.0404`, minor `1.0376`, nonprime reserve `.00271`, and final positive reserve `.00009`. Do not substitute the reduced-height alternative or integrated weighted-moment condition into the new pointwise base-gap proof.

## Exact final root and branch structure

`Helfgott/Main.lean:68`, `ternaryGoldbachFrom`, targets every odd natural `N>=10^27`. It uses `repSum_lower_bound`, `nonprime_input`, and `final_inequality_crude`; `isSumOfThreePrimes_of_repSum_ne_zero` itself omits Platt. `Helfgott/Inputs.lean` supplies the circle identity, major and minor inputs, and nonprime bound. The circle identity and nonprime bound already have no Platt premise.

The selected major input changes `1.049` to `1.0404`. Therefore the literal old `repSum_lower_bound` and old final numerical argument cannot simply be reused unchanged. The reviewed numerical route bounds the same existing `6.7e6*N*sqrt(N)*log N` subtraction by `.00271*x^2/49` for every `N>=10^27`, leaving

`1.0404-1.0376-.00271=.00009>0`.

This is an elementary numeric adapter, not a new prime-distribution input. The inclusive threshold remains `10^27`. `Helfgott.ternaryGoldbachUpTo` explicitly omits Platt and retains `BinaryGoldbachInput`. The final `Statement` and both wrappers in `MainTheorems.lean:16,23` must be rebuilt with only that binary premise for the full theorem and no mathematical premise for the large theorem. An unused `Fact PlattGRH` binder would still violate the target even if its proof term's axiom list were standard.

## The ten Type I/II producer interfaces

I rechecked their actual call sites in `MinorArcs`. The historical status paragraphs in `TYPEII_REMAINING_INPUTS.md` are superseded; its boundary and exact source domains remain useful.

| ID | Existing producer and domain | Actual consumers | Selected repair |
|---|---|---|---|
| P1 | `Prelim.LambdaMu.sum_vonMangoldt_lt:337`, real y>0, psi(y)<1.03883y | `TypeI2Proof:753`, `TypeI2Large:44`; separately `EBound:218` | Existing small finite tables plus E give the entire original coefficient. |
| P2 | `sum_vonMangoldt_div_le_log:535`, x>=1, sum Lambda(n)/n<=log x | `GcdSums:155`, `TypeI2Proof:258,752`, `TypeI2Large:82` | Reviewed elementary P2 proof, compact constant1.43 and finite split1e6. No E, QRH, or P6 needed. |
| P3 | `log_sub_le_sum_vonMangoldt_div:1170`, x>=1, log x-log(3/sqrt2)<=sum Lambda(n)/n | `TypeI2Large:87` | Reviewed 45-term floor-kernel/factorial proof plus existing finite MertWalk. No psi envelope needed. |
| P4 | `sum_vonMangoldt_le_a14:1375`, y>=2.5e7, psi(y)<=1.0064y | `TypeI2Large:71,331`, `TypeI2Sum:389` | E plus finite sieve and P6 gives coarse psi<=1.002y from1e6, preserving1.0064. |
| P5 | `sum_vonMangoldt_mul_lt_a17:1362`, y>=2.5e7, sum n*Lambda(n)<1.022y²/2 | `TypeI2Large:322`, `TypeI2Sum:380` | Same two-sided coarse psi envelope and Abel identity give coefficient1.0075968<1.022, including lower endpoint. |
| P6 | `sum_vonMangoldt_nonprime_lt:761`, y>0, NP(y)<1.4262sqrt(y) | `TypeIIReduction:388`; separately `EBound:220,247` | Reviewed full-domain elementary repair; finite source kernels below1e12 and nonprime decomposition/Chebyshev above. |
| P7 | `sum_log_sq_primes_le:1884`, y>=2e6, dyadic prime log-square sum<=y*log(y)/2 | `TypeIITotal:37`, inherited by `TypeIITotalGen` | E, finite theta sieve and P6, with real-floor reserve and exact Abel endpoint terms. This is a main Type II input and cannot be omitted. |
| M1 | `LiouvilleBound.abs_sum_moebius_div_coprime_le_log:680`, q>=1,q<x, coefficient2.8 | `TypeITotal:44`, both first/second-choice Type I branches | Reviewed `.03/.10` profile implies the existing `.14` input to Liouville; preserve `.99`, then2.8 and existing SmallCGrid. |
| M2 | `T2Bound.T2_le':23`, real S>=16, T2(S)<=.37273 | `TypeIIS1:345,348,400`, generic Type II branches | New internal G2 integral<=.0089, from the relaxed profile and exact replay; preserve public .37273. |
| R1 | `MertensProduct.div_totient_lt:2258`, q>=1,r>=3,q<=r | `FirstChoiceTypeII:153`, `SecondTypeIIa:172`, `SecondTypeIIb:216`, `SecondBridge:58`; downstream `GBound:89` | Finite q<=2^1000 theorem plus elementary fourth-root/remote-envelope consumer repairs. This does not prove unrestricted `div_totient_lt`. |

`PointwiseBound.theorem_3_1_1:65` uses `x>=2.16e20`, the full `Approx2` hypothesis and the split `q<=x^(1/3)/6`. Its two branches call the first/second-choice final theorems. `SecondBridge` calls first choice again. Decomposition, rational approximation, the generic Type II S2 large sieve, and the unweighted/log-weighted elementary coprime Möbius bounds remain reusable without a new cancellation assumption. No eleventh prime/Möbius producer appeared in the inspected boundary.

### The common E input and its actual status

E is the exact integer assertion `|psiN(v)-v|<=.01*v/log v` for every integer `v>=1e9`. It is not an allowed extra premise of Goldbach. Reviewed `PRIME_ENVELOPE_ASSEMBLY` and its audit derive P1/P4/P5/P7, retaining the real-cutoff loss: for real t>=1e9 the safe envelope is `.011*t/log t`, not `.01*t/log t` without a floor correction.

The reviewed shared-strip Gaussian argument proves E on paper for `x>=exp35`, conditional on the same principal finite `.555` certificate, global QRH, and the translated true-multiplicity xi-mass bridge. The finite-gap design covers `[1e9,1.6e15]`, with exact overlap `exp35<1.6e15<exp36`. Its source seed at1e9 is `SieveTab.stg2813.2.1`, not an invalid extension of `sieve_table3`.

That design still needs 85,721 actual certified prime counts, all logarithm boxes, and theta centering tests. The accepted correction uses seed denominator1e9 and log-width scale1e7. The grid is not the data. The optional new low-zero moment refinement is not needed for the selected original route and is not silently assumed here.

### E to Möbius to M1/M2

`integration/RESUME_MOBIUS_INPUT_2026-11-11.md` and the independent `mellin/RESUME_MOBIUS_REVIEW_2026-11-11.md` review the 214-cell induction and changed terminal/tail constants. They give the real profile `.03` on `[11815,100000001)` and `.10` thereafter from E, P2, and existing finite source inputs. The revised tail uses nu=.037,b=.060,K0=.022,S/T=.000135; it does not reuse old terminal constants. Its final bound is below .10. P3 is separately needed for Type I even though the repaired Schoenfeld tail no longer needs it.

For M1, `LiouvilleBound.term_big_le:241` calls `abs_m_le_014` on arguments>=11815. The new profile immediately implies `.14/log x` there. The finite small-argument branch stays unchanged. The original `.99` Liouville bound and `2.8` coprime bound then survive. `MoebiusBound.abs_sum_moebius_div_le:30` can likewise use `.10` in place of its old `.09` step and preserve `.55/(log x-.7521)`; there is no reason to claim the old `.09` result.

For M2, the relaxed profile gives the squared-tail allowance `.000591`, and the existing exact replay gives the altered G2 integral bound `.0088846711<.0089`. The literal old `.0082` theorem is not supplied. `T2Bound:23` only needs

`1.4423050431/4+9.2185538/10000+(5/4)*.0089=.372623116155<.37273`.

The finite `16<=S<10000` branch is unchanged. Proved soundness for the modified G2 checker/data and the real/integer profile adapters remains implementation work, not another unproved prime envelope.

## Totient and quotient-large-sieve routes are distinct

For R1, the reviewed finite theorem covers `q<=2^1000` with **no upper bound on r**. `MertProd.inv_2000` already contains the necessary finite primorial/product facts. The global elementary estimate `q/phi(q)<=2q^(1/4)` repairs the first-choice rest term at the original constants. For the remote second choice, the replacement is a weaker pointwise bound, not the old sharp logarithmic helper. With `S=2^500`, use

`H(r)=12000*log(max(r,S))²/max(r,S)^(1/4)`.

The repaired `GBound/Prop1123b/LinftyLevels` transport raises `ghatY(y,n)` by `1.398*H(n)`. The reviewed analysis includes all convolution scales, the plateau, initial/middle/terminal layers, and the asymptotic choice of r2. Its total Mexpr increase is `<1e-24`. Retain this correction explicitly; the original pointwise theorem is not automatically recovered. The finite first-choice estimates used for q1/2/3 base high branches preserve their constants.

A separate path is `LSQuot3.regionS:75 -> LSQuot6.prop_12_2_4:69 -> LargeSieveProof.cor_12_2_5:378 -> Thm1321.thm_13_2_1_repaired:146`. `regionS` uses both the sharp totient bound and a conditional theta bound. The reviewed `work/qrh-blueprint/REGION_S_ELEMENTARY.md` bypasses both through finite Mertens data and an elementary coarse totient bound, preserving the quotient constant cPlus=2 and existing cE. The other `LSQuot6` large-R and finite-q branches have no additional Platt input. This is not Type II's generic S2 large sieve and must remain a separate adapter.

Thus “full totient repair” means all selected consumers are covered. It does not mean the old unrestricted Mertens-product theorem has been proved.

## Every additional MinorTotal input

`MinorTotal.minor_total:323` has the following conditional branches beyond the Type I/II boundary. Its existing summability, prime support, norm-square splitting and the uniform etaStar bound22.75 are reusable.

| Source use | Needed quantity | Selected replacement and check |
|---|---|---|
| `norm_sq_sum_a2_le:138`, used in step2 and `I0_ge` | residual energy<=8e-11*x | Reviewed elementary `EBOUND_UNCONDITIONAL.md`, preserving actual small-prime/nonprime carrier and cutoff. It proves the final large-x bound without global P1/P6; alternatively the full repaired P1/P6 are available once E is proved. |
| `T_le:216`, used at415 and433 | prime-restricted square energy | Direct actual-smoothing weighted energy<=.65*x*log x. Preserve summability; no positive lower bound on T is needed. Recompute sig, sD, tau and Mexpr numeric adapters. |
| `I0_ge:277`, used near417 | lower prime-restricted major energy8.6294*x | Shared-family Ep supplies full J>8.6296. Combine with the unchanged residual energy and t=1e-5 split exactly as source. No need to reproduce the old two-sided `l2_major_14_7` or upper8.79. |
| `hv0:394`, base gap at395–403 | pointwise<=y*ghatY(y,150000), y=x/49 | New original-height finite-family pointwise route plus q1/2/3 high branches, described below. Does not assert the obsolete `.0121*y` lemma. |
| `hvn:404`, and off-larger-arcs part of hv0 | pointwise at every level150000<n<=r2 | Repaired ten-producer route and the raised totient envelope. `LinftyLevels.norm_S_etaStar_le_ghat:358` is conditional in source; its elementary transport alone does not remove that dependence. |
| `key:410` | repaired integrated layer inequality | Independent regionS/quotient repair above, preserving `PrimeSupported`, scale and logarithm side conditions. |

The direct energy proof uses global7/8, the `.07` positive xi-mass bound for each finite actual zero rectangle, actual etaPlus projection/derivative estimates, kernels172 and566, and the unconditional explicit formula. It yields the stronger paper upper bound `(.64621*log x-.021095)*x`, hence `.65*x*log x`. The `.07` mass is an analytic theorem obligation through xi logarithmic derivatives and true multiplicities, not an extra finite spectral certificate or RH. Totalized tsum must not replace its absolute summability proof.

The reviewed numerical replay for zero-offset sigma=.65log x gives Mexpr<=1.037 on every finite source cell and the infinite tail after changing sD/tau. Adding the totient correction allows the convenient bound1.037001. The final source split gives

`1.0005*1.037001+2001*22.75*8e-11=1.03752314232<1.0376`.

This has room for the stated correction. No extra base-gap increment is needed if its new pointwise proof stays below the old ghat; the raised envelope is larger still.

## Selected new base-gap coverage

The frozen new report is `zero-sum/RESUME_BASE_GAP_FINITE_FAMILY_2026-11-11.md`, SHA256 `09340D4135D7E895E6F3FDA660DE9A7F773A91FF41F3B88FC125C814884D5E74`. Its completed independent review is `audit/RESUME_BASE_GAP_FAMILY_REVIEW_2026-11-11.md`, SHA256 `973B7B90B892E2514D3C3A6953880F784964D0E22BEE19D628877940FE0D7E73`. The separate small-q high-branch review is `independent-feasibility/RESUME_SMALL_Q_HIGH_REVIEW_2026-11-11.md`, SHA256 `F3EC07159059587EA4031B2FD06BFF74BDC1491048DAD986BE79201A29ED3F54`. Both pass as conditional paper arguments and exact scalar replays, not Lean or actual zero certificates. The q1 high branch has its earlier completed `RESUME_Q1_FINITE_REVIEW_2026-11-11.md`.

Preserve the distinction between original character modulus m and reduced approximation denominator `q=m/gcd(m,2)`. A strengthened parity-preserving gap extraction gives `1<=q<=150000`, `u=2q*|delta|` in `[1200000/49,1200000)`, and actual etaU twist `delta`, with no further factor49. The original `BaseGap2.gap_point` statement is too weak to supply these sharper endpoints without an adapter.

Under the ORIGINAL shared Hp(c), reflection gives `.445<=beta<=.555` for the relevant finite zeros of each primitive character. The actual etaU Mellin moment interpolation gives13/8, and exact Gauss support, low multiplicity counts, broad-twist high tails, contour/zero0 and noncoprime corrections yield a pointwise bound below `.044797*y` for all reduced q>=4. The independently reviewed lower ghat comparison is `.04712`, not the endpoint upper diagnostic `.060272` and not the old `.0121` surrogate.

The finite prefixes are closed at u=486477,972954,1068377 for reduced q=1,2,3 respectively. The separately reviewed q1 high branch starts at190000. The reviewed small-q ratio<=2 high branch starts at300000 and covers q2 and q3. The independent high-branch reviewer recomputed those overlaps. Thus there is no remaining denominator or twist gap in this conditional plan. The high branches still need P1–P7/M1/M2 and their finite totient comparisons; they do not provide an independent escape from E. The global7/8 source-tail input remains necessary above the finite cutoffs.

The new pointwise assertion replaces only the actual gap input to hv0. It does not prove the old Cor713 primitive-character bound or the old BaseGap2 `.0121` statement. Those stronger historical declarations can remain unused. The strengthened parity adapter, etaU GoodSmoothing/explicit formula, reflection including conjugate characters, true multiplicities, finite enumeration, and limit passage remain substantive proof work.

## Major route and shared finite evidence

The original `MajorTotal.resid_plus:233`, `resid_star:264`, `pointwise_bound:760`, `per_modulus:808`, and `major_total:974` contain the old Platt-dependent residual chain. The selected averaged proof replaces that chain; it does not feed `.555` to the unchanged finite-RH binders.

The reviewed original-height full-family package supplies coprime `Aplus<=5e-7`, `Astar+Cross<=9.5e-7`, N<=1.23 and Ep<=1e-4, with sharper Ep available for lower J. It includes genuine fourth moments, both character indices, star twist rescaling, true Gauss-support weights, high tails, contour/zero0 terms and primitive/coprime/full transfers. The joint remainder estimate does not assume J<=10, avoiding a circular proof of that upper bound. The resulting full J lies between8.6296 and10.

The dynamic cubic loss is below .008778, retaining the reviewed full residual corrections and the unchanged main-term comparison. Hence major>=1.040492451>1.0404. Original `.555` heights also supply the new base-gap pointwise finite region and the zeta component needed by the E tail. The same finite evidence is reused, rather than assumed independently three times.

Its content is still unproved: every nontrivial zero of every active primitive character, including principal conductor1 and all conjugate characters, must satisfy the bound through its inclusive conductor-dependent Hp(c). The selected family contains150000 active conductors and5543640188 primitive characters. Enumeration counts are external exact arithmetic, not a proved finite spectral certificate. A finite count with completeness, boundary, pole and multiplicity handling is required. The smaller23/24 provider cannot replace global7/8 here.

The lower-J corollary from the same principal Ep removes the separate local2750-cell spectral kernel certificate from this selected route. Integrated major moment caps alone do not imply the new pointwise base-gap estimate; its distinct finite-family argument is essential.

## Remaining leaves, without inventing allowed assumptions

1. Prove the original shared finite `.555` spectral assertion for the actual active L-functions, with exhaustive character coverage and inclusive heights. No such certificate has been produced.
2. Prove the remaining finite E interval, currently by the accepted theta-grid design through1.6e15 or another genuine proof. No new prime-count data are available. Combined with the reviewed shared-strip tail, this supplies the all-range E used by four prime producers and Möbius.
3. Validate and integrate the genuine global7/8 provider in a compatible environment. Its known source proof is not a checked local target artifact; this is a provider/type/axiom gate, not permission to add its conclusion as an axiom.
4. Complete the specified analytic proofs: positive xi mass with divisor multiplicity; actual-smoothing projection, Gram/IBP, etaU convolution and GoodSmoothing; primitive character/Gauss/induction adapters; zero0/pole and common-height limit handling; positive smoothing/desmoothing. These are derivations from the selected inputs, but remain real mathematical implementation tasks.
5. Formalize the reviewed elementary P2/P3/P6, finite/remote totient and regionS repairs, modified Möbius/G2 soundness, finite replay, energy and minor numeric adapters, averaged major comparison, and final nonprime arithmetic. Existing source finite tables must retain their checked semantics; a Python replay is not their replacement theorem.
6. Preserve the completed independent new base/small-q review bindings, then audit expanded root types and transitive axioms after implementation. Remove residual Fact binders and avoid routing through unused old conditional wrappers. Only BinaryGoldbachInput remains permitted in the full Statement.

No additional independent distributional premise was found in the inspected selected consumer graph. This conclusion is limited to this source-level boundary audit, not a compiler-generated complete dependency graph. It does not claim that all derivations are already formalized or that the two finite evidence projects are computationally inexpensive.
