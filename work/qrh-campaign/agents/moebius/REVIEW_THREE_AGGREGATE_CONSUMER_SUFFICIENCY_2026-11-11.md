# Independent review of the three aggregate consumer targets

2026-11-11. **PASS as a conditional source-mathematics sufficiency map. No required correction.**

Author: `audit/THREE_AGGREGATE_CONSUMER_SUFFICIENCY_AUDIT_2026-11-11.md`, SHA256 `78119012C8BA40AFC93AB523B84DD441CD19D3FBC76F12418C41DD081B3C9F28`. All32 linked source/report pins were independently checked. Receipt: `moebius/review_three_aggregate_source_pins_20261111.json`, SHA256 `1F2D7E3CEA04C5E19B15A96212E9414673CC85029A9D116CCE888050FEF78ADB`.

The inspected consumer bodies support sufficiency of the three exact targets, together with principal RH through closed height1e8 and the retained analytic/finite inputs. I found no fourth nonprincipal estimate in these paths. This is not an elaborated dependency closure or kernel result. The targets are unproved, the source still has broad Fact PlattGRH binders, and the natural-R and principal-only refactors remain to be implemented. No build, axiom audit, analytic evaluation or source modification occurred.

## Exact target interpretation

The plus target is an energy over all nonprincipal ambient characters with actual coprime coefficients, inverse labels and Gauss weights, normalized as1/(phi(q)*x^2). Parseval makes it a sum, not an average, over unit numerators. The author preserves this distinction. Orthogonality of its residual to the constant principal vector permits addition of principal squared error before the outer removal's Minkowski step. The resulting bound fits rho=8.85e-7; it does not establish the older, smaller nonprincipal Cn.

The star target must be the full mixed moment

    Wstar=integral_D |Sp|^2 |Ss-As|^2,

on the finite tagged arc space, with y=x/49 in As. A moment of only nonprincipal character terms would not satisfy this definition. The principal error and removal terms would then still need to be added with their cross terms. The reviewed audit expressly requires full Wstar, so it does not conceal that obligation.

The base-gap target is pointwise in every allowed signed twist and every y>=1e25, and is attached to the original modulus m. The reduced denominator m/gcd(m,2) is used for geometry, not substituted into the character expansion. The principal/removal terms are retained even at m=1,2 where the nonprincipal energy vanishes.

## Major cubic and upper energy

I read the integrated cubic contract and the upper-L2 supplement, then compared them with `MajorTotal.lean:974-1025`. The source sums the per-modulus cubic errors, uses the major energy upper bound8.79x, and separately supplies Fourier-tail and main-term/singular-series terms. The replacement can operate on the tagged sum because the exact algebra is

    Sp^2 Ss-Ap^2 As=Sp^2(Ss-As)+As(Sp-Ap)(Sp+Ap).

Cauchy--Schwarz and L2 Minkowski yield the stated square-root moment expression. The positive square identity in the contract bounds it by the original cubic allowance; the Fourier tail is additional and unchanged. This does not replace the physical arc partition, periodicity, integrability, main term or singular series.

For upper energy, integrating the already-summed residual over an interval of length16R/(qt(q)*x) gives16R*rho^2*x times sum1/qt(q), with no extra phi(q). The odd/even decomposition bounds that reciprocal sum by H_R<=19. Combining Z<.006^2*x and Y<2.951^2*x gives X<2.957^2*x<8.79*x. Thus this new argument really bypasses the old upper-J Cn requirement. Its geometric generality does not extend the unproved residual hypothesis beyond its declared R132900 domain.

## Lower J: the hidden-dependency check

`ArcChars.lean:192-234` splits the exact Parseval identity into its principal term and a nonnegative sum R. The proof of its lower projection uses only R>=0 and phi(q)>0. The nonprincipal hE hypothesis is used to bound R for the upper projection. Accordingly the current conjunction cannot merely be called without hE; its lower proof must be extracted.

I also read `ArcChars.lean:445-469` and `Thm714.lean:572-587`. The required principal approximation is obtained at modulus1, with |delta|<=600000 and principal GRHUpTo1e8, followed by the coprime removal. No odd/even nonprincipal sibling theorem is needed for that extracted result.

