# Review of the tilted right-slab Fourier evaluator

2026-11-11. **PASS for the revised paper construction pinned below.** One required clarification was resolved during review: the e/8 finite-transform error is an error in the final scaled Fourier output. It is not an e/8 error in an unscaled normalized inverse DFT. No other correction is required.

The result supplies a holomorphic normalization, uniform kernel and derivative bounds, terminating scalar parameter selection, and a valid point-to-panel interface for actual primitive nonprincipal characters. It supplies no new actual coefficient, panel, winding, or spectral result.

## Exact inputs and independent checks

The approved producer note is `../zero-sum/TILTED_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md`, SHA256 `695BF1B9AE43BDDA950F111D8A484B35DE774578B6F5A14012763740E28848AE`.

Its unchanged scalar script `tilted_right_slab_parameters_20261111.py` has SHA256 `15D058DED942333655F3F8599FA9A893A945E18063970BFC69532F95453E1FDD`. Its unchanged JSON has SHA256 `1D009682FFA399B9E9B1A93C81022E4C9A87BB92C74573C52B9801A11C65546B`.

The independent script in this directory, `review_tilted_slab_fourier_20261111.py`, has SHA256 `DD7674CBA57C93E7360480F88FD41D110C42E0D61EB6744B6C7A119C44B93685`. Its JSON receipt has SHA256 `1E2CAC2AE4BC4A9C77E9587F1AFCD3853E755312F022391F41B67589F568AD37`.

All 119 exact checks passed. All exact fields in the five producer rows were independently reconstructed. Four additional cases include a zero requested height, rational nonintegral B, a large tolerance, a very small tolerance, and height far above the old fixed cap. The reconstruction uses exponential brackets and bisection for the monotone scalar searches, not execution of the producer script. No Fourier array, character value, special function, or spectral datum was generated.

The reviewed predecessor is `FULL_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md`, SHA256 `618FB579D8657C72F2003BE4D60C68E38648C2F30F266938CE40E2C8F5A5E771`, with my review `AE8F8F852F969B6505EE9AC60E5F4D67B7AF686E94F6A9B4E4FED54D8F9ED271`. The source pins remain Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`.

## The resolved finite-transform issue

The initially supplied pending note, hash `35B907108593DC0E64502A4F1E2BC1DFE484BBB0C3EA9EE071037816679D4E1F`, called the e/8 allowance a normalized finite-DFT implementation error without explicitly attaching it to the final scaling. I independently flagged this; root separately identified the same issue. That earlier wording is not approved as an unscaled error contract.

Under root's authorization the author revised the pending note. The final text defines

`S_m = omega sum_j C_j exp(2pi i jm/N) = omega N invDFT(C)_m`

and requires `|S_computed-S_exact|<=e/8` for the supplied finite coefficient representatives, including twiddles, transform arithmetic, the scale factor, and its multiplication rounding. Coefficient errors are counted separately. This is sufficient for the total error ledger.

The alternative explicit split is also correct: certify the unscaled normalized inverse output to e/(16D), then bound all further scaling error by e/16. Since omega N<D, the two final contributions sum to at most e/8. The independent receipt checks this split in all nine cases and records that applying an unscaled e/8 bound would fail the intended allocation. The unchanged producer receipt field `finite_transform_error_target` is accepted only with the revised final-output definition.

## Holomorphic normalization and exact cancellation

For one fixed real b, `Z_b(s)=exp(-ib s)Lambda(s)` is entire. The exponential has no zeros and has the global logarithm -ib s, so multiplication preserves all zeros and multiplicities and contributes zero winding on any closed contour. The actual source Lambda is the nonprincipal entire completion, not a totalized Gamma product.

At s=sigma+it, the necessary conversion is

`Z_b(s)=exp(-ib sigma)c^((sigma+a)/2)F_sigma,b(t)`.

The positive real factor exp(bt) already occurs in F. Adding another exp(bt), or dropping exp(-ib sigma), would be wrong. The proposed formula retains both facts. It makes no real-valuedness assertion about the output and requires no root-number square-root choice.

I independently derived the derivative identity before receiving the final note. Differentiation of the shifted kernel contributes

`partial_sigma G=(x+ib-log(c)/2)G`.

The derivative of the prefactor contributes `-ib+log(c)/2`. Both constant terms cancel, leaving

`Z_b'(sigma+it)=exp(-ib sigma)c^((sigma+a)/2) integral x G(x) exp(itx) dx`.

The t derivative is i times this expression. This confirms that the panel derivative is the derivative of the single entire function Z_b, rather than the derivative of an inconsistently rescaled family. The fixed-b condition is essential. Choosing b anew at every point would require another normalization adapter.

Source entire continuation, Gamma-factor nonvanishing on Re(s+a)>0, primitive theta reciprocity, and the conductor powers are those verified in the predecessor reviews. Thus sigma=1 and sigma=2 introduce no poles or additional hypotheses. The c=1 case remains excluded.

## Uniform Gaussian estimates and height dependence

For cos(2y)>=q>0 and q<=1, the split-Gaussian estimates yield

`|h_sigma(x+iy)| <= (2c/q) exp(r-(q/c)exp(2r))`, with r=|x|.

This follows from both signed linear exponents being at most r throughout sigma in [111/200,2], and from the parity amplitudes being at most c/q. The reciprocal negative-frequency formula uses the actual inverse character and root number. There is no same-sigma or same-character shortcut.

