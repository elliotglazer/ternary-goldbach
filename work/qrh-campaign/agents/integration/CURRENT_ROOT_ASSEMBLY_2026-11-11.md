# Current root assembly after the damped principal amendment

2026-11-11. Source and paper audit only. No Lean declaration, build, source change, evaluator run, or approved dependency graph is produced. The conclusions below describe a proof construction from the reviewed intermediate arguments, whose actual spectral certificates and formal proofs are still required. They are not additional permitted hypotheses of the final theorems.

All Lean locators below refer to `work/ternary-goldbach/TernaryGoldbach` at commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Packet paths refer to `work/qrh-campaign/agents` unless otherwise stated. The old selected-closure/frontier notes are historical inventories, not current evidence of unresolved or completed work.

## 1. Exact roots and the final numerical reserve

`Statement.lean:22,26,30,34,39,64` fixes the mathematical target. The large theorem is `TernaryGoldbachFrom (10^27)`, meaning every natural odd N with `10^27 <= N` is a sum of three natural primes. It must have **no mathematical premise**. The full `Statement` asserts the same for natural odd N with `5 < N`; it retains only the original `BinaryGoldbachInput`, namely binary Goldbach for every natural even n with `4 <= n <= 4*10^18`, including the upper endpoint. Neither global QRH nor a finite zero statement is a new final assumption.

Current `MainTheorems.lean:16,23` exposes Platt as a hypothesis. Current `Helfgott/Main.lean:5` supplies it as a section instance. The proposed proof must remove that dependence by replacing the consumed arguments, not by installing another unproved instance. `Helfgott/Main.lean:79` already omits Platt for the binary-based small-case bridge. `Statement.statement_of_upTo_of_from` then joins the two inclusive ranges.

Put `x = xOf N = N/(2+9/(196*sqrt(2*pi)))`, `kappa=49`, and `y=x/49`. `Helfgott/Inputs.xOf_ge:57` gives `x>=4.9e26`, hence `y>=1e25`. The major variable is x; the etaU variable in the star sum is y. These are not N or interchangeable scales.

The reviewed replacements give

* major real integral `>=1.0404*x^2/49`;
* minor norm integral `<=1.0376*x^2/49`;
* nonprime contribution `<.00271*x^2/49`.

`Inputs.circle_identity_input:37` and the real-part/norm argument in `Main.repSum_lower_bound:30` therefore give `repSum True N >=.0028*x^2/49`. Subtracting the nonprime bound yields

`repSum (fun n => n.Prime and Odd n) N > .00009*x^2/49 > 0`.

The reserve is **`.00009*x^2/49`**, not `.00009*x^2` and not a coefficient of N squared. The unchanged finite-sum extraction at `Main.isSumOfThreePrimes_of_repSum_ne_zero:56` concludes the prime representation. It explicitly omits Platt and only requires the predicate to imply primality. The old `repSum_lower_bound` coefficient `1.049-1.0376` and old `final_inequality_crude` cannot be called unchanged.

There is no new analytic lemma needed for the sharper nonprime subtraction. `Inputs.nonprime_input:126` is already unconditional and gives `6.7e6*N*sqrt(N)*log(N)`. In the proof of `Numerics.final_inequality_crude:71`, set `v=N^(1/64)`: `v>=2.64`, `sqrt(N)=v^32`, `log N<=64*v/2.7`, and the denominator of x has square at most4.0804. Its existing algebra bounds the nonprime term by `158900000*v^97`. Dividing by `x^2/49` leaves at most

`158900000*4.0804*49/(2.64^31) < .00271`.

This is the exact integer comparison `158900000*10201*49*40*25^31 < 271*66^31`, already checked in the reviewed major-final scalar packet. The strict reserve survives at N=10^27.

## 2. The two direct Platt branches at the root

`Inputs.major_arcs_input:76` and `minor_arcs_input:109` are the only direct Platt-dependent inputs in this root assembly. The circle identity, nonprime bound, prime extraction and small-case bridge are separate unconditional or binary-conditional source arguments. A section-level instance alone is not evidence that every declaration in the file consumes it.

