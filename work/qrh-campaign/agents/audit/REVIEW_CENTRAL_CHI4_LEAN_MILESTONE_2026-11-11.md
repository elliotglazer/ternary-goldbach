# Central chi4 Lean milestone: independent semantic audit

**PASS for the exact internal central-value theorem only.** The result concerns the actual analytic Dirichlet L-function, with its complete infinite tail proved. It is not the requested representative positive-height numerical/transform/Hardy-sign pilot and cannot calibrate that pipeline. No public frozen-anchor adoption or full spectral certificate is approved here.

## Exact statement and input audit

`work/lean-pilots/spectral/CentralChi4.lean:172` exports:

```lean
theorem SpectralPilot.central_chi4_certificate :
  (1 / 4 : ℝ) < (SpectralPilot.chi4.LFunction (1 / 2)).re ∧
    (SpectralPilot.chi4.LFunction (1 / 2)).re ≤ 1 ∧
    (SpectralPilot.chi4.LFunction (1 / 2)).im = 0
```

| Expanded logical input | Classification |
|---|---|
| None | This is a closed proposition, with no explicit, implicit, or instance hypothesis supplied by a caller. The modulus is the concrete numeral 4; its `NeZero` instance is discharged internally. |

Binder counts: SOURCE 0, STANDING 0, TYPING 0, RULED 0, EXCESS 0. In particular, no integrability, continuation identity, finite enclosure, tail, prime, zero-location, or rounding assumption is a premise of this theorem.

The intended central specialization was explicitly allowed as a separate internal milestone by the coordinator. It does not replace the intended positive-height target. The independently written exact-type probe uses the complete literal character expression rather than relying only on the local `chi4` name.

## Definitions and mathematical reconstruction

At line 14, `chi4` is literally `ZMod.χ₄.ringHomComp (Int.castRingHom ℂ)`. The underlying Mathlib character is zero on residues 0 and 2, one on 1, and minus one on 3. The local nonprincipal proof evaluates at 3. This is the real nonprincipal character modulo 4, not a default or conditional surrogate.

The imported `DirichletCharacter.LFunction` is the actual analytic continuation. The independent probe printed its definition and the underlying definition:

```text
DirichletCharacter.LFunction χ s = ZMod.LFunction (⇑χ) s
ZMod.LFunction Φ s = N^(-s) * ∑ j, Φ j * HurwitzZeta.hurwitzZeta (ZMod.toAddCircle j) s
```

This matters at real part 1/2: the proof does not substitute the naive `LSeries`, whose off-convergence semantics would not be an acceptable target. In `Explicit/LGrowth.lean:156–176`, the continuation identity is proved by equality on real part greater than 1 followed by analytic continuation on the connected right half-plane. The full partial-sum integral is integrable there for nonprincipal characters. Its hypotheses are actually discharged here.

The finite partial sums `psum chi4 n` are proved to be 1 when `n mod 4` is 1 or 2, and 0 otherwise. Consequently the real integrand is nonnegative and bounded by `t^(-3/2)` on positive real t. `centralIntegrand_integrable` at line 90 transports the actual complex-integrand integrability, rather than relying on the default value of a nonintegrable integral.

`actual_central_integral` at line 97 gives the exact equation

`L(1/2,chi4) = (1/2) integral_(1,infinity) psum(chi4,floor t) t^(-3/2) dt`,

embedded into the complex numbers. The integrand equals `t^(-3/2)` throughout `[1,2]`, including the endpoints with the correct floor convention. Its half-integral is exactly `1−1/sqrt(2)`. The remaining half-integral over `(2,infinity)` is the actual `centralTail`. Lines 131 and 138 prove `0 ≤ centralTail ≤ 1/sqrt(2)` using integrability and the power majorant. Line 156 joins the finite interval and infinite tail into the actual L-value. The shared endpoint is harmless for Lebesgue integration and is handled by the invoked interval-plus-tail theorem.

