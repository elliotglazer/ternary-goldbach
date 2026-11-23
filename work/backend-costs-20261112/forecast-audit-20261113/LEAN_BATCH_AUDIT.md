# Independent audit of the stock-Lean batch port

PASS for the completed source theorem and the saved bounded replay evidence. No proof-file correction is requested. The negative-control and timing limitations below remain explicit. This review performed only source reading and small in-memory parsing, hash and receipt checks. It ran no Lean build, kernel replay, modular arithmetic or primality computation and wrote only this report.

## Exact mathematical result

`FiniteBatch1024.complete` in `finite-lean/BatchBlock1024.lean` proves both the primality of every member of the concrete 393-element `BatchData1024.roots` list and

    ∀ n : Nat, 3999999997356537860 ≤ n →
      n < 3999999997356539908 → n % 2 = 0 →
      ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n.

The interval is half-open, with 1,024 even targets and last even target 3999999997356539906. The actual printed declaration in `batchaudit01.log` agrees. The final theorem has no external certificate, primality, source-bitmap or coverage premise. `roots` is concrete data, not a universally supplied list. `PrimeCoverage.BinaryGoldbach` unfolds literally to the displayed existential statement.

| Logical variable or condition in the final conclusion | Classification | Finding |
|---|---|---|
| p : Nat in the root-list clause | TYPING | Universal natural-number variable |
| p belongs to the concrete roots list | SOURCE | Exact domain of the requested root assertion |
| n : Nat in the interval clause | TYPING | Universal natural-number variable |
| Lower endpoint, exclusive upper endpoint, evenness | SOURCE, three conditions | Exact requested interval domain |

There are no STANDING, RULED or EXCESS conditions. The root and interval clauses are proved conclusions of a closed conjunction, not assumptions used to certify themselves.

## Soundness and split coverage

`BatchPrime.contains` follows a binary-tree search, but soundness does not require a separate sorting hypothesis. A successful search reaches an actual node with the queried number. `contains_valid` extracts that node's validity from validity of the inspected tree. A malformed ordering can cause rejection, not false primality.

For p other than 2, `nodeValid` checks p>1, the complete expanded factor product p-1, strictly smaller factors present in the full tree, the Fermat congruence and the residue-not-equal-to-one conditions for every factor. `nodeValid_prime` uses strong induction on p. Each factor's node is valid in the same full tree and has smaller numerical candidate, so the induction hypothesis proves it prime. The full-product membership lemma covers every prime divisor of p-1, and `lucasNat` invokes Mathlib's Lucas criterion. The base p=2 is independently prime. There is no circular use of the desired root claims.

I independently parsed the generated tree and lists rather than accepting the JSON counts. They match `fixture1024.json` and the HOL coverage fixture exactly: 1,537 distinct candidate nodes, 7,614 expanded factors, 393 distinct requested roots and 1,024 exact witness pairs. Every pair has the correct target sum. As in the HOL audit, these pairs use 231 distinct root values and leave 162 requested roots unused by the chosen witnesses. The full 393-root claim remains proved; this is not a minimized interval certificate.

The eight `BatchValidPart00` through `07` modules contain 127 subtree-validity theorems. Static comparison against the actual data definitions verifies 64 directly checked leaf blocks and 63 checked interior nodes joined by `treeValid_node`. Each validity statement retains the same full `certificates` tree as its lookup context. Every interior theorem uses its actual left and right child proofs plus its actual p, a and factor-list check. The final `certificates` alias is `certificates_126`, and `valid_126` therefore supplies whole-tree validity. Splitting changes resource use, not the mathematical checker or factor domain.

`roots_checked` checks the complete root list; `rootsKnown_sound valid roots_checked` proves every requested root prime. Unlike the HOL benchmark, this port does not save 393 separately named root theorems. It proves the complete universal list claim. That distinction matters for output-cost comparisons, not for the primality assertion.

`covered` checks each actual pair's exact sum and both tree memberships. The list induction in `checkedCover_sound` yields every index below the witness length. The proved length is 1,024. `PrimeCoverage.binaryGoldbach_interval` derives the index `(n-target)/2` from the literal bounds and parity, so no endpoints or even targets are dropped. The final conjunction consumes both completed results.

## Kernel and imported boundaries

