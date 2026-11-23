# Bounded audit of the actual short reflected energy

Date: 2026-11-11. Source baseline: `work/openai-math` commit
`4eaee87548250b2682affda7d05d947c05554bae`. Paths below are relative to
`work/openai-math/lean/OAI/NumberTheory/DirichletL/`.

## Finding and scope

The inspected source gives a substantive mechanism for the short saving: a mixed quadratic/cubic sieve bound for the actual reflected rows, a three-case terminal-width inequality giving an initial `cstar/4` gain, and explicitly paid losses for retained branches, tails, fibers, cube slots, harmonic summation and squarefree labels. The remaining gain is `cstar/256`. I found no mathematical mismatch in these inspected steps. This is a bounded source/math audit, not a compilation result, an axiom audit, or validation of the global QRH provider.

The deepest estimates still needing independent validation are listed in Section 7. In particular, deriving the reflected energy from the quadratic and cubic sieve estimates does not establish those sieve estimates. Likewise, inspecting how the physical integral and its rapid tail are consumed does not establish their underlying Fourier/Mellin identities or decay bounds. No Lean files were edited, no Lean commands run, and no analytic or prime values evaluated.

## 1. Exact quantity and quantifiers

`Inversion/ReflectedShortNormalizedUniformDegree.lean:13` states the target. For a smooth compactly supported `W`, with support in `[lo,hi]` and `lo>0`, fixed `L>=0`, `cstar>0`, `0<eta<=min(1,cstar/100000)`, and natural `rmax,K`, it chooses a natural `degree` **before** the modulus. For each natural `q!=0`, it then chooses positive `C` and `Z0>1`. These work for every admissible finite state, character coefficient, height twist and sufficiently large `Z` in the theorem.

The state includes `m!=0`, nonnegative `N,V,M`, `M,V,z0,hcut<=L`, `hcut>=0`, `norm(m)<=Z^L`, and

```
CanonicalMargins (N+V) M (normWidth Z (span {m})) z0 margin,
cstar/2 <= margin,
V <= d, hcut <= d+eta, d <= cstar/200.
```

It has squarefree ideal labels `f` with norm at most `Z^V`, nonzero row elements `k` of norm at most `Z^M`, and at most `rmax` pairwise-disjoint prime lists. The lists satisfy the actual good-prime and odd-residue-characteristic conditions, have norm caps `H_i>=1`, and `prod H_i<=Z^z0`. The multiplicative coefficient `Psi` has norm at most one and factors modulo the specified `fixedBaseConductor q`. All tuple weights have norm at most one.

The left side is the weighted sum of squared norms of

```
Z^(-(N+V)/2) * sqrt(Z^N) *
markedShortCompletedSum
  (rowTwist Psi (maskElement q m) (idealGenerator f) k)
  (normTwistedSource W theta) (Z^N) (Z^hcut)
  (tupleDivisibilityMark lists w).
```

The weight is `secondLabelWeight K f = divisorCard(f)^(9+4*K)`
(`Descent/SecondNormalizedEnergy.lean:35`). The conclusion is at most
`C*(1+norm(theta))^degree * Z^(N+V-cstar/256)`.

The two outside factors square to **`Z^(-V)`**, not `Z^(-(N+V))`.
`Descent/CanonicalShortFinite.lean:15` explicitly proves this identity and transports the finite indexed mark and prime-list data to the theorem. It does not change the character or smoothing function. Its raw-square-sum consequence therefore has exponent `N+2V-cstar/256`; claiming raw exponent `N+V-cstar/256` would be incorrect.

The polynomial degree is uniform in `q`; the constant and eventual threshold are not asserted uniform in `q`. The proof freezes arithmetic families, takes finite maxima/sums, and absorbs their constants into `Z0`. No quantitative conductor dependence is supplied here. Empty labels, row sets or tuple fibers give zero sums. No strict positivity of the energy is needed or obtained. Nonzero hypotheses are retained where norms, generators or logarithmic widths are used.

## 2. The short sum is the actual completed cube sum