Finally `sqrt(2)>4/3` follows from the exact squared identity and nonnegativity. Hence `1−1/sqrt(2)>1/4`, the nonnegative tail preserves the strict lower bound, and the tail upper bound gives at most 1. The exact real-valued integral representation proves the imaginary part is zero. No numerical function evaluation or assumed sign margin is used.

Definition audit for `chi4`, `centralIntegrand`, and `centralTail`: BODY_MATCH OK; PUBLIC_CARRIER OK for their internal literal definitions; WELL_DEFINEDNESS N/A_LITERAL; CHARACTERIZATION N/A_LITERAL; CHOICE_INDEPENDENCE N/A. Their use in the final actual-L conclusion is justified by the proved identities and integrability. No surrogate characterization premise remains.

## Independent Lean check

The owned transient probe supplied a closed example at the independently reconstructed literal-character type and a definitional equality for `chi4`. Lean 4.35.0, strict import trust level 0, exited successfully. `#print axioms` for the final certificate, exact finite-approximation identity, tail upper bound, and imported continuation identity returned exactly:

```text
[propext, Classical.choice, Quot.sound]
```

No `sorryAx`, custom analytic axiom, assumed enclosure, or native evaluation acceptance axiom appears in that transitive closure. The imported actual source and object pins were checked before and after the probe. The temporary Lean file was deleted, with its exact text retained in the receipt. This probe is an independent check of the completed milestone, not an author build timing.

## Remaining representative-pilot boundary

The separate `POSITIVE_HEIGHT_TARGET.md` describes the value at `s=1/2+i*5/64` of `4^(s/2) * completedLFunction chi4 s`. That normalization is consistent with Mathlib's conductor-free completion and its functional equation. A final certificate would still need the actual finite Abel decomposition and tail, certified elementary finite inputs, the implemented finite transform/character sum and its arithmetic errors, an actual Gamma/conductor enclosure, and the character/functional-equation/conjugation proof of realness. Different Hardy conventions require their own proved phase and positive scaling.

This central result bypasses those numerical producer and completion steps. Its elapsed compile time does not price positive-height cpow/Gamma boxes, large-conductor Bluestein/tensor arithmetic, interpolation, sign repair, or Turing completeness. Even a later small-modulus direct-transform pilot would only measure the circuit actually implemented. The representative spectral pilot remains open at this review snapshot.

## Exact pins

| Workspace-relative artifact | SHA-256 |
|---|---|
| `work/lean-pilots/spectral/CentralChi4.lean` | `DADBA753B6475CD5ED9C48F0CC1312709F60DE8FCCF7291C5CC797A844A89D22` |
| `work/lean-pilots/spectral/CentralChi4.olean` | `B7FB59F14A902F4E4712DF2485EE9760D417CCAFFCB118252321FD38CC480607` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean` | `5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341` |
| `work/qrh-campaign/agents/integration/artifacts/TernaryGoldbach/Explicit/LGrowth.olean` | `1F4140842770D4B6A8B9CFE93D724FF5C1B55111A2CAA57C5350BAEBE9EBB7FC` |
| `work/lean-pilots/spectral/POSITIVE_HEIGHT_TARGET.md` | `A25A52C5F520177DFABF29DF2DF7B25538D542CAB3B9552C8E3D0A0A7A7839EE` |
| `work/lean-pilots/audit/audit_central_spectral_export.py` | `4D5DB2697A02313A07E6D5C1EB027DD0949364A60BAD1B3800412196D3F80EB8` |
| `work/lean-pilots/audit/central_spectral_export_probe_receipt.json` | `EF7223D060FA2EEE597983636E05B3DB49320D50D95A0F4887F89893BD65657B` |
| `work/lean-pilots/audit/central_spectral_export_probe.log` | `E6372D6FA43B709C88BB5946ED816E229BCB69000CADD989C49488A61C8ED6C2` |

The probe receipt records the executable hash, exact command and 44.6462-second import/probe wall observation. This observation includes strict imported-object checking and has no standalone throughput interpretation.
