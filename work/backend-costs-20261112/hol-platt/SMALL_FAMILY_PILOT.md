# A full-length small-family adaptive-radius pilot

13 November 2026. Prospective packet only. No source values, characters, roots, FFTs or signs were evaluated, and no build or producer was run. Read-only JSON parsing extracted the one specified existing conductor row and its already saved selector. Counts and storage formulas below are elementary arithmetic on that row, not a fresh family survey. The frozen schedules and precision audit remain unchanged.

## Selected row and scope

Choose **conductor c=10000**, the final row of the saved small-family e=0 scenario. This is a deliberate fixed choice with known factorization and a manageable full time length, not a claimed minimum over the family. The exact selected row is

    [conductor, last_coarse_index, N, raw_time_bits, magnitude_exponent]
    = [10000, 84224, 524288, 243, 59].

Its selected theta is 64. This is from `sign_only_minimal_theta_nonprincipal_schedule_20261111.json`, scenario 0, `small_sign_only_conditional_candidate.raw_metadata[-1]` and `conductor_theta`; the theta also agrees with the final choice in `small_family_minimal_theta_20261111.json`, scenario 0. Use the following immutable mathematical parameters:

| Parameter | Value |
|---|---:|
| c | 10000 = 16 * 625 |
| phi(c) | 4000 |
| Primitive labels / parity split | 1600 / 800 even, 800 odd |
| Ordered group dimensions | 2, 4, 500 |
| Required integer height H | 6580 |
| Main grid | t_l=5l/64, 0<=l<=84224 |
| V | 6580 |
| theta | 64 |
| b | pi/4 - 16/1645 |
| N | 2^19 = 524288 |
| P=N*Delta | 40960 |
| omega=2pi/P | pi/20480 |
| X / C / n0 | 10 / 44 / 8192 |
| J=ceil(PX/6) | 68267 |
| Nonnegative frequency count J+1 | 68268 |
| Saved tail-selector K / L | 164 / 148 |
| Wbar | 1250000 |
| Exact W=cV/theta | 1028125 |
| epsilon | 2^-80/(4*3^64) |

The source height formula is `ceil(200+max(255,3.1416*(191/10)*(1063200/10000)))=6580`. N is the saved theta128-length choice also admitted at theta64. Its period satisfies P>=2VK/theta, P>=V+2K and P>=6; J<N/2. This is the complete time transform on the original period, not an FFT on only the 84225 requested output sites.

The first bounded experiment should select one explicit primitive character and its inverse, retain both full N-point time outputs, and test every main-grid site in both channels. It is a complete full-length numerical block for two actual channels, **not** a complete conductor or finite-RH certificate. The full-conductor dimensions and their costs remain stated below. Do not scale this selected-pair implementation into a full-family forecast without the shared-character-transform alternative.

## Exact characters and fixed phase

Use CRT coordinates modulo16 and625. For a unit r, write

    r mod16 = (-1)^e * 5^j,     e in {0,1}, j in {0,1,2,3},
    r mod625 = 2^h,             0<=h<500.

The proposed channel labels are (e-character index, j-character index, h-character index) **(0,1,1)** and **(0,3,499)**. Thus

    chi(r) = i^j * exp(2pi i h/500),
    chi_inverse(r) = conjugate(chi(r)),
    chi(r)=0 on nonunits.

The implementation must certify the two coordinate-generator orders and bijections. The order500 assertion for2 mod625 is a prerequisite to check, not an inferred property of a floating root table. The mod16 factor has odd C4 index and the mod625 factor has index not divisible by5, establishing exact conductor16*625 through the primitive-character criteria. Both chosen characters are odd: -1 has h=250 and j=0, so chi(-1)=-1. This gives a concrete descriptor without pretending an existing checked character table is already present.

For each channel compute the positive Gauss sum

    tau_chi = sum_(r mod10000) chi(r) exp(2pi i r/10000),
    W_chi = tau_chi/(i*100).

Use the existing phase-chart construction from `SMALL_CONDUCTOR_SHARED_ELEMENTARY_CIRCUIT`, section4. Certify |W_chi|=1 from primitiveness, enclose it numerically, select a quarter-turn chart with a proved positive real lower bound, take the positive square root there, and undo the chart with the certified eighth root. Fix the resulting epsilon_chi once, with |epsilon_chi|=1 and epsilon_chi^2 W_chi=1. Record the chosen chart and its exact branch alignment to the canonical Hardy/count convention. Do not choose the sign of epsilon independently at every sample, assume rootNumber=1, or copy the chi4 pilot's root number. Do not identify the two positive-height channels.

