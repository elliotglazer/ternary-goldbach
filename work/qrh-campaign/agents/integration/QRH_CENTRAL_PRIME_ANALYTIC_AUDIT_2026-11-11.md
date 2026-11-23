# Central prime estimate and actual phase comparison — 2026-11-11

## Scope and result

This is a bounded mathematical/source audit of `ProbeCentralPrimeSum.actual_central_prime_sum`, not a compiled theorem, an axiom audit, or a proof of global QRH. The inspected source gives a substantive estimate: exact local normalization separates a phase, an ordinary error, and a repeated-prime contribution; the last contribution gains a half-power at each selected prime only after it is multiplied by the same row L-function. The phase is the actual inverse-row prime amplitude, whose source estimate supplies the bin upper bound. No gap or result-shaped replacement assumption was found in the cut reconstructed here. The deeper analytic inputs listed below remain separate obligations.

Source base `B = work/openai-math/lean/OAI/NumberTheory/DirichletL/`, at repository commit `4eaee87548250b2682affda7d05d947c05554bae`. References below are relative to B. File hashes are at the end. This continues the accepted normalized-cell audit; it does not repeat the final detector contradiction.

## 1. Exact estimate, hypotheses, and uniformity

`Detector/CentralPrimeSum.lean:13` fixes N, 0<e<1/1000, eps>0, positive support endpoints c,d, a nonnegative weight bound B0, and a finite exclusion set S satisfying SourceExclusions, FirstTail(4e), and maximality. It then chooses C>0 **before** the FreeRow u, character eta, finite twist family, T0,a,i, prime pools, weights, scales, complex variables, and allowances p.

Write U=rowNorm(u), H=(3i+2)T0, and Q=Norm(P). The later inputs require u.val!=1, T0>2, 51/100<=a<=1, and the actual sourceDetectorFamily maximum at 3(i+1)T0 to be <a+2e. The N pools are pairwise disjoint, outside S, coprime to eta.modulus, with Q>=480 and 198 Q^(-10e)<=1/2. Each Y_j>=1; each W_j has support in [c,d] and norm <=B0. The complex coordinates satisfy

    Re x=a+16e, Re w=1-a-6e, Re z=17/50,
    |Im x|, |Im w| <= H.

There is no Im z bound in this central theorem. That bound belongs to the subsequent production of the phase allowances, not to the local estimate. For p_j>=1 and the **actual** phase sums bounded by Y_j^(-4/25)p_j, the conclusion is

    ||sum over one prime from each pool of calibratedTupleValue||
      <= C Norm(eta.modulus)^(2eps)
           U^(a-1/2+12e+eps(N+8)) (3+H)^(2+4eps)
           product_j Y_j^(-4/25) product_j p_j.

The phase premise is not discharged by choosing arbitrary bins: Sections 5–6 explain its actual source producer. The local pool lower bounds and FirstTail are likewise real hypotheses, not conclusions of this theorem. This cut does not re-audit their eventual-scale discharge from the full detector assembly.

## 2. Exact normalization and local alternatives

`PrimeRows/CentralSplit.lean:13,19,22,27,31` defines the normalized local slot as the continued compensated local factor divided by its supported correction. A repeated prime divides (u) with actual multiplicity at least two. The identity is exactly

    normalized slot = -star(idealRowHom(u,P)) + regular error + repeated term.

On repeated primes the regular error is zero; on other primes the repeated term is zero. The phase vanishes on ramified primes. `central_actual_local_bounds` at line 42 proves, under the stated smallness and support conditions:

    ||supported correction|| >= 1/2,
    ||regular error|| <= 1440 * (Q^(1/2) if P divides (u), else Q^(-51/100)),
    ||repeated term|| <= 812 Q^(1-Re w) on repeated primes, and zero otherwise.

These are not estimates on a freely chosen surrogate slot. `CentralNormalized` and `CentralRamified` identify the continued factor with the actual local closed expression. In the unramified case the numerator error is <=720 Q^(-51/100), and division by a factor of norm >=1/2 gives 1440. The ramified quotient gives an ordinary 800 Q^(1/2) term plus 12 Q^(1-Re w); for multiplicity >=2 the former is absorbed into the displayed 812 bound. FreeRow supplies multiplicity <6.

