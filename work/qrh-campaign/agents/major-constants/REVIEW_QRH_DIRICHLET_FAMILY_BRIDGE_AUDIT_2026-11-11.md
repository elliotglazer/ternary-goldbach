# Independent review of the family-to-Dirichlet export bridge

Verdict: PASS within the bounded mathematical/source scope, with no correction requested. The reviewed author report is `zero-sum/QRH_DIRICHLET_FAMILY_BRIDGE_AUDIT_2026-11-11.md`, SHA256 `C55361E7134C70D82E9B8CBECF296E3D2072D5CE98F0E0E583050C732019CF0D`. I read it in full and verified all 27 of its source hashes. This is not a build, axiom audit, or validation of the global QRH provider.

The inspected checkout is `work/openai-math`, HEAD `4eaee87548250b2682affda7d05d947c05554bae`. Paths in the source discussion are relative to `lean/OAI/NumberTheory/DirichletL/`.

## 1. The exact exported assertion and its decisive split

`Nonvanishing.lean:19–25` asserts, for every natural `q` with `NeZero q`, every ordinary `DirichletCharacter ℂ q`, and every complex `s`, nonvanishing of the ordinary Mathlib `LFunction χ s` under `7/8 < s.re` and `¬(χ = 1 ∧ s = 1)`. There is no primitivity hypothesis, finite conductor bound, height bound, or assumed ordinary zero-free region above 7/8.

The actual call path is `FinalAssemblyUnconditional.dirichlet_nonzero` at line 37, `FinalAssemblyCertifiedBands.dirichlet_of_certified` at line 150, `FinalAssemblyChosenData.dirichlet_of_chosen_moments` at line 77, `CommonProbe.dirichlet_of_common_probe` at line 52, then `Hecke/Dirichlet.dirichlet_seven_eighths_of_hecke` at line 158. The chosen-data route must not be replaced in this description by the sibling raw-moment wrapper.

The final theorem splits on `1 ≤ s.re`.

* On that closed half-plane it invokes ordinary `χ.LFunction_ne_zero_of_one_le_re` with exactly `χ ≠ 1 ∨ s ≠ 1`, obtained from the exceptional-pair hypothesis. Thus the nonprincipal point `s=1` is handled without applying a punctured identity or asserting that norm pullback preserves nonprincipality.
* Otherwise `7/8 < s.re < 1` implies `s ≠ 0,1`. The Hecke nonvanishing input applies to the constructed character because `s ≠ 1`, irrespective of whether that character is principal. The actual product identity turns this into `L(χ,s)L(χ',s) ≠ 0`; the first factor is therefore nonzero.

This is a valid reduction for principal and nonprincipal ordinary characters alike. It does not divide by a potentially zero or singular companion at `s=1`.

## 2. Actual norm pullback and the analytic identity

In `Hecke/Dirichlet.lean:12–80`, the ideal modulus is `(q)` in the Eisenstein integer ring `O`. Its nonzero proof uses only `q ≠ 0` and characteristic zero. The residue function is the descent of

\[
 z\longmapsto\chi\bigl(N((z))\bigr).
\]

`Eisenstein/CoordinateLaplacian.lean:571–603` proves the descent using the actual norm polynomial `a²-ab+b²` modulo `q`. The nonunit-zero obligation is proved in the correct direction. If the norm is a unit modulo `q`, coprimality gives that the norm is a unit in `O/(q)`. Since `z` divides the norm of `(z)`, its image is a factor of a unit and hence is a unit. Contraposition lets `MulChar.map_nonunit` apply. No field hypothesis on `O/(q)` is inserted.

Every global unit has principal ideal the unit ideal, of norm one, so the pulled-back residue is unit-trivial. `Character.ofResidue` in `Hecke/Family.lean:31–44` supplies a positive finite period using the quotient cardinality. For each nonzero ideal `I`, choosing its actual generator proves `idealCoeff (character χ) I = χ(N I)`. The zero ideal is treated separately in the Möbius identity because its Möbius coefficient is zero.

The analytic function in use is genuinely `continuedLattice/6`, not a renamed formal ideal series. `Hecke/IdealBridge.lean:55–100` transports a `HasSum` over actual lattice elements through the coordinate equivalence, removes the zero term, and applies the unit-invariant six-to-one reindexing of nonzero generators. This proves equality with the ideal Dirichlet series when `Re(s)>1`. The division by six is therefore accounted for before the ordinary product identity.

The companion is explicitly

\[
 \chi'=\operatorname{changeLevel}_{3q}(\chi)
         \operatorname{changeLevel}_{3q}(\chi_{-3}),
\]

