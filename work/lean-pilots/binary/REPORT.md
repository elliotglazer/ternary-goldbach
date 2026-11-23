# Complete high-end binary Goldbach Lean pilot

2026-11-11. The isolated prototype is complete. Lean4.35 checked the following theorem, with all source-prime, anchor-prime, shift, coverage and interval-assembly obligations discharged:

```lean
theorem BinaryPilot.binary_interval :
  ∀ n : Nat, 3999999997356523524 ≤ n → n ≤ 3999999997356523650 →
    Even n → ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ n = p + q
```

The interval contains64 even targets. This is a complete internal prototype, not the full binary Goldbach range or an approved public frozen anchor. The parent task's overall goal remains incomplete outside this assigned pilot.

## What was implemented

The fixture is the first word `b0-nearest-0` in `work/formal-goldbach-bench/prime-cover/actual_trace.json`, SHA256 `F073F27D03A88B84AA19825F7CF8BFC2E3028D4BF8F8843CE385B2A59ECFABC2`. Its12 actual anchors are62-bit primes. Source chunk entries are33- or34-bit integers. All160 positive source-bit occurrences, representing152 distinct primes, receive actual primality proofs. Zero source bits need no compositeness claim.

The local Pratt DAG contains644 prime nodes and164 distinct roots, including the12 anchors. The producer reads the existing certificate fixture `work/formal-goldbach-bench/native/pratt_certificates.json`, SHA256 `E1ABF0B7A80C5DCBE872FFA38E444E2023D2E3E3338A8504E9F543DC1F53E0A5`, and proposes320 additional nodes using FLINT factorization and witness search. None of those external results establishes a theorem. The generated Lean source proves all factorization identities, modular tests and prime-factor dependencies with the actual Mathlib Lucas criterion and ordinary kernel reduction. The only base is the library proof that2 is prime.

`BinarySupport.lean` proves a generic source-slice theorem. A slice contains a concrete source mask/base, anchor, shift, positive-bit prime proof, anchor prime proof and exact origin equality. Every retained bit yields two actual primes with the exact target sum. A generic bitwise-union lemma and tile theorem consume these certificates.

`BinaryPilot.lean` proves source-mask membership for every index of each128-bit source chunk, binds those memberships to the generated prime theorems, and instantiates all concrete slices. It checks the two32-bit union equalities by reduction. The two tile origins differ by64, so their even targets are contiguous. The final proof uses the given parity witness and an exact quotient index, including both endpoints.

The implementation is deliberately small enough to finish while retaining high-end operands and the intended sparse-source/anchor/shift architecture. It is not a synthetic random OR benchmark or a list of unverified Goldbach witnesses.

## Actual measurements

All runs use the explicit Lean4.35 executable, one requested Lean worker and strict trust level0:

```text
C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe
  -j 1 -t 0 -o CompleteBinaryPilot.olean CompleteBinaryPilot.lean
```

Lowercase `-t` selects trust, not timeout. The actual help text is retained. No uppercase `-T`, heartbeat or recursion override was used. Imports come only from the owned directory and the read-only cached packages under `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages`. No Lake invocation or dependency build occurred.

The complete source concatenates all owned support, concrete prime proofs and semantic coverage proofs, importing only Mathlib/core dependencies. It does not import `BinaryPilot` or `PilotPrimes`. Its measurement therefore includes actual construction and checking of the concrete proofs, rather than checking a reference to an already compiled final theorem.

|Run|Wall seconds|Process CPU seconds|Scope|
|---|---:|---:|---|
|Fixed-fixture producer|0.067686|0.062500|Read existing certificates, generate missing nodes and write local proof sources; excludes historical anchor/cover search|
|Generic support|15.751245|15.515625|Own generic proofs plus strict cached-library import checking|
|644-node prime DAG|80.464256|114.343750|Concrete primality proof construction/checking, imports and object output|
|Concrete coverage module|15.929556|15.953125|Source membership, certified slices, two tiles and interval assembly, with compiled prime module imported|
|Complete standalone source|87.796652|126.031250|All owned proofs, strict imports and object output|
|Import-only baseline|12.872155|12.718750|Same Mathlib/core import list, with no owned theorem construction|

The complete run receipt is `run-1794467932249989500.json`, with matching `.log`; the baseline is `run-1794467956599937400.json`. Process CPU is Windows `GetProcessTimes` for the Lean process, not an inference from wall time or the requested worker count. Other campaign work was active, so these are individual measurements, not a controlled throughput calibration. The separate stage times overlap imported work and must not be added as isolated component costs.

