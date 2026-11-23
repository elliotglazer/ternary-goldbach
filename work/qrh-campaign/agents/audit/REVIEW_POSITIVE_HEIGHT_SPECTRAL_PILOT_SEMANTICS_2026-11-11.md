# Positive-height spectral pilot semantic audit

Independent PASS for the complete internal sample theorem, with no correction requested. The actual function, finite inputs, numerical enclosures, analytic tail, completion and exact reality are connected in the final proof. This audit does not adopt a public frozen anchor or certify a family of zeros. It does not establish large-transform throughput.

## Exact target and binders

The reviewed export is `SpectralPilot.positive_height_chi4_certificate` at `work/lean-pilots/spectral/PositiveHeight.lean:11`, source SHA256 `955866564A49B21DC9B6436B7B830305ED569C167474CB9E592486CB2355309A`, object SHA256 `74A15CD89D6B042FDBF6C1A6C2F610941BE0F0F6BBB5DE8B29671545DC9C355B`.

For the literal character `ZMod.χ₄.ringHomComp (Int.castRingHom ℂ)` and the literal point `s = 1/2 + I*(5/64)`, it proves

    0 < (4^(s/2) * DirichletCharacter.completedLFunction chi4 s).re
      and (4^(s/2) * DirichletCharacter.completedLFunction chi4 s).im = 0.

This matches `work/lean-pilots/spectral/POSITIVE_HEIGHT_TARGET.md`. That earlier target document's open-status sentences are historical; this review checks the completed export rather than treating those sentences as current evidence. The target is one fixed positive height and modulus, not a quantified claim for other heights or characters.

| Expanded final binder | Bin | Source comparison |
|---|---|---|
| None | No logical input | The final export is closed. The character, modulus and height are concrete definitions. The `NeZero 4` instance is resolved internally. |

Counts are SOURCE=0, STANDING=0, TYPING=0, RULED=0, EXCESS=0. In particular, no enclosure, Gamma box, functional equation, root number, source accuracy, finite-RH assumption or sign margin is an input to the final theorem. The internal product lemma has two L-box premises; the final proof supplies both from `actual_sample_box`.

The definition `chi4` is the literal mapped integer character. Its values vanish on even integers and alternate on odd integers. `sampleS` and `samplePoint` are definitionally the same stated complex point. `DirichletCharacter.completedLFunction` expands to the actual `ZMod.completedLFunction` of the character, not a surrogate constrained by a predicate. Definition verdicts for these literal project objects are BODY_MATCH OK, PUBLIC_CARRIER OK, WELL_DEFINEDNESS N/A_LITERAL, CHARACTERIZATION N/A_LITERAL, CHOICE_INDEPENDENCE N/A, DEFINITION_VERDICT PASS.

## Actual finite source and tail

The reviewed lower-input packet is `work/lean-pilots/audit/spectral-inputs/REVIEW_2026-11-11.md`, SHA256 `B5FE164DFC0758F3B8B867AA99E1F1AFBDD86D6C80670DCAC4FFBE1A6E9851D3`. The generic Abel review is `work/lean-pilots/audit/abel/REVIEW_2026-11-11.md`, SHA256 `8AA5BB633EF1EA429887C2E58DCE96A8687F9DCC24719D49D6BAA9E794B05ED0`. This final audit read the actual sample assembly and its source interfaces, and preserves their scope.

The eight nonzero terms are the actual powers `n^(-s)` for odd n from 1 through 15, with the actual character signs. Finite logarithm and exponential polynomials, positive-real logarithm identities and proved remainder inequalities connect those powers to the concrete grid20 centers. Each actual input has complex norm error at most `1/500000`. These are enclosure certificates, not a proof that the centers implement a particular nearest-rounding tie rule.

`SampleBox.lean:14` identifies the inclusive character sum through 16 with the eight odd terms. The exact signed center is `(572952 + I*51250)/1048576`; summing the eight input errors gives `1/62500`. No transform operator is substituted for this finite sum.

The actual Abel identity includes its boundary term. At 16 the character partial sum is zero, so the boundary term vanishes for a proved reason. The remaining integral is over `(16,infinity)`, with actual partial-sum norm at most 1 and weight `t^(-3/2)`. Actual integrability comes from the source continuation interface and the integrable majorant. Its integral is `1/2`, and `norm(s) <= 33/64`, giving the tail radius `33/128`. There is no default-integral loophole or omitted finite endpoint.

Consequently `actual_sample_disk` bounds the actual L value within `33/128 + 1/62500` of the stated center. Projection gives the strict actual bounds `Re L > 1/4` and `abs(Im L) < 1/2` in `SampleBox.lean:48`. The cached project `LGrowth.LFunction_eq_mul_Iint` is a proved analytic-continuation identity for nonprincipal characters and positive real part; it is not an assumed finite-RH input. Its source and object are included in the independent probe's pins.

## Completion and exact reality

The independent Gamma/completion review is `work/lean-pilots/audit/spectral-completion/GAMMA_COMPLETION_SOURCE_AUDIT.md`, SHA256 `D905B0120422E5B3BA2212CE06DDE97CB8108E9BF7CCC3DE2AB55C68778549A4`. Its conditional product conclusion is discharged here.

