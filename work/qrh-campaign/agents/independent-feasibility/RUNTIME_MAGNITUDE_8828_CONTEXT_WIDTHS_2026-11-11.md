# Runtime data capacities from the stored-input bound8828

2026-11-11. Separate future paper candidate, pending independent review. The current combined precision assignment and every frozen price baseline remain unchanged. This note contains fixed rational identities only, with no saved-inventory fold, assignment scan, value evaluation, build, declaration or proof emission.

The accepted stored-input margin can supply runtime capacities as well as error bounds. The normalized context proofs are valid for any augmented input bound V>=1. Under their unchanged safety and semantic peak guards, set V=8828 for runtime data. At an exact positive context factor f, the sufficient magnitude capacity becomes `p+ceil(log2(8828*f))`. Against the old `p+14+ceil(log2 f)` rule it saves either zero or one bit, never more. Whether a bit is saved depends on f before rounding. No frequency, price saving or production choice is established here.

## 1. Same input object and unchanged guards

The reviewed subgrid packet B7E78161 plus magnitude companion39EC80DD, independently reviewed8431B9FF, proves the following under its exact raw-input contract. The consumed polynomial center has norm below8192. The raw head center has norm below634. They are formed on grid100 and added exactly before the optional single regrid. For p80..108, with rho_p=1 below100 and0 otherwise, the resulting actual vector satisfies

    max_a |z'_a|+1 < 8827+rho_p*2^-p < 8828.             (1)

The actual source, head, assembly and converter obligations are retained. A radius alone does not identify the grid100 encoding. A different evaluator, extra assembly round or alternate head placement needs a compatible magnitude proof before (1) may be used. This candidate uses the same stored vector as the reviewed error proof. It does not regrid a second time or change its source radius.

Retain the local D guard, the old-axis `S_old*u<=1/2` guard, all root/cache/complex-gate contracts and the same selected precision p, with u=2^-p. In particular the normalized Bluestein semantic postchirp bound still needs `C_old*u<=1/2`; local D alone is insufficient. The p80 floor supplies u<1/3, while the old global bounds already cover every local safety condition. No sharper error C, tensor factor, cache adapter or new precision selection is assumed here.

## 2. Why the context bounds allow this V

Track `L+1<=aV`, where a>=1 is an exact context multiplier and V>=1 is the original input bound. All additive rounding allowances in the accepted proofs are absorbed through this augmented quantity. They do not require V to be16384 or a power of two.

For an approximate unit-root product with one final round, the output augmented magnitude is at most `(1+u)(L+1)`. A radix butterfly satisfies

    L_next+1 <= (2+u)(L+1).

The finite binomial bound under `2ku<=1` gives `(2+u)^j<=2^(j+1)` for j<=k. A direct r-point partial sum has augmented magnitude at most `r(1+u)(L+1)<=2r(L+1)`. For a computed length-n transform the semantic estimate gives

    |Dhat_n|+1 <= n(1+C_n*u)(L+1) <= (3/2)n*aV.          (2)

These are the existing recurrences with symbolic V. The root uncertainty, arithmetic rounding and cached-kernel uncertainty remain charged under their original proofs.

At a CT node n=rm, the first length-m children receive aV. Their semantic outputs followed by the cross twiddle give second-child input at most `2m*aV`, using `(1+u)*(1+C_m*u)<=2`. Therefore the child multiplier is exactly the same `2m`; it does not depend on V. The local bridge can conservatively use that factor too.

For outer axes in the original order, let v_before be the product of FULL preceding axis lengths. The incoming multiplier remains `a=2*v_before` under the same finite product bound. The retained-output prefix determines operation multiplicity, not this norm multiplier. Repeated axes and pruned outputs do not alter this distinction. Identity, signs, quarter turns and permutations preserve their appropriate input bound.

## 3. Exact selected runtime factors

Write a for the incoming exact multiplier at a node. In the table, f is the FULL multiplier of V, not its ceiling exponent. It is the same envelope as the accepted normalized structural fold, with V left symbolic.

