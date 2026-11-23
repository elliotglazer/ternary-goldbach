# Global physical high-frequency tail — mathematical/source audit, 2026-11-11

## Verdict and scope

The inspected source gives a genuine arbitrary-order bound for the actual finite physical block. Its constants and finite family of source Schwartz seminorms are chosen before the prime pool, source points, frequency sets, marking lists, and weights. The argument combines a continuous-linear Schwartz Fourier estimate, a proved summable Eisenstein lattice majorant, norm bounds for the actual arithmetic columns, and an injective count of support keys. No default-tsum argument, coefficient cancellation assumption, or bound depending on the number of selected frequencies was found in this cut.

This is a source/paper audit, not Lean compilation or a transitive axiom check. It does not prove full QRH. In particular, the prior local radial review restricted to A0=0 is not being treated as proof of this tail: the arbitrary order A+2 and its source-seminorm control are reconstructed here. Lower foundational dependencies and the finite/infinite distinction are recorded in Section 7.

Source base B is `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, repository commit `4eaee87548250b2682affda7d05d947c05554bae`. Paths and declaration line numbers below are relative to B; the closing table gives immutable file hashes and line counts.

## 1. Exact target and quantifier order

`Inversion/InitialHighFrequencyTailRapid.lean:14`, `InverseInitialHighFrequencyTail.original_physical_tail_rapid`, takes real Lcap, saving, tau with tau>0. It returns a finite set s of pairs of natural numbers and C0>0, then universally quantifies the arithmetic data and all finite sets. Neither Lcap nor saving is initially required positive; applications additionally supply Lcap>=0. Meaningful positive saving is allowed without any upper bound.

Arithmetic inputs are arbitrary index types, nonzero generators p_i of maximal ideals, pairwise coprime generated ideals, exclusion of goodLambda, injectivity of the generated-ideal family, and residue characteristic different from 2. The monoid character Psi has norm<=1 at every element. Marking lists are pairwise disjoint over the finite slot set and their coefficients have norm<=1. W1,W2 are only required to have global norm bounds B1,B2>=0; no smoothness of these two weights is used in this tail. Phi is an actual Schwartz map from R to C.

Scale inputs satisfy

    Z>=1, L>=1, Lcap>=0, L<=Z^Lcap,
    -m<=Lcap, m-D<=Lcap, Gamma>=0.

A Point consists of five finite supports (common, divisor, overlap, left, right) and an Eisenstein integer frequency. `InitialPhysicalMeasure.lean:38` defines Valid by divisor subset common, overlap disjoint from left and right, and nonzero frequency. Every source point must be Valid, its weight must have norm<=Gamma, each support lies in the supplied finite pool and has prime-product norm<=L. In addition, the two correlated column bounds are required:

    C*v*n1<=L and C*v*n2<=L,

where C,d,v,n1,n2 are the norms of common, divisor, overlap, left, right. The tail predicate is the actual radial argument

    Z^tau <= [Z^m/(d*v^2*n1*n2)] * ||eisEmbedding(frequency)||^2.

The conclusion is

    ||physicalBlock|| <= C0*Gamma*B1*B2*s.sup(source Schwartz seminorms)(Phi)*Z^(-saving).

`InitialPhysicalMeasure.lean:233` defines physicalBlock as the finite sum over the supplied points and the fixed finite SecondRayIndex. It is not an infinite sum represented by a default value. Arbitrary finite frequencies are permitted; the tail predicate, not a cardinality limit, controls them. Empty source sets are harmless, but neither nonempty sources nor nonzero Phi are excluded by the proof.

## 2. Actual radial transform and arbitrary decay

`GaussSum/SexticRadialPoisson.lean:304,307,426` defines the paper Fourier integral with its factor 2/sqrt(3), identifies it with the standard plane Fourier transform at paperFrequency, and defines paperRadialFourier Phi(t) by evaluating the radial input Phi(||z||^2) at sqrt(t). No formal radial symbol is substituted for this integral.

`Poisson/RadialFourier.lean:70–174` constructs

    radialTestCLM: Schwartz(R,C) -> Schwartz(C,C),
    radialFourierCLM = standard Fourier CLM composed with radialTestCLM.

The composition by norm squared has the required temperate-growth and properness bound. For t>=0, the frequency satisfies ||paperFrequency(sqrt(t))||^2=4t/3. Thus the source proves

    (1+t)^A ||paperRadialFourier Phi(t)||
      <= (2/sqrt(3))*2^(2A)*sup_{indices <=(2A,0)} seminorm(radialFourierCLM Phi).

It then applies continuity of this linear map and the Schwartz topology's family of seminorms: the finite output supremum is bounded by C times a finite source supremum. This chooses s,C before Phi or t. Consequently `paperRadialFourier_source_weighted_bound:146` holds for every natural A. It does not derive high-order decay from the previously reviewed order-zero bound.

This tail needs no derivatives of the sqrt profile, no local logarithmic window, and no Cauchy–Riemann extension of the real radial parameter. It only evaluates t>=0 and invokes the global Schwartz transform bound.

## 3. Genuine lattice summability and finite-set domination

For the lattice coordinate pair (a,b), q=||eisEmbedding(h)||^2=a^2-ab+b^2 satisfies q>=(a^2+b^2)/2. `RadialFourier.lean:455–503` bounds

    (1+q)^(-2) <= 4/[(1+a^2)(1+b^2)].

`GaussSum/SecondPoissonScale.lean:701–724` establishes summability of each integer factor by the p=2 series, treating zero separately, and then establishes the product summability. The coordinate equivalence therefore gives a finite Cauchy mass M=sum_h (1+q_h)^(-2), with actual Summable evidence.

For K>0, T>=0, T<=Kq and a nonnegative f, the polynomial majorant at `RadialFourier.lean:505` uses

    min(1,K)*(1+q)<=1+Kq,
    (1+T)^A<= (1+Kq)^A.

Combining these with the order A+2 Schwartz estimate gives

    ||paperRadialFourier Phi(Kq)||
      <= [C seminorm_s(Phi)/(min(1,K)^2*(1+T)^A)]*(1+q)^(-2).

`paperRadialFourier_lattice_summable_norm:533` first obtains global norm summability using order 2. `paperRadialFourier_lattice_tail:544` also constructs a summable majorant on the tail subtype before comparing tsums. It absorbs M into a positive constant using M+1. In particular, the infinite norm sum is never used without an established summability hypothesis.

`InitialHighFrequencyTailKernel.lean:13–56` injects an arbitrary finite F into the tail subtype, applies a finite-sum/tsum inequality with that summability proof, and bounds each coefficient by Gamma. The result is uniform in F:

    ||sum_{h in F} a_h paperRadialFourier Phi(Kq_h)||
       <= Gamma*C seminorm_s(Phi)/(min(1,K)^2*(1+T)^A).

No orthogonality or cancellation of the arbitrary a_h is needed. This conservative min(1,K)^(-2) cost is important in the subsequent exponent budget; it is not silently replaced by a sharper density heuristic.

## 4. Physical kernel, arithmetic coefficients, and marking mass

`InitialProfile.lean:364` and `InitialHighFrequencyTailKernel.lean:57` give the exact physical kernel, at coordinates [C,d,v,q,n1,n2], as

    [Z^(-D)*Z^m/(d*v*sqrt(n1*n2))]
      *W1(C*v*n1/Z^D)*W2(C*v*n2/Z^D)
      *paperRadialFourier Phi([Z^m/(d*v^2*n1*n2)]q).

The actual physicalTerm initially uses overlap unions in its two column supports. `InitialHighFrequencyTailCoefficient.lean:30` restores the coordinates above using Valid's disjointness and `InitialKernelBridge.lean:268`. The latter uses the exact square-root identity for the common nonnegative overlap norm. This is an equality for the original columns, not a clipped-column estimate or a newly defined surrogate.

The coefficient in `InitialHighFrequencyTailCoefficient.lean:20` contains initialBeta, two Mobius factors, secondRayCoefficient, and the product of the original left/right marked columns, with conjugation and opposite frequencies retained. Its bound at line 43 is

    ||originalCoefficient(x,rho)|| <= ||secondRayCoefficient(rho)||*(128L)^2.

Here is the source mechanism for that mass bound:

- `InitialArithmetic.lean:20,28` gives initialColumn and its exact secondPreColumn specialization. `InitialEnergyCallerWeights.lean:18` and `Fourier/FrequencyTwists.lean:577` bound its unmarked norm by ||Psi(product p)||. The actual factors are the unit normalized Gauss column coefficient, a 0/1 coprimality mask, and finite squarefree rows of norm<=1. The coefficient is not simply assumed bounded.
- `CubicSieve/FirstPassage.lean:378` proves the column coefficient has norm one through its Gauss-block expression. `PrimeRows/IdealGenerators.lean:526` bounds the finite squarefree row using its self-pair equal to the coprimality mask. The underlying Gauss/trace facts remain in the foundational cut below.
- `Descent/Marks.lean:76` bounds a primeMark on support U by 2^|U|. Pairwise disjoint marking lists make the sum of intersection cardinalities at most |U|; thus this bound is independent of the number of marking slots.
- `InitialHighFrequencyTailWeights.lean:14` notes that all subsets of a support of prime-product norm<=L also have norm<=L. The bounded-support count then implies 2^|U|<=128L. The left and right correlated bounds ensure this applies to both marked columns, including the unions with common and overlap.
- initialBeta and each Mobius factor have norm<=1; the two ray twists preserve the norm<=1 bound on Psi. The only remaining ray mass is the fixed finite sum R=sum_rho ||secondRayCoefficient(rho)||, whose index and coefficient are defined in `CubicSieve/RayCoefficients.lean:185,187` independently of all pools.

## 5. Source-key count and correlated scale

`InitialHighFrequencyTailSource.lean:15–77` defines the exact five-component key and its frequency fibers. A key together with frequency reconstructs the Point, so the finite source sum is exactly the iterated sum over keys and their distinct frequencies. No multiplicity is lost under the image operation; injectivity on each fiber is proved.

`QuadraticSieve/PrincipalDifference.lean:632–651` counts bounded supports by mapping a support injectively to the product of its distinct prime ideals. Uniqueness uses the injected ideal family. `Mellin/InverseContour.lean:306` bounds nonzero ideals of norm<=L by 128L, from the explicit 64(floor(L)+1) ideal count and L>=1. The latter is obtained by injecting ideal generators into a bounded Eisenstein lattice region in `Hecke/FiniteEulerFactors.lean:430`. Thus each of the five supports has at most 128L choices, irrespective of pool cardinality:

    number of source keys <= (128L)^5.

For each fixed key, all five norms are >=1. `InitialHighFrequencyTailScale.lean:12,22` uses C>=1 and the two correlated column bounds to obtain

    d*v^2*n1*n2 <= L^3,
    Z^m/(d*v^2*n1*n2) >= Z^m/L^3,
    |Z^(-D)*Z^m/(d*v*sqrt(n1*n2))| <= Z^(m-D).

Combining the fixed-key radial bound, the two marked-column factors and the five-key count yields exactly `original_physical_tail` (`InitialHighFrequencyTail.lean:14`):

    ||physicalBlock|| <=
      (128L)^7 * Gamma*R*Z^(m-D)*B1*B2*C seminorm_s(Phi)
       /[min(1,Z^m/L^3)^2*(1+T)^A].

The exponent seven is therefore five support choices plus two marked columns. No factor depending on the cardinality of the finite source or frequency sets remains.

## 6. Rapid order and the actual high-radial gate

`InitialHighFrequencyTailPower.lean:9,39` proves the full scale inequality. Since L<=Z^Lcap and m>=-Lcap,

    min(1,Z^m/L^3) >= Z^(-4Lcap).

The numerator contributes 7Lcap from L^7 and at most Lcap from Z^(m-D). The squared inverse minimum contributes 8Lcap. With T=Z^tau the tail contributes at most Z^(-tau*A), giving

    (128L)^7*Z^(m-D)/[min(1,Z^m/L^3)^2*(1+Z^tau)^A]
      <=128^7*Z^(16Lcap-tau*A).

Choose a natural A>(16Lcap+saving)/tau. This is done before Z,L,m,D, all arithmetic families, and all finite sets. It works also at Z=1 and for nonpositive saving. The final theorem replaces R by R+1 to retain a strictly positive C0. Its finite seminorm set is the one selected for this A, not one chosen after examining Phi or the source.

The tail predicate is not automatic for every physical point. `InitialHighFrequencyTailGeometry.lean:16,42` provides a concrete sufficient gate: lower bounds C>=Z^B and q>=Z^H, upper bounds d<=Z^(theta+eta), L<=Z^(D+eta), and both correlated columns give actual radial argument >=Z^(radialCenter-3eta). Hence eta>=0 and radialCenter>=4eta+tau imply the required >=Z^tau. This geometric implication was read; the selected campaign's complete division into high-radial and complementary regions is outside this audit.

## 7. Exact boundary of this conclusion

The independent reviewer reconstructed the radial CLM, lattice majorant, finite-tsum passage, and rapid exponent selection; the author also read these consuming proofs, and traced the coefficient and key-count branches above. No mathematical discrepancy was found in those bodies. This does not promote every imported foundation to independently audited status.

Remaining lower foundations include the standard Fourier continuous-linear Schwartz theorem, the composition/topology seminorm APIs, the trace/Fourier normalization and lattice-coordinate identities, normalized finite Gauss norm and character self-pair identities, unique factorization/injectivity of prime-support products, and the underlying explicit lattice count. Their concrete uses are identified above; no additional final mathematical premise is proposed.

`InitialHighFrequencyTailInfinite.lean:12,21,25` separately proves bounded-weight radial summability and a radial tsum tail by first establishing Summable, then passing uniformly bounded finite sums to the limit. The current rapid physical-block theorem itself quantifies only finite S. An infinite physical-source statement would still require its correct key/fiber summability and reindexing adapter; it is not inferred merely from the absence of cardinality factors. In particular, no divergent physical tsum is accepted as zero.

No source, frozen earlier report, declaration, dependency or runtime configuration was changed. No build, analytic function evaluation, or production scan was performed. All conclusions here are bounded mathematical/source findings; the provider's complete proof and target-version/kernel validation remain separate.

## Source pins

Each range gives the inspected file's full line span for stable navigation, not a claim that every unrelated declaration in that span was independently audited. The sections above delimit the bodies used.

| Source | File span | SHA-256 |
|---|---|---|
| Inversion/InitialHighFrequencyTailRapid.lean | 1-66 | 53FDA6A2E82B6C38E4595C3148BDEAB49235F36F685D8A0960F59BCF01473AED |
| Inversion/InitialHighFrequencyTail.lean | 1-88 | B5930642B1651B658EF159746824796E0128A48373EA6EC35D83D190FCD6870C |
| Inversion/InitialHighFrequencyTailPower.lean | 1-57 | 93701D33339158B202D04D138A5469BFDFB1E411571EC3D49D5376AE1BB56046 |
| Inversion/InitialHighFrequencyTailFiber.lean | 1-90 | CC1D39EE0DF1E746EBDBD0A1BC4600CA97B33F6C591D4A6351A4009C0D4B3222 |
| Inversion/InitialHighFrequencyTailAggregate.lean | 1-31 | B266F812374BEA7356119E98087343513BB77AC9D69747087A106612EB89757F |
| Inversion/InitialHighFrequencyTailScale.lean | 1-78 | A70322FB284FB427DF81E631F59A7779503087870D0CE2D0BE4617C9CA79D8AE |
| Inversion/InitialHighFrequencyTailCoefficient.lean | 1-86 | A2EB2A68A7BAA36968D87413C2698270224A67A01A230B6F90473E7C0049CD2D |
| Inversion/InitialHighFrequencyTailSource.lean | 1-83 | 481BB3E146F89E4A24E08F3FE1C3B7006F8138485E7EC335E243C52E6208B3A4 |
| Inversion/InitialHighFrequencyTailKernel.lean | 1-103 | 62FD8695AAAF9E7E44731D6F6F5986B6F1940400D7CF11D32FC18623A421A5D4 |
| Inversion/InitialHighFrequencyTailWeights.lean | 1-56 | 60965579BEA2233186CBF7C92697C8067FE3AFA71A09859F9DF85A34C9F072DD |
| Inversion/InitialHighFrequencyTailGeometry.lean | 1-59 | 06BF46C85583F2D694A3876144CB14D34A44AFEC9406EEF6749D938C8A6A3481 |
| Inversion/InitialHighFrequencyTailInfinite.lean | 1-55 | DC799D17448ADB67FBDA35D045CF12B0E7D07366206BED350BD6D52FB533EEC8 |
| Inversion/InitialPhysicalMeasure.lean | 1-482 | 4E34DE8B8777EBB75998F7B484643D4DA6D63F222C352C531655836D0D8B0751 |
| Inversion/InitialProfile.lean | 1-584 | 83B1C5FEC03CCE64C50DE747EA3F3F518A1569633B35592A67D89E79D57ECA19 |
| Inversion/InitialArithmetic.lean | 1-381 | 5E368A359177146C65C00F3CEE8D2B7B4B36CABC956CA1B2A19C458A6D74C00C |
| Inversion/InitialKernelBridge.lean | 1-389 | F4CDFD1EED22258A4F0C4F4FD6E9A165BA9CE564F9BCC36AC10ECD43B9C1AD35 |
| Inversion/InitialEnergyCallerWeights.lean | 1-63 | E047A77618A056D2663D6C2F29FDFB19D3756AEDA97B2FEE5C01DD45438062C8 |
| Poisson/RadialFourier.lean | 1-625 | 86D5DEB861723EBF182C8A8489EFD29320F97049F4CCB471684C827F931C8E58 |
| GaussSum/SexticRadialPoisson.lean | 1-856 | 8DB6F0F3B850868F18706630A4F8F1DA42A345D2F0D32949B8D4CC6CB0F5D21C |
| GaussSum/SecondPoissonScale.lean | 1-950 | 60105F7CBAACC19CEC0704164673538A6924E7201F224C321580179FF88FD31A |
| Descent/Marks.lean | 1-108 | 5EB91FD55EC8FA2088E61FCC2B7E9BE1A5BCCE7503DF8DAE64E7F877CBAC191B |
| Fourier/FrequencyTwists.lean | 1-651 | 42A77DA5A9DA397B65BED79F5F44C7E6EFF707994AC27EE3A1D016F14AAEBAC5 |
| CubicSieve/FirstPassage.lean | 1-673 | 567DAF8EF52B38FFE4396AEE1379127D44B9C68CEA0E07526741649871F38A0D |
| CubicSieve/RayCoefficients.lean | 1-653 | 7661899BF8E3F925540E7B251995B5AEC8DF88AD6E75A8DC10A0FF4DA65C5D8F |
| PrimeRows/IdealGenerators.lean | 1-646 | FFD100322A61D78A44F28CE7EDEA6E7CC756D7055C5710B42809B1B2AA016949 |
| QuadraticSieve/PrincipalDifference.lean | 1-672 | DB43BA4F8848D4B6792952A9A5E42FB4B35F05DF2E878067C9892F65953ED64B |
| Mellin/InverseContour.lean | 1-674 | 07583B9AD1732A76889CA43FA78BDD98E902E0B41612F68D6CFB5ED4C5166D20 |
| Hecke/FiniteEulerFactors.lean | 1-659 | 4F65030622460B1636D6F66C43FB8175E8EF3244502BDBA48C3AAFACB2452716 |
