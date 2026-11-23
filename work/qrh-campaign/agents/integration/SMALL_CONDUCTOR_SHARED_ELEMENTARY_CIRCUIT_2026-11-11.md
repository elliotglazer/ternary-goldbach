# Shared elementary construction for the small-conductor theta backend

2026-11-11. Paper circuit and exact parameter metadata only. No elementary value, character, theta coefficient, transform, prime or zero was evaluated. This supplements the conditional small-conductor backend [1], without changing its analytic identity, parameter selector, error target or spectral acceptance obligations. It supplies the elementary work omitted from that report's outer-exponential count. It does not select a runtime winner over Euler--Maclaurin.

## 1. Fixed interface

Use [1, sections 1--4] verbatim: conductor c>=3, primitive nonprincipal labels, parity a, k=a+1/2, b=pi/4-theta/V, P=N Delta>=6, omega=2pi/P, j=0,...,J=ceil(PX/6), and R=J+1. There are n primitive labels, v=phi(c) residues and h<=2 present parities. Put Jout=floor(V/Delta)+1. The exact outputs remain

    G_chi(x)=2 epsilon_chi c^(-k/2) exp(k(x+ib))
               sum_n n^a chi(n) exp(-pi n^2 exp(2x+2ib)/c),
    Y_chi(t)=exp(theta*t/V) F_b,chi(t),  t=m Delta, 0<=m<Jout.

The fixed phase satisfies epsilon_chi^2 W_chi=1. The positive character transform, positive time transform and final factor omega are unchanged. Negative frequency reuse is G(-x)=conj G(x) after this phase, not conjugation of an unphased bucket or identification of inverse-character positive-height channels.

Let eps=tau/(4*3^theta), C=4(X+1), delta=2^-p where [1] chooses delta+5delta within its Gaussian recurrence allowance. Keep all its bucket, character, time-transform and final-rounding tolerances. Define

    B=3^(X+1), M=B+1,
    epref=eps/[64 C(n0^2+2)], D=min(delta/16,1/W), W=cV/theta,
    sigma=min(1/4,D/(64M^4),epref/(16M^3),1/(16n0)),
    dr=sigma/[4B max(1,J)],
    kappa0=min(dr/16,sigma/(16384c^2)).                    (1)

Errors below are absolute real errors or complex Euclidean norm errors. A complex-times-real product can meet norm error sigma by rounding each coordinate within sigma/2. Bit counts below specify tolerances, not a hidden floating-point evaluator. Exact input and output bounds remain certificate predicates.

## 2. One radial seed, explicit growth and cutoff certificates

Set r=exp(pi/P) and A_j=r^j=exp(x_j/2). Since x_j<2(X+1), A_j<B; also 1<r<2. Obtain rhat with error <=dr and use

    Ahat_0=1, Ahat_(j+1)=round(Ahat_j*rhat),

with per-update error <=dr. The elementary product bound (1+dr)^J<=2 follows from Jdr<=1/2, for example by expanding the finite product and bounding it by the geometric series. Thus

    |Ahat_j-A_j| <= 2j dr (r+dr)^(j-1) <=4jB dr<=sigma.   (2)

In particular Ahat_j>=3/4 and |Ahat_j|<=M. The one real exponential seed has an exact rational input apart from pi. A pi error <=dr/16 and an intrinsic exp error <=dr/2 suffice, since the derivative exp(pi/P)/P<1/3 throughout the small enclosing interval after tightening if necessary. All other uses can refine this common pi certificate further.

At each j form T=round(Ahat^2), U=round(T^2), and, if an odd channel is present, V3=round(T*Ahat), with round error <=sigma. Straight product subtraction gives

    E2 <=(2M+1)sigma,
    E4 <=(6M^3+3M^2+1)sigma,
    E3 <=(3M^2+M+1)sigma.                                (3)

Here |T|<=2M^2, |U|<=2M^4 and |V3|<=2M^3. For E3 use (T-A^2)Ahat+A^2(Ahat-A), not a fictitious exact T.

The same radial state supplies the cutoff without an extra exp or log. For j>0 take

    u_j=min(n0,ceil(n0/(Ahat_j-sigma)));  u_0=n0.

The lower denominator is positive. Its reciprocal exceeds 1/A_j by at most 4sigma, since A_j>=1 and Ahat_j-sigma>=1-2sigma>=1/2. Consequently

    n0/A_j <=u_j<=min(n0,n0/A_j+2),

using 4n0 sigma<=1/4 and the ceiling error <1. This proves precisely [1,(8)]. It costs one rational division/ceiling comparison per frequency; it is not an unchecked integer estimate of a transcendental floor. The resulting Gaussian term upper bound of [1,(9)] still applies.

## 3. Gaussian arguments and prefactors

