# Independent complete replay of the principal signs through height 1500

Date: 2026-11-11. Verdict: PASS as an external interval certificate joined to the separately accepted complete contour count and the reviewed analytic sign/completeness argument. All 1070 retained points were independently evaluated and had the claimed strict signs. This is a full alternate numerical replay of the retained certificate, not a sample check.

The resulting mathematical conclusion is finite RH and simplicity for every nontrivial zeta zero with |Im rho|<=1500. In particular, the required principal strip (.4975,.5025) is established externally through 1500. This conclusion does not assume QRH, PlattGRH, historical finite RH, Gram's law, minimum spacing, or simple zeros. It is not a Lean theorem. The interval 1500<|Im rho|<=1000000 and every formal proof bridge remain separate tasks.

## Frozen evidence

| Artifact | SHA256 |
|---|---|
| Author `mellin/PRINCIPAL_SIGNS_1500_CERTIFICATE_2026-11-11.md` | `0C2DF29B039E0418144EDAAF1ADA05BEEF31B90F3E1F0358DCAD837F7BF69082` |
| Author `principal_signs_1500_20261111.py` | `5DADC07911BBE024947F1CA6EC2FFCE0CDF205DC63EFD1968D2B545B9E1C182A` |
| Author sign JSON | `542346DEB342369A1D53601DC051AFADB39149DB34C6E7426C33AB4094BC8CF4` |
| Independent `audit/principal_signs_1500_independent_review_20261111.py` | `FA38C959821BDF6209C8BAF1727ABB0650465D2FB501DAF482DE9985914885C6` |
| Independent replay JSON | `B7E6FA48F63A31AD047BA1B7A1358042F993B5F985A933A68D13FCD6F8D5E142` |
| Accepted head evaluator | `D7F187FA357EACA184A2214F8952B396B9D2DF42348580993005B7DA00252A9A` |
| Accepted head JSON | `82AD7ACDFFBCAC24D190A98ACB78BF66471249D09BFE2C43051ADD2AAEC0D030` |
| Independent head review `moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md` | `0BD2AF981C7F8A201F15597A7EE4C7B9812053C4987231C8EB02E5A6AA8BA491` |
| Analytic route note | `AC1FA5C0308D24C9CB19FEBF6A2C231B42C6E25113E534D4C23FE62E4CE2D92C` |
| Independent route review | `FB268AD7ACE08954435194D51BF6FC3C358AE7838E8CCFAE7087B0E0F84EAA11` |

All pins above were checked. Original files and the frozen package were left unchanged. The independent script imports no producer code. The existing interval environment was used without installing dependencies or building Lean.

## Independent evaluator and full replay

The producer evaluates the pole-cancelled zetaF finite expression with N=500, B=N+1=501, M=32, 128-bit intervals and a coarse sigma0=-1/10 remainder. I read that code and checked that its scalar use includes only the Euler–Maclaurin error, with no missing Taylor error because there is no power-series block approximation in this sign computation. Dividing by s-1 is safe on Re(s)=1/2. The uniform error enlarges every actual factor by S+j and |s-1| by S+1, then uses the upper error endpoint as the added coordinate radius.

The independent replay uses a different finite expression directly for zeta, at cutoff B=640 with 639 terms, M=40 and 192-bit intervals:

    sum_(n=1)^(B-1) n^(-s)
    + B^(-s)*(B/(s-1)+1/2)
    + B^(-s)*sum_(k=1)^M [B_(2k)/(2k)!]*(s)_(2k-1)*B^(1-2k).

The rational Bernoulli coefficients come from the formal reciprocal of (exp(z)-1)/z, rather than the author's Bernoulli-number recurrence. Its coefficients c_n satisfy c_0=1 and

    c_n = -sum_(k=0)^(n-1) c_k/(n+1-k)!.

Thus c_n=B_n/n!, with checked c_2=1/12, c_4=-1/720 and vanishing higher odd coefficients through the used degree. No builtin Bernoulli evaluator is needed.

For s=1/2+it the direct zeta remainder is bounded by

    4 * product_(j=0)^79 sqrt((j+1/2)^2+t^2)
      * B^(1/2-80) / (6^80*(80-1/2)).

This is the standard periodic-Bernoulli Euler–Maclaurin remainder integrated over the positive real axis, using 2*zeta(80)<4 and 2*pi>6. Every actual rising-factorial modulus is bounded directly here, rather than by the producer's S+j bound. The denominator is sigma+2M-1=79.5>0, and the power is 1-sigma-2M=-79.5. The direct expression needs no |s-1| multiplier in its remainder. The resulting disk is enlarged to a coordinate square before further interval operations.

