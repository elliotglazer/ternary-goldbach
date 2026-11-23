# MM0 toolchain for a fast Goldbach certificate checker

Research date: 2026-11-10. Source pin: `digama0/mm0` commit `0d414c0bfdaaeb7fea571895127abc1fa5a3d956`. This is an implementation recommendation, not a claim that the proposed checker or its correctness proof exists. No new benchmark or implementation was started for this task.

## Recommendation

Build a small, specialized checker whose additional rules are proved admissible for a frozen PA theory expressed in MM0. Its inner loop should read certified prime bitmap words, compute exact shifts and bitwise unions, and advance a checked coverage interval. It should not produce or interpret a digit-level proof for every machine operation. Retain an ordinary MMB expansion path for small examples and differential testing.

There are two distinct deliverables. The first is a source-audited native checker with the same kind of implementation trust placed in an ordinary theorem prover kernel, plus checked mathematical proofs justifying its rules. The stronger deliverable additionally proves that an exact executable implements that checker. The second can reuse MM0's program specifications and proof-producing compiler ideas, but the upstream verified compiler/checker chain is unfinished. Do not make completion of the entire upstream bootstrap a prerequisite for the first deliverable.

The earlier 0.822 us/update result measured a particular symbolic proof application pattern. It imposes no lower bound on this new architecture. Native checking can avoid those applications altogether, provided its acceptance rule has the required PA-derivability justification.

## Existing components and their limits

| Component | What is actually present | Recommended use |
|---|---|---|
| `mm0-c` and MMB | A small executable checker, specification parser, shared terms/proofs, and explicit proof instructions. The parser is needed to bind the result to the intended specification. | Bootstrap checker for the ordinary MM0 proofs; independent reference for small expanded certificates. Do not disable the parser for final acceptance. |
| `mm0-rs` / MM1 | Proof elaboration, a Scheme-like metaprogramming language, proof compilation and documentation. | Author the arithmetic/invariant proofs and generate small reference certificates. The producer remains untrusted. |
| `examples/peano.mm0`, `.mm1` | A PA presentation and arithmetic development, including `div`, `mod`, `pow`, `shl`, `shr`, and naturals represented as finite sets of bit positions. | Start the frozen theory here. Audit its declared base axioms and every added definition. Reuse proved arithmetic rather than restarting with successor arithmetic. |
| `examples/x86.mm0`, `.mm1` | Machine and input/output specifications, scalar bitwise operations, shifts, division and ELF execution. | Reuse definitions and relevant theorems for a later scalar executable refinement. No SIMD/AVX model was found in this inspected specification. |
| MMC compiler | Real intermediate representations, optimization, register allocation, code generation, linking, and proof generation infrastructure. | Reuse selectively after closing the proof dependencies exercised by the small checker. Do not treat the full toolchain as already verified. |
| `examples/verifier.mm0` | A useful target statement relating successful execution of a particular ELF to derivability of the input specification. | Copy the shape of the contract, not a claim that its proof is complete. |