Construct once Z0=(pi/c)cis(2b), with error <=sigma, and set zhat_j=round(Z0hat U_j). Since |Z0|<2,

    |zhat_j-Z0 A_j^4|
      <=[12M^3+6M^2+3+2M^4]sigma
      <=15M^4 sigma<D.                                  (4)

The exact z has Re z>=pi theta/(cV)>3/W, whereas D<=1/W. Hence the entire line segment to zhat has positive real part. On this segment exp(-z) has derivative norm <=1. An intrinsic exp(-zhat) error <=delta/16 therefore gives total raw q error <=delta/8. Apply the two-round unit-disk contraction in [1, section 3] with eta=delta/8. Its final error is <=5delta/8<delta and its norm is <=1. This preserves the original q^(n^2) error induction and its gamma=5delta gates. A large imaginary argument still requires a proved angle reduction and sufficiently precise pi; it is not a constant-cost exponential.

For each label cache

    K_chi=2 epsilon_chi c^(-(2a+1)/4) cis((2a+1)b/2),

with error <=sigma. Its exact norm is <=2. The full prefactor is K_chi A for even parity and K_chi A^3 for odd parity. One complex-times-real product with error <=sigma, (3), and |V3|<=2M^3 give the common bound

    prefactor error <=[6M^2+2M+3+2M^3]sigma
                     <=7M^3sigma<epref.                 (5)

The final multiplication of this prefactor with the character contraction is still charged at the separate [1] tolerance eps/(32C). It is not counted a second time as part of (5).

This construction uses no per-frequency inner exponential or parity cis. The outer q exponentials, at most R, remain. For a frequency with M_j=0 they may be skipped. The radial circuit still has to establish its cutoff.

## 4. Root numbers, fixed phases and transform roots

The phase cache is mathematical input, not a table of unspecified unit complex numbers. The following complete construction is one option.

Obtain h_c=c^-1/2 and v_c=c^-1/4 through two positive algebraic certificates with errors <=kappa0. The exact predicates are c*h_c^2=1 and c*v_c^4=1 with positive roots; rational interval endpoint power inequalities discharge the witnesses. If implemented by successive square roots, propagate the first uncertainty and refine it accordingly. Merely assigning both intermediate square roots the same error is not the stated contract. Form v_c^3 with two rounded products. For each present parity construct

    Q_a=2 v_c^(2a+1) cis((2a+1)b/2).

Refine the pi certificate and arithmetic so every constituent angle/leaf/gate error is <=kappa0. On this bounded domain an elementary product/telescoping bound <=64kappa0 for Q_a and Z0 suffices; this is <sigma/16. The relevant angles are pi/2-2theta/V and (2a+1)pi/8-(2a+1)theta/(2V). There are 1+h such cis values. Their integer/rational coefficients are fixed, not growing with j.

For all primitive root numbers at one conductor use one additional unnormalized positive character transform of the v additive roots cis(2pi r/c), r in the unit group. The exact output is tau_chi=sum_r chi(r)cis(2pi r/c), with the same explicit character labels as the main transform. Set eta=sigma/256. Make each additive-root error <=eta/(16v); make the intrinsic transform error <=eta/16. The accepted mixed-radix lemma [4] gives the latter with input-center bound 2 and

    u_G<=min(1/max D_axis,1/(2S),eta/(256vS)),             (6)

since its output bound is 2vS u_G(Minput+1)<=6vS u_G. Exact trivial axes omit the denominators. Thus the total tau error is <eta/4. This setup includes its Bluestein kernels and cannot reuse a main-transform kernel with insufficient precision.

Use W_chi=tau_chi*h_c*i^(-a). Since |tauhat|<=2c, error(h_c)<=eta/(8c) and final round <=eta/4 give W error <eta. Formula (1) supplies this root precision. For direct additive-root leaves, pi/angle errors totaling <=3kappa0 are <=eta/(32v); a cis error <=eta/(32v) completes their tolerance.

Choose a fixed chart for conj W using one of four exact quarter turns so that the rotated exact w has Re w>=1/2. This can be certified by rational lower bounds from the W enclosure: a unit complex number has one signed coordinate >=1/sqrt(2), leaving strict slack. No equality or argument-branch oracle is needed. In that chart

    r0=sqrt((1+Re w)/2), s0=Im w/(2r0), r0+i s0=sqrt(w).

Here r0>=sqrt(3/4). With W error <=eta and each positive-root/division error <=eta, direct derivative bounds on this chart give root error <=7eta. Undo the chart using a certified eighth root, error <=eta, and one final round <=eta. Total epsilon error <=10eta<sigma/16. Epsilon is unit in its exact mathematical definition; its center need not be. This square root gives epsilon^2 W=1. It costs one root and one division per primitive label. It does not prove a sign of a previously fixed phase. A new packet may fix this branch once throughout its values/counting interface; reuse of an existing packet must explicitly align its phase, including a possible minus sign.