`Descent/ReopenedBins.lean:61` defines the short part by summing ideals `H` with `norm(H)<H0`, with coefficient `mu(H)*cubeWeight Psi H`, applied to the completed sum at scale `X/norm(H)^3` and the mark `I -> mark(H^3*I)`. `Descent/Completion.lean:15` defines that completed sum as the actual two-ideal sum involving `summand Psi W X I J` and the mark on `I*J^3`.

`Descent/ShortCompletionEnergy.lean:12` converts the short part to a finite sum on `shortCubeRange H0`. The zero ideal is removed by the source definitions; this step is not an exchange of two unproved absolutely convergent sums. At line 25 the weighted Cauchy estimate uses
`norm(mu(H)*cubeWeight Psi H)<=1/norm(H)` and pays the square of the harmonic sum. The bound used later is `256*(columnDyadicLength H0+1)` for that harmonic sum.

The reflected row to which the sieve is applied is also explicit. `Descent/Hybrid.lean:219,226` forms an inner sum of a bounded coefficient times the quadratic row at the primary generator of `n*b`, the inverse cubic kernel at `(P,n)`, and the coprimality indicator for `(P,b)`. The outer sum has coefficient `a(P)/sqrt(norm(P))`, the coprimality indicator for `(k,P)`, and that inner sum. Thus the next step is not an estimate for arbitrary unrelated rows or an inference of a mixed moment from a second moment.

## 3. Actual analytic mechanism of the initial saving

### 3.1 From hybrid rows to a physical reflected energy

`Descent/Sharp.lean:83` proves, under its explicit admissibility, squarefree, nonzero-generator and dyadic support hypotheses,

```
sum_k |hybridRow(k)|^2
 <= C_epsilon * (K*N*B*L)^epsilon
      * (K+N*B)*B * (N+L+(N*L)^(2/3)),
K,N,B,L >= 1.
```

Its body combines `hybridRow_energy_sieve_norm(epsilon/2)` with the sharp cubic sieve factor. At line 12, substituting `sieveNorm N (2L)` and absorbing the factor 2 gives exactly the displayed cubic shape, with an additional constant depending on epsilon. These constants are chosen before the finite row and column sets.

The route below the sieve-norm wrapper was inspected rather than merely listed. `Descent/SourceHybrid.lean:75` reconstructs supported product columns using a fixed square factor and common dyadic cells. The fixed-square row energy has a `1/Td^2` cost, while the finite outer reconstruction has at most `256*Td` terms; the squared count cancels this power, leaving dyadic-count losses. `Descent/HybridBound.lean:11` absorbs these losses with `delta=epsilon/9`: the base small-power contribution and the three squared logarithmic factors fit the nine allocated delta units. The supported-to-rectangular specialization at line 96 preserves the row definition.

`Descent/HybridReduction.lean:12` rewrites the finite inverse-cubic energy as the conjugated finite matrix norm. At line 45 the quadratic reduction applies the fixed-factor quadratic product-column estimate and coefficient Cauchy. Lines 83 and 120 control repeated product columns through divisor multiplicities and the cubic sieve norm. I inspected these reductions; the entire deeper fixed-block reconstruction and the underlying quadratic large-sieve proof were not independently validated in this round.

On the cubic side, `CubicSieve/Sharp.lean:8,63` uses finite exponent improvement from the initial exponent, then reciprocity, obtaining `M+N+(MN)^(2/3)`. The algebra in `CubicSieve/ExponentImprovement.lean:77` takes `theta=min(epsilon/14,1/4)`, enlarges `M` to `max(M,N^enlargementExponent)`, applies `HasCubicExponent.full_improved`, and absorbs `N^(7theta)` into the requested epsilon. This is a genuine exponent-improvement step, but the analytic producer `full_improved` is an explicit remaining cut, not validated by inspecting this use.

`Reflection/UniformSieve.lean:14,81` applies the hybrid bound to the actual extracted branches. The extracted sizes are `max(1,Y/norm(D1))` and `max(1,B/norm(D2))`, so the sieve lower-size hypotheses are respected. Actual frozen, row, slot and cusp phases are retained in the branch definition; their absolute-value bounds are used in the energy estimate. `Reflection/UniformFiltered.lean:15,71` pays the finite branch count and uses the common integrable density. Its integrability proof first bounds each finite row vector, so the integration step is justified before applying the vector triangle/Cauchy inequality.

