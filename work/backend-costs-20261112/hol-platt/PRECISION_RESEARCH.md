# Small-family precision: cause and a bounded next change

13 November 2026. Read-only source and paper audit, except this report. No builds, numerical L-values, roots, transforms, new inventories, or timing experiments were run. The frozen forecast is unchanged. The proposed successor below is not an implemented or accepted spectral certificate.

## Finding

The selected small-family design does **not** establish that finite RH needs 241–343 fractional bits, or that its Gauss setup needs 534. Those are sufficient tolerances for a particular global absolute-error allocation. They descend from an old requirement to approximate every normalized Hardy value Y to absolute error 2^-80, combined with a tilted whole-height Fourier transform and several deliberately loose, uniform bounds. The later sign-only export removes output scaling operations but explicitly retains that allocation.

The closest useful next change is to implement a complete-radius, adaptive **sign** interface for the small-family evaluator. Retain the actual completed-L normalization, canonical phase, analytic tails and count gate; accept an endpoint when its computed center is separated from its own proved radius. Do not demand the inherited Y-at-2^-80 radius at every endpoint. This can lower computational precision where actual sign margins allow it. Its success distribution is unknown, and the existing whole-height tilt creates a real cancellation obstacle: merely replacing fixed-point arithmetic with double intervals does not prove that 53 significand bits suffice.

## 1. What the forecast actually prices

`forecast-audit-20261113/WIDTH_RESOLVED_LEDGER.md`, section “Small family,” inherits the selected minimal-theta sign-only schedule, not a completed evaluation. Its fractional-bit ranges are:

| Role | Fractional bits | Source of the tolerance |
|---|---:|---|
| Time FFT | 241–343 | Old coarse time budget plus three bits for raw-polynomial interpolation |
| Main character transform | 279–411 | Coefficient budget, global prefactor, residue count and circuit error constant |
| Gaussian seed/unit gates | 302–404 | Coefficient budget and n0^4 error accumulation |
| Shared elementary tolerance sigma | 382–484 | Seed/prefactor budget divided by powers of a global radial bound |
| Radial seed | 417–523 | Sigma divided by radial growth and the full number of recurrence steps |
| Fixed setup leaves | 422–527 | Radial seed and conductor/phase conditioning |
| Gauss transform | 402–534 | Sigma inherited through phase construction, then its own transform bound |

These are fractional bits of an absolute dyadic grid. They are not IEEE significand bits or complete signed operand widths. For example the retained raw time samples add magnitude exponents 54–69; the ledger's conservative maximum signed capacity is 343+69+1=413 bits. Products and rounding witnesses are wider again. Conversely a floating interval with a 53-bit significand can represent a tiny number using its exponent; it does not provide 343 significant bits of that number.

The frozen `end_to_end_model.py:30–57` uses assumed transfers from a measured 343-bit dependent butterfly for these distinct roles, with separate elementary/setup rows. It does not experimentally derive their necessary precision. Changing a tolerance formula is therefore not a measured reduction of the model's hours, nor a license to rescale all those rows by a bit ratio.

## 2. The mathematical chain generating the bits

Let V include all requested heights, theta be the selected integer in [64,128], and

    b = pi/4 - theta/V,
    Y(t) = exp(theta*t/V) F_b(t),
    epsilon = 2^-80 / (4*3^theta).

These are the actual source normalization and allocation in `NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST`, sections 1–2. The positive output scale is bounded by 3^theta. Hence an error measured in F_b is made very small before it is amplified back to a uniformly accurate Y. The 80 bits are an accuracy choice, not a zero-count theorem. The factor 3^theta costs roughly 102–203 further bits, and the factor four costs two. Using a sharp bound for exp(theta) would remove only roughly 9–18 of those bits; it would not resolve the main mismatch.

There is also a real conditioning issue. At t=V the exact identity is F_b(V)=exp(-theta)Y(V). The Fourier coefficient sum may involve quantities much larger than this result. A global scalar rescaling multiplies both the result and its absolute error; it does not remove cancellation. No lower bound on |Y(V)| or on every selected sign margin is available. Thus neither 2^-80 nor the full 3^theta overestimate is necessary for an individual sign, but deleting them does not make all signs easy.

