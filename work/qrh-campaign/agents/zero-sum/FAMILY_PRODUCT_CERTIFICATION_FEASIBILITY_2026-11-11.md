# Conductor products and aggregate inverse certificates

2026-11-11. Paper derivations and a small exact arithmetic check only. No L-values, contour, FFT, production scan, or Lean proof were computed. The selected spectral assertion is unchanged.

The useful positive result is a conductor-level certificate based on one holomorphic convolution inverse approximation. It can replace individual character image polygons by aggregate residual bounds, and a convolution-power test avoids a dimension loss in a simpler norm test. This is a genuine alternative evidence format. It does not establish a reduction in production arithmetic: a suitable inverse has not been constructed, and the existing shared evaluators already remove repeated special-function summation. A determinant alone supplies no such reduction.

## 1. Existing work and the exact target

The following frozen sources were read before this derivation:

* `major-constants/FAMILY_BATCH_WORKLOAD_MODEL_2026-11-11.md`, SHA256 `3A5444AB295112E86DF0740DB8F4533EC37510A66E41EB0DF0340D16CF82A4E1`.
* `major-constants/JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md`, SHA256 `3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D`.
* `zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md`, SHA256 `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54`, with the actual-character coverage proof and its integration review.
* `zero-sum/RESUME_SPECTRAL_CERTIFICATE_STRATEGY_2026-11-11.md` and its separate erratum. Their product contour proposal already removes individual zero isolation, but does not supply a faster product evaluator. This note develops the missing group-algebra alternative rather than claiming that proposal as new.

There are 149,999 active nonprincipal conductors, supporting 5,543,640,187 primitive characters. Conductor one is a separate principal task. Including it gives the familiar 150,000 and 5,543,640,188 totals. Put beta0=111/200 and retain exactly

    qt(c) = c if c is even, and 2c otherwise,
    Hp(c) = 200 + max(1000, ceil(704*1200000/(7*qt(c)))),
    Hcert(c) = min(Hp(c), 100000000/c).

The second term is rational, not rounded upward. Every primitive zero with inclusive height |Im s|<=Hcert(c) must satisfy Re s<=beta0. No character can be removed on account of a small Gauss weight. No inducing modulus is counted as an additional primitive character.

For c>1 choose an actual rational T>Hcert(c) and the closed rectangle R=[beta0,2]+i[-T,T]. Excluding all zeros from R is sufficient, but stronger than the target at Re s=beta0 and above the requested height. A boundary zero at beta0 can therefore prevent this producer from succeeding even when the target holds. Choosing beta0+epsilon is not a valid repair. Real-axis zeros and both ordinate signs belong to the same rectangle. There is no unexamined seam at height zero.

## 2. Product identities with no zero cancellation

Let P_c(s) be the product of the actual L(s,chi) over primitive characters of conductor c>1. All factors are nonprincipal and entire. At any point z,

    ord_z P_c = sum_primitive ord_z L(s,chi).

Each summand is a nonnegative integer. Hence P_c(z) is nonzero exactly when every factor is nonzero. If P_c is nonzero on the complete boundary of R, its counterclockwise boundary winding is the sum of the primitive zero counts in R's interior, with multiplicity. Winding zero therefore excludes every primitive zero there. It also excludes zeros on the boundary by the separate nonvanishing premise. Cancellation between zero orders is impossible.

This is the accepted polygon/argument-principle contract, not an endpoint-sampling criterion. Whole-panel image enclosures, shared rational vertices, orientation and exact winding are still required if this form of certificate is used. See `major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md` and its independent review. Conjugation permutes the complete primitive family, so P_c(conj s)=conj P_c(s); this does not remove real zeros.

For parity a in {0,1}, write Gamma_a(s)=Gamma_R(s+a) and let n_a count primitive characters of that parity. The source-correct completed function is

    Lambda_chi(s) = c^((s+a)/2) completedLFunction_chi(s).