### Major branch and the lower J estimate reused by minor arcs

Use `major-constants/MAJOR_FINAL_CONSUMPTION_JOIN_2026-11-11.md` and its independent audit. At the actual major-arc change of variables, `d alpha=d delta/x`; the two plus sums and one star sum have scale `x^2*y`, so their integrated scale is `x*y=x^2/49`. The exact `N/x` identity in `Inputs:76-91` supplies the original main-term argument.

The reviewed weighted residual bounds retain actual supported Gauss factors, inverse-character orientation, principal terms, both coprimality removals and norm control of the mixed remainder `<.000160001`. The resulting dynamic error is `<.008778`; the fixed main-term loss is `.002834895`; the main lower bound is `1.052105346`. Hence the actual major result is `>1.040492451*x^2/49`, which supplies1.0404. This replaces the final use of `MajorTotal.major_total:974`, preserving the source main-comparison and Cmain normalization.

Minor arcs also consume a lower bound for J. The latest proof uses the weighted principal error **over all q**, `Ep < (.00020001)^2`, together with `sqrt(Mlow)>2.94`, to obtain `J>8.6296*x`. It does not infer this from a q=1 estimate alone or from the weaker `Ep<=1e-4`. Its upper bound is `J<10*x`. The star-removal estimate is obtained independently from the low-star integral `<10000` and `dstar*sqrt(W)<2e-6`, giving `<10001`; it does not depend circularly on a minor-arc star bound.

The actual smoothing, finite-carrier zero transfer and sharp vertical estimates remain part of this proof: `ACTUAL_SMOOTHING_CONTINUITY_JOIN`, `ZERO_SUM_SOURCE_JOIN`, and the reviewed sharp vertical packet. Their paper identities must be attached to the source functions. Qualitative admissibility alone does not prove the quantitative900/106000 estimates.

### Every direct minor branch

The following rows cover the uses in `MinorArcs/MinorTotal.lean`, including the separate quotient large-sieve path.

| Actual consumer | Current replacement and exact obligation |
|---|---|
| `norm_sq_sum_a2_le:138`, via `EBound` | Retain the bound `8e-11*x`; use repaired P1/P6 and the reviewed EBound relaxation. Do not import current conditional psi bounds under a removed instance. |
| `T_le:216`, via `PartIICited.prop_7_1_5` | Use the actual mass/energy proof `T<(.64621*log x-.021095)*x`, then `sigma_dagger=.65*log x-.021095`. It proves summability and uses genuine analytic orders. It need not reproduce the old signed prop7.1.5 identity. |
| `I0_ge:277`, via `PartIICited.l2_major_14_7` | Use the major proof's `J>8.6296*x` and the unchanged a2 bound. The source square split with parameter1e-5 gives `I0>=8.6294*x`. |
| `hv0:394-403`, at radius150000 in x-arcs | Split off-y arcs from the base gap. Use the latest actual-source gap join directly at `y*ghatY(y,150000)`, rather than claiming the old `.0121*y` statement. |
| `hvn:404`, all higher levels in y-arcs | Use the repaired first/second-choice pointwise estimates, all ten producer inputs below, and both remote totient envelopes. |
| `thm_13_2_1_repaired:410` | `Thm1321:153` keeps prime support, summability, mixed x/y arcs, antitone/nonnegative weights and all level hypotheses. Its conditional large-sieve call descends through `LargeSieveProof.cor_12_2_5` to `LSQuot6.prop_12_2_4:69`; replace the `regionS` call at line90 separately. |
| Numerical end of `minor_total:323-544` | Rebuild `sig`, Mexpr and numerical auxiliary bounds with sigma_dagger and the enlarged ghat. Existing `NumericsFinal.numerics_M:12` is not literally a proof of these new definitions. Preserve its nine finite cells and asymptotic witness and all five size/radius/log hypotheses. |

