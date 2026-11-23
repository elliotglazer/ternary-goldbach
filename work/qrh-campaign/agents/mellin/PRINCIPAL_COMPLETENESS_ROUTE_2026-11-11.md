# Principal finite completeness: a sign certificate versus a narrow rectangle

Research design, 2026-11-11. No full zero enumeration, new evaluator, Lean build, canonical edit, or frozen-file change. No value of N(1000000) is asserted here. The numerical quantities below are derived from analytic formulas, not from an indexed-zero table.

## Decision and current target

The reviewed head certificate gives Q1500<1.668. Together with the reviewed analytic count majorant, it suffices to prove that every nontrivial zero through height1000000 lies in (.4975,.5025); then W35<23.953<24. The strip remains unproved.

There are two complete routes:

* Certify a zero-free closed right rectangle starting at Re(s)=.5025, then reflect. This proves the needed weaker strip and permits multiple zeros inside it.
* Independently compute the exact total multiplicity count M=N(T), for a certified endpoint T>=1000000, and exhibit M disjoint strict sign-change intervals of a real Hardy function on [14,T]. Equality with the total count forces every zero in this domain onto the critical line and forces simplicity. This is a stronger conclusion, proved internally rather than assumed.

The second route needs only point-value certificates during sign discovery, plus one short certified horizontal path for the total count. Its prospective evidence count is much smaller than the current fixed-block near-line design. There is no guaranteed bound on discovery work or precision without further information about close or multiple zeros. A failure to complete the sign search is not itself a proof of an off-line zero.

## 1. A real sign function requiring no new gamma evaluation at each point

Define the analytic log-Gamma branch on Re(z)>0 to be real on the positive real axis and set

\[
\theta(t)=\Im\log\Gamma(1/4+it/2)-\frac t2\log\pi,
\quad Z(t)=e^{i\theta(t)}\zeta(1/2+it).
\]

One must prove that Z is continuous and real-valued for real t. A source-faithful route uses `TernaryGoldbach.Explicit.xiF_one_sub` (`Explicit/Xi.lean:24`) and `xiF_conj` (`Explicit/XiPartial.lean:669`), which make xiF real on the critical line. The identity `xiF_eq` (`Xi.lean:28`) expresses it there as a strictly negative real factor times Z(t): the source xiF omits the conventional factor1/2, which does not affect the sign argument. Gamma is nonzero in this right half-plane. The branch normalization and Gamma-real-factor decomposition must be proved; a pointwise principal argument of Gamma cannot replace the unwrapped theta in the counting identity.

There is a useful simplification for the sign samples. Put

\[
\theta_0(t)=\frac t2\log\frac{t}{2\pi}-\frac t2-\frac\pi8,
\quad V(t)=\Re\left(e^{i\theta_0(t)}\zeta(1/2+it)\right).
\]

The reviewed Binet proof gives

\[
|\theta(t)-\theta_0(t)|\le\frac13+\frac{3}{16t}<.347<\pi/2
\qquad(t\ge14).
\]

Since Z is real,

\[
V(t)=Z(t)\cos(\theta_0(t)-\theta(t)),
\qquad \cos(\theta_0-\theta)>.939.
\tag{1}
\]

Thus V is continuous, has exactly the same zeros, and has the same sign as Z on the whole requested range. A certified sign of V needs only a zeta point enclosure and elementary log/exp for theta0. The once-proved normalized Gamma/Binet and Hardy-realness lemmas remain essential; (1) does not infer realness merely from a small computed imaginary part.

In particular, no separate high-precision complex log-Gamma evaluation is needed for each sign sample. The underlying complex RS zeta evaluator may still use Gamma internally, and its own proof contract is unchanged. A pointwise phase modulo2pi would suffice for signs, whereas the total-count formula requires an unwrapped theta; the theta0 bound makes this distinction explicit.

## 2. The exact top count is an independent certificate

Choose a rational endpoint T>=1000000. First try T=1000000. If it cannot be certified away from a zero ordinate within the bounded computation, another rational T'>T may be used, but every sign interval and total count must then refer to T'. Proving the stronger result through T' covers the original closed height. It is not legitimate to move the endpoint while retaining an old count.

For an endpoint not at a zero ordinate, the reviewed contour identity is

\[
N(T)=1+\theta(T)/\pi+S(T),
\tag{2}
\]

where S is the continuous zeta argument along `2 -> 2+iT -> 1/2+iT`, divided by pi. N counts all nontrivial zeros with positive ordinate up to T, including true complex-analytic multiplicity. The +1 and branch normalization come from the analytic argument-principle proof in `RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md` and its independent review, not from calibrating a computed count at1500.

### Initialization on Re(s)=2

The source-independent Dirichlet-series estimate gives
`Re zeta(2+iu) >= 2-zeta(2)>1/4` for every real u. Consequently the continuous argument along the vertical segment, starting at the positive number zeta(2), stays in (-pi/2,pi/2). Its endpoint is exactly the principal argument of zeta(2+iT), with no unknown winding integer. A rigorous endpoint value ball and a principal logarithm in this right half-plane therefore initialize the argument. No vertical sampling from0 toT is necessary for this initialization.

