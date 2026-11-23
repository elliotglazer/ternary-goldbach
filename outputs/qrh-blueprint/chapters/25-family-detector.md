# Family-detector experiment at p=149993

Research only; no Lean compilation or implementation. Source pin: `work/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The script `family_detector_test.py` and its output `family_detector_results.json` accompany this note.

**Result.** Real centers closer to 1 substantially improve the mass-at-2 estimate, but the proposed nonnegative positive-detector method still fails at the hard cell p=149993, delta=.082, y=1e25. A paper argument with exact rational final checks proves cost >.11 for all nonnegative combinations with real abscissae sigma>=9/8 and arbitrary imaginary centers. It also proves cost >.068 after enlarging the family to every sigma>=1.02. The existing source theorem `MinorArcs/NumericsCells.lean:10`, `c0_g0`, gives the actual downstream envelope ghatY(1e25,150000)<=.060272. Thus this is an obstruction to this detector-majorant method for the actual consumer, not merely the stricter .0121 or .01398 surrogate. It is not an obstruction to QRH, to the true base-gap estimate, or to methods using additional information about actual zeros.

## 1. Exact family average, with the principal character removed

Let p=149993, n_e=(p-3)/2=74995, n_o=(p-1)/2=74996, N=p-2=149991. These are the numbers of even primitive, odd primitive, and all primitive characters modulo this prime. Every nonprincipal character modulo p is primitive; the principal character has conductor1 and is excluded here.

For z=sigma+i*t with sigma>1 set

    B(z)=sum_(n>=1,p does not divide n) Lambda(n)n^(-z),
    C+(z)=sum_(n>=1,n=1 mod p) Lambda(n)n^(-z),
    C-(z)=sum_(n>=1,n=-1 mod p) Lambda(n)n^(-z).

Absolute convergence permits interchanging the finite character sum with the Euler series. Orthogonality gives the following exact sums of L'/L, before taking real parts:

    sum_(chi primitive) L'/L(z,chi) = B(z)-(p-1)C+(z),
    sum_(chi even primitive) L'/L(z,chi) = B(z)-(p-1)(C+(z)+C-(z))/2,
    sum_(chi odd primitive) L'/L(z,chi) = -(p-1)(C+(z)-C-(z))/2.

The B term is precisely the removed principal character. It must not be omitted, nor replaced by the zeta series including multiples of p. The sign is from L'/L=-sum Lambda(n)chi(n)n^(-z).

The completed log-derivative means are therefore

    M_e(z)=.5log(p/pi)+.5Re digamma(z/2)
             +Re[B-(p-1)(C++C-)/2]/n_e,
    M_o(z)=.5log(p/pi)+.5Re digamma((z+1)/2)
             -Re[C+-C-],
    M(z)=(n_e M_e+n_o M_o)/N.

These formulas distinguish the two parity gamma terms. There is no principal pole in these completed nonprincipal L-functions.

The positive-zero identity needed to use them as detectors is

    M_a(z)=average_(primitive chi of parity a)
       sum_rho m_rho*(sigma-beta)/((sigma-beta)^2+(t-gamma)^2).

All zeros are the actual nontrivial completed-L zeros, with multiplicity. For sigma>1 their summands are nonnegative. Establishing the completed-log-derivative identity, its convergence, and the primitive zero correspondence in Lean remains a separate analytic bridge; it is not introduced here as an axiom. This experiment grants the identity to assess whether the resulting method would be strong enough even after that bridge is proved.

A nonreal character must not be assigned the real-character quartet without proof. At gamma0 the functional equation together with conjugation pairs beta with1-beta inside the character, and conjugation supplies the corresponding zero of the conjugate character. The detector test can instead be read simply as the required majorant inequality on the permitted reflected pair; it makes no assertion that actual zeros at these points exist.

## 2. Rigorous truncation formulas and numerical implementation

The script sieves Lambda(n) up to L=10^6, omits multiples of p, and computes the above three Euler sums. For sigma>1 put

    I_sigma(u)=u^(1-sigma)*(log(u)/(sigma-1)+1/(sigma-1)^2).

This is the exact integral of log(v)/v^sigma from u to infinity. For residue r=1 or p-1 let n_r be the first integer >L congruent to r mod p. Since log(v)/v^sigma is decreasing on this range,

    |tail B| <= I_sigma(L),
    |tail C_r| <= log(n_r)/n_r^sigma + I_sigma(n_r)/p = R_r.

The imaginary twist has modulus1, so these bounds are uniform in t. Hence the Euler-mean errors are at most

    epsilon_all = [I_sigma(L)+(p-1)R_+]/N,
    epsilon_even = [I_sigma(L)+(p-1)(R_++R_-)/2]/n_e,
    epsilon_odd = R_++R_-.

These are analytic bounds, not statistical estimates. The program evaluates them in ordinary floating point, so its displayed decimal endpoints are not themselves outward-rounded interval certificates. A future certified evaluation must also enclose elementary-function roundoff.

Digamma is evaluated diagnostically by recurrence to real part at least30 and a finite asymptotic expansion. This is not an interval-certified special-function evaluation. The rigorous obstruction in Section4 avoids trusting these decimal evaluations.

We evaluated t in {0,.5,1,2,4,8,16,32}; negative centers have the same family mean and test-pair value because the family is closed under conjugation. The original sigma set was {1.125,1.25,1.5,2}; the expanded test also used1.02,1.05,1.1. No optimizer or LP library is required for the single-pair necessary condition: every nonnegative combination has cost/test-pair ratio at least the smallest individual ratio.

## 3. Actual numerical findings

For the reflected test pair beta=7/8 and1/8, gamma=0, write

    W(sigma,t)=(sigma-7/8)/((sigma-7/8)^2+t^2)
               +(sigma-1/8)/((sigma-1/8)^2+t^2).

The real-center outputs are:

| sigma | truncated completed mean M | Euler truncation bound | M/W |
|---:|---:|---:|---:|
| 1.02 | 4.7679176743 | .032281103 | .59495819 |
| 1.05 | 4.7913758285 | .004524048 | .70509451 |
| 1.10 | 4.8284042092 | .000799844 | .88269264 |
| 1.125 | 4.8460292512 | .000415364 | .96920585 |
| 1.25 | 4.9265306955 | .000030320 | 1.38558676 |
| 1.50 | 5.0584898594 | .000000431 | 2.17356986 |
| 2.00 | 5.2516304099 | .000000000206 | 3.69255263 |

Among all tested shifted centers, the best diagnostic ratio is always attained by t=0 at the smallest sigma. The original grid's best ratio is .96920585 at sigma9/8. Adding sigma1.02 improves it to .59495819. The larger truncation uncertainty near1 is explicitly retained.

The actual etaU Mellin-Taylor series at beta7/8, delta=.082, truncated after30 terms, diagnostically gives

    F = 1.1383729847 + .5424828811 i,
    |F| = 1.2610236828.

Its analytic Taylor-tail expression is about7.02e-27; that tiny expression does not certify all floating-point Gamma and summation errors. Using these diagnostic values, the original grid's necessary normalized majorant cost is about.35495, and the expanded grid's about.21789. Those diagnostics suggest a large shortfall, but the proof of insufficiency below uses coarser exact inequalities instead.

## 4. A paper obstruction independent of the floating-point table

### Every detector has a family cost bounded away from zero

For all sigma>=1.02 and every real t,

    M_e(sigma+i*t)>4,  M_o(sigma+i*t)>4,  hence M>4.

Here are explicit sufficient estimates.

First, .5log(p/pi)>41/8=5.125. Use pi<4, e<11/4, and exp(1/4)<4/3. The exact rational comparison

    (11/4)^10*(4/3) < p/4

implies log(p/pi)>10.25.

Next, Re digamma(u+i*v)>=digamma(u) for u>0, by the convergent digamma series term by term. Digamma is increasing on positive reals. Since the real arguments are at least1/2, Re digamma>=digamma(1/2)=-gammaEuler-2log2>-2, using gammaEuler<.6 and log2<.7. Thus each half-digamma term is greater than-1.

Finally, uniformly for sigma>=1+a, a=1/50, the absolute value of each parity Euler mean is less than1/8. A deliberately coarse proof uses Lambda(n)<=log(n):

    |B| <= 2+1/a^2,
    |C_+|, |C_-| <= 12/100000 + (12/a+1/a^2)/p = R.

For B, isolate n=2,3, whose individual terms are less than1, and dominate the remaining decreasing sum by the integral from1 to infinity, equal to1/a^2. For C_r, the first possible nonzero index is >=p-1>100000 and <=p+1; log(p+1)<12, checked from (27/10)^12>p+1 and e>27/10. The progression integral gives the displayed R, discarding the factor n_r^(-a)<=1. The n=1 term in C_+ is zero.

The even mean is bounded by

    (2+1/a^2)/n_e + (p-1)/(p-3)*2R < 1/8.

This also dominates the odd mean bound2R. The script checks the final rational inequality exactly for both a=1/50 and a=1/8. Combining the three bounds gives M_a>5.125-1-.125=4. This argument works for every t and does not rely on any finite gamma grid.

### A stronger elementary transform lower bound

As in BASE_GAP_QRH.md, set H(s)=Mellin(etaU)(s), with the actual eta2 Gaussian convolution. For beta7/8, A(beta)=Mellin(eta2)(beta)>=1. Improve the earlier lower bound for its Gaussian factor by splitting at1:

    integral_0^1 u^(15/8) exp(-u^2/2)du > .6/3,
    integral_1^infinity u^(15/8) exp(-u^2/2)du
       >= integral_1^infinity u exp(-u^2/2)du = exp(-1/2)>.6.

Thus H(beta)>.8. The existing paper calculation H(beta+2)<=135/64 remains valid. Using cos(v)>=1-v^2/2, delta=.082, and pi<22/7 gives

    |F(7/8,.082)| >= Re F(7/8,.082)
      > 4/5 - 2*(22/7)^2*(41/500)^2*(135/64)
      = 10188173/19600000 > .51.

No numerical Gamma evaluation is needed. The final rational comparison is checked exactly.

### Consequence for all nonnegative combinations

Suppose nonnegative coefficients lambda_j give a pointwise majorant, on every permitted reflected pair, of the absolute zero contribution. At this test pair they must satisfy at least

    sum_j lambda_j W_j >= .51.

This is a generous necessary condition: it only charges the right-edge zero and ignores the nonnegative contribution of its reflected partner. It remains valid when the real-part attenuation y^(beta-7/8) is retained, since the right-edge factor equals1. The averaged detector cost is sum_j lambda_j M_j.

For sigma_j>=9/8, W_j<=4+1=5, hence

    sum_j lambda_j M_j > (4/5)*sum_j lambda_j W_j >= .408.

For the enlarged family sigma_j>=1.02,

    W_j <= 1/(1.02-7/8)+1/(1.02-1/8) < 8.1,
    sum_j lambda_j M_j > (4/8.1)*.51.

These comparisons hold for arbitrary real centers t_j and any finite nonnegative combination, not only the sampled grid. They also allow different nonnegative combinations for even and odd families because the lower bound M_a>4 holds separately for each.

The exact Gauss-L1 normalized factor for the N primitive characters at p is

    Fp = y^(-1/8)*N*sqrt(p)/(p-1) = .2904240653... at y=1e25.

For a rational lower certificate use y^(-1/8)>.0007, sqrt(p)>387, and N=p-2. Exact rational comparisons then prove

    Fp*.408 > .11,
    Fp*(4/8.1)*.51 > .068.

These are lower bounds on what this positive pointwise-majorant recipe must spend, not lower bounds on the true exponential-sum error. The actual error may have cancellations or its zero inventory may avoid the test configuration entirely. Those are additional ingredients which this recipe, by its definition, does not exploit.

At y=1e25 the source `c0_g0` gives ghatY<=.060272. Thus even the enlarged sigma>=1.02 family cannot certify the required bound by this recipe. Ignoring the main term, removals, and all other character/conductor contributions already leaves a cost>.068. Adding these positive allowances cannot repair the deficit.

The claim does not cover signed combinations whose total detector is nevertheless nonnegative, extra constraints excluding the test pair, moments nonlinear in the character family, or direct cancellation in the reconstructed exponential sum. It also does not cover centers1<sigma<1.02; our coarse absolute Euler estimate loses strength there. Those are possible next directions, not methods ruled out by this calculation.

## 5. Proof-status boundary and useful next move

The Euler orthogonality formulas and tail bounds are mathematical derivations with fully specified normalizations. The numerical table uses floating-point elementary functions and an uncertified digamma approximation. The coarse obstruction has a paper proof using standard digamma facts and exact rational final checks; it has not been compiled or independently audited in this task. The analytic identities for completed L-functions and their infinite zero sums remain Lean obligations even though granting them does not make this detector method strong enough.

This experiment did produce more than a restated missing estimate: it evaluated actual character-family Euler averages, quantified the improvement from moving sigma2 to9/8 and1.02, and excluded every nonnegative combination of the latter detector family as a sufficient pointwise absolute majorant at the threshold.

A focused next test should change the information, not merely add more shifted centers with sigma>=1.02. Two specific options are: derive a signed combination with a rigorously nonnegative zero kernel that strongly suppresses beta near1/2 while detecting beta7/8; or compute a second family moment of truncated logarithmic derivatives using exact character orthogonality, then test whether it excludes a sufficient proportion of right-edge low-height pairs. Either must retain the actual principal subtraction and supply explicit tails. Direct character-sum cancellation is another route, but is outside this bounded detector experiment.


Independent review: the integration worker completed FAMILY_DETECTOR_REVIEW.md and found no mathematical defect in the stated finite nonnegative-combination obstruction. The verified scope is a common detector combination for the whole family, or separate combinations common within each parity. Arbitrary character-dependent detector coefficients require additional weighted information and are not covered. Its independent exact lower certificate is255834649/3749800000>.068. No Lean verification was performed.
