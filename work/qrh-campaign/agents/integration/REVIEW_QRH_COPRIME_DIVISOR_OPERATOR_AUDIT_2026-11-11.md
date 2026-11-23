# Independent review of the coprime divisor operator

2026-11-11. **PASS at the bounded source and mathematical scope below.** No correction to the frozen author report is required. No Lean/Lake build, evaluator, source modification, or numerical experiment was performed. This review concerns the finite operator producer and its immediate ideal-quotient application, not the outer sieve induction or the full QRH provider.

Reviewed author: `work/qrh-campaign/agents/audit/QRH_COPRIME_DIVISOR_OPERATOR_AUDIT_2026-11-11.md`, SHA256 `686CA3A8438D8468758EC5B917258CF8E8557C5080FD97E8059129F0B8D79B4B`. I read the complete frozen report and independently checked all eight source pins and six supporting-report pins against the current bytes; all fourteen match. The independent reconstruction agrees with its stated domains, factors and lower boundaries.

Source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, revision `4eaee87548250b2682affda7d05d947c05554bae`. The prior initial-cubic audit and its independent review were consulted to avoid treating the finite operator norm infrastructure as a fresh sharp sieve estimate. The remaining-obligations inventory was also read; its historical B2 analytic requirements are separate from this finite argument.

## 1. Actual finite carriers and inclusion-exclusion

I read `QuadraticSieve/CoprimeBilinearBound.lean:82–495,522–621`, including the entire `divisor_block_bound:319` proof. Matrices are actual maps between finite complex Euclidean spaces, with operator as defined in `FiniteOperator.lean:77`. `energy_bound:178` follows directly by squaring the operator norm inequality; it does not divide by coefficient energy. The matrix need not satisfy a desired sharp bound to exist.

For prime-support sets L_j,R_k in a finite ambient set B, `CrossSeparation.lean:493–525` gives

    1_(L_j disjoint R_k) = sum_(D subset L_j intersect R_k) (-1)^|D|.

The sum is exactly (1-1)^|L_j intersect R_k|. The ambient powerset is reduced to the intersection powerset before this identity is used. The empty intersection contributes 1. `disjoint_bilinear_expansion` preserves the complex conjugation on the left coefficient and introduces no positivity assumption on those coefficients.

After triangle inequality, Cauchy-Schwarz is applied over the finite product of D and the row index. For each D the matrix energy estimate applies to the masked coefficient vector. `CubicSieve/CrossFactorization.lean:446–460` then counts the masks exactly:

    sum_(D subset B) sum_j |1_(D subset L_j) a_j|^2
       = sum_j 2^|L_j| |a_j|^2.

Thus the bilinear bound has one support factor on each side, with no unrecorded |B.powerset| or row-cardinality loss. The construction is valid for empty finite types and zero coefficient vectors.

`CrossFactorization.lean:527–554` identifies disjoint prime support with ideal coprimality for nonzero ideals. `Arithmetic/SquarefreeDivisors.lean:83–125` proves the uniform support subpower bound by a globally finite small-norm set and 2<=Norm(P)^epsilon outside that set. It is not a squarefree restriction on the generic column ideals. The resulting constant depends on epsilon before any matrix, finite support, column norm cap, or coefficients.

## 2. The divisor loss is distinct and both sides are charged

`CoprimeBilinearBound.lean:238–274` counts, for each nonzero column ideal I, the selected divisors D actually dividing I. This count is at most the cardinality of idealDivisors(I), regardless of the size of the selected divisor set. It is separate from 2^|primeSupport(I)|.

I read the divisor subpower proof in `FiniteOperator.lean:281–409`: normalized-factor multisets inject the divisors into all multiplicity choices; the cardinal bound is product_P(e_P+1). On the finite small-norm prime set, e+1 is bounded by a fixed constant times Norm(P)^(epsilon e); on the remaining primes, e+1<=2^e and Norm(P)^epsilon>=2. The product reconstructs Norm(I)^epsilon. This handles nonsquarefree ideals and repeated prime factors rather than replacing divisor count by support count.

Writing Cs,Cd for the support and divisor constants, the generic squared block sum is bounded by

    |S| |T| UA UB (Cs N1^epsilon)(Cs N2^epsilon)
      (Cd N1^epsilon sum_j |a_j|^2)
      (Cd N2^epsilon sum_k |b_k|^2).

Here UA,UB are explicit uniform bounds on the squared norms of the divisor-indexed matrices. The proof first bounds each block, then uses rectangular Cauchy with the visible |S||T| factor, then sums the two masked energies. For N1=N2=N this is N^(4epsilon) on the squared inequality. It would be incorrect to report only one of the two support or divisor costs. No sharp numerical value is assigned to UA or UB at this stage.

## 3. Quotient columns are restricted injectively, not identified by fiat

