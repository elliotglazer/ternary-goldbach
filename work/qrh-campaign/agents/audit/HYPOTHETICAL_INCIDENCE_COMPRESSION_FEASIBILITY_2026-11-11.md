# Hypothetical feasibility of exact-row incidence compression

2026-11-11. A planning diagnostic under explicitly hypothetical probability assumptions. No primes, source bits, incidence masks or anchor sets were evaluated or sampled. Only eight exact integer inequalities for two fixed rational dimension fixtures were checked. This is not a probabilistic premise in any Goldbach proof, a measured distribution, a production recommendation or a runtime estimate.

The diagnostic cautions against assigning a favorable small K to the accepted column design. A large palette can make nearly every source row inclusion-minimal; a small palette can instead leave empty rows. Even when every row has hits, the available prime anchors may be too few to cover them. These effects must be studied jointly. They do not invalidate a deterministic compiled certificate that actually passes its checked premises.

## 1. What the model assumes, and what it does not model

Let W>=1 rows H_t be subsets of an M-element palette, M>=1. Assume all W*M incidence entries are mutually independent Bernoulli variables with common rate 0<theta<1. This is an iid incidence-matrix proxy. It is stronger than merely assuming a single source bitmap has independent bits: the actual rows H_t={i:P[t0+t+s_i]=1} can share exactly the same source position across different t and i. The iid matrix model ignores those overlaps.

For a separate illustrative availability model, suppose each of the M anchors is available independently with rate eta, independently of the matrix. Then the number B of available anchors is Binomial(M,eta). Its expectation M*eta is not a count guarantee. Actual primality, wheels, congruences, source/anchor overlap, selected palettes and adaptive search can invalidate both independence assumptions and the constant rates. No rate here is claimed to estimate actual primes.

The accepted certificate still requires actual nonempty source rows as clauses and checked domination of every row. The model is used only to ask whether the favorable K/a region needed by a cost comparison looks robust under one deliberately simple proxy.

## 2. Exact clauses force the inclusion-minimal rows

For a deterministic nonempty family of rows, let K_* be the number of distinct inclusion-minimal rows. Every exact-row clause certificate that dominates all rows must include each such minimal row: a clause C contained in a minimal row H is itself a source row, hence C=H. Conversely all distinct minimal rows dominate the finite family. Therefore the smallest possible number of distinct exact-row clauses is precisely K_*.

If an empty row exists, no anchor set can cover that row; the nonempty-clause certificate fails rather than certifying a small successful K. If all rows are distinct and pairwise incomparable, K_*=W. A capped compiler can also abort before finding a compressible final family; its behavior is not assumed optimal here.

Put q=1-theta+theta^2. For different rows u,v, each coordinate forbids only the pair (1,0) when requiring H_u subset H_v. Independence gives

    P(H_u subset H_v)=q^M.                         (1)

This includes equality. Union over all ordered pairs gives

    P(any comparable distinct-index pair)
        <= W(W-1) q^M.                            (2)

For the weaker near-antichain statement, let Z count rows having some other row contained in them. Each row without such a witness is a unique minimal row, so K_*>=W-Z. The union bound and linearity give

    E[Z] <= W(W-1) q^M,
    E[K_*] >= W-W(W-1)q^M.

For 0<delta<1, Markov's inequality consequently gives

    P(K_* <= (1-delta)W)
        <= (W-1)q^M/delta.                         (3)

The bounds may be vacuous; they are not claims of compression when their right sides are large. For example, a desired model probability at least tau of K_*<=(1-delta)W requires

    M <= log((W-1)/(tau*delta)) / (-log q)

when W>1. This is a necessary condition derived from this bound, not a sufficient compression criterion. No logarithmic values are evaluated here.

The empty-row probability is s_M=(1-theta)^M. Row independence gives

    P(no empty row)=(1-s_M)^W <= exp(-W*s_M),
    P(any empty row) <= W*s_M.                    (4)

Thus increasing M helps avoid empty rows while also making subset relations rarer. A sufficient model condition for no empty row with probability at least 1-epsilon is W*(1-theta)^M<=epsilon. Neither this condition nor (3) says an available anchor set actually hits every row.

## 3. Coverage and adaptive selection must be separated

For a fixed a-element anchor set independent of the matrix, a target is uncovered with probability s_a=(1-theta)^a. The uncovered-target count is Binomial(W,s_a), so

    E[uncovered]=W*s_a,
    P(complete coverage)=(1-s_a)^W <= exp(-W*s_a),
    P(complete coverage) >= 1-W*s_a.              (5)

The lower bound may be negative and then gives no information. A small expected uncovered count supplies a sufficient high-probability condition by the union bound. A large expectation alone would not prove a low coverage probability in an arbitrary correlated model; the upper bound in (5) uses the row independence assumed here.

An anchor set chosen after inspecting rows does not satisfy the fixed-set calculation by itself. Union over all a-element choices gives the valid adaptive bound

    P(some a-element subset covers all rows)
        <= binom(M,a)*exp(-W*s_a).                 (6)

Coverage by any set of at most a can be extended to a set of exactly a when a<=M, so (6) also bounds that event. Conditional on an independent availability set of size b, replace M by b for adaptive choices among those anchors. If all available anchors are used, the exact conditional success probability is

    P(coverage | B=b)=[1-(1-theta)^b]^W.           (7)

It is incorrect to replace the random B in this expression by its mean M*eta. Unconditionally E[uncovered]=W*(1-theta*eta)^M, but target failures share the same availability set and are then correlated. This expectation is not a license to reuse the independent-target exponential upper bound with theta*eta.

