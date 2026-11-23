# Independent inverse-root comparison audit

Status: **PASS for the compiled semantic comparison, measurement method, and all nine published measurement rows.** This review reads existing sources and receipts only. It runs no Lean build, candidate generator, inverse-root evaluation, replay or reporter. The initial source/method audit (SHA256 `62E62CAF3F7B01589C19C7EAB181400681D638E5F863CCD2CAB34096106B723C`) withheld numerical comparison while generated measurements were pending. This authorized successor binds the completed `MEASUREMENTS.json` below and adds an independent receipt/arithmetic check. It does not assert a production-speed improvement.

## Same actual mathematical result

For each of the same 64 ordered positive integer inputs `x`, both implementations conclude, with the same concrete integer `m`,

`0 ≤ (sqrt x)⁻¹ − m / 2^98` and `(sqrt x)⁻¹ − m / 2^98 < 1 / 2^98`.

These are unconditional theorems about `Real.sqrt`, not hypotheses about a candidate, a finite mask, or an abstract approximation predicate. Both aggregate roots are the exact ordered conjunction of these 64 claims. The current default-resource supplied source is used, not its historical raised-heartbeat predecessor.

Independent static checks matched all 64 fixture numerators and input identifiers against the generated source, compared every leaf's statement text against the supplied source, and compared the full aggregate headers. The compiled `AuditRawGenerated` probe is stronger than a pretty-printed resemblance: it retrieves both theorem declarations and checks `Lean.Expr.equal supplied.type generated.type`. Its saved successful log contains `MATCHED_TYPE,64,supplied_and_generated_inverse_roots` and exactly the standard axiom list `[propext, Classical.choice, Quot.sound]` for the generated aggregate. The earlier supplied-root audit remains the corresponding supplied-side axiom evidence. This review independently read the probe and checked its receipt/source/object pins; it did not rerun it.

## What differs

The supplied implementation accepts the fixture's proposed integer numerator only after kernel-checked lower and strict upper adjacent-square comparisons. The generated implementation defines

`inverseRootCandidate x S = Nat.sqrt ((S*S)/x)`.

For positive `x`, natural square-root correctness gives `m*m ≤ (S*S)/x < (m+1)*(m+1)`. The two positive-divisor equivalences then give `m*m*x ≤ S*S < (m+1)*(m+1)*x`. Integer casting and the existing actual inverse-root soundness theorem yield the same real enclosure. Positivity of `S` is supplied when invoking that enclosure; the integer certificate itself needs only positivity of `x`.

Each generated fixture theorem proves `inverseRootCandidate x (2^98) = m` using `decide +kernel`, then specializes the generic producer theorem and rewrites by this checked equality. Consequently the saved literal is an untrusted expected output, not an assumed evaluation result. The emitted file imports `RawInverseRootProducer`, not the supplied witness module. Reading `generate_inverse_candidate.py` confirms that it merely copies pinned fixture data and emits these obligations; its Python execution is not part of mathematical acceptance. It does not calculate a new inverse root. No `sorry`, custom axiom, `native_decide`, or resource override occurs in the generated fixture source.

`invgenerated01` records clean successful construction of the generated fixture module; `generatedaudit02` records the compiled exact-type and axiom check. Both receipts bind unchanged sources and resulting objects. They do not by themselves provide a matched first-construction comparison: the supplied `RawLogCases64` module also constructs logarithm claims, whereas the generated module contains inverse-root claims only.

## Replay boundary and imported costs

Both replay wrappers select their own namespace, the inverse-root aggregate, width 64 and 1,000 repetitions. The existing replay implementation recursively collects theorem dependencies in that namespace, renames their types and bodies, rejects any surviving original namespace reference, and submits each fresh bundle to `addDeclCore` at trust zero. Each repetition starts from the same base kernel environment. Thus this is acceptance of renamed concrete proof terms, not just a reference to the final imported theorem.

Generic theory outside the selected namespace remains imported: in particular the generated candidate definition, `Nat.sqrt`/division correctness, the generic producer enclosure, and the common analytic inverse-root theorem are not reconstructed on every replay. Computation required to check the concrete candidate equality is part of the generated replay, but proof of the generic algorithm is not. The analogous supplied checker theory is also reused. The successful receipts report 321 collected declarations for supplied inverses and 193 for generated inverses. Fewer declarations therefore do not imply lower checking cost: their proof bodies and computation differ.

Both wrappers explicitly set `maxHeartbeats=0` and `maxRecDepth=65536`, within the separately documented bounded measurement protocol. These are disclosed replay settings, not default source-construction settings. `-t0` is trust level zero. The comparison must retain import/library setup, source elaboration, proof production, pool renaming, warmup, retained object size and per-run process overhead as separate quantities. A kernel-replay ratio cannot price these away.