The saved successful build and audit receipts use the installed stock Lean 4.35.0 executable with `-t0 -j1 -M4096`. The axiom log for both `BatchPrime.nodeValid_prime` and `FiniteBatch1024.complete` lists exactly `propext`, `Classical.choice`, `Quot.sound`. The concrete checks use `decide +kernel`; no `native_decide`, new axiom or proof assumption occurs in the inspected implementation.

These are not default-resource-limit experiments. The files set `maxHeartbeats 0` and `maxRecDepth 65536`. The runner retains a 600-second process wall cap and a 4-GiB observed-private-memory cap, in addition to Lean's memory option. These settings do not alter the theorem or trust level, but must accompany any reproducibility claim. The first monolithic check was stopped at the private-memory cap; it is not a successful timing. The split build subsequently completed, and all eight saved part receipts bind their current source/object hashes.

`FiniteReplay` recursively collects theorem dependencies whose names begin with `FiniteBatch1024.`, including generated proof helpers. It creates fresh `FiniteTrial` names, rewrites both types and values, and rejects any surviving reference with the original prefix. Declarations are then passed to `Kernel.Environment.addDeclCore` in dependency order. Each replay starts with the same imported base environment and checks a fresh renamed bundle.

The measured bundle is therefore genuine kernel rechecking of the concrete certificate theorem closure, not merely applying the previously accepted public theorem. It is also not a clean build from only foundational axioms. Generic `BatchPrime` soundness theorems, `PrimeBitmap` interval lemmas, `PrimeSupport`, Mathlib, the datatype and concrete data definitions remain imported. The original theorem declarations also remain in the base environment, but the renamed bundle does not directly refer to their namespace. The inspected generic/data sources contain no hidden import of this concrete certificate proof. Source generation, elaboration and import loading are outside the timed kernel loop.

The saved axiom print and prior successful builds support standard-axiom closure. This read-only review does not itself re-run `#print axioms` or independently rebuild every imported library object.

## Controls and their limits

`batchcontrols01.log` records five accepted and nine rejected checks with successful process exit. The positives cover a small complete prime tree, the full root-membership check, full coverage, width and endpoint. The small-tree positive replaces a repeat of the memory-heavy monolithic whole-tree computation; the full graph is certified by the split proof, not by that small positive control.

The negatives cover wrong base, wrong product, missing factor subtree, self-reference, composite node, empty prime tree, wrong origin, missing witness length and wrong endpoint. Their source propositions are false for the stated mutations. The self-reference also damages the factor product, so its rejection does not isolate the smaller-factor condition. Missing-witness and wrong-endpoint controls test those equations rather than rerunning an entire malformed interval assembly.

The imported `Replay.lean` control command records every `addDeclCore` error as `accepted=false`; it does not preserve the error constructor. Thus the negative markers alone cannot distinguish a definitional-equality failure from a resource error. The valid controls and successful split closure are substantial evidence, but do not remove that logging limitation. No additional diagnostic experiment was run or requested as part of this review.

## Timing snapshot

All three full replay receipts were available and independently checked before this report froze. Each succeeds with 265 declarations and one timed repetition. The timed bundle elapsed seconds are 18.6024854, 17.3168339 and 18.5160106, with median 18.5160106. The corresponding median whole-process CPU is 52.1875 seconds and whole-process wall is 52.8791955 seconds.

`measure` constructs the proof pool and performs one full untimed warmup before starting the timed loop. The timed number uses monotonic elapsed nanoseconds, not CPU accounting. The process includes imports, pool construction, warmup, timed replay and output. The `.olean` written by the command is the small replay-command module; it is not a serialized archive of the renamed 265-declaration proof bundle. Initial source elaboration and acceptance occurred in the separate build receipts.

The pending primality/root/coverage phase repeats are outside this snapshot. Their source wrappers were inspected: they replay `valid`, `roots_checked` and `covered`, respectively. Root membership alone is not the cost of deriving all roots prime, and coverage alone excludes the graph-validity proof. Each phase has its own warmup and imported base. Phase totals should not be added or compared to HOL CPU phases without preserving those boundaries. Root's later summarizer must validate their completed receipts; this audit does not anticipate their results.

The HOL implementation uses its stock kernel-compute facility and constructs/exports a different set of intermediate theorems. The Lean replay uses the stock Lean kernel on previously elaborated terms. These results do not establish a universal backend ratio or an end-to-end finite-proof forecast.