from `Hecke/NormFiberCharacters.lean:55–58`. It is not `χ⁻¹` or `conj χ`. `Hecke/LocalEulerIdentities.lean:389–498` checks the factors even at primes dividing the levels. At an unramified split prime the inverse polynomial is `(1-χ(p)X)²`; at an inert prime it is `1-χ(p)²X²`; at 3 it is `1-χ(3)X`. If a prime divides `q`, the character value is zero. The source proves the prime and prime-square identities, higher coefficients vanish by the stated ideal Möbius argument, and multiplicativity extends the identities to all positive integers. This retains the missing Euler factors of imprimitive characters.

`Mellin/LocalNonvanishing.lean:159–195` identifies the resulting coefficient sequence with the convolution of the two Möbius-twisted characters and proves its L-series multiplied by the two ordinary L-functions is one on `Re(s)>1`. `Hecke/Euler.lean:35–38` gives the same inverse relation for the actual Hecke function. In `Hecke/Dirichlet.lean:112–126`, the shared inverse series is nonzero because its product with the Hecke function is one. Cancellation then proves the product identity. This argument does not presume the desired 7/8 nonvanishing.

At lines 128–156 the identity theorem extends it to `ℂ \ {0,1}`. The source proves this set open and preconnected, proves both functions analytic there using the exact differentiability interfaces, and starts with equality on a neighborhood of 2 contained in `Re(s)>1`. This continuation does not require either function to be nonzero on the connected domain.

## 3. Modulus one, primitive reduction, and absence of an extra zero-free premise

For `q=1`, the ideal modulus is the unit ideal. Its quotient is the one-element ring, which the `MulChar` and `Character.ofResidue` interfaces allow. A unit ideal is nonzero, and the quotient cardinality is one, so no empty period occurs. The ideal coefficient at the zero ideal is still zero by its separate `MonoidWithZeroHom` definition. The element coefficient need not vanish at zero; the analytic sum's zero term vanishes for the nonzero exponents where that step is used.

The zeta export in `Hecke/Dirichlet.lean:171–179` invokes the ordinary modulus-one identity away from `s=1`. At `s=1` it invokes `riemannZeta_one_ne_zero` for Mathlib's defined value. This is a statement about that totalized value, not a claim that zeta has no pole.

The Hecke family input is full-family nonvanishing conditional on `UniformCommonProbe`. The primitive restriction exists only inside the probe contract. `Hecke/FiniteDeletion.lean:12–39` defines the finite factors `∏(1-a_P (NP)^(-s))`, whose nonvanishing on `Re(s)>0` follows from `|a_P|≤1` and `NP≥2`. The source obtains the masked L-function identity first on `Re(s)>1`, then for regularized L-functions on `Re(s)>0`. At `s=1`, principality is transported using the nonzero principal residue and the zero nonprincipal residue, not a 7/8 theorem. The invoked `regularizedL_ne_zero_at_one` at `Hecke/Reciprocal.lean:61–65` has no beta hypothesis. The different whole-region theorem beginning at line 71 does have a beta hypothesis and is not needed for this step.

`FiniteDeletion.lean:147–159` consequently takes any nonpole zero in `Re(s)>0` to a primitive character at the same point. `PrimitiveSupremum.lean:30–58` proves the equality of the primitive and full zero suprema after adjoining the sentinel `1/2`. Lower zeros are dominated by that sentinel; no zero is selected from an empty set without a near-supremum hypothesis. `CommonProbe.lean:27–49` uses the probe contradiction to establish `beta≤7/8`, then excludes all full-family zeros above it. The basic bound `beta≤1` comes from ordinary absolute-convergence-region Hecke nonvanishing, not from the claimed QRH conclusion.

Thus this bridge introduces no additional unproved stronger zero-free premise. It still relies on the substantive construction of `UniformCommonProbe` from the chosen source moments and certified energy bands. Reading those callers is not a fresh audit of their analytic estimates.

## 4. Limits of this review

The checked bodies include the export split, norm descent and unit conditions, ideal coefficient identification, six-unit normalization, inverse-series cancellation, analytic continuation, finite-deletion continuation, primitive-supremum reduction, and actual wrapper consumption. The local prime-factor assembly was inspected with its split/inert/ramified inputs exposed. Underlying cyclotomic splitting, ideal factorization, Möbius convergence, theta continuation, the general identity theorem, and the full moment/probe production remain foundations or separate audit tasks. This report does not replace their proofs with the displayed Euler polynomials.

The checkout has no installed target Mathlib tree. A read-only cached Mathlib tree was used to inspect the ordinary endpoint theorem and modulus-one identity. Its revision is `56a005855ea17e0b0958f73ec801ae140b0a1679`; the target manifest requests `d13f23b723b8a846827a245b89c10fc7d3f11612`. The cached theorem `NumberTheory/LSeries/Nonvanishing.lean:397–400` has exactly the ordinary `χ ≠ 1 ∨ s ≠ 1`, `1 ≤ s.re` contract used above. `DirichletContinuation.lean:66–68` identifies modulus-one L-functions with `riemannZeta`. This supports statement interpretation only. No target-version elaboration, build, or comprehensive dependency/axiom audit was performed.

