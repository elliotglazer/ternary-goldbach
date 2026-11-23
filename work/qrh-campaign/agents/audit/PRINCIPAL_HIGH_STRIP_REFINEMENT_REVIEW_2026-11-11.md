# Independent review of the principal high-strip refinement

Date: 2026-11-11. Verdict: PASS as a conditional mathematical implication with independent exact arithmetic. The primary remaining finite target may be widened to the closed strip [.4968,.5032] for 1500<|Im rho|<=1000000, together with the accepted external critical-line result through 1500. This yields W35<23.980532761132<24. The high strip itself is still unproved; this review supplies no new zero computation or Lean theorem.

## Pins and replay scope

The reviewed author artifacts under `major-constants/` are:

| Artifact | SHA256 |
|---|---|
| `PRINCIPAL_HIGH_STRIP_REFINEMENT_2026-11-11.md` | `B5BA5316102AB6AA303B30929B3E10020526F6A17C2D8D560C24B4AC65C6C47D` |
| `principal_high_strip_refinement_20261111.py` | `542867E6669FD724BB1AC34FE778A94C9F0B608B934AA20E2CAB41BB2557F3E9` |
| Its saved JSON | `CEA7698DBFE4D70A74E6EE7C65CDCA2A460608A03590C6E076C2CD7852FA561B` |

All hashes matched. I read the full note and script, the accepted sign/head reviews and the existing low-zero psi contract. I did not execute the author script because it writes its frozen JSON. Instead I wrote and ran `audit/principal_high_strip_independent_review_20261111.py`, SHA256 `2A12626FE7C1D4471AD8002357665660A0709F793A29761E8EFD12B22E039985`. It imports no author code and exited 0. The new JSON records all bounds and pins. No Lean build, zero search, or frozen-file edit occurred.

## The low carrier and exact head identity

Set A=1500 and T=1000000. The accepted external head has N(A)=1069 and Q_A<417/250, with N the complete positive-ordinate analytic multiplicity count and Q_A=sum m*(1/gamma-1/A). The independent sign review `PRINCIPAL_SIGNS_1500_REVIEW_2026-11-11.md`, SHA256 `A2961DEBB4BF2734FB048F1500D6E495E42B5DCB8439DD2412299F803A37FFFE`, establishes critical-line location through A externally. The earlier head review is pinned in the author note and remains the separate source of the complete count and Q bound.

On that low carrier beta=1/2, so the moment's exponential weight is exactly 1. Also |rho|=sqrt(1/4+gamma^2)>=|gamma|. Conjugation preserves multiplicity and supplies the negative ordinates. Therefore

    W_low <= 2*sum_(0<gamma<=A) m/gamma
          = 2*(Q_A+N(A)/A)
          < 3571/750.

The addition N(A)/A is essential because Q_A is a boundary-corrected moment, not the raw reciprocal sum. Simplicity, although separately established externally, is not used. The certified zero-free bottom/height-14 component excludes gamma=0, so division by gamma is legitimate.

## High reflection and endpoint bookkeeping

The high carrier is A<gamma<=T on the positive side. The map rho -> 1-conj(rho) preserves this carrier and multiplicities and negates beta-1/2. Replace 1/|rho| by 1/gamma before averaging; this avoids falsely treating the two unequal norms as identical. The two exponential weights sum to at most 1+exp(35*delta), including fixed points beta=1/2. Reindexing the whole finite sum proves the averaging inequality without choosing disjoint orbits. Conjugation supplies the other ordinate sign, cancelling the factor 1/2. Hence

    W_high <= (1+exp(35*delta))*sum_(A<gamma<=T) m/gamma.

There is no further factor of two. Multiplicity preservation is an analytic symmetry fact to formalize, not a simplicity assumption.

The exact summation-by-parts identity is

    sum_(A<gamma<=T) m/gamma
      = N(T)/T-N(A)/A+integral_A^T N(t)/t^2 dt.

A zero at A is assigned only to the head. Its contributions on the right cancel: 1/T-1/A+integral_A^T t^-2 dt=0. A zero at T contributes 1/T through N(T)/T. Intermediate roots contribute 1/gamma. Thus the identity has the stated closed/open endpoints even without the available stronger nonvanishing at A.

Substitute the reviewed closed-height majorant G(t)=F(t)+5log(t)+20 at T and inside the integral, keeping the exact N(A)=1069 in the negative term. An upper bound for N(A) could not replace this exact input in that direction. No exact value of N(T), no nonzero-top certificate at T, and no lower count bound are needed.

Differentiating F gives F'(t)=log(t/(2pi))/(2pi), so integration by parts yields

    F(T)/T+integral_A^T F(t)/t^2 dt
      = F(A)/A+(log(T/(2pi))^2-log(A/(2pi))^2)/(4pi).

An antiderivative of (5log(t)+20)/t^2 is -(5log(t)+25)/t. Including the upper endpoint term therefore leaves [5(log A+1)+20]/A-5/T. Both negative corrections, -1069/A and -5/T, are justified and retained. The author's H_G formula is correct.

## Exact arithmetic audit

The author uses Machin arctan sums, power-of-two/atanh logarithms and Taylor exponentials with rational tails. I checked their directions. The logarithms entering squares are positive, and the difference numerator is positive, so the chosen upper/lower pi denominators are valid. The exponential remainder bounds the tail starting at the first omitted term. All decimal acceptance comparisons use Fraction.

The independent script uses 80-term Machin sums and verifies proposed log boxes by rational degree-170 exponential bounds. Decimal logarithms generate hints only; each accepted box must satisfy exp_upper(lo)<argument_lower and argument_upper<exp_lower(hi). Thus acceptance does not depend on a floating logarithm. This differs from the author's atanh method. All comparisons pass:

    9.072023958327 < H_G < 9.072023958328,
    delta=2/625:   conservative upper model <23.980532761132,
    delta=13/4000: conservative upper model <23.998305865133.

The primary margin to 24 exceeds .019467238868. The same independent calculation confirms the optional model crossing between .00325476 and .00325477. This brackets a limit of the chosen conservative scalar expression only. It is not a necessary condition on zeta zeros or a lower bound for actual W35.

One nonblocking receipt-label caution: the author's `W_lower_rounded_down` fields are lower enclosures of the conservative scalar model, not lower bounds on the true moment. The note's model discussion makes this intended interpretation clear; future summaries should preserve it. The independent JSON labels its quantities explicitly as model bounds.

## Consumer match and remaining scope

Read the existing `mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md` contract (W). It is exactly the both-sign, multiplicity-weighted sum exp(35*max(beta-1/2,0))/|rho| through T=10^6, with the separate location condition .49<=beta<=.51. Low RH gives beta=.5, and the new closed high strip [.4968,.5032] is strictly contained in that required interval. Equality on the new high-strip real boundaries is allowed by the weight estimate. A zero-free closed right rectangle starting at .5032 is a stronger sufficient certificate and would imply the desired weak bound after reflection.

Consequently the refinement supplies the same W35<=24 input and retains the same x>=5*10^9 psi consequence once all its other ingredients are supplied. It changes neither the intermediate shared finite .555 condition nor the genuine global tail/provider, Gaussian sandwiches, finite prime proof, or final Goldbach roots. Accepted external low RH does not remove their formalization obligations.

The original analytic count bound suffices throughout this proof. The new exact-count/sign route at height one million, its possible count value, and the two-sided count sizing argument play no role. The high finite strip remains an independent external certificate task, and all analytic, numerical and multiplicity bridges remain unproved in Lean.
