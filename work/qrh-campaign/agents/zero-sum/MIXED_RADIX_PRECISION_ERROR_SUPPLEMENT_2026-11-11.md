# Precision for the mixed-radix character circuit

2026-11-11. Paper bounds and integer-only schedule checks. No roots, character values, Fourier transforms, L-functions or zeros were evaluated; no build was run. Previous artifacts are unchanged.

**Result.** The fixed mixed-radix schedule admits a conservative error budget at the same number of fractional bits as the whole-axis Bluestein baseline, when both are certified by the bounds below. This includes construction error in the cached Bluestein kernel. It does not compare against an optimized baseline precision obtained by a sharper analysis or actual values. It also does not equate fractional precision with total integer word width, memory, or runtime.

## 1. Exact operator and arithmetic contract

Let D_n be the positive, unnormalized DFT from the accepted mixed-radix report, and T_n=D_n/n. Its sup-operator norm is at most one, by the triangle inequality. The code still evaluates D_n: normalization here describes errors and does not introduce new division gates. CT uses the same input/output permutations and cross twiddles; the product of the outer unit-group axis lengths is v=phi(c). Only Bluestein's inverse convolution divides by its power-of-two length P.

Fix a positive dyadic u<=1. Every approximate unit root, including chirps, has complex norm error at most u from the specified exact root. Every rounded complex addition or product has absolute complex error at most u from the exact operation on its stored operands. Exact sign changes, quarter turns, permutations and zero padding need no error charge. These are distinct assumptions: a product's arithmetic error does not include error already present in its operands or coefficient. A chosen real-arithmetic implementation must prove this complex-gate contract; u is not silently identified with one coordinate's rounding error.

The bounds use absolute fixed-point error, not a fixed relative mantissa error. For a fixed finite input bound and positive budget, sufficiently fine dyadic rounding supplies the contract. Root enclosures and all gate checks remain required certificate inputs. No probability, independence or cancellation of rounding errors is used.

For exact stored input x with ||x||_infinity<=M, associate a node with integers C_n>=0,D_n^safe>=1 such that

    0<u<=1/D_n^safe  implies
    ||computed_D_n(x)/n - T_n(x)||_infinity <= C_n u(M+1).       (1)

The superscript distinguishes the safety denominator from the DFT. An uncertain input with radius E is handled by the exact norm-one operator separately: add E to the normalized error and apply the intrinsic bound with M bounding the stored center. This avoids amplifying input uncertainty by a product of artificial condition numbers.

## 2. Radix two and direct leaves

For n=2^k, let e_j bound absolute arithmetic error after stage j and normalize f_j=e_j/2^j. The exact intermediate magnitude is at most 2^j M. A multiply followed by either butterfly addition gives

    f_(j+1) <= (1+u/2)f_j + u M/2 + 2u/2^(j+1),  f_0=0.     (2)

This overcharges the exact cheap roots equally on both sides of the comparison. If 2ku<=1, the accumulated multiplicative factor is at most two: expand the finite product and bound it by the geometric series with ratio ku/2<=1/4. The sum of inhomogeneous terms is at most kuM/2+2u. Thus the deliberately relaxed choice

    C_rad(n)=2k+4,  D_rad^safe(n)=max(1,2k)                    (3)

satisfies (1). At n=1 use C=0,D^safe=1. The same proof applies to the negative transform in the convolution inverse.

For a direct r-point leaf, r in {3,5,7,11}, each nonzero output row has r-1 approximate-root products and r-1 additions; its zero input coefficient is exactly one. The absolute error is at most (r-1)uM+(2r-2)u. After division by r this is at most 2u(M+1). Hence

    C_direct=2,  D_direct^safe=1.                              (4)

This counts rounding once per product and once per sum, and root approximation separately. It needs neither a trigonometric identity nor numerical root evaluation in this paper proof.

## 3. CT node, with cross terms retained

For n=rm, first compute r length-m children, then cross-twiddle products, then m length-r children. Write C_m,C_r for the selected child bounds. The first outputs have ideal norm at most mM and error at most m C_m u(M+1). After the cross twiddle the error divided by m is at most

    u(M+1)d,  d=C_m(1+u)+1.                                  (5)

