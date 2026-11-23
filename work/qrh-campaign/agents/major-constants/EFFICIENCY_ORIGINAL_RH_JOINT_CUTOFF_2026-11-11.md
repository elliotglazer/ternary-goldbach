# Spending the original-RH major/minor reserve: R=135000 at unchanged N0

2026-11-11. Bounded paper/source and rational-scalar research. This extends the independently reviewed original-RH V2 and R138000 reports; it does not change them. No Lean sources, declarations, dependencies or frozen artifacts were edited. No build, prime search, zero computation or analytic-function evaluator was run.

## Result and what changes

The actual final positivity inequality permits **R=135000** at the same **N0=989*10^24**, using the same original finite-RH heights, smoothing functions and all-consumer scalar envelope. The exact certified normalized margin after the nonprime subtraction is

    6382725162604415567444907717114329003
    / 41825194012491047334000000000000000000000
      > .0001526.

This does not preserve the separately rounded minor constant1.0376. Instead, it replaces the final subtraction of1.049-1.0376 by the actual major lower bound minus the actual minor upper bound. It preserves the desired positive odd-prime representation count, conditionally on the same localized original finite-RH inputs and the source refactors already required by V2.

The bounded search tested138000,137000,136000,135000,134000 on a1000 grid, stopping at the first failure, and then134900 in one100-step refinement, again stopping at the first failure. Thus135000 is the smallest demonstrated cutoff in this search, not a global optimum. The two failed budgets are not proofs that the actual integrals fail positivity.

## 1. The exact final consumer and nonprime normalization

`Helfgott/Main.lean:30–51` proves the weighted representation bound by splitting the integral over the actual measurable major/minor partition. Its only numerical operation is

    repSum(True,N) >= (a_R-b_R)*x^2/49,

where a_R is a lower bound for the real major integral and b_R is an upper bound for the integral of the minor norm. The triangle inequality controls the real minor contribution by the negative of this norm. No positivity of the complex major integrand is assumed.

`Inputs.nonprime_input:126–148` bounds the difference between the full representation sum and the sum over odd primes by

    6.7e6 * N*sqrt(N)*log(N).                               (1)

It uses the actual sup-norm bounds400 and6.2, Chebyshev bounds psi(N)<=1.387N and psi(N)-theta(N)<=1.6sqrt(N), and the extra even-prime term log2. The previously reviewed lower-threshold report verifies this complete proof at N>=N0, including the root/floor and log2 absorption steps. It does not replace6.7e6 by the sharper unproved7.3306 option mentioned in source comments.

Write c0=N/x=2+9/(196sqrt(2pi)). The existing `Numerics.xOf_denom_bounds:11–21` gives0<c0<=2.02. Dividing (1) by x^2/49 gives the exact normalized expression

    Cnp(N)=49*c0^2*6.7e6*log(N)/sqrt(N).                    (2)

This division retains the factor49 and both powers of c0. It does not replace N by x inside a logarithm or square root.

For N>=N0, log(N)/sqrt(N) is decreasing: its derivative is

    N^(-3/2)*(1-log(N)/2)<0.

The sign holds since N0>9>e^2. Also N0<10^27, so log(N0)<27log10<27*2.303. The last elementary log bound follows from the positive exponential Taylor sum through degree24 at2.303 exceeding10; the new script verifies that rational inequality. Let d=floor(sqrt(N0)), computed by integer square root and checked by d^2<=N0<(d+1)^2. Equations (1)–(2) yield, uniformly for all N>=N0,

    Cnp(N) <= Cnp_bar
      :=49*(2.02)^2*6.7e6*(27*2.303)/d
       =20618162523/7784250095800
       <.002648703<.00265<.00271.                           (3)

Thus the earlier .00271 diagnostic was a valid uniform subtraction, rather than an unexplained numerical allowance. This report uses the exact rational Cnp_bar in(3). Keeping .00271 would also pass at R135000, but no second parameter search using that weaker number is needed.

Combining the actual partition, (1), and(3),

    repSum(odd primes,N) >= (a_R-b_R-Cnp_bar)*x^2/49.        (4)

Since x>0, a strictly positive coefficient in(4) gives a nonzero odd-prime representation sum. The existing extraction theorem `Main.isSumOfThreePrimes_of_repSum_ne_zero:55` applies unchanged. This argument replaces `final_inequality_crude`'s particular .0114 target; it does not try to instantiate that old target with different constants.

