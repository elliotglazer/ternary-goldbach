# Averaged residual and cubic-error review

Independent reviewer: worker 8. Date: 2026-11-10.
Source revision: calr3/ternary-goldbach at 23b2d68ca344203d4384e0aff7affa4ec034bef9.
Reviewed AveragedResidual.lean SHA256: C8250BD289575BFAB27495BC40FA2E37CCBBA66EF9550961F24D1931760D2FD0.

Scope: the three public identities and private character-sum helper in agents/major-constants/AveragedResidual.lean; the averaged cubic derivation and coefficients in AVERAGING.md; the auxiliary etaU Gaussian integral and Fourier-tail arithmetic. No Lean compiler was run. The comparison-repository claims in the latter part of AVERAGING.md were not independently audited here.

## Verdict and one correction

The exact residual identities and averaged cubic inequality are mathematically valid with the stated definitions and hypotheses. The imprimitive weights and inverse-character convention agree with the pinned source. No new PlattGRH premise or axiom appears in the scratch file.

One small but real exact-arithmetic correction was sent to major_constants. The displayed sufficient plus cap 9.731162500794e-7 rounded upward from the exact cap. Use 9.73116250079e-7 or the exact fraction below. The other displayed V and Astar+Cross caps round downward safely.

This is a mathematical pre-compilation review. It confers no frozen-declaration or root-closure status.

## Character identities

Bombieri.lean:27-29 proves Parseval with the convention

    sum_psi |sum_b psi(b) F(b)|^2
      = phi(q) sum_(b unit) |F(b)|^2.

The private sum_character_eq is correct: the principal character sums to phi(q), while every other character sums to zero. It includes q=1, for which phi(1)=1 and the trivial ring has one unit.

With F(b)=expTsum(a,b/q+beta)-c, linearity subtracts c*sum_b psi(b). Bombieri.lean:78-81 proves the first transform is tau(psi)*Schar(psi^-1,a,beta), assuming absolute summability and support on integers coprime to q. Thus the first public residual identity follows with the principal correction phi(q)*c.

Choosing c=tau(1)*A/phi(q) is legitimate because q!=0 implies phi(q)>0. The principal term factors as tau(1)*(Schar(1,a,beta)-A); every nonprincipal term factors as tau(psi)*Schar(psi^-1,a,beta). Taking norm squares gives the second identity.

The third identity substitutes Bombieri.lean:135-138 exactly:

    |tau(psi)|^2
      = conductor(psi)
          if q/conductor(psi) is squarefree and coprime to conductor(psi),
        0 otherwise.

The vanishing branch matters. No assumption that every character is primitive is made. Neither q nor conductor alone can replace this exact weight in an equality.

MajorTotal.lean:75-88 identifies tau(1)=mu(q), so the constant matches the major-arc main term. A nonsquarefree q gives a zero principal Gauss factor and zero principal main term as it should.

The inverse psi^-1 is required by the source transform convention. Conductor and principal status are unchanged by inversion, but a later analytic estimate still needs either the exact inverse character or a proved reindexing. No functional equation is used or needed for these algebraic identities. Functional equations or QRH symmetry arguments belong to the later estimates on character L-functions and must not be silently inserted into this equality.

## Inputs and remaining transfer

The scratch inputs are q:Nat, [NeZero q], a:Nat->Complex, absolute norm summability of a, support on gcd(n,q)=1, beta:Real, and an arbitrary complex constant c or target A. These are precisely the hypotheses of this internal identity, not extra assumptions on the public Goldbach root.

The identity is for the coprime-supported sum. The cubic definitions use the full S_eta. To transfer the identity, bound the actual removed coefficients in the finite-dimensional L2 norm. A character induced from primitive conductor c has its q-prime Euler/coprime removals; its Schar cannot be replaced by the primitive Schar without those corrections. The worker's AVERAGING.md states both obligations explicitly.

## Averaged cubic derivation

Use delta=x*beta, y=x/49, and the worker's normalized variables s=Splus/x, v=Sstar/y, r=s-mP, t=v-mU, m=mu(q)/phi(q). The algebraic identity

    s^2*v-(mP)^2*(mU)
      = t*s^2 + mU*r*(s+mP)

is exact. Unit complex phases in the Goldbach integrand do not change its norm.

