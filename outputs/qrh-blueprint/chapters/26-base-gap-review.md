# Basegap research review

Independent paper/source review, 2026-11-10. Target: agents/zero-sum/BASE_GAP_QRH.md, inspected SHA256 AC89B7041797DE5D58EF8998308F4EE796E4EAD441742AF0BD9DB4ABAB2A42BC. Pinned project: calr3/ternary-goldbach commit23b2d68ca344203d4384e0aff7affa4ec034bef9. No Lean compiler ran and no target/peer source was changed. Arithmetic replay is in check_base_gap.py, in this audit directory.

## Verdict and scope correction

The three requested analytic formulas are correct at paper level: the principal main contribution is below .000481*y; the real part of the twisted etaU Mellin transform at beta=7/8 exceeds .12 for abs(delta)<=.082; and the stated twice-integrated-by-parts formula implies the real-zero bound2.72/delta^2 for beta in[1/8,7/8]. The proofs preserve the actual etaU, its Mellin convolution, and the twist normalization. These statements and the finite totient glue have not been implemented or Lean-validated in this work.

The hypothetical zero inventory demonstrates failure of the specified uniform absolute recipe to reach the fixed .0121 or conservative .01398 targets. It does not by itself demonstrate failure to meet the actual downstream ghatY(y,150000) envelope. That envelope can exceed .01398 substantially at the worst scale. Therefore a claim that family sparsity or cancellation is necessary for every downstream basegap route is too broad. Qualify it to the stated fixed targets, or compare with the actual all-y ghat envelope. This correction was sent to zero_sum.

Likewise, consistency with global QRH locations and reflection/conjugation is clear, but compatibility with unspecified additional local-count or positive-mass hypotheses is not a checked theorem. State the actual constraints and verify them before asserting such compatibility. This is an artificial test of an upper-bound method, not a counterexample to actual Dirichlet L-functions or to the basegap theorem.

## Exact source geometry and normalization

BaseGap2.norm_S_etaStar_le_gap has x>=4.9e26, alpha in majorArcs8 r0(x/49), alpha outside majorArcs8 r0 x, and concludes norm(S etaStar x alpha)<=.0121*(x/49). Here r0=150000 and y=x/49>=1e25. It has a Fact PlattGRH binder.

Tracing the two branches of gap_point back to majorArcs gives the sharper parity domains:

- Odd q: 1<=q<=150000 and600000/(49q)<=abs(delta)<600000/q.
- Even q: 2<=q<=300000 and1200000/(49q)<=abs(delta)<1200000/q.

In both cases delta=(alpha-a/q)*y for a reduced rational. The lower endpoint is included because the narrow arcs are open. The upper endpoint is excluded. The global minimum4/49 is valid; the coarser exported gap_point forgets parity and allows an artificial even-q minimum2/49. The larger domain is safe for proving an upper bound but obscures useful geometry.

The transform is F(s,delta)=integral_(u>0) etaU(u)*u^(s-1)*exp(2*pi*i*delta*u)du. There is no further division of delta by49. BaseGap2.S_etaStar_eq_expTsum identifies the original sum with etaU(n/y), so this is the exact character-sum twist.

At p=149993, delta=.082 lies strictly inside the wide ranges for q=p and q=2p and outside the corresponding narrow ranges. Trial division confirms p prime. Distinct reduced rational wide arcs do not overlap here: after multiplying the sum of radii by qq', it is at most1.2e6*(q+q')/y<=7.2e11/y<1. Thus the global exclusion of other narrow arcs does not invalidate these example points.

## Principal main term and finite totient comparison

Read the actual unconditional statements MajorTotal.norm_fourier_etaUC_le, EtaU.norm_fourier_etaU_le and BaseGap2.fourier_const_le. They yield A=norm(Fourier etaU(-delta))<=1.2534 and delta^2*A<=1.016. Since A>=0, their product gives (abs(delta)*A)^2<=1.2534*1.016<1.129^2. On the gap delta is nonzero.

