# Independent review of the cubic improvement audit

Date: 2026-11-11. Reviewer: independent-feasibility.

## Verdict and scope

PASS for the bounded source and mathematical reconstruction in `major-constants/QRH_CUBIC_IMPROVEMENT_ANALYTIC_AUDIT_2026-11-11.md`, SHA-256 `1727E899339761F828A0D5B56F776884C63E9BB810EF5E0606C9E88E85AC10BD`. I read the complete report, verified its 40 source hashes, and independently reconstructed the main proof below `HasCubicExponent.full_improved`. No correction to this report is required.

The argument derives the new asymmetric term from the old exponent through an element-row bound and weighted Poisson summation. It accounts for the unit zero mode, the common-factor restrictions, negative row-scale powers and all seven theta losses. The review follows the estimates beneath the improvement wrapper and the iteration.

This verdict does not establish every underlying Poisson, Fourier, Gauss, arithmetic or initial-sieve theorem. It does not validate the global QRH provider, a spectral certificate, or the Goldbach theorem. No Lean build, elaboration, axiom print, source change, analytic evaluation or production scan was performed. Hash verification identifies the reviewed bytes; it is not a proof of their correctness.

The previous short-energy report and its original-ideal versus residual-ideal correction remain unchanged.

## 1. Exact objects, hypotheses and quantifiers

All source paths in this review are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, at the stated repository baseline `4eaee87548250b2682affda7d05d947c05554bae`. The per-file hashes below bind the actual bytes inspected. Bare filenames refer to the `CubicSieve/` subdirectory; the two root-level files are explicitly named in the source table.

`Growth.lean:9` defines the old property, for every positive epsilon, by the existence of a positive constant uniform for all real M,N at least one:

```
sieveNorm M N <= C*(MN)^epsilon*(M + N^xi + (MN)^(2/3)).
```

Here `CubicSieve/Ideal.lean:14,131-153` uses squarefree ideals with nonzero primary generator. `Gcd.lean:13` defines `cubicRow I z` as the embedded actual cubic ideal symbol. `FullNorm.lean:11-28` defines the new matrix on all nonzero Eisenstein elements with principal-ideal norm at most M, against the admissible ideal columns of norm at most N. Its norm is a squared finite operator norm. The full-element norm is not identified with the squarefree-ideal norm. The latter is bounded by the former through an injective primary-generator row restriction at `FullNorm:48`.

`FullImprovement.lean:48` assumes the old property, 4/3 <= xi <= 2 and 0 < theta < 1/2. It supplies a positive C before M,N and concludes

```
elementSieveNorm M N <= C*N^(7theta)
  * (M + (MN)^(2/3) + M^(1-xi)*N^(2xi-1)).
```

The preceding annular theorem selects its constant before the finite coefficient type, column family, coefficients and row set. No zero-free strip, rank-induction hypothesis or QRH conclusion occurs in these inspected statements. This is a fixed-field result. It does not assert uniformity over number fields or an explicit numerical constant.

## 2. Independent reconstruction of the old-exponent element bound

`Elements.lean:26` rewrites a row at a*b^2*d using multiplicativity and `idealKernel_square_eq_star`. The two ideal factors give a kernel and a conjugate kernel. The remaining coefficient factor has modulus at most one. Bounding the same finite block in either ideal direction gives a minimum of two operator bounds.

`FullExtraction.lean:24` covers the original nonzero element rows by reconstructed tuples. The map need not be injective: nonnegative squared energies justify enlarging to all tuples. The extra tuple count is six units times two four-element bad-prime subset families times the cube-ideal family. Thus the factor is 96, not an omitted unit factor or an assumed bijection. `ExtractionBounds.lean:23` separately pays the ideal-count bounds, producing 96*128^2*H times the minimum. Dyadic caps 2X,2Y contribute the further factor two.

`Dyadic.lean:112` selects a maximum-energy nonempty extraction block and pays the square of the dyadic label count. The full element ball is nonempty for M >= 1 because it contains 1. The choice can depend on the coefficient vector; this causes no quantifier defect because the following optimization is uniform in all admissible X,Y. The proof does not divide by the coefficient energy, so the zero vector and an empty column space remain covered.

Let T = X*Y^2 <= M, with X,Y >= 1. After the old bound, the expression to control is

```
(M/T)^(1/3) * min(
  Y*(X^xi + N + (XN)^(2/3)),
  X*(Y^xi + N + (YN)^(2/3))).
```

