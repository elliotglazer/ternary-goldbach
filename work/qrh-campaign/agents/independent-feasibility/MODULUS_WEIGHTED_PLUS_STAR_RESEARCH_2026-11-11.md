# Modulus-dependent plus/star energy and the source sieve comparison

2026-11-11. Research-only paper derivation and exact finite arithmetic. No actual prime sums, character values, transforms, zeros, or analytic integrals were evaluated. No Lean/MM0 build, declaration, source edit, or frozen-file mutation occurred.

There is a genuine arithmetic refinement of the mixed Wstar term. The support dimension of the plus character transform gives a factor at most one half for every modulus divisible by four. This needs no new estimate on the actual plus energy. The resulting weighted target is explicit below. It does not, by itself, make the current prime large-sieve comparison sufficient. A new lower bound for the squared L2 norm of the actual star smoothing shows that even an optimized uniform scalar comparison of the weighted arc coefficients leaves an allowance above 279.3. The entire Wstar target permits less than 169 in the same units, even after deleting all principal and other error costs. This conclusion includes the coordinator's improved principal allocation. It concerns one upper-bound method, not the actual weighted energy or every possible sieve argument.

## 1. Preserve the actual plus energy

Use R=132900, x=49y, y>=10^25, delta=x*beta, Dq=8R/qt(q), and the finite tagged arc measure of the reviewed Wstar report. Let u_q,b be the normalized nonprincipal coprime star sum, with E*_q=sum_b|u_q,b|^2. Let z_q,b be the normalized nonprincipal coprime plus sum, with E+_q=sum_b|z_q,b|^2. These are energies summed over unit numerators, not averages. The character labels, Gauss factors, and q-dependent coprime coefficient sequences are those in `DIRECT_PLUS_RESIDUAL_ENERGY_TARGET` and `WSTAR_WEIGHTED_SPECTRAL_STATISTIC`.

The exact plus decomposition is

    s_q,b = a_q P(delta) + z_q,b + a_q e_q + o_q,b,
    a_q=mu(q)/phi(q), |e_q|<=p0=2.83e-7, |o_q,b|<=d0=1e-15.

Here e_q is the principal coprime error and o is the outer removal. Principal RH through 10^8 and the existing localized source estimates remain inputs. The proposed actual plus inequality E+_q<=epsilon=7.02e-13 is still unproved. It is used below only when stated explicitly.

For the full star residual u+v, retain the improved bound from `WEIGHTED_PRINCIPAL_WSTAR_BUDGET`:

    ||s v||_2 < pbar=1.902e-6.

This is already the entire integrated principal/removal norm. It must not be multiplied by sqrt(j) again. The final target is ||s(u+v)||_2^2 <= j*u0^2, where j=8.79 and u0=3.67e-6.

## 2. A support factor that is available without new spectral estimates

Let J_q be the set of nonprincipal characters modulo q with nonzero Gauss sum, d_q=card(J_q), and kappa_q=d_q/phi(q). This kappa is unrelated to the source's parity factor `kap(c)`.

Finite character orthogonality normalizes the plus expansion as

    z_q,b = phi(q)^(-1/2) sum_(psi in J_q) A_psi psi(b^-1),
    sum_psi |A_psi|^2=E+_q.

All character values at a unit have norm one. Finite Cauchy-Schwarz gives

    max_b |z_q,b|^2 <= kappa_q E+_q,
    sum_b |z_q,b u_q,b|^2 <= kappa_q E+_q E*_q.       (1)

The factor is exact as a support count. `Bombieri.norm_sq_gaussSum:135` says a character of conductor c contributes precisely when q/c is squarefree and coprime to c. At a local prime power p^a with a>=2, this requires full conductor p^a. There are phi(p^a)-phi(p^(a-1)) such characters, a fraction 1-1/p. At exponent one all local characters have nonzero Gauss sum. CRT multiplies these counts. The global principal character must be removed exactly when q is squarefree. Thus, including q=1 and q=2,

    kappa_q = product_(p^2 divides q) (1-1/p)
                  - 1_(q squarefree)/phi(q).             (2)

