# Fixed-factor reuse on the b100 Horner side

2026-11-11. Conditional arithmetic and exact metadata only. No coefficients, product tables, quotients, analytic values, primes, transforms or builds were evaluated. Frozen predecessors remain unchanged. The newly authored b100 circuit is bound below and remains subject to its separate independent review.

**Result.** Apply the same fixed-multiplier proof-table idea to the new Horner comparator before crediting it only to finite differences. Here the fixed factors are narrow. Under the declared ordinary-PA byte-event model, a correctly oriented rectangular multiplication costs232 events, while the table/prefix proof costs337 even with growing-prefix widths. Setup is additional. Thus this particular table schedule has no amortization crossover under this common scalar-event price. This does not rule out sparse constant multiplication, different event prices, a better proof template or a faster implementation.

## 1. Bind the new circuit, not the old arbitrary-grid Horner

The actual candidate is audit/B100_PRODUCT_ONLY_HORNER_2026-11-11.md, SHA256 `84E9E1491DE668337E0DACFCFFFBA7F6CDEBDAE6479929EB6CC097D2535D9A6C`, read in full. It uses the explicit coefficient conversion z'_j=n_j/2^100 with norm below2^16. Its source-grid adapter and mixed-evaluator clarification are retained. It changes the center polynomial and pays that error; it does not assert that old centers already had this grid.

For one conductor, residue and band, set F=2Dout, k=floor((2Fa+c-1)/(2c)), r=Fa-kc, v=2c and h=r/v. The exact ties-down geometry gives |h|<=1/4. For j=18,...,0 and each coordinate, the source circuit proves

    t=r*M,
    t=q*v+s, 0<=s<v,
    e=1 if 2s>=v, else0,
    M_new=q+e+n_j.

Thus q is the signed floor quotient, and q+e is the nearest product with ties toward positive infinity. The coefficient addition is exact on grid100, and the final output needs no extra round. The coefficient-change and nineteen product-round errors together are below(8/3)2^-100 per residue. Inherited source, Taylor, shift and character-normalization bounds remain separate. This note does not replace their review.

The relevant source bounds are |M|<2^117, |q|<2^115, |r|<2^18, and v<2^20. These are natural magnitude bounds; the corresponding signed capacities include a sign bit. The floor-quotient bound includes negative-floor and increment cases. Per complex stage there are two r*M products and two q*v witness products. The remainder reconstruction, strict/non-strict comparisons, quotient increment, exact coefficient additions, range proofs and input/output bindings remain mandatory. A nearest-quotient residual variant could prove the same round, but this comparison follows the actual floor-q source and does not silently delete its operations.

## 2. Two different fixed-factor caches

An unsigned table for |r| proves T_r[d]=d|r|, d0..255. The signed product restores the actual sign of r and M. It can serve all nineteen stages, both coordinates and all heights with the same exact geometry. The key must bind the conductor, F, chosen anchor k, residue a and derived r, or a checked identity to an already cached equal magnitude. Different residues/bands cannot be merged merely because they have similar displacements. r=0 and small special factors deserve their own proved branches; they are not forced through a table for this analysis.

A table T_v[d]=dv depends only on the conductor through v=2c. It can serve all quotient-witness products at all residues, anchors, bands and heights for that conductor during its checked lifetime. It is not the finite-difference final divisor Q=(2c)^19; those two tables prove different products and must not be conflated.

For either factor A, the existing ordinary proof is T_A[d+1]=T_A[d]+A followed by induction using distributivity/successor arithmetic. A most-significant-first byte traversal maintains V=A*p for the exact processed input prefix p. The transition V'=256V+T_A[d] proves V'=A(256p+d). The full input decomposition, digit bounds, factor and table-result identities must be checked. Signs use the existing signed-magnitude adapter, including zero; they are not unsigned array indices.

Local table proofs do not automatically survive theorem resets or independent shards. Charge setup once per actual checked lifetime, or charge global theorem storage, import and reinstantiation instead. A digest is not a proof import. Data ordering to retain r tables may require additional buffering or transposition of height/source data. The more reusable v cache does not make the residue-dependent r cache free.

## 3. Tight byte widths and the proper direct orientation

Both variable magnitudes use at most15 bytes. Their maximum top-byte sizes differ:

| Product | Factor bits | Variable bits | Top variable bits | Final magnitude bits |
|---|---:|---:|---:|---:|
| abs(r)*abs(M) |18|117|5|135|
| v*abs(q) |20|115|3|135|

In both cases factor bits plus top-variable bits is23. After j processed bytes the product fits j+2 bytes, for j1..15. Therefore the prefix-adder widths are4,5,...,17 bytes. The first table lookup fits3 bytes for the validated top digit, even though the complete factor table needs4 bytes per entry. The radix-shift operand before each addition is bounded by the next nonnegative prefix product. No cancellation is assumed to establish these widths.

