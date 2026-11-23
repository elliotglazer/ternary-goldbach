# Next primality experiment

The complete baseline interval checks now identify two different costs:
several seconds of prime-certificate reconstruction, and a much smaller
coverage computation. Balanced witness definitions reduce a measured input
translation cost. They do not remove the prime-certificate work.

The upstream Lucas converter constructs a separate theorem for every prime
node and invokes the modular evaluator repeatedly from proof-producing ML.
The next experiment keeps the entire arithmetic certificate check inside
one evaluator call. `BatchPrimeScript.sml` now compiles, including its generic
soundness theorem and the evaluator translations. A three-prime probe accepts
the intended tree, rejects five corruptions, checks the exact mathematical
output with no hypotheses, and passes the four-standard-HOL-axiom audit.
See `BATCH_PROBE_RESULTS.json`. The full fixture has since passed in three
fresh processes, including all 1,537 nodes, 393 individual root theorems and
the closed interval. `BATCH_RESULTS.json` and `BATCH_REPORT.md` contain the
completed benchmark. Median batched primality time is 64.05 ms CPU; whole
process time is 13.09 CPU seconds, including loading and export. The native
reference is separately audited in `NATIVE_BATCH_RESULTS.json`.

Each certificate tree node stores its candidate, base and factor list.
The checker verifies the complete factor product, all modular equalities,
and that each factor is smaller and has a certificate in the tree. A strong
induction on the candidate proves primality, including every recursive
factor. Smaller-factor checks rule out circular certificates. Prime 2 is
the sole base case. Tree ordering helps lookup efficiency but is not a
soundness premise; an unsuccessful lookup rejects.

The generic theorem derives `tree_primes (prime_values certificates)`, so
the existing coverage theorem can consume it without changing the desired
interval statement. The whole certificate tree, prime-value projection,
witness list and exact endpoints must be bound in the final theorem.

Required evidence:

1. Completed: compile the generic theorem, evaluator translations and small
   corruption probe; audit the standard HOL axiom inventory.
2. Completed: use exactly the existing 1,537-node fixture, with multiplicities expanded
   faithfully, and retain all 393 root-prime claims and the closed interval.
3. Completed: measure input translation, the batched arithmetic check, semantic assembly,
   coverage, controls, export and whole-process resources separately.
4. Completed: reject wrong bases, wrong products, absent factors, self-references,
   composite nodes and wrong interval data.
5. Completed: repeat in fresh processes and compare the mathematical output with the
   existing baseline. Do not confuse a faster certificate with an ordinary
   PA MM0 proof or a stock-Lean theorem.

If repeated-factor modular tests become material, replace expanded factors
by a checked factor/exponent list and prove that its expanded product and
universal conditions agree. If input translation remains dominant, use
balanced definitions or a proved compact source producer. Those are further
measured changes, not savings already credited to the full TG estimate.

The successful library build is `batchprime_build06`; the successful probe
is `batch_probe02`. Earlier failed attempts remain logged. The translator
requires first-order list predicates, proved equivalent to the original
`EVERY` conditions, plus the existing `cv_std` modular-power translation and
an explicit translation of `PROD`. The small probe is not a performance test.

The full benchmark initially repeated tree projection while producing each
root theorem. `BatchRootsScript.sml` proves a batched membership test, then
ordinary kernel projection supplies all 393 individual theorems. This removes
the observed 8.74-second root-membership overhead. Fresh runs r1/r2/r3 export
identical artifacts and pass nine controls. The stock-Lean comparison now
also compiles, using bounded subtrees to respect its memory limit. It proves
the root conjunction and interval with the standard three axioms. Its full
replay median is 18.516 elapsed seconds, versus 9.452 for the earlier explicit
certificate. HOL's local saving does not transfer automatically. See
../forecast-audit-20261113/LEAN_BATCH_AUDIT.md and the Lean batch receipts.
None of these timings is a full TG compute forecast.