In particular kappa_1=kappa_2=0, 0<=kappa_q<=1, and kappa_q<=1/2 whenever 4 divides q. For squarefree q it is 1-1/phi(q), which approaches one along large prime moduli. An odd repeated prime p only guarantees the factor 1-1/p; there is no uniform one-half saving for all nonsquarefree moduli. No lower bound on actual energy is inferred from a support count.

This already improves the uniform-rho loss. Define

    C_mix = sum_q integral kappa_q E+_q(delta) E*_q(delta) ddelta,
    B_a = sum_q a_q^2 integral E*_q(delta) ddelta,
    B = sum_q integral E*_q(delta) ddelta,
    A = sum_q a_q^2 integral |P(delta)|^2 E*_q(delta) ddelta.

Minkowski and (1), with the exact normalization from the reviewed Wstar identity, give

    sqrt(49^2 Wstar/x^3)
       < pbar + sqrt(A) + sqrt(C_mix) + p0 sqrt(B_a) + d0 sqrt(B). (3)

All cross terms are included by triangle inequalities. The principal-plus cost carries a_q; the outer plus removal does not. One cannot infer B_a from A by division by |P| because no positive lower bound for |P| is available on the full twist domain.

One complete sufficient allocation, deliberately loose on the tiny outer-removal term, is

    A<=9e-12, C_mix<=50*epsilon, B_a<=1/100, B<=10^6.      (4)

Indeed sqrt(50*epsilon)<5.925e-6, so the right side of (3) is below 10.855301e-6, whose square is less than j*u0^2. These are conditional actual-function targets, not established estimates. If the existing proposed plus bound E+_q<=epsilon is supplied, then C_mix<=epsilon*B_kappa, where

    B_kappa=sum_q kappa_q integral E*_q(delta) ddelta.

Consequently B_kappa<=50 is a sufficient replacement for the C_mix entry in (4). Unlike a renaming of B, it has a proved arithmetic discount, including the entire 4-divisible branch. Retaining actual E+_q could do better still. No smaller E+_q has been assumed or inferred.

## 3. What a weighted source sieve must prove

The source `LargeSieveProof.Farc_eq:143–173` is a finite character identity before its scalar quotient estimate. For fixed nonnegative modulus weights lambda_q, the same interchange gives the coefficient

    W_lambda(c,m) = sum_(q:qt(q)<=m, c|q)
                       lambda_q * w(q,c)/phi(q),
    w(q,c)=c if q/c is squarefree and coprime to c, otherwise 0. (5)

The unweighted coefficient is the source expression

    W_1(c,m)=(c/phi(c))*kap(c)*G_(qt(c))(m/qt(c)).

This weighted identity preserves primitive and imprimitive characters and includes the principal character. It requires the common prime-supported coefficient sequence used by the source: primes above sqrt(x), hence coprime to every modulus up to 2Q, where Q=sqrt(x/16)=7sqrt(y)/4. Splitting the actual etaU coefficients into that sequence and its complement, bounding the small-prime/prime-power contribution, and returning to the actual q-dependent coprime sums remain necessary.

A sufficient uniform coefficient comparison is

    W_lambda(c,m_R(beta)) <= C_lambda(y) W_1(c,m_Q(beta))  (6)

for every relevant conductor and twist. The source integration, arc disjointness, and full-circle Parseval then bound the weighted total prime-supported arc energy by C_lambda times its coefficient square sum. This is the exact place where arbitrary arithmetic weights must be paid. Averaging lambda_q over moduli or primitive labels does not justify (6).

For lambda=kappa, the actual weighted nonprincipal energy has a weighted principal subtraction. In the optimistic limit of exact principal approximation this is

    L_kappa=sum_q kappa_q mu(q)^2/phi(q)
                      integral_[-Dq,Dq]|Fourier(etaUC)(-delta/49)|^2 ddelta.