`PrimeRows/RestoreCorrection.lean:23,47,74` restores the finitely removed Euler factors using HasProd and explicit nonzero denominators. `CentralProduct.lean:20,53` then gives the exact calibrated tuple identity and separates the finite tuple sum into a product of finite prime sums. Pool disjointness implies the injectivity needed by this identity. There is no unproved exchange of infinite sums and no cancellation by a potentially zero correction in this step.

The ordinary-error sum uses `CentralSlotSum.lean:12`. Multiplying the local error by Q^(1/2) gives a bound by 1440 times Q on divisors of u and by 1440 elsewhere. The shifted weight exponent has real part Re z-1/2=-4/25. `SelectedPrimeSums` combines the finite ideal count <=128X with a divisor subpower bound, then uses support to restrict Q to an annulus comparable to Y. It yields C U^eps Y^(-4/25). This ordinary-error argument needs ideal counting, not a prime number theorem.

## 3. Why repeated primes still save a half-power

Bounding each repeated term independently would lose the needed saving. `Detector/RowRadicalConductor.lean:198,245,276,318` instead produces one primitive character psi underlying the row and the inequality

    Norm(psi.modulus) * product_j Q_j^(m_j-1) <= C_S U,

for every injective selected family with P_j^m_j dividing (u). The character is selected before the family and multiplicities. The same psi is used in the reflected L-function estimate; the proof does not choose incompatible primitive presentations for different factors.

The underlying ideal argument is concrete. Distinct selected prime powers have product dividing (u). Writing (u) as that product times an ideal B1 gives the radical norm bound by product_j Q_j * Norm(B1). Multiplication by product_j Q_j^(m_j-1) recovers U. The raw row has a presentation controlled by the radical, proved using local row congruence and passage to a primitive character.

Put A=a-1/2+6e>=0. For m_j>=2, `RowReflectedAllocation.lean:30,37` proves

    -(1-a-6e) <= (m_j-1)A - 1/2.

Raising the conductor deficit to A therefore gives a factor Q_j^(-1/2) for each selected repeated prime. The analytic companion at lines 126,160,192,229 uses the reflected argument 1-conj(w), whose real part is a+6e and whose imaginary part equals Im w. Buffered regular control, the reflection bound and the finite deletion factors give the joint estimate for

    ||star(calibration(u)) * continued rowL(w)|| * product_j Q_j^(-Re w).

Calibration zero is handled by the exact zero product. Otherwise the source proves the needed row nonprincipality and identifies the continued function with that L-function. It does not divide by calibration or assume it is always nonzero.

`CentralRepeatedProduct.lean:25,53` adds the weighted local factors. `CentralRepeatedChoices.lean:35` bounds the number of active tuples by a divisor subpower, using eps/(N+1) and k<=N. `CentralRepeatedSum.lean:14` uses annular comparison and this counting bound. `CentralRepeatedSubset.lean:12` transports the result to every subset of the N slots, including the empty subset. Thus, for L=||star(calibration)*continued rowL(w)||,

    L * product_{j in J} ||repeated-slot-sum_j||
      <= C rowCost U^eps product_{j in J} Y_j^(-4/25).

The empty subset supplies the bound for L alone. No division by L, no assumed nonempty selected family, and no assumed positive local amplitude are used.

## 4. All-slot algebra and exact remaining powers

`CentralBranchProduct.lean:9,22` expands finite products over subsets. Combining the subset estimate above with phase allowances and ordinary errors yields

    L * ||product_j (phase_j+error_j+repeat_j)||
      <= C rowCost U^(eps(N+1)) product_j Y_j^(-4/25) product_j p_j.

The constant includes a factor (C_regular+2)^N. The use of U>=1 and p_j>=1 is explicit in `CentralAllSlots.lean:18`; there is no missing subset-count factor. Constants may depend on fixed N and support data. This is not a computational cost claim.

The residual scalar is defined in `PrimeRows/CentralCosts.lean:14`: the principal L-value at 6z, the reciprocal target factor at x, and continuedCorrection. Re(6z)=51/25>2 permits the principal L bound by absolute convergence, independently of Im z. Buffered reciprocal control handles the target factor with its pole cancellation; it does not assume a nonprincipal target. `FirstContinuation` bounds the ramified product by a divisor subpower and the unramified part using FirstTail.

