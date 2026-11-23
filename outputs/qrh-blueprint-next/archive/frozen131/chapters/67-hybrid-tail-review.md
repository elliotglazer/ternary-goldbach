# Independent review of the hybrid spectral-tail reduction

Review date:2026-11-11. Verdict: no mathematical defect found in the audited etaU/etaPlus high-tail reduction or its mixed-norm transport. The stated norm bound below6e-9 is supported by the source formulas and the exact scalar checks, conditional on the required proved global7/8 strip and the ordinary analytic bridges explicitly left open. This is a paper/source review, not Lean validation or a certificate of finite zero locations.

Reviewed artifacts:

- independent-feasibility/RESUME_HYBRID_CERTIFICATE_2026-11-11.md, SHA256 AF3F6FF51A58C36E18F5C77F67BA2F92C8601882F24E5A262DA1D668E111E511.
- independent-feasibility/hybrid_tail_check_2026_11_11.py, SHA25645322AE9C8927CD1B786FCF7243C6EC4B9CD96DED0E23F27756FA7B2C3AE0370.

I independently executed the checker with the work-local Python environment. It exited0 and printed PASS_EXACT_ARITHMETIC_ONLY, the tail coefficient, mixed norm6e-9, and the displayed height examples. No Lean process or canonical source change was made. Source references are to ternary-goldbach23b2d68.

## Mellin normalization and actual smoothing

The etaU identity is correct. Helfgott/Defs.lean defines mellinConv(f,g)(t)=integral f(v)g(t/v)dv/v, and phi(u)=u^2 exp(-u^2/2). MinorArcs/EtaU.lean:24 defines etaU using the swapped order; BaseGap2.lean:23 identifies the source Mellin convolution. Substitution t=vu in the Mellin integral contributes exactly v^s, giving

    F_U(s,d)=integral_(1/4)^1 eta2(v)v^s Gr(s,dv,0)dv/v.

Explicit/GMellin.lean:22 proves mellin(fdelta d)(s)=Gr(s,d,0), with the Gaussian u^2 already inside fdelta. There is therefore no s+2 shift and no additional v^2 factor. The eta2 moment bound below2 is valid for beta in[1/8,7/8]: eta2 is nonnegative with support[1/4,1], and its logarithmic tent gives4((1-2^-beta)/beta)^2<=4(log2)^2<2. Even without the closed formula, v^beta<=1 reduces it to the beta=0 moment.

Fubini, the positive-real cpow multiplication law and differentiation/continuity bridges remain formal obligations. Compact v support bounded away from0 and Gaussian u decay give the needed absolute domination; this is an ordinary missing proof, not a hidden additional arithmetic hypothesis.

Explicit/ZetaBound.lean:18, norm_G_tail_floor, has the exact real-part range[-1,1], cutoff max(10pi|d|,50), and exponent floor((|gamma|-H)/4.4). It applies directly at s to etaU. The source tail rate uses |d|+1 in rhoA; the report retains this. EA's decreasing endpoint function is valid because its u parameter is at least10. The delta=0 branch is explicitly zero. Both rate and endpoint replacement by D are in the safe direction.

For etaPlus, Explicit/EtaPlusMellin.lean's norm_mellin_fP_tail correctly requires the extra200 in the height threshold and evaluates EB/EA at H-200. EtaPlusCg.lean:89 gives Cg*(2aH)<=129.24. This distinction between the two smoothings is retained throughout the report.

The crude finite-low bound |F_U|<4 also checks: after the eta2 moment<2, the Gaussian moment is bounded by integral_0^1 u du plus integral_1^infinity u^2 exp(-u^2/2)du, which is <.5+sqrt(pi/2)<2. No unsupported all-twist cancellation is used.

## Conductors, Gauss support and cutoffs

MinorArcs/Bombieri.lean:135, norm_sq_gaussSum, gives weight c exactly when q=c*r with r squarefree and coprime to c; otherwise the weight is0. Conductor divisibility and the character's primitive lift appear in the same proof. Inversion preserves the conductor, so the inverse-character convention causes no different height range.

The needed Dq<=Dc holds on this active support:

- If c is even, every active q is even and qt(q)=q>=c=qt(c).
- If c and q are odd, qt(q)=2q>=2c=qt(c).
- If c is odd and q is even, q=c*r with r even>=2, so qt(q)=q>=2c=qt(c).

A conductor with2-adic valuation one has no primitive characters: for c=2m,m odd, the unit groups at c and m are naturally isomorphic and every character comes from m. This is a valid mathematical exclusion, but its enumeration/induction bridge still needs a formal proof.

For the star transform the relevant primitive twist is delta/49, so Dstar=Dc/49. The rational cutoffs ensure

    Hplus-200>=32pi Dc,
    Hstar>=32pi Dc/49,

and both Gaussian base heights are at least1000. Since Dc<=600000 for every positive active conductor, monotonicity proves the global height bounds61 million and1.3 million. The script's seven sample conductors merely illustrate the formula; the all-conductor assertion follows from this inequality, not an exhaustive check of those seven rows.

No high conductor has been discarded on the basis of these cutoffs. This correctly preserves the potential concentration in the finite mixed aggregate.

## Counts, both signs and high-tail coefficient

Explicit/ZeroSums.lean:17 defines

    BP(c,H)=1400*c^9*(c+1)*(|H|+22)*(1.25(|H|+11))^10.

Bounding c^9(c+1) by(c+1)^10 gives the report's logarithmic numerator349. All finite cutoff/count centers are below10^8; the checker supplies the exponential lower comparisons for the logarithmic bounds. For zeta, XiPartial.lean:49, log_BPz2_le', gives the separate smaller numerator10.24+19+9*19<349. A literal polynomial inequality BPz2<=BP is not required.

