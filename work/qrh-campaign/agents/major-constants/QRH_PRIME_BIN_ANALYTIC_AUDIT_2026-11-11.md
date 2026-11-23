# Prime-bin analytic bound: bounded mathematical source audit

Date: 2026-11-11. Status: no defect found in the reconstructed chain below, conditional on the explicitly retained analytic foundations. This is static source/mathematical review, not an elaboration, axiom, or global QRH validation. No Lean build, numerical function evaluation, prime scan, or source modification was performed.

The starting point is `Moments/PrimeGlobal.lean:28`, previously left at a wrapper boundary in `QRH_ENERGY_INDUCTION_MATH_AUDIT_2026-11-11.md`. The current checkpoint and `work/qrh-blueprint/QRH_PROVIDER_MATH_FRONTIER_2026-11-11.md` were read before this audit. Source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`; byte hashes appear at the end. The repository baseline is the previously recorded `4eaee87548250b2682affda7d05d947c05554bae`; hashes, rather than that label alone, bind this review.

## 1. What the theorem actually estimates

`Hecke/Family.lean:22` defines finite-modulus characters of the Eisenstein integer ring, trivial on global units. There is no unbounded angular character parameter hidden in this structure. The separate real frequency enters through `Hecke/Dyadic.lean:40`,

\[
  \operatorname{shift}(\sigma,\omega)=\sigma-i\omega.
\]

For smooth compactly supported `W`, with support in `[A,B]` and `A>0`, the actual prime polynomial is

\[
 P_\chi(D;\sigma,\omega)=D^{-1/2}
 \sum_{\mathfrak p\in\mathrm{annulusSet}(B,D)}
 \chi(\mathfrak p)W(N\mathfrak p/D)
 (N\mathfrak p/D)^{-\sigma+i\omega}.
\]

The ray version restricts to the identity ray class. These are the bodies in `PrimeAnnular.lean:13–20` and `PrimeRay.lean:20–23`, not arbitrary functions satisfying an estimate. Support containment justifies the finite annulus despite its coarse upper endpoint `floor(max(1,B)*D)`.

Write `U=Z^d`, `D=U^r`, `T=Z^tau`. `PrimeBin.lean:13` proves

\[
 |P_\chi(D;\sigma,\omega)|\le C U^{(a-1/2)r+\varepsilon},                 \tag{1}
\]

under the finite-zero, height, and conductor conditions below. `PrimeGlobal.lean:28` applies this to the ray polynomial with `a=beta`, then squares it:

\[
 |P_{\rm ray}|^2\le C' U^{\kappa r+2\varepsilon},\qquad 2\beta-1\le\kappa.
\]

Here `beta` is the source-defined supremum of actual zero real parts, with a `1/2` sentinel (`ZeroSupremum.lean:10–16`). Only `beta<=1` and `beta>=.51` are used at this application. **The bound does not assume or prove `beta<=7/8`.** If `beta=1`, its exponent is correspondingly weak. It supplies an upper bound parametrized by the true supremum; an improvement of that supremum must come from the later energy argument.

## 2. Finite zeros really give the required zero-free region

`DetectorZeros.lean:13–83` uses all actual zeros in the closed rectangle

\[
 .51\le\Re s\le1,\qquad |\Im s|\le H_*.
\]

Finiteness comes from the nonprincipal entire function and its nonzero value at `2`, not from a finite numerical list. A finite union over the supplied family is taken, and `.51` is inserted before taking the maximum. This is a location maximum: multiplicities can be discarded here because existence/nonexistence of a zero is unchanged. No zero-count or multiplicity-weighted estimate is inferred from this construction.

The hypothesis is

\[
 \mathrm{zeroMaximum}(3(i+1)T)<a+2e,
 \quad .51\le a\le1,\quad 0<e<.001,\quad T>2.
\]

For `|t|<=(3i+2)T`, `nonzero_on_buffered_disk` (`DetectorZeros.lean:113`) proves nonvanishing on the **closed** disk centered at `2+it`, radius `2-a-2e`. Indeed, a zero there has real part at least `a+2e>=.51`. Euler nonvanishing excludes real part above `1`; the imaginary part is at most `(3i+2)T+(2-a-2e)<3(i+1)T`. It would therefore belong to the finite zero set and contradict the strict maximum bound. The actual radius is positive (greater than `.998`), so this use is not an empty-disk argument.

`PrimeGlobal.lean:12–23` proves maximum `<=beta`, including the `.51` sentinel by its explicit `hbeta` hypothesis. Taking `a=beta` makes the needed inequality strict because `e>0`. No attainment of the global supremum is needed. The separate combinatorial `exists_actual_buffered_bin` in `DetectorZeros` is not needed for this global application.

## 3. The analytic estimate inside that region

`PrimeDyadicControl.lean:28–67` proves, for the actual possibly imprimitive character,

\[
 \left|\frac{L'_\chi}{L_\chi}(z)\right|
 \le B_e\log\mathcal C_\chi(t)
       +c_{1/2}\log N(\operatorname{rad}\mathfrak m_\chi),
 \quad \mathcal C_\chi(t)=2N\mathfrak m_\chi(3+|t|)^2,                  \tag{2}
\]

on the smaller disk of radius `2-a-8e`. The constant `B_e` is chosen before the character, center height and `a`.

The nonprincipal primitive step is substantive, not a restatement of (2):

1. `LogarithmicInput.lean:122–153,195–225` obtains a polynomial bound for the regularized actual function from a primitive strip bound and the absolutely convergent right half-plane. For nonprincipal characters the regularized function is exactly `LFunction` (`:14`). Its disk estimate is `4*uniformConstant*(N modulus)^(3/5)*(3+|t|)^2`.
2. `Logarithmic.lean:26–46` absorbs this into `mathcal C^M`, with one `M>=1` chosen uniformly before the primitive character, `a,e,t`. This uses `mathcal C>=exp(1)` and `(N modulus)^(3/5)<=N modulus`.
3. `LogarithmicActual.lean:23–48` supplies an actual Euler logarithm, holomorphic in the radius-`1/2` disk at `2+it`, bounded by one constant on radius `.49`. Its exponential equals the actual function there. Thus its imaginary additive constant is fixed by the Euler logarithm, not arbitrarily set to zero at a complex center.
4. `LogarithmicControl.lean:375–403` extends that logarithm over the supplied zero-free disk and normalizes it to agree with the inner Euler logarithm. Consequently `Re g<=M log mathcal C` on radius `2-a-3e`, and `|g(center)|<=A`.
5. Borel–Caratheodory (`:302–328`) gives `|g|<=K log mathcal C` on radius `2-a-4e`, where `K=(4M+4A)/e`. Cauchy's derivative bound on a radius-`2e` circle at a point of radius `2-a-8e` then gives `|g'|<=K/(2e)*log mathcal C` (`:351–373`). The circle lies within the region just bounded: its points have distance at most `2-a-6e` from the original center. Finally `g'=L'/L` is proved using the local exponential identity (`:405–417`). This reconstructs the derivative estimate without a zero-density or desired-beta assumption.

