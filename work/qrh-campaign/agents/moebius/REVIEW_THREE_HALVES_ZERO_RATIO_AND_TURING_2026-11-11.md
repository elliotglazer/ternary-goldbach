# Independent review of the three-halves zero-ratio proof

2026-11-11. Verdict: PASS for the complete continuum scalar proof and its stated paper-level b=9 implication, with the two application corrections below. The author artifact remains unchanged. Its final rounded-grid guard must be consumed with this review, not literally as printed. No analytic values, zero data, transforms, Lean declarations or builds were produced. Thirty-nine exact rational and file-pin checks passed.

Author: `major-constants/THREE_HALVES_ZERO_RATIO_AND_TURING_2026-11-11.md`, SHA256 `C28A4328D55AFCD5638F0171FC152E7C2C7DAB627EAB13FE97A5DF7AF920F1F9`. Paths without an absolute prefix are relative to `work/qrh-campaign/agents`.

## 1. Integrability and the full real boundary

The intended integral is the difference of real log norms. For y=0, a zero of a-t is a single integrable logarithmic singularity; the endpoint a=1 is included. Totalized quotient identities hold almost everywhere, not at that singular point. The previously reviewed log-integrability adapter applies. For a>0, the integrand is nonnegative almost everywhere and decreases as y squared increases. Hence 0<=J(a,y)<=F(a)=J(a,0).

The exact formula

    F(a)=(a+1)log(a+1)+(a-1)log|a-1|-2a log a

has a continuous extension through a=1 and to F(0)=0. On 0<a<1, differentiating gives log(1-a^2)-2log a. Integrating the six-term upper bound for log(1-v) from zero to a, with the integrable -2log a term retained, gives

    aF(a)<=P(a^2),
    P(t)=2t-t log t-sum_{k=1}^6 t^(k+1)/(k(2k+1)).

This P has a finite polynomial correction to a logarithmic term; no numerical polynomial fit is involved. Each omitted series term has the correct negative sign. P''(t)=-1/t-sum (k+1)t^(k-1)/(2k+1)<=-1 for 0<t<=1.

At u=7/8, the integral for log(8/7) lies between 2/15 and 15/112. Independently reconstructed rational substitution gives exactly the author's three fractions for P(u), the lower derivative bound and the upper derivative bound. In particular P(u)<191/128 and 0<P'(u)<1/8. Integrating the second derivative estimate on either side of u gives

    P(t)<=P(u)+P'(u)(t-u)-(t-u)^2/2
         <=P(u)+P'(u)^2/2<3/2.

Continuity handles t=0 and t=1. Thus aF(a)<3/2 on 0<a<=1 without an unsampled boundary interval.

For a>=1, the exact derivative in t of a log((a+t)/(a-t)) is 2a^2/(a^2-t^2). It is at most 2/(1-t^2) for 0<=t<1. Integration twice gives aF(a)<=F(1)=2log2. The atanh integral gives log2<3/4, strictly because its integrand is below the endpoint bound on a positive-measure set. This covers every a>=1, including the meeting point. No vertical artificial boundary at a=1/2 or 3/2 is needed.

## 2. Harmonic domain, branch, origin and infinity

In the open first quadrant, z, z+1 and z-1 all avoid the principal-log cut. The two integrated antiderivatives have cancelling constants, so

    Phi(z)=(z+1)Log(z+1)+(z-1)Log(z-1)-2z Log z
    Re Phi(z)=J(Re z,Im z).

The exponential of Phi(z)-(3/2)/z is holomorphic there. On a closed quarter annulus r<=|z|<=R with r>0, use the upper boundary value for Log(z-1) on the negative real axis. Its product with z-1 tends to zero at z=1, since |w Log w|<=|w|*(|log|w||+pi). This is a continuous extension from the domain, not a claim that principal Log is globally continuous across its cut. The pole at z=0 is excluded by r>0.

Writing H=Re(Phi-(3/2)/z), the positive real boundary has H<=0 by section 1. On the positive imaginary boundary, the two log norms agree and Re(1/z)=0, giving H=0. The complete remaining frontier is the two circular arcs, including their endpoints.

On the inner arc, the subtracted term is nonnegative before subtraction, and

    H<=J<=F(a)<=2a(1-log a)<=2r(1-log r).

The last comparison uses a<=r<1 and derivative -2log a>=0. The bound tends to zero uniformly as r tends to zero. In particular the singular reciprocal term is never assumed to have a finite limit at the origin.

On the outer arc R>2, |(z+t)/(z-t)|<=(R+1)/(R-1) uniformly for 0<=t<=1. Therefore H<=2/(R-1), which tends to zero uniformly. No comparison of two small real parts near the imaginary axis is needed.

The bounded maximum modulus theorem applied to the exponential gives H<=max(2r(1-log r),2/(R-1)) on the entire quarter annulus. For each fixed interior z, choose r<|z|<R and then exhaust the quadrant. This proves H<=0 there. Evenness in y and the already proved real boundary give the claimed inequality for all a>0 and all real y. This is a continuum proof; its acceptance does not rest on the rational scalar receipt alone.