The true function is exactly

    F_b,chi(t) = epsilon_chi exp(b*t) c^(it/2)
                  completedLFunction_chi(1/2+i*t),
    Y_chi(t) = exp(64*t/6580) F_b,chi(t).

The completion and c^(it/2) factor are mandatory. Positive scaling permits strict signs of F_b/omega to serve as canonical signs after the fixed phase alignment. No amplitude-valued Y export is promised by the pilot.

## Complete source generation

For j=0..68267 set x_j=j*omega, z_j=pi*exp(2*x_j+2*i*b)/10000. With odd parity k=3/2 the actual coefficient is

    G_chi(x_j) = 2 epsilon_chi c^(-3/4) exp((3/2)*(x_j+i*b))
                 * sum_(n>=1) n chi(n) exp(-z_j*n^2).

Generate the shared radial sequence A_j=exp(x_j/2) and its certified approximations exactly by the existing shared-elementary contract. At j=0 set u_j=8192. At later j choose

    u_j = min(8192, ceil(8192/(Ahat_j-sigma))),
    M_j = u_j-1,

and certify `8192/A_j <= u_j <= min(8192,8192/A_j+2)`. All divisions and ceilings are outward/verified operations. Their actual values are not in the saved metadata. The Gaussian tail inequalities use Wbar=1250000 and the already admitted selector; do not replace them with a cutoff chosen from a point approximation.

At each frequency form q_j=exp(-z_j) and use the contracted unit-disk recurrence

    g_1=q_j, h_1=q_j^3, d=q_j^2,
    g_(n+1)=g_n*h_n, h_(n+1)=h_n*d,

where every product has the proved unit-disk/error contract. The same g_n supplies both selected channels. Even nonunit n advances the sequence; skipping an accumulation is not permission to skip its recurrence. Either accumulate the odd residue buckets and apply the exact 2*4*500 character transform, or contract directly with these two explicit character rows. The latter is the recommended bounded-pair source producer. It computes the same two sums, with a full direct-contraction error bound, but its cost is not the shared full-family character-transform cost.

Apply each fixed prefactor, produce A_chi,0 real by the allowed real projection, and set A_chi,-j=conj(A_chi,j). All unused frequencies, including Nyquist, are exact zero. Perform the positive, unnormalized N-point time transform. Its exact output is the finite real polynomial U_chi on the original grid. Neither U nor its roots are substituted for the L-function in the count proof.

There are exactly68268 outer-frequency positions. The admitted Gaussian-term upper schedule for this row is

    ceil(8192*(1+40960/3)+68268) = 111924567.

Thus the conservative Gaussian unit-gate count is223849134. These are upper schedules, not observed term counts. Direct two-channel contraction adds its own weighted accumulation and phase work; it is not included in that unit-gate count. Source generation is substantial even for two output channels. It must be included in the first-admission measurement, with a separate already-checked-source timing if desired.

## Precision contract and one adaptive candidate

Keep the existing rigorous baseline source budget. Write

    B=3^11, M=B+1, Bpref=2*3^33, delta=2^-302,
    epref=epsilon/(64*44*(8192^2+2)),
    D=min(delta/16,1/1250000),
    sigma=min(1/4,D/(64*M^4),epref/(16*M^3),1/(16*8192)),
    dr=sigma/(4*B*68267),
    kappa0=min(dr/16,sigma/(16384*10000^2)).

The exact seed/gate condition is `delta+5delta <= epsilon/(32*44*Bpref*8192^4)`. Intrinsic outer exponential error is at most delta/16 before the prescribed contraction and argument-error composition. The phase/prefactor and cutoff proofs retain all their exact inequalities.

For the full character-transform baseline, the saved axis recurrence gives S=496582 and safety denominator112128001: the C500 axis uses a1024-point Bluestein convolution, while C2 and C4 are radix two. Its exact tolerances are

    u_char = min(1/112128001,1/(2*S),
                 epsilon/(128*44*Bpref*4000*S*(8192^2+2))),
    u_Gauss = min(1/112128001,1/(2*S),
                  sigma/(65536*4000*S)).

