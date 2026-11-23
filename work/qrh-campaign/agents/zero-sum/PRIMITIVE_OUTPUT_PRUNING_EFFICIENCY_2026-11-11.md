# Computing only primitive character outputs

2026-11-11. Paper identities and integer schedule metadata only. No character/root/FFT/L-value/zero evaluation or build. Previous artifacts are unchanged. The R138000 analytic profile retains its separate acceptance obligations.

**Positive result:** on the same R138000 coarse inputs, a specified primitive-output circuit uses .708022–.708023 of the existing mixed-radix general complex products and .702508–.702509 of its complex additions above c=10000. Almost all this improvement is available by filtering local character indices between complete axis transforms; pruning inside those axes adds a smaller saving. The input Hurwitz contractions and shared seeds are unchanged. These are operation counts, not runtime or spectral-success claims.

## 1. Exact required indices

Use the actual character coordinates in the reviewed `FAMILY_CHARACTER_MANIFEST_PROOF_PLAN`: odd prime powers use a specified primitive unit generator; at powers of two the coordinates are powers of -1 and5. A positive DFT coefficient has the same positive-exponent label as that manifest.

| Local conductor | Input cyclic axes | Required output labels |
|---|---|---|
|odd p|n=p-1|k in[0,n), k!=0|
|odd p^e, e>=2|n=(p-1)p^(e-1)|k in[0,n), p does not divide k|
|4|n=2 (sign)|k=1|
|2^e, e>=3|n1=2 (sign), n2=2^(e-2) (power of5)|both sign labels, odd second label|

These restrictions follow from the source factor-through/kernel definition of conductor, not from matching a count. At odd prime powers, triviality on the reduction kernel to p^j is equivalent to p^(e-j) dividing k; reduction to conductor1 additionally requires k=0. For 2^e the primitive condition is precisely the odd power-of5 label, with the stated separate4 case. CRT gives global conductor equal to the product of local conductors, hence the primitive output set is the Cartesian product of these local subsets.

Every subset is closed under k->-k modulo its axis length. Both members of every nonreal inverse pair remain, as do all real primitive labels. No sign/parity channel is discarded except an index proved imprimitive by this criterion. Conductor one and levels with two-adic exponent1 are outside this nonprincipal inventory. The manifest's historical height profile is not reused here; heights are those of the fixed R138000 inventory.

The underlying source APIs are `DirichletCharacter.factorsThrough_iff_ker_unitsMap`, `conductor`, `IsPrimitive`, the units-CRT isomorphism, and the actual unit-homomorphism character equivalence, pinned and derived in the manifest's sections1–4. This report uses that established coordinate bridge; it does not replace actual source characters by an unrelated abstract Fourier list.

## 2. Filtering between axes is exact

Let axis i have input length m_i, required output size r_i and projection P_i onto that subset. The full transform is the tensor product of the D_(m_i). A projection on one output coordinate commutes with transforms acting on the other coordinates. Consequently, after computing an axis, immediately discard its unwanted outputs; every later transform for a retained prefix is identical to the corresponding part of the full transform. No later retained output depends on a discarded prefix.

For an axis order pi, the number of lines for stage i is

    product_(j<i) r_(pi(j)) * product_(j>i) m_(pi(j)).        (1)

Multiply this by the cost of the selected one-dimensional partial transform. Formula(1) counts all multiplicities. In contrast, replacing m_i by r_i inside a full transform without changing its line dependencies would be invalid.

Every input unit residue is still required: the coefficients of any one character on units are nonzero. No input is deleted, and no reduction in the103868439142446 large-branch residue-height contractions is inferred. The result is the full-transform output restricted to the actual primitive set, not a new shorter DFT. In particular, an implementation using normalized transforms still recovers the original scale v=product m_i, never product r_i.

## 3. One-dimensional pruning on the existing CT tree

Write S(n,q)={k in[0,n): q does not divide k}, with q dividing n, q>=2. Use q=0 as a notation for the full set. The local table needs only q=n (omit zero), q=p at an odd prime power, and q=2 at a power of two. Let C(n) be the frozen full mixed-radix cost vector and C(n,q) its partial counterpart.

The exact CT step n=rm uses input j=a+rb and output k=v+mu. Its phases satisfy jk/n=bv/m+au/r+av/n modulo integers. For an arbitrary requested set S, first request V={k mod m:k in S} from every one of the r length-m transforms. For each v in V, apply the length-r transform to the cross-twiddled values and request U_v={floor(k/m):k in S,k mod m=v}. This is a dependency derivation of the partial circuit, not an assumption about FFT sparsity.

For q=n, V is all m indices; U_0 omits0 and every other U_v is full. Thus

    C(n,n)=r C(m)+C_bridge(r,m)+(m-1)C(r)+C(r,r).             (2)

For q<n on the trees used here, q divides m. Then V=S(m,q) and every U_v is full, giving

    C(n,q)=r C(m,q)+C_bridge_restricted(r,m,q)
                         +(m-m/q)C(r).                     (3)

