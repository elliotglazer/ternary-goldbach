# Independent review of live-allocation common energy

Verdict: PASS within the bounded source/mathematical scope, with no correction requested. This review binds `independent-feasibility/QRH_LIVE_ALLOCATION_COMMON_ENERGY_AUDIT_2026-11-11.md`, SHA256 `67B64EAE035944821BEA870E7B62972464B2E233DBF2BBF6569A17F9162A5C54`. I read that report in full and independently matched all 18 source hashes. The source baseline is `work/openai-math` at `4eaee87548250b2682affda7d05d947c05554bae`.

The result is a transfer from actual child-energy bounds. It is not an unconditional bound on those children, a proof of an induction's admission hypotheses, or validation of the full QRH provider. No Lean build, declaration, analytic evaluation or frozen-file edit was performed.

## 1. Exact energy and allocation objects

`Moments/CommonAllocationSum.lean:14–26` constructs allocation labels as an image of the finite original tuple box under support extraction, then filters by the exact product condition product B_i=C. Different original tuples may share one label. The inner coefficient sums retain their multiplicities; the allocation count alone does not count all original tuples. Every coordinate B_i is nonzero, and each divides C. At lines 79–90 the map into functions valued in `idealDivisors C` is explicitly injective, giving

\[
\#\mathcal A_C\le d(C)^{\#\text{coordinates}}.
\]

The actual coordinate type is the original slot type plus `Fin 2`, not just the slot type. The two plain factors are therefore included in the cap N+2 used later.

I read the allocation identity at `FirstPhysicalSourceOriginalData.lean:25–103`, including the actual allocated-data and common-Gauss definitions. It retains the coprimality gate with C, the mask L dividing the residual column, the same height coefficient, and the puncture R*C in the child. The argument is a finite coefficient decomposition followed by linearity of the Gauss polynomial and exact change of its finite supported column domain. `SourceAllocationEnergy.lean:15–21`, `LiveDomain.lean:49–110` and `CommonPuncture.lean:14–65` confirm these immediate operations. They do not invoke a norm estimate to replace an asserted coefficient equality.

The allocated energy is a full radial lattice sum of a square norm. It is not the finite-row field of the generic input. In particular `CommonRadialData.commonData` fills generic row fields with an empty set and zero weight, but `AmplificationChildInput.lean:210–216` defines `childNormalizedGaussSource` using the actual `sourceGaussEnergy` and positive child volume. The equalities in `FirstPhysicalSourceAllocatedInput.lean:21–57` match the finite columns, coefficients, volume and resulting energy exactly. Empty auxiliary row fields therefore do not trivialize the target.

## 2. One Cauchy count and legitimate lattice summation

Let A_C=#mathcal A_C. `FirstAllocationGaussEnergy.lean:57–97` applies

\[
\left|\sum_{B\in\mathcal A_C}f_B G_B(z)\right|^2
\le A_C\sum_B|f_B|^2|G_B(z)|^2
\]

pointwise. This introduces one count, not an orthogonality assertion. It multiplies by the nonnegative real sampled radial weight. `allocated_hasSum` and `allocated_nonneg` at lines 37–55 justify passage from finite lattice partial sums to the actual allocated energies. Positivity is only required at the sampled lattice radii, exactly as in the theorem. It is not necessary to assume that the whole complex Schwartz function is real or positive everywhere.

The source also proves summability: `SmoothedWindowEnergy.lean:15–21` takes real parts of the actual `gaussEnergy_summable` statement. I checked its immediate producer in `GaussEnergy.lean:17–31,34–93`: finite expansion reduces it to periodic Gauss-row pair summability against the scaled Schwartz radial test. The underlying lattice summability and Gauss arithmetic remain lower foundations. No inference in this reviewed transfer relies on assigning a default value to a divergent sum.

## 3. The inverse norm factor comes from live support

Write V for parent raw volume and r_B for `rawReduction`. `CommonRawScale.lean:13–69` and `FirstAllocationGaussEnergy.lean:99–124` give

\[
r_B=N(B_{\mathrm{plain},0})N(B_{\mathrm{plain},1})
       \prod_{i:\,B_i\ne1}P_i>0,
\qquad V_B r_B=V.
\]