On Re s>0 the product identity is

    product Lambda_chi(s)
      = c^((n*s+n_1)/2) Gamma_0(s)^n_0 Gamma_1(s)^n_1 P_c(s).

Every displayed multiplier is holomorphic and nonzero on a neighborhood of R. Therefore it changes neither zero multiplicities nor the closed-contour winding. For a fixed real tilt b, the product of Z_b,chi(s)=exp(-i*b*s)Lambda_chi(s) adds exp(-i*b*n*s), also nonzero. Different tilts cannot be glued as identical image polygons. The source completion, not a totalized Gamma-times-L formula at arbitrary negative integers, defines the actual entire function.

## 3. Primitive versus all-level products

Let D_c(s) be the product over ALL level-c characters of their level-c L-functions. Each such character is induced uniquely from an actual primitive psi of conductor d|c. Source `LFunction_changeLevel` gives, for nonprincipal psi at every s and otherwise away from s=1,

    L_c(s,psi lifted) = L_d(s,psi)
                       product_{p|c, p not dividing d}(1-psi(p)*p^(-s)).

Each extra Euler factor is nonzero for Re s>0: |psi(p)*p^(-s)|=p^(-Re s)<1. Define their total finite product E_c(s). Then, as a meromorphic identity,

    D_c(s) = E_c(s) product_{d|c} P_d(s),       P_1(s)=zeta(s).

There is exactly one principal pole at s=1. Define A_c to be the ANALYTIC EXTENSION of (s-1)D_c(s), including its removable value, and Ptilde_1=zetaF, the source entire pole-corrected zeta function. Then

    A_c(s) = E_c(s) Ptilde_1(s) product_{d|c,d>1} P_d(s).

Do not define A_c at 1 by multiplying the totalized source value by zero. The identity above defines its correct extension. In Re s>0, E_c is nonzero. Thus a zero-free A_c certificate would certify all primitive ancestors at the same height, including the principal one. This is stronger data than merely certifying P_c.

Divisor inversion yields for c>1

    P_c = product_{d|c} (A_d/E_d)^(mu(c/d)).

This is an identity of meromorphic expressions whose final result is entire. It is not a safe numerical quotient at zeros of ancestor products: apparent 0/0 cancellation can occur. Contour count subtraction is valid only with all the required boundary nonvanishing and counts proved. The primitive projector below avoids those divisions entirely.

On Re s>1 a further exact all-character identity is

    D_c(s) = product_{p not dividing c}
             (1-p^(-ord_c(p)*s))^(-phi(c)/ord_c(p)).

Here ord_c(p) is the order of p in the unit group. This follows by multiplying the character values of p, whose values run through the ord_c(p)-th roots equally often. Absolute convergence justifies this multiplication on that half-plane. Likewise

    -P_c'/P_c = sum_{m>=1} vonMangoldt(m)*A_c^prim(m)*m^(-s),
    A_c^prim(m) = 1_(gcd(m,c)=1)
       sum_{d|c, m=1 mod d} mu(c/d)*phi(d).

The symbol A_c^prim is a coefficient, distinct from the regularized product A_c. These sparse arithmetic formulas do not converge as stated on Re s=.555. No analytic continuation estimate sufficient for the left edge follows from their positive-half-plane origin. No cyclotomic-field factorization is needed or imported here.

## 4. A group determinant on the primitive subspace

Set G=(Z/cZ)^times, v=phi(c). Use unnormalized convolution

    (u*v)(g)=sum_{h in G} u(h)v(h^(-1)g),
    uhat(chi)=sum_{g in G} u(g)chi(g).

Then (u*v)hat=uhat*vhat. The convolution matrix C_u, indexed by G, has entries C_u[x,y]=u(x*y^(-1)). Its eigenvector with entries chi(x)^(-1) has eigenvalue uhat(chi). The manifest proves that these are all actual characters and a basis; positive exponent, inverse vector and the absence of a normalization factor are intentional.

For d|c let K_d be the kernel of the surjective reduction G to (Z/dZ)^times, and let e_d=1_Kd/|K_d|. Averaging a character over K_d gives

    ehat_d(chi)=1 if conductor(chi)|d, and 0 otherwise.

