# Smaller finite-RH input for the original ternary proof

2026-11-11. Source-only refactor blueprint. No Lean declaration, approved anchor, build, finite spectral certificate, or numerical analytic evaluation was produced. This is a candidate route to the same final theorem, not an adoption of a new final hypothesis.

The economical candidate is to preserve the original analytic constants and replace the broad `Fact PlattGRH` dependency by a smaller finite-RH input at its actual consumers. The source supports this separation: the character calls need the active arc conductors, while the unbounded psi/E1/Mertens chain needs only conductor-one RH through `10^8`. It does **not** support constructing the old broad `PlattGRH` proposition from the smaller input.

Paths in the discussion are relative to `work/ternary-goldbach/TernaryGoldbach`. Exact inspected bytes and the two planning inputs are pinned below. The companion consumer-domain report supplies the wider principal downstream inventory; the decisive character bodies and final assembly were also read directly for this blueprint.

## 1. Exact temporary input, and the final theorem

Use a temporary, explicitly conditional finite-RH proposition with these rows. Names here describe proposed interfaces, not new Lean declarations.

| Primitive conductor c | Required closed height |
|---|---|
| odd, `1 <= c <= 150000` | `10^8/c` |
| `4 | c`, `4 <= c <= 125000` | `10^8/c` |
| `4 | c`, `125000 < c <= 300000` | `200 + 7.5*10^7/c` |

For every primitive complex Dirichlet character of each such conductor, every actual L-function zero with `0 < Re rho < 1` and `abs(Im rho) <= H(c)` must satisfy `Re rho = 1/2`. This includes both ordinate signs, the real axis, and the top height. It does not require simplicity. Actual multiplicities remain those of the source zero sums. Inverse/conjugate transport must concern the actual character and its L-function, not just a shared conductor label.

The even rows can equivalently use `max(10^8/c, 200+7.5*10^7/c)` throughout. Their crossover is exactly `c=125000`. Omitting conductors `c=2 mod 4` requires proving that there is no primitive character there. A practical interface may quantify over all even c up to 300000, while its certificate adapter proves these cases vacuous. The CRT unit isomorphism modulo `2m` and modulo odd m implies every character modulo `2m` is induced from m; the exact `IsPrimitive`/conductor API proof is a real outstanding obligation, not a metadata convention.

The c=1 row gives `RHBelow 1e8` by the existing `DirichletCharacter.LFunction_modOne_eq` and `isPrimitive_one_level_one` argument in `Explicit/ZetaZeroSums.lean:29-34`. Preserve this height. Neither the selected QRH height 60343058 nor an RH1500 head is a substitute in the original analysis.

The intended final roots remain:

- `TernaryGoldbachFrom (10^27)` with no mathematical input once this finite-RH proposition has been proved by a standard-axioms certificate;
- the actual `Statement`, namely every odd natural n greater than 5 is a sum of three primes, with only the original inclusive `BinaryGoldbachInput = BinaryGoldbachUpTo (4*10^18)` left as a hypothesis.

A theorem conditional on the new finite-RH proposition is an intermediate refactor milestone. It is not the final unconditional large theorem. This task makes no change to the binary input, the prime ladder, or the true `Statement` definition.

## 2. Separate analytic estimates from finite verification

The following local changes suffice at the direct character extraction sites; preserve every other argument and output constant.

| Existing helper | Proposed local input and exact change |
|---|---|
| `MajorArcs.cor_7_1_3'`, Cor713:807-833 | Keep arbitrary `q <= 300000`, primitive chi, `y >= 1e25`, and `abs delta <= 1200000/q`; add explicit `GRHUpTo chi (1e8/q)`. Replace only `platt_grh hq chi hchi` at827 by that argument. The generic numerical domain need not be reduced. |
| `thm_7_1_4_one`, Thm714:572-587 | Take explicit `GRHUpTo chi 1e8`; retain `x >= 4.9e26`, `abs delta <= 600000`, and original principal error. |
| `thm_7_1_4_odd`, Thm714:593-625 | Take explicit `GRHUpTo chi (1e8/q)` for odd q<=150000. Its q=1 branch passes the same bound to the localized principal helper. |
| `thm_7_1_4_even`, Thm714:631-686 | Take explicit `GRHUpTo chi (max (1e8/q) (200+7.5e7/q))`. Use monotonicity to the first height in the q<=125000 branch and the second height otherwise. Retain the existing small/middle/high error calculations. |
| `prop_7_1_5'`, Prop715:356-367 | Take `GRHUpTo (1 : DirichletCharacter Complex 1) 500`, supplied by monotonicity from the c=1 row. Its square-smoothing estimate has no other family-RH need. |
| `Explicit.rh_upto_1e8`, ZetaZeroSums:29-34 | Add a smaller-input-to-`RHBelow 1e8` adapter, using the same actual L-function identity. Principal-only estimates then take that RH proposition rather than broad family data. |