The direct comparator has a15-byte changing operand and a3-byte fixed factor. The rectangular ordinary-PA skeleton M(m,n)=5mn+2n+1 takes n outer rows. Put the NARROW factor in the three-row position:

    M(15,3)=5*15*3+2*3+1=232.

The reverse orientation costs M(3,15)=256 and is not the best matched comparator. Its proof may initially use18 output-byte slots, with the sharper135-bit range justifying the zero padding/trim; representation and range binding remain charged. Neither orientation needs the roughly500-bit difference-state capacity.

## 4. Matched template counts and the negative crossover

Use A(w)=2w+1 for the existing byte adder macro. The tight table product has15 table references,14 prefix-fusion applications and fourteen growing-width adders:

    T=15+14+sum_(w=4)^17(2w+1)=337.

This already improves the coarser uniform18-byte-adder subtotal547. It still exceeds232 by105. Both factor tables require4-byte values in the full0..255 range, giving the same declared setup count per factor:

    S=255*(A(4)+2)+4=2809.

Here the extra two applications are the successor-product and save steps. The full256-entry raw value payload is1024 bytes per table, excluding statements, proofs, digit terms and references.

For a single degree19 complex polynomial the unsigned product subcomponents are

    direct: 2*19*(232+232)=17632,
    table:  2*19*(337+337)=25612,

an excess7980 before table setup and other costs. The first two-factor setup is5618 events; a retained conductor-v table can avoid its repeated setup, but cannot remove the per-use105-event disadvantage in this model. For any positive use count H, S+337H>232H. Unlimited reuse therefore does not create a crossover under this equal-macro-event convention.

The two methods are entitled to the same zero/short-factor, leading-zero, power-of-two and specialized-constant branches if implemented. This note has not counted those branches or assumed anything about the distribution of actual mantissas, quotients or r values. In particular, adding a short table value to a long shifted prefix could use a sparse carry scheme better than the full-width A(w) adapter; that is a distinct proved schedule, not the337 count claimed here.

## 5. Full cost interface and fair finite-difference comparison

For objective t, compare actual direct costs M_t(A,x) with complete table costs T_t(A,x), including term/decomposition/binding differences. The condition for a table lifetime is

    sum_uses [M_t(A,x)-T_t(A,x)] > S_t(A)+E_t,

where E_t charges extra transport, storage, ordering and cache management. Lookups, digit multiplication facts, carry proofs and theorem fusion need not have equal prices. Consequently the no-crossover result in section4 is only a statement about that declared scalar-event model, not an impossibility theorem for the full objective.

Native generation still computes the stage product and obtains floor quotients/remainders, or supplies them by another charged method. A table proof does not discover q. A producer may use direct native arithmetic while emitting table proofs for a different checker, but then pays both appropriate generation and proof-construction work. Ordinary Lean kernel numeral multiplication may favor the direct narrow product; this explicit-PA subtotal is not a Lean operation count or time ratio.

For the full finite-difference comparison, retain this new b100 Horner comparator as an alternative to the older fine-grid Horner. Both methods share the optional20-coefficient grid conversion only through an actually retained cache object. Horner still has nineteen stages and per-stage quotient witnesses; FD still has initialization, wide state additions through nonunits, coefficient prescales and final wide-denominator rounding. A fixed-Q table may improve a declared FD final-round subtotal, while the analogous generic table is not favorable for these narrow Horner factors. That difference follows from matched operand sizes, not an asymmetric prohibition on proof reuse. No full-family operation ledger, selection guard or method winner is changed here.

## Evidence

The source table schema is moebius/P27_FIXED_STEP_PROOF_REUSE_2026-11-11.md, SHA `F578D50723A09A1580D6ACFBA4F6AEB93371AF81B7929121A9F402E0ED5A38D0`, reviewed at `F9E0EDCE65255FD912176E321606CA17E2854E3D23E78EBA36B6A4006858D4CC`. The rectangular template is integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md, SHA `3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227`, section2. The specific FD denominator reuse is zero-sum/FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md, SHA `E5622749AB1A5A9D91743586B17DCE8C3E10C87237E2F48168CD47D7064385BF`, reviewed in this directory at `314CE4EEF32B3E5C87D671E6221AA43FC50428F642F0C062A0FA94E392DB59CF`.

The new exact-only script horner_fixed_factor_reuse_20261111.py has SHA256 `EF1BDDE692B2D0CA06BD219882EB367B6B79C2900F4109D57F4EBD12DC04CEA1`; its JSON has SHA `F6461A2C6648C5BBCDCCE0047D4AE1A6312168315B262536690DD2E5E7799169`. All13 bit-width/count assertions pass. It constructs only sizes and counts, not tables, products or quotient data. The b100 author pin was separately read and hash-verified. Its independent circuit review and any later degree-dependent-grid successor remain separate from this bounded conditional comparison.
