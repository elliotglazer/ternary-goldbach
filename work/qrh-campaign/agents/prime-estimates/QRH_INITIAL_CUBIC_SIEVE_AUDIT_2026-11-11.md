# Initial cubic sieve and its convergence input

2026-11-11. Bounded source and mathematical audit, prepared for independent review. No local mathematical defect was found. The initial bound follows from the actual cubic character Gram matrix, trace Poisson and normalized finite Gauss transform, elementary scaled lattice bounds, and a finite ideal count. Its proof does not consume a later improved cubic exponent or the final QRH conclusion. The lower trace-Poisson and finite-character foundations remain explicit below; this is not a complete provider or kernel validation.

All OAI paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, revision `4eaee87548250b2682affda7d05d947c05554bae`. No Lean/Lake command, analytic evaluation, spectral scan, declaration, source mutation or dependency change was performed.

## 1. Exact target and finite matrix

`CubicSieve/Initial.lean:300`, `ideal_initial_cubic_sieve`, takes a finite family F of nonzero squarefree ideals, all of whose prime factors avoid goodLambda, a natural N>=1 with Norm(I)<=N for I in F, a real M>=1, arbitrary complex coefficients a, and a finite set R of Eisenstein elements satisfying |z|^2<=M. It proves

    sum_(z in R) |sum_(I in F) a(I) * idealSexticRow(I,z)^2|^2
      <= C0*(M+N^2)*sum_(I in F)|a(I)|^2.

Here C0 is the fixed positive real number

    diagonalControl(sieveCutoff) + 128*pvControl(sieveCutoff) + 1.

It is independent of F,N,M,R,a. The constant is defined through fixed Schwartz seminorms; this audit neither evaluates it nor asserts an effective runtime for its construction. The finite theorem allows zero in R and the unit ideal as a column. The empty-support column contributes to the diagonal rather than being dropped by the off-diagonal zero-frequency argument. Its character and prime conditions are not replaced by an arbitrary family of bounded functions.

`CubicSieve/Ideal.lean:14,131–153` defines admissibility as squarefree with nonzero primary generator, `idealRange(X)` as the admissible ideals of norm at most X, and the matrix with row I, column J equal to the embedded cubic symbol of J at the primary generator of I. `CubicSieve/Operator.lean:12–19` defines the operator between finite Euclidean spaces and its squared operator norm. `Norm.lean:20` identifies the actual embedded ideal symbol with `idealSexticRow^2`, using squarefree factorization and the canonical row identity.

`Norm.lean:35` injects row ideals into their primary generators and applies the finite theorem with natural bound ceil(N). `FullNorm.lean:99` applies the same theorem directly to all nonzero element rows in `elementRange(M)`. Consequently both norms satisfy

    norm(M,N) <= C0*(M+ceil(N)^2),       M,N>=1.

Neither adapter asserts equality of the two row carriers. The energy-to-operator lemma at `QuadraticSieve/CoprimeBilinearBound.lean:480` proves the operator bound by taking sqrt(C), applying the defining norm inequality to every vector, and squaring. It handles zero vectors and empty index types without division by their energy.

## 2. The cubic pair and the off-diagonal bound

`Initial.lean:13–69` defines the cubic row as the square of the finite sextic row. In a conjugate pair from supports S,T, common primes give the coprimality mask. The symmetric difference gives exponents 4 on S\T and 2 on T\S. Thus

    conjugate(cubicRow(S,z))*cubicRow(T,z)
      = commonMask(S intersection T,z)*activeSexticRow(z).

`Poisson.lean:305–326` proves both exponent choices nonprincipal. If chi is the square of the sextic character, chi is the actual nontrivial cubic character and chi^3=1. Therefore chi^2 cannot be principal either. This does not borrow the quadratic exponent-3 nonprincipal assertion or impose the quadratic proof's odd-characteristic hypothesis. The cubic theorem retains its own actual good-prime hypotheses.

When S differs from T the active support is nonempty. `Poisson.lean:14–212` transports the finite CRT Gauss identity to the actual principal quotient and trace additive character, then applies `actual_radial_paper_poisson_trace`. With q=|finitePrimeModulus(active)|>0 and t=M/q^2>0, the normalized identity has prefactor M*G/q, where |G|=1, and dual sum

    sum_h conjugate(activeSexticRow(h))*paperRadialFourier(W,t*|h|^2).

