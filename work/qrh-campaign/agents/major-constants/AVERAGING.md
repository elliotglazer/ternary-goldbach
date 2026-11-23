# Averaged character errors and the modulus-one obstruction

The ternary source is pinned at 23b2d68ca344203d4384e0aff7affa4ec034bef9. The comparison repository work/goldbach-lean is pinned at f003a97d7598923787920723668d62c16c82b81e. This bounded investigation inspected the implemented proofs in the comparison entries. The Challenge files contain the challenge statements and placeholders, while Solution files import the implementation.

AveragedResidual.lean contains three proposed exact identities with complete proof scripts. They have not been compiled. No analytic error estimate is claimed proved. The file imports only TernaryGoldbach.MinorArcs.Bombieri. An independent reviewer has received it and the cubic derivation below.

## Exact spectral residual

Put tau_q(psi)=gaussSum psi ZMod.stdAddChar. Suppose a(n) is absolutely summable and vanishes unless gcd(n,q)=1. For any complex A and real beta, the proposed identity is

    phi(q) * sum_{b unit mod q}
      |S_a(b/q+beta) - tau_q(1)*A/phi(q)|^2
      =
    sum_{psi mod q} |tau_q(psi)|^2
      |S_{psi^-1,a}(beta) - 1_{psi=1}*A|^2.

The proof applies the existing parseval_chars theorem to S_a(b/q+beta)-c. The character transform is tau_q(psi)*S_{psi^-1,a}(beta) minus phi(q)*c for psi=1. The parent source proves tau_q(1)=mu(q) in MajorArcs/MajorTotal.lean, lines 76-88.

This identity retains the average over characters and includes the principal error exactly. No factor-three triangle inequality is needed for the coprime-supported sum. To restore the original coefficients, add the actual coprime-removal error in the finite-dimensional L2 norm.

MinorArcs/Bombieri.lean, lines 114-121, already proves Parseval without a main term. Its norm_sq_gaussSum theorem at lines 137 onward gives the exact imprimitive weight. If c is the conductor of psi, then

    |tau_q(psi)|^2 =
      c * 1_{q/c squarefree and gcd(q/c,c)=1}.

Replacing this by c for every imprimitive character loses the zero weights. AveragedResidual.lean has a separate corollary retaining the indicator. The inner character sum uses psi^-1 because that is the exact convention in sum_char_mul_S. Inversion preserves the principal character and conductor.

If one regroups the spectral sum by primitive conductor, the error must include the primes dividing q that were removed from the coefficients. For a primitive character chi mod c inducing psi mod q, use the actual Schar of coprimePart q a, or explicitly subtract the removed prime powers from the primitive Schar. The existing BaseGap.Schar_primitive identity supports this conversion. The primitive and imprimitive sums cannot be silently identified for the original coefficients.

## A weighted integral target for the cubic major arcs

Write y=x/49 and delta=beta*x. On modulus q put D_q=1200000/qt(q), and integrate delta over [-D_q,D_q]. All following sums are over q in Qset(150000) and b in its unit residue classes.

Define

    s_b = S_etaPlus(b/q+delta/x,x)/x
    v_b = S_etaStar(b/q+delta/x,x)/y
    P(delta) = Fourier(etaPlus)(-delta)
    U(delta) = Fourier(etaU)(-delta/49)
    m_q = mu(q)/phi(q)
    r_b = s_b - m_q*P(delta)
    t_b = v_b - m_q*U(delta)
    Rplus(q,delta) = sum_b |r_b|^2
    Rstar(q,delta) = sum_b |t_b|^2.

The exact algebraic expansion

    s_b^2*v_b - (m_q*P)^2*(m_q*U)
      = t_b*s_b^2 + m_q*U*r_b*(s_b+m_q*P)

gives a bound for the normalized cubic error, after summing and integrating,

    error <= sqrt(J*V) + sqrt(B*A),

where

    J = sum_q integral sum_b |s_b|^2,
    V = sum_q integral sum_b |s_b|^2*|t_b|^2,
    A = sum_q integral |m_q*U|^2*Rplus,
    B = sum_q integral sum_b |s_b+m_q*P|^2.

These are ordinary Cauchy-Schwarz bounds. Their integrability and the original-to-coprime conversion must be checked in a Lean proof. The calculation scales back by x*y=x^2/49.

