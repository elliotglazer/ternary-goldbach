# Context keys for normalized-kernel width pricing

2026-11-11. This is a narrow supplement to `BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md`, SHA256 `FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9`. It supplies explicit local norm factors for a future saved-manifest cost fold. The author packet remains unchanged and pending independent review. No new inventory, values, builds or arithmetic execution is supplied here.

Let an occurrence receive stored inputs with augmented norm at most aV, where a>=1 and V>=1 are the outer-context quantities. Retain n, P=2^k, m=2n-1, u=2^-p and Z_s=nm/P+2 from the author. All factors below multiply aV unless explicitly marked as a coefficient bound. The peak/output statements retain both the old local safety and C_old*u<=1/2, supplied by the inherited global S condition.

|Location|Sufficient augmented stored-center bound|
|---|---|
|Data forward output feeding the point product|(n+2)aV|
|New rounded scaled-kernel coefficient|Its norm is strictly below1; this is a separate coefficient object, not an aV-scaled data bound|
|Rounded point-product output, inverse input|Z_s*aV|
|Input to inverse stage j, 0<=j<k|(2+u)^j Z_s*aV; at j=0 this is exactly Z_s*aV; for j>=1 it is at most2^(j+1)Z_s*aV|
|Stored root product within that stage|(1+u)(2+u)^j Z_s*aV|
|Stage output|(2+u)^(j+1)Z_s*aV<=2^(j+2)Z_s*aV|
|Common stage allocation covering input, root product and output|2^(j+2)Z_s*aV|
|Selected inverse output entering final chirp|n(1+C_new*u)aV<=3n*aV/2|
|Final chirp output|(1+u)n(1+C_new*u)aV<=2n*aV|

The stage bounds follow by induction from L_next+1<=(2+u)(L+1). The finite-binomial estimate applies at every j<=k because 2ku<=1, so (2+u)^j<=2^(j+1). One must use that induction, not repeatedly double a previously rounded coarse bound and discard the u term. The root-product bound includes its product round. Its factor is less than the stage-output factor, so the common stage allocation covers all operands and stored outputs. Raw integer presums/products still require the larger capacities in the main note.

For the postchirp, e_I<=n*C_new*u*aV follows from the error proof. The local safety already gives u<1/3, and the inherited semantic condition gives C_new*u<=1/2. Therefore the final coefficient-and-round factor is at most(4/3)(3/2)=2. This sharpens the main note's sufficient bound below3n without changing its peak proof or examples.

On grid p, a factor H in the table gives data magnitude capacity p+ceil(log2(H*aV)); the underlying augmented inequality makes the coordinate magnitude strictly less than that power of two. The kernel capacity is p. The exact-cache alternative instead retains its numerator on grid p+k, and must use p+ceil(log2(2n)) for the coefficient. There is no permission to deduct k from that exact numerator width.

A future fold must retain or reconstruct exact structural keys `(n,P,j,a,V,p,coefficient grid,root/kernel type,normalization location)` and their occurrence multiplicities. In particular n controls both Z_s and the semantic final-chirp bound. The outer a must use the complete preceding-axis norm multiplier, not the count of retained outputs. Requested-output labels and original axis order remain unchanged.

An old histogram containing only rounded ceiling exponents is not an invertible representation of these keys. Subtracting k from an old stored exponent does not reconstruct the new stage bound. The new proof must be associated with the actual Bluestein context from the saved manifest, and all aggregate projections must still match its frozen operation counts. This supplement does not authorize or perform that reconstruction.

For an implementation decision, compare the normalized successor against the strongest reviewed original-circuit local-width schedule at the same input/error contract and backend prices. The main note's local example table is an explicitly chosen matched conservative rule, not a dominance claim over a tighter original implementation. Any newly supplied original-circuit local-width fold should replace that comparator before an aggregate saving is claimed. Cache construction, signed/range/binding overhead, coefficient grids, generation and proof-production costs remain explicit on both sides.
