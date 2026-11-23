# Independent review: detector moments to the zero contradiction

2026-11-11. Verdict: **PASS for the bounded mathematical/source audit described below**, not for the complete seven-eighths theorem. No build, Lean declaration, source change, evaluator, spectral computation, or transitive-axiom validation was performed. The current research checkpoint was read; no finite spectral premise is supplied by this review.

Reviewed author: `../integration/QRH_DETECTOR_CONTRADICTION_MATH_AUDIT_2026-11-11.md`, SHA256 `B28B9982BEAD587411C9FC10F5D61C06A03073E59B3701F85B8B328C6CF48ABC`. This supersedes `2786839B...` after the author corrected the distinction between a nonzero normalization denominator and a nonzero probe function. All 31 source hashes in the final author's section 9 were independently recomputed and matched. Paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, repository commit `4eaee87548250b2682affda7d05d947c05554bae`.

## 1. Actual carrier and the zero used in the contradiction

I independently traced the bridge from an actual Dirichlet zero, rather than starting with the abstract moment contract. `Hecke/Family.lean:14-29` uses characters of ideal quotients in the Eisenstein field with unit triviality and a positive period. `Hecke/IdealBridge.lean:95` defines its L-function from the continued lattice sum divided by 6. These are substantive analytic constructions, not a renaming of the desired Dirichlet L-function.

`Hecke/Dirichlet.lean:71,112,128,158` constructs the norm-induced character, proves the Euler product identity in the right half-plane, and extends it away from 0 and 1. Thus an actual Dirichlet zero with `7/8 < Re(s) < 1` produces a zero of the Hecke product at the same point. The branch `Re(s) >= 1` instead uses the existing Dirichlet nonvanishing theorem with the original pole exception. This avoids applying a Dirichlet series outside its convergence half-plane. The continued-product and lattice foundations remain inputs to this bounded review.

`Hecke/ZeroSupremum.lean:10-48` defines beta using real parts of actual zeros with positive real part and the nonpole condition, together with a 1/2 sentinel. The sentinel proves nonemptiness; Euler nonvanishing above 1 proves boundedness. Every admissible actual zero is bounded by beta. Neither attainment nor existence of a zero at the sentinel is assumed.

`Hecke/PrimitiveSupremum.lean:29,46` uses finite deletion at the same complex point to obtain a primitive zero strictly above `beta-epsilon`, provided `epsilon > 0` and `beta-epsilon >= 1/2`. In the final application the latter boundary is strictly above 7/8. The selected element cannot be the sentinel. `Hecke/FiniteDeletion.lean:32,97,126-159` supplies nonvanishing Euler factors and principal-character compatibility. Primitive descent needs the former; transferring a primitive zero to its excluded-prime mask only needs the product identity. This distinction and the possible nonprincipal point s=1 are handled correctly.

## 2. Chosen data, normalization and uniformity

`Detector/FinalAssemblyChosenData.lean:13-28` orders its quantifiers as follows: under beta>7/8, choose D, F, counts and one exponent J>=0; then for every character choose C>0; then quantify over the height parameter tau and an eventual Z threshold. J does not depend on the character or tau. Thresholds may depend on both. The later contradiction requires a common positive saving, not common numerical constants or starting heights across all characters.

The existence step at `:30` is not a universal statement over an empty type. `ParametersHighDataFine.lean:10` builds positive parameters and slots after the positive mesh is fixed. `Detector/FinalAssemblyData.lean:33,46` builds F and counts. `ParametersProbeWindows.lean:9` constructs an actual bump with a nonzero value, and `ParametersFixedSource.lean:24,38` supplies the source exclusions and window. The count record has theorem-shaped fields, but `Detector/FinalAssemblyCountParameters.lean:49` constructs them using the two adaptive count producers. Those producers remain substantive leaves, not hypotheses silently discharged by a definition. The author's locator `:48` is one line before this theorem, a harmless locator discrepancy.

The source probe is divided by the residue/principal normalizer. `Detector/LowNormalized.lean:13` and `PrimeRows/CubeNormalizer.lean:13` explicitly conclude eventual nonvanishing of that denominator. Its proof calls the ray-mass and signed-source-normalizer results. These are genuine obligations; totalized division is not a substitute for them.

My sole requested correction concerned the original opening's implication that these facts establish a nonzero probe function. They do not. The final author text now states the right conclusion: nonempty chosen data, nonzero windows and eventual nonzero denominator remove these particular vacuities, while even an identically zero probe would still have to satisfy the actual-signal approximation. No independent nonzero-probe theorem is claimed or needed in this upper argument.

After the uniform J is known, the fine construction's positive choice `tau=min(cost/3200,min(1/800,t/(4(J+7))))` supplies the height inequalities. For Z>=1, `C(1+Z^(2tau))^J <= C*2^J*Z^(2tau*J) <= C*2^J*Z^t`. This matches `FinalAssemblyMomentInput.lean:41` and `FinalAssemblyChosenData.lean:38`. It would not justify a uniform saving if J were chosen separately after each character; the actual order avoids that error.

## 3. Certified input and high-bound assembly

