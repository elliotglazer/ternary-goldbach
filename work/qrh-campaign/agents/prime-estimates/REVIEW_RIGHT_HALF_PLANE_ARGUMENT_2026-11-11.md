# Independent review of the right-half-plane argument adapter

Date: 2026-11-11. Reviewer: prime-estimates agent, independent of the root-authored adapter and scalar script.

**Verdict: PASS, conditional on the explicitly retained EM endpoint, path/branch theorem, analytic count formula, and Binet allowance.** No mathematical or scalar-arithmetic defect was found. This review does not certify the EM calculation anew, prove a zero-count theorem, or establish a Lean implementation.

## Reviewed artifacts and scope

The following exact files in `work/qrh-blueprint/elementary-argument` were hashed before inspection and after replay:

| File | SHA256 |
| --- | --- |
| `RIGHT_HALF_PLANE_ARGUMENT_2026-11-11.md` | `29E860455878D580B3F7E359318EDE37FEAAC0AFABECAD22E6163CE12AD65C86` |
| `check_top_argument.py` | `F411792FCC2D1F960F1F5BD43F530F6AC44974CCFF647F2A6FB11E610A65DD31` |
| `check_top_argument.json` | `331CE3D0C1325F226F168B572D77D9590B29D4BA9BC539CF44C15F3D5A2F37B3` |

Their pinned input is `agents/zero-sum/em_top_horizontal_20261111.json`, SHA256 `9F8D349077CEA0598C50C61377C80A0098FFBB0EF723A0A68D85A18FC73AEC26`. The actual input has `T=1000000`, PASS status, and six blocks. Its endpoint rectangle at `1/2+iT` has ordered real and imaginary intervals and a strictly positive lower real endpoint. Hash and schema checks identify this accepted external enclosure; they do not prove the enclosure's analytic validity.

The original script writes its receipt when run. To preserve the frozen output, my replay imported the original script without invoking `main`, retained its already resolved input path, and redirected only its output `__file__` location to this review directory before calling `main`. The resulting owned copy is byte-identical to the frozen receipt. All three original hashes were unchanged afterward. No Lean command, dependency modification, frozen-file write, or new zeta/EM evaluation occurred.

## Principal argument and the right-half-plane condition

I inspected the actual pinned Mathlib sources at commit `56a005855ea17e0b0958f73ec801ae140b0a1679`:

* `Analysis/SpecialFunctions/Complex/Arg.lean:217`, `Complex.tan_arg`, gives `tan(arg z)=Im(z)/Re(z)`.
* In the same file, `abs_arg_lt_pi_div_two_iff:399` has the exact right side `0<Re(z) or z=0`. The note uses only the first alternative. A strictly positive real part excludes zero, so the extra totalization case causes no defect.
* `Real.arctan_tan` requires the angle to lie strictly between `-pi/2` and `pi/2`; the preceding result supplies both inequalities.
* `Analysis/SpecialFunctions/Complex/Log.lean:35`, `Complex.log_im`, identifies the imaginary part of the actual principal complex logarithm with `arg`.

Therefore `arg z=arctan(Im(z)/Re(z))` is correct on the stated open right half-plane. It is not a formula for arbitrary nonzero complex numbers. The interval division is valid because the entire real-coordinate interval is strictly positive. Four-corner rational multiplication with the reciprocal interval accounts for either sign of the imaginary part. Monotonicity of arctangent then permits separate endpoint certificates for the ratio interval.

This establishes the principal endpoint argument. Equating it to the continuously initialized argument in the count formula requires the accepted whole-path statement, including its initial normalization. A positive real part along the entire relevant initialized path makes the principal argument continuous there, but endpoint positivity alone does not. The note explicitly retains that path dependency, so it does not infer a winding number from a single endpoint rectangle.

## All range-reduction branches and endpoints

The four branches are correct, with no missing multiple of pi:

1. For negative `r`, `arctan(-r)=-arctan(r)` gives the negated interval with endpoints reversed.
2. For `r>1`, `arctan r=pi/2-arctan(1/r)` follows from `arctan_inv_of_pos`. The reciprocal lies strictly in `(0,1)`, so the reduction cannot cycle back to the same branch.
3. For `1/2<r<=1`, set `v=(r-1)/(r+1)`. The denominator is positive, `-1/3<=v<=0`, and `(1+v)/(1-v)=r`. The source `arctan_add` has premise `x*y<1`; taking `x=1`, `y=v` satisfies it. It yields `arctan r=pi/4+arctan v`, without a branch correction. At `r=1`, `v=0` gives the exact pi/4 case.
4. At `0<=r<=1/2`, the series is used directly. This includes `r=0` and `r=1/2`, both strictly within the convergence domain `abs(r)<1`.

For the even truncation length 80, the alternating partial sum is a lower bound at a nonnegative input, and adding the next term gives an upper bound. The gap `r^161/161` is correct. The negative-input handling applies oddness after the nonnegative enclosure, so its inequality direction is also correct. The series and sign identities are the same pinned APIs independently reviewed in the interval-primitives plan.

