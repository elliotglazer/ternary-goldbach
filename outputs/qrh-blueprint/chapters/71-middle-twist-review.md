# Independent review of the Q90090 middle-twist certificate

Date: 2026-11-11. Research review against target source commit
`23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build or canonical source edit.

## Verdict and scope

No blocking mathematical or source-transcription defect was found in the proposed middle-band argument. It supplies a conditional paper route for the reduced denominator Q=90090, all y >= 10^25, and

    33000 <= u = Q |Delta| <= 26400000/49.

The original Type I/II producers remain assumptions of this route. In particular, the source large Type I2 estimate retains its prime-estimate inputs, including the 1.03883 term. This review does not remove its `Fact PlattGRH` dependency, prove replacement producers, or turn the external certificate into a Lean theorem.

The finite arithmetic, source applications, floor estimates, monotonicity bounds, convolution and integrability arguments still need formalization. The accepted research classification is distinct from formal closure of a denominator or of basegap.

## Source contract and normalization

Checked `MinorArcs/TypeI2Large.lean:223`, `typeI2_le_large`, directly. In addition to `Approx2`, it requires positive scale z, QV <= H, 16V <= H, U >= 1, V >= 2.5e7, UV <= z, |Delta_z| >= 1/(2c2), and 0 < epsilon <= 1. There is no further upper phase restriction in this theorem. The choice epsilon=3/100 satisfies this contract; it is separate from the floor error 10^-8.

The source's first two terms coincide with the small Type I2 bound. Dividing the remaining four terms by z, with T=z^(1/3), UV/z <= p, V/H <= 4b/(3T), H/z=3/(4T), and V/z <= b/T^2, gives exactly the proposed

    A0 + Dcoef*g(D) + B(D)/T + C2/T^2,
    D = Q |Delta_z| = w u.

The factors 1.0064, sqrt(3+2 epsilon), (1+epsilon)/epsilon, 35*32*c2/(3*pi^2), and both logarithmic arguments agree with the source. No large-branch remainder is dropped. The use of cPlus <= 1+etaL*p preserves all signs.

Here g(D)=(1.03883+log Q+logPlus(6pD/sqrt 2))/D is decreasing for D>0: on the positive-log branch its derivative numerator is 1-(1.03883+log Q)-log(6pD/sqrt 2)<0, and on the zero-log branch it is negative. The formulas agree at their junction. B(D) is nonnegative and increasing. The script consequently uses a lower D endpoint in g, an upper endpoint in B, and a lower T endpoint in both decaying terms.

## Floors, source side conditions and the branch boundary

With a=1/(1152 sqrt(180180)), b=576, U=floor(aT^2), V=floor(bT), and T>79000000, the stated relative floor bounds hold. The stronger constraint QV <= H reduces to T >= 768Q=69189120. Also U >= T^2/489600-1 > (14/3)T, which supplies the Type II size constraint 3.5z/U <= H. The other stated Type I1, Type I2, Type II and assembly size constraints follow at this endpoint and persist as T grows.

The approximation error is safely bounded: w u <= 8*(26400000/49) < 4310209, whereas 4T/3 > 105333333. The exact reduced-rational identity and coprimality are inherited from the source setup, not inferred from numerical interval data.

The cutoff is K=Q/(2c2). The small theorem permits D<=K and the large theorem D>=K, including equality. The script marks small as possible when w_lo*u_lo <= K_upper and large as possible when w_hi*u_hi >= K_lower. These tests may include an extra branch but cannot omit the actual branch. On a straddling cell the maximum of the two bounds is valid. The large lower endpoint max(K_lower,w_lo*u_lo) remains below every actual D in that branch.

The new b=576 requires the updated saturation cap

    G2 = M + log(16*b*Q^2/3) + log(b*Q).

The script makes this change. Reusing the old b=72 value would have been incorrect. The sufficient lower bound min(H/(2V),U) >= 3T/(8b) holds. The imported utility retains a stronger auxiliary assertion alpha*T >= 1/192; this is harmless, rather than an unverified weakening of the new condition.

## Compact scale and interval arithmetic

For r=1/(log(y)/3+d), d=log(9/601200), the r partition includes every finite y>=10^25. A cell ending at r_hi supplies

    v-v0 >= 1/r_hi-v0_upper >= k*log(2),
    T >= (w_lo*10^25)^(1/3)*2^k.

The script computes k with an upper enclosure of log 2 and explicitly checks this inequality when k>0. For k=0 the original lower endpoint is sufficient, including any outward enlargement of r_max. Capping k at 8 weakens the estimate for large y; it does not impose an upper bound on y. Setting the utility's lower scale to 10^25*2^(3k) is the correct cubic conversion. The original compact-variable endpoint v0 stays unchanged, intentionally.

The Type II main term uses r_hi, and the increasing consumer lower envelope uses r_lo. The previously reviewed normalized errors decrease with T; the newly added large remainder has nonnegative coefficients of 1/T and 1/T^2. This does not require monotonicity of the total slack in y.

The subtraction `common = E - smallrest(T)` is interval arithmetic applied to the same explicit algebraic expression, not subtraction of an unrelated upper estimate. The matching small-remainder terms were checked against the imported utility. Both intervals enclose their exact quantities, so subtracting their intervals still encloses the desired exact common expression, albeit with extra width.

The 159 w bins cover [.05,8]. The existing certified Gaussian masses and the two tails are reused. Different Vaughan decompositions or small/large bounds may be selected pointwise before applying the common integrable upper envelope.

## Coverage and count consequence

The nine closed middle u intervals have no gap. Their endpoints join the separately reviewed certificates exactly:

* Small band: [1200000/49,33000], all y>=10^25.
* This middle band: [33000,26400000/49], all y>=10^25.
* Raw tangent band: [26400000/49,1200000], all y>=10^25.

The raw-tangent report used D=Q|delta_old|, whereas this report uses Delta=2 delta_old and u=2D. Its lower threshold D=13200000/49 therefore converts to u=26400000/49. Missing this factor of two would invalidate the splice; the current reports use the correct conversion.

Thus the full permitted source twist range for Q90090 has a conditional research argument. This does not assert coverage below the source lower endpoint 1200000/49. If the prior union of 73578 denominators is unchanged and excludes 90090, adjoining this one composite gives 73579 conditionally classified denominators, with 76421 remaining. This is a research inventory update only; no denominator has thereby become Lean-proved.

## Evidence and pins

Current hashes independently verified:

| File in agents/moebius | SHA256 |
|---|---|
| RESUME_MIDDLE_2026-11-11.md | A0A3C4EACB6723AA65D9B585F05933E87D3C77F2DC9A21CF438F4C63B9A2E8E7 |
| resume_middle_certificate.py | B70FC634C350E7FDF8174504D033254C24B4FB1209BB7AA385E7F31BCBC06E77 |
| resume_middle_certificate.json | 4CCD7AE1A458FA0AF67F284EC97D993E16EA06E4FBCCF91CC213938C5875AD38 |

Independent output checks verified nine adjacent u intervals, 128 adjacent r cells per interval, all 1152 positive exact gaps, valid dyadic powers in [0,8], and the exact minimum gap 139563943/10^12. The minimum is on u in [65000,85000], r cell31.

A full independent replay then completed with exit code 0. The only runtime change redirected the final output path into this audit directory; the calculation was unchanged. `middle-independent-replay.json` is byte-identical to the frozen author's JSON, with SHA256 `4CCD7AE1A458FA0AF67F284EC97D993E16EA06E4FBCCF91CC213938C5875AD38`. The author's artifacts were not modified.

Imported numerical dependencies at replay:

| File | SHA256 |
|---|---|
| moebius/resume_minor_allscale_certificate.py | F7934294EA5907153F2B518F4F6BCB4D1076D347496D9B5726E22BD36BC23FF4 |
| major-constants/base_gap_90090_certificate.py | 8097511736E499522B93AAAFD54F2B2140B42EBBE88400B9A497FF3F0812924D |
| major-constants/base_gap_binned.py | 8F4C2455217A9C0251A2E3F3692E7ACAA49FF6797771E4CCF0C5B94FDFFE8748 |

No new declaration, sorry, axiom, import, or sealed theorem was introduced by this review.