`Reflection/UniformPhysicalUniformDegree.lean:15` obtains the actual physical-row integral representation from `Inversion/ReflectedArithmeticHeight.lean:118`. The shared prefactor is
`exp(M2/2+M3)/(ramifiedScale*sqrt(Qn)*Qb) * smallScalar(R)`.
The common density has L1 bound `C0*(1+|theta|)^degree`. Integrating the branch energy pays the **square** of this bound. There is no independent choice of density for each row and no use of an L2-to-L4 implication.

### 3.2 The power accounting and terminal width inequality

`Inversion/ReflectedNormalization.lean` rewrites the squared outside scalar as the power

```
-v - 2*ell - 2*el/3 - S - B
 - max(0,Td-v-3*ell-el)/2.
```

The quadratic shape is bounded by `2*Z^max(H,v+ell)`. The cubic shape is bounded by
`3*Z^(v+za-h)`, where `h=min(v,za,(v+za)/3)`.
The resulting exponent, before small losses, is

```
E = max(H,v+ell)-S-B+za-h-ell-2*el/3
    - max(0,Td-v-3*ell-el)/2.
```

This is the source `reflectedExponent` with its separate `O/2` adjustment removed. The numerical factor is 6. `Reflection/AnnularExponent.lean` and `UniformNormalized.lean` connect these powers to actual scales and retain the epsilon loss and fixed arithmetic constants. The max-one extracted sizes are removed only on surviving branches where the necessary lower bounds have been established.

The terminal argument is substantial. `Inversion/TerminalWidths.lean:16,126,194,286` transports the actual norm/charge inequalities to logarithmic widths. In particular, the common arithmetic charge bounds

```
norm(residual)^2 * reflectionConductorCost
 <= norm(B) * (norm(I)^2/norm(powerfulPart)) * norm(F)*norm(R).
```

The source charge is a ratio with `norm(D2)^4` in its denominator, not an unweighted count of active primes. `Descent/Widths.lean` and `CubicSieve/NormalizedMass.lean:598` connect it to the actual local costs. The latter uses cost at most `q` off the residual ideal and at most `q^2` on it, together with a product-divisibility bound. The underlying local Gauss/product-divisibility identities remain a separate cut.

Writing `F0=N+V`, `Q=normWidth(m)`, the two margin assumptions are
`F0-M-Q-z0>=margin` and `4F0-3M-6z0>=margin`.
With `Nstar=N-3*hhat`, `V<=d`, `hhat<=d+eta`, the source obtains the needed dual-width upper bound, allowing its stated extra slack. Surviving branches satisfy `v,ell>=0`, `el>=-eta`, and `v+3ell+el<=Td+tau` with `tau=delta+eta`.

`TerminalWidths.lean:348–425,472` then uses three exhaustive cases:

| Case | Upper exponent, including the `O/2` adjustment but before `pi` |
|---|---|
| `v+ell<=H` | `F0-margin+5*eta/3` |
| `H<=v+ell` and `h=za` | `F0-2*margin+5*d+17*eta/3+tau` |
| remaining column case (`h>=v/2`) | `F0-M/4-3*margin/4+5*d/2+19*eta/6+tau/2` |

For `margin>=cstar/2`, `d<=cstar/200`, and `eta,tau,pi<=cstar/1000`, the respective savings, even using these looser eta bounds, are at least
`373*cstar/750`, `1451*cstar/1500`, and `2147*cstar/6000`.
Each exceeds `cstar/4`. Thus the literal branch bound is
`F0-cstar/4-O/2`. This is the precise source of the initial gain.

`Reflection/CanonicalParameters.lean:9` supplies the error parameters. At the enlarged cap `Lc=4L+2`, take
`epsilon=cstar/(100000*(Lc+1))`, `rho=cstar/(64*(Lc+1))`, `kappa=cstar/64`, `delta=eta`, `pi=cstar/1000`.
The logarithmic scale cap is `7Lc+1`. The proof bounds its epsilon coefficient by `22*(Lc+1)` and verifies `kappa+rho*Lc<=cstar/16`. Choices precede the fixed arithmetic family; eventual thresholds can depend on that family.

