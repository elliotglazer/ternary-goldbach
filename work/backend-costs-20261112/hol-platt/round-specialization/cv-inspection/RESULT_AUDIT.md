# Readback of the compiled one-quotient CV path

The inspect01 result supports the intended generated-code claim. No discrepancy was found in the emitted definitions or branch counts. This is an inspection of root's completed run, not a new build, numerical evaluation, or performance measurement.

| Root | Reachable code equations | Syntactic natural DIV sites | Syntactic MOD sites |
|---|---:|---:|---:|
| `cv_positive_den_div_one` | 5 | 2 | 0 |
| `cv_round_scaled_one` | 7 | 2 | 0 |
| `cv_rounded_butterfly_one` | 8 | 2 | 0 |
| stock `cv_int_div` | 4 | 4 | 2 |

These totals count each reachable equation once, not each runtime call. The stock closure's zero count for nested `cv_int_div` calls does not mean it omits signed division: the inspected root is itself `cv_int_div`.

## Actual branch structure

The generated helper tests `cv_int_lt cv_n (Num 0)`. Its negative branch contains exactly

```
cv_div (cv_sub (cv_abs (cv_int_neg cv_n)) (Num 1)) cv_d
```

followed by integer negation and addition of negative one. Its nonnegative branch contains exactly `cv_div (cv_abs cv_n) cv_d`. Each branch contains one natural DIV; neither contains MOD. Its other reachable definitions are `cv_int_lt`, `cv_int_add`, `cv_int_neg`, and `cv_abs`; these add no DIV or MOD sites. Neither the helper nor its enclosing rounding/butterfly closure contains a call to `cv_int_div` or `cv_total_int_div`.

The generated round function passes the exact numerator `2*r+s` and absolute magnitude of `2*s` to this helper. The successful core theorem supplies equality to the original rounding function for positive integer scale. There is no change to tie handling.

For the stock divider, the outer else branch is the nonnegative-denominator branch. Its inner then branch, selected by a negative integer numerator, contains one `cv_div` and one `cv_mod`; its inner else branch contains one `cv_div` and no MOD. Positive scale ensures the denominator is strictly positive, so this is the relevant comparison.

`Compute.sml` dispatches `If` by first evaluating its condition and then evaluating only the selected branch. The generated butterfly binds two calls to `cv_round_scaled_one` in separate lets. Consequently, for well-formed encodings of the integer-pair arguments and positive scale, this generated path dispatches two natural quotient operations and no remainder operation per butterfly. The corresponding original signed-division path dispatches two quotient operations plus zero, one, or two remainder operations, according to the signs of the two adjusted numerators. Malformed raw CV encodings are outside this claim; their pair-check fallback branches need not execute the butterfly body.

This describes evaluator operation dispatch, not the bigint implementation's internal instruction count, elapsed time, or a speedup. Magnitude extraction, sign tests, predecessor subtraction, and correction remain. The count of negative adjusted numerators in the numerical fixture has not been measured by this audit. The dependent benchmark still must validate the actual full workload and report setup, evaluation, transport, controls and export separately.

## Evidence and scope

The run log ends in `HOL4_ROUND_CV_INSPECTION_DONE` after all four case markers. The root-produced before/after dependency checks match all four compiled core/CV object/data files; the source check matches the inspector, Holmakefile and runner. The core/CV source pins in round03 are unchanged. No source or result object was edited by this readback.

- `inspect01_run.log`: `E2558D2A2E487EEB77112B452F02171EE18F939F333753B50FAE55ABB520CEA7`.
- `inspect_cv.sml`: `327ECF6F9C9EFD48B7BF198CE6021A33B1022E76EC4EF35008D9CE48BC7D5687`.
- Core source: `37CB4079D95F48B1F1FF9974525C909DDA21F829FD39FB341027EB9CD5380DAF`.
- CV source: `269681276C74C1EE027CD31A8C146EE38D896BC7CE1C4166DB24E90EB72CD336`.
- Pinned HOL `src/thm/Compute.sml`: `7DAB9DD6E848FDFE2EB7869865031CFDADBA44A2FB3D7E74D98CEA77F712E059`; `exec` selects one If branch, `Let` evaluates its bound expression once, and `do_div`/`do_mod` are separate dispatcher implementations.

The failed initial search for Compute under `src/prekernel` was corrected to the actual `src/thm/Compute.sml`; it performed no execution or mutation.