The proposed direct two-channel source must prove its own contraction radius; it may conservatively retain these tolerances but may not cite the FFT theorem as a proof of a different algorithm. Gauss sums may likewise use an explicitly bounded direct4000-term sum instead of the complete character transform. The term/root and accumulation errors must be summed, then propagated through the phase chart. Exact algebraic character definitions are distinct from their numerical root centers.

The baseline raw time gate is at most

    min(1/304, epsilon*(5/64)/(448*42*(2*1250000^2+2))).

The saved sufficient dyadic choice is2^-243. This covers its root and arithmetic contract, not only a final rounding. Full root/coefficient source error is separate. Additional element-level tolerance splits must sum to these budgets; no elementary function is a constant-cost oracle.

For an initial adaptive-radius comparison propose **one alternative time-gate tolerance 2^-160**, with the same already certified coefficient centers and source bounds, the same N and all actual time roots freshly enclosed to the required gate contract. This is an attempted sign producer, not a promise to meet the fixed baseline E_raw radius. Carry its larger time radius `N*42*2^-160*(2*1250000^2+2)` into the full raw sign radius from `PRECISION_RESEARCH.md`. Do not change source precision in this first test. This isolates a major runtime precision decision without claiming that ancillary precision has been solved. It is not a precision sweep; any subsequent candidate requires a separate decision based on the actual failed obligations.

For the coarse-only adaptive targets, a concrete sufficient radius with the retained source contract is

    R_adaptive = 3*epsilon/(4*(6/40960))
                 + 524288*42*2^-160*(2*1250000^2+2).

The first term transfers the complete pre-time physical error into raw U units; the second is the actual time-DFT error contract. This requires the full retained coefficient bound and all gate/root hypotheses. It contains no uncharged interpolation or output-scale operation. The baseline final comparison may use E_raw=109*epsilon*40960/704. The adaptive comparison uses R_adaptive, not E_raw. Centers change with gate precision; successful baseline signs do not transfer automatically. At any true zero the strict test fails regardless of precision. Keep the canonical sign, inconclusive, and any contradictory-result diagnostics separate.

## Target samples and count boundary

Both variants retain and bind all524288 outputs per channel. Test every requested main site l=0..84224, including the exact top6580. Report strict signs or inconclusive at all168450 selected-channel sites. In particular report l=0,1,42112,84224 separately; these correspond to heights0,5/64,3290,6580. Do not report only easy low-height signs while claiming full-height success.

This first packet uses coarse-grid targets only. It invokes no historical sinc interpolation or finite-polynomial off-grid theorem. An adaptive repair can later use the already specified finite polynomial or a separately proved direct L evaluator, with all extra samples/costs charged. Main-grid opposite signs yield only the appropriate disjoint critical-line lower evidence. Two channels do not establish the1600-channel conductor count; the e=0 row also supplies no automatically successful auxiliary Turing region. Any completion claim must add actual auxiliary endpoints, their source-domain extension, weights, canonical Gamma integral and the final strict count inequality.

## Data size and honest boundedness

For the **baseline** raw time array, p=243 and the saved magnitude exponent59 need at most303 signed bits per coordinate. A proposed fixed40-byte signed integer field gives320 bits, hence80 bytes per complex center. These are packed payload sizes, excluding headers, multiprecision object overhead, radii, proof terms and temporary products.

| Object | Cells | Packed center payload at80 bytes/cell |
|---|---:|---:|
| One nonnegative coefficient row |68268|5461440 bytes|
| Two coefficient rows |136536|10922880 bytes|
| One full time array |524288|41943040 bytes =40 MiB|
| Two full time arrays |1048576|83886080 bytes =80 MiB|
| All1600 full time arrays |838860800|67108864000 bytes =62.5 GiB|
| All1600 nonnegative coefficient rows |109228800|8738304000 bytes|

Four fixed-width interval endpoints rather than two center coordinates double these payloads. One radius shared by a justified group is a different representation with its own bound. A proposed512-bit-per-coordinate **source storage envelope** would use128 bytes per complex source center; this is a layout budget to validate, not a proved bound for every elementary temporary. At that layout the pair of coefficient rows needs17476608 bytes, and4000 character centers need512000 bytes. Multiprecision heap usage is larger. Do not infer whole-process memory from these tables.