In `L2Major.lean:145-224`, A0lo contains Cp and Cb, while Cn appears only in A0hi. The lower branch explicitly uses hlo and the principal approximation. The interval inequalities needed to repeat it at smaller R are preserved: w*x>=4, 2w<=1200000/x and q<=300000. The summed lower expression at325-328 yields the stated (.63907-.000962)M_R-.00108. It is a newly assembled bound using the reduced mass, not a restriction of the old lower bound on a larger domain.

`MinorTotal.I0_ge:277-310` then uses only lower J, the nonprime coefficient energy and t=1e-5. Solving its upper comparison of J with I and E gives precisely

    I/x >=(J/x-100001*8e-11)/1.00001.

The source mass script contains this expression at its `evaluate_cutoff` entry. No new nonprincipal lower-energy target is required.

## Base gap and all higher levels

`BaseGap2.gap_point:185-227` proves stronger parity-specific bounds inside its odd/even branches before weakening the returned statement. A new natural-R witness must retain those branch facts. The audit correctly requires that adapter; the old theorem's weakened conclusion alone does not supply the sharp parity ranges. `S_etaStar_eq_expTsum:229` uses y=x/49 without a further scale factor.

The aggregate character Cauchy--Schwarz step pays the dimension and gives at most sqrt(E_U,m). With retained principal, removal and Fourier-main estimates, the resulting bound is.029546004*y. `MinorTotal:395-403` consumes an upper envelope y*ghatY(y,R), not the earlier.014 sufficient guard. Since the reviewed lower ghat envelope exceeds.03, this weaker target suffices for that actual consumer. It does not prove the old.014 assertion.

For higher levels, I read `LinftyLevels.norm_S_etaStar_le_ghat:358` and its convolution proof, and `MinorTotal:406` onward. Their n and w parameters are not bounded by R; their rational approximations can involve arbitrarily large arithmetic moduli as the scale grows. The inspected `GBound.norm_S_eta2_le_gx` uses the Type I/II producer and `MertensProduct.div_totient_lt`. That totient theorem is global in q and r. Its E1 input at `MertensProduct:545` invokes principal `rh_upto_1e8`, not RH at that arithmetic q. Restricting these domains to the finite spectral conductor range would be invalid; the author explicitly rejects this shortcut.

The other retained source inputs were checked at their consumer boundaries: `Prop715:365` uses modulus1 and height500; `EBound.E_partial/E_le_14_28` use Chebyshev/nonprime estimates; `LambdaMu` identifies its psi/theta and finite-table producers; `Explicit/ZetaZeroSums:29` obtains RHBelow1e8 from the principal instance. These scalar/finite descendants are retained rather than newly reproved by the aggregate estimates. The targeted accessor search supports the body trace but is not treated as a semantic axiom-closure proof.

## Final target and residual work

`Helfgott.Inputs`, `Helfgott.Main` and `MainTheorems` still use the old separate major/minor constants and broad Fact. The R132900 route instead needs the reviewed joint mass/singular-series/nine-cell/asymptotic budget, with the original nonprime subtraction and xOf(N) relation. The aggregate cubic comparison spends no extra part of that joint reserve. Neither the old1.0376 minor bound nor an unconditional completed Lean root follows from this audit.

The lower research threshold989*10^24 is below1e27, so restricting a completed large-N result preserves the requested endpoint. The small-case branch continues to require the original inclusive BinaryGoldbachInput through4e18 and its existing finite coverage; proposed cheaper binary/ladder alternatives are not imported. The large branch has no binary hypothesis. A final result must discharge the three targets and principal RH certificate internally, rather than exposing them as new final premises.

Accepted scope: the stated three targets form a sufficient source-level replacement boundary for the inspected nonprincipal uses. Unresolved: their quantitative proofs, principal finite certificate, retained finite inputs, all localized/natural-cutoff implementations, and final compatible kernel validation. No cost saving or truth of an aggregate target is inferred from consumer sufficiency.
