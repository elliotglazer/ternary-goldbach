# Selected quadratic Poisson scalar majorant: bounded mathematical audit

2026-11-11. Source baseline: `work/openai-math`, commit `4eaee87548250b2682affda7d05d947c05554bae`.

**Finding:** no mathematical defect identified in the selected scalar bound or the inspected assembly into the quadratic annular estimate. The exponent 259*eta is accounted for explicitly below. This is a source-level mathematical audit, not a Lean build, expanded-axiom verification, or validation of the global QRH provider. It advances the scalar-majorant boundary of the preceding quadratic product-column review; it does not silently validate the remaining analytic Poisson inputs. No source or previous artifact was modified. No analytic function, spectral evaluator, or production scan was run.

The target is `QuadraticSieve/PoissonConstants.lean:562–684`, `poissonComparisonMajorant_selected_power`. I read its full local helper chain, the majorant definitions and nine-term expansion, the retained/source/tail/principal assembly, and the finite high-square-part reduction. Exact source ranges and hashes appear at the end.

## 1. Exact statement, fixed data and nonvacuity

Write P=M*X and use the actual source selections

    T = C*P^eta,
    K = T*X^2/M,
    N = X/q,
    g = norm(G) = B*q.

The source fixes an OLD quadratic `HasSieveExponent alpha`, 1/2<=alpha<=2, 0<eta<=1, natural l,A with eta*l>=4 and eta*A>=4, three finite seminorm sets sD,sS,sT, nonnegative CD,CS,CT,CP, B,C1>=1, and a Schwartz function W. It then supplies Cfinal>0 BEFORE C,M,X,q,G such that

    Majorant(G,K,N,M,T,one,W)
      <= Cfinal*P^(259*eta)*(M+X+X^(2*alpha-1)*M^(1-alpha))

whenever 4<=C, B<=C<=C1, M,X>=1, 1<=q<=X, G!=0, norm(G)=B*q and K>=1. `one` denotes the one-element coefficient family with coefficient 1. Both loss parameters in the general majorant are specialized to eta.

The conditions matter. N>=1 follows from q<=X, while N<=X follows from q>=1. K>=1 is an explicit hypothesis of this theorem; it is NOT a consequence of M,X>=1 alone. The application separately establishes it in the selected range. If C1<max(4,B), the C interval is empty, but the intended application chooses a nonempty interval. No nonvacuity claim is based on that empty case.

The scalar theorem does not require G squarefree, admissible column families, or W(0)=0: it bounds a defined nonnegative expression. Applying the expression to actual masked sums DOES require the extra hypotheses in section 6. Nonnegative constants chosen arbitrarily in this scalar theorem are not automatically valid analytic constants.

Cfinal may depend on eta, alpha and the OLD exponent witness, W, seminorm sets and constants, B,C1, and through those inputs the finite derivative orders. It is uniform in C,M,X,q,G under the displayed bounds. It is not a common constant for all W, all eta approaching zero, or all derivative orders.

## 2. The actual scalar expression and nine retained terms

`PoissonComparison.lean:317–331` defines the majorant as four blocks: retained dual, dual high tail, masked source, and principal-density difference. Its dependence on coefficients is exactly quadratic:

    Majorant(...,a,W) = Majorant(...,one,W)*sum_j|a_j|^2.

This is `poissonComparisonMajorant_energy_factor:471–481`, obtained by unfolding and using the diagonal identity for `divisorEnergyFactor`. Since sqrt(E)*sqrt(E)=E for E>=0, no division by E or assumption E>0 is needed. Empty coefficient families give zero.

