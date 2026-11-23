# Independent review of the minor-energy mass source join

Verdict: **PASS at paper/source level**, 2026-11-11. I read the final author join in full and found no remaining mathematical gap in its composition with the existing energy argument. The .07 mass premise is supplied by a separate unconditional finite certificate plus the reviewed finite-order transport. The energy conclusion still consumes the genuine global 7/8 zero-strip result. No new Lean proof or provider validation is claimed.

## Inputs and independent arithmetic

The reviewed final artifact is `prime-estimates/MINOR_ENERGY_MASS_SOURCE_JOIN_2026-11-11.md`, SHA256 `44B1F9CAE1397818A4F1B7152F4BB9040BB6BAE6D969ED091161A2A27CDE9DF5`. All 20 entries in its two source/artifact tables were independently hash-checked, as recorded in `minor_energy_mass_source_pins_20261111.json`.

The underlying energy argument is `mellin/MINOR_ENERGY_QRH.md`, SHA256 `A0C414E8FAEAB6C8A4768B2179635F5B42F69D118EA17EBB062AA7FD7857C0A6`. The old, explicitly uncompiled draft `prime-estimates/XiMass.lean` is SHA256 `DC2F179566C4DD7EFEBBC295CD49C1E40CD1B861EAC5555ABF6EA4377765A899`.

The accepted finite-order argument is `zero-sum/FINITE_MASS_ORDER_TRANSPORT_2026-11-11.md`, SHA256 `C62CB504C15A02CB954C35F8F5DAB5B551C483014F6FEE1F957FF37C444C5E0D`; the combined translated-mass review is `independent-feasibility/REVIEW_TRANSLATED_MASS_JOIN_2026-11-11.md`, SHA256 `A7093604DB1EFD79FCB8367F79CCF066CFC964F0366ED5A9C7E7C1DC41067FD5`.

The new independent script `minor_energy_mass_scalar_review_20261111.py`, SHA256 `3D417B572FB9A1E36ECFDFB685EE733644482D7742E202F5E32C645BAAA12914`, reads the actual old XiMass table without importing author code or running its generator. It checks all 303 lower-log certificates, independently identifies the 333 prime-power terms through 2000, computes their exact rational lower sum, checks the harmonic and log(1001) certificates, and verifies the mass/kernel/vertical/final-energy arithmetic. Its receipt `minor_energy_mass_scalar_review_20261111.json` has SHA256 `C478C5E323988D04DC2CDD4EC5C106446C20EA6DADD35F4D8384011189EF1D6C`. No transcendental evaluator, numerical quadrature, spectral calculation, Lean declaration or build was used.

## The .07 input is a sharper specialization, not the coarse translated constant

