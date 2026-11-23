# The xi mass and actual minor-energy source join

Research and source review, 2026-11-11. No Lean declarations, builds, evaluator runs, numerical integrations, or frozen-file edits were made. Source paths below refer to `work/ternary-goldbach/TernaryGoldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Mathlib references use pin `56a005855ea17e0b0958f73ec801ae140b0a1679`.

The new translated-mass estimate alone does **not** give the energy packet's mass constant .07. At translation zero its upper bound is 101/40=2.525. The complete source-level route instead combines the old, independently checked finite `XiMass` certificate with the newly proved exact-order transport. That gives the required .07 finite mass on paper without RH, QRH, or a finite zero computation. The new digamma-series argument is unnecessary at this one evaluation point: the existing exact `Complex.digamma_one` already supplies its value.

With this mass join and the actual global 7/8 zero-free provider, the actual-square energy packet yields the stronger estimate

    sum'_n ||MinorArcs.a₁ x n||^2
       <= (.64621*log(x)-.021095)*x
       <  (.65*log(x)-.021095)*x
       <  .65*x*log(x),                                  (E)

for every real x>=4.9e26. This note supplies the source composition, an explicit Fourier-derivative projection argument, and boundary majorants for the integrations by parts. These are paper proofs and a formalization plan, not new kernel-checked theorems. Global QRH validation, the indicated new Lean lemmas, finite arithmetic replay in Lean, and changes to the minor numerical envelopes remain work.

## 1. Which mass input is now supplied

For any real U and S contained in the actual source `zerosRectD zetaF U`, the new [finite-order transport proof](../zero-sum/FINITE_MASS_ORDER_TRANSPORT_2026-11-11.md), SHA256 `C62CB504C15A02CB954C35F8F5DAB5B551C483014F6FEE1F957FF37C444C5E0D`, gives

    sum_(rho in S) (multRectD zetaF U rho : Real)
       * (2-Re(rho))/((2-Re(rho))^2+Im(rho)^2)
      <= Re(logDeriv xiF 2).                             (M)

This is its sigma=2, translation=0 specialization. It retains natural divisor multiplicities and uses the actual containing balls to identify their analytic orders. In particular it does not use `WeilBridge.multRectD_eq_mult` with an unsupported T>=1 assumption. The approximation theorem exports only T>0; square membership itself supplies the containing disk needed by `divB_eq_of_analyticOrderAt_eq`.

The proof treats any real strict-strip zero as an ordinary positive summand. It needs neither a low-height exclusion nor pairing of conjugate zeros. The source xiF values at 0 and 1 exclude those points; omitted terms have positive real kernel because every source nontrivial zero has real part in (0,1). The empty S is allowed. Taking S to be the whole finite rectangle proves exactly the mass interface used in `MINOR_ENERGY_QRH.md`, for every U>0 and indeed every U for which that carrier is defined.

The independently accepted translated-mass/digamma packet proves a useful all-translation bound, but its specialization is too weak here. The sharper calculation already present in `prime-estimates/XiMass.lean` is

    Re(logDeriv xiF 2)
      = 3/2 - log(pi)/2 - EulerGamma/2
        - Re(LSeries (fun n => (Lambda(n):Complex)) 2).    (X)

This is `Explicit.ZeroFreeRegion.re_vM_eq` at 2 with `Complex.digamma_one`. There is no limit, branch choice, or digamma asymptotic in (X).

The finite certificate supplies these exact lower bounds:

    log(pi) >= 1.1447,
    EulerGamma >= .576715,
    Re(LSeries Lambda 2) >= .56945.

Thus (X) is at most

    3/2 - 1.1447/2 - .576715/2 - .56945
       = 27937/400000 = .0698425 < .07,                  (C)

with margin 63/400000. All decimal constants here are exact rationals.

The underlying finite certificate is not an external zeta computation. It checks 303 logarithm lower bounds with the source `Prelim.Small.chkLow`, then uses 333 prime-power terms among n<=2000. Its lower summand branches on the same `IsPrimePow` and `Nat.minFac` as the actual `ArithmeticFunction.vonMangoldt`. At n=0 both values are zero; no exp(log(0)) identity is used. `hasSum_re_vM` at sigma=2, tau=0 gives the actual nonnegative Lambda(n)/n^2 series, so `sum_le_hasSum` extends the finite bound. For EulerGamma the exact harmonic lower bound H_1000>=7.48547086 and the source `chkStep` upper bound log(1001)<6.908755 imply H_1000-log(1001)>.57671586. Mathlib's `Real.eulerMascheroniSeq_lt_eulerMascheroniConstant` then gives the retained .576715.

The source-soundness APIs are `SmallMertens.lean:45 le_log_of_chk` and `SmallPsi.lean:69 log_lt_of_chk`, with positive denominator and positive integer argument. The existing independent [XiMass review](../audit/XIMASS_REVIEW.md), SHA256 `F285D46C3275A3A605A52974A5FA30BCAA87912007C6A28CC5BFD3772C5DD436`, checked the finite arithmetic against the exact unchanged draft SHA256 `DC2F179566C4DD7EFEBBC295CD49C1E40CD1B861EAC5555ABF6EA4377765A899`. That review explicitly did not claim Lean compilation.

Equations (M) and (C) close the mathematical mass premise of the energy packet. They do not make `XiMass.lean` compiled, and they do not establish the unrelated global zero strip. The earlier energy packet's reference to `multRectD_eq_mult` should be replaced in a future implementation by the lower-level order transport just described. No frozen source is changed here.

## 2. Actual source objects and summability

The target is the unchanged source definition at `MinorArcs/MinorTotal.lean:95`:

    a₁ x n = if n.Prime and sqrt(x)<n
              then (Lambda(n)*etaPlus(n/x) : Real)
              else 0,

embedded in Complex. The smoothing is exactly `Helfgott.etaPlus`, defined by

    etaPlus(t) = hH(200,t)*t*exp(-t^2/2).

It is not replaced by the compact etaO smoothing. The complete Gaussian tails remain throughout.

Put L=log x and

    S(x) = sum'_n Lambda(n)*log(n)*etaPlus(n/x)^2.

At `Explicit/EtaPlusSq.lean:183,185`, `phi1(t)` is the real square etaPlus(t)^2 embedded in Complex and `phi2(t)=log(t)*phi1(t)`. The source already proves `goodSmoothing_phi1`, `goodSmoothing_phi2`, and `summable_SsumG` at lines 382,396,415. For the actual principal character chi modulo 1, chi(n)=1 for every n, exactly as established in `MajorArcs/Prop715.lean:313ff`.

For x>0, these two summability results imply summability of the complex sequence

    L*Lambda(n)*phi1(n/x) + Lambda(n)*phi2(n/x).

For n>0, log(n)=L+log(n/x), so this is the real sequence defining S(x), embedded in Complex. At n=0, Lambda(0)=0 and both sides vanish; that case is separate. Applying `Complex.hasSum_re` to the summable complex sequence proves real summability. As the real summands are nonnegative, this also proves absolute summability. This is a direct proof, with no appeal to the totalized value of a nonsummable tsum.

The resulting exact identity is

    (S(x):Complex) = L*SsumG chi phi1 x + SsumG chi phi2 x. (S)

The original `prop_9_5_1` proof contains this algebra, but that theorem itself has an RH-to-500 input and is not used as a black box. Its local identities may be reproved from the unconditional interfaces above.

Independently, `MinorTotal.summable_a₁` gives summability of ||a₁ x n|| for x>0. `TernaryGoldbach.summable_norm_sq_of_summable_norm`, in `MinorArcs/Plancherel.lean:16`, gives summability of their squares. For every n,

    ||a₁ x n||^2 <= Lambda(n)*log(n)*etaPlus(n/x)^2.      (P)

On the active prime branch, `ArithmeticFunction.vonMangoldt_apply_prime` makes this equality. On the inactive branch the left side is zero and the right side is nonnegative, including n=0,1 by `Real.log_natCast_nonneg`. Thus `Summable.tsum_le_tsum` gives the desired comparison to S(x). The cutoff sqrt(x)<n is not relaxed or omitted from the definition; it is only discarded in this upper bound.

## 3. Completing the derivative-projection argument

Here are the paper details behind the projection step in the existing [energy packet](../mellin/MINOR_ENERGY_QRH.md), SHA256 `A0C414E8FAEAB6C8A4768B2179635F5B42F69D118EA17EBB062AA7FD7857C0A6`.

Use the actual `MajorArcs.gL(u)=hBase(exp u)` and its complex embedding gC. Write h(u)=hH(200,exp u), and B=[-200/(2*pi),200/(2*pi)]. The existing `hH_eq_fourier_K` identifies h with the inverse Fourier transform of `Kc 200=1_B*Fourier(gC)`, in the convention

    Fourier(g)(xi) = integral g(u)*exp(-2*pi*i*xi*u) du.

For j=0,1,2 define the auxiliary density, on paper,

    D_j(xi)=(2*pi*i*xi)^j*Kc(200,xi).

These are ordinary functions, not replacement smoothings or assumptions. All D_j are integrable and in L2: Kc is supported on the compact B, its Fourier factor is continuous and bounded, and the polynomial multiplier is bounded on B. The same holds for D_j with any fixed higher j.

Differentiate the integral against exp(2*pi*i*xi*u). For its j-th derivative, the dominating function for one further derivative is

    1_B(xi)*(2*pi*|xi|)^(j+1)*|Fourier(gC)(xi)|.

It is integrable and does not depend on u. `hasDerivAt_integral_of_dominated_loc_of_deriv_le` in Mathlib `Analysis/Calculus/ParametricIntegral.lean:284` applies on any real neighborhood of u: measurability and integrability follow from compact support, and the exponential derivative is exact. It follows inductively that h is smooth, its j-th derivative is the inverse transform of D_j, and every derivative is bounded by integral |D_j|. The source identity for j=0 fixes the function being differentiated. Since h is real-valued, its derivatives agree with the real derivatives used below.

The source has integrable and square-integrable gC, gC', and gC'', with exact derivative identities in `HHFourier.lean:430ff` and `HHFourier2.lean:208ff`. It applies `Real.fourier_deriv` once and twice, respectively, to obtain

    Fourier(gC^(j))(xi)=(2*pi*i*xi)^j*Fourier(gC)(xi).

Therefore D_j=1_B*Fourier(gC^(j)). Apply the existing `TernaryGoldbach.integral_norm_sq_fourier` first to D_j, change u to -u using measure preservation, and apply it again to gC^(j). This gives

    integral |h^(j)|^2 = integral_B |Fourier(gC^(j))|^2
                       <= integral |gC^(j)|^2.          (D)

This proves contraction for actual u-derivatives. No extra 2*pi is missing: those factors are already in D_j and in the source Fourier derivative identity. No assertion that the sharp cutoff is differentiable in frequency is needed; only differentiation in u occurs.

For j=0, the source `Helfgott.hP'` factors as exp(t-1/2)*t*(2-t)^2*(1-t)*(4+t). Thus hBase increases on [0,1], decreases on [1,2], vanishes outside [0,2], and has maximum exp(1/2)<1.65. Its nonnegativity is immediate from its formula on [0,2]. The existing `Explicit.Cg_le` gives integral |gC|<=2.03. Hence integral |gC|^2<=1.65*2.03<4. For j=1,2, the source bounds are 19.5 and 368. From (D),

    ||h||_2<2,   ||h'||_2<=sqrt(19.5)<4.5,
    ||h''||_2<=sqrt(368)<19.2.                          (L2)