It satisfies

    L_kappa <=49 V_U M_kappa <=49 V_U M_R <49 V_U*14,
    V_U=integral_0^infinity etaU(t)^2 dt.                 (7)

The factor is mu^2/phi, not mu^2/phi^2. The existing finite mass bound is M_R<=13.59756; replacing it by 14 only favors this attempted method. Coprime-removal and prime-power errors cannot be set to zero in a real proof. They are set to zero below solely to test the best possible comparison within this scalar method.

For actual weights lambda_q(delta)=kappa_q E+_q(delta)/epsilon, (5) remains a pointwise identity, but (6) becomes a new coefficient inequality involving the actual plus energies. The currently proposed uniform plus theorem only gives lambda<=kappa. It supplies no further arithmetic or twist-dependent discount.

## 4. A stronger elementary lower bound for the star smoothing norm

This is a new paper lemma for the actual source etaU, not a numerical integral. `Cor933.etaU_eq:49` gives the positive Mellin mixture of g(t)=t^2 exp(-t^2/2). `Eta2Moments:20–54` supplies its compact support and integral eta2=1. Its two explicit pieces also give

    integral_0^infinity r eta2(r) dr =9/16.

For clarity, the left piece integrates to (1/2)log2-3/16 using antiderivative 2r^2 log(4r)-r^2. The right piece integrates to 3/4-(1/2)log2 using antiderivative -2r^2 log r+r^2. The logarithms cancel exactly.

Tonelli and substitution in the positive mixture now give

    m0=integral etaU=sqrt(pi/2)>5/4,
    m1=integral t etaU=2*(9/16)=9/8.

The strict mass bound uses pi>25/8. All moments are finite by compact mixture scales and Gaussian decay. Test against h(t)=(3-t)_+ on the positive line. Since h>=3-t and etaU>=0,

    integral etaU*h >=3m0-m1>21/8,
    integral h^2=9.

Cauchy-Schwarz therefore proves

    V_U > (21/8)^2/9 =49/64 >3/4.                       (8)

The truncated pairing is bounded below, not asserted equal to 3m0-m1. This strengthens the earlier V_U>1/5 comparison and does not evaluate actual prime sums or a Mellin transform.

## 5. The uniform coefficient comparison still cannot close the budget

Consider conductor 3. It has a genuine nonprincipal character. For |delta|<4, both arc sets have all their moduli active: m_R=2R and m_Q=floor(2Q). The finite weight identities already account for floors. The eligible small moduli are q=3d and q=6d with d<=44300, squarefree and coprime to 6. Both are squarefree and have phi(q)=2phi(d). Equations (2) and (5) give

    W_kappa(3,2R)=3 G_kappa,
    G_kappa=sum_(d<=44300,(d,6)=1) mu(d)^2
                              [1/phi(d)-1/(2phi(d)^2)].  (9)

The unweighted large-arc coefficient is 3G_6(Q/3). Consequently every uniform scalar satisfying (6) must obey

    C_kappa(y)>=G_kappa/G_6(Q/3).                       (10)

This constraint holds on an interval of twists, not only at the measure-zero central point. The source `LSQuot1.ramare_Gq:31` states the explicit estimate implying G_6(z)=(1/3)log z+O(1) for fixed modulus 6. No finite-RH or QRH binder occurs in this statement. Since log(Q/3)=(1/2)log y+log(7/12), (10) gives

    liminf_(y->infinity) C_kappa(y) log y >=6 G_kappa.    (11)

This uses the existing Ramaré source estimate as a mathematical input; its deep proof is not re-audited here. It does not use the coarse log(2R)+2 quotient corollary.

The new integer-only companion calculates the finite sum (9) by directed dyadic bounds. For each nonzero term it floors its exact rational value on the 2^-64 grid. There are 13468 terms, and the sum of the floors is

    67935707915980013489 / 2^64 >18/5.

Adding 13468/2^64 gives an upper enclosure below 3.69. This is arithmetic on mu^2 and phi, not a search for Goldbach primes or evaluation of spectral data.