For the layer step, `NumericsGoal` at `MinorTotal:84` requires `r0<r2`, `(20000*r2)^2<=x/784`, `2*r2<=(2*sqrt(x/784))^.6`, `r2<=y^(1/3)/6`, `2.16e20*r2<=670*y`, and `cL(r2-1)<=Dx`. These are not dropped when reusing the numerical partition. The quotient large-sieve itself requires the first two size inequalities, `r0>=1e5`, prime support and the exact mixed family of arcs.

## 3. Totient and energy changes compose, with both tails

The selected totient repair does not prove unrestricted `Prelim.MertensProduct.div_totient_lt:2258`. It proves the original estimate for q<=2^1000 with comparison radius unrestricted subject to the original hypotheses, and repairs larger-denominator consumers. The first-choice bound uses `q/phi(q)<=2*q^(1/4)`. The fresh second-choice denominator is `q'<=T^2/349`, so its finite/remote split is at `T=2^500`; it must not be confused with the original denominator.

The reviewed all-scale convolution gives

`ghat_dagger(y,r)=ghatY(y,r)+1.398*(H1(r)+H2(r))`,

where

`H1(r)=132*log(2*max(r,2^1000))^2/(2*max(r,2^1000))^(1/4)`,

`H2(r)=12000*log(max(r,2^500))^2/max(r,2^500)^(1/4)`.

Both are nonnegative and antitone, and r times each is increasing. Thus the enlarged level function meets the source hypotheses. The first-branch and second-branch envelopes combine by `max(g+H1,h+H2)<=max(g,h)+H1+H2`. The complete layer additions, including the terminal level, are respectively `<1e-60` and `<1e-24`, hence `<2e-24`. Retaining H2 alone is not the literal reviewed proof.

An elementary adapter avoids a possible monotonicity mistake. Mexpr's initial coefficient is `cL(r0)*sigma/Dx-8.6294`, which need not be assumed positive. For a nonnegative increment e(r), expand the difference exactly. Its initial term is at most `e(r0)*cL(r0)*sigma/Dx` by discarding the negative `-8.6294*e(r0)`. Middle weights are nonnegative; the terminal weight is nonnegative by `cL(r2-1)<=Dx`. Apply the reviewed full tail estimates to these three terms. One cannot simply assert that Mexpr is monotone in every ghat value.

`MINOR_ENERGY_TOLERANCE` proves the numerical layer bound1.037 with sigma_dagger, keeping the negative offset. Its finite-cell maximum is below1.030545; its asymptotic proof has the required margin. The combined remote correction fits the conservative bound1.037001. The unchanged a2 split with t=.0005 then gives

`1.0005*1.037001 + 2001*22.75*8e-11 = 1.03752314232 <1.0376`.

The separate `LSQuot3.regionS:75,121` uses a prime-product totient estimate and a theta bound, neither supplied by H1/H2. `work/qrh-blueprint/REGION_S_ELEMENTARY.md`, with the resume/repair audits, repairs precisely the large-q small-R branch consumed at `LSQuot6:90`, preserving the quotient constants. Its elementary and finite-Mertens argument is sufficient for that branch; it is not a proof of every generic c'-parameter version of regionS.

## 4. Prime and Mobius producer boundary after the amendment

The current selected amendment is `work/qrh-blueprint/SELECTED_PRINCIPAL_ROUTE_2026-11-11.md`. Common E is the two-sided integer inequality `|psiN(v)-v|<=.01*v/log(v)` for every integer v>=1e9. It follows from the completed external finite-grid data on `[1e9,5e9]`, the reviewed damped real bound `<.0096*x/log x` on `[5e9,exp35]`, and the earlier real bound `<.0081*x/log x` above exp35. Both junctions are covered. The finite grid is now fully independently recounted:6439 windows, not a missing85,721-window long-gap project. Its count/log/formal acceptance still needs implementation. The finite nonprime repair below1e12 is sufficient here and avoids a circular dependency on global P6.

