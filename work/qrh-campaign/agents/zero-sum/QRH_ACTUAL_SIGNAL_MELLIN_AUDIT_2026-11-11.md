# Actual Hecke signal and Mellin recovery: bounded source audit

Date: 2026-11-11. Verdict: PASS for the conditional analytic producer described below. This is a source and mathematical audit, not a build, axiom audit, or validation of the complete QRH provider. No Lean source was changed and no analytic values were evaluated.

## 1. New boundary and exact scope

The accepted `integration/QRH_DETECTOR_CONTRADICTION_MATH_AUDIT_2026-11-11.md`, section 7 (line 143), explicitly left `Hecke/Signal.signalMellin_eq_amplitude_on_line` and its contour/reciprocal inputs outside its checked boundary. The present audit follows those bodies. It does not repeat the outer identity-theorem contradiction or claim to construct the detector approximation premises.

All source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`. The principal target is `Hecke/Signal.lean:237`. Its assumptions are an actual `HeckeFamily.Character` chi, a complex function H differentiable on Re(s)>7/8, the pointwise bound |H(s)-1|<=1/2 there, real c and a with a<2, and the **separate** top-end bound

\[
 f(x)=O(x^{a+c})\quad(x\to+\infty),\qquad f=\operatorname{signal}(\chi,H,c).
\]

No primitivity, reality, or nonprincipal restriction is present. The conclusion holds for every real y. The top-end bound is not inferred from the inverse Mellin definition. The source supplies local integrability and rapid decay at zero, then uses this top-end bound to obtain the second integrability condition needed for Fourier inversion.

## 2. Actual functions and reciprocal bound

`Hecke/Signal.lean:13–19` defines Q(s)=H(s) reciprocal(chi,s), A(s)=exp((s-5/6)^2)Q(s), and

\[
 f(x)=x^c\operatorname{mellinInv}_{-2}[s\mapsto A(-s)](x).
\]

All identities involving real x below have x>0. Thus complex powers use the real logarithm of a positive base; cancellation by x^c is legitimate. There is no claim about a chosen value at x=0 or negative x.

`Hecke/Reciprocal.lean:84–98` uses the actual reciprocal: for a principal residue character it is (s-1)/regularizedL(chi,s); otherwise it is L(chi,s)^(-1). The regularized function is the actual regularized lattice L-function divided by six. Away from 0 and 1 it equals (s-1)L. Consequently `reciprocal_eq_inv:87` applies everywhere on the contours used here. At the principal pole s=1 the reciprocal is zero, not an asserted nonzero amplitude.

`Signal.lean:22` obtains differentiability on Re(s)>1 by applying reciprocal differentiability with beta<Re(s), using only `Hecke/ZeroSupremum.beta_le_one:36`. That bound comes from ordinary Euler-region nonvanishing: any actual zero of positive real part, excluding the principal pole convention, has real part <=1; the inserted 1/2 sentinel makes the supremum nonempty. This does not use beta<=7/8.

The stronger uniform estimate used for integration is only on Re(s)>=2. Put

\[
 B_2=\sum_I |\operatorname{fullIdealWeight}(2,I)|,\qquad C_Q=\tfrac32 B_2.
\]

`Hecke/ReciprocalBound.lean:13,29` proves |reciprocal(chi,s)|<=B_2 there and hence |Q(s)|<=C_Q. The triangle inequality gives |H|<=3/2. For nonzero ideals NI>=1, so (NI)^(-Re(s))<=(NI)^(-2); the zero ideal is handled separately, with weight zero.

This is not a default-tsum argument. `IdealEuler.lean:38,52,65,113` proves absolute summability of the actual weighted series and its Möbius inverse, multiplies the two absolutely convergent series, and reindexes over multiplication fibers. The fiber Möbius sum is one at the unit ideal and zero otherwise; the zero ideal fiber contributes zero. Thus inverseSeries*series=1 before identifying inverseSeries with series^(-1). `QuadraticSieve/DyadicColumns.lean:209` proves the dominating ideal sum converges by injection of nonzero ideals into chosen Eisenstein generators and summability of their embedding norms to power -2 Re(s)<-2. The norm is the Euclidean embedding norm; its square equals the ideal absolute norm. The generic lattice-summability and ideal-generator foundations are retained dependencies, not reproved here.

The constant C_Q is independent of chi and H within the displayed assumptions. It is finite and nonnegative. No effective numerical value or uniformity beyond those assumptions is asserted.

## 3. Contour identity and zero-end bound

`Signal.lean:53` unfolds Mellin inversion, changes y to -y, and combines powers to obtain exactly

\[
 f(x)=\frac1{2\pi}\int_{\mathbb R}x^{2+iy+c}A(2+iy)\,dy.
\]

The factor is 1/(2 pi), with dy, rather than an additional i from an oriented complex line integral. `ContinuationContour.lean:83,86` defines G_x(s)=x^(s+c)A(s) and computes

\[
 |G_x(u+iy)|=x^{u+c}e^{(u-5/6)^2}|Q(u+iy)|e^{-y^2}.
\]

For any fixed B>=2 and 0<x<=1, throughout 2<=u<=B this is at most

\[
 x^{2+c}e^{(B-5/6)^2}C_Q e^{-y^2}.
\]

Both comparisons have the correct direction: x<=1 reverses monotonicity in the exponent, while (u-5/6)^2 increases for u>=2. The bound is uniform in u and y after B,x,c are fixed.

`ContinuationContour.lean:12–81` proves the shift rather than assuming it. Analyticity on the closed strip yields the rectangular boundary identity. Continuous vertical restrictions and the Gaussian majorant give Bochner integrability on both vertical lines. Each horizontal integral has norm at most (B-2) times the displayed constant times exp(-T^2), so both vanish. The truncated vertical integrals tend to their actual full integrals by integrability. Cancellation of the nonzero factor i gives equality of vertical dy-integrals. The B=2 case is included; there is no crossed pole or zero because every contour lies in Re(s)>=2.

`Signal.lean:111,146` therefore gives

\[
 |f(x)|\le C_B x^{B+c},\qquad
 C_B=|1/(2\pi)|e^{(B-5/6)^2}C_Q\int_{\mathbb R}e^{-y^2}dy.
\]

For each real R choose B=max(2,R-c). Then B+c>=R, so x^(B+c)<=x^R on (0,1]. This proves `signal_rapidDecayAtZero:166`. Constants may grow with R and c; no uniform-in-R decay constant is promised. The proof shifts **right**, not into the hoped-for zero-free strip.

## 4. Continuity and the two integrability obligations

`Signal.lean:181–231` sets F(y)=A(2-2 pi i y). Its continuity follows from differentiability of Q on Re>1. Its integrability follows from the Gaussian estimate by the nonzero real scaling -2 pi. Mellin inversion is rewritten as

\[
 f(x)=x^{c+2}(\mathcal F^{-1}F)(-\log x),\qquad x>0.
\]

The inverse Fourier transform of this integrable F is continuous. Composition with log and positive-base powers proves continuity on (0,infinity), hence local integrability there. No growth bound at infinity is needed for this continuity step.

For Mellin recovery, `Continuation.lean:46` additionally uses the stated top-end bound and rapid zero-end decay to prove convergence at -(2+c). In general it proves convergence at -(s+c) whenever a<Re(s). The source chooses a sufficiently strong zero-end power for the particular s; it does not treat rapid decay as a fixed exponent valid for every Mellin argument at once.

The delicate inversion step is explicit in `ContinuationInversion.lean:11–76`. For a generic Mellin-convergent function v at real sigma, define

\[
 g(u)=e^{-\sigma u}v(e^{-u}),\quad
 F_\sigma(y)=F(\sigma+2\pi i y).
\]

The change of variables x=exp(-u), including its absolute derivative exp(-u), proves g is integrable. The inverse Mellin representation gives g=FourierInv(F_sigma). Hence g(-u) is integrable and equals Fourier(F_sigma)(u). This supplies integrability of Fourier(F_sigma), **not** just integrability of F_sigma. Fourier inversion then recovers F_sigma pointwise, using its continuity. Thus no totalized integral or unproved inverse-transform integrability is used as an identity.

`ContinuationInversion.lean:78–117` applies this with v=x^(-c)f(x), sigma=-2, and F(s)=A(-s). The identity -( -2+2 pi i y)=2-2 pi i y fixes both the sign and the 2 pi scale. The output is precisely

\[
 \operatorname{signalMellin}(f,c)(2-2\pi i y)=A(2-2\pi i y),
 \qquad\operatorname{signalMellin}(f,c)(s)=\operatorname{mellin}(f)(-(s+c)).
\]

## 5. Nonzero amplitude and caller boundary

For Re(s)>1, actual Euler nonvanishing and reciprocal_eq_inv identify A with exp((s-5/6)^2)H(s)/L(chi,s). The contraction bound implies |H(s)|>=1/2, so A is nonzero on that half-plane. This statement is not extended to the principal point s=1. At a hypothetical zero further left the argument uses the analytic **numerator** exp((s-5/6)^2)H(s), not an independently asserted nonzero reciprocal there. `Continuation.lean:113–128` proves that numerator is nonzero from H's contraction bound and the exponential's nonvanishing.

`Hecke/SignalIdentity.lean:26,98` consumes the recovered line identity, the separate top-end bound and regularized L-functions in the previously audited contradiction. In its actual caller `nonzero_of_probe_bounds`, the top exponent is a=beta-continuationMargin, with a<2 following from beta<=1 and positive margin. The bound itself comes from **both** the probe bound and its approximation error, not from current contour analysis. `Hecke/CommonProbe.lean:13–21` states those as actual-function premises with c=-11/16, retaining the masked character and H. This audit neither proves those detector estimates nor replaces them with an arbitrary signal satisfying the desired conclusion.

Consequently the new checked boundary is the conditional actual-signal producer: actual reciprocal and Gaussian inverse Mellin definition -> absolute contour integrability -> rightward shift and rapid zero-end decay -> local integrability -> Mellin recovery when the caller supplies top growth. The genuine remaining cuts are the detector construction of H and its contraction/analyticity, the actual probe approximation/top bound, and the underlying Hecke continuation, lattice/Euler and library Fourier/Mellin/Cauchy theorems. No energy induction, PNT estimate, or target QRH theorem was invoked to close this local chain.

## 6. Frozen source pins

Line references above identify declarations in the following exact files. These hashes identify inspected source, not successful compilation or compatibility with any different Mathlib revision.

| File | SHA-256 |
|---|---|
| Hecke/Signal.lean | `EC7A4403C352DEE276850EA4418122C03DD3A5BC108AC8352FCD866578BE36F6` |
| Hecke/Reciprocal.lean | `4161F072933BAAC5769ADAD68ACF0B8B3C45BD75FFFACF6152587AE001355D68` |
| Hecke/ReciprocalBound.lean | `EBBED5A1FA1DCFAEEE9710B287780D44D439BDA86B23FD3DD364FDA575B50CFC` |
| Hecke/ZeroSupremum.lean | `F27256644A64572823B53CAE87483C4726192FF906EE7F64AE30E13F77E57242` |
| IdealEuler.lean | `D8EC594DEDB83661937B1DA00600AFE85A4A319434CE1C0B64543EF06A24BB59` |
| QuadraticSieve/DyadicColumns.lean | `06DD20DAD9FB49BFC615256402AA6664FAFB5125CB6AC11C701118057A47F87C` |
| ContinuationContour.lean | `802518ADB58151BB191B51683F36BBE81FCC297BAFF729B4521E3A1F8A8E7A62` |
| ContinuationInversion.lean | `FD0A5CDB4484BB36F988FECBF8F3A5539EFE4AD338F5FF4DED1CE1EAB2035A78` |
| Continuation.lean | `BAF2CD9ADB5911D766AABD9112EEA36DA4841E8EC04852A369882AE45D253E85` |
| Hecke/SignalIdentity.lean | `2FF1E2AAB2956D512457F121068804D65B34D790AB70520F2836041C44776C2E` |
| Hecke/CommonProbe.lean | `D2FE9C934B4DE31248CFC3B4F0F5B806BBCEF6A6C8769805C74CAA556E0A8097` |

Prior coverage checked: `integration/QRH_DETECTOR_CONTRADICTION_MATH_AUDIT_2026-11-11.md`, SHA-256 `B28B9982BEAD587411C9FC10F5D61C06A03073E59B3701F85B8B328C6CF48ABC`. Its explicit remaining-cut entry, rather than an inference from the report title, establishes that the present signal analysis is new coverage.
