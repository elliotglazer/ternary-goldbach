# Full-family finite spectral sufficiency for second moments

Research derivation, 2026-11-11. Source pin: ternary-goldbach23b2d68ca344203d4384e0aff7affa4ec034bef9. No Lean build, canonical edit, axiom, sorry or finite-zero computation was performed. The exact arithmetic script is resume_family_caps_20261111.py; its JSON records rational upper coefficients. Analytic lemmas identified below are paper derivations, not compiled declarations.

A uniform finite strip with upper real part111/200=.555 would suffice for all the second-moment targets, using the actual conductor-dependent heights below. Separate optimizations557/1000=.557 and5573/10000=.5573 also pass the second-moment scalar inequalities; they are not the selected shared mixed-moment contract. The finite zero-free rectangles are entirely unproved. This result makes their required strength concrete; it does not discharge them or the other analytic bridges.

The primary downstream caps remain coprime Aplus<=5e-7, coprime Astar<=2.5e-7 and N<=1.23, with Ep<=1e-4 for J<=10. Astar is allocated2.5e-7 of the corrected Astar+Cross<=9.5e-7 budget, leaving7e-7 for Cross. Zero_sum handles that separate mixed fourth moment. The final major1.0404/minor1.0376/nonprime.00271 budget is unchanged.

## Certificate scope and source counts

Let Q=Qset150000: odd q<=150000 and even q<=300000. Define qt(c)=2c for odd c and c for even c, Dc=1200000/qt(c), and

    Hplus(c)=ceil(200+max(1000,(704/7)Dc)),
    Hstar(c)=ceil(max(1000,(704/343)Dc)).

These are the exact cutoffs in independent-feasibility/RESUME_HYBRID_CERTIFICATE_2026-11-11.md. There is no exclusion of high conductors. A primitive character contributes precisely when it induces into an active q with nonzero Gauss weight. Conductors with2-adic valuation1 have no primitive characters. The finite enumeration has150000 active conductors and5,543,640,188 primitive characters, including the trivial conductor-one character.

For every active primitive character require a proved upper real-part bound b on its actual nontrivial zeros through its relevant height. Taking the plus height for both smoothings is a sufficient common certificate. The global7/8 provider controls higher zeros. At every height apply the functional-equation/conjugate-character correspondence correctly; complex characters do not individually have real-character quartets.

Source ZeroSumGen.sum_multRectD_le at59, radius2.7, counts all multiplicities in each3.48 window. Dirichlet PolyDatum uses BP(c) and kappa11 (ExplicitBoundGen.lean:17); zeta has its own BPz2. The hybrid note's elementary polynomial bounds, with the small window enlargement, give fewer than400 zeros per window for all conductors and all these finite heights. Put the integer upper bounds

    Nplus(c)=ceil(400*(2Hplus(c)/3.48+2)),
    Nstar(c)=ceil(400*(2Hstar(c)/3.48+2)).

The script evaluates those ceilings exactly. These are upper counts, not lists of actual zeros. Their size is deliberately crude. No translated Dirichlet Hadamard-mass lemma is needed in this full-family route.

## Actual smoothing bounds

The Mellin worker's paper Gram lemma is

    |Mellin(etaPlus^2)(sigma+i tau)|<=min(4,428/(25/16+tau^2)),
    -3/4<=sigma<=3/4.

Its actual Fourier-projection norm and integration-by-parts obligations are detailed in mellin/RESUME_PRINCIPAL_2026-11-11.md. With400 zeros per3.48 window, its absolute Gram row sum is

    800*(16+428/(3*3.48^2))<23000.                              (G+)

For etaU there is a new elementary Gaussian-mixture Gram bound. From the actual eta2 convolution (Cor933.etaU_eq),

    etaU(t)=integral_(1/4)^1 eta2(r)*(t/r)^2*exp(-t^2/(2r^2)) dr/r.

The positive mixing measure has total mass4(log2)^2<2. In its square take two variables r,s and set A=(r^-2+s^-2)/2. Then1<=A<=16 and r^-2s^-2<=A^2. For sigma in[-3/4,3/4] write k=sigma+4 in[13/4,19/4]. The absolute zero-frequency Mellin integral for one pair equals

    (1/2)r^-2 s^-2 A^(-k/2) Gamma(k/2) <=9/2.

