# Bounded audit of the cubic exponent improvement

Date: 2026-11-11. Baseline: `work/openai-math` commit
`4eaee87548250b2682affda7d05d947c05554bae`.
Source paths below are relative to `lean/OAI/NumberTheory/DirichletL/` in that repository.

## Finding

The inspected proof of `HasCubicExponent.full_improved` contains a substantive argument. It converts the old squarefree-ideal exponent into a bound for all nonzero element rows by cube extraction. Pair Poisson summation and a separated radial kernel then turn that bound into a new asymmetric power estimate. The proof pays the common-divisor costs and the column-shell cost explicitly.

I found no local mathematical defect in the inspected argument. In particular, it keeps the unit-column zero-frequency term, proves frequency-sum convergence from the initial bound, and uses only the old exponent in the improvement step. This does not validate the global QRH provider. Underlying Poisson, Gauss-sum, Fourier-separation, initial-sieve and arithmetic estimates remain explicit audit boundaries in Section 8. No Lean build, declaration, source edit, analytic evaluation or prime computation was performed.

The preceding short-energy report remains immutable. Its independent review records the agreed descriptive correction: the local reflection cost splits according to `P` dividing the original ideal `I`, not the residual ideal. This new report does not alter that packet.

## 1. Exact input and output

`CubicSieve/Growth.lean:9` defines `HasCubicExponent xi` as

```
for every epsilon>0, there is C>0 such that, for all M,N>=1,
sieveNorm M N <= C*(M*N)^epsilon * (M+N^xi+(M*N)^(2/3)).
```

`CubicSieve/Ideal.lean:14,131–153` uses admissible ideals, meaning squarefree ideals with nonzero primary generator. The matrix entry is the actual cubic symbol evaluated at the primary generator of the row ideal, embedded in the complex numbers. `sieveNorm` is its squared finite operator norm. `FullNorm.lean:11–28` instead uses every nonzero Eisenstein element whose principal-ideal norm is at most `M`; its matrix entry is `cubicRow J z`. This defines `elementSieveNorm`. The exact row function is `eisEmbedding (CubicJacobiGlobal.idealSymbol I z)`, at `Gcd.lean:13`.

`FullImprovement.lean:48` assumes the old property, `4/3<=xi<=2`, and `0<theta<1/2`. It concludes

```
there is C>0 such that, for all M,N>=1,
elementSieveNorm M N <= C*N^(7*theta)
  * (M+(M*N)^(2/3)+M^(1-xi)*N^(2*xi-1)).
```

The constant is selected before `M,N`, all finite families, coefficients and row sets used to prove the operator estimate. It may depend on `xi`, `theta`, and the constant supplied by the old exponent property. The underlying field is the fixed Eisenstein field; there is no claim here of uniformity across number fields. Norm bounds cover all the specified finite ideals/elements, not a sampled family. There is no hypothesis about zeros of a Dirichlet L-function in this statement or the inspected analytic reductions.

## 2. Cube extraction gives the old-exponent element bound

The conversion from squarefree-ideal rows to element rows is essential. It is not the assertion that the two operator norms coincide.

`Elements.lean:26` expands the element character at `a*b^2*d`. Multiplicativity and the exact identity `idealKernel^2=star idealKernel` give a product of a kernel in the first ideal, a conjugate kernel in the second, and a coefficient of norm at most one. The finite block estimate can therefore use either first-ideal or second-ideal rows. It takes the minimum of the two resulting operator bounds.

`FullExtraction.lean:24` covers each original nonzero element using its first, second and cube ideal parts, its unit, and the two subsets of the fixed bad primes. The covering is not assumed injective. The energy is nonnegative, so extending to all reconstructed tuples is legitimate. The exact count of the extra factors is `6*4*4=96`, times the number of cube ideals. `ExtractionBounds.lean:23` bounds the first, second and cube ideal counts by `128` times their norm caps. This yields

```
energy <= 96*128^2*H
  * min(Y*sieveNorm X N, X*sieveNorm Y N) * coefficient_energy.
```

