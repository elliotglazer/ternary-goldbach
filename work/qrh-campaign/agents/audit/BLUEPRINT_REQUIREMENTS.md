# Blueprint requirements and independent closure audit

This is a research blueprint requirements audit, not an approved/frozen declaration manifest, a source dependency database, or a claim that ternary Goldbach has been proved in Lean. Source pin: calr3/ternary-goldbach, cde-moebius, commit 23b2d68ca344203d4384e0aff7affa4ec034bef9. No Lean compiler or implementation was launched for this task. Paths below are relative to work/ternary-goldbach/TernaryGoldbach unless they begin agents/.

## 1. Refute-first findings that control the blueprint

1. **The earlier averaged budget omitted nonprime terms.** The number .011670451 is 1.052105346-.002834895-1.0376. Spending all of it only establishes major greater than minor. It does not establish positivity of the count restricted to primes. The source subtracts as much as 6.7e6*N*sqrt(N)*log(N). All old A/V budgets derived by dividing this entire number between two errors are superseded as full-Goldbach sufficiency claims. Section 4 gives the corrected primary route.
2. A principal estimate on delta in [-4,4] can supply the lower major energy. It does not supply the upper major energy, the principal contribution on the entire major-arc twist range, the etaStar residual, or the mixed fourth moment.
3. QRH with beta<=7/8 cannot be substituted into the existing critical-line estimates. ZeroSumGen.zero_sum_boundG uses beta=1/2 both for x^rho and for Mellin bounds. A provider at 23/24 or a local gap beta<=.996 cannot support the proposed global 7/8 quartet estimate.
4. Replacing the major-character estimates leaves independent Platt paths through prime-weighted etaPlus energy, the base gap, pointwise minor estimates, Mobius/Liouville inputs, prime-power removal, and Mertens/totient large-sieve weights.
5. The far-asymptotic psi drafts beginning at exp(20000) do not cover the moderate psi/theta range. The Mertens window also has a direct finite-RH input independent of those pointwise replacements.
6. A large-sieve second moment alone does not control Eplus*Estar. Concentrated functions have bounded L2 norms and arbitrarily large mixed fourth moments. Exact imprimitive Gauss weights and induced-character corrections must remain in the mixed expression.
7. A coefficient bound proportional to log(x) is not a uniform all-x error cap. A bounded-x computation must have an overlapping tail argument. Raising the Goldbach threshold without extending the small-case proof creates an uncovered interval.

## 2. Exact public outcome and fixed definitions

The requested large outcome is

    TernaryGoldbach.TernaryGoldbachFrom (10^27)

without a Platt or BinaryGoldbachInput premise. Expanded, it means every natural N with Odd N and 10^27<=N admits natural primes p,q,r with p+q+r=N. The full outcome retains exactly the original BinaryGoldbachInput:

    (hBG : TernaryGoldbach.BinaryGoldbachInput) -> TernaryGoldbach.Statement.

Statement.lean:14-35 defines these predicates. Statement is forall N:Nat, Odd N -> 5<N -> exists three natural primes summing to N. Repetition of primes is permitted. BinaryGoldbachInput at line64 means every even natural m with 4<=m<=4*10^18 is a sum of two natural primes. Both binary bounds are inclusive. There is no requirement of distinct primes or a new witness restriction.

| Expanded large-root binder | Role |
| --- | --- |
| N : Nat | Typing |
| Odd N | Source premise |
| 10^27<=N | Source premise |

| Expanded full-root binder | Role |
| --- | --- |
| hBG, with the entire binary proposition above | Retained source premise |
| N : Nat | Typing |
| Odd N | Source premise |
| 5<N | Source premise |

There are no standing analytic assumptions. A QRH theorem must be proved/imported with audited dependencies and applied inside the proof. A class or structure containing missing residual inequalities would still be an excess root premise. The full root must not acquire a stronger binary range or a finite-RH verification assumption.

MainTheorems.lean:16,23 are the current explicit-hypothesis roots. Helfgott/Main.lean:68 consumes the major and minor bounds, the nonprime subtraction and the final inequality. Lines77-80 explicitly omit Platt for the small-case theorem. Statement.lean:39 joins inclusive UpTo and From ranges at the same C; the existing C is10^27. This overlap must be preserved.