### Propagation along the horizontal top path

Partition `[1/2,2]+iT` into panels, oriented from2 to1/2. Certify the full zeta image of each panel inside an open coordinate half-plane. At every common endpoint obtain a certified value ball contained in both adjoining half-planes. This last requirement concerns actual endpoint enclosures, not just the arbitrary rational polygon vertices used in a winding-only certificate.

For a panel choose a fixed rotation r in {1,-1,i,-i} sending its half-plane into Re>0. Then its actual argument increment is

\[
\Delta_j=\Im\left[\operatorname{Log}(r\zeta(s_{j+1}))
-\operatorname{Log}(r\zeta(s_j))\right],
\tag{3}
\]

with principal Log on the right half-plane. Because the entire panel stays there after rotation, (3) is the continuous increment along that panel. Summing these increments and the initialized vertical argument gives a rigorous S interval. Different panels may use different rotations; the increments, not unadjusted principal endpoint arguments, are summed. This supplies the required branch tracking without calling a precomputed S or zero-count helper.

The top path's nonvanishing includes its endpoint at beta=1/2 and every beta>=1/2 in the critical strip. The functional equation reflects any zero with beta<1/2 at the same ordinate to one on this top path. Thus this certificate excludes every nontrivial zero at ordinate T. The count is consequently the closed count, with no half-weight convention or omitted horizontal-boundary zero. Conjugation treats -T.

### Integer rounding

Write `F(T)=T/(2pi)*(log(T/(2pi))-1)+7/8`. The Binet estimate gives
`1+theta(T)/pi in F(T)+[-1/8,1/8]` for T>=1500. Hence an enclosure I for

`F(T) + S(T) + [-1/8,1/8]`

contains the integer N(T). For example, F interval width<1/100 and S interval width<1/4 give total width<.51<1. The checker must verify `ceil(inf I)=floor(sup I)=M`. Neither rounding a midpoint nor choosing the integer nearest F(T) is valid. If the check is inconclusive, refine the horizontal models/point values or their precision; do not substitute a historical value of N(T).

### Bounded top-path implementation target

The existing Cauchy/RS wrapper can initially cover the length1.5 top path with six quarter-unit blocks. With outer radius1/2 their leftmost real part is1/8. The already proved source bound
`|zeta(s)|<=|s|/|s-1|+|s|/Re(s)`
gives the coarse uniform outer bound `M<=8*(T+3)+2`. Thus this top-path wrapper can use the existing elementary growth theorem rather than requiring a new sharp Rademacher bound. Sixty-four samples per block give384 baseline point enclosures; this is a proposed cover, not an assertion that those six models will pass every nonvanishing or argument-width check. Subdivision, more coefficients, or a different T may be necessary.

No top-path certificate at one million has yet been computed. Zero_sum's bounded RS work sampled only local vertical blocks; it is not an endpoint-count certificate.

## 3. The finite completeness argument

Suppose (2) has independently produced the exact integer M, and the height14 exclusion has been accepted. Supply ordered rational samples

\[
14=t_0<t_1<\cdots<t_M=T
\]

with certified, strictly nonzero V(t_j) of alternating signs. More generally, M pairwise disjoint open intervals in (14,T), with certified opposite-sign endpoint values, suffice; adjacent intervals may share a nonzero endpoint. They need not cover the entire domain.

By continuity, each interval contains a zero of V, hence a zero of zeta on the critical line by (1). Disjointness makes these M distinct zeros. Every one has analytic multiplicity at least1. Their total multiplicity is therefore at least M, while the complete positive-ordinate carrier has total multiplicity exactly M.

Equality leaves no room for any other zero, including an off-line zero, an even-multiplicity zero missed by signs, a second zero in a bracket, or additional multiplicity of a bracketed zero. Hence all zeros in the carrier are simple and lie on beta=1/2. There are none below14, and the top boundary has already been excluded. Conjugation yields the closed two-sign finite RH conclusion through T, which implies the required (.4975,.5025) strip.

No local uniqueness test or derivative sign is needed for each bracket. Simplicity is a consequence of equality with the complete multiplicity count, not a premise. Conversely, an actual multiple zero can prevent this sign route from completing even if every zero lies on the critical line. The narrow-rectangle route does not have that limitation and proves a weaker claim sufficient for the campaign.

The function identity, count formula, and global finite-count comparison must all be proved before calling the finite sign file a completeness proof. The already externally reviewed N(1500)=1069 can be a later block boundary only after its formal replay; it does not establish critical-line location for those1069 zeros, and it cannot calibrate an unproved version of (2).

## 4. Discovery and certificate size

A generator may choose approximate Gram points or adaptive rational samples as heuristics, but acceptance checks only ordered rational coordinates, certified strict signs and the independently established total count. Gram's law, Rosser's rule and minimum zero spacing are not assumptions. No proof that a sample is exactly a Gram point is needed.