The generic explicit-formula producers `cor_9_3_3`, `prop_9_4_2`, and `prop_9_5_1` already accept their needed RH input. Retain their hypotheses, including `max(10*pi*abs delta,50) <= T0` for etaU and the extra 200 for etaPlus. Keep existing choices of T0: the domain reduction does not justify lowering those choices or reusing their constants at a new height.

Old public wrappers may remain as compatibility theorems under old `Fact PlattGRH`, calling these localized analytic lemmas. The new root must call the localized versions, never these old wrappers. In particular, do not redefine a smaller proposition under the old name and do not introduce an instance asserting the larger proposition.

## 3. One active-conductor adapter, used at all three callers

`qt(q)` is q for even q and 2q for odd q. Establish once: if `q>=1`, `qt(q)<=300000`, and positive c divides q, then even c<=300000 and odd c<=150000. For odd c and even q, `Coprime 2 c` gives `2*c | q`, hence `2*c <= q`. For odd q use `c<=q` and `2*q<=300000`. The existing proof in `ArcChars.lean:405-432` already contains this arithmetic.

Apply the adapter to `c = conductor (psi inverse)` and its primitive character. `conductor_dvd_level`, `conductor_ne_zero`, and `primitiveCharacter_isPrimitive` supply the actual carrier facts. Keep `conductor_inv` in the Gauss bound. At even c=2 mod4, the primitive impossibility adapter discharges the branch; do not silently identify it with a different modulus inside an L-function estimate.

Three uses are required:

1. `ArcChars.arc_chars` already retains the odd/even conductor bounds and corresponding twists at lines405-432. Replace its calls to Thm714 and its principal call at449 by explicit finite-RH arguments. Gauss norms, coprime-removal errors, and all character sums stay unchanged.
2. `ArcCharsStar.arc_chars_star`, lines139-228, has `qt(q)<=300000` but currently uses only c<=q<=300000 at the Cor713 call210. Recover the stronger parity bounds there and pass the smaller-input RH value, monotonically restricted to `1e8/c` if necessary. Its principal call226 uses c=1. Preserve `y=x/49`, actual twist `beta*y`, and its bound; do not divide that twist by 49 a second time.
3. `BaseGap2.norm_S_etaStar_le_gap`, lines243-309, needs the witness repair below before applying the same adapter. It then calls the localized `MinorArcs.cor_7_1_3` with the conductor-specific RH proof. This is the only extra geometry obligation exposed by the smaller input.

## 4. Retain the BaseGap2 witness before it is forgotten

`BaseGap2.gap_point`, lines185-227, currently exports only `1<=q` and `q<=2*r0`. Its proof already receives either odd q<=r0 or even q<=2*r0 from `majorArcs`. Add to the returned witness either `qt(q)<=2*r0` or the explicit disjunction

    (Odd q and q<=r0) or (Even q and q<=2*r0).

Retain the same q, a, coprimality, and both existing twist inequalities:

    4*r0/(49*q) <= abs((alpha-a/q)*(x/49)) < 8*r0/q.

In the odd branch, the proof already derives the stronger upper bound `4*r0/q` before weakening it. No sharper numerical estimate is needed; the added parity/size witness alone is sufficient. Existing clients needing the old result can project away the new field or use a compatibility wrapper.

After setting y=x/49 and passing to `d=conductor(psi inverse)`, the proof still has `d|q`, `d<=q`, `y>=1e25`, and `abs delta <= 1200000/d`. The added witness is used only to obtain reduced-domain RH for d. Keep the original lower twist endpoint, open upper endpoint, actual additive numerator modulo q, and coprime-removal comparison. No cutoff on x is introduced.

Without this repair, a helper quantified over arbitrary q<=300000 cannot justify odd conductors in (150000,300000]. Replacing `platt_grh` at that call by a reduced-domain accessor without carrying parity would be a genuine missing premise.

## 5. Propagate the smaller inputs, not the broad Fact

