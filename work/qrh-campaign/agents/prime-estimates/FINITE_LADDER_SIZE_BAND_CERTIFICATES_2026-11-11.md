# Size-band truncation of supplied-root ladder certificates

2026-11-11. Paper/source research and integer metadata only. No candidate, primality test, modular residue, sieve, transform or analytic value was computed. No build, Lean declaration or frozen-file edit was made.

This gives a modest, deterministic reduction of the **checked arithmetic trace** for an existing supplied-root ladder. It requires no new primes or favorable gap distribution. A producer already performing the 44-square Proth test can retain a later intermediate state; small candidates then need fewer checked squares. At most 45 increasing size bands avoid a per-record exponent field. The principal comparison is against the accepted direct supplied-root format, not the compact small-base format.

The reduction is not a new global optimum or a claim of substantial runtime savings. In the hypothetical maximum-step geometry its square-call saving is about one percent; actual bit-cost savings need the width-weighted sum below. It is useful precisely because it does not depend on a new prime-availability assumption. The expensive binary prefix, unsuccessful searches and the actual coverage chain remain unchanged.

## Existing contracts and the new distinction

The accepted `FINITE_GOLDBACH_GLOBAL_COST_FRONTIER` already optimizes the binary cutoff and selected path in a fixed certified pool. `EFFICIENCY_ADAPTIVE_PRIME_CHAIN` already admits supplied order roots and varying candidate formats. `SUPPLIED_ROOT_PRODUCTION_PAYLOAD` already avoids recomputing a successful root by retaining a state during the native test. None of those credits the size-dependent truncation, its forced early-region savings, or a sorted-band proof avoiding per-record exponent tags. Those are the additions here.

Use N0=989*10^24, T=N0-1, and an even B>=4. The finite reduction still requires a proved binary theorem on every even integer in [4,B] and an increasing certified odd-prime chain

    p0=3<p1<...<pK<=T-4,
    p_i-p_(i-1)<=B-2,             pK+B>=T.                  (1)

Each prime covers odd targets [p_i+4,p_i+B]; the next interval starts no later than the next odd number after its predecessor ends. Thus all odd 7<=n<=T are covered, with even remainder in [4,B]. N0 and above remain the analytic branch. No new binary theorem is asserted. In particular a smaller B does not prove the original `BinaryGoldbachInput` through 4*10^18.

The same selected path, order, gaps, first point, terminal test, primality witnesses and source binding are retained. Only the exponent and initial state of each **supplied-root** primality proof change. General or smooth-F certificates may remain alongside it; the universal counts below are for the all-fixed-root comparison, not an assumption that all actual selected primes will have that format.

## Parameterized prime criterion

For every natural m, odd integer p>1 and natural y, the conditions

    p < (2^(m+1)+1)^2,          p divides y^(2^m)+1          (2)

imply p is prime. This is the proof of `Ladder/Spec.lean:38` with the exponent parameter exposed. The actual pinned Mathlib `Nat.pow_pow_add_primeFactors_one_lt` at `NumberTheory/Fermat.lean:154` already has a general natural n, not the literal 44.

To see (2), if p were composite, let r be its least prime factor. Then r is odd and r^2<=p. The source lemma applied to r shows r=k*2^(m+1)+1. Since r>1, k>=1, so r^2>p by the strict size guard, a contradiction. The m=0 case is valid too: odd p<9 is prime. No coprimality, lattice-shape or CRT premise is missing. A successful congruence forces the needed unit/order facts.

For every consumed p<N0 define

    e(p)=min{m>=0 : p<(2^(m+1)+1)^2}.                       (3)

It satisfies e(p)<=44. The boundary is strict: p equal to (2^j+1)^2 may not use m=j-1. This matters even when a valid prime will never equal that odd composite square: the checker must reject malformed candidate records without first assuming their primality.

## Reuse the producer's trace, omit its prefix from the proof

The old direct format supplies x and checks x^(2^44)=-1 modulo p. Let s=44-e(p). During that same successful test retain

    y=x^(2^s) modulo p.

The remaining e(p) squares show y^(2^e(p))=-1 modulo p. Supply only y in the new certificate. Its canonical residue lies in [0,p), just like x. Thus the old and new raw root-field capacity is identical.

