# Review of row-specific half-transform applicability

2026-11-11. PASS at conditional paper applicability scope, without correction. This binds `major-constants/HERMITIAN_HALF_TRANSFORM_MINIMAL_THETA_APPLICABILITY_2026-11-11.md`, SHA256 `418E1991D01876108ECF804FC4811895722ED418B15E8E0FC03CE3E9D6F8DD82`. No values, transforms, builds, parameter search or source changes were performed. All frozen files remain unchanged.

I read the complete supplement, selected minimal-theta report, mandatory bucket-rounding clarification, independent selector review, intermediate-theta interpolation applicability proof and review, and sign-only successor and review. The earlier half-transform proof and my review are already accepted. I verified the supplement's nine input hashes and its own hash. The saved sign-only JSON also matches `E767EC3B3E14F2A243837DA85C811DE5ED67CE701BDD08998C2329F9C687C24D`. This is a bounded composition review, not a new execution of the 29,996 row selectors or the half-transform error recurrence.

## Parametric error contract

The supplement resolves the coefficient-bound qualification in my earlier review `519450342B34823AC596C3C778E90CDFA1EB96944F5EA0DF4E793F748EE505AE`. Its B is the coefficient magnitude bound, not the Gaussian-series constant also called B in the selector.

For any real B>=1, positive eps<=1 and admitted depth k, the proposed tolerance is

    u <= min(1/(16k), eps Delta/[448(2k+4)(B+1)]).

It implies the safety conditions in the accepted half-transform proof. In particular a=(B+1)u<1, the geometric amplification remains below two, and the final normalized error satisfies

    e <= (2k+4)(B+2)u
      <= 3eps Delta/896 <1.

The last inequality uses Delta=5/64 and `(B+2)/(B+1)<=3/2`. Thus the proof covers the full stated B and eps domains, rather than only the author's previous uniform-B numerical test. The exact output shift by m=N/2 then gives the raw sample error below eps/(64H), with H=44/(7N Delta). The strict comparison follows from `(B+2)/(B+1)<2` and `1/448<7/2816`.

Polyphase preparation is already included in the packed-input error. It changes neither the transform length N nor the exact coefficient magnitude bound. The negative phase-modified centers use exact conjugation. This does not extend a padded length-dN transform beyond the admitted depth range. C0's round, source-denominator widths, output grid shift and root-generation obligations remain explicit.

## Actual selected rows

The accepted selector uses every integer theta from 64 through 128 where selected, not an interpolation between two endpoint checks. Its cohort bound is 40000000/theta for odd conductors and 80000000/theta for even conductors. Therefore each row's coefficient bound is its own `B_row=2 Wbar^2+1`, with 1<=B_row<=3125000000001. Its epsilon is `2^-82/3^theta`, which lies in the supplement's domain.

The independent selector review establishes N(selected)=N128 for every one of the four scenarios' 7499 conductor rows. The saved theta128 ranges are 2^18 through 2^30 in all four scenarios, contained in the supplement's 2^18 through 2^31 domain. The explicit J ceiling consequently gives J<N/4, as required for disjoint sparse packed positions. The reviewed period, frequency, Gaussian and elementary admissions remain necessary; equality of N alone would not prove them.

The selected coarse gate is

    u_time=min(1/(2k), eps Delta/[56(2k+4)(B_row+1)]).

Its sign-only successor divides the whole minimum by eight. This is exactly the supplement's tolerance, including the safety branch 1/(16k). The recorded coarse fractional precision plus three bits therefore suffices for the new packed products, sums and C0 round as well as the normalized half FFT. These additional operations still require execution and proof. A shared cache must meet its strictest actual consumer's tolerance.

The intermediate-theta applicability proof supplies the same target-only comparison to omega U for each selected theta. Its input includes the corrected rounded bucket additions. The discarded exact-accumulation sentence in the original selector report is not used. No Gaussian, character, coefficient, phase or bucket error allocation is relaxed by this supplement. New theta values still require newly certified coefficient centers; matching dimensions do not transfer old values.

## Consumer and accounting limits

The resulting samples satisfy the sign-only raw-U interface and its rational threshold `109eps N Delta/704`. They do not restore the deleted numerical Y-amplitude API or prove any strict sign. Actual character, fixed phase, source array, target and gate bindings remain required. Nonreal inverse-character channels, closed endpoints, central cases, multiplicities, auxiliary intervals and canonical Turing arithmetic are unchanged. Polynomial index wrapping does not assert periodicity of L or F_b.

The supplement makes no aggregate count mutation. Its mathematical applicability is sufficient for a later minimal-theta half-transform ledger, but that ledger must explicitly include packing, precision, roots, widths, shifts and retained outputs. The fixed-theta half-transform totals cannot simply replace unrelated counters or be relabeled as an already executed minimal-theta computation. Actual arithmetic certificates, successful signs, complete counts and implementation costs remain open.

The nine pinned predecessors are exactly the manifest in the reviewed supplement, all matched during this review. The additional saved whole-family range check uses `prime-estimates/small_family_theta_inventory_final_20261111.json`, SHA256 `26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69`, already verified in the accepted half-transform review. No author program was imported or executed, and no old receipt gained new checks.