## 2. All analytic errors and the changed minor interface

The definitions of a_R and b_R are exactly those of the accepted V2 envelope. In brief,

    s_R=13.597558-(15015/5760)*upperlog(150000/R),
    jfull_R=.638108*s_R-.00108,
    j_R=(jfull_R-100001*8e-11)/1.00001,
    C_R=2*(.6606*(1-1/199)-22.1/R),
    a_R=.800689*C_R-E,

where every term of the original summed major error remains

    E=(3.67e-6+49*8.85e-7/9)*8.79
       +(9*8.85e-7*7.78/2+49*2.03e-5)*2.85
       +49*8.85e-7*.640208*13.59756/9.

For each finite scale cell, its bound for the reduced numerical expression is

    U_R=G_Y(R)*(cl0*sD-j_R)+sD*old_chain+old_tail,
    b_R,cell=1.0005*U_R+2001*22.75*8e-11.                  (5)

The same asymptotic expression from V2 is retained. Define b_R to be the maximum over all nine finite bounds and that asymptotic bound. Their intervals cover all x>=4.9e26. The corrected bounded parser still explicitly asserts Y=[1e25,3e25,1e26,1e27,1e28,1e30,1e34,1e42,1e58] and serializes every source binding. All log, root and sign guards of the accepted V2 recipe remain.

The actual source `MinorTotal.NumericsGoal:82–87` currently ends with Mexpr<=1.037. Inspection of `minor_total:323–526` shows that this numerical upper bound is used only in the final scalar step at516–525. Before that step the proof gives the right side of(5) with Mexpr itself. The new interface retains all existence/size hypotheses for r2 and substitutes a cell-specific U_R, or the maximum b_R after the split. Thus allowing b_R>1.0376 does not bypass an earlier hypothesis used to obtain the analytic estimate.

In particular the original sig(x), with its366.91/sqrt(x) term, is unchanged. So are all large-sieve chains, the prime-power energy8e-11, the uniform star-sum factor22.75, and both final triangle factors1.0005 and2001. No .65 energy estimate or QRH spectrum is used.

The passing predicate is now a_R-b_R,cell-Cnp_bar>0 for each of the ten bounds, in addition to every validity guard: R even in[100000,150000]; positive mass/J/I/singular and major lower bounds; positive upper base coefficients; valid ghat log/root domains; and basegap<.014<.03<ghat. The old targets1.049 and1.0376 remain diagnostic fields only and do not define acceptance.

## 3. Exact bounded search

The following upper displays are rounded upward. The last column is the sign of the exact rational joint margin, not the sign inferred from displayed numbers.

|R|controlling minor upper bound|exact joint budget passes?|
|---:|---:|:---:|
|138000|1.0375704|yes|
|137000|1.0404968|yes|
|136000|1.0434566|yes|
|135000|1.0464512|yes|
|134000|1.0494809|no|
|134900|1.0467519|no|

Cell0 controls every tested row; all other finite cells and the asymptotic branch are still computed and checked. At R135000,

    a_R =1761760471717520694083/1679062500000000000000,
    b_R =209292325007822254773386391/200002000000000000000000000,

and their difference minus(3) is the exact positive fraction stated at the beginning. The basegap is224554049/16875000000<.013307<.014 and j_R>8.50028. No width, sign or tail guard fails in either rejected row; the failed condition is the final joint coefficient in cell0.

These are bounds on the original functions. A negative computed joint envelope below R135000 does not imply a negative true representation count, nor rule out a sharper proof. No such sharper branch is attempted here.

## 4. Endpoints, spectral work and remaining proof obligations

The threshold proof is unchanged: pi>3.14 gives c0<989/490 and (989/490)*(4.9e26)=N0, so x>4.9e26 even at N=N0. The finite-cell floor and r2 conditions therefore retain their previous domains. The underlying sets are the actual open major arcs intersected with(0,1] and their measurable complement; the partition identity in(4) includes every endpoint. The small-case/analytic overlap at the even integer N0 remains the accepted lower-threshold plan. No finite interval is left uncovered and no new ladder is required by this cutoff change.

