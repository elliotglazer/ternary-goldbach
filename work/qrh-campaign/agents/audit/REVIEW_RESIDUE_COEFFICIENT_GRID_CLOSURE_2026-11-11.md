# Review of the residue coefficient-grid closure

2026-11-11. PASS for the conditional representation and error adapter, with the mandatory mixed-evaluator clarification below. No actual coefficient data, function values, transforms, primes, zeros, builds or Lean declarations were produced. This review does not change the operation ledger or establish a saving.

Reviewed author `integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md`, SHA256 `9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4`, together with `integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md`, SHA256 `B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815`. I read both documents, the scalar checker and receipt, and the relevant source clauses. No further correction is requested. The clarification preserves the original author bytes.

## What is inherited and what changes

The scaled seed source at line71 permits a nearest common coordinate grid of step2^-122 for its named internal gates. Its shifted output interface bounds each complete shift update by u_T=2^-110. The joint construction at lines89-105 bounds a final output round by u_C=2^-110 after postscaling to Dout8192. These norm-error statements do not force arbitrary satisfying records to lie on a prescribed dyadic grid. In particular a finer-grid center can meet the radius while failing a b122 membership check.

A compatible implementation can choose the stated nearest grids. Coarser grid2^-110 outputs embed in grid2^-122; retained source slots on grid2^-122 already fit. The final postscale requires the stipulated output round. This proves the possibility of a concrete grid implementation, not membership of unsupplied records. Exact exponent shifts and every rounded gate still need their actual encoding and arithmetic proof.

The optional adapter instead rounds each original delivered coordinate to a new grid2^-b and explicitly names a new polynomial P_b. The original P is the finite polynomial of stored centers for f(alpha)=zeta(s,1+alpha). Its inherited source/EM, numerical coefficient, analytic shift and target errors continue to compare the actual function to P. The new P_b is not silently substituted as an identical object. Separate finite-head/residue corrections, conductor normalization and later transforms remain required.

## Exact rounding and error composition

For an exact rational coordinate N/Q, Q>0, the two inequalities

    (2m-1)Q <= 2^(b+1)N < (2m+1)Q

give a signed nearest-grid witness with ties toward positive infinity. They imply error at most2^(-b-1) in each coordinate, so complex Euclidean error is strictly below2^-b. No assumption about the input being a floating-point value or a b-bit mantissa is needed. Any cancellation of powers of two must preserve the same exact inequality.

At every consumed |h|<=1/4,

    |P_b(h)-P(h)| < 2^-b sum_(j=0)^19 4^-j < (4/3)2^-b.

The inherited absolute character/conductor amplification633 therefore gives less than844*2^-b. This error is independent of the original coefficient uncertainty in the logical sense that it is an additional deterministic term; no probabilistic independence is used. The screened finite-difference method may evaluate P_b at polynomial-only setup points outside the cell. This inequality is needed only at the actual in-cell output points. Exact arithmetic on setup values introduces no roundoff term.

With b=g=100, the final complex output rounding adds less than u_H=2^-100. The per-residue sum is below(7/3)u_H, hence the all-adapter character-summed allowance is below1477u_H. The old allowance was1688u_H, leaving211u_H of reserve. This is enough to preserve the old alpha targets without relying on the numerical size of their remaining slack.

The first-four-band exact comparison uses P27,330 shift updates, eta=2^-100 and the original two Taylor bounds. The final band uses the joint Dout8192 and P28 shift bound, with its delivered coefficient term844eta. I independently reconstructed both old and new rational sums and matched the saved fractions. The first-four bound is below one third of2^-82; the final bound remains below(4/25)2^-82. The m159 correction change does not alter these downstream formulas.

For b122, the extra quantization term844*2^-122 fits even on top of the old whole evaluation allowance. Independently checked inequalities give the stated first-band ratio below1/3 and final ratio below151867/10^6, which is below4/25. This is a separate permitted precision choice, not a reason to charge the b100 computation at b122 widths.

## Required mixed-schedule correction

I requested the frozen clarification because1477u_H is not the aggregate allowance for an arbitrary mixture with original Horner fallback. If E is the actual adapter subset and H the disjoint original-Horner subset, the correct evaluation bound is

    (7/3)u_H sum_E w_a + (8/3)u_H sum_H w_a <=1688u_H,

where w_a are the actual nonnegative absolute character/conductor weights and their total is at most633. When all residues use the adapter,1477 follows. Otherwise a claimed saving needs the actual subset weights. The old whole-alpha caps remain valid for every such mixture, and the clarification explicitly interprets the receipt rows accordingly.

The fallback must use the original center array. An unchanged rounded Horner evaluation of the b100-quantized polynomial would add its own old rounding error to the new coefficient error and would not satisfy the claimed replacement allowance. The author excludes that unintended combination.

## Widths, magnitude and cost

The coefficient cap survives by an explicit margin. The general source bound is4*(3*3387+5)+1=40665, the selected first-four bound is20661, and the joint final bound is6*(3*1500+7)+1=27043. Adding2^-b for either reviewed b leaves each strictly below2^16. Adding a tiny error merely to an unspecified strict2^16 bound would not suffice; that shortcut is not used.

At c=265800, (2c)^19 has362 bits. The b100 polynomial denominator has462 bits. The inherited pruned live/temporary capacities become499/500 signed bits, and the screened full-state capacities become500/501 bits. At final g100 the factor2^100 cancels and the final divisor has362 bits. Coordinate coefficient numerators fit117 signed bits. The b122 figures521/522,522/523 and384 agree with the earlier conditional width theorem. These are sufficient capacities, not minimum widths or measured costs.

The new cache charge is20 complex rounds, or40 real witness rounds, per distinct converted coefficient array. Actual input decoding, potentially finer input widths, exact shifts/divisions, certificate references and cache reconstruction are still charged. Sharing across conductors is valid only for the same height, anchor, normalization and exact coefficient object. The conductor-dependent prescales by(2c)^(19-j) remain separate. Coordinate ties toward positive infinity are not the same field as the nearest-alpha ties-down geometry rule.

No current receipt has supplied these coefficient arrays. A future checker must bind the original exact centers and their source theorem, prove all new coordinate witnesses, run the exact polynomial computation and check exhaustive target coverage. Ordinary-rule proof production and runtime remain open. No uncharged direct-grid specialization or wholesale ledger replacement is accepted here.

## Independent evidence

Own script `audit/review_residue_coefficient_grid_20261111.py`, SHA256 `579E94109910E08997C58A84562BE723EEBC523CD7A1E8E53A113B6FD59CB9B9`, passed2906 exact checks. Its receipt `audit/review_residue_coefficient_grid_20261111.json` has SHA256 `A50959BB891D8B66ABD3D5C6065282CB05332770924CE2DA5114EF7A77144449`. The script independently uses quotient/remainder nearest rounding on bounded synthetic dyadic and rational inputs, reconstructs all budget fractions and width bounds, and checks the mixed cap. It imports no author code and evaluates no analytic function or actual source coefficient.

Author script SHA256 `75E355AC1E89ADB76D1B9F2254C74E35C818852E9BE67B8504EFF4CBE0B84B93`; author receipt SHA256 `28206373F718F044394C5E2E34C193B300BECA3416FFC523E10AAA333565E0DE`. Both author documents and all six predecessor/source pins matched. Those six include scaled seed251B95AE, joint sourceAA1A7464, m159E6F0F3B2, selected P27579AAEC2, exact-circuit V2691A9B74 and its independent reviewA21A7B16; full hashes and paths are preserved in the independent receipt. This acceptance is conditional paper/source arithmetic only.