|Runtime location|Selected exact multiplier f|
|---|---|
|Outer axis incoming context|2 times the full preceding-axis product|
|First CT child|a|
|Second CT child and conservative local bridge|2m*a|
|Ordinary radix stage j root operand, one-based|2^j*a|
|Ordinary radix stage j addition envelope|2^(j+1)*a|
|Direct r-point leaf envelope|2r*a|
|Pruned length-two addition envelope|4a|
|Bluestein prechirp envelope|2a|
|Bluestein data forward radix input context|2a, followed by the ordinary radix factors|
|Bluestein point-product data operand|(n+2)a|
|Normalized inverse input|Z_s*a, where Z_s=n(2n-1)/P+2|
|Normalized inverse stage j root operand, one-based|2^j*Z_s*a|
|Normalized inverse stage j addition envelope|2^(j+1)*Z_s*a|
|Normalized postchirp envelope|2n*a|

Here P is the same least power of two at least2n-1. The point-product augmented output bound `Z_s*aV` follows from the original normalized-kernel error proof: the ideal point term is bounded by `n(2n-1)/P` times aV, the permitted point error is at most aV, and the additional1 is absorbed by aV>=1. The inverse starts from that bound. Its exact stage-j input is bounded by `(2+u)^(j-1) Z_s*aV`, hence the stated root-operand envelope; its addition/output envelope is one further power of two. A root operand key need not bound the rounded product output, because the multiplication template separately bounds that product.

The postchirp key covers the selected inverse output and final chirp under the retained semantic guard. Its proof uses a bound on the selected inverse output, not an assumed small internal inverse FFT. Runtime inverse division remains absent in the normalized-cache variant.

All Z_s products must remain rational through multiplication by a and8828 before the final capacity ceiling. Replacing Z_s by a rounded power first is safe but can lose the proposed bit. This note does not sharpen the chosen envelopes, alter phase schedules or re-count operations.

## 4. Capacity comparison and exact one-bit criterion

Suppose the relevant stored operand satisfies `|z|+1<=fV` and is on grid2^-p. Its coordinate numerator has absolute value strictly less than `2^p*fV`. Thus

    w_new = p+ceil(log2(8828*f))                         (3)

is a sufficient magnitude-bit capacity. A signed representation separately needs its sign and canonical-zero rules. This proof applies at equality of the capacity threshold too, because the numerator inequality is strict.

Let `k=ceil(log2 f)`. Then `2^(k-1)<f<=2^k`. Since

    2^13 < 8828 < 2^14,

we have `2^(k+12)<8828*f<2^(k+14)`. Consequently its ceiling logarithm is either k+13 or k+14. The old rule is exactly `w_old=p+k+14`, and

    w_old-w_new is0 or1,
    w_old-w_new=1 iff 8828*f<=2^(k+13),
                         iff f/2^k<=2048/2207.           (4)

Exact powers of two give no bit reduction. As abstract rational examples, f=3/2 and f=2 both have k=1. The former gives integer-part exponent14, while the latter gives15; the old rule gives15 to both. Therefore a saved ceiling exponent alone does not determine the new capacity. Multiplying its upper envelope2^k by8828 always yields k+14, a conservative no-saving fallback. One must not subtract a bit unconditionally or reconstruct f by treating a rounded exponent as an exact factor.

The statement concerns sufficient envelope capacities at fixed p. A byte count drops only when the resulting bit boundary crosses a byte boundary. It proves neither that every operand shrinks nor that the new envelope is an actual-value minimum.

## 5. Raw arithmetic and unchanged coefficients

Let a_bits denote the newly proved DATA magnitude capacity from (3), distinct from the context multiplier a. Keep the coefficient magnitude capacity b_bits from its own contract: p+1 for approximate unit roots, p for the rounded normalized Bluestein coefficient of norm below one. The two exact REAL sums of those coefficient centers keep their existing extra bit. Neither they nor root-generation inputs depend on V_runtime.

Before accepting a multiplication or round, range-check its supplied operand encodings. Then a data presum needs a_bits+1, a coefficient presum needs b_bits+1, and the fixed three-product scheme uses shapes `(a_bits+1,b_bits)` and twice `(a_bits,b_bits+1)`. Generic exact output-combination capacity remains `r3=a_bits+b_bits+2`; the four-product scheme uses `r4=a_bits+b_bits+1`. The signed dyadic witness additions retain magnitude capacity r3+2 or r4+2. Exact standalone complex additions retain the chosen input-envelope plus one-bit sum allowance. No cancellation of a verified residual is used to shrink these pre-acceptance temporaries.

