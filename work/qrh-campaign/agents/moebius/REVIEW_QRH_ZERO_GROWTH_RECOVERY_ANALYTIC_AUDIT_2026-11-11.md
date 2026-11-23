# Independent review: QRH zero-growth recovery

2026-11-11. PASS at the bounded source/paper scope described below. No correction is required to `integration/QRH_ZERO_GROWTH_RECOVERY_ANALYTIC_AUDIT_2026-11-11.md`, SHA256 `E7E7459604669F251BDC7A1FE196CEDCC734D1AF37C4005B96EA1781F4CA720D`. I independently reconstructed the immediate recovery implication and read the frozen report in full. This verdict does not construct its supplied GrowthAt premise, validate the entire QRH proof, establish elaborated axiom closure, or certify a build. No Lean builds, declarations, source edits, or analytic evaluations were performed.

Source locations below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, expected revision `4eaee87548250b2682affda7d05d947c05554bae`.

## Growth premise and child carrier

`Energy/ZeroGrowth.lean:15` defines the actual premise `ZeroGrowthAt`: for states of width at most Mcap, positive scales each at most Z^L, and supported profiles, the energy is bounded by the stated controls times Z^(max(width,length1+length2)+loss). Here length(Z,X)=log_Z(max(1,X)). This recovery uses that premise; it does not construct it or silently replace max(width,length1+length2) by width.

`ZeroGrowthChild.lean:22,43` applies it to the unit-puncture state at height zero after incorporating the two independent frequencies into the profiles. `ZeroReferenceChild.independent_energy` supplies the exact equality with the actual unpunctured natural-character pair. The unit-puncture state requires Bmask>=0, keeps the same width and fixed modulus, and preserves the effective radial carrier. The latter removes only rows where the radial profile vanishes. It does not discard a live exceptional or inconvenient row.

`ZeroGrowthMoments.lean:22` controls the reflected profiles uniformly before choosing the state or frequencies. It yields a factor `(1+|t|)^(2n)(1+||v||)^(2n)` with finite seminorm controls. The old GrowthAt degree disappears because the common height supplied to that premise is zero; the independent profile twists are explicitly paid by the new seminorm bound.

## Deleted lengths and the exact Nlong cost

Write M=state.width, Ns=Norm(product Dshort), Nl=Norm(product Dlong), and a_l=log_Z(Xlong/Nl). Both divisor norms lie in [1,Z^Bmask] by `ReferenceDivisors.lean:12`. Only the original scales are ordered: 0<Xshort<=Xlong. No proof here assumes their deleted versions remain ordered.

`ZeroReflectionSupport.lean:120` proves

    length(Z,Xshort/Ns) <= log_Z(Xlong)+log_Z(max(1,b)).

The second term pays for the clipped length at scales below one. Its proof uses the actual nonzero-support condition 1<=b*Xlong. On the live branch M-a_l+xi>=0, for x in the closed reflected window `[0,(M-a_l+xi)log Z]`, line 137 gives

    length(Z,exp x)+length(Z,Xshort/Ns)
      <= M+log_Z(Nl)+log_Z(max(1,b))+xi.

For sufficiently large Z the fixed endpoint defect obeys log_Z(max(1,b))<=defect. Consequently `ZeroGrowthMoments.lean:52` proves

    Z^(max(M,length(Z,exp x)+length(Z,Xshort/Ns))+loss)
      <= Nl * Z^(M+loss+defect+xi).

The Nl factor is retained. It is not canceled by log algebra at this step. Since M<=Mcap and log_Z(Nl)<=Bmask, the margin Mcap+Bmask+defect+xi<=L puts the reflected scale exp x within the original growth cap Z^L. The short deleted scale is also capped because Ns>=1. The distinct condition Mcap+Bmask+defect<=Lreflect supplies M<=Lreflect+a_l for the reflection approximation.

## Actual reflection and the two terms

I read `Moments/NaturalReflection` through its adapter to `primitive_deleted_reflection` and `normalizedGauss_norm`. It supplies an actual primitive character, a norm-one Gauss factor, the original-to-deleted coefficient identity, and the conductor-times-redundant-ideal bound. The primitive reflection and Gauss-norm producers remain lower foundations of this review.