Here is an independent expansion of the one-element expression. Put

    d = card(idealDivisors G), lk = columnDyadicLength(K)+1,
    ln = columnDyadicLength(N)+1,
    f = 256*supportConstant_eta*divisorConstant_eta*N^(2*eta),
    e = divisorExponentConstant(old,eta)*((2*K)*N)^eta,
    vh = |RadialFourier(V)(0)|, vz = |V(0)|,
    uh = |RadialFourier(U)(0)|,
    dv = dualMiddleDecayConstant(V), du = originalMiddleDecayConstant(U),
    lat = nonzeroLatticeEnvelopeConstant,
    cd = supportConstant_eta*(N*N)^eta*CD*seminorm_sD(V),
    cs = supportConstant_eta*(g*N*N)^eta*CS*seminorm_sS(U),
    ct = CT*seminorm_sT(W),
    cp = supportConstant_eta*N^eta*CP*(K*N)^eta,
    a0 = sqrt(M)*(2*K)^(alpha-1/2),
    b0 = sqrt(M/K)*N + sqrt(M)*K^(alpha-1/2),
    eD = K*M/T^l, eS = K*N/T^l,
    t = M/(g*N*N), tail = M/((min(1,t))^2*(1+t*K)^A),
    U(x)=W(x^2), V(x)=RadialFourier(W)(x^2).

The actual expression is

    d*lk*(8*vh*ln^2*f*e*(M+a0)
          +8*vz*ln^2*f*e*(M+2*T*a0)
          +8*ln^2*lat*dv*f*e*(M+2*T*a0)
          +65536*cd*eD)
    +1536*d*ct*tail
    +lk*(2*uh*d*ln^2*f*e*(4*N/T+a0)
         +2*d*ln^2*lat*du*f*e*(N+2*T*a0)
         +32768*cs*eS)
    +uh*d^2*cp*b0.

This agrees with `GlobalBinLoss.lean:93–105,176–216` after substituting the definitions. In particular 65536=16384*2*2 in the retained-dual error (the row scale is 2K), 32768=16384*2 in the source error, and 1536=6*256 in the tail. The factor six from the actual Poisson normalization is retained. The principal-difference term really has d^2, not d; the scalar argument pays it.

If each of the fifteen unit-budget factors d,lk,ln,f,e,vh,vz,dv,uh,du,lat,cd,cs,ct,cp lies in [0,U0], U0>=1, and a common S>=0 bounds M,N,T*a0,b0,eD,eS,tail, then a0<=S and N/T<=N for T>=1. The nine shape bounds are 2S,3S,3S,S,S,5S,3S,S,S. The corresponding numerical allowances are

| Contribution | Product degree in unit factors | Numerical allowance |
|---|---:|---:|
| Retained large principal | 7 | 16 |
| Retained small principal | 7 | 24 |
| Retained middle | 8 | 24 |
| Retained truncation error | 3 | 65536 |
| Dual tail | 2 | 1536 |
| Source principal correction | 7 | 10 |
| Source middle | 8 | 6 |
| Source truncation error | 2 | 32768 |
| Principal-density difference | 4 | 1 |

Their sum is 99921<262144. Nonnegativity permits bounding each product by U0^8, padding the degree because U0>=1. Thus the source's bound 262144*U0^8*S is valid, with ample unused numerical margin. This is finite algebra, not an unrecorded cancellation estimate.

## 3. First product envelope and the 256*eta loss

`PoissonConstants.lean:93–342` collects nineteen primitive constants: the divisor, dyadic-log and support constants; 256; the old divisor-exponent constant; the profile evaluations and middle-decay constants; the lattice constant; CD,CS,CT,CP and the three seminorm values; and D^eta, where D=2*C1+B. A finite maximum supplies H>=1 bounding them all. Each is nonnegative; the positivity arguments do not assume W itself is positive.

The selected scales satisfy

    g<=B*P, K<=C1*P^3, N<=P,
    g,K,N,2*K*N,N*N,g*N*N,K*N <= D*P^4.

For K, use eta<=1 and X^2/M<=P^2. Each other comparison follows from P>=1 and the three initial bounds. Therefore any of the seven scale factors raised to eta is bounded by D^eta*P^(4*eta)<=H*P^(4*eta).

Let V0=H*P^(4*eta)>=1. Each unit-budget entry is a product of at most eight primitive or scale-power factors bounded by V0. In fact the displayed fifteen entries need respectively 2,2,2,5,2,1,1,1,1,1,1,4,4,2,4 factors, after replacing d and the dyadic counts by their standard small-power upper bounds. Eight is a safe loose cap. Consequently U0=V0^8 is a common unit budget; section 2 then uses U0^8=H^64*P^(256*eta).

