# Review of the reusable binary cover dictionary

2026-11-11. PASS for the finite mathematical construction and conditional ordinary-proof cost model, with the explicit cost qualifications below. No prime evaluations, sieve, build or actual compression experiment was performed. No author files were changed.

The author is `major-constants/BINARY_SHARED_COVER_DICTIONARY_2026-11-11.md`, SHA256 `3B9747B5502C2AD7665A17EA55D2DF1357AA97D8CB874239C350DA21DD4F5E0A`. Its metadata script has SHA256 `9E97CDAF5C8C5837FF08B25A37AA54D34D8B991526A707FF5E034251F3882976`; its receipt has SHA256 `C81B37DA6AFA850FA07A5449BBF3D734A564B3CE01E2A426D2AD146601ED46DE`. Paths below are relative to `work/qrh-campaign/agents/` unless stated otherwise.

## The reusable theorem has the required quantifiers

Fix integers L,D with L>=D+2, a fixed source bit string P of length L+D, and a finite set S contained in {0,...,D}. Retain both premises: every set source bit denotes an actual prime, and every target offset t<L has at least one s in S with P[t+s]=1. These premises are independent of the outer block r.

For each r>=1, the only new mathematical premise is actual primality of every selected anchor `q(r,s)=2rL-(2s+1)`. Choose a source-cover witness s for t. Since

`2rL-(2s+1)>=2L-(2D+1)>=3`,

natural subtraction is exact. Also `0<=t+s<=L+D-1`. Thus the source-prime implication applies and

`q(r,s)+(2(t+s)+1)=2(rL+t)`

is an equality of natural numbers. This proves the universally quantified block theorem. It does not prove the anchor premise for any r, and therefore makes no unsupported prime-existence assertion.

The theorem may be stored once with the fixed source and cover proof, then specialized at many r. This shares the cover derivation, not the primality proofs. If `q(r,s)=q(r',s')`, cancellation gives `(r-r')L=s-s'`. Because |s-s'|<=D<L, this forces r=r' and then s=s'. Thus distinct blocks have distinct anchor values in this format. A prime proof can be reused across clauses within one block, but it cannot be identified with a different block's anchor merely by sharing an offset.

The top source implication needs soundness, not completeness. Unset bits can omit primes. If the source is constructed by the proposed sieve, its base-prime lists still need completeness to prove soundness of all surviving bits. P[0] cannot be set because it would assert that1 is prime. The prime2 and the initial binary interval remain separate. Hash equality and a probable-prime result do not supply either source or anchor primality.

## Exact finite coverage and clauses

For even B, put E=B/2 and assume E>=L. Each integer k with L<=k<=E has a unique division `k=rL+t`, where r>=1 and0<=t<L. For r=R=floor(E/L), the permitted offsets end at E-RL, so the last width is E-RL+1. If L divides E this width is1, not0. The earlier outer blocks have full width L. Together with initial k=2,...,L-1, the disjoint target count is

`(L-2)+(R-1)L+(E-RL+1)=E-1`.

This proves coverage of all even n from4 through B once every block and the initial interval has a certificate. No overlapping block can conceal a missing endpoint. For the degenerate L=2,D=0 case the initial interval is empty; a nonexistent usable template must fail or fall back, rather than becoming a proof of its anchor premise.

For the hitting formulation, regard each H_t and every clause as a subset of the finite palette index set. The available set A_r contains only indices with supplied positive prime proofs. There is no need to prove omitted anchors composite. In the finite family of distinct rows, every row contains an inclusion-minimal row: choose a row of least cardinality among those contained in it. Therefore hitting all minimal rows is equivalent to hitting all rows. Empty rows must remain; they correctly make success impossible.

The more general sufficient clauses satisfy `for every t, some C_j is contained in H_t`. If the later block hits every C_j, a witness from that intersection belongs to H_t and supplies both primes. The order of quantifiers matters: the one-time clause domination is uniform over all t, while the later witness may depend on r and j. No common witness across all targets is assumed. Clause indices must lie in the palette; the displayed mask construction has this typed-set interpretation.

The AND mask for a clause records exactly the targets for which every one of its members is a source hit. OR coverage of those masks proves domination. Nonempty clauses and a valid ID format are necessary for usable certificates. The `ceil(log2 K)` dictionary-ID expression is interpreted for K>=1; an empty dictionary can only send every block to a separately complete fallback. It does not define a zero-cost successful template lookup.