The source obtains |G|=1 from the exact finite Gauss squared norm, primitive trace character and quotient cardinality q^2. It does not assume a numerical Gauss bound. The row vanishes at h=0 because the active support is nonempty. Its norm elsewhere is at most one. The uniform lattice estimate in Section 3 then bounds t times the norm of the dual sum by pvControl(W). Multiplying by M/q=q*t proves the smoothed Polya–Vinogradov bound pvControl(W)*q, uniformly for every M>0.

`PrimeRows/IdealGenerators.lean:136–217` supplies the common-mask inclusion-exclusion identity. It keeps the Mobius factor, row value at the subset generator, and reduced positive scale M/|generator|^2. The two coefficient factors have norm at most one. Summing the same bound over all subsets of S intersection T costs exactly 2^|S intersection T|. No disjointness of the two original supports is presumed.

The apparent divisor loss is paid exactly. `QuadraticSieve/InitialBound.lean:145–185` uses Norm(P)>=2 and the support-product identity to give

    2^|S intersection T| <= Norm(common),
    q^2*Norm(common)^2 = Norm(S)*Norm(T) <= N^2.

All factors are nonnegative, so 2^|S intersection T|*q<=N. Hence every off-diagonal Gram entry has norm at most pvControl(W)*N. This argument does not use a divisor small-power estimate, a cubic exponent, or a zero-free region.

## 3. Uniform lattice estimate below the PV wrapper

The scale-uniform fact used above is not left as an assumed cancellation estimate. `GaussSum/MixedConversion.lean:521–738` proves it from ordinary summable positive kernels.

Write Q(m,n)=m^2-m*n+n^2=|eisEmbedding(eval(m,n))|^2. Then Q>=(m^2+n^2)/2. `Poisson/RadialFourier.lean:461` proves

    (1+K*Q)^(-2)
      <= 4/((1+K*m^2)*(1+K*n^2)),       K>0.

For b>0 the function (1+(b*x)^2)^(-1) is decreasing on x>=0. Its integral over the positive half-line is pi/(2b). Integral comparison, followed by the exact positive/negative integer split, gives

    sum_(n in Z) (1+(b*n)^2)^(-1) <= 1+pi/b.

The source proves summability before multiplying or rearranging these sums. With b=sqrt(K), the two-dimensional positive product therefore yields

    sum_h (1+K*|h|^2)^(-2) <= 4*(1+pi/sqrt(K))^2.

For 0<K<=1, multiplying by K bounds the right side by 4*(1+pi)^2. For K>=1 and h nonzero, the actual norm is a positive integer, so |h|^2>=1, and the source proves

    K*(1+K*|h|^2)^(-2) <= 4*(1+|h|^2)^(-2).

The last kernel has finite total mass E, by the same coordinate product comparison. Thus any profile with (1+x)^2*|F(x)|<=B for x>=0 satisfies

    K*sum_(h nonzero)|F(K*|h|^2)|
      <= [4*(1+pi)^2+4*E]*B,          K>0.

The exclusion of zero in the large-scale branch is essential. This is exactly why the nonempty active support was proved before applying the estimate.

For the actual profile, `RadialFourier.lean:70–174` defines the continuous linear radial pullback W(z)=W(|z|^2), followed by the Schwartz Fourier transform. It relates the paper-normalized radial Fourier value to the plane transform with factor 2/sqrt(3) at a frequency of squared norm 4x/3. A plane Schwartz seminorm of order 4 bounds (1+x)^2 times this value. Continuity of the composite map, via `Seminorm.bound_of_continuous`, bounds that output seminorm by a constant times a finite supremum of source seminorms. Both the finite index set and the constant are chosen before W and K.

`paperRadialFourier_nonzero_lattice_uniform:723` combines those facts. `QuadraticSieve/CoefficientCancellation.lean:547–567` then chooses this index set and constant once to define pvControl. The dependence on W remains explicit and is harmless after choosing the one fixed sieve cutoff. This is a qualitative continuous-seminorm construction, not a computed universal number.

## 4. Diagonal, smoothing, and finite ideal count

The diagonal uses only |row|<=1. `InitialBound.lean:200–240` defines

    diagonalControl(W)=16*(1+pi)^2*sup_(indices <= (2,0)) seminorm(W)

and proves sum_z |W(|z|^2/M)|<=diagonalControl(W)*M for M>=1. Its proof applies the source Schwartz order-2 decay and the small-scale lattice estimate at K=1/M. No cancellation is used on the diagonal.