Using the existing J<=8.79 and Fourier L2 bound gives

    B <= 2*8.79 + 2*0.640208*13.59756
      = 34.99053338496.

The fixed smoothing loss is 0.002834895, the main term is 1.052105346, and the current minor bound is 1.0376. Consequently a sufficient averaged target is

    sqrt(8.79*V) + sqrt(34.99053338496*A) < 0.011670451.

An equal split of that budget gives

    A < 9.73116250079e-7
    V < 3.87370382660e-6.

The split is a modeling choice. It can be optimized. It assumes that the source L2, Fourier, singular-series and minor-arc estimates have themselves been re-established without Platt.

There is a version involving only the spectral squared residuals. Since |s_b|^2 <= 2|m_q P|^2+2|r_b|^2,

    V <= 2*(Astar+Cross),
    Astar = sum_q integral |m_q*P|^2*Rstar,
    Cross = sum_q integral Rplus*Rstar.

Thus Astar+Cross < 1.936851913302e-6 is sufficient for the star half. The product term records the correlation that a pure L2 estimate for etaStar leaves uncontrolled.

For the coprime-supported sums, substitute the exact spectral identity into Rplus and Rstar. This produces an explicit weighted integral over all characters, with the correct Gauss weights. The task is then to prove these numerical inequalities, together with the L2 and minor-arc replacements.

For a QRH absolute zero-sum estimate, put

    Z_eta(chi,delta) =
      sum_rho mult(rho)*|Mellin(f_eta,delta)(rho)|,

with a separately controlled remainder. QRH allows |error|/z <= z^(-1/8)*Z_eta. Squaring and substituting into the spectral average gives an x^(-1/4) factor for plus and y^(-1/4) for star. Ignoring remainders only to display the scale, the plus weighted zero-sum aggregate must be below 4.57840012664 under the equal split. The corresponding isolated star weighted aggregate must be below 3.44426387772 if the cross term is zero. Remainders and the positive cross term consume these budgets.

## Modulus one and two

At q=1 there is one character and one unit. The etaPlus requirement contributes exactly

    A_1 =
      integral_{-600000}^{600000}
        |Fourier(etaU)(-delta/49)|^2
        |S_etaPlus(delta/x,x)/x-Fourier(etaPlus)(-delta)|^2 ddelta.

There is no average over nonprincipal characters in this expression. Bounding A_1 requires a zeta estimate. A general large sieve cannot create cancellation by averaging characters at q=1.

Allocating the whole plus half to q=1 requires A_1 < 9.73116250079e-7. The source's bound integral etaU^2 <=7.78 gives the Fourier weight bound 49*7.78=381.22. A uniform normalized etaPlus zeta error below 5.05236274333e-5 is sufficient, corresponding to C<0.109589522325 for C*x^(-1/8). This is much weaker than the current pointwise ArcChars target, but it remains a numerical zeta estimate to prove.

The etaU norm can be computed more accurately from its definition. Nonnegative Fubini and the Gaussian fourth moment give the exact mathematical integral formula

    integral_0^infinity etaU(t)^2 dt
      =
    3*sqrt(pi/2) *
      integral_{1/4}^1 integral_{1/4}^1
        eta2(r)*eta2(s)*r^2*s^2/(r^2+s^2)^(5/2) dr ds.

The eta2 definition is at Helfgott/Defs.lean lines 43-47. etaU is at MinorArcs/EtaU.lean line 24. Cor933.lean lines 49-64 supplies the swapped Mellin-convolution formula.

Composite Simpson quadrature, split at the eta2 corner r=s=1/2, gives

| Subintervals per smooth piece | integral etaU^2 |
| --- | ---: |
| 50 | 1.063615229632995 |
| 100 | 1.063615244870743 |
| 200 | 1.063615245824731 |
| 400 | 1.063615245884484 |

This is uncertified quadrature. It suggests the full Fourier weight is 52.11714704834. The existing Fourier envelope |Fourier(etaU)(t)| <=1.016/t^2 implies that truncating the delta integral at 600000 changes that weight by at most

    2*1.016^2*49^4/(3*600000^3) = 1.8366513645e-11.

Using the quadrature value suggests the uniform q=1 error cap 0.000136644465281, or C<0.296392053366 in the QRH scale model. Formalizing the Gaussian double integral and certifying its quadrature are necessary before using the improvement.

