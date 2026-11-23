# Threshold reduction and alternatives to the explicit ladder

2026-11-11. Coordinator reconciliation. The previous goal turn made progress through the integrated cost model and independently reviewed acceptance designs. This turn accepts one bounded threshold improvement and records distinct ladder-replacement candidates, with their unresolved inputs preserved. No prover build, prime test or analytic-function evaluation occurred.

## Accepted threshold improvement at source scope

The candidate analytic threshold is N0=989*10^24. The original major and minor estimates remain at their existing x>=4.9e26 and y>=1e25 domains. The elementary inequality sqrt(2*pi)>5/2 gives

    c0=2+9/(196*sqrt(2*pi)) < 989/490,
    N0=(989/490)*(4.9e26).

Hence N>=N0 supplies the original scale assumptions. The Chebyshev/nonprime chain still has the root lower bounds it uses, and the actual strict final inequality proof survives. This changes wrappers and an elementary scale lemma, not the spectral domain or the estimates inside the major/minor integrals.

The coordinator read both the author and independent review, verified their hashes and all 34 source-table pins, inspected the scale wrapper and the full crude-inequality body, and independently checked 12 exact scalar/count assertions. The source review is accepted. Implementation, elaborated dependency inspection and kernel validation remain outstanding.

For the old stride and B=4*10^18, the required maximum index becomes 251837287. At 4096-rung checking granularity the prefix needs 61484 chunks rather than 62168. It removes 684 chunks and 2801664 checked positions. Keep the first 61198 chunks before L126 and 286 chunks of L126; omit the remaining terminal chunks. Prefix-only data/import aggregation is necessary to realize this saving. Restricting a theorem that imports the complete old aggregate saves no clean-build work.

This is about 1.1 percent of the old ladder component, not of the total proof. The candidate can be used in future production plans. Existing N=10^27 comparison tables remain conservative reference counts and are not silently rescaled. A route that eliminates explicit ladder enumeration would have a different response to lowering N.

| Artifact | SHA256 |
|---|---|
| `../qrh-campaign/agents/major-constants/EFFICIENCY_LOWER_ANALYTIC_THRESHOLD_2026-11-11.md` | `99D06335D5F8AF1D9AB0916A84BB60AE2ECF060B5FDF04C0134AB9BCB860F786` |
| `../qrh-campaign/agents/audit/REVIEW_LOWER_ANALYTIC_THRESHOLD_2026-11-11.md` | `CA5489EB8F7357CC4E4FC73FC96FACF700388DD513D3BC84495A246892FFD7D8` |

## Uniform prime intervals can replace the numerical ladder

The finite reduction only needs a prime in the permitted interval for each odd n. If a proved uniform prime-interval estimate supplies that existence, the proof need not enumerate or serialize one prime per interval. This is a mathematical change in the certificate architecture. Batching a list of explicit primes does not by itself achieve it.

For even B and odd n, a prime in [n-B,n-4] gives an even remainder in [4,B]. The checked binary theorem supplies the other two primes. A positive difference of normalized theta at these endpoints also suffices: its half-weight endpoint terms still witness a prime in the closed interval. Do not strengthen that conclusion to a strict-left interval without justification. A positive psi difference instead needs prime-power removal.

When a theta estimate starts only at 599, one small certified prime p0>=599 can cover the low transition after the p=3 base case, provided its interval overlaps and p0<=B+1. The strict endpoint in a theorem stated for t>599 must be included in that elementary patch. This is an exact coverage obligation, not an assumed prime-gap computation.

The prime-interval theorem and every finite computational input must eventually be proved in the chosen foundation. A published numerical verification is a source for an algorithm and a claim to reproduce, not a new allowed mathematical axiom.

## Candidate routes remain distinct

The following rows are working research candidates reported by the assigned workers. Except for the threshold improvement above, this document does not give a completed independent audit of their analytic application. The coordinator opened both primary papers and confirmed their versions and scope.

| Route through N=10^27 | Proposed B | Principal spectral input and open cost |
|---|---:|---|
| Explicit mixed ladder | 10^16 or 2*10^16 | Original principal height 10^8 remains; new mixed prime certificates and complete binary verification still needed |
| Johnston Theorem 3.2 | 10^16 | Candidate height 9*10^12; its published initialization through 3*10^12 lies inside that target; full analytic formalization and spectral certificate remain |
| Corrected Cully-Hugill–Lee table route | 2*10^16 | Exact height 3000175332800, additional low-zero sums/counts, zero-density/free-region inputs and rigorous table inequalities; stitching under independent audit |
| Johnston Theorem 4.1, printed a=1 row | 2.5*10^17 | Displayed scalar condition suggests 8*10^10, but the published proof also consumes the 3*10^12 initialization; no lower verification bill is credited |
| Fresh Johnston lemma-level parameters | 2*10^16 | Research into a coefficient near .08 and a smaller height with a different initialization; no completed bound or accepted height |
| QRH-assisted high-zero tail | Undetermined | Research into whether beta<=7/8 plus a finite critical-line head reduces principal verification enough to repay the QRH and smoothing formalization |

