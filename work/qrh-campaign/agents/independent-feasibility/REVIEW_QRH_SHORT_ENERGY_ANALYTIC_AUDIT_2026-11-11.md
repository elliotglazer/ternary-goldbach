# Independent review of the actual short-energy saving

Verdict: PASS for the bounded source/mathematical argument, with one descriptive correction recorded below. No change to a source estimate or to the cstar/256 saving is required. This is not a global QRH-provider or compiled-proof verdict.

Reviewed author report: `../major-constants/QRH_SHORT_ENERGY_ANALYTIC_AUDIT_2026-11-11.md`, SHA256 `F45A59471E8A762710AF1F25CD74576E87C9061E4AE592A9B8682ABC6FCF1420`. The complete report was read. All 60 source hashes in its manifest were independently recomputed and matched. The author report remains unchanged.

## Scope and independent reconstruction

This review concerns the actual short term consumed by `Descent/CanonicalShortFinite.lean:14`, through `Inversion/ReflectedShortNormalizedUniformDegree.lean:13`. It checks the normalization, actual ideal and element sums, uniform quantifiers, scalar saving, retained-tail accounting and the attachment to the canonical rank argument. It does not validate the whole QRH provider, all imported analytic foundations, elaboration, or compiled axiom closure. No Lean or numerical evaluator was run.

