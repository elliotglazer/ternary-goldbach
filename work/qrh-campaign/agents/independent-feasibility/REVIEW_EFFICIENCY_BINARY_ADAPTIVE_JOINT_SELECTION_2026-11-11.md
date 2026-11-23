# Review of binary cutoff and adaptive ladder selection

2026-11-11. Verdict: PASS at bounded paper and exact-metadata scope for the original report together with its erratum. The original mixed-lattice pruning claim is false in isolation. The erratum removes that claim without changing the valid fixed-lattice result or its numerical inventory. No measured optimum, complete prime chain or full formal proof is established.

## Frozen packet

Paths below are relative to `work/qrh-campaign/agents/` unless stated otherwise.

| File | SHA256 |
|---|---|
| moebius/EFFICIENCY_BINARY_ADAPTIVE_JOINT_SELECTION_2026-11-11.md | FF655308043C2627F8E757AF238E0275F055B483A9C3F7BC4E01503ABC8089BC |
| moebius/ERRATUM_BINARY_ADAPTIVE_PRUNING_2026-11-11.md | 98A6C32B43C63354AC044B5757BD30C92D84C18317AE9A0D38C5BF4A0D1F130B |
| moebius/binary_adaptive_joint_metadata_20261111.py | F1CBD6F75ABDB9E397B0B0272396CB7354AAC89A068966CE5E5EF3302A3687BC |
| moebius/binary_adaptive_joint_metadata_20261111.json | 1CD875317F21009CECA5F591A272219AD1E2CDBDDE4A98E415B0FD19419A298C |
| work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean, repository-relative | 0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F |

I read the complete author packet and code, the actual source primality theorem and the relevant binary-coverage/direct-order constructions. All five support pins in the metadata receipt matched their files. A separate read-only integer/rational check reconstructed the ten rows, thirty block cases, cell endpoints, nine switching thresholds and support hashes. It completed 314 grouped checks, plus the mixed-tag counterexample. Tool record `b2ee44` records the check. The author writer was not imported or rerun. No prime search, primality evaluator, analytic function, Lean build or source edit was used.

## Fixed-lattice pruning really preserves the certificates

For primes p=1+Fk after the initial prime 3, the first gap bound is Fk-2<=B-2, equivalently k<=floor(B/F). Every later positive jump obeys delta_k<=floor((B-2)/F). The terminal test is k>=ceil((O-B-1)/F). Hence the three gates control all coverage conditions, including the start and stop. Oddness, primality and the explicit p<T size bound do not change when B moves within a gate cell.

Solving those three integer inequalities gives exactly the author's closed cell endpoints. Intersecting with even B and the permitted planning range is necessary. All same-F prime values, supplied roots and products can remain unchanged at the smallest admissible B. The stopping index is unchanged too. Before termination p+B<O; parity strengthens this to p+B<=O-2, so any proposed next prime satisfying the gap condition is <=O-4<T. This justifies the stated search-size implication, although the verifier must still check its own size field.

The source theorem `prime_of_dvd_pow_add_one` proves the required odd candidate prime from the negative-one power and the bound below (2^45+1)^2. The proposed direct supplied-root checker can use that theorem; the old fixed-stride `Cert` and `run_spec` do not already implement the adaptive format. Product batching still requires exact product formation and the global congruence proof. It is not free arithmetic.

Binary truncation is a separate condition on the pruning rule. With fixed L,D, retain complete earlier blocks and the needed prefix of the last block. Their anchor values remain 2rL-(2s+1), independent of B; rL<=B/2 gives anchor<=B-1. All retained source facts stay valid. A residual tree or packed check must expose a sound prefix restriction or be recomputed for that prefix; blindly reusing a whole-block acceptance flag is insufficient. The author's truncatable-architecture and nondecreasing-cost hypotheses are therefore substantive. They do not follow from prime geometry, cache heuristics or measured run times.

## Required mixed-tag correction

The original instruction to intersect all per-tag cells was insufficient for chains changing F. Take F1=8, F2=12, O=101, and B=20 or 22. Both cutoffs give gates (2,2,10) for F1 and (1,1,7) for F2. But the cross-tag edge 17=1+2*8 to 37=1+3*12 has gap 20. It fails B=20 and passes B=22. This is an exact algebraic counterexample, not a prime-density argument.

The erratum correctly limits the intersected-cell rule to separate single-F alternatives. For mixed chains, include cross-transition thresholds or retain exact gap tests without the claimed pruning. Arbitrary-prime fallbacks likewise invalidate this coarse cell invariance. The counterexample changes none of the receipt's fixed-F=2^45 values.

## Binary source, support and range checks

The initial range has L-2 even targets. The outer blocks have total E-L+1, including a final width of one when L divides E. Together they give E-1 targets, exactly the even integers from 4 through B. The maximum source index is L+D-1 and its odd value is U=2(L+D)-1. A sound positive-only source suffices for coverage; bit zero must not certify 1. A complete base-prime list is additionally needed if the chosen sieve proof consumes completeness.

For all thirty B,L cases, U^2>B. Thus an anchor n<=B-1 can have at most one prime factor of n-1 exceeding U. Such a factor q exceeds sqrt(n), while q< n/2 because n is odd and n-1 has its factor 2. The resulting logarithmic above-U chain-depth bound is valid. It says nothing about whether factorization is cheap, how many distinct support nodes occur across anchors, or whether the needed smaller prime has a retained proof. The report preserves these distinctions.

The exact-order component power count follows from P(d)=floor(log2 d)+popcount(d)-1 and P(d)<=2 floor(log2 d). The sum of the relevant logarithms is log2 F, giving the stated 2 floor(log2 F) bound before unit, factor and representation checks. The support's unit tests or guarded cyclotomic alternative are necessary; non-equality modulo a composite is not a replacement. The source/cache proof costs remain in the ledger.

## Cost interpretation and usable decision rule

The production/checking separation is appropriate. In particular, supplied roots remove the precursor power from acceptance, not from root discovery. Batch products reduce the number of chains while increasing their operand widths. A model proportional to width^a gives the stated n^(a-1) ratio for the 44-square portion only. No preference for direct or batch verification follows without the other terms and the actual arithmetic representation.

The square-root minimizer and two-cutoff switching inequality are algebraically correct for fixed positive a,c,kappa and the stated continuous approximation. They are not valid across changes in search success, deficit distribution, certificate format, source setup or cache behavior unless those quantities are repriced. Mean advance per rung must describe a complete scenario, not successful candidates with failures omitted. The necessary prime count is a lower bound; the d_max upper count requires a successful next prime at every step. Neither supplies availability.

The useful selection procedure is therefore to prune only justified fixed-F cells, retain actual binary architecture thresholds, and compare complete cost intervals or symbolic switching inequalities. Moving to a smaller B is justified only when the full binary saving exceeds the added ladder cost under the same obligations. If intervals overlap, retain both candidates and identify the missing coefficient or distribution. No candidate B or L in this packet is a measured optimum. The conditional threshold T=9.89*10^26 still requires its complete analytic theorem and costs; substituting it into geometry does not establish that theorem.
