# Joint binary cutoff, block length and anchor-span frontier

2026-11-11. Paper cost model and exact integer/rational checks only. No new primes, coverage instances, Lean/MM0 builds or analytic evaluations. This is separate from the frozen `EFFICIENCY_BINARY_COVERAGE_2026-11-11.md` (SHA256 `EEED5871CE2A7737F01D92CDBC0D362BA42307FF58D0A1192892989C4FBF8436`).

The useful decision is not “make B smaller” or “make L larger.” It is whether the complete binary saving exceeds the additional *certified* ladder work. The surface below can be populated separately for Lean and MM0. It neither imports historical headline forecasts nor assigns native arithmetic costs to ordinary MM0 proof steps.

## 1. Exact finite accounting

Fix the unchanged analytic threshold N=10^27 and a chosen analytic route. Its proof/library/certificate cost is common to the alternatives in this note and cancels in their comparison. It remains in the final end-to-end total. A route or N change requires restoring that term; it is not free here.

Let B be even, E=B/2, 2<=L<=E, and D the permitted source offset. An anchor layout policy pi determines which genuine primes are sought, their offsets, which subsets are consumed by each tile, and the fallback policy. It is not a claim that those searches succeed. Put

    R(B,L)=floor(E/L),
    w_r=min(L,E-rL+1),
    Q_outer=sum_r w_r=E-L+1.

The initial range has L-2 targets; hence Q_outer+(L-2)=E-1. The final block has width one when L divides E. Every policy must preserve these counts and the exact source-prime/anchor interpretation in the frozen coverage note.

For a proof system S, define nonoverlapping **generation plus verification** costs as follows. Retain their G and V components separately in measurements.

| Symbol | Work included |
|---|---|
| F_S | One-time additional library and checker build for this architecture, not already in the common analytic library |
| S_S(L,D) | Complete source-prime proof, bootstrap, source data, required certified dilation and retained factor-cache establishment |
| I_S(L;pi) | Initial binary range, using the established source facts where applicable; no second charge for those facts |
| A_S(r,L,pi) | Anchor search including failures, factorization/certificates, anchor-polynomial preparation and local anchor metadata |
| C_S(r,tile,pi) | Coverage-plan generation and its complete check, including true source access, residual completeness, splits/packing and exceptional representations not counted in A |
| J_S | Parsing, immutable fact reuse, replication/import, output and full range composition not charged above |
| K_lambda, c_lambda | Number of certified ladder windows and complete mean cost per window under ladder policy lambda |

Then the exact accounting identity is

    Total_S = common_analytic_S + F_S + S_S + I_S
              + sum_r A_S(r,L,pi) + sum_tiles C_S(r,tile,pi)
              + J_S + K_lambda*c_lambda.

The last mean is an accounting definition, not a uniform cost bound. For pre-run decisions use explicit operation bounds or conditional estimates. A source pass repeated on multiple batches, a prime proof rechecked in fresh independent workers, or an independent final replay must be included in S,J or V, once in the chosen convention. A serialized witness is not a substitute for C. Missing exceptional witnesses prevent completion.

This formula is already a usable break-even surface: substitute the exact R,w_r,K and a component-cost vector for each candidate. It supports nonlinear source checking and nonuniform anchor/coverage tails. It does not require a prime-density model.

## 2. A low-dimensional surface for planning

For a locally fixed algorithm and bit-size regime, let alpha_S be complete mean outer-block anchor cost and beta_S be complete mean outer-target coverage cost. Their dependence on B,L,pi is suppressed only within that regime. The approximation is

    Binary_S(B,L,pi)
      = F_S+S_S(L,D)+I_S(L;pi)+alpha_S*R(B,L)
        + beta_S*(B/2-L+1)+J_S.

Replace the uniform means by row/tile histograms whenever available. In particular beta includes cover search, source extraction and exception processing, not just an OR opcode. Changing L changes source number sizes and can change beta and alpha. Changing B changes anchor word lengths and search difficulty. Neither coefficient is automatically constant.

Ignoring only the floor for a smooth local sensitivity calculation gives

    Binary_S ≈ H_S(L,pi)+a_S(L,pi)*B,
    a_S=(beta_S+alpha_S/L)/2,
    H_S=F_S+S_S+I_S-beta_S*(L-1)+J_S.

H may be negative as a bookkeeping intercept; this does not make actual setup work negative. For numerical selection use the original nonnegative-component formula and exact floor. There is no omitted initial-range cost: the subtraction merely separates the same binary workload into a slope and intercept.

## 3. When shrinking B loses to the ladder

For two complete candidates 0 and 1, with B_1<B_0, compute the actual modeled binary saving

    D_bin = Binary_S(B_0,L_0,pi_0)-Binary_S(B_1,L_1,pi_1).

The smaller cutoff wins precisely when

    K_1*c_1-K_0*c_0 < D_bin.                         (1)

This is the principal decision test. If D_bin<=0 and ladder work rises, shrinking B is dominated. If K_1*c_1 is already too large with zero fallbacks, no optimistic fallback rate can rescue that candidate under the stated costs.