I read `IdealQuotients.lean:152–249` and the finite restriction proofs in `CoprimeBilinearBound.lean:375–473`. On the divisible set, D*idealQuotient(D,I)=I. Hence equal quotients imply equal original columns, even though no global injectivity is claimed off that set. Nonzero D is required when dividing the norm cap. Admissibility passes to ideal divisors, including the unit ideal; the quotient norm is at most N/Norm(D).

Zero extension along an injective map preserves exactly the energy of the selected coefficient vector. Its norm is at most the full vector norm. This proves masked column restriction; row restriction follows through conjugate transpose. Consequently the quotient family is a submatrix of the canonical actual matrix at the smaller column cap. The off-divisibility entries are zero and are handled by the explicit selected subtype, not by giving an arbitrary quotient value mathematical significance.

The canonical row is the cube of the actual ideal sextic row on admissible ideals. Ambient prime-pool independence is proved by product reindexing. `sieveNorm(M,N)` is exactly the squared operator norm of this matrix on idealRange(M) by idealRange(N). Its monotonicity is proved by injective row/column restriction, not assumed from an asymptotic formula. The unit ideal remains an admissible column; no nonprincipal-character assertion is needed for this finite matrix estimate.

## 4. Actual divisor blocks and the remaining symbolic norm

`DivisorBlocks.lean:84–145` uses Norm(D) in [D1,2D1] and Norm(E) in [D2,2D2], with D1,D2,N>=1. This proves D,E nonzero. Quotient restriction and monotonicity give UA=sieveNorm(M,N/D1), UB=sieveNorm(M,N/D2). `Mellin/InverseContour.lean:306–318` gives |S|<=128*(2D1), |T|<=128*(2D2) using the finite ideal count. Its immediate floor/ceiling adapter was read; the underlying lattice/ideal count remains a lower input, already covered at the relevant bounded scope in earlier audits.

The result is exactly

    (sum_(D in S,E in T) quotientBlock(D,E))^2
      <= 256^2 D1 D2 sieveNorm(M,N/D1) sieveNorm(M,N/D2)
           (Cs Cd)^2 (N^epsilon)^4 (sum |a|^2)(sum |b|^2).

`DivisorBlocks.lean:149–284` restores original columns using quadraticRow(I)=quadraticRow(D)*quadraticRow(I/D) for admissible I and D|I. Squarefreeness of the product supplies disjoint factor supports. The extracted two row multipliers have norms at most 1, so the original block is bounded by the quotient block. The indicator **IsCoprime(original left, original right)** survives this step unchanged. It is not replaced by coprimality of the quotients, which is not an equivalent test in general.

All source hypotheses concerning finite injective row/column labels, admissibility, nonzero ideals and norm intervals remain present. No HasSieveExponent, beta estimate, QRH assertion, or desired sharp output enters these bodies. The conclusion is a finite transfer inequality involving the symbolic actual sieveNorm values. Later reverse/old-exponent and analytic kernel arguments still have to bound those values and connect them to the required principal/middle estimates.

## 5. Scope and pins

The finite inclusion-exclusion, two support losses, two divisor losses, exact quotient restriction, original coprime indicator, and normalization above were independently reconstructed from source. Generic Hilbert-space inequalities, ideal factorization APIs, finite ideal-count foundations, and canonical local character-row definitions remain imported lower foundations. No complete B2 analytic closure, kernel validity, axiom inventory, or performance claim follows from this review.

The ledger below pins the eight independently inspected source files. Whole-file hashes do not claim inspection of every unrelated declaration in those files. The author report supplies the six supporting-report hashes, all independently reconciled above.

| Source relative to B | SHA256 |
|---|---|
| `QuadraticSieve/CoprimeBilinearBound.lean` | `FCB07617E92E671559105F156013B13ECCDC2B1F9E72AE05203680462A353D10` |
| `QuadraticSieve/IdealQuotients.lean` | `3961EF95BA392A9352CADD3A9EC9C3336081BDC468B89A14FB099D00FD64D499` |
| `QuadraticSieve/DivisorBlocks.lean` | `41458D0EB675CCBDCC9F9FAD95AFEE7AF76ED46C16FD719DC658921EFDCF837D` |
| `QuadraticSieve/FiniteOperator.lean` | `4A8A56A5AC5A218C00616F40749B33A1942DC65F579BB6DF216F039EC2BA32BF` |
| `QuadraticSieve/CrossSeparation.lean` | `95D1DF46A455A7257986EBDFE8420809B40E69CF8B1171667FBD27F645E2550E` |
| `CubicSieve/CrossFactorization.lean` | `FBF22E8AF7E34C1AB76CDAB3101CAACF1ED7BA1A766CE476D9F0B34841399933` |
| `Arithmetic/SquarefreeDivisors.lean` | `7EC9C941095748C47D3B2D871D10F48C6840BEC6B1A0EC242BC931C7688FA3AB` |
| `Mellin/InverseContour.lean` | `07583B9AD1732A76889CA43FA78BDD98E902E0B41612F68D6CFB5ED4C5166D20` |
