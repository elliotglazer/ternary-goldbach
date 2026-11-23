# Minor replacement audit

Research review against calr3/ternary-goldbach commit 23b2d68ca344203d4384e0aff7affa4ec034bef9. No Lean compiler was launched. This report is not a frozen-declaration or axiom audit. Proposed analytic estimates remain distinct from proved source declarations.

## Findings

1. A direct upper bound on the actual prime-supported coefficient energy suffices. The signed Prop 7.1.5 identity and its lower error bound are not required downstream. The clean target T(x) <= .65*x*log(x), for every real x >= 4.9e26, is sufficient after explicitly updating the internal numerical envelope and its dependent numerical proofs.
2. The proposed unconditional EBound route is mathematically sound at paper level. Its exact public endpoint remains 8e-11*x. All 17 rational checks replayed successfully. The real endpoint lift, strict prime cutoff, tail blocks, and convergence argument preserve the source definitions.
3. The basegap estimate can be weakened from .0121*y to .01398*y without changing the current ghat envelope. A larger relaxation must pay an explicit extra term in the minor bound or use sharper recomputed envelopes.
4. The complete actual-smoothing 172/566 kernel route passes this paper-level audit, conditional on its explicit global7/8 zero strip and finite xi-mass bound. The final section reviews the full explicit-formula assembly. Its analytic glue and tracked inputs are not Lean-validated.

## Exact energy interface and convergence

MinorTotal.lean:70 defines sig(x)=(.640208+366.91/sqrt(x))*log(x)-.021095. Its a1 coefficient is zero except at natural primes n with sqrt(x)<n, where it is Lambda(n)*etaPlus(n/x), viewed as a complex number. Define T(x)=sum'_n ||a1(x,n)||^2 with this exact sequence.

MinorTotal.T_le:216 is the only direct consumer of PartIICited.prop_7_1_5. It bounds T by the nonnegative weighted sum F_n=Lambda(n)*log(n)*etaPlus(n/x)^2. The old proof uses the positive signed identity to rule out divergence of F_n, because Lean assigns zero to a divergent tsum. Therefore a bare upper bound on that totalized weighted tsum is not a sufficient abstract replacement. Supply its summability, bounds for every finite partial sum, or a direct bound on T. For T itself, the source's unconditional summable_a1 already gives absolute summability and hence summability of the squared norm; its tsum represents actual energy.

The usages of sig downstream are the energy upper bound, its nonnegativity, and the affine expressions in MinorTotal.Mexpr, NumericsCore, and NumericsAsymp. There is no extra use of its exact old formula outside those proofs. I0_ge remains a separate input: major energy >=8.6296*x and residual energy <=8e-11*x yield prime-supported major energy >=8.6294*x. A new upper energy estimate does not prove this lower bound.

Changing the internal sig expression is substantive source work, not an automatic application of the existing NumericsGoal theorem. One may introduce a clearly separate envelope sigma_a=a*log(x), preserve the sequence a1 and public minor1.0376 conclusion, and reprove the parameterized numerical chain. No new source definition has been approved or installed by this audit.

## Exact .65 numerical tolerance

Reviewed minor_energy_tolerance.py, MINOR_ENERGY_TOLERANCE.md, NumericsCore.sig_div_Dx_le, tail_le, cell_bound, and NumericsAsymp.asymp_goal. The scalar envelope formula agrees with the source proof:

F_i(a)=(G0*cl0+sum G_j*ell_j)*(a*L0-b)/(L0/2-1.3066)
       +Gt*(a*L1-b)*(1-clt/(L1/2-1.3064))-8.6294*G0.

For the old negative offset b=.021095, the ratio derivative has numerator b/2-a*d<0 for a>=.640208000017 and d in [1.3064,1.3066]. Numerators, denominators, and the tail factors have the signs used in the source. The analogous derivative for b=0 is strictly negative. The conditions cl0*sD>=8.6294 and tau>=0 also hold after increasing a to .65. All ghat, cL, block, size and logarithm bounds are independent of a. Exact endpoint sD and tau must replace the old narrowly rounded constants.

For b=.021095 the limiting cap is cell0:
381605715428698635087625105/584653183815430767285135948 = .6527044168960991... .
For the cleaner target with b=0 the cap is:
31783786807619686162862000/48721098651285897273761329 = .6523618655463307... .
Thus .65 fits either target. The asymptotic branch uses the same source chain and tail estimates, replacing only sD and the coefficient of log(y)+3.9; it is less restrictive. This is a scalar audit, not proof of the energy estimate.

The final source square split gives minor/(x^2/49) <=1.0005*Mexpr+2001*22.75*8e-11. The additive term is .00000364182. Mexpr<=1.037 implies the unchanged minor constant1.0376, leaving .00007785818. No major-arc or nonprime allowance is spent by this replacement.

## Unconditional EBound review

Reviewed agents/moebius/EBOUND_UNCONDITIONAL.md and ebound_rational_audit.py. Inspected the actual unconditional Prelim.nonprime_sum_le at LambdaMu:129 and Mathlib Chebyshev.psi_le. The former bounds the complete nonprime Lambda sum through natural N by psiN(Nat.sqrt N)+N^(1/3)*log(N), for N>=1. The latter gives psi(t)<=log(4)*t+2*sqrt(t)*log(t), for real t>=1.

