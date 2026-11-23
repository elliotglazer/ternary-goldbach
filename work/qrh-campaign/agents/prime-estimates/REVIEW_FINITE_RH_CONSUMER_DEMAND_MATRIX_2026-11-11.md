# Independent review of the finite-RH demand matrix

2026-11-11. **PASS for the conditional source/paper demand map and the proposed even-family energy allowance. No author correction requested.** This does not supply finite RH certificates, prove a new reduced height, or validate a replacement Lean proof closure. No analytic values, characters, zero data, transforms or builds were evaluated. The only executed computation was source/artifact hash verification.

Reviewed author: `audit/FINITE_RH_CONSUMER_DEMAND_MATRIX_2026-11-11.md`, SHA256 `54B08C6DA98CFD0F27FE055371CFFF07A167BC8987225F7865439515623F9A4E`.

## The exact ambient term

I checked the actual `Bombieri.totient_mul_sum_units` and `norm_sq_gaussSum`, `ArcChars.arc_chars` and its primitive/removal proof, `LargeSieveArcs.Qset`, the parity branches in `BaseGap2.gap_point`, and its `S_etaStar_eq_expTsum` adapter. The relevant source hashes are all the ones pinned by the author.

To make the notation unambiguous, for each actual ambient modulus q in Qset(R), put a= coprimePart q (cP x), and define

    t(q,psi)=||gaussSum psi stdAddChar||
             *||Schar psi^-1 a beta||/x,
    c=conductor(psi^-1)=conductor(psi).

Then the nonprincipal numerator energy is exactly

    Eplus_q=(1/phi(q))*sum_(psi!=1) t(q,psi)^2.            (1)

This follows from the source's phi(q)-multiplied Parseval identity, after removing its principal term. There is no additional phi(q) outside (1), nor an average over primitive conductors in its place. The proposed per-character bounds in the matrix are read as bounds for this ambient t(q,psi), classified by c. They are not bounds only at q=c and not bounds for an unrestricted primitive character sum without removal.

Inversion permutes the ambient labels and preserves the conductor. The source proof actually uses the primitive ancestor of psi^-1, so this convention preserves the inverse in Schar and the original psi in the Gauss sum. No extra inverse channel is silently discarded.

## Support count and the factor two

For c dividing q, the source Gauss norm is nonzero precisely when q/c is squarefree and coprime to c; its square is then c. At a prime power p^a exactly dividing q:

* If a=1, local conductor exponent zero or one is allowed; all phi(p) local characters contribute.
* If a>=2, only conductor exponent a is allowed. The reduction on local unit groups is onto, so the characters factoring through p^(a-1) number phi(p^(a-1)); the supported number is phi(p^a)-phi(p^(a-1)). Their fraction is 1-1/p. This includes p=2,a=2.

CRT multiplies the local counts. The principal character has conductor one and nonzero Gauss weight exactly when q is squarefree. Removing that label therefore gives exactly

    kappa_q=|J_q|/phi(q)
      =product_(p^2 divides q)(1-1/p)
          -1_(q squarefree)/phi(q),                    (2)

where J_q excludes the principal label. For q=1 and q=2 the formula gives zero, as required. It does not subtract a nonexistent principal contribution at nonsquarefree q.

If 4 divides q, every supported conductor has the full 2-adic exponent of q, hence is divisible by four. In particular, an odd primitive character induced to such a q has zero Gauss weight; it cannot contaminate this branch with an unrelaxed term. Equation (2) gives kappa_q<=1/2. If 4 does not divide q, no supported even primitive conductor occurs: conductors with exact 2-adic valuation one have no primitive characters, since the unit-group factor modulo two is trivial. The ambient moduli q=2d for odd d nevertheless remain; their supported characters come from odd conductors.

Consequently, with K=4.25e-7, full ambient bounds

    t(q,psi)<=K for odd c,
    t(q,psi)<=sqrt(2)*K for 4|c

give Eplus_q<=K^2=1.80625e-13. At 4|q this is (1/2)*2*K^2; at other q it is at most K^2. This is an exact arithmetic support allowance, not an assumption about average character energies. It is not available at every even q or every nonsquarefree q: for example q=2d with d odd squarefree has no uniform half-support factor.

The primitive-to-ambient estimate must remain

    t(q,psi)<=sqrt(c)*(primitive unrestricted bound
                                  + ambient removal bound)/x.

Thus enlarging only the first summand by sqrt(2) does not automatically use the full allowed constant. The author explicitly preserves this requirement. A new even-height proof must budget both terms and all its other analytic errors. No new height or rho=5.75e-7 allocation is inferred here: this matrix's concrete proposal preserves the existing rho=5.12e-7 route.

