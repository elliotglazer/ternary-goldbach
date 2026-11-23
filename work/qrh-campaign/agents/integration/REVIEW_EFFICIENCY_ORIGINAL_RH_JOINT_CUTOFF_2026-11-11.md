# Original-RH joint cutoff: independent review

2026-11-11. **PASS at source/paper and exact rational-composition scope.** No correction required to `major-constants/EFFICIENCY_ORIGINAL_RH_JOINT_CUTOFF_2026-11-11.md`, SHA256 `838F651558DF63A1AE44128A2A5B3F44FD64D4470871A5FC044355CE2BB174C5`. R135000 preserves the desired final positive representation count at N0=989*10^24 through a new joint inequality. It does not preserve the old separately rounded minor constant1.0376. No new spectral premise, compiled theorem or successful finite-RH certificate is asserted.

## The nonprime bound is uniform in N

I read the actual final consumers and the lower-threshold source argument. `Helfgott/Inputs.lean:126–148` bounds the full representation sum minus its odd-prime restriction by

    E(N) = 6.7e6 * N*sqrt(N)*log(N).

Its proof uses the genuine sup-norm/Chebyshev product, including the even-prime contribution. The coefficient comparison is

    3*400^2*6.2*1.6001*1.387 < 6.7e6.

It does not use the sharper7.3306 constant mentioned in the comment. The N0 extension is justified by the previously reviewed `Chebyshev.psi_sub_theta_le:115–204` and `psi_le:207–218` bodies: `(6.9)^32<N0` preserves the root lower bound, N0>1e26 preserves sqrt(N)>=1e13, and the log2 absorption remains valid. I reread those bodies and checked the coefficient and root comparisons with exact rational arithmetic. These source declarations still state their old threshold; their N0 adaptations remain implementation work.

`Helfgott/Defs.lean:52,80` defines kappa=49 and x=N/c0 with c0=2+9/(196sqrt(2pi)). Therefore, for N>0,

    E(N)/(x^2/49) = 49*c0^2*6.7e6*log(N)/sqrt(N).

Both powers of c0 and the factor49 are necessary. `Numerics.xOf_denom_bounds:11–20` gives 0<c0<=2.02. There is no substitution of x for N inside log or sqrt.

The claimed uniformity follows from a simple comparison, independently of the derivative calculation in the author note. For N>=A=N0 let u=sqrt(N/A)>=1 and L=log(A)>2. Then

    log(N)/sqrt(N) = (L+2log(u))/(sqrt(A)*u),
    2log(u) <= 2(u-1) <= L(u-1),
    log(N)/sqrt(N) <= L/sqrt(A).

The only logarithmic inequality here is `log(u)<=u-1` for u>0, the same API already used in `Numerics.lean:43` and `Chebyshev.lean:185`. Positivity of A and u justifies every division and the log-product identity. L>2 follows from A>9>e^2. Equality N=A is covered; no open-endpoint argument is needed.

Since A<10^27 and log is increasing, L<27log(10). For v=2.303>0 the degree24 positive exponential partial sum is a lower bound on exp(v). The exact rational partial sum exceeds10; hence log(10)<v. The recorded integer d=31448370387032 satisfies d^2<=A<(d+1)^2, so 0<d<=sqrt(A). These comparisons give uniformly

    E(N)/(x^2/49) <= 49*(2.02)^2*6.7e6*(27*2.303)/d
      = 20618162523/7784250095800
      < .002648703.

I checked this exact fraction, the integer square bracket and all25 rational terms in the finite exponential partial sum. This uses no exponential/logarithm numerical oracle. It establishes a uniform source-level inequality, not merely a value at N0.

## The changed final conjunction is valid

`Main.repSum_lower_bound:30–51` uses the integrable circle identity, the measurable partition into major and minor regions, and `-abs(Re z)>=-norm(z)`. Replacing its numerical lower/upper constants by a and b therefore gives

    repSum(True,N) >= (a-b)*x^2/49.

The actual integrand norm is unchanged. A negative real minor integral is accounted for by the norm upper bound. No sign condition is imposed on the pointwise complex major integrand. Subtracting the valid nonprime estimate gives

    repSum(odd primes,N) >= (a-b-Cnp_bar)*x^2/49.

With x>0 and a-b-Cnp_bar>0, the right side is strictly positive. The unchanged finite-sum extraction `Main.isSumOfThreePrimes_of_repSum_ne_zero:55–64` then applies. This replaces the particular old `final_inequality_crude` call; it cannot be obtained by claiming the old1.0376 conclusion still holds.

I also checked the place where the minor constant is consumed. `MinorTotal.NumericsGoal:84–87` includes both essential r2/domain conditions and its final numerical bound. `minor_total:332` separates these fields. The field hM is first consumed only at518, after the proof has established the actual integrated Mexpr estimate at500–514. Replacing hM by a bound U and retaining every other field yields

    minor_integral <= [1.0005*U +2001*22.75*8e-11]*x^2/49.