The explicit rational primitive idempotent is

    e = sum_{d|c} mu(c/d)*e_d,
    e_d(g) = phi(d)/phi(c) * 1_(g=1 mod d).

Divisor cancellation gives ehat=1 exactly for conductor c and zero otherwise. Consequently e*e=e. Its construction uses only checked integer arithmetic and reduction kernels, not approximate character recognition. It kills the principal character for c>1. A simple norm bound is ||e||_1<=2^omega(c), at most64 for c<=300000, because seven distinct prime factors would force c>=510510. This bound is optional; exact coefficients may give a better one.

For a unit representative g in {1,...,c}, define the entire coefficient

    a_g(s)=c^(-s) [zeta(s,g/c)-zeta(s,1)],

where the bracket means the analytic Hurwitz difference with its removable pole cancelled. On Re s>1 its positive character transform equals L(s,chi) for every nonprincipal chi, since sum_g chi(g)=0. Analytic continuation gives the same identity everywhere for those characters. This is not a claim about equality of individual Mathlib totalized Hurwitz values at s=1. The common-difference adapter avoids that convention issue.

With delta the convolution identity supported at the group identity, put

    B(s)=C_{delta-e+e*a(s)}.

Its eigenvalues are L(s,chi) for primitive chi and 1 for all other characters. Thus the exact determinant identity is

    det B(s)=P_c(s).

There is no hidden power of v. The matrix is entire, its complement eigenvalues are exactly1, and no principal pole enters. It is unnecessary to construct a numerical v-by-v dense matrix. The formula is an algebraic contract for structured convolution.

The existing Gaussian route also supplies group-algebra coefficients. In the joint plan, a finite synthesis at one parity is D_chi(Uplus)+W_chi*D_inverse(Uminus). Let J u(g)=u(g^(-1)) and w_a(g)=exp(2*pi*i*g/c)/(i^a*sqrt(c)). Then that synthesis is the positive character transform of Uplus+w_a*J Uminus. Project with e_a=(delta+(-1)^a delta_{-1})/2, multiply by the final scalar exp(-i*b*sigma)c^((sigma+a)/2), sum the parity channels, and project with e. Its primitive eigenvalues are precisely the finite approximations to Z_b,chi from the accepted evaluator, with its errors. This handles the inverse channel and Gauss phase; it does not replace W by1. The two parity projections are applied before discarding nonmatching outputs.

One caution concerns errors. A per-primitive eigenvalue error epsilon does not automatically give a group-coefficient l1 error epsilon. For a primitive-supported error vector, Parseval and Cauchy give at most sqrt(n)*epsilon, where n is the primitive count. Direct coefficient-error bounds or a certified group-algebra computation are preferable if an l1 residual test is used. All transform scaling and analytic tails from the accepted evaluator remain part of the input contract.

## 5. A certificate that actually omits individual polygons

Here a(s) denotes the entire coefficient vector just defined, and e is fixed. Supply a finite vector b(s) of rational-coefficient polynomials, or rational functions whose poles are certified outside a neighborhood of R. The same b(s) must be used throughout R. It is an inverse CANDIDATE, not an inverse assumed to exist. Define

    r(s)=e-e*a(s)*b(s).

Its primitive eigenvalues are rhat_chi=1-L(s,chi)*bhat_chi(s); other eigenvalues are zero. If every boundary panel has a certified uniform bound ||r(s)||_1<=q<1, then every primitive scalar residual has modulus at most q there. Each scalar residual is holomorphic on a neighborhood of R. The maximum-modulus principle puts the same strict bound throughout R. Consequently L(s,chi)*bhat_chi(s) never vanishes, and neither does L(s,chi), for EVERY primitive chi throughout the closed rectangle.

This proves the desired zero exclusion without evaluating det B and without recording any individual winding. The proof is an aggregate invertibility argument. It includes multiplicities and real-axis zeros automatically. It is a substantive improvement in certificate format if b has a compact representation.

