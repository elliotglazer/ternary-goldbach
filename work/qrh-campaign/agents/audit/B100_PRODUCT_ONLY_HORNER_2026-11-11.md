# Product-only rounded Horner on the b100 coefficient grid

2026-11-11. New conditional arithmetic and error proof, pending independent review. This is a competitor for the width-sensitive finite-difference comparison. No actual coefficients, analytic functions, prime candidates, zeros, transforms or builds were evaluated. No frozen predecessor or operation ledger is changed.

The proposed circuit uses the same optional b100 coefficient requantization as exact finite differences. It then rounds only the nineteen Horner products. Each subsequent coefficient addition is exact on the same grid. Coefficient-change error plus product-round error is strictly below the old per-residue allowance(8/3)u_H. This permits a narrow-grid Horner comparator without retaining arbitrary fine coefficient alignment in every residue evaluation. It is a newly specified circuit, not the unchanged two-rounded-gate fallback excluded by the grid-closure report.

## 1. Source-bound inputs and geometry

Let u=2^-100. At a fixed actual height s=1/2+it and fine anchor k/F, consume the twenty delivered coefficient centers z_j of the existing degree-19 polynomial for f(alpha)=zeta(s,1+alpha). Here F=2Dout; the five output normalizations are512,1024,2048,4096,8192. The final sourceD4096 still has Dout8192. Coefficient source uncertainty and the analytic shift/target remainders are inherited at their actual normalized interfaces. Separate finite-head/residue corrections in the attachment to L, conductor factors, character transforms and later height work remain unchanged.

Apply the independently reviewed grid adapter to obtain z'_j=n_j*u, where n_j is a signed complex integer pair and |z'_j-z_j|<u. Each real coordinate is rounded by the exact nearest-grid inequalities, with ties toward positive infinity. The explicit source margins40665 and27043 ensure |z'_j|<C=2^16. This is not inferred merely by adding a tiny radius to an unspecified strict C bound.

Define P(h)=sum_(j=0)^19 z_j h^j and P_100(h)=sum_(j=0)^19 z'_j h^j as different exact polynomials. The source theorem compares the actual function to P; the new adapter separately pays P_100-P. No identity of old and new centers is claimed.

For every required unit numerator1<=a<c, use the exact nearest anchor with the chosen cache convention. For compatibility with the occupancy work take ties down,

    k=floor((2F*a+c-1)/(2c)),
    r=Fa-kc, v=2c, h=r/v.

Then -1/4<h<=1/4 and |r|<=c/2. Bind the same k, height, Dout and coefficient object in both geometry and lookup. The arithmetic theorem needs only |h|<=1/4 and v>0, so another proved nearest-anchor tie rule is possible, but it must not be mixed with these cache indices.

The selected large domain has10000<c<=265800 with its original odd/4-divisible restrictions. The circuit does not need c>10F or c>20F, nor a run of consecutive numerators. It evaluates each required unit independently. It does not export nonunits or change the selected conductor/character/height family.

## 2. The exact integer stage

Start with the integer accumulator M=n_19. This is an exact copy of a grid100 coefficient, with no extra initial rounding. For j=18,...,0, treat each real coordinate as follows:

    t=r*M_old,
    t=q*v+s_rem,  0<=s_rem<v,
    e=0 if 2*s_rem<v, and e=1 otherwise,
    m=q+e,
    M_new=m+n_j.

The supplied q is a signed floor quotient. The remainder is nonnegative even when t is negative. The two possible tie cases exhaust the comparison, and equality2*s_rem=v chooses e=1. Exact integer equality and remainder bounds prove

    (2m-1)v <=2t<(2m+1)v.

Thus m*u is nearest-grid100 rounding of h*(M_old*u). Each coordinate round error is at most u/2, so the complex product-round error is strictly below u. The following addition of n_j is an exact integer addition. Both summands represent values on grid100, so this addition needs no numerical round at all. Its signed arithmetic, capacity and equality proof still cost work.