## 5. Source pins

The following table pins the independently inspected source bodies. All 27 author pins also matched, including sources retained as lower foundations.

| Source | SHA256 |
| --- | --- |
| `Nonvanishing.lean` | `16A7F55147E177E972264A2AC61D1639188A2090844A89D1C080CBA8500791CC` |
| `Detector/FinalAssemblyUnconditional.lean` | `70D01B604FD5CC3522A4503543D9A5E422F9105C19E88985C5CD7C28C5958BA2` |
| `Detector/FinalAssemblyCertifiedBands.lean` | `BFA8FC2524634A7F7CCF893C944BBBDA6F0BD3A3DC666C13821CE06CF13F960F` |
| `Detector/FinalAssemblyChosenData.lean` | `0D072EFAFE870A968D5D9DCDCC98309BFDDA366637E1D9E812B8BFFC4D26D6BE` |
| `Hecke/CommonProbe.lean` | `D2FE9C934B4DE31248CFC3B4F0F5B806BBCEF6A6C8769805C74CAA556E0A8097` |
| `Hecke/Dirichlet.lean` | `55D1D7D6CAF40B33973651D25A12DE35DCFF0E3F9BFACF7F84E4997D8014702F` |
| `Hecke/Family.lean` | `B18557C5C055910287507F1ED2B1F7BB31EDE318CB62A2A10A3140F1995A9408` |
| `Hecke/FamilySeries.lean` | `F154DD42BFB33F908A9F7C8987BE9AF9D37FB4DD406C8EBED5F07A33D3F1FF8C` |
| `Hecke/IdealBridge.lean` | `D64B454F8DE573198F360DD4B4647DF87916020D4F89ECB44EB9B18D162A567F` |
| `Hecke/Euler.lean` | `89E3AFA01E51EB5CEB4C5FC863BB9F2639F655BD5736E4B480498B65586FFFD8` |
| `Hecke/NormFiberCharacters.lean` | `AB8E15BBB51980AC1B3FBCBACA9243AA9F11E4EB0147A9F17857C60E894257D6` |
| `Hecke/LocalEulerIdentities.lean` | `C702C0FE99777C4BC2AE7D7C8FA49F17E636B187154DBBC07AA0060E56871D27` |
| `Mellin/LocalNonvanishing.lean` | `B3051EF224AF6911F869B83706FFF2463E7A3F3784AECBFC56458520D5D25E8F` |
| `Eisenstein/CoordinateLaplacian.lean` | `D8AD25D880AC21A4198140B81BBD562667BE4B10E3EC49C48952809F7C43C26D` |
| `Hecke/ZeroSupremum.lean` | `F27256644A64572823B53CAE87483C4726192FF906EE7F64AE30E13F77E57242` |
| `Hecke/PrimitiveSupremum.lean` | `8DC3B1BBD50945D38EDC095181429C1864F409096503163AA63B448496BB9D45` |
| `Hecke/FiniteDeletion.lean` | `8186CCBFBB6D3BD95E65AD807C852B82204C689664CDDEDAB2407035911AE72C` |
| `Hecke/IdealOperations.lean` | `6760E7000AD9A8EC58BC78A52F598F20F292F17201161C36E50296D3D46B01F2` |
| `Hecke/Reciprocal.lean` | `4161F072933BAAC5769ADAD68ACF0B8B3C45BD75FFFACF6152587AE001355D68` |
| `EulerFactors.lean` | `061E4DCE508143E4A48D77806BD2BA06650804066E9943CD2E08F62508DA10FE` |
| `IdealEuler.lean` | `D8EC594DEDB83661937B1DA00600AFE85A4A319434CE1C0B64543EF06A24BB59` |
| `Hecke/ThetaSeries.lean` | `02D62C45C0A81D8E24044E524B3203242D951B97B779FF332DD595E1A8F197A4` |
| `CubicSieve/ResidualSectors.lean` | `D914C36A8F6AD49FD03B98C67D96694F790EC83BC4324B469DFD4E1F893584BE` |
| `Hecke/MobiusEulerCorrection.lean` | `21C29B0284FE3E74D5855F584CC36339FC8B42349EEF38FD5423E50DDE70843F` |
| `MeanSquare/SourceTransfer.lean` | `8D21A870B194D8E759B9D11F34C693339026672FC4F23FD22320B06F76E6C5E6` |

Cached Mathlib files below belong to the distinct revision disclosed in section 4.

| Cached source | SHA256 |
| --- | --- |
| `NumberTheory/LSeries/Nonvanishing.lean` | `97D125ED132D6E39E61A6D9A8532E3460800FCE77569F5D621FC2B24E808B776` |
| `NumberTheory/LSeries/DirichletContinuation.lean` | `ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1` |