Panel-dependent inverse candidates, unrelated across panels, do not satisfy this contract. They only certify boundary invertibility. For that weaker construction one still needs a product winding or exact count. In particular a boundary inverse can exist when the interior contains zeros. The global holomorphy of b is the premise that makes the maximum-principle argument work.

### A stronger aggregate residual test

The l1 test can be unnecessarily strict. Define r-dagger(g)=conj(r(g^(-1))) at each s, and t=r-dagger*r. For every positive integer k,

    T_k(s) = v * (t^{*k})(1_G)
           = sum_primitive |1-L(s,chi)*bhat_chi(s)|^(2k).

To prove this, take positive character transforms: r-dagger has transform conj(rhat), so t has transform |rhat|^2. The coefficient at the identity is the average of all transformed coefficients by finite character orthogonality. All nonprimitive terms vanish. Thus T_k is a nonnegative real number, even if its implementation uses complex arithmetic.

A certified uniform upper bound T_k(s)<1 on every full boundary panel implies |rhat_chi(s)|<1 for each primitive character. The same scalar maximum-principle argument then excludes all zeros in R. T_k itself is not holomorphic; no maximum principle is applied to it. Its sole role is a positive boundary bound for each of the holomorphic scalar residuals.

An equivalent form is T_k=v*sum_g |r^{*k}(g)|^2. This follows by Parseval, or by the coefficient-at-identity identity for (r^{*k})-dagger*r^{*k}. It avoids a cancellation-prone final complex sum. For k=16 it needs four convolution squarings of r followed by a sum of nonnegative squares; rigorously enclosing the convolution powers remains necessary.

This criterion can be computed by certified convolution powers without emitting individual eigenvalues. For example n<=149991 and every residual <=1/2 imply T_9<=149991/4^9<1. With k=16, constructing t and then four squarings gives the required convolution power in five convolutions after r is available. This is an operation count for the identity, not a measured cost. On the already understood edge Re s=2, b=delta and |L-1|<=zeta(2)-1<2/3 imply T_16<149991*(4/9)^16<1. Nothing in this edge calculation proves the left-edge condition.

An interval checker must enclose the actual finite convolutions, their rounding, the analytic coefficient errors, and the entire boundary panel dependence. Replacing T_k by a central floating-point value is not acceptance. Large powers may amplify interval uncertainty even when the exact positive sum is small. The appendix script checks finite algebra and the displayed integer inequalities, not any actual function residual.

## 6. Why the arithmetic saving is still unproved

At one point a convolution inverse on the primitive subspace has coefficients

    b_exact(g)= (1/v) sum_primitive chi(g)^(-1)/L(s,chi),

provided the primitive factors are nonzero. If m=min_primitive |L(s,chi)|, then

    1/m <= ||b_exact||_1
          <= (sum_primitive 1/|L(s,chi)|^2)^(1/2)
          <= sqrt(n)/m.

The lower bound is the modulus of its largest character transform. The upper bound is Parseval followed by Cauchy. Thus an almost-zero primitive factor cannot be hidden by the product or the convolution representation. The corresponding normal convolution operator has smallest primitive singular value m. A generic determinant-invertibility calculation faces the same conditioning.

Naively multiplying factors introduces a further difficulty. Relative factor enclosures |f_j/f_j(center)-1|<=rho give the product enclosure radius (1+rho)^n-1. Requiring that disk to exclude zero forces rho<2^(1/n)-1. At n=149991 this is about4.62e-6. This is a limitation of that particular enclosure rule, not a lower bound for all product algorithms. Logarithmic or inverse representations can avoid huge product exponents; they do not remove the smallest-factor problem.

The read workload model counts 9,118,941,848 unit coefficients for one common point at all nonprincipal conductors, compared with 5,543,640,187 primitive outputs. A coefficient-space certificate therefore does not automatically have fewer scalar entries. A dense determinant is worse than using the available character diagonalization. Structured determinant evaluation by diagonalization retains a transform plus a product over its outputs. The joint Gaussian plan has already shared special-function buckets across characters and real parts; this work is not saved again by naming their product.