The primary sources are [Johnston, version 2](https://arxiv.org/pdf/2109.02249v2) and [Cully-Hugill and Lee, corrected version 3](https://arxiv.org/pdf/2103.05986v3). The corrected version matters. A rounded published height, an obsolete table or a theorem's displayed parameter alone is insufficient evidence of its full computational dependency.

For the CHL route the reported extra data include a low-zero cutoff 104537615, a count of 260 million and a reciprocal-weight sum bounded by 21.98308. The exact sum interpretation and sufficient interval margins are being reconciled. The spectral worker is investigating whether already checked zero/count blocks can certify this sum cheaply, rather than treating it as a separate costly per-zero calculation.

Older interval estimates are also being considered. A weaker gap bound may permit a larger B while requiring a much smaller principal spectral certificate. The narrowest published interval need not minimize total proof cost.

## Compare complete costs, including a hybrid

At fixed B and unchanged nonprincipal/large-N proof, replacing the explicit ladder is advantageous only if

    additional principal certification
      + additional prime-interval analytic library and scalar certificates
      + new range assembly
        < avoided complete ladder work.

If B changes, add the complete change in binary source, anchor and coverage work. The principal RH certificate up to the old height is already an obligation; reuse it where actual proofs permit, but do not assume it has been produced. Nonprincipal character verification is not removed by a conductor-one prime-gap theorem.

A hybrid can use a uniform interval theorem only up to C and retain a suffix of explicit ladder rungs. Its exact first and last rung indices, chunk boundaries and overlap must be derived from the actual coverage theorem. No prime-to-prime seam is needed if each retained rung directly covers its assigned target cell. Suffix-only imports are necessary for a real checking saving.

There is also a simple general low-range patch that needs no numerical prime certificate. Let A>=2 be an integer and B>=2A be even. Bertrand supplies one prime A<p<2A, so p is odd and p<=2A-1. For odd n with B+5<=n<=A+B, the difference n-p is even, at least B-2A+6>=6 and at most B-1. It therefore lies in [4,B]. The base p=3 covers n<=B+3, and a theta estimate whose lower endpoint is at least A handles the rest. The proof uses Bertrand as a theorem; it does not evaluate a prime near A.

This patch motivates the fresh lemma-level route now under two independent checks. Its author proposes A=10^16, Q in [1,50], principal height H=4*10^10*Q and theta-error coefficient a(Q)=.031+2.261/Q through 10^27. At Q=48 the proposed coefficient is about .078105, sufficient in the author's gap calculation for B=2*10^16. These are unaccepted research parameters pending the complete scalar derivation and source-premise audit. The low reciprocal-zero input through 5000 remains explicit. No published table is interpolated, and no finite spectral certificate is assumed.

For the CHL comparison, the spectral worker reports that the two selected rows use the count alternatives of both low-zero bounds. Adding those alternatives can cancel the intermediate low cutoff/count and avoid the reciprocal-sum certificate in a rederived inequality. This is a potential simplification of the published input list, not yet coordinator acceptance of the complete table inequality.

The coverage worker's conditional smooth model suggests that with spectral cost proportional to H*log H and range proportional to H^2 times increasing logarithms, interior stationary points can be maxima rather than minima. This is not an optimization verdict for the real prover: actual theorem domains, initialization floors, bit precision, fallback costs and discrete chunks can introduce other candidates. Keep the no-extension option and every genuine theorem boundary in the comparison.

## Arithmetic reconciliation

The coordinator also read the mixed-ladder efficiency report and checked all five source/artifact pins, at SHA256 `9AACAF7FC0B5DCD9145AB3006D40248A2C7D57319677C57600890D21E5F75783`. It retains grouped indexed jumps, direct singleton Proth checks and common-X batches as competing implementations. Modular offsets avoid potentially much wider unreduced powers. Its operations are indexed by actual operand sizes and do not imply a winning batch size.

For MM0, distinguish fixed limits of the inspected mm0-c implementation from the ordinary proof rules. A widened-format, garbage-collected or streaming implementation can check the same PA inferences without adding arithmetic axioms. Its implementation and validation cost must be included, with the same assurance standard used for Lean's kernel implementation. A new arithmetic acceptance rule or accelerator is a separate case. Do not turn an avoidable 32-bit metadata limit into a claimed fundamental lower bound for an efficient MM0 implementation.

The full goal remains incomplete. The current progress changes the available designs and rejects unsupported cost reductions; it is not an end-to-end proof or a new compute estimate.

    DRAFT_ANCHORS: 0 created
    UNREGISTERED_SORRIES: 0 introduced
    DRAFT_IMPORT_VIOLATIONS: 0 introduced
    SEALED_THIS_TURN: 0
