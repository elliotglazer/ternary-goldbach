# Full P20 input bounds5691 and5032

2026-11-11. Separate conditional paper successor, pending independent review. No previous8828 packet, precision assignment, price baseline or source artifact is changed. The work uses fixed rational envelopes only. No coefficient, function, root, transform, prime or zero values, saved inventories, builds, declarations or proof emission occur.

The actual stored-coefficient bounds give a full P20 polynomial center below5172.5 in the first four bands and below4513.5 in the final band. After the finite head, exact grid100 assembly, optional checked regrid and augmented1, uniform V=5691 suffices. The final-band-only bound is5032. These bounds include coefficient conversion and product rounding in the three already reviewed full P20 profiles. They improve both the generic error allowance and potential runtime capacities, but no new assignment or price saving is adopted.

## 1. Actual producer and evaluator being bounded

Consume `STORED_HURWITZ_DEGREE_MAGNITUDE`9B777E02 and its independent source review10281561. The centers are the stored coefficients of the FINITE translated coarse polynomial, with their numerical errors. They are not asserted to be exact fine-anchor derivatives. The first four bands retain their P27 coarse source and m64 schedule; the rightmost unshifted endpoint needs only P20. The final band retains V_height7000, sourceD4096/N1500/P28/m159, the actual shifts0,1/4,1/2,-1/4 and the output2^-j postscale to normalization8192. The present P20 means20 delivered/evaluated coefficients, not truncating every coarse source to20.

The three bound evaluator profiles are those in reviewed repricing96734A7E:

- uniform100 at every degree;
- root_linear with degrees0..19 on grids100,100,98,97,96,95,94,93,92,91,90,89,88,87,86,85,84,83,82,81;
- fixed15442 on grids100,100,100,100,97,95,95,95,89,87,87,87,81,79,79,79,71,71,71,71.

All directly convert the ORIGINAL stored coefficient to its own grid, initialize the top coefficient once, then perform19 rounded real-displacement products and19 exact coefficient additions. There are20 coefficient conversions and19 product rounds. The displacement has absolute value at most1/4. The degree0 addition is exact and no further product follows it. Each profile has output grid100, so its export introduces no new round. An intermediate grid100 conversion of every coefficient followed by another conversion is not this schedule.

The source, shift and target error contracts remain those of the admitted profiles. In particular their evaluation-error envelopes are already below `(8/3)*2^-100`. Using the much coarser b>=70 majorant below is only a magnitude proof. It does not admit a new all-grid70 evaluator or relax the full alpha error bound. No shortened-output or rounded-difference evaluator is imported.

## 2. Expand the exact magnitude recurrence

Let

    eta=2^-100, u_T=2^-110, R=2^-116,
    W=4eta+330u_T,
    Eflat=2^27*(eta/4+330u_T),
    e_j=(3/4)*2^-b_j,    e=(3/4)*2^-70.

The reviewed stored-center envelopes are

    Z0_first = 5170+R+W,
    Zj_first = 6*(5/4)^j/j! + min(4^j*W,Eflat), j>=1,
    Z0_final = 4507+9/2+R+eta,
    Zj_final = (15/2)*(7/8)^j/j! + eta, j>=1.             (1)

Every source center has norm strictly below its corresponding Z_j. In particular the finite-shift numerical errors and final postscale round are already included. The analytic finite-shift bias belongs to the actual-function radius and is not an additional magnitude perturbation to this already specified finite vector.

For these actual product-only-rounded Horner profiles the magnitude recurrence is

    A19=Z19+e19,
    Aj=Zj+ej+A_(j+1)/4+ej, j18,...,0.

Unrolling it gives the identity

    A0=sum_(j=0)^19 Zj/4^j
          +sum_(j=0)^19 m_j*ej/4^j,
    m19=1, and m_j=2 for j<19.                           (2)