On the finite union of modulus/residue/closed-delta-interval domains, triangle inequality and two Cauchy-Schwarz applications give

    error <= sqrt(J*V)+sqrt(B*A),

where J,V,B,A are exactly the nonnegative integrals in AVERAGING.md. The actual S and Fourier functions are continuous, and domains are bounded with finitely many q,b, so integrability is mathematically available. A Lean proof must supply those facts.

The Jacobian is d(beta)=d(delta)/x. The original cubic has factor x^2*y, so normalization leaves x*y=x^2/49. No extra power of x or 49 is missing.

The bound |s+mP|^2<=2|s|^2+2|mP|^2 gives

    B <= 2J+2*0.640208*13.59756,

using phi(q)|m|^2=mu(q)^2/phi(q) and the source Fourier L2/singular-series estimates. The source use of J<=8.79 is at MajorTotal.lean:1020-1023 and currently depends on the Platt-based L2 result. The averaged algebra does not discharge that dependency.

Likewise,

    V <= 2*(Astar+Cross)

follows from |s|^2<=2|mP|^2+2|r|^2 and
sum_b |r_b|^2|t_b|^2 <= (sum_b |r_b|^2)(sum_b |t_b|^2).
Cross is the integral of the product of the two squared residual sums. Separate integrated L2 bounds alone do not bound this correlated product. The worker correctly leaves Cross explicit.

## Exact arithmetic

Python fractions.Fraction calculations, using exact finite decimals, give:

    B = 27336354207/781250000
      = 34.99053338496

    main = 1.314*0.800689
      = 1.052105346

    fixed = 49*2.03e-5*2.85
      = 0.002834895

    budget = main-fixed-1.0376
      = 11670451/1000000000
      = 0.011670451

For an equal split of the dynamic budget:

    A_cap = (budget/2)^2/B
      = 136199426543401/139962133539840000000
      approximately 9.731162500793976e-7

    V_cap = (budget/2)^2/8.79
      = 136199426543401/35160000000000000000
      approximately 3.873703826604124e-6.

Thus A<9.73116250079e-7 and V<3.873703826604e-6 are safe sufficient inequalities. Astar+Cross<1.936851913302e-6 safely implies the latter. A<9.731162500794e-7 is not an exact sufficient claim, despite the tiny rounding error.

All these are conditional budgets: they preserve the source main, Fourier, smoothing-loss, L2 and minor-arc constants. Those estimates must themselves be available without PlattGRH before this can certify the requested result.

## Modulus-one diagnostics

q=1 has one character and one unit, so the given A_1 expression is exact. Its Fourier weight is |Fourier(etaU)(-delta/49)|^2 on delta in [-600000,600000]. There is no nonprincipal-character averaging available in this term.

The source definitions are:
Helfgott/Defs.lean:43-49 gives eta2 and phi(t)=t^2 exp(-t^2/2);
MinorArcs/EtaU.lean:24 gives etaU;
MajorArcs/Cor933.lean:49-64 gives the swapped integral formula.

Substituting that formula twice yields an inner Gaussian fourth moment. Its exact value is

    integral_0^infinity t^4
      exp(-t^2*(r^2+s^2)/(2*r^2*s^2)) dt
       /(r^3*s^3)
    = 3*sqrt(pi/2)*r^2*s^2/(r^2+s^2)^(5/2).

This verifies the double-integral factor in AVERAGING.md. Positivity permits Tonelli, while finite values and the existing square-integrability support the final equality. The Simpson approximations remain uncertified; agreement between meshes is not an error bound.

Given the cited Fourier envelope 1.016/xi^2, its squared tail after scaling xi=delta/49 is at most

    2*1.016^2*49^4/(3*600000^3).

The powers and scaling are correct. I did not independently prove or compile the envelope theorem itself.

At q=2 the principal induced character retains the removed powers of 2, so the claimed near-duplication of the q=1 zeta contribution is only a model. The worker labels it approximate and retains that correction as an obligation. It must not become an exact factor-two bound without proof.

## Next verification

Compile the narrow AveragedResidual file after integration grants a slot, inspect exact types and axioms, then formalize the averaged Cauchy-Schwarz inequality with the actual finite domain. Keep the full-to-coprime residual transfer, exact induced-character weights/corrections, and Cross as explicit proof obligations. No final root or numerical analytic closure is claimed here.

