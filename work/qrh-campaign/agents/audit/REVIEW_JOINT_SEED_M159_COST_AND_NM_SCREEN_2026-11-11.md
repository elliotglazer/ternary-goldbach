# Review of the m159 cost supplement and bounded N/m screen

2026-11-11. PASS for conditional cost algebra and the stated bounded scalar screen. No correction requested. Only N1500/m159 inherits the complete analytic construction approval; the other screened pairs do not.

The reviewed author report is `independent-feasibility/JOINT_SEED_M159_COST_AND_NM_SCREEN_2026-11-11.md`, SHA256 `463E5617A73FC661D2F7229026F1F6A584298C7190767D3D58E5AAEAC9A3640F`. Its script is `D91EC28FD860780C95412B13F8C4167E0EB364B8490D6A9FD71D0567D6185F93` and receipt is `DDF48DE42BBB771591E25ABA23327A8B283DDE84DABD8F609ABB348E5A291BB2`. Paths in this report are relative to `work/qrh-campaign/agents` unless prefixed otherwise.

## Independent reconstruction

I read the full report and scalar script, the previous conditional cost comparisons and the accepted m159 construction. The companion `audit/review_joint_seed_m159_cost_screen_20261111.py` independently reconstructs category counts from interior and endpoint work, all four final-height scenarios, setup differences, and all seven bounded N/m searches. It imports no author program. It uses a binary search for the least strict integer root upper bound, independently of the author's `isqrt` implementation. The result is 1437 passing exact integer/rational checks.

The accepted m159 row has 165928500 head scales, 172074000 head additions, 18239844 gamma scales and the same number of gamma additions, and 1409368 E stages per height. Relative to m256 it deletes 11127452 operations from each gamma category and 794818 E stages. Translation, source slots, normalization and retained-state work remain unchanged. The final argument count is 6148097. The union remains 7049217, with 901120 retired and no introduced states. A retirement does not remove the first update of each retained state.

Every B/Q/C comparison in section 2 equals the signed difference of its reconstructed row and the m159 row. The setup correction subtracts the introduced-state first-update count from the ordinary per-height count. In particular, the coefficients of `i-s` are 12513280, 2732032 and 6148096. The log-stage differences are 262778019, 57371790 and 148033557; the log-anchor differences are 41, 42 and -1. The C comparison must retain `Gamma_256-Gamma_159`, which no longer cancels. The author does retain it.

These are exact inequalities under the declared common nonnegative category-price model. They are not comparisons of implementations with different operand widths or theorem costs. `Gamma_m` denotes the full certified setup cost, including the actual constants and their proof work. It cannot be replaced by a constant price times the number of Bernoulli entries without further evidence.

## Screen and proposed next pair

For each of the seven N values I checked every integer m from 64 through 256. The strict squared inequalities give the stated W and S, including perfect-square cases. The remainder comparison is an integer-power comparison equivalent to

`8*S/(4*m-1) * (W/(6*(N+1)))^(2*m) < 2^-116`.

The scaled-factor condition and the conservative E ratio also hold at every reported first-passing row. The resulting pairs are exactly 1400/220, 1450/184, 1500/159, 1550/141, 1600/127, 1660/114 and 1720/104. This is minimality only for this sufficient remainder test and the enumerated m range. It is not a proof of optimal correction order or of an optimal N.

The actual normalized finite-EM remainder justifies this sufficient test through the already reviewed Euclidean rising-factor estimate. It does not alone certify the N-dependent head, endpoint, accumulated correction, magnitude, translated-output or final-alpha error budgets. The report explicitly leaves those checks open for the six alternatives to the accepted row. Its opening recommendation of N1450/m184 is therefore a conditional research choice, not a Pareto or runtime optimum.

For N1450/m184 the independently reconstructed differences are -5530950 head scales, -5735800 head additions, +2867900 gamma scales and separately additions, +204850 E stages, and -204800 retained updates and separately EM copies per height. All other displayed categories agree. Both grids introduce zero final states, so the price inequality needs no introduced-state adjustment. The extra gamma setup through Bernoulli index 368 must remain. Section 4's inequality has the correct signs and exactly characterizes a saving within its common-price model after a complete analytic approval.

## Evidence and limits

The independent script has SHA256 `D87E9565CC27EB1C89A9C24F274693AAD2A9F399622F014060ED12B8C8F16308`. Its receipt `audit/review_joint_seed_m159_cost_screen_20261111.json` has SHA256 `76488C9A90B69FBA6844B8B316537108809A20F2F2442CCB090D8A0F7F8D3F6A`. It verifies the three author pins and six input pins and records all reconstructed rows and differences.

The complete m159 analytic approval remains `audit/REVIEW_JOINT_SEED_159_CORRECTIONS_2026-11-11.md`, SHA256 `09DEF5ABB358A807936270B07E61FFEE624EF0F04C3E17AC47A1179D944E2E82`, bound to root author `E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9`. No frozen predecessor was edited. No analytic values, spectral data, builds or Lean/MM0 declarations were produced. Actual numerical certificates, their acceptance, proof costs and spectral completeness remain separate obligations.