For every natural1<=q<=300000, q has at most six distinct prime factors: the product of seven distinct primes is at least510510, while the prime-factor product divides q. The factors p/(p-1) decrease with p. Consequently q/phi(q)<=2*(3/2)*(5/4)*(7/6)*(11/10)*(13/12)=30030/5760. Source MertensProduct.div_totient_eq_prod and exch provide the exact product identity and comparison; this finite consequence does not use the conditional global div_totient_lt. The empty product q=1 is included.

Using q*abs(delta)>=600000/49 gives
A/phi(q) <= (30030/5760)*1.129*49/600000
 =55376321/115200000000 <.000481.
The principal Gauss coefficient may add abs(mu(q))<=1; dropping it is safe. For even q the parity-aware lower endpoint improves this bound by a factor2. The claimed finite-enumeration maximum is only a floating diagnostic and is unnecessary for this proof.

## Cosine lower bound

The source eta2 is nonnegative, supported in[1/4,1], and has integral1. Its Mellin transform is A(s)=4*((1-2^(-s))/s)^2, with removable interpretation at s=0. The etaU Mellin transform is H(s)=A(s)*G(s), where G(s)=2^(s/2)*Gamma(1+s/2). All exponents in the reviewed inequalities avoid the removable case.

For beta=7/8, A(beta)>=1 because r^(beta-1)>=1 on the support. Restricting the positive Gaussian moment to[0,1] and[1,2] gives
G(beta)>=exp(-1/2)*(8/23)+exp(-2)*(3/2)
 >.6*(8/23)+.13*(3/2).
The powers are correct: the integrand is u^(beta+1)*exp(-u^2/2)=u^(15/8)*exp(-u^2/2), and u^(15/8)>=u on[1,2].

For the upper moment A(beta+2)<=A(2)=9/16. Weighted AM-GM gives u^(7/8)<=1/8+7u/8, so G(beta+2)<=2/8+7*4/8=15/4. Here the two Gaussian moments are2 and3*sqrt(pi/2)<4. Hence H(beta+2)<=135/64.

The pointwise inequality cos(t)>=1-t^2/2 can be integrated against the positive weight; the required moments converge. It yields
Re F(beta,delta)>=H(beta)-2*pi^2*delta^2*H(beta+2).
For abs(delta)<=.082 and pi<22/7 the lower bound is exactly55673979/450800000=.123500397...>.12. The sign of delta does not matter. Our exact replay also checks the exponential lower bounds using the standard upper bound on exp1.

## Twice integration by parts

Writing etaU(u)=integral eta2(r)*r^(-3)*u^2*exp(-u^2/(2r^2))dr is correct. The r integral is over the fixed positive compact support[1/4,1]. The second derivative of u^(s+1)*exp(-u^2/(2r^2)) consists of

s(s+1)*u^(s-1), -(2s+3)*u^(s+1)/r^2, and u^(s+3)/r^4,

all multiplied by the same Gaussian. Thus every absolute u-integral scales as r^(beta-3) after including r^(-3), and the common r moment is A(beta-2), not A(beta) or A(beta-1). The three remaining Gaussian moments are G(beta)/beta, G(beta), and(beta+2)*G(beta).

For beta>0 the original amplitude and its first derivative vanish at0 and infinity. Its second derivative has local behavior O(u^(beta-1)) at0 and Gaussian decay at infinity, so it is absolutely integrable. Compact positive r support justifies differentiation/Fubini through a common integrable bound. Two integrations by parts consequently give, for every real gamma and nonzero delta,

abs(F(beta+i*gamma,delta)) <= A(beta-2)*G(beta)/(2*pi*delta)^2
 * (abs(s*(s+1))/beta+abs(2*s+3)+beta+2).

