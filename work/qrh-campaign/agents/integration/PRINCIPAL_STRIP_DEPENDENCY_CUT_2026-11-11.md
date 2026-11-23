# Conditional cut of the extra principal strip

2026-11-11. Source/packet dependency review only, against ternary-goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No evaluator, Lean build, source change or frozen-packet edit. The proposed damped psi argument has not been accepted or assumed successful here.

**Finding:** in the current selected route, the additional principal strip through one million and the accurate weighted moment W35<=24 enter the root through the common psi envelope E. No independent major-arc, minor-energy or base-gap consumer needs them. P4 once had a separate narrow-strip route, but its accepted shared-strip reduction already removes that dependence. A successful replacement of the analytic E branch would therefore remove the additional narrow-strip certificate from the selected proof obligations, while leaving the shared c=1 height 60343058 and the other family conductors intact.

**Important qualification:** the live damped proposal is not merely “RH through 2000.” In the author's status message for this review, it retains RH through 1500, the quantitative head data Q1500<1.668 and N(1500)=1069, shared [.445,.555] through 60343058, global seven-eighths, analytic count and order-preserving symmetry. Thus its success would remove the global-through-one-million moment W35<=24, but not automatically the quantitative head inputs used to prove its new damped bound. No frozen damped proof/version exists to pin in this note. The analytic count majorant is unconditional in zero location and valid to infinity; using it to majorize a finite shared-range sum does not require extending the shared or narrow strip above60343058. The genuinely higher zeros still use global seven-eighths and their separately bounded tail.

## 1. Exact removable edge and replacement contract

The old analytic branch is `mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md`. It consumes the location bound .49<=beta<=.51 and

    W35 = sum_(actual zeros |gamma|<=10^6)
             multiplicity * exp(35*max(beta-1/2,0)) / |rho| <= 24.

The selected sufficient producer, `major-constants/PRINCIPAL_HIGH_STRIP_REFINEMENT_2026-11-11.md`, combines the low RH/count/moment packet with the additional closed strip [.4968,.5032] on 1500<|gamma|<=10^6 to give W35<23.980532761132 and the required .49/.51 location. Its zero carriers have both height signs, inclusive tops and actual orders. The additional strip is not the shared [.445,.555] strip.

That branch proves |psiR(x)-x|<.01*x/log(x) for 5e9<=x<=exp(35). The older `integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md` already proves the stronger .0081 coefficient for all x>=exp(35) using only shared [.445,.555], global seven-eighths and the translated mass/analytic ingredients. Hence the exact replacement needed for the cut is:

    for EVERY real x in [5e9, exp(35)],
       |psiR(x)-x| < .01*x/log(x),                           (D)

with both endpoints included and both upper/lower inequalities, from the retained shared/global/head inputs, without W35<=24 or the extra narrow strip. Proving the same statement for all real x>=5e9 is also sufficient. A sampled scalar check, an upper-only P4 bound, or a larger constant times x is not (D).

At natural N, `Prelim/ThetaExplicit.psiR_nat:42` and `psi_eq_Icc:126` connect `Explicit/PsiSandwich.psiR:82` to `Prelim/LambdaMu.psiN:53`. Combine (D), the existing exp(35) tail and the finite [1e9,5e9] certificate route to get

    E: every natural N>=10^9 satisfies
          |psiN(N)-N| <= .01*N/log(N).

The 6,439 finite windows have complete independently recounted external evidence, not Lean count proofs; their count/log/theta and finite nonprime bridges remain required. (D) does not remove them. It also does not require adopting the older unproduced long finite interval to exp(35).

For real t>=1e9, N=floor(t) gives a lower-side loss below 1. The existing assembly absorbs this in .001*t/log(t) and proves |psiR(t)-t|<=.011*t/log(t). Retain this real envelope; an integer result does not silently become the real .01 bound. `PsiLarge.psi_upper_of_err:296` and `psi_lower_of_err:326` are the source sandwich endpoints for (D). `PsiExplicit.SsumG_gsm_errH:120` still assumes RHBelow H and cannot be reused by deleting that premise.

## 2. Every E consumer in the selected source repair

The dependency is a repair map: the new E/W35 propositions are not declarations in the pinned Lean source. The actual source still has Platt-dependent producers, so a textual search alone does not prove the cut. I checked their exported names/call sites and the selected replacement packets. Text occurrences `chunkW35`/`stW35` in finite weight tables are unrelated to the spectral W35.

