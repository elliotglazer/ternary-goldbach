# Resumed prime-estimate research, 2026-11-11

Pinned source: calr3/ternary-goldbach at23b2d68ca344203d4384e0aff7affa4ec034bef9.
Research only: no Lean build, source edit, new axiom or proof implementation.
The original10^27 endpoint and BinaryGoldbachInput are unchanged.

## First bounded result: full P6 has an elementary paper replacement

The original producer is Prelim/LambdaMu.lean:761,
`sum_vonMangoldt_nonprime_lt`:

    y>0 ==> NP(y):=sum_{1<=n<=floor y, n not prime} Lambda(n)
               <1.4262 sqrt(y).

This feeds MinorArcs/TypeIIReduction.lean:388. The new argument preserves the
**entire original domain and constant**, not merely the EBound large-y use.
It uses neither QRH nor a new finite verification. Its only finite inputs are
already present source theorems. Paper audit is requested; this note is not
a Lean validation claim.

### A. The unbounded range N>=10^12

Use the existing unconditional `LambdaMu.nonprime_sum_le4:589`:

 NP(N)<=thetaN(sqrt_nat N)+thetaN(floor N^(1/3))
       +thetaN(floor N^(1/4))+N^(1/5) log N.

`Helfgott/Chebyshev.lean:24 theta_le` gives theta(m)<=m log4 for every m.
The thetaN convention is transported through the exact prime-sum identity
`Prelim/ThetaExplicit.lean:33 theta_eq`; there is no global psi input.
Floor and natural-square-root bounds therefore give

 NP(N)/sqrt(N) <= log4*(1+N^(-1/6)+N^(-1/4)) + log(N)*N^(-3/10).

For N>=10^12, the two powers are <=.01 and <=.001. Moreover log4<1.387,
using log4=2log2 and `Real.log_two_lt_d9`. Put L=log N. Since
exp(1)<2.72 and2.72^27<10^12, L>=27. The function L exp(-3L/10)
is decreasing for L>=10/3. Existing unconditional
`ThetaExplicit.pow_exp_anti:89`, with k=1,c=3/10,L0=27, supplies exactly
this comparison. Thus

 L exp(-3L/10) <=27 exp(-8.1) <=27 exp(-8)
                 <27/(2.7^8) <.01,

using exp(1)>2.7 and the exact rational check2.7^8>2700. Hence

 NP(N)<[1.387*1.011+.01]sqrt(N)
      =1.412257 sqrt(N)<1.4262 sqrt(N).

The margin in the last comparison is exactly .013943. This argument replaces
the current large branch's call to global `psiN_le` at sqrt(N). It is stronger
than the earlier EBound-only1.5 coefficient and does not depend on EBound.

### B. Audit of the finite branch, not an assumed draft conclusion

The prior scratch `moebius/FiniteBoundary.lean` contains the proof scripts
`psi_small_two_sided_finite`, `psiN_le_finite`, `nonprime_mid_finite`, and
`nonprime_small_finite`. They remain uncompiled. The complete mathematical
argument behind them is as follows.

1. For12<=m<10^6, `SmallTab.small_table`, rewritten by
   `PsiTwoSided.thS_add_ppS:65`, gives abs(psiN(m)-m)<=sqrt(m).
   No use of the conditional full-range `psi_two_sided` is necessary.
2. For1<=m<=700, `Small.psi_lt_small_700` gives psiN(m)<1.03883m.
   For701<=m<10^6 the preceding estimate gives the same weak bound because
   sqrt(m)>=26.47 and .03883*26.47>1. Atm=0 the sum is zero.
   This proves psiN(m)<=1.03883m for every m<10^6 directly.
3. For10^6<=N<10^12 set v=N^(1/12), so v>=3.162 since3.162^12<10^6.
   All three arguments in nonprime_sum_le4 are strictly below10^6:
   sqrt_natN<10^6, floorN^(1/3)<10^6, floorN^(1/4)<10^6.
   The square-root argument is at least12. Steps1–2 give

      thetaN(sqrt_natN)<=v^6+v^3,
      thetaN(floorN^(1/3))<=1.03883v^4,
      thetaN(floorN^(1/4))<=1.03883v^3.

   The existing elementary `log_le_div_e:671`, applied toN^(1/20), gives
   N^(1/5)logN<=(20/e)N^(1/4)<=7.3576v^3. Therefore

      NP(N)<=v^6+1.03883v^4+9.39643v^3<1.4262v^6.

   The last step is the polynomial inequality
   .4262v^3-1.03883v-9.39643>0 forv>=3.162.
   At3.162 its value is495541922771/625000000000>0. Its derivative is
   positive there and thereafter; alternatively expand in w=v-3.162>=0,
   with all nonconstant coefficients positive. No unspecified numerical
   comparison remains in this step.
4. For1<=N<=10^6, the existing
   `SmallNP.nonprime_small_kernel` supplies the exact1.4262 bound directly.
   This overlaps step3 at10^6. StepA takes over atN=10^12, which is excluded
   from step3. There is no uncovered integer endpoint.