The Gram expansion in `Initial.lean:148–261` proves absolute summability first. A finite pair expansion and finite-sum/tsum interchange give the exact double coefficient sum. The diagonal plus off-diagonal bounds imply

    |smoothed energy|
      <= D*sum|a|^2+B*(sum|a|)^2
      <= [D+B*card(F)]*sum|a|^2,

where D=diagonalControl(W)*M and B=pvControl(W)*N. Injectivity of the support map is necessary to apply the off-diagonal estimate whenever the two coefficient indices differ. The source supplies this using squarefree ideal factorization.

The fixed cutoff is the ordinary smooth bump with inner radius 1 and outer radius 2 at zero, viewed as a complex Schwartz function. It is real and nonnegative and equals one on [0,1]. Therefore its smoothed square energy dominates the arbitrary finite row sum on |z|^2<=M. This comparison does not hold for arbitrary complex W; `Initial.lean:263–298` specializes to the cutoff before using positivity.

`Hecke/FiniteEulerFactors.lean:430` bounds the number of ideals of norm at most N by 64*(N+1). It injects each ideal into its chosen generator, whose span recovers the ideal. `Arithmetic/LatticeCount.lean:20–88` uses Q(m,n)<=N to bound both coordinate squares by 2N, counts an integer square of radius floor(sqrt(2N))+1, and obtains 64*(N+1). With N>=1 this is at most 128N. Hence B*card(F)<=128*pvControl(W)*N^2. The fixed C0 above absorbs this and the diagonal term, with an added 1 to guarantee strict positivity. This is a finite coordinate count, not a prime or ideal asymptotic.

## 5. Two different convergence checks and the initial exponent

The smoothed pair sums and the later dyadic majorant have separate justifications.

For each positive scale, `Initial.lean:108–120` dominates the pair by the sampled Schwartz radial test. `Poisson/EisensteinLattice.lean:271–291` pulls the lattice back by an actual invertible affine coordinate map. `GaussSum/SecondPoissonScale.lean:704–733,742–765,866–875` proves plane lattice summability from the ordinary integer inverse-square series and a product of two Cauchy weights. The dual radial Fourier lattice series is likewise summable by `RadialFourier.lean:477–542`. These facts precede every finite/infinite interchange or removal of the zero term in the argument above.

`Growth.lean:14` now derives HasCubicExponent(2). Since ceil(N)<=2N for N>=1, and (MN)^epsilon>=1 for epsilon>0 and M,N>=1, it can take the constant 4*C0 before M,N. This is the starting exponent, not a call to the improvement step.

`Majorant.lean:17–57` works for M>0 and N>=1. Set c=M/N^2>0, K=2^j, and Q=ceil(N)^2. The element-row initial estimate gives

    elementSieveNorm(K,N) <= C0*(1+Q)*K,
    frequencyMajorant(M,N,j)
      <= C0*(1+Q)/c^3 * (1/4)^j.

It uses (1+cK)^3>=(cK)^3 and K>=1. The geometric series converges, so the majorant is summable. M need not be at least one here; only the row argument K of the initial theorem does. The constant may blow up as M tends to zero; no uniform convergence across that limit is claimed. This proof is independent of all new exponent estimates and is sufficient for the later recurrence's convergence prerequisite.

## 6. Circularity check and remaining foundations

A read-only traversal of the local OAI import headers starting at Initial, Growth and Majorant found 317 modules and no missing local file. It did not reach modules named FullImprovement, AnnularImprovement, B2Growth, ExponentImprovement, Sharp, HeathBrownIteration or Nonvanishing. `Foundation.lean` is a broad earlier import bundle, so this header check is not a claim that all its theorems were audited. The substantive proof bodies read here use the finite character, Schwartz, lattice and ideal-count inputs just described. Neither the starting exponent nor the geometric convergence argument appeals to the later improvement or final QRH theorem.

The exact remaining mathematical boundaries are:

* `GaussSum/SexticRadialPoisson.lean:499`, the original trace-normalized radial Poisson identity, including its Fourier measure and trace-frequency normalization. Its input/output and the cancellation of q^2 against the Gauss magnitude were checked here. Its full analytic proof remains a separate audit.
* The primitive trace character, the finite CRT scalar Gauss transform and exact Gauss squared norm, and the canonical nontrivial cubic character. Their actual use and domains were checked in `CubicSieve/Poisson`; this report does not reprove all finite-field and trace constructions.
* The underlying ideal factorization, quotient norm, chosen/primary generator and coordinate equivalences. The subset-product recovery, norm losses and finite coordinate-count proof were inspected. Foundational ring/ideal theorems remain imported.
* General Schwartz Fourier continuity, the finite-seminorm criterion, inverse-square series, integral comparison, and the Cauchy integral. The source assembly below the PV wrapper was inspected; the full general library proofs were not independently audited or compiled.

