# Direct ordinary-MMB implementation preflight

Reviewed 2026-11-12. This is a source and format review of the snapshot pinned below. No compiler, verifier, candidate generator, full fixture construction or benchmark was run. Only existing files, saved binary metadata and the fixed fixture's sign labels were inspected. The reviewer changed only this file.

Verdict: **revise the experiment controls and reporting gates before accepting a complete comparison**. I found no source-level arithmetic or command-order defect that prevents a bounded, staged zero-case diagnostic. This is not acceptance of an emitted proof. Both complete files still require the ordinary parser-enabled checker, independent output audit and successful controls.

## Exact claim and arithmetic

`prepare.py` takes exactly the 64 ordered pairs `input[2], input[4]` from the pinned `P343N64.json`. It represents each signed integer by `(max(x,0), max(-x,0))`. For each row it exports

```
XP*YP + XN*YN = ZP
XP*YN + XN*YP = ZN
```

with six concrete component definitions and `z=x*y`. The balanced conjunction preserves all 64 rows and both equalities. This is a sufficient exact signed-product contract for those canonical natural pairs. It is not an integer-sort import, rounded product, recurrence, transform or analytic theorem.

The magnitude proof uses the same binary multiplication and four-bit addition recurrence in both arms. Nonzero signed-coordinate products reuse that proof. Zero products, additions, transport and conjunction are proved with existing PA rules. The frontend and direct arms use the same specification and derived proof structure; differences in inferred conversions, term sharing and serialization remain measurable differences. The conjunction is included initially in both arms, so the historical separate aggregate-import timing cannot be added only to one arm.

## Controls that are missing or insufficient

1. **The zero-size control is only library plus `0=0`.** It does not test zero multiplication or a sign wrapper. The actual fixture has 17 negative/positive, 15 positive/positive, 14 positive/negative, 17 negative/negative and one negative/zero pair. Thus its full proof exercises every nonzero sign branch incidentally, but no left-zero or zero/zero case. The planned explicit zero and sign-helper checks are absent. The implementation also constructs concrete per-row wrappers rather than the four once-proved generic wrappers proposed in `MM0_NEXT_MEASUREMENT.md`. This change is sound in principle, but must be reported and tested as the implemented design. Add small separately checked controls without changing the timed 64-row fixture or claiming that the empty control already provides them.

2. **The planned sign-conversion corruption is absent.** `audit.py` constructs four mutations: input magnitude, input sign, result magnitude and a theorem reference in `signedProduct63`. These are useful, distinct checks. They do not constitute the separately requested corruption of a sign-case conversion. Add an explicit conversion/binding mutation, or narrow the advertised control coverage. The theorem-reference mutation's actual rejection also remains to be observed.

3. **A resource failure can pass the rejection classifier.** The runner excludes exit statuses 0, 124 and 137. The collector additionally requires `MM0_REJECT`, but the actual checker prints that prefix for `stack overflow`, `heap overflow`, `store overflow` and related capacity errors. Require a non-resource logical/format rejection and preserve its reason. A timeout, signal, allocation failure or capacity limit establishes no corruption sensitivity.

4. **The collector is weaker than the successful runner protocol.** `run.sh` checks its input manifest at the end, but `summarize.py` does not validate that manifest or its final successful unchanged-input result. It accepts whichever non-check phase timing files happen to exist rather than requiring the complete phase inventory. Manual collection after a failed or incomplete run could therefore publish a misleading result. Make collection fail closed on all required phase receipts and unchanged input/artifact bindings. Until repaired, only a separately reviewed successful whole-run record could supply these missing gates. Python assertions must be enabled; an inherited `PYTHONOPTIMIZE` setting is not an acceptable execution environment for these assertion-based audits.

These are pre-acceptance blockers for the advertised experiment, not counterexamples to PA multiplication. Root should retain every failure and request a bounded repair before publishing a matched timing table.

## Ordinary command and library boundary

I compared `mmb.py` with the pinned parser/exporter and the actual C checker sources. The following choices are consistent on inspection:

- The command prefix has 0/1/2/4 little-endian argument bytes. Statement lengths include their own prefix. Table offsets are rebuilt and aligned; original term and theorem IDs remain unchanged.
- Every original library proof statement is copied, not replaced by an assumed theorem. The original library has 3 sorts, 170 terms and 2,994 theorem headers, including the four-bit rules and bootstrap. Direct output appends its declarations and omits only the optional debug index. The fixed ordinary-PA axiom list remains 26 entries.
- Proof emission orders premises, arguments and result before `Thm`, matching `export.rs`. Term sharing uses actual local `TermSave`/`Ref` identities. Unifier saving reserves the slot before descending, and hypothesis order is reversed to match the checker's pop order.
- Explicit conversion uses the existing `Conv`, `Refl`, `Symm`, `Cong` and `Unfold` commands. The matcher and native integer calculations propose a proof; they do not extend the checker. Fresh local emitter caches respect theorem boundaries.
- The independent output audit does not import the encoder. It checks component bodies, magnitude statements, ordered signed conjunction, the unchanged axiom list and absence of `Sorry`. It also compares the direct library statement bytes with the saved library. Logical acceptance and exact public statement matching still belong to the parser-enabled checker.

