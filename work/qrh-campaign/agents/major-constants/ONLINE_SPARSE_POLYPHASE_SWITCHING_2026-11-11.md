# Online sparse-to-polyphase switching

2026-11-11. Conditional scheduling theorem for the same finite polynomial and fixed precision. No values, transforms, builds or source edits. This note does not estimate the number of successful sign queries or assign a runtime to arithmetic operations.

## 1. Scope and result

For one offset class ell/8, a deterministic policy achieves at most twice the cheaper of two fixed charged schedules: answer all requested points by local interpolation, or build one dense polyphase transform and retrieve its requested outputs. It retains all local work spent before switching. The policy checks the next local cost before paying it, so an unusually expensive first cache miss or kernel setup cannot cause an unbounded overshoot.

The comparison is for the same sequence of requested points, coefficient array, precision and mathematical acceptance contract. The online controller, deduplication and bookkeeping have an explicit additional cost. Cross-class sharing and memory eviction are not hidden inside the factor-two statement.

The predecessor is `SMALL_THETA_OFFGRID_ARITHMETIC_SCHEDULE_2026-11-11.md`, SHA 8B299BFBDB936C6B85E0AEE6A3D61B0104A2D40D9E604DA98E1E8A76AAD8A0B9. It supplies signed polyphase identities, the 340-term local schedule, complete conditional rounding allocations, and operation categories. Its arithmetic proof remains separately reviewable; the theorem here applies to any two correct fixed implementations satisfying the following cost assumptions.

## 2. Exact charged-cost model

Fix the conductor, tilt, admitted interval, N, coefficient centers, root conventions, offset class, precision and output kind. Output kind distinguishes a strict sign from a numerical Y value. Hold the underlying finite polynomial fixed throughout this instance.

After exact repeated-query deduplication, requests are x_1,...,x_q. The cache key must identify that entire instance and the exact target. A previous inconclusive sign result is also a reusable result at the SAME precision; it is not a successful sign and does not eliminate a later higher-precision request. Domain and phase provenance remain attached to every reused answer.

Let C be work truly common to both schedules, already performed or charged once. An adequate base transform belongs here only when both compared schedules actually use it. A baseline that avoids this base transform is a different comparator. Let K>=0 be the fixed price to build, retain and make queryable the dense transform, excluding per-query output costs. K includes its phase/root setup, length-N FFT, array allocation/initialization, transfer and retained output storage under the selected backend. Local caches are not presumed to reduce K.

For unique request i let d_i>=0 be the dense retrieval, output normalization, rounding and required sign/acceptance-check cost. Let l_i be the all-local incremental cost in the fixed request order. It includes:

* First-use local kernel construction/certification if not in C.
* The 340 products, 339 additions, named roundings and sample accesses.
* Normalization and storage of coarse samples not already in the local cache.
* Its own output and acceptance-check costs.

Thus repeated use of a coarse sample is charged once in the all-local schedule. The local cache is monotone and starts from the same declared initial state. The incremental prices l_i can be determined from the target's stencil and cache metadata before evaluating the local polynomial. The policy need not calculate an unused kernel or sample merely to learn its scheduled cost.

The essential condition is

    r_i = l_i - d_i >= 0.                                     (1)

This is a priced-schedule condition to check for the chosen backend, not a theorem that every conceivable local implementation is dearer per query. For the intended comparison, a 340-term dot product plus local cache misses is compared with one stored dense output plus its final normalization. All categories still have to be priced at their actual widths.

Write D_q=sum_i d_i and R_q=sum_i r_i. Then the fixed alternatives cost

    L_q = C + D_q + R_q,
    B_q = C + D_q + K,                                        (2)

for a nonempty request stream. For q=0 neither optional setup is performed. Equation (2) is exact for the declared schedules, including the local cache. If prices are only upper bounds, the result compares those upper-bound ledgers; subtracting them does not prove the same ratio for measured executions or for an independently optimized implementation.