## Evidence pins

Paths in this table are relative to `work/backend-costs-20261112/finite-lean`.

| File | SHA256 |
|---|---|
| BatchPrime.lean | `2581D464D91D2524831245630D82E38E6D5B250A83936FCB66863799B99E5FDD` |
| BatchData1024.lean | `0026850572C53CE109DEBDF0DBF5AEC97EAE4E3A4095B48C5377B85129FF0DB3` |
| BatchValidPart00.lean | `FCEC68C7A09B8B22888A6BDB3E69F71E4CB9F0BE84797E1D88184A3FF65566D7` |
| BatchValidPart01.lean | `E671D2D74C9C0A6BB317D7A3EA0D0C4A5E4493B9DBAF460E18128F3734A70D29` |
| BatchValidPart02.lean | `5888D8C9535ABC29910DE95D1249A6BD66041730C07E93199C0B172165CBF670` |
| BatchValidPart03.lean | `08F5E25F7AD6ECFCD3901A4A3C7B8C4CDD15F42C10B69696F2BB8502F4837867` |
| BatchValidPart04.lean | `54F2BC8BAF150C0A34956116675F4CAC1C3BA5D16F05CD3B246D09428FB90A03` |
| BatchValidPart05.lean | `C1865ECE3D1DA57303FF8001FC72936ADD6AEB6501FA16D9F588B4E47DE11FE8` |
| BatchValidPart06.lean | `199FA612D65565BBD2F1DE796BA77CAE309E296FAB0D533F918669C481BD8D33` |
| BatchValidPart07.lean | `65AB9FA1F103677F2FCF75B228F0757734F0F21993070F26B291C2D7B0F2D054` |
| BatchBlock1024.lean | `ED22BE88B14D45B5D084606A2EA49261C8715B266C111C977114E7450858B6F1` |
| FiniteReplay.lean | `6F9BC9ECB3CB1000F975B30DB43174D6C2D2A3859B4699857C50AF9E389319C0` |
| BatchControls1024.lean | `D5A40C8A2F9EB291BD44306CBB3403F2DFC791EE0FD5DCB6FA32471DDA9FE2AA` |
| PrimeBitmap.lean | `3F2A51E21ACB33C5130084B7563EB9E5B4CD58E5E038E919DA94607EFC80B93B` |
| BATCH_DATA_AUDIT.json | `D0A14ABE8AE4CB948E263479E0F585C37BB084893D7880F76AB5C683C9C16482` |
| batchaudit01.log | `ACDBC407475ABB02CF9D00062D7689A4FC4FF0FC995031A3536F2DE264F0252A` |
| batchcontrols01.log | `0FF3D4D1E236C02498729DDFBD7D0BEB2E9D0FF56EDF84C3F226B524A35C7E5B` |
| batchcontrols01.json | `8F6966E1CBA74EB4C1CFE698D6A02D75DD832BE3CA8AE13EEBC6F29E7205D657` |
| batchfull_sample1.json | `C93CE69B6135443123E3A2C5D835598F2C703B6EF5924B5A2A295378B87A255F` |
| batchfull_sample2.json | `497BC2994CC674934073420585C2AF79ECFC2E5078FC919FB373AD994D9D1CAF` |
| batchfull_sample3.json | `6B93454C0F2602DAAAA2A14256470495F58B1BAEB6AB0E5B70C2078002F8EA23` |
| run_lean.py | `2677AEB5DD25534F6684207D5B8428E25944E7FAD6DFA737D19882752667BFE0` |

The imported control source is `work/lean-pilots/batched-transform/Replay.lean`, SHA256 `AF7FAEFA0CE1926715F2570E17A74BC6D221707EDB05352735D89ECB2CD88C0F`. The Lucas adapter is `work/formal-goldbach-bench/prime-cert/PrimeSupport.lean`, SHA256 `4B92C38A1AEB82359A41E05EF83AA72DB57C323E21F0F080E25BA789F35E1C08`. All saved source/object/log hashes in the successful selected build, control, audit and three full-replay receipts matched the current files during the read-only check.

The accepted conclusion is the complete bounded root-and-interval theorem plus the explicitly limited kernel-replay measurement. It is not a full finite-range certificate, a minimal witness graph, or a cross-backend production-cost estimate.