The divisor bound and log/dyadic bound used at this point are genuine upper bounds, not definitions of the integer counts. The former was read in the preceding quadratic audit. The latter is `DyadicColumns.lean:83–97`: ceil(log N/log 2)+1<=2+log N/log 2, followed by log N<=N^eta/eta and N^eta>=1. It requires N>=1; this holds for both K and N in the selected theorem.

`divisorExponentConstant` is explicitly chosen from the OLD `HasSieveExponent.divisor_pair`, not from an exponent being proved (`LatticeEnvelopes.lean:346–363`). The divisor-pair proof applies the old reverse estimate at N/D with 1<=D<=N, so all its input column scales remain at least one (`FirstCoreCutoff.lean:557–577`). These constants can be large; the theorem is qualitative in them.

## 4. Selected shape: the remaining 3*eta

Put Z=X^(2*alpha-1)*M^(1-alpha), F=M+X+Z and R=P^(3*eta). These are nonnegative, F>=1 and R>=1. The source uses

    Cshape=2+4*C1^3+B^2+C1,
    S=Cshape*R*F.

The potentially negative exponent 1-alpha causes no monotonicity mistake: M is positive, Z is carried as a whole positive term, and the exact power identity is used before comparing anything.

**Middle term.** With K=T*X^2/M,

    T*sqrt(M)*K^(alpha-1/2)
      = T^(alpha+1/2)*X^(2*alpha-1)*M^(1-alpha).

Since alpha<=2, 2^(alpha-1/2)<=4 and T^(alpha+1/2)<=T^3 (T>=1). Thus T*a0<=4*C1^3*R*Z. This is the complete source calculation at `ArithmeticBins.lean:499–560`; its coefficient is not inferred by a numerical sample.

**Principal difference.** Since K>=X^2/M, sqrt(M/K)*N<=M when N<=X. Because alpha>=1/2 and T>=1, the second part of b0 is bounded by T*a0. Hence b0<=(1+4*C1^3)*R*F<=S. The lower alpha bound is necessary for this monotonicity step.

**Truncation errors.** T>=P^eta and eta*l>=4 give T^l>=P^4. Since K<=C1*P^3 and M,N<=P, both eD and eS are at most C1, hence at most S. No assumption of integral P or integral T is used; l is a natural exponent.

**High dual tail.** Using g=Bq and N=X/q,

    t=M*q/(B*X^2),
    t*K=T*q/B,
    t>=1/(B*P^2),
    1+t*K>=P^eta.

Here q>=1 and C>=B are both used. Since B*P^2>=1, min(1,t)>=1/(B*P^2), and eta*A>=4 gives (1+tK)^A>=P^4. Therefore the denominator of tail is at least 1/B^2 and tail<=B^2*M<=S. All denominators are strictly positive in the selected domain. This treats t below, at, and above one together; it does not assume the tail has entered a large-t regime.

The remaining M,N are bounded by F<=S. Substituting into section 2 yields exactly

    262144*((H*P^(4*eta))^8)^8 * (Cshape*P^(3*eta)*F)
       = (262144*H^64*Cshape)*P^(259*eta)*F.

Thus Cfinal=262144*H^64*Cshape is positive and chosen before the varying scales. No dependence on q or G remains outside their declared ranges.

## 5. Retained dual and high square parts are not discarded

There are TWO distinct high/low mechanisms here; they should not be conflated.

First, the infinite ideal Fourier sum is split at norm(squarefreePart)<=K, with the strict complement >K (`DyadicColumns.lean:558–590`). Summability is supplied before splitting. The low part is reexpressed as a finite sum over squarefree ideals, but its principal kernel still contains the corresponding square variables (`TruncatedSecondTransfer.lean:119–129`). It is not a truncation of the total ideal norm. `CommonMasks.lean:83–230` inserts this into each divisor-twisted pair and reindexes the finite coefficient sums. This produces retainedDualPrincipalSum PLUS maskedDualTailFamily exactly, with the original pair-coprimality restriction and star(a_j)*a_k coefficients intact.