The sharper squared estimate ||h'||_2^2<=19.5 is retained in the following operator bound. These projection conclusions are new formal lemmas to prove; the existing source does not export them as already compiled statements.

## 4. Mellin identification and all boundary terms

Fix beta in [0,7/8], any real gamma, and set

    a=2-beta, b=beta+2, z=exp(2u),
    E(u)=exp(b*u-exp(2u)), F(u)=h(u)^2*E(u).

The logarithmic change of variables t=exp u in the source Mellin integral gives

    mellin(phi1)(beta+i*gamma)=integral F(u)*exp(i*gamma*u) du,
    mellin(phi2)(beta+i*gamma)=integral u*F(u)*exp(i*gamma*u) du. (T)

These formulas also follow from the existing Mathlib `mellin_eq_fourier` in `Analysis/MellinInversion.lean:49`, followed by u -> -u and the explicit Fourier convention. The factor from dt is included: etaPlus(t)^2 contributes t^2, and t^(s-1)dt contributes exp(su). Thus b=beta+2, not beta+1 or beta+3.

All needed integrations by parts can now be justified with explicit majorants. The bounded h,h',h'' from Section 3 and

    E'=(b-2z)E,
    E''=((b-2z)^2-4z)E

show that each of F,F',F'',uF,(uF)',(uF)'' is bounded in absolute value by a fixed constant times (1+|u|)*(1+z^2)*E. On u<=0 this is at most C*(1+|u|)*exp(2u), because 2<=b<=23/8 and z<=1. On u>=0 it is at most C*(1+u)*exp(7u-exp(2u)), since b+4<=55/8<7. For u>=2, exp(2u)>=8u: at u=2, the first four nonnegative Taylor terms already give exp(4)>16, and the difference exp(2u)-8u is increasing thereafter. Hence the positive-tail majorant is C*(1+u)*exp(-u). The compact middle interval causes no issue.