For a dyadic block, the caps become `2X,2Y` and
`H=(M/(X*Y^2))^(1/3)`, where `X,Y>=1` and `X*Y^2<=M`. The constant becomes `192*128^2`. `Dyadic.lean:112` selects a maximal nonempty extraction block and pays at most `(columnDyadicLength M+1)^2`. For the full element ball, `1` supplies a nonempty row set when `M>=1`. Empty coefficient spaces still have zero energy, so no positive coefficient norm is divided out.

`ExtractionOptimization.lean` then proves the decisive elementary optimization. Under the old bound, the shape to control is

```
(M/(X*Y^2))^(1/3)
 * min(Y*(X^xi+N+(X*N)^(2/3)),
       X*(Y^xi+N+(Y*N)^(2/3))).
```

If `Y<=X`, select the first expression; otherwise select the second. In the selected expression write the outside multiplicity as `W` and the varying norm as `U`. Both cases satisfy `W^2*U<=X*Y^2` and `W^3<=X*Y^2`. Thus `W*U^a<=(X*Y^2)^a` for `a>=1/2`, and the cube-scale factor converts that to at most `M^a`. The three terms are bounded by `M^xi`, `M^(1/3)*N`, and `(MN)^(2/3)`. Finally
`(MN)^(2/3)<=M^(1/3)*N+M^xi` for `xi>=4/3`, by splitting `M<=N` versus `N<=M`.

Consequently `B2Growth.lean:11,73` proves

```
elementSieveNorm K N <= A_delta*(K*N)^delta
  * (N*K^(1/3)+K^xi),      K,N>=1.
```

Its logarithmic loss is explicit. Apply the old exponent at `delta/2`; bound the square of the dyadic length using the small-power estimate at `delta/4`; then `K^(delta/2)<=(KN)^(delta/2)`. The constant before this absorption is `384*128^2`. This part uses the old exponent only and precedes the new Poisson estimate.

## 3. Actual pair Poisson and radial-kernel transfer

`Smoothed.lean:29` defines a smoothed **coprime pair** sum. It is not necessarily a nonnegative expression, so later steps take its complex norm. `PairPoisson.lean:65` applies the actual trace-normalized lattice Poisson formula to a coprime pair of admissible ideals `I,J`. The result has prefactor

```
M * star(gaussTwo I) * gaussTwo J / sqrt(norm(I)*norm(J)),
```

and dual kernel argument `M*norm(span{h})/(norm(I)*norm(J))`. The dual symbols have the reversed conjugation, `cubicRow I h * star(cubicRow J h)`. Its body identifies the principal finite row with `star(cubicRow I)*cubicRow J`, transports the quotient, applies the finite Gauss transform, and cancels precisely one square-root modulus factor against the Poisson determinant. This checks the normalization at the application layer. The underlying trace-Poisson and local Gauss theorems are not independently proved in this audit.

`DualCoefficients.lean:13` defines the dual coefficient as
`star(a_j*gaussTwo J_j)/sqrt(norm J_j)`. Its squared norm is exactly
`|a_j|^2/norm J_j`. For the column annulus `N/2<=norm J_j<=N`, the total dual coefficient energy is at most `(2/N)*sum |a_j|^2`. The Gram rewriting explicitly swaps the two finite indices to get the correct conjugation.

The radial kernel depends on both column norms. It cannot be replaced by a scalar bound without a cost. `KernelTransfer.lean:13` uses the generic `radial_matrix_kernel_transfer` at `QuadraticSieve/DivisorBlocks.lean:455`. The underlying representation on bounded logarithmic windows is

```
F_W(R*exp(x+y)) = integral logPhase(t,x)*logPhase(t,y)*b_R(t) dt,
(1+R)^A * integral |b_R(t)| dt <= C.
```

I inspected the generic integration proof at lines 389–502. Each finite integrand is measurable and dominated by the integrable Schwartz density times a fixed coefficient norm. The finite sum of integral norms is bounded by `H*integral|b_R|`. The constant precedes `R` and the finite matrices. The proof consumes `paperRadialFourier_log_separation_envelope`; that analytic envelope remains an explicit cut.

For the cubic application, the phase in the two column coordinates is handled by twisting `a_j` with the conjugate log phase and `b_j` with the log phase. Both coefficient energies are unchanged. The coprime bilinear operator estimate gives a bound for the square of the rowwise norm sum. Nonnegativity permits taking the square-root inequality; no division by a potentially zero energy occurs. The result is bounded by
`elementSieveNorm K N * supportConstant(epsilon)*N^epsilon * E`.

