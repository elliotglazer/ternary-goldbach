# Independent review of principal block-wave error

2026-11-11. Verdict: PASS as a deterministic finite arithmetic error theorem under the stated operation-error bounds. No correction is requested. The proof is generic in the block parameters; a finite collection of tested allocations is not being used as its justification. No numerical wave block, Hardy sign, zero scan, Lean/Lake command, dependency edit, or frozen-source change was made.

The reviewed note is `work/qrh-blueprint/turing-scalars/PRINCIPAL_BLOCK_WAVE_ERROR_2026-11-11.md`, SHA256 `F93CEC28EB94AB14BF6F10B74828C39D0634AA11D7D9A400377A8A4302D20EE0`.

## Accepted expression and pinned inputs

I read the actual simple-phase K0 assembly and its independent review, and the stable interval plan and its review. Their hashes match the note:

| Component under `work/qrh-campaign/agents/` | SHA256 |
| --- | --- |
| `independent-feasibility/PRINCIPAL_SIMPLE_PHASE_K0_PAPER_ASSEMBLY_2026-11-11.md` | `E14AC6ADC47771795B75142340962F9FEA95BC499049D7BBD0D4103B7019B6D6` |
| `prime-estimates/REVIEW_PRINCIPAL_SIMPLE_PHASE_K0_PAPER_ASSEMBLY_2026-11-11.md` | `A39ED6F31EE45499080BD95357B453F065F0FFEEE78AFDC9B794775460A73633` |
| `prime-estimates/PRINCIPAL_K0_INTERVAL_EVALUATION_PLAN_2026-11-11.md` | `E3B6843DA11022ACBC0A7BBAFA5B8C125CF38B88127B69DCB3B8FF6EB90B157A` |
| `independent-feasibility/REVIEW_PRINCIPAL_K0_INTERVAL_EVALUATION_PLAN_2026-11-11.md` | `D483173A41EACEAB527579BB92A9F2795FB93161BAFAB47C2E249D264FD01197` |

The wave convention exp(-it log n) is correct: taking 2Re after multiplication by exp(i thetaHat) gives exactly 2cos(thetaHat-t log n)/sqrt(n). The correction is -(-1)^N*a^(-1/2)*F(z), with z=1-2(a-N). This is the assembly's sign, not its negative. The phase is theta0+1/(48t); the accepted analytic error .451*t^(-3/4) already includes replacing the true phase by this particular thetaHat. The arithmetic phase approximation below is to thetaHat and does not change that analytic theorem.

F is the analytic removable extension, including F(+/-1/2)=1/2. The stable sinc routine evaluates that function. The note does not substitute totalized division at its removable points or replace the correction by the earlier theta0-only sign proxy.

## Exact recurrence and accumulated center error

For real log n and exact rational t_j=t0+jh,

    w_n(t_j)=n^(-1/2)*exp(-it_j log n),
    r_n=exp(-ih log n),
    w_n(t_(j+1))=r_n*w_n(t_j),    |r_n|=1.

Let E_j=|w_n(t_j)-v_(n,j)| and a_n=n^(-1/2)<=1. With nonnegative error tolerances E0, delta, eta as stated in the note, the exact decomposition

    r_n*w_j-v_(j+1)
      =r_n*(w_j-v_j)+(r_n-q_n)*v_j+(q_n*v_j-v_(j+1))

gives

    E_(j+1)<=E_j+delta*|v_j|+eta
             <=(1+delta)E_j+delta*a_n+eta.

The potentially growing quantity is the computed center v_j; the estimate |v_j|<=a_n+E_j correctly accounts for it. No assumption |q_n|=1 is made.

Induction gives, including delta=0,

    E_j <= (1+delta)^j E0
            +(delta*a_n+eta)*sum_(k=0)^(j-1)(1+delta)^k.

If j<=B and B*delta<=1/2, each geometric term is at most exp(1/2)<2. The latter elementary inequality follows by comparing the exponential series termwise to sum_(k>=0)(1/2)^k=2, with a strict loss from k=2 onward. Thus

    E_j <= 2*(E0+B*(delta+eta)).

This derivation does not divide by delta and includes j=0. Correlations among log or phase approximations do not affect the deterministic triangle inequalities.

## All allocations and the final arithmetic bound

The prescribed bounds give

    2*(E0+B*delta+B*eta)
      <= (e/M)*2*(1/64+1/128+1/128)
      = e/(16M).

The separate B*delta<=1/2 guard is satisfied. In fact e<=1 and M>=1 make B*delta<=1/128 under the second delta bound alone, so the displayed minimum is conservative.