The property q|m is justified for these local axes and the frozen smallest-prime-factor split: while an odd prime p remains in (p-1)p^(e-1), every prime factor of p-1 is smaller than p and is removed first. Subsequent p factors leave p|m until the final p leaf. At powers of two the analogous assertion holds until n=2. A Bluestein fallback stops the recursion before this test. The script also asserts the divisibility at every such recursive request. Equation(3) is not claimed for arbitrary masks or factor schedules.

The restricted bridge has (r-1)(m-m/q) nonidentity entries before recognizing cheap roots. Retain exactly a>=1,v>=1 with v mod q!=0. Among them, av=n/4, n/2 or3n/4 are respectively quarter turns, negations or quarter turns when integral; all others are general products. These conditions are checked by integer divisibility.

At n=2 with only label1, one subtraction suffices. A direct odd-prime leaf r<=11 with zero omitted has G=(r-1)^2 and A=(r-1)^2: its nonzero rows are unchanged, and only the zero row's additions disappear. For a power-of-two node above2, use the same r=2 CT recurrence; its full form agrees with the prior radix-two circuit.

**Conservative Bluestein rule:** retain both full padded transforms, all P pointwise products and all input chirps. Omit only the final chirp multiplications and output storage for unwanted indices. The kept post-chirp classification uses the same exact fourth-root test n|2k^2, restricted to k mod q!=0. If g,Q,z count general/quarter/negative chirps on all n indices, and g_S,Q_S,z_S count them on S, then

    C_Blue(n,S)=2 C_radix2(P)+(P+g+g_S,0,Q+Q_S,z+z_S,P).     (4)

There is deliberately no pruned inverse-FFT or padding-output saving in these figures. All full-output kernel setup may be retained unchanged. More aggressive Bluestein/Rader pruning is a separate optimization, not silently credited to primitive filtering.

## 4. Axis order and its limited optimality

Let G_i be the partial one-dimensional general-product count, and delta_i=m_i-r_i. Comparing adjacent axes i then j against j then i in(1), the former is no worse exactly when

    delta_j G_i <= delta_i G_j.                             (5)

The unaffected prefix/suffix factors are positive and cancel. Thus sorting by G_i/delta_i, with zero-deficit axes last, minimizes G for these fixed one-dimensional circuits. Ties are sorted by A_i/delta_i, then a deterministic integer key. This only optimizes the order in the specified separable schedule, not all possible Fourier circuits or total bit cost. The chosen order must be recorded and its output tuple remapped to the original character manifest.

For comparison, the metadata also keeps the original increasing-prime order, and a variant which uses the selected order but performs full one-dimensional transforms before filtering between axes. The latter isolates the main source of savings.

## 5. Exact inventory on the unchanged nominal grid

The large branch retains130500 conductors,4673659621 primitive labels and the same103868439142446 coarse residue inputs. Each circuit is multiplied by the same J(c)=ceil(64H(c)/5)+1. No sign-test refinement, auxiliary height, character identity or coverage target is altered.

| Category, c>10000 | Full mixed circuit | Partial, original axis order | Partial, order from(5) |
|---|---:|---:|---:|
|General complex products|2736537742659260|1938924872313744|1937530158480010|
|Complex additions/subtractions|5668480164659994|3994327052278456|3982154589952312|
|Quarter turns|251954587115486|176530156065968|176464968332865|
|Negations|60339019852|37987596280|37945283538|
|Dyadic scalings|244332926367552|171086141798400|171051285804864|

The final-column/full ratios are .708022–.708023, .702508–.702509, .700384–.700385, .628868–.628869 and .700074–.700075. Even retaining the original axis order gives G ratio .708532–.708533; order optimization is a small additional gain in this aggregate.

With the selected order but **full one-dimensional transforms**, filtering only between axes gives G=1941517858969426 and A=4037673628062396, ratios .709479–.709480 and .712302–.712303. Thus most of the product saving comes from not carrying imprimitive local prefixes into later axes, rather than eliminating many operations inside a single large cyclic transform.

Examples show why primitive-label ratios cannot stand in for circuit counts:

| c | Full G / A | Partial G / A, selected order |
|---|---:|---:|
|8|0 / 8|0 / 4|
|27|64 / 90|54 / 60|
|100003|4182168 / 9012898|4182168 / 9012897|
|138000|617600 / 880000|130560 / 189440|
|262144|851972 / 2228224|458752 / 1114112|
|276000|1252800 / 1830400|269920 / 396480|

At a large prime conductor, the only removed local index is the principal one, and here its removal saves just one addition. Mixed conductors with restrictive small local factors can instead eliminate many later transform lines. This is an exact structural effect, not a uniform saving per omitted character.

The small-conductor theta/time branch is not replaced. All-conductor character-circuit numbers in the receipt are diagnostic only. Kernel/root setup is conservatively retained at the full R138000 amount; persistent primitive-output storage was already filtered in the old plan, so it is not counted again as a new storage saving. Intermediate line counts decrease, but actual peak memory depends on the implementation.