The pi interval uses `16*arctan(1/5)-4*arctan(1/239)`. Its negative coefficient uses the upper arctangent endpoint on the lower pi side and the lower endpoint on the upper side. No decimal pi constant is assumed.

## Logarithm, positive product, and exact integer extraction

The script's `log_unit` computes

`2*sum_{j<N} t^(2j+1)/(2j+1)`

with the upper remainder

`2*t^(2N+1)/((2N+1)*(1-t^2))`,

where `t=(y-1)/(y+1)` and `1<=y<=2`. Thus `0<=t<=1/3`, the denominator is positive, and the exact existing `RamPf.log_one_add_inv_bounds` applies after the substitution described in the interval plan. At `y=1` both the sum and tail vanish. The binary scaling keeps `x=2^k*y`; negative `k` correctly reverses the log2 interval through signed interval multiplication.

The real value `x=T/(2*pi)` is enclosed by positive interval division, then its enclosure is rounded outward to 30 decimal places with exact rational floor and ceiling. The script computes a lower logarithm at the new lower endpoint and an upper logarithm at the new upper endpoint. Its explicit test that the lower log bound exceeds 1 ensures both `x` and `log(x)-1` are positive throughout the interval. The product of the lower endpoint bounds is therefore a lower bound on `x*(log x-1)`, and the product of the upper bounds is an upper bound. No missing negative-factor sign case or midpoint approximation enters the formula

`F(T)=x*(log x-1)+7/8`.

The argument interval divided by the positive pi interval encloses `S`. Four-corner division remains sound even for a signed argument interval. Adding the accepted analytic error allowance `[-1/8,1/8]` yields the count interval.

For an integer `N` lying in `[L,U]`, one has `ceil(L)<=N<=floor(U)`. Equality of those two exact integers therefore isolates the count. The source script checks equality rather than comparing with a historical hard-coded zero count. Its result is `1747146`. The recorded rounded interval is approximately `[1747145.8749999934,1747146.1249999934]`; the actual extraction uses exact rational endpoints before rounding. The displayed endpoints also have the same ceiling and floor.

This extraction is conditional on an integer-valued count satisfying the normalized analytic formula and the stated error allowance at this height. It does not prove the count formula, top-boundary nonvanishing, or the Binet allowance. Those remain external/paper dependencies as stated by the author.

## Independent alternate calculation

The new owned script `review_right_half_plane_replay_20261111.py` first reproduces the original result, then calculates a second enclosure using a different arithmetic schedule:

* Machin arctangent lengths 32 at `1/5` and 12 at `1/239`, rather than 80 at both;
* length 40 for general arctangent and atanh logarithms;
* successive-term recurrences rather than separate powers for the series terms;
* 25 decimal places for outward rounding of `x`, rather than 30;
* for `1/2<r<=1`, the distinct identity `arctan r=arctan(1/2)+arctan((r-1/2)/(1+r/2))`, whose second argument lies in `(0,1/3]` and satisfies the `arctan_add` premise.

The alternate run again isolates `1747146`. Its outward-rounded rational count interval is

`[87357293749999668427146549/50000000000000000000,`

` 174714612499999336854514469/100000000000000000000]`.

Ten nonnegative rational arctangent tests, together with their negative counterparts, include exact branch endpoints and points immediately to either side of `1/2` and 1. The alternate and original enclosures overlap, oddness holds exactly, and the alternate widths are less than `10^-23`. Six positive log tests include values below 1 and exact binary boundaries, so negative and positive binary scaling are both exercised. These tests support the arithmetic implementation; the mathematical identities above establish the branch rules.

The complete bounded review run exited 0. It used rational and integer arithmetic only. It accepted the same pinned endpoint rectangle and did not call a floating-point elementary function, FLINT, a zeta evaluator, a Gamma evaluator, or a zero-count helper.

Evidence pins in this owned directory:

| Artifact | SHA256 |
| --- | --- |
| `review_right_half_plane_replay_20261111.py` | `38C852C4742AF1A94E123024ACDEB7AC294B83E0D55CC187BCEB1EC4C53AAB36` |
| `review_top_argument_original_replay_20261111.json` | `331CE3D0C1325F226F168B572D77D9590B29D4BA9BC539CF44C15F3D5A2F37B3` |
| `review_right_half_plane_comparison_20261111.json` | `45890FDA8E7F766063CF8ADDD4FF0D5A2E7695C9F1626301F74A6ACE36494FB2` |

No correction to the reviewed root files is requested. The accepted result is an exact elementary scalar replay and a source-faithful right-half-plane argument adapter on paper. Its future Lean checker and its EM, branch, count-formula, and error providers still require proof and audit; no such premise may be added to the final Goldbach theorem as a substitute for those proofs.
