# A complete conditional backend schedule for the small conductors

2026-11-11. Paper derivation and exact rational/integer parameter metadata only. No L-function, theta value, prime candidate, zero, transform array or build was evaluated. No existing source or frozen report was changed. The new finite arithmetic circuit and its implementation remain to be proved/constructed; no successful sign or finite-RH result is asserted.

The omitted c<=10000 branch can reuse the accepted character-transform and elementary arithmetic backends, but not the large-branch Hurwitz operation subtotal. This report supplies an explicit conditional parameter selector and a separately priced theta/time-transform schedule. Its new coefficient circuit uses **one exponential per retained nonnegative frequency**, followed by a unit-disk Gaussian recurrence with quadratic error growth. It also makes the tilt/precision/transform-length tradeoff explicit. The conservative examples do not establish that this backend is preferable at every small conductor.

## 1. Scope, prior work, and exact output

The current R132900 inventory has 7499 active conductors in 3<=c<=10000, with 18477108 primitive labels. They are the odd conductors and the multiples of four; the original height is H(c)=100000000/c throughout this subrange. The existing nominal 5/64 grid has 4729100914759 positive primitive output slots. These are manifest counts, not successful values or zero counts. The older `FAMILY_PRODUCTION_COMPLETENESS_PLAN` has a historical .555/profile target; its evaluator identities are reusable, but its old manifest and weaker spectral conclusion are not the selected target here.

Platt's primary paper, locally retained as `audit/platt_turing_1305_3087.txt`, section 5, identifies why this branch differs: a high-t Hurwitz lattice has fewer conductors sharing it. Lemmas 5.1–5.2 give the theta Fourier coefficients; 5.4–5.6 address the two periodization errors; section 6 adds interpolation. The accepted `FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN`, off-critical and tilted-slab papers reconstruct the actual source normalization and analytic tails. The old reduced-cost report already prices a symbolic coefficient/character/time pipeline. The new work below is its concrete finite-accuracy specialization and Gaussian recurrence, not a new claim that FFT batching or historical interpolation was absent.

For an actual primitive nonprincipal character chi mod c, parity a in {0,1}, let k=a+1/2 and choose one fixed unit epsilon with epsilon^2 W_chi=1. Use the source entire completion, not the pointwise product of totalized Gamma at its poles. On the critical line define

    F_b(t)=epsilon exp(b*t) c^(it/2) completedLFunction_chi(1/2+it),
    G_b(x)=2 epsilon c^(-k/2) exp(k*(x+i*b))
           *sum_(n>=1) n^a chi(n) exp(-pi*n^2*exp(2*x+2*i*b)/c).

The accepted convention is G_b(x)=(1/(2*pi))*integral F_b(t)exp(-i*x*t)dt, and F_b(t)=integral G_b(x)exp(i*x*t)dx. F_b is real for real t. Therefore

    G_b(-x)=conj(G_b(x)).                                      (1)

This follows from conjugating the absolutely convergent Fourier integral, after fixing the actual epsilon. It is also consistent with the theta functional equation. It is **frequency** reuse for the same character. It does not identify positive-t values of a nonreal character with those of its inverse, and does not halve the required positive-height channels. Before multiplication by the actual root phase, arbitrary raw buckets need not satisfy (1).

We compare tilt choices using a common output

    Y_chi(t)=exp(pi*t/4) epsilon c^(it/2) completedLFunction_chi(1/2+it),
                0<=t<=V.                                    (2)

It is a positive real rescaling of the Hardy function, so signs and zeros agree. V must cover every actual main, auxiliary and guard sample used later. Choosing a scenario V does not certify a Turing interval. The canonical phase for counting is still separate; no sign proxy is substituted into an interpolation theorem.

## 2. Explicit parameters and both periodization errors

Take rational V>=1, integer tilt parameter theta>=1 with V>=2theta, and W=cV/theta>=1. Set

    b=pi/4-theta/V, Rlog=pi/4-theta/(2V), r=3/8.

