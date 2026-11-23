# Independent review of fixed Horner degree-envelope repricing

2026-11-11. **PASS at conditional paper and exact-metadata scope; no further correction requested.** All six fixed-profile product subtotals, stage capacities and retained error envelopes agree with an independent reconstruction. No new profile optimum, implemented backend, full-family saving or runtime conclusion follows.

Author: moebius/FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md, SHA256 `96734A7E4A0C93857EE538A59890451C40644AAAA0D0F07FE9D82B936509C0D3`. I read the full frozen note, script and receipt, prime's stored-degree source note and major's independent source review. My accepted optimized-grid review supplies the separate error/circuit check for the three unchanged profiles. No author script was imported or executed, no actual coefficients or functions were evaluated, and no builds or frozen mutations occurred.

## Source acceptance is a separate input

The source author9B777E02 and independent review10281561 bind the actual stored coefficients of finite translated coarse polynomials. Their first-four class includes P27 midpoint translation and the unshifted P20 right endpoint. The final class uses sourceD4096/P28/N1500/m159, shifts0,1/4,1/2,-1/4 and the output2^-j postscale. The final output normalization is8192. These are not exact derivatives at the fine anchor.

The bounds consumed here first control the finite ideal translation and then its numerical slot errors. In the first four bands, min(4^j W,Eflat) is justified by two separate bounds on the same numerical slot error. The final eta bound includes its postscale/round. The separate analytic finite-shift bias is still part of the function enclosure; it has not been set to zero because the coefficients have small magnitudes. I checked the copied rational Z_j formulas against this source and its receipt. Major's independent source review remains the acceptance of the underlying jet/EM/translation proof, rather than being reissued by this pricing review.

Degree zero uses its separate finite-EM envelope. It is not put into the absolutely convergent positive-degree estimate. Its large bound enters Horner only at the final exact coefficient addition, which has no later multiplication. The repricing preserves this distinction without omitting its final output capacity.

## Recurrence and widths

The profiles are the same uniform100, root-linear and former15442 vector. Each directly converts the ORIGINAL stored centers to its own grid; a second conversion through a b100 cache is not free or covered automatically. With e_j=(3/4)2^-b_j, I independently expanded the magnitude recurrence as

    A_j = sum_(k=j)^19 (Z_k+e_k)4^(j-k)
            +sum_(k=j)^18 e_k4^(j-k),
    T_j = A_(j+1)/4+e_j.

The second sum is empty at j19. This verifies the exact initial copy, one product round per later stage and exact additions. These expanded finite sums agree with every saved A_j and T_j. Because they bound complex norms, each coordinate uses the same bound without an extra factor. The unchanged weighted evaluation-error sums still lie strictly below8/3; reduced magnitude does not permit increased error.

At stage j, the multiplication input has grid b_(j+1), and the rounded witness has grid b_j. The widths come from A_(j+1)2^b_(j+1) and T_j2^b_j respectively. Thus the first input is the actual converted degree19 bound, not a generic accumulator cap. Degree-zero A0 is used only for the output/addition width. The two priced products are rM before alignment and Lv after witness selection. All114 stage records match this separation.

The exact shift follows rM. The stored rational caps independently bound the shifted numerator, witness product, their raw difference and its double. These raw capacities are checked before relying on the small accepted residual. The final exact coefficient addition is bounded by C_j+T_j=A_j. Across all six cases its largest signed capacity is114 bits at the degree-zero output. The complete raw residual maxima124 and123 bits for the two band classes are retained, rather than replaced by divisor-sized widths before equality verification.

The universally available even-divisor cancellation removes t=min(delta,1) from both the shifted numerator and v. It preserves the same nearest witness L and the closed-lower/open-upper ties-up inequality. It changes alignment/residual widths but not the globally padded three-byte divisor factor. No additional conductor- or mantissa-specific cancellation is credited without a proved branch and matched accounting.

## Matched arithmetic results

For each coordinate product, the smaller byte operand is the outer-row count in M(m,n)=5mn+2n+1. The two coordinate products per complex stage and nineteen stages give76 product proofs in every case. This is the declared unsigned macro-template subtotal, not the cost of a complete signed round.

|Profile|First four bands|Final band|
|---|---:|---:|
|Uniform100|12562|11872|
|Root linear|11272|10552|
|Fixed former15442 vector|10702|9970|

The independently reconstructed old coarse-width subtotals remain17632,16252,15442. Every new subtotal uses the same template and the actual sharper sufficient widths. In the final fixed-vector case, the two stage18 variable operands and stage17 witness occupy two bytes. Each real product therefore costs M(3,2)=35 rather than M(2,3)=37. Three such products across two coordinates explain12 events:9970 rather than9982. This orientation change is necessary for a fair matched subtotal.

The old optimized vector is cheapest among these three fixed choices. Its old dynamic-programming optimum does not carry over to this different magnitude-dependent objective. This packet conducts no new optimization and does not price all74 former Pareto profiles. The same stored-degree information can also sharpen FD partial initialization, so these figures alone do not settle Horner versus FD.

The report explicitly defines the saved summary key `guaranteed_cancelled_alignment_bits` to mean the REMAINING distance after guaranteed cancellation. Its values0,1,22 agree with the stage-level `remaining_alignment_bits`; removed distances would be0,18,7. I raised the naming ambiguity before freeze, and the frozen note supplies the required definition while preserving its receipt. Consumers should use that explicit meaning rather than infer one from the abbreviated key.

## Evidence and cost boundary

Owned checker: independent-feasibility/review_fixed_horner_degree_repricing_20261111.py, SHA256 `408832A643E66EDA97E3F023364F8A6C8AD8CBBFECF6F0B56BC02FDB4155CFA8`. Owned receipt: same stem JSON, SHA256 `623B16021D6A1D15BCFD51C6E1C6EAC1EF9A0414E4BFCED7B44D67A8C3E8E1A6`. All3599 exact checks pass. The receipt binds fifteen input hashes and retains the six subtotals. It reconstructs the Z envelopes, uses expanded finite sums instead of the author's recurrence, and checks every saved stage's magnitude, raw capacity, cancellation and product orientation.

Author script and receipt are respectively `22D456ADE5596011FF01145F384C2FA0A93D86C29E4A8EB97AE2C24FDA1B1162` and `4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9`. The source author and independent acceptance are `9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2` and `1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6`.

Twenty direct conversions per distinct array, original input widths, alignment/cancellation proofs, signed wrappers, coefficient additions, residuals, comparisons, quotient discovery, numerator representations, ordinary-library construction, coverage bindings, storage and cache lifetimes remain outside the displayed subtotal. Their costs cannot be inferred from the smaller byte widths. Actual arrays, ordinary-rule arithmetic records, exhaustive spectral outputs and complete implementation comparisons remain open. Acceptance is limited to the fixed-profile conditional repricing and its sufficient-width proof.
