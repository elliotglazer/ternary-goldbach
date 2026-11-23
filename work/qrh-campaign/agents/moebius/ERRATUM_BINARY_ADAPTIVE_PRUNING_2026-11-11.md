# Correction to mixed-lattice cutoff pruning

2026-11-11. This corrects only the portfolio extension in section 5 of `EFFICIENCY_BINARY_ADAPTIVE_JOINT_SELECTION_2026-11-11.md`, SHA256 `FF655308043C2627F8E757AF238E0275F055B483A9C3F7BC4E01503ABC8089BC`. Those frozen bytes and their metadata remain unchanged. The independent reviewer identified the error; the coordinator authorized this separate correction. No prime evaluations or builds were performed.

The fixed-F result remains valid. If all ladder primes after 3 lie on one fixed lattice 1+F*k, the triple

    floor((B-2)/F), floor(B/F), ceil((O-B-1)/F)

determines the allowed first indices, subsequent index increments and terminal index. With the stated nondecreasing binary-cost assumption, use the least even cutoff in each triple's cell.

Intersecting the cells for several F values also permits comparison of *separate single-F alternatives*, each of which uses only one F throughout its chain. It does not preserve the feasible set of chains that change F. Their cross-tag inequality

    k2*F2-k1*F1 <= B-2

can change inside such an intersection. For genuinely mixed chains one must include every relevant cross-transition threshold, use a separately proved sufficient refinement, or retain the exact original gap tests without this pruning. No compression or feasible-set invariance follows from the individual triples alone.

The reviewer supplied an exact counterexample. Take F1=8, F2=12, O=101, and compare B0=20 with B1=22. The triples are (2,2,10) for F1 and (1,1,7) for F2 at both cutoffs. Nevertheless the cross-tag edge

    17=1+2*8, 37=1+3*12, difference=20

fails the first gap bound 18 and passes the second gap bound 20. This is an integer-geometry counterexample and requires no primality oracle. It directly disproves the asserted mixed-tag gate implication. For illustration, the sequence 3,17,37,41,61,73,89 uses the two lattice tags, has all gaps at most 20, and reaches beyond O-B1; its 20-sized gaps fail at B0. No production prime certificate is claimed for this illustrative sequence.

All numerical metadata in the original receipt concern fixed F=2^45, so this correction changes none of those counts or tests. The cost ledger, direct-order scope, unknown adaptive availability, fixed-F switching rule and all binary source/cache qualifications are unchanged. Read the original report together with this erratum.
