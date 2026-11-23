# Review of resumed prime and totient repairs

2026-11-11. Independent paper/source audit against `work/ternary-goldbach`, baseline `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build or canonical edit. The three reviewed arguments pass this bounded mathematical review. They remain unformalized replacements, not newly checked Lean theorems.

## Full P6 prime-power bound

The proposed replacement preserves the exact `Prelim.sum_vonMangoldt_nonprime_lt` contract at `LambdaMu.lean:761`: for every real y>0, the sum of Lambda(n) over nonprime integers 1<=n<=floor(y) is strictly less than `1.4262 sqrt(y)`. Here P6 names the Type I/II producer interface, not row P6 in the older broad closure table.

I checked the actual source `nonprime_sum_le4:589`, `log_le_div_e:671`, the conditional current `nonprime_mid/nonprime_small`, and the real-cutoff wrapper. The new argument replaces their contaminated calls rather than invoking those current conditional theorems.

For N>=10^12, the unconditional four-term decomposition and `Helfgott.theta_le:24` give exactly

`NP(N)/sqrt(N) <= log4*(1+N^(-1/6)+N^(-1/4))+log(N)*N^(-3/10)`.

The theta carrier conversion is `ThetaExplicit.theta_eq:33`, which has no Platt binder. `pow_exp_anti:89` is also unconditional. At this cutoff the powers are bounded by .01 and .001. The logarithmic term is below .01 using L>=27, monotonicity for L>=10/3 and `exp(8)>2.7^8>2700`. The final strict coefficient is 1.412257, leaving .013943 below 1.4262. All signs, exponents and monotonicity domains agree.

For the finite branch, `SmallPsi700.psi_lt_small_700` covers 1 through 700. `SmallTab.small_table` covers real 12<=t<10^6; its first two conjuncts, rewritten with `thS_add_ppS`, give the claimed psi error. For integer m>=701, sqrt(m)>26.47 and `.03883*26.47>1`, so the small linear bound follows. At m=0 the non-strict bound is exact.

For 10^6<=N<10^12 all three theta arguments in `nonprime_sum_le4` are strictly below 10^6. The square-root argument is at least 12, and its error converts to v^3 when v=N^(1/12). The other two theta terms use the newly established finite psi bound. The remaining power-log term is bounded by `7.3576v^3`, so the stated polynomial `.4262v^3-1.03883v-9.39643` is the right one. Its positive expansion about v=3.162 gives strict positivity throughout the required range.

`SmallNP.nonprime_small_kernel:192` covers 1<=N<=10^6. It overlaps the middle argument at 10^6. The large branch includes N=10^12, excluded from the middle branch. For real y>0, N=floor(y)=0 gives a zero sum and a strictly positive right side; otherwise strictness is already obtained at N and survives sqrt(N)<=sqrt(y). No finite or real endpoint is omitted.

These selected source inputs have no Platt premise. Importing a file that also contains conditional declarations does not invalidate this selected proof path, but future implementation must use the selected unconditional declarations and inspect the resulting type and axioms. This review is not a fresh kernel check of the source tables.

I ran `resume_primes_20261111_cert.py`; all 12 exact Fraction checks passed. No new prime enumeration or conjectural estimate is needed for this paper argument. P6 may therefore be marked a complete independently reviewed paper replacement, with formalization and exact consumer validation outstanding.

## Finite P1/P4/P5/P7 extensions

`PsiSieveMain.sieve_table3:28160` really has the half-open real domain `[10^6,10^9)` and `RtT 2 1 1 10` means theta between `t-2sqrt(t)` and `t+.1sqrt(t)`. With full P6 this gives psi between `t-2sqrt(t)` and `t+1.5262sqrt(t)`.

The P1 and P4 comparisons are valid. The P5 Abel identity `F(y)=y psi(y)-integral_0^y psi(t)dt` has the correct sign and includes n=y when y is integral. Applying the lower estimate only from A=10^6, and nonnegativity below A, gives the claimed upper bound and coefficient `37602893/37500000<1.022` for y>=2.5e7.

The P7 identity uses the open lower prime endpoint y/2 and closed upper endpoint y. This agrees with `floor(y/2)<p<=floor(y)`. Its interval stays in the sieve domain for 2e6<=y<1e9. The lower theta bounds enter with negative signs and positive logarithmic factors. The error bound `1.6sqrt(y)log(y)+4sqrt(y)` is safe. Its coefficient is below .02, while the main correction is below -.15y. The script checks the weaker sufficient comparison against .15 rather than the prose's .02; this is not a defect in the resulting theorem.

All these extensions exclude 10^9. No all-range P1/P4/P5/P7 result follows. P2/P3, moderate and infinite ranges, and Mobius producers remain separate.

## Optional Mertens 20-log route

Section 5 of `REGION_S_ELEMENTARY.md` is valid on paper. I checked `PNTMertens.E₂Λ.abs_le:934` and `sum_mangoldt_div_log_eq:1724`. The file imports Mathlib and has no Platt/Fact dependency in the inspected source. The identities apply at y>=2000, well inside their analytic domain.

In the finite Euler-product logarithm, each prime power p^k contributes `1/(k p^k)`. The truncated von Mangoldt sum includes exactly the powers p^k<=y. Every omitted power has k>=2, because all product primes satisfy p<=y. Dropping 1/k and extending the prime index to all integers gives a nonnegative tail at most `sum_{m>=2}1/(m(m-1))=1`. Thus the claimed constant `93/35=.6+(1.4+6)/7+1` is correct. Exponentiating gives M(y)<=15log y; the prior large-prime factor 4/3 gives `n/phi(n)<=20log(max(2000,log n))`.

The source `SecondNumerics.eulerMascheroni_lt` already proves gamma<.5812 without Platt, so gamma<=.6 can be obtained directly without the proposed extra exponential comparison. Either route is valid. The regionS consumer has R>=1, so `20*.02L=.4L<=.4log(qR)+.86` preserves the required inequality despite using all .4L. This alternative changes no finite-branch premise.

Formal obligations remain for the finite product logarithm expansion, prime-power truncation, the convergent tail, carrier conversions and the consumer. Existing unconditional Mertens identities reduce the implementation burden; they do not provide those adapters automatically. The prior reviewed 15-log Markov route remains separate and valid.

## One common H envelope

The new synthesis is sound. For `f(r)=log(r)^2/r^(1/4)`, `B=2^1000` and `S=2^500`, the inequality `(1001/1000)^8<2` gives f(2u)<=f(u) for u>=B. Since f decreases above S, the old first correction H1 is bounded by `H(r)=12000 f(max(r,S))`, the old second correction H2.

I checked the source combination in `LinftyLevels.lean:351,373,393` and `Prop1123b.norm_S_eta2_le_of_not_mem`. These really are alternative branches bounded through a maximum. Replacing the common maximum M by M+H(n) is valid; the corrections need not be added when each is separately bounded by H.

For all w>=670/n, retain the original hypothesis `2.16e20*n<=670*y` to obtain the raw theorem's scale lower bound. The separate level condition n<=y^(1/3)/6 gives `min(1,w)n<=(wy)^(1/3)/6` in both branches. For T>S the second raw bound is at most H(min(1,w)n); for T<=S the finite-denominator proof supplies the old hfun bound. Monotonicity of H and of rH(r) then gives the same `max(1,1/w)` factor as the source. Integration over the entire upper interval costs at most 1.398H(n); no unbounded-w tail is lost.

The layer expression includes initial, middle and terminal weights. The claimed coefficient 65 corresponds to the safe terminal estimate `log x<8+4log m` at the actual asymptotic witness. The middle integral includes the plateau. The uniform correction is below 1e-24, so it fits the explicitly reserved 1e-6 numerical allowance. I ran `resume_totient_check_2026_11_11.py`; it exited zero with exact arithmetic, including final minor coefficient `1.03752314232<1.0376`.

This repairs the identified pointwise sharp-totient consumers on paper. It does not prove the original unrestricted logarithmic totient theorem, remove other raw Type I/II hypotheses, supply base gap, or alone prove the quotient large-sieve theorem. The regionS repair is a distinct argument.

## Evidence pins and workflow

Reviewed SHA256 values:

| Artifact | SHA256 |
|---|---|
| Prime note | `03329F66CBC269F8993E1A06E2CAA5A7A6DEDD31C3DC5CEC986DF31DD789798E` |
| Prime exact script | `2450FF0AA65461B005E2E362A3023D0457B74670241C12BB9B45BDADCEB0E2C8` |
| RegionS note including section 5 | `E538FAFFD6AD7551C514A5F7A5528EE7326C6153CA501981B1A88D0FA57BAE40` |
| Common-envelope synthesis | `817234C6768F343714508B5F5F93B3ABDDEDD29D6F43365EDF1F2349A015907A` |
| Common-envelope exact script | `1D8AF0550CF8FC9E23D7CCCAD0AFC889EC13C7E26C6287C2350E379C5AD7FFD7` |

The two script executions establish arithmetic only. All analytic/source conclusions above are independent paper review. No new anchor, sorry, draft import or sealed declaration was introduced. Earlier source pins and the first audit's conclusions are preserved; its package-staleness paragraph now explicitly identifies the snapshot inspected before regeneration.