The written `logarithmic_control` theorem also proves a stronger subpower bound for `|L|+|1/L|` via three circles. The prime-bin application selects its derivative component; that stronger component is not mathematically needed for (2), although it remains part of the source theorem's proof/dependencies. This audit does not silently replace the source with a different compiled theorem.

For imprimitive characters, the proof chooses a primitive inducing character of no larger modulus and uses the exact finite Euler-factor identity (`PrimeDyadicControl.lean:13–26`). Nonvanishing of the original function implies nonvanishing of the primitive function on this positive-real-part disk. The logarithmic derivative is the sum of the primitive term and the finite-deletion term. `DeletionDerivative.factors_logDeriv_norm` supplies exactly the second term of (2), valid for `Re z>=1/2`. It is retained throughout; no imprimitive factor is dropped.

`buffered_rectangle_control` (`PrimeDyadicControl.lean:85`) applies these disks at each point's own imaginary part and bounds their complexities by the single height `(3i+2)T`. Thus (2) and nonvanishing hold throughout the closed rectangle `a+8e<=Re z<=2`, `|Im z|<=(3i+2)T`.

## 4. Mellin normalization and the finite contour

`PrimeDyadic.lean:15–24,73–117` first treats the Mangoldt-weighted polynomial. Its Dirichlet series is the actual `-L'/L` on `Re s>1`. Absolute summability of the twisted coefficients is explicitly supplied before invoking weighted Mellin inversion. The result is