Indeed root approximation contributes u*mM, and the one product rounding contributes u; m>=1 absorbs the latter. A length-r child applied to these stored inputs contributes, after division by rm, at most C_r u[(M+1)+u(M+1)d]. Therefore the full normalized error coefficient is bounded by

    C_m+C_r+1 + u[C_m+C_r d].                                (6)

Because d<=2C_m+1, a valid integer recurrence is

    C_CT=C_m+C_r+2,
    D_CT^safe=max(D_m^safe,D_r^safe,1,C_m+C_r(2C_m+1)).         (7)

This uses the actual ordered split: the m child is first. It is not an assumption that rounding errors merely add. The last safety condition pays the product of child/coefficient errors. Recursive application proves (1) for the complete selected tree. No additional r or m factor survives in normalized sup error.

## 4. Bluestein, including the cached kernel

Let n>=2, P=nextPowerOfTwo(2n-1), k=log2(P), R=2k+4, A=1+3R, and m=2n-1. The chirped data have at most n nonzero entries. The padded two-sided kernel has m nonzero unit entries. Their exact unnormalized transforms therefore have magnitudes at most nM and m respectively, independently of P.

The input chirp error is at most u(M+1). Applying (3), including that input error, bounds the data-transform error by

    e_F <= P A u(M+1).                                       (8)

The stored kernel inputs have error at most u. Their forward transform, constructed once at this precision, must have a certified error

    e_K <= P A u.                                            (9)

This is not a unit-root coefficient: its exact magnitude can be m, and its stored magnitude can be m+e_K. Reuse of the same enclosure is valid for arbitrarily many input transforms; one pays its error at every use, not its construction anew, and does not divide its error by the number of uses.

The pointwise product error includes the cross term:

    e_C <= nM*e_K + m*e_F + e_F*e_K + u.

If PAu<=1, this is at most Q u(M+1), where Q=3nPA+1. If also Qu<=1, the stored point-product input norm plus one is at most (nm+2)(M+1). Applying the normalized negative transform and charging up to u for final dyadic division/rounding gives

    e_inverse <= [Q+R(nm+2)+1]u(M+1).                         (10)

The selected exact convolution outputs have norm at most nM. A final chirp gives absolute error at most (1+u)e_inverse+unM+u. Division by n in the error statement now yields the safe choice

    C_Blue=6PA+2R(2n+1)+8,
    D_Blue^safe=max(1,2k,PA,Q).                              (11)

For example, the constant part before relaxing is (n+5)/n; the +8 safely covers it for n>=2. Exact power-of-two division needs no rounding charge, but retaining the charge permits a fixed-grid implementation. P remains only an internal convolution normalization: there is no uncharged 1/n in the computed character transform.

If a cache is imported rather than rebuilt, (9) or a stronger supplied bound is mandatory. A kernel at lower precision cannot simply be relabeled as a tighter cache. Alternatively, retain its actual e_K in the displayed product recurrence. Both setup gates and final kernel boxes must be checked against the intended chirps/DFT.

## 5. Whole character transform and a sufficient precision choice

Let selected outer cyclic axes have coefficients C_i, and S=sum_i C_i. On the normalized product-group transform, applying (1) successively gives an intrinsic error at most

    (M+1)[product_i(1+C_i u)-1].                             (12)

If Su<=1/2, finite product expansion bounded by the geometric series gives product_i(1+C_i u)-1<=2Su. For true input bound B and input-center radius E_0, use M<=B+E_0. The final unnormalized output radius is at most

    v[E_0+2Su(B+E_0+1)].                                    (13)

Thus, for a desired normalized radius tau>0, a sufficient selection is

    E_0<=tau/2,
    u<=min(1/max_i D_i^safe, 1/(2S),
           tau/[4S(B+E_0+1)]).                             (14)

When S=0 the transform is exact and the fractions involving S are omitted. For an unnormalized budget use tau=budget/v. The conductor factor and subsequent actual-L/Hardy normalization require their own multiplication error and magnitude bounds; (13) does not bypass them. This plan neither weakens strict sign tests nor guarantees any sign margin.

## 6. Same-precision comparison on the frozen schedule

The companion rebuilds only integer factor schedules and their bound coefficients. It checks the identical canonical plan hash from the previous metadata, across 149999 conductors, 13943 distinct axis lengths and 37117 active nodes. It performs no FFT or root evaluation.

