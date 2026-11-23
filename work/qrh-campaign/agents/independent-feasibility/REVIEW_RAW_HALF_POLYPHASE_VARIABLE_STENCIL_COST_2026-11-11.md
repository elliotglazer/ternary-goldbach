# Review of raw half-polyphase versus variable-stencil costs

2026-11-11. PASS at conditional paper and saved-metadata scope, with the explicit common-result-format interpretation below. No author correction is required. This review binds `major-constants/RAW_HALF_POLYPHASE_VARIABLE_STENCIL_COST_2026-11-11.md`, SHA256 `4DF324E244610C99C7944E72DD2D02A7F525640044E80096CE62FB6F22BC5137`. Frozen files remain unchanged. No transforms, elementary or spectral values, prime searches, builds or source edits were performed.

## Same function and complete arithmetic contracts

I read the author report, script and receipt; the raw adaptive composition together with its required count erratum and independent review; and the online policy. The half-transform, row-specific applicability and online-policy proofs were already reviewed independently in this directory. This bounded join reuses those accepted proofs rather than rerunning them.

Both alternatives consume the same selected row's exact Hermitian polynomial U, actual character, fixed phase, theta, N and physical target domain. The raw sign radius is `109eps N Delta/704`. The half-polyphase route supplies a sample within eps/(64H), while the local route additionally pays its reviewed interpolation remainder, propagated sample error and kernel/arithmetic error. Both satisfy the same conservative final sign interface. Their centers can differ. A common realized query sequence is required for the cost comparison, not equal success at every queried point or equal eventual search trajectories.

The half route uses each row's own B and raw tolerance u_time(theta)/8. The local route uses its own order and v_raw allocation. No uniform-B numeric test replaces these row contracts. Finer source-coefficient grids remain relevant to the first phase products, while normalized later nodes use the gate grid. Exact output shifts enlarge the raw scale and may enlarge an integer representation. Thus matching sufficient error does not give equal operand widths or equal operation prices.

The raw adaptive report's +320 additions typo is correctly excluded by its frozen erratum. Its correct value is 2436206631058893. The local order, kernel proofs and sample dependency union remain bound to the selected family. No amplitude, argument, derivative or contour consumer is silently admitted under this sign-only contract. Both inverse-character channels and the actual count obligations remain.

## Typed schedules and metadata binding

For one occupied nonzero phase class, I independently reconstructed the following complete core counts, with Fm=F(N/2):

    products: Fm+2J;
    complex additions: 2Fm+2J;
    complex rounds: 3Fm+4J+1;
    exact butterfly halvings: 2Fm.

One J product block prepares phased coefficients and the other packs the half transform. The phase product rounds, both packed-sum rounds, packed-product rounds and C0 round all remain. Conjugations, quarter turns, zero filling, copies, source-grid conversions and root setup are separate categories. A direct packed implementation need not materialize a redundant full negative-frequency array; it must still charge the actual assignments it performs.

The local query has r real products, r-1 additions and 2r arithmetic rounds, plus r sample accesses. Quantizing shared weights is setup. Missing raw coarse samples are charged by their actual distinct-index set, bounded by min(N,rq), rather than assumed all different. A completed common base transform may cancel only when both compared schedules actually require and use that same admitted base computation. A base that has already run remains sunk work. It cannot be removed from one side merely because a different off-grid-only algorithm could avoid it.

The joined saved ledger is the selected sign-only minimal-theta JSON, not merely the older fixed-theta report. Its N128 geometry and its reviewed source/precision contracts supply S, F, Jsum and the primitive label count. Summing seven explicit class schedules reproduces all four author rows. The local order histograms independently reproduce products, additions, rounds and physical query counts. The number of physical eighth-grid queries is `7*(coarse-prefix requests-C)`; the seven transforms still compute 7S raw outputs. These two counts must not be interchanged.