Here Rlog is a log-plane contour height, not the conductor cutoff. The elementary sine bound gives cos(2b)>=theta/V and cos(2Rlog)>=theta/(2V). Also Rlog-b=theta/(2V) and Rlog+b>1/2. These are strict interior strips, never b=pi/4.

The off-critical split-Gaussian proof specializes at sigma=1/2. Its prefactors are c^(1/4)/sqrt(q) and 2c^(1/4)/(pi*q), both <=c/q for 0<q<=1. Thus the same conservative majorant as the tilted-slab proof holds at the critical line:

    |G_b(x)| <= Q(|x|),  Q(z)=2W exp(z-exp(2z)/W),
    integral |G_b(x)|dx <=2W^2,
    |F_b(t)| <=8W^2 exp(-theta*t/(2V))       (t>=0),
    |F_b(t)| <=8W^2 exp(-|t|/2)              (t<=0).            (3)

The two last bounds use contour shifts to +/-Rlog. They do not use a Rademacher estimate, a computed zeta constant or a historical GRH result. The identity/decay premises are those of the accepted theta-Mellin paper. The previous tilted-slab theorem's stated sigma>=.555 domain is not simply asserted to include .5: the displayed prefactor inequalities give the needed specialization directly.

For a requested absolute Y error 0<tau<=1, first target F error

    eps=tau/(4*3^theta).

Choose positive integers K,L,X by exact rational tests

    32W^2 r^K < eps/4,
    12W r^L < eps/4,
    (8/3)^(2X) >= W*(2X+L).                                  (4)

Start Delta=5/64 and halve until Delta*X<=1. Take N>=8 a power of two with

    P=N*Delta >= max(2VK/theta, V+2K, 6).

Set omega=2pi/P, J=ceil(PX/6), Rfreq=J+1. Then J<N/2, since X*Delta<=1 and N>=8. Retain frequencies -J,...,J, fill the rest of a length-N array with exact zero, and use the positive-exponent DFT. Its final multiplier is omega, equivalently omega*N after a normalized inverse DFT. It is not the character-transform factor phi(c).

For 0<=t<=V, Poisson summation and (3) bound the unwanted time copies by

    8W^2 [exp(-theta*P/(2V))/(1-exp(-theta*P/(2V)))
            +exp(-(P-V)/2)/(1-exp(-P/2))] < eps/4.            (5)

The positive copies start at P+t, not P-V. The negative copies use P-t. The selected P makes each denominator >1/2 and each numerator <=exp(-K); (4) completes the bound.

The first omitted positive and negative frequencies both have magnitude >X. For z>=X the logarithmic derivative of Q is at most -(2exp(2X)/W-1). Consequently the discrete omitted tail, already multiplied by omega, is at most

    2Q(X)*(omega+1/(2exp(2X)/W-1)) < 6Q(X) < eps/4.          (6)

Here omega<2, (4) makes the other denominator >1, and exp(1)>8/3. This is the full omitted-frequency error, not just a tail for a single folded coefficient. The Nyquist slot is zero because J<N/2. Formula (1) constructs negative retained slots by exact conjugation; the zero slot can be replaced by the real part of its enclosed center since its actual value is real.

The grid output is t_m=m Delta with 0<=m<=floor(V/Delta). A requested non-grid endpoint needs direct evaluation of the same finite trigonometric sum with its own rounding, or an accepted interpolation proof. No value at ceil(V/Delta)*Delta is covered by a bound stated only through V. Main height H is covered only when the actual selected top/guard geometry is inside the chosen V; this remains an admission check.

## 3. Gaussian cutoffs and a new finite recurrence

Choose an integer n0>=1 with

    v0=3n0^2/W>=2, z0=3(2n0+1)/W-1/n0>0,
    C*2n0*(1+1/z0)*r^floor(v0) < eps/8,
    C=4(X+1).                                               (7)

