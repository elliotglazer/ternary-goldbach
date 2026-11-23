# Independent review: fixed-grid shorter Horner prefixes

2026-11-11. **PASS at conditional paper and exact-metadata scope; no correction requested.** Reviewed author `prime-estimates/SHORT_OUTPUT_HORNER_PREFIX_COMPOSITION_2026-11-11.md`, SHA256 `716B9E5FFE726D629E97F2CA85CA972D351051A209CB0D5DC0B6CAC21F60C98B`. I read the full note and script, the stored-degree source and its independent review, and the earlier full-degree repricing and review. I independently reconstructed all66 prefix/profile/class cases and all saved band counts without importing or executing author code.

This is a composition of three fixed profiles with output grid b0=100, not a claim that every coefficient grid equals100. It does not optimize the joint order/precision choice, select a production circuit, or establish an end-to-end saving.

## 1. New top copy and complete error

The actual consumed polynomial is the first K entries of the stored finite translated vector. It is generally a different polynomial from the former degree19 output. Its actual-function target and finite-shift error are those of the independently reviewed shorter-order packet; no fine-derivative identity for the stored coefficients is introduced.

For each profile, let `e_j=(3/4)2^-b_j`. Coordinate nearest rounding directly from the original stored center gives complex norm error strictly below e_j. Each new highest coefficient at degree K-1 incurs this conversion once and is copied into the accumulator. It incurs no product round. Every lower degree has one product round to its destination grid and one direct coefficient conversion, followed by an exact addition on that grid. There is no final rounding after the degree-zero addition. Consequently

    E_K = sum_(j=0)^(K-1) e_j4^-j
             +sum_(j=0)^(K-2) e_j4^-j.

The difference from E20 includes one removed round at the NEW top, in addition to the omitted higher-degree terms. I verified this identity for every K10..19 in all three profiles. All66 error envelopes are strictly below `(8/3)2^-100`; amplification633 therefore stays below1688*2^-100. This replaces the inherited evaluation allowance. The source coefficient uncertainty, analytic shift and target remainder are separate and unchanged, except for the already reviewed new K-dependent target bound.

A variable-grid array must be rounded directly from the original stored centers. An uncharged intermediate b100 conversion is not authorized. Reusing a conversion requires the exact source-object identity, grid and checked-context lifetime. Source20-slot generation remains charged even when only a prefix is consumed.

## 2. Actual stored-coefficient bounds and stage capacities

I reconstructed the source rational envelopes, rather than treating the author's copied Z values as unexplained inputs. For `u=2^-100`, `W=4u+330*2^-110` and `Eflat=2^27(u/4+330*2^-110)`, they are

    Z0(first)=5170+2^-116+W,
    Zj(first)=6(5/4)^j/j!+min(4^j W,Eflat), j>=1;
    Z0(final)=4507+9/2+2^-116+u,
    Zj(final)=(15/2)(7/8)^j/j!+u, j>=1.

These bound stored finite-polynomial coefficients, including numerical source error. The independent stored-degree review `10281561...` supplies the underlying source argument; this review does not replace that separate acceptance. Analytic shift bias remains an actual-function error, not an omitted part of these magnitude bounds. Z0 enters only the final exact addition.

For every prefix I independently used the expanded formula

    A_j=sum_(k=j)^(K-1)(Z_k+e_k)4^(j-k)
            +sum_(k=j)^(K-2)e_k4^(j-k),
    T_j=A_(j+1)/4+e_j.

This differs from the author's backwards-loop computation and agrees with every saved accumulator/product bound. In particular `A_(K-1)=Z_(K-1)+e_(K-1)`, without the old higher-degree contributions. Each new bound is no larger than its corresponding old degree19 bound.

The actual integer stage is `X=rM*2^delta`, `delta=b_j-b_(j+1)>=0`, with nearest witness `-v<=2(X-Lv)<v`. The denominator v=2c is positive. These endpoints implement ties toward positive infinity for negative and positive inputs. I checked all recorded input/output grids, exact shifts, magnitude bytes, signed raw product and shifted-product capacities, witness-product capacities, raw residual and doubled-residual capacities, and final exact-add capacities. Raw residuals are bounded before using the accepted small remainder. No shift or comparison cost is hidden inside the multiplication subtotal.

