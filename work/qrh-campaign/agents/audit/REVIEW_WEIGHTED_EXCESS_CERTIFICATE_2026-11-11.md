# Independent review of the weighted spectral-excess proposal

2026-11-11. **PASS as a conditional paper implication and exact budget calculation. No correction is required.** The proposed replacement is weaker than demanding the uniform finite strip on every large conductor, at the level of admissible spectral information. It preserves the selected consumer budgets. It does not establish the new spectral condition, a production saving, a Lean theorem, or adoption into the selected strategy.

## Frozen packet and independent work

Paths below are relative to `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
| `major-constants/WEIGHTED_EXCESS_CERTIFICATE_2026-11-11.md` | `5039FA2BE3CD7062E99B75CC82F84F2B154E88714E19F140461FD954F8C67FF2` |
| `major-constants/weighted_excess_budget_20261111.py` | `CB1AE496E413B0D8C4AA16492BB618121FA30A90CED7E13B3386EC9C90E4D178` |
| `major-constants/weighted_excess_budget_20261111.json` | `D960FA57A3EB80B7B3E2025D35E4159960EB58EF2EDC59513BB30A2F5DE71DDB` |
| Independent `audit/review_weighted_excess_20261111.py` | `D590A1A204BCBAD9F164ED950A9D4EA9133BB6B27C06599981D265C080B89972` |
| Independent `audit/review_weighted_excess_20261111.json` | `47EE013AF013E5D406DB3D2BE5F79437E2A951FC86B137F87D2E15F9209CD6CC` |

I read the complete frozen derivation and script, inspected the inherited full-strip Gram and direct mixed bounds, and reread the actual Gauss support statement in `MinorArcs/Bombieri.lean:135` at target commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The independent script imports no author code and performs no analytic evaluations. It reconstructs every displayed new coefficient square and final budget, proves the endpoint power comparisons by integer arithmetic, and recomputes the conductor census by divisor inversion of a separately sieved totient rather than the author's prime-power primitive formula. It exited zero.

The new proposal retains the current `Hcert(c)=min(Hp_old(c),10^8/c)`, the active odd/multiple-of-four conductor set, all actual primitive characters, global seven-eighths QRH, and the additional principal condition. It changes only the finite `.555` requirement for `c>100000` to the stated positive K budget.

## Actual kernels, coefficients and uniformity in scale

The potentially fatal interpretation would have moved each zero's real part to `min(beta,b)` while continuing to use its old Mellin value or count. That is **not** the frozen construction. It keeps actual `rho=beta+i gamma`, the exact kernel `F_eta(rho,delta)`, and `exp(i gamma log z)` in both summands, and splits only the real amplitude:

`z^(beta-1)=z^(min(beta,b)-1)+Delta_z(beta)`.

This is an exact identity for positive real z. There is no omitted Mellin beta derivative or log(t) term. The resulting capped sum is not asserted to be a zero sum of another L-function. It is a finite linear combination of the original kernels, which is all the required estimates use.

The excess monotonicity is proved for the **difference**, not inferred by subtracting decreasing upper bounds. If beta>b, its derivative is nonpositive when

`log z >= log((1-b)/(1-beta))/(beta-b)`.

The right side is the mean of `1/(1-b-u)` on `[0,beta-b]`, at most `1/(1-beta)<=8`. Both endpoint scales have logarithm greater than 8. Hence each excess at a larger scale is bounded by its corresponding endpoint excess. Taking the maximum of the two normalized endpoint contributions in k(beta) controls plus and star with the same K. There is no claim that the normalized expression at arbitrary larger z itself decreases.

For the baseline, the actual pairwise kernel parameter remains `beta+beta'-1` in `[-3/4,3/4]`. The inherited Gram rows cover this entire range and arbitrary phases. Their count hypotheses refer to the unchanged actual ordinates and analytic multiplicities. Repeated roots remain repeated indices; no virtual spectrum, separation, simplicity, or new location-count hypothesis is introduced. The capped coefficient magnitude is at most `z^(b-1)`, sufficient for the inherited positive Gram and mixed estimates.

The stronger inherited direct-modulus bound `Cross_low<1e-9` is essential. It is explicitly established in `zero-sum/RESUME_FAMILY_MIXED_2026-11-11.md` section 2, with `Cmix<6.794e36` and the exact power check in its script at line 89. I independently repeated that power comparison. It applies here because it is a plus-L2 times star-L-infinity estimate for arbitrary coefficient phases and magnitudes, not a theorem requiring the actual beta values to be at most b. Together with the current `.000160001` remainder it yields the baseline norm below `.000192`. Using the older `.0005` low norm instead would not justify the new displayed budget.

## Multiplicities, partners and exact arithmetic weights

K sums **actual analytic multiplicities** over all primitive characters with `c>100000` through inclusive Hcert, including both signed ordinates and any real nontrivial zeros. No inverse/conjugate pair is discarded or counted with half weight. Character inversion permutes the complete primitive family; the estimates can therefore retain the source inverse-character convention. Reflection is still used to obtain the global two-sided strip, not to pretend that the capped combination satisfies a functional equation.

For an affected primitive conductor c, nonzero Gauss induction requires `q/c` squarefree and coprime to c. If c is odd, only q=c and q=2c can be active. If c is divisible by four, q=2c is unsupported and only q=c remains. Since c>100000, q>=3c exceeds the active range. Thus each affected character appears at most twice, all affected q exceed 100000, and `c/phi(q)<R=21/4`.

Consequently, for the note's Bq,

`max Bq<=RK^2`, `sum Bq<=2RK^2`, and `sum Bq^2<=2R^2K^4`.