The existing analytic geometry is fixed when reusing its consumers: kappa=49, r0=150000, xOf(N)=N/(2+9/(196*sqrt(2*pi))), etaPlus(t)=hH(200,t)*t*exp(-t^2/2), etaStar(t)=mellinConv(eta2,phi)(49*t), and majorArcs(8,r0,x). These are actual source definitions in Helfgott/Defs.lean:42,52,55,77,80. The proof has x>=4.9e26 for N>=10^27, and y=x/49>=1e25. A replacement smoothing is not the original theorem's analytic input until its change is propagated through every consumer.

For Qset(r0), qt(q)=q if q is even and2q otherwise; q runs over odd q<=150000 and even q<=300000. Set Dq=1200000/qt(q), delta=x*beta. Therefore d(beta)=d(delta)/x, while the normalized star sum uses y=x/49 and the star main Fourier term is evaluated at -delta/49. The total cubic normalization is x*y=x^2/49. Sign, Fourier normalization, and all these scale factors are requirements, not adjustable numerical conventions.

## 3. Independent Platt-consuming routes to the roots

This is a source-level branch map, not a claimed machine-verified transitive dependency graph. It records independent consuming estimates even when they share an upstream RH input. Importing a Platt-containing file is not itself proof dependence; conversely, a theorem with no visible Platt token can call a contaminated theorem.

| Route | Existing source chain and final consumer | Required replacement or preserved contract |
| --- | --- | --- |
| P1, etaPlus character residuals | MajorArcs/GRH.platt_odd/platt_even -> Prop942 -> Thm714 -> ArcChars -> MajorTotal.resid_plus/per_modulus -> major_total -> major_arcs_input | New actual etaPlus residual control on all required conductors/twists, or the corrected integrated replacement in section4. |
| P2, etaU/etaStar residuals | GRH -> Prop932/Cor933 -> Cor713 -> ArcCharsStar -> MajorTotal.resid_star, and MinorArcs/PartIICited.cor_7_1_3 -> BaseGap2 -> minor_total | The star major residual and the minor base-gap pointwise requirement are distinct consumers. An averaged major estimate does not replace the latter. |
| P3, major L2 energy | Thm714 -> MajorArcs/L2Major.l2_major_bounds -> major_total upper-energy input, and PartIICited.l2_major_14_7 -> MinorTotal.I0_ge | Lower8.6296*x and original upper8.79*x at x>=4.9e26. The new major route permits upper10*x; the lower8.6296*x remains needed to retain minor numerics. |
| P4, prime-weighted smoothing energy | Platt at q=1,height500 -> MajorArcs/Prop715.prop_9_5_1 -> prop_7_1_5 -> MinorTotal.T_le/sig -> Mexpr and numerics | sum Lambda(n)log(n)etaPlus(n/x)^2 <= [( .640208+366.91/sqrt(x))*log(x)-.021095]*x. The exact signed-error identity is stronger than this consumer needs. An unconditional2.8log(2x) sieve-energy bound is much coarser and cannot be silently substituted here. |
| P5, pointwise minor estimates | Explicit/ZetaZeroSums.rh_upto_1e8 -> PsiRanges1e8/PsiPlateau1e8/PsiRange1/PsiAsymp -> Prelim/PsiTwoSided/ThetaExplicit/LambdaMu -> GcdSums, TypeI/II and FirstChoice/SecondChoice -> PointwiseBound/GBound/EtaStarBound -> minor_total | Preserve the explicit Lambda contracts and resulting pointwise ghat envelope, or recompute all affected minor numerics. |
| P6, Mobius and Liouville | psi/theta estimates plus direct smoothed EOneBound RH use -> EOneNum/EOneRanges -> Schoenfeld finite cells and tails -> MoebiusSch/Profile/Bound and LiouvilleBound -> G2Tail/T2Bound and TypeI/II -> minor_total | The finite and tail Mobius bounds both need producers. A tail theorem alone does not replace finite induction premises. Preserve T2<=.37273 for S>=16 if reusing its consumers. |
| P7, prime-power and small-prime energy | LambdaMu.sum_vonMangoldt_lt and sum_vonMangoldt_nonprime_lt -> MinorArcs/EBound.E_partial/E_le_14_28 -> MinorTotal.norm_sq_sum_a2_le | The existing bounds1.03883*y and1.4262*sqrt(y), for every positive y, yield E<=8e-11*x. This is separate from the unconditional coarse nonprime subtraction at the very end. |
| P8, Mertens/totient large sieve | Direct RH in Prelim/MertensProduct.E1_win_num, plus pointwise theta/E1 edges -> E1/E2/product bounds -> div_totient_lt -> MinorArcs/LSQuot3/LSQuot6/LargeSieveProof -> Thm1321 repaired levels -> minor_total | For q>=1,r>=3,q<=r, q/phi(q)<exp(gamma)*loglog(r)+2.50637/loglog(r), together with all other quotient-weight premises. This is not discharged by the Mobius profile or by the principal quartet calculation. |