## 4. The discarded part is paid for

`Reflection/OriginalSectorUniformDegree.lean:13` combines the literal physical energy with `OriginalSaving`, `OriginalExponent`, and `OriginalBranchSum`. The retained branch count is squared, and its small-power bound together with the pool loss uses at most `cstar/16`. The resulting retained energy has exponent `F0-3*cstar/16-O/2`, retaining the squared density constant and polynomial theta degree.

`Reflection/OriginalFullUniformDegree.lean` decomposes the whole source into the retained source and its actual error. It uses `|u+v|^2<=2|u|^2+2|v|^2`. The row error contains the prime-set cardinal, kernel scale factors, a negative power of `Z^delta`, and inverse raw-scale powers; it is not set to zero.

`Reflection/TailEnergyBudgetUniformDegree.lean:11` chooses a rapid-tail order before freezing the arithmetic family. The source's polynomial tail factor is bounded by a constant times `Z^(17*Lcap)`; the choice through `choose_weighted_rapid_tail_order` pays both its square and the row-count power `Z^Lcount`. `FullBudgetUniformDegree` requests enough saving to place this whole error below the retained target. The target's positivity follows from the actual canonical margins, not from an assertion that every arbitrary state is admissible. The analytic rapid-tail theorem supplying that decay remains unvalidated in this audit.

## 5. From the reflected bound to `cstar/256`

The following losses were traced through their proof bodies; inequalities sometimes deliberately weaken a stronger exponent.

| Operation | Resulting saving |
|---|---:|
| Actual terminal branch | `cstar/4`, with `-O/2` |
| Retained branch count/pool; whole-tail absorption | `3*cstar/16`, with `-O/2` |
| Literal dyadic/slot selection and its count | at least `5*cstar/32`, weakened to `cstar/8` |
| Inactive-mark/frozen-family assembly | at least `3*cstar/32`, weakened to `cstar/16` |
| Completed representative/fiber aggregation | `cstar/32` |
| Cube-slot/subset assembly | `cstar/64` |
| Short harmonic square | `cstar/128` |
| Squarefree label divisor weight after `Z^-V` | `cstar/256` |

The canonical dyad proof selects actual nonempty row/slot witnesses to transfer the norm inequalities; empty cells are treated separately. `CompletedCanonicalEnergyUniformDegree` uses the actual reflection conductor, fixed Fourier geometry and masked twist. `CompletedRowsEnergyUniformDegree` pays the powerful-part fiber sum. `CubeCompletedEnergyUniformDegree` uses epsilon `cstar/(64*(L+1))` so the cube norm factor fits its assigned loss. `ReflectedShortPowerUniformDegree` absorbs the harmonic square, and `ReflectedShortGeneratorUniformDegree` applies the squarefree divisor-weight sum with loss `cstar/256` and the six-unit generator multiplicity. Neither the label count nor this factor 6 is omitted. The last factor is part of the constant, not an exponent loss.

Finally `CanonicalShortFinite` transports the actual excluded-prime pool and indexed mark to this bound. Its additional `Supported f` hypothesis is preserved by the caller; the more general generator theorem does not need that extra hypothesis. No circular use of the eventual marked-energy rank theorem was found in the inspected chain. This statement is restricted to the bodies inspected here, not a claim about every foundational dependency.

## 6. What was checked

The audit reconstructed the hybrid row definition, finite quadratic/cubic reductions, the cubic improvement wrapper, integrated physical energy, outside-scalar normalization, actual charge-to-width argument, all three terminal exponent cases, explicit parameter choices, tail budgeting, and upper short/label normalizations. This goes below the previous rank audit's short-energy boundary.

It did not attempt a fresh proof of the full quadratic or cubic large sieve, local Gauss identities, the completed Fourier kernel or arbitrary-order rapid decay. It also did not inspect a generated environment, compiled theorem type or axiom closure. No positive energy, nonempty admissible state for arbitrary caps, uniform-in-modulus threshold, or computationally usable constant is inferred.

## 7. Exact next boundaries

