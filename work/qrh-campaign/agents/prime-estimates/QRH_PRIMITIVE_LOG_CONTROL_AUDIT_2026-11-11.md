# Primitive Hecke logarithmic control: source audit

Date: 2026-11-11. This is a paper/source audit of the local logarithm and growth assembly at OAI revision `4eaee87548250b2682affda7d05d947c05554bae`. No Lean compilation, evaluator, analytic-value computation, dependency change, or frozen-source edit was performed.

Verdict: the inspected local argument is mathematically coherent. The actual Euler logarithm, principal regularization, disk geometry, and uniform constants supply the hypotheses of the generic logarithmic-control theorem. This does not validate the whole QRH provider, its transitive imported proofs, or its kernel axioms. The precise remaining foundational cuts appear below.

All source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/` in the shared repository. Line numbers refer to the hashes in the final table.

## 1. Actual family and theorem boundary

`Hecke/Family.lean:22` defines a character over the ring of integers of the Eisenstein field. Its data include a nonzero ideal modulus, a multiplicative character of the finite quotient, triviality on global units, and a positive integer period contained in the ideal. This is the finite-order, unit-trivial ideal-character family. It is not a theorem about arbitrary archimedean infinity types. Any application to ordinary Dirichlet characters still needs the separate family bridge.

Write

\[
 Q=N(\mathfrak m)\ge1,\qquad C=2Q(3+|t|)^2,\qquad c_t=2+it.
\]

The integer lattice period is absent from this complexity. `Hecke/IdealBridge.lean:95` defines the actual L-function as the continued lattice function divided by six. Lines 80 and 97 identify this normalization with the ideal Dirichlet series on \(\Re s>1\). The factor six counts the units; it must not be dropped in the source identification.

`Hecke/LogarithmicInput.lean:11` defines \(F=\mathrm{regular}(\eta)\). It is the actual L-function for a nonprincipal residue character. For a principal residue character it is

\[
 F(s)=\frac{\mathrm{poleRemoved}(\eta,s)}{s+1},
 \qquad F(s)=\frac{s-1}{s+1}L(s)\quad(s\ne0,1).
\]

`Hecke/LogarithmicActual.lean:50` has exactly this order of quantifiers: for fixed \(0<e<10^{-3}\) and \(\varepsilon>0\), there are \(D>0,B\ge0\), before the choices of primitive ideal character, \(a\in[1/2,1]\), and real \(t\). Assuming \(F\ne0\) on the open disk of radius \(2-a-2e\), it concludes

\[
 |F(z)|+|F(z)^{-1}|\le D C^\varepsilon
 \quad (|z-c_t|\le2-a-6e),
\]
\[
 |F'(z)/F(z)|\le B\log C
 \quad (|z-c_t|\le2-a-8e).
\]

Thus the constants are uniform in the character, ideal norm, chosen lattice presentation, \(a\), and \(t\). They may depend on \(e,\varepsilon\), and the fixed Eisenstein field. No assertion is made uniformly as \(e\downarrow0\). The derivative assertion is about the regularized principal function, not the raw principal logarithmic derivative at its pole.

## 2. Euler logarithm and its convergence

`Hecke/EulerLog.lean:16` uses

\[
 E_\eta(s)=\sum_{\mathfrak p}-\operatorname{Log}
   (1-\eta(\mathfrak p)N\mathfrak p^{-s}).
\]

This is an ordinary convergent sum of principal logarithms of local factors, not an unproved global choice of \(\operatorname{Log}L\). For \(\Re s\ge\sigma>1\), each local coefficient has modulus at most \(N\mathfrak p^{-\sigma}\le1/2\). The local factor lies in the slit plane. `log_factor_norm_le:52` bounds its logarithm by \(\tfrac32N\mathfrak p^{-\sigma}\). `majorant_summable:22`, `eulerLog_differentiableOn_halfplane:81`, and `eulerLog_differentiableOn:90` give local uniform convergence and holomorphy on \(\Re s>1\).

The summability proof descends as follows.

* `Hecke/MobiusEulerCorrection.lean:317`, `prime_norm_series_summable`, restricts the absolutely convergent full ideal series to prime ideals.
* `QuadraticSieve/DyadicColumns.lean:209`, `fullIdealWeight_summable_norm`, injects nonzero ideals into their chosen generators and uses the equality \(N\mathfrak a=|\mathrm{embedding}(g_\mathfrak a)|^2\).
* `Eisenstein/FourierCoefficients.lean:477`, `summable_embedding_rpow`, reduces to Mathlib `ZLattice.summable_norm_rpow` for the rank-two period lattice. The exponent is \(-2\Re s<-2\). This inspected summability path does not require a prime number theorem or QRH.

`Hecke/Boundary.lean:63,69` proves the exponential identity. A `HasSum` of the logarithms is exponentiated using `HasSum.cexp`; each local exponential is the inverse Euler factor. Uniqueness of `HasProd`, compared with `IdealEuler.euler_hasProd:155`, yields \(\exp E_\eta=L\) in the half-plane. `IdealEuler` first proves the inverse-series convolution identity at line 65 using absolute summability, the product of the two series, fiberwise regrouping, and the ideal Möbius divisor sum. It obtains nonvanishing at line 106, then the reciprocal Euler product at line 155. It does not assume Euler-product nonvanishing to establish the convolution identity.

Let
\[
 A_0=1+\sum_{\mathfrak p}\tfrac32N\mathfrak p^{-3/2},\qquad A=3+A_0.
\]
`eulerLogBound:103` and `eulerLog_norm_le:111` give \(|E_\eta|\le A_0\) on \(\Re s\ge3/2\), uniformly in the character. On the disk \(|s-c_t|<1/2\), the actual principal branch is instead

\[
 E_\eta(s)+\operatorname{Log}\left(1-\frac2{s+1}\right).
\]

The second factor is holomorphic on \(\Re s>1\), exponentiates to \((s-1)/(s+1)\), and its logarithm has modulus at most 3 on \(\Re s\ge3/2\), since \(|2/(s+1)|\le4/5\). These are `principalLog_differentiableOn:181`, `exp_principalLog:198`, and `principalLog_norm_le:210`. `LogarithmicActual.actual_inner_log:23` supplies this actual logarithm on the open half-radius disk and the bound \(A\) on the closed radius-49/100 disk. The principal pole at 1 is outside that initial disk.

## 3. Uniform growth and its actual inputs

Define
\[
 D_1=\sum_{\mathfrak a}\!N\mathfrak a^{-11/10},\quad
 L_0=\left(\frac{\sqrt3}{2\pi}\right)^{6/5}
       \frac{\Gamma(11/10)}{\Gamma(19/10)},\quad
 C_* =108(1+L_0)D_1.
\]

The zero ideal contributes zero in this notation. `Hecke/ReciprocalBound.lean:10` defines \(D_1\) as the sum of norms of `fullIdealWeight`, with finiteness supplied above. `Hecke/Strip.lean:12,55,73` defines the Gamma ratio, completion scale \(\sqrt{3Q}/(2\pi)\), and \(L_0\). These are fixed field constants, not functions of the character or period.

The actual left-boundary functional equation is `Hecke/StripActual.lean:112`, on \(\Re s=-1/10\). It expresses \(L_\eta(s)\) by the inverse character at \(1-s\), multiplied by a unit root number, the completion-scale power, and \(\Gamma(1-s)/\Gamma(s)\). It checks that \(s,1-s\ne0,1\) and that both Gamma factors are nonzero. The scale power contributes \(Q^{3/5}\). `Strip.gamma_ratio_left_bound:17` supplies the remaining bound \(L_0(3+|t|)^2\). The right boundary \(\Re s=11/10\) uses the absolutely convergent ideal series.

For completeness, the source FE joins are concrete. `Primitive.pair:63` builds a `WeakFEPair` from `GaussianTheta.theta_inversion:308` and `PeriodicThetaRegularity.primitivePair:54`. `Primitive.completedL_functional_equation:136` applies its FE and identifies the symmetric pair with the inverse character. `Primitive.completedL_eq_gamma_mul_LFunction:149` and `StripActual.completedL_eq_standard:47` identify the completion with the actual L-function. `TraceCharacter.normalizedGauss_norm:93` supplies modulus one from the primitive finite Gauss sum. These theta, Gauss, and Mellin foundations remain the deeper source cut; this report does not reprove them.

Phragmen-Lindelof is not applied with only boundary data. `StripActual.LFunction_exp_growth:151` first obtains character-dependent exponential strip growth. `Mellin/VerticalContourShift.mellin_uniform_strip_bound:142` is an endpoint-integrability argument: the sum of the two endpoint absolute Mellin kernels dominates every intermediate real part. `Strip.uncompleted_exp_bound:284` adds the inverse-Gamma exponential bound. `Strip.vertical_strip_of_exp_bound:108` then verifies Mathlib's admissible growth condition with rate 1, less than \(\pi/(6/5)\). The temporary growth constants can depend on the character; the resulting boundary maximum does not.

The normalization by \(Q^{3/5}(s+2)^2\) leads to
\[
 |L(s)|\le36(1+L_0)D_1Q^{3/5}(3+|\Im s|)^2
\]
on the closed strip for primitive nonprincipal characters. `Presentation.uniform_strip_bound:83` removes the choice of ideal generator. For the principal case, `PrincipalStrip` first uses `poleRemoved/(s+2)`, then changes to `poleRemoved/(s+1)`. The latter ratio costs at most 3 on this closed strip, giving `uniform_source_normalized_strip_bound:219` and the common \(C_*\).

`LogarithmicInput.regular_right_growth:137` extends the bound rightward by the Euler estimate. `regular_disk_growth:195` uses \(|\Im z-t|\le3/2\), hence \(3+|\Im z|\le2(3+|t|)\), and gives
\[
 |F(z)|\le4C_*Q^{3/5}(3+|t|)^2\le2C_*C.
\]
Since \(C\ge18>\exp1\), `Logarithmic.exists_uniform_polynomial_exponent:26` supplies \(|F|\le C^M\). One witness from `absorb_polynomial_constant:473` is
\[
 M=2+\log\max(1,2C_*)\ge1.
\]

## 4. The logarithm, Borel-Caratheodory, and three circles

The following statements refer to `LogarithmicControl.lean`.

On \(D=\{|z-c_t|<2-a-2e\}\), nonvanishing and holomorphy give a continuous logarithm by the simply connected ball theorem. `differentiableOn_of_exp_eq:18` uses the local analytic inverse of exp to make it holomorphic. `exists_holomorphic_log_normalized:52` shifts the logarithm by a constant so that \(g(c_t)=E(c_t)\). Its exponential is unchanged. `log_eqOn_of_eq_center:66` proves equality with \(E\) throughout the initial half-radius disk, first by the local inverse and then analytic uniqueness. Thus there is no uncontrolled multiple of \(2\pi i\) in the center bound.

The polynomial bound yields \(\Re g\le M\log C\). `outer_log_bound:302` applies Borel-Caratheodory with radii \(2-a-3e\) and \(2-a-4e\), gap \(e\). Put
\[
 C_0=(4M+4A)/e,\qquad T=\log C\ge1.
\]
It gives \(|g|\le C_0T\) on the closed radius-\(2-a-4e\) disk. This alone would only give a fixed power of \(C\), not \(C^\varepsilon\) for every positive \(\varepsilon\).

`three_circles:109` derives the circular interpolation from Mathlib `HadamardThreeLines.norm_le_interp_of_mem_verticalClosedStrip'` applied to \(g(c_t+\exp w)\). It checks boundedness on the entire closed vertical strip, rather than assuming it from two boundary lines. The small radius is \(r=49/100\); the intermediate radius is \(\rho=2-a-6e\); the outer radius is \(R=2-a-4e\). `three_circles_exponent_uniform:221` uses
\[
 \rho(1+e)\le R,\quad R/r\le200/49,\quad
 \theta=1-\frac{\log(1+e)}{\log(200/49)}\in(0,1).
\]
Consequently `inner_log_bound:330` gives \(|g|\le AC_0T^\theta\) on the closed radius-\(\rho\) disk, uniformly in \(a\). `exp_sublinear_le:263` absorbs \(\exp(AC_0T^\theta)\) into a constant times \(\exp(\varepsilon T)\). The bound applies to \(\exp g\) and \(\exp(-g)\), and their sum costs a factor two. Its constant is existential; this source theorem does not offer a practical numerical constant.