The damped branch retains critical-line head data through1500, exact `N1500=1069`, `Q1500<1.668`, and the corresponding positive head bound3571/1500. It uses the shared closed principal strip `[.445,.555]` through60343058 and the genuine global7/8 provider with symmetry and actual orders. The unconditional count bound used to majorize the finite shared range does not require the shared strip beyond60343058. The additional narrow strip through1e6 and W35<24 are removed. Existing stronger head evidence may supply these facts, but its stronger statement is not a new requirement.

For legacy real-variable consumers retain the proved safe `.011*t/log t` floor transport. The new real `.01` bound above5e9 does not justify changing a wrapper on the whole real range starting1e9 without proof. P4 has its separately reviewed shared-strip shortcut, so its old narrow-strip status paragraph is obsolete.

| Input with original exported threshold/coefficient | Actual main uses | Current proof route |
|---|---|---|
| P1 `LambdaMu.sum_vonMangoldt_lt:337`, y>0,1.03883y | `TypeI2Proof:753`, `TypeI2Large:44`, `EBound:218` | Finite tables and E. |
| P2 `sum_vonMangoldt_div_le_log:535`, x>=1 | `GcdSums:155`, `TypeI2Proof:258,752`, `TypeI2Large:82` | Reviewed elementary P2, independent of E/P6/QRH. |
| P3 `log_sub_le_sum_vonMangoldt_div:1170`, x>=1, subtraction log(3/sqrt2) | `TypeI2Large:87` | Reviewed floor-kernel/factorial proof plus finite MertWalk. |
| P4 `sum_vonMangoldt_le_a14:1375`, y>=2.5e7,1.0064y | `TypeI2Large:71,331`, `TypeI2Sum:389` | Reviewed P4 shared-strip reduction and finite floor wrapper. E could also supply the old route. |
| P5 `sum_vonMangoldt_mul_lt_a17:1362`, y>=2.5e7,1.022y^2/2 | `TypeI2Large:322`, `TypeI2Sum:380` | E, real transport, Abel endpoints; unchanged threshold. |
| P6 `sum_vonMangoldt_nonprime_lt:761`, y>0,1.4262 sqrt(y) | `TypeIIReduction:388`, `EBound:220,247` | Reviewed unconditional finite/large-y prime-power repair. This is distinct from root `nonprime_input`. |
| P7 `sum_log_sq_primes_le:1884`, y>=2e6 | `TypeIITotal:37`, hence generic TypeII | E, finite theta/P6 and exact Abel endpoint terms. |
| M1 `LiouvilleBound.abs_sum_moebius_div_coprime_le_log:680`, q>=1,q<x, coefficient2.8 | `TypeITotal:44` | Relaxed Mobius profile implies old .14 bound, retains .99 Liouville and2.8 coprime constants. |
| M2 `MinorArcs.T2Bound.T2_le':23`, S>=16,.37273 | `TypeIIS1:345,348,400` | New G2 tail integral<.0089, not old.0082; `1.4423050431/4+9.2185538/10000+1.25*.0089=.372623116155<.37273`. |
| R1 sharp totient consumers | `FirstChoiceTypeII:153`, `SecondTypeIIa:172`, `SecondTypeIIb:216`, `SecondBridge:58`, `GBound:89` | The finite/remote construction in section3, not an unrestricted sharp theorem. |

The Mobius profile is `.03` on `11815<=x<100000001` and `.10` thereafter, in `|sum mu(n)/n|*log x`. The reviewed modified Schoenfeld J estimator,214 cells and infinite tail all remain necessary. E bounds the nonnegative weighted absolute rho sum and its boundary value; an upper-only psi bound cannot replace it. P2 supplies the weaker but sufficient infinite-tail kernel estimate. Current `chkCell`, `rho_le`, `bTerm_le`, and old stronger profile theorems are not automatically unconditional. No old .09 or .0082 estimate is silently retained.

## 5. Base gap, finite-zero support and exact heights

Use `BASE_GAP_ACTUAL_SOURCE_JOIN` and its audit. Write m for the original reduced rational denominator, `q=m/gcd(m,2)`, `d=(alpha-a/m)*y`, `Delta=2*d`, and `u=2*q*abs(d)`. The gap has `q<=150000` and `1200000/49<=u<1200000`. Preserve the parity adapter and original m in the character expansion; no extra49 belongs in the Mellin argument.

