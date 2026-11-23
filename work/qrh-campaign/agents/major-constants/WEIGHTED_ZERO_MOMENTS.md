# Weighted zero masses and character moments

This note extends the Mellin worker's proposed principal-character method. It is a paper derivation and arithmetic diagnostic, not a Lean theorem. No compiler ran. The script weighted_zero_moments.py reproduces every conductor sum below using floating-point arithmetic. The transforms, completed-L logarithmic derivative identities, and numerical mass constants still require formal proofs.

The method is useful for the local principal lower-L2 task. Mass alone does not close the current averaged cubic bounds. A useful next analytic lemma would control weighted Gram rows with an explicit local zero count, rather than repeat Cauchy-Schwarz using only total mass.

## Exact spectral normalization and mass

Set theta = 7/8, x >= 4.9e26 and y = x/49. For a primitive character chi of conductor c, define

    M_chi = sum_rho m_rho (2-beta)/((2-beta)^2+gamma^2).

Zeros here are the nontrivial zeros of the completed L-function. At s=2, the completed logarithmic derivative gives, for primitive nonprincipal chi of parity a,

    M_chi = .5 log(c/pi) + .5 digamma((2+a)/2) + Re (L'/L)(2,chi).

For the principal conductor-one function, the pole corrections give

    M_zeta = 3/2 - .5 log(pi) - gammaEuler/2 + zeta'/zeta(2).

The Mellin worker's exact rational calculation supports M_zeta < .07, conditional on the analytic identity and finite prime bridge. Since |L'/L(2,chi)| <= -zeta'/zeta(2), one obtains the safe prospective bounds

    M_chi <= .5 log(c) - .29       for even nonprincipal chi,
    M_chi <= .5 log(c) + .017      for odd chi.

For example these follow from -zeta'/zeta(2)<.57, gammaEuler>.577, log(pi)>1.144 and log(2)>.693. The first bound can be certified by a finite prime sum with the remaining integer integral tail; that certification is not included here. These are explicit proof obligations, not imported source theorems. Their conductor growth is unavoidable in a bound of this form. Replacing Re L'/L by its opposite extreme gives matching lower bounds up to an absolute constant.

Complex conjugation gives M_chi = M_conj(chi). The functional equation pairs beta+i gamma with 1-beta+i gamma within chi; conjugation changes gamma's sign and the character. Consequently the real-character quartet must not be assigned unchanged to a single nonreal character. One can work in the direct sum of the chi and conjugate-chi Hilbert spaces. This preserves the pair's masses and energies but supplies no cancellation between distinct characters.

## The exact Gram identity

Let H be the Hilbert space in delta with the actual integration interval and weight. For Aplus use weight |U(-delta/49)|^2. For each zero put

    v_rho(delta) = x^(beta-theta+i gamma) Mellin_etaPlus(beta+i gamma,delta),
    w_rho = (2-beta)/((2-beta)^2+gamma^2),
    k_rho = v_rho / w_rho.

The harmless sign of the zero term can be included consistently in v. With positive atomic measure nu = sum m_rho w_rho delta_rho, the normalized spectral error is

    e_zero = -x^(-1/8) integral k_rho dnu(rho).

Thus, whenever these sums and integrals converge,

    ||e_zero||_H^2 = x^(-1/4) integral integral
                       Re <k_rho,k_sigma>_H dnu(rho) dnu(sigma).

Writing G(rho,sigma)=<k_rho,k_sigma> gives the weighted Schur bound

    ||e_zero||_H^2 <= x^(-1/4) M_chi R_chi,
    R_chi = sup_rho integral |G(rho,sigma)| dnu(sigma).

A uniform kernel norm ||k_rho||<=K only yields R_chi<=K^2 M_chi, and hence the mass-squared estimate K^2 M_chi^2. Grouping functional-equation pairs or quartets changes the atoms and improves K but does not remove this second mass factor.

This loss is real for abstract positive measures: mass can concentrate where the vectors k_rho are parallel. QRH location and one total positive moment do not prohibit such concentration. This is a limitation of the information supplied, not a claim that the actual L-function zeros exhibit it. A local density bound, a multiplicity bound, or a spacing-sensitive Gram estimate is extra information. It must be proved or sourced explicitly.

## What the proposed principal constant 85 means

The Mellin worker's K=85 is a proposed quartet norm-to-mass bound exclusively on delta in [-4,4]. Its 2-by-2 Gram maximum handles every phase gamma log(x). It is not a bound on the weighted full arc and is not presently a proved bound for a nonreal character pair.

For q=1 it would give

    integral_[-4,4] |e_zero|^2 <= x^(-1/4) (85*.07)^2,

about 7.53e-6 at x=4.9e26. That is compatible with the intended local lower-L2 task. It is not a current Aplus estimate. The vertical remainder for this particular principal calculation was reported below 1e-28 in norm; no analogous conductor-uniform remainder is asserted here.

## Preserve every imprimitive Gauss factor

The following is for primitive spectral terms before the separate Euler/coprime corrections. In Aplus the main factor restricts to squarefree moduli. Pairing q=r and q=2r, r odd squarefree <=150000, gives

    Aplus_zero <= x^(-1/4) sum_c 2c sum_(r<=150000,c|r,odd squarefree)
                     [sum_(chi primitive mod c) ||zero kernel_chi||_H(r)^2] / phi(r)^3.

The factor c is |tau_q(chi induced)|^2 and occurs exactly once. In general q, the squared Gauss norm is c only if q/c is squarefree and coprime to c, and is zero otherwise. None of the calculations replaces it by c outside that support.

For a common weighted norm-to-mass K, the last bound becomes x^(-1/4) K^2 S, where

    S = sum_(odd squarefree c<=150000) 2c
          sum_(odd squarefree r<=150000,c|r) 1/phi(r)^3
          sum_(chi primitive mod c) M_chi,upper^2.

Primitive character parity counts are exact. Their total is multiplicative, with count p-2 at p and p^(a-2)(p-1)^2 at p^a for a>=2. Even-count minus odd-count is mu(c)+1_(2|c)mu(c/2). For odd squarefree c it is simply mu(c). These formulas also handle c=1 separately in the script.

The floating-point sum is

    S = 128.3751519747,
    conductor-one contribution = .01127471156890,
    x^(-1/4) S = 2.72855021487e-5.

To prove the reviewed coprime Aplus target 9e-7 by this common weighted-kernel method would require K <= .18161649. These are diagnostic thresholds, not certified safe decimals. Merely taking K=1 already exceeds the total budget by a factor above 30.

Even on the LOCAL interval [-4,4], multiply the unweighted energy by the valid Fourier supremum 1.2534^2. Taking the proposed K85 only for the principal characters of every contributing modulus gives upper bound 2.72003e-5, about 30.2 times the whole Aplus budget. Hypothetically extending K85 to all characters would give .309706, over 344000 times that budget. Such an extension is not justified; it is an intentionally favorable stress test. Wider arcs would still need a new kernel estimate.

Selected conductor-bin contributions to S are

    [1,2):              .01127471
    [128,256):         4.30897172
    [1024,2048):       8.53476447
    [8192,16384):     14.28921361
    [32768,65536):    18.04512700
    [65536,131072):   19.44886452.

Thus conjugate-character pairing does not supply a decreasing conductor profile. The positive mass grows like log(c), and these bin contributions grow rather than disappear.

## Estar and the mixed Cross term

For the star smoothing, replace x by y and the Mellin twist by delta/49. Astar uses the weight |P(delta)|^2 and the same Gauss reconstruction. A plus-kernel estimate is not a star-kernel estimate. Both transforms must be bounded separately.

A mass-only pointwise envelope would have the form

    |e_chi,+| <= x^(-1/8) M_chi kPlus(delta),
    |e_chi,*| <= y^(-1/8) M_chi kStar(delta/49).

Define the exact weighted character mass

    T_q = 1/phi(q) sum_(chi mod q) |tau_q(chi)|^2 M_cond(chi),upper^2.

Then a common envelope gives

    Cross_zero <= (xy)^(-1/4) sum_q T_q^2
                    integral_arc(q) kPlus(delta)^2 kStar(delta/49)^2 ddelta.

The script preserves the imprimitive support by enumerating q=c*r with squarefree r and gcd(c,r)=1. Enlarging the actual arc index set to every q<=300000 gives the conservative arithmetic quantities

    sum_(q<=300000) T_q^2 = 4.84441863842e18,
    (xy)^(-1/4) sum T_q^2 = 579018.775223.

If each joint kernel integral were replaced by one common bound, spending the entire 1.65e-6 Astar+Cross budget on Cross alone would demand a common bound below 2.85e-12. This enlargement and uniform replacement are coarse; they do not prove the actual Cross is large. They show that the direct mass-only common-envelope argument is quantitatively unusable. General L2 kernel bounds alone do not control this product integral at all.

A useful positive route must instead retain the modulus-dependent intervals and the correlated four-kernel structure, or combine a genuinely small pointwise star estimate with an independent second moment. Passing from real characters to conjugate pairs does neither automatically.

## Actual next lemma and stopping point

The mathematically relevant next object is the weighted Gram row R_chi for the real etaPlus transform, with the true |U(-delta/49)|^2 weight and modulus-dependent arc interval. An explicit bound on

    sum_(c,r,chi) 2c/(phi(r)^3) * M_chi * R_chi,r

below 9e-7*x^(1/4), together with the nonzero spectral remainders, would address Aplus. The generic Schur inequality above is ordinary Hilbert-space algebra; proving it is not the missing number theory. To improve its row sums one needs explicit estimates for weighted zeros in short height windows, including multiplicity, and decay of off-diagonal kernel entries. No such improvement has been proved in this bounded task. A mixed four-kernel estimate remains necessary for Cross.

The correct immediate use of the new ingredient is therefore the Mellin worker's q=1 local lower-L2 lemma. The available positive mass, QRH location, conjugation and functional equation do not by themselves furnish the averaged cubic estimates. This report does not introduce a new assumption standing in for those estimates.
