# Actual quadratic middle-frequency estimates

2026-11-11. Source baseline: `work/openai-math`, commit `4eaee87548250b2682affda7d05d947c05554bae`. All short source paths below are relative to `lean/OAI/NumberTheory/DirichletL/` in that checkout. This is a bounded reading of mathematical proof bodies. No Lean build, declaration, source edit, analytic evaluation or axiom-closure check was made.

No mathematical defect was found in `Poisson/LatticeEnvelopes.lean:215,277,408,436`. The all-frequency estimates are genuine summability statements, obtained from a scaled nonzero-lattice envelope after separating the actual radial kernel. The block estimates then use the existing exponent witness at smaller column scales. They do not assume the sharp exponent being bootstrapped. The lower boundary is now the finite coprime divisor-block inequality, the positive-log-profile Fourier estimates, and their arithmetic/Schwartz foundations, rather than the four theorem names themselves.

## 1. Objects and uniformity

Let q(h)=||eisEmbedding(h)||^2, b_i=norm(rows_i), d=norm(D), e=norm(E), n_j=norm(left_j), n_k=norm(right_k). All norms of ideals are absolute norms in the fixed Eisenstein ring. The frequency carrier is exactly {h : O // h!=0}. Finite row/left/right index types are arbitrary. Each family is injective and admissible; rows lie in [B/2,B], divisor pools S,T lie respectively in [D1,2D1],[D2,2D2], and D1,D2,B,N>=1. M>0; the dual estimate additionally has F>0.

`QuadraticSieve/DivisorBlocks.lean:616` defines the actual coefficient `originalTerm`: the coprimality indicator for left_j,right_k times

    conjugate(q_left_j(gen rows_i) * 1_{D|left_j} a_j)
      * q_right_k(gen rows_i) * 1_{E|right_k} b_k.

The original `originalMiddleAt` (`LatticeEnvelopes:166`) sums, over D,E,i, the norm of the j,k sum with kernel

    paperRadialFourier(W)(sqrt(M/b_i)*q(h)/(d*e)),

then multiplies that norm by sqrt(M/b_i)/(d*e). The dual `dualMiddleAt` (`:176`) instead uses kernel argument sqrt(F*n_j*n_k/(M*b_i))*q(h)/(d*e) and outside prefactor sqrt((M/F)/b_i)/(d*e). In particular the dual kernel depends on both columns, so pulling it out of their sum would be invalid.

The original theorem only needs n_j,n_k<=N; the dual theorem needs both in [N/2,N]. Coefficients may depend arbitrarily on h, provided their norms are bounded by fixed coefficient vectors a0,b0 at every h. No regularity in h or bounds on the number of frequencies are imposed. W is fixed before the decay constants are chosen. Those constants precede M,F,B,N, all pools and index types, the coefficient families and h. The exponent-dependent constant is chosen from the old `HasSieveExponent alpha` and deltaLoss>0 before these data. The all-frequency theorems themselves need no exponent witness.

## 2. Actual radial separation and finite operator cost

The source does not replace the radial kernel by a pointwise constant inside an oscillatory double sum. `DivisorBlocks:666–710`, `canonical_original_radial_divisor_block_bound`, applies `radial_matrix_kernel_transfer:455–497` to a finite matrix whose row index is (D,E,i) and column index is (j,k). For bounded real x,y it writes

    paperRadialFourier(W)(R exp(x+y))
      = integral_t logPhase(t,x) logPhase(t,y) b_R(t),
    (1+R)^A integral |b_R(t)| <= C,    R>0.

`radial_two_variable_window:410–443` obtains one Schwartz b_R for the entire prescribed rectangle. The selector functions are interval indicators, but they are not differentiated: a separate smooth cutoff is used for the log profile. The constant is chosen before R and before the finite matrix. `radial_phase_integrable:445` proves integrability of each matrix entry against b_R using unit-modulus continuous phases. Finite sums are moved through the integral only after this proof; `sum_norm_integral_bound:392` then bounds the sum of row norms by H times the L1 mass. This costs no matrix cardinality when the uniform phase bound is H.

For the coefficient matrix, `originalTerm_phase:623` puts conjugate(logPhase(t,y_j)) into a_j and logPhase(t,z_k) into b_k. The outer conjugation on the left coefficient yields exactly the **positive** phase logPhase(t,y_j+z_k). Norms of the coefficients are unchanged. `canonical_original_divisor_block_phase_bound:635` follows from the squared block estimate by nonnegativity, not by dropping a square root.

The exact cost (`DivisorBlocks:511`) is

    Bcost = 256^2 D1 D2 sieveNorm(B,N/D1) sieveNorm(B,N/D2)
      * (supportConstant(eps) divisorConstant(eps))^2 N^(4eps)
      * (sum|a|^2)(sum|b|^2).

`canonical_original_divisor_block_bound:265` first factors q_D and q_E from divisible columns and discards only their norm<=1 factors (`:210–262`). Its quotient bound (`:84–143`) uses actual quotient matrices, injective restriction, the coprime divisor-block estimate and at most 128*(2D1),128*(2D2) divisors in the pools. This explains 256^2 D1D2. It does not use an independent sharp quadratic sieve. The deeper finite inequality is `QuadraticSieve/CoprimeBilinearBound.lean:319`, `divisor_block_bound`; quotient matrix restriction is `QuadraticSieve/IdealQuotients.lean:214`. Those are retained lower arithmetic/operator inputs in this audit.

## 3. Logarithmic ratios and the true kernels

For the original kernel set

    R=sqrt(M/B)*q(h)/(D1D2),
    r=sqrt(B/b_i)*(D1/d)*(D2/e).

`QuadraticSieve/PrincipalDifference.lean:180–244` proves 1/4<=r<=2, hence |log r|<=4, and the exact argument identity R exp(log r)=sqrt(M/b_i)q(h)/(de). All factors are positive. `actual_middle_radial_block_bound:246–296` applies the separated bound with log windows (4,0,0). Nonzero h is used to make R>0. Therefore, for any natural A, the unweighted sum of row norms is at most C_W,A sqrt(Bcost)/(1+R)^A.

For the dual kernel, `QuadraticSieve/SpatialDerivatives.lean:77–174` uses

    R=N sqrt(F/(MB))*q(h)/(D1D2),
    x=log r, y=log sqrt(n_j/N), z=log sqrt(n_k/N).

All three absolute log values are <=4 under the dual shell assumptions. The exact square-root identity gives R exp(x+y+z)=sqrt(F*n_j*n_k/(M*b_i))*q(h)/(de). Separation uses windows (4,4,4), with the two column windows combined to 8 in the matrix transfer. This is why the extra dual lower-shell hypotheses matter. No asymptotic replacement of n_j or n_k by N occurs.

`SpatialDerivatives:176–217` proves the outside prefactor bound sqrt(M/b_i)/(de)<=2sqrt(M/B)/(D1D2), and the analogous bound with M/F. This is a pointwise bound on a nonnegative factor outside the norm, so it is legitimate after the kernel estimate. Empty pools and zero coefficient energy remain harmless throughout.

## 4. Genuine all-frequency summation and normalization

Take A=2. Write L=4(1+pi)^2+4*eisensteinCauchyMass. `LatticeEnvelopes:88–126` proves the general implication

    f(h)>=0, (1+t*q(h))^2 f(h)<=C, t>0
      => Summable(f),  t*sum_h f(h)<=L*C.

It first dominates f by a genuinely summable scaled Cauchy lattice sequence. `GaussSum/MixedConversion.lean:643–724` establishes the uniform scaled mass: for t<=1 it compares with the full lattice Cauchy bound; for t>=1 it uses q(h)>=1 on nonzero h and compares t/(1+tq)^2 to 4/(1+q)^2. The zero exclusion is essential to the second regime. These facts reuse the existing lattice/summability foundation; this audit does not re-prove integer-pair Poisson.

For the original estimate t=sqrt(M/B)/(D1D2). Kernel decay and the prefactor give C=2t*C_W*sqrt(Bcost(a0,b0)). After the preceding lemma the factor t cancels, yielding

    sum_{h!=0} originalMiddleAt(h) <= 2L*C_W*sqrt(Bcost(a0,b0)).

For the dual estimate t=N sqrt(F/(MB))/(D1D2), and r=M/(FN). `dual_middle_scale_identity:266` proves sqrt((M/F)/B)=r*N sqrt(F/(MB)), with positivity resolving the square roots. The envelope numerator is consequently 2tr*C'_W*sqrt(Bcost), and only t cancels:

    sum_{h!=0} dualMiddleAt(h) <= 2L*C'_W*(M/(FN))*sqrt(Bcost(a0,b0)).

There is no missing M/(FN) or extra factor N in the dual normalization. The coefficientwise domination in `LatticeEnvelopes:149` is used before summation, so the proof remains valid for arbitrary h-dependent phases or selectors. Both estimates return Summable together with the bound, rather than invoking a default value of tsum. They neither estimate h=0 nor claim cancellation across frequencies: they sum nonnegative norms. Finite retained frequency disks can be dominated later by these sums without further cardinality loss.

## 5. Old exponent witness and the block gates

`CubicSieve/FirstCoreCutoff.lean:583–612` factors sqrt(Bcost) exactly as

    E_eps(a0,b0) * sqrt(D1D2 sieveNorm(B,N/D1) sieveNorm(B,N/D2)),
    E_eps = 256 supportConstant(eps) divisorConstant(eps) N^(2eps)
              sqrt(sum|a0|^2) sqrt(sum|b0|^2).

`HasSieveExponent.divisor_pair:557` uses the old witness's reverse inequality (`:524`, with factor262144 inside its constant). D1,D2<=N ensures N/D1,N/D2>=1. For arbitrary delta>0 this gives a constant C_delta, independent of the pools, with the remaining square root <=C_delta(BN)^delta[N+B^alpha D1D2]. Its elementary two-factor comparison uses D1,D2>=1. There is no assumption alpha>=1/2 at this particular step: the positive-base real powers and old witness suffice.

`LatticeEnvelopes:408–434` applies the original gate D1D2<=U sqrt(M/B), obtaining

    2L*C_W*E_eps*C_delta(BN)^delta
      * [N+U sqrt(M) B^(alpha−1/2)].

The dual gate at `:436–466` is D1D2<=U*N sqrt(F/(MB)). Multiplying the same bracket by M/(FN) gives

    2L*C'_W*E_eps*C_delta(BN)^delta
      * [M/F+U sqrt(M/F) B^(alpha−1/2)].

Both are exact scalar inequalities after positivity checks. The consuming window lemmas pass 2U where required by their support geometry; that is a later factor, not silently included here. An impossible gate with U<=0 has no admissible positive D1D2, and is not needed to establish all-frequency summability.

## 6. Source-profile dependence and remaining boundary

`originalMiddleDecayConstant(W)` and `dualMiddleDecayConstant(W)` (`LatticeEnvelopes:135–146`) select witnesses for A=2 after W is fixed. They are not global constants independent of W. The construction beneath them is explicit about profile control: `IdealQuotients:415` applies the positive-log envelope to paperRadialFourier(W); `Poisson/RadialFourier.lean:394–423` supplies bounds for finitely many Euler derivatives through a finite family of source Schwartz seminorms.

In `IdealQuotients:305–407`, the log cutoff radius is determined by the fixed windows, with Lwin=T+1 and m=exp(-Lwin)>0. A compact smooth cutoff equals one on the required log interval. For each R>0 the Fourier coefficient is the actual transform of V(s)*F(R exp(s)). Derivative bounds use only finitely many derivatives of V and Euler derivatives of F, giving `(B+Bpoint)/m^A` uniformly in R. The profile is Schwartz because of that compact cutoff; its Fourier weighted L1 integrability is proved separately. The sharper positive-log-profile derivative/Fourier estimates and the generic Schwartz inversion theorem are lower inputs, not newly proved here.

This construction explains finite-seminorm dependence of available witnesses. It does **not** by itself state an upper bound on every classical-choice witness named C_W by the wrappers. Any later uniform-W theorem must use an explicit suitable witness or a proved wrapper comparing its selected constant; it cannot substitute a new seminorm inequality by notation. The current fixed-W middle theorems require no such substitution.

The audit therefore closes the immediate middle-kernel separation, logarithmic geometry, nonzero-lattice summation and old-exponent block algebra. Remaining deeper inputs are the finite coprime divisor-block/quotient matrix bounds; the finite source-seminorm Euler control and positive-log Fourier estimates; basic ideal counts/divisor bounds/row factorization; and the already isolated lattice/Schwartz foundations. Neither a new spectral premise nor a proof of the full sharp quadratic sieve or QRH provider is asserted. The prior masked-Poisson audit remains a distinct consuming assembly.

## Pins

SHA-256 values below bind the source reads and the supporting reports. A file pin is not a claim to have audited its unrelated declarations.

| Source | SHA-256 |
|---|---|
| Poisson/LatticeEnvelopes.lean | BF911A0AA1CB1468B57F4DC48ACBEC400EA06C5AD504C95F3B050E577825FC29 |
| QuadraticSieve/SpatialDerivatives.lean | A87D29EA420B6D6A815F0BCA1EF4F2A3FB6098576F8C4746D12D4A506ECA5BFE |
| QuadraticSieve/PrincipalDifference.lean | DB43BA4F8848D4B6792952A9A5E42FB4B35F05DF2E878067C9892F65953ED64B |
| QuadraticSieve/DivisorBlocks.lean | 41458D0EB675CCBDCC9F9FAD95AFEE7AF76ED46C16FD719DC658921EFDCF837D |
| QuadraticSieve/IdealQuotients.lean | 3961EF95BA392A9352CADD3A9EC9C3336081BDC468B89A14FB099D00FD64D499 |
| CubicSieve/FirstCoreCutoff.lean | F7C16F712BC622AE9C048678A4D776EC78C45F6502CFFAF7CD7B36BB20156FB1 |
| Poisson/RadialFourier.lean | 86D5DEB861723EBF182C8A8489EFD29320F97049F4CCB471684C827F931C8E58 |
| Fourier/PositiveLogProfiles.lean | F35DE7EF62C99B19FA5D50501E84AB0CFD751C5318459A78C0A43EE597901E4D |
| GaussSum/MixedConversion.lean | 90817AFABD6E351DFCBB0488DE0635A86B227A746CF693BAB5B2BFC7CB030FD3 |
| QuadraticSieve/CoprimeBilinearBound.lean | FCB07617E92E671559105F156013B13ECCDC2B1F9E72AE05203680462A353D10 |

Supporting reports are relative to work/qrh-campaign/agents.

| Report | SHA-256 |
|---|---|
| integration/QRH_QUADRATIC_MASKED_POISSON_AUDIT_2026-11-11.md | A0F3A9EC4259987A358B6666FD26877F418C67EE1831ED5C7FC8D1A0D509F09D |
| moebius/REVIEW_QRH_QUADRATIC_MASKED_POISSON_AUDIT_2026-11-11.md | D1389E3E2D1D84774B425A57A6AFD429614130C2BB8FE233FEC060CF3885A69C |
| integration/QRH_GLOBAL_TAIL_ANALYTIC_AUDIT_2026-11-11.md | F3DAB6983C136728A4AE0A9467C44397A41F7CA4F476FDB3C16BAA5F5464B0EE |
| moebius/REVIEW_QRH_GLOBAL_TAIL_ANALYTIC_AUDIT_2026-11-11.md | 468EA90C5E52C933700F6E59F1DDB28358B6876D86D6B009103A92E0E6C768CA |
| integration/QRH_ORIGINAL_POISSON_ANALYTIC_AUDIT_2026-11-11.md | DE7237156824F7503A51F36A9E4A777F57647F2FC98F82D624D000E5D5C12AFA |
| moebius/REVIEW_QRH_ORIGINAL_POISSON_ANALYTIC_AUDIT_2026-11-11.md | 9516B5144F691A5D5203C93D737B943E69EFE4A0E4BA4F399A164F833AF75407 |
