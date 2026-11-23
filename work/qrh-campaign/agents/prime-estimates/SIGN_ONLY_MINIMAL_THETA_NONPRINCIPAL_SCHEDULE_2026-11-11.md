# Conditional sign-only successor to the minimal-theta schedule

2026-11-11. Saved-metadata and exact rational join only. No function values, FFTs, primes, zeros, builds or source declarations were evaluated. The original coarse-value JSON and all frozen dependencies remain unchanged.

This candidate changes the **small nonprincipal branch's export contract** from numerical Y amplitudes to certified canonical signs through the raw polynomial U and its exact error threshold. It does not fulfill the old Y-at-tau contract after deleting its scalings. The large branch, principal requirements, selected conductors/heights, seed bands and all unrelated work are unchanged. Adoption remains conditional on the stated consumer restriction and actual arithmetic/sign certificates; root's independent join review is separate.

The supporting mathematical interface is the raw-U report and its independent review. The separately pinned consumer audit identifies no mandatory Y-amplitude export in the selected small sign/Turing path, but explicitly retains non-sign repairs and canonical count arithmetic. This proposal consumes that bounded inventory rather than claiming every possible consumer is sign-only.

## 1. Exact successor output

For one actual primitive nonprincipal character, retain its fixed root phase, conductor/parity label, selected theta, coefficient centers A_j, conjugate negative coefficients and real A_0. With Delta=5/64, P=N Delta, omega=2pi/P and J=ceil(25N/192), define

`U(t)=A_0+2 Re sum_(j=1)^J A_j exp(i*j*omega*t)`.

The positive unnormalized time DFT gives U at coarse grid nodes. A normalized implementation instead gives U/N and must change the error units explicitly; this candidate assumes the former. The accepted target comparison is

`|F_b(t)-omega U(t)|<3epsilon/4`, for 0<=t<=V,

where epsilon=2^-80/(4*3^theta) and b=pi/4-theta/V. The exact positive identities relate F_b, Y and the fixed canonical Hardy normalization. They do not identify zeros of U with actual L-zeros.

Let L=6/P and H=44/(7P), so 0<L<omega<H. With the raw interpolation/sample allocations from the pinned proof, a real center z has sufficient rational radius

`E_raw=3epsilon/(4L)+3epsilon/(16H)=109*epsilon*P/704`.

The record accepts a sign only if z>E_raw or z<-E_raw. A rounded dyadic radius is allowed only after proving it is at least this exact radius. The comparison must bind the actual center, row parameters, target, character and phase. A failure of either strict test is inconclusive. The rational row checks in this packet prove no such strict sign.

The same radius is conservative for coarse targets. Noncoarse targets require the proved interpolation arithmetic and actual raw samples, not merely a list of coarse sign bits. The candidate retains the fixed340 raw interpolation contract as an unpriced downstream obligation; variable-order and polyphase proposals are not imported as free work or savings.

The time gate/root tolerance is the selected coarse tolerance divided by eight. The source DFT error is then below epsilon/(64H), including its roots and internal rounding. This is **three extra fractional bits relative to the coarse schedule**, not a deduction from an already priced four-bit interpolation schedule. Final omega multiplication is absent, but omega still determines the exact frequency grid, coefficients and transform phases.

## 2. Exact deletions and retained work

The only changed numerical count fields in each small-branch total and its two conductor-cohort subtotals are:

* `omega_complex_scalings`: Q to zero, for the old exported coarse prefix only.
* `final_Y_real_products`: Q to zero.
* `positive_scale_real_updates`: the shared positive-Y recurrence count to zero.
* `real_exp_seed_certificates`: 2C to C, removing C positive-output-scale seeds and retaining C radial seeds.

Here Q is the requested primitive coarse-grid output count and C=7499 is the active small-conductor count. Every other count field is checked equal to its predecessor. The transformed counts are checked to equal the sum of their odd/even conductor subtotals. “Cohort” here means conductor parity, not character parity.

| Extra coarse nodes | Removed omega scalings | Removed Y products | Removed positive-scale updates | Removed positive-scale exp seeds |
|---:|---:|---:|---:|---:|
|0|1,775,431,871,117|1,775,431,871,117|3,791,938,303|7,499|
|167|1,778,517,548,153|1,778,517,548,153|3,793,190,636|7,499|
|320|1,781,344,545,677|1,781,344,545,677|3,794,337,983|7,499|
|640|1,787,257,220,237|1,787,257,220,237|3,796,737,663|7,499|