Indeed A^(-sigma/2)<3 and Gamma(k/2)<3: split its integral at1 and use t^(k/2-1)<=1 below1 and<=t^2 above1. Integrating the two mixing measures gives the uniform bound18.

For logarithmic variable u, the pair's kernel is H(u)=exp(ku-A exp(2u)). Gaussian moments give

    integral |H''| <=[k^2+2k(k+1)+k(k+2)] integral H
                    =4k(k+1) integral H <=109.25 integral H.

Two integrations by parts applied to H-H'' therefore prove

    |Mellin(etaU^2)(sigma+i tau)|<=min(18,1985/(1+tau^2)).       (G*)

The numerator is bounded by18*(1+109.25)=1984.5. All boundary terms vanish by the positive lower exponent k>=13/4 and Gaussian decay. Fubini and differentiating the mixture require the same integrable Gaussian domination; they are legitimate new proof obligations, not assumed kernel constants.

The corresponding row bound is

    800*(72+1985/(3*3.48^2))<102000.

Fourier Plancherel gives these kernels at sigma=beta+beta'-1. Multiplicities are repeated indices. Schur's inequality handles arbitrary phases x^(i gamma). For each primitive character the finite zero sums satisfy

    integral_R |zplus(delta)|^2 ddelta <=23000*Nplus(c)*x^(2b-2),
    integral_R |zstar(delta)|^2 ddelta <=49*102000*Nstar(c)*y^(2b-2).

Here y=x/49. The factor49 is essential because the star Mellin twist is delta/49. The reflected global strip ensures every pair's sigma is in the range used above. A finite b bound controls magnitudes without freezing phases at x0.

The other important improvement concerns P(delta)=Fourier(etaPlus)(-delta). The source's crude Gaussian envelope gives |P|<=130, which is too weak in this aggregate. The actual pointwise smoothing bridge in mellin/PointwiseSmoothingTail.md gives

    |etaPlus(t)-etaO(t)|<=.00221*t*exp(-t^2/2), t>0.

Source EtaCirc.lean:18,30 has etaO>=0, supported on[0,2], with etaO(t)<=[t(2-t)]^3. Hence

    |P(delta)|<=integral|etaPlus|<=32/35+.00221
               =641547/700000<.917.                           (P)

The true noncompact Gaussian tail is integrated, not truncated. Mellin independently confirmed this deduction. The pointwise inversion/tail bridge remains a new supporting Lean lemma. The existing source supplies |U(delta)|<=1.2534 (MajorTotal.lean:475).

## Exact family sums, with each Gauss weight once

Let a(c) denote the number of primitive characters of conductor c. It is multiplicative with a(1)=1, a(p)=p-2 and a(p^k)=p^(k-2)(p-1)^2 for k>=2. The arithmetic script enumerates phi, squarefreeness and these local factors with integer sieves.

Aplus and Astar have mu(q)^2 and therefore only squarefree moduli. Pair q=r,2r with r odd squarefree. Their per-character weight at primitive c|r is exactly2c/phi(r)^3. Thus define

    Splus=sum_(r odd squarefree<=150000) [2/phi(r)^3]
                   sum_(c|r) c*a(c)*Nplus(c),
    Sstar=sum_(r odd squarefree<=150000) [2/phi(r)^3]
                   sum_(c|r) c*a(c)*Nstar(c).

For the nonprincipal upper energy N retain all moduli and the exact induction indicator:

    SN=sum_(q in Q) [1/phi(q)]
          sum_(c>1,q=cr,r squarefree,(c,r)=1) c*a(c)*Nplus(c).

No primitive conductor suppression is introduced. Each character induces once, and inversion preserves conductor. The independent identity sum_(eligible c) c*a(c)=phi(q)^2 is checked at every active modulus by a separate accumulation.

The rational upper totals are

    Splus <=39208458062457503852351/10^12,
    Sstar <=801017730726031768989/10^12,
    SN <=4669960266957896769868364637/10^12.