## 3. Policy and proof

Maintain rental balance R=0 and a flag initially LOCAL. For each new request:

1. If DENSE, retrieve the dense answer at cost d_i.
2. If LOCAL, compute the next incremental scheduled r_i from metadata. If R+r_i>=K, build the dense array at cost K BEFORE performing this local request, switch permanently to DENSE, and answer it at cost d_i.
3. Otherwise perform the local request at cost l_i, update its cache, and set R:=R+r_i.

Take the immediate dense branch when K=0. An empty stream pays neither K nor local setup. Already cached answers are returned before these steps, at their separately charged lookup cost.

If the policy never buys, it duplicates the all-local execution and R_q<K. Its cost is exactly L_q=min(L_q,B_q).

If it first buys at request s, the preceding local cache is identical to the all-local cache. Therefore the predicted r_s is the true all-local increment. The policy has paid R_{s-1}<K and the trigger proves R_s>=K. Since future all-local r_i are nonnegative, R_q>=K. Dense is consequently the cheaper fixed alternative for this final request stream. The actual work, excluding controller cost, is

    C + sum_{i<s} l_i + K + sum_{i>=s} d_i
      = C + D_q + R_{s-1} + K
      <= C + D_q + 2K.                                       (3)

Combining the cases gives the sharper additive form

    ALG <= controller + C + D_q + 2 min(R_q,K)
        <= controller + 2 min(L_q,B_q).                       (4)

For K>0 the switched inequality in (3) is strict before rounding any external price representation. The mathematical model may use rational or common-denominator integer prices. The implementation must compare their exact scheduled values, not an unchecked floating-point estimate.

No future query distribution is used. The inequality holds after every finite prefix. It also holds when requests are chosen adaptively, provided the comparator is charged for the SAME realized requests. If different numerical error intervals would cause another algorithm to request different points, this theorem does not compare those different sign-search strategies or their final Turing success.

The constant two can be approached within this model by many small rentals whose total is just below K followed by one further request. This is a limitation of this deterministic policy and comparator model, not a lower bound on proving finite RH or on all possible query algorithms.

## 4. Concrete local-cache instantiation

For the 340-node T-normalized interpolation schedule, write

    l_i = Ldot_i + m_i S + W_i + 1_{i=1} A,

where m_i is the number of missing coarse samples in the stencil, 0<=m_i<=340; S charges each sample's normalization, rounding and insertion; W_i accounts for accesses and the query's output checks; A is any lazy class-specific kernel setup. If these costs vary by sample or width, replace m_i S by the exact sum. No upper estimate 340S may be subtracted as if it were a measured local cost when claiming comparison with the cache-aware all-local schedule.

The policy uses the actual missing-index set. If the first predicted local request costs more than the dense construction, it buys immediately and never pays A or its sample normalizations. If it switches later, every already normalized sample and local answer remains a sunk cost in (3), even if the dense route never uses it.

One simple deterministic controller uses bitsets for the N possible class outputs and N coarse sample indices. Initializing these costs 2 ceil(N/w) zero-word writes for a w-bit backend. Before each distinct local request, at most 340 sample-membership tests identify misses; after choosing local, at most 340 corresponding bit insertions occur. There are also output deduplication tests/inserts, stencil index calculations and exact price/balance arithmetic. The sample cache and answer values have their own storage. A sparse dictionary may avoid full bitset initialization but must replace these costs with its proved lookup/update schedule. No specific dictionary price is assumed here.

The `controller` term in (4) includes this decision/deduplication work, duplicate-answer returns and setup that is absent from the two fixed comparators. It must not disappear into an alleged arithmetic speedup. Duplicate queries do not increase R or trigger purchase; they only incur this lookup/return cost. The dense path may also normalize a requested output lazily and cache it once, so d_i is charged only for a unique request under this model.

## 5. Sharing, storage and changing precision

