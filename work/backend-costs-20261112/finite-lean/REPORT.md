# A complete finite Goldbach interval in stock Lean

The closed theorem `FiniteP0N1024.binary_interval` proves that every even
integer in `[3999999997356537860, 3999999997356539908)` is a sum of two primes.
This covers exactly 1,024 even targets. Its axiom audit reports only `propext`,
`Classical.choice` and `Quot.sound`. No primality or coverage premises remain.

`PrimeBitmap.lean` proves the generic connection from a shifted prime bitmap
to binary Goldbach, including natural-number subtraction, index bounds and
both interval endpoints. The concrete proof checks 283 source primes and 110
anchor primes through 1,537 shared Lucas certificate nodes. It then proves
the bitmap coverage equality by kernel computation. The source bitmap has
3,284 odd slots starting at 8,589,932,551.

## Measured checking cost

Three fresh Lean processes independently reconstruct each dependency closure
under fresh declaration names and submit it to the kernel at trust level
zero. Every reference to a project certificate theorem is renamed, including
the lifted computation helpers. The imported generic mathematical library
and named input definitions are outside these timed loops. Each process runs
one untimed warmup and then one measured replay.

| Certificate closure | Declarations | Median kernel elapsed time |
|---|---:|---:|
| Complete interval, including prime certificates | 8,650 | 9.452 s |
| Source bitmap and its prime certificates | 5,178 | 4.545 s |
| Anchor primes and nonunderflow bounds | 4,144 | 4.983 s |
| Numerical bitmap coverage equality | 2 | 3.516 ms |

The complete replay samples were 8.676, 15.972 and 9.452 seconds. The spread
precludes fine-grained throughput claims. These loops measure elapsed time;
whole-process CPU time is separately recorded. The whole-process median for
the complete replay is 37.219 CPU seconds and 37.475 wall seconds, including
imports, proof extraction, renaming, warmup, checking and output. Peak resident
memory is about 1.29 GB; observed private memory is about 2.86 GB.

The closures overlap, so their times must not be added to reconstruct the
whole. The source closure includes source-bitmap proof assembly, and the
anchor closure includes the anchor-list proof. Neither is solely modular
exponentiation time.

## Construction and validation

The successful project builds cost 547.234 CPU seconds in aggregate, including
the generic bridge, named data, thirteen prime-certificate modules, their
aggregator and the final block. Dependencies were already compiled and were
left unchanged. Repeated imports contribute to this total. The final block
alone cost 172.844 CPU seconds; profiling that assembly is a separate pending
optimization. The monolithic prime file exceeded the 4 GiB private-memory
limit. Splitting its unchanged proof declarations into thirteen modules fixed
that failure. It is a memory remedy, not a demonstrated throughput gain.

The untrusted native certificate producer took 0.047 CPU seconds. All of its
proposals are subsequently checked by Lean. Source generation and proof
checking are distinct measurements.

The known-good coverage check succeeds. Five deliberately false claims are
rejected: empty source, empty anchors, wrong mask, wrong target origin and
an invalid Lucas base. The theorem and generic bridge both pass the axiom
audit. `summarize.py` checks all run exits, limits, source/log hashes, closure
sizes, controls and theorem-audit results before writing `RESULTS.json`.

## Consequences for the full estimate

For this block, establishing primality dominates the numerical cover check.
Efficient source-prime generation and sharing, larger cover blocks and cheap
anchor-prime certificates deserve priority. Charging the full source
certificate set to every 1,024 targets would overstate a design that shares
it across many blocks. Conversely, the 3.516 ms cover equality alone omits
nearly all of this concrete theorem's checking cost.

This is a complete small binary-Goldbach interval proof. It neither proves
the whole finite range needed by the ternary theorem nor supplies the
spectral obligations or a complete end-to-end cost estimate. The unmeasured
shifted-singleton variant is not included in any claimed speedup.

## Reproduction

Use the pinned Lean 4.35.0 executable and the read-only Mathlib artifacts
listed in `run_lean.py`. `generate.py 1024`, `split_primes.py 1024` and
`build_parts.py 1024` produce and build the primality certificate modules.
Build `PrimeBitmap.lean`, `Data1024.lean`, `Block1024.lean` and
`FiniteReplay.lean` with the bounded runner. `generate_controls.py 1024`
creates the controls and phase replay files. Run each with a fresh result
label; the runner deliberately refuses to overwrite existing logs. The
completed labels and all timings are retained in this directory.
