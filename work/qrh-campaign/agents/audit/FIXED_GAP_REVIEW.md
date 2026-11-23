# Fixed zero-free gap: independent source audit

Reviewed draft: agents/zero-sum/ZeroFreeFixedGap.lean
SHA256: 1DECBC841B33388BCAD64C0B66E3C0FBECB818A376EBB40F1188C103F14FFFA0
Original source: calr3/ternary-goldbach commit 23b2d68ca344203d4384e0aff7affa4ec034bef9.

Verdict: no mathematical or source-level hypothesis defect found. This is not a compilation or axiom-check verdict. No new declaration has been frozen by this audit.

## Exact target

zeta_zero_re_le_fixed assumes zeta(rho)=0, 0<Re(rho)<1, and |Im(rho)|<=10^8, and concludes Re(rho)<=249/250. No RHBelow, Fact PlattGRH, or QRH parameter occurs. It depends on the separately audited, still uncompiled ZetaLowUnconditional helper. No lower real-part gap is claimed by this particular declaration.

## Lowered digamma threshold

The draft does not invoke the old half_re_digamma_half_le theorem below its |t|>=10 domain. It rederives a bound from Digamma.lean:506, re_digamma_le', whose only hypothesis is x>0:

    Re psi(x+iy) <= log(x+1) + (1/2)log(1+y^2/x^2).

For 1<sigma<=2 and |t|>=2.39, x=sigma/2>0, log(x+1)<=log2, sigma^2>=1, and

    1+t^2/sigma^2 <= 1.18*t^2

because .18*(2.39)^2=1.028178>1. All logarithm arguments are positive; t!=0 is explicitly established. Thus

    (1/2)Re psi((sigma+it)/2)
      <= (1/2)log|t| + (1/2)log2 + (1/4)log1.18
      <= (1/2)log|t| + .4.

Using log1.18<=.18 leaves over .0084 of slack. Both signs of t are covered.

## von Mangoldt assembly and signs

vM_term_le_low copies the original algebra of ZeroFreeRegion.vM_term_le, replacing only the digamma estimate and its domain. The other inputs require 1<sigma<=1.02 and tau>0, not tau>=10. In particular re_digamma_sub_le requires only 0<a<=b, satisfied by a=sigma/2 and b=1.6181/2.

Writing X=Re(xi'/xi)(s), P=Re psi(s/2), R=Re(1/s+1/(s-1)), and c=(1/2)log pi, the identity is L=-X+R-c+P/2. For the analogous quantities at s1, Z<=X-kappa X1 gives

    L <= -Z+kappa L1+R-kappa R1
         -(1-kappa)c +(1-kappa)P/2 +kappa(P-P1)/2.

The draft uses kappa>=0 and 1-kappa>=0, R1>=0, L1<=E1, and bounds R by 2/tau^2. Thus all discarded terms and multipliers have the correct signs. The bound for P-P1 is .20604+11/tau^2: the constant estimate follows from sigma>1, while the denominator terms sum to at most10.4724/tau^2<=11/tau^2. No additional low-height assumption is concealed in these steps.

## Fixed numerical bound

At sigma=1.014, kappa=.514/1.1181, tau in[2.39,4e8], the exact inequalities used are

- 2/tau^2<=.351 and11/tau^2<=1.926;
- log tau<=20, since (2.7182818283)^20>4e8 and exp_nat_ge' supplies the lower exponential bound;
- 0<=1-kappa<=.55;
- (1/2)log tau+.4-(1/2)log pi<=9.83, using log pi>=1.1447;
- (kappa/2)(.20604+11/tau^2)<=.491;
- E1<=1.2857 and kappa E1<=.592, using log2.80905<=1.0329.

The sum is bounded by .351+.55*9.83+.491+.592=6.8405<6.85. The proof first bounds the possibly sign-indefinite logarithmic expression by9.83 while multiplying by nonnegative1-kappa, and only then enlarges1-kappa to.55. Therefore it does not require that expression to be nonnegative.

## Stechkin, distinguished zero and multiplicities

ZeroFreeRegion.stech_wrap and stech_wrap_rho require only1<sigma<=1.02; there is no height premise. Their underlying ZeroFree.stechkin_xi requires1<Re(s)<Re(s1), equal imaginary parts, and

    (Re(s)-1/2)^2+(Re(s1)-1/2)^2 >=3/2.

Here the sum equals1.51434361. The elementary source proof factors the relevant numerator through nonnegative factors; the polynomial coefficient c^2+c1^2-6b^2 is nonnegative because |b|<=1/2. Thus the low-height use is legitimate.

The distinguished-zero theorem additionally requires beta!=1/2, which follows from the contradiction assumption beta>249/250. Its source uses rho and1-conj(rho), proves them distinct, and includes both in a finite partial-fraction approximation with multiplicity at least1 (XiPartial.xi_partial_approx:776). Each gives the same nonnegative paired contribution. These two terms cancel the factor2 in the paired logarithmic-derivative approximation. There is no lost factor2 and no simple-zero assumption.

Since xiF_zero_re gives0<beta<1, all four distinguished-zero denominators are strictly positive. For beta>.996 the draft proves

    1/(1.014-beta) >=500/9,
    1/(1.014+beta-1) >=.98,
    1/(1.6181-beta) <=1.618,
    1/(1.6181+beta-1) <=.62.

Consequently the weighted negative pair is<=1.03 and Z>=500/9+.98-1.03>55.5. The upper bounds are rounded outward even at limiting beta=1 and beta=.996 respectively.

## Final positivity and endpoints

ZeroFreeRegion.vM_positivity has only sigma>1 as hypothesis. It follows from absolute convergence of the von Mangoldt Dirichlet series and the nonnegative polynomial with coefficients18,30,17,6,1; there is no RH premise. The frequencies j*t for j=1,2,3,4 all lie in[2.39,4e8] when t is in[2.39,1e8]. The j=1 term receives Z>=55.5; j=2,3,4 use the nonnegative Stechkin bound Z=0. The real term is<=500/7; source logarithm bounds actually leave more than .44 of slack.

The resulting contradiction is exactly

    0 <=18*(500/7)+54*6.85-30*55.5=-657/70<0.

The coefficients54=30+17+6+1 and30 on the distinguished subtraction match the source polynomial. Negative imaginary parts are handled by xiF conjugation, preserving the real part and reversing the imaginary part. All endpoints2.39 and1e8 are included. The final zeta theorem uses strict-strip xiF equivalence and the unconditional height floor, so no pole conversion or uncovered height interval remains.

## Verification record and next target

check_fixed_gap_rationals.py was run successfully and independently checks19 exact positive rational margins. Results are saved in fixed_gap_rational_results.json. This verifies the arithmetic, not Lean elaboration. Neither imported original proof closure nor new helpers were compiled by this reviewer, and no #print axioms evidence was available.

Minimal next target: compile ZetaLowUnconditional and this exact ZeroFreeFixedGap draft, inspect theorem types and axioms, and then check the far-asymptotic consumer. No final Goldbach closure follows from this source audit.