This does not prove the encoder correct for arbitrary MMB files. Its bounded signature parser only supports the regular-variable arithmetic fragment it consumes. A malformed proposal must be rejected by the independent checker, not excused by the producer's assertions. The first real run remains necessary to check all inferred frontend conversions and direct substitutions together.

## Resource and timing boundary

The proposed cap is **10 GiB virtual address space**, from `ulimit -v 10485760`, with 600 seconds per regular phase and 120 seconds per corruption check. This is deliberately different from the Lean/HOL 4 GiB jobs. The historical `fourbit64.compile.time` records 6,374,992 KiB peak RSS, 63.57 user plus 15.51 system CPU seconds, and exit 0. Its RSS already exceeds 4 GiB. A 10 GiB virtual cap is not a promise that the new frontend or direct proposal fits.

The selected ordinary-rule checker has enlarged capacities: stack 65,536, heap 2^22 entries, store 2^30 bytes, hypothesis and unifier stacks 256, and unifier heap 65,536. This review does not establish stock-capacity acceptance. The internal timer in `timed-src/main.c:73-76` includes `init_parser()` and `verify()` after file mapping. Whole-process CPU/elapsed and internal checking CPU must remain separate; do not add them as disjoint work.

The direct preparation cost includes parsing and re-emitting an existing proved library. The frontend arm compiles its textual import. Both full output files replay the library during checking. Historical library proof development, compiler construction and a new platform's toolchain installation remain outside those per-output timings. The empty-file subtraction is only a setup diagnostic, never a replacement for gross first production and acceptance.

The files remain on the selected filesystem. This does not reproduce the historical warm-tmpfs measurement automatically. Five repeated checker runs do not measure five independent proof constructions. Profile/high-water runs and mutation checks are additional diagnostics, not part of the primary median. The current code reports CPU, wall time, sizes and counts separately, which should be retained after repair.

## Smallest next command

For a staged source-generation diagnostic only, from the repository root, the existing README's exact command is suitable:

```powershell
& C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe work/backend-costs-20261112/mm0-direct/prepare.py spec 0
```

Run it with assertions enabled and preserve its output. It produces only the common zero-case specification; it proves nothing and is not a benchmark. Because outputs are exclusive, doing this prevents a subsequent fresh `sh run.sh direct01` without an explicit archival/version decision. Do not delete evidence to make that runner proceed. If root instead repairs the controls and collector first and chooses the complete fresh-directory experiment, the declared Linux command remains `sh run.sh direct01`, subject to the stated caps and stop-on-failure policy. This reviewer has run neither command.

## Reviewed pins

Paths in this table are relative to this directory unless stated otherwise. A changed candidate needs a targeted successor review; these pins do not endorse later bytes.

| File | SHA256 |
|---|---|
| README.md | 302A4B3DCFC807CFD61B9297D86B911131D76C3B41CED665362694293890A92C |
| mmb.py | 45373102AF356E8737C995248CCF9E8CDF410919D28330932F4C13039FAC98AC |
| prepare.py | 52EFAB7D37CC43B18B1E026DB38F2BB4F5A924B2F66833BA298C6FB64E8AC095 |
| audit.py | D9F1E59AF80442801113CF471A6F2B63EC34FFA1A2E5069FC6ECBB003E7D7430 |
| run.sh | BC4FAA34A3800ACF5162C771A54F345F932B10A5EA0ECEF1C95D4A4340EB9795 |
| summarize.py | 51903A850978A50999F17D495C7B25BA623C165191109A7069A34E9D4D8605FD |
| unit_format.py | 12EC8A7395F0AA5591B1B01A8A0B95DA625728CCAABE2F27EBB1BCD662E95579 |
| ../MM0_NEXT_MEASUREMENT.md | 1369FD33BAD7B92684689BA8721ABB60045B762C17AA295D0EE87DE3DAD808A2 |
| ../mm0-pa/fourbit0.mmb | 813A982693548162973DCBAAB7BA4B2558EDD3CEFC7179040113E92ECBD9CBF4 |
| ../mm0-pa/fourbit64.compile.time | B00DD074259DC72648CCF345C73300CA8CFDDD3A6A6F0FFF29B2282CDFD3B8DA |
| ../../lean-pilots/batched-transform/P343N64.json | F024EAF87BD02898530A72CAB2C567B00C98BCC83DF48E0BE4E8D9CFCA6D00AE |
| ../../formal-goldbach-bench/mm0/timed-src/main.c | CD59AAD1DADD47AFCE54CD65A080B9715E9ABFE584D56A04CE4A4D0C0E91F63A |
| ../../formal-goldbach-bench/mm0/timed-src/verifier.c | 7C991DF328C4BF463605C2C01CF609DA9A31C8C2EF27B019B8F3582BE3B3C3EA |
| ../../formal-goldbach-bench/mm0/timed-src/verifier_types.c | F642629BAD66B4D44EBE2ACE9E42EEC5E86489833B815FD31F132BE92A196EC5 |

For upstream commit `0d414c0bfdaaeb7fea571895127abc1fa5a3d956` under `../mm0-pa/mm0-<commit>/`, `mm0-rs/src/mmb/export.rs` has SHA256 `6858428079696F9C487A76FE9773EB629D6C8863AFE7A60B5B4D826BA737A8F0`; `mm0-rs/components/mm0b_parser/src/lib.rs` has SHA256 `5A1EF03F0C447A7A020D8DD7534AEA32201771A906F9491FBB8C1F0E81B2838C`.
