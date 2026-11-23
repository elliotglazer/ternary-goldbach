# Independent review of b100 Horner fixed-factor proof reuse

2026-11-11. PASS within the stated conditional source-interface and arithmetic-template scope. No substantive correction is required. One section-reference clarification is recorded below. This does not validate an implemented arithmetic backend, assign timings or select a whole-family evaluator.

Reviewed author: `prime-estimates/B100_HORNER_FIXED_FACTOR_PROOF_REUSE_2026-11-11.md`, SHA256 `973FA8095EA9BC4768B1D50B70AB0218FE730508C46E7BC37F68B5E944381CE0`. The frozen author files are unchanged. I read the full author note, its script and receipt without running or importing them, the complete b100 Horner circuit, the fixed-step table proof, the rectangular arithmetic-template source, and the grid review with its mandatory mixed-evaluator clarification.

## Source and rounding interface

The bound applies to newly converted centers n_j/2^100, not arbitrary original fine-grid centers. The grid adapter proves the coordinate witnesses and supplies explicit magnitude margins below2^16. For ties-down anchor geometry, |r/(2c)|<=1/4; this is distinct from the ties-up product-round convention.

The signed Euclidean stage t=rM=qv+s, 0<=s<v, followed by m=q+1_{2s>=v}, correctly rounds the product toward the nearest grid point with ties up. Negative products require the signed floor quotient, and the formula handles them. Adding n_j is exact on the shared grid. The initial n_19 is copied exactly and the last coefficient addition needs no further round. Coefficient conversion contributes less than u sum_{0..19}4^-j and the nineteen product rounds contribute less than u sum_{0..18}4^-j. Their sum is below(8/3)u, preserving the inherited1688u character-summed allowance with amplification633. The stronger all-FD1477u allowance is not assigned to this mixed option.

The accumulator bound (4/3)(2^16+u)<2^17 and the quotient bound, including negative-floor and increment slack, imply magnitude widths117 and115 for M and q. The selected conductor domain gives |r|<2^18 and v=2c<2^20. Thus the compared unsigned products have widths18+117 and20+115, both135 bits. These are derived b100 capacities, not an assertion that arbitrary supplied encodings fit them. Decoding and conversion of the original arrays remain separately charged. The separate independent review of the new Horner circuit is still required for adopting that comparator; this note verifies the interface consumed by the fixed-factor analysis and does not replace its full review.

## Product proof and width accounting

For either nonnegative fixed magnitude A, induction on d proves T[d]=dA from T[0]=0 and T[d+1]=T[d]+A. The most-significant-byte invariant V=Ap is preserved by 256V+T[d]=A(256p+d). Actual factor, digit, table-result and input-decomposition identities must be present in the ordinary proof. Signed output reconstruction, zero conventions and range checks are additional obligations. A digest alone cannot supply them.

The changing operand needs fifteen bytes. Its top digit uses five bits for M and three for q. In both cases the fixed factor plus top digit uses23 bits. After j digits, the unsigned product has at most8j+15 bits and therefore j+2 bytes. This gives3 through17 bytes for the successive prefix products, and4 through17 bytes for the fourteen adders. Both nonnegative addends fit the next prefix-product bound, so no cancellation is used. The complete256-entry factor table still needs four bytes per entry even though the validated initial top-digit lookup fits three.

The rectangular source macro charges five events per cell, two per outer row and one base event. The narrow factor must occupy the three outer rows. The resulting count is3*(15*5+2)+1=232. Reversing the orientation gives256. This choice is mathematically allowed by multiplication commutativity, with any actual representation/orientation conversion charged outside the skeleton. The sharper135-bit final bound does not require silently removing the generic direct comparator's padding slots.

The table subtotal is15 references+14 prefix fusions+sum_{w=4}^{17}(2w+1)=337. The adder sum is308. The per-factor setup255*(9+2)+4=2809 follows the declared successor/save convention. A degree19 complex evaluation has76 unsigned products of these two types, giving17632 direct events versus25612 table events, a difference7980 before setup. Two initial tables cost5618 events. The raw value payload1024 bytes per table excludes theorem terms, proofs, references and digit facts as stated.

For any use count H>=0, the table-minus-direct subtotal is2809+105H>0. Thus reuse cannot create a crossover for this particular equal-event schedule. This is not a lower bound on every constant-multiplication proof. Sparse carry handling, specialized factors, unequal event prices or a different proof representation can change the comparison and need their own schedule. The author does not conflate these macro events with Lean kernel steps, MM0 opcodes or elapsed time.

## Cache and comparator limits

The r table is tied to the actual displacement geometry or a proved equal magnitude. The v table is conductor-wide and can have a longer lifetime. It is not the FD divisor table for(2c)^19. The two kinds of reuse must not be merged. Resets, proof shards, imports, buffering, ordering and cache reconstruction remain charged. Neither table computes the producer's quotient for free.

The full comparison must price exact additions, Euclidean witness reconstruction, remainder/tie tests, sign/range proofs, bindings and source conversion. Existing finite differences still traverse nonunits and use wide states, prescales and final division. This negative table subtotal therefore neither proves Horner wins overall nor modifies the Newton cost frontier. The comparator in that frontier must be rebound explicitly if this b100 circuit is selected.

## Evidence and documentary clarification

My independent exact checker performed69 assertions. It verified all twelve packet/interface hashes, reconstructed every width and count above, compared both saved rows and the degree19 subtotal, and checked the geometric and quotient inequalities with rational arithmetic. It used no author imports, actual coefficient data, tables, products, function evaluations, scans or builds.

The author cites section2 of `integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md` for the rectangular5mn+2n+1 template. The explicit template and its event convention occur in section3. Section2 gives the quotient/remainder proof interface. This is a documentary clarification only; the cited file hash matches and the mathematical comparison is unaffected.

Independent script: `major-constants/review_b100_fixed_factor_20261111.py`, SHA256 `CA837C26B5624E9EF053D30CD32053ABBE64781ED95AD17D8B048F0A54FD6848`.

Independent receipt: `major-constants/review_b100_fixed_factor_20261111.json`, SHA256 `53B4AA1B867F3CBCF6696C1E24B760140648943B78110C96373F15CA8AF690AC`. It contains all twelve full source/packet pins, including author script `EF1BDDE692B2D0CA06BD219882EB367B6B79C2900F4109D57F4EBD12DC04CEA1`, author receipt `F6461A2C6648C5BBCDCCE0047D4AE1A6312168315B262536690DD2E5E7799169` and the exact b100 circuit `84E9E1491DE668337E0DACFCFFFBA7F6CDEBDAE6479929EB6CC097D2535D9A6C`.