These follow from nonnegative sums and `sum k_chi^2<=(sum k_chi)^2`; they require no ownership information beyond the actual conductor/character interpretation of K. Also `1/phi(q)^2<=R^2/C^2` on this support. This is arithmetic weighting after reconstruction, not a fictitious extra suppression of each primitive Mellin sum.

The diagonal full-line kernel bounds are 4 for plus and `49*18=882` for star. Applying Minkowski within each character yields the stated excess L2 bounds in terms of `k_chi^2`, without charging every exceptional zero a whole Jensen upper count. Pointwise bounds 3.95 and 13/8 then give the two L-infinity bounds. The star constant is valid for excess terms because beta>b and its affine Mellin upper bound decreases with beta.

## Every mixed term and the numerical reserve

Writing the full vectors as capped-low plus old remainder plus excess gives exactly five additional tensor terms beyond the old full baseline: excess-plus with low-star, excess-star with low-plus, excess-star with plus remainder, excess-plus with star remainder, and excess/excess. The table in section 5 accounts for all five. In each, one factor is integrated and the other bounded pointwise on the **same modulus**. The last uses `sum Bq^2`; it is genuinely a two-character product estimate, not an invalid deduction of fourth moments from second moments.

The uniform low Jp/Js bounds follow from the displayed count proxies, the exact Gauss identity `sum c*n(c)=phi(q)^2`, and `sum n(c)<=phi(q)`. The common-height plus-tail maximum plus its separate `2e-15` remainder is below h. The star remainder remains `2e-12`. Thus no old high tail, contour, zero-at-zero, or primitive-to-coprime term disappears when the new excess is added. The baseline mixed remainder itself still applies because its estimates use the same capped low positive envelopes.

My exact reconstruction gives:

| Quantity | New sufficient upper value at K=6 |
|---|---:|
| Aplus | `5.15554156441e-9` |
| Astar | `2.622259264e-7` |
| Cross | `6.76572091081920576e-7` |
| Astar+Cross | `9.38798017481920576e-7` |
| N | `0.044352360842400004` |

The exact remaining joint slack is `175030976844991/15625000000000000000000`, positive. The required combined cap is `9.5e-7`. **Astar exceeds the old optional `2.5e-7` allocation**; the note correctly does not retain that separate allocation. The selected consumer uses the combined cap, so the existing coprime-to-full transfer and major constant 1.0404 remain available. Principal Ep and lower-J inputs are unchanged because c=1 is retained uniformly.

## Base gap and other consumers

The pointwise base gap cannot be inferred from major averages. Section 6 supplies its own argument. For the actual etaU transform, `M(beta)=1.922-.6686 beta` bounds the modulus throughout the global strip. When beta<=b, `M(beta)y^beta` is increasing in beta at every relevant y, since `M(beta)log y-.6686>0`. When beta>b, the amplitude is capped and M decreases. Therefore the baseline retains the old `13/8*y^(b-1)` bound even for reflected partners with beta<.445. It does not incorrectly assume the old finite reflected strip for those partners.

The additive reconstruction weights the new excess by `sqrt(c)/phi(m)`. Since `phi(m)>=phi(c)` and c>C, this is below `R/sqrt(C)<R/316`. The same K bounds the lower base-gap cutoff by positivity and the already reviewed Hbase containment. The new full sufficient bound is exactly

`2365117277/52653500000 < .044919 < .04712`.

This covers all q>=4. For q=1,2,3 only conductors at most 6 occur, so their selected low-prefix/high-u joins are unaffected. The uniform finite assertion on c<=100000 also preserves c=1's intermediate psi estimate. The separate principal narrow strip/moment to one million is neither weakened nor derived by this proposal. The all-height global-QRH energy, EBound, prime/Mobius/totient replacements, off-arcs Type I/II and regionS branches retain their existing separate proof obligations.

The final major/minor/nonprime reserve remains `1.0404-1.0376-.00271=.00009`. None of this permits a new hypothesis in the large root `TernaryGoldbachFrom (10^27)` or in the full root beyond the original BinaryGoldbachInput. All inherited analytic and carrier formalizations remain open as before.

## Weaker information is not a measured production reduction

Uniform finite beta<=b implies K=0. The positive excess condition allows nonzero mass above b, including consistent conjugate/reflection configurations within the global strip. This establishes strict permissiveness as a condition on candidate spectral data. It does not assert an actual Dirichlet spectrum violating the old condition, or prove strict logical separation when every arithmetic fact about those L-functions is included.

The independent census agrees: the retained uniform side has 75,000 conductors and 1,847,865,075 primitive characters; the weighted side has 75,000 conductors and 3,695,775,113. These are not saved-evaluation counts. A conductor-product count can avoid attaching each zero to a character, but must still give complete positive upper bounds at the varying inclusive heights. Multiplicities of product zeros add; poles, unsafe quotient cancellation, or missing boundary roots cannot be ignored.

The proposed Stieltjes layer-cake formula is sound: k is continuous increasing with k(b)=0, so counting beta>t and integrating against dk recovers the finite weighted sum, with no atom ambiguity. The sum of the two endpoint derivative densities is a sufficient upper majorant, not an identity for dk. No such actual density estimate is provided.

Finally the author correctly limits its unchecked-row counterexample to the stated strip/window inequalities. Those permit enough right-edge multiplicity to make K>6; they cannot supply the desired budget merely by replacing every k with 1. This does not prove that global QRH plus all arithmetic structure is insufficient. It does explain why this proposal alone does not justify omitting a character row or establish a cheaper aggregate verifier.

The current uniform strategy remains unchanged. Before this alternative could replace it, K<=6 must be proved from complete actual spectral evidence or a new analytic density bound, its inherited source adapters must be formalized, and its exact combined-budget interface must be adopted explicitly. No such adoption, certificate, implementation, build or new axiom was made in this review.
