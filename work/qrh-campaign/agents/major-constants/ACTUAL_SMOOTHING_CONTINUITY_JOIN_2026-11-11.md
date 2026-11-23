# Actual smoothing continuity and admissibility join

2026-11-11. Source-supported paper derivation, not Lean declarations or a compiled result. No numerical function evaluation, zero scan, build, or frozen-file edit was made. This supplies the actual moment and continuity adapter requested in `zero-sum/ZERO_SUM_SOURCE_JOIN_2026-11-11.md`, SHA256 `600F627B397F7A8E83AE20578D8BA7A7C5EBEC536578EA5EC41D1E3AAC25ABDA`. It also gives a qualitative full-strip admissibility construction for etaU. It does not change any selected numerical high-zero or Gram constant.

Source paths below are relative to `work/ternary-goldbach/TernaryGoldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Mathlib was read from the existing cache at commit `56a005855ea17e0b0958f73ec801ae140b0a1679`. The new lemmas described here are proof targets in prose, not approved Lean statements.

## 1. The actual functions and unconditional bounds

The definitions are `Helfgott/Defs.lean:42,45,49` and `MinorArcs/EtaU.lean:24`:

    etaPlus(t) = hH(200,t) t exp(-t^2/2),
    phi(t) = t^2 exp(-t^2/2),
    etaU(t) = integral_(w>0) eta2(t/w) phi(w) dw/w.

Here eta2 is the nonnegative logarithmic tent supported on [1/4,1], with integral 1. The existing facts are `Helfgott/Decay.lean:55,58,66` (nonnegative, <=3, zero outside the open support), `Helfgott/Eta2.lean:48,92` (absolute integral 1 and continuity), and `MinorArcs/BaseGap2.lean:23` (the swapped Mellin-convolution identity for positive t). The bounds used throughout are

    |etaPlus(t)| <= (63/20) t exp(-t^2/2),
    |etaU(t)| <= 144 t^2 exp(-t^2/2),                  t>0.       (1)

The first is `MajorArcs/HHFourier.abs_etaPlus_le_gauss:570`, equivalently `Explicit/EtaPlusMellin.norm_fP_le:65`; the second is `MinorArcs/BaseGap2.abs_etaU_le_gauss:29`, whose proof calls the unconditional `Helfgott/Decay.abs_mellinConv_eta2_phi_le`. These declarations have no PlattGRH premise. Their enclosing files contain other conditional results; none is used here.

Both functions vanish on t<=0. The etaU assertion follows directly from eta2(t/w)=0 for w>0. The etaPlus assertion is already used by `HHFourier.etaPlus_eq_indicator:550`. `HHFourier.measurable_etaPlus:560` and `MajorArcs/MajorTotal.measurable_etaU:437` are existing unconditional measurability proofs. Thus no integrability argument below relies on a totalized integral accidentally being zero.

Continuity also has a direct route. For etaPlus on t>0, `EtaPlusMellin.continuousAt_hHc:44`, `hH_eq_hHc:30`, and `continuousAt_fP:77` give the actual function's continuity. At zero (1) tends to zero; on the negative half-line the function is zero. For etaU, for every w>0 the function t -> eta2(t/w)phi(w)/w is continuous and its absolute value is bounded, for every real t, by

    3 w exp(-w^2/2).

This is integrable on w>0, so dominated convergence gives continuity on all real t, including zero. This argument is stronger than merely inferring almost-everywhere measurability of a parameter integral.

## 2. One explicit bound for every finite absolute moment

Write (C,d)=(63/20,1) for etaPlus and (144,2) for etaU. For real sigma and nonnegative integers r,m define the nonnegative absolute moment

    I_eta(sigma;r,m) = integral_(t>0) |eta(t)| t^(sigma+r-1) |log t|^m dt.

It is finite whenever sigma+d+r>0. In particular all r,m>=0 are allowed simultaneously for sigma>-d. This is an absolute-integrability statement before any complex Mellin integral is taken.

Here is a uniform majorant that also handles complex twists. Fix real a<=b, D>=0, and integers r,m>=0 with q=a+d+r>0. Restrict a<=Re(s)<=b and |Im(delta)|<=D. Set k to any nonnegative integer with

    2k >= max(0,b+d+r-1)+m.

For t>0, the absolute value of

    eta(t) t^(s-1) t^r (log t)^m exp(2*pi*i*delta*t)

is bounded by the following nonnegative function B(t), independent of s and delta:

    0<t<=1: C exp(2*pi*D) m! (2/q)^m t^(q/2-1),
    t>=1:   C exp(4*pi^2*D^2) 8^k k! exp(-t^2/8).       (2)

Either choice at t=1 is harmless. To verify the first bound, put u=-log t>=0 and use (qu/2)^m/m!<=exp(qu/2); also t^(Re(s)+d+r-1)<=t^(q-1). For the second, use |log t|^m<=t^m, t^(Re(s)+d+r-1)<=t^max(0,b+d+r-1),

    -t^2/2+2*pi*D*t <= -t^2/4+4*pi^2*D^2,
    t^(2k) <= 8^k k! exp(t^2/8).

Every direction remains valid when m=0, r=0, k=0 or D=0. The first piece is integrable because q/2>0. The second is integrable; even exp(-t^2/8)<=exp(-t/8) for t>=1 suffices. An explicit, deliberately loose upper bound for its total integral is

    C exp(2*pi*D) 2^(m+1)m!/q^(m+1)
      + C exp(4*pi^2*D^2) 8^(k+1)k!.                    (3)

This avoids a logarithmic moment substitution theorem: only a power integral near zero, an exponential integral at infinity, and the nonnegative exponential series inequality are needed. It retains the true infinite Gaussian tail.

For real delta, D=0 and the bound is uniform over every real twist, with no restriction on its size or on Im(s). The low-zero range [1/8,7/8], its finite subrange [89/200,111/200], and the principal exponent s=1 all lie strictly inside both moment half-planes. The possible trivial zero s=0 is inside too. The closed contour strip [-1/2,3/2] also lies inside both half-planes. No moment claim is made at the limiting endpoint Re(s)=-1 for etaPlus or -2 for etaU.

## 3. Mellin normalization, parameter continuity and derivatives

Use the actual source convention

    f_eta(delta,t) = eta(t) exp(2*pi*i*delta*t),
    M_eta(s,delta) = integral_(t>0) t^(s-1) f_eta(delta,t) dt.   (4)

Positive real t uses t^(s-1)=exp((s-1)log t), so its norm is t^(Re(s)-1). This is `Mathlib/Analysis/MellinTransform.lean:45,91` with scalar multiplication specialized to complex multiplication. For etaPlus it is exactly `Explicit/EtaPlusMellin.fP:59`; no conjugation or sign reversal is inserted.

For every fixed t>0 the integrand is continuous in (s,delta). The eta factor is a measurable fixed coefficient. On a neighborhood of any point with Re(s)>-d, choose a,b,D with a>-d. Bound (2), with r=m=0, and dominated convergence prove joint continuity on

    {(s,delta) in C x C : Re(s)>-d}.

In particular it is jointly continuous for the real twists actually used. This is continuity of the actual convergent Mellin integral, not a formula valid only after analytic continuation. The same argument for arbitrary r,m makes all the corresponding integral moments jointly continuous. `ParametricIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le` then proves, one parameter at a time,

    partial_s^m partial_delta^r M_eta(s,delta)
      = (2*pi*i)^r integral_(t>0) eta(t)t^(s+r-1)(log t)^m
                                      exp(2*pi*i*delta*t) dt. (5)

On each small parameter neighborhood, the next m or r bound in (2) supplies the derivative majorant. Thus each variable is holomorphic on the stated domain; no multivariable Hartogs theorem is needed for the continuity adapter or GoodSmoothing. Formula (5) states ordinary derivatives; normalized Taylor coefficients would additionally divide by m!r!.

At s=1, (4) is the ordinary Fourier main term `fourier(eta)(-delta)` for real delta, with the source's e(+delta*t) convention. Both functions vanish on t<=0, so extending the integral to all real t introduces no term. This verifies the principal pole subtraction used in the zero-sum source join. At fixed positive physical scale z, multiplying by z^(rho-1), the finite analytic-order multiplicity and the minus sign preserves continuity. The same holds jointly in z>0 by exp((rho-1)log z). This does not assert that any infinite zero sum converges or is continuous.

## 4. A qualitative full GoodSmoothing construction for etaU

`Explicit/ExplicitFormula.lean:51` requires five facts: continuity on t>0; MellinConvergent at 3/2; Mellin differentiability on Re(s)>-1; positive exponential rate; and an exponential Mellin bound on the **whole closed strip** -1/2<=Re(s)<=3/2. Sections 1-3 give the first three facts for etaU and recover them for etaPlus. Moments alone do not give the fifth fact.

There is nevertheless a direct unconditional full-strip source route for etaU. Swapping the source Mellin convolution and substituting t=rv gives, for Re(s)>-2 and real delta,

    M_U(s,delta) = integral_(1/4<=r<=1)
                    eta2(r) r^(s-1) Gr(s,delta*r,0) dr.       (6)

`Gr` here is the Mellin transform of phi(v)exp(2*pi*i*delta*r*v), exactly `Explicit/GMellin.fdelta` and `mellin_fdelta`. The factor is r^(s-1), not r^s: the original convolution has dr/r and the substitution dt=r dv. Absolute Fubini is justified before swapping: eta2 is bounded and supported away from zero, and the inner norm has Gaussian moment integral v^(Re(s)+1)exp(-v^2/2), finite precisely for Re(s)>-2. The complex-power scaling identity uses r,v>0. Closed versus open endpoints of [1/4,1] do not affect the integral.

The existing unconditional `Explicit/GMellin.norm_G_le_strip:86` covers the full required strip and gives

    |Gr(s,delta*r,0)| <= Kdelta(delta*r) exp(-.28|Im(s)|),
    Kdelta(d) = integral_(v>0) (v^(1/2)+v^(5/2))
       exp(-cos(.56)*v^2/2 + 2*pi*|d|*|sin(.28)|*v) dv.

This positive integral is finite by the quadratic-Gaussian integrability proved in that source; cos(.56)/2>0 is `cos_056_pos`. For r in [1/4,1], pointwise comparison of these integrands gives Kdelta(delta*r)<=Kdelta(delta). Also |r^(s-1)|<=8 throughout the closed strip, and integral eta2=1. Consequently

    |M_U(s,delta)| <= 8 Kdelta(delta) exp(-.28|Im(s)|).        (7)

Together (1)-(7) prove the paper target GoodSmoothing(f_U(delta),8*Kdelta(delta),.28). This requires implementing the mixture identity and integral comparisons, but no new spectral premise. For etaPlus `EtaPlusMellin.goodSmoothing_fP:268` is already an existing source theorem; its particular numerical proof is not modified here.

The earlier `integration/RESUME_BASE_GAP_INTERFACE_LEDGER_2026-11-11.md` already proposes the stronger qualitative constant 3*Kdelta(delta). Equation (7) is only a simpler support-based option, not a correction of that proposal. After the same absolute-integrability proof, `MajorArcs/Eta2Moments.moment_3half:176` bounds the integral of eta2(r)/(r*sqrt(r)) by 2.74517. Since r^(Re(s)-1)<=r^(-3/2) on this strip and support, it gives the earlier 3*Kdelta(delta) as well. The new work here is the complete moment, Fubini, parameter-continuity and differentiability join, not discovery of a new numerical admissibility constant.

Equation (7) is a qualitative admissibility bound. Kdelta can be very large. It is **not** the selected 900 vertical-line constant, a replacement for the selected high-zero envelope, or an improved major-arc numerical estimate. Its purpose is to discharge the full-strip hypothesis of the source explicit-formula limit. Those numerical bounds remain separate inputs.

## 5. Actual residuals and the finite low-zero sum

For a fixed positive scale, `Helfgott/Decay.summable_etaPlus:247` and `summable_etaStar:251` supply absolute summability of the actual von Mangoldt coefficients. `MajorArcs/ArcChars.summable_cP:30` merely restates the plus result. For etaU use `MinorArcs/EtaU.etaStar_eq_etaU:26` with etaStar scale 49z: for n>0,

    etaStar(n/(49z)) = etaU(n/z).

The n=0 summand is zero because Lambda(0)=0; no use of the positive-argument lemma at zero is needed. Multiplying by a Dirichlet-character value or a coprimality indicator preserves the summable bound, since their norms are at most one. Every additive-twist summand is continuous and the summable bound is independent of that real twist. Hence the actual character sum is continuous by `continuous_tsum`, or the existing `CircleMethod.continuous_expTsum:305` after defining the fixed coefficients. This uses no base-gap estimate or Platt-dependent arc theorem.

Subtracting the continuous principal term from section 3 and dividing by the fixed positive scale proves continuity of the actual residual R(delta). The low-zero sum p(delta) is finite with fixed actual orders, so section 3 proves its continuity directly. Composition with delta/49 in the star channel remains continuous. Thus R-p is Borel measurable and supplies exactly the input needed by the accepted measurable radial truncation construction. No measurable selection of good heights, limit under an arc integral or infinite zero-series rearrangement is needed.

## 6. Source/API implementation order

The following are actual APIs inspected in the pinned Mathlib cache, not inferred names:

* `MeasureTheory/Integral/Bochner/Basic.lean:447,458,468,476`: `continuousWithinAt_of_dominated`, `continuousAt_of_dominated`, `continuousOn_of_dominated`, `continuous_of_dominated`. They require eventual or pointwise AEStronglyMeasurable sections, an integrable majorant, an almost-everywhere bound and pointwise parameter continuity. Apply with measure `volume.restrict (Ioi 0)` and parameter space C x C, which is first countable.
* `Analysis/Calculus/ParametricIntegral.lean:284`: `hasDerivAt_integral_of_dominated_loc_of_deriv_le`. Its conclusion includes integrability of the derivative and HasDerivAt of the integral. It requires a genuine neighborhood, measurable derivative at the center, uniform derivative bound on that neighborhood and pointwise HasDerivAt. Section 2 supplies these bounds for each next derivative.
* `Analysis/MellinTransform.lean:45,91,319`: `MellinConvergent`, `mellin`, and `mellin_hasDerivAt_of_isBigO_rpow`. The last is an alternative route for a fixed twist, with a log-weighted Mellin derivative. `EtaPlusMellin.lean:111,116` already proves differentiability and convergence for etaPlus on Re>-1 using the exponential-decay variant.
* `Analysis/SpecialFunctions/Integrals/Basic.lean:147,236`: the power and exponential integral formulas; the near-zero power is greater than -1. `Real.pow_div_factorial_le_exp` supplies the two moment absorptions. The existing Gaussian integrability in `HHFourier.integrable_etaPlus:578` is another route for the large-t piece.
* `Analysis/Normed/Group/FunctionSeries.lean:115,124`: `continuousOn_tsum` and `continuous_tsum` from a summable norm bound.

Suggested new proof order is: positive-ray envelopes and etaU continuity; the elementary majorant (2) and its integrability; joint Mellin continuity and derivative induction; etaU absolute-Fubini mixture (6) and qualitative full-strip (7); fixed-scale coefficient summability and actual residual continuity. The local etaU lemmas should live near its definition, not import MajorTotal into Explicit and create a cycle. The proof of `MajorTotal.measurable_etaU` can be copied downward or replaced by the continuity argument. Nothing requires making an entire imported file unconditional.

## Pins and remaining work

| Source | SHA256 |
| --- | --- |
| Explicit/GMellin.lean | B35DEB66E13608081839069DDCF4368E6FF6CF680D2B04B8F7871662399EAABB |
| Explicit/EtaPlusMellin.lean | BA9CD4DFA03A6CB36482C52EB135C81D8BA3AD117510A96AF308B2D4FE8DD2BC |
| MinorArcs/EtaU.lean | 4D940B228064E1C311D46B7F64C50EE2A7C3BFB0865AB7355790311384F88798 |
| MajorArcs/HHFourier.lean | C2672D93F08DD59A8FB1D8B474BD5393F1B8823938F4D7ACF39FB9AC97CFF665 |
| MajorArcs/MajorTotal.lean | 106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A |
| Helfgott/Decay.lean | 55764C16ACFB4CD3C94C23F581AA77EDC3B774C6A87ED384C67FC553D6288D8A |
| Helfgott/Eta2.lean | A2FF833091A7D65D1E02BD24284CCE8C9FCBF6032BD52715CB4DCB055BD850FE |

The paper derivation uses only the actual unconditional smoothing facts listed here. Its new integral/continuity wrappers are not implemented. It neither certifies the finite zeros nor discharges the sharp Mellin/Gram constants or the numerical major-arc inequalities. Independent review is requested before treating this join as accepted paper mathematics.
