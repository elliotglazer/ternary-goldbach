# Multiple Proth bases before general-prime fallback

2026-11-11. This is a proposed improvement to the mixed-ladder design, with exact residue-class checks and a paper soundness argument. It contains no new Lean declaration, prime search, benchmark, or completed ladder certificate.

## Proposed change

Use a small set of odd bases before paying for a general primality certificate. The current source searches only base 3 and additionally requires its candidate to be 2 modulo 3. A prime of the correct Proth shape can fail this base while succeeding with base 5, 7 or another small base. Treating every such failure as a general-prime fallback wastes available structure.

Compare three complete certificate designs: base 3 plus general fallback; bases 3 and 5 plus general fallback; and a small larger base set plus general fallback. The last design does not automatically win because it introduces more batch groups. The comparison must use total generation and checking cost, and every missing window still needs a certified prime.

## Soundness without a new analytic dependency

Write F=2^45, D=2^44, k=S*i-t and c=k*F+1. Assume 1<=k<F and 0<=t<W. The following are sufficient for the same specialized primality argument with any natural base a:

    gcd(a,c)=1,
    c divides a^(D*S*i) + a^(D*t).

Indeed S*i=k+t, so the second expression factors as

    a^(D*t) * ((a^k)^D + 1).

The gcd condition permits cancellation, giving c divides (a^k)^D+1. Every odd prime divisor r of this expression has r=1 modulo F. To see this, x=a^k has x^D=-1 modulo r and x^(2D)=1. Its multiplicative order divides 2D=F but not D=F/2, and since F is a power of two the order is F. Thus F divides r-1.

If c were composite, its least prime divisor would have square at most c and would be at least F+1. But c<(F+1)^2 because k<F. This is a contradiction. The argument covers composite c with repeated prime factors as well as squarefree composites.

The generic `prime_of_dvd_pow_add_one` source theorem already expresses the final step. Only the specialized base-3 cancellation and checker wiring would change. The final checker does not need quadratic reciprocity or a trusted table of nonresidues. It checks the gcd and concrete modular arithmetic. Even an erroneous producer-side choice of base simply fails to certify the candidate.

## Cheap producer-side base selection

Quadratic reciprocity helps the untrusted producer choose a promising base without first exponentiating every base. For a prime c of this shape, c=1 modulo 8 and hence c=1 modulo 4. For an odd prime base ell distinct from c,

    (ell/c)=(c/ell).

Thus a lookup of c modulo ell can identify when ell is a quadratic nonresidue, which for prime c is exactly when Euler's criterion gives ell^((c-1)/2)=-1 modulo c. The source's modular certificate is the same equality after cancellation. This reasoning predicts a useful search strategy; the checker still accepts only the actual certified congruence and gcd.

Base 2 is not useful here: it is a quadratic residue for primes c=1 modulo 8. Adding it cannot rescue a prime that failed base 3. Composite bases made only from already unsuccessful prime bases likewise cannot rescue a prime, because the Legendre symbol is multiplicative. Use additional independent odd prime bases instead.

