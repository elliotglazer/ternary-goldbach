# Independent review of the P4 shared-strip reduction

Verdict: **PASS as a conditional paper/source reduction**, 2026-11-11. No correction is required to the frozen author note. The new estimates remove the *additional narrow principal strip* and *quantitative head-moment certificate* from this P4 path. They do not prove the retained shared finite strip, validate the global provider, or complete the Lean consumer.

## Frozen evidence

Reviewed in full: `audit/P4_SHARED_STRIP_REDUCTION_2026-11-11.md`, SHA256 `EE2E6A7752136F751D64890A0E2BD4CD613790529B1A4D5BC24483F2A3B5B585`, and its exact scalar script, SHA256 `641D47F7ADB06F1266A7D3C15BC5514818FBE1A85139942B6DCE3F4AAEC6ACBA`.

I also read the cited analytic-count argument, prior P4 source join, low-zero refinement, and actual `LambdaMu.sum_vonMangoldt_le_a14`, Gaussian Mellin endpoint/strip interfaces, and unconditional low-height draft. The .07 finite mass and true-order transport were independently reviewed in the immediately preceding minor-energy and translated-mass reviews.

The new independent `p4_shared_strip_review_20261111.py` checks eight frozen input hashes and 17 exact rational implications. It uses no author imports, zero data, or transcendental evaluator. Its output `p4_shared_strip_review_20261111.json` is SHA256 `04A261C5C43172BDBC5BE7ED1E3C0FA123D797406A1A691A31AF77849783C789`. The alternate endpoint check uses the coarser elementary inequality exp(z)<=1/(1-z) and only 25 terms of the positive inverse-exponential polynomial, and still proves the required factor below 1.002. All files in this review are new; frozen inputs were not changed.

## Count, mass and reciprocal moment

The retained analytic count is the **closed positive-ordinate count with true multiplicities**, not an exact data-derived count. Its bound N(t)<=F(t)+5log(t)+20 is valid for every real t>=1500 under its paper proof. That proof first treats nonzero ordinates and then passes from larger nonzero ordinates to the closed endpoint using continuity of the upper majorant. Thus applying it at 1500 and one million does not assume that either height avoids zeros.

The proposed elementary consequences are valid. In bounding the first term of F(t), one can first replace its logarithmic factor by the positive constant 6 (at 1500) or 12 (uniformly through one million), keeping the positive factor t/(2*pi), and only then replace 1/(2*pi) by 1/6. This avoids any unsupported multiplication rule for a possibly negative logarithmic factor. The results are N(1500)<1600 and N(t)<(25/12)t throughout the required interval.

The unconditional height-floor argument uses the actual zetaF integral remainder on the right half of the strip and xi reflection on the other half. It implies |gamma|>=2.39 and excludes real nontrivial zeros. It is not the different RH-dependent source height lemma. Together with multiplicity-preserving conjugation, this gives total multiplicity below 3200 in the closed two-sign head. Conjugation is needed as an actual zero/order statement, rather than as an assumption that a supplied list happens to contain pairs.

Put a=2-beta. The global reflected strip gives 9/8<=a<=15/8. Every denominator is positive, and

    1/(|rho|^2*w2(rho))
      = a/(beta^2+gamma^2) + gamma^2/[a*(beta^2+gamma^2)]
      <= a/gamma^2 + 1/a
      <= (15/8)/(2.39)^2 + 8/9 < 5/4.

Apply finite Cauchy-Schwarz to sqrt(m*w2) and sqrt(m)/(|rho|*sqrt(w2)). The first squared norm is at most .07, by the sharp s=2 mass certificate and finite-order transport. The second is below 3200*(5/4). Thus the low reciprocal sum has square below 280<17^2. This retains each true multiplicity m, including multiple zeros; it does not count only distinct locations.

For the remaining positive ordinates, the finite Abel identity is exact:

    sum_(1500<gamma<=T) m/gamma
      = N(T)/T - N(1500)/1500 + integral_1500^T N(t)/t^2 dt.