All source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL`. The independently read current research checkpoint identifies short energy, two-pass energy, global tails and the common Fourier/radial foundations as open audit boundaries. This review advances the bounded short-energy argument; it does not close the other boundaries by association.

## The quantity being bounded

`Arithmetic/IdealMobius.lean:442–472` defines the actual cube weight, column weight and completed double sum. For a nonzero ideal H, the cube weight is the cubed angular/character factor divided by Norm(H). Under the supplied character norm bound its modulus is at most 1/Norm(H). The zero ideal has weight zero. The column summand contains the actual squarefree Gauss coefficient, the character, the factor 1/sqrt(Norm I), and the window `Vstar W y = sqrt(y)*W(y)`.

`Descent/Completion.lean:15` multiplies each such summand by the mark at I*J^3. Compact support and positive X give the finite-support/summability facts used for reordering. This is not a freely chosen model energy.

`Descent/ReopenedBins.lean:61` defines the short sum by the outer ideal H with strict Norm(H)<H0, coefficient mu(H)*cubeWeight(H), inner scale X/Norm(H)^3 and mark A↦mark(H^3*A). `Descent/ShortCompletionEnergy.lean:12` rewrites this to the finite short-cube range. The zero ideal contributes zero; a cube at the cutoff is excluded. `Descent/ShortReflectedEnergy.lean:15–37` supplies the actual tuple divisibility mark, its completed-sum identity, and the scale identity

    hhat = log_Z Norm(H),
    Z^N / Norm(H)^3 = Z^(N-3*hhat).

An effective exponent N-3*hhat need not be nonnegative. The inner analytic scale remains positive, and the later arithmetic cap bounds its inverse. No extra nonnegativity assumption on this exponent is introduced.

The row character is `rowTwist Ψ m f k`, with the source's m^6*f^4*k dependence. Passing from an arbitrary generator of a nonzero label ideal to the selected generator changes the row by a fourth power of a unit. `Inversion/ShortCanonicalNormalization.lean:58–78` records this transfer. The finite element row set maps to its principal ideals; each fiber is covered by the six Eisenstein units. Thus the factor six is a valid upper bound even when the element row set contains only some unit associates. It is not a claim that every row fiber has exactly six members.

Most importantly, `normalization_norm_sq` at line12 gives

    |Z^(-(N+V)/2) * sqrt(Z^N) * S|^2 = Z^(-V)*|S|^2.

The extra sqrt(Z^N) is present in the actual short attachment. The final estimate is therefore Z^-V times the weighted actual short-square sum, not Z^-(N+V) times that sum. `CanonicalShortFinite` uses precisely this identity when converting to its displayed conclusion.

## Uniformity and admissible input

The fixed data are the smooth window with support in [lo,hi], lo>0, the bound L>=0, cstar>0, 0<eta<=1 with eta<=cstar/100000, and the finite slot and divisor-weight parameters rmax,K. The degree is chosen from these data before q. For every nonzero q the theorem then chooses C>0 and Z0>1 before the varying state, row set, labels, slots, character, theta and bounded coefficients.

The varying state retains N,V,M>=0; M,V,z0,hcut<=L; hcut>=0; Norm(span m)<=Z^L with m nonzero; `CanonicalMargins (N+V) M (normWidth Z (span m)) z0 margin`; margin>=cstar/2; V<=d; hcut<=d+eta; d<=cstar/200. The theorem does not require N<=L. Labels are squarefree and have norm at most Z^V. The finite attachment additionally retains supported labels and the actual excluded-prime construction. Rows are nonzero with norm at most Z^M. The disjoint finite prime lists retain primality, admissibility, odd residue characteristic, individual norm bounds and product H_i<=Z^z0. The actual character is bounded by one and factors through the fixed conductor. The finite attachment also retains D>=hi*Z^N.

`CanonicalShortFinite` passes to the finite subtype of selected slots and transports the actual list coefficients. It supplies the prime hypotheses from the existing outside-squarefree pool. It does not replace the mark by a new arbitrary bounded function. Its assumptions are stronger than the normalized abstract-list theorem at this attachment, not weaker.

The inspected short-energy proofs do not invoke canonical rank existence, a successor induction hypothesis, or the final QRH conclusion. Their physical estimates, width bounds and finite summations supply the short bound used by that induction. This is a direct-call audit, not a claim to have proved acyclicity of every imported theorem.

## Initial saving and its costs

`Inversion/TerminalWidths.lean:318–427` uses

    hybridSaving(v,za) = min(v,za,(v+za)/3)

and the exact reflected exponent

    O0/2 + max(H,v+ell) - S0 - B0 + za - hybridSaving(v,za)
      - ell - 2*el/3 - max(0,Td-v-3*ell-el)/2.

The common-width input, after the canonical invariant and Nstar=N-3*hhat, is

    Td-S0-B0 <= M-O0+2*za-z0-margin+5*d+4*eta.

The other physical input is H<=M-O0+eta. `actual_terminal_saving` at line472 derives these from the actual ideal norm bounds and the common-width charge, then invokes the three-case scalar theorem. The signs require nonnegative M,O0,S0,B0,za,v,ell, za<=z0, and el>=-eta. These are retained, not silently inferred from arbitrary real parameters.

The three scalar bounds before the final pi allowance are respectively

    F0-margin+5*eta/3,
    F0-2*margin+5*d+17*eta/3+tau,
    F0-M/4-3*margin/4+5*d/2+19*eta/6+tau/2.

Substitution of margin>=cstar/2, d<=cstar/200 and eta,tau,pi<=cstar/1000 leaves savings at least 373/750, 1451/1500 and 2147/6000 times cstar, respectively, after adding pi. Each exceeds cstar/4. The row/column split includes equality; the column split on `hybridSaving=za` is exhaustive. The initial cstar/4 is therefore supported by the explicit scalar proof, not by a claim that the reflected exponent is always small without the canonical margins.

`Reflection/OptionalWidth.lean` transports the same charge to the selected representative fiber using equality of the actual powerful and mask parts. `OriginalSaving.lean` gets the required nonnegative extracted widths and retained-width bound from `actual_surviving_retained_gates`. `OriginalExponent.lean` pays epsilon*(H+v+ell+za)+eta/2 from the supplied pi budget. `OriginalBranchSum.lean` then retains the square of the surviving-branch count and pays it by Norm(product pool)^rho.

`OriginalSectorUniformDegree.lean` combines this scalar result with `sector_normalized_literal_energy_uniform_degree` for the actual dyadic row. The common physical density costs the square of its L1 norm. The polynomial theta degree doubles at this step. The finite unit/dyad sum costs 36 times the square of the dyad count. Neither multiplicity is omitted.

`CanonicalParameters.lean:9` chooses epsilon=c/[100000*(L+1)], rho=c/[64*(L+1)], kappa=c/64, delta=eta and pi=c/1000. With the actual caps substituted, the pi condition holds and kappa+rho*L<=c/16. `RetainedBudgetUniformDegree` consequently changes -c/4 to -3c/16.

The full row has an additional tail. `OriginalFullUniformDegree` uses the actual identity with a fixed shape scalar and bounds the remainder per row. Its energy contains the explicit term

    2*rows.card*(Pset.card*Ctail*(1+|theta|)^degreeTail
       *Norm(product pool)*QK*QP*(Z^delta)^(-Adecay)
       *(familyRawScale)^(-2))^2.

Here `(familyRawScale)^(-2)` denotes the source's inverse square of its raw scale. `FullBudgetUniformDegree` selects Adecay before the fixed arithmetic family, bounds the finite row/column counts and inverse scale by the caps, and pays the tail using `actual_finite_source_tail_budget_uniform_degree`. It takes the maximum of the main degree and twice the tail degree. The canonical target exponent is positive by `CanonicalParameters.lean:35`, so the chosen tail target -1 is admissible. This review does not discard the tail or infer it from a retained-row estimate.

## The remaining loss ledger

The following entries describe a bound, so deliberate weakenings retain their slack. All fixed factors are incorporated into C after the fixed conductor; none is silently treated as one.

| Stage | Exponent relative to N+V | Reason |
| --- | --- | --- |
| Actual reflected sector, after retained count and tail | -3c/16-O0/2 | Previous section |
| Finite canonical dyad choice | <=-c/8-O0/2 | Count budget c/32; actual resulting -5c/32 is stronger |
| Inactive slots and frozen source choices | <=-c/16-O0/2 | Weighted finite Cauchy and source-cost budget c/32; resulting -3c/32 is stronger |
| Representative row aggregation | -c/32 | Aggregation costs c/32 and consumes Norm(powerful part)^(-1/2) |
| Cube-slot splitting | -c/64 | Norm(H)^epsilon, epsilon=c/[64*(L+1)], hhat<=L |
| Outer short-cube sum | -c/128 | Reciprocal-norm harmonic square costs c/128 |
| Label divisor weights and exact normalization | -c/256 | Sum of label weights <=C Z^(V+c/256), followed by Z^-V |

The raw weighted short-square sum therefore has exponent N+2V-c/256; the displayed normalized theorem has exponent N+V-c/256.

The row aggregation is an actual summation theorem, not removal of O0 from an inequality with an uncontrolled number of rows. The completed-row identity, puncturing of excluded primes and cube-slot split are preserved by the source calls in `CompletedCanonicalEnergyUniformDegree`, `CompletedRowsEnergyUniformDegree`, `OriginalCompletedEnergyUniformDegree` and `CubeCompletedEnergyUniformDegree`.

`ShortCompletionEnergy` applies weighted Cauchy with the genuine reciprocal norm weights. Its harmonic square is bounded by `[256*(columnDyadicLength(H0)+1)]^2`. `ShortReflectedPower.lean:14` absorbs it with exponent c/128 uniformly for hcut<=L. The divisor-weight lemma at `ShortCanonicalNormalization.lean:23` uses the divisor estimate and finite ideal count, with an exponent chosen from fixed K,L,c. This is why summing labels pays Z^(V+c/256) uniformly. The six-unit row bound is another fixed constant.

## Analytic boundary retained by this review

The scalar saving and upper summation/normalization chain have been reconstructed from the source bodies. Their main deeper inputs remain mathematical obligations at the following boundaries:

- The common-width charge `actual_common_width_charge_label_puncture` and its local ideal/character arithmetic. `TerminalWidths` takes logarithms of this actual positive-norm inequality correctly; that alone does not prove all its local arithmetic inputs.
- The physical reflected-row identity and common density, including `weighted_finite_physical_row_branch_measure_arithmetic_uniform`, its Fourier/radial construction and uniform derivative bounds. The inspected physical wrapper retains measurability, integrability, the actual coefficient factor and the L1-square cost.
- The quadratic/cubic hybrid sieve behind the bound proportional to `(X*Y*B*L)^epsilon*(X+Y*B)*B*(Y+L+(Y*L)^(2/3))`. This review does not promote that deep sieve merely because the subsequent exponent calculation works.
- The actual completed residual-source identity, finite Fourier geometry, local Gauss/reflection identities, retained-gate facts, and rapid whole-source tail producer. Their uses and parameter ordering are checked; their entire transitive foundations are not.
- Standard divisor/powerful-ideal counting and exact algebraic reindexing lemmas cited in the finite aggregation steps. The loss assigned to each is checked, not every theorem in their import closures.

These boundaries are narrower than the entire short-energy wrapper. They are not fresh hypotheses proposed for the final theorem. They identify existing source producers whose complete independent mathematical audit has not been established by this report.


## Author comparison and recorded correction

The author report agrees with the independently reconstructed actual sums, generator multiplicity, normalization, quantifier order, three terminal cases and complete saving ledger. Its distinction between a uniform degree and modulus-dependent constants/thresholds is necessary and correct. The canonical margins are substantive input conditions. The theorem does not assert nonempty admissible states for every arbitrary selection of caps or strict positivity of the resulting energy.

One sentence in its Section 3.2 needs correction. It describes the local reflection cost as at most q off the residual ideal and q^2 on it. The actual split in `CubicSieve/NormalizedMass.lean`, `reflectionLocalCost_le_gain`, is **P not dividing the original row ideal I versus P dividing I**. If P does not divide I, `completedLocalExponent_of_not_dvd` gives j=0 or j=4 and the cost is at most q. If P divides I, the general bound is q^2. All selected primes already satisfy P not dividing `rowResidualPart I Q`; some still divide the powerful or masked part of I, so a blanket q bound on nonresidual primes would be false. `Descent/Widths.lean` and the actual logarithmic-width proof retain the correct charge. This is a correction to the report's prose, not a repair of the source or the saving. The parent explicitly requested preserving the frozen author bytes and recording this correction here.

The additional analytic descriptions were also checked against the relevant source bodies. `Descent/Hybrid.lean:219,226` gives the actual inverse-cubic/quadratic sum, including 1/sqrt(Norm P) and both coprimality indicators. `HybridReduction` bounds repeated product columns by divisor multiplicity and the conjugated finite cubic matrix norm. `SourceHybrid` obtains a fixed-square energy E/Td^2, then multiplies by at most (256*Td)^2, leaving 256^2*E. `HybridBound` pays the two base powers and three squared logarithmic factors with nine epsilon/9 units. `Descent/Sharp` applies the cubic shape at N,2L, absorbs the factor two and combines two epsilon/2 contributions.

`CubicSieve/Sharp` and the inspected improvement body use a finite exponent iteration, monotone enlargement and reciprocity; they do not assume the desired final QRH conclusion. Their correctness as a complete analytic foundation still depends on the explicitly unreviewed initial/full-improvement/reciprocity producers. `Inversion/ReflectedNormalization` gives the exact squared outside scalar and the factors two and three from the row and cubic shapes, producing the same reflected exponent with factor six. The common-density integration in `UniformFiltered` establishes integrability from a pointwise finite-row norm bound before applying the common-measure energy inequality. These observations corroborate the author's reductions while preserving its stated deeper proof cut.

The three rational worst-case margins and every fractional step in the saving ledger were separately checked with exact rational arithmetic. This was scalar checking only, with no analytic function or source-code evaluator execution. The independently inspected source manifest below contains 53 files or specified ranges. The 60-file author manifest also contains named boundary files; its successful hash comparison is not an assertion that their entire proofs were read.

No further mathematical correction was found within this bounded review. The next productive audit targets are the actual quadratic product-column estimate, the cubic full-improvement producer, and the physical Fourier/radial identity and rapid-tail source. Formal elaboration and transitive axiom checks remain separate work.

## Independent source manifest

The following exact files or indicated ranges were inspected. `full` means the file body was read, not that its whole transitive import closure was validated. Hashing a file identifies the read source and does not certify its mathematics. Source repository commit: `4eaee87548250b2682affda7d05d947c05554bae`.

| Source path | Read scope | SHA256 |
| --- | --- | --- |
| `Inversion/ReflectedShortNormalizedUniformDegree.lean` | full | `C5078507182DBBAFFD26D14AB4414AFA2CA4B06253709BE773221757BF2E7609` |
| `Inversion/ReflectedShortGeneratorUniformDegree.lean` | full | `7414DC17396093E66C5D52C0D661173C2FCA175B04ADD901D9D315DE77A1400E` |
| `Inversion/ReflectedShortPowerUniformDegree.lean` | full | `7DD4285079442D8C7C8940BC3EBC84166FFAC047C43559BC5FA28CC4B6371235` |
| `Inversion/ReflectedShortUniformDegree.lean` | full | `AC833089F61DC974DCA7B54847A9BCEAFD7D00BA99310EC6CD50AFA3EF352D55` |
| `Descent/CanonicalShortFinite.lean` | full | `690078847B6F630C3E2C1FCF2B37BD64608C9AA59683516F12647C6BC1BB9FFD` |
| `Descent/ShortReflectedPower.lean` | full | `C1DD00C85AB567E70569B841719D94789D43DA06D13E12E485784FD98514975B` |
| `Descent/ShortReflectedEnergy.lean` | full | `46EF3748B2DC9E2A4FD12865E2707434DD2FEDE8EA636FC2BC846968C2EAD3C5` |
| `Descent/ShortCompletionEnergy.lean` | full | `BF5EA73961AD990D00E96AD7399DCFA17C9B0595059E0AA326FA7A389F925CF8` |
| `Reflection/CubeCompletedEnergyUniformDegree.lean` | full | `EA32C63D50B5676564108387B0F3050B658F68D72FB46CDC23AEE9F3F1020521` |
| `Reflection/CubeCompletedEnergy.lean` | full | `561578D6659FE80B6004E87699FA2D297606BCC01FA61D2D32A268BA50195EBE` |
| `Reflection/OriginalCompletedEnergyUniformDegree.lean` | full | `CDFB8020036FA17410234B0F346BA5A95646D46964607D70FE1D3725D323D854` |
| `Reflection/CompletedRowsEnergyUniformDegree.lean` | full | `02E7E646E7113D40B98F038F86E13D8D0B27D6961D0E6E1577AC80D56AE98AB5` |
| `Reflection/CompletedCanonicalEnergyUniformDegree.lean` | full | `8CB893C02D53809E287266EFD518ADD73612DEB725ACB1B0986D77D86761A1B0` |
| `Reflection/CanonicalFrozenEnergyUniformDegree.lean` | full | `C9044C940712B57EED6B00E564608AD164A587404E02FDB7D8931C332DB47A6C` |
| `Reflection/CanonicalInactiveEnergyUniformDegree.lean` | full | `94DFE2610816E9B50B19C49FB0439CF20997674D32D9E96431CDBB873FAF6679` |
| `Reflection/CanonicalChoiceEnergyUniformDegree.lean` | full | `B682AEA9AFD5C26D9C965B4BFEB6250F283EF9DC24FC1C5F37B2D3F651D2CFE2` |
| `Reflection/MemberGeometryUniformDegree.lean` | full | `D261FB4E3B3C4F2DB3C5429D75FBC94CC2B78C3B562C2C64A3E75912DB6223B8` |
| `Reflection/MemberBudgetUniformDegree.lean` | full | `C449B561788442CD76BDAC2D1542D55D741EF6AE2F8C32FB1190E7B9CFC0A5D7` |
| `Reflection/GlobalBudgetUniformDegree.lean` | full | `3DDDE9995ED21D643B511D83BC902625A00BB71E9C22974C91E909F18AC8BD2A` |
| `Reflection/FullBudgetUniformDegree.lean` | full | `DA4507E8A9DD28C59DAB3677BD3240D9150FC9711415F6E65E347BE8B88D2994` |
| `Reflection/OriginalFullUniformDegree.lean` | full | `D751E2CC8B063F4A293E09DDC58D23DC2FA31E0F68A3055BF75CD671E8B321C2` |
| `Reflection/ActualSizeCapsUniformDegree.lean` | full | `610881B045FFA13D898B1426E51AC7D981DFB5903ED1B821D73EDA14D59FC5E3` |
| `Reflection/RetainedBudgetUniformDegree.lean` | full | `75223CDD469A60D4A0293D38DDE432E8892A984E29E2654B8552CE15ED290460` |
| `Reflection/OriginalRetainedUniformDegree.lean` | full | `25FB1C1F5F39D0CAC6BE4D2D1128CB9AA742392A6C8A0470852F07D98F083B54` |
| `Reflection/OriginalSectorUniformDegree.lean` | full | `C838E96509377095AB08A79E479398275088E96E2276AC75EF7A16BE446E48DE` |
| `Reflection/OriginalBranchSum.lean` | full | `C579A307C1CBD3A28FFA82D61EE40A4E535F186145459ED6ED3250401F7F257A` |
| `Reflection/OriginalSaving.lean` | full | `F4F197B1C40F015CC57C6B02AFEF1F4B5A10AE9E9BCA4E56D006810B4FCBAFD9` |
| `Reflection/OriginalExponent.lean` | full | `CB95D8779394D6026167DF31E4F027076D465BD7CFE186FEE3C682861CFE38C9` |
| `Reflection/OptionalWidth.lean` | full | `8A2A44CDB361EAF276391C77C08C9FCAA428890635F1BD08EDA35B9CE2B0B98A` |
| `Reflection/CanonicalParameters.lean` | full | `34FE18EA8FC6A4E7AA6FA635FA7BB44C9FFAA17C525ACBF1A6F6CBCD6B36862A` |
| `Reflection/CanonicalCaps.lean` | full | `EBFAAFD9FE57DC93B6A3DC30E4C24BFBF23E0884472825A8D64E9DFA85D549DC` |
| `Inversion/TerminalWidths.lean` | full | `3D61740AE583E07ECD4D42813FB411299B96AAC43E66DC60F91AA8BD0A04F0B9` |
| `Reflection/UniformPhysicalUniformDegree.lean` | full | `4082B9C2FFF5658C46C97C9E4E667AC14A7A4CA51166064C4FDCDD1460A91829` |
| `Inversion/ShortCanonicalNormalization.lean` | 1-205 | `F3490F18A0380DA7E61FFA3B556B22BE1A15A24BA0C2A6E9725BA7F008758228` |
| `Descent/Completion.lean` | 1-80 | `6D3490853CBAE6F716C06CF99724C65F64418E9B6171EF6A89711E801E9C3BAC` |
| `Descent/ReopenedBins.lean` | 46-83 | `B9D71C53602FDDBB043ED7BA5002EE0A0D17146BC5915F58C663492FABB9D1CB` |
| `Arithmetic/IdealMobius.lean` | 438-475 | `EBE57D9158EB08FB55394555D08DAFDDB8A135BF15C74CFD5B77E7E7D0784B79` |
| `Eisenstein/CompactEnergyFamilies.lean` | 481-508 | `DC9740419DEF3E33582594A250BE19B7BF94837FBA36E23EC1633CA343AC91A7` |
| `Reflection/CanonicalDyadsUniformDegree.lean` | 1-12,65-end | `F31291E1D2C402BF0EB44229FCBD2F05E147AB6B484069CA38F7CD8AEDE1EE54` |
| `Reflection/CanonicalEnergyUniformDegree.lean` | 1-14,58-end | `874DF35EC60329AEABD16F54D1FF1976D4B3287F57C5693F21207366F4F34AF6` |
| `Reflection/UniformSieve.lean` | 1-155 and final 110 lines | `C9F4E42A1C42222DD8F0BA683B12E529B3C8A4C79329C04C3565A281E9015365` |
| `Descent/Sharp.lean` | full | `8256E57E8E08D6E210B60ED2F1A06FB18F866346306581AB36B7947AD439E875` |
| `Descent/HybridReduction.lean` | full | `BB6BC1D1C10F933D551BED6775D41756C56F6AA4C8410DB38A9E7D72625AF5E4` |
| `Descent/HybridBound.lean` | full | `71776523D09523434636E25BCAC7E8555D497A00B1EBDA84287140C2AF5354E7` |
| `Descent/SourceHybrid.lean` | full | `B45F84E5AC360319E7F28524B252DA9E3A40DE8812FBB851008C74A716B8E777` |
| `Inversion/ReflectedNormalization.lean` | full | `B8630BCA224AEAB67865AAE5079333FA30B4ED946076DA50F7F4A14B60C3E0DD` |
| `CubicSieve/Sharp.lean` | full | `2EA22192D557C6D359EA6E5AF91C1DE03E6B91759FA4DB971AF3EE5D6D68F3FA` |
| `CubicSieve/ExponentImprovement.lean` | 66-end | `5225C2910E2CC4F464D65CBA0101D6C4B4D099ABA0338929DE4D6C204AAECFAD` |
| `Descent/Hybrid.lean` | 201-250 | `9D49CC4EA3DEB655392842BA580AC00BACB2DB7577F42840D9BAE30A0C419929` |
| `Reflection/TailEnergyBudgetUniformDegree.lean` | full | `2A44BA1E44B2F9D4FDE90F2506FB972B033ED6358BEC19776BBF6E6E2E909E26` |
| `Reflection/UniformFiltered.lean` | full | `143A5AF7D317BC21A7ECA721BC8E7705EC01881D429145AF6499A341DF2BA46F` |
| `CubicSieve/NormalizedMass.lean` | 571-670 | `637BA74AD000F0C71BBCF1B4A9BF7AE8D2244BF7394BE3B225FE17B963D0587E` |
| `Descent/Widths.lean` | final 60 lines | `5EE47679B2E0213A8EBDB77582A2828B4BC269D0F4F1F5B227CBE95C0D3E51D8` |