The constant1.037 is not an earlier analytic smallness hypothesis. The proposed max over all nine cells and the asymptotic branch is therefore a valid common b. The original energy sig, a1/a2 decomposition, coefficient energy and two triangle factors are retained.

## Exact scalar checks

All12 pins in the author table match. The seven scalar recipe functions have identical syntax trees to the accepted frontier script. All nine parsed source-cell records and the full NumericsCells source hash agree with the accepted frontier. The corrected cell1 scale3e25 is retained.

A separate read-only integer/Fraction calculation, without importing or executing the producer, checked all54 finite-cell and six asymptotic compositions, the60 named row predicates, every joint margin, positive upper-base coefficients, every `(6R)^3<=Y` condition, and all displayed values. The overlapping R138000 and R137000 rows retain exactly the earlier mass/J/I/singular/major, ghat, minor and gap values; only the subtracted nonprime constant and acceptance criterion change.

For R135000 the exact values are

    a = 1761760471717520694083/1679062500000000000000,
    b = 209292325007822254773386391/200002000000000000000000000,
    a-b-Cnp_bar
      = 6382725162604415567444907717114329003
        /41825194012491047334000000000000000000000
      > .0001526.

The base-gap fraction is224554049/16875000000<.013307<.014 and I_R/x>8.50028. Cell0 is the controlling minor bound in every row. At R134000 and R134900, only `joint_finite` fails, and within it only cell0 has a nonpositive joint margin. All validity guards and the asymptotic conjunction still pass. R135000 also passes if .00271 is subtracted, although the reviewed acceptance uses the exact smaller rational Cnp_bar.

The finite sequence138000,137000,136000,135000,134000,134900 and its stop decisions agree with the source loops. Thus135000 is the smallest demonstrated member of this bounded search, not an optimal cutoff or evidence that the true integral fails below it.

The independent arithmetic check uses the saved rational ghat and mass envelopes. It does not regenerate the new logarithm/root enclosures or rerun the author's scalar producer. Their unchanged analytic recipe and source hypotheses remain as reviewed in V2 and the frontier report. This distinction limits the executed-check claim; it does not identify recorded fractions with independently evaluated analytic functions.

## Unchanged source joins and open implementation

All tested R are even and between100000 and150000, so the prior mass comparison, positive singular-product bound, per-modulus geometry and large-sieve conditions remain applicable. At R135000, q-tilde<=2R implies odd primitive c<=135000 and primitive even c divisible by4 with c<=270000. The inverse-character closure and original inclusive heights1e8/c and max(1e8/c,200+7.5e7/c) remain. The base-gap witness must retain q-tilde, rather than only q<=2R.

The extra minor levels R<n<=150000 are still bounded directly and telescope into cL(150000), with the old chain beginning at150001. All cells and their joins remain unchanged. No omitted nonprincipal conductor is used in this comparison. The original principal-only estimates remain required; no .65 energy, shared strip or global7/8 assumption enters this route.

The accepted bound c0<989/490 gives x>4.9e26 and y>1e25 for N>=N0, including equality. N0 and the small-case/ladder endpoint therefore do not change. The large result has no binary premise; the full Statement keeps the original inclusive BinaryGoldbachInput through4e18 and the separate checked ladder input.

Implementation must still localize the finite-RH consumers, parameterize the arc partition, implement the new J/I/singular/base-gap and numerical interfaces, prove the uniform nonprime adapter, and use the joint subtraction in Main. Keeping old blanket PlattGRH wrappers would not prove a smaller dependency set. No source edits, builds, spectral certificates or runtime savings are certified by this review.

## Binding

The author table binds the V2/frontier/threshold reports and reviews, all four final-consumer files, and the following new scalar files:

| Artifact | SHA256 |
|---|---|
| `major-constants/original_rh_joint_cutoff_20261111.py` | `3B0656B83852FAA44D7943FE432C5DEE81730E5535C75AD295E4396463330171` |
| `major-constants/original_rh_joint_cutoff_20261111.json` | `89E97EA327705E6EABEAC43C63347F1FB77C880AF9AD9CBF66A238B0EB5688B6` |

The first column here is relative to `work/qrh-campaign/agents`. Additional directly read files under `work/ternary-goldbach/TernaryGoldbach` are `Helfgott/Defs.lean`, SHA256 `4CE6EA7FB475024DF403775F9480D7D01B6336A798E0CF254BD61B5AFEC79DC7`, and `Helfgott/Chebyshev.lean`, SHA256 `3E1809BA6681FF486C62608A42B5D5D48674D240E41D474A74B2C4A5A28E5269` (the latter also appears in the accepted lower-threshold packet). This review is conditional source mathematics and exact finite arithmetic, not a kernel-validity assertion.
