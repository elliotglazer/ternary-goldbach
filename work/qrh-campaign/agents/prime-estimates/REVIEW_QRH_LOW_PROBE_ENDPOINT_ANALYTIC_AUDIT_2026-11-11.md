# Independent review: actual low-probe endpoint

Date: 2026-11-11. Verdict: **PASS for the bounded conditional source assembly.** No correction is requested. This review does not close the lower reflected-energy, additive Gram or Gaussian reconstruction foundations, and does not validate the complete QRH provider.

Reviewed frozen author report `../zero-sum/QRH_LOW_PROBE_ENDPOINT_ANALYTIC_AUDIT_2026-11-11.md`, SHA-256 `C6514DD1CEE85B24417B7E48D857D0E870CBB9F7DFB08264E764567E05E07C95`. All 29 source hashes in its table match. Sources are from `work/openai-math`, revision `4eaee87548250b2682affda7d05d947c05554bae`; paths below are relative to `lean/OAI/NumberTheory/DirichletL/`.

I read the actual source chain independently before the author report froze, reconstructed the scale and exponent calculations, then compared the complete report against it. Checks were source reads, paper algebra and hashes only. No Lean build, analytic evaluation, scan or frozen-file edit was performed.

## 1. Exact target and prior coverage

`Detector/FinalAssemblySource.normalizedProbe_low` bounds the actual normalized compensated physical probe, with scales `X0=Z^(17/48)`, `Y0=Z^(23/48)` and the stated ray-prime pools. The conclusion is Big-O of `Z^(3/16+loss)` for every fixed character and every positive loss. Its constants and eventual threshold can depend on the character, fixed weights, modulus, exclusions and slot data. It is not a uniform estimate for moving moduli or growing slot counts.

The report correctly separates this numerator endpoint from the previously accepted multiplier construction and signal Mellin argument. It also reuses, rather than reproves, the ray normalizer. That author dependency has hash `693FA8013AC733DAE96CAD1C464912CF9F04DF5F09F9ACE6B3E7556F93443270`; its independent review in `major-constants/REVIEW_QRH_RAY_NORMALIZER_PRODUCTION_AUDIT_2026-11-11.md` has hash `64051835DEA4012784320B9660964910754C2FCB8AE7E5C33D84784B6F0BF2D1`.

## 2. Actual rows and the central scale cancellation

The source's subset J denotes unselected slots. Its complement carries the selected slots. Write d and e for their respective sums of scale exponents. Nonnegativity gives `d,e>=0` and `d+e<=1/6`. For an unselected tuple, L is its product's absolute ideal norm, not its complex absolute value. Supported nonzero entries imply `L>=1`, and the annular bounds give

\[
 (\min(1,a))^K Z^d\le L\le(\max(1,b))^K Z^d.
\]

The physical row scale is exactly `Q=q*Z^(5/6)/L^2`, with fixed positive calibration norm q. The lower L bound controls the numerator row cutoff. The upper L bound cancels the apparent main power in the selected row energy:

\[
 E_\sigma\le C(1+|t|)^nZ^{5/6-2d+507\epsilon}
 \quad\Longrightarrow\quad
 \frac{\sqrt{E_\sigma}}{\sqrt Q}
 \le\sqrt{CB^2/q}(1+|t|)^n Z^{507\epsilon/2}.
\]

The proof intentionally replaces the square root of `(1+|t|)^n` by the larger `(1+|t|)^n`. All square-root and division arguments have the required positivity. The finite ray-residue sum and `1/(2*pi)` are paid in the constant, not deleted.

I checked the nominal central parameter conversion: `ell0=e+epsilon/2` and `shift=log_Z(U)-1-ell0` satisfy `|shift|<=epsilon`, with the stronger range `-epsilon<=shift<=0`, whenever U is in the specified central interval. Also `ell0<=1/6-d+epsilon`. This supplies the actual lower energy theorem's domain.

The adapter does not replace a physical row by an arbitrary coefficient vector. `LowActualReflectedEnergy` and `LowSelectedBound` keep the true-period prime filter, period and calibration mask, correction coefficients, selected-list disjointness and six unit rows. The endpoint theorem then consumes `Reflection/LowOriginalEnergy.low_original_completed_energy`. Reading that interface and its adapter does not revalidate its entire reflected-energy proof; the author's lower cut is necessary and correctly retained.

## 3. Gram estimate and unselected mass

Eventually `q<=Z^(1/8)` and `L<=Z^(11/48)`. The latter follows from the fixed bound `L<=B Z^(1/6)` by requiring `B<=Z^(1/16)`. These conditions justify both scale-admissibility inequalities before applying the Gram bound.

For `P=Y0/(q X0)`, the Gram square has the form

\[
 \frac{qX_0}{L}
 \left(1+P^{1/6}+\frac{LP^2}{Y_0}\right)
 (Y_0/L)^\epsilon.
\]

Here `P>=1` and `L P^2/Y0=L Y0/(q^2 X0^2)<=1`. Thus the parenthesis is at most `3 P^(1/6)`. Since `P<=Z^(1/8)`, taking the square root gives

\[
 \operatorname{Gram}\le\sqrt{3q/L}\,Z^{3/16+23\epsilon/96}.
\]

Combining it with the inverse energy costs

\[
 507/2+23/96=24359/96<254.
\]

The remaining `L^(-1/2)` is essential. The unselected compensation already has `L^(-3/2)`, so their product is exactly a product of norm powers `-2`, multiplied by the window norms. `LowUnselectedMass` uses the actual canonical-slot/prime-ideal equivalence and supported-ideal summability at exponent `-2`; it does not estimate this sum by the number of tuples or discard unit multiplicities. Finitely multiplying these bounds is uniform in the actual pools, subset and scales, with K fixed.