Doubling n0 terminates: v0 grows quadratically and z0 becomes positive. At x_j=j omega>=0 choose an integer first omitted index u_j satisfying

    n0 exp(-x_j/2) <= u_j <= n0,
    u_j <= n0 exp(-x_j/2)+2,   u_j>=1, M_j=u_j-1.             (8)

These overlapping bounds allow finite interval selection without an exact floor decision at a transcendental equality. At j=0 take u_0=n0. Such an integer always exists; a producer must prove (8) from elementary enclosures or use a larger separately checked cutoff. The latter changes its work accounting.

For d_j=pi exp(2x_j)cos(2b)/c, the omitted term ratios are <=exp(-z_j), where

    z_j=3exp(2x_j)(2u_j+1)/W-1/u_j >=z0.

Indeed (8) gives z_j >= exp(x_j/2)(6n0 exp(x_j)/W-1/n0)+3exp(2x_j)/W, which is >=z0 since v0>=2. Also d_j u_j^2>=v0 exp(x_j). The Fourier prefactor is <=2exp(3x_j/2), and u_j^a<=n0. Since v0>=2, the function exp(3x/2-v0 exp(x)) decreases for x>=0. Thus every complete coefficient tail is bounded by the expression in (7) without C. Multiplying by the retained frequency weight costs at most C because omega(2J+1)<C. Series truncation therefore contributes <eps/8 to every output.

The total number of retained Gaussian terms has the useful bound

    sum_(j=0)^J M_j <= n0/(1-exp(-omega/2))+Rfreq
                         < n0*(1+P/3)+Rfreq.                (9)

The last step uses 1/(1-exp(-z))<=1+1/z and pi>3. This is an upper bound for admitted cutoffs (8), not an observed term count.

For each frequency write z=pi exp(2x+2ib)/c and q=exp(-z). Its norm is <=1. The exact sequence can be generated by

    g_1=q, h_1=q^3, d=q^2,
    g_(n+1)=g_n*h_n, h_(n+1)=h_n*d.                          (10)

Then g_n=q^(n^2), h_n=q^(2n+1). Both parity buckets share g_n; the odd bucket multiplies it by the exact integer n. Accumulate these terms by the exact residue n mod c. Nonunit coefficients may be skipped in the buckets, but the recurrence still advances unless an additional proved jump circuit is used.

Use a checked unit-disk multiplication gate: for |A|,|B|<=1 it returns |C|<=1 and |C-AB|<=gamma. This is constructible with dyadics. First round AB with norm error <=eta, shrink the result by the exact dyadic factor 1-2eta, then round again with norm error <=eta, where 0<eta<=1/2. The final norm is <=(1-2eta)(1+eta)+eta<=1 and its error is <=4eta+2eta^2<=5eta. Thus gamma=5eta suffices. The two rounds, shrink and signed arithmetic are real costs, not one native complex multiplication. The initial q center can be contracted by the same construction to stay in the unit disk.

If the seed has norm error delta and all these gates have error gamma, induction using unit norms gives

    error(d)<=2delta+gamma,
    error(h_n)<=(2n+1)delta+2n gamma,
    error(g_n)<=n^2 delta+(n^2-1)gamma.                     (11)

This is the new stability advantage: no factor (1+error)^(n^2) is needed. It requires the checked unit-disk invariant, not just an approximate modulus observation. The Gaussian sequence costs at most 2M_j such multiplication gates; more exactly it needs none for M_j<=1 and 2M_j-1 for M_j>=2. One exponential seed suffices whenever M_j>0. Frequencies with no retained term may omit that seed.

## 4. A complete finite-arithmetic allocation

The following conservative allocation makes the remaining arithmetic interfaces explicit. Let

    Bpref=2*3^(3(X+1)).

