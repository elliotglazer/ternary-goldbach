# Base-gap alternatives and the complex-character detector

Research-only assessment, 2026-11-10. No Lean compilation or source implementation. The concrete result below is a complete paper deduction from the current Type I/II pointwise theorem. That source theorem still requires `Fact PlattGRH`; replacing its prime/Mobius inputs remains necessary before the deduction is a no-Platt theorem.

## Result and recommended next step

Keep the current arcs and use a direct convolution bound on the portion of the gap whose reduced denominator for `2 alpha` satisfies

    100000 <= Q <= 150000,     Q / phi(Q) <= 1.05.

On this portion the existing pointwise theorem implies

    |S_etaStar(alpha,x)| < .038 y,     y=x/49 >= 1e25.

This is uniform in y and the entire allowed twist interval. It needs no Dirichlet zero-family estimate for this portion. It includes every prime Q in this range, and also the composite denominators meeting the displayed totient-ratio test. The test is about Q, not necessarily the original denominator q of alpha.

The source consumer only needs `|S_etaStar| <= y * ghatY(y,150000)`, not the earlier `.0121 y` or `.01398 y` sufficient bounds. Direct evaluation of the definitions gives approximately .0601840 at y=1e25 and an asymptotic floor .0471323. These evaluations alone are diagnostic; the major-constants worker has an independent rational-envelope proof of the uniform lower bound `.04712`. Even the parent's earlier `.0404` lower bound suffices for the .038 branch.

Thus the zero-sum note's hypothetical .03485 contribution does not obstruct the actual downstream target. Its obstruction remains valid for the narrower .0121 and .01398 intermediate targets.

## Exact geometry and rescaling

Use the rational a/q selected by membership in the wider y-major arcs, with delta=(alpha-a/q)y. The actual parity-aware conditions are

    q odd:  q <=150000,  600000/(49q) <= |delta| < 600000/q;
    q even: q <=300000, 1200000/(49q) <= |delta| <1200000/q.

Reducing `2a/q` gives denominator

    Q=q       if q is odd,
    Q=q/2     if q is even.

The reduced numerator is respectively 2a or a, and is coprime to Q. In both cases

    Q <=150000,       Q |delta| <600000.

At scale z=w y, the additive parameter in the pointwise theorem is `Delta_w=2w delta`. It follows that

    delta0=max(2,w|delta|/2),
    t=delta0 Q=max(2Q,w|delta|Q/2).

For the central interval `1/20 <= w <=8`, and Q>=100000,

    z >=5e23,       200000 <=t <=2400000.

The same reduced rational is a valid approximation throughout this interval. Its required error condition is

    |2delta/y| <= 1/[Q*(3/4)*(wy)^(2/3)].

After multiplying positive factors it is enough that

    (3/2)*Q|delta|*w^(2/3) <= y^(1/3).

The left side is at most 3600000, since w^(2/3)<=4. The right side exceeds 200000000, since `(2e8)^3<1e25`. Also `Q <= z^(1/3)/6`: indeed z^(1/3)>79000000 and Q<=150000. In particular Q is at most the approximation height `(3/4)z^(2/3)`. Finally z>=2.16e20. These verify all size and approximation hypotheses of the first branch of `theorem_3_1_1`, including the additional rescaling condition for w>1.

Source locations: `MinorArcs/PointwiseBound.lean`, theorem `theorem_3_1_1`; `MinorArcs/EtaStarBound.lean`, theorem `theorem_3_1_1_scaled`. This calculation does not use the incorrect assumption that delta remains fixed when w changes.

## Uniform central envelope

Write v=Q/phi(Q)<=1.05. Dividing the pointwise theorem by z gives

    C(z,t,v) = (R(z,t) log t+.8764)*sqrt(v/t)
             +2.526/sqrt(t)
             +2*[v*(3.25 log t+7.82)+13.66 log t+37.55]/t
             +3.8*z^(-1/6).

