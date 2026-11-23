# Can the new A allowance avoid nonprincipal finite RH?

2026-11-11. Bounded source and paper research, pending independent review. No analytic, prime, zero or transform value was evaluated. No Lean build, declaration, source edit or old-artifact mutation occurred.

The new allocation changes the B conclusion materially: the supplied etaU coefficient theorem and existing prime large sieve can give B<1915. It does not yet close A<=1e-10. I derive a source-compatible weighted sieve bound for A below. Even with the exact Fourier weight retained, its uniform coefficient-comparison method has an upper-bound expression whose limiting lower bound exceeds 38. This is a failure of that particular sufficient bound, not a lower bound on actual A or a proof that the target is false. A separate small-conductor variance estimate, or a more informative nonuniform/centered sieve theorem, remains necessary for this approach.

## 1. Target and the changed allocation

Use the actual definitions of the reviewed Wstar statistic. R=132900, x=49y, y>=1e25, Dq=8R/qt(q), P(delta)=Fourier(etaPC)(-delta), and a_q=mu(q)/phi(q). The nonprincipal coprime energy is

    E_q(delta)=(1/phi(q))*sum_(psi!=1)|tau_q(psi)|^2
       *|Schar(psi^-1,coprimePart(q,Lambda*etaU_y),delta/x)/y|^2.

Define A=sum_q a_q^2 integral_[-Dq,Dq]|P|^2 E_q and B=sum_q integral E_q. These are sums over numerator energies, not averages. The updated allocation uses rho=5.12e-7, u=1.194e-5 and the unchanged integrated principal norm pbar=1.902e-6. The sufficient bound

    sqrt(49^2 Wstar/x^3)<pbar+sqrt(A)+rho*sqrt(B)

accepts A<=1e-10,B<=2000. The separate source proof gives B<1915 conditionally on the etaU coefficient theorem and retained principal/finite arithmetic inputs. Nothing here revives the older B<53 obstruction. The question addressed here is the remaining actual A input.

The exact factor a_q^2 kills nonsquarefree ambient q. A primitive conductor c dividing such a surviving q must itself be squarefree. Primitive conductors with exact 2-adic valuation one are impossible, so only odd squarefree nonprincipal conductors remain. This eliminates the 4-divisible branch from A, not from B, plus or base gap. Imprimitive characters induced from small squarefree c still contribute at every eligible squarefree multiple q.

## 2. A source-compatible weighted prime-sieve comparison

Write F_y(alpha)=sum_n Lambda(n)etaU(n/y)e(n alpha), and F'_q for its coprimePart(q) sum. Exact character Parseval gives

    E_q=sum_(b unit mod q)|F'_q(b/q+delta/x)/y|^2
          -mu(q)^2/phi(q)*|F'_q(delta/x)/y|^2.

Consequently, with lambda_q(delta)=mu(q)^2|P(delta)|^2/phi(q)^2, A is the weighted full coprime energy minus

    L_Acop=sum_q mu(q)^2/phi(q)^3
         *integral_[-Dq,Dq]|P(delta)|^2|F'_q(delta/x)/y|^2.

The power phi(q)^3 is essential. The principal term has not disappeared merely because the desired energy is nonprincipal. The q=1,2 energies are identically zero, so the full-minus-principal identity may be restricted to q>=3 before bounding.

Split the coefficients into g supported on primes n>sqrt(x)=7sqrt(y), and h comprising the remainder. Put tlarge=sum|g|^2/y and esmall=sum|h|^2/y. Let Q=sqrt(x/16)=7sqrt(y)/4. The prime support is coprime to every modulus through 2Q, exactly as required by LargeSieveProof.prop_12_1_2:295. No assumption about nonprincipal zeros is needed for this step.

Before the source's scalar quotient bound, its finite character interchange works with the actual weights:

    W_lambda(c,m,delta)=sum_(q>=3, qt(q)<=m, c|q)
           lambda_q(delta)*w(q,c)/phi(q),
    w(q,c)=c if q/c is squarefree and coprime to c, and 0 otherwise.

The unweighted denominator is

    W_1(c,m)=(c/phi(c))*kap(c)*G_(qt(c))(m/qt(c)).

Here kap(c)=2 for odd c and 1 for even c, distinct from any support-dimension factor in earlier reports. For each y, suppose a nonnegative scalar C_A(y) satisfies

    W_lambda(c,m_R(delta/x),delta)
       <=C_A(y)*W_1(c,m_Q(delta/x))                       (1)