Taking N=floor(y) preserves the exact finite sum. Nat.sqrt(N)<=sqrt(y), psi monotonicity, and monotonic positive powers and logarithms give P(y)<=psi(sqrt(y))+y^(1/3)*log(y). There is no restriction on the individual summands, only on y. For t>=1e8 the elementary Chebyshev estimate yields psi(t)<=1.4*t. For y>=X=4.9e26, decreasing log(y)/y^(1/6), log(X)<=61.5 and X^(1/6)>=28000 give P(y)<=1.5*sqrt(y).

The original unconditional eTerm_low and eTerm_block apply with their exact weak/strict cutoff conventions. The small-prime boundary n=sqrt(x) stays in the residual. All block endpoints 2^(j+1)*x exceed X. Finite initial sums are bounded before passing to a nonnegative infinite sum, so the proof establishes summability rather than exploiting totalized tsum.

The resulting bound is sqrt(x)*(25.943*log(x)+18.94). Using sqrt(X)>=22135000000000 and monotonic log(x)/sqrt(x), the normalized upper bound is exactly
3228869/44270000000000000 <8e-11,
with margin312731/44270000000000000. I independently reran all17 exact checks; they passed. No Platt, QRH, finite table, theta estimate or hidden global1.03883 estimate is used in this replacement argument. The new partial-sum helper must have x>=X; it does not prove the old E_partial helper on all x>=1. Lean glue, exact declarations, compilation and axioms remain outstanding.

## Basegap relaxation interface

The source gap is alpha in majorArcs8(150000,x/49) but outside majorArcs8(150000,x), with x>=X and y=x/49. The derived rational approximation has 1<=q<=300000, coprime a,q, and 600000/(49*q)<=abs(delta)<1200000/q, where delta=(alpha-a/q)*y. Parity permits sharper upper/lower endpoints, but this common domain is valid.

Thm1321.thm_13_2_1_repaired actually needs ||Sstar(alpha)||<=y*ghatY(y,150000) on this gap. It does not require the literal .0121. The unconditional source lower gx>=.01 gives
G0(y)=ghatY(y,150000)>=1.398*.01+(17/3)*(670/150000)^3
=141552612971/10125000000000 =.013980504984790124... .
Thus .01398*y is a safe drop-in weaker target, subject to an actual proof with the same domain. Cor713 errors are not the only Platt dependency of the old gap proof: its q/phi(q)<5.53 call is a separate Mertens/totient route. A new elementary totient bound can replace that use, but must be proved and connected explicitly.

For a proposed bound B(y)*y exceeding G0(y), set Delta=max(0,B-G0) and raise only the base envelope; the higher-level envelopes stay unchanged. Monotonicity of the level envelope survives. The exact additional normalized layer bound is Delta*(cL(150000)*T/(x*Dx)-I0/x). A valid upper bound is Delta*(cL(150000)*sigma_a/Dx-8.6294), or its positive part for a standalone sufficient estimate. This extra term must be included in the cell arithmetic. Under the old uniform Mexpr<=1.037 bound, at most3892909/50025000000=.00007781927036481759... can be added while preserving final1.0376. Sharper recomputed cells may have more room; it cannot be presumed free.

## Actual-smoothing kernel route: interim audit

For h(u)=hH(200,exp(u)), phi1(t)=etaPlus(t)^2 and phi2(t)=log(t)*phi1(t), set b=beta+2, a=2-beta, z=exp(2u), E=exp(b*u-z), F=h^2*E. For 0<=beta<=7/8, the Mellin transform is integral F(u)*exp(i*gamma*u) du, with no 2*pi in this final phase. The factor from Fourier conventions occurs only in the projection representation of h.

The proposed identity (a^2+gamma^2)*Mphi1=integral(a^2*F-F'')*exp(i*gamma*u) is correct when the integrations by parts are justified. Direct differentiation gives E'=(b-2z)E and a^2*E-E''=[-8beta+(4beta+12)z-4z^2]E. For G=uF the differential operator is u*(a^2F-F'')-2F'. The coefficient identities are correct.

The reported scalar envelopes E<=.5, |E'|<=2, |a^2E-E''|<=15.5 and their |u|-weighted versions1,7,58 are consistent with bounding z^k E by(.5,1,3,10), k=0..3, and splitting z<=1 and z>=1. The norm arithmetic then yields191.9/a<172 and633.8/a<566, since a>=9/8. The estimates require projection contraction for h,h',h'', their source derivative energies, justified boundary decay/IBP, an exact Xi mass with zero multiplicity, and the full explicit-formula remainder. A complete written bridge and numerical scalar certificate are still awaited. No conclusion about the final energy theorem is certified by this interim paragraph.

## Completed actual-smoothing paper review

