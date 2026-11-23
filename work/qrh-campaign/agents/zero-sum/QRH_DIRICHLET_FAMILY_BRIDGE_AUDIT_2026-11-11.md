# QRH family-to-ordinary-Dirichlet bridge audit

Date: 2026-11-11. Scope: bounded paper/source audit, with no Lean build, declaration changes, or function evaluations. Source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`. The final table pins the files actually used. This is a local transfer result conditional on the stated analytic and detector dependencies, not a validation of the entire provider.

## 1. Result and exact dependency boundary

No defect was found in the transfer from the Eisenstein ideal-character family to the ordinary continued Dirichlet L-function. In particular, the transfer does not require the ordinary character to be primitive, does not confuse its inverse with a quadratic twist, and does not assume that pulling back along the norm preserves nonprincipality.

The exported statement at `Nonvanishing.lean:19` is about Mathlib's actual `DirichletCharacter.LFunction χ s`, for every positive modulus (encoded by `[NeZero q]`), under `7/8 < s.re` and `¬(χ = 1 ∧ s = 1)`. Its immediate provider is `ProbeFinalAssemblyUnconditional.dirichlet_nonzero` at `Detector/FinalAssemblyUnconditional.lean:37`.

The retained energy dependency is precisely `ProbeFinalAssemblyUnconditional.detector_certified_bands` at line 15, which invokes `CenteredMomentEnergyCertifiedExistence.terminal_certificate`. I did not re-audit that induction. The downstream chain is `dirichlet_of_certified` in `FinalAssemblyCertifiedBands`, `dirichlet_of_chosen_moments` in `FinalAssemblyChosenData`, and `CommonProbe.dirichlet_of_common_probe`. The substantial detector-to-probe producer `common_probe_of_chosen_moments` remains a dependency: this report checks how its family conclusion is consumed, not its signal estimates again.

The decisive final input is the all-family statement

\[
 \mathcal L(\eta,s)\ne0\quad
 (7/8<\Re s,\quad s\ne1\ \text{or}\ \eta.\mathrm{residue}\ne1).
\]

Here \(\eta\) is the actual source `HeckeFamily.Character`, not a free collection of coefficients. The final implication from this statement is proved in `Hecke/Dirichlet.lean:158`.

## 2. Actual field and norm character

`Hecke/Family.lean` uses \(K=\mathbb Q(\zeta_3)\), represented by `CyclotomicField 3 ℚ`, and its ring of integers \(O\). A family character contains a nonzero ideal modulus, a multiplicative character of its finite quotient, triviality on every global unit, and a positive integer period lying in the modulus. `Character.ofResidue` supplies a period from the finite quotient cardinality. This remains meaningful for the unit ideal: the quotient is a singleton with positive cardinality, rather than an excluded case.

For an ordinary character \(\chi\) modulo \(q>0\), `Hecke/Dirichlet.lean:12–77` constructs the modulus \((q)\) and residue rule

\[
 z\longmapsto\chi(N((z))).
\]

The underlying monoid homomorphism is `SourceTransfer.normCharacter` at `MeanSquare/SourceTransfer.lean:438`. The quotient descent is proved, rather than inferred from a matching cardinality: `Eisenstein/CoordinateLaplacian.lean:583` uses the coordinate norm \(a^2-ab+b^2\) and its congruence under changing both coordinates by multiples of \(q\). `Hecke/IdealBridge.lean:23` identifies the coordinate element with the same arithmetic model.

The extra MulChar requirement, zero on nonunits, is also checked. If the norm of \(z\) is a unit modulo \(q\), its image is a unit in \(O/(q)\). The source identity expressing that norm as \(z\bar z\) then forces \(z\) itself to be a unit in the quotient (`quotient_unit_of_norm_unit`, line 31). The contrapositive supplies the zero-on-nonunits clause. A global unit has principal-ideal norm 1, so its value is 1 (`residue_unit_trivial`, line 64).

Consequently, for every nonzero ideal \(I\),

\[
 a_{\eta_\chi}(I)=\chi(NI).
\]

The zero ideal is deliberately treated separately. The source ideal character has coefficient zero there; the Möbius-weighted comparison at `Hecke/Dirichlet.lean:83` explicitly handles this case. This matters for modulus one, where blindly replacing every coefficient by the ordinary character evaluated at zero would be unsafe.

No character conjugation occurs in this norm pullback. Algebraic conjugation in the norm formula is conjugation of an Eisenstein integer.

## 3. Lattice, ideal series, and the factor six

The family continuation is constructed from the actual periodic lattice coefficients. `Hecke/Theta.lean:164` defines the uncompleted lattice function by multiplying the completed theta expression by \(\pi^s/\Gamma(s)\). `Hecke/ThetaSeries.lean:55` proves its `HasSum` on \(\Re s>1\); Gamma nonvanishing in this region and the nonzero power of \(\pi\) justify the cancellation. `Hecke/FamilySeries.lean` specializes this to the family's coefficients.

`Hecke/IdealBridge.lean:56–97` then proves

\[
 \mathrm{continuedLattice}(\eta,s)
 =6\sum_{I\ne0}a_\eta(I)(NI)^{-s},\qquad
 \mathcal L(\eta,s)=\mathrm{continuedLattice}(\eta,s)/6.
\]

The six is an exact multiplicity. `CubicSieve/ResidualSectors.lean:560–609` constructs a bijection between nonzero elements and pairs consisting of a global unit and a nonzero ideal, using a chosen ideal generator. Injectivity uses equality of principal ideals followed by cancellation of the nonzero generator; surjectivity uses associated generators. The unit group has exactly six elements. `tsum_nonzero_unit_invariant` transports an explicitly summable function across this bijection before summing over units; `tsum_unit_invariant_of_zero` removes the zero element only after proving its term is zero.

Thus the ideal-series identity is not a default-tsum equality for an unproved convergent series. The same is true of the Möbius inverse used next: `Hecke/Euler.lean` calls `IdealEuler.inverseSeries_mul_series`, whose proof first supplies absolute summability for the coefficient and inverse series, then groups their product by ideal multiplication. The ideal Möbius divisor sum leaves only the unit ideal.

These checks validate the normalization and the immediate summability interfaces. The theta functional-equation construction, underlying lattice convergence estimates, PID/unit-cardinality facts, and ideal divisor identities remain foundations rather than results re-proved here.

## 4. The second ordinary factor is an exact level-3q twist

Write

\[
 \psi=\mathrm{baseChangeChar}(\chi)
 =\chi\text{ lifted to }3q\;\cdot\;\chi_{-3}\text{ lifted to }3q.
\]

This is the actual definition at `Hecke/NormFiberCharacters.lean:55`. It is neither \(\bar\chi\) nor \(\chi^{-1}\), and no primitive-ancestor simplification is made. At every rational prime, including primes dividing \(q\) and the ramified prime 3, `Hecke/LocalEulerIdentities.lean:389` proves the corresponding product formula for its value.

For \(x=\chi(p)\), the norm-fiber sums of \(\mu_O(I)\chi(NI)\) at norms \(p\) and \(p^2\) are respectively

| Prime type | Norm p | Norm p² |
|---|---:|---:|
| split | −2x | x² |
| inert | 0 | −x² |
| ramified p=3 | −x | 0 |

When \(p\mid q\), the relevant values vanish. The displayed table agrees with the coefficients \(-\chi(p)-\psi(p)\) and \(\chi(p)\psi(p)\) of the product of the two ordinary Möbius inverses. The ramified line is essential: \(\psi(3)=0\).

The higher-power vanishing at `LocalEulerIdentities.lean:106` has a concrete arithmetic reason. A contributing ideal is squarefree, divides \((p)^k\), and therefore divides \((p)\). Its norm \(p^k\) must divide \(N((p))=p^2\), impossible for \(k\ge3\). Multiplicativity and the prime-power cases give the norm-fiber coefficient identity at line 491. The split/inert/ramified fiber classifications are lower arithmetic inputs; I inspected their use and the prime-power assembly, not every proof of cyclotomic splitting.

`Hecke/MobiusEulerCorrection.lean:629` groups the summable ideal inverse by its norm. `Mellin/LocalNonvanishing.lean:159–172` supplies the ordinary convolution identity, again with L-series summability on \(\Re s>1\). Hence `Hecke/Dirichlet.lean:94–125` obtains a common inverse \(A(s)\) satisfying

\[
 A(s)\mathcal L(\eta_\chi,s)=1,
 \qquad A(s)L(\chi,s)L(\psi,s)=1.
\]

The first equality proves \(A(s)\ne0\); cancellation yields the required product identity. There is no unsupported cancellation at a zero, and no omitted imprimitive Euler factor.

## 5. Continuation and pole cases

`Hecke/Dirichlet.lean:128` continues

\[
 \mathcal L(\eta_\chi,s)=L(\chi,s)L(\psi,s)
\]

to \(\mathbb C\setminus\{0,1\}\). This set is open and preconnected; both functions are analytic there by their actual continuation theorems. They agree on a neighborhood of 2 lying in \(\Re s>1\), so the identity theorem applies. The argument does not substitute the Dirichlet series at a point where that series need not converge.

The final proof separates two regions. If \(\Re s\ge1\), it invokes the existing ordinary theorem `χ.LFunction_ne_zero_of_one_le_re`, with the original pole exclusion. Otherwise \(7/8<\Re s<1\) gives \(s\ne0,1\); all-family nonvanishing applies to \(\eta_\chi\) using the `s ≠ 1` disjunct alone. The product identity then implies its first factor is nonzero.

This separation is why no proof that \(\eta_\chi\) is nonprincipal is needed, including when a nonprincipal ordinary character has a principal norm pullback. There is no unproved use of the punctured product identity at 1.

For modulus one, `(q)` is the unit ideal, but the construction and the preceding argument remain defined. The zeta corollary at line 171 uses `LFunction_modOne_eq` away from 1. At 1 it separately uses `riemannZeta_one_ne_zero`, a statement about the source's totalized value; this must not be described as removal of the classical zeta pole. The ordinary exported theorem retains its explicit pole exclusion. Modulus zero is outside `[NeZero q]`.

## 6. Why the primitive probe controls every family character

`Hecke/CommonProbe.lean` requests a probe only for characters satisfying the family's `primitiveOnIdeals`. This is not an unmentioned restriction on the final conclusion. `Hecke/FiniteDeletion.lean` proves that every family character has a primitive associate with an exact finite Euler-factor relation. On \(\Re s>0\), each deletion factor is nonzero: a prime ideal has norm greater than 1, while the character coefficient has norm at most 1. Nonprincipality/pole guards are transported explicitly, including the separate treatment at 1.

`Hecke/PrimitiveSupremum.lean` uses that same-point zero transport to equate primitive and all-family zero suprema. The sentinel \(1/2\) in `Hecke/ZeroSupremum.lean` avoids an empty-set supremum problem; zeros with real part below it need no primitive transport for the supremum comparison. CommonProbe then derives the all-family nonvanishing consumed in section 5. This route neither assumes an ordinary primitive conductor nor changes the zero's ordinate.

The exact existence theorem `IdealCharacter.exists_primitive_associate`, its conductor arithmetic, and the analytic nonzero-probe contradiction remain named dependencies. Their interfaces and the finite-deletion consumption were checked here; the detector and energy constructions underneath them were not re-certified.

## 7. Bounded verdict and remaining cut

The inspected transfer is coherent at source level: actual characters descend to the quotient; zero coefficients and the six-unit multiplicity are retained; the inverse identities have summability support; the correct quadratic twist is kept at its actual level; analytic continuation is used on a valid domain; and the final pole split covers all positive moduli without a primitivity assumption.

The remaining cut is substantive: the detector certified-band theorem and common-probe analytic estimate; the underlying theta/Fourier continuation and convergence; finite-ideal Euler/conductor and cyclotomic splitting foundations; and Mathlib's ordinary nonvanishing/analytic identity APIs. A successful source audit of this bridge is not a build, an axiom audit, or independent validation of those foundations. No source files or prior frozen reports were changed.

## Source pins

SHA-256 values below were obtained after the reads. They pin the audit's source version, not a tested build.

| File | SHA-256 |
|---|---|
| Nonvanishing.lean | `16A7F55147E177E972264A2AC61D1639188A2090844A89D1C080CBA8500791CC` |
| Detector/FinalAssemblyUnconditional.lean | `70D01B604FD5CC3522A4503543D9A5E422F9105C19E88985C5CD7C28C5958BA2` |
| Detector/FinalAssemblyCertifiedBands.lean | `BFA8FC2524634A7F7CCF893C944BBBDA6F0BD3A3DC666C13821CE06CF13F960F` |
| Detector/FinalAssemblyChosenData.lean | `0D072EFAFE870A968D5D9DCDCC98309BFDDA366637E1D9E812B8BFFC4D26D6BE` |
| Hecke/CommonProbe.lean | `D2FE9C934B4DE31248CFC3B4F0F5B806BBCEF6A6C8769805C74CAA556E0A8097` |
| Hecke/Family.lean | `B18557C5C055910287507F1ED2B1F7BB31EDE318CB62A2A10A3140F1995A9408` |
| Hecke/Dirichlet.lean | `55D1D7D6CAF40B33973651D25A12DE35DCFF0E3F9BFACF7F84E4997D8014702F` |
| MeanSquare/SourceTransfer.lean | `8D21A870B194D8E759B9D11F34C693339026672FC4F23FD22320B06F76E6C5E6` |
| Eisenstein/CoordinateLaplacian.lean | `D8AD25D880AC21A4198140B81BBD562667BE4B10E3EC49C48952809F7C43C26D` |
| Hecke/IdealBridge.lean | `D64B454F8DE573198F360DD4B4647DF87916020D4F89ECB44EB9B18D162A567F` |
| Hecke/Theta.lean | `69668551F9379A136381A5DCF45D773DCCDC9AE70DD423CB91698E298D43E514` |
| Hecke/ThetaSeries.lean | `02D62C45C0A81D8E24044E524B3203242D951B97B779FF332DD595E1A8F197A4` |
| Hecke/FamilySeries.lean | `F154DD42BFB33F908A9F7C8987BE9AF9D37FB4DD406C8EBED5F07A33D3F1FF8C` |
| Hecke/CharacterAnalytic.lean | `A439B16326E73782045166626B22BE9D84A95D23774E5326B390BC1874EFCC6A` |
| IdealCharacter.lean | `6AAB22876E8326D3AB56F56692F371F58B5D99CA8779356D9D47287E7569725A` |
| CubicSieve/ResidualSectors.lean | `D914C36A8F6AD49FD03B98C67D96694F790EC83BC4324B469DFD4E1F893584BE` |
| Hecke/Euler.lean | `89E3AFA01E51EB5CEB4C5FC863BB9F2639F655BD5736E4B480498B65586FFFD8` |
| IdealEuler.lean | `D8EC594DEDB83661937B1DA00600AFE85A4A319434CE1C0B64543EF06A24BB59` |
| Hecke/NormFiberCharacters.lean | `AB8E15BBB51980AC1B3FBCBACA9243AA9F11E4EB0147A9F17857C60E894257D6` |
| Hecke/LocalEulerIdentities.lean | `C702C0FE99777C4BC2AE7D7C8FA49F17E636B187154DBBC07AA0060E56871D27` |
| Hecke/MobiusEulerCorrection.lean | `21C29B0284FE3E74D5855F584CC36339FC8B42349EEF38FD5423E50DDE70843F` |
| Mellin/LocalNonvanishing.lean | `B3051EF224AF6911F869B83706FFF2463E7A3F3784AECBFC56458520D5D25E8F` |
| Arithmetic/NormFiberMellin.lean | `A8903B1F7135B26F60B0AE44699A481A6D76D9DDA83B83079850B55F258298F3` |
| Hecke/FiniteDeletion.lean | `8186CCBFBB6D3BD95E65AD807C852B82204C689664CDDEDAB2407035911AE72C` |
| Hecke/PrimitiveSupremum.lean | `8DC3B1BBD50945D38EDC095181429C1864F409096503163AA63B448496BB9D45` |
| Hecke/ZeroSupremum.lean | `F27256644A64572823B53CAE87483C4726192FF906EE7F64AE30E13F77E57242` |
| Hecke/IdealOperations.lean | `6760E7000AD9A8EC58BC78A52F598F20F292F17201161C36E50296D3D46B01F2` |