At R135000 the proposed nonprincipal finite-RH domain is all primitive characters at odd c<=135000 and4|c<=270000, with inclusive zero heights1e8/c and max(1e8/c,200+7.5e7/c), respectively. It includes inverses; principal inputs stay unchanged. Keeping q-tilde<=2R in the base-gap witness proves these conductor limits. All widths and twists are smaller than the original ones. The old broad PlattGRH instance is still not an acceptable proof of the claimed dependency reduction: localize the exact character estimates and rebuild the new arc consumers.

Relative to the restricted R150000 family, eligible nonprincipal integer conductor indices decrease from149999 to134999; relative to R138000, a further3000 indices disappear. Actual primitive-character/height counts and generation/checking work need their own inventory. N0/B, the finite-prime-chain endpoint, and principal spectral heights do not increase. This offers a modest additional possible family saving with no new finite-range cost, not a measured speedup or an adopted strategy.

Beyond V2's already listed source refactors, the new proof work is explicit: generalize the last scalar bound in NumericsGoal/MinorTotal, supply the elementary uniform bound(3), and use the parameterized major-minus-minor subtraction in Main followed by the unchanged odd-prime extraction. Every underlying analytic estimate and every finite-RH premise is retained. No claim of Lean elaboration or provider validation is made.

## Frozen dependencies and artifacts

Paths are relative to the workspace. V2 pins all reused analytical source files. The three final-consumer source files are additionally pinned below when this report is frozen.

|Artifact|SHA256|
|---|---|
|`work/qrh-campaign/agents/major-constants/EFFICIENCY_ORIGINAL_RH_MODEST_CUTOFF_V2_2026-11-11.md`|`33A3D9645BD9A8F856DD13A40028FF314A2769E8938FA90050A194C048C84517`|
|`work/qrh-campaign/agents/integration/REVIEW_EFFICIENCY_ORIGINAL_RH_MODEST_CUTOFF_2026-11-11.md`|`3DDA3A1073AD671AA418816D96966D07B0AA0B08D686C67E701B2B81302DC3A2`|
|`work/qrh-campaign/agents/major-constants/EFFICIENCY_ORIGINAL_RH_CUTOFF_FRONTIER_2026-11-11.md`|`92D9973CE90C99748317A4D029057B7D3A2522BC1DE30A5EA300F4A3EA61FEE6`|
|`work/qrh-campaign/agents/integration/REVIEW_EFFICIENCY_ORIGINAL_RH_CUTOFF_FRONTIER_2026-11-11.md`|`F4AA21A1C9E3AA3D5EEFDF3A03E750C09781CA37D47DC61E762AF1B97EC96EB8`|
|`work/qrh-campaign/agents/major-constants/EFFICIENCY_LOWER_ANALYTIC_THRESHOLD_2026-11-11.md`|`99D06335D5F8AF1D9AB0916A84BB60AE2ECF060B5FDF04C0134AB9BCB860F786`|
|`work/qrh-campaign/agents/audit/REVIEW_LOWER_ANALYTIC_THRESHOLD_2026-11-11.md`|`CA5489EB8F7357CC4E4FC73FC96FACF700388DD513D3BC84495A246892FFD7D8`|
|`work/qrh-campaign/agents/major-constants/original_rh_joint_cutoff_20261111.py`|`3B0656B83852FAA44D7943FE432C5DEE81730E5535C75AD295E4396463330171`|
|`work/qrh-campaign/agents/major-constants/original_rh_joint_cutoff_20261111.json`|`89E97EA327705E6EABEAC43C63347F1FB77C880AF9AD9CBF66A238B0EB5688B6`|
|`work/ternary-goldbach/TernaryGoldbach/Helfgott/Main.lean`|`DD5E20E51EC7C699CAC00A497C34FEF687E7E5B4562D3B1D8B981ECE54F4261D`|
|`work/ternary-goldbach/TernaryGoldbach/Helfgott/Inputs.lean`|`5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83`|
|`work/ternary-goldbach/TernaryGoldbach/Helfgott/Numerics.lean`|`059874D201ECC571583118A56BA6193D6D8B49016C227988CBC83FA0F34648DB`|
|`work/ternary-goldbach/TernaryGoldbach/MinorArcs/MinorTotal.lean`|`6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742`|