A live slot here means B_i=1; a live allocation in the outer estimate instead means f_B is nonzero. These are distinct uses. For a nonzero frozen coefficient, each frozen window is nonzero at N(B_i)/P_i. Its support supplies N(B_i)<=b P_i. A live slot has N(B_i)=1. The two plain factors stay exact. Thus `CommonRawScale.actual_reduction_norm:89` proves

\[
N(C)\le\max(1,b)^{\#\text{slots}}r_B.
\]

The lower comparison with min(1,a) is also proved but is not the source of the needed upper inverse bound. `FirstAllocationGaussEnergy.frozen_normalized_bound:153–181` combines the displayed inequality with |f_B|<=F_B, where F_B is the product of frozen controls, to obtain

\[
\frac{|f_B|^2}{r_B}\le
\frac{\max(1,b)^N}{N(C)}F_B^2.
\]

Zero coefficients are handled separately as zero terms; their window support is not invoked. Every inversion is of a positive raw reduction or positive N(C). This explains the gain 1/N(C) independently of the counting argument.

Dividing the first energy estimate by V and using V_B r_B=V gives the exact factor (|f_B|^2/r_B) times the normalized child energy. The source proves that child energy nonnegative before replacing its multiplier by this upper bound. Hence the multiplier comparison has the correct sign.

## 4. Both counts are paid

`FirstPhysicalSourceAllocationControl.lean:19–38` proves the complementary product identity

\[
F_B\prod_{i\text{ live}} M_i=\prod_iM_i.
\]

The child control vector is exactly the restriction to live slots. Squaring this identity requires no division by a control and no separate nonzero assumption. Consequently

\[
\sum_{B\in\mathcal A_C}F_B^2\left(\prod M_{B,i}\right)^2
=A_C\left(\prod M_i\right)^2.
\]

Extending from nonzero frozen coefficients to all allocations is safe because E>=0 and the squared controls are nonnegative. This contributes the second count. The target does not silently pay just one count.

I independently checked `AllocationCost.lean:13–36` and the underlying fixed-field divisor proof at `QuadraticSieve/FiniteOperator.lean:281–410`. The latter bounds each prime exponent factor e+1 by a geometric norm factor, paying a fixed constant only at finitely many small prime ideals. Norm multiplicativity then gives d(C)<=D_delta N(C)^delta uniformly for nonzero C. For a coordinate cap Q the allocation proof takes delta=eta/(Q+1), enlarges the base to at least one, and obtains A_C<=D N(C)^eta, including empty coordinate types.

`allocated_control_mass:40–67` applies that result with Q=N+2 and eta=epsilon/2, and squares it explicitly. Thus

\[
\frac{A_C^2}{N(C)}\le D^2N(C)^{\epsilon-1}.
\]

Combining the displayed formulas proves the reported transfer. No radial Fourier estimate, later sieve gain or child-energy conclusion is imported to produce this count or inverse-norm factor.

## 5. Quantifiers, power extension and degenerate cases

`FirstCommonSourceBudget.lean:73–109` chooses its positive constant after N,a,b,epsilon and before the finite input type, pools, C,R,seed,character,height,L,W,K,E. The proof constructs the constant from the uniform allocation bound and max(1,b)^N. The statement retains seed|C, Supported C, positive physical scale, nonnegative sampled radial weight, E>=0, and the bound on every nonzero frozen child's actual normalized energy.

The pools are finite with nonzero members; their nonemptiness is not an extra premise. If no allocations exist, the exact polynomial decomposition makes the common polynomial zero. The unit ideal C is permitted, but C=0 is excluded. A zero child bound E or empty family of power terms forces a correspondingly zero upper bound under the stated child premises; it is not independently assumed attainable for every input.

`AmplificationChildSourceCaps.lean:41–74` proves V_B<=b^N V/N(C) for nonzero frozen coefficients when b>=1. The power version at `FirstCommonSourcePowerBudget.lean:17–47` then uses nonnegative exponents and nonnegative coefficients. Its constant is independent of how many power terms are supplied. Negative exponents or signed coefficients would not justify the same monotonicity step and are not allowed. The linear-volume specialization at lines 49–83 separately acquires the additional 1/N(C), yielding epsilon-2, with b^N incorporated into its constant.

## 6. Remaining boundary

I found no correction to the frozen report. The finite allocation mass, support gain, actual volume normalization, sign conditions and final constant dependencies are sound in the inspected source.

The lower support-extraction and residual-tuple bijections, prime-slot freezing identities and full masked-profile derivations are retained where the report places them. Their immediate finite reindexing calls were checked, not their entire transitive arithmetic development. Likewise the underlying periodic lattice/Gauss summability and fixed-field ideal factorization/finiteness facts remain dependencies.

Most importantly, every live child's normalized energy bound remains a genuine hypothesis. This transfer neither establishes that analytic bound nor checks its admission in a later induction. There is no claim here of full provider validation or compatible Lean elaboration.

## Source pins

Paths are relative to `lean/OAI/NumberTheory/DirichletL/`. All 18 frozen author pins matched. The additional files listed below bind the immediate source checks described above; they do not imply full-file validation.

| File | SHA256 |
|---|---|
| Moments/FirstCommonSourceBudget.lean | `C409066589A7187C223E1A60088B1E8BC4E6F0A8FFC444FD94DF45DF393E3A4C` |
| Moments/FirstCommonSourcePowerBudget.lean | `F369306E785677A776C3BAF09EAE64B6D834141E294F504F690FE1054DC346D1` |
| Moments/FirstPhysicalSourceAllocationControl.lean | `0C0BC48310A6D5A18A79372A2B9CCF9137A0B23F3F5A0F76DB799EEC590B2EC9` |
| Moments/AllocationCost.lean | `8B42C5DAA737360A53E2DED445FEA04C273ED8C567EE92E181C31A0DB8567E0C` |
| Moments/CommonAllocationSum.lean | `7630E12A9729D0820E7D3DDA157E59DE6D311CC26F2B541850C632C8B2647B7F` |
| QuadraticSieve/FiniteOperator.lean | `4A8A56A5AC5A218C00616F40749B33A1942DC65F579BB6DF216F039EC2BA32BF` |
| Moments/CommonRawScale.lean | `9167B10E42D1321F176FC86CA23BA89EC8758E34CF71B9413D4C06067D79067B` |
| Moments/FirstAllocationGaussEnergy.lean | `816D14E0E9E9FEA44DA0BD6A3434869A91423BFFEC65BF849157BA48E542A6C1` |
| Moments/FirstPhysicalSourceAllocatedInput.lean | `F8BE7972BD1604B5682330EA9B6720644FDD6B5E5B28DD0FE79A469531AD534C` |
| Moments/FirstPhysicalSourceOriginalData.lean | `F3DD66FE9B2A1B65422FCAD04DBD0DB99E0C22583BF1F93D7EC1317C67D961BB` |
| Moments/AmplificationChildSourceCaps.lean | `2E8C744EBA824E73580216150557A7AC8525C405823997675D2F6918C18DBF8B` |
| Moments/AmplificationChildInput.lean | `EF430B59F9C352E98CC2B7DE3C0B3045D93E3A4F3110B723268730EDB9976EC0` |
| Moments/CommonRadialData.lean | `20CD6C8F88BEC6A294DBCB3EE0C80EEAA74A095452B2353F2B36D58774B96E6B` |
| Moments/CommonProfile.lean | `79A92558A50057439C252B603D45C1CB5D7044457D8041B4A0289B168007DA26` |
| Moments/SourceLiveColumn.lean | `86DB65FAB3858521F724456A3CDB61D6C17062A4E3E788FD3F371D070FDB8F30` |
| Moments/SmoothedWindowEnergy.lean | `448DFDA39CD97DB6E875F0CE4D885FE5600F90498ED5797C087BE1969B459575` |
| Moments/EligibleEnergy.lean | `A482485229654996866B3BA2230533521D9CACB553524D29A6DB49B9AD25C0D2` |
| Moments/ActiveDivisorShell.lean | `7615F59BDBA12C6766FF35EA65E1045DD88E2F22BE75F3E3129ECCC49746221A` |
| Moments/GaussEnergy.lean | `4F2FDD3D94CC5DF1330DEB4EBAF1CCA0132A2781AEA9170BAE0E113B82BD87B8` |
| Moments/SourceAllocationEnergy.lean | `148A9C0E5DAA8873A5D3192D8812E886C98851CA58C77618E98671BF5709C6F2` |
| Moments/LiveDomain.lean | `C79A4C02EDFF990021727C44C0A8F8897ED630C41010DEA79429D8AC15735C15` |
| Moments/CommonPuncture.lean | `25E876BAE3CBDF4E642D4A9F75A1828B1F1D16D047FC90E2B443FC2DCD529BEE` |