It bounds the Fourier prefactor at every retained frequency, since x_j<=J omega<2(X+1), k<=3/2 and c^(-k/2)<=1. For both parities sum_(n<=M) n^(a+2)<=n0^4. Require

    delta+gamma <= eps/(32 C Bpref n0^4),
    bucket addition error <= eps/(32 C Bpref n0)

per addition. Equations (11) and the triangle inequality bound the total bucket-error l1 norm by eps/(16 C Bpref). The exact character transform has unit-modulus entries, so its unnormalized output error from these bucket uncertainties obeys the same l1 bound. It is not multiplied by phi(c) again.

For intrinsic transform arithmetic, use the accepted mixed-radix error recurrence with S=sum C_axis and safety denominators D_axis. With stored bucket norm <=n0^2+1, choose its root/gate tolerance

    u_char <= min(1/max D_axis, 1/(2S),
                    eps/[128 C Bpref phi(c) S (n0^2+2)]).

Omit S denominators for an exact trivial transform. Formula (13) of that precision paper then bounds unnormalized intrinsic error by eps/(64 C Bpref). Its Bluestein kernel setup and nonunit kernel magnitudes remain included. Primitive/parity pruning is allowed only through the proved partial-output circuit; the examples below use a conservative full-axis circuit for each present parity.

Enclose the full prefactor, including the fixed epsilon, with norm error at most eps/[64 C(n0^2+2)], and round its final multiplication with error at most eps/(32 C). The approximate character contraction is bounded by n0^2+2. Prefactor error, intrinsic character error and final rounding then cost at most eps/(16 C); the bucket input error after the exact prefactor costs at most another eps/(16 C). Thus total finite arithmetic error in each coefficient is <=eps/(8C). With (7), coefficient truncation and arithmetic together cost <=eps/4 after the frequency sum.

For the final length-N time transform, the stored coefficient bound 2W^2+1 is sufficient. Let Ctime=2log2(N)+4. The radix-two precision lemma, with its root errors included, permits

    u_time <= min(1/(2log2(N)), eps*Delta/[56 Ctime(2W^2+2)]).

Since omega*N=2pi/Delta<7/Delta, intrinsic error in the final scaled output is <=eps/8. Approximate omega with error <=eps/[16N(2W^2+2)] and allow final multiplication rounding eps/16. These two contributions cost at most eps/8. Hence finite time-transform arithmetic costs <=eps/4. Together with (5), (6) and the coefficient budget, F error is <eps.

Finally Y(t)=exp(theta*t/V)F_b(t). This positive scale is <=3^theta. Enclose it with error <=tau/[4(2W^2+1)] and allow final multiplication error tau/4. With |F_center|<=2W^2+1 and the chosen eps, the total Y error is <3tau/4. Refining the positive scale cannot fix an inadequate F bound; all three terms have been charged.

Every primitive above has an existing exact-rational/dyadic enclosure plan, and the error recurrences give finite explicit tolerances. The algorithm still needs its actual checked primitive implementation and data. In particular phase arguments, signed exponents, root-number branches, raw integer products and output normalization are not certified by choosing a number of fractional bits. The metadata's seed bit count is only the unit-disk Gaussian seed/gate requirement: delta=2^-p, gamma=5*2^-p. Its initial uncontracted exponential must be correspondingly tighter (for example norm error <=2^(-p-3)). It is not a precision prescription for every stage of this backend.

## 5. Operation schedule, storage, and crossover

For each conductor let h(c) be the number of present parity channels, v=phi(c), n the number of primitive labels, and (G_c,P_c) the butterfly and extra-product counts of the chosen unnormalized character circuit. Let T=sum M_j, Rfreq=J+1. A conservative full schedule is:

| Component | Retained work before exceptional repairs |
|---|---|
| Gaussian leaves | at most Rfreq complex exponentials, plus shared pi/tilt/prefactor elementary leaves |
| Gaussian recurrence | at most 2T unit-disk multiplication gates, with two rounds and one shrink each |
| Buckets | at most h(c)T additions; at most T exact integer n scalings for the odd channel; residue/index checks |
| Character transforms | h(c)Rfreq G_c butterflies and h(c)Rfreq P_c additional products; cached roots/Bluestein setup separately |
| Prefactor/phase | at most n Rfreq contractions; fixed root-number proof once per label |
| Negative frequencies | exact conjugation/copy after the phase; zero and Nyquist treatment as above |
| Time transforms | n*(N/2)*log2(N) radix-two butterflies, plus cached length-N roots |
| Output normalization | at most nN products if all outputs retained; common positive scale at each used height; selected-only output possible with a proved partial circuit |
| Values to RH | interpolation/guard/repair, actual strict signs, central/real-zero handling, inverse-channel coverage and closed count gate, separately |

These are different operation categories. A unit-disk gate, arbitrary complex exponential, fixed-twiddle butterfly and exact integer scaling are not interchangeable. The three-real-product and ordinary-PA/Lean digit models can price them only after total operand widths and the local error contracts above are instantiated.

For comparison with an unshared exponential-per-term generator, the new circuit is beneficial only if the saved elementary evaluation cost exceeds the recurrence and its tighter seed precision: compare sum over n,j of E(z_j*n^2,required_error) against one E(z_j,delta_j) per frequency plus the actual unit-gate/rounding costs. The old formula did not mandate exponentiating each term, so this is an implementation option, not a measured speedup over a particular producer.

For a point-EM comparator with Jout=floor(V/Delta)+1, the character stage costs Jout*(G_c,P_c), plus Jout*v*Palpha contractions, the conductor's admitted share of common Hurwitz seeds, short heads and output normalization. The theta character stage alone is cheaper only when h(c)Rfreq<Jout for the same full-axis circuit. A whole-backend comparison must then add theta coefficients and n time transforms on one side, EM seed/contraction work on the other. The P20 figures in the receipt are only contraction counters; they do not assert that an old P20 seed allocation covers these very high t or an auxiliary extension. Neither side is allowed to charge its shared setup once per output.

This branch's frequency/output transpose is a real storage obligation. Streaming frequencies uses O(h(c)*v) bucket space, but the n output rows need Rfreq coefficients each before their time transforms. Options are a checked n-by-Rfreq external transpose, or batches of r labels with O(rRfreq+N) working complex cells and recomputation of the frequency/character pass for each batch. Without retained checked intermediate data the latter pays ceil(n/r) passes. Hashes alone do not license importing an unchecked transpose. Mathematical source/normalization and index bindings must survive each shard. No RAM claim follows from the total operation counters.

Reusable components are concrete: exact roots, unit-group coordinates/primitivity, mixed-radix circuits, Bluestein kernels, signed dyadics and elementary enclosures from the large branch; time-transform machinery and elementary kernels from the principal branch. The principal theta has a nonzero constant/pole correction, so its analytic identity cannot replace the nonprincipal one. EM can provide independent point checks or sign repairs. A Hardy phase proxy may prove a sign, but its values cannot be inserted into the F_b interpolation array without a proved amplitude conversion. Modular theta buckets are an optional same-value coefficient backend; their characteristic phases/transport and per-residue work must be priced instead of the direct recurrence, not added as if both were compulsory.

## 6. Exact metadata examples and their limitation

The owned script performs no factor sieve: it uses five explicitly specified unit-group shapes and label counts, then rational tests (4),(7) and integer circuit counts. The scenario is V=100000000/c+1000 and tau=2^-80. The additional 1000 is **not** a proved sufficient count/guard region. All cases keep Delta=5/64. A requested non-grid V endpoint needs the explicit extra evaluation described above. Each row lists an upper schedule, not actual data.