The baseline exposes substantial import overhead. Subtracting these two single-run observations would not be a separately measured pure-kernel cost. Elaboration, tactic proof construction, kernel checking, importing and object serialization remain combined in the reported full run. No peak-memory trace was collected.

The complete source has322829 bytes; its object has8214968 bytes. These are one artifact pair, not all transitive library storage or a production streaming bound. The generated data and logs are local and reproducible from the pinned fixtures.

## Validation and failure history

The final axiom probe prints exactly:

```text
[propext, Classical.choice, Quot.sound]
```

It also instantiates the exact displayed interval type. There is no `sorry`, custom axiom, native decision, unsafe proof bypass, heartbeat override or undisclosed primality/coverage premise in the owned proof files. `decide +kernel` certifies the closed arithmetic checks.

The deliberately false `CorruptCoverage.lean` equality changes the first tile's full mask from `2^32-1` to `2^32-2`. Lean rejects its `rfl` proof. This is a negative acceptance check, not a statement that the neighboring Goldbach problem is false. Its expected failure is retained at `run-1794468011517925600.json/.log`. The successful full-source axiom probe is `run-1794468011658879000.json/.log`.

Two development support compiles failed before the successful prototype. The first used a nonexistent `Mathlib.Tactic.Omega` import; it was replaced by the cached core tactic import. The second exposed the wrong zero-testBit lemma and an OR-expression simplification mismatch; these were corrected in the owned source. The generator assembly script also needed explicit UTF-8 decoding on Windows. No dependency artifacts were changed. All Lean attempt receipts remain available. A single unused simp-argument warning remains in the generated prime3 proof; it does not affect acceptance or require a setting change.

Independent audit `work/qrh-campaign/agents/audit/REVIEW_BINARY_LEAN_PILOT_SEMANTICS_2026-11-11.md`, SHA256 `189FCB113A859B16919E6BF3E1AA394B890649833E6F9B619475021C437E3162`, passed the exact statement, source bindings, primality closure, tile seams and kernel axiom probe. Its review scope is semantic/internal-prototype acceptance; the timing interpretation above is separately stated.

## Reproduction and limitations

From the workspace root, use the existing interval Python to rerun `work/lean-pilots/binary/generate_pilot.py`, then the standard Python executable to run `assemble_complete.py`. Build the standalone source through `run_lean.py`, followed by `Audit.lean`. `CorruptCoverage.lean` is expected to fail. Regeneration overwrites only owned pilot sources, so preserve a copy of this pinned result before changing the fixture or generator. The runner always works inside this isolated directory and never builds dependencies.

This prototype gives a real complete-proof calibration point. It establishes neither a typical64-target cover nor the cost of all binary targets. Its source-prime DAG is built cold within the pilot; a full source table could amortize some of that work, while its own complete certification remains mandatory. The existing selected anchors and cover were already available, so their original search effort is absent from the short producer timing. Broad anchor success, difficult residues, cache reuse, exception frequency, finite initial/final range assembly and production-scale I/O remain unmeasured. No core-hour forecast or Lean/MM0 speed ratio follows from this run.

## Pinned outputs

|Artifact|SHA256|
|---|---|
|BinarySupport.lean|690E5341CA663D37B93DDD3FAF37C115B80D0666A610D6D593AB3A629918F669|
|PilotPrimes.lean|6575142C02AFC8158631D43EB3C1CECB56AA8F690A13964A9A6338CBE7D7DE79|
|BinaryPilot.lean|FF3C1F408E1E83C368DEF8788686731BD9A5323AFB0E6A40CE98837946FABEFD|
|CompleteBinaryPilot.lean|153341B41AB534824354323CEA6061C312C922F6EB73AF5FD3B1BF9853AC0B2F|
|CompleteBinaryPilot.olean|A4F0CE27803B6C70B564BF3EEC071CFA8BAD4B69D2C2E3AB26931CF8DD86D445|
|results.json|C0C0B289849E2FDC7CAB8BBD5859A40A4FAEC2FB7EC263FD44F062A32C2EF0AA|

`results.json` records all run commands, statuses, timings, fixture hashes and additional source hashes. The final export is at `BinaryPilot.lean:600` and the identical standalone export at `CompleteBinaryPilot.lean:5824`.