These integrable majorants also tend to zero at their respective infinities. In particular F,F',uF,(uF)' vanish at both ends. Multiplication by exp(i*gamma*u) or its first two derivatives changes only a fixed factor depending on gamma, since this exponential has modulus one. Thus all products in two integrations by parts are integrable, and every boundary term vanishes. This includes gamma=0 and every beta endpoint.

One may apply the existing whole-line theorem `MeasureTheory.integral_mul_deriv_eq_deriv_mul` in `IntegralEqImproper.lean:1358` twice, with the displayed zero boundary limits. Its integrable variant at line 1369 is also applicable. The result, with the sign fixed by (exp(i*gamma*u))''=-gamma^2*exp(i*gamma*u), is

    (a^2+gamma^2)*M1 = integral (a^2*F-F'')*exp(i*gamma*u) du,
    (a^2+gamma^2)*M2 = integral (a^2*uF-(uF)'')*exp(i*gamma*u) du. (IBP)

No division by gamma or hypothesis excluding real zeros enters this argument.

## 5. Kernel constants and explicit-formula composition

The existing energy packet and its independent review prove the following elementary scalar bounds on this full beta range:

    E<=1/2, |E'|<=2, |a^2*E-E''|<=15.5,
    |u|E<=1, |u||E'|<=7, |u||a^2*E-E''|<=58.

