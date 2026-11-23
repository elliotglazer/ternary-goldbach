# Independent static gate for both small-EM-batch implementations

2026-11-11. **PASS for the final frozen producer, independent verifier and schema at static/preflight scope.** Three narrow issues found in the independent draft were repaired before its final freeze. No remaining blocking source-fidelity, error-unit, coverage or publication defect was found. This does not authorize execution, establish numerical containment or predict either implementation will meet its caps.

Neither evaluator was imported or executed. Only paper/source reading, file hashing, AST inspection and compilation to unexecuted code objects were performed. No FLINT call, logarithm, phase, moment, transform, coefficient, image, Lean build or spectral scan ran.

## Frozen versions

Paths below are relative to `work/qrh-campaign/agents/`. Every hash was independently checked from disk.

| Artifact | SHA256 |
| --- | --- |
| `integration/small_em_batch_candidate_20261111.py` | `23D358590279AA810EAE764D3FEEA0756C51DF8CF0EA6F05B457A192BB82822C` |
| `integration/SMALL_EM_BATCH_CODE_PREPARATION_2026-11-11.md` | `65379869F849BB27BE9DF4974F73984269FECF1C408C442D2C772BFF37E53500` |
| Producer preparation check | `43B8EC0D5481770B258F42463BD579AE4470103DBC2AAB667EB3432BC9F5D13B` |
| `independent-feasibility/review_small_em_batch_prepared_20261111.py` | `A6F6A8C78B4DC70F657564D19398ADF2E9F8922B005969B7ABAAA62BFBBC5A9A` |
| `independent-feasibility/SMALL_EM_BATCH_INDEPENDENT_CODE_PREPARATION_2026-11-11.md` | `2619FCF789FA8CF3592B26CFBB5612A2E3C7D3D54086A3FA142238F443A848DF` |
| Independent preparation/syntax check | `044F499982B25A36D40AE8F8CA3B34F2D4C97C5158240D7804420A204AA08D33` |

The fixed main specification is `3977881D20CFE9F948E850AC9A83CF50084AA1EF7D0B7023E5D1A95DE845B929`; scalar support is `47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23`; receipt contract is `DA2740C39148A2F1AB2291E6581B5C55A75BF33456E8006CB148B34B516178AF`; accepted paper preflight is `E8D928EB25CA0AAB583609D33DF982CFC2A1D01E65890AE8BCBBB58C4BF9C7F0`.

The review's own [static checker](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/check_small_em_batch_static_20261111.py) and same-basename JSON record syntax, hashes, imports and literal source-pin equality. All ten producer pins and all sixteen independent pins matched. The independent required producer-pin dictionary equals the complete producer dictionary. The static receipt SHA is `5A531788F7652BE06BD02CD0A21E630AC79CA74BA88FE8AC8F0072772D19E681`. These checks supplement the manual review below; they are not behavioral tests or a proof of program correctness.

## Producer formulas and error units

The target and all 8 centers are fixed, with N1024, B1025, M16, K16, p24, J8, L32, sigma629/1250, t0=31999/16 and Delta=-1/8. Closed panels cover exactly heights [1999,2000]. The endpoint owner min(l,7) is preserved for all nine canonical endpoint images.

The producer computes every actual bin witness from enclosed log/pi values, keeps the full signed q in the residual, and uses q modulo32 only as a bucket index. The rational midpoint floor, width, full label range and actual residual enclosure are checked. The h-streamed moment recurrence includes both factorials exactly once and every n. It creates all 12288 entries, including empty bins.

Lossless internal midpoint/radius exports and the sum of coordinate radii certify the Euclidean 2^-110 moment disks. The positive normalized FFT starts from the exact stored dyadic centers, with explicit exact-import checks, bit reversal and simultaneous butterfly reads. It does not run on uncertain actual-moment balls and then mislabel the resulting width as arithmetic-only. Each of the 3072 consumed outputs has its separate 2^-110 arithmetic disk at index -j modulo32. Horner at exact j/8 and multiplication by32 have a separately checked 2^-100 rounding allowance. The source-input errors sum over bins; transform errors receive the factor32. The residual Taylor term is charged separately for every h.

The complete correction uses all sixteen Bernoulli terms, rising lengths1,...,31, the half term and Q=(s_j-1+z)R+B. Multiplication by exp(-z log B) gives normalized correction jets. The B-phase recurrence propagates approximate-step and rounding errors, using the valid upper bound B^(-sigma)<=1 rather than assuming the approximate step has unit norm. The correction-product decomposition charges phase_error*norm(C_center)+C_error+product_rounding; its norm bound includes the mixed effect. The complete correction, not an unmultiplied coefficient, must meet 2^-80. Final assembly has a separate 2^-80 check. Every actual finite-g coefficient midpoint error must be <2^-53 before exporting the fixed coordinate halfwidth2^-52.

Actual rational sigma is enclosed, not substituted by a float. Its interval uncertainty is retained in phases, correction polynomials and final assembly. The final g coefficient is the complex-s normalized derivative; no height-derivative i factor or second factorial is introduced.

## Independent scientific coverage