for every relevant c and delta. The source Farc_eq/Farc_le proof then applies termwise, keeping the inverse-character labels, and integrates the weighted prime-supported energy to at most 49*C_A*tlarge. The factor 49 is x/y, from the change delta=x*beta. Integrability follows from finite modulus sums, bounded continuous P, compact arcs and the source summability of g.

For the h part, |P|<1 and phi(q)>=2 at q>=3 give lambda<=1/4. Physical arc disjointness and full-circle Parseval give a bound 49*esmall/4. The removal F_y-F'_q has normalized magnitude at most d0=2e-9. Its weighted norm is at most

    d0*sqrt(.640208*sum_q mu(q)^2/phi(q))<6e-9,

using the retained mass upper bound13.59756. Thus a concrete source-compatible bound is

    A <= [sqrt(49*C_A*tlarge)+sqrt(49*esmall/4)+6e-9]^2
            -L_Acop.                                  (2)

This preserves all principal and coprime terms. It is not a theorem already stated in source: it is the weighted finite-interchange adaptation of the inspected proof. A finer bound for h or removal can replace its displayed allowances. In particular, 49*esmall/4 with the current esmall<2.1e-9 is itself too coarse for a 1e-10 target if used alone. The obstruction next already occurs after granting zero h/removal cost.

## 3. Exact P weight does not fix the uniform comparison

Conductor 3 has a genuine nonprincipal character. The two eligible moduli q=3 and 6 each have phi=2 and nonzero Gauss norm squared3. Their contribution alone gives

    W_lambda(3,2R,delta)>= (3/4)|P(delta)|^2.

For |delta|<4 all moduli in both relevant families are active. The unweighted large-family coefficient is 3G_6(Q/3). Hence (1) necessarily requires

    C_A(y)>=|P(0)|^2/[4G_6(Q/3)].                       (3)

This is also forced if (1) is imposed only almost everywhere: the same two terms are active near zero and P is continuous. It is a coefficient-comparison constraint, not a claim about how much the actual conductor-3 character sum contributes.

The actual P(0) is bounded below without evaluating a transform. Source EtaCirc defines etaO(t)=(t(2-t))^3 exp(-(t-1)^2/2) on [0,2]. Since exp(-v)>=1-v for v>=0, the substitution u=t-1 gives

    integral etaO >=integral_[-1,1](1-u^2)^3(1-u^2/2)du
                  =272/315.

The reviewed PointwiseSmoothingTail proof gives |etaPlus-etaO|<=.00221*t*exp(-t^2/2) on the positive line, with both functions zero off it. The last majorant integrates to .00221. Thus

    |P(0)| >=272/315-.00221=5426077/6300000>.86.

The source LSQuot1.ramare_Gq:31 gives G_6(z)=(1/3)log z+O(1) at fixed modulus6. Since log(Q/3)=(1/2)log y+log(7/12), (3) implies

    liminf C_A(y)*log y >=(3/2)|P(0)|^2>1.1094.          (4)

This keeps the Fourier weight exactly where it enters the coefficient comparison. Replacing it by a supposed average over delta would not prove (1).

For completeness the new etaU coefficient theorem supplies a lower comparison too. Its two-sided bound for P_etaU(y), and the removed small-prime energy<1e-50, imply

    liminf tlarge(y)/log y >=(1-.000468)*V_U,
    V_U>49/64.

This is weaker than a sharp coefficient asymptotic, and uses only the theorem's stated error. No O(1) error is falsely inferred from its O(log y) bound.

Even the exact principal subtraction cannot remove this allowance. Positivity and the actual mixture give |Fourier(etaUC)|<=sqrt(pi/2)<sqrt(2). The retained principal estimate, including its inner coprime removal, has error at most1.502e-6. Since (1.415-1.502e-6)^2>2,

    L_Acop < .640208*(32/13)*(1.415)^2 <3.156.           (5)

Here .640208 is the full integral of |P|^2 upper bound, and32/13 bounds sum mu(q)^2/phi(q)^3. Restricting intervals and q>=3 only decreases this upper bound. This uses an upper bound on the possible subtraction, in the correct direction for testing (2).

It follows from (4)-(5) that the right-hand side of (2), even before its positive h/removal terms, has limiting lower bound strictly exceeding

    49*1.1094*(1-.000468)*(49/64)
       -.640208*(32/13)*(1.415)^2
      =7996571791889/208000000000 >38.                  (6)

Therefore no selection of the scalar C_A satisfying (1) can make this particular bound prove A<=1e-10 uniformly in y. This directly tests the new allocation, rather than reusing the obsolete B budget. Equation (6) is not a lower bound on A. A delta-dependent integration retaining actual character information, or a different centered large-arc denominator, is outside this negative conclusion.