1. **Quadratic sieve producer.** `Descent/Quadratic.lean:77`, `quadratic_squarefree_product_column_energy`, and its fixed-factor transport consumed in `HybridReduction.lean:45`. The use and norm factors were traced; the underlying product-column estimate and all of its analytic dependencies were not established here.
2. **Cubic exponent improvement producer.** `CubicSieve/FullImprovement.lean:48`, `HasCubicExponent.full_improved`, called at `ExponentImprovement.lean:87`; also the initial exponent and reciprocity used by `CubicSieve/Sharp`. The enlargement and final iteration algebra were checked, not the complete deeper analytic improvement proof.
3. **Physical row representation.** `Inversion/ReflectedArithmeticHeight.lean:118`, `weighted_finite_physical_row_branch_measure_arithmetic_uniform`, called by `UniformPhysicalUniformDegree.lean:60`. Its exact representation and L1 bound are consumed faithfully. The underlying Fourier/Mellin construction, local arithmetic phases and all required exchanges of integrals remain separate source-audit work.
4. **Rapid tail producer.** `Reflection/WholeTailUniformDegree.lean:13`, `original_family_whole_tail_uniform_degree`, and its row-tail/rapid-decay dependencies. The finite energy budget and quantifier order after this input were checked; arbitrary-order decay was not proved by this audit.
5. **Local charge and reconstruction foundations.** `CubicSieve/NormalizedMass.lean` local reflection cost and nonresidual-gain divisibility, and the remaining detailed fixed-square reconstruction beneath `Descent/HybridReduction.lean:137`. Their exact interfaces are retained. These are not assumptions that can simply be dropped when claiming the physical saving.

These cuts identify work still required before a source-level proof audit could validate the provider. There is no new final spectral premise, strategy adoption or numerical consequence asserted in this report.

## Source SHA-256 pins

The table below pins consulted source and explicitly named cut files. Inclusion does not mean every line of every file was independently proved; the read depth and remaining boundaries are stated above.