`ExtractionOptimization.lean:68,124` chooses the first side for Y <= X and the second otherwise. On the chosen side write the multiplicity as W and the variable ideal scale as U. Then W^2*U <= T and W^3 <= T. For a >= 1/2, W*U^a <= T^a; the outer cube factor then bounds this term by M^a when a >= 1/3. The linear and cross terms become M^(1/3)*N and (MN)^(2/3). For xi >= 4/3 the cross term is at most M^(1/3)*N + M^xi, by splitting M <= N and N <= M.

The exact resulting theorem `B2Growth.lean:73` is

```
elementSieveNorm K N <= A_delta*(KN)^delta*(N*K^(1/3) + K^xi),
K,N >= 1.
```

The old property is applied at delta/2, and each of the two dyadic lengths is absorbed using delta/4. This establishes the required delta loss without assuming the improved estimate. The factor before logarithmic absorption is 384*128^2. I checked these finite reductions at the source level; the underlying ideal factorization, bad-prime and ideal-count facts remain listed as arithmetic boundaries below.

## 3. Pair Poisson, coefficient normalization and kernel transfer

I inspected `PairPoisson.lean:12-130` at the application layer. For coprime admissible I,J the original pair has symbols star(cubicRow I)*cubicRow J. The dual pair reverses that conjugation. The multiplier is

```
M * star(gaussTwo I) * gaussTwo J / sqrt(norm(I)*norm(J)),
```

and the radial Fourier argument is M*norm(span{h})/(norm(I)*norm(J)). The square-root denominator and the full product denominator have different roles and are retained in the source. The quotient trace and Gauss transform are actual named producers, not a stipulated estimate of the target sum.

At `DualCoefficients.lean:13-38`, the dual coefficient is star(a_j*gaussTwo J_j)/sqrt(norm J_j). Its squared modulus is exactly |a_j|^2/norm J_j. The annulus therefore bounds the energy by (2/N)*sum|a_j|^2. `cubicDualRow_eq_gram` swaps the two finite indices; that swap is needed for the conjugations to agree.

The kernel's joint column dependence is handled at `KernelTransfer.lean:13-83`, rather than discarded. The two coefficient vectors acquire conjugate and ordinary unit log phases. Their energies remain unchanged. `element_coprime_bilinear_bound` bounds the square of the rowwise norm sum; both sides are nonnegative before taking the square-root inequality. There is no division by an energy or a norm that might vanish.

I also read `QuadraticSieve/DivisorBlocks.lean:389-502`. It derives the matrix bound from a Schwartz density b_R satisfying the actual Fourier representation on fixed log windows and a uniform bound on (1+R)^A*integral|b_R|. Finite sums commute with the integrals after integrability is established. The constant is chosen before R and the finite matrices. The row phase has modulus one, so it disappears from the rowwise bound.

`FrequencyShell.lean:44` chooses R=M*K/N^2, x=log(norm(h)/K) and y_j=log(N/norm J_j). The shell bounds place them in the fixed window of radius four. Expanding R*exp(x+y_j+y_k) gives exactly the pair argument above. This supplies the cubic denominator used in the recurrence when A=3. The construction of the uniform Schwartz envelope, and the underlying trace-Poisson and local Gauss identities, still require separate audits.

## 4. Zero frequency and legitimate infinite summation

The consumed theorem is `Recurrence.lean:60`, with the `_all` suffix. It does not require nonunit columns. `ZeroMode.lean:15` uses column injectivity to allow at most one unit ideal. Every other column vanishes at zero, and the remaining term is at most (2/N)*sum|a_j|^2*|F_W(0)|. The common-factor proof explicitly calls this all-column version. Removing the unit term would not be justified.

There are two convergence obligations. `Smoothed.lean:15,40,70` bounds each pair by a summable radial Fourier lattice function, then commutes the finite column sums with that lattice sum. Independently, `Majorant.lean:17-50` bounds

```
elementSieveNorm(2^j,N)/(1+M*2^j/N^2)^3
```

by a fixed multiple of (1/4)^j for every fixed M>0,N>=1. It uses the initial element-sieve estimate with the K+ceil(N)^2 shape. The new exponent estimate is not used to establish convergence. `Recurrence` can consequently reindex into disjoint frequency shells and sum their bounds, retaining zero separately.

## 5. Exact dyadic powers and the common-factor issue

The full `CubicDyadicDecay.lean` proof was inspected. For t>0 and 0<alpha<3 it gives