There are at most M active waves. Replacing them by centers costs at most e/16 in the complex sum; the separately charged summation rounding costs at most another e/16. If W is the exact active sum and S is its computed center, |W-S|<=e/8.

For N>=1, monotonicity of x^(-1/2) yields sum_(n=1)^N n^(-1/2)<=2sqrt(N)-1<2sqrt(M). Hence |S|<=2sqrt(M)+e/8<=A for any certified A>=2sqrt(M)+1. With P=exp(i thetaHat), the correct product decomposition is

    P*W-u*S = P*(W-S)+(P-u)*S.

Its norm is at most e/8+e/16=3e/16 because |P|=1 and |P-u|<=e/(16A). Taking 2Re costs at most a factor 2, giving 3e/8. This decomposition needs no independent bound for |u|.

Add the stated e/8 charge for the final multiplication, real-part scaling and correction addition, and e/4 for the correction center itself. The total is

    |k_j-Khat(t_j)| <= 3e/8+e/8+e/4 = 3e/4 < e.

Every allocation has a distinct role. Rectangular component arithmetic is acceptable only after its component errors have been converted to these Euclidean complex-norm bounds. A precision setting in bits alone is not that proof. Likewise, uncertainty in h log n and t0 log n belongs in the rotation and initial-wave errors, respectively.

## Saddle activation, reanchoring, and the selected finite range

All M waves are initialized and propagated whether or not currently active. Therefore the error bound already applies to a wave when N first reaches its index. Each sample still needs the exact independently certified N=floor(sqrt(t/(2pi))) and the corresponding correction branch. No continuity of the piecewise finite Khat expression across a saddle change is assumed.

For rational t, equality sqrt(t/(2pi))=k with positive integer k would make pi rational. This justifies eventual success of the stable plan's strict floor certificates. It does not give a uniform precision bound near transitions. Samples are points; one floor witness cannot be used for an entire uncertain height interval crossing a saddle.

For t<=1000000, the claimed M=398 cap has a short rational check. The existing `Real.pi_gt_d4` gives pi>3.1415>3141/1000, and

    2*(3141/1000)*399^2-1000000 = 50341/500 > 0.

Thus a<399 and N<=398 throughout that range. Also 398<400 implies 2sqrt(398)+1<41, so A=41 is valid. Outside the stated finite range a new M must be certified.

A new block must initialize its waves afresh within E0, as stipulated. Reusing previous terminal centers without charging their accumulated errors would not satisfy this theorem. Rotations may be reused for blocks with the same h only when their original delta certificate meets the current block's tolerance.

## The height-dependent .019 reserve

Let t_top=t0+Bh and choose e<=min(1,19/(1000*t_top)). Since 1<=t_j<=t_top,

    |k_j-Khat(t_j)| < e
      <= .019/t_top <= .019/t_j <= .019*t_j^(-3/4).

Combining with the accepted strict analytic error gives |hardyZ(t_j)-k_j|<.47*t_j^(-3/4). There is no reversal of the endpoint inequality. In fact retaining the stronger 3e/4 arithmetic bound yields an upper coefficient .451+.75*.019=.46525, leaving additional slack below .47.

If an implementation reports a rational interval rather than this analytic inequality, it must outward-enclose the positive fractional-power radius and charge that outward rounding. The slack permits this by refinement; a rounded-down radius is never justified by the error theorem. The stable point plan already makes this radius-enclosure requirement explicit.

I independently evaluated the dimensionless allocation fractions, the .451+.019 join, the sharper .46525 coefficient, and the saddle/A41 rational comparisons using exact Fraction/integer arithmetic. These are checks of the displayed universal derivation. No inference is made from the coordinator's 193 finite allocation examples, and no actual wave block was computed.

## What this result supplies

For B steps, the operation count M initial waves, M rotations, and MB rounded center updates is correct. There are B+1 sample positions if every position is retained. Each retained sample also needs its active sum, independently evaluated phase and correction, and floor witness. O(M) streaming wave storage does not describe the total storage of a fully serialized proof certificate; the note does not claim that it does. Replaying only a sparse subsequence may favor another method, as stated.

The accepted elementary enclosures can in principle refine to the finite positive operation tolerances. This proves existence of accurate Khat arithmetic under the stated input contract, not successful sign separation, a uniformly terminating sign search, or practical throughput. K0's fixed analytic remainder does not decrease when arithmetic precision increases. Completeness still needs the actual retained signs, their order and disjointness, and the independent all-zero count. Multiple zeros or allowed off-line zeros can obstruct a sign-based route even when the weaker target strip is true.

The deterministic arithmetic theorem and its connection to the accepted Khat expression pass review. Its Lean implementation, certified update semantics, actual block data, and any full sign-chain or performance claim remain open.
