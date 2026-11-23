# Finite RH actually consumed by the original analysis

2026-11-11. Bounded source research for the compute-first comparison. No Lean build, theorem edit, numerical analytic evaluation, prime search or spectral scan was performed. This is a sufficient-domain reconstruction for a future refactoring of the existing proof, not a compiled replacement for its `Fact PlattGRH` interface or a proof of finite RH.

The original estimates can be retained with the following finite critical-line input:

| Primitive conductor c | Required inclusive height |
|---|---:|
| odd, 1 <= c <= 150000 | 100000000/c |
| 4 divides c, 4 <= c <= 125000 | 100000000/c |
| 4 divides c, 125000 < c <= 300000 | 200+75000000/c |

Every actual nontrivial zero of every primitive character in this family must have real part 1/2 when its absolute imaginary part is at most the listed height. In particular the principal conductor-one requirement remains RH through 100000000. The two even formulas agree at c=125000; together they equal `max(100000000/c,200+75000000/c)`.

The genuine reduction is to omit odd conductors above 150000 and even conductors above 300000 from the declared Platt input. Conductors congruent to 2 modulo 4 have no primitive characters. This reconstruction does not establish that any listed height is mathematically minimal. It preserves the existing chosen T0 and numerical estimates. Smaller heights would require another estimate audit.

## What the unchanged public interface requires

`Statement.lean:55-63` declares odd c<=300000 and even c<=400000, with the same respective height functions. `MainTheorems.lean:16-27` still accepts that complete proposition. A certificate for the table above cannot be plugged into that theorem by pretending it proves the larger proposition.

There are three distinct scopes:

1. The unchanged public theorem requires all of its declared `PlattGRH` hypothesis.
2. Merely specializing the broad character lemmas would still leave `cor_7_1_3'` quantified over every c<=300000, hence odd conductors up to 300000.
3. Re-threading finite RH at the actual major-arc and base-gap consumers permits the table above, with all original error estimates unchanged. The only extra geometric work is retaining the parity information that `gap_point` currently forgets.

No such refactoring has been implemented here. A future unconditional proof may reproduce the downstream argument under the smaller finite proposition, rather than prove the larger unused public hypothesis.

## Complete direct-access inventory and height choices

Source searches for the actual accessors and their uses locate two direct extractions of the Platt proposition: `MajorArcs/GRH.lean:43-47` and `Explicit/ZetaZeroSums.lean:29-33`. The former exposes primitive-character RH; the latter specializes directly to the conductor-one character. No other direct numerical RH extraction was found in the target source. This is textual/source evidence, not a compiler-generated transitive dependency certificate.

`GRHUpTo` at `MajorArcs/GRH.lean:32-38` and `RHBelow` at `Explicit/ZetaZeroSums.lean:23-25` both use 0<Re(rho)<1 and the closed condition |Im(rho)|<=T. Neither means a sampled list of zeros. The `platt_grh` accessor at GRH:62 gives height 1e8/c for every c<=300000, using the even maximum's left term when necessary.

| Actual direct consumer | Chosen finite input | Downstream role |
|---|---|---|
| `Thm714.lean:572-587`, `thm_7_1_4_one` | conductor 1, T0=1e8 | etaPlus principal major sum, x>=4.9e26, |delta|<=600000 |
| `Thm714.lean:593-616`, `thm_7_1_4_odd` | odd c<=150000, T0=1e8/c | etaPlus primitive sums, |delta|<=600000/c |
| `Thm714.lean:631-649`, even lower branch | even c<=125000, T0=1e8/c | etaPlus primitive sums, |delta|<=1200000/c |
| `Thm714.lean:661-671`, even upper branch | 125000<c<=300000, T0=200+7.5e7/c | same etaPlus estimate |
| `Cor713.lean:807-827`, `cor_7_1_3'` | c<=300000, T0=1e8/c | etaU primitive sums, y>=1e25, |delta|<=1.2e6/c |
| `Prop715.lean:356-367`, `prop_7_1_5'` | conductor 1, T0=500 | actual etaPlus-square prime energy |
| `ZetaZeroSums.lean:29-33`, `rh_upto_1e8` | conductor 1, H=1e8 | principal explicit-formula, psi, theta, E1 and Mertens estimates |

The uniform etaPlus lower requirement is `200+max(10*pi*|delta|,50)<=T0`; the etaU requirement is `max(10*pi*|delta|,50)<=T0`. They are admissibility inequalities, not a license to reduce T0 while reusing the final error constants. The source also bounds the T0-dependent remainder and low-zero contribution at the stated T0. The high even branch is genuinely used; at c=300000 its T0 is 450, larger than 1e8/c=1000/3.