For completeness their finite certificate reduces to z^k E<=(1/2,1,3,10)_k for k=0,1,2,3. Split z<=1 and z>=1; on the latter range maximize z^(k+3/2)*exp(-z). Squaring leaves four positive exponential lower bounds at 3,5,7,9, certified by the already reviewed degree-30 rational Taylor sums. The source scalar script was read, not rerun here.

Write P*E=a^2*E-E''. Since

    a^2*F-F''=-2*((h')^2+h*h'')*E -4*h*h'*E' +h^2*P*E,
    a^2*uF-(uF)''=u*(a^2*F-F'')-2F',

Cauchy-Schwarz and (L2) give

    ||a^2*F-F''||_1 <= 191.9 < 172*(9/8),
    ||F'||_1 <= 17,
    ||a^2*uF-(uF)''||_1 <= 633.8 < 566*(9/8).

Here 191.9=2*(19.5+2*19.2)/2+4*2*4.5*2+4*15.5 and 633.8=2*(19.5+2*19.2)+4*2*4.5*7+4*58+2*17. Since a>=9/8, (IBP) proves

    |mellin(phi1)(rho)| <= 172*w2(rho),
    |mellin(phi2)(rho)| <= 566*w2(rho),
    w2(rho)=(2-Re(rho))/((2-Re(rho))^2+Im(rho)^2).      (K)

The actual OAI 7/8 theorem, once validated in the target environment, supplies Re(rho)<=7/8 for every zeta zero in the source strict strip. Only that upper endpoint is needed. The source `zerosRectD_zetaF_strip` supplies the original zeta-zero identity and 0<Re(rho)<1. No finite .555/principal-strip certificate is needed for this energy branch.

For every finite source rectangle, (M),(C),(K), and |x^rho|=x^Re(rho)<=x^(7/8) give the zero-sum bounds

    |sum m(rho)*mellin(phi1)(rho)*x^rho| <=172*.07*x^(7/8),
    |sum m(rho)*mellin(phi2)(rho)*x^rho| <=566*.07*x^(7/8). (Z)

These are the same weights and carrier as the unconditional `Explicit.explicit_formula_zeta_seq`, `ZetaExplicit.lean:122`. Apply that theorem to each existing GoodSmoothing and pass the finite norm bound (Z) to the limit along its actual `goodSeqD ldatum_zeta` sequence. The limit is

    mellin(phi_j)(1)*x - SsumG chi phi_j x
       - (1/(2*pi))*verticalIntegral_j.

Rearranging gives |SsumG-main| <= the zero bound plus the normalized vertical norm. All trivial-zero and zero-at-zero issues are already handled by this source formula: its finite zetaF rectangles consist of strict-strip nontrivial zeros, and the pole term is the displayed mellin(phi_j)(1)*x. No extra residue is inserted. The RH-dependent `norm_SsumG_phi1_le`, `norm_SsumG_phi2_le`, `err_phi1_le`, `err_phi2_le`, and `prop_9_5_1` are not used.

The existing `phi1_vert`, `phi2_vert` and `norm_integral_hZeta_le_gen` provide the vertical bounds. Their constants satisfy Kv1<400000 and Kv2<2200000 by `cA_sq_le` and the source exponential bounds. `MajorArcs.VgL400_le` gives VgL(3,Kv,1/400)<=6.6403e6*Kv. With 2*pi>6, the two normalized vertical contributions, after division by x, are at most

    R1=5e11*x^(-3/2), R2=3e12*x^(-3/2).               (V)

These source interfaces are unconditional and their parameters are positive, as required. The factor x^(-1/2) in the vertical integral becomes x^(-3/2) only after division by x.

## 6. The actual energy and preserved negative offset

The integral identity accompanying (S), proved by the same source log split and integrability of phi1 and phi2, is

    (I(x):Complex)=L*mellin(phi1)(1)+mellin(phi2)(1),
    I(x)=integral_(t>0) etaPlus(t)^2*log(x*t) dt.

For phi1 its Mellin convergence at 1 follows from the existing real-power/Gaussian estimates in `EtaPlusSq`; for phi2 it is the first component of `hasDerivAt_mellin_phi1` at s=1. `MajorArcs.mellin_one_eq` and `integrableOn_of_mellinConvergent_one` in `Prop715.lean:282ff` perform the integral conversion without RH. Thus every sum and integral combined here is integrable or summable before algebra is applied.

Combining (S), (Z), and (V) gives

    |S(x)-x*I(x)|/(x*L)
       <= .07*x^(-1/8)*(172+566/L)
          +5e11*x^(-3/2)+3e12*x^(-3/2)/L.

For x>=X0=4.9e26 the previously reviewed exact scalar facts give L>=61 and x^(1/8)>2125. The zero term is at most 38703/6481250. Its gap below .006 is 369/12962500, which is greater than 1e-27. The vertical terms are less than 6e11*x^(-3/2)<1e-27. Hence

    |S(x)-x*I(x)| < .006*x*L.                           (A)

Every majorant is decreasing with x on this range; the endpoint inequalities therefore cover all x>=X0. There is no finite upper endpoint or hidden asymptotic transition.

The existing unconditional `MajorArcs.integral_etaPlus_sq_log`, `EtaPlusSqLog.lean:889`, gives

    I(x) <= (.640206+1.95e-6)*L-.021095+5.3e-7.

Use (A) and 5.3e-7/L<=5.3e-7/61<1e-8. It follows that

    S(x) < (.64620796*L-.021095)*x
         < (.64621*L-.021095)*x.

Finally apply (P) and both established summability statements. This proves the paper bound (E), including the offset -.021095. This derivation uses the public main-integral bound, not the sharper number claimed in a source comment, and not any unproved sign of the main-integral error.

The inequality with .65 and the same offset is strong enough to use the previously reviewed `MINOR_ENERGY_TOLERANCE.md` replacement sigma(x)=.65*log(x)-.021095. It does not prove the original source `sig(x)=(.640208+366.91/sqrt(x))*log(x)-.021095`. `MinorTotal.T_le` therefore cannot simply have its Platt premise deleted without changing its conclusion or the internal definition of sig. The sigma-dependent `Mexpr`, `NumericsGoal`, and sD/tau bounds must be revised and checked as already specified in that packet. No extra 366.91/sqrt(x) term should be added to .65 without accounting for it.

The separate branches for `a₂`, the major-arc lower energy 8.6294, base gap, large sieve quotient, and higher minor levels remain separate. This energy join proves none of them and makes no final Goldbach closure claim.

## 7. Implementation boundary and smallest new obligations

The mathematical mass input is now supplied by (M)+(C). The exact distinction is important: the finite rational data were independently checked externally, while the corresponding Lean decision proofs are still uncompiled. The new order transport is accepted on paper, while its Lean proof is absent. The all-translation digamma series neither replaces the finite calculation nor adds a dependency to this energy branch.

An implementation can proceed in the following order, preserving the actual source functions throughout:

1. Validate the unchanged XiMass finite certificates and exact s=2 identity with standard kernel checking. Prove the new finite source-order transport and specialize to the complete source rectangle. No new prime or zero data are needed for this step.
2. Prove the derivative projection statements (D) for j<=2 from `hH_eq_fourier_K`, compact Fourier support, `Real.fourier_deriv`, and `integral_norm_sq_fourier`. Prove the displayed L2 bounds from existing source energies and hP monotonicity.
3. Formalize (T), the explicit integrable boundary majorants, the two whole-line integrations by parts, and the finite scalar weight bounds. This yields the actual all-height kernels (K), without a missing kernel-bound premise.
4. Validate and consume the genuine global OAI 7/8 zeta theorem; compose the existing `explicit_formula_zeta_seq` with the exact mass and kernels. The OAI source export is `OAI.riemannZeta_ne_zero_of_seven_eighths_lt_re`, not the weaker 23/24 export. Its target-version elaboration and transitive axiom checks remain required.
5. Prove weighted real summability through the phi1/phi2 split, bound S by (A), retain the negative offset, and use the unchanged definition of a₁ and its existing square summability for (E).
6. Update and validate only the intended sigma-dependent minor numerical interfaces. They are not unchanged consequences of the new energy theorem.

This is a complete paper-level route to one consumer, with no additional finite spectral premise and no result-shaped replacement hypothesis. The still-missing items are the listed formal proofs, kernel-certified finite arithmetic, provider validation, and downstream numerical integration. No runtime feasibility is inferred from the small number of displayed formulas or finite table entries.

## 8. Pins

Prior packets were read at these exact hashes:

| Artifact | SHA256 |
| --- | --- |
| prime-estimates/XiMass.lean | `DC2F179566C4DD7EFEBBC295CD49C1E40CD1B861EAC5555ABF6EA4377765A899` |
| audit/XIMASS_REVIEW.md | `F285D46C3275A3A605A52974A5FA30BCAA87912007C6A28CC5BFD3772C5DD436` |
| mellin/MINOR_ENERGY_QRH.md | `A0C414E8FAEAB6C8A4768B2179635F5B42F69D118EA17EBB062AA7FD7857C0A6` |
| audit/MINOR_REPLACEMENT_AUDIT.md | `056E4229B2F62A630A81143244AC75A6D3E052F03C577CF369D3D045D76118FE` |
| mellin/minor_energy_constants.py | `1EC75D826A67250318F7678A4B945BCF99A255403F0ED01B8B6C3BD9C0314AD3` |
| major-constants/MINOR_ENERGY_TOLERANCE.md | `EFD427246B3416F3F9F79E0AE4DD4370F5EBB038BC38D59E1B2AC1A33BADBEC1` |
| prime-estimates/TRANSLATED_MASS_DIGAMMA_JOIN_2026-11-11.md | `DAE3AC2179E3DC43FC0C91DA0297D412DF01A444D96AE3ED27214BE165166115` |
| independent-feasibility/REVIEW_TRANSLATED_MASS_JOIN_2026-11-11.md | `A7093604DB1EFD79FCB8367F79CCF066CFC964F0366ED5A9C7E7C1DC41067FD5` |

Inspected production files, relative to TernaryGoldbach:

| File | SHA256 |
| --- | --- |
| MinorArcs/MinorTotal.lean | `6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742` |
| MinorArcs/Plancherel.lean | `4FF44BFCF782143518E50A5992EBD864CD9618AE674656A1565944ADFFD24149` |
| Explicit/EtaPlusSq.lean | `CC8A2F3B837189B87F1752792B0D2C6D1E92850C32A10FCC500BAD71955E77EF` |
| Explicit/EtaPlusSqBound.lean | `DF6A1AA3116DD329206E5AD2CB311CA9401EF1CD46116EFAC8D02712CF210787` |
| Explicit/ExplicitBoundGen.lean | `360706F9766A940C13D1E1FFAA9A3EE4A248F845C2816B5568F207D41BB7E44E` |
| Explicit/ZetaExplicit.lean | `A2252356B4A2FCE4BC0B2B0EFF9A26B43DFAEBA9B05DB94BFEAA444A423B94E2` |
| MajorArcs/HHFourier.lean | `C2672D93F08DD59A8FB1D8B474BD5393F1B8823938F4D7ACF39FB9AC97CFF665` |
| MajorArcs/HHFourier2.lean | `B90303E4F7F4404F7587590A30982081EE026F74F307D866DF7443A9F3F38254` |
| MajorArcs/EtaPlusSqLog.lean | `E28D20389EEA3C4A85A2A8210C7CB3567FF10A21A9768A65390D111C1B543FD3` |
| MajorArcs/Prop715.lean | `CD026A3D01FD8578484E43A48888885C2DC3BF696B2F7ACB89BB525E4E064DF0` |
| Helfgott/HHBound.lean | `D2006ECE07FB59B4B9EA7F818CD314DAEEE89637F56ECC43237E923C42C5E0FF` |
| Prelim/PlancherelReal.lean | `F6F59C43D412308D6F9328445F78E629E34BC25D8E62AB2093E8C65BE90B9E97` |

The source files for (X) and the finite arithmetic soundness remain at the same pinned production commit. `Explicit/ZeroFreeRegion.lean` SHA256 is `AC367CDA6777165DF4AF22BA1BA1530B8A280B77CA55F1918562376DE69C0EAB`; its `hasSum_re_vM:140`, `re_vM_eq:192`, and `log_pi_ge:243` are the exact interfaces used by XiMass. The companion mass-transport note pins the additional Xi/WeilBridge/carrier sources.
