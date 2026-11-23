# Independent review of the initial cubic sieve

2026-11-11. Verdict: **PASS for the bounded source and mathematical audit below.** No correction to the frozen author report is required. The inspected proof gives the initial finite cubic energy bound and the stated convergence input without using the later improved cubic exponent. This does not validate the complete QRH provider, every imported theorem, or an elaborated proof.

Author report: `../prime-estimates/QRH_INITIAL_CUBIC_SIEVE_AUDIT_2026-11-11.md`, SHA256 `169F69528A8D47F61E0EBE4340456ED8521EA2BDF7F2495EB7F0551B35C1636A`. I read the complete frozen report and independently compared all 22 source hashes in its manifest with the current files. All match. Its source baseline is `work/openai-math`, revision `4eaee87548250b2682affda7d05d947c05554bae`; the byte hashes bind this review more precisely than that baseline label. All source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`.

This review used source reads and hashing only. No Lean/Lake command, evaluator, spectral calculation, source modification, or new assumption was used. The author report and prior reports remain unchanged. Whole-file hashes identify the files; they do not mean every declaration in those files was audited.

## 1. Actual target and normalization

`CubicSieve/Initial.lean:300` takes a finite set F of nonzero squarefree ideals whose prime factors avoid goodLambda, a natural N>=1 with absNorm(I)<=N, arbitrary complex coefficients a, a real M>=1, and an arbitrary finite set R of Eisenstein elements with |z|^2<=M. Its conclusion is

    sum_(z in R) |sum_(I in F) a(I)*idealSexticRow(F,I,z)^2|^2
      <= C0*(M+N^2)*sum_(I in F)|a(I)|^2,

where the single fixed positive constant is

    C0 = diagonalControl(sieveCutoff) + 128*pvControl(sieveCutoff) + 1.

It is chosen independently of F, N, M, R and a. There is no normalization by the cardinality of either finite set, by conductor, or by coefficient energy. Empty sets and zero coefficients do not require separate nonzero-energy assumptions. R may contain zero. F may contain the unit ideal, whose empty prime support is handled by the same diagonal argument.

`CubicSieve/Ideal.lean:14,16,131,150,153` defines the actual admissibility, kernel and matrix. Admissibility is squarefreeness together with nonzero primary generator. The matrix entry with row I and column J is the embedded cubic ideal symbol of J evaluated at the primary generator of I. `CubicSieve/Operator.lean:12,19` defines the usual map between finite complex Euclidean spaces and its squared operator norm. The analogous definitions in `QuadraticSieve/FiniteOperator.lean:77` have the same body. The bound-to-operator theorem at `QuadraticSieve/CoprimeBilinearBound.lean:480` applies the all-vector energy bound, obtains operator norm at most sqrt(C), then squares. It does not discard zero vectors or divide by their norm.

`CubicSieve/Norm.lean:20` identifies the embedded cubic ideal symbol with the square of the actual ideal sextic row. This consumes squarefree factorization and canonical local row identities. `Norm.lean:35` then injects row ideals into their chosen primary generators; equality of generators gives equality of their principal ideals. Thus no multiplicity is silently lost by `Finset.image`. `FullNorm.lean:11,26,29,99` instead uses all distinct nonzero element rows in the norm ball. It does not identify associates, claim equality of the two carriers, or add an unproved factor of six. Both adapters give

    norm(M,N) <= C0*(M+ceil(N)^2),  M,N>=1.

## 2. Cubic cancellation and the zero mode

I read the complete finite-pair mechanism in `Initial.lean:13-145` and the nontrivial-character Poisson/PV mechanism in `CubicSieve/Poisson.lean:12-329`.

The conjugate pair of cubic rows is exactly the common coprimality mask times a sextic row on the symmetric difference of supports. Its exponents are 4 on S minus T and 2 on T minus S. Squaring the sextic pair identity produces this formula because the common mask is idempotent and exponent 10 reduces to exponent 4 modulo 6. These are identities for the actual multiplicative characters, including their zero values at nonunits.

For either exponent, the local character is nonprincipal: the square of the sextic character is the actual nontrivial cubic character chi, with chi^3=1; chi^2=1 would force chi=1. This establishes the hypotheses of the new nontrivial-character PV lemma. It does not import the quadratic exponent-3 assertion or its additional residue-characteristic-two exclusion.

For S!=T, the symmetric difference is nonempty. Let c be its actual modulus generator, q=|c|>0 and t=M/q^2>0. The inspected Poisson adapter gives a dual sum with prefactor M*G/q, where the canonical normalized Gauss factor has |G|=1. The latter follows from the exact finite CRT squared Gauss norm, primitivity of the actual trace character, and cardinality of the quotient equal to q^2. Thus this proof uses q, not q^2, after Gauss normalization.

The dual row vanishes at zero because its support is nonempty. Absolute summability is established before dropping that term. The uniform estimate

    t*sum_(h!=0) |paperRadialFourier(W,t*|h|^2)| <= pvControl(W)

then gives a bound pvControl(W)*q for the original smoothed row at every M>0. This zero-mode removal is only used off the diagonal. On the diagonal, the proof retains the full lattice sum, including zero. In particular, the empty support and unit column do not invalidate the argument.

The common mask is removed by the exact subset dilation formula in `PrimeRows/IdealGenerators.lean:133-217`. Each term retains its ideal Mobius coefficient, its row value at the subset generator, and its reduced positive scale M/|generator|^2. The first two factors have norm at most one. The same PV bound applies at every reduced scale, giving the factor 2^|S intersection T|.

`QuadraticSieve/InitialBound.lean:145-185` pays this factor without a divisor asymptotic. Each prime ideal has norm at least two and

    q^2*Norm(common)^2 = Norm(S)*Norm(T) <= N^2.

Since 2^|common|<=Norm(common) and all factors are nonnegative, the off-diagonal Gram entry is at most pvControl(W)*N. No pairwise coprimality of the two original supports is presumed; only the actual distinct-prime construction is used for the active CRT modulus.

## 3. The lattice estimate is an inspected analytic step

The PV estimate is not accepted here merely because its theorem is named. I checked its lower source bound in `GaussSum/MixedConversion.lean:521-738` and `Poisson/RadialFourier.lean:70-174,461-542`.

For Eisenstein coordinates, Q(m,n)=m^2-m*n+n^2 is at least (m^2+n^2)/2. The source bounds the inverse-square radial kernel by four times the product of the corresponding one-dimensional Cauchy weights. The positive-half-line integral pi/(2b), monotone sum/integral comparison, and positive/negative integer split give

    sum_(n in Z) 1/(1+(b*n)^2) <= 1+pi/b,  b>0.

Summability is proved before the product and sum rearrangements. Consequently

    sum_h (1+K*|h|^2)^(-2) <= 4*(1+pi/sqrt(K))^2.

For 0<K<=1, multiplication by K gives at most 4*(1+pi)^2. For K>=1, a nonzero Eisenstein element has |h|^2>=1 by the positive integral ideal norm. The source then proves

    K/(1+K*|h|^2)^2 <= 4/(1+|h|^2)^2.

The latter kernel is summable by the same coordinate comparison. These two regimes prove the uniform nonzero-lattice bound for any profile satisfying (1+x)^2*|F(x)|<=B, with constant [4*(1+pi)^2+4*E]*B and finite E equal to the unscaled lattice Cauchy mass. The large-scale argument genuinely requires removal of zero.

For the actual Fourier profile, the source constructs the continuous linear radial pullback and Schwartz Fourier transform. The paper transform equals 2/sqrt(3) times that plane transform at a frequency with squared norm 4x/3. Schwartz order-4 decay and continuity bound the needed output seminorm by finitely many source seminorms. The finite set and constant are chosen before W and K. This makes `pvControl` uniform in scale and modulus while retaining its explicit dependence on W. No effective numerical value for C0 is asserted.

The diagonal uses the small-scale bound at K=1/M and order-2 decay of W itself, giving `diagonalControl(W)*M`. Its restriction M>=1 is retained. The sampled Schwartz sums used in the pair expansion are justified separately by `Poisson/EisensteinLattice.lean:271-291` and the product-decay proof in `GaussSum/SecondPoissonScale.lean:704-765,866-875`. These are actual affine lattice pullback and summable Cauchy-product arguments. They do not consume a cubic energy bound.

## 4. Finite energy, ideal count and convergence

`Initial.lean:148-261` expands the squared norm into a finite double coefficient sum after proving summability. With D=diagonalControl(W)*M and B=pvControl(W)*N, the estimate is

    D*sum|a|^2+B*(sum|a|)^2
      <= [D+B*card(F)]*sum|a|^2.

Injectivity of the support map on the chosen coefficient set is required and supplied by squarefree ideal factorization. Repeated labels are not quietly treated as distinct supports. Complex coefficients are arbitrary; Cauchy-Schwarz is applied to their norms.

Only after specializing W to the fixed nonnegative bump, equal to one on [0,1], does `Initial.lean:265` compare the infinite smoothed energy to the finite row sum. This step would be invalid for arbitrary complex W, but the source does not make that substitution.

The ideal count at `Hecke/FiniteEulerFactors.lean:430-458` injects ideals into chosen generators. `Arithmetic/LatticeCount.lean:24-88` then bounds their two integer coordinates using Q<=N, encloses them in the square of radius floor(sqrt(2N))+1, and obtains 64*(N+1). For N>=1 this is at most 128N. Thus the off-diagonal total costs 128*pvControl(W)*N^2, exactly what C0 absorbs. This is finite counting, independent of prime distribution.

`CubicSieve/Growth.lean:9-34` takes 4*C0 for the initial exponent 2. The only extra inequalities are ceil(N)<=2N, (MN)^epsilon>=1, and nonnegativity of the additional (MN)^(2/3) term, under M,N>=1 and epsilon>0.

`CubicSieve/Majorant.lean:9-57` proves a distinct convergence fact for M>0, N>=1. Set K=2^j, c=M/N^2 and Q=ceil(N)^2. The full element-row initial bound gives

    elementSieveNorm(K,N) <= C0*(1+Q)*K,
    frequencyMajorant(M,N,j) <= [C0*(1+Q)/c^3]*(1/4)^j.

Here K>=1 permits the initial theorem, while positivity of c permits division. The coefficient is independent of j and finite for each allowed M,N, so ordinary geometric summability applies. M need not be at least one, and the constant may diverge as M tends to zero. This establishes the stated convergence prerequisite without an improved exponent, uniform convergence in M, or an assertion about an unbounded collection of other series.

## 5. Scope of the noncircularity and remaining work

The proof bodies inspected here use finite character identities, the trace Poisson adapter, Schwartz decay, elementary lattice bounds and finite ideal counting. Neither `hasCubicExponent_initial` nor `frequencyMajorant_summable` calls an improved exponent or the QRH conclusion. The author separately reports a 317-module local import-header check. I did not repeat that entire traversal; this review's noncircularity finding is based on the inspected substantive chain, not a claim that all 317 proof bodies have been validated.

The remaining lower cut includes the full original trace-normalized radial Poisson proof at `GaussSum/SexticRadialPoisson.lean:499`; the construction and primitivity of the actual trace character; finite CRT Gauss identities and the canonical nontrivial local cubic character; underlying ring, ideal, generator and coordinate-equivalence facts; and the general library Fourier-continuity, seminorm and integration theorems used above. Their types, consumers and normalizations were checked to the extent described, but their complete foundations were not independently re-proved. The source contains these dependencies; listing them here does not introduce them as assumptions into a proposed Goldbach statement.

The useful next analytic audit is the actual trace Poisson normalization and primitive finite Gauss input. This review closes the bounded initial-sieve and convergence mechanism beneath those inputs. It does not close the whole mathematical dependency graph, produce a successful Lean build, certify an axiom inventory, or prove Goldbach.

## Source evidence

All 22 source hashes in the pinned author report matched independently. The main independently read ranges are listed above. Three additional files were read at the following narrow scopes and hash-checked:

| Source | Read scope | SHA256 |
|---|---|---|
| QuadraticSieve/FiniteOperator.lean | Actual Euclidean operator, lines 73-86 | 4A8A56A5AC5A218C00616F40749B33A1942DC65F579BB6DF216F039EC2BA32BF |
| CubicSieve/Gcd.lean | Actual cubicRow definition, line 13 | C887EC26ABC6AED7617B00021CA5240D7F069B740FDC5920706467409B644E6F |
| CubicSieve/Blocks.lean | Nonnegative squared norm and initial operator consumers, lines 1-35 | 80B9006B2A7E6BC3443B7712E82E99ECE0E576DE9F806C14126292F8D98217B4 |

No numerical test is needed to infer these all-parameter inequalities from the inspected arguments. The evidence is the source reconstruction and exact pin comparison, with the lower analytic cut retained explicitly.
