# Independent review of the original reciprocal edges

2026-11-11. **PASS for the diagnostic's complete 24-operation classification.** Independently recomputed exact ranges agree: 22 operations pass full-input containment and two fail. Both failures are imaginary upper bounds of modular inversion outputs. All twelve reciprocal root-factor operations pass. No correction requested. This is an arithmetic statement about the unchanged exported boxes, not a contradiction of any intended analytic point value.

## Frozen evidence

Paths are relative to `work/qrh-campaign/agents/`.

| File | SHA256 |
| --- | --- |
| `prime-estimates/ORIGINAL_RECIPROCAL_EDGES_2026-11-11.md` | `289A090FD9C0307B09B79A82AC42E03792A1CCF73977411E95EDB1C5E2B80E68` |
| `prime-estimates/original_reciprocal_edges_20261111.py` | `1BF4CBF3EB3364FCABE7C19EB3B121228AF5F14884A005AFA944049B8449CF88` |
| `prime-estimates/original_reciprocal_edges_20261111.json` | `12E011FD7F68CE6FFEC8BD8BF5659FD13A9EA804D0C8EFA35ECA7F70F27C6078` |
| Original `prime-estimates/principal_theta_modular_pilot_20261111.json` | `C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF` |
| Independent `independent-feasibility/review_old_reciprocal_operations_20261111.py` | `C9FBD0525E669D7430E4EA6C61D4F6B1727F67A84C08D2047D961B295C74426C` |
| Independent receipt, same stem `.json` | `495D42E1FAE4B01AF3A51756599B71AC2BF00DAAC051E7AF011D396FFBF52804` |

The exact criterion is the separately reviewed `COMPACT_RECIPROCAL_RECTANGLE_2026-11-11.md`, hash `53E2BCD126E06BCB280F579352BEB05BCB1C939AE4ACC97661F0525B3486434F`. Its independent review has hash `9E7C5548435232AA0660A568F0C6DEF5C0CB9F2DFD9184EDCCFAABDF8FE27675`. The current work applies that criterion; it does not change its domain or arithmetic semantics.

I read the new report and full implementation, then independently checked every operation and every stored candidate. The script verifies the five relevant input/code/report pins before and after its run. No original or producer file was modified. Only the new independent script, receipt and review were written.

## Complete range computation

The independent checker visits every S step in all four original points. For each it reads exactly the original `binary_re` and `binary_im` endpoint pairs of the input, S output, root and A fields. It never replaces them with regenerated balls, presentation intervals, or inferred internal endpoints. It checks input order and exclusion of zero.

All these endpoints have modest exponents: the largest absolute exponent is 283 and the largest mantissa is 256 bits. Therefore every operation could be checked by exact rational arithmetic without using a large-exponent approximation. The explicitly guarded conversion accepts absolute exponents and mantissa widths at most 4096; these particular inputs are well within that bound. The reciprocal candidate values used at most 559 numerator bits and 557 denominator bits.

For a rectangle excluding zero, the reciprocal's real and imaginary coordinate extrema occur among corners and stationary points on edges. The independent implementation uses the union of both coordinates' candidate sets: on each fixed-x edge, y is an endpoint, zero or ±x when in range; on each fixed-y edge, x is an endpoint, zero or ±y when in range. Every included point belongs to the original rectangle. The required extrema are included, and extra valid candidates cannot alter the true extrema incorrectly. This also covers degenerate rectangles.

At every candidate it directly evaluates `(x/(x²+y²), -y/(x²+y²))` and applies the requested reciprocal sign. It then compares the exact component minima and maxima with the original output bounds. This mathematically different procedure agrees with the compact quadratic test on all 24 operations.

## Exact failures

Indices below are zero-based, as in the receipt. Every reciprocal gate other than the two listed passes. In particular, all twelve `A=1/root` gates pass, and ten of twelve `S_output=-1/input` gates pass.

| Point | T | r | Step | Violating input point | Failed original bound | Exact positive-gap bound |
| ---: | ---: | --- | ---: | --- | --- | --- |
| 0 | 1000000 | 0 | 1 | `(input.re.lo, input.im.lo)` | S output imaginary upper | `2^-245 <= gap < 2^-244` |
| 1 | 1000000 | 1/8 | 3 | `(input.re.hi, input.im.hi)` | S output imaginary upper | `2^-270 <= gap < 2^-269` |

Here `gap = y/(x²+y²) - output.im.hi`. Both gaps are strictly positive by exact rational comparison. The independent receipt retains each x, y, reciprocal value, claimed bound and gap as a complete rational, together with the endpoint labels and binary brackets above. The six literal dyadic witness values printed in the author's note were independently parsed and checked against these original endpoint values. They agree exactly.

The equivalent denominator-cleared residual is `U*(x²+y²)-y<0`, where U is the original imaginary upper endpoint. The first case has the inactive x interval positive and positive active derivative at both endpoints, giving the lower/lower corner. The second has the inactive x interval negative and negative active derivative at both endpoints, giving the upper/upper corner. These are not samples near a suspected extremum; they are exact contained points which violate the advertised bound.

## Every stored residual and witness

The independent replay checks all 96 coordinate-bound rows and all 240 stored candidate records. It reconstructs each coefficient from the original input/output boxes rather than trusting the recorded a and b. It checks active-axis selection, normalized side and original-output side. In particular the two failed normalized imaginary lower bounds become original imaginary upper bounds after output reflection for `-1/z`.

For every candidate, the replay verifies membership in the relevant original rectangle, all dyadic residual terms, their exact sum sign, and any recorded endpoint derivative signs. Symbolic interior vertices are interpreted as their stated numerator divided by a checked positive denominator. Their clearing multiplier is checked equal to positive `4a`; other candidates use multiplier one. Exact rational minimization confirms that the minimum over the recorded candidates equals the global separable quadratic minimum on that rectangle. The redundant negative-candidate lists also match their source records. Exactly two candidates are negative, in precisely the two failed rows above.

## Preserved scope and earlier status

The result replaces 24 coarse-rule non-certifications with an exact classification. It does not turn the original four-point packet into a fully valid arithmetic trace. Its previously identified translation and root-component quotient failures remain unchanged, and two reciprocal full-box conditions now have explicit counterexamples.

A true analytic input may occupy only a correlated subset or use different internal bounds. The new counterexamples prove that the displayed input rectangles are too broad for the displayed output rectangles under this full-set contract. They do not prove that the intended input equals either counterexample, or that any intended analytic output is false. No new analytic value or modular trajectory was generated.

The separately accepted `LOSSLESS_SEED_TAYLOR` supplement and the accepted lossless first-step gates retain their existing paper/external-arithmetic status. The old receipt's original seed label does not reopen that separate local seed obligation. Conversely, that supplement does not repair these unchanged older exported endpoints. No Lean build, kernel proof, analytic certification, or production scan was performed here.
