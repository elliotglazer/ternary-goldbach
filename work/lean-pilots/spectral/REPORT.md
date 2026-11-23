# Positive-height spectral Lean pilot

The actual positive-height certificate is complete and independently reviewed. `SpectralPilot.positive_height_chi4_certificate` has no hypotheses. For the literal character `ZMod.χ₄.ringHomComp (Int.castRingHom ℂ)` and `s = 1/2 + I*(5/64)`, it proves

```text
0 < (4^(s/2) * chi4.completedLFunction s).re
and (4^(s/2) * chi4.completedLFunction s).im = 0.
```

The internal implementation is in `PositiveHeight.lean`. `FullSpectralPilotV2.lean` contains all eleven owned helper bodies and the final theorem, importing only the external Mathlib and `LGrowth` dependencies. No analytic enclosure, source accuracy, root number, functional equation, sign margin or finite-RH premise remains in the final export. This completes the representative sample, not a finite-RH family certificate or public anchor adoption.

## Proof and numerical producer

`Elementary` proves actual logarithm and complex exponential Taylor bounds. `FiniteInputs` connects them to the actual powers `n^(-s)` for the eight odd integers from 1 through 15. `RoundedInputs` checks concrete grid20 centers against those rational polynomials, with each actual input error at most `1/500000`. Their exact alternating character sum is `(572952 + I*51250)/1048576`, with total finite error at most `1/62500`.

`FiniteAbel` derives the finite truncation from the actual analytic-continuation integral in `LGrowth`. The character partial sum at 16 is exactly zero. `Tail` proves integrability and the remaining tail bound `33/128` using the actual partial sums. `SampleBox` therefore proves `Re L > 1/4` and `abs(Im L) < 1/2` unconditionally.

`GammaEnclosure` proves the actual Gamma/conductor phase box through the Euler integral, convexity and elementary bounds. `CompletionFactor` proves the exact positive scaling identity and consumes the proved L box. `Chi4Reality` proves primitivity, self-duality, root number 1 and completed-function conjugation. Its root-number argument uses the separately proved central nonzero value; it does not assume the positive-height conclusion. The final theorem joins positive real part and exact reality.

The input generator performs exact rational arithmetic only. Lean checks its proposed constants. These certificates establish enclosure of the supplied centers, not a particular nearest-rounding tie policy. Taylor intermediates use exact rational arithmetic with final grid20 rounding, rather than the fixed-grid production circuit priced in earlier research.

## Strict validation and measurements

All final commands use installed Lean 4.35 with `-t0`, default resource limits and read-only cached dependencies. No canonical source, dependency object or pin was changed. No dependency build, `sorry`, `native_decide`, custom axiom, heartbeat override or trust bypass was used.

| Run | Wall seconds | CPU seconds | Result |
|---|---:|---:|---|
| Fresh complete own proof source, `FullSpectralPilotV2`, `-j2` | 51.733959 | 63.031250 | Exit 0 |
| Same external imports only, `ImportBaseline`, `-j2` | 38.279340 | 37.937500 | Exit 0 |
| Full exact-type and transitive-axiom probe | 46.865792 | Not measured | Exit 0 |
| Corrupted finite input control | 22.114956 | Not measured | Exit 1, no object |

The full construction peak working set was 3,625,549,824 bytes. Sampled peak private memory was 8,722,370,560 bytes. The import baseline measured 3,384,676,352 and 8,512,413,696 bytes respectively. Memory comes from Windows process counters, with private memory sampled at 0.1 seconds. The sequential single-run wall and CPU differences are descriptive only; shared-host scheduling and cache effects prevent treating them as isolated arithmetic costs.

The complete object is 9,821,984 bytes; the rounded-input module alone is 6,774,144 bytes. These sizes and timings describe this proof construction. They do not calibrate billions of production checks.

The full audit and independent literal-type probe report only `propext`, `Classical.choice` and `Quot.sound`. The corrupted control changes the n=3 center to zero while retaining the claimed small error; Lean rejects the proof with the residual goal `False`. Its failure is mathematical, not a syntax error.

Early module builds used default trust and remain development evidence. The final full construction and audits are explicitly strict. The first assembled source failed because file-local `open` declarations leaked into later concatenated bodies. V2 restores original file scopes and implicit section endings without changing proof bodies. Both sources and the failed receipt remain preserved. The successful V2 log retains unnecessary-`simpa`, unreachable/unused-tactic warnings and a `ring` diagnostic; no warning-free claim is made.

## Frozen evidence

| Artifact | SHA256 |
|---|---|
| `PositiveHeight.lean` | `955866564A49B21DC9B6436B7B830305ED569C167474CB9E592486CB2355309A` |
| `FullSpectralPilotV2.lean` | `948342E85DE5C59BC96CD00AD494FE343514EDDBD545D9A6A7F3D26356C1BAD1` |
| `FullSpectralPilotV2.olean` | `9ADE460D1EBF4089A538395D7A949985A8D5A4E7499D6CEF6607A41B579C0D00` |
| `full_closure_manifest_v2.json` | `D7BC60631D93A516009614A8BF60C1B3BF6553AB90836BF67C2C334136CAD781` |
| Complete strict build receipt | `B27BD7FBA95B3E1F36A7FE281BC248D86B7FD4E9FE458877F32D5081C3C804D1` |
| Import baseline receipt | `A4B20A0C78F13EAEDA56AD07EFFC52B4283B535503502CD069895F97BA8B8D37` |
| Strict full audit receipt | `29B3B0493D60708CB9077201856DC69E1BFFF8A69ED58B7444DAF946FA62974D` |
| Strict corrupt-control receipt | `28DF7A697AFEA134D31D488A0CE6FC2248E2E956D0DDF459D298E416465054A7` |
| Independent final semantic review | `B6C709EDA23CA78F58CCFCC4A230189CA3AEAADE2DCC91174A36418C61AF3F23` |
| Independent input/tail review | `B5FE164DFC0758F3B8B867AA99E1F1AFBDD86D6C80670DCAC4FFBE1A6E9851D3` |
| Independent finite Abel review | `8AA5BB633EF1EA429887C2E58DCE96A8687F9DCC24719D49D6BAA9E794B05ED0` |
| Independent Gamma/completion review | `D905B0120422E5B3BA2212CE06DDE97CB8108E9BF7CCC3DE2AB55C68778549A4` |

`pilot_receipt.json` records actual paths, sizes and hashes for the source closure, objects, runners, logs, external provenance and independent reviews. The earlier `POSITIVE_HEIGHT_TARGET.md` is historical planning; this report and the final semantic review supersede its open-status sentences.

This pilot uses a direct eight-term character sum at one low positive height. Large CT/Bluestein transforms, interpolation, family-wide sign search, Turing completeness and high-height Gamma production remain outside its measured scope. No end-to-end production runtime extrapolation follows from this sample.