At gamma=0, beta in[1/8,7/8], the bracket equals4*beta+6<=9.5. Monotonicity of the support moment gives A(beta-2)<=A(-2)=9. For completeness, G(beta)<=G(1)=sqrt(pi/2) follows by integrating u^beta<=(1-beta)+beta*u against u*exp(-u^2/2); both endpoint moments are finite and G(1)>1. Thus G(beta)<1.2534. Even the coarse pi>3.14 proves the coefficient <=1071657/394384=2.717293...<2.72.

For q=1,2 the minimum twist600000/49 gives2.72/delta^2<1.82e-8. This does not bound all-height zero sums: the displayed bracket grows quadratically in abs(gamma), and the estimate alone loses decay at large height. The report correctly requires a separate high-height treatment.

## Reconstruction, inventory and quantitative scope

The source reconstruction bound is D+norm(M)/phi(q)+sqrt(q)*(E+D). Preserving individual Gauss norms gives the proposed sufficient weighted character inequality with(1+Wq)*d, Wq=sum norm(tau)/phi(q). Both the original noncoprime removal and the inducing-character correction are counted. The inducing character belongs to psi inverse. Gauss norms equal sqrt(c) only when q/c is squarefree and coprime to conductor c; otherwise they vanish. No extra inverse square-root conductor factor may be inserted.

For prime p there are p-2 primitive characters, each with Gauss norm sqrt(p), and the denominator is phi(p)=p-1. One allowed beta=7/8 real zero per character forces the stipulated absolute envelope above .12*y^(-1/8)*(p-2)*sqrt(p)/(p-1). At y=1e25 this exceeds both fixed targets. The exact replay proves a coarser lower bound .03250778 using sqrt(p)>387 and y^(-1/8)>.0007, so floating arithmetic is unnecessary for this comparison. Reflection or conjugation can only add to this absolute envelope; a sufficiently small nonzero height preserves the strict transform lower bound by continuity.

This establishes only insufficiency of location-only uniform absolute estimates at those fixed targets. The analytic lower bound on the envelope is not a lower bound on the actual exponential sum: phases can cancel. It also cannot rule out the larger actual ghat envelope. Any proposed stronger positive-detector obstruction is a new claim requiring independent assumptions and review; it is outside the three formulas audited here.

## Separate off-larger-arcs dependency correction

The basegap is one of two branches of MinorTotal.hv0. The other branch is not unconditional in the current source. LinftyLevels.norm_S_etaStar_le_ghat:358 has Fact PlattGRH at355 and calls Prop1123b.norm_S_eta2_le_of_not_mem:107, under that module's Fact binder. The latter uses GBound.norm_S_eta2_le_gx in its first case and theorem_3_1_1 in its second. GBound also invokes Prelim.div_totient_lt. PointwiseBound.theorem_3_1_1 combines the conditional Type I/II first and second choices.

The original MINOR_INTERFACE_MAP.md opening table called this off-larger-arcs theorem unconditional. Root identified the error; I independently confirmed the exact chain and asked integration to correct the map. Definitions, smoothing transport and some scalar lemmas are unconditional, but that does not remove the theorem's substantive Type I/II and Mertens dependencies. Resolving basegap or the new energy estimate alone does not discharge this separate branch.

## Evidence and remaining work

check_base_gap.py passed all exact checks: first-seven-prime product, six-factor totient value, Fourier product bound, main fraction, cosine fraction and elementary exponential comparisons, Gaussian moment and IBP constants, prime-cell geometry, and a rational inventory comparison. It does not certify differentiation, integrability, finite prime enumeration in Lean, source elaboration, or actual character zero constraints. Source-only inspection supports the claims stated above; no new declaration is marked proved.

Remaining substantive work includes an actual all-character explicit-formula estimate with correct remainders and convergence, enough family information or a suitable actual-ghat envelope comparison, and implementation/validation of the paper lemmas. The existing public basegap theorem and the final Goldbach theorem remain unclosed by these calculations.
