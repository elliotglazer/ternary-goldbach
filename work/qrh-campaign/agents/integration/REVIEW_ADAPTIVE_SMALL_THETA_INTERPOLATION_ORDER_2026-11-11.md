# Independent review of variable small-theta interpolation order

2026-11-11. PASS at the stated paper, error-allocation and exact metadata scope. No correction requested. No function values, transforms, prime/zero candidates, builds or source edits were performed.

## Bound proposal and review scope

The reviewed author report is `prime-estimates/ADAPTIVE_SMALL_THETA_INTERPOLATION_ORDER_2026-11-11.md`, SHA256 `6F275BC37931D5AF741AC9DFA87C8CFC5022BC61FF829B3A45AD4C288539416C`. Its script is `83397BC9122A7D965E91503990AAF7DAFE6A3A8FEB4CF1508C92C2886FBF229A`, and its JSON receipt is `3E6F184E7C7D2F13915F925C6687E3970204990035487DAC8BD41D9991C283A2`.

I read the complete report and script, checked their frozen bytes and all seven predecessor pins, and independently reconstructed the new rational metadata without importing or executing the author's program. The earlier minimal-theta admissions and finite-polynomial source comparison are reused at their reviewed scope; this is not a new review of every underlying theta/Mellin theorem.

The independently owned script `review_variable_theta_interpolation_20261111.py` passed 93,632 exact checks. It reconstructs weights through an adjacent-weight recurrence instead of the author's closed factorial denominator, and character counts through divisor inversion of Euler phi instead of the author's prime-power product. It verifies polynomial reproduction through degree six as consistency checks. General interpolation correctness comes from the basis formula and remainder proof, not these finite controls.

## Bandwidth, order and full-domain remainder

The actual finite polynomial retains the same phase-normalized coefficient centers, real zero coefficient and exact conjugate negative coefficients. Its derivative majorant is M*Omega^r with M=44(2Wbar^2+1), Omega=2pi*J/(N*Delta), Delta=5/64 and J=ceil(25N/192). This is a global estimate for the finite polynomial. It does not extend the analytic F_b approximation beyond its admitted [0,V].

Every selected row has N>=262144. Since ceil(x)<x+1 and pi<22/7,

    Omega*Delta/2 =pi*J/N
      <(22/7)(25/192+1/N)
      <=(22/7)(25/192+2^-18)
      =160919/393216.

The equality and strict comparisons are correct. The independent reconstruction checks the frequency index and bound for every row, rather than infer the minimum N from examples. The minimum actually attained is 2^18.

For each of the 130 integer-theta/conductor-cohort pairs, I checked the exact M and epsilon=2^-80/(4*3^theta), then both inequalities

    M*q_star^r <epsilon/16,
    M*q_star^(r-2) >=epsilon/16.

All r are positive even integers. Since 0<q_star<1, these comparisons establish the claimed minimal even order for this particular sufficient envelope. They do not establish the minimum possible order for the actual function. The alternate old-bandwidth order column also matches its own exact boundary comparisons.

The centering is correct: for r=2m, the nodes are -m+1 through m relative to the left coarse endpoint, and the target offset xi lies in [0,1]. Writing u=xi(1-xi), the nodal product is

    u*product_(j=1)^(m-1)(j(j+1)+u),

which is at most its value at u=1/4. That value is `[(2m)!/(4^m*m!)]^2`. The usual real interpolation remainder and binomial(2m,m)<=4^m therefore yield M*(Omega*Delta/2)^(2m). This proof includes the zero nodal products at xi=0 and1 and every off-grid eighth point. No large-height or zero-spacing assumption is used.

“Odd/even” in the parameter table means the conductor cohort determining Wbar. It does not merge character parity arrays. Both character parities at a conductor may use the same order while keeping their distinct actual coefficients and phases.

## Kernels and complete arithmetic

All 40 even orders from182 through260 occur. For every order and each of the seven offsets, the independent recurrence reconstructs the exact weight list and matches its digest only after that reconstruction. All 280 exact norm sums agree with the receipt and are below4. The largest upward thousandth is2.616, at the central offset. The reported mirrored offsets have equal norms. The full kernel count is61880; no half-table storage saving is assumed.

The sampled values must enclose the same finite polynomial T with error epsilon/64. The previously reviewed factor16 tightening applies to the selected row's time-root/gate, omega and final time-output rounding allowances. The change in order requires no further Gaussian, rounded-bucket or character-transform refinement.

The new per-query allocation is sound. If each weight, each real product, each sequential addition and the final rounding has error at most

    v=epsilon/[16*r*(M+3)],

then the kernel uncertainty is at most r(M+1)v and the arithmetic rounding is at most2rv. This includes r products, r-1 additions and one final rounding. The sum is epsilon/16. The bound M+1 applies to the stored sample centers because T has magnitude at most M and the sample radius is below1. There is no uncharged independence assumption or missing weight-error contribution.