### C. Real cutoffs and production consequence

For y>0 set N=floor y. If N=0 the sum vanishes and sqrt(y)>0. Otherwise use
stepB forN<10^12 and stepA forN>=10^12, then sqrt(N)<=sqrt(y).
The strict bound survives even at integer y. This is exactly the production
P6 type, with no added hypothesis and no change to TypeIIReduction or its
1.4262^2*W term. It also supplies the global nonprime producer needed by
other source branches, though those branches may retain separate psi inputs.

The proposed future integration removes the unnecessary Fact binders from
nonprime_mid and nonprime_small after replacing their calls as above, then
replaces only sum_vonMangoldt_nonprime_lt's large proof branch. It does not
claim to remove any Fact from a wrapper that still uses P1–P5 orP7.

## Second result: finite P1/P4/P5/P7 coverage can reach10^9

These are paper consequences of existing `PsiSieveMain.sieve_table3:28160`
and the full P6 argument. They do not close the unbounded producers. The
endpoint10^9 is deliberately excluded because the sieve table is strict.
For real1e6<=t<1e9 the source table gives

    t-2sqrt(t)<=theta(t)<=t+.1sqrt(t).

Combining the upper bound with P6 and the exact psi=theta+NP identity gives
psi(t)<=t+1.5262sqrt(t). The lower bound psi(t)>=t-2sqrt(t) follows from
nonnegative NP. These preserve real-floor conventions.

* P1: for1e6<=t<1e9, psi(t)/t<=1+.0015262<1.03883. Together with the finite
  small proof in stepB, the original coefficient is now available for0<t<1e9.
* P4: for2.5e7<=t<1e9, sqrt(t)>=5000, so
  psi(t)/t<=1+1.5262/5000=1.00030524<1.0064.
* P5: put A=1e6. Abel summation gives
  F(y):=sum_{n<=y}nLambda(n)=y psi(y)-integral_0^y psi(t)dt.
  On[A,y] use the lower bound t-2sqrt(t), and on[0,A] use nonnegativity.
  For2.5e7<=y<1e9 this yields

    F(y)<=y^2/2+(1.5262+4/3)y^(3/2)+A^2/2.

  The discarded term -(4/3)A^(3/2) only improves the bound. Relative to
  y^2/2 the coefficient is at most

    1+2*(1.5262+4/3)/5000+1e12/(2.5e7)^2
       =37602893/37500000 <1.022.

  Thus the original strict P5 coefficient holds across this finite range,
  including its lower endpoint. This is a direct Abel argument; it does not
  require the original psi_mul_a17 proof's stronger global premises.
* P7: for2e6<=y<1e9, the entire interval[y/2,y] lies inside the sieve range.
  Stieltjes summation by parts gives exactly

    sum_{y/2<p<=y}(log p)^2
      =log(y)theta(y)-log(y/2)theta(y/2)
       -integral_(y/2)^y theta(t)/t dt.

  Substitute the upper theta bound at y and the lower theta bounds at y/2
  and inside the integral. The result is at most

    y log(y)/2 + y(log2-1)/2
     +.1sqrt(y)log(y)+2sqrt(y/2)log(y/2)
     +4(sqrt(y)-sqrt(y/2)).

  Bound the positive error by1.6sqrt(y)log(y)+4sqrt(y), using sqrt2<1.5.
  The function log(y)/sqrt(y) decreases fory>=e^2. Since
  sqrt(2e6)>1400 and log(2e6)<14.51 (existing LambdaMu.log_2e6_le:1529),
  this error/y is at most(1.6*14.51+4)/1400<.02.
  The main correction is less than-.15y since log2<.7. The substantial
  remaining slack proves P7's original ylog(y)/2 bound. Its exact prime
  endpoints are floor(y/2)<p<=floor(y), identical to the source contract.

For eventual Lean implementation these continuous Abel identities can either
be imported from the existing Chebyshev/Stieltjes APIs or proved with finite
floor partitions and the exact `LambdaMu.abel_theta`/`abel_Ioc` identities.
No such API implementation is claimed here. The paper inequalities are fully
specified and do not require a new prime computation below10^9.

## Exact arithmetic replay and status

`resume_primes_20261111_cert.py` checks every new decimal comparison above
with Python Fraction, including the polynomial expansion coefficients,
2.72^27<10^12,2.7^8>2700, the finite small-linear conversion, the1.412257
large coefficient, and the P4/P5/P7 finite numerical budgets. It exits0.
The script does not validate analytic identities or Lean proofs.

P6 is a complete paper replacement assembled from identified unconditional
source inputs, pending independent review and later formalization. P1/P4/P5/P7
have improved finite overlap through, but not including,10^9. Their remaining
unbounded ranges, plus P2/P3 and the Mobius profile, remain separate research
obligations. This does not close the original Goldbach theorem.