For each supported primitive conductor c dividing m, the finite-prefix height is at most the old Hp(c) and strictly below1e8/c, hence at most their minimum Hcert(c). Inclusive height is preserved under induction and reflection: induction fixes the zero, reflection negates its ordinate and preserves its absolute value. Gauss support is essential; do not demand the same finite assertion for every character at an ambient modulus regardless of its coefficient.

The actual etaU smoothing/Mellin proof gives the low-strip13/8 bound and high-zero/vertical estimates with true off-line multiplicities. For q>=4 the pointwise result is `<.044797*y`, below the reviewed ghat floor `.04712*y`. For q=1,2,3 the finite prefixes end at u=486477,972954,1068377; the separately reviewed high branches start at190000,300000,300000. These overlap, and high branches retain the TypeI/II obligations in section4. Enlarging ghat to ghat_dagger only weakens the required gap bound. The finite-zero carrier stabilization and radial clipping in `ZERO_SUM_SOURCE_JOIN` justify the actual residual envelope without equating its clipped part to an infinite zero sum.

The shared family height is exactly `Hcert(c)=min(Hp_old(c),1e8/c)`, not the ceiling of that minimum. The active family consists of primitive nonprincipal characters at odd c<=150000 or c divisible by4 with c<=300000, plus the principal zeta component. Its zeros must satisfy the closed .555 upper strip assertion through that exact height; reflection supplies the lower side where used. At c=1 the height is60343058. Finite location, multiplicity, principal pole treatment and functional-equation transfers remain proof obligations, not root assumptions.

## 6. Remaining work and audit conclusion

No further independent mathematical input was exposed at the inspected root/consumer boundary. The paper composition has a positive reserve with unchanged large/full root statements. This finding is not a certification of all transitive Lean proofs or a declaration that the finite family exists in checked form.

The unresolved work remains concrete:

1. Validate the genuine global7/8 consumed export and its source-faithful pole/order/symmetry adapters on the target toolchain. The accepted minimal consumed-export plan reduces the interface, not the imported closure or build obligations. Final expanded types and transitive axioms must meet the fixed standard-axiom policy `propext`, `Classical.choice`, `Quot.sound` only.
2. Produce and formally accept the full shared finite family and actual head certificates. No extra narrow1e6 certificate is needed in this selected route. External head/count/prime data and bounded evaluator pilots are not Lean acceptance or complete family coverage.
3. Formalize actual smoothing, quantitative vertical bounds, zero-carrier/order transport, damped psi and all limiting/desmoothing steps. Then formalize E-to-prime/Mobius adapters and exact finite replays.
4. Formalize the energy/J/base-gap, both totient tails and the separate regionS replacement. Rebuild the modified numerical layer theorem with every source domain condition, rather than rewriting old final theorem statements alone.
5. Reassemble the unchanged circle and finite-sum proof with1.0404,1.0376,.00271 at scale x^2/49. Check the final large theorem has no mathematical premise and the full theorem only the original inclusive BinaryGoldbachInput. The binary assertion itself is not proved here.

The elementary additions established here are the explicit normalized nonprime comparison and the signed initial-term adapter for the enlarged layer function. Their ingredients were already reviewed; making them explicit prevents a normalization or monotonicity shortcut in the final implementation.

## 7. Version binding

The following tables bind the source and principal paper inputs read for this audit. They are inventory hashes, not proof certificates. Each paper's scope and its independent review remain distinct from a compiled theorem.

