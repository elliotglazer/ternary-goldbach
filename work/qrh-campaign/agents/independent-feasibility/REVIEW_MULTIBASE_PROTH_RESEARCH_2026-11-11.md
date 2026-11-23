# Independent review of the multibase Proth proposal

2026-11-11. **PASS at bounded paper/source and exact residue-arithmetic scope. No correction requested.** The arbitrary-base certificate is sound, the six residue tables and their CRT counts agree with an independent recount, and the grouped recurrence preserves all-slot coverage. No prime-window frequency, runtime benefit, completed mixed checker or new ladder certificate follows from this review.

I read the full author note, script and JSON; reread the actual base-3 producer, checker and cancellation bodies; and compared the operation accounting with the frozen mixed-checker inventory. I did not run the author's writer. An independent, read-only integer recount used square residues rather than the author's Euler-power test. No Lean/Lake, candidate-prime search, analytic evaluation or source edit was performed. The three author files had identical hashes before and after the recount.

## Bound artifacts

| Artifact | SHA256 |
|---|---|
| `work/qrh-blueprint/MULTIBASE_PROTH_RESEARCH_2026-11-11.md` | `555DA959A4591205291DB862E1FE1FBA885545C4E3EC920D2FDF48F8A200D337` |
| `work/qrh-blueprint/proth_base_residues_20261111.py` | `756B71D759DD5A1D2DD2A091081F54EF7573398CDF054AE0979F1C0485A9CE53` |
| `work/qrh-blueprint/proth_base_residues_20261111.json` | `CBC0E74A3298468074231185E1E399E5C6A94D85ED5F9F4343FD446207124BE4` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Check.lean` | `A7993B4D1E8A70112403B85B15CF586B4DA84B962A04416531BDE9F35817A42D` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| `work/ternary-goldbach/LadderHints.lean` | `3AA4E7D3357E5D544288249ED13616B3D9F9151C21D1DAE82AEFD7355C53505D` |
| `work/qrh-campaign/agents/independent-feasibility/MIXED_PROTH_CHECKER_COST_DESIGN_2026-11-11.md` | `78E8CB820D054DC8D1536052BBE69DA2063522A2614ACEC601E267413228D7D6` |

## Certificate and cancellation

Put F=2^45, D=F/2, c=kF+1 and k=S*i-t with 1<=k<F. Then c is odd, c>1 and c<(F+1)^2. The identity

    a^(D*S*i)+a^(D*t)=a^(D*t)*((a^k)^D+1)

has the correct plus sign. From gcd(a,c)=1, cancellation modulo c is valid even when c is not yet known prime. Thus the batched divisibility implies c divides (a^k)^D+1. `Spec.lean:38-55` already proves the required arbitrary-x power-plus-one criterion; `Spec:58-80` specializes its cancellation to base 3. Replacing that specialization by the stated gcd hypothesis introduces no new analytic input.

Independently, an odd prime divisor r of (a^k)^D+1 has a^k nonzero modulo r. Its order divides F but does not divide F/2 because -1 is not 1 modulo odd r. Every proper divisor of this power of two divides F/2, so the order is F and r>=F+1. If c were composite, its least prime factor would have square at most c, contradicting c<(F+1)^2. Repeated factors cause no exception.

The gcd check is substantive for the uncancelled batched test. For example, a base divisible by c and a positive t could make both uncancelled terms zero modulo c without certifying primality. The proposal retains the check. Bases need not themselves be prime for checker soundness; primality of the small bases is used only in the producer's residue interpretation.

## Producer-only reciprocity and independent counts

Every candidate has c=1 modulo 8. For a prime candidate, the supplementary law makes 2 a quadratic residue. It cannot supply the negative-one Proth certificate. For an odd prime base ell, reciprocity has positive sign since c=1 modulo 4, giving (ell/c)=(c/ell). All six selected bases are smaller than every candidate c, so the distinct-prime condition presents no exception. Multiplicativity also justifies the statement about products of unsuccessful prime bases, when c is prime and “unsuccessful” means quadratic residue.

I inspected the cited Mathlib documentation, including `legendreSym.at_two`, `ZMod.exists_sq_eq_two_iff` and `legendreSym.quadratic_reciprocity_one_mod_four`. It corroborates these mathematical laws. It does not establish that a new implementation elaborates against the campaign toolchain. [Mathlib reciprocity documentation](https://leanprover-community.github.io/mathlib4_docs/Mathlib/NumberTheory/LegendreSymbol/QuadraticReciprocity.html).

The independent recount first checked primality of the six small fixed bases by trial divisors, then formed each set of nonzero squares `{x*x mod ell}`. Its complement among 1,...,ell-1 supplies the nonresidues without calling the author's `pow(r,(ell-1)//2,ell)` predicate. Mapping every k modulo ell through F*k+1 reproduced every table field, including F modulo ell and every listed k class.

It then directly enumerated every k in each of the six prefix wheels and compared every retained row of the JSON. Results were:

| Bases through | Wheel | Admissible | First-success counts | No selected base |
|---:|---:|---:|---|---:|
| 3 | 3 | 2 | 1 | 1 |
| 5 | 15 | 8 | 4,2 | 2 |
| 7 | 105 | 48 | 24,12,6 | 6 |
| 11 | 1155 | 480 | 240,120,60,30 | 30 |
| 13 | 15015 | 5760 | 2880,1440,720,360,180 | 180 |
| 17 | 255255 | 92160 | 46080,23040,11520,5760,2880,1440 | 1440 |

The proof of the fractions is finite: F is invertible modulo each odd base, so k maps bijectively to c modulo that base. Excluding c=0 leaves ell-1 classes, half squares and half nonsquares. CRT takes the Cartesian product of these independent residue choices. It gives first-success fractions 1/2,...,1/2^m and an unselected fraction 1/2^m among admissible classes. The six-base selected count is therefore 90720. The independent wrong-sign selector for base 3 gives k=0 instead of k=2, reproducing the stated negative control. This is a selector control, not a mutation test of an implemented multibase checker.

None of this conditions on c actually being prime or on an entire short window containing a useful prime. Composites may select bases. Finite residue independence is not independence of prime occurrences. The author explicitly preserves these distinctions. The residue arrays are optional untrusted search aids; actual modular certificates establish primality.

## Grouped recurrence and coverage

For group a, every assigned c divides M_a by construction. Gcd(a,M_a)=1 implies the necessary gcd(a,c)=1. Starting with V_a=a^D, A_a=V_a^S and U_a=A_a^i0 modulo M_a, induction over the original slot index gives

    U_a congruent to a^(D*S*(i0+j)) modulo M_a.

Advancing at every position, including slots belonging to another base or general fallback, is correct. Skipping those advances without an exact jump would be incorrect; the proposal does not do so. Reduction to c and the offset term give exactly the certificate above. No pairwise coprimality or distinctness of factors is used.

Every required slot must have exactly one group assignment or a general-prime certificate. Its output is an actual prime in the same specified interval. This preserves the earlier B-2 gap/coverage argument. Empty groups do not run a modulus-1 proof; all-general blocks simply use their general records. No group choice, tag or modulus can stand in for a missing interval-prime fact.

The cost description agrees with the frozen inventory. A nonempty group with n_a factors has a modulus of at most 90*n_a bits. The straightforward schedule duplicates initialization and q advances for each nonempty group, but at different operand sizes. Slot tests belong only to assigned groups. Thus neither a fixed multiple of the old whole-block cost nor one unchanged cost is justified. Fallback frequency alone also misses the distribution of group sizes and positions. The proposed decision criterion correctly includes failed searches, general certificates, proof construction and storage; it does not infer a measured saving from CRT proportions.

## Remaining implementation boundary

The current Lean code still has base-3 and fixed-width specializations. The generalized gcd/cancellation adapter, group product and recurrence, tags, interval outputs, partial last blocks and sound assembly must be implemented and checked before a multibase ladder is accepted. Candidate generation, complete window coverage, fallback cost and any eventual Lean/MM0 runtime remain open. The paper implication and exact residue recount pass without changing those boundaries or any old file.