`FrequencyShell.lean:44` takes row logarithm `log(norm(h)/K)` and column logarithm `log(N/norm J)`. Each lies in the bounded window of size 4. With `R=M*K/N^2`, their exact exponential product gives the desired pair kernel argument. `DualShell.lean:24` then yields decay `(1+M*K/N^2)^(-A)` with the correct `(2/N)` coefficient-energy factor.

## 4. Zero frequency and convergence are not omitted

The version used is `Recurrence.lean:60`, `cubic_smoothed_frequency_recurrence_all`. It allows the unit ideal among the columns. Injectivity permits at most one such column. `ZeroMode.lean:15` shows every other column vanishes at the zero row, and bounds the remaining unit contribution by
`(2/N)*sum|a_j|^2*|F_W(0)|`.

For nonzero dual rows, the disjoint dyadic frequency shells cover the actual lattice. `Smoothed.lean:15,40,70` proves absolute summability from the radial Fourier lattice bound and the norm-one symbol bound before interchanging the finite column sums with the infinite lattice sum.

`Majorant.lean:9` sets

```
frequencyMajorant(M,N,j)
 = elementSieveNorm(2^j,N)/(1+M*2^j/N^2)^3.
```

Its summability proof uses the **initial** estimate
`elementSieveNorm K N <= C0*(K+ceil(N)^2)`. For fixed positive `M,N`, the majorant is bounded by a constant times `(1/4)^j`. It does not assume the improved bound to establish convergence. The recurrence therefore gives the full frequency cost

```
frequencyCost = (2M/N) * [ |F_W(0)|
  + C_W*supportConstant(epsilon)*N^epsilon
      * sum_j frequencyMajorant(M,N,j) ].
```

The constant `C_W>=0` is chosen before epsilon, scales and finite family. This includes the zero-frequency term even for the unit-only family.

## 5. Computing the new powers from the frequency sum

I read the full `CubicDyadicDecay.lean` argument. For `t>0` and `0<alpha<3`, it proves

```
sum_{j>=0} (2^j)^alpha/(1+t*2^j)^3 <= D(alpha)*t^(-alpha),
D(alpha) = 2^alpha/(2^alpha-1) + 1/(1-2^(alpha-3)).
```

For `t>=1`, use the cubic denominator and a convergent geometric tail. For `t<1`, choose a dyadic point between `1/t` and `2/t`. Bound the lower part by the geometric prefix with ratio `2^alpha` and the upper part by ratio `2^(alpha-3)`. Both series have explicitly positive denominators. These arguments cover all positive `t`, including very small descendant row scales.

Insert the old-exponent element bound from Section 2, with `delta=theta`, and set `t=M/N^2`. The two exponents are `alpha=1/3+theta` and `beta=xi+theta`; `4/3<=xi<=2` and `0<theta<1/2` put both strictly between 0 and 3. `CubicDyadicDecay.lean:189–244` checks the scale identity

```
N^theta*(M/N)*(M/N^2)^(-(b+theta))
 = N^(3theta)*M^(-theta)*M^(1-b)*N^(2b-1).
```

For `b=1/3`, the extra coefficient `N` from the old element bound turns the result into `(MN)^(2/3)`. For `b=xi`, it gives the new term `M^(1-xi)*N^(2xi-1)`. This is the actual source of the improved asymmetric power, not an algebraic restatement of the target.

## 6. Common factors, descendant scales and seven theta losses

The original square has non-coprime column pairs. `CompactDescent.lean:114` first dominates the finite row energy by the nonnegative compact radial majorant. It expands exact gcd blocks, applies the finite Möbius identity, and then uses the triangle inequality and `|mu|<=1`. It does **not** assert positivity of each Möbius or coprime pair term. The row scaling is `M/norm(E)` and column scaling `N/norm(D)`, for `E|D`. `QuotientColumns.lean` restricts to supported coefficients and proves quotient-column injectivity, admissibility and annular bounds.