The selected parameters keep X=10, C=44, n0=8192, B=3^11, M=B+1, and Bpref=2*3^33. The precise sufficient allocations are:

    delta = 2^-p_seed,
    6 delta <= epsilon / (32 C Bpref n0^4),
    epref = epsilon / (64 C (n0^2+2)),
    D = min(delta/16, 1/Wbar),
    sigma = min(1/4, D/(64 M^4), epref/(16 M^3), 1/(16 n0)),
    dr = sigma/(4 B max(1,J)),
    kappa0 = min(dr/16, sigma/(16384 c^2)).

The first expression is a genuine stability bound for the chosen Gaussian recurrence: seed error is multiplied by n^2, and the odd-character weighted sum is bounded by n0^4. It uses the worst retained cutoff for every frequency. The global Bpref bounds the Fourier prefactor over the entire retained interval; it discards frequency-specific size information. Since n0^4=2^52 and Bpref itself costs about 53 bits, these choices account for much of the approximately 118 bits between epsilon and the seed tolerance. They are not a new analytic uncertainty about where zeros lie.

The next approximately 80 bits come from the shared radial construction. It computes A_j=exp(x_j/2), then powers up to A_j^4, with a uniform absolute error. The proof bounds argument propagation by 15 M^4 sigma. The dr denominator then pays for a recurrence extending through all J frequencies. The setup and Gauss phase tolerances inherit these small budgets even where the phase itself has only unit magnitude:

    eta = sigma/256,
    u_G <= min(1/max D_axis, 1/(2 S), eta/(256 phi(c) S)).

This is why the ancillary maximum can exceed the runtime time-FFT precision. It is a sufficient common contract, not a measured need for 534 significant bits in every phase. A new direct/local phase or radial construction would need a new complete bound before these inherited constraints could be relaxed.

For the time transform, with k=log2 N,

    u_time <= min(1/(2k), epsilon*Delta /
                  (56*(2k+4)*(2 Wbar^2+2))),   Delta=5/64.

The sign-only interpolation successor uses u_time/8. Wbar is the conductor-parity upper bound 40000000/theta or 80000000/theta. This explains the remaining time bits: the absolute epsilon target is divided by a global coefficient magnitude and a circuit constant. The original factor N cancels against omega=2pi/(N Delta) in the scaled bound; it is incorrect to add a second log2 N loss here. The raw-sign formula changes the error units consistently and adds three bits, not a new N-sized penalty.

The script `small_family_minimal_theta_20261111.py:58,67,94–97` contains these exact rational constructions. It searches theta only within 64..128 while retaining the theta128 transform length. This already removed some needless tilt precision, but it did not optimize the sign margin, the error allocation, or smaller tilts with different lengths.

## 3. Why deleting output scaling did not solve this

`SIGN_ONLY_MINIMAL_THETA_NONPRINCIPAL_SCHEDULE`, sections 1 and 3, explicitly retains epsilon=2^-80/(4*3^theta). Its source/seed/sigma/radial/setup/character/Gauss fields are unchanged, and time changes from 238–340 to 241–343 bits. That successor removed omega output multiplication, positive Y-scale recurrence, and final Y multiplication. It did not reallocate their inherited accuracy goal.

The separate selected-consumer audit establishes a narrower and useful fact: strict endpoint signs, sign brackets, auxiliary weights and the selected Turing upper-count test do not require numerical Y amplitudes from this array. Off-grid processing still needs actual raw polynomial centers and radii, not just coarse sign bits. Canonical Gamma/argument arithmetic, central multiplicity if claimed, and any derivative/contour repairs remain distinct obligations. General complex zeros cannot be inserted into the critical-only lower count K.

The accepted half-time Hermitian transform and polyphase variants can reduce work, but do not by themselves remove the amplitude-derived epsilon or the shared radial/phase conditioning. Root reuse can reduce generation and often increases the required seed accuracy through error accumulation. No such option should receive a second precision discount here.

## 4. What Platt's evidence does and does not say

The saved primary manuscript `platt_turing_1305_3087.txt:192–213` describes interval arithmetic with MPFI above the 53 bits of IEEE double, and a custom double interval implementation with correctly rounded elementary functions otherwise. It does not claim that all work used doubles. Lines 443–448 explicitly distinguish a once-per-height high-precision Hurwitz lattice from many double-interval evaluations. That is the large-q method, not direct evidence that every small-q setup used only doubles.

