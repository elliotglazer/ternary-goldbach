# Whole small-conductor theta inventory at the combined heights

2026-11-11. Conditional paper construction and exact integer/rational metadata. This extends the reviewed theta and shared-elementary schedules to every primitive nonprincipal character with conductor at most10000. No elementary, character, theta, L-function, zero or prime-candidate value was evaluated. No transform, build or Lean declaration was run or changed.

The universal parameter conditions do hold. The new inventory has7499 conductors and18477108 primitive labels, with both character parities and all positive-height channels retained. At the combined main heights it requests1775431871117 primitive output values. Two explicit theta choices have different counts and precision costs; neither is selected as a runtime winner. A useful refinement is that3876 conductors have identical FFT lengths under both choices, so theta128 buys no loop-count reduction there under this fixed schedule.

## 1. Exact target and height admission

Retain the actual completion and fixed root-phase normalization from the accepted small-conductor backend. At each conductor and primitive label the target is

`Y_chi(t)=exp(pi*t/4) epsilon_chi c^(it/2) completedLFunction_chi(1/2+it)`.

This is real and has the same signs and zeros as the canonical Hardy function. For tilt `b=pi/4-theta/V`, the coefficient construction first produces F_b, then multiplies by `exp(theta*t/V)`. Changing theta changes intermediate values but not Y. Frequency conjugation is used only after the fixed phase: `G_chi(-x)=conj(G_chi(x))`. It does not remove the inverse-character positive-height channel. Principal conductor1 remains excluded and has a different analytic theta identity.

Use the exact combined odd/even formulas, not the old `10^8/c+1000` examples. Put `d_c=531600/c` for odd c and `1063200/c` for4|c. On the half-open bands c<100,100<=c<1000,1000<=c<10000,c>=10000, take

| Conductor | u in the four bands | Floor |
|---|---|---:|
| odd |21,20,19.5,19.2|240|
|4 divides c|22.6,21.1,20.1,19.1|255|

The plus height is `H=ceil(200+max(floor,3.1416*u*d_c))`. As a separate check, the script takes the established base and star requirements and verifies they do not exceed H for any row. The base heights are `ceil(27e6/c)` and `ceil(54e6/c)` respectively; the star height is `ceil(max(300,704*d_c/343))`.

For extension e in{0,167,320,640}, define

`m_c=ceil(64H/5)+e`, `V_c=5m_c/64`, `Jout=m_c+1`.

The entire output prefix is `t=5j/64`,0<=j<=m_c. Thus both the integer spectral-height ceiling and the grid overshoot are included. V is an exact grid endpoint, eliminating the former non-grid-endpoint ambiguity. The extensions add835/64,25 or50 after the main grid endpoint. They are conditional requested domains, not proved sufficient Turing guards. More extensive guards require another domain/count check.

The component height implications and their full analytic assembly remain separate premises. This inventory cannot itself certify them. The earlier combined cost note excluded the small branch for accounting reasons; that exclusion did not preserve the old higher height formula for this branch.

## 2. Character labels and both parity channels

For a prime-power factor p^a, the number of primitive characters is p-2 if a=1, and `(p-1)^2 p^(a-2)` otherwise. Multiply these local counts to obtain n(c). This makes the families with v2(c)=1 empty and leaves exactly the odd conductors and multiples of four in the current range.

The primitive parity difference is

`n_even(c)-n_odd(c)=mu(c)+1_(2|c) mu(c/2)`.

To derive it, sum chi(-1) over all characters at a divisor d. Character orthogonality makes that sum phi(d) if d divides2 and zero otherwise. Every character has its unique primitive inducing character, so divisor inversion gives the displayed formula. This is a character-count identity, not a prime-distribution assumption. It yields9238543 even and9238565 odd primitive labels. Only c=3 and4 are odd-only; c=12 is even-only. All other7496 conductors have both parities.

Both parity bucket transforms are therefore charged at those7496 conductors. A parity with no primitive output is omitted. The Gaussian recurrence is shared by the two present parities; the odd bucket additionally scales by the exact integer n. The Gauss-sum phase setup uses one full character transform per conductor, not one per parity.

The finite coordinate schema uses the usual CRT factors: C_(p^(a-1)(p-1)) for odd prime powers, C2 for4, and C2 times C_(2^(a-2)) for powers of two of exponent at least3. The script factors only the small integer conductors to derive these counts. Actual coordinate generators, exact label/primitivity bindings and their proofs remain necessary certificate data; an integer count does not certify those labels.