Put `e=norm(E)`, `d=norm(D)`. The proof has `1<=e<=d<=N`, so `N/d>=1` while `M/e` need only be positive. The frequency-cost theorem was deliberately proved on that larger row-scale domain. In particular, one cannot simply drop `(M/e)^(-theta)` by assuming `M/e>=1`.

Instead `CubicDyadicDecay.lean:248–331` compares whole monomials. For the mixed term their powers are
`u=2/3-theta`, `v=2/3+3theta`; for the asymmetric term they are
`u=1-xi-theta`, `v=2xi-1+3theta`. In both cases `v>=0` and `u+v>=0`. Thus
`(M/e)^u*(N/d)^v <= M^u*N^v` follows from `e<=d`, even when `u<0`. The zero-frequency descendant factor satisfies `(M/e)*2/(N/d)<=2M`. This preserves every negative exponent in the comparison.

At the original scales `M,N>=1`, `M^(-theta)<=1`. The decay and coprime-support factors cost `N^(3theta+theta)=N^(4theta)`. `DescentEnergy.lean:21` bounds the summed descendant coefficient energies by
`(divisorConstant(theta)*N^theta)^2*sum |a_j|^2`. One divisor bound pays for the choices of `E|D`; the other pays for the column divisor masks. Thus `AnnularImprovement.lean:14` has loss `N^(6theta)`.

Finally `FullImprovement.lean:48` partitions columns with the deterministic dyadic labels from `ColumnShells.lean`. Cauchy across the shells costs one dyadic length, not its square. For any nonempty shell its upper scale `Y` satisfies `Y<=2N`; empty shells contribute zero and require no witness. Replacing `Y` by `2N` costs at most 8 in the shape and at most 8 in `Y^(6theta)`, since `2xi-1<=3` and `6theta<3`. The dyadic length is at most
`[2+1/(theta*log 2)]*N^theta`.
The final constant is `64*K*[2+1/(theta*log 2)]`, and the total loss is exactly `N^(7theta)`.

## 7. Why the iteration is not circular in the inspected argument

`ExponentImprovement.lean:77` chooses `theta=min(epsilon/14,1/4)` and uses the new full-element estimate at
`T=max(M,N^a)`, where `a=(6xi-5)/(3xi-1)`. Monotonicity first gives
`sieveNorm(M,N)<=sieveNorm(T,N)<=elementSieveNorm(T,N)`.

Writing `b=(6xi-4)/(3xi-1)`, the exact identities are
`(a+1)*2/3=b` and `a*(1-xi)+2xi-1=b`. The negative exponent `1-xi` reverses the comparison in the correct direction, so the last asymmetric term is at most `N^b`. Also `a<=b`. The enlarged shape is at most
`3*(M+N^b+(MN)^(2/3))`, and `N^(7theta)<=(MN)^epsilon`. This proves the exponent step from the old property.

`HeathBrownIteration.lean:14–87` gives
`step(x)-4/3 = 2*(x-4/3)/(3x-1)` and contraction at most `2/3` for `x>=4/3`. Starting at 2, a finite number of steps places the exponent within any requested positive error of `4/3`; `Sharp.lean` absorbs that error into epsilon. It does not require a uniform constant as the iteration count tends to infinity. Each finite call uses constants from the previous exponent.

The starting statement `Growth.lean:14` comes from the initial sieve, not this iteration. The inspected coefficient extraction, Poisson cost, descendant comparison and finite iteration do not call the eventual QRH theorem or a previously improved exponent. This is a local source-reasoning conclusion, not a transitive compiled-axiom or dependency certification.

## 8. Remaining exact audit boundaries

The following inputs still need separate substantive audits before this argument can contribute to a complete provider validation.