**Across offset classes.** If every class has declared independent prices and cache state, apply (4) to each and sum it. Common C and controller work are charged once, yielding a factor-two bound against the sum of the per-class fixed minima. This does not equal the optimum that can choose a shared padded transform, jointly share roots, or optimize all local sample normalizations across classes.

A rigorous simple implementation may start all classes with a fixed precomputed shared cache, include its actual cost in C, and then price each class's new normalizations privately. Actual deduplication of those new normalizations can only reduce the online work, but the resulting guarantee is still relative to that private-cache comparator. Alternatively freeze a deterministic cost allocation for shared setup before running. A claim against the fully shared offline optimum needs a new theorem: buying one class can change which coarse samples another class has available, so its counterfactual l_i is not automatically the same as the observed l_i.

**Memory.** K must buy a persistently queryable dense result. Retain all N raw outputs and normalize on demand, or retain fully normalized outputs with their extra setup cost. Streaming the transform and discarding unrequested outputs is insufficient for arbitrary future requests at d_i. External storage is allowed when its writes, reads and persistence are priced. If an array is evicted and later rebuilt, the one-purchase proof no longer applies. A policy can refuse additional dense classes when memory is exhausted, but its bound then holds only for the classes for which a persistent purchase remains admissible. Optimizing shared memory is outside (4).

**Precision.** A new required precision, coefficient array, tilt or admitted interval begins a new instance unless a separate reuse proof and incremental cost model is supplied. Summing (4) over such instances gives a bound against the sum of their fixed comparators, not against a clairvoyant evaluator that computed the final precision at the start. An inconclusive sign is preserved as inconclusive. Neither sparse nor dense evaluation guarantees the next refinement will resolve it.

**Raw-U alternative.** The newly proposed sign-only polynomial U=T/omega can instantiate the policy after its own arithmetic and error contract is accepted. Its larger raw operands, different scale-free output cost and time-gate allowance change l_i, d_i and K. The T-normalized values from the predecessor cannot be reused as raw-U prices at unchanged widths. The scheduler theorem needs no omega or analytic identity itself; correctness comes from whichever two evaluator contracts are actually selected.

## 6. Necessary limitations and exact tests

Condition (1) cannot simply be deleted. Let K=10, dense per-query costs be (1,20), and local costs be (11,1). The policy buys on the first request, costing 31. All-local costs 12, so 31>2*12. The second negative rental invalidates the proof that crossing K makes dense the cheaper final choice. Such a backend needs a different policy or a restricted comparator.

Likewise, allowing future K to fall after uncharged root generation, allowing unknown arbitrary eviction, or comparing different generated query streams invalidates the stated model. These are explicit boundaries, not presumed harmless constant costs.

The companion script tests 8184 abstract cache-aware streams, including overlaps, repeated queries, empty streams, lazy setup and large first misses. It checks 46427 exact assertions and records the negative-rental counterexample. No prime or Fourier data enters these tests. The general theorem is the prefix argument in section 3, not an inference from the tests.

Files and pins:

|File relative to `work/qrh-campaign/agents/major-constants`|SHA-256|
|---|---|
|SMALL_THETA_OFFGRID_ARITHMETIC_SCHEDULE_2026-11-11.md|8B299BFBDB936C6B85E0AEE6A3D61B0104A2D40D9E604DA98E1E8A76AAD8A0B9|
|online_polyphase_switching_20261111.py|B4DDCBF0D9B3A155C0D921D68B43DE3978CB4FD126CCB8FB9857219F13D01FBF|
|online_polyphase_switching_20261111.json|E23E7BB25C69DB258D79C057BC259C617C204216DD9439BE8A8FED0E13AEB92A|

The result supplies a conditional adaptive choice among fixed correct arithmetic schedules. A backend price model, an accepted evaluator contract, persistent storage and actual endpoint/completeness evidence are still required. No runtime or global proof-cost optimum is claimed.