## 3. A universal selector, rather than extrapolation from examples

Fix the same requested error `tau=2^-80` for every Y output. This is an explicit accuracy contract, not a promise of a sign margin. Use theta64 or128. On odd conductors take `Wbar=40e6/theta`, and on multiples of four take `Wbar=80e6/theta`.

These are uniform bounds for `W=cV/theta`, including e640. Indeed H is below `201+max(floor,3.1416*u*d_c)`, and the grid and extension add at most `50+5/64`. With c<=10000, u<=21 odd and u<=22.6 even, direct rational substitution gives cV<40e6 and cV<80e6 respectively. Also V>=2700 from the base-height bound, hence V>=2theta, and W>=1. The script independently checks these inequalities on every row.

All majorants and parameter tests in the accepted backend may use Wbar instead of W. The function `2W exp(z-exp(2z)/W)` increases with W. The integral/time-tail bounds increase with W; the Gaussian v0 and z0 conditions become harder as W increases. Thus passing the larger-W tests suffices uniformly. No analytic conclusion is inferred from testing only example conductors.

Let `eps=tau/(4*3^theta)` and r=3/8. The following parameters pass all accepted tests:

| theta | Conductor cohort | Wbar | K | L | X | n0 | Gaussian seed p |
|---:|---|---:|---:|---:|---:|---:|---:|
|64|odd|625000|162|148|10|8192|302|
|64|4 divides c|1250000|164|148|10|8192|302|
|128|odd|312500|233|219|10|8192|404|
|128|4 divides c|625000|234|219|10|8192|404|

Specifically `32 Wbar^2 r^K<eps/4`, `12 Wbar r^L<eps/4`, and `(8/3)^(2X)>=Wbar(2X+L)`. The complete Gaussian tail test uses `v0=3n0^2/Wbar>=2`, `z0=3(2n0+1)/Wbar-1/n0>0` and `4(X+1)*2n0(1+1/z0)r^floor(v0)<eps/8`. These are rational inequalities. The seed/gate choice delta=2^-p, gamma=5delta satisfies the complete bucket budget.

Delta remains5/64 because X Delta=25/32<1. For each conductor choose the smallest power of two N>=8 with

`P=N Delta >= max(2V K/theta,V+2K,6)`.

Take `J=ceil(PX/6)`, `Rfreq=J+1`. The script checks J<N/2 and Jout<=N. The omitted positive and negative frequencies, both time-periodization tails, Gaussian truncation, coefficient arithmetic and time-transform arithmetic are paid exactly as in the accepted universal proof. The final positive rescaling still gives Y error below3tau/4. Zero is retained once and the unused Nyquist slot is exact zero.

The frequency-dependent cutoff is certified using the shared radial state. It must satisfy `n0 exp(-x_j/2)<=u_j<=min(n0,n0 exp(-x_j/2)+2)`. Actual cutoffs are not evaluated here. Instead the entire recurrence is charged by the rigorous upper bound

`T <= ceil(n0(1+P/3)+Rfreq)`.

Thus Gaussian work and buckets in this inventory are upper schedules, not observed term counts.

## 4. Whole-family operation schedule

Use one explicit conservative character algorithm: full CRT-axis transforms, radix two for a power-of-two axis and whole-axis Bluestein otherwise. No pruning, mixed-radix improvement or favorable twiddle is credited. For axis d and v=phi(c), multiply its cost by v/d. A radix-two d costs `(d/2)log2d` butterflies. A Bluestein axis with padding B costs `B log2B` butterflies, B+2d extra complex products, and B inverse-normalization dyadic scales. One butterfly here includes its fixed-twiddle product and two additions. It is a template count, not a machine instruction.

At a conductor, the principal categories are:

* At most Rfreq outer complex exponentials, each followed by a separately charged seed unit-disk contraction; two real exponential seeds for the radial and positive-output recurrences.
* At most2T Gaussian unit-disk multiplication gates, hT rounded bucket additions, and oT exact integer scalings, with o indicating a present odd channel. Each unit gate contains the accepted product, two rounds and shrink. Bucket accuracy is the accepted per-addition bound; no exact accumulation shortcut is assumed.
* hRfreq full character transforms; nRfreq final prefactor/contraction products; `J+(4+o+2n)Rfreq` real products for the radial powers, arguments and prefactors; Rfreq cutoff division/ceiling checks.
* One Gauss transform, v additive-root cis certificates, n phase roots/divisions, n K-cache products and at most n chart-undo products. Conductor root setup, tilt/parity cis, eighth roots and at most16+12n additional setup calls remain separately charged.
* n length-N time transforms, their root cache, nJout omega scalings, Jout-1 shared positive-scale updates and nJout real output multiplications. Unused time outputs are still computed by this full-transform schedule.

