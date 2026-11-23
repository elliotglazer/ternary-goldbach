# Degree-dependent grids for residue Horner evaluation

2026-11-11. Root-authored conditional arithmetic proposal. Independent review is required before acceptance. It refines the pending product-only-rounded Horner design. No actual source coefficients, analytic values, primes, transforms or builds are used. No saving is entered into the selected ledger.

## Objects and exact circuit

Use the degree-19 residue polynomial P(h) = sum z_j h^j from the reviewed source contract, with real h = r/v, v = 2c > 0, |h| <= 1/4 and c <= 265800. The delivered source coefficients have a quantified magnitude margin below 40665 in the general bound. The optional grid adapter's original-to-polynomial source errors remain separate from the new coefficient rounding. Its frozen source/error report is integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md, SHA256 9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4, with mandatory mixed-evaluator clarification B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815 and review 793AD4410778F45B39040F246B361E8877876ABA11083A2C9492288B2492B16D. This proposal proves a different coefficient adapter rather than claiming that the old uniform-grid theorem already supplies it.

Set u = 2^-100 and choose coefficient and accumulator exponents

    b_0 = b_1 = 100,
    b_j = 100 - j,  2 <= j <= 19.

For each coefficient, round both coordinates of the ORIGINAL z_j directly to the nearest grid 2^-b_j, ties toward positive infinity. Call the result z'_j = n_j / 2^b_j. Do not silently round an already rounded b100 array a second time. Direct conversion from the original encoding needs its own exact witness and actual input-width charge.

Initialize the accumulator A_19 = z'_19. For j = 18 down to 0, round h A_(j+1) coordinatewise to grid 2^-b_j and then add z'_j EXACTLY on that same grid, obtaining A_j. Each addition is an ordinary exact signed-integer addition. There is no addition round. The final A_0 is already on grid 2^-100 and needs no additional numerical round.

If a coordinate of A_(j+1) is M / 2^b_(j+1), define

    delta_j = b_j - b_(j+1) >= 0,
    X = r M 2^delta_j.

The rounded product coordinate is L / 2^b_j. Prove L by the nearest integer relation to X/v, for example the single signed product p = Lv and residual range -v <= 2(X-p) < v. The accumulator numerator is then L+n_j. Here delta_0 = 0, delta_1 = 2, and every delta_j for 2 <= j <= 18 is 1. The exact shifts and all signed arithmetic/proof bindings are charged.

## Error proof

Nearest coordinate rounding to grid 2^-b has complex Euclidean error at most sqrt(2) 2^(-b-1), strictly less than (3/4)2^-b because 2 < 9/4. This uses an explicit rational bound on the complex norm, not an assumption that a complex round costs one coordinate error.

The coefficient perturbation at an admitted output is less than

    (3/4) sum_(j=0)^19 2^-b_j |h|^j.

Let e_j be the product-round error at stage j. Exact additions give A_j = z'_j + h A_(j+1) + e_j. Expanding this identity gives arithmetic error sum_(j=0)^18 e_j h^j relative to the polynomial of the new coefficients. Therefore its norm is less than the analogous sum through 18. The initial coefficient has no separate accumulator round.

At |h| <= 1/4 the two weighted sums have the exact bounds

    sum_(j=0)^19 2^(100-b_j) 4^-j = 7/4 - 2^-19,
    sum_(j=0)^18 2^(100-b_j) 4^-j = 7/4 - 2^-18.

Consequently the combined coefficient-conversion and arithmetic error is less than

    (3/4)(7/2 - 3*2^-19)u < (21/8)u < (8/3)u.

The old per-residue evaluation allowance is preserved. The rational reserve against 8/3 is greater than 1/24 of u. There is no independence assumption between errors. At the inherited character/conductor amplification of at most 633, the coarse new allowance is less than 13293/8 times u, below the old 1688u. In any mixture with original-center Horner or another independently bounded evaluator, use subset weights or retain the old whole-band cap. Source approximation, coefficient uncertainty, analytic shift bias and target Taylor tails remain unchanged.

## Magnitudes and sufficient widths

All b_j are at least 81, so direct coefficient conversion adds less than one in norm. The quantified source margin therefore retains |z'_j| < 2^16. The largest product-round error is less than one as well. Starting from A_19, induction using |h| <= 1/4 shows |A_j| < 2^17 for every stage. Thus each coordinate accumulator numerator has magnitude below 2^(b_j+17) and fits b_j+18 signed bits. These are sufficient capacities, not observed values or a particular machine encoding.

At stage j, |r| <= c/2 <= 132900 < 2^18. Therefore the unrounded shifted numerator obeys |X| < 2^(b_j+35) and fits b_j+36 signed bits. The sharper |h A_(j+1)| < 2^15 and nearest coordinate rounding imply |L| < 2^(b_j+16), so L fits b_j+17 signed bits. The coefficient numerator is below 2^(b_j+16). Their raw sum fits b_j+18 signed bits, consistent with the accumulator invariant.

The divisor v has at most 20 bits. The signed witness product Lv fits b_j+37 signed bits. A conservative temporary for X-Lv fits b_j+38 signed bits, and doubling it before checking the range fits b_j+39. The accepted residual is much smaller, but that does not justify narrowing its operands before subtraction. A half-divisor range can avoid the doubling after proving v=2c. The optional choice does not remove the multiplication or order proof.

Compared with uniform b100, the sum of the twenty coefficient/accumulator fractional precisions is 1811 instead of 2000. Across the nineteen output-stage precisions it is 1730 instead of 1900. These are representation sums only. The circuit still has nineteen real-times-complex products, nineteen exact complex additions, nineteen complex product rounds and twenty complex coefficient conversions per distinct converted array. Actual operand byte/limb lengths, shifts, witnesses and cache lifetimes decide any runtime or proof-size change. The highest stages may remain within the same native limb count.

## Binding, reuse and acceptance

Bind the degree-indexed grid vector, original coefficient objects, direct conversion witnesses, tie rule, height/anchor/normalization, conductor displacement and complete unit coverage. A converted array may share across consumers of that identical source object; different source arrays or reconstructions pay separately. Existing uniform-grid data are not interchangeable without a checked conversion and its added error. The old selected ledger is unchanged.

This is a full error and sufficient-width argument for a candidate ordinary-arithmetic circuit. It still requires independent review, a generic formal soundness theorem, actual records and ordinary-rule arithmetic proofs. It establishes no actual sign, spectral count, Lean/MM0 runtime ratio or end-to-end cost reduction.

## Bounded scalar evidence

The companion script passed 92 exact rational/width and source-pin checks. It evaluated no coefficient or analytic function. The combined scalar error factor is 5505015/2097152, strictly below 21/8. These checks support the written argument and do not replace its independent review.

degree_horner_precision_checks_20261111.py SHA256 DD79FB92239C33508EA8C707A491DD4822DD8C5D977A1D67989F77451FBAB4EE

degree_horner_precision_checks_20261111.json SHA256 82C68F3E3445E4594076BD411EDAC6421A9276B9878C385CCAD90322B8C32A6A