For small q, lines 481–503 define the tilted Fourier functions and say eta controls Gamma decay. The inspected historical source `low_q_f1.3.cpp:500–503` reads eta from input, rather than establishing that every historical run used our theta64..128 choice. Its lines 562–609 add a computed tail enclosure and apply the positive scale. These saved files are algorithm evidence, not the full historical parameter or error transcript.

The manuscript's results, lines 918–942, describe regular upsampling followed by exceptional Euler–Maclaurin work, sometimes at 100-bit MPFI precision, and adjustments of Turing regions. Lines 964–968 describe further central-point repairs. These are observed successes of that historical computation. They are not a proof of an a priori 53-bit sign margin, and their exceptional percentage cannot be transferred to the current target/circuit. The paper gives no requirement to return every Y value at absolute error 2^-80. Matching its workload therefore calls for checked adaptive intervals and count closure, not imposing our uniform accuracy contract and then calling the resulting width inevitable.

## 5. One concrete successor: carry a complete radius to the sign gate

Implement a radius-parametric small-family certificate, initially on one already selected conductor/target block. Keep its existing theta, N, frequency cutoffs, source normalization and exact phase. This avoids changing the analytic algorithm while testing the most direct unnecessary constraint. Keep the existing fine analytic-tail bounds initially; relax finite arithmetic only when its new error is explicitly included.

Let A_j be the actual stored phase-normalized coefficient centers, with the required real/Hermitian symmetry. Let r_j bound each coefficient's error against the exact truncated Fourier coefficient. Bound omega by L=6/P and H=44/(7P). Define

    U_A(t) = A_0 + 2 Re sum_(j=1)^J A_j exp(i*j*omega*t),
    R_pre = R_time_alias + R_frequency_tail + R_Gaussian_tail
            + H * sum_(j=-J)^J r_j.

All terms must be proved in the same physical F_b units. Include phase/prefactor error in r_j; do not assume exact phase centers. The source Fourier identity and triangle inequality then give

    |F_b(t)/omega - U_A(t)| <= R_pre/L.

For an off-grid center z obtained from the finite-polynomial interpolant, certify

    |U_A(t)-z| <= R_interpolation + Lambda*R_samples + R_arithmetic,
    R_total = R_pre/L + R_interpolation + Lambda*R_samples + R_arithmetic.

Lambda is the proved sum of absolute interpolation weights. The retained fixed stencil has Lambda<4; a different stencil must supply its own proof. R_interpolation concerns the exact finite polynomial built from these stored A_j, not the exact L-function. Its derivative bound must use a proved coefficient-center bound. A coarse target can omit the interpolation terms. Every raw time sample has its own full DFT error, including twiddles, arithmetic and the chosen center bound. For example the already proved uniform bound is N*(2k+4)*u*(B+1), under its safety conditions. If the relaxed coefficient errors invalidate B=2Wbar^2+1, certify a new B or reject the attempted precision.

Accept only z>R_total or z<-R_total. These comparisons give exactly the canonical sign because omega and the Y rescaling are positive. The abstract sign-to-bracket/count proof is unchanged. This is a proposed radius-parametric replacement for the fixed E_raw contract, not a claim that a coarse center satisfies that old contract. Complete recorded radii, source identities and all strict tests remain kernel obligations.

Try a modest precision first, then refine failed blocks or individual targets with a separately admitted direct evaluator. No starting precision or repair rate is certified here. Retain failed attempts and charge their source, cache, transpose and output work. Never reuse old signs for changed centers merely because a new requested precision is smaller. A reused cache needs the same exact object and a sufficient enclosure; a refinement can reuse previous proved facts without treating old centers as exact. Fixed analytic tails give a floor on this attempt's radius, so arbitrarily increasing arithmetic precision alone is not a termination argument.

The first implementation deliverable is the theorem above and a complete one-block evaluator returning centers with R_total, plus exact comparison and failed-case records. The existing actual chi4 sign pilot supplies a useful normalization/realness example; it does not supply the generic small-family Fourier/interval theorem or its throughput. A HOL implementation must prove the numerical operations and analytic source connection in HOL; a Lean paper or checked Lean example is not a free imported HOL theorem.

## 6. Remaining obstacle to a double-like whole-family implementation

Adaptive acceptance removes the unnecessary requirement to achieve 80 accurate absolute Y bits everywhere. It does not erase cancellation of the small F_b values inside a long global Fourier sum. At the selected endpoint, the condition-number contribution from the exact exp(-theta) factor can itself cost roughly 92–185 bits relative to a Y of order one, before coefficient scales. This is a conditioning illustration, not an assumed size or lower bound for actual Y. Simply changing error units, multiplying the final output, or using 53-bit floats with wide exponents cannot repair lost significant information.