The primitive assumption source is Statement.PlattGRH. It asserts beta=1/2 in the strict nontrivial strip for primitive characters, odd q<=300000 up to1e8/q and even q<=400000 up to max(1e8/q,200+7.5e7/q). Explicit.rh_upto_1e8 specializes it to zeta. Some comparison bridges, such as IEANTNBridge, expose another form of the same finite-RH input; they are not an independent proof of it.

For original pointwise character consumers, Thm714.lean:572 has q=1, |delta|<=600000 and error(1e-18+6.24e6/sqrt(x))*x. Lines593 and631 have primitive odd q<=150000 with |delta|<=600000/q, or even q<=300000 with |delta|<=1200000/q, and error(7.5e-8+7.7e6/sqrt(x))*x/sqrt(q). Cor713 as exported at PartIICited.lean requires y>=1e25, primitive q<=300000, |delta|<=1200000/q, and error(1e-17+4.7e6/(sqrt(q)*sqrt(y)))*y. These are contracts for reuse, not claims that QRH already implies them.

The prime chapter must retain the exact boundaries of its moderate and tail interfaces. Currently open are psi_mid8 on[1e6,1e17] with its22-bin cW8*sqrt(x) envelope, psi_plateau8 from1e17 with4.91e-7*x+1145sqrt(x)+4.2e10, and theta_explicit from1e12 with its epl correction active only for120<log(n)<20000. Fixed-gap drafts target psi_range1_8 from exp(20000) with2.1e-14*x and psi_asymp8 from exp(35000) with.2*x/log(x)^3. They remain uncompiled. E1_win_num independently requires x>=1e12,Y>=x,log(Y/x)<=20001 and its1443/sqrt(x)+13/x+16/log(x)^3+8.4e-6 variation budget. See agents/prime-estimates/BLUEPRINT_PRIME_ESTIMATES.md for the complete22 bins and seven Lambda exports.

The Mobius worker's proposed weakened internal profile is .03 through the10^8 region and .10 thereafter. Its external rational replay gives a G2 tail below.0089, sufficient for the unchanged T2 bound since1.4423050431/4+9.2185538/10000+1.25*.0089=.372623116155<.37273. The original G2 bound.0082 cannot be retained merely by relabeling this result. The new profile itself is still an analytic obligation. Finite EOneRanges.psi_le_two has both a broad-psi contamination and a global prime-power contamination; fixing just one leaves the other.

## 4. Corrected primary positivity budget

The blueprint may deliberately weaken the internal major theorem from1.049 to1.0404 and reprove the final assembly. This does not weaken the public Goldbach conclusion. If the existing major_arcs_input is reused unchanged, however, the entire new dynamic loss must instead be at most .000270451. These two routes must never be conflated.

For the new primary route take J<=10, with normalized full residual energies A and Q=Astar+Cross. The integrated cubic loss is bounded by

    sqrt(B*A)+sqrt(2*J*Q),
    B=2*J+2*(.640208*13.59756)=37.41053338496.

The actual coprime residual definitions and Gauss weights are those in agents/major-constants/STRONGEST_AVERAGE.md. In particular Eplus and Estar sum |tau_q(psi)|^2/phi(q) times squared errors for psi^-1, normalized by x and y respectively. Preserve the exact zero Gauss weights for imprimitive characters; the mixed term includes nonsquarefree q and even primitive conductors. The Fourier weights in Aplus and Astar are |mu(q)U/phi(q)|^2 and |mu(q)P/phi(q)|^2.

The corrected sufficient **open analytic targets**, for every x>=4.9e26, are

    J<=10,
    coprime Aplus<=5e-7,
    coprime (Astar+Cross)<=9.5e-7.

