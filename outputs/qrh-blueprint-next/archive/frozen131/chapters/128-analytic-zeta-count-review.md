# Independent review of the analytic psi zero-count bound

2026-11-11. Reviewed the frozen proposal `mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md`, SHA256 `4648E4C454F4344D4F110E878F6CF619F5AC2128CAC91C2658E443FA3D1DF303`, and checker `resume_psi_analytic_count_20261111.py`, SHA256 `DF23382FEBD4262FBAD80409A7303E4C56B6471164CBF2CD8D65145BF7C2EA94`.

Verdict: PASS as a paper analytic derivation and conditional scalar implication. No mathematical correction is required. In particular, the proposed bound

    N(t)<= t/(2*pi)*(log(t/(2*pi))-1)+7/8+5*log(t)+20,
    t>=1500,

does not use a finite zero count or finite RH computation. The normalization and branch issues can be resolved directly as detailed below. This review does not turn the new analytic lemmas, the finite spectral premises, or the rational checker into proved Lean declarations.

## Growth and the Jensen application

I inspected the actual pinned source `TernaryGoldbach/Explicit/ZetaGrowth.lean:177`. Its norm bound on the entire zetaF, divided by |s-1| using `zetaF_of_ne`, gives exactly

    |zeta(s)|<=|s|/|s-1|+|s|/Re(s)

for Re(s)>0 and s!=1. On |z-2|<=1.9 and s=z+it or z-it, the proposed bounds Re(s)>=.1, |s|<=t+3.9 and |s-1|>=t-1.9 are valid. At t>=1500 this gives |zeta(s)|<12t. The two possible poles in the z-plane are 1-it and 1+it, outside a neighborhood of the closed disk.

The auxiliary function f_t(z)=(zeta(z+it)+zeta(z-it))/2 is analytic and equals Re zeta(z+it) on real z. Its center is a positive real number: Re zeta(2+it)>=2-zeta(2)>1/4. The strict estimate zeta(2)<7/4 follows by separating the n=2 term and comparing the decreasing n>=3 tail with integral_2^infinity u^(-2) du. Thus f_t is not identically zero, and its real roots on the compact segment are finite.

The cached Mathlib file inspected was

    C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/Analysis/Complex/JensenFormula.lean

At line389, `AnalyticOnNhd.sum_divisor_le` has the claimed hypotheses: positive inner radius, strictly larger outer radius, M>=1, analyticity on a neighborhood of the closed outer disk, nonzero center, and a sphere norm upper bound. Its conclusion counts the closed inner disk. It does not demand that the outer boundary be zero-free. The choices r=3/2, R=19/10, M=12t therefore give

    n<log(48t)/log(19/15).

Here n is the analytic zero multiplicity sum of f_t. It is not a zeta multiplicity count. Every distinct real-part root on [1/2,2], including a possible endpoint root at1/2, is counted at least once. Analytic divisor multiplicities are nonnegative, so this is enough for the crossing argument.

## Continuous argument and the exact count normalization

For a height t that is not a zero ordinate, zeta is nonzero on the horizontal path. Between consecutive roots of its real part, it lies in one open half-plane. A continuous argument lift on that interval has endpoint variation of absolute value at most pi. Limits exist at the partition points because zeta itself is nonzero there. Summing the variations gives at most (n+1)*pi. Tangencies and multiple real-part roots cause no problem; n only becomes a larger upper bound.

On Re(s)=2, Re zeta>1/4 fixes the argument lift in (-pi/2,pi/2), starting at arg zeta(2)=0. Thus the path-continuous S(t) used by the proposal satisfies |S(t)|<=n+3/2. Replacing it by the pointwise principal endpoint argument would be incorrect, but the proposal explicitly does not do that.

For clarity, the following derivation supplies the normalization in its equation(9) without appealing to any positive-height zero count. Let P be the path 2 to2+it to1/2+it, and let A be the continuous argument variation of the entire source xiF along P. Its factor1/2 convention differs from the conventional xi by a positive real constant, which has no effect on A.

Consider the counterclockwise rectangle with vertical sides -1 and2 and heights +/-t. The unconditional source facts `Explicit/Xi.lean:42,51,56` exclude xiF zeros on or outside the critical strip and identify its zeros within the strip with those of zeta. The functional equation is at line25. Conjugation and the local nonzero multiplicative factors preserve actual analytic multiplicity.

There are no real xiF zeros. One can use the alternating-eta argument in the proposal, or avoid that extra bridge by generalizing the source proof `Xi.re_zetaF_half_ge` at line79. For real0<sigma<1, the sawtooth in Izeta is nonpositive and the real power is positive, so Izeta(sigma)<=0. Hence `ZetaGrowth.zetaF_eq` gives

    zetaF(sigma)=sigma+sigma*(sigma-1)*Izeta(sigma)>=sigma>0.

The source xiF formula then shows xiF(sigma)>0. At0 and1 it equals1; the unconditional strip exclusion covers the remaining real axis. This requires no low-height zero exclusion or count.

The rectangle therefore contains 2N(t) zeros with multiplicity. Its four consecutive pieces are P, the reflected-conjugated reverse of P, the image of P under s->1-s, and the conjugated reverse of P. The two xi symmetries make the argument variation on each equal to A. The argument principle gives

    4*A=2*pi*(2*N(t)), hence A=pi*N(t).