## Reporter review

The reviewed reporter is `E1BFAB3F…`. Its three groups are:

| Group | Included receipts | Repetitions per process |
|---|---|---:|
| Logs | `cpu_logs64_02`, `_03`, `_04` | 50 |
| Supplied inverse | `cpu_inverse64_01`, `_02`, `_04` | 1,000 |
| Computed inverse | `cpu_generated_inverse64_01`, `_02`, `_03` | 1,000 |

The supplied `_03` interruption is excluded explicitly, with coordinator-observation provenance and no invented CPU or elapsed cost. This is replacement of an incomplete run, not silent selection of a faster valid observation. The three supplied included receipts currently report valid protocol, exit zero, 321 declarations and 1,000 repetitions.

Before publication the reporter requires all nine receipts, exact wrapper hashes/arguments, trust and resource markers, positive finite measured intervals, successful exit, no reader/stop errors, unchanged import snapshots, matching log hashes/COVER data, and the complete request/acknowledgement files. It checks group consistency and identical hashes for shared local imports across groups, and publishes by exclusive creation only after validation. It is an aggregation/validation script, not a new measurement or proof checker. Its integrity rests on the saved runner evidence and source audit as well as these consistency checks; markers alone do not prove an honest implementation.

The divisions by repetition count and then by 64 correctly form observed per-bundle/per-input averages. Medians/minima/maxima are over three fresh processes; within each process the same fixture is reused. Phase CPU includes child-side handshake polling and boundary bookkeeping. Child inner-loop elapsed has narrower boundaries. These are different observables, and their separately computed ratios must not be conflated. Whole-process totals include imports and warmup and use different repetition counts for logs, so are not construction comparisons. The fixture's native proposal CPU value, if zero, is below timer resolution rather than zero work.

The reporter computes ratios only between the two inverse groups with identical semantic output. These numbers describe the fixed proof representations and this checker/reuse boundary. They do not establish batching improvement, an optimized algorithm, complete source-production speedup, or transfer to 265,800 inputs, complex recurrence, completed signs, zero completeness or the TG workload.

## Completed independent measurement check

A separate read-only inline checker, without importing or running the author reporter, made **800 successful checks**. It reconstructed every saved summary field from the nine receipts, verified exact prescribed labels/repetitions/declaration counts, checked successful protocol/exit/status fields, command and wrapper bindings, exact COVER/limits lines, marker inventories and contents, receipt/log/wrapper hashes, and every before/after local import snapshot. The merged 26 local file pins (4,255,058 bytes) agree across all groups and with current files. The reporter and fixture pins agree with the original audit. CPU medians and ratios were independently computed using rational arithmetic from the saved decimal process times; elapsed values used integer nanoseconds. No new measurements were taken.

Each table entry is seconds per complete 64-input bundle, obtained by dividing the measured phase by its repetition count. Ranges are the minimum and maximum of three fresh-process observations, not confidence intervals.

| Group | Replayed declarations | Median process CPU | CPU range | Median inner elapsed | Inner elapsed range |
|---|---:|---:|---:|---:|---:|
| Logs | 195 | 0.8378125 | 0.820625–1.011875 | 0.84469406 | 0.82913035–1.01996075 |
| Supplied inverse | 321 | 0.137140625 | 0.131140625–0.14578125 | 0.1380385143 | 0.1321724346–0.1480673285 |
| Computed inverse | 193 | 0.219328125 | 0.205203125–0.22296875 | 0.2272305655 | 0.2076441875–0.2306453559 |

For the matched inverse contract, the ratio of median supplied to computed **process CPU** is exactly `8777/14037`, approximately **0.625276**; equivalently computed replay uses about **1.599294 times** the median CPU. The corresponding inner-elapsed ratio is `1380385143/2272305655`, approximately **0.607482** (inverse approximately **1.646139**). These are ratios of separately observed medians, not paired-run ratios or a forecast. The log row is a separate source-component measurement, not another implementation of the inverse-root claim.

The measured outcome favors supplied-witness replay for this fixture and these proofs. It does not settle the combined cost of proposing candidates, proving the generic producer, constructing/elaborating concrete proofs, importing libraries, storing/transporting artifacts and checking them once. In particular the whole-process replay totals are **not first-construction times**, and the generated and supplied original modules have different construction scopes. No end-to-end or TG saving is inferred.

The final report's nine receipt pins are:

| File | SHA256 |
|---|---|
| `MEASUREMENTS.json` | `67E33EED8D679D97E5598B2FD1F68AE9EF8D663BE8CB143C918405A4E97F9815` |
| `cpu_logs64_02.json` | `2137737E2E7508BEDF9FAEB5B66BDD406A94A4A833D0F9A401B931BE4D80BA1A` |
| `cpu_logs64_03.json` | `AA605EEC30D3C9E8FDE5990AD98F0C6E23FF8174100663EC37646CC25E1B7E8F` |
| `cpu_logs64_04.json` | `1976DAD61A378B8E80E288B8F2BDDC87A338180FC1D140031B946E148F70A5CC` |
| `cpu_inverse64_01.json` | `3983A1A930CBA7D3584329EA918959620262FD3C759C733600D86865504C81DD` |
| `cpu_inverse64_02.json` | `D7649C4E94363431421089EC289F1361E3E5ECEE7914AEB3AE232E4EEE5308C0` |
| `cpu_inverse64_04.json` | `7886CCDC97399A13B14817C489FD99A41EAC55869FFE21FDB3210344D4BDCB93` |
| `cpu_generated_inverse64_01.json` | `6FCA36A45B76FC6DFA6D378C52B8030654881A8D29A4ACD6B3B45776880C9D4B` |
| `cpu_generated_inverse64_02.json` | `84CDAB25654D76F80FABDB4D0A7923B9D0B9489A977AB9631F889F433DDEA5F2` |
| `cpu_generated_inverse64_03.json` | `8B5B262D8D0CC260294E6E6EFE5B8802EB51174E9E922655C4ECC67F5A9926CD` |

## Pinned evidence

All paths below are relative to this directory unless stated otherwise. SHA256 values were checked from current bytes during this review.

| File | SHA256 |
|---|---|
| `fixture64.json` | `BB725A50AB0EC32A07F3516542E2FC3CE59081E75598E7283B686D0AFDBB12C3` |
| `RawLogCases64.lean` | `0B922F559AB7F10EEFFC0FEAB697AED9D8035BA1161C4B30F636A43C829D01EC` |
| `RawLogCases64.olean` | `890C853F2984DF84D199376C01FDE72E126ADADF29B5E6C444668867711296DE` |
| `RawInverseRootGenerated64.lean` | `4E8734F6F6AB2ECA6D06A0AE3A0076B593958F25ABF7C4CD55F4E56008AA288A` |
| `RawInverseRootGenerated64.olean` | `22D4414B7A1E2FD7C1640D20B2268969FD470CAF20AAF94428D2684F20381C79` |
| `RawInverseRootProducer.lean` | `AB4B5B6721C03D37E87DC09732865B27A42161C8B7B686EEC50EEF48B676353B` |
| `RawInverseRoot.lean` | `D0B6C28B39F35DE88056CA4BBB078B2A8D84463DC92AAA2D32F3C4CD1BA67619` |
| `RawInitialization.lean` | `C695D2F12F1822C57A8E13EC4376CD2E0378D90B82ABD111805FC7A72FACA1E1` |
| `generate_inverse_candidate.py` | `8A7B29D79BF5610406F6C84D36F10E5966502E906CC82A95CB2CF624B04E0EB2` |
| `generate_cases.py` | `2D929670B83B39F3BBD5C7EEF9CA4B155C33D13177C3F7E6C47EBC4075EEDD9F` |
| `AuditRawGenerated.lean` | `6B1524FF6D0DEC50D21AC4EF6FB64D96A7995EF4C03BBD4D658DB1417C9AFE1F` |
| `AuditRawGenerated.olean` | `10B315A7EE31CD301611B969AC08AFA572BFA4F59F20866A081AE8B4B6C6B458` |
| `generatedaudit02.json` | `F28F0747F62BAC3FCB3FC7E352ACF520536B62BEA9B3CD682A40B6CEA13ECB4F` |
| `generatedaudit02.log` | `0A5F41349ACE63FCE4FE261964231583DEE1FC754D5640E57AE9148213CB70E4` |
| `invgenerated01.json` | `4835D492F11501B9856788252092CC53C075786C3C4CDC81020DEE8DA2936310` |
| `report_measurements.py` | `E1BFAB3F1B57EA0A7E386696437F6E539943D84D7631BB94AC132325D961567B` |
| `RawReplay.lean` | `3C2BFF76BB762B21A5ED86D02946B4592D5741D843E46AA0A37734B57005E943` |
| `run_replay.py` | `AEA4F1DB24BC2298EE562332B3B106C92F70F04FE4A1119F1464AF3A4D6C745C` |
| `CpuRawInverseRoots64.lean` | `661595CA11540F221B4CD871073D6497D8AF3C978E9419E59D798D1A5A183E84` |
| `CpuRawGeneratedInverseRoots64.lean` | `26555DC23E6F605F0EF990D783DC522CC1852C18F27E854F528993151261B8A0` |

Only this audit file was written. The first read-only static check encountered Windows' default text-decoding error; the UTF-8 rerun passed. No author file, fixture, object or receipt was changed.