The source's separated Gram integration retains the actual Mellin transform and bounds its weighted norm by `C/(1+v^2)`. Integrating pays pi. This checks the integration and consumption of `actual_additive_gram_bound`, not the underlying additive Gram inequality or the foundational separated Fourier identity.

## 4. Complete dyadic summation

The common Gaussian identity keeps every subset and the density scale `R=Z^(1+e)`. It does not replace R by Z. `GaussianPhysicalTuple` first constructs a common finite physical row set for the finite family; `GaussianTuple` supplies corrected Gaussian dyadic summability before interchanging the finite tuple sum and tsum. Those explicit statements prevent a default-tsum interpretation, while their deeper Gaussian reconstruction inputs remain open cuts.

For central dyads, insertion of `(2^j)^epsilon>=1` is in the correct direction. The weighted Gaussian moment theorem gives a genuinely summable positive series bounded by `C R^epsilon`. Its exponent cost is

\[
 254\epsilon+(1+e)\epsilon\le(254+7/6)\epsilon<256\epsilon.
\]

The remote predicate includes both equality boundaries: `2^j/R<=A^(-1)` or `A<=2^j/R`, where `A=Z^(epsilon/2)`. The central summand is zero there, so the two pieces neither omit nor double-count a boundary dyad.

I also read the remote physical-family reduction and its finite-row mass identity. The actual tuple count is at most `(128 max(1,b))^K Z^(1/6)`. Each scale contribution is at most `q Z^(5/6)`, since `L>=1`; coefficient and window norms are at most one. Consequently the scale mass is at most a fixed constant times Z. The remote theorem supplies both summability and `C mass R^2/A^N`. Choosing a natural N with `epsilon*N/2>=13/3` gives

\[
 1+2(1+e)-\epsilon N/2\le-1.
\]

The physical scales are eventually at least one before this theorem is applied. `LowGaussianSum` adds the two nonnegative norm series and obtains absolute summability of the entire complex dyadic series; its norm is bounded by the two totals. The `Z^-1` term is harmless for `Z>1`. No assumption about cancellation between remote and central dyads is used.

## 5. Pools, losses and nonzero denominator

Distinct fixed scale exponents imply eventual strict annulus separation. The source's floor-defined pool bounds are preserved when proving this disjointness. Actual supports outside S and supported-prime conditions are supplied by the source exclusions; they are not imposed on an unrelated pool.

The finite collection of subsets is handled by summing constants and intersecting eventual statements before admitting dynamic pools and bounded weights. The logarithmic support bound for each slot follows from its support in the fixed positive annulus.

For general slot bound B, `LowWindowBound` sets `D=max(1,B)>0`, divides each slot weight by D and proves the exact degree-K homogeneity. Its `epsilon=min(loss/512,1/2)` is positive and less than one, and `256 epsilon<=loss` follows. The bound is not claimed uniform in K or B.

`LowNormalized` then requests numerator loss `loss/2` and normalizer-inverse loss `loss/2`. The normalizer is the identical source residue constant and principal scalar built from the identical pools and weights. Its eventual nonzero conclusion is kept. Multiplication produces exactly `3/16+loss`. Enlarging W1's upper support endpoint to `max(b1,a1+1)` changes neither W1 nor that denominator. The final Big-O conversion uses eventually positive Z.

## 6. Pins and remaining scope

All 29 author source pins were verified. The following additional files were read for independent interface or adapter checks; their listing does not claim a full foundational audit.

| Additional source | SHA-256 |
|---|---|
| `Detector/LowCentralGeometry.lean` | `48C40BD87FCD7109E2ACE6630397BBA759D93A0C1A1D5E60728B9E9B11AFB18C` |
| `Detector/LowGramApplied.lean` | `CCFDE79F283D13891068D3071204AFBC37D0DE77CE88367C19F46325D26E99B9` |
| `Detector/LowActualReflectedEnergy.lean` | `CCA009B06D6A06A38994D86FE524A0C475AB992496F5DB00AA35452C612DA621` |
| `Reflection/LowOriginalEnergy.lean` | `F01E49A1FAC91859E1D23C6EF3DC84C9EFF39C0B5BAB19CA4CEF8A7A1B0F7E62` |
| `Detector/GramIdealSummation.lean` | `1EE170F3F7D8E55B416873FFA630111582963C6A1AF61A5BFCA92E56398BF76C` |
| `Detector/GaussianRemoteRows.lean` | `5C289CEC6F30F7DAAAD9C2F571BD0E2C42DD16802C8CC8628D4D3D2E219EA5C5` |
| `Detector/GaussianPhysicalTail.lean` | `54073EF793652BCC5AB435BE69DBF11BD00D0346F42C03FF608C56E2C4631394` |

The accepted statement is the low endpoint's immediate conditional source production, including exact scale cancellation, compensated finite mass, full dyadic summation, pool geometry and normalization. Its reflected completed-energy input, actual additive Gram input, Gaussian/log-window and low-polynomial identities, and ideal-count/summability foundations remain exactly the lower cuts named in the author report. The previously accepted ray normalizer remains a separate dependency.

This bound does not prove the physical probe nonzero or its high approximation to the source signal. Compatible elaboration, transitive kernel axioms, formal consumer joins and finite-spectrum certificates remain independent open gates. No new QRH premise or final contradiction was used in the inspected endpoint assembly.
