# A convergent fallback evaluator for nonprincipal strip contours

2026-11-11. Research paper argument submitted for independent review. This is not a Lean implementation or a practical production algorithm. It supplies an explicit way to shrink every evaluation and whole-panel error in the positive half-plane. It does not prove that the selected spectral statement is true, or that a contour through a zero can be certified nonzero.

## Source and exact scope

Fix a natural q>1 and an actual nonprincipal complex Dirichlet character chi modulo q. Primitivity is not needed here. Let f(s)=chi.LFunction(s), the actual entire continued function. Use the exact source at target commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`:

`work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean`, SHA256 `5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341`.

The coordinator read the complete file. Its `psum`, `norm_psum_le`, `LFunction_eq_mul_Iint`, and `hasDerivAt_Iint` give the source objects and formulas used below. They have no PlattGRH binder. This is source inspection, not a fresh elaboration or transitive axiom check.

Write A(x)=sum over 1<=n<=floor(x) of chi(n), for real x>=1. The source bound is |A(x)|<=q+1. We deliberately retain that bound rather than assume a stronger partial-sum estimate. For Re(s)>0, the source identity is

    f(s)=s*integral_1^infinity A(x)*x^(-s-1) dx.

Every power of a positive real uses its real logarithm. All following finite sums omit n=0. No Hurwitz value, pole subtraction, Gamma normalization or root phase is used.

Fix a closed rational rectangle K=[b,d]+i[u,v], with 0<b<d and u<v. Set B=d+max(abs(u),abs(v)); then |s|<=B for s in K. The boundary is traversed counterclockwise. The chosen rectangle must be the actual domain to be certified; it is not inferred from a collection of sampled points.

## Explicit finite-sum tail

For any integer N>=1, finite summation by parts gives

    S_N(s)=sum_(n=1)^N chi(n)*n^(-s)
          =A(N)*N^(-s)+s*integral_1^N A(x)*x^(-s-1) dx.

One can prove this by splitting at the integers: A(x) is constant on [n,n+1) and s*integral_n^(n+1) x^(-s-1) dx=n^(-s)-(n+1)^(-s). The finite sum telescopes. Since Re(s)>0, s is nonzero; the primitive formula has no exceptional s=0 case here. At N=1 the identity reduces to S_1=A(1).

Subtracting from the source integral, with its absolute convergence, yields

    f(s)-S_N(s)
      =s*integral_N^infinity A(x)*x^(-s-1) dx - A(N)*N^(-s).

For sigma=Re(s)>0 this implies

    |f(s)-S_N(s)| <= (q+1)*(1+|s|/sigma)*N^(-sigma).

Consequently, uniformly on K,

    |f(s)-S_N(s)| <= C*N^(-b),
    C=(q+1)*(1+B/b).                                      (1)

N need not be a multiple of q. The boundary term A(N)*N^(-s) is included; dropping it without a separate vanishing proof would be wrong.

This remainder tends to zero with an explicit rational test. Write the positive rational b=p/r, with positive integers p,r. To ensure C*N^(-b)<e for rational e>0, it suffices and is equivalent to check

    N^p > (C/e)^r.                                         (2)

All quantities in (2) are rational or integer. Doubling N from1 terminates. A finite machine may run out of resources long before reaching this bound; mathematical termination is not a resource forecast.

## Certified point values from finite elementary arithmetic

At a rational complex point s in K, each term is chi(n)*exp(-s*log(n)). The accepted finite-character manifest plan gives finite root-of-unity expressions for the actual values of chi, with nonunits mapped to zero. The accepted interval-primitive plan supplies arbitrarily accurate rational enclosures for positive logarithms, exponentials and trigonometric values. Their exact source interpretations and soundness are dependencies still to be formalized. A raw floating character table is not an acceptable substitute.

For any rational requested point error e>0, select N by (2) with tail target e/3. Evaluate the N complete terms with complex error less than e/(3N) each, including character uncertainty and multiplication error. Sum their rational centers exactly. If a dyadic final center is desired, round with complex error less than e/3. Triangle inequality gives a rational complex center z with

    |f(s)-z|<e.                                            (3)

Every term is a fixed finite elementary expression once N and s are fixed. Elementary enclosure refinement therefore terminates. There is no lower bound on |f(s)| in this point-evaluation argument; it works at a zero as well. It does not decide whether that value is zero.

## A rational derivative and whole-panel bound

The source differentiates I(s)=integral_1^infinity A(x)*x^(-s-1) dx. Product differentiation of f(s)=s*I(s) gives

    f'(s)=I(s)-s*integral_1^infinity A(x)*log(x)*x^(-s-1) dx.

Both integrals converge absolutely for sigma>0. The elementary real integrals are

    integral_1^infinity x^(-sigma-1) dx=1/sigma,
    integral_1^infinity log(x)*x^(-sigma-1) dx=1/sigma^2.

The second follows by x=exp(y) and one integration by parts, or by direct integration by parts in x; its endpoint term vanishes because log(x)*x^(-sigma) tends to zero. Thus

    |f'(s)| <= (q+1)*(1/sigma+|s|/sigma^2)
             <= L=(q+1)*(1/b+B/b^2),      s in K.           (4)

L is positive rational. This argument needs no outer disk or numerical differentiation. It uses the actual analytic derivative supplied by the source integral.

If a straight panel [a,c] lies in K, its midpoint m is rational and the segment fundamental theorem gives

    |f(s)-f(m)| <= L*|s-m|,                 s in [a,c].

For axis-aligned panels let ell=|c-a|, a rational length. A point enclosure (3) at m therefore gives the whole-panel disk

    |f(s)-z_m| < e+L*ell/2.                               (5)

A rational coordinate square centered at z_m with half-width e+L*ell/2 contains that disk. This encloses every point of the analytic panel. It does not infer nonvanishing from endpoint samples.

## Termination on a fixed nonzero boundary

Assume for this conditional search theorem only that f is nonzero on the entire boundary of K. Compactness gives m0=min_boundary |f|>0. This m0 need not be known or computably supplied. It is used to prove existence of a successful finite stage, not as a premise accepted by the finite checker.

At stage j subdivide every side into 2^j equal panels and choose point error e_j=2^(-j). Compute (3) at all panel midpoints and all shared vertices, using a single stored rational center for each shared vertex, including closure. There are finitely many evaluations at each stage, and each terminates as above.

For each panel test all four coordinate functionals Re,-Re,Im,-Im. Accept that panel only if the lower coordinate bound from (5) is strictly positive for one functional and both stored image vertices have strictly positive value under the same functional. These are exact rational tests. Accept the boundary stage only if every panel passes and geometry, adjacency and closure all match K exactly.

To see that some stage passes, at each true midpoint value one coordinate has absolute value at least |f(m)|/sqrt(2)>m0/2. Use its sign as the corresponding functional. For every sufficiently large j,

    2*e_j+L*ell_j/2 < m0/2

simultaneously for every panel length ell_j. The lower bound of the whole-panel square is then positive: the point-center coordinate loses at most e_j and its enclosure radius is e_j+L*ell_j/2. Each stored endpoint center also has positive coordinate, since its true endpoint differs from the midpoint by at most L*ell_j/2 and its own point error is below e_j. Thus the tests pass eventually.

At a shared endpoint, the actual value and the shared rational image vertex belong to both adjacent half-planes. Their connecting segment lies in the intersection. The accepted generic polygon theorem therefore identifies the exact rational image-polygon winding with the actual analytic boundary winding. The actual f is entire, so this is the interior zero count with multiplicity and no pole correction.

This proves eventual production of a sound winding certificate for any fixed rational K in Re(s)>0 whose entire boundary is nonzero. Its winding need not be zero. A successful boundary construction with positive winding is not a zero-free certificate. To certify a zero-free closed K, require the exact winding to be zero as well.

## What this closes and what remains

The fallback closes, at paper level subject to independent review, the generic enclosure-convergence gap for positive-half-plane nonprincipal contours. It shrinks the analytic remainder, finite arithmetic error and panel variation together, using existing source integral identities. Faster EM, Cauchy, Fourier or batched evaluators may replace it after their soundness is proved. No practical claim is attached to direct summation near the critical strip.

It does not establish a zero-free boundary or the desired zero winding for any actual production rectangle. An allowed zero exactly on Re(s)=111/200 prevents this strict-boundary path. Enlarging the top above Hcert requires a certificate on the enlarged domain; it does not justify discarding height-boundary zeros. The separate principal conductor-one function is excluded. The narrow principal strip, the global seven-eighths provider, full-family numerical evidence, all new Lean adapters and the final consumers remain open. None of these results becomes an added hypothesis at either Goldbach root.

The current source and accepted interval/character/polygon plans are the proof dependencies. This note runs no finite sum and generates no L-value, contour record or spectral data. It creates no approved Lean anchor or formal dependency graph.

For scale only, an inline exact Fraction check at q=101, b=111/200 and K=[b,2]+i[7999/8,8001/8] gives B=8017/8, C=6818224/37 and L=1363644800/4107. For requested point error e=10^(-12), the least dyadic cutoff satisfying the strict tail test with target e/3 is N=2^107; both that test and failure at2^106 were checked exactly. No sum of that length was attempted. This deliberately crude bound demonstrates why the fallback is a mathematical convergence argument rather than the proposed production evaluator.