It follows directly by summing the elementary integral identity for each zero in a fixed larger finite carrier. Zeros at 1500 belong to the low part; zeros at T are included in the high part. The negative boundary term can be discarded. The count bound and log(T/1500)<7 give a strict upper bound 50/3. Conjugation gives the same negative-ordinate bound, so the entire reciprocal sum through T=10^6 is below 151/3. No infinite reciprocal sum, exact head count, or numerical moment enters.

## Shared strip and the wider Mellin endpoints

The shared upper bound beta<=.555 gives 35*max(beta-1/2,0)<=1.925<2. Multiplying the finite reciprocal bound by exp(2)<(11/4)^2 yields

    W35 < 18271/48 < 381 < 436.

Only the shared strip's restriction through one million is needed here. The remaining shared heights still support the intermediate-zero estimate. This argument does not establish that finite strip; it changes what can be deduced once that same selected certificate is proved.

The source `GaussSmooth.norm_intExp_le'` keeps the two endpoints exp(a*beta)+exp(b*beta), divided by |rho|. The source Gaussian factor is exp(delta^2*(beta^2-gamma^2)/2). Its enlarged exp(delta^2/2) bound needs only 0<beta<1. On the low range, L<=35 permits

    x^(beta-1) <= x^(-1/2)*exp(35*max(beta-1/2,0)).

With b=log(1000)-L<0, the shared lower bound beta>=.445 gives exp(b*beta)<=exp(-.445*(L-7)); the other endpoint is at most exp(.555*|a|). Thus the replacement endpoint coefficient is exactly the one in the note, not the old .49/.51 or .4968/.5032 expression.

Every factor of that coefficient decreases with L on [22.33,35]. The exact independent endpoint check gives it below 1.002. Then sqrt(x)>70700 at x>=5e9 gives E_low<1.002*381/70700<.0054. No phase cancellation or zero-spacing assertion is used.

## Remaining errors, domain joins and the actual consumer

I checked the low-zero refinement's separation of its estimates. Intermediate zeros already use only the shared .445/.555 strip, translated window mass and the fixed T/H cutoffs. The high tail uses global QRH and its count bounds. Neither range uses the narrow head strip or quantitative head moment. The vertical integral and smoothing/desmoothing terms also do not use them. Their unchanged scaled allowances sum to .002188002001, which divided by L>22 is below .0001.

Both sandwiches are therefore bounded by (.0054+.0001)*1.000001=.0055000055<.005501<.0064 on [5e9,exp(35)]. The farther argument remains .0081/log(x), under the retained shared-strip/global inputs, and it covers the meeting point. This does not assert that W35 alone controls all arbitrarily large x.

The lower finite-prime branches and their outstanding certificate replays are retained. Their integer bounds overlap the analytic branch at 5e9. The actual source target uses a natural floor and coefficient 1.0064 for every real y>=25000000. Once the corresponding integer upper bound is proved, N=floor(y)>=25000000 and N<=y give the original conclusion without an additional unit loss or changed threshold. The existing Platt-dependent `psi_bounds` is not silently reused to obtain the new integer bound.

## Precise acceptance boundary

The new reciprocal and endpoint calculations are complete paper implications from the listed inputs. No narrow principal-strip or quantitative head-moment premise survives in this P4 argument. No historical zero counts or measured spectral values are substituted for the analytic count.

Remaining work includes formalizing the analytic count with its branch/order/closed-height conventions; implementing the unconditional height floor and finite mass transport; proving the Gaussian finite-sum, limit, vertical and sandwich adapters; replaying the finite-prime/log certificates in the kernel; and validating the genuine global provider and retained shared finite spectral certificate. These are not already compiled consequences of this review. The shared finite certificate remains a substantive unproved spectral input, rather than merely an implementation detail.

The common sharper .01/log(x) envelope and its other consumers are not improved by this note. Their stronger low-zero requirements remain separate. No complete P4 Lean theorem, whole proof-graph closure, or Goldbach theorem is claimed.
