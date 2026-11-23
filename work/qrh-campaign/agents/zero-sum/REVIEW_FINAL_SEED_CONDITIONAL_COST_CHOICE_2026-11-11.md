# Review of the three-way final seed cost choice

2026-11-11. PASS at conditional paper and integer-metadata scope. No correction requested. The cost-difference signs, lifetime subtraction and all three break-even inequalities are correct. This verdict does not select a runtime winner or certify actual analytic values.

The reviewed author note is `independent-feasibility/FINAL_SEED_CONDITIONAL_COST_CHOICE_2026-11-11.md`, SHA256 `DEB728C9991A4B906B49D65651CD8E6C994CF814C0091809A3CB7138A157D1B2`. Its script is `A5A5C7E2F4B88CB2C5A939B1D168B0559874C93E3AB0E417622CDB8AA97947E8` and receipt is `7E8ABFDC0F2A212B975738DE94D17448F8A6C9EA597D3203A01933A4FB8882E9`. Paths here are relative to `work/qrh-campaign/agents/`.

## Independent reconstruction

I read the complete note and code, then reconstructed every per-height row by counting the retained orders at each anchor. B and C keep27 orders at8192 anchors and20 at the last endpoint. Q keeps28 at all4097 anchors. Summing these actual order counts, one fewer reciprocal-power update per anchor, and the E indices gives the stated head, correction, E, slot and anchor counts. Counting the Pascal-loop updates gives330 per B/C midpoint and350 per Q shift, with three Q shifts per coarse interval. The finer output has327700 slots. Q's final scale and final round remain distinct operations, even when represented by their combined price n.

The same H=20839 final heights and J=84840 total heights are used in every row. The last height is424195/64<7000. Thus the algebra does not credit Q with the larger old component prefix or C with fewer target heights.

Let X_i be route i's active final argument count and I_i the number introduced at the transition. At the first final height, X_i-I_i retained states update and I_i new states initialize. Each of the remaining H-1 heights updates all X_i states. Therefore the exact final update count is

`(X_i-I_i)+(H-1)X_i = H X_i-I_i`.

The previous grid has7049217 points. Intersections with the final B,Q,C grids have7049217,7049217,6148097 points respectively. These give I_B=12513280, I_Q=2732032 and I_C=6148096. C's901120 retired states are neither reinitialized nor updated in the final band. The union is the common previous set plus I_i, so union differences equal introduction differences. This equality would not automatically hold if the earlier bands differed.

## Sign and setup audit

Using the author's symbols, let L_i contain all listed per-height work except state updates and EM copies. Then the full modeled cost, after omitting common earlier work, is

`C_i = S_i + H L_i + (H X_i-I_i)s + H X_i c`.

Consequently

`C_i-C_j = H[L_i-L_j+(X_i-X_j)(s+c)] + F_ij`,

`F_ij = S_i-S_j-(I_i-I_j)s`.

This proves the negative sign on the introduction correction. Positive F_BQ increases the allowable Q transport bill, since it means B has more fixed net cost. Dividing by positive H gives the displayed F/H signs. Direct coefficient comparison verifies all three printed inequalities, including the extra Q R stage,1597440 translations and327700 scale-plus-round pairs. Strict inequality describes strictly lower modeled cost; equality is a tie.

For the optional simple setup model, the union/introduction difference is9781248 for B-Q,6365184 for B-C, and3416064 for C-Q. The log-stage differences are205406229,114744462 and90661767; anchor differences are-1,42 and-43. Q alone pays the extra lambda setup, while C alone pays the extra gamma setup. These facts give exactly the three printed expansions in `(i-s)`, l, z, Gamma and Lambda. Gamma is correctly a total certified setup bill, not192 equal-cost operations. The unusual negative anchor terms reflect different block layouts rather than nested anchor sets.

C's log work covers14098433 points although its required state union has13197313. This overcomputed log setup is explicitly charged. Substituting the smaller union into that log count without a new log construction would be invalid. Conversely, none of the901120 retired states receives final-band updates.

## Scope qualifications retained

The inequalities are exact for a common per-category price model. Equal fractional error targets do not imply equal operand widths, arithmetic cost, proof size or wall time. A sufficient upper bound on each route's cost also does not establish their cost ordering by subtracting the bounds. When prices depend on route, height, order or actual representation, the valid test is the difference of the complete weighted sums, including setup, data movement, proof bindings, generation and checking. Those objectives need separate prices.

Residual slot and anchor prices must exclude already charged operations. Similarly, setup must not count the same log, initialization or step certificate twice. Existing pi or gamma data cancel only if they are genuinely shared. The no-values paper contracts do not establish successful output enclosures, an implementation, old-box containment or performance.

The author's first-candidate recommendation is thus conditional guidance, not a proved dominance statement. In particular the equality of sufficient error exponents does not close the intermediate-width obligations.

The new joint D4096/N1500 route was properly excluded from the frozen three-way proof. It has since received a separate joint mathematical review. A separate cost supplement may add that fourth row; doing so is not a correction to this note and does not make the joint route a measured winner.

## Evidence

`zero-sum/review_final_seed_cost_choice_20261111.py`, SHA256 `C1597AAC64043CD204B545C59469E38D969FAD37AB2662F96692B69463576633`, passed166 independent exact integer checks. It imports no author script or evaluator. It verifies the author pins and nine prerequisite/data pins, all reconstructed rows and totals, transition intersections, differences and the cost identity on basis price vectors. Its receipt `review_final_seed_cost_choice_20261111.json` has SHA256 `A036E25A7F6F9D9F37DCD907531BC4A2DD790E6293AB6F862870FEC3F9DA96D6`.

The analytic validity of the three component error contracts is reused from their pinned independent reviews, not re-proved by these metadata checks. I authored the original quarter-mesh component; its independent acceptance is the prime-estimates review `8D50DDB6C7398D10930F8437ABE9B3E0C672F9AD1F85851D040EF1BD6D385B6A`. No new analytic evaluation or build was performed, and no frozen author file was changed.
