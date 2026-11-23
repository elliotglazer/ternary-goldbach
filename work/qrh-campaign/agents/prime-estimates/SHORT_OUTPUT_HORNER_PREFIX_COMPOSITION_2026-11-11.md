# Short output orders with the three fixed Horner profiles

2026-11-11. Conditional paper and exact metadata composition. This packet reads saved source envelopes, fixed profiles and band unit totals. It performs no new profile search, conductor/unit enumeration, coefficient evaluation, prime/zero computation or build. The source/Pascal production schedule remains unchanged. No finite-difference circuit or selected production ledger is changed.

The three existing profiles remain valid when restricted to an admitted K-coefficient prefix. The shortened highest coefficient has one conversion error and no product-round error. The new circuit has exactly K-1 Horner stages. Recomputing its magnitude recurrence confirms that the removed high-degree products are relatively cheap in the declared ordinary-PA multiplication model. Their removal is not a proportional reduction in whole-evaluator work.

## 1. Source and output objects

SHORTER_HURWITZ_OUTPUT_ORDER supplies the admission inequality

    1266*((|t|+K)/(4D_out))^K/K! + S_class + N_class <2^-82.

It retains the old P27/P28 finite-shift remainder and numerical budgets. Its output is the prefix of the ACTUAL stored finite translated coefficient vector, followed by a newly justified Taylor approximation of length K. Those stored coefficients are not identified with true fine-anchor derivatives. The principal channel, finite a^-s head, conductor scaling, character transforms, height interpolation, repairs and completeness remain outside this isolated alpha estimate.

The five bandwise constant lengths used for counts below are19,19,19,20,18. The first four are valid at the declared band tops. The final18 is valid only on the actual requested grid ending at j=84839 in the largest existing extra-node scenario, with t=5j/64; it is not valid at the full declared V7000 cap under this sufficient estimate. Integration's frozen independent shorter-output review confirms all four actual endpoints and this K18 admission. Its exact pin is recorded below.

All20 source outputs and the original finite translation circuits remain available and charged. This packet consumes a prefix. A coefficient conversion may be shared only for an identical original stored coefficient and grid, within the actual checked-context lifetime. It cannot be treated as free because another residue uses a similar anchor.

The new evaluated center is generally different from the old20-coefficient center. Its full new error radius must propagate through the remaining L-function assembly and sign test. Neither a previously successful sign nor a saved narrower radius transfers merely because the source coefficient prefix is shared.

## 2. Prefix conversion and evaluation error

The fixed profiles, in degree order0..19, are

    uniform100 = [100]*20;
    root_linear = [100,100,98,97,96,95,94,93,92,91,
                   90,89,88,87,86,85,84,83,82,81];
    fixed_15442 = [100,100,100,100,97,95,95,95,89,87,
                   87,87,81,79,79,79,71,71,71,71].

For length K, take their first K entries. Directly convert each original stored complex center z_j to grid2^-b_j by coordinate nearest rounding. Let e_j=(3/4)2^-b_j, a strict bound on the resulting Euclidean error. Do not first convert to b100 and then incur an uncharged second conversion.

Initialize from the converted coefficient of degree K-1. For j=K-2 down to0, round the product by the exact rational h=r/v, |h|<=1/4, to grid b_j and add the converted coefficient exactly on that same grid. There is no initial product round and no final round after the degree-zero addition. Monotonicity b_j>=b_(j+1) permits the exact alignment shift used by the existing circuit.

The error relative to the original stored prefix polynomial is bounded strictly by

    E_K = sum_(j<K) e_j 4^-j + sum_(j<K-1) e_j 4^-j.       (1)

The highest conversion e_(K-1) occurs once. All lower conversions and product rounds occur twice in the weight sum. For K<20,

    E_20-E_K = e_(K-1)4^(-(K-1))
              +sum_(j=K)^19 (2 if j<19 else1)e_j4^-j >0.

Thus every admitted prefix of each existing profile still has E_K<(8/3)u, u=2^-100. This includes the weight change at the NEW top, rather than merely deleting omitted high-degree terms from an otherwise unchanged error formula. The original character amplification633 gives633E_K<1688u. This replaces the existing evaluation allowance, not an additional allowance on top of it.

The receipt checks all K=10..20, covering every length selected by the shorter-output metadata. Selected error bounds in units of u are:

|Profile|First-four K19|Final K18|
|---|---:|---:|
|Uniform100|549755813883/274877906944|137438953467/68719476736|
|Root linear|2752503/1048576|1376247/524288|
|Fixed15442|2619/1024|2589/1024|