`logarithm_derivative_bound:351` is a separate Cauchy estimate on radius \(2e\), for centers in the closed radius-\(2-a-8e\) disk. It uses the coarser bound \(C_0T\), giving
\[
 B=C_0/(2e)=(4M+4A)/(2e^2).
\]
`logarithmic_derivative_eq:405` identifies \(g'=F'/F\). All circles lie strictly inside the holomorphy disk. Closed conclusion disks do not silently require nonvanishing at the outer open-disk boundary.

The wrappers need only individual disk logarithms. If overlap consistency is needed later, it follows as a paper consequence: on each connected intersection with \(\Re s>1\), analytic uniqueness extends the equality with the same Euler logarithm. Two intersecting disks centered on \(\Re s=2\) have an overlap point on that line. Their convex intersection is connected, so their normalized logarithms agree throughout it. This extra gluing statement is not asserted as an existing Lean declaration.

## 5. Nonvanishing, poles, and the supremum parameter

`Hecke/ZeroSupremum.lean:10` takes real parts of actual zeros over all characters in this family with \(\Re s>0\), excluding the principal point 1. The set includes a sentinel \(1/2\), and \(\beta\) is its supremum. Euler nonvanishing to the right of 1 establishes boundedness; hence \(1/2\le\beta\le1\). `LFunction_ne_zero_of_beta_lt:48` is the elementary supremum implication, not an assumption that \(\beta\le7/8\).