Thus all20 conversions and19 products are counted. Exact additions/export contribute no rounding term. The second sum is less than `(8/3)*e`, since e_j<=e and the finite geometric sum is below4/3. This is deliberately conservative for the three actual profiles. Their much smaller error admission remains independent.

Use the previously proved rational finite-series majorant

    H(z)=1+z+z^2/[2(1-z/3)], 0<=z<3.

Starting at the degree2 factorial term, the successive ratio is at most z/3. Hence every finite factorial sum is bounded by H(z). This uses rational inequalities, not an exponential-function evaluation.

In the first-four class, the weighted numerical part of (1) is at most20W: the degree0 term contributes W, and each of the19 positive degrees contributes at mostW after its factor4^-j. This overcounts the stronger weighted-vector theorem but is sufficient. Equations (1)–(2) therefore give

    A0_first < 5170+R+20W
                  +6*(H(5/16)-1)+(8/3)*e
             < 10345/2 = 5172.5.                        (3)

For the final class, the weighted numerical term is below4eta/3. The output normalization8192 is essential to the factor7/8 in (1); source4096 cannot replace it. We obtain

    A0_final < 4507+9/2+R+(4/3)*eta
                  +(15/2)*(H(7/32)-1)+(8/3)*e
             < 9027/2 = 4513.5.                         (4)

The strict rational comparisons in (3)–(4) include all displayed terms, not just their leading ideal parts. The fixed companion also reconstructs (2) independently by recurrence for all six band/profile cases. The magnitude proof covers the full stated band heights, negative heights, zero and the source endpoints through the unchanged source hypotheses.

## 3. Head, exact assembly, regrid and augmented bounds

For a unit representative1<=a<c in the selected large family, and s=1/2+it,

    |(a/c)^-s|=sqrt(c/a)<=sqrt(c)<516,

because `c<=265800<516^2=266256`. This is uniform in the sign and magnitude of t. A raw head center with Euclidean error at most1 has norm below517. The actual much tighter head radius and encoding remain mandatory. For example the retained conductor-scaled head sum H<=2^-63 implies every individual head radius is at most `sqrt(c)*2^-63<1`; it must still be bound to the actual vector. A radius does not by itself provide its grid100 representation.

As in the accepted subgrid packet, produce the head center on grid100 with its original radius, take the exact polynomial grid100 output, and add them exactly. A distinct inexact assembly must pay its additional error and magnitude before using this proof. Under this selected exact assembly, (3)–(4) give

    raw norm_first < 5172.5+517 = 5689.5,
    raw norm_final < 4513.5+517 = 5030.5.                 (5)

For p80..108, retain the checked single input converter from B7E78161. Its Euclidean error is at most `rho_p*2^-p`, where rho=1 below100 and0 otherwise. Adding that error and the augmented1 yields

    M_new_first+1 < 5690.5+2^-80 < 5691,
    M_new_final+1 < 5031.5+2^-80 < 5032.                 (6)

The source numerical coefficient errors, direct conversions, product rounds, head error, exact export/assembly and final regrid have now each been accounted for once. There is no extra source-center round hidden in (6). The previous conservative converter encoding capacities115/p+15/116 remain safe and are not repriced in this note.

Uniform V=5691 applies across all selected bands. V=5032 is available only when the actual producer is the final-band source/evaluator just specified. It cannot be assigned using an unrelated legacy band label or applied to first-four inputs. A conductor-wide precision shared across all its samples can safely use5691; using final-only5032 in that whole-conductor selector would need proof that its entire input domain has that producer, or a separately reviewed variable-domain policy.

## 4. Error and runtime consequences, without adoption

The reviewed generic error companion permits any proved V_e>=M_new+1. Thus with the OLD factor two, a uniform sufficient replacement is

    E_c(p)=phi(c)/sqrt(c)*(11382*S(c)+rho_p)*2^-p,

subject to the unchanged localD and oldpeak guards. The corresponding squared test compares

    [phi(c)*(11382*S(c)+rho_p)]^2*2^(2*(108-p))
                <= c*4196258524692480^2.                 (7)