## Conductor support of A versus plus and base gap

The A weight contains mu(q)^2/phi(q)^2. A nonzero term has squarefree ambient q, hence every inducing divisor c is squarefree. Such a primitive c is odd, since a squarefree even conductor would have exact 2-adic valuation one. It is therefore correct that A has no contribution from nonsquarefree primitive c, including every 4-divisible conductor.

This is not true for plus, B, or the base gap. At ambient q=c, each existing primitive label has positive Gauss square c. The parity caps from Qset are odd c<=R and 4|c<=2R. An odd conductor induced into an even q obeys 2c<=q, so it is still at most R. There is no new deletion of a primitive conductor from these larger demands merely from its being nonsquarefree. This is a nonzero structural coefficient assertion; it does not assert any actual analytic sum is nonzero.

The matrix correctly keeps primitive conductor and ambient modulus distinct throughout. In particular, deleting the empty primitive family at c=2 mod4 does not delete ambient q=2 mod4 or its character sums.

## Height union and base-gap variables

The two branches of the actual `gap_point` proof retain the sharper geometry before weakening to its common conclusion. At general retained R they yield

    odd m: 4R/(49m)<=|d|<4R/m,
    even m: 8R/(49m)<=|d|<8R/m.

Here m is the original character modulus; m/gcd(m,2) is a different rational-approximation denominator. The source etaStar adapter gives coefficients Lambda(n)etaU(n/y), y=x/49, with additive perturbation d/y. It does not introduce d/49 at this base-gap stage. The odd inducing case m even has m>=2c, yielding the stated common primitive twists 531600/c and 1063200/c at R=132900.

I compared the pinned plus, base-gap and star-floor papers. Their heights and domains match the matrix. With u>=19.89 and pi bounded below by 3, the odd plus coefficient exceeds the base coefficient because 19.89*3*531600=31720572>27000000; the even inequality doubles both sides. Ceiling is monotone. Also the plus expression is at least 460 and its twist coefficient is greater than 704/343. Therefore Hbase<=Hplus and Hstar<=Hplus on every retained class, including switching points and the floor-controlled end of the range. There is no uncovered equality case at an integer ceiling.

Ordinary RH on the larger closed height implies the weaker upper-strip star premise through Hstar, not conversely. Both signs, true multiplicities and nontrivial real zeros remain in the demanded carriers. The matrix does not infer closed RH from a list of discovered critical-line zeros.

## Current status and exclusions

The independently reviewed cubic reallocation accepts A<=1e-10 and B<=2000 as sufficient after the preserved plus/principal inputs. Its B<1915 composition consumes the independently reviewed etaU coefficient bound and localized source sieve. This removes the nonprincipal star-B spectral demand within that route, conditionally on those remaining analytic/formal inputs. It does not prove plus or A.

The older independently reviewed squarefree .5075 star profile already gives A<4e-12 and is enough for this union argument. The author's pending .5357 profile need not be accepted to obtain the matrix's conclusion. Likewise no later all-conductor plus reallocation is silently combined with the preserved rho=5.12e-7 constants.

Since the retained plus finite-RH profile dominates both the base-gap and squarefree-star heights, removing the star-B demand does not further shrink the union of required finite certificates at this checkpoint. Future changes to plus would require recomputing the union; base-gap would then again be a possible lower constraint. This is a statement about the chosen sufficient proof recipes, not a theorem that these certificates are necessary for Goldbach.

The principal c=1 row remains separate. RH through 10^8 alone does not prove retained head moments, finite arithmetic or all helper theorems. The source's broad Fact PlattGRH wrappers still need localized replacement and compatible kernel/axiom validation. The matrix's reference to the earlier three-target audit is appropriately limited to its inspected source consumer frontier; it is not a transitive whole-repository closure claim. Unbounded scales and auxiliary arithmetic moduli are not restricted by the finite conductor table.

## Evidence

All 15 author-listed source/report hashes were matched independently, as was the author hash at the top of this review. Source inspection covered Bombieri:106–179, ArcChars:347–440, LargeSieveArcs:26–35 and BaseGap2:185–242, with the definition of qt in LargeSieveWeights. The pinned author/review pairs for plus, base-gap and star-floor were compared at their relevant contracts, without rerunning their scalar or analytic work.

The additional comparison of the actual A/Eplus definitions used `WSTAR_WEIGHTED_SPECTRAL_STATISTIC` and the already-pinned modulus-weighted report. No new numerical receipt is needed for the finite character count or height domination: they follow from the explicit local-count and rational inequalities above. This review adds no source theorem, final premise, spectral data, or performance estimate.
