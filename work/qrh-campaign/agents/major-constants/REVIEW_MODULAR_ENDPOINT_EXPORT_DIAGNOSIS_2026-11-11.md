# Review of the first-edge endpoint-export diagnosis

2026-11-11. **PASS for the stated single-edge external representation diagnosis.** No correction is requested. This explains the failure at `points[0].steps[0]` only. It does not repair or accept the full modular operation receipt, the other translation failures, or any root-component quotient failure.

## Frozen inputs and independent check

All paths below are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
| --- | --- |
| `mellin/MODULAR_ENDPOINT_EXPORT_DIAGNOSIS_2026-11-11.md` | `C25E171FBDF9A8689CD7D2ACB99F85828534F6C6286D82A895384343109C4DC3` |
| `mellin/modular_endpoint_export_diagnosis_20261111.py` | `59B922F743FC3906E944A459D873F5FA4A545A880E0FE37ED9D3C6E7ABE3822F` |
| `mellin/modular_endpoint_export_diagnosis_20261111.json` | `6CEA85CA705494E5DD20751722FF620CB6F7AF72EE898EE8C3D680F77DE4011F` |
| Frozen original four-point input | `C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF` |
| `major-constants/review_endpoint_export_20261111.py` | `6A4EF78E7B494DD7E1F4E2E67D47E64247C86216D946A285D86A6EBA95A26C34` |
| `major-constants/review_endpoint_export_20261111.json` | `015CE1317AE718CBC7E71DB3BC3EDBDC8205F1279446EE494BAE947822525D30` |

I read the note and complete diagnostic script, inspected the original producer at `run_point` lines 188–191 and `binary` lines 51–56, and checked the installed API docstrings directly. I wrote and ran a separate bounded script. It does not import the author's diagnostic or execute the full producer. It constructs only the first input expression at the original 256-bit precision and adds one. All four exported real/imaginary endpoint pairs match the frozen edge.

The independent script passed 62 checks, including input pins, exact midpoint/radius values, exported endpoints, both coordinate translations, export inflation, the lossless mathematical payload, bit lengths and re-export of the same existing input ball at 283 bits. All subsequent arithmetic on extracted values uses exact Fraction arithmetic with an explicit exponent bound of 1,024. This edge has modest exponents; no huge-denominator endpoint from the rest of the receipt is expanded. No reduction loop, theta series, derivative unwind, node grid, FFT, Lean build or full pilot was run.

## Exact mechanism

Write the real input ball as `[m-r,m+r]`. The diagnostic's extracted radius is

```
r = 134742021 * 2^-283.
```

The independently reproduced output midpoint is exactly `m+1` and its radius is exactly `r`. The imaginary midpoint and radius do not change. Thus the internal interval operation is exact translation of the entire input ball in both coordinates.

The input's exported endpoints are instead

```
[m-r-d, m+r+d],     d = 133693435 * 2^-283 > 0.
```

The output's exported endpoints equal its exact internal endpoints. Consequently each exported translation boundary is inward by exactly `d`. This is the same exact deficit independently found in `REVIEW_COMPACT_DYADIC_RECEIPT_PILOT_2026-11-11.md`, SHA `18A09166EEE647E126BF29434F81600B5A5653E7987AA0F7C37352B4DA3817FF`.

The claimed width ratio follows directly:

```
r+d = 268435456 * 2^-283,
exported_width / internal_width = 268435456 / 134742021.
```

The exact input endpoints need 283 normalized mantissa bits, while the output endpoints need 245. The separate script changed the precision only after constructing the ball, then verified that `.lower()` and `.upper()` on that same object at 283-bit precision equal the exact `m-r` and `m+r`. It restored the previous precision afterward. No analytic value was recomputed for this re-export test.

## API and mathematical interpretation

The installed `arb.mid()` and `arb.rad()` docstrings promise exact arb values for the midpoint and radius. `man_exp()` requires an exact finite value and decomposes it into integer mantissa and exponent. By contrast, `.lower()` and `.upper()` explicitly round toward negative and positive infinity at the current precision. The stored endpoint is exact after that rounding; it need not equal the original ball's exact boundary.

These API contracts, the reproduced internal values, and the exact algebra above support the claimed explanation for this edge. They remain facts about an external library execution. This review does not verify the implementation of Arb or prove that the initial trigonometric ball encloses the intended mathematical value. That analytic premise is neither needed nor established to diagnose the mismatch between two representations of the same computed ball.

The original receipt's rejection remains correct. A certificate whose operands are the exported endpoint intervals must enclose the operation on every element of those intervals. Running an operation on a narrower internal ball and then exporting its result does not supply that implication merely because both exports may contain the intended point.

## Lossless payload and limits

The proposed center/radius payload denotes exactly the real interval `[m-r,m+r]`, with both entries represented by signed dyadics and with radius required to be nonnegative. The proposed exact endpoint payload is mathematically equal to it, as independently checked for both coordinates of this edge. Either representation can therefore express an exact translation witness for this one operation.

This is an assertion about the payload's declared mathematical semantics. It is not a promise that any external `arb(mid,rad)` constructor recreates the same internal representation without widening. A consumer must prove its decoding semantics. Similarly, forming exact endpoint mantissas by aligning arbitrary midpoint and radius exponents can require large integers on other data; this edge's small endpoint sizes do not establish a general compactness bound. Retaining the center/radius pair avoids imposing that expansion at serialization time.

A fixed larger export precision is not a general repair. Exactness must be shown for every exported boundary, or the producer must operate on the actual exported intervals and propagate their widths. A new trace or dependency-aware certificate would then need its own complete operation and analytic checks.

The evidence reviewed here is limited to the first translation. The other 13 failed nonzero translations, the three failed root-component quotient enclosures, and the 24 uncertified coarse reciprocal tests retain their prior status. No full-graph repair, spectral assertion, runtime forecast, or Lean acceptance follows.