The pinned `Analysis/Complex/AbsMax.lean:404` requires a bounded set, `DiffContOnCl`, a full frontier bound and membership in the closure. The construction above supplies those mathematical hypotheses, but the one-sided extension and quarter-annulus frontier adapter still need formal implementation. `Analysis/SpecialFunctions/Complex/LogDeriv.lean:37,41` gives the slit-plane derivatives used in the interior. These interfaces were read directly.

## 3. Finite zeros and the Turing implication

The scalar inequality sums over any finite carrier with nonnegative true multiplicities. It does not require conjugate pairing, a zero-free ordinate or simple zeros. The separate reflection paragraph is also correct: the inverse-character functional equation followed by conjugation preserves each ordinate and the local analytic order. At a fixed critical-line zero the order is counted once, with no evenness assumption.

I checked the actual finite-removal contract in `GENERAL_COMPLETED_L_REAL_RESOLVENT_SOURCE_ROUTE`, sections 4-5. With real resolvent error at most epsilon and integrated zero-removed remainder error at most epsilon, the new coefficient 3/2 gives total error (5/2)epsilon. The limit removes it. This uses a complete finite carrier and exact orders; lower sign counts cannot replace that carrier. No infinite-product or sum-integral interchange is introduced by the new scalar lemma.

The source `DirichletContinuation.lean:249,258,283` supplies nonprincipal entireness, the completed/usual relation and the primitive inverse-character functional equation. The actual finite-resolvent construction, its reflection adapter and the canonical Littlewood identity retain the formal obligations in their previously reviewed packets. This review does not turn those paper assemblies into compiled Lean theorems.

The quantitative substitution checks exactly:

    -(3/2)*(Z/2+2.525)+Z/2-1/40-2.368
       =-Z/4-6.1805.

Together with the inherited upper bound 3.434+3Z/4, both orientations of the endpoint difference are less than 9.6145+Z_H. Monotonicity Z_t<=Z_H applies to each positive-coefficient occurrence. At Z_H<=18 this is below 9*3.14<9pi; at Z_H<=20 it is below 10*3.14. Thus b=9 or b=10 follows in the stated nonprincipal primitive domain t1,t2>50, conditional on those analytic source assemblies. Principal and imprimitive cases are not included.

## 4. Corrections to the auxiliary-grid application

Two application details in the frozen author's final section need correction. Neither changes J<=3/2 Re(1/z) or the b=9 theorem.

First, for the reviewed dense grid, T is the rounded main top, not the nominal height. Its available bound is

    cT<128160000+265800*(5/64).

The printed bound cT<=128160000 omits this possible overshoot. For example, at c=265800 the rounded index 6172 gives cT=256330875/2. The corrected exact sufficient witness for a rational width h is

    [128160000+265800*(5/64+h)]/6 < (8/3)^18.

It passes for h=13. Together with pi>3 and e>8/3 it still proves Z_(T+13)<18.

Second, 13/(5/64)=166.4 is not an integer. Width13 can be used with separately justified rational endpoint/direct evaluations and their full source domains. If a schedule requires coarse-grid endpoints, use 167 steps, h'=835/64, and recompute Abar,W and D at that new endpoint. The corrected log witness also passes for h'. With an independently certified D<=1/2 at that endpoint, the surplus is

    2-1/2-18/h'=201/1670>0.

At literal h=13 the reserve is 3/26; at h=12 the stated D cap gives equality and fails the strict gate. These are sufficient conditions on measured certificates, not proof that any such D exists. The new h' does not inherit old W or D, and neither endpoint option inherits a source-evaluator extension automatically. The author acknowledged these corrections and retained the frozen bytes.

## 5. Checked artifacts and limits

All three Mathlib source pins and all eight paper-input table pins in the author note match their files. I read the relevant maximum-modulus, slit-log and completed-L source declarations and the finite-resolvent and Gamma/Euler interfaces. The historical Booker comparison is not a premise of the new proof and was not independently re-audited here. The lower analytic foundations of the consumed source packets and the known pi lower bound are retained inputs.

The independent checker `moebius/review_three_halves_ratio_20261111.py`, SHA256 `02A66560DE2122BD1B5D99A1094344C6F4A58087C93033D5FEE03FA0D807C0BA`, reconstructed the finite rational substitutions, derivative coefficients, ledger arithmetic and both corrected height witnesses. It did not import the author's program. Its receipt `moebius/review_three_halves_ratio_20261111.json`, SHA256 `B846055E958D3F62816956B1013458B1755107F3D76D3A45AF2E22A6F637D07B`, records 39 passing checks. The default Python launcher was unavailable; the final standard-library-only checker passed with the existing interval-environment interpreter. No interval or special-function library was imported.

The accepted contribution is a complete paper scalar inequality and a conditional analytic allowance implication, with corrected auxiliary-height arithmetic. There is no new spectral certificate, sign margin, finite-RH assertion, runtime forecast or end-to-end cost reduction.