Two independent input streams should remain visible while rebuilding the live caller chain:

- **Active finite family:** localized ArcChars/ArcCharsStar -> `L2Major.Jq_bounds` (97-120) and `l2_major_bounds` (309), and the per-modulus/character comparison chain in MajorTotal -> `major_total` (974). `Qset r0` already supplies the needed qt bound. The PartIICited Cor713 wrapper must receive explicit conductor RH, its Prop715 wrapper needs only the principal bound, and its L2 wrapper needs the active family. BaseGap2 and MinorTotal receive the matching inputs.
- **Principal only:** `RHBelow 1e8` -> original psi/E1/Mertens/Moebius bounds -> Type I/II, large-sieve and off-arc inputs -> MinorTotal. These downstream arithmetic moduli and scales remain unbounded.

In particular re-thread direct `rh_upto_1e8` uses in `PsiRanges1e8` (all generated range proofs and dispatcher), `PsiPlateau1e8:138,171`, `PsiRange1:431`, `PsiAsymp:637`, `EOneBound:160`, and `MertensProduct:545`. Preserve the principal-only hypotheses throughout their actual downstream callers, including ThetaExplicit, EOne/Mertens and Moebius/Schoenfeld wrappers. A low-effort implementation can use a local `Fact (RHBelow 1e8)` for this branch, with explicit hRH at the analytic boundary; a single reduced-family Fact throughout the live branch is also logically sufficient but obscures the independence.

`MertensProduct.div_totient_lt:2258` is required for arbitrary q and comparison r. FirstChoiceTypeII, SecondTypeIIa/b, SecondBridge, GBound, LSQuot3 and BaseGap2 consume it with unbounded parameters. Keep that theorem's original domains. H2=3e10 and larger Gamma values in the psi proofs are analytic tail/zero-free parameters, not additional finite-RH verification heights. Conversely the original `PsiLarge` split has an H>=1e8 condition: this branch cannot use the smaller selected QRH principal height unchanged.

This is a refactor across a live transitive closure, not just the six direct extraction sites. A search found broad Fact section variables in many downstream files. Some are unused for particular declarations; source text alone does not determine the elaborated binder/dependency closure. Do not remove estimates or truncate unbounded inputs merely to avoid re-threading them. The companion report records the principal source inventory; the future implementation must resolve each actual live dependency.

## 6. Final assembly and the fail-closed verification gate

Rebuild `Helfgott.Inputs.major_arcs_input` and `minor_arcs_input` from localized `major_total` and `minor_total`. Preserve their original outputs `1.049*x^2/49` and `1.0376*x^2/49`, respectively. The existing `circle_identity_input` and `nonprime_input` do not need the spectral family; reuse them unchanged. In `Helfgott/Main.lean:31-74`, reconstruct `repSum_lower_bound` and `ternaryGoldbachFrom` using these two localized inputs and the unchanged `final_inequality_crude`. There is no reason to import the changed QRH major/minor constants into this route.

For the full result, reuse `SmallCases.ternaryGoldbachUpTo_1e27` and `statement_of_upTo_of_from`. This preserves the original inclusive binary input and the upper/lower overlap at `10^27`. Do not use existing `MainTheorems.ternary_goldbach_large_of_hypotheses` or `ternary_goldbach_of_hypotheses` as the new proof: both explicitly manufacture the broad Fact.

The eventual acceptance checks are substantive:

1. Source-audit the exact smaller proposition and each localized helper's carrier, closed height and unbounded parameter list. Prove the active-conductor and primitive-empty-row adapters.
2. Build the changed consumer chain under a compatible target toolchain, preserving frozen dependencies. This work is not authorized or performed by this note.
3. Inspect the elaborated new root type and dependency closure. No `PlattGRH` hypothesis/instance, global QRH provider, unproved finite-RH axiom, `sorryAx`, or native-decision shortcut may remain. Old wrappers may exist outside that closure. Token searches are only triage.
4. Separately prove the complete finite-RH certificate proposition with standard axioms, including character enumeration, both signs, closed-height completeness and actual zero multiplicities. A sign list alone is not completeness; ordinary sign saturation may also require stronger simplicity conditions than this input demands.
5. Close the temporary finite-RH input internally, then check the large root has no added mathematical premise, the full root has only the original binary hypothesis, and the axiom closure is only `propext`, `Classical.choice`, `Quot.sound`.

This plan neither proves nor assumes that a finite computation has succeeded. Compatible compilation, axiom validation, and all finite spectral data remain open.