`CentralTargetCost.lean:60` gives residual cost

    C Norm(eta.modulus)^(2eps) U^(3eps) (3+H)^(2eps).

`CentralRowCost.lean:25` gives

    rowCost <= C U^(a-1/2+12e+4eps) (3+H)^(2+2eps).

Hence `CentralTargetCost.lean:85` has row exponent a-1/2+12e+7eps and height exponent 2+4eps. The all-slot factor adds eps(N+1), giving exactly eps(N+8), as the explicit rpow identity in CentralPrimeSum confirms.

## 5. The phase really is the source prime amplitude

`Detector/RayPhaseAmplitude.lean:22,64,91` proves the exact finite-pool identity

    phase = -D^(z-1/2) * canonicalPrimeAmplitude,
    ||phase|| = D^(Re z-1/2) ||canonicalPrimeAmplitude||.

Positive real D fixes the complex-power conventions. Open support in (A,B), together with the eventual bound Norm(P)<=AD for each excluded prime, makes the omitted terms exactly zero, including support endpoints. No approximate removal error is hidden here.

`RayCharacterFamily.lean:73` identifies that amplitude with the ray prime polynomial of rawRow(u).inverse, at shift (1-Re z, Im z). The inverse supplies star(row coefficient). W is not conjugated, and the frequency is not negated. Its line 36 proves that all ray twists are nonprincipal for sufficiently large supported FreeRows: a principal twist would constrain u to fixed exceptional prime support, and the sixth-power-free condition bounds such a row. Line 65 controls their conductors.

`Hecke/PrimeAmplitudeActual.lean:15`, `PrimeAmplitudeScale.lean:11,36` and `PrimeAmplitudeBins.lean:11,21,44,106` give the actual capped logarithmic bin. A separate analytic upper bound for the actual prime polynomial is essential. The strict gap eps<rmin*mesh absorbs its uniform constant as Z grows; clipping a bin alone would not prove an upper estimate. Zero amplitude is allowed. A lower/spike bound is asserted only for positive bin g.

`PrimeRows/CubePhaseBins.lean:17` makes the threshold uniform before eta,u,a,i,r and all admissible heights. Here i<=n is bounded, row size is between Z^delta and Z^(d-nu), nu>0 absorbs the fixed conductor constant, and 2tau<dmin*cost absorbs the height square. Its hypotheses also include 8eR+kappa<=eps and eps<rmin*mesh. With D=(Z^d)^r, it gives

    0<=g<=a-1/2, ||Q||<=D^(g+mesh),
    g>0 implies (Z^d)^(2rg)<=||Q||^2,
    ||phase||<=D^(-4/25+g+mesh).

Taking p=D^(g+mesh)>=1 supplies the central theorem's allowance. This is an actual source comparison, conditional on the stated source zero maximum and scale budgets, rather than an independent assumed prime cancellation statement.

## 6. Deeper analytic boundary and what was checked

The author read the bodies of the local normalization, restoration, radical deficit, reflected-allocation, finite all-slot, row-cost, and phase/bin comparison files pinned below. The independent reviewer additionally reconstructed the prime-estimate path through `Hecke/PrimeRay`, `PrimeBin`, `PrimeDyadicSource`, `PrimeDyadic`, `PrimeDyadicControl`, and `PrimePowers`:

- Ray character averaging has its class-number denominator; summing the uniform twist bound cancels that number.
- PrimeDyadic's series is -L'/L with coefficients Lambda(I)*idealCoeff(chi,I). `polynomial_mellin` at line 107 uses the 1/(2pi) Mellin normalization.
- The finite rectangle identity retains the central edge, signed horizontal edges and exterior right-line tail. No infinite horizontal limiting argument is silently substituted.
- Buffered logarithmic-derivative control is obtained from primitive disk control plus finite-deletion derivatives and the actual source zero maximum. Profile/height losses are absorbed with the declared scale budgets. Proper prime powers are removed by an exact extraction identity and a powerful-ideal bound.

This supporting reviewer reconstruction is not presented as an independent second author audit of all those deeper bodies. The independent final review should be read with this note.