The old R108 target and every non-transform producer tolerance remain unchanged. This paper does not compose a newer tensor constant, tight leaf selection or a new assignment. A future such composition must substitute its separately proved coefficient explicitly. The regrid term rho remains unscaled by S or V_e and is charged once.

The generic runtime result3363B798, reviewed8ED151A2, is also available with V=5691 or the properly tagged5032. For exact positive full context factor f, including normalized inverse rational factors before the ceiling, use

    data magnitude bits = p+ceil(log2(f*V)).              (8)

Both new V lie strictly between2^12 and2^13. If `k=ceil(log2 f)`, then `2^(k+11)<fV<2^(k+13)`, so the new exponent is k+12 or k+13. Against the old V16384 rule p+k+14, every such data-envelope capacity falls by one or two bits. Exact powers of two fall by exactly one; the second bit occurs exactly when `fV<=2^(k+12)`.

This is a bit-capacity theorem, not a byte-cost or actual-value claim. Coefficient/root/cache-sum capacities and setup objects remain independent of runtime V. Generic data presums, rectangular products and signed rounding witnesses must use the new operand bound before acceptance, with all the old extra bits and range/binding checks. A smaller accepted residual is not used to shrink raw witnesses. Cheap events, setup, source production and conversion costs do not vanish. No existing exponent-only histogram can reconstruct the exact f threshold, and no histogram is folded here.

The8828 papers, current combined assignment and current price preflights remain immutable and valid. This note is a separate candidate for independent review. It provides no actual spectra, strict signs, count closure, principal computation, finite coverage, revised operation distribution or runtime estimate.

## 5. Fixed evidence and pins

Owned `full_p20_input_magnitude_20261111.py`, SHA256 `E5DBF113F5E791DB3C6DB1B69186429D36E15EAEEE14749ED7957102860F08CD`, checks50 fixed assertions. It hashes eight source/review files, proves the displayed rational envelope comparisons, expands all six actual profile recurrences, verifies their retained `(8/3)*eta` evaluation allowances, and checks the head/regrid/augmented bounds. Five abstract factor fixtures supplement the universal bit argument. No actual coefficient, source JSON, conductor inventory or transform value is read. The first run produced the2304-byte exclusive receipt `full_p20_input_magnitude_20261111.json`, SHA256 `8127C8DA33B6864CD464DA50E9364F778563571FF223DA00DF4920FC4E9A1B0B`.

|Source relative to agents|SHA256|
|---|---|
|prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md|9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2|
|major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md|1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6|
|moebius/FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md|96734A7E4A0C93857EE538A59890451C40644AAAA0D0F07FE9D82B936509C0D3|
|independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md|B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266|
|independent-feasibility/SUBGRID100_ERROR_MAGNITUDE_COMPANION_2026-11-11.md|39EC80DDC3388A9E470647CC4486D448108BB1FFD0D4CC58C13B61FBE3A4A761|
|audit/REVIEW_SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md|8431B9FF6B172F8ED36644413C359F5B8E2FEB58D9EBF0F88E500F152113EBAD|
|independent-feasibility/RUNTIME_MAGNITUDE_8828_CONTEXT_WIDTHS_2026-11-11.md|3363B798ED75652737431D46829C43483CF641F12169E1982F947DDF385CAD3C|
|zero-sum/REVIEW_RUNTIME_MAGNITUDE_8828_CONTEXT_WIDTHS_2026-11-11.md|8ED151A2CEAE534B668D900B473197E59DA88343A99FEF4D8ECAFB813F14BAE1|

The matched fixed-profile independent review was additionally read and rehashed directly: `independent-feasibility/REVIEW_FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md`, SHA256 `57D7DEDBA4D5497861DD641F4CC68416CA89EEAD0358F2151DA005ABCE319468`. It preserves the separate source acceptance and actual finite-polynomial object. This successor stops at its new rational magnitude implication, before implementation or cost adoption.
