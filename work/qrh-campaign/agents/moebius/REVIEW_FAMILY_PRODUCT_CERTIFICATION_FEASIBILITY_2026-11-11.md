# Review of family-product certificate feasibility

2026-11-11. **PASS as a paper proof and feasibility assessment. No correction required.** The global holomorphic inverse-residual criterion is a valid alternative to individual character polygons. The note correctly does not claim that it reduces production arithmetic. No actual inverse candidate or successful residual certificate is supplied.

The distinction is substantive: panelwise inverse witnesses prove boundary nonvanishing only. One common inverse candidate holomorphic throughout the rectangle allows a maximum-principle argument and can exclude interior zeros without a winding calculation. The author includes that distinction explicitly.

## Frozen evidence and independent checks

Reviewed `../zero-sum/FAMILY_PRODUCT_CERTIFICATION_FEASIBILITY_2026-11-11.md`, SHA256 `B701615E4D93727BF7A2C290C41F94EDEB40C0E9FE2BCFAB4A725CB6AC4B8973`.

The producer's exact script is `family_product_certificate_checks_20261111.py`, SHA256 `3F877AE40F2D89ABFC45E8981CBC8696149233D8909BC9146992A7EAE1B1A6C0`; its receipt has SHA256 `68FAA891D5954CAC21D5460583578513083D0515459C2DF5F140A047A7B3401E`. Its read-only replay passed and matched the receipt.

The independent script in this directory, `review_family_product_20261111.py`, has SHA256 `E479AF5E8063BB22E1214A0BF5BE3A1E5062881BC42FD8915E9070079A16A595`. Its receipt has SHA256 `296D542FF9ADA53079AEAD3448E5B8D42781131C8CE105F9EDE2615E5C78DED7`.

The independent checks use nontrivial rational-complex arrays at c=5 and c=8. They verify the primitive idempotent, actual character multiplication, the compressed determinant by exact permutation expansion, and the two residual-moment expressions for k=1,2,3. The arrays are synthetic and are not asserted to satisfy a spectral residual bound. The script also checks the displayed n/4^9 and n(4/9)^16 inequalities, the elementary Re(s)=2 bound, and the six-prime limit. No special function or numerical spectral data is used.

I reread the exact source level-change theorem in pinned Mathlib `NumberTheory/LSeries/DirichletContinuation.lean`. Its hypothesis is `chi != 1 or s != 1`, exactly supporting the note's distinction between nonprincipal continuation and the principal point. The same file supplies the principal formula and residue. I also reread `differentiable_hurwitzZeta_sub_hurwitzZeta` in `NumberTheory/LSeries/HurwitzZeta.lean`, including the adjacent explanation of the nonstandard individual value at s=1. The common-difference construction respects that source convention.

## Products, poles, and multiplicities

For c>1 every primitive character is nonprincipal, so the actual L-functions in P_c are entire. They are not identically zero, for example from their convergent series near the positive real point 2. The analytic order of their finite product is the sum of their nonnegative orders. Therefore no zero can disappear through multiplication. If the product is nonzero on the full positively oriented rectangular boundary and has winding zero, every factor has no zero in its interior; the boundary is handled separately by the nonvanishing check.

This reasoning would fail for an uncorrected meromorphic product, since a pole can cancel a zero. The note avoids that problem. Its completed-product factor is

`c^((n s+n_1)/2) GammaR(s)^n_0 GammaR(s+1)^n_1`.

Every factor is holomorphic and nonzero on a neighborhood of the requested positive-real-part rectangle. The fixed exponential tilt likewise has a global holomorphic logarithm. These factors change neither multiplicities nor winding there. Their values are not interchangeable image vertices without explicit conversion.

For all level-c characters, the source level-change Euler factors are exactly those indexed by primes dividing c but not the primitive conductor. On Re(s)>0, their nonconstant terms have modulus less than one, so these factors cannot vanish. The factorization of D_c into E_c and the primitive ancestor products is correct. The principal factor has to be regularized by analytic extension of (s-1)D_c, not by evaluation of a totalized source value followed by multiplication by zero. The resulting identity through zetaF supplies that extension. The simple-pole source residue can justify the principal behavior; the regularized identity does not need an unproved cancellation assumption at s=1.

The divisor-inversion formula is valid as a meromorphic identity. Its quotients need not be safely evaluated at an ancestor zero. The note correctly rejects using formal cancellation of 0/0 as a numerical certificate and requires complete boundary/count data for any count subtraction. Its all-character Euler product and primitive logarithmic derivative are only asserted in Re(s)>1. They do not supply left-edge estimates at .555.

Both signed heights and real-axis zeros remain in the same closed rectangle. Conjugation permutes the primitive family but does not delete real zeros. A zero on Re(s)=111/200 is allowed by the ultimate weak inequality and can still obstruct this stronger closed-rectangle producer. Increasing the left edge is not an authorized remedy.

## Primitive projection and determinant normalization

For the specified unnormalized convolution, the vector `g -> chi(g)^(-1)` has eigenvalue `sum_g a(g)chi(g)`. The inverse in the vector is essential for the positive-transform convention. The complete character basis gives the determinant identity with no extra factor of phi(c).

The averaging kernel e_d has transform one precisely for characters trivial on the reduction kernel. By the source factor-through criterion and conductor divisibility this means conductor(chi) divides d. Hence

`e=sum_(d|c) mu(c/d)e_d`

has transform one exactly on primitive characters at c. This proves e*e=e and removes the principal character when c>1. The coefficient formula `phi(d)/phi(c)` follows from surjectivity of the unit-reduction map. The optional l1 estimate by the number of squarefree divisors, at most 64 in this conductor range, is valid.