`LogarithmicInput.regular_ne_zero:32` handles the principal point 1 separately by `HeckeOrigin.poleRemoved_one_ne_zero:40`; away from 1 the pole-removed formula and the zero-supremum theorem apply. Requiring \(\Re s>\beta\ge1/2\) also excludes 0 and the denominator zero at -1. `regular_ne_zero_on_disk:155` uses \(a\ge\beta\) and \(\Re z>a+2e\). Thus `LogarithmicActual.primitive_reciprocal_subpower:65` legitimately instantiates \(a=\beta\), without presupposing the final QRH theorem.

For \(\beta+8e\le\Re s\le2\), the same-height disk inclusion gives the bound. For \(\Re s>2\), `ReciprocalBound.reciprocal_norm_le:29` supplies the fixed absolutely convergent inverse-series bound. The final constant is enlarged by `bound 2`. In the principal case, the analytic reciprocal has value zero at 1 and elsewhere is transferred using \(|(s-1)/(s+1)|\le1\) on \(\Re s\ge0\). The proof does not identify the holomorphic regularization with the totalized raw reciprocal at a pole.

## 6. Acceptance limits and next source cuts

The local wrapper has no missing Euler-log or growth hypothesis after its actual instantiation. Its explicit disk-nonvanishing hypothesis is used honestly. Primitive ideal characters are essential to the uniform FE-derived growth input. The branch argument, character-uniform constants, principal pole handling, and strict/closed disk boundaries have been checked above.