These are directed upper sums: each nonnegative modulus term is rounded upward at denominator10^12 after its integer numerator is formed. They are not floating evaluations. The rounding error is below the number of terms divided by10^12. Primitive enumeration and finite arithmetic still need a Lean replay theorem before they can be consumed as a formal certificate.

It follows for the low-zero pieces that

    Aplus_low <=Cplus*x^(2b-2), Cplus=(1.2534)^2*23000*Splus,
    Astar_low <=Cstar*y^(2b-2), Cstar=(641547/700000)^2*49*102000*Sstar,
    N_low <=CN*x^(2b-2), CN=23000*SN.

The JSON preserves exact rational coefficients. For principal Ep use W(delta)<14 and the conductor-one count, giving Ep_low<=14*23000*Nplus(1)*x^(2b-2).

## Critical-line diagnostic and beta tolerance

At b=1/2, the low bounds evaluate approximately as follows; these decimal displays are diagnostics of the exact expressions.

| Quantity | Bound at b=1/2 | Allocated cap |
|---|---:|---:|
| Aplus |2.8913e-12|5e-7|
| Astar, actual(P) |3.3628e-10|2.5e-7|
| N |2.1921e-7|1.23|

With |P|<=130 instead, the Astar bound is6.7659e-6, more than27 times its allocated cap, even at b=1/2. This was a loss in that particular upper bound, not a lower bound or impossibility result for the actual star moment. The genuine smoothing estimate(P) removes it.

After reserving the explicit norm remainders below, the Astar threshold within these inequalities is approximately b=0.55738307. Aplus and N alone permit approximately.59812 and.62643 before their negligible norm remainders. Thus Astar is the current second-moment bottleneck. These values are not optimality claims for the mathematical problem or for sharper kernels.

Exact Taylor lower sums and rational comparisons certify the selected common value b=111/200, shared with the factor25 mixed certificate. They also certify b=5573/10000 using log(y0)>57.56; the true endpoint logarithm would allow slightly more. For the convenient value the checked estimates include

    sqrt(Aplus_low)<.00007,
    sqrt(Astar_low)<.00049,
    N_low<.001,
    sqrt(Ep_low)<.0002.

All are uniform for x>=x0 since every positive power x^(2b-2) and y^(2b-2) decreases. This monotonicity concerns proved envelopes, not the oscillatory residual itself.

## Remainders and actual coprime moments

The independent hybrid report proves on paper the actual high-zero bounds <1e-30*x^(-1/8) and <1e-30*y^(-1/8) for every primitive character on its relevant twist interval. Its BP, kappa, Gaussian and bandlimit constants are retained.

For the remaining explicit-formula terms one can use coarse bounds uniformly over c<=300000. Source ExplicitFormula.DN at805 is<150. Source ExplicitBoundGen.VgL at28 supplies the vertical integral constant. For plus, take Kv<106000 and thP>=4e-7. For star, the eta2 moment at real part-1/2 is16(sqrt2-1)^2<3; source GrExtend.norm_G_uniform_ext at73 then gives Kv<=900 and theta>=2e-5. Applying its convolution to etaU justifies these vertical-line bounds. The separate GoodSmoothing/explicit-formula wrappers for etaU need the full analytic proof; they must not be inferred solely from one vertical-line estimate.

Keep possible zero-at-zero residues rather than silently discard them: their multiplicity is<400, with Mellin bounds39000 for plus and600 for star. With x>=4.9e26,y>=1e25, the normalized vertical plus zero0 term is<1e-18 for either smoothing. The source zeta specialization has a smaller DN constant; its main pole term is subtracted in the residual. Exact scalar checks include these allowances.

Primitive-to-coprime removal is <=1e-15 for plus and<=1e-12 for star by ArcChars.coprime_split at298 and ArcCharsStar.coprime_split_star at85, extending them through character values of norm<=1. Including high-zero and contour terms gives per-character perturbations<2e-15 and<2e-12.

The exact sum of Gauss norm squares is phi(q)^2. Hence the Astar perturbation measure is at most sum_q2Dq*mu(q)^2/phi(q)<=3.6e11; (P)<1 then gives norm remainder Rstar<1.2e-6. For Aplus, U^2<2 gives Rplus<2e-9. For N, sum_q2Dq*phi(q)<=7.2e11 gives RN<2e-9. The same argument gives REp<1e-8. These are primitive-to-coprime and explicit-formula allowances; they precede the distinct reviewed coprime-to-full transfer in the final cubic argument.