The q=2 principal character has the same arc width, phi(2)=1, and induces the same zeta character. Its removed-power correction must be retained, but its main zeta contribution approximately duplicates q=1. Allocating to the pair rather than q=1 reduces the indicated uniform cap by roughly sqrt(2). Other induced principal characters also contribute positive terms.

## Existing comparison results

The usable explicit theorem is LeanLab.PNTPort.LargeSieve.multiplicative_large_sieve, at entries/bombierivinogradov1965/LeanLab/PNTPort/LargeSieve/Multiplicative.lean line 246. It proves

    sum_{c<=Q} c/phi(c) sum_{chi primitive mod c}
      |sum_{M<n<=M+N} a_n chi(n)|^2
      <= (N+2Q^2)*sum |a_n|^2.

It permits a fixed additive twist by replacing a_n with a_n*e(delta*n/x). However the coefficients must be the same across characters and moduli. The cutoff in delta depends on q, the actual coefficients have q-dependent coprime removal, and etaPlus has unbounded support. Truncation, tail estimates and nonnegative extension of the integration region are required.

Applied directly at N about x and Q=300000, the N term dominates. Even using the optimistic source energy scale sum|a|^2 about0.640208*x*log(x), the normalized bound is about39.3449, before integrating delta. This does not approach the all-conductor weighted aggregate target by itself.

The factor |m_q|^2 in A helps for large q. In an idealized primitive-only model, replacing phi(q) by q and taking q>=D would give a coefficient roughly

    49*7.78*0.640208*log(x)/D^2 = 14999.06637/D^2.

This suggests potential usefulness of the raw sieve in the largest conductor ranges. It is not a bound for the actual problem. The missing totient factors, induced characters, truncation, small conductors, star correlation and principal error must all be supplied. In particular, the q=1 term is unaffected.

LargeSieve/Bilinear.lean line 56 proves a bilinear estimate with explicit factors (N1+2Q^2)(N2+2Q^2). Its coefficient factorization does not survive an arbitrary twist e(delta*m*n/x). BV/Hyperbolic.lean line 175 handles a product cutoff, with C0=8+24*C where C is obtained existentially from Perron's cutoff. That theorem does not directly handle the oscillatory twist. BV/TypeII.lean line 220 exports an existential K.

The implemented BV/LargeConductorProof.lean chooses conductor cutoff (log x)^(A+5). For every A>0 and x=4.9e26 this exceeds (log x)^5=876672261.2057. Thus its large-conductor portion covers none of the conductors up to300000. Its small-conductor portion uses Siegel-Walfisz with ineffective constants.

BVMax/Uncond.lean line 24 proves the unconditional maximal Bombieri-Vinogradov theorem, but its B and K are existential and ineffective through Siegel. To include Q=300000 at this x requires B<=4.39903833197. The theorem does not supply such a B or a numerical K. Partial summation for the present smoothing would add delta-dependent variation costs.

The Heath-Brown entry proves a mean square of binary representation errors over the represented integer, and an eventual ternary theorem. Its Statements.lean lines 38-81 quantifies existential constants. This average has a different variable from the fixed-N cubic error here. The implementation does not provide a numerical threshold1e27.

Searches of both entries' PNTPort trees found zero-free-region, local zero and Siegel machinery, but no aggregate Dirichlet zero-density theorem ready to provide the weighted zero sums above. This is a scoped source search, not a claim about all possible libraries.

## Status and next concrete use

The exact residual identities remove an avoidable maximum over characters and preserve imprimitive zero Gauss weights. They are ready for a narrow compilation after the active numerical job. They do not prove the new spectral bounds.

The immediately testable analytic target is A_1 above, followed by the q=1,2 pair with the removed-power correction. Its explicit Fourier weight is now available as a one-dimensional zeta-error integral and as an elementary Gaussian double integral for constant-error sensitivity. A large-conductor sieve estimate could then be evaluated separately. The existing comparison theorems supply no complete explicit replacement at the target threshold.

Run averaging_model.py to reproduce the arithmetic and quadrature. averaging_results.json records its output. No Lean compilation was launched during this task.

Independent review found no mathematical defect in the proposed identity or averaged cubic inequality. The reviewer checked the coefficients with exact rational arithmetic and approved the conservative cap decimals displayed above. The coprime-removal transfer, primitive-character corrections and Platt-dependent J bound remain explicit open interfaces. This review did not compile the Lean proof.