`UniformReflectionApproximation` keeps the retained/discarded split of the actual polynomial, including summability of each smooth-ideal series. Its discarded bound is proportional to `(Y^B/sqrt(Y))/R^A`. Taking B=2 and choosing A with `(xi/2)A>=saving+(3/2)L` gives the arbitrary prescribed Z^(-saving) remainder under the displayed dual-scale cap. Constants and the finite source seminorm set are chosen before the character, profile and scales. The elementary source permits saving to be any real number; the later reserve supplies a genuinely positive choice.

`UniformOriginalEnergy` uses the norm-one factor only inside a norm and applies the squared triangle bound. It yields twice the retained energy plus a squared error with Rcap^(2epsilon) Z^(-2saving). `UniformOriginalComparison` calls that theorem with xi/2, so its retained cutoff is exactly Z^(xi/4), matching `UniformNaturalRetained`. The required source cap follows from M<=L+along. No reciprocal L-function or zero-free premise is inserted into this comparison.

The retained-profile transfer preserves the inverse-character convention. `UniformReflectionProfile.inverse_annular_frequency` uses a real annular log window to convert the inverse-character polynomial at +2pi*v into the conjugate of the original-character polynomial at -2pi*v. This is a norm comparison, not an equality of the two character polynomials without conjugation. Its common density envelope is produced at order J+2, so it pays the child growth `(1+||v||)^(2J)`.

`ReflectedProfileMeasure.lean:49,106,177` supplies the intervening integral argument. The normalized density divides only by strictly positive reference weights; actual density integrability is supplied before the finite energy inequality. Finite annular separation proves each density-times-phase term integrable before interchanging the finite sum and integral. The plain annular version reduces to a finite ideal carrier using the compact logarithmic support. These are actual carrier and integrability checks, not an assumed unrestricted exchange of a prime series with an integral.

`UniformReflectionScale` charges both logarithmic scale intervals by `(1+2*(hi-lo))(1+2*(high-low))`. The short interval in the selected application is a singleton, leaving only the first factor. `UniformReflectionChoices` obtains a bound for every rowwise choice. `ReflectionWeightedEnergy` has an explicit base index, bounds each row supremum from this all-selection premise, proves absolute weighted summability, and then bounds the sum of row suprema by E using finite approximate choices. There is no measurable-choice assumption or informal interchange of an infinite supremum and an integral. `RetainedWeightedSource` uses that summability before reindexing its signed series.

`UniformRadialComparison` extends the finite-row result using nonnegative radial weights. It proves summability of the short energy and each pair child before comparing finite sums to tsums. Its constants do not depend on the finite row subset. `ReferenceHomogeneous` handles a zero source seminorm separately; otherwise it supplies a strictly positive source bound. Its profile normalization therefore does not divide by zero.

It follows that `ZeroGrowthReflection.lean:20` has two genuinely different contributions: a main reflected-child term with Rcap^epsilon and the logarithmic window length, and an error term with Rcap^(2epsilon) Z^(-2saving) times the short energy. `ZeroGrowthBounded.lean:21` caps the window by L and the short mass by a fixed seminorm factor times diagonalControl*max(1,scale)*Z^L. It retains the factor Nl in the main child bound.

## Weighted deletion, dead branch and complete original energy

`ReferenceDeletionEnergy.lean:20` accepts child energy `E*Nl^p` for p<=1. Finite weighted Minkowski introduces `Nl^(p/2)` into the coefficient mass. At p=1 this exactly offsets the long divisor's inverse-square-root coefficient. The remaining subset multiplicity does not disappear: `ReferenceDeletionBudget.lean:27,118` pays powerset-cardinality squared and slot factors by a radical subpower bound. The call at epsilon/2 followed by the outer square leaves radical^epsilon. Child radial summability is proved before the infinite-row comparison.

`ZeroGrowthOriginal.lean:52` splits every finite deletion choice at M-a_l+xi>=0. Equality belongs to the live branch. The strict complement M+xi<a_l invokes `ZeroRetainedError`: the retained reflected source is empty, but the original polynomial is bounded by its approximation error. The short deleted scale is at most Z^L. Both branches therefore satisfy a common child estimate `E*(Pmain+Perror)*Nl`, since Nl>=1 and all factors are nonnegative. Weighted deletion consumes it with p=1.