The redundancy inequality follows by double counting the same finite incidences. If every target has at least d+1 distinct hits, deleting at most d anchors leaves one hit. Summing these lower bounds gives `(d+1)L` no larger than the sum of the per-offset source-hit counts. Neither argument assumes random or independent primality.

## Congruence obstruction

For an odd prime ell not dividing L, multiplication by2L is invertible modulo ell. The exact condition `ell | q(r,s)` is

`r=(2s+1)/(2L) mod ell`.

Distinct offset residues give distinct forbidden r residues. Hence exactly ell-d_ell classes avoid divisibility by ell, and independent prime moduli give the stated product of surviving classes by CRT. These are necessary conditions for prime anchors only once each relevant q exceeds its potential divisor. Equality q=ell must be treated separately. If the offsets contain every class modulo ell, every sufficiently large r has at least one composite required anchor, so that full template is unusable there.

For a fixed finite nonempty palette, choose distinct primes ell_s not dividing2L. CRT solves all of its forbidden-anchor congruences simultaneously. The resulting positive arithmetic progression is unbounded, so r can be chosen large enough that every q(r,s)>ell_s. Every palette anchor is then composite. This refutes an all-r success claim for that fixed palette. It gives no bound placing a bad block below any specified finite R and does not refute another palette, fallback, or Goldbach. For an empty palette success already fails because L>0; no CRT argument is needed.

## Ordinary-proof and cost qualifications

The new compression is logically real: one previously checked universally quantified cover theorem can replace repeated derivations of the same finite source-cover fact. In ordinary Lean, an opaque theorem reference can supply that fact without replaying its concrete arithmetic derivation at each r. In ordinary MM0, ordinary theorem specialization and implication elimination can do the analogous job. Neither observation supplies the missing concrete source-primality theorem, the cover proof, the anchor proofs, or a measured cost. The cost of specialization and its term representation remains charged. Unchecked native acceptance or an unchecked hash-to-theorem lookup is not sufficient.

I inspected the actual Statement and SmallCases sources named in the author receipt. `BinaryGoldbachUpTo` is the inclusive every-even-number proposition; `BinaryGoldbachInput` fixes4*10^18. SmallCases uses that fixed bound and the ladder. A smaller prefix still needs a changed, separately proved reduction. I also inspected the arithmetic-fixture construction in KernelBench and SourceProofs. Their mask equalities do not contain a proof that all set bits denote primes or the general block theorem above. No old timing is evidence of that missing work.

Two qualifications apply to the exact saving language in section5, and the author has confirmed this interpretation without changing the frozen note:

* `Cover_S(j)` must be the cost of the selected charged full-L replay schedule for the equality-of-cost comparison. When its formula is only an upper bound, subtracting two such upper bounds does not prove actual savings. A concrete comparison needs exact charged schedules or appropriate upper/lower bounds.
* The last block may be partial. Reusing a full-L theorem is valid there, but a direct competitor can check only its width w_R. Relative to that competitor, replace its repeated full-L charge by the smaller actual partial-block charge. Formula(10)'s repeated `R_j Cover_S(j)` comparison assumes the same full-L replay schedule for each assigned block; it is not a universal lower bound for old checking methods.

Unused dictionary entries must still pay their one-time construction/checking costs. If every template is used only once, there is no automatic cover-arithmetic gain; a partial last block can make the difference worse. Actual reuse counts, clause sizes, failure costs, prime generation/checking, source setup, initial interval and fallback coverage remain unknown or separately charged. The source and theorem must genuinely be shared rather than textually expanded into every instance. These restrictions preserve the useful construction while preventing unearned end-to-end compression claims.

## Evidence and unresolved implementation

The independent `zero-sum/review_binary_shared_cover_20261111.py`, SHA256 `7F7438AF37792A782796960481E96665B0F12E439B6894E2BE79A002AB43067E`, passed4169 abstract-set, source-pin and exact integer checks. Its receipt has SHA256 `566FB878DC24E9B3B9347D914E10E22BBEBBD95DCBC58EC5FA5CFD47A1602C90`. It uses set-based minimal-row tests on different tiny layouts, checks all small finite block partitions including divisible endpoints, and reconstructs the three published large layouts. It does not assert that any tested abstract bit pattern is a prime table. An initial syntax typo was corrected before this receipt was produced; no earlier run generated data.

All nine source/report pins in the author receipt were verified. General finite-set and CRT proofs are the arguments above, not consequences of the finite tests. Their formalization, an actual dictionary or clause set, complete fallback data and ordinary proof-cost evidence remain open. No analytic or prime evaluation, build, or mutation of a frozen author artifact was performed.