For the mixed ladder in `HYBRID_LADDER_COST_FRONTIER_2026-11-11.md`, distinguish the ladder window width W_lad from binary tile width W. With F=2^45,

    S_lad=floor((B-2)/F)-(W_lad-1),
    g=S_lad*F,
    K=floor((N-5)/g).

Require S_lad>=W_lad, g>0, and S_lad*i<F for the relevant Proth candidates. The certified ordinary or fallback prime lies in the same closed window; `(S_lad+W_lad-1)F+2<=B` proves binary coverage. The supplied K is a conservative complete index schedule starting at one; do not silently replace it by N/B. The stride g changes in steps as B varies.

For fixed W_lad, write B-2=qF+r with 0<=r<F. Then

    B-g=2+r+(W_lad-1)F.

The loss of stride can be a material fraction of B near small cutoffs. In particular, with this fixed F and W_lad, S_lad>=W_lad requires `B>= (2W_lad-1)F+2`. Below that value this particular construction is inadmissible; another F/window/early-range construction is needed, not a lower extrapolated cost.

Let cP be a successful regular window's complete cost and cF a fallback window's complete cost **including its failed regular search**. If fallback fraction f and cF>cP, then c=cP+f(cF-cP). Candidate 1 satisfies (1) only if

    f_1 < [D_bin+K_0*c_0-K_1*cP_1] / [K_1*(cF_1-cP_1)].  (2)

A negative numerator rejects even f_1=0. A right side above one makes the fallback fraction nonbinding within this cost model. Otherwise actual production must supply every window, and its total fallback work must satisfy the budget. A small sample estimates a planning parameter; it cannot prove global existence or a universal fallback bound.

For intuition only, freeze H,a, per-rung c and effective stride ratio kappa=g/B. Then

    Total ≈ H+aB+cN/(kappa*B).

The continuous balance is B_*^2=cN/(kappa*a). If B shrinks by a factor s>1 while these parameters stay fixed, the change improves cost exactly when

    old_ladder_cost / old_variable_binary_cost < 1/s.

Thus even a seemingly small ladder fraction can dominate a large shrink. This local result does not apply across changed windows or source architectures without recomputing a,H,kappa,c.

An exact-count illustration uses the existing ladder rows, same c, and purely linear binary cost with setup unchanged. Let q be old ladder cost divided by old variable binary cost, B_0=4e18 and K_0=254638308. Then the smaller candidate wins only if

    q < (1-B_1/B_0)/(K_1/K_0-1).

For B_1=1e16,K_1=181029996372, this bound lies strictly between 1/712 and 1/711. For B_1=2e16,K_1=90804183483, it lies strictly between 1/358 and 1/357. These are exact rational comparisons, not calibrated cost ratios. Source, initial-range, certificate-bit-size or fallback changes belong back in (1).

## 4. Choosing L jointly, not after fixing an anchor headline

At fixed B, the ladder term cancels. A move from L_0 to L_1 is beneficial exactly when its extra source, initial-range, coverage and assembly costs are below its saved anchor costs. With constant alpha,beta only,

    Delta(F+S+J) + [I(L_1)-I(L_0)-beta*(L_1-L_0)]
      < alpha*[R(B,L_0)-R(B,L_1)].                    (3)

The bracket is the **initial-range excess over the outer coverage it replaces**. It is neither free nor automatically positive. If beta changes, use

    beta_1*(B/2-L_1+1)-beta_0*(B/2-L_0+1)

explicitly instead. Increasing L can lower R while increasing the masks or exceptional primes needed per target. The source proof may also change from resident to streamed, introducing extra passes or import costs.

For a conditional smooth model with source/initial excess `sigma*L^p`, constant beta and alpha, minimize

    sigma*L^p + alpha*B/(2L) + beta*B/2.

Its interior balance is

    L_*^(p+1)=alpha*B/(2p*sigma).

Thus a linear marginal source model gives L_* proportional to sqrt(B), while a dense prime-by-chunk envelope behaving like L^(3/2) gives L_* proportional to B^(2/5). The latter is a model of one conservative implementation envelope, not an asymptotic lower bound for source certification. After optimizing L, these two terms scale as B^(p/(p+1)); the coverage term remains linear if beta is fixed. Consequently shrinking B while retaining a formerly optimal large L can waste setup and initial-range work. Enforce L<=B/2, memory constraints and the discrete admissible layouts after this calculation.

The existing source design supplies concrete algorithms to fill sigma or replace it: a cached progression-mask proof and a word-memory sieve proof. They have different checked operation counts. The number of actual base primes and the cost of proof-state access are not captured by assigning one native marking time to both.

## 5. Anchor span is a third axis

For a consumed anchor subset, let u=min offsets, d=max offsets-u. The frozen span-normalized test uses source `[a+u,a+u+d+W)` and product size bounded by k(W+2d). For the **same anchors**, normalization leaves their prime/search cost unchanged. It changes packed source extraction, cache keys and dilation reuse, which are charged in beta or J. It does not reduce the global source size L+D unless the permitted maximum offset D is itself reduced.

