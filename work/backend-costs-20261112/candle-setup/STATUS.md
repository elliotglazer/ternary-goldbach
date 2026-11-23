# Candle benchmark status, 12 November 2026

The prototype proves the entire encoded checker equivalent to its integer
acceptance predicate, proves that predicate implies the integer residual bounds,
and lifts the result to arbitrary matching lists. It constructs a closed
integer-residual theorem for the P343N64 fixture and rejects four corruptions.
It does NOT yet derive the real-coordinate error theorem. No spectral source
or root-of-unity certificate is supplied by these files.

Official kernel-controlled theorem export now succeeds. ISOLATED_RESULTS.json
records all proof/control/export markers, no ERROR or EXCEPTION lines and exit
status zero. isolated_export.sexp contains only the kernel channel's theorem
and context; ordinary console messages are in reproduce_isolated.log.
The complete fresh run uses 128.42 CPU seconds, 151.54 elapsed seconds and
3328440 KiB peak RSS. Its final export uses 4.254 CPU seconds and 6.023 elapsed
seconds. These are one-run reproduction costs, not a steady-state TG rate;
the HOL4 setup/build was also active during this experiment.

The raw theorem/context artifact is 326228857 bytes. The mathematical conclusion
is unchanged up to proved equalities: balance_lists.ml replaces the two lists
with balanced APPEND expressions, and compact_export.ml replaces large numeral
literals with balanced arithmetic expressions. All literals are below 65536.
Every replacement is justified by an ordinary kernel-checked equality, and the
result has no hypotheses. Neither kernel inference nor axiom checks changed.
EXPORT_ARTIFACT.json records a successful structural audit: one Sequent with
empty hypotheses, 302 constant specifications, 20 type definitions, three
NewAxiom entries, three new types and two new constants. Maximum S-expression
depth is 116. The gzip artifact is 4048786 bytes and its decompressed SHA256
matches the original. Structural scanning took 15.72 CPU seconds and gzip
compression 3.11 CPU seconds. These optional transport checks are not logical
rechecking or part of the prover's reported CPU total.

build_export.py redirects the existing kernel FFI payload to a dedicated file
using checked fwrite/fflush calls, retaining the same compiled prover assembly.
This is an output-channel change of the kind described by the Candle project;
it is part of the host-FFI execution assumptions. It also avoids the default
stdio channel's interleaving with ordinary console output. Source/build hashes
are in build_export.json. validate_export.py performs a structural and gzip
round-trip audit, not a second logical proof check.

The diagnostic history remains available. Original exports failed at 1 and
3 GiB heap; balancing numerals alone also failed. Exporting TRUTH after the
entire checker context succeeded at 1 GiB, isolating the numerical conclusion.
Balancing both lists and numerals succeeded, but the default output channel
produced a mixed 329963029-byte log and took 21.030 CPU / 186.244 elapsed seconds
for export. That run is BALANCED_RESULTS.json. The dedicated-channel run is the
authoritative clean artifact. SOUND_RESULTS.json and COMPACT_RESULTS.json retain
their original failure statuses. Earlier name-collision and quotation-parser
experiments are preserved separately. All Candle prover sessions are closed.

## Completed mathematical connection

- encoding_sound.ml proves signed-value validity/closure, arithmetic decoding,
  order/equality decoding, Boolean guards and interval decoding.
- row_sound.ml proves exact equivalence to the 19-check integer row predicate.
- residual_sound.ml proves the four symmetric scaled residual bounds for both
  rounded outputs, using the output-sum relation and three-product identities.
- stage_sound.ml proves the list-level equivalence and residual implication.
- export_integer.ml combines these with the computed fixture theorem, checks
  that both resulting theorems have no hypotheses, and checks the library axioms.
  Its INTEGER_EXPORT_DONE marker denotes an in-memory theorem, not successful
  Kernel.print_thm output. The latter needs SOUND_REPRODUCTION_DONE as well.

The fresh 3 GiB run has no ERROR or EXCEPTION lines and reaches every marker
except SOUND_REPRODUCTION_DONE. It uses 154.57 CPU seconds, 175.24 elapsed seconds,
and 3328876 KiB peak RSS. Three timings per distinct-input stage give CPU medians
20.305/68.718/78.162/364.051 ms for P100N64/P343N64/P415N64/P343N256. Each stage
has distinct input rows; timing repetitions reuse the stage. Source loading,
theory development, literal-term construction and output are excluded.

cached_compare.ml prepares the ordinary compute wrapper's code equations once
and then calls the unchanged kernel directly. Preparation takes 1.520 ms;
three 100-call batches cost 81.456/77.451/76.123 ms per P343N64 call. A constant
result costs 0.206 ms with prepared equations and 1.369 ms through the wrapper.
Preparation does not account for the main stage cost. Input conversion and
the computation itself remain distinct from that setup.

An earlier proof tactic loop was our implementation error: INT_POLY_CONV can
succeed without changing a term, so nesting it in DEPTH_CONV needs CHANGED_CONV.
That error was fixed before the successful generic proofs. It is separate from
the remaining kernel-output memory failure.

