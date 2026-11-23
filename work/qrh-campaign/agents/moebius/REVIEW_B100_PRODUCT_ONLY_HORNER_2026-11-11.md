# Review of product-only rounded b100 Horner

2026-11-11. PASS for the conditional arithmetic, error and width theorem, with no correction. This binds `audit/B100_PRODUCT_ONLY_HORNER_2026-11-11.md`, SHA256 `84E9E1491DE668337E0DACFCFFFBA7F6CDEBDAE6479929EB6CC097D2535D9A6C`. No actual coefficient arrays, ordinary-kernel implementation, runtime advantage or spectral success are accepted.

I read the full author note, script and receipt; the coefficient-grid adapter, its mixed-evaluator clarification and independent review; and the relevant scaled/joint source clauses. All seven predecessor pins matched. Only independent rational bounds and synthetic signed integer witnesses were checked. There were no polynomial function samples, analytic evaluations, transforms, prime calculations, builds or frozen-file changes.

## Exact object and circuit

The grid adapter creates a new polynomial P100 from the original delivered polynomial P. It proves each complex coefficient change is below u=2^-100 and validates the actual common grid. Its explicit magnitude margins40665 and27043 leave the new coefficients below C=2^16. A norm-error bound alone would not imply grid membership, and a strict C bound without a numerical margin would not by itself survive requantization. Both issues are handled by the consumed adapter.

For every unit target, the ties-down anchor gives r=Fa-kc, v=2c and h=r/v with |h|<=1/4. F=2Dout is the delivered normalization, including F16384 in the final band despite sourceD4096. The same height, anchor, source object and normalization must bind geometry and coefficient lookup. This per-unit circuit needs no c>10F or c>20F condition and no consecutive-unit run.

For a signed accumulator coordinate M, write t=rM=qv+s with v>0 and0<=s<v. Let e=1 exactly when2s>=v, otherwise0, and m=q+e. If e=0, the residual t/v-q belongs to[0,1/2); if e=1, it belongs to[1/2,1). Thus

    (2m-1)v<=2t<(2m+1)v,
    -1/2<m-t/v<=1/2.

This handles negative t through the signed floor quotient and nonnegative remainder. At either signed tie the higher integer is selected. Each coordinate error is at most u/2; the complex Euclidean error is below u. The coefficient addition m+n_j is exact because both coordinates use grid100. It still requires a checked signed addition, but no extra numerical rounding. Initial n19 is copied exactly, and the final exact addition is already an output on grid100, so there is no hidden initial or final round.

The producer may supply quotient/remainder witnesses. Their existence or native computation is not trusted: equality qv+s=t, remainder bounds and the tie decision must be established by ordinary integer arithmetic. No inverse or coprimality condition is substituted for division. A fused storage expression does not become a new inference rule.

## Complete error allocation

Let Gm=sum_(j=0)^(m-1)4^-j. Coefficient conversion gives |P100-P|<uG20. Exact additions introduce no evaluation error, so the product-round error recurrence is E_next<=E_old/4+u, starting from zero. After19 stages, E<uG19. Therefore

    |H100-P|<u(G20+G19)
      =u[8/3-(4/3)(4^-20+4^-19)]<(8/3)u.

The argument uses deterministic absolute errors; it assumes no cancellation, independence or relative accuracy. It holds at every consumed in-cell argument, including h=0 and both permitted signs. It compares to the original polynomial P rather than silently identifying the requantized centers with the original ones.

The scaled source's Horner allowance is(8/3)u per residue, obtained there by rounding both products and additions. The new proof spends that same total allowance on coefficient conversion and product rounding. With the inherited actual character/conductor amplification633, the evaluation contribution is below1688u. The other source/EM, numerical coefficient, shift and target-tail terms remain separate. I independently reconstructed the retained first-four and final-band rational envelopes; they remain below(1/3)2^-82 and(4/25)2^-82 respectively. The final-band m159 change does not alter those consumed formulas.

This resolves exactly the different circuit excluded by the older grid clarification: unchanged two-rounded-gate Horner on P100 would add its old evaluation error to conversion. Here exact coefficient additions remove that second per-stage rounding term. The predecessor clarification is preserved, not contradicted.