Each full time transform has(524288/2)*19=4980736 ordinary radix-two butterflies. The pair has9961472; all1600 would have7969177600. This packet does not take an additional unproved half-transform reduction. In-place processing can keep one full time array plus two retained coefficient rows and indexed root data; baseline/adaptive runs can be sequential. An out-of-place or proof-producing implementation must declare its extra buffers. The two-channel block is not tiny, and the roughly112-million-term source upper schedule may be the larger first cost. If that is too large for the agreed cap, stop before execution rather than silently shrinking N or discarding high-frequency source dependencies.

A sound smaller first implementation stage is to construct and check the exact character/phase objects and one coefficient at a declared frequency, but that is only a prerequisite test. It is not this full-length pilot and cannot supply its arithmetic or precision forecast. A genuinely smaller whole-height algorithm would require a different proved tilted/centered block decomposition, including new alias tails; cutting this FFT into independent time intervals without such a theorem is unsound.

## What executable source exists

The local saved Platt `low_q_f1.3.cpp` implements the positive FFT and tail/output processing, but its first comment states that it **reads the output of split1.2**. It is not a complete coefficient producer. Its includes and input ABI are additional dependencies. The saved `low_q_low_upsam8.cpp` is downstream refinement, not a replacement source generator. No complete coefficient array or runnable certified nonprincipal theta producer for this exact row was found in the bounded files inspected here.

The campaign's `small_family_minimal_theta_20261111.py` and `build_sign_only_minimal_theta_schedule_20261111.py` are exact metadata generators. Running them does not generate G_chi, phase values or signs. The mathematical coefficient formula and unit-disk recurrence are explicit in the backend and shared-elementary reports; they provide an implementation specification for a new interval producer. Existing elementary arithmetic and actual-completion pilots can support parts of that implementation, but they do not already prove its family Fourier identity, full phase construction or output enclosure in HOL.

An attempt to read the pinned public low_q directory through the web tool returned a cache miss; no unseen upstream producer or archive is claimed. Before execution, locate and audit the actual historical coefficient producer or implement the small specification above, bind all dependencies and output schemas, prove its complete radius theorem, and agree source/array memory and execution caps. This is the precise missing implementation, not an assumed array in a timing harness.

## Evidence

The saved row and selector are planning metadata, not a numerical certificate. The following pins record the bounded read set. No broad minimum search, source-value evaluation or scheduled run occurred.

| File | SHA256 |
|---|---|
| work/qrh-campaign/agents/prime-estimates/sign_only_minimal_theta_nonprincipal_schedule_20261111.json | E767EC3B3E14F2A243837DA85C811DE5ED67CE701BDD08998C2329F9C687C24D |
| work/qrh-campaign/agents/prime-estimates/small_family_minimal_theta_20261111.json | 25E4BF80119B05A5C0FF25BDB7AECACEBC7495B5A00097B991E11C3DBF77D422 |
| work/qrh-campaign/agents/prime-estimates/small_family_minimal_theta_20261111.py | 0B0656A46461D397B9A459BEFEFC9686640FDCBC4EA5C6CD73E19BB2C3B1C5E0 |
| work/qrh-campaign/agents/prime-estimates/build_sign_only_minimal_theta_schedule_20261111.py | 88225615982B611EBFED86E00EC98CA6A1DEB07AFCCB40CDFC8B9FCE9A7F24B5 |
| work/qrh-campaign/agents/prime-estimates/WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md | 74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE |
| work/qrh-campaign/agents/prime-estimates/NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md | 6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043 |
| work/qrh-campaign/agents/integration/SMALL_CONDUCTOR_SHARED_ELEMENTARY_CIRCUIT_2026-11-11.md | A8AC4A3B594C8671476FCC92C67A45DCF42EFF0060F522023F929BA440835A4B |
| work/qrh-campaign/agents/zero-sum/FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md | 5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41 |
| work/qrh-campaign/agents/moebius/platt-reuse-sources/low_q_f1.3.cpp | 20C88BB0F2F2D0CA43617428E8AA550DA4126F026F0F4A34AF60F92CD2305E47 |
| work/backend-costs-20261112/hol-platt/PRECISION_RESEARCH.md | 957B4878CD16FD7EBC7F5DE235A4FBB707F3CD92C2753E58C50AC8E1584540A8 |