The high tail is bounded by an injection from ideals to chosen ideal generators, norm(squarefreePart)<=norm(ideal), and a radial lattice tail. `DyadicColumns.lean:124–177` supplies the injection and summability comparison. `ScaleCaps.lean:352–480` uses norm(q)<=norm(G), pair norms in [N/2,N], and character/Moebius magnitudes<=1. The pair prefactor is <=2M/N. Finite Cauchy and card(columns)<=128N turn that into 256M times coefficient energy. Multiplying by the outer six gives the 1536 term already counted. The underlying radial Fourier decay and lattice summability are analytic inputs, not proved anew by the scalar calculation.

Second, the ANNULAR large-gcd branch has a separate highKernelNorm. Its actual finite square-part argument was inspected at `RetainedDualBounds.lean:531–648`: group row ideals I by A=squarePart(I), then I=A^2*squarefreePart(I). On a fixed A fiber, the squarefree part is injective and the coefficients become idealZeroMask(column,gen A)*a(column), which contracts energy. This yields a sum of sieveNorm(M/norm(A)^2,N), not a bound with an uncharged fiber cardinality.

For each retained A, 1<=M/norm(A)^2<=M and norm(A)<=sqrt(M/K). The old exponent therefore applies within its domain. `HighKernelGeometry.lean:77–181` uses inverse-square norm sum<=1024 and card(A)<=128sqrt(M/K), giving

    highKernelNorm(M,N,K)
      <= C_old*1024*(MN)^eta*(M+sqrt(M/K)*N^alpha).

The inverse-square bound is a finite dyadic argument: each bin has at most 128*2^j ideals, each term is at most 4/2^(2j), and sum_j 512/2^j<=1024. The foundational ideal count and squarefree decomposition/character identities remain inherited.

`AnnularLifting.lean:483–537` then adds, rather than discards, this separate high-kernel branch to the small-gcd Poisson bound. Its actual result contains

    16*((C/6)*divisorConstant*N^eta
        + highKernelBound(2M,N/Hcut,K)
          *supportConstant*divisorConstant*N^(2eta)) * energy.

Hcut here is the gcd cutoff, not the primitive bound H in section 3. The C/6 comes from norm(6*annularRayGcdBlock)=6*norm(block). The condition 0<Hcut<=N/2 keeps N/Hcut>=1 for the old high-kernel estimate.

In the selected threshold range the three-term F is <=3M. The small-gcd term gains one additional divisor power, 259*eta+eta=260*eta. The large-gcd estimate has a 3*eta loss at that assembly and is enlarged to 260*eta using MN>=1. This verifies the local loss allocation leading to the previous audit; it does not turn 259 into the final annular exponent by omission.

## 6. Actual analytic consumption and the remaining source boundary

The actual function is `maskedPoissonDifference=maskedDualFamily-(1/6)*maskedPrincipalSourceSum`. `PoissonComparison.lean:184–239` centers the retained dual and source and gives

    6*Difference = sum_q mu(q)*centeredRetainedDual(q)
                   +6*maskedDualTailFamily-centeredMaskedSource
                   +RadialFourier(U)(0)*sqrt(M)*actualPrincipalDifference.

The final density term is not asserted to vanish. The normalization of U,V is actual: U(x)=W(x^2), V(x)=paperRadialFourier(W)(x^2), and equality of their principal Fourier values follows from the source radial identity (`ReflectionBrackets.lean:267–304`). No complex conjugate or factor six is dropped in the inspected assembly.

`masked_poisson_complete:333–381` obtains the four analytic producers, retains all four blocks by triangle inequalities, and then bounds the densityColumn energy by the original energy. Its hypotheses include squarefree G containing the two bad primes, injective admissible columns in [N/2,N], a common column ray, columns coprime to G, M,N,K>=1, T>=4 and W(0)=0. These are additional to the scalar theorem, not consequences of its parameter inequalities. In the selected application they are supplied by the actual annular/gcd adapter. The scalar theorem alone does not assert a bound for arbitrary characters or arbitrary nonadmissible families.