The original two scales are ordered by an exact profile swap. If the energy is nonzero, a nonzero row supplies the support condition needed above; if it is zero, the nonnegative bound is immediate. Thus this is exhaustive, including scales below one. The final estimate retains

    Pmain = Rcap^epsilon * (1+2L log Z) * Z^(M+loss+defect+xi),
    Perror = Rcap^(2epsilon) * Z^(-2saving) * max(1,scale) * Z^L,
    Rcap = max(1, fixedConductorFactor*bPhi*Z^M).

It also retains the external puncture radical^epsilon, K+1, radial/profile controls and the height power. Neither the error nor the conductor cap is a disposable constant uniform over states. The output constants and eventual threshold precede the variable Bmask,L,Mcap,loss,Q,degree,K, subject to the two explicit room conditions and the fixed reflection length.

## Bounded reserve and remaining boundary

`ZeroGrowthContourBounded.lean:31,64` chooses

    d = min(1, epsilon/[8(Bmask+Mcap+4)]),
    L = max(Loriginal,Mcap+Bmask+2d)+1,
    saving = L+Bmask*d+2*Mcap*d+1.

The main exponent charge is `d*(Bmask+Mcap+4)<=epsilon/8`; the error charge simplifies to `-L-Bmask*d-2*Mcap*d-2<0`. `ReferenceScalarBounds.log_interval` pays the logarithm by `(1+2L/d)Z^d`, and the radial scale is bounded by Z^M. With incoming loss ell>=0, `ledger_loss_mono` pays both contributions by an additional Z^ell. Hence the conclusion is ZeroAt with loss ell+epsilon and scales capped by Loriginal, conditional on GrowthAt at the enlarged but explicitly bounded L. It is not a construction of GrowthAt and does not prove the physical recovery producer or the outer induction schedule.

Lower inputs retained: primitive reflection/functional equation and normalized Gauss magnitude, natural primitive/conductor descent, reflected annular/Fourier-Euler and coupled log-separation estimates, the supplied growth bound, and the existing ideal/radial/finite-deletion foundations. The numerical Goldbach targets and their final hypotheses are not altered by this local source implication.

## Frozen evidence and precise scope

The read-only byte checker `check_zero_growth_recovery_source_20261111.py`, SHA256 `97EDD1F0D57B6133FDBFD152BA9215EDBB7294EB872641F74B3AF721039C5DFA`, reconciled all 31 source pins and seven prior-scope pins in the author report. Its receipt `check_zero_growth_recovery_source_20261111.json` has SHA256 `D909BF0F552CD06F1F086F49701491231E0C6998D72909B684F3364618513C77`. Both are in this review's directory. This check establishes byte identity only; the preceding mathematical reconstruction is separate.

Five additional independently read files are pinned in that receipt:

| Source | SHA256 |
|---|---|
| `Energy/ZeroReferenceChild.lean` | `99F4578EAE4F8F197BA833F1E60FB20AA7BB7E1D236991EFD156FFAB9BE9C0AD` |
| `Energy/ReferenceLowChild.lean` | `039F42D462FC365F92CFA479F0F9F733DA03587DF6E637BE48897CA556B26026` |
| `Energy/ReferenceState.lean` | `B36CB63E659FAB4957581C6CE5D3184012F1A836D2CF099358BC527B9C765688` |
| `Energy/ReferenceDivisors.lean` | `FB222C730642403B00184D065A60A9BC993784AFC0029206DF61565C5E9A55B0` |
| `Energy/ReferenceProfileBudget.lean` | `636D88C9F544C4833A66852824024734D2590829F692D2077A178EB8D9DB0686` |

Names such as `primitive_deleted_reflection`, the normalized Gauss magnitude producer, `paired_rowwise_scales`, and coupled separation identify lower inputs, not newly reconstructed producer bodies. The pinned immediate adapters and profile/scale consumers are the covered implication. High-band recovery, the outer induction schedule, and the actual producer of GrowthAt are outside this review.