For every used axis, C_mixed<=C_old. The only raw safety-denominator increase is n=598:

    old C=1033004, new C=29358;
    old D^safe=290254849, new D^safe=366746468.

Both denominators are below 2^29, and the companion checks that ceil(log2 D_mixed^safe)<=ceil(log2 D_old^safe) for every axis. Consequently any dyadic precision chosen by (14) and rounded up to whole fractional bits for the baseline also suffices for the mixed schedule at the same input bound and tolerance. No additional fractional guard bit is required **by these sufficient bounds**.

The largest old safety denominator is 29961461170177 (45 fractional bits suffice); the largest new one is 7130494795777 (43 suffice). These safety floors are not precision prescriptions: the requested tolerance and input magnitude in (14) may require far more bits.

| Conductor | Sum C, baseline | Sum C, mixed |
|---|---:|---:|
|10007|21611516|10175952|
|100003|206316952|98039924|
|150000|4772920|50|
|262144|42|42|
|300000|4772922|52|

These are deliberately conservative error coefficients, not measured condition numbers. In particular, the coarse Bluestein norm estimates can be much looser than actual errors. A baseline using more refined data or analysis might need fewer bits than (14), in which case this same-precision conclusion does not compare with it. Generally the extra fractional bits are obtained directly by comparing the three right-hand constraints in (14), not by multiplying operation counts by a guessed precision ratio.

## 7. Intermediate magnitudes and total bit width

Fractional precision alone does not bound operands. There is a separate constructive magnitude recurrence. For stored inputs bounded by L, a radix-two stage has all outputs and its product intermediates bounded by

    L_next=(2+u)L+2u.                                       (15)

A direct r-point computation, including partial sums, is bounded by r(1+u)L+2(r-1)u. A CT node takes the first child's output bound, multiplies it by 1+u and adds u at the cross-twiddle stage, then supplies that bound to the second child; track the maximum of both child peaks and that intermediate. The semantic output bound n[L+C_n u(L+1)] from (1) may replace a looser propagated output bound without replacing the internal peak.

For Bluestein, bound the chirped inputs, propagate (15) through their FFT, and separately propagate the kernel inputs through its cached FFT. The point-product magnitude is at most

    (nL+e_F)(m+e_K)+u.

Feed this bound through all k unnormalized inverse stages in (15), then divide by P and include any final rounding; finally apply the output chirp. Internal inverse FFT values occur before division by P and cannot be bounded by the final nL merely because the answer has that scale. This procedure gives finite rational bounds for every stored complex quantity, all independent of unknown root values.

For a fixed-point representation with p fractional bits, a sufficient signed coordinate width is p+ceil(log2(max(1,L_peak)+1))+2. Exact multiply temporaries, presums and unreduced rational representations need their own larger widths. A relative-mantissa implementation must convert these magnitude bounds into local absolute gate budgets; it cannot reuse u for every operation solely because the nominal mantissa precision is unchanged.

This leaves the root's schoolbook-width sensitivity question in the correct form: the previous multiplication saving persists at equal fractional precision under this plan, but a runtime conclusion also needs actual integer-part bounds, backend multiplication costs, root construction and setup, and memory traffic. A 26-percent width tolerance is not a universal cost law or an assumed precision allowance. Different three-real-product complex formulas must prove their own intermediate and rounding contract before using the same u.

## 8. Artifacts and remaining obligations

Parent report: `MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md`, SHA256 `C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01`. Its metadata receipt is `2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F`; its independent review is `independent-feasibility/REVIEW_MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md`, SHA256 `BABEF1416D8D02864360DD523DE18F468FD0DCDD3FA5C583F6BD564C76A19AB9`.

New integer-only script: `mixed_radix_precision_metadata_20261111.py`, SHA256 `3750A9C8FD77163C878694959158762D183F1425E4F85F983230A841BAEBDC42`. New receipt: `mixed_radix_precision_metadata_20261111.json`, SHA256 `8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E`. Reconstructed plan SHA256: `fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b`.

The identities and recurrences are paper proofs; the metadata checks only their integer specialization and schedule equality. Actual root enclosures, arithmetic implementation/gate evidence, cache verification, source values, analytic remainder bounds, sign selection and Turing completeness remain separate obligations. No additional character or time output was pruned, and no spectral success or production cost has been established.
