# Pure-kernel replay architecture for the completed short-gap data

Date: 2026-11-11. Research design only. No Lean source was generated, edited, or checked for this task. The interfaces below are proposed mathematical contracts, not frozen declarations or completed proofs. All source references are relative to `work/ternary-goldbach/TernaryGoldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

The external candidate data covers all 6,439 grid windows and 125,271 subcells in `(10^9,5*10^9]`. Independent full recount agrees on all counts. There are still **zero new Lean count proofs**. This design explains how to replace external trust in those counts with kernel-checked closed computations and small generic proofs. The analytic estimate beyond `5*10^9` and its finite spectral inputs are separate outstanding obligations.

## Existing proof components and the required changes

`Prelim/PsiSieve.lean` already supplies the difficult bit arithmetic:

* `maskP` and `maskP_spec`, around lines 67 and 72, construct and characterize the bits congruent to a residue below a length. The length need only satisfy the existing `W <= 2^64` premise.
* `pcL` and `pcL_spec`, lines 202 and 221, count bits by splitting into 256-bit leaves. `pcL 7` counts exactly the first 32,768 bits.
* `orP` and `orP_cons`, around line 319, shift each prime pattern by `(n+1) % p` and combine with bitwise OR.
* `thS_sub`, line 412, identifies a theta increment with the sum of prime logarithms on `Ioc a b`.
* `InvT`, line 418, expresses a theta interval with scale `S = 10^9`.

`Prelim/PsiSieve3.lean` supplies the template, but its current constants are insufficient. `mem_PS3` at line 106 only proves completeness through 31,622; `prime_iff_PS3` at line 113 requires `m < 1,000,014,129`; `pats3`, `orP_spec3`, and `cnt3_spec` at lines 131, 133, and 166 use 66,000-bit masks. The new contracts must use the complete prime base through 70,710 and 131,072-bit masks. Reusing `cnt3_spec` unchanged for the completed data would be invalid.

`outerT3_spec` at line 233 proves the older square-root-shaped `RtT` condition and evaluates counts inside its loop. It should not be the new public checker. Separate the new count proofs from the relative theta checkpoint recurrence so the latter cannot cause a sieve to be evaluated again.

## Minimal generic mathematical contracts

These contracts are internal proof infrastructure. Each finite premise must later be discharged by a concrete kernel proof. None is to become an additional assumption on the final prime estimate.

1. **Complete finite prime base.** For a concrete finite base `B`, prove `p in B iff p <= 70710 and Nat.Prime p`. Sortedness and absence of duplicates are useful for data checking but not required for OR correctness. Completeness is required. Adapt `isPrimeSlow3_iff` with the exact guarded predicate `2 <= n and forall d in [2,265], n < d*d or n % d != 0`. Retain both guards: rejecting divisibility by every integer in this range without the square guard would incorrectly reject small primes. Since `266^2 = 70756 > 70710`, this covers every possible smallest divisor. Partition the candidate integers `0..70710` into 277 blocks of at most 256 integers, prove each filtered list by kernel decision, and combine the block equalities structurally. This avoids one 70,711-element recursive decision. There are exactly 7,004 supplied primes, with largest prime 70,709.

2. **Prime characterization above the base.** If `70710 < m < 70711^2`, then `m` is prime iff no member of `B` divides it. The proof is the existing `Nat.minFac_prime`, `Nat.minFac_sq_le_self`, and `Nat.minFac_dvd` argument from `prime_iff_PS3`. The strict cap is `70711^2 = 5,000,045,521`, so the endpoint `5,000,000,000` is included with room to spare. The lower premise excludes falsely striking a prime equal to a base prime.

3. **Certified literal patterns.** For each base prime `p`, introduce a concrete natural-number literal `M_p` and prove `M_p = maskP p 0 131072` by a closed kernel decision. Derive once from `maskP_spec` that `M_p.testBit i = decide(i < 131072 and i % p = 0)`. The computed count must refer to the literal definition `M_p`, not to `maskP p 0 131072`. A theorem asserting equality does not automatically replace a computed definition during normalization.

4. **Balanced shifted OR specification.** Combine the leaves `(p,M_p)` using a balanced binary OR tree. For each leaf use `M_p >>> ((n+1) % p)`; an empty tree evaluates to zero. Prove by tree induction that, when `i + 70710 <= 131072`, the resulting bit equals `decide(exists p in B, p divides n+1+i)`. This is the proof of `orP_spec3` with its constants generalized and list induction replaced by tree induction. The only leaf facts required are `0 < p <= 70710` and the certified pattern bit formula. All positions used by a subcell satisfy this condition, because `i < W <= 32768` and `32768+70710 = 103478 < 131072`.

5. **Count soundness.** Define the new count expression mathematically as `pcL 7 ((2^W-1) XOR (shiftedOR(n) AND (2^W-1)))`. Under `70710 <= n`, `n+W < 5000045521`, and `W <= 32768`, prove equality to the cardinality of the primes in `Ioc n (n+W)`. Copy the mathematical argument of `cnt3_spec`, using the new OR and prime characterizations. Bits past `W` are zero; `pcL 7` therefore counts exactly the intended cell. For each supplied triple `(n,W,c)`, a separate closed kernel check proves that the count expression equals `c`, then the generic theorem exports the cardinality equality. No external classification hash is a premise.

6. **Subcell assembly.** A finite consecutive list of positive widths whose sum is `b-a`, with proven prime cardinalities `c_j` on its `Ioc` cells, gives prime cardinality `sum c_j` on `Ioc a b`. Prove this by disjoint interval union, or by an induction using an additive prime-count function. This is the only bridge from 125,271 subcell results to the 6,439 macro counts. It must check adjacency and both endpoints, not only the sum of widths.

7. **Theta interval update.** Suppose `InvT a L U`, `ell_a/S <= log a`, `log b <= u_b/S`, and the prime count on `Ioc a b` is `c`, with `0 < a <= b`. Then `InvT b (L+c*ell_a) (U+c*u_b)`. Use `thS_sub`, logarithm monotonicity, and the cardinality-times-constant bounds on a sum, as in `outerT3_spec`. This update uses only the left lower log and right upper log. All arithmetic states in the data are natural numbers at fixed scale `S=10^9`; there is no floating-point conversion or rounding in this recurrence.

8. **Checkpoint and interval coverage.** From the final natural-number comparisons `a*(S-S/10000) <= L` and `U <= a*(S+S/10000)`, obtain `abs(theta(a)-a) <= a/10000`. Prove that the concrete grid starts at `10^9`, ends at `5*10^9`, and has each successor `min(5*10^9,a+floor(a/4000))`. Finite induction and positive widths give coverage of every point, including the right endpoint. The interpolation theorem below then produces the finite psi envelope.

## Literal masks, cache semantics, and recursion

The `pats3` docstring says that the kernel builds patterns once per declaration. It does not promise that the normal form of each `maskP` call persists across 125,271 unrelated declaration checks. The pinned Lean 4.35.0 source `Lean/Elab/Tactic/Decide.lean`, lines 117–136, says that `decide +kernel` caches proved decision types per module and stores the resulting auxiliary proof in the environment. That supports reuse of already proved equations; it does not establish a global cache of arbitrary computed natural numbers.

The literal route makes the reuse explicit. One kernel-checked equality per mask proves its meaning. The mask value itself is a numeral in a reducible data definition. Later counts read that numeral; they do not need to reconstruct it from `maskP`. The equality proof and bit specification are opaque proof constants used only for soundness. Hex numerals are supported directly by the pinned parser, `Lean/Parser/Basic.lean` around lines 896–916. Numeric elaboration in `Lean/Elab/BuiltinTerm.lean`, around lines 209–233, uses a natural literal value. No string parser, native oracle, or custom trusted elaborator is required.

Partition the 7,004 leaves into 110 chunks of at most 64, with 28 leaves in the last chunk. Use a balanced tree within each chunk and a balanced tree over chunk results. The semantic proof can identify the tree's leaves with the complete base without flattening that list in the count evaluator. The combined OR depth is at most 13. This avoids the existing 7,004-deep list-recursion pattern; it does not guarantee any particular elaboration limit or runtime. Keep the existing `pcL 7` split into 256-bit leaves.

Each count theorem should be a closed `decide +kernel` check of one count value. A module may contain 128 such declarations, but it must not wrap all 128 expensive computations in one linearly recursive checker. Assembly uses the already exported cardinality theorems. A candidate organization would have 979 count modules. This is a packaging choice to test later, not a required theorem granularity. Similarly, 110 pattern modules can each contain up to 64 independently checked literal equalities. If default limits fail on a small representative sample, split the computation further and prove the composition. Do not add heartbeat or recursion-depth overrides. Do not copy the large overrides in the older sieve data files.

Retain the computed-pattern version only as a later measured comparison. It has smaller source data but can rebuild masks in each declaration. Literal masks remove that cost at the expense of substantial imported data. Storing every partial OR value would produce much larger certificates and is not part of this proposal. Cropping shifted patterns to the cell width before OR is an optional implementation experiment with a separate bitwise identity proof, not an assumed improvement.

## Exact data and proposed schema

The external inputs remain frozen. The full candidate report is `RESUME_PSI_FULL_CANDIDATE_2026-11-11.md`, SHA256 `466ABA0CBBBE9ED52C9FFB805336CBF7208AEF25DAD57C45FCA03CD9E8EACDDE`. Its final receipt is `psi_full_candidate_20261111/COMPLETE.json`, SHA256 `92770E969395E4817210366B3ECBDFF218768D800C923CA6E7944CF71DD73763`. The three earlier JSON datasets supply the first 538 windows; the 93 new batches supply the remaining 5,901. The independent full recount report is `../audit/RESUME_PSI_FULL_RECOUNT_REVIEW_2026-11-11.md`, SHA256 `F18029529E22892D2225C96DC36058BFC1DDB2D22E19082A0292A320DAE97FF1`.

A future untrusted generator should normalize this mixed historical JSON schema into these separate, small records:

| Record | Mathematical fields | Proof export |
| --- | --- | --- |
| Base chunk | integer range and literal prime list | exact filtered-list equality |
| Pattern | prime and hex natural literal | equality to `maskP p 0 131072` |
| Subcell | global cell index, `n`, `W`, `c` | exact prime cardinality on `Ioc n (n+W)` |
| Macro window | grid index, `a`, `b`, ordered subcell references, `c` | adjacency, endpoint equality, exact macro cardinality |
| Log endpoint | endpoint, lower numerator, upper numerator, denominator `10^9` | lower and upper real log inequalities |
| Theta checkpoint | endpoint, scaled lower and upper state | `InvT` and relative checkpoint bound |

Source hashes, byte hashes, receipts, and external timings belong in provenance metadata. They are not mathematical inputs and cannot substitute for any count proof. The generator must preserve `(n,n+W]`, especially at subcell and macro boundaries. The old ASCII prime-list hashes and new raw 0/1 classification hashes need no Lean model because all actual counts are recomputed from the complete base.

The source seed is exactly `SieveTab.stg2813.2.1`, `Prelim/PsiSieveMain.lean:28149`, at endpoint `10^9`. Its scaled theta bounds are `999967635190289132` and `999970323068320645`. The accompanying log bounds have numerators `20723265833` and `20723265841`. Keep the seed denominator `10^9`.

For each new endpoint `b`, kernel-check `Small.chkLow ell_b S b = true` and `Small.chkStep u_b S 1 b = true`. Apply `Small.le_log_of_chk`, `Prelim/SmallMertens.lean:45`, and `Small.log_lt_of_chk`, `Prelim/SmallPsi.lean:69`. There are 6,439 new endpoint boxes and 12,878 Boolean checks. The complete data's boxes were replayed against these exact Taylor expressions externally, but every new Lean check remains to be done. Their widths need not equal one unit at scale `10^9`; the validation allowed up to 100 units. Do not reintroduce the rejected claim that the source checker supports width `10^-9` everywhere.

The final theta state is `[4999882220821805278,4999930929840072558]/10^9`. A proof should derive this state from the seed and count equations, not accept it as an input theorem. To avoid a 6,439-step recursive checker, stage theta assembly in bounded blocks, each importing the preceding endpoint theorem and exporting a theorem covering all its internal checkpoints. Later coverage composition should use these theorems without re-evaluating the sieve.

## Finite psi conclusion and dependencies

The source functions `Helfgott.psi` and `Helfgott.theta` have natural-number arguments. For real interpolation use the existing `psiR(v) = Helfgott.psi(floor v)`, defined in `Explicit/PsiSandwich.lean:82`, and the notation `thetaR(v) = thS(floor v)` only within this note. `Prelim/ThetaExplicit.lean:33` supplies `theta_eq` for identifying the natural theta sum, and `:42` supplies `psiR_nat`. No new real-wrapper definition is required for the implementation.

The reviewed P6 repair supplies `0 <= psi(t)-theta(t) < 1.4262*sqrt(t)` for the natural arguments used here. It is still a proof obligation, despite its independent paper audit. At real `v >= 10^9`, apply it to `floor v >= 10^9` and use `sqrt(floor v) <= sqrt(v)` to obtain `0 <= psiR(v)-thetaR(v) <= 17*v/360000`, using `sqrt(10^9)>31622`. For integer grid endpoints `a <= v <= b`, we have `a <= floor v <= b`. Theta monotonicity and the relative endpoint bounds therefore give, with no extra unit loss,

* `v-psiR(v) <= a*(1/4000+1/10000) = 7*a/20000`;
* `psiR(v)-v <= a*(1/4000+(1/10000+17/360000)*(4001/4000)) = 572053*a/1440000000`.

Both coefficients are strictly below `1/2300`. Since `a <= v` and `log(v) < 23` through `5*10^9`, the result is `abs(psiR(v)-v) < .01*v/log(v)` on the entire finite interval. Specializing to natural `v` and applying `psiR_nat` gives the requested integer envelope. The elementary exponential comparison `2.7^23 > 5*10^9`, together with `exp(1)>2.7`, proves the log bound. The seed itself satisfies the relaxed checkpoint condition. The prior failed `a/24000` enclosure is not used or altered.

Keep the proof dependency order acyclic:

1. Generic bit, base-prime, interval-cardinality, and tree-OR soundness.
2. Complete base certificates; independent literal-pattern certificates; a small aggregator proving the full tree specification.
3. Closed subcell count checks and their cardinality exports. Independently, endpoint log checks.
4. Macro cardinality assembly, then theta blocks starting from the existing `stg2813` seed.
5. Reviewed P6's actual proof, with its own finite and elementary producers. It must not import the new psi envelope that is about to consume it.
6. Relative checkpoint interpolation and the finite psi envelope. Its final statement has only the range premises, not a prime-list, count, spectral, or checkpoint assumption.
7. A separate analytic theorem above `5*10^9`, after its providers are genuinely proved, joins the finite result to the global envelope used by P1/P4/P5/P7.

Reuse existing proved source interfaces first. Any later effort to narrow broad imports is a separate dependency task. In particular, importing `PsiSieveMain` for the seed imports a large historical certificate chain; this note does not assume that its compiled artifacts are present or cheap to build.

## Structural workload and memory, without a Lean runtime prediction

`resume_psi_kernel_replay_sizing_20261111.py` reads the existing data and computes only lengths and counts. It does not build masks, generate Lean, or run a new sieve. Its companion JSON records:

| Quantity | Exact amount |
| --- | ---: |
| Raw pattern magnitudes, each rounded to whole bytes | 100,387,363 bytes |
| Fixed-width 16,384-byte storage upper bound for patterns | 114,753,536 bytes |
| Hex digits with leading zeros omitted | 200,771,450 characters |
| Syntactic one-pass base-leaf visits across all subcells | 877,398,084 |
| Syntactic one-pass outer chunk-result visits | 13,779,810 |
| Outer binary ORs, 109 per cell in a nonempty balanced tree | 13,654,539 |
| All binary ORs, 7,003 per cell in the full nonempty tree | 877,272,813 |
| Syntactic `pcL 7` 256-bit leaf occurrences | 16,034,688 |
| Prime bits over all subcells | 184,106,689 |
| All 32,768-bit cell masks, if unnecessarily materialized | 513,110,016 bytes |
| Subcells per macro window | 8 to 39 |

For a prime `p`, the literal pattern's exact bit length is `p*floor((131072-1)/p)+1`. The raw integer and text figures exclude object headers, expression nodes, parser buffers, proof terms, imported modules, and transient arithmetic allocations. They are not process-memory upper bounds. Refer to each pattern by a constant name so its numeral is not copied into every count declaration's syntax or theorem type. Imported data may still be loaded in every concurrently compiling process. Choose concurrency only after measuring actual memory for a representative check.

One traversal of the count expression performs a modulus and shift at each base leaf and an OR at each internal node. A nonempty tree with 110 chunk results has 109 outer OR nodes; the full tree with 7,004 leaves has 7,003 OR nodes. The 110-per-cell figure counts chunk-result visits, not OR operations.

These are syntactic one-pass counts, not bounds on dynamic kernel work. `pcL_succ` supplies its input to both the modulus and shift branches. Without an established reduction-sharing result or measurement, those branches may demand the composite OR input repeatedly. Literal definitions prevent regeneration of `maskP`; they do not by themselves prove memoization of the shifted OR result. The existing `pcL` logic avoids a linear 32,768-bit recursion, but its actual input evaluation, 256-bit leaf work, and theorem elaboration still require measurements. No external sieve time is being used to predict Lean time.

The next authorized implementation experiment should be small: prove the generic interfaces, certify a few literal masks including the smallest and largest base primes, then check one full-size subcell near each end of the range under default limits. Inspect the exact exported types and axiom dependencies. Only after that evidence should anyone generate the approximately 200.8 MB literal-mask source or all count modules. Standard kernel decisions and proofs should suffice mathematically; their resource feasibility has not yet been demonstrated.

The acceptance gate is an audit of the exact finite-envelope type and its transitive axioms. Permit only the standard axioms already used by the source; reject new axioms, sorryAx, native_decide trust, external checker assumptions, and unverified imported artifacts. No external JSON parser or hash comparison belongs in the proof's trusted base. The proposed generic contracts and all new closed decisions remain unproved until that audit succeeds.