For this odd character, the factor is `GammaR(s+1)`, so the Gamma argument is `3/4 + I*5/128`. The exact identity in `CompletionFactor.lean` is

    4^(s/2) * GammaR(s+1)
      = exp(log(4)/4 - 3*log(pi)/4)
          * exp(I*(5/128)*log(4/pi)) * Gamma(3/4 + I*5/128).

The real scale is positive. The phase sign, conductor factor and parity shift agree with the source completion. The actual rotated Gamma has real part at least `3/4` and imaginary absolute value at most `1/4`. The L-box therefore gives a real product exceeding `3/16 - 1/8 = 1/16` before the positive scale. The imaginary cross term is explicitly retained. This is a bound on the actual Gamma function via its integrable Euler representation, not a supplied box hypothesis.

I independently read `Chi4Reality.lean`, SHA256 `D1CFC512A3271DF46D961A2E5FAD0FA159CCBC974786CCBDFCEF7D4635555C21`. The primitive-conductor argument excludes conductor 1 by nonprincipality and conductor 2 by oddness; the conductor divides 4 and is nonzero. The inverse character equals itself by its actual values. Root number 1 follows from the primitive functional equation at the center and the separately proved nonzero central completed value. That central positivity came from an integral argument, so the root-number derivation does not assume the reality or positive-height result being proved.

Conjugation of the actual L function is proved using the continuation integral and real partial sums. Gamma conjugation supplies the completion conjugation. On the critical line, conjugation sends s to `1-s`. The functional-equation factor `4^(s-1/2)` combines with `4^((1-s)/2)` to give `4^(s/2)`. Positive real base 4 justifies the complex-power identities. Hence the conductor-normalized completion equals its conjugate and has imaginary part zero. The final proof specializes the generic real-height theorem to `5/64`.

No extra Hardy-convention claim is made. Comparison with a different named Hardy output still requires its exact positive scale and phase convention. The exported normalized completion itself is the actual source object specified by this pilot.

## Independent compiled check and evidence

`work/lean-pilots/audit/audit_positive_height_export.py`, SHA256 `4DA697D2483D4BA6EFA5CA0E15E96A2131BCF7387FFBED449D5DA8009D51C082`, generated a transient exact-type example with the character alias replaced by the literal mapped character. The example applied the final theorem without hypotheses. The probe also printed the completion definition and axioms of the final export, actual L box, completion identity, Gamma enclosure and generic reality theorem.

Lean 4.35.0 ran with `-j 1 -t 0`, no heartbeat override and no dependency build. Exit was 0. All five axiom sets are exactly `propext`, `Classical.choice`, `Quot.sound`. There is no `sorryAx` or project axiom in the transitive final closure. Lowercase `-t 0` sets the trust level; it is not a resource override. The temporary probe was deleted after retaining its exact text and hash.

The receipt is `work/lean-pilots/audit/positive_height_export_probe_receipt.json`, SHA256 `BABB0916686CAE2D9F14187A8442AADC70DD9E5808D2F7697AAD438EAB5F0414`. The log is SHA256 `DBECF2DD25BFA17E47DEDBDB60227B676C1E02B6E1759C35D1369D81D35582EC`. The receipt binds 24 source/object pins, the exact command and Lean executable. Its 44.024-second wall measurement is a narrow import/type/axiom audit, not generation or spectral throughput.

A separate read-only evidence check verified all 24 pins, four supporting reports and all eleven complete original proof bodies inside the author's fresh `FullSpectralPilotV2.lean`. Only imports and file-scope section wrappers differ in that concatenation. The combined file imports external Mathlib/project continuation modules, not the concrete pilot proof modules. Its source is `948342E85DE5C59BC96CD00AD494FE343514EDDBD545D9A6A7F3D26356C1BAD1`; the manifest is `D7BC60631D93A516009614A8BF60C1B3BF6553AB90836BF67C2C334136CAD781`. The author's strict-trust build receipt reports exit 0. That log contains harmless linter/tactic diagnostics, so this review does not describe it as warning-free. The initial concatenation's scope failure is preserved by the author. The static evidence receipt is `work/lean-pilots/audit/positive_height_evidence_receipt.json`, SHA256 `0BAE09318029878B54870AA155F8031FDD07E0B2C928E350B6ED15A9387FFA71`.

## Bounded conclusion

The closed internal positive-height theorem passes declaration fidelity, actual-object semantics, term-level consumption and transitive axiom checks. No actual-L, tail, Gamma, root-number or sign premise remains open in this theorem. Frozen predecessor files were not edited.

The pilot uses a direct eight-term character sum with a deliberately coarse but adequate tail. It does not measure a large CT/Bluestein transform, a reusable high-height Gamma producer, an interpolation repair schedule or a Turing completeness computation. It proves no family-wide RH result and no success-rate or throughput scaling law. Its complete semantic result may inform pilot accounting only with those distinctions retained.