Crucially, the checker need **not** prove y=x^(2^s). It consumes the sufficient criterion (2), whose arbitrary y is independently checked by the shorter suffix. The discarded prefix is a generation method, not an unproved new hypothesis. No root search is added: if the old root passes, the retained suffix root passes for the identical p. Production performs the same old modular test and retains one chosen state instead of its start; p and its band are known before that test. Failed candidates still incur all operations actually performed.

This retention requires a producer exposing its square sequence; an opaque powMod returning only a Boolean does not expose it automatically. If an old file contains only x, converting it requires s extra modular squares per record unless an old trace is available. Conversion is therefore not free retrospective savings. No such conversion was performed here.

This is also **not** a free reduction of the indexed-small-base format. Starting from a compact base a and exponent k, obtaining y=a^(k*2^s) costs the omitted squares unless y is supplied or another proved schedule saves them. Compare the full root payload and generation costs before replacing compact bases.

## Sorted bands, binding and endpoints

Put A_j=(2^j+1)^2 for j=1,...,45. The bands for e(p) are p<A_1 and A_m<=p<A_(m+1) for m>=1. Since the chain is increasing, band numbers are nondecreasing. At most 45 nonempty runs occur.

A wire format can store up to 44 cumulative band endpoints in [0,K], followed by the roots in the original path order. Repeated endpoints mean empty bands. Check that endpoints are ordered and end at K, and that all root and candidate arrays have exactly K entries. The existing increasing-chain proof then lets the verifier check the **last** candidate of each nonempty band against its upper A_j; every earlier candidate in that run inherits the bound. Lower band bounds are unnecessary for soundness. Choosing minimal e is the producer's optimization, not a condition for accepting a valid longer proof.

Hence there are at most 45 additional fixed-threshold comparisons, not K exponent tags or K independent size searches. The raw header reserve is at most 44*bitlength(K) bits for K>=1. Actual decoded lengths, including a short final shard, must be bound to the same candidate/root objects as the modular tests. An ordinary-MM0 theorem import must carry checked context; hashes alone cannot bind these arrays. Lean proof reduction must likewise refer to those exact objects, not a second unproved copy.

The existing coverage verification is not dropped: all adjacent gaps and positivity/increasingness still have to follow from the checked decoder or be checked explicitly. This avoids circularly using primality to establish ordering before applying (2). Across shards, retain exact predecessor equality, the first gap, and the final pK+B>=T test. A shard crossing a size boundary can carry its local band runs. Global ordered endpoints can also be proved first and reused; either design must charge its proof context and serialized data.

## A forced count of saved square calls

For a particular supplied-root path the exact direct-format saving is

    S(path)=sum_i(44-e(p_i))
           =sum_(j=1)^44 #{i>=1:p_i<A_j}.                  (4)

This is an identity, not a density estimate. Suppose pK>=A_44, as is forced by (1) for every B row below. Set D=B-2. At the first index l with p_l>=A_j, the gap bound gives p_l<=3+lD. Thus l>=ceil((A_j-3)/D), and there are l-1 earlier new records. Consequently

    S(path)>=sum_(j=1)^44 max(0,ceil((A_j-3)/D)-1).         (5)

This lower bound applies to any complete path whose new records use the old fixed-root format. For a mixed-format path, use only its actual eligible records in (4); do not charge general/smooth certificates as saved Proth squares.

The old geometric lower bound is Kmin=ceil((T-B-3)/(B-2)) for these rows. On the hypothetical integer sequence p_i=3+iD, i=1,...,Kmin, the counts in (5) are exact and (1) holds as interval geometry. These labels are not asserted prime. In particular S/(44Kmin) is a schedule sensitivity, **not** a guaranteed fraction of actual total work: K can exceed Kmin, widths vary, and noneligible records may occur.

| B | Kmin | Forced saved square calls in the all-fixed-root comparison | Header bits at Kmin |
|---:|---:|---:|---:|
|10^15|989000000000|412646679750|1760|
|2*10^15|494500000000|206323339870|1716|
|10^16|98900000000|41264667966|1628|
|2*10^16|49450000000|20632333978|1584|
|10^17|9890000000|4126466788|1496|
|2*10^17|4945000000|2063233391|1452|
|4*10^18|247250000|103161663|1232|

Most high-range candidates still require 44 squares. This cannot eliminate the dominant finite-chain scale. It does remove many full modular proof steps without asking for extra primes, changing B, or changing the candidate pool.

## Charged direct and product-batch models