The source-level separation of specification, untrusted proof producer and checker is documented in the [pinned repository README](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/README.md#what-it-is). The arithmetic interfaces are in [peano.mm0](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/peano.mm0#L225-L294) and [its shift/bit-set definitions](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/peano.mm0#L421-L451). Scalar instruction semantics appear in [x86.mm0](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/x86.mm0#L1094-L1111).

Three concrete warnings prevent treating the upstream chain as finished:

1. [compiler.mm0:6](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/compiler.mm0#L6) declares `axiom sorry (p: wff): $ p $`. Its comments say this keeps partial proofs checked in CI. Passing that specification does not establish a PA-only correctness theorem.
2. [verifier.mm1:33](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/verifier.mm1#L33) defines the intended representation invariant `Represents` as true. Its leading verifier-correctness declarations do not have completed proofs. The [thesis, section 2.2.10, printed page 66](https://digama0.github.io/mm0/thesis.pdf#page=66), also explicitly describes the bootstrap theorem as incomplete. The pinned README still presents it as the project's endpoint.
3. The [compiler proof generator](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/mm0-rs/src/mmc/proof/compiler.rs#L978-L1005) contains unimplemented branches. The [CI recipe](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/.github/workflows/build.yml#L230-L247) checks compiler examples against the specification containing `sorry`, rather than establishing a clean x86-only dependency closure.

There is another, subtler axiom issue. [peano_hex.mm0](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/peano_hex.mm0#L67-L134) adds coercion axioms for strict syntactic hex, character and string sorts. It documents their intended admissibility. These are different from the unrestricted `sorry` axiom, but they still need conservative-elimination justification for an exact PA-only contract. Prefer nat/list encodings for the new checker specification, or explicitly include and prove the syntax translation. Do not silently label every imported axiom “just PA.”

## Precise acceptance contract

Freeze a base theory `Γ`, definitions of primality and bounded Goldbach, the numeral `4×10^18`, and the final target syntax before writing the optimized checker. The target should express every even integer from 4 through the inclusive upper bound as a sum of two primes, with no certificate-success hypothesis left in the final statement.

For the mathematical checker `A`, the required metatheorem is syntactic:

```text
A(spec, certificate) = accept
    implies exists d, Prf_Γ(d, exactTargetSyntax(spec)).
```

Prefer an explicit, possibly expensive proof expansion function `E`, with a theorem that acceptance makes `E(certificate)` a valid ordinary derivation. Existence of the expansion is enough for admissibility; production need not materialize it. This avoids invoking a blanket principle that every PA-provable statement is true. A theorem about the abstract checker alone does not certify an arbitrary native implementation or an alleged successful execution.

The stronger executable contract is separate:

```text
Initial(exactELF, exactInputs) and SuccessfulExecution(exactELF, exactInputs)
    implies A(spec, certificate) = accept.
```

Together they imply PA derivability of the frozen target when this exact executable accepts. This follows the derivability-oriented structure of [Verifier_Valid](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/verifier.mm0#L24-L28). It does not remove the usual dependence on the stated machine/environment semantics and faithful execution. See the companion [soundness.md](soundness.md) for the trust analysis.

For the first deliverable, the abstract-checker proof is machine checked, while the native implementation is audited and tested as part of the trusted checker. No logical axiom saying “this run succeeded” is added to `Γ`. The acceptance operation itself is a newly implemented, admissible proof rule. It is a new MM0-compatible proof-certificate checker, not an unmodified `mm0-c` run.

## Smallest useful new kernel

Keep a small registry of immutable buffers and facts, not millions of arbitrary theorem objects. A buffer handle means that a checked invariant holds of these exact bytes. Handles are created only by checking, cannot be supplied as certificates, and must not be reusable after mutation. Treat hashes as cache identifiers, not collision-free mathematical evidence.

The following coarse operations should cover the first implementation:

| Operation | Mathematical obligation and runtime check |
|---|---|
| `CHECK_SMALL_PRIME_BITMAP` | Establish that each set bit denotes a prime under the exact offset/stride convention. A verified sieve can establish this once. Check lengths, omitted tails, exceptional prime 2 and sieve initialization. Only sound set bits are necessary for coverage; completeness is useful for generation but need not be assumed. |
| `CHECK_PRIME_CERT` | Establish primality of an anchor using a chosen deterministic certificate theorem. Check every factor, exponent, modular relation and gcd required by that theorem. Probable-prime output alone is insufficient. Reuse accepted anchors through registry handles. |
| `CHECK_COVER_BLOCK` | Given accepted anchors and the immutable small-prime bitmap, compute the exact source index and alignment for each selected mask, OR into the current accumulator, and require every valid target bit covered. Verify the relation “target minus anchor is the prime represented by this source bit.” Reject incorrect bounds and incomplete final words. |
| `ADVANCE_COVERAGE` | Extend a contiguous already-covered interval by the exact next interval. Reject omissions, wrong endpoints, duplicated intervals used as new coverage, stale handles and mismatched specifications. |
| `FINISH` | Require the coverage interval and exceptional cases to equal the frozen target range. There is no unchecked “all workers succeeded” import. |

The critical invariant is that every registry fact has a derivation in `Γ`, each bitmap bit used has its prime interpretation, and the covered prefix really has Goldbach witnesses. Prove this invariant preserved by every operation. A concrete result can then be checked using machine arithmetic while its proof-expansion witness is justified uniformly.

Use native `u64` words initially, with explicit overflow-safe index arithmetic and a well-specified 128-bit product or two-limb equivalent for modular arithmetic. Keep arbitrary-precision libraries out of the first trusted implementation unless the selected prime certificates actually require them. A 64-bit anchor does not automatically imply every intermediate product fits 64 bits. Handle shifts by zero and by the word width explicitly; C's shift rules must not define the mathematics accidentally.

The source bitmap can be prealigned when that reduces total work, or sliced directly. This is a measured engineering choice, not a logical requirement. Batch enough operations to avoid per-word parsing overhead. Start with scalar code and a reference implementation; add vectorized code only after the scalar end-to-end checker is correct and profiling shows a benefit. A second implementation can cross-check outputs, but agreement is not a substitute for the admissibility proof or executable refinement.

Parallel workers and checkpointing must preserve the same invariant. The coordinator must consume actual checked results bound to exact intervals and inputs. Plain success logs, digest lists or signed acknowledgements are not PA proofs. A single trusted checker can manage worker results internally; a later verified coordinator can justify distributed composition. Scheduling and certificate production remain untrusted.

## Reusing MMC without inheriting its proof gaps

MMC's useful idea is per-program proof generation: an untrusted compiler produces machine code and an ordinary proof about that code. It does not require proving the whole compiler implementation correct. Its [language documentation](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/mm0-rs/mmc.md#L1-L25) already describes bounded integers, arrays, ghost invariants and overflow obligations. The [compiler wrapper](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/compiler.mm1#L19-L29) exposes an ELF and an `okProg` theorem. The [native numeral proof code](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/mm0-rs/src/mmc/proof/norm_num.rs) supplies reusable term/proof sharing ideas.

A feasible stronger track is to verify only the small checker actually shipped, either through a repaired subset of MMC or direct translation validation of its scalar assembly. Freeze exact machine-code bytes and close every theorem dependency used by that proof against the permitted base. This may avoid completing unused compiler features and the general MM0 self-verifier. It still requires substantial work on memory, input decoding, control flow, arithmetic and output semantics; “the compiler emitted a proof” is not a completion test while its closure includes `sorry`.

## Strict stock-MMB alternative

If final acceptance must use unchanged `mm0-c`, every new arithmetic rule must expand into ordinary MMB steps. Reuse shared numerals and closed facts, fused word lemmas, deterministic certificate generation and optimized native emission. A byte table is one possible implementation, not the only one or a lower bound. Keep the theory and exact target identical to the fast-checker route.

This alternative has a serious deployment gate. [Stock format limits](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/mm0-c/README.md#limits) require statement data within the first 4 GiB and each individual proof below 4 GiB. Temporary proof storage resets between theorem declarations. Arbitrary separately checked shard results cannot simply become axioms in a final proof. A self-contained final check must include a valid composition and all required derivations, or the composition machinery itself becomes an additional trusted/verified checker component.

Therefore keep stock MMB as the independent reference and fallback, but do not commit to a full-range production run until a complete representative PA-only certificate has established size, time, bootstrap-reuse and file-format feasibility. Avoid claiming that untrusted template compression removes the verification work: it saves materialization and parsing costs, while ordinary proof steps still need checking. A streaming-format modification is useful engineering but is no longer the strict unchanged-checker alternative.

## Milestones, rejection tests and rough effort

These are engineering estimates, not measured schedules. One person-month means one experienced full-time formal-methods/systems engineer. MM0 expertise is scarce. The ranges assume reuse of the prime-cover algorithm and certificate design, and exclude computing the complete range, building a cluster and discovering new number theory. Parallel staffing does not divide elapsed time linearly.

| Milestone | Completion evidence | Rough effort |
|---|---|---:|
| Freeze theory, target and certificate format | Independently audited binders/definitions; clean axiom inventory; reference parser and tiny complete stock-MMB examples | 1–2 person-months |
| Prove bitset/sieve/coverage rules and implement scalar checker | Machine-checked admissibility of the used rules; every accepted tiny case expands to a stock proof; actual bitmap and source-index checks included | 2–5 person-months |
| Prime certificate arithmetic and full block integration | Deterministic prime certificates checked; overflow and boundary tests; one representative complete block with no schematic arithmetic axioms | 2–4 person-months |
| Production robustness and measured optimization | Bounded memory, restart/parallel composition, adversarial inputs, independent audit and end-to-end performance measurements | 2–5 person-months |
| Optional exact-executable refinement | Clean ordinary MM0 proof about the exact deployed binary, including parser and I/O; no compiler `sorry` dependencies | additional 8–24 person-months |

Thus an audited fast-checker implementation with checked mathematical rules is roughly **7–16 person-months** of new toolchain work. A defensible exact-binary version is roughly **15–40 person-months total**, with substantial overrun risk if MMC infrastructure needs extensive repair. A focused stock-MMB producer/reference route may take **4–10 person-months**, sharing much of the theory work, but this does not promise a practical full-range run. These are alternative/overlapping tracks, not quantities to add blindly.

Start with a short feasibility gate: within 2–4 weeks, produce one complete small block from actual source bits and genuine prime certificates, with the ordinary MM0 target audited, and demonstrate the exact proposed rule-expansion contract on it. Failure here should revise the architecture before optimizing its throughput.

Required negative tests include: a single false source-prime bit; a composite anchor with a plausible certificate; wrong source offset or stride; shifts 0/63/64; arithmetic overflow near the endpoint; one uncovered bit; swapped source buffers; mutation after registration; a certificate naming another target; skipped or replayed intervals; truncated, duplicated and trailing input; invalid length arithmetic; and a successful worker for the wrong range. Every one must fail closed. For executable refinement also mutate a code byte and require the code-bound proof to stop matching.

The highest risks are proof/theory binding, source-bit provenance, modular arithmetic correctness, parallel composition, and underestimated compiler-proof gaps. The numerical bitwise OR itself is the easy part. Production approval should require a full-block benchmark under the final trust contract, not a new microbenchmark that excludes those costs.

## Local evidence

`toolchain-sources/` contains the pinned GitHub tree and targeted source copies used in this review. No claim of kernel verification is inferred from merely reading those files. The earlier measured symbolic benchmark and its explicit exclusions remain in `../formal-goldbach-bench/mm0/REPORT.md`; those frozen files were not modified by this task.
