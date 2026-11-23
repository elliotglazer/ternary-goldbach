# Adaptive entry for the selected small-family block

13 November 2026. Mathematical and implementation proposal only. No new numerical evaluation, inventory, benchmark or worker edit. No forecast saving is credited.

The next experiment should retain the complete selected conductor-10000 geometry and fine source, then replace the fixed output-accuracy requirement by a proved radius and a strict sign test. Start with the two already bound inverse characters and their full N-point transforms. This tests the actual time algorithm, not a small substitute transform. A complete conductor calculation must subsequently cover all 1600 primitive characters; two channels cannot establish its finite RH statement.

## Fixed input contract

Use the parameters and actual character descriptors in `SMALL_FAMILY_PILOT.md`: conductor 10000, odd characters with Conrey labels 1877 and 2813 after exact binding, theta 64, V=6580, Delta=5/64, N=524288, P=40960, omega=2*pi/P, J=68267, n0=8192, X=10 and Wbar=1250000. Keep the complete main grid l=0,...,84224. The two positive-height channels remain distinct. The full conductor has 800 odd and 800 even primitive channels.

Before either transform is accepted, its input artifact must bind all 68268 nonnegative coefficient centers per channel to the actual source, including the fixed canonical phase. It must prove real A0, A(-j)=conj(Aj), and exact zeros at unused frequencies. Retain the original frequency truncation, periodization and Gaussian-tail bounds, the unit-disk Gaussian recurrence, its delta=2^-302 budget for this row, the fine bucket and character-contraction budgets, and the original radial, prefactor and Gauss-phase tolerances. In particular, the available direct L margin values do not generate or certify this coefficient artifact.

Write B=2*Wbar^2+1, eps=2^-80/(4*3^64), L0=6/P and H0=44/(7P). The retained source contract supplies

    U_A(t) = A0 + 2 Re sum_(j=1)^J Aj exp(i*j*omega*t),
    |F_b(t)-omega*U_A(t)| < 3*eps/4,
    max_j |Aj| <= B,       0<=t<=V,
    0<L0<omega<H0.

These are actual function/array identities and error bounds, not assumptions justified by a successful FFT. A source producer must provide their numerical premises. The paper Fourier/analytic connection remains a separate formalization obligation.

## Exactly what becomes coarser

Take u=2^-160 for each approximate time root's complex error and for each rounded time-FFT complex addition or product. Keep the positive, unnormalized radix-two DFT and its original permutations and N. The generic theorem requires 2*19*u<=1 and yields

    E_time(u) = N*42*u*(B+1),
    R_coarse(u) = 3*eps/(4*L0) + E_time(u).

The existing root/gate theorem treats root error and arithmetic rounding separately. An implementation must meet both; setting a floating library to 160 significant bits does not do so. Coordinate nearest rounding on an absolute grid 2^-160 has complex norm error below u. Root computation needs its own certified enclosure plus final rounding allocation. Exact quarter turns, signs and permutations may stay exact.

For the primary experiment, **do not quantize the input coefficient artifact again**. Use its exact stored dyadic centers in the first radix-two stage. A bit-reversed DIT schedule has only unit twiddles in that stage: perform the fine-grid sums/differences exactly, then round the outputs to the new time grid. Subsequent stages use the coarse grid, with exact intermediate products followed by certified rounding. This satisfies the same theorem with the original exact input A and retains the previously screened R_coarse. The first-stage fine additions, alignment and conversion costs must be measured. They are not low-width operations merely because their outputs are coarse.

Magnitude capacity remains separate from fractional precision. Track the proved recurrence M_(j+1)=(2+u)M_j+2u from M0=B for all stages and raw products, or use a separately justified tighter bound. Do not assign the saved final-sample exponent to every intermediate without its proof. Root operands, exact product numerators and division/rounding witnesses have their own widths. The 512-bit native reference precision used for the eight-point screen is unrelated to these fixed-grid capacities.

An optional all-input-coarse implementation would require a different radius. If its input error is e_in<=u per complex coefficient, the stored input bound becomes B+u, and a safe radius is

    R_regrid = 3*eps/(4*L0) + N*u + N*42*u*(B+u+1).

The N*u term is the unnormalized DFT's input-error charge. Omitting it silently changes the exact polynomial. This variant is not the primary experiment, and the eight saved tests of R_coarse are not automatically tests of R_regrid. No new comparison of the saved points against this variant was performed here.

The lower width applies to the time roots and time-butterfly arithmetic after the first input-consuming stage, and to an explicitly designed time-output representation. It does not apply to Gaussian generation, bucket sums, character FFT/Bluestein kernels, radial recurrences, root-number phases or their fine prefactors. The two omitted final output scalings remain omitted; they cannot be credited again.

## Output, strict decisions and count boundary

Bind every output slot of each full N-point transform to its channel, input-artifact digest, exact grid index, time-root identity, arithmetic policy and proved radius. Export real projections of the computed centers, with the imaginary residual available as a diagnostic. The polynomial is exactly real by its Hermitian construction; a small observed imaginary residual is not a proof of that identity.

At each of the 168450 requested pair/channel sites accept positive only if z>R_coarse, negative only if z<-R_coarse, and otherwise record inconclusive. Use exact directed comparisons. A count of successful points alone is not an acceptable output: retain the per-index verdicts and all unresolved indices. The completed native screen supplies eight actual margin comparisons at t=0,5/64,3290,6580 for these channels. It does not imply any of the other verdicts, an expected repair percentage, or success for even characters.

For off-grid targets, the accepted 340-node finite-polynomial interpolation proof can still be used with its complete error budget. Its weight norm is less than 4, so a sufficient new radius is

    R_off = 3*eps/(4*L0) + E_interp + 4*E_time(u) + E_arithmetic.