First, `R(z,t)<.68` over the whole central rectangle. The definition is

    R(z,t)=.27125 log(1+log(4t)/(2log(9z^(1/3)/(2.004t))))+.41415.

Since z^(1/3)>79000000 and t<=2400000, the argument of the denominator logarithm exceeds 140. Use

    log140>4.9,    log9600000<16.1,
    log(1+16.1/9.8)=log(259/98)<.98.

Consequently `R<.27125*.98+.41415=.679975<.68`.

For A,B positive, `(A log t+B)/sqrt(t)` decreases when `log t>2`, and `(A log t+B)/t` decreases when `log t>1`. Their derivatives have numerators `A-(A log t+B)/2` and `A-A log t-B`, respectively. Therefore after replacing R by .68 and v by 1.05, every t-dependent term of C is bounded by its value at t=200000. This avoids differentiating R itself.

The following deliberately loose scalar bounds suffice:

    log200000 <12.21,
    sqrt(1.05/200000) <.002292,
    1/sqrt200000 <.002237,
    3.8*(5e23)^(-1/6) <.000428.

They yield the exact rational central envelope

    C < (.68*12.21+.8764)*.002292 +2.526*.002237
        +[1.05*(3.25*12.21+7.82)+13.66*12.21+37.55]/100000
        +.000428
      =593191013/20000000000
      =.02965955065.

## Integrating the central envelope and both tails

The source identity uses `phi(w)=w^2 exp(-w^2/2)` and gives

    |S_etaStar(alpha,x)|/y
       <= integral_0^infinity [|S_eta2(alpha,wy)|/(wy)] phi(w) dw.

The unconditional elementary bound in `norm_S_eta2_le_trivial` is 17 for the bracket. Use it on both tails, and the preceding C on `[.05,8]`. This can be expressed in the existing `norm_S_etaStar_le_of_pointwise_Ici` by a piecewise G equal to C through 8 and 17 thereafter. Its Gaussian integrability is immediate.

The required mass bounds are

    integral_0^infinity phi = sqrt(pi/2)<1.254;
    17 integral_0^.05 phi <=17*.05^3/3 <.000709;
    17 integral_8^infinity phi
       <=17*(8+1/8)*exp(-32)<.000000002.

For the final bound, integration by parts gives the term `8exp(-32)` plus the Gaussian tail, and `integral_8^infinity exp(-w^2/2)dw <=exp(-32)/8`. The exponential lower bound exp32>1e13 is more than enough. The total is strictly below

    1.254*.02965955065+.000709+.000000002
      =379020785151/10000000000000
      =.0379020785151 <.038.

This proves the displayed paper branch for every y>=1e25. It does not extrapolate numerical integration at the minimum y.

## Arithmetic checks and proof status

The nine elementary inequalities used above were checked with exact BigInt rational arithmetic in this research session. For positive rational r, use the Taylor sum S_N through N=160 and

    S_N < exp(r) < S_N + [r^(N+1)/(N+1)!]/[1-r/(N+2)].

This checks exp4.9<140, exp16.1>9600000, exp.98>259/98, exp12.21>200000, and exp32>1e13. The two square-root bounds are checked by squaring positive rationals, and the sixth-root bound by checking `(3.8/.000428)^6<5e23`. The final total is the exact fraction above. The Gaussian mass estimate follows for example from pi<22/7 and `(1.254)^2>11/7`.

No interval quadrature, zero ordinates, random sampling or floating-point assertion is needed for this branch. The exact checks do not certify the Lean translation. The analytic argument still needs independent review and formalization. Above all, the source Type I/II theorem remains Platt-dependent until its planned input replacements are proved. The branch removes a separate conductor-family obligation only on the stated denominator set; it does not solve the remaining base-gap region.

## Arc changes and numerical dependencies

Decreasing the wide-arc cutoff to r0/49 gives the inclusion `M(8,r0/49,y) subset M(8,r0,x)`. Thus a generic pointwise bound with n=r0/49 applies outside the original x-major arcs. It is much too expensive as a drop-in estimate: evaluating the current ghat formula at y=1e25 gives approximately .46828 instead of .06018. Its asymptotic floor is about .43493. A new minor-integral budget would be needed.