The main row has 315177493507002 complex products, 613515133299642 complex additions and 928692756146400 complex rounds for the seven dense classes. It represents 12427893758063 physical requests but 64664487329792 potential raw output shifts/stores. All 18477108 primitive labels remain. The four extra-node scenarios are alternatives, not summands. None predicts the request set actually needed to close a count.

The real-product expansions are exact before the single charged complex round. Four products require two internal real additions; three products require five. Including the separate complex additions gives `mu G` real products and `alpha G+2A` real additions. The three-product schedule adds 376037530158283 real additions relative to the independent local schedule, while the four-product schedule removes 569494950362723. The product ratios therefore do not establish a total-cost ordering. Separate internal rounding would require another error proof. Expanded temporary widths and signed representations must be priced.

## Purchase model, persistence and break-even

The sufficient online model buys all N raw shifts/stores and persistent answers as part of K. Each local result is also stored before the common result read and strict comparison. This makes the remaining local rent a sum of nonnegative charged operations, so the accepted pre-crossing policy applies. It buys before paying the rent that crosses K, including a large first cache miss or lazy kernel setup. Previously spent local work stays in its bound.

The common read/check cost d_i presumes an identical priced result format and comparison schedule on both sides. Dense output exponent shifts and local rounds need not naturally produce that format. Any exact re-encoding, numerator padding, width extension or corresponding writes must be charged to K or to the local rent before calling the final read/check common. A common conservative format and fixed comparison schedule are a valid conditional implementation choice. This is not a proof that arbitrary existing encodings have equal read/check prices. The author confirmed this intended interpretation; no frozen mutation is needed.

Under that model, the policy theorem gives

    ALG <= controller+C+sum d_i+2 min(sum rents,K).

This compares the same realized requests against the two declared fixed schedules. Controller, exact price comparisons, deduplication and metadata work are additional. Kernel and root setup can be common only under a fixed, consistent allocation. Upper prices compare upper-price ledgers, not measured executions. An inconclusive cached result is not a successful sign. A precision or coefficient change requires a new instance or a separate reuse proof.

A normalized dense array with shifts on demand has different retrieval prices and must re-establish nonnegative rents. Discarding future answers or evicting purchased arrays invalidates the one-purchase premise unless rebuilds are charged under another theorem. External storage and reads can satisfy persistence if priced. Summing per-class results does not yield a factor-two guarantee against a globally optimized shared-root, shared-cache, padded-transform or memory-eviction strategy.

The product-only threshold is correctly a diagnostic. For N=262144 and r=182 its first strict integer is 19490 for three-product expansion and 25987 for four-product expansion. Actual break-even compares the full local rent with K, including setup, different widths, exact shifts, data movement and storage. A class may have fewer admissible requests than either threshold.

## Independent evidence and remaining scope

Owned script `independent-feasibility/review_raw_half_polyphase_join_20261111.py`, SHA256 `9488DEC83B5912E7661CB8FC32A1875DA2292BEDD8F24EF73D6B18AB25D2EC25`, and receipt `independent-feasibility/review_raw_half_polyphase_join_20261111.json`, SHA256 `7D4C3BC322E3B8F88C58245A775018FA89F459836040023CC48B1B793CAD9095`, pass 324 exact checks. The three author artifact pins and all twelve input pins match. The author program was read but not imported or executed.

The independent checks reconstruct all four joined rows from the selected ledger and saved order histograms, all typed seven-class categories, both exact real-operation expansions, strict rational ratio brackets, the corrected additions cell and every product-only threshold example. The kernel-pool count is independently `7*sum(182,184,...,260)=61880`. No conductor inventory, kernel values, root values or FFT was regenerated. The accepted component reviews remain the source of their respective analytic and finite-family facts.

This is a defensible selection interface among fixed conditional circuits. It is not a new main ledger, a mandatory full seven-class workload, a runtime forecast or proof of successful signs. Principal work, coefficient and root production, Gaussian/character stages, actual endpoint repairs, complete counts and ordinary-proof implementation costs remain required.