The stage may store M_new=q+n_j+e without materializing a separate m object. That is only a representation choice: the same q*v+s_rem equality, remainder inequalities, tie comparison and exact additions must still be proved. It is not a fused primitive verifier instruction. No gcd condition or inverse modulo v is needed. The divisor is the unreduced positive integer2c; reducing h is optional and its own cost.

The last exact addition already gives a grid100 output. There is no extra final output round. No assumed division instruction or native quotient is trusted: a quotient supplied by the producer is accepted only through the stated ordinary integer witnesses.

## 3. Error proof

The coefficient adapter gives, for |h|<=1/4,

    |P_100(h)-P(h)|<u*G20,
    G20=sum_(j=0)^19 4^-j<4/3.

Compare the new accumulator with exact Horner evaluation of P_100. The initial accumulator has zero evaluation error. Each stage multiplies the preceding error by at most1/4, introduces product-round error below u, and adds the exact coefficient with no new numerical error. After nineteen stages,

    |H_100(h)-P_100(h)|<u*G19,
    G19=sum_(j=0)^18 4^-j<4/3.

Consequently

    |H_100(h)-P(h)|<u*(G20+G19)
      =u*[8/3-(4/3)(4^-20+4^-19)]<(8/3)u.

This pays the change of polynomial as well as the evaluation. The original coefficient/source/EM errors and the analytic shift/target remainders are still added separately. The argument assumes no cancellation or independence of errors.

After the actual unit-character sum and c^-s scaling, use the inherited amplification at most633. The replacement evaluation contribution is below1688u, precisely the old allowed cap. Thus the selected P27 first-four alpha bound remains below2^-82, and the joint/m159 final-band bound remains below(4/25)*2^-82. The exact old rational envelopes in the companion receipt remain below1/3 and4/25 of that budget, respectively. Their analytic normalization and finite-head attachment are not changed here.

The old unchanged two-rounded-gate Horner on P_100 would instead add its old evaluation allowance on top of coefficient quantization. That is not this circuit. Here the exact common-grid coefficient additions are essential to the error proof.

Mixed schedules may use original-center Horner, this grid100 Horner, and reviewed grid100 finite differences on disjoint subsets of the required unit outputs. The first two have evaluation allowance at most(8/3)u per residue; finite differences have below(7/3)u. Summing actual nonnegative absolute character weights gives at most1688u in general. The all-FD1477u bound cannot be assigned to the mixed schedule. Source errors and output coverage remain common obligations. No claim is made that these methods return identical rounded centers or identical strict sign margins.

## 4. Accumulator and witness widths

The widths here are sufficient signed capacities, including one sign bit. They concern validated inputs on grid100, not arbitrary unvalidated supplied integers.

At every stage the complex accumulator magnitude is bounded by the geometric recurrence

    B_new <= C+B_old/4+u,
    B_initial<C,
    B <(4/3)(C+u)<2^17.

The rounded product alone has magnitude below C/3+(4/3)u<2^15. These tighter bounds also imply that the signed floor quotient and its possible increment have magnitude strictly below2^115 in integer grid units. For example the floor quotient's absolute value is at most `(C/3+u/3)*2^100+1`, and adding one still stays strictly below2^115. This accounts for negative floor quotients as well.

Since v=2c<=531600<2^20 and |r|<=132900<2^18, the following capacities suffice throughout the selected domain:

|Object|Capacity|
|---|---:|
|Grid100 coefficient coordinate n_j|117 signed bits|
|Accumulator coordinate M|118 signed bits|
|Displacement numerator r|19 signed bits|
|Raw product r*M|136 signed bits|
|Floor quotient q and rounded product m|116 signed bits|
|Witness product q*v|136 signed bits|
|Raw reconstruction temporary q*v+s_rem|137 signed bits|
|Exact coefficient sum m+n_j|118 signed bits|
|Divisor v and remainder s_rem|20 unsigned bits|
|Doubled remainder2*s_rem|21 unsigned bits|