## 6. Precision, inverse channels and completeness

For a fixed chosen axis order, the partial circuit is a subgraph of a virtual full circuit with the same retained operations. Fill the unused gates conceptually; every kept output and rounding operation is identical. The prior full-node sup-error bounds therefore suffice for the retained coordinates. Projection itself has sup norm at most one. The product-axis error argument remains valid with the same full-node coefficient sum and root/gate budgets; it does not divide by the number of retained labels.

Here the subgraph claim has a concrete inductive contract. Choose the full reference circuit with the same recursive CT decomposition, radix-two butterflies, direct-row summation order and Bluestein implementation used to define the counts. The count specification alone does not identify an arbitrary external FFT executable. For a direct leaf, retain the complete input-to-sum chain of each requested row, in the original input order. At a two-point leaf keep the required original addition or subtraction. At a Bluestein leaf keep all input chirps, both transforms and point products, then only the required final chirps. These choices retain every predecessor of each requested output.

At a CT node, every requested k uses exactly v=k mod m in each first child and u=floor(k/m) in the second child for that v. Retaining V, the associated cross-twiddle gates and each U_v therefore retains all predecessors. Apply the same argument inductively inside those children. At the outer tensor level, a later-axis gate combines entries only with the same completed-axis prefix; deleting a nonprimitive prefix cannot delete a predecessor of a primitive final tuple. This proves dependency closure, not only equality of exact transform formulas.

Require the retained gates to use the identical stored inputs, coefficient boxes, arithmetic formula, summation order and rounding rule as this chosen full reference. Deletion does not authorize reassociation, fusing roundings, or replacing two-point subtraction by a differently rounded formula. Induction over its topological gate order then makes every retained stored value identical to the full reference value. Thus its error and peak-magnitude bounds transfer for that fixed order without extra input-precision assumptions; an implementation using a different arithmetic graph needs a new argument.

The optimized outer order is a different full reference, not a subgraph of the old outer order. Its fractional-error transfer instead uses the already proved product-axis bound with the same coefficients C_i: the factors product_i(1+C_i*u), their sum bound, and their safety conditions are invariant under permutation. Its peak bound must use its new prefix lengths, as distinguished below.

This provides a conservative route to correctness, not a new measured precision or word-width claim. Magnitude bounds must be applied to the recorded axis order, cache errors remain present, and any different fused/rounded implementation must prove its own refinement. In particular, a previously calculated fixed-order integer-width bound does not automatically apply to the order chosen by(5); that width comparison remains open here. The operation saving is not paired with an assumed unchanged total operand width. Skipping gates does not authorize weaker input enclosures.

Every actual primitive positive-height output remains available. Since the retained set is invariant under coordinate negation, the existing inverse-character adapter can still cover negative ordinates without losing either positive channel of a nonreal pair. Central real zeros, multiplicities, closed target heights, auxiliary data and count saturation remain unchanged obligations. No RH, simplicity or sign success is assumed by this circuit identity. Induced-character consumers continue to require the existing conductor-descent proof; these partial transforms make no statement about discarded imprimitive outputs themselves.

## 7. Reproduction and source boundary

`primitive_output_pruning_inventory_20261111.py` copies the frozen full-circuit integer definitions, implements(2)–(4), and checks the product of local retained sizes against the actual primitive count for every conductor. It reconstructs the pinned R138000 full totals, checks each partial one-dimensional category is no larger than the full category, and checks the ordered tensor G does not exceed the original-order G. It has12960 top-level axis/restriction types and13221 recursive requests. An additional133 small finite-index checks verify requested-output projection, inverse closure and the two CT set identities. No root values occur in these checks.

Script SHA256: `EFA92DB65FC1419243CF9A6FF1DE063E19718E5AE4ADCB297D195B34D25F41D5`. Receipt SHA256: `407DB4730F9A31811D4B95184225C0619630FAD69B22B106CA565B3444C5E0DA`.

Source manifest: `FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md`, SHA256 `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54`; independent review `integration/REVIEW_FAMILY_CHARACTER_MANIFEST_2026-11-11.md`, SHA256 `EEE3BAE662500804EAEC0268A8612D0E01ED1C2FAF5D0208D442A97739794664`. Only its arithmetic character identification is used, not its historical spectral profile.

Full-circuit report: `MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md`, SHA256 `C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01`. Fixed R138000 receipt: `0D48AF7655976B5B0A0BC2750CA92F26E30B33E1F45540015627EEFFC5C60D5F`. Prior precision supplement: `4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4`, independently reviewed at `1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537`.

The resulting saving concerns only this character-transform component. Hurwitz seeds/contractions, full analytic error certification, native search, retained signs, auxiliary counts, final proof assembly and their runtime remain separate. A smaller arithmetic DAG is not a produced spectral certificate.