```
sum_j (2^j)^alpha/(1+t*2^j)^3 <= D(alpha)*t^(-alpha),
D(alpha)=2^alpha/(2^alpha-1) + 1/(1-2^(alpha-3)).
```

For t>=1 the cubic denominator controls the entire tail. For t<1 a dyadic cutoff between 1/t and 2/t separates a growing geometric prefix from a decreasing geometric tail. All denominators are positive on the stated open alpha interval. The two uses alpha=1/3+theta and alpha=xi+theta lie strictly inside that interval, including xi=2.

The scale identity at `CubicDyadicDecay:189-244` is

```
N^theta*(M/N)*(M/N^2)^(-(b+theta))
  = N^(3theta)*M^(-theta)*M^(1-b)*N^(2b-1).
```

The b=1/3 term also has a factor N from the element bound, yielding (MN)^(2/3). The b=xi term yields M^(1-xi)*N^(2xi-1). This calculation is the substantive origin of the new power.

I separately followed the common-factor descent through `Mobius`, `CompactDescent`, `QuotientColumns`, `CommonFactorBound` and `DescentEnergy`. The original squared energy is first bounded by its compact radial majorant. The exact gcd and finite Mobius identities then produce coprime descendants. The proof takes complex norms and uses |mu|<=1; it never assumes that each residual or Mobius block is positive. Compact support justifies the corresponding finite/infinite sum conversions.

A descendant uses the original columns divided by D, with the coefficient supported only on D dividing that column. The scalar multiplier is the actual cubic symbol at a generator of E. Quotient injectivity, admissibility and the annulus [N/(2d),N/d] are proved on this restricted index type. The coefficient energy is unchanged by that restriction; its subsequent upper bound uses the cubic symbol's modulus at most one.

Write d=norm D and e=norm E. Nonzero ideals and divisibility give

```
1 <= e <= d <= N.
```

Thus the column scale N/d is at least one, but the row scale M/e need only be positive. `CostGrowth.lean:12` has exactly that domain. This point prevents a false application of an M>=1 bound at every descendant.

The proof also does not estimate (M/e)^(-theta) in isolation. For the complete mixed monomial, u=2/3-theta and v=2/3+3theta. For the complete asymmetric monomial, u=1-xi-theta and v=2xi-1+3theta. In both cases v>=0 and u+v>=0, with sums 4/3+2theta and xi+2theta. Hence e^(-u)*d^(-v)<=1 when 1<=e<=d. This proves the descendant comparison even when u is negative. Only after returning to the original scale is M^(-theta)<=1 used.

The zero-mode scale satisfies (M/e)*2/(N/d)<=2M. The other factors give N^(3theta+theta)=N^(4theta). `DescentEnergy.lean:21` pays two divisor bounds, one for E dividing D and one for the supported column divisors D, giving N^(2theta). This yields the exact annular loss N^(6theta). The unused coarser `descendant_loss_le` would lose an additional theta; the actual proof calls the coupled comparison in `CubicDyadicDecay`.

## 6. Final shells, constants and noncircular finite iteration

At `ColumnShells.lean:39,44`, the coefficient energies sum exactly over the deterministic disjoint labels. Cauchy on the row sum costs one shell count. There is no second shell count after the coefficient energies are recombined. A nonempty shell has scale Y<=2N; an empty shell contributes zero. The shape comparison costs at most eight since 2xi-1<=3, and the N^(6theta) comparison costs at most eight since 6theta<3. The shell count is bounded by [2+1/(theta*log2)]*N^theta.

With K the annular constant, the final constant is

```
64*K*[2+1/(theta*log2)],
```

and the loss is exactly N^(7theta). All constants are chosen before the free finite families and M,N. Bounds can depend on theta and the old exponent constant. No assertion of useful explicit magnitude follows here.

I checked the subsequent finite iteration as a consumption check, not as a substitute for the preceding analysis. `ExponentImprovement.lean:77` sets theta=min(epsilon/14,1/4) and enlarges M to T=max(M,N^a), where a=(6xi-5)/(3xi-1). Put b=(6xi-4)/(3xi-1). The identities (a+1)*2/3=b and a*(1-xi)+2xi-1=b give the claimed shape after enlargement. The negative exponent 1-xi reverses the T comparison in the required direction. N^(7theta)<=(MN)^epsilon supplies the error budget.