The following main-prefix counts include the whole small family:

| Category | theta64 | theta128 |
|---|---:|---:|
| Required Y outputs |1775431871117|1775431871117|
| Outer complex exp upper |3666989329|2605203866|
| Gaussian unit-gate upper |12023410796974|8542028172242|
| Rounded bucket additions upper |11221194208339|7969016316193|
| Main character butterflies |178774519697023|128941391789290|
| Main character extra products |35506875596080|25399177848072|
| Main character inverse dyadic scales |20967349847456|15046227780352|
| Time butterflies |129247714213888|89858217607168|
| Radial/argument/prefactor real products |3396964824169|2421291652611|
| Prefactor/contraction complex products |1687516400381|1202865170991|
| Per-conductor time root cis upper |14081196032|10003939328|
| Full time-transform outputs computed |12959915966464|9237783904256|

Shared phase setup in either column includes18477108 roots and divisions,25330722 additive cis leaves,7499 Gauss transforms,1005598874 Gauss butterflies,191293204 extra products and113309696 inverse dyadic scales. The two real seeds per conductor total14998. There are22494 tilt/parity cis leaves,14998 conductor positive-root certificates and221845280 further bounded setup calls. All of these are finite certificate calls at specified accuracies, not constant-cost elementary operations.

The complete eight rows and every category are in the final receipt. A compact view of the guard scenarios is:

| Extra nodes | Y outputs | theta64 time butterflies | theta128 time butterflies |
|---:|---:|---:|---:|
|0|1775431871117|129247714213888|89858217607168|
|167|1778517548153|129557981560832|89954059550720|
|320|1781344545677|129870543716352|90062828601344|
|640|1787257220237|130490037698560|90276181311488|

No extra-node row is evidence that its guard actually closes a count.

## 5. Precision, reuse and a useful two-choice reduction

Every accuracy request is finite and positive. The new script instantiates the reviewed character safety denominators, input and intrinsic-error budgets, Gauss-transform precision, radial/log-plane construction, root-number charts, time-transform precision and final-scale recurrence. It uses Wbar consistently for magnitude bounds as well as tails. The resulting main-prefix fractional-bit ranges are:

| Contract | theta64 | theta128 |
|---|---:|---:|
| Gaussian seed |302|404|
| Shared elementary sigma |382|484|
| Radial seed/update |417--430|519--531|
| Fixed setup leaves |422--434|523--535|
| Character gates/roots |279--313|381--415|
| Gauss gates/roots |402--436|504--538|
| Time gates/roots |238--241|338--340|
| Positive-scale recurrence |242--256|341--356|

These are not total word widths. The accepted magnitude bounds still control integer parts, raw products and phase reduction. Outer exponential arguments can have modulus up to4M^4, M=177148. Certified pi must be refined for that argument reduction and the strictest root request. The inventory does not turn each exponential/cis certificate into a universal fixed number of integer operations. That needs a chosen elementary checker and its range-reduction/series ledger.

There is real reuse across conductors. At a common sufficiently fine accuracy, a rational-angle root table depends on its order, and a Bluestein kernel on its axis/padding, not the conductor. For the main prefix, global sharing reduces the time-root direct-leaf upper counts to2147352576 or1073610752, respectively. The character direct-root upper count becomes28900242;1252 distinct Blue kernels require17274256 stored entries and122204544 setup butterflies. These are optional checked-cache counts, not free imported tables. They require the minimum tolerance over all consumers, correct indexing and genuine proof-context continuity. The per-conductor baseline is retained in the main table.

Within a conductor, root recurrences can replace direct cis leaves by one primitive leaf per distinct order and prefix unit gates. The accepted construction requires primitive/gate error at most u/(2m), so it buys fewer transcendental certificates at finer precision. Neither this alternative nor the full-array root cache is free. Principal and large-branch caches can be reused only for matching roots/circuits at adequate accuracy; their differing analytic coefficient identities cannot be interchanged.

An exact two-choice observation removes some unnecessary comparisons. Both theta choices have X10 and n0=8192. If they give the same N, then Rfreq,T and every loop/category count are identical. Theta64 has weaker precision demands under the displayed budgets: eps128/eps64=3^-64, Wbar128=Wbar64/2, and any possible quadratic W improvement is less than a factor4. Therefore the eps loss dominates. The sigma/radial/phase budgets also tighten at theta128. For a fixed implementation priced by these conservative contracts, theta128 offers no counted advantage in that case.