The K19 first-class initial copies require57,39,28 sufficient signed bits for uniform, linear and fixed profiles. The final-class K18 copies require53,36,24. These are recalculated top bounds, not inherited old stage19 widths.

## 3. Matched product subtotals

The declared unsigned byte-schoolbook model is `M(m,n)=5mn+2n+1`, with the smaller byte length used as n. Both products rM and Lv are charged for each coordinate. When the variable operand drops below three bytes, the orientation changes. This is a possible ordinary-PA template-event count, not executed MM0 instructions or Lean reduction timing.

|Profile|First class K20|First class K19|Final class K20|Final class K18|
|---|---:|---:|---:|---:|
|Uniform100|12562|12114|11872|11096|
|Root linear|11272|10974|10552|10076|
|Fixed15442|10702|10494|9970|9656|

All six full20 baselines match the independently accepted repricing. For the selected shorter rows, the retained stages have unchanged byte-level product prices after their magnitudes are recomputed. The differences448/298/208 and776/476/314 are exactly the removed high-stage subtotal. The high stages are cheaper than the old average: multiplying an average stage cost by the removed stage count would overstate this modeled reduction.

I also checked every selected alignment count and distance. First-class K19 retains0/17/7 nonzero shifts with distances0/18/29; final K18 retains0/16/7 with distances0/17/29. Quotient discovery, signed wrappers, ranges, residual comparisons, additions, exact shifts/cancellation proofs, coefficient conversions, numeral encoding, bindings, setup and storage all remain separate. A reduction in this subtotal is not a complete proof/checking or runtime comparison.

## 4. Saved unit weights and actual final endpoint

The packet uses K19/19/19/20/18 as conservative constant lengths by band. My prior shorter-order review `B15D0C3B...` independently derives all four requested endpoints from the actual combined height formula and proves that the largest final index84839 lies below the K18 threshold89533. K18 is not admitted at the entire declared V7000 cap by that envelope. This bound applies to every shorter conductor prefix and to negative heights through absolute value. It does not assert that any requested auxiliary extension succeeds.

I read only the saved occupancy receipt. Each band has exactly two disjoint conductor-parity cohorts, odd and even; their `unit_outputs` add to U_i. These are already height-weighted unit-residue inputs, not primitive character outputs, bucket counts or an unweighted conductor population. No height factor is applied again. No conductor, unit or prime scan was performed.

The new stage count is `18U1+18U2+18U3+19U4+17U5`; subtracting from `19 sum U_i` gives `U1+U2+U3+2U5`. All20 band records, their real-product-proof counts and all four scenario totals match:

|Extra nodes|Old stages|New stages|Removed stages|
|---:|---:|---:|---:|
|0|1139279177111712|1080290989644456|58988187467256|
|167|1161912234442848|1101748834505028|60163399937820|
|320|1182647909722272|1121408081109366|61239828612906|
|640|1226016642332832|1162526298064904|63490344267928|

The saved totals do not resolve the finer within-band K distribution. No such weighted saving is inferred. These stage counts apply equally to the three profiles, but their widths and prices differ.

## 5. Retained boundaries and evidence

All source P27/P28 production, full330/350-update translations and20 delivered slots remain. No source work, character transform, finite head, phase, interpolation, repair or count cost is deducted. Degree19 finite-difference counts are not used: changing the output polynomial degree needs a new circuit instantiation, unlike truncating the state orders of an unchanged degree19 polynomial.

The required alpha interface remains `2^-82`, not the old achieved final fraction `.16*2^-82`. New polynomial centers and complete radii must flow through the actual L/Y/sign assembly. No previous successful sign or narrower saved enclosure transfers automatically. The old cost ledgers are preserved, not silently relabeled.

Independent script `integration/check_short_horner_prefix_review_20261111.py`, SHA256 `13D288B651926C2979B886722512D89B30470F194957DC14A7F11C7EAD6FAB28`; receipt `integration/short_horner_prefix_review_20261111.json`, SHA256 `C94BC596FAFF14839C929576ACB376B93846FE30DE04069722A10CD6CA2D5C55`. All34515 exact checks pass. The receipt pins15 artifacts, including the author, script/receipt, ten author inputs, the shorter-order independent review and the stored-degree source. It reconstructs Z, expands all66 prefix bounds, checks every recorded stage field and all20 saved band records. Author script `B7625DA3...` was read but not run. No analytic/coefficient values, production computation, builds or source edits occurred.
