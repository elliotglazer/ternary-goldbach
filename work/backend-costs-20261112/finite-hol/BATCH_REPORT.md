# Batched primality with the complete interval theorem

The optimized HOL implementation checks the same 1,537 Lucas certificate
nodes, proves all 393 requested primes, and exports the same closed
1,024-target binary-Goldbach interval theorem. Three fresh processes pass
all nine corruption controls and the four-standard-HOL-axiom audit. Their
2,071,826-byte exported theory files are identical. The exact interval is
`[3999999997356537860,3999999997356539908)` restricted to even natural numbers.

## What changed

`BatchPrimeScript.sml` proves soundness for a whole certificate tree. Its
checker verifies each candidate's complete factor product and modular
conditions, and checks that its factors have smaller candidates present in
the tree. Strong induction proves that every accepted node is prime, with
2 as the sole base case. No externally asserted primality result is used.
The existing 7,614 expanded factor occurrences are preserved exactly.

The first full implementation reduced primality checking to 86.9 ms but
then spent 8.74 seconds separately checking root memberships. Those calls
repeatedly evaluated the projected prime tree. `BatchRootsScript.sml` now
checks the complete requested-root list in one evaluator call. Ordinary
kernel inferences project all 393 individual prime theorems from the resulting
universal list theorem. Neither optimization changes the final mathematical
obligations or adds an axiom.

This comparison deliberately retains the original 393 requested root values.
The explicit witness pairs use 231 distinct roots, leaving 162 requested roots
unused by this isolated interval's witnesses. The benchmark is therefore not
a minimal prime-certificate set for the interval. Larger shared source pools
require a separate reuse model.

## Measured costs

| Phase | Median CPU seconds, three fresh processes |
|---|---:|
| Certificate-data translation | 1.467315 |
| All 1,537 primality certificates | 0.064050 |
| Construct the proved prime-tree projection | 0.000828 |
| Requested-root data translation | 0.169898 |
| Check all requested-root memberships | 0.023791 |
| Derive and save 393 individual prime theorems | 0.084930 |
| Witness-data translation | 0.816570 |
| Check the 1,024 target witnesses | 0.029397 |
| Assemble the exact interval theorem | 0.016545 |
| Export the complete theory | 3.324970 |

The median sum of phases is 6.006 CPU seconds; the median whole process is
13.09 CPU seconds. Per-phase medians need not sum to the median phase total.
Startup, imports, parsing, controls and uninstrumented setup account for the
difference between phase and process totals.

The earlier balanced HOL implementation spent 8.850 CPU seconds reconstructing
the prime certificates. The new 64.05 ms primality phase is about 138 times
faster. That ratio excludes data translation and semantic assembly. The
complete process improves from 18.27 to 13.09 CPU seconds, about 1.40 times,
while exporting more explicit intermediate root theorems. The end-to-end
improvement is therefore much smaller than the isolated arithmetic gain.

## Native reference and interpretation

An independently parsed native GMP implementation checks the same graph in
2.667 ms median CPU time. It also checks the exact root identities and
coverage witnesses. Three processes each run 500 iterations; invalid-base
and invalid-sum controls reject. This implementation has no proof authority.
Its arithmetic algorithm uses GMP modular exponentiation, so it is a useful
runtime reference rather than an identical instruction trace.

HOL's batched primality phase costs about 24 times this native reference.
The native root-membership/coverage check takes 0.146 ms, but it does not
construct or accept a theorem. The remaining representation and output costs
are distinct from this arithmetic overhead. Treating all of them as one
generic proof-assistant slowdown would give a misleading forecast.

## Validation and scope

`summarize_batch.py` independently parses every generated SML certificate
literal and compares it with the original Lean fixture. It also checks the
exact ordered 393-root list, interval endpoints, all successful process exits,
all nine controls, axiom inventories and matching exported artifacts.
`BATCH_RESULTS.json` records the complete evidence and source hashes.
`summarize_native_batch.py` independently checks the native fixture identities
and completed runs before writing `NATIVE_BATCH_RESULTS.json`.

The theorem-tag audit permits the standard `DISK_THM` imported-theory tag.
It checks standard HOL ancestry and the absence of an additional computational
oracle; it is not a fresh replay of every upstream library proof.

This is a HOL4 result. The batched design is being tested separately in
unchanged stock Lean; no timing transfers to Lean or ordinary PA MM0 are
assumed. The successful small interval cannot be extrapolated per target to
the whole finite range. Source primes and anchors can be shared across much
larger blocks, and the dense prime ladder requires different certificates.

For the complete TG plan, this result removes a measured implementation
bottleneck and supplies a better primality component. It does not reduce the
number of spectral evaluations or prove a corresponding whole-proof saving.
Full spectral certification, production-scale source reuse, ladder generation
and fallback costs remain separate entries in the forecast.