The final F_b error is below15epsilon/16. The target-only comparison |F_b-T|<3epsilon/4 is added once; it is not propagated through the stencil. Sample errors, interpolation remainder and kernel/arithmetic each fit epsilon/16. The mandatory rounded-bucket correction remains in the first term and in the generation cost.

Wrapping indices modulo N is valid only for T. Its unwrapped real-node values equal the wrapped polynomial values, including near zero and the last cell. The row checks establish N>r and m_grid+1<=N. No negative Y samples, periodicity of F_b/Y, or analytic halo is assumed. All final targets stay in [0,V]. For a sign, the proved positive factor from F_b to Y can be omitted numerically. Actual Y enclosures still require the separately budgeted scale. The canonical Turing phase, central data and completeness conditions are unchanged.

## Counts, setup and interpretation

The independent reconstruction derives the7499 active conductors and18477108 primitive labels by divisor inversion. It then uses the already reviewed selected-tilt lists, reconstructs each height and closed grid, and obtains every selected N from the rational period inequalities. All29,996 row admissions and all four query/order histograms match. This does not rerun or reassert minimality of the earlier theta-selection algorithm; that remains its prior reviewed input.

For each label there are exactly7*m_grid new eighth-grid endpoints. The final coarse endpoint is retained, and every interior offset in the last coarse cell is counted once. Each order-r query costs r real products, r-1 additions,2r arithmetic rounding gates and r sample accesses under the stated schedule. Kernel quantization is setup, not a newly charged per-query rounding gate. Strict sign tests and optional Y rescaling are additional.

The main schedule totals agree exactly:

| Quantity | Count |
|---|---:|
|New endpoints|12427893758063|
|Adaptive real products|2439308097734074|
|Fixed340 real products|4225483877741420|
|Saved real products|1786175780007346|
|Adaptive additions|2426880203976011|
|Adaptive arithmetic rounding gates|4878616195468148|

These are full-range independent-stencil counts, not a forecast of needed signs or the cost of an optimal dense circuit. The additional59500 kernel weights, their proofs, storage and rounded representations are correctly retained. Sparse queries, repeated endpoints, shared sample neighborhoods and dense FFT alternatives can change the preferred schedule. The report appropriately requires actual query savings to exceed incremental setup and proof costs, and makes no Lean/MM0 instruction-count or runtime claim.

## Remaining acceptance boundary

The proposal supplies a valid variable-order version of the already reviewed finite-polynomial interpolation method and a reproducible conditional work inventory. It does not supply source-bound coefficient values, actual time samples, checked kernels in Lean/MM0, successful strict signs or a Turing surplus. It does not alter the family, heights, final roots or original binary-input condition. The only new finite checks here are rational/kernel/metadata checks; no spectral assertion is inferred from their PASS status.

## Evidence pins

| File, relative to agents | SHA-256 |
|---|---|
| `prime-estimates/MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md` | `73337A5EB2688E5B1A5196A901232A314D89F3E48B5EEFC013CA178A8FFA238A` |
| `prime-estimates/CLARIFICATION_MINIMAL_THETA_BUCKET_ROUNDING_2026-11-11.md` | `4ACF800D0F7C773FA5A2DF013BD5F1341ED3CC98C0F9D257D81A2EE63B480D41` |
| `prime-estimates/small_family_minimal_theta_20261111.json` | `25E4BF80119B05A5C0FF25BDB7AECACEBC7495B5A00097B991E11C3DBF77D422` |
| `audit/REVIEW_MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md` | `58215EA3A0D697D229AD746F6FCE340DE913165D63599DC197798E705392308B` |
| `integration/SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md` | `19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081` |
| `moebius/REVIEW_SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md` | `B815BBEEF96C0E8D1259A915E8BB0F3BEB98BBD1CFB9473B038E0B3D64F3A38F` |
| `integration/MINIMAL_THETA_INTERPOLATION_APPLICABILITY_2026-11-11.md` | `BEE442CFF66187EAEEC930441D0AE414725A198A72B394A47701DB27E1D6B8FC` |
| `prime-estimates/ADAPTIVE_SMALL_THETA_INTERPOLATION_ORDER_2026-11-11.md` | `6F275BC37931D5AF741AC9DFA87C8CFC5022BC61FF829B3A45AD4C288539416C` |
| `prime-estimates/adaptive_small_theta_interpolation_20261111.py` | `83397BC9122A7D965E91503990AAF7DAFE6A3A8FEB4CF1508C92C2886FBF229A` |
| `prime-estimates/adaptive_small_theta_interpolation_20261111.json` | `3E6F184E7C7D2F13915F925C6687E3970204990035487DAC8BD41D9991C283A2` |
| `integration/review_variable_theta_interpolation_20261111.py` | `E427CCA6F514D666E00F6080D2070F0AD8C64D2D793F96E301D638A4CDA2B3B1` |
| `integration/review_variable_theta_interpolation_20261111.json` | `F123DA2C73C9B95B12A3623325A4893596AC812794B286E712AFFDAD128FB334` |
