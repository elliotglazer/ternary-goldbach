# Actual source multiplier: bounded analytic production audit

Date: 2026-11-11. Verdict: PASS at the source and mathematical scope below. No build, Lean edit, analytic evaluation or spectral scan was performed. This does not validate the complete QRH provider.

## 1. Selected boundary

The preceding `QRH_ACTUAL_SIGNAL_MELLIN_AUDIT_2026-11-11.md` leaves the actual multiplier H and detector approximation/top-growth estimates as separate inputs. The remaining-source inventory, B4, names `Detector/FinalAssemblySource.actual_source_analytic` among the deeper producers. The accepted final-contradiction and ray-normalizer reports consume `sourceCorrection` or `SourceExclusions`; they do not reconstruct the local correction and normal-product argument audited here.

The new target is `Detector/FinalAssemblySource.lean:58`. For any actual Hecke character eta and finite S satisfying `SourceExclusions`, it supplies the mask for chi=eta.excludePrimes(S), analyticity of H=sourceCorrection(eta,S) on Re(s)>7/8, and |H(s)-1|<=1/2 throughout that half-plane. The mask theorem is retained from the previously audited character bridge. The two analytic conclusions are reconstructed below, including the existence of suitable finite exclusions. The proof does not assume eta is primitive, real, or nonprincipal.