## 7. Efficiency conclusion and recommended bounded order

First prove the active-conductor adapter and the parity-preserving gap witness; then localize Cor713/Thm714/Prop715; then re-thread principal-only estimates and the final consumers. These are falsifiable source-interface milestones before investing in a new spectral producer. They reuse the original analytic machinery and eliminate the need to formalize the global QRH provider for this candidate route.

The baseline comparison records 5,543,640,188 primitive-character labels in the retained family versus 18,068,152,606 in the declared original domain, and a reduced height-weighted metadata ratio near .532276. These are reused planning figures, not newly verified counts here and not proof-checking/runtime ratios. The selected QRH route still has lower heights and a weaker real-part target; this refactor alone does not establish which complete certificate is cheapest. In particular it gives no automatic MM0 speedup, no runtime bound, and no transfer of Lean source proofs into MM0. The benefit established here is a concrete way to avoid a broad finite input and the additional global QRH proof dependency while preserving the original final mathematics.

## Pins

The following source and planning-file hashes bind this blueprint. Hash verification is not kernel validation.

| File | SHA256 |
|---|---|
| `work/qrh-campaign/agents/independent-feasibility/ORIGINAL_RH_CONSUMER_DOMAIN_RESEARCH_2026-11-11.md` | `AC14194BAB999170E7444DD0EDAA0285A3758942681AB44E4E2047CF8A87D48C` |
| `work/qrh-blueprint/SPECTRAL_BASELINE_COST_COMPARISON_2026-11-11.md` | `0DD28598568EC61FC8B589017680AA9A3AE350608ADA32FD94D9869B9C06B9A5` |
| `work/ternary-goldbach/TernaryGoldbach/Statement.lean` | `3F61837D2C3A0DDE3A1997F05AF21C20C7FE6EE13E29891125495F6947596BF8` |
| `work/ternary-goldbach/TernaryGoldbach/MainTheorems.lean` | `4B2BDB187A2D9AC485239611EEE99D1C716C5BC0F57F1946DAA32CBD22FECFFF` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/GRH.lean` | `89C6DF8490955EEA8F4141498BCA6D163355C2E7765C9ECD09F8CEE5B257A070` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Cor713.lean` | `11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Thm714.lean` | `7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Prop715.lean` | `CD026A3D01FD8578484E43A48888885C2DC3BF696B2F7ACB89BB525E4E064DF0` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcChars.lean` | `0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcCharsStar.lean` | `B95DE4A83BAF37008B21FCFF90A0188AA230548C8776DE6C5F2905C19DA9DF10` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/L2Major.lean` | `8C9424D92074ABB35DF00273D598F5A3F95C49A34F07F4146DD83FD2B6F3A5FC` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/MajorTotal.lean` | `106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/PartIICited.lean` | `0447F5A3D00DBB6B11CEA1A729FA4CCA2FEF993A8242574D2241A33195B14D30` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap2.lean` | `AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/MinorTotal.lean` | `6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZetaZeroSums.lean` | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiRanges1e8.lean` | `26BDF0EEEAD4C7628B3205ECF1B52BB05A914E492A3721DCA6B784F6FE3C1120` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiPlateau1e8.lean` | `F5BEB066695D24085A74706C9FFE3219A2A053E2C1854FC3E209BD0CD78E392C` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiRange1.lean` | `F474C24F28ED3D14774A170F19EF312AE132124D727ABD438478C4AF89BBE026` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiAsymp.lean` | `2EEE8AAAC78360010044AB5964058ADB5998FB30EFAC3000352ED6D2114D047D` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiLarge.lean` | `D370555A164DA01E37E5BDB14EFA774DC79FE43682EED21D42C90BA2D1B165F2` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/EOneBound.lean` | `ADD1130F3FBBB4EA2AAFB7A7F769FBD565E14DB13B2F6500245E14023106DC65` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/MertensProduct.lean` | `8182DC2B990DC8D65AC76D3CC55847B26922E2062CD154C14367D5DB97F71A0F` |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/Defs.lean` | `4CE6EA7FB475024DF403775F9480D7D01B6336A798E0CF254BD61B5AFEC79DC7` |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/Inputs.lean` | `5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83` |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/Main.lean` | `DD5E20E51EC7C699CAC00A497C34FEF687E7E5B4562D3B1D8B981ECE54F4261D` |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean` | `61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359` |