Along P, the continuously lifted argument of s at the endpoint is arctan(2t), and that of s-1 is pi-arctan(2t). Their sum is exactly pi. The Gamma logarithm is analytic on the right half-plane and real on the positive axis, so the Gamma and pi-power factors contribute exactly theta(t). The zeta factor contributes pi*S(t). Consequently

    A=pi+theta(t)+pi*S(t),
    N(t)=1+theta(t)/pi+S(t).

This fixes the +1 without calibrating against a known zero count. It also shows why using the analytic log-Gamma and the path-continuous zeta argument is essential. The source xiF uses no factor1/2, which changes neither argument variations nor zeros. The analytic contour method is consistent with [Trudgian, section2, equations(2.1)-(2.5)](https://arxiv.org/pdf/1208.5846); his separate all-height numerical S bounds are not used here.

## Gamma phase and coefficient checks

I checked the stated Laplace form of Binet against [DLMF5.9.10_2](https://dlmf.nist.gov/5.9.E10_2). Its domain is Re(z)>0, and its left side is the analytically continued logarithm of Gamma, normalized on the positive axis. The proposal correctly distinguishes it from the principal logarithm of Gamma(z).

The kernel inequalities are algebraically correct. After multiplication by positive denominators, the lower numerator is (u-2)exp(u)+u+2, with coefficients (n-2)/n! for n>=3. The upper numerator is (u^2-6u+12)exp(u)-u^2-6u-12, with coefficients (n-3)(n-4)/n! for n>=5. All earlier coefficients cancel. Thus0<=k(u)<=1/12 for all u>0, not merely on a sampled range.

It follows that |R_Gamma(z)|<=1/(12*Re(z)). At z=1/4+it/2 this is1/3. I independently expanded Im[(z-1/2)log z-z], obtaining exactly the proposal's two positive correction terms

    (t/4)*log(1+1/(4t^2))+(1/4)*arctan(1/(2t)).

They are at most3/(16t). Therefore the normalized count-phase error is at most (1/3+3/(16t))/pi<1/8 for t>=1500, using only pi>3. No missing factor of2 or pi appears.

Combining the count identity, crossing bound and Gamma error gives

    |N(t)-F(t)|<log(48t)/log(19/15)+13/8
                 <(9/2)*log(t)+18+13/8
                 <5*log(t)+20.

The final inequality has positive slack; it does not depend on a delicate large-height asymptotic.

## Closed heights, partial summation and the weighted moment

The argument is first applied away from zero ordinates. Entire xiF is nonzero as a function, and its zeros are locally finite in the closed critical strip. For any t>=1500 there are heights t_j decreasing to t that avoid all zero ordinates. The closed count N(t)<=N(t_j), while the majorant is continuous. Passing to the limit gives the required non-strict upper bound with every zero at t counted with its full multiplicity. No half-weight convention or assumption that1500 and1000000 avoid zeros is needed.

I independently checked the moment reduction. For the finite positive-ordinate measure,

    sum_(0<gamma<=T) m/gamma
      =Q_a+N(T)/T+integral_a^T N(t)/t^2 dt.

Zeros at a have zero contribution to Q_a and are recovered by the other terms. Zeros at T occur in N(T)/T. Integration by parts of the smooth majorant R(t)=A*log(t)+B gives the upper remainder [A*(log(a)+1)+B]/a. The F contribution is precisely the displayed B0 in the author note.

Under the separately required narrow strip .499<beta<.501 and exclusion of |gamma|<=14, reflection averaging bounds the exponential weight by (1+exp(.035))/2 times the both-sign ordinate moment. Conjugation doubles the positive-ordinate moment, cancelling that denominator2. Thus equation(M), with prefactor1+exp(.035), has the correct multiplicity normalization. These finite spectral facts remain assumptions of the conditional moment implication, not conclusions of the analytic count proof.

## Independent arithmetic replay and status

The new checker `major-constants/review_psi_analytic_count_20261111.py` imports no code from the author. It bounds logarithms by a positive atanh series with an explicit geometric tail, independently of the author's exponential-inversion log bounds. It also checks pi by Machin's formula, exponentials by positive Taylor sums, the disk constants, Gamma error and coefficient cancellations. It makes no zeta calls and consumes no zero data.

Both independent and frozen author checks exited0. The independent error-budget interval is

    69.554816754858 < admissible coefficient budget <69.554816754859.

For the selected A=5,B=20, its rounded rational upper bound is

    W35 <=5997289669111/250000000000 =23.989158676444<23.990<24.

The original checker gives a slightly looser but consistent bound because its log/pi enclosures are coarser. Agreement of acceptance is not being substituted for the analytic review above.

Remaining formal work is substantial but explicit: continuous argument lifting and its partition bound, the argument principle and four-piece symmetry calculation, normalized analytic log-Gamma/Binet, the real-axis exclusion or its source generalization, multiplicity transport, the closed-height limit, and exact replay of the scalar bounds. The source Jensen and zeta growth statements are genuine existing inputs. The finite height14 exclusion, narrow strip through one million and Q1500<=2 remain unproved certificate tasks. No historical finite count, Platt computation, or new permitted root assumption has entered this derivation.