This audit leaves the following foundations separate:

1. The period lattice, ideal-generator reindexing, and six-unit identification used by `IdealBridge` and `DyadicColumns`. The last summability step is the standard rank-two Mathlib lattice theorem, but this report does not independently establish every preceding arithmetic equivalence.
2. The primitive finite Gauss sum, actual Gaussian theta inversion, `PeriodicThetaRegularity.primitivePair`, and Mellin continuation/entireness. The concrete calls and actual functions have been traced; the full Poisson/theta proof has not been re-audited here.
3. `QuadraticSieve/MainTermDifference.lean:229`, `CubicReflectionKernel.Gamma_shifted_pair_bound`, and `Mellin/VerticalContourShift.lean:435`, `CubicGammaExponential.inverse_Gamma_strip_exp_bound_complex`. These supply the Gamma estimates used in the boundary and admissible-growth arguments. The elementary Mellin endpoint bound at line 142 was inspected separately.
4. The principal residue nonzero theorem below `HeckeReciprocal.regularizedL_ne_zero_at_one`, and the actual family-to-Dirichlet bridge. Neither is replaced by the local logarithm theorem.
5. Mathlib's branch-log existence, local inverse, analytic uniqueness, Borel-Caratheodory, Hadamard interpolation, Cauchy estimate, and Phragmen-Lindelof implementations. The precise source invocations were read. No new compilation establishes compatibility or transitive axioms under the target Lean/Mathlib versions.