Consequently, at the selected b=.555,

    Aplus_coprime<(.00007+2e-9)^2<5e-7,
    Astar_coprime<(.00049+1.2e-6)^2<2.5e-7,
    N_coprime<(sqrt(.001)+2e-9)^2<1.23,
    Ep_coprime<(.0002+1e-8)^2<1e-4.

These establish a quantitative sufficient-condition implication on paper. They do not assert any certified zeros or completed Lean proof. Mixed Cross requires the separate two-character estimate and its remainder analysis; a second moment alone cannot supply it. Zero_sum reports its exact induction calculation passes a wider b=.58, but that separate result and its audit must be read before combining the conclusions.

## Remaining proof tasks and scope

The decisive finite task is to certify, for every active primitive character, absence of zeros to the right of the selected b=.555 (or a complete counted cell profile yielding smaller weighted sums) through the stated heights. The certificate is weaker than finite RH equality, but covers billions of characters with conservative height floors. No claim is made that its runtime or storage is smaller than a formal replay of Platt's original computation.

The analytic supporting work comprises the actual etaPlus Gram theorem, the etaU Gaussian-mixture Gram theorem, the Fourier-tail pointwise bridge and(P), complete etaU explicit-formula/smoothing interfaces, finite-to-limit passages, and the elementary remainder transfers. The source Jensen and Gauss identities already provide the correct starting statements. All supporting statements must be proved and their source dependencies audited; the finite spectral statement must be discharged by a real certificate rather than added as a new assumption to Goldbach.

The arithmetic run passed with no numerical integration and no assumed zero spacing. It uses integer sieves, directed rational sums, exact powers, and positive Taylor sums. The JSON's beta-threshold decimals are labeled diagnostics. A bounded independent audit has been requested; no closure of the global QRH replacement is claimed.


## Added joint remainder closure at the selected b=111/200

The same finite-strip estimate gives a much smaller explicit mixed remainder than the general target1e-6. This appendix concerns the actual coprime moments and includes all the preceding high-zero, contour, zero0 and primitive-to-coprime allowances. It is conditional on the finite certificate and the analytic lemmas already listed, not on an assumed final J bound.

Let Lplus(q,delta),Lstar(q,delta) denote the Gauss-weighted character energies of the finite nontrivial-zero sums. The nonprincipal calculation and principal weight bound give

    integral sum_q Lplus <=.001+.0002^2 <.002.

For star, Hstar(c)<1.3e6 gives Nstar(c)<3e8 for every character. The unweighted actual star Gram bound, exact Gauss identity and sum_q phi(q)<=9e10 imply

    integral sum_q Lstar
      <=9e10*49*102000*3e8*y^(-.89) <10000.

The last inequality is checked by a positive exponential Taylor sum using log(y)>=57.5. It is intentionally coarse and only supplies a product perturbation bound.

Let dplus=2e-15 and dstar=2e-12 be the per-character remainder bounds above. At a fixed q the weighted norm of its error vector is at most sqrt(phi(q))*d. Expanding the product of the two character vectors, then applying Minkowski in the actual two-character/direct-sum Hilbert space, yields

    Rmix <=dplus*sqrt(300000*10000)
           +dstar*sqrt(300000*.002)
           +dplus*dstar*sqrt(3.24e22)
         <1.6000072e-10 <2e-10.

This is a norm bound, not a direct bound on Cross. The last measure bound uses sum_q2Dq*phi(q)^2<=3.24e22. Both independent character indices are retained. No L2-to-L4 inference is made: the product error contains one small pointwise error and one known finite second moment.

Combining this with zero_sum's separately checked factor25I_low<2.5e-7 would give

    Cross_coprime <(sqrt(2.5e-7)+2e-10)^2<7e-7.

That algebra has ample slack. The underlying finite mixed estimate and its actual-smoothing input must still be proved; this appendix closes its explicit-formula/removal allowance within the same conditional research route. It does not certify the finite zeros or the final Goldbach theorem.