## 4. Small/large conductor splitting

Orthogonality decomposes each E_q into nonnegative primitive-conductor contributions E_q,c, retaining the q-dependent coprime coefficients. For any C>=1 let A_<=C and A_>C denote the corresponding parts of A. Since c|q implies q>=c, the elementary bound q/phi(q)<21/4 on q<=265800 gives

    A_>C <=(21/(4C))^2 * B_>C
          <=1915*(21/(4C))^2.                         (7)

The finite totient bound follows from the product formula: seven distinct prime factors would force q>=510510, while the first six give30030/5760<21/4. There is no claim that the residue weights average to this value. Equation (7) uses |P|<1 and is uniform in y. It may discard useful Fourier localization but is a valid immediate consequence of the new B theorem.

For C=10000,50000,100000,132899 its exact upper comparisons are respectively

    168903/320000000,
    168903/8000000000,
    168903/32000000000,
    844515/282594307216.

All exceed1e-10. The first integer C for which this scalar comparison alone is <=1e-10 is22974375, beyond the nonempty conductor domain c<=132900. This does not say the actual high-conductor tail is large. It says that transferring the full B<1915 allowance by a supremum weight does not produce a useful cutoff, even if the low-conductor A contribution were separately zero.

A useful split theorem must therefore supply more than (7), for example conductor-local energy bounds or a weighted variance estimate. It must also solve the small-conductor input. The q=3 term alone in the actual A definition is

    (3/8)*integral_[-D3,D3]|P(delta)|^2
           *|Schar(chi3,coprimePart(3,Lambda*etaU_y),delta/x)/y|^2.

Consequently A<=1e-10 requires this integral to be <=8e-10/3. This is a concrete single-character weighted mean-square target at all y>=1e25, not an assumed consequence of its arithmetic weight. The present source scalar sieve does not provide it. A separately proved small-conductor estimate need not be finite RH, but its quantitative statement and cost must be supplied. Removing a small primitive conductor from the sum must remove its induced contributions at all eligible moduli through the same proved estimate.

## 5. Decision and boundaries

The direct B result is useful and survives this test. A remains a substantive missing estimate. Squarefree support gives a genuine family reduction, but neither the full B bound nor the uniform weighted version of the existing source sieve closes the new A allowance. The first concrete research target is the displayed c=3 weighted variance estimate, together with a high-conductor weighted theorem stronger than the supremum-weight transfer. Success should be judged against1e-10 with the principal/removal and small-coefficient costs included, not against a renamed unweighted energy.

This does not rule out a different analytic approach, a nonuniform integrated sieve, or use of additional information already generated for other consumers. In particular the plus and base-gap finite-RH requirements remain in the current global union. Even an unconditional proof of A would not by itself remove those certificates or establish a computational saving.

## Evidence and source scope

The 16 exact scalar checks, polynomial integral, four split comparisons and pin manifest are in `star_a_only_scalars_20261111.json`, SHA256 `0056130014CC7CF09DFE458035FAC659D0581CCD49669204DDD6722F4D952D1B`. The script `star_a_only_scalars_20261111.py` has SHA256 `306B518EF673CA06678A2D4CCFEFEABF1A3BCF56CC9F499F64D4890856E3877C`. It imports only standard integer/rational/hash/JSON utilities and evaluates no analytic function.

The new allocation is `major-constants/PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md`, SHA256 `7A5B81DA0290BE52D8E64A521702D0299114FF9DE2923E1897AE608E5241ECAD`; its independent review is `AD993398C6E41DCCE3A9826C0FA5BF6DA89A3B0139672429D7BD61E797DE9F0E`. The etaU coefficient input is `0B97BC320F7BEEA4B7CC9D8144FBB70CFC19A4AF756602BDA4DCBD1239399D5C`. Its principal/finite source hypotheses remain conditional here.

Direct source scope: LargeSieveProof:137-246 for the character coefficient identity and comparison, :295-405 for prime support, integration, Parseval and the scalar corollary; LargeSieveWeights:20-45 for parity and support; LSQuot1:31 for fixed-modulus Ramaré asymptotics; EtaCirc:18-30 for the actual etaO; and the previously reviewed Bombieri, principal, Fourier-energy and source-mass interfaces. All twelve exact source/report hashes are retained in the new receipt. This is a bounded mathematical feasibility result, not a recursive source validation, compiled theorem or final axiom audit.