As in the preceding direct-B obstruction, grant the favorable coefficient asymptotic tlarge(y)=V_U log y+O(1), vanishing small-prime/removal costs, and exact principal subtraction. This asymptotic is an optimistic input to the comparison, not a newly proved coefficient estimate. The limiting lower bound on the resulting upper-bound allowance, using (7), (8), and (11), is

    liminf allowance >=49 V_U*(6G_kappa-14)
                       >49*(3/4)*(6*(18/5)-14)
                       =279.3.                         (12)

In contrast, even if A=0 and every principal and plus-removal norm in (3) were deleted, the full target would allow only

    B_kappa <= j*u0^2/epsilon <169.                    (13)

Thus the uniform plus bound followed by support weighting and the uniform termwise source sieve comparison cannot close this target. This remains true after the improved principal successor. The earlier lower comparison near 79.34, obtained with V_U>1/5, would not establish that conclusion under the new principal budget and is not used as the final obstruction.

Equations (12) and (13) compare sufficient bounds. They are not lower bounds on actual B_kappa, C_mix, or Wstar. The conclusion does not extend to a centered large-arc denominator, a nonuniform integrated comparison using actual character energies, or separately proved small-conductor estimates. Those are different inputs or methods.

## 6. A concrete next test

The support discount is worth retaining in any future mixed-energy proof, especially for the 4-divisible family. It is insufficient to average that discount across the family and insert the average into the current scalar sieve. Conductor 3 alone prevents that substitution.

A useful new result would prove the actual weighted inequality C_mix<=50*epsilon together with the other entries in (4), or establish a stronger allocation through (3). A source-level candidate is a centered comparison controlling the nonprincipal part of the large-arc coefficient expansion before the final full-circle energy bound. Another is a separately proved small-conductor plus-energy profile, inserted into (5) before taking a uniform coefficient ratio. The latter must control every inducing ambient modulus and all twists; deleting the primitive label alone does not set the full E+_q to zero. Neither estimate is supplied by the existing pointwise plus cap or the source's total-energy corollary.

No actual aggregate bound, removal of the nonprincipal spectral family, or production-cost saving is adopted. Principal RH, the plus estimate, the separate base-gap target, coefficient-energy/small-prime adapters, and final formal acceptance remain open or retained as before.

## Evidence

Owned script `modulus_weighted_plus_star_scalars_20261111.py`, SHA256 **937394259B8CE895FE1DD05F3BD926198B652659156300568804C43ABF1DD017**. Receipt `modulus_weighted_plus_star_scalars_20261111.json`, SHA256 **F597479266AD948C803C6CA2AE77F2C12DBC2840A8E03528270721F1A5B421D7**. It records 526 exact checks, the directed finite sum, and thirteen source/report pins. The small support-count checks for q<=256 supplement the general CRT proof; they do not replace it.

The principal and predecessor report pins are:

| Artifact | SHA256 |
|---|---|
| audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md | AFDBBF90157F5170666C481D512D475A1F719366C8FB785D312A213864C38D0B |
| audit/DIRECT_STAR_B_SOURCE_OBSTRUCTION_V2_2026-11-11.md | 65B892756EA24A086C673082D3CA551AF99EECA5DDA63CB3523EE3F5514A88A9 |
| major-constants/DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md | E69701B4AE8145B016015A2C355151DFAA5D4946D2281BAE3CC08A86422196B1 |
| work/qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md | 22A6A16880BE2FA5CB0FF393C533BD60B1AFCD32C751E5A0D64FE7ADAB7C40F7 |

Direct source reads comprise `Bombieri`'s exact Gauss support; `BaseGap`'s character and coprime identities; `LargeSieveWeights:20–45,130–139`; `LargeSieveProof:137–246,295–405`; `LargeSievePrimes:29–39`; `LSQuot1:20–46` and its `Prelim/Ramare:27` interface; `Cor933:49–70`; and `Eta2Moments:20–54`. Their exact hashes are retained in the companion receipt. This is a paper derivation at those interfaces, not a build or a recursive validation of every analytic dependency.
