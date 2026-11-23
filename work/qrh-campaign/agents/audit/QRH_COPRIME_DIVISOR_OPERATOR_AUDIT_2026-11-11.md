# Finite coprime divisor blocks and quotient operator restriction

2026-11-11. **No mathematical defect found in the bounded finite producer reconstructed below.** This is an author source audit for independent review, not a compatible Lean build, transitive axiom audit or validation of the whole QRH provider. No Lean source, prior report or frozen artifact was changed; no analytic values were evaluated.

Source root B is `work/openai-math/lean/OAI/NumberTheory/DirichletL`, at revision `4eaee87548250b2682affda7d05d947c05554bae`. Source paths and line references below are relative to B.

## 1. What is new, and the exact target

The quadratic product-column report already inspected its product fibers, use of the sharp quadratic output and immediate submatrix adapter. The initial cubic report inspected the energy-to-operator adapter. Neither established the bilinear coprimality/divisor-block producer used beneath the newly reviewed middle-frequency estimates. The middle report explicitly leaves `QuadraticSieve/CoprimeBilinearBound.divisor_block_bound:319` and `IdealQuotients.quotientMatrix_squared_norm_le:214` as lower inputs. This audit reconstructs those finite mechanisms and their immediate specialization to actual quadratic rows. It does not repeat the outer sharp-sieve iteration, radial separation or lattice summation.

For finite row, left-column and right-column types m,n,p, let L_j,R_k be nonzero ideals, with norms at most N1,N2 respectively, where N1,N2>=0. The generic theorem allows arbitrary matrices A_D:m by n and B_E:m by p, arbitrary complex coefficient vectors a,b, and finite ideal sets S,T. Assume squared Euclidean operator norms satisfy ||A_D||op^2<=UA for D in S and ||B_E||op^2<=UB for E in T, with UA,UB>=0. The vectors a,b are fixed across the divisor blocks; the matrices may depend on their respective divisor.

The actual nonnegative block is

`H(D,E)=sum_i |sum_(j,k) 1_(coprime(L_j,R_k))`
`  * conjugate(A_D(i,j)*1_(D|L_j)*a_j)`
`  * B_E(i,k)*1_(E|R_k)*b_k|`.

For eps>0 write S_eps=`supportConstant eps` and D_eps=`divisorConstant eps`. The precise conclusion is

`(sum_(D in S,E in T) H(D,E))^2`
` <= #S #T UA UB (S_eps*N1^eps)(S_eps*N2^eps)`
`       * (D_eps*N1^eps*sum_j|a_j|^2)`
`       * (D_eps*N2^eps*sum_k|b_k|^2)`.

No injectivity, squarefreeness or character property is required for these generic ideal columns. Their indexed multiplicities remain in the vectors and matrices. The canonical specialization adds injectivity and admissibility below. The two kinds of arithmetic loss are distinct and both are paid.

## 2. Finite inclusion–exclusion, without an ambient-support loss

`CrossSeparation.lean:493–525` proves the finite identity

`1_(S disjoint T)=sum_(U subset S intersection T) (-1)^#U`.

It is the expansion of the product of 1-1 over the intersection, including the empty intersection. The finite ambient support B merely permits a common index set U subset B; terms outside the intersection are zero.

`CoprimeBilinearBound.lean:76–117` inserts this into the actual bilinear sum and factors its two coefficient sums. For fixed U, let a_U,j=1_(U subset support(L_j))*a_j and b_U,k analogously. Triangle inequality followed by Cauchy–Schwarz on the finite product index (U,i) gives

`(sum_i |coprime bilinear sum_i|)^2`
` <= (sum_U ||A a_U||_2^2)(sum_U ||B b_U||_2^2)`.

There is no additional factor 2^#B: the Cauchy factors retain their actual masked energies. `CrossFactorization.masked_coefficient_energy:446–460` exchanges finite sums and counts precisely the subsets of each individual column support. Thus

`sum_U ||a_U||_2^2=sum_j 2^(#support(L_j))*|a_j|^2`.

The same holds on the right. `FiniteOperator.energy_bound:178–184` is the ordinary Euclidean operator inequality, derived from `||Ax||<=||A||op||x||` and `EuclideanSpace.norm_sq_eq`. It is not a sieve estimate or an entrywise supremum norm. Together these prove `coprime_bilinear_operator_bound:119–172`.

For nonzero ideals, `CrossFactorization.primeSupport_disjoint_iff:527–543` identifies absence of a common prime factor with ideal coprimality through ideal gcd/unique factorization. Repeated prime factors cause no problem because the support is a set. The actual ambient set is the union of the two finite families' prime supports. The norm bound on each column gives `2^omega(I)<=S_eps*norm(I)^eps<=S_eps*N_i^eps`, yielding the ideal form at `CoprimeBilinearBound:195–228`.