If representative blocks show that this dominates, the next mathematical choice is a smaller tilt or a locally centered/blocked evaluator. A smaller theta reduces attenuation and can lower precision, but the current sufficient time-period condition P>=2VK/theta then increases transform length. K must also be rederived for the new permitted radius. A centered-height algorithm needs a genuine new coefficient/tail identity and source production plan; translating the old polynomial after it has already suffered cancellation is insufficient. Neither tradeoff was resolved by the fixed-N theta64..128 selector. No length/precision winner or time ratio follows without the matched source, arithmetic, memory and repair costs.

There are also worthwhile local improvements to the existing sufficient bounds: frequency-dependent cutoffs and prefactors instead of n0^4/Bpref everywhere; independently initialized radial blocks instead of charging one seed over J updates; and phase tolerances tied to their actual coefficient effect rather than inherited from the smallest radial sigma. They require new error/producer proofs and can add setup work. They are not substitutes for the sign-radius change, and this audit assigns them no savings.

The precision problem is therefore not exhausted. The immediate defensible experiment is a complete adaptive-radius sign block, followed only if needed by a smaller-tilt or centered-block design. Until it succeeds with measured full source/acceptance work and certified repairs, keep the current forecast widths and its uncertainty. No claim of Platt-like hours is justified by this report.

## Source pins

The following files were read directly. Hashes bind the inspected bytes; they do not turn paper contracts or historical numerical results into formal theorems.

| File | SHA256 |
|---|---|
| work/backend-costs-20261112/forecast-audit-20261113/WIDTH_RESOLVED_LEDGER.md | B15214CA3EF1668B5D10CB3ACC6864A5C16F5F9A7448869F55438069917A11C8 |
| work/backend-costs-20261112/forecast-audit-20261113/END_TO_END_MODEL.md | 37D11CA50EFD9259021C2B6422C662D476FE683C6C5E1AA3B97C19288AEDE3FA |
| work/backend-costs-20261112/forecast-audit-20261113/end_to_end_model.py | 4E35DBD5C8162B1989F54610431B5311AB9CF5AA403CEAF42E9F7C7A77E2D028 |
| work/qrh-campaign/agents/prime-estimates/NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md | 6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043 |
| work/qrh-campaign/agents/integration/SMALL_CONDUCTOR_SHARED_ELEMENTARY_CIRCUIT_2026-11-11.md | A8AC4A3B594C8671476FCC92C67A45DCF42EFF0060F522023F929BA440835A4B |
| work/qrh-campaign/agents/prime-estimates/MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md | 73337A5EB2688E5B1A5196A901232A314D89F3E48B5EEFC013CA178A8FFA238A |
| work/qrh-campaign/agents/prime-estimates/small_family_minimal_theta_20261111.py | 0B0656A46461D397B9A459BEFEFC9686640FDCBC4EA5C6CD73E19BB2C3B1C5E0 |
| work/qrh-campaign/agents/prime-estimates/SIGN_ONLY_MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md | C1D2C360A296C961BD2FA46576521FEDB1AFE01527610DF1D21CC145E5565918 |
| work/qrh-campaign/agents/audit/SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md | 076030481DEB4A922356A5BC0B8CCB243DF3FBB15A0DD427A29DEB044E82D430 |
| work/qrh-campaign/agents/moebius/SMALL_THETA_SELECTED_CONSUMER_AUDIT_2026-11-11.md | CA2006BBC18394CC20D74AED5A1F24D8432AA2A1D2CEA22B3AEDBAB284A6EA51 |
| work/qrh-campaign/agents/audit/LARGE_BRANCH_PRECISION_REPAIR_POLICY_2026-11-11.md | CEE051ACA50EBFF46E422E104B4978603FFD7CA427672B30FF8AC1529841D567 |
| work/qrh-campaign/agents/audit/platt_turing_1305_3087.txt | 2A2EABBCA321E6B29BC3E0BAE4339245C819B5234C0C4CC222C65E981E84E3E9 |
| work/qrh-campaign/agents/moebius/platt-reuse-sources/low_q_f1.3.cpp | 20C88BB0F2F2D0CA43617428E8AA550DA4126F026F0F4A34AF60F92CD2305E47 |