| Source relative to TernaryGoldbach | SHA256 |
|---|---|
| `Statement.lean` | `3F61837D2C3A0DDE3A1997F05AF21C20C7FE6EE13E29891125495F6947596BF8` |
| `MainTheorems.lean` | `4B2BDB187A2D9AC485239611EEE99D1C716C5BC0F57F1946DAA32CBD22FECFFF` |
| `Helfgott/Main.lean` | `DD5E20E51EC7C699CAC00A497C34FEF687E7E5B4562D3B1D8B981ECE54F4261D` |
| `Helfgott/Inputs.lean` | `5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83` |
| `Helfgott/Numerics.lean` | `059874D201ECC571583118A56BA6193D6D8B49016C227988CBC83FA0F34648DB` |
| `MinorArcs/MinorTotal.lean` | `6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742` |
| `MinorArcs/NumericsFinal.lean` | `27DB90B71D4B3ACBF7F3BB84374733A4E9601170A770C83E8006CCB2465B95A4` |
| `MinorArcs/PointwiseBound.lean` | `E4B743A18A31B313E9B732A5598282BCD0ECB5D2BF178AEEB0E6344B024C6307` |
| `MinorArcs/Thm1321.lean` | `46E2E0919EEC0310EFCA401EFA7DD7FD9C7690E1337BB5996A6597DDDA342F2A` |
| `MinorArcs/LSQuot3.lean` | `4E1105C3A734EF94CBFFA81AF2128D0525092F95F0E4E6F8B8ED8E0B983542BD` |
| `MinorArcs/LSQuot6.lean` | `DC67FC28217D1212FD67A920C6AC62003F13EAC9F0FB26200EDA426CD43CB2AE` |
| `Prelim/LambdaMu.lean` | `45A40A3209665061FF2F4F28F7CDDD1C012BCEE66FA90E555859A22D38D8568E` |
| `MinorArcs/T2Bound.lean` | `CE29C61DFD09904320F9853ABDCF3915C3A68D6784452C1ADEEF4165A10B26C3` |