## Actual conductor support, including the base gap

`Helfgott/Defs.lean:61-69` defines the major arcs using odd q<=r0 and even q<=2*r0, with r0=150000 at line79. `MinorArcs/LargeSieveWeights.lean:26` encodes the same condition as qt(q)<=300000, where qt(q)=2q for odd q and q otherwise. These are moduli of rational arcs. The conductor c of an inducing primitive character is a divisor of q, not a second independent index.

For every such divisor c:

- If c is even, c<=q<=300000.
- If c is odd and q is odd, c<=q<=150000.
- If c is odd and q is even, gcd(2,c)=1 and both 2 and c divide q. Thus 2c divides q, and c<=q/2<=150000.

`MajorArcs/ArcChars.lean:383-432` already performs exactly this argument. It sets c to the conductor of the inverse character, proves c|q, calls the even theorem for c<=300000, and proves `2*c<=qt(q)` before calling the odd theorem. The inverse character does not enlarge the family or conductor bound.

`MajorArcs/ArcCharsStar.lean:139-210` has the same qt(q)<=300000 input, induction from primitive characters and c|q. It calls the broad `cor_7_1_3'` after only recording c<=300000. The omitted odd-divisor argument above applies unchanged. The principal star term at line226 uses c=1. Here y=x/49 and the actual primitive twist is beta*y. There is no additional division of that twist by 49 when passing it to etaU. The source's conservative |beta*y|<=1200000/qt(q) is already enough.

The only other call chain to `cor_7_1_3'` is `MinorArcs/PartIICited.lean:45-50` -> `MinorArcs/BaseGap2.lean:306`. This deserves a separate check because the public helper has forgotten parity:

- `gap_point`, BaseGap2:185-228, exposes only 1<=q<=2*r0 and a twist range.
- Its actual construction at lines191-217 splits membership in the two unions defining `majorArcs`. The odd branch retains q<=r0 in its local `hqr`; the even branch has q<=2*r0. The witness it chooses is exactly that modulus, without a transformation that changes parity.
- `norm_S_etaStar_le_gap`, BaseGap2:243-306, takes this witness and the primitive conductor d of an arbitrary inverse character modulo q. It establishes d|q and applies Cor713.
- A strengthened local witness carrying qt(q)<=300000 therefore gives odd d<=150000 by the same divisor proof. The lower/upper delta bounds, periodicity argument, noncoprime terms, Fourier estimate and final .0121*y bound need no change.

Using only the *statement* of the current `gap_point` would not justify this last restriction: it admits an odd q between150001 and300000. The reduction is justified by its source construction and requires retaining that invariant in the future proof. This is not an inference from a Gauss-weight aggregate to a pointwise bound. Every character used by the pointwise base-gap argument remains covered.

Finally, if c=2m with m odd, the reduction map on units `(Z/2m Z)^* -> (Z/m Z)^*` is an isomorphism by CRT, since `(Z/2 Z)^*` is trivial. Every character modulo2m is consequently induced from m<c and cannot be primitive. This removes the v2(c)=1 rows, including c=2. The report uses this elementary argument; it does not claim a specific Lean declaration implementing it has been found or checked. Keeping those rows in the proposition with an `IsPrimitive` premise is harmless and vacuous until that adapter is formalized.

## Principal psi, global auxiliary estimates and prime gaps

The conductor-one input is not just the short height500 energy input. The following uses explicitly preserve H=1e8:

- `Explicit/PsiRanges1e8.lean:19-1177` gives the22 half-decade psi bounds on [1e6,1e17]. Each upper/lower invocation of `psi_range_upH` / `psi_range_loH` fixes H=1e8; the dispatcher is at1187 onward.
- `Explicit/PsiPlateau1e8.lean:138,171` uses `tsum_gsm_leH` at1e8 in the upper and lower sandwich.
- `Explicit/PsiRange1.lean:431` fixes H=1e8, H2=3e10 and Gamma=6.43e15.
- `Explicit/PsiAsymp.lean:631-647` fixes H=1e8 and H2=3e10 for all x>=exp35000.
- `Prelim/ThetaExplicit.lean:387,512,568,662,674,691` consumes those psi bounds.
- `Prelim/EOneBound.lean:155-170` uses `rh_upto_1e8` in the smoothed E1 estimate for variable smoothing parameters and unbounded Y.
- `Prelim/MertensProduct.lean:531-546` uses H=1e8 in its local E1 window. Its later global product/totient bound, including `div_totient_lt` at2258, inherits this conductor-one input.