| Source | SHA-256 |
|---|---|
| `Inversion/ReflectedShortNormalizedUniformDegree.lean` | `C5078507182DBBAFFD26D14AB4414AFA2CA4B06253709BE773221757BF2E7609` |
| `Inversion/ReflectedShortGeneratorUniformDegree.lean` | `7414DC17396093E66C5D52C0D661173C2FCA175B04ADD901D9D315DE77A1400E` |
| `Inversion/ReflectedShortPowerUniformDegree.lean` | `7DD4285079442D8C7C8940BC3EBC84166FFAC047C43559BC5FA28CC4B6371235` |
| `Inversion/ReflectedShortUniformDegree.lean` | `AC833089F61DC974DCA7B54847A9BCEAFD7D00BA99310EC6CD50AFA3EF352D55` |
| `Inversion/ShortCanonicalNormalization.lean` | `F3490F18A0380DA7E61FFA3B556B22BE1A15A24BA0C2A6E9725BA7F008758228` |
| `Inversion/ReflectedNormalization.lean` | `B8630BCA224AEAB67865AAE5079333FA30B4ED946076DA50F7F4A14B60C3E0DD` |
| `Inversion/TerminalWidths.lean` | `3D61740AE583E07ECD4D42813FB411299B96AAC43E66DC60F91AA8BD0A04F0B9` |
| `Inversion/ReflectedArithmeticHeight.lean` | `0B7D916E472059D8F70C09719CE54D891A66EEA8904039F02EF18D293AFE24BE` |
| `Descent/CanonicalShortFinite.lean` | `690078847B6F630C3E2C1FCF2B37BD64608C9AA59683516F12647C6BC1BB9FFD` |
| `Descent/SecondNormalizedEnergy.lean` | `CCC23556F52E7CCBF521A54B022BCE64ED645F92317913CB2F47401144CE5F0C` |
| `Descent/ReopenedBins.lean` | `B9D71C53602FDDBB043ED7BA5002EE0A0D17146BC5915F58C663492FABB9D1CB` |
| `Descent/Completion.lean` | `6D3490853CBAE6F716C06CF99724C65F64418E9B6171EF6A89711E801E9C3BAC` |
| `Descent/ShortCompletionEnergy.lean` | `BF5EA73961AD990D00E96AD7399DCFA17C9B0595059E0AA326FA7A389F925CF8` |
| `Descent/Hybrid.lean` | `9D49CC4EA3DEB655392842BA580AC00BACB2DB7577F42840D9BAE30A0C419929` |
| `Descent/Sharp.lean` | `8256E57E8E08D6E210B60ED2F1A06FB18F866346306581AB36B7947AD439E875` |
| `Descent/HybridBound.lean` | `71776523D09523434636E25BCAC7E8555D497A00B1EBDA84287140C2AF5354E7` |
| `Descent/SourceHybrid.lean` | `B45F84E5AC360319E7F28524B252DA9E3A40DE8812FBB851008C74A716B8E777` |
| `Descent/HybridReduction.lean` | `BB6BC1D1C10F933D551BED6775D41756C56F6AA4C8410DB38A9E7D72625AF5E4` |
| `Descent/Quadratic.lean` | `1A7449EA20381B280C7920C47C49BBC3B5C7478E911F98D23E6CAAB529741A16` |
| `Descent/Widths.lean` | `5EE47679B2E0213A8EBDB77582A2828B4BC269D0F4F1F5B227CBE95C0D3E51D8` |
| `CubicSieve/Sharp.lean` | `2EA22192D557C6D359EA6E5AF91C1DE03E6B91759FA4DB971AF3EE5D6D68F3FA` |
| `CubicSieve/ExponentImprovement.lean` | `5225C2910E2CC4F464D65CBA0101D6C4B4D099ABA0338929DE4D6C204AAECFAD` |
| `CubicSieve/FullImprovement.lean` | `917501B7005D3BE61C668BAB919265AD061F2EF305E42CC5BAFA21CBA7DB84CA` |
| `CubicSieve/Growth.lean` | `7CAA9B7C0DB9D5B4641F2734A2827835FAD00CC234632157A4376A56B127B255` |
| `CubicSieve/NormalizedMass.lean` | `637BA74AD000F0C71BBCF1B4A9BF7AE8D2244BF7394BE3B225FE17B963D0587E` |
| `Reflection/UniformSieve.lean` | `C9F4E42A1C42222DD8F0BA683B12E529B3C8A4C79329C04C3565A281E9015365` |
| `Reflection/UniformFiltered.lean` | `143A5AF7D317BC21A7ECA721BC8E7705EC01881D429145AF6499A341DF2BA46F` |
| `Reflection/UniformPhysicalUniformDegree.lean` | `4082B9C2FFF5658C46C97C9E4E667AC14A7A4CA51166064C4FDCDD1460A91829` |
| `Reflection/AnnularExponent.lean` | `973AE11628720C626EF96481B68F7012DC3E9CBE2CFFEF60FE25588CB1813A2D` |
| `Reflection/UniformNormalized.lean` | `E1BAB5C5DC71D7E840C8205CCEB6CAAF7BAB9F9BF6081741D479359C835F6CB8` |
| `Reflection/UniformNormalizedUniformDegree.lean` | `956CFB2083488BCC2AD5E80001D589BCDEF55C58E679BDBA80F43E9682AC7FFC` |
| `Reflection/SectorNormalizedUniformDegree.lean` | `F42E6BCBE49DF95A2AE4DDC853D474CA3DF8818EADDDADF549A4D6B6B85094C2` |
| `Reflection/LiteralNormalizedUniformDegree.lean` | `FDFE59A5F4FDE6C055DF5CF48A3BEF0760658A83C4287E865F4538D7ED251DF6` |
| `Reflection/OriginalSectorUniformDegree.lean` | `C838E96509377095AB08A79E479398275088E96E2276AC75EF7A16BE446E48DE` |
| `Reflection/OriginalSaving.lean` | `F4F197B1C40F015CC57C6B02AFEF1F4B5A10AE9E9BCA4E56D006810B4FCBAFD9` |
| `Reflection/OptionalWidth.lean` | `8A2A44CDB361EAF276391C77C08C9FCAA428890635F1BD08EDA35B9CE2B0B98A` |
| `Reflection/OriginalExponent.lean` | `CB95D8779394D6026167DF31E4F027076D465BD7CFE186FEE3C682861CFE38C9` |
| `Reflection/OriginalBranchSum.lean` | `C579A307C1CBD3A28FFA82D61EE40A4E535F186145459ED6ED3250401F7F257A` |
| `Reflection/SurvivingGate.lean` | `3E0EF52884B35B20B03236B8EFDAC6D064B5A508843461DEC8F51DCB1E2835BC` |
| `Reflection/CanonicalParameters.lean` | `34FE18EA8FC6A4E7AA6FA635FA7BB44C9FFAA17C525ACBF1A6F6CBCD6B36862A` |
| `Reflection/OriginalFullUniformDegree.lean` | `D751E2CC8B063F4A293E09DDC58D23DC2FA31E0F68A3055BF75CD671E8B321C2` |
| `Reflection/FullBudgetUniformDegree.lean` | `DA4507E8A9DD28C59DAB3677BD3240D9150FC9711415F6E65E347BE8B88D2994` |
| `Reflection/ActualSizeCapsUniformDegree.lean` | `610881B045FFA13D898B1426E51AC7D981DFB5903ED1B821D73EDA14D59FC5E3` |
| `Reflection/TailEnergyBudgetUniformDegree.lean` | `2A44BA1E44B2F9D4FDE90F2506FB972B033ED6358BEC19776BBF6E6E2E909E26` |
| `Reflection/WholeTailUniformDegree.lean` | `6A8459EF5764E85846CE9FACE26D0C33B0D6BDA6280291AFD048A256F38D967A` |
| `Reflection/RowTailUniformDegree.lean` | `811B963CA6B853F44D6C6851513A4227D3C56F76E4842E01989F30731A89CAD4` |
| `Reflection/CanonicalFrozenEnergyUniformDegree.lean` | `C9044C940712B57EED6B00E564608AD164A587404E02FDB7D8931C332DB47A6C` |
| `Reflection/CanonicalInactiveEnergyUniformDegree.lean` | `94DFE2610816E9B50B19C49FB0439CF20997674D32D9E96431CDBB873FAF6679` |
| `Reflection/CanonicalChoiceEnergyUniformDegree.lean` | `B682AEA9AFD5C26D9C965B4BFEB6250F283EF9DC24FC1C5F37B2D3F651D2CFE2` |
| `Reflection/CanonicalDyadsUniformDegree.lean` | `F31291E1D2C402BF0EB44229FCBD2F05E147AB6B484069CA38F7CD8AEDE1EE54` |
| `Reflection/CanonicalEnergyUniformDegree.lean` | `874DF35EC60329AEABD16F54D1FF1976D4B3287F57C5693F21207366F4F34AF6` |
| `Reflection/MemberGeometryUniformDegree.lean` | `D261FB4E3B3C4F2DB3C5429D75FBC94CC2B78C3B562C2C64A3E75912DB6223B8` |
| `Reflection/MemberBudgetUniformDegree.lean` | `C449B561788442CD76BDAC2D1542D55D741EF6AE2F8C32FB1190E7B9CFC0A5D7` |
| `Reflection/GlobalBudgetUniformDegree.lean` | `3DDDE9995ED21D643B511D83BC902625A00BB71E9C22974C91E909F18AC8BD2A` |
| `Reflection/CompletedCanonicalEnergyUniformDegree.lean` | `8CB893C02D53809E287266EFD518ADD73612DEB725ACB1B0986D77D86761A1B0` |
| `Reflection/CompletedRowsEnergyUniformDegree.lean` | `02E7E646E7113D40B98F038F86E13D8D0B27D6961D0E6E1577AC80D56AE98AB5` |
| `Reflection/OriginalCompletedEnergyUniformDegree.lean` | `CDFB8020036FA17410234B0F346BA5A95646D46964607D70FE1D3725D323D854` |
| `Reflection/CubeCompletedEnergyUniformDegree.lean` | `EA32C63D50B5676564108387B0F3050B658F68D72FB46CDC23AEE9F3F1020521` |
| `Eisenstein/CompactEnergyFamilies.lean` | `DC9740419DEF3E33582594A250BE19B7BF94837FBA36E23EC1633CA343AC91A7` |
| `QuadraticSieve/ProductColumns.lean` | `B3CBB538BB0A8A18F2F0853BCF0A45E3EDC3E619A9310BB6E798DEDD9CF08C84` |