Finally cache K_chi=epsilon_chi Q_a. Errors sigma/16 for each input and final rounding, with exact norms 1 and <=2, give error <=5sigma/16<sigma. This is one complex product per label, not per frequency. Primitive Gauss norm, character labeling and the completed functional equation remain the source theorems in [2]. They are not inferred from approximate W.

Transform roots have two fully priced options. A direct baseline certifies every needed rational-angle cis once. Time radix two needs at most N/2 roots. A character radix-d axis needs at most d roots; a Bluestein axis of convolution size P_d needs at most P_d+2d roots, plus its one cached kernel transform. Different axes and the Gauss/main calls share a cache only at the finest required precision.

Alternatively, for each distinct root order m certify one primitive cis(2pi/m), contract into the unit disk, and build the required consecutive powers with unit-disk gates. If the required root error is u, take primitive error <=u/(2m) and gate error <=u/(2m). After k<=m products the error is <=k*u/(2m)+(k-1)*u/(2m)<u. Each gate is the two-round/shrink construction, not an ordinary rounded multiply. Time roots use m=N and only N/2 powers; Blue chirps are indexed powers of order 2d, and their convolution uses order P_d. The Gauss additive roots can similarly use order c and at most c-1 gates instead of v direct leaves. Eighth roots use order 8. All indices and signs are exact. This option reduces cis certificates to the distinct orders but adds gates and asks for about log2(m) more bits. The global pi enclosure must be refined for the finest primitive-root leaf and the outer exponential reductions, beyond kappa0 if needed. Neither option is declared faster.

## 5. Final positive rescaling

Set escale=tau/[4(2W^2+1)], BY=3^theta, mmax=Jout-1, and ds=escale/[8BY max(1,mmax)]. One additional real exponential certifies s=exp(theta Delta/V) with error <=ds. Generate Shat_0=1, Shat_(m+1)=round(Shat_m*shat), with round error <=ds. The same proof as (2), with true powers <=BY, gives scale error <=escale/2, so [1]'s escale contract has slack.

Take the real part of the approximated F output, since the exact F is real; this does not enlarge its error. Multiply this real center by Shat_m with final error <=tau/4. Thus Jout-1 shared real recurrence products and n*Jout real output products suffice. All labels at this conductor share the same positive scale. No complex cis c^(it/2) is evaluated at each output: it is already part of the exact F identity. A point-EM evaluator using another completion must still produce this same normalized Y, including its own completion/phase conversion costs.

## 6. Work and storage, with a matched comparator

The unchanged core from [1] costs at most 2T unit-disk Gaussian gates, hT bucket additions and at most T exact odd-integer scalings; hR character transforms; nR final complex prefactor/contraction products; and n(N/2)log2N time butterflies. No claimed reduction to these terms follows from the new cache.

The extra construction now has an explicit schedule. Let o be 1 if odd parity is present and 0 otherwise.

| Work | Count before repair |
|---|---:|
| Radial seed and positive-scale seed | 2 real exponential certificates |
| Outer Gaussian leaves | at most R complex exponential certificates |
| Radial updates/powers/z/prefactor scaling | J+(4+o+2n)R real products |
| Cutoffs | R rational divisions/ceilings, with interval checks |
| Tilt/parity cis | 1+h certificates |
| Conductor amplitudes | 2 positive algebraic root certificates; 2 products for v_c^3 |
| Gauss root numbers | 1 character transform, v direct additive cis leaves or one root recurrence |
| Phase extraction and K cache | n positive roots, n divisions, n complex products, plus at most n eighth-root undo products |
| Fixed Q/Z0/W arithmetic | O(h+n) explicitly bounded coordinate scalings/products; at most 16+12n real/complex arithmetic calls suffices |
| Time/character roots | direct cache bound above, or one primitive cis per distinct order plus the stated prefix gates |
| Positive output scale recurrence | Jout-1 real products |
| Final real output multiplication | n Jout products |

The O(h+n) line is a fixed-size straight-line setup, not a variable-length analytic evaluation: two products for v^3, two coordinate scalings for each of <=2 Q values, two for Z0, two for each W, exact quarter turns and bounded chart tests, and rounding/copy operations. Division and square-root calls are already itemized separately. The deliberately loose 16+12n count does not include the separately listed Gauss transform, K products or chart-undo products. Every such call still carries its required operand width.