H2 and Gamma in these formulas are NOT additional RH verification heights. They split regions bounded by analytic zero-free/counting estimates. `Explicit/PsiLarge.lean:121,205,360,373` places RH only up to H. In particular its original zero-free-region split requires H>=1e8. Replacing this by the selected QRH principal height60343058 would change the argument.

This distinction also removes a possible false conductor requirement. The all-q totient estimate is used in `MinorArcs/FirstChoiceTypeII.lean:153`, `SecondTypeIIa.lean:172`, `SecondTypeIIb.lean:216`, `SecondBridge.lean:58`, `GBound.lean:89`, `LSQuot3.lean:121`, and `BaseGap2.lean:343`. Their q and scale parameters can grow without bound. They do not demand RH for those q: their finite-RH dependency is the principal E1/psi input inside MertensProduct. No global QRH replacement or changed weak-totient envelope is used in this report.

`Explicit/IEANTNBridge.lean:22-32` also derives the one-sided zero-free form through1894438.5122 from RHBelow1e8. A name/import search found its export only in the umbrella `TernaryGoldbach.lean:593`, with no invocation in the target proof. Even if retained, that height is contained in the principal requirement. It is not evidence that the target uses an additional prime-gap certificate.

The actual small-case prime-gap mechanism is `Helfgott/SmallCases.lean:21-42`: binary Goldbach to4e18 plus `Ladder.ladder_prime` gives p in[n-4e18,n-4]. That theorem has only `Fact BinaryGoldbachInput`; it has no `Fact PlattGRH` parameter. `Helfgott/Inputs.lean:126-155` also uses elementary nonprime bounds without Platt. Therefore this target's ladder/prime-gap coverage adds no finite-RH conductor or height. This statement is about the local target, not every historical prime-gap method.

## Safe certificate contract and implementation boundary

A sufficient certificate must imply all-zero critical-line membership on the table's closed domains. A list of some line zeros, strict sign changes without a complete count, or samples of a nonvanishing boundary does not do so. One can certify line zeros and a matching complete zero count by argument principle/Turing, with multiplicities and boundary ordinates treated consistently. The present source input itself asks only the location of every zero, not simplicity. Its downstream zero sums use the actual analytic multiplicities.

For complex characters, conjugation exchanges the character with its conjugate and changes the sign of the ordinate. A producer may share that work, but one positive-height list for one complex character cannot be substituted for both signs of that same character without the conjugate-character/completeness argument. No new factor-of-two cost saving is claimed here.

The following work remains before the smaller domain is usable in a formal proof:

1. State and prove the finite certificate contract, without a new axiom, for precisely these primitive characters and closed heights.
2. Re-thread specialized Cor713/Thm714 and conductor-one consumers under it, retaining the stronger parity witness in the base gap. Broad unused APIs may keep the old hypothesis; they must not become accidental prerequisites of the new root.
3. Formalize primitive v2(c)=1 exclusion if the concrete certificate omits those vacuous labels.
4. Compile the resulting root and inspect its actual dependency/axiom closure. Current source searches do not replace this check, especially for inherited `Fact` parameters, generated psi files, or indirect instances.

All scales x,y and smoothing parameters remain quantified as in the original estimates. The finite heights do not grow with N. The source's unbounded principal auxiliary estimates explain why arbitrary arithmetic moduli do not imply an unbounded family-RH input.

## Comparison with the current QRH route

The selected QRH profile is recorded in `work/qrh-blueprint/SELECTED_HIGH_CONDUCTOR_PROFILE_2026-11-11.md`. After this original-analysis reduction, both routes have the same possible primitive-conductor support: odd c<=150000 and 4|c<=300000. The existing finite arithmetic inventory records150000 conductor indices and5543640188 primitive-character labels, including c=1. This report reuses that inventory and has not re-enumerated it.

The differences are heights, permitted real parts, and analytic proof dependencies:

| Feature | Original analysis after this restriction | Selected QRH analysis |
|---|---|---|
| Low conductors | exact RH to heights in the first table | beta<=.555 to min(ceil(200+max(1000,844800000/(7*qt(c)))),1e8/c) |
| Odd c>100000 | exact RH to1e8/c | beta<=.56 to5e7/c |
| 4|c>100000 | exact RH to max(1e8/c,200+7.5e7/c) | beta<=.56 to9.9e7/c |
| Principal c=1 | RH through1e8 | shared strip through60343058 plus retained RH1500/count/reciprocal-moment inputs |
| Global spectral input | original unconditional tail/zero-free estimates | proved global7/8 bound in addition to the finite certificates |

All selected QRH heights are no larger, and some are strictly smaller. Thus the QRH profile contains no more zeros merely by height and support. This is not a timing comparison: line-zero verification with a complete count and off-line strip exclusion are different certificate/evaluation problems, and the QRH route adds a large analytic formalization dependency.