The independent code imports no producer module and uses fixed224-bit interval arithmetic. Its n-major moment accumulation differs from the producer's h-major schedule. It keeps the producer's certified q labels, independently encloses every actual bin coordinate and residual, and proves all 12288 actual moment boxes fit their fixed claimed disks.

It directly computes every consumed 32-term positive normalized DFT of the stored rational centers, without radix-two butterflies, and checks all3072 full-box disk containments. Center-transform correctness is distinct from actual-moment correctness. It separately constructs all128 finite-g jets by direct sums at every center, without bins or FFTs. The independent correction forms D=main+EB/2+EB*A and H=exp((1-s)log B), then g_h=(s-1)D_h+D_(h-1)+H_h. This avoids using the producer's B-phase recurrence as an oracle. Every direct-g rectangle must be wholly contained in the fixed producer square, not merely overlap it.

Required diagnostic sections and their dimensions are checked. The verifier additionally reconstructs main-jet contraction and error sums exactly, checks Bernoulli constants and phase-error recurrence, and checks correction/assembly caps. It does **not** independently prove every stored elementary or internal R/Q/C diagnostic ball has its advertised analytic meaning. Those narrower diagnostic claims rely on reviewed producer source and external interval semantics. The separate moment/DFT/direct-g paths establish the consumed output claims without that stronger diagnostic claim. This is not a standalone operation-proof trace.

## Rational images and serialization

Both implementations use exact rational rectangular Horner on the fixed g squares, add the EM and finite-g Taylor coordinate padding once, then multiply by the reciprocal rectangle of the full s-1 input. Correct unary interval squaring makes the reciprocal denominator strictly positive. The two implementations' reciprocal operation orders are equivalent: extrema of endpoint division by a positive interval equal multiplication by its reversed reciprocal interval. The independent verifier requires exact equality for all eight whole panels and nine endpoints. It does not re-add coefficient uncertainty or the unused optional 2^-64 allowance.

The actual offsets are purely imaginary; the separately reviewed coordinate-square propagation therefore applies. Actual EM is used on target points, while the finite-g outer estimate applies to its larger disks. These domains are not interchanged. No positive-real test, image intersection, polygon or winding is required by this evaluator-only experiment. An image containing zero may still be a valid output.

The schema separates dyadic internal mid/rad balls from reduced rational final endpoints. Installed `flint/types/arb.pyi`, SHA `0B8F83271C2D328B49CD9D924C9CD6EC7383D6F72E59261EA754E42A2092D1F4`, exposes the tuple constructor, mid/rad/man_exp and exact/finite checks used here. The producer also checks that reconstructed center points are exact and equal to the source dyadic. Neither implementation substitutes precision-rounded display endpoints for full internal balls. This source/API inspection is not a runtime API test or verification of FLINT.

Duplicate JSON keys, changed exact parameters, missing/duplicate indexed claims, widened fixed budgets and malformed mathematical payloads fail acceptance. Integer/string/exponent bounds precede costly shifts, and rational signs, reduction and ordering are checked. The independent parser has additional conservative size/depth limits; a legitimate but unusually large packet can fail those limits rather than be silently accepted. No arbitrary malformed-input performance guarantee is claimed.

## Repaired draft issues and operational acceptance

The final independent version fixes all three findings raised during this review:

1. Candidate provenance now requires the exact ten-entry producer pin dictionary, not only the first four contract pins.
2. A zero disk radius requires a zero center, matching the fixed exact-zero exception.
3. BaseException handling downgrades an observed interruption, including publication interruption. A final console record binds the actual serialized receipt hash, candidate hash and independent code hash.

Both programs require separate coordinator manifests, verify exact code/source bindings before importing FLINT, and have no child-process, delegation, automatic retry or retuning path. Source scans found no builtin zeta, Hurwitz, Gamma, theta, Riemann–Siegel or zero oracle. Elementary FLINT arithmetic remains external trust.

The producer reserves an exclusive attempt marker and pending file, streams a bounded receipt, checks time/peak working set after serialization and telemetry writes, then uses no-overwrite Windows rename and a post-publication guard. On handled failure it removes only files owned by that attempt and writes a bounded failure record. The marker prevents same-name restart. The independent verifier exclusively reserves its result, then updates only that owned handle; post-write failures replace it with a failure record. It never overwrites an unrelated existing artifact.

Caps are180/360 seconds,512MiB evaluator-process peak working set and64MiB per receipt. Windows peak-working-set sampling and serialization costs are included at the specified guard points. These are cooperative checks, not hard OS limits. An in-flight call or external kill can prevent cleanup. **The coordinator must require successful process completion and final completion records, not a PASS-looking file alone.** For the independent run, verify all final console hashes against the actual files; retain observed resource data for both runs. Missing telemetry or observed overshoot prevents complete acceptance. Post-serialization snapshots are not mislabeled as complete process lifetime measurements.

## Verdict limit

The frozen code is suitable for the next separately authorized bounded experiment at the reviewed external-interval/paper-analysis scope. This static gate supplies no numerical results, runtime estimate, verified elementary library, rational-only transcendental certificate, standard-axioms Lean proof, nonvanishing result, new spectral coverage or change to the final Goldbach premises. All claimed containment and cap success must still occur in the actual runs.