A successful ordered search with exactly M observed strict sign changes can discard redundant consecutive equal-sign samples, leaving M+1 alternating samples. This statement concerns a single strictly ordered list of actual rational sample points, all with proved nonzero signs of the real proxy V. Partition that list into maximal consecutive runs of the same sign. M changes means exactly M+1 runs; retain one point from each run, preserving14 from the first and T from the last. Their signs alternate and their coordinates remain strictly ordered. The existence of M distinct line zeros and equality with the full multiplicity count must be established as in §3; no simplicity or completeness is inferred from the run compression alone. If the initial evidence is separate brackets rather than a sample list, first merge their endpoints into an ordered list and certify every sign. Any further sign change across a gap would force an extra distinct zero and contradict the already matched count. Uncertain signs cannot be merged or discarded by this argument. Additional samples used during discovery are not needed in the final sign certificate. This compression does not bound discovery work or precision.

The selected theorem (C) in the analytic-count note is only an upper bound. The lower bound used here is derived separately from its preceding construction, not inferred from (C). At a nonzero ordinate, that proof gives both `|S(t)|<=n+3/2` and `|1+theta(t)/pi-F(t)|<1/8`, hence
`|N(t)-F(t)|<n+13/8<5log(t)+20`.
For an arbitrary closed height t, local finiteness in the bounded critical strip gives an epsilon>0 with no zero ordinate in (t,t+epsilon). Thus N(u)=N(t) for every u in this interval, including all zeros exactly at t in the closed count. Letting nonzero heights u decrease to t extends **both** inequalities by continuity. This argument is the additional two-sided paper consequence needed for the evidence-size lower bound; it is not a new compiled theorem.

The exact-arithmetic script `principal_completeness_sizes_20261111.py` uses no zeta evaluator. From this explicitly derived two-sided estimate and elementary log/pi bounds it obtains, at T=1000000,

* `F(T)=1747145.50863210896162645643863...`;
* `1747057 <= N(T) <= 1747234`;
* therefore between1747058 and1747235 entries in a compressed successful sign chain.

These are count bounds, not the exact N(T). Only the top certificate can supply the exact required number of sign changes. The principal main-term local spacing is approximately.52458 near T; this is not a lower bound on actual zero separation and cannot justify a fixed discovery mesh.

For comparison, a quarter-unit cover of the positive near-line edge from14 to1000000 has3,999,944 blocks. At64 points per block, the current Cauchy scheme requires255,996,416 point samples before reuse or a different batching method. The often quoted3,994,000 blocks covers only heights1500–1000000: the head-count certificate does not prove the narrow strip below1500, so that lower part cannot be skipped without another certificate. Conjugation can reuse the negative edge with the appropriate orientation. This comparison concerns the current fixed-block design, not a lower bound for all rectangle algorithms.

At T=1000000 the RS main-sum length is398. Pinned FLINT3.6.0 source reuses the conjugate auxiliary value when Re(s) is exactly1/2, whereas a generic off-line value computes two auxiliary sums. For a final sign chain of at most1747235 points, multiplying by398 gives695399530 ordinary RS summands as a conservative main-sum accounting in the RS regime. It excludes correction terms, Gamma work internal to the evaluator, low-height fallback, extra discovery samples, precision changes and proof traces. No runtime forecast follows from this multiplication. [Pinned critical-line branch](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs.c).

## 5. Avoiding circular library completeness

The installed Python acb exposes `zeta` and `lgamma`, but no direct Hardy-Z method was found in the inspected API. The sign proxy V needs only the former and elementary phase arithmetic. Its point evaluator remains subject to the RS proof/remainder work already owned by zero_sum; this note does not develop a competing evaluator.

High-level indexed-zero and count routines are not acceptable as the independent completeness input here. Pinned FLINT3.6.0 defines historical Gram and Rosser shortcut thresholds126 and13999526 in its zero-isolation source. Our target range lies inside the latter. Those shortcuts must be reproduced as proofs or bypassed; they cannot be silently treated as assumption-free certificate generation. [Pinned isolation source](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/isolate_hardy_z_zero.c).

Moreover, the library's `backlund_s` routine computes S from a call to `zeta_nzeros`, then subtracts theta/pi+1. Using it to obtain an independent N from (2) would be circular. [Pinned S implementation](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/backlund_s.c). Certified zeta **point values** do not have this same count dependency, but their analytic RS remainder and numerical primitives still need the explicit proof contract described in the evaluator report.

## Recommended bounded next step

First certify the short horizontal top path and its continuously propagated S interval at a rational T>=1000000, then extract M by exact integer inclusion. This tests the missing completeness component without enumerating any zeros. Separately, demonstrate the sign-proxy constructor and equality argument on the already counted interval[14,1500], requiring1069 sign changes; that is a bounded implementation target, not work performed in this note. Only after both pass should the full sign search be proposed.

The stronger finite RH route is attractive because it converts most evidence into point sign checks and uses only one independent top count. The remaining work is still substantial: rigorous RS point replay, analytically normalized Hardy realness, continuous argument propagation, exact count extraction, all required strict signs, and formal multiplicity/completeness transport. No new finite-spectrum theorem or allowed root assumption is claimed.