The main raw time-output count remains **9,237,783,904,256**. The other scenarios retain 9,247,225,020,416; 9,257,887,727,616; and 9,278,818,353,152. These arrays, or a proved retained/recomputed dependency subset, still support interpolation. Deleting prefix output scaling does not delete raw FFT outputs, their proof, or the full time transforms.

In particular the main small branch still has 89,858,217,607,168 time butterflies, 128,941,391,789,290 character butterflies, 8,542,028,172,242 Gaussian unit gates and 7,969,016,316,193 rounded bucket additions. All radial exponentials, Gaussian exponentials, coefficient prefactors, conductor roots, Gauss/root-phase transforms and undo phases remain. Shared kernel and root setup is not reduced by this join.

The four seed scenarios, five large seed bands, m159 final construction, large arithmetic/setup objects and original required-unpriced list are copied exactly. Setup aliases for initial B, step-cis and step-grid calls remain aliases; they are not added again. The full requested-site cardinalities also remain unchanged. In the main scenario 38,066,330,390,620 is now mixed bookkeeping for unchanged large outputs and small requested sign sites, not a homogeneous amplitude-output count and not a count of proved signs.

The old prefix ledger never included rescaling every full-array sample or every future off-grid query. Avoiding those hypothetical additions is not a second subtraction. The removed Q entries cannot also be removed through a full-N count. Any off-grid positive-scale work that would otherwise have been newly introduced is simply absent from this sign-only contract, not credited as an additional coarse-ledger saving.

## 3. Precision and representation map

The JSON gives an explicit disposition for every old local fractional-bit range:

| Old field | Successor treatment |
|---|---|
|`seed`|Unchanged Gaussian seed requirement.|
|`sigma`|Unchanged shared elementary error contract.|
|`radial`|Unchanged radial seed/recurrence requirement.|
|`setup`|Unchanged root/phase setup requirement.|
|`character`|Unchanged character-transform requirement.|
|`gauss`|Unchanged Gauss/root-number-transform requirement.|
|`time`|Replaced by `time_raw_sign`, tolerance divided by8 and sufficient bits increased by3.|
|`scale`|Inapplicable **only** as the old final positive-Y scale recurrence `ds`. It is not a coefficient-prefactor, radial, phase or frequency tolerance.|

Thus each scenario's time range changes from 238--340 to **241--343 fractional bits**. No other listed range is relaxed. All coefficient/prefactor rounding and rounded bucket allocations are retained. There is no final output omega or Y rounding in this new API; omega approximations used elsewhere in the source or roots still need their original proofs.

Every selected row reconstructs m_grid and N from the frozen height and selector rules. It verifies the source raw DFT error bound, epsilon/(64H)<1, H<1, the exact radius identity and H*E_raw=(109/112)epsilon<epsilon. It also checks that the raw time precision is exactly the coarse sufficient dyadic precision plus three.

The raw sample magnitude bound is C_U+1 with C_U=(2J+1)(2Wbar^2+1). The computed sufficient exponents w with C_U+1<=2^w range from 54 to69. These are magnitude exponents, not fractional precision or complete signed/product widths. Raw operands can be larger than scaled-T operands; any implementation must price their actual integer parts, product temporaries, comparisons and rounding proofs. No checker throughput or proof-byte saving follows from removing operations while tightening other gates.

The receipt binds each conductor to its theta and gives compact row metadata `[c,m_grid,N,time_bits,w]`. Exact threshold multipliers `(109/704)P` are shared by N and multiplied by that row's exact epsilon. These metadata do not include z and therefore cannot masquerade as a strict-sign certificate. The coefficient array, wrapped sample lookup and exact target remain separate bindings.

## 4. Consumers, exceptions and required unpriced work

The pinned consumer audit supports strict endpoint signs, sign-change intervals, the critical-line-only lower count K, and weighted auxiliary intervals. The canonical integrated Turing quantities Abar and b are separately certified; they are not computed from amplitudes of the small Y array and cannot be replaced by an argument of U. The strict final surplus test, closed carriers, multiplicities and both positive channels for a nonreal pair remain unchanged.