The earlier arithmetic-only fresh-process evidence is reproduce.log,
reproduce.time and RESULTS.json.
The complete fresh run passed all markers with no errors. Separate compute
calls averaged 84.40 ms CPU and 84.42 ms elapsed per 64-row stage. Inside one
call, 10000 repetitions took 9.358 seconds CPU and 9.364 seconds elapsed,
or 0.936 ms per stage. These are one fresh-process sample and a diagnostic,
respectively, not established whole-proof rates.
The interactive log contains failed experiments; only complete successful
timing intervals are valid. In particular r1/r2/r3 failed because an older
closure retained the unspecialized equation list. r4/r5/r6 used the corrected
closure. The first-call timings include printing a large theorem and must not
be treated as isolated compute timings. Repeated-call timings do not print it.

The inside-N diagnostic checks the SAME fixture N times inside one compute
invocation. It amortizes literal conversion and evaluator initialization.
Its rate is not independent-data throughput. The compiled Lean runtime also
reuses the same data. Before any full-proof cost extrapolation, measure a
complete block with distinct inputs, computation-generated intermediate values,
error propagation, and one exported mathematical conclusion.

## Build provenance and changes

- Candle repository pin: 6a9acd58867610c78fee0f3dd9ed4c4c14087b18.
- Compiler release: upstream regression artifact 3286. downloads.json pins the
  fetched archives by SHA256. These hashes are local provenance, not an
  independently checked connection between this binary and a soundness theorem.
- Linked the released assembly using existing Windows clang targeting Linux
  musl; no system-wide packages installed. build.json records the command/hash.
- Applied upstream's enlarged data/code buffers and custom-FFI compatibility
  patch. The actual release starts with a 65536-byte data buffer, differing
  from the old-value context in upstream's patch. Added sys/wait.h for musl.
- Fixed the library hash helper's shift count from a Word64 value to an integer,
  matching the compiler's reported API.
- Corrected the library's pair-valued conditional case to return its false
  branch, matching the compute kernel's required characteristic theorem. The
  uncorrected library was rejected by Kernel.compute. Updated its auxiliary
  numeral-conditional lemma and proved it. No kernel acceptance check weakened.
- build_timed.py adds only a timestamp-reporting custom FFI branch. The prover
  assembly is unchanged relative to the untimed build. Instrumentation and
  ordinary OS/FFI operation remain part of the execution environment assumptions.
- patch_library.py and library_patches.json reproduce and pin the library fixes.
- build_export.py additionally isolates the kernel output channel. It does not
  alter the compiled prover assembly or the mathematical acceptance rules.

The earlier arithmetic-only run used a 1 GiB heap and 1 GiB stack. The current
soundness/export run was tried with 1 and 3 GiB heap, retaining a 1 GiB stack. An
initial trial with a 128 MiB stack exited early and is not a successful run.
The standalone successful library smoke run took 78.00 seconds user CPU,
2.93 seconds system CPU, and 99.20 seconds elapsed. Its computation call was
still rejected before the conditional-definition fix; this figure measures
library loading, not a successful arithmetic certification run.

## Reproduction

1. Run fetch.py, build.py and patch_library.py using the installed Python.
2. Run candle/build/cake --types with empty stdin from its build directory;
   redirect output to types.txt. Run upstream candle/insulate.py on types.txt
   to produce candle/build/insulate.ml.
3. Run build_timed.py, generate_fixture.py, generate_row_sound.py,
   generate_stage_sound.py and generate_distinct.py.
4. From candle/build, run cake-timed --candle with ../../../reproduce.ml as
   stdin; save stdout as ../../../reproduce.log and stderr, including external
   /usr/bin/time -v output, as ../../../reproduce.time.
5. Run summarize.py. It requires all success/control markers and no ERROR or
   EXCEPTION lines. RESULTS.json records sources, outputs, hashes and timings.
6. The original full-integer attempt uses reproduce_sound.ml and
   summarize_sound.py and retains its failed-export evidence.
7. For the successful export, run build_export.py and use reproduce_isolated.ml
   as stdin to cake-export --candle, with CML_HEAP_SIZE=3072,
   CML_STACK_SIZE=1024, and CANDLE_KERNEL_OUTPUT set to the absolute path of
   isolated_export.sexp. Save stdout/stderr as reproduce_isolated.log/.time.
   Run summarize_compact.py isolated, then validate_export.py.

## Work remaining

The dependent multistage computation is now complete, including normalized
signed arithmetic, floor rounding, the full local-residual/length contract,
final bounds and checksum. Three clean processes pass all cases and controls,
exact full-coordinate comparisons and identical kernel-channel exports.
See DEPENDENT_REPORT.md and DEPENDENT_RESULTS.json. The largest block has a
158.679 ms CPU median; input setup is a separate 4.186-second median.

The next task is an actual spectral block with real interpretation, certified
source values, roots and global propagation. HOL4 and native Rocq comparisons
are complete at their documented scopes; complete ordinary-MM0 arithmetic and
end-to-end workload pricing remain separate tasks. All current jobs are closed.

All previous interactive Candle sessions are closed. The successful declarations
were developed using several continuation fragments; reproduction uses the
corrected complete sources instead. Do not count debugging-log errors as errors
in the fresh run, or count partial successes as a completed export.