I checked the selected route through `FinalAssemblyUnconditional`, `FinalAssemblyCertifiedBands`, and `FinalAssemblyChosenData`, rather than treating the parallel raw-moment wrapper as unconditional. With Delta=beta-7/8, `kappaPlain=3/4+2Delta=2beta-1`. The terminal certificate's beta and kappa inequalities follow from the contradiction assumption and this equality; they do not assume beta<=7/8.

The finite induction in `Energy/CertifiedExistence.lean:19,40` uses the floor and previous-stage bounds. The inspected successor assembly passes old-stage zero/positive bounds to the low/high/zero constructions. Reading this assembly does not prove those constructions. The fixed-ideal gates are nonvacuous: `Moments/NaturalFixedRaySourceFixedIdeal.lean:16-36` and `DetectorEnergyInitialState.lean:100` prove the nonzero/proper/containment conditions for the actual source ideal. The three moment inputs have uniform exponents; the combination at `FinalAssemblyCertifiedBands.lean:80` supplies all four components of the actual source-moment predicate.

I also read `FinalAssemblyFixedHigh`, the transport/exponent portion of `FinalAssemblyHigh`, and the finite summation body of `FinalAssemblyCollected`. A nonempty supported nonfloor bin gives j!=0 and hence the required strict lower bound on its a parameter. Its row and height hypotheses are supplied from actual geometry. Empty bins are zero sums, not a premise that all bins are empty. The finite partition pays its dyadic counting factor. With saving=t and both auxiliary costs t/8, its central exponent is

`3/16+(beta-7/8)-t+t/8+t/8 <= beta-11/16-sigma`.

The inequality follows from the stated high-saving budget and has the correct direction for Z>=1. The normalizer inverse and single-cell/transport estimates remain inputs. This checks the final exponent and summation use, not the analytic saving itself.

## 4. Actual analytic contradiction

Put omega=(beta-7/8)/2 and epsilon=min(beta-7/8-omega,sigma)>0. `Supremum.lean` gives `a=beta-epsilon > 7/8` and a<beta. The actual signal is the difference of the low probe and its error, so its exponent is

`max(3/16+omega,beta-11/16-sigma)=a-11/16`.

`Continuation.lean:16,45-74` defines the Mellin transform with argument `-(s+c)`. The sign is important: growth Z^(a+c) at infinity then gives convergence for Re(s)>a. Local integrability on positive reals and rapid decay at zero are separately supplied by the actual signal theory; neither follows from the growth estimate alone.

`Hecke/SignalIdentity.lean:26` uses the Fourier-inversion line and analytic continuation, not equality at a single point. Its regularizer at `:64-101` is R=s-1 for a principal character and R=1 otherwise. The corresponding Lreg is entire, including the principal pole removal. On the initial right half-plane,

`Lreg(s)*signalMellin(s)=R(s)*exp((s-5/6)^2)*H(s)`.

The product identity extends to Re(s)>a by `Continuation.lean:76`. At the near-supremum masked zero rho the left side vanishes. The right side cannot vanish: the nonpole condition gives R(rho)!=0, the exponential never vanishes, and the actual source correction satisfies norm(H-1)<=1/2. Re(rho)>7/8 excludes 0; a nonprincipal rho=1 is allowed with R=1. This is the contradiction in `Continuation.lean:94` and `Hecke/CommonProbe.lean:27`. No restriction on ordinate, simplicity, or multiplicity is used.

## 5. What this verdict does not establish

The author's section 8 accurately preserves the unresolved analytic frontier: normalized nonempty-cell estimates; physical-probe transport; inverse/marked/unmarked moment fields; low/high/zero induction stages and floor; both adaptive count regimes; ray normalizer and low-probe estimates; primitive/Euler and actual Fourier/Mellin foundations. These candidate source bodies were not all independently reconstructed here. A clean public signature or this checked outer contradiction cannot validate them.

The precise public declaration at `Nonvanishing.lean:19` has the intended actual Dirichlet L-function, positive modulus, strict seven-eighths real-part inequality, and only the principal-pole exception. That is a source/signature observation. Successful elaboration with the selected toolchain, allowed transitive axioms and the remaining mathematical audit are still required. This review supplies neither global QRH nor a new admissible final assumption for Goldbach.

## 6. Additional source pins

The 31 author-table hashes were checked without discrepancy. The following additional source files were read for nonvacuity and actual-function checks and independently hashed:

| Relative source | SHA256 |
|---|---|
| `ParametersProbeWindows.lean` | `3774B92E45F075223244620EB5F624640369D0271D3F2FDCF900B603231D5713` |
| `ParametersFixedSource.lean` | `6D17586F6573F6FFCBC1343AF5E7B27F5CC19824A0ADA96A8BDFF0B0ADC2A1B8` |
| `Hecke/IdealBridge.lean` | `D64B454F8DE573198F360DD4B4647DF87916020D4F89ECB44EB9B18D162A567F` |
| `Detector/LowNormalized.lean` | `01619D97B7806B1BF4BB29588A3138F57F09B22553651E1DF064BA00F07B376B` |
| `PrimeRows/CubeNormalizer.lean` | `B6808E221D9A1963FC56ABEF23B9DA5F357F25DFC066612B57ED757BCAA5CA55` |

No further correction is requested to the final frozen author note at this bounded scope.