The still-unvalidated lower mathematical cut is explicit:

1. Actual local Gauss/selected-polynomial identities behind the 720/800/12 estimates, the ramified lower correction estimate, and the first-region Euler-product majorants.
2. Local reciprocity and actual periodic-row construction beneath the radical presentation/nonprincipality results; the divisor subpower, finite ideal count and powerful-ideal count foundations.
3. The primitive analytic growth, Euler-log input and generic logarithmic-control theorem beneath `Hecke/LogarithmicActual.disk_control`; the reflection theorem and finite-deletion analytic estimates. This round inspected their consuming identities and buffers, not their full analytic proofs.
4. Weighted Mellin inversion, uniform logarithmic-profile Mellin decay, and the contour-integration foundations used by the actual prime estimate.
5. The already separately identified detector moment, normalizer and other analytic branches. A central prime estimate alone does not establish their conclusions or global QRH.

The source does provide producers for these inputs; they are not proposed new final assumptions. No Lean check, transitive axiom check, elaboration result, or standard-axioms closure claim was obtained in this audit. No numerical function values or new finite spectral evidence were generated.

## Source pins

Paths are relative to B. Hashing is a read-only provenance check, not theorem validation.

| Source | SHA-256 |
|---|---|
| Detector/CentralPrimeSum.lean | 7460FFE9A3C50780C22322455FE9222E4CFC8229BD7902FBD66A8D5C7AF3F911 |
| Detector/CentralAllSlots.lean | E339EB9D875C180B9A894FEB6873CA3E26DC7AC60F0986BB3DA16B62B29866C8 |
| Detector/CentralBranchProduct.lean | 86160C034FD74C07B458139D1482A77E79EC6B5427E3BAA60811256EC7A1A43E |
| PrimeRows/CentralSplit.lean | 23A97A2FBD86CDFC1F2CF680B885B0EFA317760A93BE89285CB5C23A4D703011 |
| PrimeRows/CentralNormalized.lean | 826F27CBD7C507460936150850E152BBB9B2CA18983F4E9558434516E1B83FFF |
| PrimeRows/CentralRamified.lean | 5ADB4895FC5CDFC44A4142D24352D7617915CCF883B80BA4835B34EACF6273A9 |
| Detector/HighRowsCentralQuotient.lean | F35364E12419308D8ABB57D389FA96B32E2A5406D8B4B98F5067171E52748523 |
| Detector/HighRowsCentralSelected.lean | 7E5F2CA4D34A8ADEAF3BBC0D07C9067D7A2AFEEE14B7DEEA0B247450B90C647B |
| Detector/HighRowsCentralRamifiedQuotient.lean | 8545C52C9A1F6A42023B6820E6CBFD4B92B2A7566D5EAF0C732AD10197617F02 |
| PrimeRows/CentralProduct.lean | 849C29C488E2D4687E2C55D94827DA611EB739987B9CBF1428B25D4EAC37F20A |
| PrimeRows/RestoreCorrection.lean | D60EE7D849B06D09A15C2F702F2FD895EB0C3201599209E047BBB7895C337C29 |
| PrimeRows/CentralSlotSum.lean | 165AB52E1164BDD623D210F1379FCB9622BF17B95D7507D96E4DF0BAEBE8E79A |
| Detector/SelectedPrimeIndexed.lean | 4263B7F2007281BF08F011B19EB4663BC724182764904B308CDE1CCADD12122F |
| Detector/SelectedPrimeSums.lean | C90769CBB9672144A04AF9DE9B1949FA8473AE83CECE1E05C9561EA9FF7C9CCA |
| Detector/CentralRepeatedProduct.lean | DE6A14E1539C7153AF7289E19372856800D6398F1BC3086DD1EE9883977BF1DB |
| Detector/CentralRepeatedChoices.lean | 5D886D3A8CC28C10A8B9894EF22734F0AE3FC2E6F6380189F9D124F03F9FF10C |
| Detector/CentralRepeatedSum.lean | EE9CD3DFD7FDE1A5A914F4001ECE92D34B7832E6960E682F692907A5244DDD2A |
| Detector/CentralRepeatedSubset.lean | E2CBDC8814023471BD57AF9F12CE7FE4018EA891F60702D474AB50A179CF8510 |
| Detector/RowReflectedAllocation.lean | 2E575B996F35DF98A1841E953750B4E3DBB372A989EF922F9C7BA1474CC904CB |
| Detector/RowRadicalConductor.lean | 30E9551DF83568E25F1C3182B4EA82826865124E54074D548100B6FE53B04357 |
| PrimeRows/CentralCosts.lean | E49BBECF52EEEDFE56C96B71E16380C70A54144A62CE358E9A0312560EBB7ACC |
| PrimeRows/CentralRowCost.lean | B8A34BBB019F5D90D0163CF2F9E77E8EA79360C618A693BEDBC650558D79ABAB |
| PrimeRows/CentralTargetCost.lean | E0460D95BC1C56BC0DB9CC9D06B2FAB4C7E7264AAC5CA0E392EBED6661393941 |
| PrimeRows/FirstContinuation.lean | 42BA2F8C55F4873AA3693656CFC8BCA3E7BDA81E951BCA3560883EC4B68FC325 |
| PrimeRows/BufferedBin.lean | 878B426B575EDD9CD9108FBFB82DA185A23C2360DF901514BF8ADDE2C04D98B9 |
| PrimeRows/DiskControl.lean | F1F07053EDDA528E0F87BCEB507A1ED926E3FCC134874C16327BCE6805136819 |
| Hecke/LogarithmicActual.lean | 3B6586669D48F18C1C291F8CF81086DB7250CB05013F3086057F8C4D26300599 |
| Hecke/Logarithmic.lean | 03F29A2484577DBDDAB8B7092A7B131945CF179A87C2724320DFCF4A6AB10A8B |
| Detector/RayPhaseAmplitude.lean | C0E68045330F45EB2F9343B32ED1C537897C08D8071A0FDB9457D27FEADC7175 |
| Detector/RayCharacterFamily.lean | B8F30F1023D71966768EF4371BA111277F1AFE77FB88BD5B24FEC3A2A183041B |
| Detector/RayPhaseBins.lean | BC185990264A30900B1DCBBE13B1698A47C467CB15CFE11DE8CB23274EBC6DA1 |
| PrimeRows/CubePhaseBins.lean | 4B755990B4FE2BB40BAAA0E9F2BCA93267B1A23EFC1BC1BEB44DA7BA0A214B5C |
| Hecke/PrimeAmplitudeActual.lean | A9B286AB27D2193B9378EF6D4E1EF2316A730412B2758DC601D9B0B4C48D1D99 |
| Hecke/PrimeAmplitudeScale.lean | BBE8A96F789B0BC7FFE6EC50A12283764C174DECC69FE2280177491B499800E4 |
| Hecke/PrimeAmplitudeBins.lean | 3D441FF7D020CC8CFF5224244117ACEAC85849AD14BB08F0BE51F198C3BFB55C |
| Hecke/PrimeRow.lean | 031FAC10D8D85697F5A083A9B39EE2E63106FEDCFFF907503DD51899070F4107 |
| Hecke/PrimeScale.lean | 8D095A4DF236B45DF9842D28CA4B92D71F7F363EF703272F53B3E6B1CDA832A1 |
| Hecke/PrimeRay.lean | CA691B3732199B35B2C7A6BF1F8C1F7815D50069DC899E0DEE928DABAF7DF895 |
| Hecke/PrimeBin.lean | 49DF819F59D7D7D0F15BDEDBFC198CA579E1F5AA72C7553D717E3CACD3FBB79B |
| Hecke/PrimeDyadicSource.lean | 0BE9777D15BAAF0FE6A036557471D7DB230EDA1CE85BE78DC6E00A579D7CF5DC |
| Hecke/PrimeDyadic.lean | 31806E0A1915B831ECE1B5F6F761D57C494C57DE5BF977E214050F9C1A8AF9E7 |
| Hecke/PrimeDyadicControl.lean | 3B33CC3222945C05C787BD48C81A3CADF07402969C735FE1CE630565A98FF752 |
| Hecke/PrimePowers.lean | F7EF767AE1B7785B25C4DB74586525076C79CD690AD014D39080789B532732E4 |