| Input | Exact source boundary and what was checked here |
|---|---|
| Trace-normalized lattice Poisson | `GaussSum/SexticRadialPoisson.lean:499`, `actual_radial_paper_poisson_trace`. Its application and prefactor cancellation in `PairPoisson:65` were checked; its analytic proof was not. |
| Finite Gauss transform and pair separation | `PairPoisson:57,65` calls the canonical principal Gauss transform and `cubicPairGauss_separation`; `DualCoefficients:17` uses `gaussTwo_norm_one`. The induced characters, conjugations and norm factors were checked at these calls. Underlying local/CRT identities remain unvalidated here. |
| Uniform radial Fourier separation | `QuadraticSieve/IdealQuotients.lean:415`, `paperRadialFourier_log_separation_envelope`. The full integration/phase-transfer argument in `DivisorBlocks:389–502` was checked, but not the analytic construction and weighted L1 bound of that envelope. |
| Initial sieve and Fourier lattice summability | `CubicSieve/Initial.lean:300`, `ideal_initial_cubic_sieve`, and the radial Fourier lattice-summability theorem consumed at `Smoothed:15`. The finite operator adapters and how convergence is used were inspected. Their deeper analytic proofs were not. |
| Arithmetic/divisor operator facts | The finite cubic factorization, bad-prime separation and norm counts used in extraction; ideal divisor small-power and coprime bilinear operator estimates used in `DescentEnergy` and `FullNorm`. Their explicit losses and correct inputs were followed. A complete proof of each foundation was outside this bounded audit. |

The new progress is a checked mathematical reconstruction of `full_improved` below its wrapper, through finite extraction, actual dual coefficients, kernel transfer, convergent dyadic summation, common-factor descent and exponent iteration. It does not close the listed foundational inputs, and it does not change any selected spectral premise or final strategy.

## Source SHA-256 pins

This table pins the inspected files and named boundary files. It is not a claim that every line of every boundary file was audited. Read scopes are specified above.

