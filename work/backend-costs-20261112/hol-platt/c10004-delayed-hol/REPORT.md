# Delayed five-point transform on eight actual heights

Scalar execution took 0.026609 kernel CPU seconds for 64 five-point transforms. Across those same 64 transforms, four-lane packing took 0.041428 seconds and eight-lane packing took 0.046803 seconds. Each packed mode cost more kernel time on all eight matched input leaves. This comparison covers the depth-one numerator arithmetic at conductor 10004. The larger fused transform and final-sign consumer have different cost structures.

The source slab supplies actual nearest-p81 input centers at height indices 1 through 8. The fastest axis is the sign axis. Within the first C40 row, take differences of successive source pairs. For each t from 0 to 7 the genuine CT leaf contains differences at the five indices t+8j, j=0,...,4. The benchmark evaluates all five frequencies for every leaf, as the parent transform needs all child labels. The eight leaves contribute 320 complex scalar outputs per representation. The scalar and packed modes use identical root-center numerators, exact three-product rotations and no intermediate rounding. All coordinates share denominator 2^81 relative to input-grid units. Special rotation by 1 uses an exact scale.

Python compared every result from the parent's delayed transform to the four-real-product DFT sum computed from the same p81 root table, unpacked every lane, checked exact signed numerators, and compared the final nearest-integer rounding. Lane spacing was 168 or 176 bits. The producer's bounds used 13 times the maximum input component and an extra 81 delayed scaling bits. HOL evaluated 88 closed terms returning five signed integer pairs each, discharged hypotheses and compared every coordinate structurally. Integer inputs in multiheight terms are the signed packed coefficients supplied by Python. This checks the CT numerator. The HOL run does not establish the general packing theorem, root truth, outward analytic radius, or final rounded p81 conclusion.

| CPU seconds per 64 equivalent scalar transforms | Scalar | Four lanes | Eight lanes |
|---|---:|---:|---:|
| Construct input and expected HOL terms | 0.036078 | 0.060374 | 0.080242 |
| Prepare CV input and select equations | 0.276419 | 0.275619 | 0.270955 |
| Stock CV evaluation and conversion-rule application | 0.026609 | 0.041428 | 0.046803 |
| Decode and discharge premises | 0.180634 | 0.350384 | 0.237469 |
| Structural equality checks | 0.004505 | 0.003474 | 0.002925 |
| Kernel microseconds per scalar-equivalent transform | 415.77 | 647.31 | 731.30 |

The full build used 8.03 user and 4.46 system seconds, 39.20 wall seconds and 528,048 KiB RSS. Source loading, Python reference generation and creation of the term fixture used 0.15625 CPU seconds in a separate process. HOL cold startup, dependency scans and theory export appear in the full-build measurement. The three modes were interleaved by source leaf; the process retained stock translation caches. Numeric library root and source proofs were outside the run.

Given p81 boxes for the input coordinates and root table, the input error for the five actual sign differences is at most 10 grid units in complex norm by the triangle inequality. An exact partial rotation of an approximate difference carries this input error with unit norm. Each nonspecial root's p81 representation contributes at most the norm of its input difference divided by 2^81 in grid units. Final nearest coordinate rounding contributes at most one more grid unit in complex norm. This radius argument is conditional on the stated boxes. No delayed-intermediate truncation contribution is needed at this single level.

The data hashes appear in inputs.json and result.json. generate.py generates terms.txt and LeafPriceScript.sml from the supplied roots, actual data, and bench.smlfrag. leaf02.log and leaf02_theory.time are the successful run. The earlier leaf01 run used the same input values but omitted premise discharge and failed the acceptance check.