An intermediate cutoff n<r0 does not make `M(8,r0,x)` a subset of `M(8,n,y)`, because its missing high denominators remain. A union of the two sets can restore nesting, but changes the cumulative energy/large-sieve bookkeeping. It is not a free replacement of the initial level in the existing summation argument.

Increasing the x-major arc widths to the y-major widths removes the gap geometrically. It also enlarges the major-arc twist intervals by 49. The existing major average and cross-error bounds would then have to be re-established on those enlarged intervals. Increasing r0 globally additionally changes the conductor cutoff, singular-series truncation and minor-layer finite cells. Decreasing r0 changes those quantities in the opposite direction and worsens ghat. Neither operation preserves the present final numerical proof automatically.

In contrast, the .038 direct branch leaves the sets, the initial-level ghat coefficient, the major averages, and the minor finite cells unchanged. Only the proof that the initial-level pointwise bound holds changes. This is the bounded alternative recommended for the next proof task.

## Complex-character positive detector

The real-part detector is exact for primitive nonprincipal characters, including complex characters. Put a=0 or1 according to parity and

    Lambda_chi(s)=(q/pi)^((s+a)/2) Gamma((s+a)/2) L(s,chi).

For sigma>1, the exact identity is

    sum_rho (sigma-Re rho)/|sigma+it-rho|^2
      = (1/2)log(q/pi)
        +(1/2)Re digamma((sigma+it+a)/2)
        +Re[L'/L(sigma+it,chi)].

Multiplicities are required. The sign of the final term is plus; substituting the Euler series makes it minus the real part of `sum Lambda(n)chi(n)n^(-sigma-it)`.

The Hadamard expression has a constant B_chi and the compensating terms 1/rho. The functional equation implies

    Re B_chi = -sum_rho Re(1/rho),

so those real terms cancel for every s, including sigma+it. An imaginary constant in the full complex expression has zero real part and creates no missing term. A proof must not discard the constant in an asserted full complex identity without establishing the summation convention.

One direct explanation uses `Lambda_chi(s)=epsilon_chi conjugate(Lambda_chi(1-conjugate(s)))`. Within one fixed character the zero reflection is `rho ->1-conjugate(rho)`, preserving the sign of the ordinate. On the critical line the logarithmic derivative has zero real part away from zeros, while the reflected zero pair contributes opposite real parts. This establishes the constant cancellation. The reflection `gamma ->-gamma` alone generally changes chi to its conjugate; using it within one complex character would be an error.

The real zero sum converges absolutely, since its terms are O((1+gamma^2)^-1) for fixed s and the standard zero count is O(T log(qT)). For sigma>1 every term is positive, so restricting the sum is legitimate. Principal characters require their pole corrections, and imprimitive characters require the missing Euler-factor corrections or reduction to the inducing primitive character.

The literature distinguishes the real identity from the subtler full complex one. See Ihara, Murty and Shimura, *On the logarithmic derivatives of Dirichlet L-functions at s=1*, Acta Arithmetica 137.3 (2009), section 2.3 and Theorem 2: https://www.impan.pl/shop/publication/transaction/download/product/82940 . Their discussion explicitly notes that the real-part identity is standard while convergence for the complex version needs justification. The argument here supplies the sigma+it version directly from the completed functional equation and Hadamard product.

For a prime modulus p, summing all nonprincipal characters before taking real parts gives the exact coefficient `(p-1)1_(n=1 mod p)-1` on integers coprime to p, and zero otherwise. Even/odd subfamilies use the two residue classes n=+/-1. The factor `n^(-it)` remains present; for these real aggregate coefficients its real part is cos(t log n). No imaginary constant survives this family detector. Its numerical strength is a separate open question, needed only on the residual denominator set after applying any direct branch.
