# Matching Lucas prime certificates in HOL4

The pinned upstream HOL4 prime-certificate library proves the same 393 prime
roots used by the Lean 1,024-target interval fixture. They consist of 283
source primes and 110 anchor primes. The shared certificate graph has 1,537
nodes. HOL's existing proofs supply primes 2 and 3; the other 1,535 nodes use
the generated Lucas certificates.

Three fresh processes pass all root checks and export identical 189,167-byte
theory files. Each returned theorem has the exact expected prime conclusion
and no hypotheses. The ancestry audit permits only HOL4's usual four bool
theory axioms: infinity, choice, eta and Boolean cases. No other oracle tag
is accepted beyond the library's `DISK_THM` import tag. These are HOL results,
not Lean theorems and not an ordinary PA MM0 certificate.

| Fresh certificate cache | Roots | Median CPU seconds |
|---|---:|---:|
| All roots | 393 | 9.110255 |
| Source roots only | 283 | 4.896598 |
| Anchor roots only | 110 | 4.805317 |

The all-root samples are 9.110, 8.869 and 10.135 CPU seconds. Each cohort uses
a fresh proof cache. The cohorts overlap in recursive prime factors, so the
separate source and anchor costs need not sum to the shared all-root cost.
Export costs a further median 1.081 CPU seconds. Process startup, imports,
executable construction and upstream library builds are recorded separately
in the adjacent logs and timing files.

Each process rejects an invalid base, a wrong factor exponent and a composite
candidate. `summarize_primes.py` checks exact root identities, all controls,
all axiom lists, successful exits and identical exports before writing
`PRIMALITY_RESULTS.json`.

This measures certificate reconstruction and kernel acceptance through
`primeCertificateLib.PRIME_CERT_CONV`, including its modular evaluator and
ordinary proof assembly. Lean's median 9.452-second complete interval replay
measures a different acceptance boundary: previously constructed expressions
are renamed and rechecked, with generic support imported. The figures are
close in magnitude, but they are not a controlled universal prover ranking.
In particular, HOL's earlier advantage on the dependent arithmetic network
does not justify applying the same factor to these prime certificates.

The complete HOL interval theorem is a separate benchmark in
`FiniteCoverScript.sml` and `coverbench.sml`. This report and its result file
claim only the matching primality cohort. They do not include the coverage
check or establish a full finite-range or ternary-Goldbach result.