The [Mathlib quadratic reciprocity documentation](https://leanprover-community.github.io/mathlib4_docs/Mathlib/NumberTheory/LegendreSymbol/QuadraticReciprocity.html) states the relevant reciprocity and supplementary law. This online source explains the mathematics; it is not evidence of compatibility with the campaign's pinned toolchains.

For c=F*k+1, the exact positive-choice residue classes are:

| Base ell | F modulo ell | k modulo ell that selects a nonresidue |
|---:|---:|---|
| 3 | 2 | 2 |
| 5 | 2 | 1, 3 |
| 7 | 1 | 2, 4, 5 |
| 11 | 10 | 2, 4, 5, 6, 10 |
| 13 | 5 | 1, 2, 4, 6, 8, 9 |
| 17 | 15 | 2, 3, 4, 6, 12, 14, 15, 16 |

For m distinct odd prime bases, restrict to residue classes for which c is coprime to every base. Exactly half of the admissible classes select each base. The Chinese remainder theorem makes these choices independent as finite residue-class conditions. Hence exactly 1-2^(-m) of those classes select at least one base. First-success class counts have proportions 1/2,1/4,...,1/2^m, with an unselected proportion 1/2^m.

These are **counts of residue classes, not proportions of actual primes or successful short windows**. They do not establish a fallback rate, a prime-density theorem, or a complete finite ladder. In particular, the extra bases cannot rescue a window containing no prime of the chosen Proth shape.

The exact-only [residue script](proth_base_residues_20261111.py) and [results](proth_base_residues_20261111.json) enumerate the finite residue wheels for the six prefixes above. With all six bases the wheel modulus is 255255, there are 92160 admissible classes, and 90720 of these select at least one base. The six first-success counts are 46080,23040,11520,5760,2880,1440; 1440 classes select none. The calculation includes a negative sign-choice control. It does not test candidate integers for primality.

## Keep sharing by grouping certificates by base

In a block of q slots, partition ordinary records by chosen base a. Each nonempty group has

    M_a = product of that group's candidate integers,
    V_a = a^D modulo M_a,
    A_a = V_a^S modulo M_a,
    U_a = A_a^i0 modulo M_a.

Require gcd(a,M_a)=1. Traverse the block's original slot indices. At each slot assigned to a, check its divisibility using U_a and (V_a mod c)^t mod c. Advance U_a by multiplication by A_a at every original position, including positions assigned to another base or to general fallback. This preserves the exponent invariant. Explicitly accounted jumps or starting at the first group position are later optimizations.

The product need not have distinct or pairwise-coprime factors. Each tested candidate divides its group product, which is all the congruence reduction uses. Each required slot must belong to exactly one group or to the general-prime branch; an empty group does no work. General records prove primality and the same interval bounds as ordinary records. This leaves the global coverage proof unchanged.

If a group has n_a candidates, its modulus has at most 90*n_a bits. Grouping duplicates initialization but uses smaller moduli. Therefore the cost is a sum over occupied groups at their actual sizes, not the old batch cost multiplied by the number of bases. Nor is it one old batch cost regardless of the number of bases. The arithmetic backend and proof representation decide the tradeoff.

An exact accounting skeleton for a block is

    sum over occupied bases a of
      [product construction + initialization at size 90*n_a
       + progression updates + assigned-slot reductions and offset powers]
    + general certificate costs + index/interval/tag checks.

Count empty and all-general blocks separately. A single overall fallback fraction does not determine this cost: the group-size and position distributions matter. The earlier scalar break-even model remains a conditional aggregate model only after its coefficients include this layout effect.

## Decision test for the next implementation

For identical windows, compare the base-3-only design with two and six bases. Record ordinary successes by base, windows lacking any special-form prime, actual general fallbacks, selected offsets and occupied-group sizes. For each complete block, count certificate generation, verified modular arithmetic, proof construction, bytes and peak memory. Include unsuccessful searches in the producer cost.

Retain another base only when its saved general-certificate and search work exceeds its added grouping and checking work. Order bases by measured total benefit, not merely by numeric value or the residue-class proportions. If generation chooses a later base to improve grouping even though an earlier base also succeeds, soundness is unchanged; the actual congruence is what matters.

The immediate mathematical benefit is a new intermediate branch requiring the same elementary primality criterion. It reduces the need to invoke general-prime certificates for primes missed solely by base 3. The size of the computational benefit remains unmeasured.

Supporting source:

- [Current checker](../ternary-goldbach/TernaryGoldbach/Ladder/Check.lean).
- [Current soundness proof](../ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean).
- [Current hint producer](../ternary-goldbach/LadderHints.lean).
- [Mixed-checker operation inventory](../qrh-campaign/agents/independent-feasibility/MIXED_PROTH_CHECKER_COST_DESIGN_2026-11-11.md).
- [Helfgott-Platt ladder paper](https://arxiv.org/pdf/1305.3062), which uses a small-base search with general-prime fallback. This supports the algorithmic direction, not a timing extrapolation to the proposed formal checker.
