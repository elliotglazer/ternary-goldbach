# Whole-product pair separation: consumer audit

2026-11-11. Bounded source and paper review, with no build, declaration, analytic evaluation, or frozen-file edit.

## Verdict and relation to earlier work

PASS for the consumer join in `Moments/Smooth.lean:13–138`, relative to the already accepted radial-envelope audit. No new analytic estimate remains in this span. The root weights and phase signs match the actual whole kernel, one density serves all finite row/column data at a fixed positive scale, and finite sums pass through the integral with explicit integrability proofs.

This advances the boundary identified in the frozen positive-band report. That report's recommendation to audit `whole_product_pair_separation` was made before reconciling the accepted radial-envelope packet. The earlier report is preserved; this note supplies the reconciliation, not a second claim of new progress on the same radial analysis.

The reused evidence is `zero-sum/QRH_RADIAL_FOURIER_ENVELOPE_AUDIT_2026-11-11.md`, SHA256 `EE7C7B00310ED151CAD460CE31D36A725E128681201B5959D607691DD8FD1D3D`, and `major-constants/REVIEW_QRH_RADIAL_FOURIER_ENVELOPE_AUDIT_2026-11-11.md`, SHA256 `7D1C5EB031F3F26F0952786F85F367CCA1BA138F69747F11D0CB28ABF526CEAD`. Both complete reports were read. Their accepted consolidation is `work/qrh-blueprint/QRH_QUADRATIC_RETAINED_RESIDUE_RADIAL_FRONTIER_2026-11-11.md`, SHA256 `4C33F3D113D174FDB449DB67A8228CD6D29496D6B2AC85886C52B7FFB6ED971F`.

Those reports already reconstruct the actual radial normalization, positive-scale Euler derivative bounds, compact logarithmic cutoff, finite-seminorm control, weighted Fourier estimates and inversion. Their library-foundation and source-version limitations remain unchanged. The present note does not claim global QRH or a compatible elaboration/axiom check.

## Exact target and density construction being reused

Write `F=paperRadialFourier W`, where `W` is a fixed Schwartz function. The target fixes four arbitrary complex functions `V_i`, support widths `M_i ≥ 0`, and natural orders `A,J`, with

`V_i(y) ≠ 0 -> |y| ≤ M_i`.

It chooses `C ≥ 0` before every `R > 0`, and then a Schwartz density `b_R` before any finite index types, finite sets, coefficients, column positions, or row positions. It provides the exact finite-pair identity and both bounds

`(1+R)^A * integral (1+|t|)^J |b_R(t)| dt ≤ C`,

`(1+R)^A * (1+|t|)^J |b_R(t)| ≤ C`.

The weighted integrability assertion is separate and explicit. The density is complex; no positivity assertion about it is needed.

The actual call is `Smooth.whole_kernel_separation:31` to `QuadraticSieve/IdealQuotients.paperRadialFourier_log_separation_envelope:415`, which calls `LocalLogFourier.coupled_positive_log_separation_envelope:305`. The already reviewed construction uses a compact cutoff equal to one on the required logarithmic range, and

`g_R(s) = cutoff(s) * F(R*exp(s)),   b_R = Fourier(g_R)`.

For this four-coordinate specialization the logarithmic range is bounded by `T=M_0+M_1+M_2+M_3`; the construction uses `L=T+1` and `m=exp(-L)>0`. Its decay estimate retains the factor `m^(-A)`. Derivatives through `J+volume.integrablePower`, not merely through `J`, supply the weighted integral bound. These are inherited facts from the pinned audit, not new estimates established by the finite-pair algebra.

## Root weights and phase signs

The exact definitions at `Smooth:13–29` are

`rootWindow(V,u) = V(u)/sqrt(exp(u))`,

`wholeKernel = V_0(rho)*V_1(x)*rootWindow(V_2,u)*rootWindow(V_3,v)`
`              * F(R*exp(rho+x-u-v))`,

`rowPhase = [V_0(rho)*logPhase(t,rho)]*[V_1(x)*logPhase(t,x)]`,

`columnPhase(V,u,t) = rootWindow(V,u)*logPhase(t,-u)`.

Here `logPhase(t,s)=exp(2*pi*i*t*s)` has the inverse-Fourier sign. The proof applies the radial envelope with windows

`[V_0,V_1,rootWindow(V_2),rootWindow(V_3)]`

and slopes `[1,1,-1,-1]`. Their phase product is therefore exactly `exp(2*pi*i*t*(rho+x-u-v))`. No conjugation, missing `2*pi`, frequency substitution or Jacobian is involved. The finite-pair expression carries `c_i*conj(d_j)`. Its right factor remains `sum_j conj(d_j)*columnPhase(V_3,v_j,t)`; it is not silently replaced by the conjugate of a sum with the same unaltered phase.

The root denominator is a positive real number at every real argument because `exp(u)>0`. More importantly for this theorem's hypotheses, `V(u)=0` implies `rootWindow(V,u)=0`. Thus the root windows have the same support bounds. No differentiability, measurability, global boundedness, or nonnegative values of the four `V_i` are required. The window values are fixed scalar factors in the integration variable `t`.

