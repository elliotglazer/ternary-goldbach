# Why one modular translation fails endpoint replay

2026-11-11. **The first failure is reproduced and explained exactly.** The internal ball operation is an exact translation and contains the entire actual input ball. Exporting its input through `.lower()` and `.upper()` at 256-bit precision enlarges that ball. Exporting the much smaller translated value adds no enlargement. The stored output therefore does not contain the translation of the wider stored input endpoint interval. The compact-receipt rejection is correct for its declared endpoint semantics.

This diagnosis covers one edge only: `points[0].steps[0]`, with `T=1000000`, `r=0`, `n=-1`. It does not repair or accept the main partial receipt, its other translation failures, or its root-v failures. No frozen artifact was edited, no full modular reduction or node pilot was run, and no Lean command was used.

## Frozen evidence and bounded reproduction

The helper is `prime-estimates/principal_theta_modular_pilot_20261111.py`, SHA256 `EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14`. Its frozen JSON is `C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF`. The helper's pinned analytic plan is `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D`.

New files in this directory:

* `modular_endpoint_export_diagnosis_20261111.py`, SHA256 `59B922F743FC3906E944A459D873F5FA4A545A880E0FE37ED9D3C6E7ABE3822F`.
* `modular_endpoint_export_diagnosis_20261111.json`, SHA256 `6CEA85CA705494E5DD20751722FF620CB6F7AF72EE898EE8C3D680F77DE4011F`.

The diagnostic imports the frozen helper with bytecode writing disabled and without executing its main program. At its original 256-bit precision it constructs only the initial input

`eta=1/1000001`, `tau=-cos(2eta)+i sin(2eta)`,

using exactly the helper's expression, and computes `tau-(-1)`. All four exported binary coordinate endpoint pairs match the frozen edge exactly. The diagnostic does not run `reduction`, `reduced_jets`, `unwind`, `direct`, or the four-point producer.

It then extracts exact midpoint and radius dyadics from the already-created input/output balls. The installed python-flint API documents `mid()` and `rad()` as exact arb values. Their `man_exp()` pairs are serialized in the new receipt. The local API docstrings are also retained there. These API semantics remain an external-library boundary, but all comparisons after extraction use exact Python fractions.

## Exact internal arithmetic

Write the real input ball as `[m-r,m+r]`. Its midpoint is

```
m = -3618502788658894115883252875309807478255009040731348575962372091860451815905 * 2^-251,
r = 134742021 * 2^-283.
```

The real output midpoint is

`7236991103340406211689642159677980069919050270677408386833485343 * 2^-251`.

Exact fraction arithmetic proves that it is `m+1`, and its radius is exactly the same r. Therefore the output real ball equals `[m-r+1,m+r+1]`; containment of the whole actual input ball under the operation is equality. The imaginary midpoint and radius are unchanged as well. There is no translation-rounding deficit in either internal coordinate.

## The export changes the set being replayed

The helper's `binary(x)` exports `x.lower()` and `x.upper()`, then calls `man_exp()` on those endpoint values. The installed API explicitly states that `lower()` rounds the endpoint down **to the current precision**; `upper()` rounds up. The endpoint is exact as a floating-point number after this rounding, not necessarily equal to `mid-rad` or `mid+rad`.

For this input the export inflates each side by exactly

`d = 133693435 * 2^-283 > 0`.

Thus the recorded real input interval is

`[m-r-d,m+r+d]`.

Its radius is `r+d=268435456*2^-283=2^-255`, compared with internal radius `134742021*2^-283`. Its width is larger by the exact ratio `268435456/134742021`. This is not a decimal-display effect: the discrepancy is present in the serialized binary mantissa/exponent endpoints.

The output export, in contrast, is exactly `[m+1-r,m+1+r]`: both extra export errors are zero. Subtracting the translated input endpoint interval from these bounds gives the two rejection deficits

```
output_lower - (input_lower + 1) = d,
(input_upper + 1) - output_upper = d.
```

The reason precision affects the two exports differently is also directly measurable. The exact input endpoints require 283 mantissa bits. The cancellation in `m+1` leaves output endpoints requiring only 245 bits, which fit the 256-bit export precision. Re-exporting the **same existing input ball**, without recomputing any analytic value, at 283-bit precision gives its exact `m-r` and `m+r` endpoints. The script verifies this and restores the original precision afterward.

Every stored interval can still be a valid enclosure of the particular intended analytic value. That is weaker than saying every output encloses the image of every element of the independently widened input interval. A primitive interval-operation checker requires the latter. It must not accept this failed edge merely because the producer used rigorous ball arithmetic internally or because both intervals contain the intended point.

## Lossless compact representations

A suitable next receipt design is either of the following, with explicit semantics.

1. **Exact center/radius.** Store midpoint and radius as integer mantissa/exponent pairs obtained from `mid().man_exp()` and `rad().man_exp()`. Require finite entries and nonnegative radius. The represented real set is exactly `[m-r,m+r]`; use two such records for a complex box. The replay of this T edge then passes with exact equality.
2. **Exact endpoints derived by integer arithmetic.** Given `m=M*2^e` and `r=R*2^f`, take `g=min(e,f)`. Store endpoint numerators `M*2^(e-g)-R*2^(f-g)` and `M*2^(e-g)+R*2^(f-g)` with exponent g, removing powers of two if desired. This computes the internal ball endpoints without calling precision-rounded `.lower()` or `.upper()`. The endpoints here are small compact dyadic records even though their mantissas exceed 256 bits.

The new receipt includes both proposed forms for this edge and proves that they denote the same exact sets. There is no need to expand powers of two into huge denominator strings in a production format. Conversely, simply keeping the current rounded endpoints but labeling them “internal” would change their meaning incorrectly. One may retain rounded endpoints as presentation enclosures, but they cannot silently serve as the operands of a primitive-operation trace computed on narrower internal balls.

An alternative producer could deliberately operate on the exported intervals, then export outputs wide enough to enclose those interval operations. That is a different trace and may suffer substantially more wrapping. It has not been tested here. Raising export precision to a fixed larger number is also not a general solution unless exactness or a sufficient bound is established for every node; midpoint/radius exponents can be much farther apart on other inputs.

## What this does not settle

The main pilot's partial failures must remain recorded. Lossless export explains and fixes the representation mismatch for this one translation, but a complete replay still needs operation-specific set semantics, directed rounding, principal-root branches, and the exact operand identities used by the producer. Any correlation exploited by a unary operation must be represented by that operation rather than by an unrelated interval expression. In particular, no conclusion is made here about the reported root-v division failures or the rest of the graph.

This is a bounded representation diagnosis with an exact proposed payload. It is not a verified Arb implementation, a whole-graph repair, a spectral statement, or a Lean proof. The next justified experiment is a new, separately versioned small receipt using lossless internal balls and a full operation replay; the original frozen analytic receipts and their review status should remain unchanged.