The denominator log(10/3)>1 makes Z3g<400 safe. The growth coefficient is kappa*4.4/[H log(10/3)]; kappa<=12 gives c3g<53/H. Thus the supplied generous constants are valid both for primitive nonprincipal L-functions and for zeta.

ZeroSumGen.lean:121, count_tail_windowG, counts the original multiplicity over BOTH signs and gives2Z3g+2c3g(k+1). Its real-part condition is only0<beta<1. The proof separates the signs explicitly; no real-character conjugation or quartet assumption enters. The exact E2g definition at line195 has precisely the corresponding factors2 and the geometric denominator squared. The report uses those factors correctly.

The estimates for reciprocal1-rhoA and1-rhoB have the correct direction. The inequality1/(1-exp(-a))<=1+1/a holds for a>0. The source constants imply a_A>=2.7/(600001), and all count heights are at least1000. Therefore800G+.106G^2<1e10 controls each geometric count sum.

The Taylor lower sums correctly certify EA<1e-44 from u>=32 and EB<1e-65 from base>=1000. Monotonicity of u^2 exp(-.1065u^2) and t exp(-.1598t) on these ranges supplies the extension beyond the endpoints. Bounding either smoothing prefactor by1000 is generous. The resulting primitive tail coefficient is strictly below1e-30.

Under the global strip, x^(beta-1)<=x^(-1/8) and y^(beta-1)<=y^(-1/8). This is the justified improvement over the old source tail sum's factor x; no critical-line assumption has been retained accidentally. Trivial zeros, the possible zero at0, pole terms and contour integrals are expressly excluded and still need their separate estimates. Uniform finite-rectangle bounds give absolute convergence of these high tails, so this part of the limit passage is valid.

## Mixed measure and products

The finite-low count uses unit-height windows at centers below61 million+1. Radius3 contains each window for the entire strip, and the same polynomial estimate gives the count400 per window. The total count bound below1e11 is consequently valid with multiplicity. The uniform source etaPlus transform prefactor is below106000; the verified etaU bound is4. The displayed low-sum bounds2e16*x^(-1/8) and1e12*y^(-1/8) are conservative.

Expanding the product gives exactly three omitted terms:

    l_plus*t_star+t_plus*l_star+t_plus*t_star.

Their common pointwise bound3e-14*(xy)^(-1/8) follows from the stated low and tail bounds. This statement applies to every ordered pair of primitive characters that induces into a given q; the characters need not be equal or conjugate.

For the actual mixed direct-sum norm, the measure is

    [w(q,psi)w(q,xi)/phi(q)^2] ddelta

on each(q,psi,xi) coordinate and its own interval Iq. There are phi(q) characters in each index and w<=q. Thus the sum of weights for one q is at most q^2, not q or phi(q). Multiplying by length<=1200000 and at most300000 moduli yields the report's3.24e22<(2e11)^2. Repeated occurrences of one primitive character under different inducing moduli are included rather than identified.

Since x0*y0>1e48, the product scale is<1e-6. The resulting mixed Hilbert norm is<6e-9. This is a norm bound; one cannot add it directly to Cross as a squared-energy error. The report correctly uses Minkowski with square roots. The constant25 allocation check also replays arithmetically, while the conductor-operator proof itself is a separately supplied research result rather than newly audited here in full.

## Finite aggregates and uniform-x clarification

The cell-envelope method is sound as stated, provided each actual cell bound is proved with its full conductor square and the joint kernel integral. The powers of x and y decrease for upper real endpoints below1. This concerns the nonnegative upper bound, not monotonicity of the oscillatory residual itself.

The Gram alternative is also sound under an essential explicit interpretation: for the mixed target the Gram operator must act on the PRODUCT basis indexed by both character/zero indices, with the multiplicity product and the actual q-window measure, or supply an equivalent operator inequality for that same mixed norm. Separate per-leg L2 Gram bounds do not control a fourth moment by themselves. I requested that the author make this implementation condition explicit.

For the product-space operator, at x=r*x0 and y=r*y0, r>=1, each normalized coefficient receives the factor

    r^(beta_rho+beta_sigma-2)*exp(i(gamma_rho+gamma_sigma)log r).

Its modulus is at most1. Therefore it is a diagonal contraction composed with a unitary phase matrix, and an operator-norm estimate valid for all coefficient vectors does give the promised all-x bound. Sampling the signed sum at x0 would not. Repeated-index or square-root multiplicity conventions are both legitimate when used consistently.

The principal finite moment quoted from my report is correctly distinct from this mixed certificate. It does not prove I_low, Astar, or nonprincipal upper energy. Its source zetaF contour uses the analytic continuation at1, and the hybrid note correctly repeats that caveat. A contour placed on beta=2/3 would require boundary nonvanishing there, which is slightly stronger than merely excluding zeros with beta>2/3; the certificate may legitimately prove that stronger fact.

## Handoff status

The high-tail architecture passes this bounded mathematical/source review. It still requires formal Fubini/convolution, monotonicity, character enumeration, finite-carrier transport and norm-limit lemmas. The global QRH provider must be validated separately. The finite weighted zero aggregates, Astar allocation, full contour/zero-at-zero remainder budget and final nonprincipal upper-energy theorem remain unproved exactly as the report states.

No finite zero data, no final cap, and no theorem closure is certified by this review. The mixed-product Gram clarification should be carried into any future frozen declaration or implementation task.