The137-bit reconstruction temporary is conservative before using its equality to the136-bit t. Neither multiplication relies on cancellation to fit its listed capacity. The small rounding increment fits the stronger quotient bound above; an implementation that does not exploit that bound must retain its own guard bit. Sign encoding, including any signed-magnitude zero convention, requires the already intended ordinary signed-integer bridge.

All stages, including the first one, use these widths because the initial z'_19 is already on grid100. This avoids the first-product divisor and later coefficient-alignment issues of an arbitrary finer original array. The coefficient adapter still reads that original encoding and must pay its actual widths. No claim is made that arbitrary finer input arrays have117-bit numerators.

## 5. Fully named cost interface

For each unit residue there are nineteen complex product-round stages and nineteen exact complex coefficient additions. There is no separate final round. The Euclidean-witness realization above requires, per residue,38 signed products r*M,38 signed witness products q*v,38 reconstruction additions,38 remainder/tie decisions and their comparisons, and the coefficient additions. Possible quotient increments, signed representation, exact input/output bindings and range checks are included in the rounding-stage contract, not omitted as zero cost.

The producer must obtain the quotients/remainders, by division or another proved method. Checker acceptance must prove q*v+s_rem=t and the inequalities using ordinary rules. A mathematical rounding gate does not count as one proof opcode. Likewise a product is not a hardware instruction or a fixed proof-byte price. Distinct generation, proof-production and checking costs must be used when needed.

Requantization costs twenty complex rounds per distinct selected source array, plus actual input decoding, exact shifts/divisions and certificates. If grid100 arrays are shared with the FD alternative, this conversion is charged once per retained cache object, not once independently to every algorithm consuming it. After eviction it is not automatically free to reconstruct. A concrete implementation that emits these new centers directly needs its own source/grid/error theorem; it cannot simply drop the adapter charge.

Geometry setup binds c,a,k,F,r,v and the unit/height manifests. r and v are fixed across the nineteen stages for one residue and across heights using the same geometry; coefficient arrays change with height. Any fixed-factor multiplication table or proof cache must charge its construction, exact factor binding, lookup, reuse lifetime and storage. No such acceleration is counted here. r=0 or another special factor may admit further simplification, but none is credited without a checked branch and target accounting.

This comparator is narrower than the roughly500-bit FD state, but it still performs products and quotient-witness work for each unit and stage. Width alone does not prove it cheaper. A complete comparison must retain FD initialization, nonunit advances, guard-specific widths, prescales, final division and both methods' setup/cache costs. This paper supplies a valid candidate baseline, not a winning runtime or proof-size prediction. No full-family count is changed.

## 6. Evidence and review boundary

The exact checker `audit/b100_product_only_horner_20261111.py`, SHA256 `6698CB66EA936C4EECC3E66C22E345B37C0093D831D3248A4F9638A1CB11A099`, passed9370 checks. Receipt `audit/b100_product_only_horner_20261111.json` has SHA256 `3B212A633B578EA1708B0A9D1E42279CE82D77BB49FE54FC75B08A77CEE9AC55`. It checks symbolic geometric bounds and widths, old alpha rational envelopes, and3090 synthetic signed Euclidean rounding witnesses. It does not evaluate any coefficient polynomial, function, prime candidate or spectral datum. The general error and integer-stage proofs are given above; the finite fixtures do not replace them.

Seven complete input hashes are retained in the receipt: grid closure9C2DA6DA, its mandatory mixed clarificationB620E1C2, independent grid review793AD441, scaled source251B95AE, joint sourceAA1A7464, m159E6F0F3B2 and selected P27579AAEC2. The full source paths and hashes were checked. Existing artifacts are unchanged. This new candidate requires independent review before any joined comparison treats it as accepted, and concrete ordinary-rule certificates remain separate from the paper proof.