| Packet relative to agents | SHA256 |
|---|---|
| `major-constants/MAJOR_FINAL_CONSUMPTION_JOIN_2026-11-11.md` | `280FDC53E61066E050DD98D4A004A9435510CC67686A59354750E0F7DE188F64` |
| `audit/REVIEW_MAJOR_FINAL_CONSUMPTION_JOIN_2026-11-11.md` | `B341209783E4FABCBCDD6390F16717DE91DC686ED457567AE22556B3748E80A1` |
| `prime-estimates/MINOR_ENERGY_MASS_SOURCE_JOIN_2026-11-11.md` | `44B1F9CAE1397818A4F1B7152F4BB9040BB6BAE6D969ED091161A2A27CDE9DF5` |
| `independent-feasibility/REVIEW_MINOR_ENERGY_MASS_SOURCE_JOIN_2026-11-11.md` | `2449AE2C0303D76DF7B2E1B129C6BE282E609EF8FE9A959043DF9F297A4F8948` |
| `major-constants/MINOR_ENERGY_TOLERANCE.md` | `EFD427246B3416F3F9F79E0AE4DD4370F5EBB038BC38D59E1B2AC1A33BADBEC1` |
| `audit/MINOR_REPLACEMENT_AUDIT.md` | `056E4229B2F62A630A81143244AC75A6D3E052F03C577CF369D3D045D76118FE` |
| `integration/BASE_GAP_ACTUAL_SOURCE_JOIN_2026-11-11.md` | `F0BC1D7899044C27E819743BBA4B157D51F42848B87A51D37764CDB8B3B6C9E0` |
| `audit/REVIEW_BASE_GAP_ACTUAL_SOURCE_JOIN_2026-11-11.md` | `0344BEB11D9006FC28BE76EE8ED2CD63AC3050B8E3217697F9C7FCD161351DAE` |
| `zero-sum/ZERO_SUM_SOURCE_JOIN_2026-11-11.md` | `600F627B397F7A8E83AE20578D8BA7A7C5EBEC536578EA5EC41D1E3AAC25ABDA` |
| `moebius/REVIEW_ZERO_SUM_SOURCE_JOIN_2026-11-11.md` | `ABD7473796D65689D1F4D4C58988B1D252BFA534425E36F99DEE50E1D59711F6` |
| `major-constants/ACTUAL_SMOOTHING_CONTINUITY_JOIN_2026-11-11.md` | `DDE8BB9C5782A91006A47E608F653A82E3BA195397D245C1304B485888F2F55D` |
| `zero-sum/SHARP_VERTICAL_SOURCE_JOIN_2026-11-11.md` | `FBB5FC9E71CB2199F36331D7BB8AFE1E565A3D8C01F95E0CECF69A9D775D0AA4` |
| `independent-feasibility/SECOND_CHOICE_WEAK_TOTIENT.md` | `FF5A0A1402C721D57EBB06193D925F0B9FB2D619975D40AC0F3A211F15F70AF4` |
| `zero-sum/SECOND_CHOICE_WEAK_REVIEW.md` | `476636A9263A85DC3D50AB80A1B0EE0C406CBE8FC45EF50F2619F82341FC928C` |
| `integration/GLOBAL_TOTIENT_FINITE_REVIEW.md` | `2303FCD1B4E0D8B3E2D9F68FD2A039488DE7F863B5D72B0D750D2160114B86BC` |
| `zero-sum/GLOBAL_TOTIENT_TAIL_REVIEW.md` | `67FE82F449103C8B75857BC494C5BB2C35987DF82ABCBAD66E6F740A5FB7712D` |
| `audit/RESUME_AUDIT_2026-11-11.md` | `04FB937C2801FCED9B271DBE2232E956009017E1CF65BFE00ED8B2AC373287AE` |
| `audit/RESUME_REPAIRS_REVIEW_2026-11-11.md` | `B3BD17411CDDB770B6934BCF39CCA3EF864435CFF543AB6EDDBC27CF61C3DD8E` |
| `prime-estimates/PSI_DAMPED_SHARED_STRIP_2026-11-11.md` | `8764E3EFDC940A4F302A761CFD2DE51778A91A5BF30F059F39CD0911F00CF5D0` |
| `independent-feasibility/REVIEW_PSI_DAMPED_SHARED_STRIP_2026-11-11.md` | `7D1315865B59B1CA84A8AB0676FF698121B665F54E2F84F81FFEA0A1B6FC7537` |
| `audit/RESUME_PSI_FULL_RECOUNT_REVIEW_2026-11-11.md` | `F18029529E22892D2225C96DC36058BFC1DDB2D22E19082A0292A320DAE97FF1` |
| `audit/P4_SHARED_STRIP_REDUCTION_2026-11-11.md` | `EE2E6A7752136F751D64890A0E2BD4CD613790529B1A4D5BC24483F2A3B5B585` |
| `independent-feasibility/REVIEW_P4_SHARED_STRIP_REDUCTION_2026-11-11.md` | `F83BAA8FEE82D47D51555D8AAF355DBDEEDCD43306D168689C5151746A6227B4` |
| `integration/RESUME_MOBIUS_INPUT_2026-11-11.md` | `2F292201BDB9E2E2E65CDB37733235A9B1107DC42DBF7233CA8D9E3761F64E52` |
| `mellin/RESUME_MOBIUS_REVIEW_2026-11-11.md` | `3CE3C8AA345512AAB170C1C8C64B98E210D665898F6F384239EBF76B9AD1123C` |
| `integration/GLOBAL_PROVIDER_NEXT_PROOF_OBLIGATIONS_2026-11-11.md` | `50F5DDF5EC71575D8DDF4F90DDBEB3AB995FEE1E1BE02F015A397BCF139D6732` |
| `prime-estimates/REVIEW_GLOBAL_PROVIDER_NEXT_PROOF_OBLIGATIONS_2026-11-11.md` | `703ECD9D543382A4658B82DADD077380D09CDC8B181F6B87C68AD0ED6398DF65` |
| workspace `work/qrh-blueprint/SELECTED_PRINCIPAL_ROUTE_2026-11-11.md` | `F5276E1C93B959BFC4D86A58BEFAA4666E320454CDC9B2CC2804EEEBE354FEBB` |
| workspace `work/qrh-blueprint/REGION_S_ELEMENTARY.md` | `E538FAFFD6AD7551C514A5F7A5528EE7326C6153CA501981B1A88D0FA57BAE40` |