The supplied metadata retains the direct-root baseline counts, including N/2 time cis certificates. They must be replaced, not silently erased, when selecting the root-recurrence option. Bluestein kernel construction is once per axis/precision and remains in either option. Primitive cis/exp certificates must expose reduction, series length, argument magnitude and rounding costs. A certificate count is not a constant unit price. In particular |z_j|<=4M^4, the new radial seed is finer than delta, and chart/setup precision can be finer still.

Only the current A,T,U,V3 states are needed while streaming frequencies. K adds n complex cache entries; Q adds h, Z0 one and r one. The root caches and Gauss workspace are additional. The n-by-R transpose or repeated-pass tradeoff in [1] is unchanged. Root recurrences can stream their certificates, but a later transform still needs its indexed root values or pays checked regeneration. The final positive scale can be streamed across output heights. Sharing between conductors requires identical mathematical parameters and sufficiently fine precision, not matching field names or a hash alone.

For a point-EM comparison fix exactly the same c, labels, Delta, V and Y error tau. Write its cost as admitted seed/short-head work + Jout*v*Palpha contractions + Jout character transforms + its complete Y normalization + identical final sign/count requirements. The old P20 seed proof at t<=10000 is not an admissibility theorem at this note's larger V. On the theta side add every row above to the unchanged core, transpose, and the same downstream obligations. Cancellation of genuinely shared roots/phase setup is allowed. The character-call difference alone is (hR-Jout) calls and proves no total-cost ordering.

For assigned nonnegative prices at their actual widths, theta wins exactly when its extra Gaussian/radial/time/transpose work is less than the EM seed/contraction/normalization work it replaces, including that character-call difference. The two real exp seeds replace R inner radial exp evaluations and nR parity exp/cis evaluations that a naive construction would perform, but [1] never asserted such a naive producer. This is a concrete available implementation, not a measured saving over the historical Platt program. Root-cache alternatives have their own crossover: saved direct-cis cost versus prefix unit gates, finer primitive leaves and retained storage.

## 7. Exact metadata and remaining acceptance

The new script reads the pinned 15-row receipt, without importing its generator or any evaluator. It verifies 135 rational/integer inequalities and records the new precision/count data. All rows are still the sensitivity scenario V=10^8/c+1000, not successful Turing guards.

| c | theta | sigma bits | radial seed bits | setup leaf bits | extra frequency real products |
|---:|---:|---:|---:|---:|---:|
|3|64|386|435|439|4473924279|
|4|64|386|434|438|2236962143|
|101|64|386|429|433|1782579539|
|1000|64|386|426|430|356079367|
|10000|64|386|423|427|437731209|
|10000|128|484|520|525|218867207|

These are sufficient fractional-bit tolerances, not storage widths. Integer parts and raw multiplication widths must also cover M, M^4, n0, transform intermediate bounds and angle-reduction quotients. The metadata's setup bits cover kappa0 only; the root-recurrence option and outer angle reduction may require finer shared pi. Final-scale seed bits and every other row are in the receipt. No empirical precision, sign separation or backend speed is assumed.

Remaining implementation obligations are the exact elementary certificate checker, straight-line arithmetic at the stated norm tolerances, root/chart/label bindings, source identities [2--3], main and setup transform proofs [4], faithful transpose and complete output/sign/Turing records. This is a paper composition of those interfaces. It creates neither a Lean theorem nor numerical evidence for any of the required values.

## 8. Frozen inputs and evidence

Paths are relative to `work/qrh-campaign/agents`.

| Ref | File | SHA256 |
|---|---|---|
|1|prime-estimates/NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md|6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043|
|1 review|integration/REVIEW_NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md|80F6CF2D828922D1654391FEC58720603503059618542B2CE5E049A1C61584EB|
|2|zero-sum/FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md|5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41|
|3|zero-sum/TILTED_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md|695BF1B9AE43BDDA950F111D8A484B35DE774578B6F5A14012763740E28848AE|
|4|zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md|4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4|
|primary|audit/platt_turing_1305_3087.txt|2A2EABBCA321E6B29BC3E0BAE4339245C819B5234C0C4CC222C65E981E84E3E9|
|input receipt|prime-estimates/small_conductor_theta_backend_metadata_20261111.json|2B149E2EE2CD5C20EDD14A38B009321847FB8FE2344D63DE5405291B3A183A1F|
|new script|integration/small_conductor_shared_elementary_metadata_20261111.py|B8DCACDC4896258C2A5E721FB67A845FCFD6099C74BA34342158F10095EBBCF3|
|new receipt|integration/small_conductor_shared_elementary_metadata_20261111.json|117D2C82B8CA19CC24C3C359573598149F6B1CE6D53463B48B395B716350520E|

The primary paper's section 5 and [1]'s source map identify the Fourier/completion inputs. This supplement uses their statements and proves the new finite error recurrences above. It does not claim an independent re-audit of the underlying infinite Fourier identities.