For a disjoint mixed cover of required outputs, original-center Horner and this new b100 circuit each satisfy the old(8/3)u cap. Reviewed b100 finite differences satisfy(7/3)u. Actual nonnegative character weights therefore give a uniform1688u cap for the mixture. The all-FD1477u cap requires that all weighted outputs use that stronger route, or a new subset-weighted proof. Different circuits need not return identical centers or produce identical sign margins.

## Raw widths

The closed recurrence B_next<=C+B_old/4+u gives B<(4/3)(C+u)<2^17 at every stage. The rounded product magnitude is below C/3+(4/3)u<2^15. These bounds include all complex values and consequently each real coordinate.

At b100, coefficients fit117 signed bits and accumulators118. The displacement numerator has magnitude at most132900<2^18, and v<=531600<2^20. Thus rM fits136 signed bits. A signed floor quotient can be negative and one integer larger in magnitude than t/v; the explicit bound including that unit and the possible increment remains below2^115. Both q and m therefore fit116 signed bits. The raw witness qv fits136, and a conservative pre-equality qv+s temporary fits137. The exact coefficient sum fits118. The denominator/remainder fit20 unsigned bits, and doubled remainder fits21.

These are sufficient capacities derived before relying on cancellation in qv+s=t. They are not widths of arbitrary unvalidated input encodings, nor proof-byte or hardware costs. Original-center decoding and conversion still use their actual potentially finer widths. The exact h is rational, so replacing it with an uncharged approximate displacement would invalidate the proof.

## Costs and remaining obligations

There are19 complex product-round stages and19 exact complex additions per unit, with no extra output round. The explicit Euclidean realization expands to38 signed products rM,38 witness products qv,38 reconstruction additions and38 rounding decisions, together with coefficient additions, increments, inequalities, range checks and bindings. Quotient generation and checking are distinct costs. No mathematical gate is assumed to be one proof opcode.

The20 complex coefficient conversions are charged per distinct retained source array. A shared b100 array can serve both Horner and FD consumers when its complete identity matches. Reconstruction after eviction, input decoding and source/grid proofs are not free. Geometry reuse likewise needs exact factor and target binding. No special r=0 branch or precomputed multiplier table is credited here.

This provides a valid narrower comparator for the Newton frontier, whose C_H was deliberately symbolic. It does not show that repeated narrow product/division witnesses beat roughly500-bit additions and initialization, or vice versa. Full unit coverage, caches, source work, the separate finite head, character transforms, sign/count completeness and analytic foundations remain required. A degree-dependent precision successor is outside this uniform b100 review.

## Independent evidence

Owned script `moebius/review_b100_product_horner_20261111.py` passed1047 exact checks, including315 synthetic signed witnesses near remainder/tie boundaries and at large signed quotient magnitudes. It independently uses closed geometric formulas and reconstructs the old complete alpha envelopes. No author program was imported or executed; the author's9370 assertions were read only.

|Artifact under work/qrh-campaign/agents|SHA256|
|---|---|
|audit/B100_PRODUCT_ONLY_HORNER_2026-11-11.md|84E9E1491DE668337E0DACFCFFFBA7F6CDEBDAE6479929EB6CC097D2535D9A6C|
|audit/b100_product_only_horner_20261111.py|6698CB66EA936C4EECC3E66C22E345B37C0093D831D3248A4F9638A1CB11A099|
|audit/b100_product_only_horner_20261111.json|3B212A633B578EA1708B0A9D1E42279CE82D77BB49FE54FC75B08A77CEE9AC55|
|moebius/review_b100_product_horner_20261111.py|C39442D114EBD775BFDB1B17F08E4F60D95BA67F38122BDF0D3EDFBBDD862542|
|moebius/review_b100_product_horner_20261111.json|7A82B87B567B7C81AEC3FBE2615DEE7266721A15EEDB006CA984DF6F066B95CA|

The seven full input paths/hashes in the author receipt were all rechecked. Relevant source clauses read include scaled-seed lines126,156-172 and joint final-band lines78,87,100-102. Acceptance is the conditional paper/source arithmetic theorem and its explicit cost interface, not implementation or numerical certification.
