# Independent review of raw small-theta signs

2026-11-11. **PASS at conditional paper and exact-metadata scope; no correction required.** This review binds `audit/SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md`, SHA256 `076030481DEB4A922356A5BC0B8CCB243DF3FBB15A0DD427A29DEB044E82D430`. It accepts a sufficient sign interface, not actual signs, a finite-RH certificate, an implementation, or a runtime saving. No analytic values, transforms, zeros, primes or builds were evaluated. Author files are unchanged.

## 1. Exact function and error units

I read the author note and scalar program, the accepted small-conductor backend, finite-polynomial interpolation argument, and radix-two error contract. The stored coefficient centers define one exact real finite polynomial U. Its Hermitian assignment and fixed actual character phase are essential. The comparison is to omega U, not U itself: the inherited three pre-time errors give `|F_b-omega U|<3 eps/4` only on the admitted target interval. This comparison is applied once at the requested target. It is not multiplied by the interpolation Lebesgue norm.

Both omega and `exp(theta*t/V)` are strictly positive. Thus a proved strict sign of F_b/omega is the same actual sign as F_b and Y. This does not make an unqualified sign of U reliable. The normalized-DFT variant needs its explicit factor N; the reviewed construction consistently uses an unnormalized positive DFT, whose exact grid output is U(k Delta).

For `L=6/P` and `H=44/(7P)`, the bounds `L<omega<H` correctly use the lower bound for division of the inherited error and the upper bound for allocation of raw arithmetic error. With `C_U=(2J+1)B`,

    H C_U <= (506/21) B < 44B=M.

The inherited global derivative bound and the same 340-node real interpolation formula therefore imply raw interpolation error below `eps/(16H)`. The seven exact Lagrange norms are below four. Raw sample errors at most `eps/(64H)` and arithmetic error at most `eps/(16H)` give

    |F_b/omega-z| < 3 eps/(4L)+3 eps/(16H)
                    =109 eps P/704.

The threshold is rational, strictly positive, and shared only for identical parameters. Either strict comparison against it proves the desired sign. The check `H*(109 eps P/704)=109 eps/112<eps` is valid as a bound, not as an instruction to produce omega z without a coefficient enclosure. The sharper physical comparison before rational overestimation is `15 eps/16`.

## 2. Arithmetic and width

The radix-two contract is an absolute complex-norm gate contract, with root uncertainty separate from arithmetic rounding. For exact stored input magnitude at most B, its unnormalized error is at most `N Ctime u(B+1)`, under the stated safety condition. The old sufficient tolerance divided by eight yields `eps P/448`. Independently,

    1/448 < 7/2816,

so this fits `eps/(64H)`. This proves the stated three additional fractional bits for the intrinsic raw time transform. It does not grant a one-bit relaxation to coefficient, character, phase or Gaussian gates. The former factor sixteen allocated error also to omega approximation and final scaling; it remains sufficient if retained.

The raw sample bound `C_U+1` follows from the very small sample radius and the finite P range. In the interpolation decomposition, use exact weights on the uncertain samples first, then weight error times the stored sample centers. Consequently the prescribed weight and accumulation allowances include the mixed uncertainty term. The inequality

    H(C_U+1) <= (506/21)B+22/21 <=44B+1

shows that the former weight precision is sufficient. Since P>=2700, H<1, so the former absolute accumulation allowance is also sufficient. Neither fact bounds raw integer widths by old scaled widths. The note correctly leaves larger raw operands, exact product temporaries and implementation costs to be charged.

Wrapping is justified by the exact finite polynomial's periodicity. It is not periodicity of F_b, Y or L. The FFT error theorem applies to the full N-index array, while the analytic comparison is used only at targets in [0,V]. The dependency union of wrapped stencil samples and their identity with the same coefficient array cannot be dropped when output scaling is dropped.

## 3. Consumer and operation scope

The sign shortcut transfers to continuity-based sign-change brackets and the already reviewed weighted count lower bound. It preserves the actual character and a common fixed phase at all endpoints. Nonreal inverse partners still require both positive channels. Central multiplicity, actual canonical Turing phase, auxiliary coverage, the applicable surplus test and all unsuccessful-sign repairs remain independent obligations. No argument or logarithmic derivative of U replaces that of L. A finite-polynomial root alone is not a certified L-function zero.

General amplitude outputs, amplitude interpolation, contour images, derivative enclosures and absolute-value consumers need their proper normalization. The conditional omission of output scales is therefore not an assertion that every current or future use of the array is sign-only; the selected consumer inventory must establish that condition separately.

All four coarse-prefix deductions match the saved whole-family receipt: omega scalings and final Y products equal the primitive exported-output count, shared positive-scale updates are counted once, and exactly 7499 positive exponential seeds can be omitted while 7499 radial seeds remain. I checked theta64 and theta128 have the same exported grid counts. Transfer to the accepted minimal-theta choice uses its reviewed unchanged grid geometry.

The full theta128 time array remains 9237783904256 complex outputs in the main scenario. Main dense eighth refinement adds 12427893758063 endpoints, giving 14203325629180 in total; direct 340-node interpolation adds 4225483877741420 weighted terms. These are schedule identities, not inevitable optimal costs. Avoided off-grid rescalings were not in the frozen coarse ledger and cannot be subtracted from it twice. A full-array scaling comparator is also distinct from the prefix comparator. Net cost still includes raw widths, threshold checks, failed discovery/refinement and any changed implementation.

## 4. Independent exact evidence and boundaries

Owned script `zero-sum/review_raw_small_theta_sign_20261111.py`, SHA256 `32D4FB667F45C196529D2BA78A2DF8840540947DF4E8A2E575171142713A8CFB`, and receipt `zero-sum/review_raw_small_theta_sign_20261111.json`, SHA256 `0D379957ABC2C35FEEDC5549B72DFCB91B0A0614531FD94B213588F22842FFB3`, pass 207 exact checks. They verify the three author pins and eight dependency pins, reconstruct all seven interpolation norms by a separate factorial-denominator formula, check the worst remainder and threshold/allocation identities, specialize supported radix-two lengths, and independently rebuild every saved count-deduction field. The author program was read but not imported or executed. No function evaluator is imported.

The source boundaries remain the reviewed backend's actual Gaussian comparison, fixed phase/Hermitian construction, and its complete coefficient budgets; the reviewed interpolation theorem and kernel constants; the accepted absolute gate contract; and the existing endpoint/count consumer. This bounded review does not repeat the full analytic backend proof or reconstruct every conductor's original inventory. It supplies no actual data or guaranteed sign margin and does not authorize execution or change a frozen ledger.