`HeathBrownIteration.lean:14-87` contracts xi-4/3 by at most 2/3. For each requested positive error it selects a finite iteration count. It does not pass a sequence of growing constants through an infinite limit. The initial exponent comes from the initial sieve; each improvement consumes only the previously established old property. No circular call to the final QRH assertion was found in this inspected chain. This is not a transitive audit of all imported foundations.

## 7. Remaining proof boundaries and next review

The author's remaining-boundary list is appropriate. A complete provider review still needs the following substantive inputs.

* The actual trace-normalized Eisenstein Poisson theorem beneath `GaussSum/SexticRadialPoisson.lean:499`. I additionally checked the scaling adapter at lines 480-541: it reduces the radial formula to `actual_eisenstein_paper_poisson_trace` and the Fourier scaling theorem. That does not verify those lower analytic producers.
* The canonical principal finite Gauss transform, coprime pair separation and the norm-one normalized Gauss factor. The conjugations, moduli and hypotheses at their consumption sites were checked here. Their local and CRT proofs were not independently reconstructed in full.
* `QuadraticSieve/IdealQuotients.lean:415`, `paperRadialFourier_log_separation_envelope`. Its immediate body calls the radial Euler bounds and `LocalLogFourier.coupled_positive_log_separation_envelope`. The latter construction and its uniform weighted L1 bounds remain analytic tasks.
* The radial Fourier lattice-summability theorem and initial cubic sieve beneath the adapters in `Smoothed` and `FullNorm`. The fact that they suffice for convergence was checked; their deep proofs were not.
* The finite-norm and coprime bilinear operator foundations, ideal divisor small-power bound, underlying cubic ideal factorization, bad-prime decomposition, and the fixed ideal-count bound. Their local use, positivity and losses were checked without claiming a new proof of every underlying identity.

The next useful analytic review is the uniform log-Fourier separation construction or the trace-Poisson normalization, with a similarly bounded examination of the underlying producers. Rechecking the finite improvement iteration would not resolve those boundaries. This review changes no spectral premise or selected global strategy.

## Source binding and read scope

The 40 hashes in the author table all match the current source files. The table below identifies this review's direct source scope. `Full` means the local file body was read for this review or the immediately preceding immutable short-energy review; it does not mean every imported lemma was verified. Boundary entries explicitly identify the smaller inspected ranges. The author table also binds remaining named files not represented as a full read below.