| Source | SHA-256 |
|---|---|
| `CubicSieve/FullImprovement.lean` | `917501B7005D3BE61C668BAB919265AD061F2EF305E42CC5BAFA21CBA7DB84CA` |
| `CubicSieve/AnnularImprovement.lean` | `04BAF1E2C8AC9B3477323758336F2C2252C539D6F1FD0478073490A8CE10EBF7` |
| `CubicSieve/CostGrowth.lean` | `6E3E957D4D03A743A73F3187D4F70E0EA8390A9053C1F8EE7BBBEBAEEB7272E8` |
| `CubicSieve/DescendantBounds.lean` | `8EB2CC225B8DA9248C85E9B6CB8AEF2A972F6BAA60D8440078D2BD770EF2827D` |
| `CubicSieve/B2Growth.lean` | `B82B26F65FCB310FE28B181D268B55FA8016ACF82C756F31833322E31C57F80A` |
| `CubicSieve/Growth.lean` | `7CAA9B7C0DB9D5B4641F2734A2827835FAD00CC234632157A4376A56B127B255` |
| `CubicSieve/ExtractionOptimization.lean` | `E330E8579ABCF887B9FCC0474945FB17FA3325476B13CC9E2202BEF0A42F5CB7` |
| `CubicSieve/FullNorm.lean` | `C0A607BD90640D0DFBC22A05D30F9D15D642529198858D44F1BF4DA3C5013885` |
| `CubicSieve/Ideal.lean` | `9C988E8D755DE2EBDF17818E14C8E2B52BE6B4D90B5924D1159DDC5729F793CA` |
| `CubicSieve/Norm.lean` | `86B9D61D5B79DDF34720290C6190BE60E9DC1488D33E08ED130A0CCD2BF37F96` |
| `CubicSieve/Initial.lean` | `D76A296A7D19D528C0EBBC93BD6D8ABA750F17201A538ECA808923172509DCD0` |
| `CubicSieve/FullExtraction.lean` | `90E840FB16DEBFABC6BA7F15A5F85C9CFBEAD866D9B90A0DDEDDB8D2EF06ECFD` |
| `CubicSieve/ExtractionBounds.lean` | `EF9A309B626D7A8E2908A3154AE23F1D8134509D728C4767732C54794F86FF21` |
| `CubicSieve/Dyadic.lean` | `E8075469559A3AEA40B6BCA76E8AD08EB9F6095370C3E71C58A2585E1C488147` |
| `CubicSieve/Elements.lean` | `09CBAA493BAAEBC188174EBE373F29E0EEE51E8AC8F7E8BD12AD4D9B9A8A82DF` |
| `CubicSieve/Extraction.lean` | `3309EB87CC03F29F5FC21D0A403458F1C34977AB90A25C51A49CBA81B1268C8F` |
| `CubicSieve/CommonFactorBound.lean` | `6D39A6115EFC27E12054D21E5605BE8040A3A7A0A217774D1725CF2B9210C08E` |
| `CubicSieve/QuotientColumns.lean` | `FF2AB83441E0D01BFC2D24A2A07B6FA93FA025C8D7CB752A8C22DF065B8F7ED7` |
| `CubicSieve/CompactDescent.lean` | `653B753BEEF481A9385F1621370856844A47EDE88A52A48B16A5308330484774` |
| `CubicSieve/DescentEnergy.lean` | `EC7A0AA65141FA68F977D8E25C761F6E986F7C7CB23A075940D04EB3136344CE` |
| `CubicSieve/Mobius.lean` | `ACA1A7FFDF4D98EC4D69DB5DFE21B779D52F62C015E0E40C1CB08108479F5FAF` |
| `CubicSieve/Gcd.lean` | `C887EC26ABC6AED7617B00021CA5240D7F069B740FDC5920706467409B644E6F` |
| `CubicSieve/Recurrence.lean` | `3A80D157EE281F0F3D210989147D9CCC786AB2A3E87D97A6AC99ADB8AFC61C16` |
| `CubicSieve/Majorant.lean` | `8A5D7BCB90FB88AAB40F8C0BD77DB52E53945C2C99D152F320E56378B42A0524` |
| `CubicSieve/Smoothed.lean` | `E25174BBACD12E434D271F5804D60547B9D38DC0E6E7BB0C1153EFF8F2AF6367` |
| `CubicSieve/ZeroMode.lean` | `72B5C5B16C6E2A2D24732938D54CEB82B3D766A0C453DADDB4D058CB26C84867` |
| `CubicSieve/DualShell.lean` | `B56F5B18187F48E689D114AE59734E059038A265226A6C6130FD32366286296E` |
| `CubicSieve/DualCoefficients.lean` | `3DE901BC4AFE6734B667A4AA61AFD23B5DB63ACABFD76D0966A16E7B3C44A841` |
| `CubicSieve/FrequencyShell.lean` | `C51D11D79F8F2712B55D1D8C8E1BA8D4690664D1CA901C890D6A887BA87756C0` |
| `CubicSieve/KernelTransfer.lean` | `EC7D03C219A67D0108D10DC69C1FE1BB7537F15ED78C29AF3E4D13D9C4F97944` |
| `CubicSieve/PairPoisson.lean` | `EC25A59907C03B82CBCA9B21195CEEE14CB7B42D76C467997725344F9D2C6F62` |
| `CubicSieve/PairPrimes.lean` | `A51D8E6B99E701AF4EFDE0333E87B74F4EC40F25007335C0ACF50039FE2F4141` |
| `CubicSieve/ColumnShells.lean` | `4B54043137F6997F5893703079BDFB423D90EBB1A5E86A5356D0DD6D5B0FC654` |
| `CubicSieve/ExponentImprovement.lean` | `5225C2910E2CC4F464D65CBA0101D6C4B4D099ABA0338929DE4D6C204AAECFAD` |
| `CubicSieve/Sharp.lean` | `2EA22192D557C6D359EA6E5AF91C1DE03E6B91759FA4DB971AF3EE5D6D68F3FA` |
| `CubicDyadicDecay.lean` | `B20A5E11C9CBD22276C9005A8C80A10F5E32C2C4F7C5AD027FDA608C3CBDD473` |
| `HeathBrownIteration.lean` | `C8BC47D96E0F239032D361E92BCCA4D8C75DE718ECBA309C21513C277B223EFA` |
| `QuadraticSieve/DivisorBlocks.lean` | `41458D0EB675CCBDCC9F9FAD95AFEE7AF76ED46C16FD719DC658921EFDCF837D` |
| `QuadraticSieve/IdealQuotients.lean` | `3961EF95BA392A9352CADD3A9EC9C3336081BDC468B89A14FB099D00FD64D499` |
| `GaussSum/SexticRadialPoisson.lean` | `8DB6F0F3B850868F18706630A4F8F1DA42A345D2F0D32949B8D4CC6CB0F5D21C` |