Paths in this report are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/` unless otherwise specified. This audit does not claim `normalizedProbe_low` or the high approximation estimate has been established by the multiplier argument.

## 2. Exact product and actual local parameters

`PrincipalSignalComparison.lean:336` defines

\[
 H_\eta(s)=\operatorname{globalClosedCorrection}(\eta,S,s,1,1/6)
 =\prod_{P\notin S}F_{P,\eta}(s,1,1/6).
\]

The product is over the actual subtype of nonzero prime ideals outside S, once each; it is not over chosen generators with an uncharged unit multiplicity. `Detector/HighEulerRational.lean:25` defines each local factor as `unramifiedClosed(Q,A,e,1,x,w,z)`, where Q=absNorm(P), e=idealCoeff(eta,P), and

\[
 A=\overline{\operatorname{angularFactor}(p)}^{\,6}
      \operatorname{elementCoeff}(\eta,p)^6,
 \qquad p=\operatorname{primaryGenerator}(P).
\]

The conjugation in A and the fixed v=1 are retained. `EulerCoordinates.lean:11–37` defines, for general v,

\[
 V=Q^{-6z},\quad R=A Q^{4-6x-6z},\quad W=vQ^{-w},\quad
 D=e\bar vQ^{-x},\quad K=e(Q-1)Q^{-x-w}.
\]

Here Q is a positive real base, so the complex powers are entire functions of their exponent. Both |A|<=1 and |e|<=1 are actual-character bounds; no division by e or assumption |e|=1 occurs. Thus primes at which a character coefficient vanishes are permitted.

With q=Q^(-1), the exact rational definitions are

\[
 P_*={\{R(1-q)-KV\}/(1-V)-D+WR\over1-R},\qquad
 F={1-VW+(1-V)(1-W)P_*\over1-D}.
\]

These are `Euler.markedFactor` with a=1 and `Local.continuedCorrection`. In particular, the continued expression has no denominator 1-W. Its algebraic relation to the raw correction is conditional on nonzero raw denominators; analyticity here uses the continued expression directly, not a totalized raw quotient at a singular point.

For excluded bad primes the support condition is available: `SourceExclusions.lean:12` proves every outside prime is supported. `HighEulerRational.lean:17` then identifies the generator character value with the ideal character value. `GlobalCorrection.lean:131` and `SourceExclusions.lean:52` consequently identify this actual H with `principalCorrection` at (w,z)=(1,1/6). The name “principal” here does not impose a principal-character hypothesis on eta. The deeper derivation of the complete physical high-series Euler factorization is not re-audited in this report.

## 3. Summable local defect from the cancellation

The decisive identities are `Euler.lean:36` and `Local.lean:68`:

\[
 P_*+D={R((1-q)+(1-V)(W-D))-KV\over(1-R)(1-V)},
\]

\[
 F-1={D(V+W-VW)-VW+(1-V)(1-W)(P_*+D)\over1-D}.
\]

The first-order D term cancels before norms are taken. Bounding P_* and D separately would not recover the summable exponent used below.

`CorrectionBounds.lean:17–84` uses |R|,|V|,|D|<=1/2 and |q|<=1 to give

\[
 |P_*+D|\le12|R|(1+|W|)+4|K||V|,
\]

\[
 |F-1|\le2\{ |D|(|V|+|W|+|V||W|)+|V||W|
                 +2(1+|W|)|P_*+D|\}.
\]

The factors two are genuine inverse-denominator bounds: |1-u|>=1-|u|>=1/2. All denominators are certified nonzero before the rational identities are used.

`GlobalRegion.lean:8` works uniformly for Q>=4, |A|,|e|,|v|<=1 and
Re(x)>=7/8, Re(w)>=9/10, Re(z)>=4/25. Its coordinate bounds are

\[
 |V|\le Q^{-24/25},\quad |R|\le Q^{-221/100},\quad
 |W|\le Q^{-9/10},\quad |D|\le Q^{-7/8},\quad |K|\le Q^{-31/40}.
\]

All R,V,D exponents are at least 1/2, giving their half bounds for Q>=4. Put T=Q^(-17/10). The products KV, DV, DW, VW are at most T: their decay exponents are respectively 347/200, 367/200, 71/40 and 93/50, each greater than 17/10. Also |R|<=T, |W|<=1 and |D||V||W|<=T. Hence |P_*+D|<=28T, (1+|W|)|P_*+D|<=56T, and the second displayed inequality gives at most 232T, safely below the source's 240T. This reconstructs the numerical bound rather than merely quoting its theorem.

`GlobalHolomorphic.lean:59–86` checks the same three denominators on this region and uses the entire coordinate functions and rational expression to establish analyticity in x on the open half-plane. At w=1,z=1/6 the domain inequalities hold strictly where needed. Thus the proof includes every imaginary height of x, not a finite vertical window. It makes no use of a zero-free region for any L-function.

## 4. The excluded tail is actually obtainable

Let b(P)=240 absNorm(P)^(-17/10). `GlobalCorrection.lean:25` proves summability by restricting the absolutely summable full-ideal norm weight at 17/10 to prime ideals. The previously inspected `QuadraticSieve/DyadicColumns.fullIdealWeight_summable_norm:209` is the source of that convergence. In particular this step requires only exponent 17/10>1, not PNT, GRH, or a prime density estimate.

`CorrectionTail(S)` requires absNorm(P)>=4 outside S and the actual complementary sum of b(P) to be <=1/6. `exists_uniform_global_cutoff:140` derives this, rather than postulating it: convergence gives a finite prime set F with complementary sum <1/6; let N be the maximum of 4 and the norms in F. Every S containing all prime ideals of norm <=N has complementary prime subtype injectively contained in the complement of F. Nonnegative-term comparison proves the required sum bound; its outside primes have norm >N>=4. This cutoff is chosen before S, eta, x,w,z, and imaginary heights.

`PrincipalProduct.lean:102` defines `smallPrimeSet(N)` using finiteness of ideals of bounded norm. `SourceExclusions.lean:29` constructs S=S0 union smallPrimeSet(N), for an initial finite prime set S0 containing the fixed bad primes. It preserves primality and bad-prime inclusion and obtains CorrectionTail. Thus the multiplier input is not vacuous. Enlarging S only improves the nonnegative complementary tail. The optional assembly in `PrimeRows/FirstTail.lean:81` takes the maximum of two cutoffs to preserve both this condition and an independent FirstTail condition; the latter analytic bound is not reproved here.

No effective N, computational estimate for its size, or growing-modulus threshold is claimed. This is an existence argument for one finite exclusion set. It is nevertheless uniform in the actual character eta, because b(P) contains no eta.

## 5. Genuine product, analytic logarithms and nonvanishing

For a fixed allowed point, each factor satisfies |F_P-1|<=b(P). Nonnegativity and summability imply b(P)<=sum b<=1/6, hence in particular b(P)<=1/2. Therefore each F_P lies in the disk centered at 1 of radius 1/2, is nonzero and belongs to the logarithm's slit plane.

`NormalProduct.lean:17–48` proves

\[
 |\log F_P|\le\tfrac32|F_P-1|,\quad
 \sum_P|\log F_P|<\infty,\quad
 \left|\sum_P\log F_P\right|\le\tfrac14.
\]

Exponentiating the HasSum statement gives a HasProd statement; finite products agree since exp(log F_P)=F_P. Consequently the actual infinite product equals exp(sum log F_P). This excludes a default-value interpretation of an undefined product. It also proves nonvanishing directly.

For analyticity, `NormalProduct.lean:58` composes each analytic factor with the same principal logarithm on the slit plane. The uniform majorant (3/2)b(P), independent of the point throughout Re(x)>7/8, permits the analytic sum theorem. Exponentiation recovers the product. No pointwise-convergence-only claim is substituted for locally uniform analytic convergence.

Finally the elementary source bound |exp(z)-1|<=2|z| for |z|<=1 yields |H-1|<=1/2. The source invokes it with the stronger |z|<=1/4. Therefore |H|>=1/2 throughout Re(s)>7/8. This is a nonzero actual multiplier, not an assumed nonzero symbol. The construction also supplies the asserted differentiability and the separate analytic-on-neighborhood form used by the consumer on its open half-plane.

## 6. Consumer, quantifiers and remaining cut

`PrincipalSignalComparison.lean:344,349` specializes the just-proved product estimates to H(eta,S); `FinalAssemblySource.lean:58` pairs them with the actual exclusion mask for chi. H remains built from eta while the signal's L-function uses chi=eta.excludePrimes(S); those are not silently identified. Their relation in the full principal-signal comparison is a separate algebraic/analytic input.

The construction supplies H for every character and every admissible S, uniformly over the full half-plane. It is independent of the width/energy induction and does not use the desired beta<=7/8 statement. Together with the preceding signal audit it discharges the multiplier analyticity/contraction input at this local source scope.

Still not discharged here: the physical probe's low bound, the high approximation error to the signal, the complete local-series-to-physical Euler factorization, and the deeper ideal-character/angular-factor, ideal norm finiteness, lattice summability and library analytic-limit foundations. In particular, the Gaussian numerator exp((s-5/6)^2)H(s) is nonzero, but neither a nonzero physical probe nor its claimed approximation accuracy follows from that alone. The next B4 work should address an actual approximation/top-growth or raw-fiber endpoint producer, not repeat the multiplier or Mellin transforms.

## 7. Frozen source pins

The following pins identify source inspected for this bounded audit. They do not assert target-version compilation or replace an axiom audit.


| File | SHA-256 |
|---|---|
| Detector/FinalAssemblySource.lean | `03F9668E3D43A20F5F1EF554C852BFCA64CBF90EC5D4C305114EC166BD1954E9` |
| PrincipalSignalComparison.lean | `FB59CCAED042EA0D445CA08B5333D0FD248B8DB8EE12E691F79A32A351E1B08D` |
| Detector/GlobalCorrection.lean | `E884072EED927E5260281E7F6065262B7D3209D2825B52836C9571841630FEF9` |
| Detector/NormalProduct.lean | `4025DC031564348772D7C00B1802FCBEC923E2A4349480BFC0AAC64B08522474` |
| Detector/GlobalRegion.lean | `84E686D9A768FAF35E459DC148F1C873F2AD6DD5707A63F851316CE9691D8FF0` |
| Detector/CorrectionBounds.lean | `33E085F02F2DC1730DFCFBA1920E8338B0BDEEA4DD127EBE2751B41A8FA5A850` |
| Detector/Local.lean | `9D418F882E1ED6D269F6A0DC337102EB43FF1CF62EC40AF0365225450CFCA818` |
| Detector/Euler.lean | `9CAE86F2B419B62E1431B82EEEB822408036E23F0A5E98C4D6434B12D5650CC9` |
| Detector/EulerCoordinates.lean | `CE9F747EFFB340BFA0DCECFE0681C4C85AD608B589B203E42EE61525A9804084` |
| Detector/EulerRegion.lean | `264072DCF96D45AFC6B71B9F12CBA8FAA3046773751FDB62B556EC508CD535F4` |
| Detector/EulerHolomorphic.lean | `C9EE90D578A016C57EB25B4EE9F42D752406E92335476EC09D504B6DF2FEF105` |
| Detector/GlobalHolomorphic.lean | `99020B9DB664C4DBCA533C162AF368BA432E656C47A2B00605B287D340AFA308` |
| Detector/HighEulerRational.lean | `5D4CDBC1BC273C77AA3EA931997F440169B71A885B83D83135D28ADD7659EAD7` |
| Detector/SourceExclusions.lean | `7CE136A63D2478F75C876BC7404717A426B97829132B9C634647009A4CB8D650` |
| Detector/PrincipalProduct.lean | `CDCFDD25D5E27712A3A8349246BD3D29F7EDC2E6E3987925DB66F5EC33D28708` |
| PrimeRows/FirstTail.lean | `BE3D26D2846B67DF0A208D6050600A9A8CEA312FC8B052CB1C0763FE8369E7EE` |
| QuadraticSieve/DyadicColumns.lean | `06DD20DAD9FB49BFC615256402AA6664FAFB5125CB6AC11C701118057A47F87C` |