These formulas give a conditional feasibility/compression region: actual availability must support enough anchors, coverage must pass, K must be small enough to amortize the dictionary/transpose, and reuse must pay all setup. None follows from the other three. All producer failures and unsuccessful palette attempts remain costs outside a successful final certificate.

## 4. Two exact rational fixtures, not sampled prime models

Both fixtures use W=2^18 and theta=1/16. The following integer inequalities were checked exactly:

    241^512 * 2^44 < 256^512,
    15^512 * 2^47 < 16^512,
    4*15^16 > 16^16,
    33^512 < 32^512 * 2^26.                       (8)

They require no floating, logarithm or exponential evaluator. The probability steps below use the elementary inequalities (1-x)^n<=exp(-nx) and exp(1)>2, valid from the exponential series/standard calculus, rather than computed transcendental values.

### Fixture A: M=512, eta=1/32

Here q=241/256. Equation (8) and W(W-1)<2^36 show that the chance of any comparable pair is below 2^-8. The chance of any empty row is below W*2^-47=2^-29. Therefore

    P(all rows nonempty, distinct and incomparable)
        > 1-2^-8-2^-29.

On that event every successful exact-row clause certificate needs K>=W=262144. Thus a much smaller K is highly atypical in this particular model; the earlier illustrative K1024 should not be silently coupled to W=262144 here.

The independent availability model has E[B]=512/32=16, but even adaptively chosen 64 anchors are unlikely to suffice. From (15/16)^16>1/4 we have (15/16)^64>1/256, hence W*s_64>1024. For each fixed 64-set its coverage probability is below exp(-1024)<2^-1024. There are at most 2^512 subsets, so

    P(any subset of at most 64 covers) < 2^-512.

Also E[2^B]=(33/32)^512<2^26. Markov's inequality gives P(B>=65)<2^-39. Coverage using all actual available anchors is contained in the union of these last two events, yielding

    P(available anchors cover all rows)
        < 2^-39 + 2^-512.

This handles adaptive choice among the available indices; it does not incorrectly assume a fixed choice of 16 anchors. It is still only a conclusion of the stated hypothetical model.

### Fixture B: M=64, with every anchor allowed if desired

The same exact inequality gives s_M=(15/16)^64>1/256 and W*s_M>1024. Thus

    P(no empty row) < exp(-1024) < 2^-1024.

An empty row blocks all anchor subsets, including the full palette. Reducing M in this fixture does not provide successful small-K compression; it overwhelmingly creates an impossible coverage problem for that palette. No availability assumption is needed for this conclusion.

The fixtures demonstrate two distinct planning failure modes, not an exhaustive optimal-M analysis, a search over parameters, or a theorem that no other model/structured palette is useful.

## 5. What this changes in the planning comparison

When K=W and the clauses are the distinct incomparable source rows, the transpose has no compression benefit. If clauses retain target-row order, its ith column is exactly

    V_i[t]=P[t0+t+s_i].

OR-ing the selected columns is then precisely the existing direct shifted-source-mask test. A different clause order gives a checked permutation, not fewer targets. It can still look much cheaper than scanning W clause rows against an M-bit availability mask, but direct coverage is the relevant competitor and already scans the a selected source shifts. The extra dictionary/transpose may then be unnecessary overhead. This does not exclude a different implementation advantage; it removes a false compression credit.

Accordingly keep the accepted column scheme as an optional representation behind its complete Direct/Row/Witness/Column cost guard. Do not prioritize it on an assumed small K or high reuse rate. A future favorable case needs deterministic actual-source clause and transpose certificates, certified anchors, full target/exception coverage, valid complete prices and enough genuine reuse to pay setup/imports. The required direct-fallback setup companion remains binding.

Conversely, failure of this iid model is not evidence against an actual deterministic certificate. Arithmetic structure, wheels and shared source positions may create useful dependencies or stronger obstructions. Deriving a faithful probabilistic model, discovering templates or measuring reuse would be new work; none is performed or authorized here. The stable conservative accounting retains the existing direct fallback and leaves all actual compression and success variables unknown. No final checking-time or core-hour estimate follows.

## Frozen evidence

All paths are relative to work/qrh-campaign/agents. The five hashes below were checked. The script performs only eight fixed integer/dimension assertions for the two fixtures; it generates no random sample or mask.

| Artifact | SHA256 |
|---|---|
| independent-feasibility/FINITE_BINARY_INCIDENCE_COLUMN_RECOMMENDATION_2026-11-11.md | 58551C27EEB2D8E80F9F5762B00D6406CA5723F14C2868391C84C102FB464B37 |
| independent-feasibility/CLARIFICATION_BINARY_COLUMN_FALLBACK_SETUP_2026-11-11.md | 6B6D38B57D0E18A940BF06C0496CBD7E65B4F16E750E490EDF5A9878095CB56C |
| audit/REVIEW_FINITE_BINARY_INCIDENCE_COLUMNS_2026-11-11.md | F091BEE4885CE1AEBCA9018E453703CED66DE6E02BFB214FF0ADF2077F9777A4 |
| audit/incidence_bernoulli_fixed_20261111.py | 155B6358A9E6AAFC354C24F23E0DE3B41552F3213E991570C0342008D16D32FE |
| audit/incidence_bernoulli_fixed_20261111.json | FA265E285927D27414F60D08D0EB9CC6E875CDC9C344F3D709C20D378E5B80A9 |