The phase calculation is also independent. Pi is enclosed by exact rational Machin sums, with 100 alternating arctan terms at 1/5 and 1/239 and the explicit next-term error. The evaluator uses

    theta0 = t*(log(t)-log(2)-log(pi)-1)/2-pi/8

and computes V as cos(theta0)*Re(zeta)-sin(theta0)*Im(zeta). The producer instead uses log(t/(2*pi)) and a complex exponential. Both formulas represent exactly the same real proxy, but the interval computations differ. No builtin zeta, Gamma, indexed-zero, zero-count, S, Hardy-Z, or historical zero-location routine is called by the independent replay.

Every exact rational sample is recomputed, with no diagnostic midpoint or supplied value interval used for acceptance. All 1070 intervals are strictly on the requested side of zero. The smallest certified signed lower endpoint occurs at t=895/8, index 35, and exceeds .000464042577721847. The largest added EM error is below 2.898e-33. These decimal summaries are diagnostic; the saved JSON contains the exact dyadic lower bounds used in acceptance. The evaluation loop took about 1.40 seconds, excluding initial pin checks and coefficient construction. This is a measured bounded replay, not a runtime forecast.

## Exact sample geometry and independent count

Checked exactly 1070 rational points, t_0=14, t_1069=1500, strict increasing order, and membership in the author's 1/8 grid. The first sign is negative, the last positive, and every adjacent pair alternates. The 1069 open brackets are therefore pairwise disjoint, though adjacent brackets share a certified nonzero endpoint. Replaying the entire earlier discovery grid is unnecessary for the existence conclusion; only the retained strict signs and geometry matter. I did not rerun that discovery scan or infer its historical timing from this replay.

The target count comes from the separately accepted head contour, not the number of sign changes. Its fixed data and review establish N(14)=0 and N(1500)=1069, counting all nontrivial positive-ordinate zeros with analytic multiplicity. The contour spans real parts -.1 to 1.1, includes a certified nonzero bottom and top, and the source carrier exclusions identify this count with all nontrivial zeros in the strip. No line-RH assumption enters it.

This review checks the head hashes and endpoint identities and independently recomputes every cumulative exact Q fraction from its already accepted checkpoint counts. It obtains the same Q1500<1.668. It does not claim a second full contour evaluation. That earlier full numeric replay, independent rational topology/crossing audit, selected alternate Taylor evaluation and mathematical carrier review retain their original stated scopes. The source-oriented local-log rectangle bridge supplies the proper winding/multiplicity proof route; based-path homotopy is not silently inferred from closed-loop interpolation.

The head top contour certifies no zero at ordinate 1500, while its N(14)=0 contour and boundary nonvanishing exclude lower positive zeros through 14. The bottom also excludes real zeros in the nontrivial strip. These are stronger endpoint facts than merely seeing nonzero critical-line sign samples at 14 and 1500.

## Phase and multiplicity joins

The independent analytic route review verifies, for the source xiF normalization,

    xiF(1/2+it) = -(t^2+1/4)*pi^(-1/4)*|Gamma(1/4+it/2)|*Z(t).

Reflection and conjugation make xiF real there. The factor is strictly negative, so the normalized Hardy function Z is real and continuous. The normalized analytic log-Gamma/Binet estimate gives |theta-theta0|<.347 for t>=14, hence cos(theta-theta0)>.939. Therefore V=Z*cos(theta-theta0) is continuous and has exactly the zeros and signs of Z. This is an exact analytic identity, not a numerical imaginary-part test.

The intermediate value theorem gives at least one critical-line zeta zero in each of the 1069 disjoint brackets. They are distinct, and each contributes at least one to the complete analytic multiplicity sum. That sum is independently exactly 1069. Equality excludes every off-line zero, every additional bracket zero, and every extra multiplicity. In particular every counted zero is simple; simplicity was not assumed to justify the sign search or the use of the intermediate value theorem. The conclusion applies to the entire positive-ordinate carrier through 1500, not merely the displayed brackets. Conjugation preserves the zero orders and supplies the negative-ordinate statement.

## Status and remaining work

The independently replayed sign data, accepted head count and reviewed analytic joins now provide external evidence and a paper proof of finite RH and simplicity through height 1500. No historical completeness table or new allowed analytic assumption is introduced. This removes the low-height part of the principal strip certificate at the external-evidence level.

It does not establish the strip on 1500<|gamma|<=1000000, the full-family finite assertions for other characters, or final Goldbach closure. Kernel formalization remains necessary for the EM identity and remainder, interval primitives and exact enclosures, normalized Gamma/Binet and Hardy realness, contour/analytic-order transport, the sign inequalities, the intermediate-value construction, and multiplicity saturation. The existing source xi identities alone do not constitute those completed Lean bridges.