The support bound is elementary and uniform in the ideal. `Arithmetic/SquarefreeDivisors.lean:83–125` splits its prime support into finitely many ideals of norm below a fixed cutoff and the complement. Each large prime pays its factor two through norm(P)^eps; the product of those distinct primes divides I. Small primes contribute at most 2^(number of small ideals). This uses ideal norm finiteness, factorization and norm multiplicativity, not PNT or a sieve exponent.

## 3. Divisor masks and the second Cauchy inequality

`divisor_mask_energy:237–251` exchanges finite sums to obtain

`sum_(D in S) sum_j |1_(D|L_j)*a_j|^2`
` <= sum_j d(L_j)*|a_j|^2`.

For each j, the relevant part of S is a subset of the actual finite set of divisors of the nonzero ideal L_j. It is not estimated by #S at this step. The full divisor small-power theorem supplies the bound with D_eps*N1^eps. Its elementary finite-prime proof at `FiniteOperator:281–409` has also appeared in earlier audits: normalized-factor multisets inject the divisors into products of exponent ranges; e+1 is bounded by a geometric norm factor, with a fixed constant at finitely many small prime ideals. I read the body here to confirm that this is the same unconditional bound, rather than the sharp sieve output.

Apply the ideal coprime operator inequality separately to the masked vectors for every D,E. It bounds H(D,E)^2 by

`UA UB (S_eps*N1^eps)(S_eps*N2^eps) EL(D) ER(E)`,

where EL and ER are the masked coefficient energies. `rectangular_cauchy:276–298` applies finite Cauchy to the outer rectangle S times T, giving exactly #S #T times the sum of these squared bounds. The separated energy sum factors as `(sum_D EL(D))*(sum_E ER(E))`. Substituting the two divisor-energy bounds proves the target at lines319–376. All replacements multiply nonnegative quantities. No orthogonality of blocks, cancellation of positive terms or division by an energy is assumed.

## 4. The quotient matrices are actual contractive restrictions

`FiniteSieveRestriction` at `CoprimeBilinearBound:385–474` constructs extension by zero along a map injective on the selected columns. Its squared Euclidean norm is exactly the selected coefficient energy, hence at most the full input energy. Multiplication by the selected matrix equals multiplication of the ambient matrix by this extension. Thus masked column restriction is contractive. Row restriction follows by conjugate transpose and the equality of an operator norm with its adjoint norm; combining them gives submatrix restriction. These are finite Hilbert-space facts, with the OAI realization inspected, not an appeal to an unproved sieve bound.

The canonical matrix at `CoprimeBilinearBound:522–621` uses actual ideals: rows and columns range over admissible ideals of norm at most the stated bound; entry (I,J) is `quadraticRow J (primaryGenerator I)`. Admissibility means nonzero, squarefree, and the specified bad-prime/characteristic-two exclusions. `sieveNorm` is the squared operator norm of this finite matrix. Injective row and column families give an actual submatrix. No reciprocity or dimension reversal is used in this restriction.

`IdealQuotients.lean:152–209` defines a chosen quotient only on D|I and proves D*(I/D)=I. For fixed D, equality of two quotient values implies equality of the original ideals by multiplying by D. Thus the quotient map is injective on divisible columns; there is no fiber multiplicity loss. A quotient of an admissible ideal is admissible. For D nonzero, norm multiplicativity and norm(D)>0 give `norm(I/D)<=N/norm(D)`.

`quotientMatrix` is zero on nondivisible columns. Lines214–249 restrict to the finite divisible-column subtype, apply the preceding actual family bound, and compare its coefficient energy to the full one. The result is

`||quotientMatrix(D)||op^2 <= sieveNorm(M,N/norm(D))`.

This bound does not require N/norm(D)>=1: an empty admissible range is allowed. It retains the original coprimality indicator on L_j,R_k in the subsequent bilinear block. It does not silently replace that indicator by one on their quotients.

## 5. Exact dyadic cost and original-row consumption

`DivisorBlocks.canonical_divisor_block_bound:84–143` assumes D1,D2,N>=1; S and T lie in the closed norm windows [D1,2D1] and [D2,2D2]; row/left/right families are separately injective and admissible, with row norm<=M and both column norms<=N. No extra M>=1 is needed by this finite statement. The quotient bound and monotonicity of the actual finite matrix ranges give UA=sieveNorm(M,N/D1), UB=sieveNorm(M,N/D2).

The immediate count adapter `Mellin/InverseContour.finite_ideal_count_real:306–318` includes S in `idealsUpTo floor(H)` and uses the previously available bound 64*(floor(H)+1)<=128H for H>=1. With H=2D_i this gives #S<=256D1 and #T<=256D2. Therefore the squared block bound is exactly

`256^2 D1 D2 sieveNorm(M,N/D1) sieveNorm(M,N/D2)`
` * (S_eps*D_eps)^2 * (N^eps)^4 * ||a||_2^2 * ||b||_2^2`.

Its square root has factor256, one product S_eps*D_eps, and N^(2eps). The later radial/middle argument was already reviewed; this note does not charge those factors again or replace the symbolic sieve norms by a sharp estimate.

