# Independent review of grouped order-root certificates

2026-11-11. Verdict: **PASS at paper soundness and static schedule scope.** No correction is required to `major-constants/EFFICIENCY_GROUPED_ORDER_ROOTS_2026-11-11.md`, SHA256 `94CEE16A312EE0535E57827BA5241AC768464EB0DE4654500A3A8B7B84C8F5C4`. No candidate, prime, modular-power or analytic evaluation, build or source change was performed. The script was read, not executed by this review.

The exact schedule source is `45E7C08123A9B8B4A892C12BD40622551778DB41C2D5990DDD4B91E48EE73DF8`; its receipt is `C0E1AAAC2EF8D90CAA841288ACCD5B3938DB981D3C3F3F3AC010CE37B1225BFC`. All six artifact pins in the note match current files. The six displayed rows match the saved receipt. This is not an independent numerical rerun of the partition optimizer.

## The mathematical implication

For the requested prime-power case, take any prime divisor r of N. The identities

`y=x_q^(q^(e-1)), y^q=1 mod N, gcd(y-1,N)=1`

imply that x_q is a unit modulo r and that its order divides q^e. The gcd condition says its q^(e-1) power is not 1 modulo r. Since e>=1 and q is prime, that order is exactly q^e. Thus q^e divides r-1.

For a general group order d, the same argument uses all primes q dividing d. An order properly dividing d must divide d/q for at least one such q, contrary to its unit test. Hence the group witness has order exactly d modulo every r. The orders from different witnesses combine by lcm. There is no requirement for the witnesses to agree or for their product to have a particular order.

If F is that lcm, each r is at least F+1. A composite N>1 has a prime divisor r with r^2<=N. Therefore N<(F+1)^2 proves primality. Repeated prime factors of N do not evade this argument. The complete factorization or exact lcm must be proved; a list of asserted factors is insufficient.

No premise F divides N-1 is used. It follows after primality by applying the order conclusion with r=N. Omitting the premise saves a redundant logical check but does not admit new prime residue classes. Actual candidate reconstruction, range and coverage remain required if the certificate uses a lattice encoding.

## Shortcuts and edge cases

For even d, x^(d/2)=-1 supplies the full root identity by squaring. Its difference from 1 is -2, a unit under the explicit odd-N guard. Once the lattice-divisibility premise is omitted, that parity guard must not disappear. For an odd-prime group the root identity remains a separate checked output.

The free parity block is valid only for the full factor 2. Oddness does not turn an order-2^(e-1) test into an order-2^e test. The selected partition keeps each full prime power atomic. Overlapping general groups contribute the maximum valuation through lcm, never a product that adds repeated valuations.

Order-one groups add nothing, empty groups are discarded, and an empty set of unit conditions needs no inverse. For the actual portfolio, every partition has exactly ten odd-prime unit conditions. Their product is a unit if and only if every factor is a unit. Forming ten residues' product and checking one inverse uses nine plus one modular products. No per-root inverse is needed.

The whole-product transfer is sound because all root and inverse identities descend from the exact M to each bound candidate divisor. It does not require pairwise coprimality. Ordinary producer CRT does require distinct primes or appropriate repeated-prime-power lifts, which the note states. No checked CRT trace is required when the resulting common residues themselves pass all arithmetic gates.

## Schedule fidelity

The shared binary ladder computes each required d/q output and, for odd groups, d itself. Reusing exponent 1 and deduplicating equal requested exponents are legitimate. The prepower t=d/rad(d) retains all repeated factors. Each complement-tree split multiplies the exponent by the radical of the other child; induction gives the exact d/q leaves. The extra odd-group q-th power obtains d. Even groups derive it from their negative-one leaf.

Static inspection of the script confirms that its group costs include prepower, the selected tree or binary ladder, and the odd-group final power. Its partition recurrence fixes the least remaining bit in each chosen block, avoiding permutation duplicates. Free parity contributes zero roots only when the 2-adic exponent is one. Aggregate-unit products are added once after partitioning.

The stated full vector Pareto recurrence is mathematically valid within its specified schedule library. The actual script keeps only the equal-weight squares-plus-products minimum at each exact root count. It does not compute the full square/product/root frontier, exploit arbitrary addition chains, or share unmodeled work across groups. The report preserves those limitations. Its illustrative coordinate-price comparisons are algebra on that finite projection, not measured cost parameters.

The existing `Ladder/Spec.lean:38` power-of-two criterion, SHA256 `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F`, supplies the least-factor mechanism. General group-order and executable arithmetic adapters remain new proof work. Every extra root and the aggregate inverse can have full product width, so fewer counted operations do not establish less generation, serialization, elaboration or kernel work.

Cyclotomic geometric-sum variants discussed during review are outside this frozen packet and its counts. No such replacement is needed for this verdict. No successful certificate, complete ladder, production rate or change to the final theorem's premises follows from the paper criterion or schedule receipt.