Nothing here proves the later continuation mechanism forces \(\beta\le7/8\). It verifies one prerequisite for that mechanism. A full provider acceptance still requires those mathematical cuts, compatible elaboration, and the transitive kernel-axiom audit of the genuine exported theorem.

## 7. Source hashes

SHA256, raw local bytes. These hashes pin the main files and the additional inspected convergence/FE bodies, not the entire import closure.

| Path under the source root | SHA256 |
|---|---|
| `LogarithmicControl.lean` | `D337B355A705123E90D7FC5F2A6521464ACA6BB520737A5C26931ED97B7552E5` |
| `Hecke/Logarithmic.lean` | `03F29A2484577DBDDAB8B7092A7B131945CF179A87C2724320DFCF4A6AB10A8B` |
| `Hecke/LogarithmicActual.lean` | `3B6586669D48F18C1C291F8CF81086DB7250CB05013F3086057F8C4D26300599` |
| `Hecke/LogarithmicInput.lean` | `9ADCC4FDE13E8A257CDC81F4A1DA752949FCFCF339B856A40411BFE901DC6F0D` |
| `Hecke/EulerLog.lean` | `D3D3921F0F777FC6CF2093690A2318156E0F904B129BBAD5F8BFAF69F72F4FDF` |
| `Hecke/Boundary.lean` | `B0248FC7BEDCAB9F88A5F5D7BBF4908B75BDEA3E4AF9A2CEF47106A85A472599` |
| `IdealEuler.lean` | `D8EC594DEDB83661937B1DA00600AFE85A4A319434CE1C0B64543EF06A24BB59` |
| `Hecke/Euler.lean` | `89E3AFA01E51EB5CEB4C5FC863BB9F2639F655BD5736E4B480498B65586FFFD8` |
| `Hecke/IdealBridge.lean` | `D64B454F8DE573198F360DD4B4647DF87916020D4F89ECB44EB9B18D162A567F` |
| `Hecke/ReciprocalBound.lean` | `EBBED5A1FA1DCFAEEE9710B287780D44D439BDA86B23FD3DD364FDA575B50CFC` |
| `Hecke/ZeroSupremum.lean` | `F27256644A64572823B53CAE87483C4726192FF906EE7F64AE30E13F77E57242` |
| `Hecke/Family.lean` | `B18557C5C055910287507F1ED2B1F7BB31EDE318CB62A2A10A3140F1995A9408` |
| `Hecke/Strip.lean` | `E6E35BDEA0A7595D8AD88FB185A8C38367E8EC1878C9312E3D2BB0BE3C4F8AB8` |
| `Hecke/StripActual.lean` | `003AED36D61C7295441B12AD6BC0C7F71EDC2214AD9E3FE495872E819166FDAF` |
| `Hecke/Presentation.lean` | `F3C534C8949E50796A732770171A829B81D3035DB2DD03C62DFC4EE2B1AFF2DC` |
| `Hecke/PrincipalStrip.lean` | `E0EB332CD6C696C75989C373A549836574C3AE0E31B0C43B39AC82CA314794E4` |
| `Hecke/Primitive.lean` | `6E465C53301C4E1F20BF61A0CF03BC458D5C55138F9AA8459548329CEC644747` |
| `TraceCharacter.lean` | `831E3776B6EA0A85190F30100EB8569455201D3787F0DCC8E133FF5D1E417A81` |
| `QuadraticSieve/DyadicColumns.lean` | `06DD20DAD9FB49BFC615256402AA6664FAFB5125CB6AC11C701118057A47F87C` |
| `Eisenstein/FourierCoefficients.lean` | `428826F42C6D0830F305FC778DF97BE96E93DBCBF0467143A38FEEC674BC901C` |
| `Mellin/VerticalContourShift.lean` | `134E7C35AFB52CFE6282F1415F7304F84FC18C31C93AD9086FEE8440414C7ABD` |