\[
 P_{\Lambda,\chi}(D)=\frac1{2\pi}\int_{\mathbb R}
 \widehat W(c+iv)D^{c+iv+\sigma-i\omega-1/2}
 \frac{-L'_\chi}{L_\chi}(c+iv+\sigma-i\omega)\,dv .                 \tag{3}
\]

In particular the external normalization is `D^-1/2`; the frequency shifts the height by `-omega`, not the real exponent. The `1/(2*pi)` results from vertical parametrization, with no missing `i`.

`PrimeDyadicContour.lean:73–125` moves only the central segment, from `Re s=2-sigma` to `Re s=a+8e-sigma` and `|Im s|<=V`. The rectangle is holomorphic by the preceding nonvanishing result, using `|omega|+V<=(3i+2)T`. The exact identity has left vertical integral plus `i*(bottom-top)`, **plus the unchanged right-line integral outside `[-V,V]`**. No limiting horizontal contour or unproved disappearance of a tail is used.

Let `Kchi` denote the right side of (2) at the bin height; let the Mellin bounds be `C2/(1+|v|)^2` on the left line and `Cn/(1+|v|)^(n+2)` throughout the strip. `PrimeDyadicEstimates.lean:13–128` gives

\[
 |P_{\Lambda,\chi}|\le\frac1{2\pi}
 \left[C_2D^{a+8e-1/2}K_\chi\pi
 +\frac{2C_nD^{3/2}K_\chi}{(1+V)^n}|2-a-8e|
 +\frac{C_nD^{3/2}E(2)\pi}{(1+V)^n}\right].                    \tag{4}
\]

The center uses comparison with `(1+v^2)^-1`, whose full integral is `pi`; the two horizontal joins retain their width. The exterior right line uses the absolute Euler/Mangoldt bound `E(2)`, whose summability and norm comparison are proved in `PrimeDyadicEuler.lean:12–54` from the Euler-series input. This makes (4) a genuine three-part estimate.

## 5. Uniform constants, external tail, and removal of prime powers

The parameter conditions are `Z>=1`, `0<=d<=dmax`, `U>=2`, `0<=r<=R`, `T>2`, all modulus norms `<=U`, and

\[
 (3+(3i+2)T)^2\le U^\eta,\quad \eta\ge0,
 \quad 8eR+s\le\varepsilon,\quad s>0.                         \tag{5}
\]

Here `s` denotes the source's positive slack parameter, called `kappa` in the intermediate files; it is not the final squared exponent `kappa` in `PrimeGlobal`.

`PrimeDyadicScale.lean:10–51` proves

\[
 K_\chi\le[B_e(2+\eta)+c_{1/2}]\log U
 \le \frac{B_e(2+\eta)+c_{1/2}}s U^s.
\]

It uses both the modulus bound and the explicit height condition in (5); it is not uniform over unrestricted frequency at fixed `U`. `PrimeDyadicScaled.lean:12–121` inserts this into (4), retaining

\[
 C C_2 U^{(a-1/2+8e)r+s}
 + C C_n\frac{U^{2R+s}}{(1+V)^n}.                            \tag{6}
\]

The source legitimately uses `3r/2<=2R`, `|2-a-8e|<=2`, and `1/(2pi)<=1` to enlarge the estimate. These sacrifices affect constants but do not introduce unaccounted powers of `U`.

`PrimeDyadicSource.lean:14` takes `V=T/2`. An integer `n` with `tau*n>dmax*(2R+s)` suffices to bound the second ratio in (6) by `2^n`, uniformly over `d` (`DyadicTailBudget.lean:8,31`). Thus the external tail is controlled, not truncated away. The first exponent is at most `(a-1/2)r+epsilon` by (5); the latter target exponent is nonnegative, so the bounded tail can be absorbed into the same power for `U>=1`.

To obtain primes, `PrimeLogProfile.lean` supplies the smooth family

\[
 W_\lambda(y)=W(y)\lambda\,\mathrm{safeInverse}(1+\lambda\log y).
\]

Joint compact smoothness gives Mellin constants uniform over `lambda in [0,1]`, `sigma in [sigmaMin,sigmaMax]` and the necessary real Mellin strip. The actual choice `lambda=1/log D` obeys this range because the theorem assumes
`log D>=2(|log A|+|log B|)+1`. On support, `1+lambda log y>=1/2`, so the safe inverse is the genuine inverse and `Wlambda(y)=W(y)/log(Dy)`. This is checked by the last theorem of that file; a zero or tiny `log D` is not silently allowed.

`PrimeAnnular.lean:35` then identifies the modified Mangoldt polynomial with the finite sum having weight `Lambda(I)/log NI`. `PrimePowers.lean:26–59` verifies this weight is one on primes, lies in `[0,1]`, and vanishes away from prime powers. Nonprime prime powers are powerful ideals. Its `:61` applies the separate counting theorem `CompletedGauss.powerful_ideal_count` to bound their contribution by `C X^(1/2+xi)` times the weight norm. After `D^-1/2` normalization, `PrimeAnnular.lean:85` obtains `E D^xi`, uniformly in frequency. The fixed compact weight bound uses `|(NI/D)^(i omega)|=1`.

Finally `PrimeBin` chooses `xi=epsilon/(R+1)`. Since `xi*r<=epsilon` and `a>=.51`, this error is bounded by a constant times the target power in (1). The constants depend on the fixed profile/support, compact sigma range, `R,dmax,tau,epsilon,e,s,eta`, but precede the finite family, its cardinality, `Z,d,a,i,r,sigma,omega`. They are not claimed numerically effective or uniform as any positive buffer/slack tends to zero.

## 6. Ray averaging, global exponent, and noncircularity

`PrimeRay.lean:25–77` uses exact finite character orthogonality:

\[
 P_{\rm ray}=h^{-1}\sum_{\theta\in\widehat{\mathrm{Ray}}}
 P_{\chi\theta},\qquad |\widehat{\mathrm{Ray}}|=h>0.
\]

The triangle inequality cancels exactly the factor `h`; this is not square-root cancellation or a large-sieve bound. Every twist must be nonprincipal and have modulus norm `<=U`; these are explicit quantified hypotheses. The same `C` from (1) therefore bounds the ray polynomial. Squaring gives exponent `(2beta-1)r+2epsilon`, bounded by `kappa*r+2epsilon` because `r>=0`. The source returns `C^2`, retaining positivity.

The inspected body chain uses the global supremum only at the last finite-maximum comparison. Earlier finite-bin estimates require a supplied local maximum bound and prove the corresponding estimate; they never assume the desired `7/8` conclusion. The source contains other beta-dependent reciprocal lemmas, but `PrimeDyadicControl.original_disk_control` calls `disk_control`, not `primitive_reciprocal_subpower`. Its zero-free premise is supplied directly by `DetectorZeros`. Importing a file with such lemmas does not by itself create a circular proof dependency.

This audit found no mathematical defect in these identities, geometry, inequalities, or quantified-constant transitions. It also found no hidden numerical zero certificate, discarded imprimitive term, family-cardinality loss, or unbounded-frequency uniformity claim in this chain.

## 7. Exact remaining boundary

The following are retained source inputs, not established from first principles in this bounded round:

| Input at the boundary | Exact declaration / source point | What still needs deeper validation |
|---|---|---|
| Actual primitive strip growth | `HeckePresentation.uniform_strip_bound`, `Hecke/Presentation.lean:83`, used by `LogarithmicInput:122` | Actual finite-character presentation, functional equation, Gamma bounds and strip interpolation; the adapter was identified, not its complete analytic foundation audited here. |
| Uniform actual Euler logarithm | `HeckeEulerLog.continued_inner_disk`, `Hecke/EulerLog.lean:149`, used by `LogarithmicActual:23` | Euler product/log-series convergence, normalization and equality with the analytically continued function. |
| Primitive induction and local factors | `exists_primitive_character`, `LFunction_eq_of_mask_nonprincipal`, `HeckeDeletionDerivative.factors_logDeriv_norm` (`Hecke/DeletionDerivative.lean:39`) | Conductor descent, exact factorization and the finite local-factor estimate. Their use and norm factors in the inspected adapter are checked. |
| Actual log derivative Dirichlet series | `HeckeLogDerivative.coeff_LSeries_eq`, consumed at `PrimeDyadic.lean:24` | Euler differentiation and the Mangoldt coefficient identity/convergence. |
| Mellin inversion and smooth-family decay | `CompletedGauss.weightedMellin_inversion`, `Eisenstein/SourceMellinInversion.lean:225`; `CompactProfileFamily.compact_fourier_weighted_bound`, consumed by `PrimeLogProfile` | Inversion/Fubini and the full uniform Fourier-decay proof. The normalization and parameter substitutions above are checked. |
| Powerful ideal count | `CompletedGauss.powerful_ideal_count`, `CubicSieve/CubeBlocks.lean:588` | The underlying ideal-counting/decomposition proof. Prime-power support, normalization, and its application above are checked. |
| Standard complex-analysis and summability facts | Holomorphic logarithm, Borel–Caratheodory, Cauchy, rectangle integral and elementary norm-tail APIs | Correct use inspected; no independent reproving or compiled verification of these libraries. |

The analytic derivative step has therefore moved beyond the previous wrapper boundary to a concrete zero-free-disk proof and finite-contour estimate. It has not validated the global provider, the later energy gain, or the foundational inputs listed here. No claim is made that all source transitive axioms are standard, that all files elaborate under the current toolchain, or that static consistency substitutes for either check.

## 8. Source byte manifest

Hashes below bind the files used for the stated proof bodies or exact boundary declarations. Merely appearing in this manifest does not mean every declaration in a file was audited.

| File | SHA256 |
|---|---|
| Moments/PrimeGlobal.lean | `8FFC0F6629F775AA1BD9DA2CC1FB61F4D37DD710B214035299C800EC8DFFFE9E` |
| Hecke/Family.lean | `B18557C5C055910287507F1ED2B1F7BB31EDE318CB62A2A10A3140F1995A9408` |
| Hecke/Dyadic.lean | `15E88379D7386D4D0A873C8D2467EF28AF8ED5FB7392219D634F616B9D36C2A2` |
| Hecke/PrimeRay.lean | `CA691B3732199B35B2C7A6BF1F8C1F7815D50069DC899E0DEE928DABAF7DF895` |
| Hecke/PrimeBin.lean | `49DF819F59D7D7D0F15BDEDBFC198CA579E1F5AA72C7553D717E3CACD3FBB79B` |
| Hecke/PrimeDyadicSource.lean | `0BE9777D15BAAF0FE6A036557471D7DB230EDA1CE85BE78DC6E00A579D7CF5DC` |
| Hecke/PrimeDyadicScaled.lean | `552CB44406A2B1E18D155F9C7737CA519BA855DF74A96CAA0621B687C35F9A0D` |
| Hecke/PrimeDyadicScale.lean | `881F005A043DB04485041EC6D7DBA697605F0CC6786E87548FE8508B5E15160D` |
| Hecke/PrimeDyadicBuffered.lean | `8E2644D6485311E8A2E7ED92E1994DA7F0B1C130D9A55C4DB17CA1620231E469` |
| Hecke/PrimeDyadicControl.lean | `3B33CC3222945C05C787BD48C81A3CADF07402969C735FE1CE630565A98FF752` |
| Hecke/PrimeDyadicEstimates.lean | `D3A54812759CC07B61029AA3C1AD46C7259941879FA36743AAE17ECFF674DB2E` |
| Hecke/PrimeDyadicContour.lean | `F1BC317704DCCE609D1D659CCCF735E128D63F0326701875FD95B17F2166C01C` |
| Hecke/PrimeDyadicEuler.lean | `6F87DE3B233284AB2F3EB8F2130BEF58C7D2E08A8CC5A65D2C19F1437938793F` |
| Hecke/PrimeDyadic.lean | `31806E0A1915B831ECE1B5F6F761D57C494C57DE5BF977E214050F9C1A8AF9E7` |
| Hecke/PrimeAnnular.lean | `63308889A785B3E031666785BD8D2EB69265AD1503B8802BB4EB0E0BF9E16815` |
| Hecke/PrimePowers.lean | `F7EF767AE1B7785B25C4DB74586525076C79CD690AD014D39080789B532732E4` |
| Hecke/DetectorZeros.lean | `2ABE0E6D801CA5F3C136FDF89E5DD4F36C0FAFE25ED012E9EC157019FC0F06B8` |
| PrimeLogProfile.lean | `6489106535C2B6DB1E3FB1602D5829D29AE04C63EDBE42AD04215B1FF00AD4F1` |
| Hecke/DyadicTailBudget.lean | `19BF6655E9B74ADB19078331BE48D528B089162E812291AC841601CD94F7A829` |
| Hecke/ZeroSupremum.lean | `F27256644A64572823B53CAE87483C4726192FF906EE7F64AE30E13F77E57242` |
| Hecke/LogarithmicActual.lean | `3B6586669D48F18C1C291F8CF81086DB7250CB05013F3086057F8C4D26300599` |
| Hecke/Logarithmic.lean | `03F29A2484577DBDDAB8B7092A7B131945CF179A87C2724320DFCF4A6AB10A8B` |
| Hecke/LogarithmicInput.lean | `9ADCC4FDE13E8A257CDC81F4A1DA752949FCFCF339B856A40411BFE901DC6F0D` |
| LogarithmicControl.lean | `D337B355A705123E90D7FC5F2A6521464ACA6BB520737A5C26931ED97B7552E5` |
| Hecke/Presentation.lean | `F3C534C8949E50796A732770171A829B81D3035DB2DD03C62DFC4EE2B1AFF2DC` |
| Hecke/StripActual.lean | `003AED36D61C7295441B12AD6BC0C7F71EDC2214AD9E3FE495872E819166FDAF` |
| Hecke/EulerLog.lean | `D3D3921F0F777FC6CF2093690A2318156E0F904B129BBAD5F8BFAF69F72F4FDF` |
| Hecke/DeletionDerivative.lean | `9D4085237057FF4C782EE5B737CFEF2F5271ADD6CAE75027D8F20070DAB3E4C6` |
| Hecke/FiniteDeletion.lean | `8186CCBFBB6D3BD95E65AD807C852B82204C689664CDDEDAB2407035911AE72C` |
| Hecke/IdealOperations.lean | `6760E7000AD9A8EC58BC78A52F598F20F292F17201161C36E50296D3D46B01F2` |
| Hecke/LogDerivative.lean | `6F976319CAF6739E01ED21F71F4BF511DABAF643ADDB58242C8C3AB895D05895` |
| Eisenstein/SourceMellinInversion.lean | `76820ED85502C5126C603800D21C59F976DDBDE2248D094266A8406F96E722FE` |
| CubicSieve/CubeBlocks.lean | `884B6EA5831F26DE61DB1091E4F603B31505791F089B335C5008EAB16C3C2BE0` |