These are internal source dependencies, not proposed assumptions for a final Goldbach theorem. The result advances the initial-sieve and convergence audit below their wrappers while preserving the separate foundational and kernel-validation obligations.

## Source pins

Hashes bind whole files. Read scopes are the declarations and ranges stated above, not every unrelated theorem in each file.

| Relative source | SHA256 |
|---|---|
| CubicSieve/Initial.lean | D76A296A7D19D528C0EBBC93BD6D8ABA750F17201A538ECA808923172509DCD0 |
| CubicSieve/Poisson.lean | 2A10C842C07951230927A3D046BD65C2A71F9F739A1401BC74B20CACA16669CF |
| CubicSieve/Growth.lean | 7CAA9B7C0DB9D5B4641F2734A2827835FAD00CC234632157A4376A56B127B255 |
| CubicSieve/Majorant.lean | 8A5D7BCB90FB88AAB40F8C0BD77DB52E53945C2C99D152F320E56378B42A0524 |
| CubicSieve/Norm.lean | 86B9D61D5B79DDF34720290C6190BE60E9DC1488D33E08ED130A0CCD2BF37F96 |
| CubicSieve/FullNorm.lean | C0A607BD90640D0DFBC22A05D30F9D15D642529198858D44F1BF4DA3C5013885 |
| CubicSieve/Ideal.lean | 9C988E8D755DE2EBDF17818E14C8E2B52BE6B4D90B5924D1159DDC5729F793CA |
| CubicSieve/Operator.lean | F8E07582787BDCBB7B9FE69682C10F4A3A953608E0F985F1E8BA63AA8C5AF4F6 |
| QuadraticSieve/InitialBound.lean | 5D3A030862AAE4997A9D8E13D51FBDBDEE1C41EC1AEC4D23BE49D8B183F7ABC4 |
| QuadraticSieve/CoefficientCancellation.lean | EB0C36E8DA5C04048719CD0C1D0806BD987F19D88FA3B6389EE63A5C8E74A3F0 |
| QuadraticSieve/CoprimeBilinearBound.lean | FCB07617E92E671559105F156013B13ECCDC2B1F9E72AE05203680462A353D10 |
| GaussSum/MixedConversion.lean | 90817AFABD6E351DFCBB0488DE0635A86B227A746CF693BAB5B2BFC7CB030FD3 |
| Poisson/RadialFourier.lean | 86D5DEB861723EBF182C8A8489EFD29320F97049F4CCB471684C827F931C8E58 |
| Poisson/EisensteinLattice.lean | CC52C9B695ECEC6ECD54AD79C8870CD36A53E99D94BF6B3D5F3A04093DC99D69 |
| GaussSum/SecondPoissonScale.lean | 60105F7CBAACC19CEC0704164673538A6924E7201F224C321580179FF88FD31A |
| GaussSum/SexticRadialPoisson.lean | 8DB6F0F3B850868F18706630A4F8F1DA42A345D2F0D32949B8D4CC6CB0F5D21C |
| PrimeRows/IdealGenerators.lean | FFD100322A61D78A44F28CE7EDEA6E7CC756D7055C5710B42809B1B2AA016949 |
| GaussSum/ActiveConductor.lean | 6D162A236C09692CA2FD918947412C0AE89A1D0D7D621DDCEC72AB0BBC399DC6 |
| Hecke/FiniteEulerFactors.lean | 4F65030622460B1636D6F66C43FB8175E8EF3244502BDBA48C3AAFACB2452716 |
| Arithmetic/LatticeCount.lean | AD7A616017D5EFD2D01A5F38C49C86EAF2F081A0E74CFA17196E5A8010BFD69F |
| Poisson/BinaryGaussian.lean | 3EDDA524FAFF311FFF2CF441771167BC8F06834270FB64D76A241D785C3E6A4E |
| Foundation.lean | 249FA9EA64A67F8B2ACF4D721639EF4C93EBCC2552EEE4B6A13580A953F815B5 |