The old proved polynomial remainder E_interp may be retained because A and the frequency support did not change. E_arithmetic must be proved for the actual new kernel/product/sum representation; it cannot be copied from a different width implementation without checking its operands. Retain the same coefficient identity and periodic wrapping of U_A only. F_b and Y are not periodic. An inconclusive coarse endpoint does not license accepting an interpolated point with the coarse radius.

Strict opposite endpoint signs give critical-line brackets only through the actual function's continuity. Use ordered disjoint brackets, the exact inverse-character transport and true multiplicity conventions. A complete finite-RH attempt still needs its admitted auxiliary domain, separately certified canonical Turing integral/allowance, auxiliary weights and strict surplus U_count<K+2. The e=0 main block does not itself provide that auxiliary coverage. Default central lower contribution remains zero; central multiplicity, general complex contours and any stronger requested count data retain separate proofs. A general complex cluster is not automatically part of critical-only K.

## Fallback and reusable work

The first comparison should be one u=2^-160 full pair attempt and one matched u=2^-243 baseline on the **same fine coefficient centers**. Run them sequentially under an agreed cap. Record setup, first-stage conversions, remaining FFT, output comparisons and unresolved sets separately. Do not choose a new precision from the observed answers inside the same fixed experiment.

For a later repair policy, these reuse rules are exact:

* Fine source coefficients, their phase and analytic certificates can serve both attempts unchanged. Their discovery/generation and first proof costs count once in a shared-source comparison and in full in a cold end-to-end comparison.
* A finer root enclosure may be reused at a coarser tolerance after checking the exact root/index identity and enclosure. A coarse root enclosure is not a finer one. Building and storing a fine root table up front is a setup cost, not a free future fallback.
* Coarse rounded butterfly states cannot be promoted to high-precision states by appending zero bits. A fine FFT must recompute the required ancestor operations from the fine input or already available exact/fine states. A full fallback costs another transform; target-only evaluation needs its own dependency/operation count and radius.
* Previously proved signs of the actual function remain valid facts at those same character/phase/height identities. The coarse numerical centers are not fine-precision values, and changed endpoints need fresh sign proofs.
* A direct L repair may reuse exact character/group metadata, but must provide the actual normalization and phase binding for signs. The current eight-point phase-free modulus screen alone supplies neither a sign value nor a reusable Fourier coefficient. Native direct L costs are separate, especially its per-call Hurwitz precomputation.
* If fixed analytic/source tails dominate an inconclusive radius, increasing only time precision is insufficient. New coefficient/source accuracy, cutoffs, endpoints or a separately admitted evaluator may be needed. There is no termination or zero-free-margin guarantee.

## What to measure, including the source floor

The next full-N pair has 9961472 radix-two butterflies. The whole 1600-channel conductor would have 7969177600 before any separately proved pruning or half-transform optimization. Source generation for the pair still has the existing upper schedule of 111924567 Gaussian terms and 223849134 unit gates, plus two-channel contraction and phase/prefactor work. These upper counts are not observed term counts. Direct pair contraction is a bounded implementation choice, not the shared full-conductor character-FFT cost model.

Required measurement categories are cold fine-source construction and validation; character/phase setup; actual cutoff and Gaussian term counts; fine coefficient storage and reload; separate time-root generation at each accuracy; first-stage fine input handling; remaining time FFT; exact radius/sign comparisons; any interpolation; failed work and repairs; peak memory and exported bytes. Record native generation versus ordinary-rule checking separately if both are implemented. The first full transform cannot be priced from the direct L reference timings.

The high-precision source can plausibly dominate the pair experiment: its Gaussian upper schedule alone is much larger than the pair's time-butterfly count and uses finer arithmetic. That is a risk, not a measured dominance claim. For the whole selected small family, the saved main ledger has 128941391789290 character butterflies versus 89858217607168 time butterflies, as well as 25399177848072 character point products and the Gaussian/elementary work. Those source categories remain at their fine widths. Hence reducing time precision cannot proportionally reduce the whole family cost.

Write a measured cold total as S+T+R, with S the unchanged source/setup cost, T the time-transform cost and R the output/repair cost. The adaptive total is S+T160+R160, plus any failed-attempt or finer-fallback work. Even an impossible free time transform could save at most T/(S+T+R) before changed repair costs. No empirical value for that fraction is available from the eight points. If S dominates, this time-only change will save little end-to-end and the next useful mathematics would have to improve the source error allocation or producer, with a new full proof. Do not lower those source tolerances on the strength of time-margin observations.

## Evidence and status

This proposal consumes the following existing artifacts without changing them: `SMALL_FAMILY_PILOT.md` (2F1C199C...), `PRECISION_RESEARCH.md` (957B4878...), `NATIVE_SIGN_EXPERIMENT.md` (52B4442E...), `native-sign-screen/POST_EXIT_REVIEW.md` (A34FDC1A...), the raw-polynomial sign interface (07603048...), selected-consumer audit (CA2006BB...), mixed-radix precision supplement, and `forecast-audit-20261113/WIDTH_RESOLVED_LEDGER.md` (B15214CA...). The native screen's eight saved comparisons are usable with the terminal-supervisor qualification in its post-exit review; its original overall receipt remains failed.

The immediate missing implementation is a certified fine coefficient producer for these two actual channels and an absolute-error-controlled full-N FFT over that artifact. Existing metadata and direct native L calls do not supply those objects. No new experiment is authorized by this paper. No whole-family success probability, repair rate, completed HOL theorem or forecast-hour reduction is asserted.