For direct roots, write Csq_S(w) for the complete standard-axioms proof production/checking cost of one modular square at width w in system S. It includes multiplication, quotient/remainder or reduction evidence, range checks, and term handling. A precise symbolic saving is

    sum_i (44-e(p_i))*Csq_S(bitlength p_i)
       minus generic-criterion library cost
       minus band/header/array-binding costs
       minus any net retained-state and I/O cost.          (6)

The modular suffix itself is identical to part of the old test, so the comparison need not assume equal costs for unrelated arithmetic. At a fixed radix, the accepted ordinary-PA square/reduction templates can instantiate Csq; their actual proof bytes and checking time are not known from square counts. Lean kernel arithmetic is a different cost function. The generic lemma is proved once; it cannot be inserted as an axiom. The retained root is the same width, so no new per-record root field is charged. Same actual-width encodings from earlier papers remain usable; their savings are not counted again here.

For a product batch M, choose m sufficient for the largest candidate factor, retain local suffix roots for that m, and CRT them. Then m checked squares modulo M suffice, with each factor inheriting the same strict bound. The product must still bind to all those candidate factors. Deduplicate intended primes or handle repeated prime powers before asserting a CRT production method; actual successful product congruence remains the acceptance test.

If fixed q-sized batches are cut at the at most 44 band boundaries, the number of batches increases by at most 44. The total product-tree, CRT, framing and root-field rounding costs must be recomputed at the resulting actual sizes. They are not assumed zero or automatically smaller. Existing unsplit batches can instead use the maximum exponent among their factors and avoid the extra batches, sacrificing some saving. A new CRT is unnecessary when the producer builds its original batch from retained local roots; converting an already stored common root requires powering that root or reconstructing it and incurs extra work.

For an unsplit actual batch b with modulus width wb, the square component saving is (44-max_i e(p_i))*Csq_S(wb). This and the direct formula are the concrete break-even tests. Neither implies that wide-product batching beats direct roots or that an ordinary-MM0 modular operation is a native instruction.

## What was rejected and what remains

I also considered certifying binary Goldbach only on a translated even interval [A,B]. It advances a prime chain by B-A+2 and needs a separate initial ternary prefix. Without an independently cheaper certificate for that translated range, this merely reparameterizes the old width tradeoff and may enlarge source-prime work. No saving is credited. The already-rejected arbitrary sparse prime-basis and universal anchor-template assumptions are not revived.

The new size-band method has a narrower but defensible benefit: it shortens an actual sufficient primality proof while preserving all finite coverage. It does not solve prime discovery, guarantee a small cutoff, or provide an order-of-magnitude reduction. A future bounded same-input implementation comparison should charge one generic criterion proof, the exact band decoder, suffix modular proofs and complete I/O against the existing 44-square format. No run is authorized or performed by this report.

## Pins and exact checks

The companion `proth_size_band_metadata_20261111.py` has SHA256 `A7B4BCFE1426A651FC37BB5CB010E29E63DA6CA3F7D40AB2A820B51DDBDE02F4`; its receipt has SHA256 `E013872F1D68BF17E391F041CD289CB674CBF8A4AB7344AA6C77ED8E68B63781`. It checks seven geometry rows, the count identity in (4), and 132 strict-boundary cases. Only integer powers, arithmetic, arrays and a rational sensitivity ratio are evaluated. No candidate is tested for primality and no modular powers are evaluated.

| Input | SHA256 |
|---|---|
| `prime-estimates/FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md` | `F950F36C3361A4BABB253B502168B613893DB5DCD002599A7BC261A950A16FC6` |
| `major-constants/EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md` | `77ADA365011EA6069D3D2F8131950AD65ECAD285400BBD5C307C7444F0093785` |
| `prime-estimates/SUPPLIED_ROOT_PRODUCTION_PAYLOAD_2026-11-11.md` | `EA13551BB8A8C572F983A26EC57E4F3FCD3E658F86DCE8252BABF70002814044` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| pinned Mathlib `Mathlib/NumberTheory/Fermat.lean` | `6A20F4E26D0345801E5CD7286CCA8A0A05130FFEAD8BDF4F501D09A2B4FD97A5` |

The first three paths are relative to `work/qrh-campaign/agents`. The pinned Mathlib checkout is `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`. Source inspection establishes the mathematical route, not compatibility or kernel validation of a new parameterized wrapper.