All are strictly below8/3. The source coefficient uncertainties, finite translation bias and target remainder remain separately paid by the shorter-output contract. In particular, using K18 in the final band spends some former slack below.16*2^-82 while retaining the required2^-82 interface. A consumer requiring that stronger historical fraction cannot use this substitution without another check.

## 3. Stored degree envelopes and the changed first product

Use exactly the reviewed stored-center bounds Z_j from STORED_HURWITZ_DEGREE_MAGNITUDE, including numerical source errors. They bound finite translated centers, not merely ideal Hurwitz jets. The large Z0 enters only the final exact addition. None of the product inputs is bounded using Z0.

For each profile and K, recompute

    C_j=Z_j+e_j,
    A_(K-1)=C_(K-1),
    T_j=A_(j+1)/4+e_j,
    A_j=C_j+T_j, j=K-2,...,0.                         (2)

The initialization in(2) matters. The old degree19 accumulator A_(K-1) included contributions from omitted higher coefficients and was not the new initial coefficient. The receipt independently recomputes every stage for each prefix and checks its magnitude is no larger than the corresponding old accumulator.

At stage j write the input coordinate as M/2^b_(j+1) and set delta=b_j-b_(j+1). The exact nearest-round witness is

    X=r*M*2^delta,
    -v<=2(X-Lv)<v.

The two unsigned product proofs are r*M BEFORE the shift and L*v. Bounds are |r|<=132900<2^18, v=2c<=531600<2^20,

    |M|<2^b_(j+1) A_(j+1),
    |L|<2^b_j T_j.

The script records strict power-of-two caps for both variables, each shifted numerator and witness product, their raw residual sum bound, its double, and the final exact coefficient addition. It does not borrow the small accepted residual before proving the witness. Signed wrappers and the nearest-tie comparisons remain required. The closed lower and open upper endpoints handle negative ties toward positive infinity.

For K19 in the first class, the initial converted coefficient has respectively57,39,28 sufficient signed bits for uniform, linear and fixed profiles. For K18 in the final class, the corresponding widths are53,36,24. These are the new top-copy widths; they do not arise by retaining a generic initial width or reusing an old top stage.

## 4. Matched multiplication subtotal

Use the already reviewed possible ordinary-PA byte-schoolbook template

    M(m,n)=5mn+2n+1,

with the smaller byte length as the row count n. Per complex stage charge two coordinates times the r*M and L*v proofs. If a variable operand has fewer than3 bytes, reverse the rectangular orientation rather than forcing the narrow fixed factor into the row position. Exact shifts, additions, signed wrappers, range proofs, quotient discovery, residual comparisons, source conversions, numeral representation, binding and storage remain separate.

The full20 rows reproduce the independently reviewed degree-envelope repricing exactly. The selected shorter rows are:

|Profile|First class K20|First class K19|Difference|Final K20|Final K18|Difference|
|---|---:|---:|---:|---:|---:|---:|
|Uniform100|12562|12114|448|11872|11096|776|
|Root linear|11272|10974|298|10552|10076|476|
|Fixed15442|10702|10494|208|9970|9656|314|

These are per-polynomial unsigned multiplication-template events, not executed opcodes, bytes or times. The first class K19 is used for bands1–3; band4 retains K20. For these selected shorter rows, recomputing the retained accumulators changes no byte-level product subtotal on the retained stages. The displayed differences are exactly the deleted high-stage costs. This equality is checked, not presumed. The saved initial-stage widths nevertheless change as described above.

The removed first-class fixed-profile stage costs208 events, versus an old per-stage average10702/19. The two removed final fixed-profile stages total314, versus two times the old average9970/19. This demonstrates why one or two fewer stages do not produce the same fractional multiplication saving as uniform-stage counting would suggest. Nothing here ranks full ordinary-MM0 checking against Lean kernel numeral arithmetic, nor predicts whole-evaluator speedup.

The K19 first-class prefixes retain0,17,7 nonzero shifts with total distances0,18,29. The K18 final prefixes retain0,16,7 nonzero shifts with distances0,17,29. These are alignment requirements before any proved divisor cancellation; they are not priced as free. Every polynomial has K-1 complex product rounds, K-1 exact complex additions,4(K-1) real product proofs in this model, and K direct coefficient conversions per distinct converted source array. Conversion reuse and all20 source-generation costs remain separate.

## 5. Exact counts from saved band totals

Only the frozen LARGE_RESIDUE_BUCKET_OCCUPANCY receipt is read for unit-residue/height totals. Its two conductor-parity cohort totals are added in each band. No conductor loop, totient calculation, residue scan or reconstructed height inventory is run. Let U_i be that saved number of unit-residue/height inputs. For the constant admissible lengths19,19,19,20,18, the exact new stage count is

    18U_1+18U_2+18U_3+19U_4+17U_5.