Default central contribution zero is a lower bound, not a nonvanishing assertion. A positive central multiplicity or a general cluster repair needs its own valid actual-function evidence. A cluster count cannot enter critical-only K without the required critical-line localization. Principal c=1 and its stronger count/moment requirements are untouched.

This successor does not provide numerical Y/L amplitudes, amplitude integrals, historical Y/sinc interpolation, derivative certificates, contour winding or canonical argument certificates. If a selected repair or external API needs any of those, restore or independently generate the corresponding actual-function normalization and arithmetic for those requests. It is neither necessary to rescale every dense output for a sparse amplitude repair nor legitimate to price the repair at zero. A mixed consumer set needs a correspondingly mixed ledger.

All original required-unpriced obligations are preserved verbatim. New explicit reminders cover raw sample retention/binding; threshold construction and strict comparisons; raw widths; actual interpolation queries and their arithmetic; and amplitude exceptions. Variable-order stencils and polyphase schedules remain separate priced alternatives, even when their mathematical papers have been reviewed. This join neither evaluates those schedules nor adds their savings to the coarse deductions.

The successor remains conditional on actual successful signs and count closure. Even multiplicities, zeros at endpoints, small margins or inadequate auxiliary weight can require refinement, changed endpoints or a different certificate. The four guard scenarios prove no success or retry bound. Ordinary Lean/MM0 proof generation/checking, analytic formalization and data transport remain required.

## 5. Reproduction and frozen pins

The builder reads saved JSON, checks the seven frozen inputs below, and performs 180,271 integer/rational comparisons. It imports no evaluator or earlier producer. It checks all 29,996 reconstructed row contracts, the precise four-field mutation, every unchanged count field, the cohort sums, retained raw outputs, and unchanged large/setup/unpriced sections. It writes a new JSON exclusively; the predecessor is not overwritten.

Exact invocation:

`build_sign_only_minimal_theta_schedule_20261111.py --consumer-report work/qrh-campaign/agents/moebius/SMALL_THETA_SELECTED_CONSUMER_AUDIT_2026-11-11.md --consumer-sha CA2006BBC18394CC20D74AED5A1F24D8432AA2A1D2CEA22B3AEDBAB284A6EA51`

The consumer report is a pinned external input to this join; the CLI interface does not grant arbitrary reports mathematical authority. The produced receipt binds the exact path/hash above. The current result must be reviewed against those bytes.

| New artifact, this directory | SHA256 |
|---|---|
|build_sign_only_minimal_theta_schedule_20261111.py|88225615982B611EBFED86E00EC98CA6A1DEB07AFCCB40CDFC8B9FCE9A7F24B5|
|sign_only_minimal_theta_nonprincipal_schedule_20261111.json|E767EC3B3E14F2A243837DA85C811DE5ED67CE701BDD08998C2329F9C687C24D|

| Frozen input, relative to workspace | SHA256 |
|---|---|
|work/qrh-blueprint/MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md|654484AF0793EA0D5A2D51A2842E06753F4D8CEC0BF75A96953EF017D9B3173F|
|work/qrh-blueprint/minimal_theta_nonprincipal_schedule_20261111.json|96483C8A5E47888AC9208A8B95CA1BD8261CBC9D42AFBCBAEE1A1ABF10AC9265|
|work/qrh-campaign/agents/zero-sum/REVIEW_MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md|C4DD11BAD42C5F6970FCABC93F90AC7506B5C01278C3EF02155AD6404B2B9F52|
|work/qrh-campaign/agents/audit/SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md|076030481DEB4A922356A5BC0B8CCB243DF3FBB15A0DD427A29DEB044E82D430|
|work/qrh-campaign/agents/zero-sum/REVIEW_SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md|5683768E8F7B8B93FD4CD2E45CDBED40BFA9CC1BAE238CF920A22B40FEBB820A|
|work/qrh-campaign/agents/audit/raw_small_theta_sign_scalars_20261111.json|D6FA13513E2A01B4B3ACFFD0A93B7B0C811F864A1C4FDAB3E907FA23626532CB|
|work/qrh-campaign/agents/moebius/SMALL_THETA_SELECTED_CONSUMER_AUDIT_2026-11-11.md|CA2006BBC18394CC20D74AED5A1F24D8432AA2A1D2CEA22B3AEDBAB284A6EA51|

No total arithmetic grand sum or time estimate is formed. The packet establishes a source-bound conditional contract and transparent count changes, not a completed finite-RH certificate or a new final premise.