The reviewed removal transfer, using a=1.01,bp=3.03e-23,bs=3.03e-17, integrated Eplus<=57 and Estar<=4.15e14, yields

    full A <5.050000000000330e-7,
    full Q <9.817952468e-7.

Do not round the first number down to5.05e-7. Independent exact Fraction arithmetic in agents/audit/check_blueprint_budget.py verifies B*A<.0043466^2 and20*Q<.0044313^2. Thus the loss is below.0087779<.008778. The source main term and fixed smoothing loss give

    1.052105346-.002834895-.008778=1.040492451>1.0404.

For the final nonprime subtraction, the proof already present in Helfgott/Numerics.final_inequality_crude gives a more precise extractable bound. With v=N^(1/64), it establishes v>=2.64, xOf(N)=N/c with c<=2.02, and numerator<=1.589e8*v^97. Consequently the normalized subtraction is at most

    1.589e8*4.0804*49/(2.64^31)
      =.002705832963159697... <.00271.

This implication was checked with exact rational arithmetic, including2.64^64<10^27. It still needs its own Lean theorem and revised assembly. Retaining minor<=1.0376 therefore leaves

    1.0404-1.0376-.00271=.00009>0.

The old cap families based on .011670451, including coprime Aplus9e-7,Q1.65e-6 for J10, are superseded for final positivity. Their algebraic transfer calculations were valid; their claim of sufficiency for the complete final theorem was not.

## 5. Principal certificate: what is established and what it does not supply

The recorded Arb run contains2750 unique ordered passing cells covering[16,75], with exact analytic outer-range reductions covering[0,16] and[75,infinity). The log header records python-flint0.9.0,128-bit precision, one thread and source SHA2563F511989A4E0F9F4D9206CEAF5C61CCDA80A30303C87484D6292B0CB42E57A67. Its maximum cell upper bound is83.571300905827202546..., below85. I independently checked all cell indices, pass flags, the record digest06d59f3d77455c573f3ce4d52cfe381c5dc4a3307b40cd946f003aa102795ed7, and the current checker hash. The JSONL file SHA256 isE81A9C76AF44EB09C8E4FA04F03E360C3BA5E0ED0250DAA7D8AA3F2DA58116F1.

This is finite interval evidence conditional on the reviewed paper reductions and ball-arithmetic correctness. It is not a Lean theorem. The remaining bridges include the actual etaPlus Fourier remainder, signed contours, Gauss error bounds, weighted zero-mass extraction, multiplicity-preserving quartet grouping and the explicit-formula Hilbert limit. XiMass's bound Re(logDeriv xiF 2)<=.07 has an independently replayed rational certificate but is also uncompiled. It is not the zero-mass identity by itself.

If these bridges and global7/8 QRH are proved, the principal route aims at integral_{-4}^4 |S_etaPlus(x,delta/x)/x-FetaPlus(-delta)|^2<=8e-6 for all x>=4.9e26, enough for the lowerJ>=8.6296 through principal extraction and coprime removal. Its domain cannot be silently enlarged to |delta|<=600000. The separate upperJ route currently asks for full-domain principal Ep<=1e-4 and nonprincipal energy<=1.23, which give J<9.994387. Both are still open. Neither follows from this local certificate.

## 6. Evidence gates for the blueprint

| Status | Evidence required | What it does not mean |
| --- | --- | --- |
| OPEN | Exact mathematical target, all ranges and constants stated, proposed producer identified | No proof supplied. |
| CONDITIONAL_DERIVATION | Checked implication with each unproved premise named | The conclusion has not been discharged. Do not export premises as a new root hypothesis. |
| EXPERIMENT | Reproducible floating calculation with method, grid and source hash | No continuous bound, no interval certification. |
| RATIONAL_REPLAY | Exact integer/Fraction comparisons, source/data hash and successful exit | No proof of analytic formulas or Lean elaboration. |
| INTERVAL_CERTIFICATE | Outward arithmetic, analytic error bounds, complete domain coverage, all cells passing, versions/source/data hashes | No Lean kernel proof unless an audited checker verifies imported certificates in Lean. |
| SOURCE_REVIEWED | Independent reading checks definitions, assumptions, signs, normalizations and dependencies | No compiled exact type or axiom closure. |
| LEAN_CHECKED_HELPER | Successful focused compilation, exact exported type, transitive axioms, matching source/artifact hashes | No downstream consumption and no root closure. |
| LEAN_CONSUMED | A compiled term applies the helper at the required source type and supplies every premise from audited producers | Other independent branches can remain open. |
| ROOT_COMPLETE | Exact two root outcomes, matching definitions, complete range coverage, term-level assembly and transitive axiom/type audit | Nothing less may be described as having proved ternary Goldbach in Lean. |