Setting c=0 in the newly proved coarse translated bound gives an upper bound of 101/40, which is far too large for this energy argument. The required route instead uses the *finite true-order transport* from that work and the old sharper s=2 identity/certificate:

    Re(xiF'/xiF)(2) = 3/2 - log(pi)/2 - gamma/2 - Re LSeries(Lambda,2).

This identity is exactly `ZeroFreeRegion.re_vM_eq` combined with `Complex.digamma_one`. It does not require the new general digamma difference series. The source `log_pi_ge` supplies log(pi)>=1.1447 without a finite RH premise. The finite certificate gives gamma>=.576715 and Re LSeries(Lambda,2)>=.56945. Thus the upper bound is exactly .0698425, leaving .0001575 below .07.

The lower log certificates match `Prelim.Small.chkLow`: split c/10^6 into integer and fractional parts, use the pinned upper bound on exp(1), and the source 12-term Taylor upper bound. The log(1001) upper certificate matches `chkStep` and its lower exponential polynomial. The harmonic inequality uses the source lower Euler sequence H_1000-log(1001). Prime-power membership and the prime base are part of the rational finite check; the proof uses the same `IsPrimePow`/`minFac` branches as Lambda. At n=0 the summand is zero. The omitted L-series terms are nonnegative, so discarding them is in the correct direction.

For any original finite zero rectangle, the accepted transport argument identifies its original `multRectD` weights with true analytic orders and bounds its positive single-pole mass by Re(xiF'/xiF)(2). This gives

    sum_rho multRectD(rho) * (2-Re rho)/((2-Re rho)^2+(Im rho)^2) <= .07.

There is no factor of two. This is not the paired Phi mass. The old energy note's convenient reference to `multRectD_eq_mult` must be understood through the new lower-level divisor proof: `xi_partial_approx` exports T>0, not T>=1. The new proof uses the actual square membership to obtain the needed containing ball, and removes epsilon with fixed original weights. It requires no finite RH, zero spacing, simplicity, low-height gap or symmetry pairing.

## Actual squared smoothing and all-height kernels

I checked the definitions in `Helfgott/Defs.lean` and `Explicit/EtaPlusSq.lean`. They give exactly etaPlus(t)=hH(200,t)*t*exp(-t^2/2), phi1=etaPlus^2 and phi2=log(t)*phi1. Under t=exp(u), their Mellin integrands are h(u)^2 E(u) and u*h(u)^2 E(u), where h(u)=hH(200,exp(u)) and E(u)=exp((beta+2)u-exp(2u)). The extra power beta+2 and the Gaussian exponent are correct.

`HHFourier.hH_eq_fourier` is the actual inverse Fourier cutoff at |2*pi*xi|<=200. The source supplies integrability, derivative identities and L2 energies for g, g' and g''. Restricting their transforms to this frequency interval and applying Plancherel gives the three contraction bounds. This is a valid paper argument but the new derivative-contraction lemmas themselves still need formal implementation. The factors 2*pi occur consistently in differentiation and cancel in the comparison with each original derivative's transform; inserting additional factors into the reported L2 bounds would be wrong.

The hBase derivative has the stated sign on [0,1] and [1,2], so hBase<=exp(1/2)<1.65. Together with the source L1 bound this gives ||g||2<2. The source derivative energies give ||h'||2^2<=19.5 and ||h''||2<19.2. The sharp 19.5, rather than 4.5^2, is retained where used.

For 0<=beta<=7/8, a=2-beta>=9/8. The scalar inequalities on E and its first two derivatives, including their |u| multiples, have the correct polynomial coefficients and signs. The finite exponential lower polynomials prove the four global z^k E maxima used; they are not samples. For z<=1 the logarithmic bounds use (-log z)z<=1/e; for z>=1 use log z<=z. These cover all real u.

The cutoff density and its polynomial multiples are integrable on a compact interval. Thus h and the derivatives used here are bounded and continuous. The E factors and their derivatives decay at both infinite ends, as do the needed factors with u. This establishes integrability and vanishing boundary terms for two integrations by parts. With F=h^2 E,

    (a^2+gamma^2) M1 = integral (a^2 F-F'') exp(i gamma u),
    (a^2+gamma^2) M2 = integral (a^2 uF-(uF)'') exp(i gamma u).

The independently checked L1 numerators are 191.9 and 633.8, respectively below 172*(9/8) and 566*(9/8). Hence the reported bounds by 172*w2 and 566*w2 hold for every real gamma, including zero. There is no hidden division by gamma or unsupported replacement of etaPlus by a compact smoothing.

The final join makes these steps explicit with D_j=(2*pi*i*xi)^j times the cutoff density. I checked the actual `hasDerivAt_integral_of_dominated_loc_of_deriv_le` and `integral_norm_sq_fourier` interfaces: compact support supplies the derivative majorant and L1/L2 hypotheses, and changing u to -u recovers the inverse-transform normalization. Its negative-tail bound C*(1+|u|)*exp(2u) and positive-tail bound C*(1+u)*exp(-u), after u>=2, are valid uniformly over the stated beta interval. In the latter case b+4<=55/8<7 and exp(2u)>=8u. The actual whole-line integration-by-parts theorem requires the two product integrability conditions and product boundary limits; these bounds supply all of them. The cutoff need not be differentiable in frequency.

## Explicit formula, summability and all-x arithmetic

I inspected `goodSmoothing_phi1`, `goodSmoothing_phi2`, `summable_SsumG`, and `explicit_formula_zeta_seq`. The first three are unconditional source interfaces. The explicit formula uses the original `zerosRectD`/`multRectD` along the actual sequence `goodSeqD ldatum_zeta`. The mass bound applies to each of those finite sums. If the actual global 7/8 provider is available, the strip theorem and x>=4.9e26>1 imply |x^rho|=x^beta<=x^(7/8). Thus the finite zero-sum bounds survive the source limit in norm. The formula already has the zeta pole term and left vertical integral; no additional zero-at-zero residue belongs in this substitution.

`phi1_vert` and `phi2_vert` have decay 1/400 and exactly the prefactors used in the old note. `norm_integral_hZeta_le_gen` gives x^(-1/2)*VgL, and `VgL400_le` bounds this by the chosen prefactor times 6.6403e6. The explicit formula's factor 1/(2*pi) must also be retained. After division by x these give the stated 5e11*x^(-3/2) and 3e12*x^(-3/2) bounds.

The logarithmic split of the weighted Lambda sum is valid termwise for n>0. Its n=0 term vanishes. Absolute summability follows from the two `summable_SsumG` applications, so the split is not a manipulation of an unconditionally interpreted divergent tsum. With L=log x, the resulting normalized error is bounded by

    .07*x^(-1/8)*(172+566/L) + 5e11*x^(-3/2) + 3e12*x^(-3/2)/L.

All factors are nonnegative and decrease for x>=X0=4.9e26. Exact endpoint checks give L>61 and x^(1/8)>2125. The zero part is at most 38703/6481250; the vertical part is below 10^-27. Their sum is strictly below .006.

The source main-integral theorem has public error 1.95e-6*L+5.3e-7, irrespective of its sharper-looking comment. Applying this bound yields

    S(x) <= (.64621*log x-.021095)*x
          < (.65*log x-.021095)*x.

The arithmetic script checks the more precise coefficient before rounding to .64621. This is an all-x argument, not a test at one numerical x.

## Consumer and proof-status boundary

The actual `MinorTotal.T_le` uses the old Platt-dependent Prop715 equality and its error bound, but its final comparison needs only the summed upper energy bound and summability. Replacing that path with the new upper-bound theorem is legitimate. It does **not** prove the old function `sig` unchanged: its .640208 leading coefficient must be replaced and the downstream constants must be re-established under the revised interface. The separately reviewed .65 scalar campaign is not re-proved by this mass review.

The fixed energy route needs the actual global 7/8 zero-strip theorem, whose compatible build/type/axiom validation is a separate gate. It needs no finite spectral certificate once the unconditional mass proof is supplied. The remaining new mathematical statements have paper derivations: Fourier derivative contraction, weighted Mellin substitution and integration by parts, finite-zero limit bounds, and the real summed energy assembly. They are still new formal lemmas to implement, not already exported source theorems. The old XiMass draft and its finite checks must likewise be compiled and axiom-audited before being consumed as Lean theorems. No full minor-arc theorem or Goldbach theorem is certified by this review.