The global inverse certificate has two potential savings: no per-character image polygons or winding counters are required, and a sparse or low-degree b could avoid a separate adaptive trace for each factor. Its possible costs are coefficient-space inverse approximation, convolution and power computations, larger panel error bounds, and a common mesh controlled by difficult factors. Neither sparsity nor a useful low-degree inverse has been proved for the actual family. Constructing b by first evaluating every L and reciprocating them uses the existing transform work; it may compress output but does not establish less arithmetic.

Conditional existence is not circular acceptance. If all actual factors are zero-free on the closed R, their finite family has a positive minimum on a slightly larger neighborhood. The exact inverse coefficients above are then holomorphic there. A Cauchy integral on a slightly larger rational rectangle, approximated by finite sums, gives rational-function approximants with poles outside R; rational approximations of their coefficients preserve uniform accuracy. Therefore some finite global inverse witness can make the residual arbitrarily small. The checker must verify a supplied residual, and never accept this existence argument as the missing spectral information. No degree, precision or runtime bound follows from it.

## 7. Next action and proof status

The next useful bounded experiment would reuse the already reviewed full conductor-5 rectangle [.555,2]+i[-12,12]. Keep its actual three primitive characters and accepted EM/common-pole evaluator. Construct one rational group-algebra inverse candidate on that rectangle, then compare three complete acceptance records: the existing three character polygons, l1 residual bounds, and T_16 bounds. Record all coefficient evaluations, unsuccessful refinements, inverse representation size and checker work. Do not call a local boundary inverse a global witness. This experiment would test whether the new format buys anything before attempting a production conductor; it is not performed in this note.

The new reusable mathematical obligations are finite convolution diagonalization, the rational primitive projector, the determinant identity, the global holomorphic residual theorem, and the positive convolution-power boundary test. Source-level bridges still need formalization, and actual residual certificates for production conductors are absent. The already reviewed contour route remains available if no compact inverse is found. The selected beta0 assertion has not been replaced by finite RH or simplicity.

Source inventory for implementation: pinned Mathlib `NumberTheory/DirichletCharacter/Basic.lean` provides FactorsThrough, conductor, primitiveCharacter and changeLevel recovery as itemized in the manifest; `Data/ZMod/Units.lean:47` provides reduction surjectivity; `NumberTheory/LSeries/DirichletContinuation.lean:74,97,149,173,181,249,258` gives the series/continuation, nonprincipal entirety, level change, principal formula/residue and completion adapters. `LinearAlgebra/Matrix/Determinant/Basic.lean:80,141` supplies det_diagonal and det_mul. The existing rectangle argument-principle and polygon sources supply multiplicity and finite crossing semantics. These were read or inherited with exact pins; the new group-algebra and maximum-principle packages are not claimed to exist as completed Lean declarations. All new identities above were derived here from finite character orthogonality and the stated analytic facts; no new external numerical theorem or historical GRH computation is used.

## Exact check receipt

`family_product_certificate_checks_20261111.py` uses only Python integer and Fraction arithmetic. It checks the two uniform moment inequalities and, at c=5,8,40,120, constructs e from actual residue reduction kernels, checks idempotence and inverse symmetry, obtains rank from v*e(1), and independently computes the sum-of-squares moment for the synthetic residual e/2. These finite tests are consistency checks for the derived formulas. They are not tests of any actual L-function or inverse candidate. The script's `--recompute` mode compares with its receipt without overwriting it.

Script SHA256: `3F877AE40F2D89ABFC45E8981CBC8696149233D8909BC9146992A7EAE1B1A6C0`. Receipt SHA256: `68FAA891D5954CAC21D5460583578513083D0515459C2DF5F140A047A7B3401E`. The run returned `PASS_EXACT_ALGEBRA_ONLY`; this status contains no spectral assertion.