| Extra nodes | Same N | N128=N64/2 |
|---:|---:|---:|
|0|3876|3623|
|167|3866|3633|
|320|3853|3646|
|640|3830|3669|

The companion receipt identifies every conductor in each set. This suggests theta64 as the static comparator on the same-N subset, and a priced comparison on the remaining subset. It is not a theorem about all adaptive implementations: different actual arguments or values may admit sharper enclosures. It also makes no assertion about sign success of either set of centers.

## 6. Honest EM crossover and remaining work

The matched point-EM comparator has the same c, grid, labels, normalized Y and tau. Its main-prefix full-character cost is94844686425215 butterflies and18723346155792 extra products. The purely formal P20 residue-term count is52698948065480. The latter is only a contraction counter: the old V<=10000 P20 seed proof does not cover the largest current small-conductor height, `1207810755/64`. An admitted arbitrary-height EM parameter choice, its complete seeds, short heads and Y normalization must be added before this becomes a valid competing evaluator.

In the theta64 main schedule, only2 conductors have fewer character calls than point-EM; theta128 has488. The totals of hRfreq are6844643187 and4860882394, compared with3791945802 point calls. Thus this conservative theta selector does not save character calls across most conductors. Its possible benefit is replacing difficult high-t EM seeds, not a presumed universal FFT-count advantage.

For assigned nonnegative prices at actual widths, compare the complete theta categories with the complete admitted EM seed/contraction/normalization categories. The break-even inequality is the corresponding weighted-sum inequality; no unit price equates a 404-bit contracted Gaussian gate, a large-angle exp, a fixed-root butterfly and a rational cutoff division. Between theta choices, a smaller operation count must pay for roughly100 extra fractional bits in several contracts. No runtime winner or final core-hour estimate follows.

The transpose and time arrays also remain substantial. The largest main-prefix N is2^31 for theta64 and2^30 for theta128. Maximum nRfreq is577888620 or415061460 complex coefficients. A label shard of size r can retain rRfreq coefficients and a time workspace, but without accepted retained intermediate records it repeats the frequency/character pass ceil(n/r) times. The proof checker must bind any transpose/cache to the actual array. Hash-only import and unexplained native FFT are not acceptance methods. A partial time-output circuit could avoid some unused outputs, but none is priced or assumed here.

The remaining gaps are concrete: verified label/phase data, actual elementary and coefficient enclosures, an implemented arithmetic/transform checker with total-width costs, faithful storage/streaming, strict signs or repairs, interpolation, real/central-zero handling and closed Turing counts. The universal analytic parameter conditions are no longer an example-only gap; successful numerical certificates and their end-to-end cost still are.

## 7. Reproducible evidence and pins

The main script performs262487 exact checks over59992 conductor/extension/theta rows. It factors only conductor integers <=10000, derives exact label counts and CRT dimensions, verifies every domain and positive error allocation, and accumulates deterministic schedules. It imports no previous generator or evaluator. The final receipt retains aggregates, precision ranges, exact parameters, example rows and a deterministic all-row digest; the digest is a reproducibility aid, not proof acceptance. The companion independently recomputes the two-length partition at every conductor.

| New object | SHA256 |
|---|---|
| small_family_theta_inventory_20261111.py |4FD7D0F84E3057F74B7F151ABEA73A392739CEA48B12B0B04F1A3F71913A98C2|
| small_family_theta_inventory_final_20261111.json |26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69|
| small_family_theta_choice_20261111.py |9BA5645C165FD51CBFADCF867B1A877F821F894624C51BD4A6DFA99051947794|
| small_family_theta_choice_final_20261111.json |FB20993DD8C1186E06B4B22D07DBC40CDCA38D7AD3D2503F8E17469648A1FCF4|

Earlier same-directory draft receipts are preserved but superseded by the explicitly named final receipts. In particular the final inventory adds seed unit contractions and Blue inverse-normalization scales; those costs are not silently discarded.

All eight source/report input pins are in the final receipt and were checked. The principal ones are the reviewed backend6AA4F11A, shared elementary constructionA8AC4A3B and review4642186F, odd/even height constructionsC4EE2B2F/D3408AA2, combined metadata6143FA84 and reviewF32FABEF, and mixed-radix precision4AD43D7D. Their accepted analytic identities and finite-rounding contracts are retained. This new whole-family inventory still requires independent review.