For the original-row version, `DivisorBlocks:147–284` factors an admissible column's actual quadratic row into its divisor and quotient rows. Squarefreeness makes the prime supports disjoint; multiplication of their finite character products gives the identity. The remaining row-dependent scalar is `conjugate(q_D(z))*q_E(z)`. Its norm is at most one, including zero values, so removing it is a valid upper bound. No reciprocal, unit assumption or reciprocity constant is involved. This supplies `canonical_original_divisor_block_bound:265` from the quotient result.

## 6. Domains and remaining boundary

Empty finite sets, empty row or column types, zero coefficients and unit ideals are included. The generic theorem permits zero in a divisor pool because it divides no nonzero column and the corresponding masked energy vanishes. The canonical positive norm windows exclude that case. If a canonical divisor window lies beyond all column norms, the relevant matrix is zero rather than requiring an unjustified lower-scale theorem. Negative or zero epsilon is excluded. Nonzero columns, norm-domain assumptions, injectivity in the canonical adapter and its admissibility conditions must be retained.

This reconstructs the finite lower producer left by the middle-frequency packet. It neither proves a sharp bound for sieveNorm nor uses `HasSieveExponent`; no sharp result is fed into its own input. Ordinary finite Cauchy, Euclidean norm/adjoint facts, finite sums, ideal factorization/norm finiteness and the existing ideal-count bound remain the library/arithmetic boundary. The immediate actual-row multiplication/norm adapters were read; the underlying local sextic-character construction belongs to its separate reviewed packet. General Fourier, radial and infinite-lattice estimates are not required by this finite argument.

Compatible dependency versions, elaboration and transitive axioms remain unchecked. This advances one OAI producer boundary, not the entire quadratic sieve, QRH provider or finite spectral/Goldbach proof.

## Frozen evidence

Hashes bind full files, while the ranges above delimit inspection. The unrelated initial-sieve and later analytic declarations in those files are not claimed audited here.

| Source relative to B | SHA256 |
|---|---|
| QuadraticSieve/CoprimeBilinearBound.lean | `FCB07617E92E671559105F156013B13ECCDC2B1F9E72AE05203680462A353D10` |
| QuadraticSieve/IdealQuotients.lean | `3961EF95BA392A9352CADD3A9EC9C3336081BDC468B89A14FB099D00FD64D499` |
| QuadraticSieve/DivisorBlocks.lean | `41458D0EB675CCBDCC9F9FAD95AFEE7AF76ED46C16FD719DC658921EFDCF837D` |
| QuadraticSieve/FiniteOperator.lean | `4A8A56A5AC5A218C00616F40749B33A1942DC65F579BB6DF216F039EC2BA32BF` |
| QuadraticSieve/CrossSeparation.lean | `95D1DF46A455A7257986EBDFE8420809B40E69CF8B1171667FBD27F645E2550E` |
| CubicSieve/CrossFactorization.lean | `FBF22E8AF7E34C1AB76CDAB3101CAACF1ED7BA1A766CE476D9F0B34841399933` |
| Arithmetic/SquarefreeDivisors.lean | `7EC9C941095748C47D3B2D871D10F48C6840BEC6B1A0EC242BC931C7688FA3AB` |
| Mellin/InverseContour.lean | `07583B9AD1732A76889CA43FA78BDD98E902E0B41612F68D6CFB5ED4C5166D20` |

Prior reports were checked for overlapping scope before choosing this task. Paths below are relative to `work/qrh-campaign/agents`.

| Supporting report | SHA256 |
|---|---|
| major-constants/QRH_QUADRATIC_PRODUCT_COLUMN_AUDIT_2026-11-11.md | `9E4A104441FA0B154132CF3F1AAE9E560EBD34EC368BB77484EAB38F3EEF758B` |
| independent-feasibility/REVIEW_QRH_QUADRATIC_PRODUCT_COLUMN_AUDIT_2026-11-11.md | `31B94E3645296163679C9B7D820AE0E0D3EFEC7BDEBC48F743382CFA5EDCFFE9` |
| prime-estimates/QRH_INITIAL_CUBIC_SIEVE_AUDIT_2026-11-11.md | `169F69528A8D47F61E0EBE4340456ED8521EA2BDF7F2495EB7F0551B35C1636A` |
| independent-feasibility/REVIEW_QRH_INITIAL_CUBIC_SIEVE_AUDIT_2026-11-11.md | `FD2CF5675DE5B544E370447912C57DEB576B22AAB11A9D3ADF1AF8166AC83229` |
| integration/QRH_MIDDLE_FREQUENCY_ANALYTIC_AUDIT_2026-11-11.md | `1B4B178F58A8DE23573F978D0C302F2AD2D02FEC5D31474BD9DE81B264F1348B` |
| moebius/REVIEW_QRH_MIDDLE_FREQUENCY_ANALYTIC_AUDIT_2026-11-11.md | `8BA08F7386784679576438526E5E321E3F2A1444CB797CD6F0EB7002E8B78579` |