I inspected the retained/source dyadic assemblers as well. They partition into finite nonempty or empty bins, bound each nonempty bin at a scale <=2K by monotonicity (alpha>=1/2), and retain the factor columnDyadicLength(K)+1. The retained term's divisor twist contracts coefficient magnitudes, and its F=norm(q)>=1 is enlarged safely to F=1. These explain the l_k and divisor multiplicities in section 2, rather than adding unrecorded ones later.

The principal-difference adapter is especially explicit: `PrincipalDifference.lean:106–174` expresses it as a finite double divisor sum of an actual quadratic matrix form with contractive twists and cutoff weights. `MaskedPrincipalBounds.lean:256–290` applies the OLD reverse exponent to sieveNorm(K,N), obtaining the d^2*CP*(KN)^eta*b0 term. The source uses no new rank or improved exponent in this step. Its lower `normalizedPair_main_difference` and `main_difference_operator_bound` remain arithmetic/operator inputs.

This audit stops at the following substantive boundaries:

* Principal kernel identities and truncation estimates beneath `retained_dual_principal_difference` and `masked_source_principal_difference`: all-conductor principal truncation, small/large principal estimates, original/dual middle estimates, and uniform error estimates. The finite assembly and exact majorant definitions were checked; the whole underlying analytic proof was not.
* Actual radial Fourier normalization, source/dual density identities, and low-squarefree principal reexpression. Their local adapters and required hypotheses were read; their Fourier/Poisson foundations are not certified by the nine-term calculation.
* `paperRadialFourier_lattice_tail` and its weighted Fourier bound/lattice summability. The tail injection and exponent handling above were checked, but the foundational decay estimate was not rederived here.
* Initial/reverse quadratic sieve, finite-field character norm/multiplicativity and normalized-pair algebra, ideal factorization and ideal count, and finite operator foundations. The inspected old-exponent uses and square-part fibers are noncircular at this level; no transitive axiom or global no-circularity verdict is claimed.

The useful next depth is one of those actual principal/middle/error or radial Fourier producers. Repeating the finite maximum argument or changing the harmless coefficient 262144 would not close the remaining analytic proof.

## 7. Exact check artifact and status

Owned script `qrh_quadratic_scalar_majorant_checks_20261111.py`, SHA-256 `8D3A758A7885CCA0DEEF2801765D15076D94EED855BFBF719EA73DBF634F1375`, exited zero. Receipt `qrh_quadratic_scalar_majorant_checks_20261111.json`, SHA-256 `AC7191B34649E32F1602C347D818958A3DB3BD750C67E206B20026C79C4DBA6F`.

It checks the two product-degree lists, nine numerical allowances, 99921<262144, the exact 259/260 loss arithmetic, and rational exponent identities. It hashes four central source files. It is deliberately not an analytic evaluator or a proof of all real-parameter inequalities; those arguments are written above and checked against source. No timing or effective-constant forecast follows.

The bounded conclusion is that the selected scalar majorant and inspected finite/parameter assembly are mathematically consistent, with no identified defect. The global provider and complete sharp quadratic sieve remain beyond this result.

## Source pins and inspected ranges