| E consumer | Actual source boundary and use | What survives after replacing the producer of E |
|---|---|---|
| P1 | `LambdaMu.sum_vonMangoldt_lt:337`, psi(y)<1.03883y for y>0; `TypeI2Large:44`, `TypeI2Proof:753` | Existing small finite bound plus E/real coarse envelope, unchanged coefficient |
| P4 | `LambdaMu.sum_vonMangoldt_le_a14:1375`, psi(y)<=1.0064y for y>=2.5e7; `TypeI2Large:71,331`, `TypeI2Sum:389` | Either E route or the already accepted shared-strip-only route; no extra narrow strip needed |
| P5 | `LambdaMu.sum_vonMangoldt_mul_lt_a17:1362`, sum n Lambda(n)<1.022y^2/2 for y>=2.5e7; `TypeI2Large:322`, `TypeI2Sum:380` | E/finite coarse two-sided psi bound and exact Abel identity |
| P7 | `LambdaMu.sum_log_sq_primes_le:1884`, dyadic prime log-square moment for y>=2e6; `TypeIITotal:37` | E, .011 real transport, finite sieve, P6 and endpoint-correct Abel identity |
| Relaxed Mobius profile | `SchoenfeldJ.rho_le:34`, `J_le:251` and `SchoenfeldTail` weighted rho pieces; `RESUME_MOBIUS_INPUT` replaces their error majorant | Same integer E, P2, finite tables, 214-cell replay and changed infinite-tail proof; profile .03 below100000001 and .10 thereafter |
| M1/M2 downstream | `LiouvilleBound.term_big_le:241` calls `abs_m_le_014` at247; `MinorArcs/T2Bound.T2_le':23` consumes G2 tail | The repaired profile implies the needed .14/log bound; G2 allowance .0089 still fits .37273. No separate W35 input |

`work/qrh-blueprint/PRIME_ENVELOPE_ASSEMBLY.md` explicitly derives P1/P4/P5/P7 from E with their existing constants. P2, P3 and P6 have separate elementary paper replacements and do not gain a narrow-strip dependency. The changed Mobius induction/tail is already independently reviewed as an implication from E; proving (D) changes its input producer, not its cells or constants.

These producers feed the first/second-choice Type I/II bounds, the off-larger-arcs estimate, and the q=1/2/3 high-twist base-gap pieces. This is an **indirect E dependence**, not a second independent narrow-strip requirement. It remains necessary to implement all those downstream producer repairs.

## 3. The P4 exception is already resolved separately

The earlier `prime-estimates/PRIME_CONSUMER_SOURCE_JOIN` replaces W35<24 by W35<436 but still uses the extra narrow strip. That is a historical alternative, not an unavoidable separate root consumer.

The later accepted `audit/P4_SHARED_STRIP_REDUCTION` derives W35<381 using the shared .555 strip, the unconditional count majorant, sharp xi mass .07 and unconditional height floor. Its endpoint calculation works on [.445,.555], giving |psiR(x)-x|/x<.005501<.0064 on [5e9,exp(35)]. It needs neither the additional narrow strip nor Q1500/N1500 as quantitative data. The unchanged finite branches and exp(35) tail finish P4. Its independent review explicitly checks those removals.

Thus there is no surviving P4 obstacle to cutting the additional strip if (D) succeeds. Conversely this P4 bound alone is not E and cannot discharge Mobius/P5/P7 by relabeling its constant.

## 4. Independent root branches that are not cut

| Selected branch | Actual requirements independent of the extra narrow strip |
|---|---|
| Major Ep, Aplus/Astar, Cross, full J and cubic major lower bound | Shared Hcert(c)=min(Hp_old(c),1e8/c), including c=1 through60343058; global seven-eighths; true multiplicities, actual smoothing, finite Gram/count/tail bounds and mixed transfer. The q=1 local lower-J estimate comes from Ep, not W35. |
| Actual-square minor energy | Global seven-eighths and sharp positive xi mass .07, actual squared-smoothing kernels172/566; no finite RH head or narrow strip |
| Finite base-gap branch | Shared .555 at the supported conductor-specific Hbase<=Hcert, global tail and etaU bound13/8; exact absolute Gauss weights and both removals. The high-twist branch uses repaired Type I/II as above. |
| Totient, regionS and residual EBound repairs | Their own elementary/finite-tail arguments; no new narrow-strip dependency introduced by removing it from E |
| Small Goldbach cases | Original inclusive BinaryGoldbachInput through4e18; no spectral input |

The first three are checked against `RESUME_COMMON_HEIGHT_MAJOR`, `MINOR_ENERGY_QRH`, the latest `BASE_GAP_ACTUAL_SOURCE_JOIN`, and `CURRENT_CONSUMER_OBLIGATION_FRONTIER`, not inferred merely from absence of a keyword. “Shared c=1 certificate” cannot be dropped: .555 through60343058 is a different assertion from the additional .5032 boundary through10^6. Other primitive conductors remain unchanged too.

## 5. What may stop being a selected obligation, and what remains reusable

If (D) is proved and independently accepted under the stated restricted inputs, the selected proof no longer needs:

* certification of [.4968,.5032] on 2000<|gamma|<=10^6 (or the earlier1500-based version plus its certified head);
* the `PRINCIPAL_HIGH_STRIP_REFINEMENT` implication as a mandatory producer of W35<=24;
* the W35<=24 and separate .49/.51 premises of `RESUME_PSI_LOW_ZERO_REFINEMENT`;
* completion of the long .5032 principal rectangle, its high endpoint slab and all intermediate panels **for that extra strip**.