| Source | Direct scope | SHA-256 |
|---|---|---|
| `CubicSieve/FullImprovement.lean` | Full | `917501B7005D3BE61C668BAB919265AD061F2EF305E42CC5BAFA21CBA7DB84CA` |
| `CubicSieve/AnnularImprovement.lean` | Full | `04BAF1E2C8AC9B3477323758336F2C2252C539D6F1FD0478073490A8CE10EBF7` |
| `CubicSieve/CostGrowth.lean` | Full | `6E3E957D4D03A743A73F3187D4F70E0EA8390A9053C1F8EE7BBBEBAEEB7272E8` |
| `CubicSieve/DescendantBounds.lean` | Full | `8EB2CC225B8DA9248C85E9B6CB8AEF2A972F6BAA60D8440078D2BD770EF2827D` |
| `CubicSieve/B2Growth.lean` | Full | `B82B26F65FCB310FE28B181D268B55FA8016ACF82C756F31833322E31C57F80A` |
| `CubicSieve/Growth.lean` | Full | `7CAA9B7C0DB9D5B4641F2734A2827835FAD00CC234632157A4376A56B127B255` |
| `CubicSieve/ExtractionOptimization.lean` | Full | `E330E8579ABCF887B9FCC0474945FB17FA3325476B13CC9E2202BEF0A42F5CB7` |
| `CubicSieve/FullNorm.lean` | Full | `C0A607BD90640D0DFBC22A05D30F9D15D642529198858D44F1BF4DA3C5013885` |
| `CubicSieve/Ideal.lean` | Definitions at 14-16, 131-155 and their consumers | `9C988E8D755DE2EBDF17818E14C8E2B52BE6B4D90B5924D1159DDC5729F793CA` |
| `CubicSieve/FullExtraction.lean` | Full | `90E840FB16DEBFABC6BA7F15A5F85C9CFBEAD866D9B90A0DDEDDB8D2EF06ECFD` |
| `CubicSieve/ExtractionBounds.lean` | Full | `EF9A309B626D7A8E2908A3154AE23F1D8134509D728C4767732C54794F86FF21` |
| `CubicSieve/Dyadic.lean` | Full | `E8075469559A3AEA40B6BCA76E8AD08EB9F6095370C3E71C58A2585E1C488147` |
| `CubicSieve/Elements.lean` | Full | `09CBAA493BAAEBC188174EBE373F29E0EEE51E8AC8F7E8BD12AD4D9B9A8A82DF` |
| `CubicSieve/CommonFactorBound.lean` | Full | `6D39A6115EFC27E12054D21E5605BE8040A3A7A0A217774D1725CF2B9210C08E` |
| `CubicSieve/QuotientColumns.lean` | Full | `FF2AB83441E0D01BFC2D24A2A07B6FA93FA025C8D7CB752A8C22DF065B8F7ED7` |
| `CubicSieve/CompactDescent.lean` | Full | `653B753BEEF481A9385F1621370856844A47EDE88A52A48B16A5308330484774` |
| `CubicSieve/DescentEnergy.lean` | Full | `EC7A0AA65141FA68F977D8E25C761F6E986F7C7CB23A075940D04EB3136344CE` |
| `CubicSieve/Mobius.lean` | Full | `ACA1A7FFDF4D98EC4D69DB5DFE21B779D52F62C015E0E40C1CB08108479F5FAF` |
| `CubicSieve/Gcd.lean` | Definition and consumed identities at 13-90 | `C887EC26ABC6AED7617B00021CA5240D7F069B740FDC5920706467409B644E6F` |
| `CubicSieve/Recurrence.lean` | Full | `3A80D157EE281F0F3D210989147D9CCC786AB2A3E87D97A6AC99ADB8AFC61C16` |
| `CubicSieve/Majorant.lean` | Full | `8A5D7BCB90FB88AAB40F8C0BD77DB52E53945C2C99D152F320E56378B42A0524` |
| `CubicSieve/Smoothed.lean` | Full | `E25174BBACD12E434D271F5804D60547B9D38DC0E6E7BB0C1153EFF8F2AF6367` |
| `CubicSieve/ZeroMode.lean` | Full | `72B5C5B16C6E2A2D24732938D54CEB82B3D766A0C453DADDB4D058CB26C84867` |
| `CubicSieve/DualCoefficients.lean` | Full | `3DE901BC4AFE6734B667A4AA61AFD23B5DB63ACABFD76D0966A16E7B3C44A841` |
| `CubicSieve/FrequencyShell.lean` | Full | `C51D11D79F8F2712B55D1D8C8E1BA8D4690664D1CA901C890D6A887BA87756C0` |
| `CubicSieve/KernelTransfer.lean` | Full | `EC7D03C219A67D0108D10DC69C1FE1BB7537F15ED78C29AF3E4D13D9C4F97944` |
| `CubicSieve/PairPoisson.lean` | Full | `EC25A59907C03B82CBCA9B21195CEEE14CB7B42D76C467997725344F9D2C6F62` |
| `CubicSieve/ColumnShells.lean` | Full | `4B54043137F6997F5893703079BDFB423D90EBB1A5E86A5356D0DD6D5B0FC654` |
| `CubicSieve/ExponentImprovement.lean` | Full | `5225C2910E2CC4F464D65CBA0101D6C4B4D099ABA0338929DE4D6C204AAECFAD` |
| `CubicSieve/Sharp.lean` | Full | `2EA22192D557C6D359EA6E5AF91C1DE03E6B91759FA4DB971AF3EE5D6D68F3FA` |
| `CubicDyadicDecay.lean` | Full | `B20A5E11C9CBD22276C9005A8C80A10F5E32C2C4F7C5AD027FDA608C3CBDD473` |
| `HeathBrownIteration.lean` | Full | `C8BC47D96E0F239032D361E92BCCA4D8C75DE718ECBA309C21513C277B223EFA` |
| `QuadraticSieve/DivisorBlocks.lean` | 389-502 | `41458D0EB675CCBDCC9F9FAD95AFEE7AF76ED46C16FD719DC658921EFDCF837D` |
| `QuadraticSieve/IdealQuotients.lean` | 415-441, boundary body | `3961EF95BA392A9352CADD3A9EC9C3336081BDC468B89A14FB099D00FD64D499` |
| `GaussSum/SexticRadialPoisson.lean` | 480-541, radial scaling adapter | `8DB6F0F3B850868F18706630A4F8F1DA42A345D2F0D32949B8D4CC6CB0F5D21C` |