Paths are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`. A hash binds the whole file but the stated scope is only the indicated range. Entries marked as a boundary identify a contract or local adapter without validating its complete lower proof.

| Source | Inspected range | SHA-256 |
|---|---|---|
| `QuadraticSieve/PoissonConstants.lean` | 80–684, complete selected scalar helper chain | `E0914B906B537C1D987169FAC2943E49E47F62579F719E485A46C20117ACCFF2` |
| `QuadraticSieve/GlobalBinLoss.lean` | 76–216 | `9E969886E08722743F7C36F19B470031253FC4F2C613133288CE3A3AC600D68B` |
| `QuadraticSieve/PoissonComparison.lean` | 156–381; 463–481 | `428339EF45AACFAB07DE6594CE4BCC58945746C0B326DC1098910396A9F74925` |
| `CubicSieve/ArithmeticBins.lean` | 470–560; annular adapter 438–469 read in prior audit | `99CDCE95094560A32F5E7601A4DA24554B47883C8F5683DC43CC23BCAD661A2A` |
| `QuadraticSieve/PrincipalMajorants.lean` | 84–115 | `7BA6C90425918E2F46B7027827D5DAC629F550AADFFDB3174DF64BC836C85577` |
| `Eisenstein/SeedDefects.lean` | 337–385; middle producer boundary | `A60BCC07E52B038B206FA3C2C16ABDC35F149F71B9276D131A2B6BECA9363F10` |
| `QuadraticSieve/RetainedDualBounds.lean` | 297–648 | `ACD0726AFE215CE68AA43C1D089D28D78571D98042D1232073C085143EBBAB33` |
| `CubicSieve/PrincipalDensity.lean` | 282–451 | `DD2371ED32B9AFAE8385FC400CD8A46A147B520FE4A006888E05D73385EC7781` |
| `Poisson/LatticeEnvelopes.lean` | 315–363; lower lattice producer boundary | `BF911A0AA1CB1468B57F4DC48ACBEC400EA06C5AD504C95F3B050E577825FC29` |
| `CubicSieve/FirstCoreCutoff.lean` | 557–626; reverse bound previously read | `F7C16F712BC622AE9C048678A4D776EC78C45F6502CFFAF7CD7B36BB20156FB1` |
| `QuadraticSieve/MaskedPrincipalBounds.lean` | 200–290 | `06FB5D3004455032D16A914D3CB16381E862EC4DBDAB3FBCA6DA037FA7DCA868` |
| `QuadraticSieve/PrincipalDifference.lean` | 81–174 | `DB43BA4F8848D4B6792952A9A5E42FB4B35F05DF2E878067C9892F65953ED64B` |
| `CubicSieve/ScaleCaps.lean` | 352–480 | `BA02CBBC2401A9025D4EDC570C4146F5496B2166E08F64A9AECD1B16A0588164` |
| `QuadraticSieve/CommonMasks.lean` | 83–230 | `92D248E33F8E722D0EEFE7DFC3AE1534B6515BB4C0A0C1D32515E35920CE0B9A` |
| `QuadraticSieve/DyadicColumns.lean` | 76–177; 558–590 | `06DD20DAD9FB49BFC615256402AA6664FAFB5125CB6AC11C701118057A47F87C` |
| `GaussSum/ReflectionBrackets.lean` | 267–304, normalization adapter boundary | `D340337267ACE775D60C578B6E6D12E78CE8C1313B019AFE93E10ADD63AC1D4F` |
| `QuadraticSieve/TruncatedSecondTransfer.lean` | 119–129, low-part adapter boundary | `946E8749B8833DE99853879BD0D8D8912F7D6781076E5357239578BA32F5629F` |
| `QuadraticSieve/CuspCoercivity.lean` | 137–155, density adapter boundary | `311DD70E96A1AC47135A20490A215560E5E66E9AE69DB17849EA735ABCA1CCF6` |
| `Poisson/RadialFourier.lean` | 544–572, foundational tail contract/initial reduction boundary | `86D5DEB861723EBF182C8A8489EFD29320F97049F4CCB471684C827F931C8E58` |
| `QuadraticSieve/HighKernelGeometry.lean` | 77–181 | `289AE0174FB5214B20F8CBC957A137D95216591D4D7F2433B69E953AA486D070` |
| `QuadraticSieve/AnnularLifting.lean` | 483–537 | `C46E96E87880A8C9D26C7BC2FE04BBA03E768869632D26C4325502794B72E7B2` |
| `QuadraticSieve/SelectedExponents.lean` | 566–655, with full upper assembly in prior audit | `08CB24AAB4C0C42BC96CF1D845C2AC269699178FD2447199DE6232B4465788B2` |