The large/small size of the root weights is not discarded in a norm estimate: both sides retain those factors exactly. The density construction depends on the logarithmic box rather than on amplitudes of these windows. This is why no hidden factor from `exp(-u/2)` is needed in the density's weighted bound.

## Integrability and finite-pair equality

`Smooth.separated_integrable:61` proves that, for fixed `rho,x,u,v,c`, the norm of the integrand is exactly bounded by

`K*|b_R(t)|`,

where `K=|c|*|V_0(rho)|*|V_1(x)|*|rootWindow(V_2,u)|*|rootWindow(V_3,v)|`.

Every phase has norm one. Continuity in `t` follows from the phases and the Schwartz density, even if the original window functions are arbitrary. Schwartz integrability of `b_R` then gives genuine integrability; the proof does not exploit the convention for a nonintegrable totalized integral.

`finite_pair_separation:78` first applies the pointwise whole-kernel identity to every pair. It moves each constant coefficient inside the integral, passes the two finite sums through the integral using the preceding integrability lemma, and factors the resulting finite product. Empty finite sets and zero coefficients are included. There is no infinite coefficient series, infinite exchange, or assumption of absolute convergence in the column indices.

Finally `whole_product_pair_separation:117` retains the same `C`, `b_R`, weighted integrability, integral bound and pointwise bound from `whole_kernel_separation`. The finite-pair equality is universally quantified after that density has been chosen. No new loss or factor proportional to the number of pairs is introduced by this equality. Any later Cauchy–Schwarz estimate has its own hypotheses and is outside this note.

## Uniformity and excluded conclusions

For fixed `W,V,M,A,J`, the constant is uniform in positive `R`. At each such `R`, the same density handles every row value, both column coordinate lists, every finite pair of sets, and every pair of coefficient functions. This is enough for the finite-row consumer in the positive-band assembly.

The theorem does not assert one density for all `R`, a measurable selection `R -> b_R`, or uniformity over arbitrary unbounded families of Schwartz inputs, support widths or derivative orders. No later integration in `R` is justified by this statement alone. The reused audit's stronger shared-box construction can justify additional window uniformity where a consumer explicitly uses it; one must not infer that statement merely by exchanging quantifiers here.

`R=0` and negative `R` remain outside the theorem. The empty support, all-zero windows, vanishing coefficients, and `A=0` or `J=0` do not introduce a division by a slope, window value or seminorm. Positive physical scale must still be checked by each actual caller.

## Next distinct positive-band boundary

There is no additional unreviewed analytic producer hidden in `Smooth:13–138` after composing the accepted envelope. The next useful bounded investigation is the **live-allocation to common-energy estimate**, which is independent of this Fourier separation.

The precise entry is `Moments/FirstCommonSourcePowerBudget.common_energy_power_budget:17`, which consumes `FirstCommonSourceBudget.common_energy_from_live_children:73`. Its characteristic conclusion is

`Re(commonEnergy)/V ≤ C * NC^(eps-1) * E * product_i M_i^2`

when every live child has normalized energy at most `E*product_i Mchild_i^2`. In the power version, child volume is additionally bounded by `b^N*V/NC` before applying the nonnegative power exponents.

The source `FirstCommonSourceBudget:28–105` shows where the work lies: normalized common-energy allocation, the frozen-coefficient bound divided by raw reduction, positivity of actual child energy, and `allocated_control_mass`. The latter must pay the actual allocation cardinality and the weighted sum of child controls with only `NC^eps`, leaving the displayed `1/NC` gain. This cannot follow merely from the radial separation or from bounding each child separately. That exact mass/normalization mechanism is the proposed next audit; it is not validated here. The other independently stated positive-band obligations, including amplified child production and first-source remainder bounds, also remain as recorded in the frozen production audit.

## Source and evidence pins

Only the specified spans are audited. The full-file hashes below bind source versions without asserting full-file validation. Earlier evidence files were checked against their quoted hashes; no files in that packet were changed.

All eight source pins in the reused radial-envelope author report match current bytes. The prior positive-band report remains unchanged at SHA256 `295C51C596813AF877A02EA4B445FAF79CD853604A4F04B20A90E13D75C351A4`.

| Source relative to DirichletL | SHA256 | Scope |
|---|---|---|
| `Moments/Smooth.lean` | `2C1337F3B8F06D4221F45A81973D9793A59CE876CDDD36A9A443D08C115ED556` | 13–138 consumer body |
| `QuadraticSieve/IdealQuotients.lean` | `3961EF95BA392A9352CADD3A9EC9C3336081BDC468B89A14FB099D00FD64D499` | 305–436 inspected and covered by reused audit |
| `Moments/FirstCommonSourcePowerBudget.lean` | `F369306E785677A776C3BAF09EAE64B6D834141E294F504F690FE1054DC346D1` | 17 onward, next-boundary identification only |
| `Moments/FirstCommonSourceBudget.lean` | `C409066589A7187C223E1A60088B1E8BC4E6F0A8FFC444FD94DF45DF393E3A4C` | 28–105, next-boundary identification only |