For final type review, count every explicit, implicit and instance binder, recursively expanding project-owned predicates and bundles. Platt, finite RH, unproved QRH, residual inequalities, prime estimates, generic envelope assumptions and unsupported numerical assertions are forbidden excess public inputs. The retained BinaryGoldbachInput must remain visible at the full root and absent at the large root. Checking axioms alone is insufficient: Fact PlattGRH is a theorem parameter, not necessarily an axiom.

For numerical certificates, record exact domains, inclusion of endpoints, discretization remainder, tail estimates, coefficient normalization, runtime/library version, source hash and complete output inventory. A few passing cells or a low sampled maximum cannot replace whole-domain evidence. For Lean validation, require successful process status, complete target-specific artifact inventory, matching source and dependency hashes, exact-type witness and axiom inspection. A zero-byte log or a stopped compiler is not validation; generic timestamp reuse is not evidence.

For every range split, give a closed/open endpoint table and prove union coverage. For every infinite zero sum, retain natural multiplicities and all conjugation/reflection degeneracies, state the limiting sets and justify convergence. For every imprimitive character, preserve conductor transport, Euler corrections and Gauss weight exactly once. No simple-zero or zero-spacing assumption is available.

## 7. Minimal research acceptance plan

First, adopt the corrected positivity ledger in every chapter and explicitly mark the old caps superseded. Second, finish the principal local bridges and preserve the distinction between local lowerJ and global upperJ. Third, obtain actual producers for the corrected Aplus and Astar+Cross bounds and the minor base-gap pointwise estimate. Fourth, close all moderate prime, Mobius/Liouville, EOne and Mertens/totient branches, recording any internal constants intentionally weakened and replaying their consumers. Fifth, assemble the unchanged minor bound or a fully recomputed alternative, the new major1.0404 bound, the explicit nonprime.00271 theorem, and the unchanged small-case theorem.

The principal certificate is useful progress, but it does not remove any of the independent prime, mixed-moment, or minor-arc requirements in section3. The blueprint is complete as a list of obligations only when each row has a concrete producer or an explicit OPEN status. It becomes a proof only after the final evidence gate.

## 8. Further bounded peer checks

The principal chapter's four-symmetry average is algebraically valid: if a finite set and its multiplicities are invariant under conjugation and rho->1-rho, each of the four reindexed sums equals the original. Averaging handles fixed points without integer division of multiplicities. The actual rectangle membership and analytic-order invariance are still needed. A common goodSeqD across delta permits Fatou after measurability and the pointwise explicit-formula limit are supplied.

The mixed chapter's newly derived formulas pass a bounded mathematical check: eta2=4 times the Mellin convolution of the indicator of[1/2,1] with itself; Mellin(etaU)(s)=4*((1-2^(-s))/s)^2*2^(s/2)*Gamma(1+s/2) for Re(s)>0; the real-twist Taylor remainder is bounded by (2*pi*|z|)^L/L! times this positive Mellin transform at Re(s)+L. The scaled star spatial factor is49*etaU(49v)*(49v)^(s-1), so its Fourier transform has twist delta/49. The Gauss-weighted Ramanujan kernel identity is valid for unit n,m. Extending it to arbitrary n,m requires the coprime indicators. These checks do not estimate the mixed-moment target.

The minor worker has proposed an optional simplification of P7: prove only the large-range bounds psi(t)<=1.4t and primepower(y)<=1.5sqrt(y), retain the actual starting scale, and rerun EBound's numerical inequality. Their resulting coefficient is below8e-11, so the global1.03883 and1.4262 bounds would no longer be needed for this one consumer. This is an unformalized alternative, not a reason to remove those bounds from other LambdaMu/TypeI/II consumers. See BLUEPRINT_MINOR_FINITE.md section9 for its exact scale conditions and pending proof.