The complete MINOR_ENERGY_QRH.md was subsequently reviewed at SHA256 A0C414E8FAEAB6C8A4768B2179635F5B42F69D118EA17EBB062AA7FD7857C0A6. This section supersedes the interim status above. No mathematical defect was found in the complete derivation, conditional on its explicitly separated global7/8 zero strip and finite positive xi-mass bound. Those two inputs and the new analytic glue remain unformalized here.

The exact source hBase is t^2*(2-t)^3*exp(t-1/2) on[0,2], not etaO. Its derivative has the factor(1-t), so hBase<=exp(1/2). Source Cg is integral|g| in logarithmic coordinates, and Cg<=2.03. Thus integral|g|^2<1.65*2.03<4. Source hH_eq_fourier uses cutoff|2*pi*xi|<=200. Multiplication by(2*pi*i*xi)^j gives the derivative projection, which contracts the actual u-derivative L2 norms. The source energies19.5 and368 consequently have exactly the required normalization. The projection/derivative contraction lemmas are still proof work, but no extra2*pi belongs in these energy bounds.

Compact Fourier support supplies integrable polynomial multiples of the Fourier density and hence bounded smooth h derivatives. Since beta+2>=2, the weights and all their polynomial-in-u derivatives vanish at minus infinity; at plus infinity the exp(-exp(2u)) factor dominates. This justifies the proposed two integrations by parts and all products used in Cauchy-Schwarz. It also explains why no smooth compact cutoff or unaccounted truncation term is needed.

The scalar argument covers every beta in[0,7/8] and every real gamma. The four half-integer maximum inequalities are certified by degree30 positive Taylor sums. I replayed minor_energy_constants.py successfully. It establishes the claimed191.9 and633.8 operator numerators and the strict margins below172*(9/8) and566*(9/8). My separate check_minor_replacement.py additionally checked every cell's new base positivity and zero-offset .65 bound, and the exact omitted scalar check(6e38)^2<X^3 proving6e11*X^(-3/2)<1e-27.

Zero-at-zero removal is legitimate. In the actual source ZetaZeroSums.lean:35, zetaF_zero_ne_zero follows from riemannZeta_zero and zetaF_of_ne. The next theorem zerosRectD_zetaF_strip explicitly excludes zero and proves every rectangle zero has0<Re(rho)<1 and is a zero of both zeta and xi. Neither theorem has a Platt instance. ZetaExplicit.explicit_formula_zeta_seq:122 sums these exact zetaF rectangle zeros with multRectD and already subtracts the pole contribution correctly. Its limit is M(1)*x-SsumG-(1/(2*pi))*verticalIntegral. There is no additional zero-at-zero or trivial-zero residue in this formula. Do not use the stronger RH-dependent norm_SsumG_phi1_le or phi2 counterpart; the new argument uses the unconditional explicit formula directly.

The finite mass premise must match those rectangles and natural divisor multiplicities:
  sum_(rho in zerosRectD zetaF T) multRectD(zetaF,T,rho)*(2-Re(rho))/((2-Re(rho))^2+Im(rho)^2)<=.07.
Under this premise and the global upper strip, termwise triangle inequality gives172*.07*x^(7/8) and566*.07*x^(7/8). No orbit division, simplicity, conjugation pairing, lower real-part gap or finite-height RH is needed. The xi approximation-to-mass proof and its exact multiplicity identification remain a separate obligation; the numeric log-derivative bound alone is not this full premise.

The source phi1_vert/phi2_vert, cA_sq_le and VgL400_le provide the stated unconditional vertical constants. The relative remainder after division by x*log(x) is at most5e11*x^(-3/2)+3e12*x^(-3/2)/log(x). There is no missing x factor or2*pi factor. At x>=X and log(x)>=61 it is less than1e-27. The zero contribution is at most38703/6481250, strictly below.006 with enough margin to absorb that remainder.

The source phi1/phi2 GoodSmoothing and summable_SsumG results also give an independent absolute summability proof for the weighted real Lambda-log sum by the log(n)=log(x)+log(n/x) identity; n=0 contributes zero. The unconditional main integral bound then yields S(x)<=(.64621*log(x)-.021095)*x, hence the sufficient direct prime energy target .65*x*log(x). This is a complete paper-level reduction, not a compiled energy theorem. It uses the actual smoothing and does not depend on the local principal2750-cell certificate or the proposed low-height nonvanishing rectangle.

Remaining status gates: formalize projection contraction, scalar inequalities and IBP; prove the finite xi-mass contract; validate the global7/8 provider in the target environment; assemble the unconditional source explicit formula with the new kernels; update and check the internal energy envelope and all minor numeric proofs; inspect resulting theorem types/axioms. Independent major lower energy, basegap, and other Goldbach inputs remain separate. This audit makes no root closure claim.

Replayed artifact hashes: minor_energy_tolerance.py CBC6943211541206E591B69CC83F2A6D8D278DA5D2AE1831D8E8FEEA1272F584; minor_energy_constants.py 1EC75D826A67250318F7678A4B945BCF99A255403F0ED01B8B6C3BD9C0314AD3; EBOUND_UNCONDITIONAL.md 7FDF1E316B7F54A299D1A75FEC86073560CC9516A94144F265792FA463ABE6F2.