Distinguish two policies:

1. Normalize whatever covering subset the search already selected. This is an exact algebraic improvement with no additional existence condition. Cache losses may offset the smaller arithmetic input.
2. Force anchors into a narrow interval [u,u+d]. This may require more candidate tests, more anchors, or more exceptions; the same subset need not cover. It is a conditional search policy, not a consequence of normalization.

At fixed B,L, if a new policy increases complete anchor cost by Delta alpha and saves complete coverage cost gamma per outer target, it helps only when

    gamma*(B/2-L+1) > R*Delta alpha + Delta(F+S+I+J). (4)

For many full blocks and negligible setup difference, the per-target test is approximately gamma>Delta alpha/L. When a forcing policy lowers D, put its source saving into Delta S, but retain every halo/index proof and enlarged exception cost. For L>=2^32 and D=2^19, D/L<=1/8192: eliminating the whole D-halo saves at most 65536 raw source bytes at these fixed L. It can substantially shrink a local packed operand while barely changing the global bitmap. Those are different cost levers.

Clustered convolutions can choose a smaller radix and span per cluster, at the price of repeating target-width multiplication and changing residual representation. The exact cost is the sum of those cluster costs, including conversions. A maximum span alone is not enough to choose a policy: the necessary statistic is the joint distribution of consumed anchor count, span, and residual difficulty, not separate favorable averages.

## 6. Small measurements that would resolve the decision locally

Each row names one bounded future measurement or statistic. None is authorized by this note, and none proves success throughout the production range.

| Uncertainty in the surface | Single useful small measurement/statistic | Decision it informs |
|---|---|---|
| Marginal source cost in L | Paired complete source-chunk proofs for two candidate source bounds, including complete base-list provenance and checked lookup into one coverage tile | Delta S in (3); reject a larger L if source cost consumes saved anchors |
| Anchor alpha and dependence on span | Complete generation-and-checking cost for a fixed small cohort under ordinary versus forced narrow-span selection, recording all failed candidates and factor-cache dependencies | Delta alpha in (4); do not use successful prime certificates alone |
| Coverage beta | On one immutable prime fixture, a histogram of (selected count, actual span, residual word count by prefix) plus a complete leaf-and-parent check for each backend | Whether wide OR, normalized packing or the residual tree wins; includes cache and provenance |
| Cache penalty of min-offset normalization | Same selected anchor sets checked with common-origin packing and min-offset packing, charging source slice/dilation construction and reuse across several tiles | Whether the algebraic input reduction produces a complete cost reduction |
| Initial-range excess | One complete recursive initial-range pack at two neighboring L choices, reusing the same proved source prefixes | The bracket in (3); prevents shifting targets into an unpriced base case |
| Ladder fallback premium and regular batching | One complete mixed ladder block with at least one fallback and one index boundary, including failed ordinary search, proof generation and checking | cP,cF and the actual batching overhead in (2) |
| Fallback frequency | The fallback count and *total fallback work* in a prespecified small set of complete candidate windows | Planning f; rare hard cases still require an explicit production allowance, never a theorem from sampling |
| Repeated proof/import cost | One complete two-pack consumer sharing the same certified source and factor facts, compared with isolated consumers | J and whether source/prime proof reuse survives the intended toolchain |

Use source-reported measurements only within their original acceptance boundary. For ordinary MM0, the schematic arithmetic library must first become actual theorems; a new benchmark must end in the intended range statement. For a specialized admissible checker, include the reusable correctness build and concrete acceptance mechanism. For Lean, include kernel checking, elaboration and import rather than only a native library call. This keeps every point on the surface a complete architecture instead of a mixture of its fastest incompatible parts.

## 7. Practical selection rule

For each proof system, first keep a feasible baseline. Evaluate a small grid of B from the existing ladder frontier, L in {2^32,2^34,2^36} where admissible, and three anchor policies: unrestricted normalized subsets, a specified narrow-span policy, and a fixed clustered policy. Use exact integer rung/block counts. Fill component ranges rather than optimistic point guesses. Reject a candidate whose lower cost bound already exceeds the baseline upper bound. Keep overlapping ranges unresolved until the corresponding row of section 6 is measured.

The single most decisive near-term quantity is the ratio of **extra complete ladder work to the complete binary saving** in (1), after optimizing L and charging the real source implementation. If that ratio is already at least one with no fallbacks, further improvements to the fallback search cannot make the shrink competitive. If it is well below one, the joint anchor-span/residual histogram and complete source-chunk cost decide which binary implementation preserves the advantage. No present packet establishes these costs or permits a new total core-year claim.

Evidence: the frozen binary coverage note above; `work/qrh-blueprint/HYBRID_LADDER_COST_FRONTIER_2026-11-11.md`; `work/qrh-blueprint/BINARY_BLOCK_SCALING_2026-11-11.md`; and `work/qrh-campaign/agents/independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md`. A companion exact-rational script records their byte hashes and checks the displayed rung-ratio brackets and halo arithmetic. It performs no prime or function evaluations.