Relative to the *declared* Platt proposition, the odd potential-conductor indices fall from150000 to75000, and the divisible-by-four indices fall from100000 to75000. The combined nonvacuous index range falls from250000 to150000. This40% reduction counts conductor positions, not primitive characters, zeros, arithmetic operations, bytes, or runtime. The omitted high-conductor rows tend to have more character labels, but no uncomputed percentage is assigned to that effect.

For compute-first planning, the appropriate baseline A is therefore the first table after an explicit localized-hypothesis refactoring, rather than the entire published/declared Platt range. Benchmark or symbolic costing should compare A and QRH on their actual shared character family and their different height/verification methods. The next cheap falsifiable test is a source-only interface design showing the refined base-gap witness and all specialized callers close under the reduced proposition; the next numerical task would require separate authorization and a standard-axioms certificate design.

## Source and comparator pins

Paths below are relative to this workspace. SHA256 pins bind the source version inspected; they do not certify elaboration or all imported proofs.

| File | SHA256 |
|---|---|
| `work/ternary-goldbach/TernaryGoldbach/Statement.lean` | `3F61837D2C3A0DDE3A1997F05AF21C20C7FE6EE13E29891125495F6947596BF8` |
| `work/ternary-goldbach/TernaryGoldbach/MainTheorems.lean` | `4B2BDB187A2D9AC485239611EEE99D1C716C5BC0F57F1946DAA32CBD22FECFFF` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/GRH.lean` | `89C6DF8490955EEA8F4141498BCA6D163355C2E7765C9ECD09F8CEE5B257A070` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Thm714.lean` | `7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Cor713.lean` | `11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Prop715.lean` | `CD026A3D01FD8578484E43A48888885C2DC3BF696B2F7ACB89BB525E4E064DF0` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcChars.lean` | `0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcCharsStar.lean` | `B95DE4A83BAF37008B21FCFF90A0188AA230548C8776DE6C5F2905C19DA9DF10` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap2.lean` | `AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/PartIICited.lean` | `0447F5A3D00DBB6B11CEA1A729FA4CCA2FEF993A8242574D2241A33195B14D30` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/LargeSieveWeights.lean` | `4577368FF4AD237E00D04259B813AFE2755ED165766070711CA33FB75E6F2304` |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/Defs.lean` | `4CE6EA7FB475024DF403775F9480D7D01B6336A798E0CF254BD61B5AFEC79DC7` |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/Inputs.lean` | `5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83` |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean` | `61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZetaZeroSums.lean` | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiRanges1e8.lean` | `26BDF0EEEAD4C7628B3205ECF1B52BB05A914E492A3721DCA6B784F6FE3C1120` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiPlateau1e8.lean` | `F5BEB066695D24085A74706C9FFE3219A2A053E2C1854FC3E209BD0CD78E392C` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiRange1.lean` | `F474C24F28ED3D14774A170F19EF312AE132124D727ABD438478C4AF89BBE026` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiAsymp.lean` | `2EEE8AAAC78360010044AB5964058ADB5998FB30EFAC3000352ED6D2114D047D` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiLarge.lean` | `D370555A164DA01E37E5BDB14EFA774DC79FE43682EED21D42C90BA2D1B165F2` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/IEANTNBridge.lean` | `54E839497E66C7444A7B03BA5C62096E7C526BF2999EF5888CC5BB17481D72FE` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/ThetaExplicit.lean` | `F30571CFFF146129180D9A1865BAE879027CB5E1F9BCC4B3C8D1912983A45F93` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/EOneBound.lean` | `ADD1130F3FBBB4EA2AAFB7A7F769FBD565E14DB13B2F6500245E14023106DC65` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/MertensProduct.lean` | `8182DC2B990DC8D65AC76D3CC55847B26922E2062CD154C14367D5DB97F71A0F` |
| `work/qrh-blueprint/SELECTED_HIGH_CONDUCTOR_PROFILE_2026-11-11.md` | `D0F77CCCFCE45DBFE5C863643236107ECBBE4D363103A70BB06CE57213A42CB7` |
| `work/qrh-blueprint/SELECTED_PRINCIPAL_ROUTE_2026-11-11.md` | `F5276E1C93B959BFC4D86A58BEFAA4666E320454CDC9B2CC2804EEEBE354FEBB` |
| `work/qrh-campaign/agents/prime-estimates/SELECTED_PROFILE_PRODUCTION_FRONTIER_2026-11-11.md` | `E633476F456ECF58135F944EC07AEDC50AB6B20058148AD1A018FD1AD69D2A46` |