Each supplied output or quotient must also satisfy an independent bounded encoding before its witness arithmetic is read. A semantic bound on an accepted output is not permission to allocate an unchecked witness as if its equality were already true. Once a gate is accepted, its stated augmented output bound supplies the next stage's operand contract. All shifts, sign/zero bridges, ranges, exact cache-sum bindings and ordinary theorem applications remain paid.

Where an operand capacity loses one bit, dependent generic presums/products may lose that bit under these same formulas. A later stage has its own factor and may lose none. Coefficient-only arithmetic is unchanged. In particular the full kernel FFT used for cache construction has its own unit-input bound and is not repriced by replacing an unrelated V16384 with8828. Scaled-cache rounds, root/chirp construction, exact coefficient sums and their lifetimes remain the existing setup objects and costs at the same p.

At fixed p and the same centers, this is a representation-capacity proof, not a different rounding circuit. It transfers no source/sign evidence that was not already supplied. Any narrower serialized implementation still needs the ordinary encoding and proof interfaces.

## 6. Metadata needed for a future comparison

The present width-key exponent is insufficient. A future separately authorized saved-metadata pass needs the exact incoming multiplier, original axis order/full prefix, CT child norm factors, phase/node identity, n/P and radix-stage index, coefficient type/grid and selected p. It must distinguish root DATA INPUT factors from addition/output envelopes. For normalized inverse stages it must reconstruct Z_s as an exact rational before applying (3). Operation multiplicities and old/guard/band weights remain attached to the same source contexts.

It could retain exact factors as reduced numerator/denominator pairs, or retain sufficient provenance to reconstruct them. This note specifies neither a new inventory nor resource caps and reads no saved rows. A future fold must reproduce its matched old baseline first and preserve all current counts, setup and omitted-cost categories. The generic proof supplies no histogram or saving percentage.

No current assignment, cache selection, comparator or price preflight is modified. This candidate can be evaluated later only with independent mathematical review and a separately approved exact-factor fold. It cannot be credited alongside another width saving without a common per-event capacity calculation.

## 7. Fixed evidence

Owned script `runtime_magnitude_8828_20261111.py`, SHA256 `08394E07E6CDDB1B1B9A4F4E53B4849F05879AB868923AEACFAD186162B547DF`, checks327 fixed assertions. It hashes ten source papers/source files, checks the rational threshold on ten abstract factors and the selected formulas for three abstract Bluestein fixtures, and checks fixed raw-width identities. It imports no writer and reads no inventory or numerical value. Its first run produced the3225-byte exclusive receipt `runtime_magnitude_8828_20261111.json`, SHA256 `020C3758B08F50163891FFF0F161DEC668B2FE24D96BD9CAB322A259B2C77935`.

The principal source pins are listed below. All ten complete pins are in the script/receipt, including the source-only schema writer584A16F0 and arithmetic modelDAEA8130. The writer was inspected for its factor/phase definitions and was not executed.

|Source relative to agents|SHA256|
|---|---|
|independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md|B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266|
|independent-feasibility/SUBGRID100_ERROR_MAGNITUDE_COMPANION_2026-11-11.md|39EC80DDC3388A9E470647CC4486D448108BB1FFD0D4CC58C13B61FBE3A4A761|
|audit/REVIEW_SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md|8431B9FF6B172F8ED36644413C359F5B8E2FEB58D9EBF0F88E500F152113EBAD|
|independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md|5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A|
|independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md|FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9|
|independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md|412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7|
|integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md|09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA|
|independent-feasibility/NORMALIZED_BLUESTEIN_STRUCTURAL_COST_FOLD_2026-11-11.md|F673EFE298538627F30DEAFD2C7F5AFF9606BA468D887A76677E14FF5C963B46|

The quantified recurrence and ceiling arguments are the paper proof. Fixed checks are supplementary evidence, not a compiled theorem or proof of actual spectral inputs. This task stops before any metadata or pricing adoption.