Substituting u=exp(r), the two-sided zeroth and first absolute moments are each at most

`(4c/q) integral_[1,infinity) u exp(-q u^2/c) du <= 2c^2/q^2`.

For the first moment the additional log(u) is bounded by u; for the zeroth moment use 1<=u. All factors of two are accounted for. Dominated differentiation and contour shifts follow from the stronger theta Gaussian decay on slightly larger closed substrips.

With H0=max(1,H), B=cH0, and b of either selected sign, the elementary sine bounds give q_b=1/H0 and q_R=1/(2H0). The exact shift gap is pi/(8H0), greater than 3/(8H0). Therefore `M_b=J_b=2B^2` and `M_R=8B^2` are valid. At H0=1, b=0 and both signed choices agree.

Multiplication by the conductor factor costs at most c^(3/2), yielding

`|Z_b|, |Z_b'| <= 2c^(7/2)H0^2 < 2c^4H0^2`.

These bounds hold for every real t once b is fixed. H0 specifies the tilt, not a hidden restriction on the derivative formula. At either closed real boundary of the slab, the identity and bound follow from the entire function and continuity from the interior, or directly from the local entire Mellin domination.

The conditioning claim is accepted in this precise sense: the evaluator directly encloses exp(bt)Lambda with its required complex phase, and its kernel and derivative majorants grow polynomially in the selected H0. No Gamma asymptotic is needed for these upper bounds. This does not prove that the normalized function is bounded away from zero, or that its values cannot still be exponentially small because of cancellation. The note explicitly disclaims such a lower bound and any runtime guarantee.

## Time, frequency, and series budgets

For P=(2+4K)H0, the minimum rate 3/(8H0) satisfies rate*(P-H0)>K and rate*P>1. Thus the geometric denominators exceed one-half, and both signed time tails total less than `32B^2 exp(-K)`. The rational K test is sufficient.

The x test gives exp(2x)/B>2x+L. The least power-of-two construction has N>=2, X>x, omega<2, and omega N<D=88x/21. The logarithmic derivative of Q_b is `1-2exp(2r)/B`, so Q_b decreases beyond x with the claimed stronger progression ratio. The two signed omissions are bounded by `6Q_b(x)<12B exp(-L)`. Starting the negative progression at X instead of its actual X+omega overcounts safely; the Nyquist endpoint is not dropped.

For the retained theta series, the real Gaussian coefficient is greater than 3/B. The direct and reciprocal prefactor exponents are both at most 3. V>=2 implies decreasing numerator as absolute frequency increases, while the ratio denominator improves. The bound `2n0(1+1/z)(3/8)^floor(V)` is therefore uniform over every retained frequency. Multiplying by D accounts for all N weighted coefficient errors.

The K and L searches terminate by geometric decay. The x threshold ratio grows by at least `(64/9)(3/5)>1`. Once n0>=B, including nonintegral rational B, z>6 and V>=3n0. The series bound is less than `3n0(3/8)^(3n0)`, whose successive-integer ratio is at most 27/256. A doubling search also terminates. There is no cH cap or hidden assumption about zeros in these arguments.

The input rounding target contributes less than e/8. With the corrected final-scaled transform target, all five contributions total less than e. Point values at general rational ordinates use the same finite trigonometric polynomial directly unless grid alignment is separately checked. The integer N and the finite theta cutoff in the receipt are existence witnesses, not executed arrays or cost predictions.

## Point multiplication, panels, and signed-domain assembly

The phase and conductor multiplier both require certified enclosures. The stated d_F and d_A targets imply a product error at most r0/4 by

`|A|d_F+(|F|+d_F)d_A <= c^2 d_F+(M_b+1)d_A <= r0/4`.

After another r0/4 for finite multiplication, the point error is at most r0/2. The radius r0/(4c^4H0^2) costs at most r0/2 under the actual complex derivative bound. This proves a whole-panel enclosure for horizontal and vertical segments of the same function. The independent checks cover both small and large r0, including the minima in the tolerance definitions.

Conjugation satisfies exactly

`Z_(-b),chi(sigma-it)=conjugate(Z_b,inverse_chi(sigma+it))`.

Same-character reuse requires a real character. Reflections of both the parameter contour and image must carry their orientations explicitly. No winding sign may be copied solely from a label match.

Different b values define different image functions, with ratio `exp(-i(b2-b1)s)`. Their images need not coincide on a shared parameter edge, and that ratio need not have unit norm. The two assembly choices in the note are valid: add separately certified counts with explicit domain and seam bookkeeping, or convert all image data to one fixed normalization and redo the interval errors before geometric cancellation.

A seam on the real axis is not automatically zero-free. A primitive nonprincipal L-function cannot be assumed free of real zeros to make the assembly work. Inclusive heights, shared edges, possible overlap, and zero multiplicities remain actual proof obligations. The note retains them.

## Remaining scope

The approved revised packet provides a refinable paper evaluator and panel interface. It does not make a computed contour nonvanishing, force an interior zero count to be zero, or resolve a zero exactly on the weak strip boundary. Fair refinement terminates for strict panel witnesses only under the genuine boundary-nonvanishing condition.

Formal source adapters, arbitrary-precision elementary arithmetic, arbitrary-size finite-transform certification, complete actual-character inputs, full contour records, and their geometric assembly remain open implementation or evidence tasks. No Lean/Lake build, dependency change, canonical source edit, FFT, or spectral scan was performed for this review.