This is a dependency cut, not deletion or invalidation of frozen research. `PRINCIPAL_LONG_OUTER_RECTANGLE`, high-slab and node-to-contour plans remain valid optional routes. Generic actual-xi/theta, finite-EM, modular, rational arithmetic and contour machinery may still be needed for the shared .555 principal boundary, family certificates or formal checker work. The parameter .5032 in a fixed evaluator pilot is a domain coordinate, not a spectral premise of its evaluator theorem. Do not abandon reusable implementation obligations merely because one target rectangle becomes unnecessary.

The exact total count N(10^6)=1747146 was not itself sufficient for or required as a separate input to the selected high-strip weighted bound. Its completed external top-horizontal packet remains evidence, but the cut need not consume it. In contrast the current damped attempt explicitly retains Q1500<1.668 and N(1500)=1069, with the required head location. The stronger externally reviewed RH/simplicity-through2000 packet can provide that head location but qualitative RH alone does not supply the quantitative moment. Those head proofs and actual-order transfers must remain until a frozen replacement demonstrably avoids them.

## 6. Acceptance gate and fixed roots

Before adopting the cut, require a frozen producer and independent review that establish: (i) (D) over the full real continuum with both signs/endpoints; (ii) actual source psiR and its normalized Gaussian formula; (iii) complete retained head inputs with true multiplicities; (iv) shared finite/global split with no hidden .49/.51 or .5032 step; (v) damping, tail, vertical, denominator and desmoothing errors; and (vi) the exact finite/asymptotic joins. If only a different threshold succeeds, expose the remaining finite interval rather than claiming the old [1e9,5e9] data cover it. New numerical experiments or a scalar upper bound at one x do not satisfy this gate.

No final theorem is weakened. `Statement.lean:14,22,34,64` still defines the same prime sums, full Statement, large TernaryGoldbachFrom, and inclusive BinaryGoldbachInput. The replacement of `Helfgott/Main.lean:68` must prove TernaryGoldbachFrom(10^27) with **no mathematical premise**; the full root retains only the original BinaryGoldbachInput. Source Platt instances must be removed by proofs, not replaced by E, a head certificate, global QRH or a checker-acceptance assumption. This note authorizes no source implementation or runtime.

## 7. Checked packet pins

Paths below are relative to `work/qrh-campaign/agents/`, except the explicitly named blueprint file. These frozen versions remain unchanged; the live damped proposal is an unpinned research dependency, not an accepted input.

| Packet | SHA256 |
|---|---|
| mellin/CURRENT_CONSUMER_OBLIGATION_FRONTIER_2026-11-11.md | 517D24E49F9F2DD8AA4E339C6EEF440070937FD94D2C9EB5ADE366A89604FF5B |
| mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md | 33C01406E927F8F49F329AB52B967AA14B85B64DF7928A034C3028EFEEB91F61 |
| major-constants/PRINCIPAL_HIGH_STRIP_REFINEMENT_2026-11-11.md | B5BA5316102AB6AA303B30929B3E10020526F6A17C2D8D560C24B4AC65C6C47D |
| audit/P4_SHARED_STRIP_REDUCTION_2026-11-11.md | EE2E6A7752136F751D64890A0E2BD4CD613790529B1A4D5BC24483F2A3B5B585 |
| independent-feasibility/REVIEW_P4_SHARED_STRIP_REDUCTION_2026-11-11.md | F83BAA8FEE82D47D51555D8AAF355DBDEEDCD43306D168689C5151746A6227B4 |
| work/qrh-blueprint/PRIME_ENVELOPE_ASSEMBLY.md | B54EA110CCDAB0ADD5F3FE4D10189A38F04AD89E93426725F05C2EE80D63EDDE |
| integration/RESUME_MOBIUS_INPUT_2026-11-11.md | 2F292201BDB9E2E2E65CDB37733235A9B1107DC42DBF7233CA8D9E3761F64E52 |
| mellin/RESUME_MOBIUS_REVIEW_2026-11-11.md | 3CE3C8AA345512AAB170C1C8C64B98E210D665898F6F384239EBF76B9AD1123C |
| integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md | D4A026F5B7190F0AA577A70A88E7BFCB79740F9CA549EE9B7AC0EF0C782B3826 |
| integration/BASE_GAP_ACTUAL_SOURCE_JOIN_2026-11-11.md | F0BC1D7899044C27E819743BBA4B157D51F42848B87A51D37764CDB8B3B6C9E0 |
| major-constants/RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md | 79833F8D5D5856E000A96D3F5CCA9FC9E26CB3BAF637CDE089FEFDD703436BA7 |
| mellin/MINOR_ENERGY_QRH.md | A0C414E8FAEAB6C8A4768B2179635F5B42F69D118EA17EBB062AA7FD7857C0A6 |
| mellin/PSI_HEAD_COUNTS_CERTIFICATE_2026-11-11.md | ED9250BD7A7DE3395543FBC06DD88FFC9227AF352D690CAA70F621C20A5F975B |

Independent review of this dependency cut is requested. Success of the proposed new envelope has deliberately not been claimed.