| c | theta | N | Rfreq | n0 | Gaussian seed p | Time butterflies |
|---:|---:|---:|---:|---:|---:|---:|
|3|64|4294967296|559240535|16384|306|68719476736|
|4|64|2147483648|279620268|16384|306|33285996544|
|101|64|67108864|8738135|16384|306|86369107968|
|1000|64|8388608|1092268|16384|306|15435038720|
|10000|64|1048576|136535|16384|306|16777216000|
|10000|128|524288|68268|8192|404|7969177600|

All 15 rows, including theta32/128 for every listed conductor, are retained in the receipt. At c10000/theta64, two parity transforms require 273070 frequency-group calls against 140801 point-grid calls. At theta128 this becomes 136536 against 140801, but the seed fractional requirement grows from 306 to 404 and the time transforms remain additional work. At c3/theta64 the bound (9) alone allows 1833078636546 Gaussian terms. These conservative numbers expose why the omitted branch cannot be priced by multiplying a large-branch per-label cost or assuming negligible seed work. They do not prove actual work reaches these upper bounds or that the historical implementation had these parameters.

The full-branch schedule is the sum of the component rows in section 5 over the exact 7499-conductor manifest, with admitted V, theta, tau and circuits per conductor/cohort. This report does not manufacture a global numeric sum from unspecified sign margins or auxiliary ranges. Cohorts can share theta/V, frequency grids, time roots and positive rescaling only when those parameters actually agree. The same G-bucket values are not shared across conductors merely because their total label counts agree.

The next useful comparison is therefore a fixed small-conductor slice with a complete parameter/error certificate and a matched EM or modular-coefficient alternative, including transpose and eventual count/repair work. It requires separate authorization and actual successful data. No universal sign-discovery termination follows from finite-accuracy termination; multiple or closely spaced zeros and inadequate sign margins remain explicit exceptions.

## 7. Source map and pins

The accepted Gaussian source map reads the actual `DirichletContinuation.lean` completed function/FE (lines249,258,271,283), `DirichletCharacter/GaussSum.lean:57` all-residue primitive Gauss identity, `Fourier/PoissonSummation.lean:190–215`, complex Gaussian Fourier transform, and Fourier inversion with its integrability premises. The new recurrences need only complex multiplication/exponential laws and norm inequalities; they do not introduce a new analytic oracle. Existing plans still need formal implementation and their source/axiom acceptance.

Paths below are relative to `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
| `audit/platt_turing_1305_3087.txt` | `2A2EABBCA321E6B29BC3E0BAE4339245C819B5234C0C4CC222C65E981E84E3E9` |
| `zero-sum/FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md` | `5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41` |
| `zero-sum/OFF_CRITICAL_GAUSSIAN_FOURIER_PLAN_2026-11-11.md` | `BA7A5D0517972FD9C93496E6166DEC471B36C18CA0B6BBA734985016ECD24B25` |
| `zero-sum/TILTED_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md` | `695BF1B9AE43BDDA950F111D8A484B35DE774578B6F5A14012763740E28848AE` |
| `zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md` | `4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4` |
| `zero-sum/REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md` | `B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC` |
| `zero-sum/CONDITIONAL_R132900_SPECTRAL_PRUNING_INVENTORY_2026-11-11.md` | `7AA9BF4D456CE25685D69427966DC7F61D0914DD091A95B74F9C242B95CADB27` |
| `prime-estimates/small_conductor_theta_backend_metadata_20261111.py` | `CBBF7F6CE3E27D9FA37B50DA9D50243F824C4C4A09ADB5F2E31D068537C89A8B` |
| `prime-estimates/small_conductor_theta_backend_metadata_20261111.json` | `2B149E2EE2CD5C20EDD14A38B009321847FB8FE2344D63DE5405291B3A183A1F` |

Only the 15 parameter/operation metadata rows were generated. No frequency coefficients, root phases, sign samples, transform arrays, prime lists or spectral assertions were generated. Prior artifacts and the selected finite-RH family remain unchanged.
