# Independent review of raw signs with variable interpolation order

2026-11-11. **PASS with the author's separate count erratum; no further correction required.** Acceptance binds both:

- `audit/RAW_ADAPTIVE_SMALL_THETA_COMPOSITION_2026-11-11.md`, SHA256 `0FF513632780E8DF9FA544E5B8AA8B919126BA8FD482D862B4761093D0996C81`.
- `audit/ERRATUM_RAW_ADAPTIVE_SMALL_THETA_COMPOSITION_2026-11-11.md`, SHA256 `36B98744446E0CC527F69C9B4F1D64A41F5CA0D5266B9ED3FA265121BECABD35`.

This is a conditional mathematical composition and exact-metadata review. It does not admit actual coefficients, signs, completeness or an executed implementation. No analytic values, transforms, prime/zero evaluations or builds were performed. Frozen author files remain unchanged. The whole-sign operation-ledger join is separate.

## Remainder and units

I read both component papers and their independent reviews, the complete composition and its scalar program. The objects agree: one actual character, fixed phase, exact stored Hermitian coefficients, positive unnormalized time DFT, and U before omega scaling. The pre-time comparison is `|F_b-omega U|<3 eps/4` on the admitted target interval. It is used only once at the target.

The variable order uses the same B and M=44B as the raw interface, with conductor parity determining Wbar. It does not merge the two character-parity arrays. From N>=2^18 and J=ceil(25N/192), the tighter half-step bandwidth is bounded by `q_star=160919/393216`. The raw coefficient mass C_U satisfies `H C_U<M`, where H=44/(7P). Hence every reviewed choice `M q_star^r<eps/16` implies

    C_U q_star^r < eps/(16H).

This is the required composition; reusing the old scaled remainder without this factor would be unjustified. The real interpolation remainder is global for U, whereas its approximation to F_b remains confined to [0,V]. The exact kernels depend on the selected order and eighth-grid offset, not on whether the interpolated polynomial is U or omega U. I independently reconstructed all 280 norm sums and found each below four; no monotonicity of those norms is assumed.

## Samples, rounding and signs

The raw sample allowance `eps/(64H)` still follows from the old sufficient time-root/gate tolerance divided by eight. Its error is at most `eps P/448`, and `1/448<7/2816` proves the allocation. The order r is absent from this FFT estimate. Three additional fractional bits refer to this absolute complex-gate contract alone, not to full machine widths or to Gaussian/character/phase precision.

At order r, exact-weight propagation of the sample error costs less than `eps/(16H)`. For stored raw centers bounded by C_U+1, weight errors plus r product rounds, r-1 addition rounds and one final round cost at most

    [r(C_U+1)+2r] v_raw = r(C_U+3) v_raw.

Thus the displayed `eps/[16rH(C_U+3)]` tolerance is sufficient. This decomposition includes uncertainty of the rounded weight multiplying the uncertain sample center. Setup weight quantization is not an additional per-query arithmetic round. Using the old scaled tolerance is also valid, since

    H(C_U+3) <= (506/21)B+66/21 <=44B+3.

The raw integer magnitude and temporary widths still need a new implementation bound; sufficient fractional accuracy does not make scaled and raw operands interchangeable.

Adding the raw remainder, propagated sample error and kernel/arithmetic contribution to the target comparison gives exactly

    |F_b/omega-z| < 3 eps/(4L)+3 eps/(16H)
                    =109 eps P/704,  L=6/P.

The threshold is unchanged by varying r. Its strict comparisons certify signs of the actual F_b and Y through positive multipliers, with no evaluation of those multipliers at the output. An inconclusive comparison remains inconclusive. Wrapped indices use U's periodicity only, and the entire consumed sample dependency union must refer to the same stored array. The closed target domain, N>r and the accepted row admissions remain mandatory.

## Counts and acceptance limits

For n queries of a common order r, the charged query work is rn real products and accesses, (r-1)n additions and 2rn arithmetic rounds. Summing the saved order histograms reproduces the four receipt rows. The +320 table cell in the original note is a transcription error: its corrected additions count is **2436206631058893**, equal to `2448675913538876-12469282479983`. The separate erratum supplies precisely this correction; the original receipt already has the right value. All other displayed count cells agree.

The setup remains 61880 exact weights at 40 orders, not 2380 weights reused at a different order. Rounded caches must satisfy the finest required tolerance or have separate certified versions. The main independent-stencil product reduction of 1786175780007346 is relative to the fixed340 raw circuit. It is not a dense-optimal bound or a prediction of the number of sign queries. The raw omega/Y omissions are common to both circuits and cannot be deducted again. Raw widths, setup, proof and storage costs remain distinct from operation cardinalities.

The composition preserves both positive character channels, fixed phases, central evidence and actual canonical Turing/count contracts. It does not supply amplitudes, general contour images or log derivatives. The use of this interface in the selected whole-family ledger and the inventory of non-sign consumers are separate joins. Actual coefficients, finite arithmetic, accepted kernels, successful strict signs, auxiliary coverage and completeness remain required.

## Independent evidence

`zero-sum/review_raw_adaptive_theta_composition_20261111.py`, SHA256 `7455659188FF41DDD5566C00F346C673B85C048CE301C228058BD08FF726B546`, and its JSON, SHA256 `11D1B054FFD51613EB2000F7E66FF98ED8DDD8D180EC82351C15A3730E8B81CC`, pass **1532 exact checks**. They verify nine source/receipt/review pins, all 130 order/remainder rows and their raw transport, reconstruct all 280 rational kernel norms by adjacent-weight recurrence, and rebuild all four query-cost rows from histograms. The separate erratum was read and hash-verified after that receipt; its corrected integer is already independently checked there.

Neither author program was executed or imported. The existing full conductor-row admissions and underlying theta analytic proof are reused at their reviewed scope rather than claimed as newly regenerated by this bounded review. No numerical spectral claim or runtime winner follows.
