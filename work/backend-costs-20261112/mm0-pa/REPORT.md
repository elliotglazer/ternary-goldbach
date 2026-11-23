# Ordinary PA arithmetic certificates, 13 November 2026 UTC

The ordinary MM0 comparison now has real PA proofs, including an independently
checked closed theorem for all 64 exact nonnegative products from the P343N64
fixture. It no longer relies solely on schematic arithmetic axioms. The first
implementation is slow compared with Lean's native kernel multiplication.
Replacing bit-by-bit addition with proved four-bit rules improves verification
by 2.29 times on 32 products, proof generation by 2.89 times, and certificate
size by 2.83 times. This is a measured optimization, not an optimized-MM0 lower
bound or a full transform benchmark.

## Mathematical and trust scope

For row i, let a_i = abs(input[2]) and b_i = abs(input[4]) in the original
P343N64 fixture. Each closed product theorem proves a_i * b_i = c_i, with every
literal specified using ordinary PA binary numerals. The final allProducts
theorem is a balanced conjunction of all 64 equalities. The specification audit
independently parses the literal definitions, compares every value with the
original JSON, and checks every leaf of that conjunction.

The arithmetic is schoolbook multiplication. The baseline uses proved binary
addition rules. The improved version derives 256 four-bit addition rules once
from those rules and reuses them. Every entry is a theorem with a proof. The
specification has exactly the pinned peano.mm0 library's 26 axioms, covering its
classical logic, arithmetic, induction and auxiliary set/description interface.
There are no new numeric facts, finite-table axioms, hex-sort axioms or oracle
axioms. This is the ordinary MM0 PA library, not a translation into Lean's
three-axiom foundation.

The untrusted Python generator and mm0-rs frontend produce MMB certificates.
The existing small C mm0-c verifier separately checks each complete certificate
against the joined textual specification, with its parser enabled. Its source
and the frontend are pinned to MM0 commit
0d414c0bfdaaeb7fea571895127abc1fa5a3d956. The C checker is the trusted checker
in this experiment; no claim is made that this local executable has itself
been formally verified. Its timing instrumentation and enlarged capacities
come from the earlier checker build; its inference rules are unchanged.

The structural audit confirms that the binary axiom inventory matches the
specification and that no sorry opcode occurs. This audit is additional evidence;
logical acceptance comes from mm0-c. Neither eval nor native execution is used
to admit a numeric result.

## Five fresh checker processes per case

Times below include the PA library and parsing of the textual specification.
The two bootstrap medians are about 4 ms. Files are copied to Linux tmpfs before
the samples; transfer time is recorded separately. The internal CPU timer starts
after the initial file mapping and covers parser initialization and verification.
Whole-process CPU, elapsed time and RSS are also recorded. These are warm-input
measurements, not cold disk throughput.

| Products | Binary-addition verifier | Four-bit verifier | Binary certificate | Four-bit certificate |
|---:|---:|---:|---:|---:|
| 8 | 70.020 ms | 30.492 ms | 19.13 MB | 7.31 MB |
| 16 | 127.082 ms | not measured | 38.92 MB | not measured |
| 32 | 251.264 ms | 111.904 ms | 78.59 MB | 27.79 MB |
| 64 | not measured | 219.343 ms | not measured | 54.31 MB |

The final single-conjunction certificate takes **220.877 ms median**, is
52,088,360 bytes, and checks about 20.22 million proof commands plus 34.28 million
unification commands. Its slightly smaller encoding follows re-export through
the compiler's MMB importer. All original derivations remain in the independently
checked certificate. One replay's peak RSS is 54,976 KiB; every sample is in
RESULTS.json.

At 32 products, subtracting the matching bootstrap gives the 2.29-fold verifier
improvement. The initial one-run times were noisier; use the repeated medians
above for comparisons. The first fixture product has a power-of-two operand and
is unusually cheap, so its 4.828 ms whole-certificate time is not a general
multiplication rate.

For orientation, the existing stock-Lean scalar probe checks the same 64
products in 2.772 ms median kernel-loop elapsed time, after imports. The MM0
conjunction's approximately 217 ms above bootstrap is around 78 times larger.
That comparison uses different clocks and setup boundaries, and these are
different logical encodings. It says this MM0 implementation is much slower on
this workload. It does not say that every efficient MM0 implementation must be
slower, or supply a ratio for the full TG proof.

## Generation, setup and rejection controls

The baseline 32-product frontend takes 111.25 CPU seconds with 6,696,420 KiB
peak RSS. Four-bit rules reduce that to 38.44 CPU seconds and 3,270,088 KiB.
Generating the four-bit 64-product MMB takes 79.08 CPU / 79.24 elapsed seconds,
with 6,374,992 KiB peak RSS. Assembling the conjunction from that MMB adds
6.86 CPU / 6.91 elapsed seconds. The Python textual proof generation adds about
0.85 elapsed seconds. These are construction costs, separate from the 0.221-second
independent verification. No production-rate estimate should omit construction
unless certificates are already available.

The portable mm0-rs build used Rust 1.100.0, release mode, locked dependencies,
no default features and release debug information disabled. It took 204.75 CPU /
91.21 elapsed seconds. This is one-time tooling setup, not arithmetic checking.
The earlier build failed because the small WSL root filesystem filled; its logs
are retained. The successful build used memory-backed storage. Downloads and
local toolchain hashes are recorded separately. No global toolchain was changed.

Four independent-checker controls reject: a changed input bit, a changed result
bit, an incorrect final product conclusion, and a corrupted theorem reference
inside product63's proof. The proof mutation preserves the command format and
file length but changes the referenced theorem to ax_1; mm0-c reports a type
mismatch. All controls require an actual rejection diagnostic, not a timeout.
All 50 fresh verification processes succeed, all four controls reject, and
RESULTS.json has passed=true. All subprocesses are terminal.

## Implications and remaining work

This closes the ordinary-PA scalar arithmetic evidence gap. It does not close
the matching signed-rounding/dependent-network gap. Larger digit rules, carry
handling, faster multiplication, proof sharing and direct MMB generation are
still possible improvements; none has a measured cost here. Direct generation
could reduce the frontend cost without changing the independent checker's
proof obligations. A verified native evaluator is a separate acceptance design.

The experiment contains no root-of-unity certificates, spectral source values,
global error propagation, zero counts, prime certificates or finite Goldbach
coverage. It must not be substituted into every line of the old TG model.
Complete spectral and prime-coverage blocks and their engineering/setup costs
remain necessary for the end-to-end comparison.

## Reproduction

- build_compiler02.sh builds the downloaded, pinned frontend; source_downloads.json
  and rust_downloads.json identify the inputs.
- generate_arithmetic.py creates the binary baseline; generate_fourbit.py proves
  the finite rule table and creates improved cases.
- run_case.sh compiles each case and invokes the independent checker.
- generate_aggregate.py and run_case.sh fourbit64_all close the conjunction.
- audit_arithmetic.py checks literal provenance, declaration structure, axioms
  and opcodes, and prepares the corrupted controls.
- replay_cases.sh performs five fresh independent checks per case and all controls.
- summarize.py requires all audits and checks before writing RESULTS.json.

The underlying PA library is available in the
[pinned MM0 source](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/peano.mm0).