The old count is19 sum_i U_i. The difference is U_1+U_2+U_3+2U_5. These are counts for a deliberately conservative constant length per band, not counts for the finer per-height selector.

Main-scenario band details:

|Band|Saved U_i|K|New stages|Removed stages|
|---:|---:|---:|---:|---:|
|1|44637243437690|19|803470381878420|44637243437690|
|2|10919369148972|19|196548644681496|10919369148972|
|3|3364154098594|19|60554773774692|3364154098594|
|4|1007584876992|20|19144112662848|0|
|5|33710391000|18|573076647000|67420782000|

The four saved extra-node scenarios give:

|Extra nodes|Old stages|New stages|Removed stages|
|---:|---:|---:|---:|
|0|1139279177111712|1080290989644456|58988187467256|
|167|1161912234442848|1101748834505028|60163399937820|
|320|1182647909722272|1121408081109366|61239828612906|
|640|1226016642332832|1162526298064904|63490344267928|

All per-band data for all four rows are retained in the receipt. Extra nodes remain requested guard scenarios, not successful Turing extensions. Constant K is shared across all three grid profiles, so these stage totals are the same for each. Their stage widths and multiplication prices are different.

The saved band totals do not determine how many unit inputs occur in each smaller within-band K interval. Therefore the sharper height-dependent weighted count is left unresolved. It would require an already saved suitable height-prefix total or a separately authorized metadata derivation. The exact number of requested points must not be substituted for the number of unit-residue inputs.

No FD counts are inferred. Degree19 initialization/traversal is a different circuit, and a degree K-1 version needs its own proof, widths and setup prices. No corresponding source-array, transform or complete-evaluator saving is added to the stage subtraction above.

## 6. Evidence and acceptance status

Owned script short_horner_prefix_composition_20261111.py, SHA256 `B7625DA3DD556966A009FFD2E884D952F93B288F0157B049FFDDD6E784F26969`; JSON of the same stem SHA256 `99671C5858B20FF3940186D33CCFB19E730C9D364FF3B3EB5B2E6B8641F399FE`. All17061 exact checks pass. They cover66 prefix/profile/class cases, the exact error reduction identity, all stored-degree recurrences and raw capacities, agreement with the six accepted full20 subtotals, and all saved band/scenario stage identities. The writer creates a new receipt and refuses to overwrite it.

The input hash manifest is retained verbatim in the script and receipt. Principal pins are SHORTER_HURWITZ_OUTPUT_ORDER `0EAED4F960DFC4F590564A9B8A86E9C22BB621FCE362CCAB7A13D2D3976A1D2A`, its receipt `4385975F56DE8CA2E4B42319DA3B0A2F5F1EB38C4520772F0E8BFC9602692B38`, stored-degree receipt `E947C32ED8EA30BA14ED64A7DFF83AA1C8E3F3F222AAD1AD8DAA8484013781BE` and independent source review `1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6`. Fixed full20 repricing is moebius/FIXED_HORNER_DEGREE_ENVELOPE_REPRICING `96734A7E4A0C93857EE538A59890451C40644AAAA0D0F07FE9D82B936509C0D3`, receipt `4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9`, independently reviewed at `57D7DEDBA4D5497861DD641F4CC68416CA89EEAD0358F2151DA005ABCE319468`. Saved occupancy receipt is `19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB`, review `C6096D0C677E09F850065EDD2103B0348E28392D482CCEE568136B387768C86E`. Fixed profiles come from the original grid receipt `9BA037D7AAFB7A0F053C109ABD9751112B586805236A14D9467EFD29B32871CE`.

The final endpoint/admission gate is now supplied by integration/REVIEW_SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md, SHA256 `B15D0C3B15B8005A6B3DC3CFE1A1CDE157448B83904950487CD124F87647536E`, read in full and hash-checked after this packet's scalar receipt was written. It independently reconstructs all95 thresholds and derives the four last indices from the actual height profiles. The receipt's field recording that review as a requirement is preserved; this pin discharges that requirement without changing the metadata. The review also checks that the2^-82 successor requires new full radius propagation and gives no inherited sign success.

This is a fixed-grid comparator, not an optimized selection. A longer output polynomial may allow a coarser common grid by spending less of the alpha budget on its target remainder; that could reduce the cost of many lower-degree stages. Such a joint order/precision tradeoff is outside this receipt. In particular, a grid shift below70 fractional bits must recompute the stored-coefficient rounding and accumulator bounds rather than consume the prior all-grids-at-least70 envelope.

This composition's independent review remains required before adoption. Actual finite data, ordinary-rule implementations, full priced proof comparisons and final spectral acceptance remain outstanding.