For `a_g(s)=c^(-s)[Hurwitz(s,g/c)-Hurwitz(s,1)]`, the common difference is entire. In Re(s)>1, grouping the Dirichlet series and using sum_g chi(g)=0 proves its transform equals actual L(s,chi) for nonprincipal chi. Analytic continuation supplies the identity at s=1 and elsewhere. There is no claim that independently pole-subtracted scalar Hurwitz values equal Mathlib's individual totalized values there.

Consequently `C_(delta-e+e*a)` has primitive eigenvalues L(s,chi) and complement eigenvalues 1. Its determinant is exactly P_c. This is an algebraic statement about structured convolution; constructing a dense matrix is unnecessary.

The alternative Gaussian coefficient construction also keeps its normalization: inversion of a group argument changes the character to its inverse, convolution with the Gauss vector multiplies its transform by W, and the two parity projectors retain only matching outputs. The final phase and conductor scale produce the actual fixed-b Z functions. Approximate finite synthesis is still accompanied by its analytic and arithmetic errors; it is not silently substituted for an exact entire coefficient vector.

## The global inverse certificate

Let the same b(s) be holomorphic on a neighborhood of the entire closed rectangle. A polynomial candidate has this property automatically. A rational candidate needs a separate proof that its poles are outside that neighborhood. Define `r=e-e*a*b`.

For each primitive character, `rhat=1-L*bhat` is holomorphic. A full-boundary l1 bound below one implies the same bound on every rhat. The scalar maximum-modulus principle extends it to the interior. At a zero of L the residual would equal one, a contradiction. Thus the criterion excludes all primitive zeros throughout the closed rectangle without a determinant computation or individual winding record.

The condition that one b is holomorphic across the whole region cannot be weakened to unrelated panel candidates. For example a function with an interior zero has a perfectly valid reciprocal on a sufficiently small neighborhood of each boundary point. Local inverse checks do not exclude that zero. The final note keeps this requirement and retains winding for the weaker boundary-only construction.

Conditional existence is stated appropriately. If all primitive factors are actually nonzero on the compact closed rectangle, they remain nonzero in a slightly larger common neighborhood. Their inverse group coefficients are holomorphic there. Cauchy approximation on a larger contour and rational approximation of finitely many coefficients produce a finite rational candidate with sufficiently small residual. This explains completeness under true nonvanishing, but is not an input accepted by the checker in place of a verified candidate. It gives no degree, precision, or runtime bound.

## Aggregate moment criterion

For `r_dagger(g)=conjugate(r(g^-1))`, its transform is conjugate(rhat). Therefore

`v*(r_dagger*r)^{*k}(1) = sum_primitive |rhat|^(2k)`.

The complement terms vanish because r is primitive-supported. Commutativity and the coefficient-at-identity identity also give

`T_k=v*sum_g |r^{*k}(g)|^2`.

This latter form is a nonnegative final sum and avoids cancellation in the last coefficient calculation. It still requires rigorous interval enclosures for the preceding convolution powers. Both identities passed independent exact tests with nonreal, nontrivial synthetic residuals, rather than only scalar multiples of e.

A full-boundary bound T_k<1 implies each primitive residual has modulus below one. The maximum principle then applies to each analytic rhat. It does not apply directly to T_k or r_dagger, which are not holomorphic in s. The note states this correctly.

The dimension examples check: `149991/4^9<1` and `149991*(4/9)^16<1`. Four squarings compute r^16; alternatively forming t=r_dagger*r followed by four squarings uses five convolutions. These are different valid formulas, not conflicting operation counts. The Re(s)=2 example with b=delta follows from `|L-1|<=zeta(2)-1<2/3`; it gives no analogous left-boundary result.

## What is and is not saved

The exact workload input was checked at hash `3A5444AB295112E86DF0740DB8F4533EC37510A66E41EB0DF0340D16CF82A4E1`. It records 149,999 nonprincipal conductors, 5,543,640,187 primitive outputs, and 9,118,941,848 unit coefficients for one common point per conductor. The largest unit array has 149,992 entries. A coefficient-space witness therefore does not automatically have fewer scalar entries than character-space output.

The existing joint plan already shares special-function buckets across characters and real parts. Diagonalizing a group determinant uses that transform followed by a product; it does not remove the transform work. A generic dense determinant would discard useful structure. A global inverse candidate might reduce individual polygons, winding counters, or adaptive traces if it has a compact representation. Its construction, convolution powers, common mesh, and interval accuracy can instead cost more. No compact candidate or comparative production measurement has been supplied.

The conditioning statements are correct. Exact inverse coefficients satisfy

`1/min|L| <= ||b_exact||_1 <= (sum_primitive |L|^(-2))^(1/2) <= sqrt(n)/min|L|`.

This follows from the transform bound, Parseval with its 1/v factor, and Cauchy-Schwarz. A nearly zero primitive eigenvalue remains difficult in every representation. Likewise per-eigenvalue error epsilon can cost sqrt(n) in a primitive-supported coefficient l1 estimate. The positive moment criterion removes that particular sufficient-condition penalty, but adds convolution work and does not bypass a small eigenvalue.

The naive relative product radius `(1+rho)^n-1` and its approximately 4.62e-6 per-factor threshold at n=149991 describe one enclosure rule, not a lower bound for every algorithm. Rescaling products or using logarithmic representations can prevent extreme exponents but does not supply the missing nonvanishing margin.

The suggested bounded conductor-5 comparison is a sensible next experiment because it can measure actual inverse representation size and verification work against already available character contours. It remains unperformed in the reviewed packet. No production speedup, spectral truth, historical GRH input, or new permitted final hypothesis is accepted here.
