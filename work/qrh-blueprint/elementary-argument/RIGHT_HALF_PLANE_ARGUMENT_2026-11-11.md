# Exact right-half-plane argument and top-count scalar replay

Research derivation, 2026-11-11. No Lean declaration or verified checker is claimed. This fills the elementary complex-argument operation deliberately excluded from the interval-primitives source plan. The frozen successor package is unchanged. The new files require independent review.

## Actual function and source identities

Use Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`. The coordinator read these sources through `git show` and `git grep` at that exact revision in the existing Mathlib cache. In `Analysis/SpecialFunctions/Complex/Arg.lean`, `tan_arg` at line217 gives `tan(arg z)=Im z/Re z`. `abs_arg_lt_pi_div_two_iff` at line399 places the argument strictly between `-pi/2` and `pi/2` when `Re z>0`. `Real.arctan_tan` in `Analysis/SpecialFunctions/Trigonometric/Arctan.lean` therefore gives

`arg z = arctan(Im z/Re z)` for `Re z>0`.

`Complex.log_im` in `Analysis/SpecialFunctions/Complex/Log.lean:35` identifies this with `Im(log z)` for the actual principal complex logarithm. This is a branch-specific assertion on the right half-plane, not an arbitrary-complex-log certificate. The existing whole-panel top-path proof establishes that this principal argument equals the continuously initialized argument used by the zero-count formula. Endpoint arithmetic alone cannot establish that path statement.

For a rectangle with real coordinate `[a,b]`, `0<a`, and imaginary coordinate `[c,d]`, rational interval division encloses `Im z/Re z` by `[l,u]`. `Real.arctan_mono` then makes separately certified endpoint bounds for `arctan l` and `arctan u` into a uniform enclosure for the argument throughout the rectangle. No assumption on the sign of the imaginary coordinate is needed.

## Rational range reduction for every real argument

The source provides `arctan_neg`, `arctan_inv_of_pos`, `arctan_one`, and `arctan_add`. These give a finite reduction for any rational argument r.

1. For r<0, negate the interval for -r and reverse its endpoints.
2. For r>1, use `arctan r=pi/2-arctan(1/r)`.
3. For `1/2<r<=1`, set `v=(r-1)/(r+1)`. Then `-1/3<=v<=0`, and `arctan r=pi/4+arctan v`.
4. For `0<=r<=1/2`, use the alternating power series directly.

Step3 follows from `arctan_add` with arguments1 and v. Its premise is `v<1`, and `(1+v)/(1-v)=r`; the denominator is positive. Thus this identity has no missing multiple of pi. The exact endpoint r=1 is covered with v=0. The power-series evaluator sees only `|v|<=1/2`, strictly within its convergence domain. No square-root or high-precision complex-log implementation is required.

For even N, the partial sum `A_N(v)` at nonnegative v is a lower bound and `A_(N+1)(v)` an upper bound. Their gap is `v^(2N+1)/(2N+1)`. Negative inputs use oddness. The pinned `Real.hasSum_arctan` and alternating-series bounds listed in the interval-primitives source plan supply the analytic proof. The script uses N=80 and exact rational arithmetic.

Pi is supplied by the same finite alternating sums in Machin's identity, `pi=16 arctan(1/5)-4 arctan(1/239)`. Its interval is not an assumed decimal constant.

## Exact scalar replay at the accepted top endpoint

`check_top_argument.py` checks the SHA256 of the frozen explicit-EM receipt, requires its PASS status and six blocks, and reads the actual zeta endpoint rectangle at `1/2+i*10^6`. The receipt hash is `9F8D349077CEA0598C50C61377C80A0098FFBB0EF723A0A68D85A18FC73AEC26`. This input is the accepted external enclosure, not a new independent evaluation of zeta.

The script computes S by rational interval division and the arctangent reduction above. It independently computes the elementary main count term `F(T)=x(log x-1)+7/8`, with `x=T/(2*pi)`. After outward rational rounding of x to30 decimal places, it bounds log at both endpoints using binary scaling and the atanh series. For `1<=y<=2`, `t=(y-1)/(y+1)` lies in `[0,1/3]`, and the existing `RamPf.log_one_add_inv_bounds` gives the tail

`2*t^(2N+1)/((2N+1)*(1-t^2))`.

The exact lower logarithm exceeds1. Therefore both factors x and `log x-1` are positive and increasing, and their respective endpoint products bound F without a separate derivative theorem. Negative binary scaling exponents reverse the log2 interval endpoints through ordinary signed interval multiplication.

The final interval is `F+S+[-1/8,1/8]`. Exact ceiling of its lower endpoint and floor of its upper endpoint agree at1747146. The script checks agreement, not equality to a hard-coded historical zero count. The count interval is approximately `[1747145.8749999934,1747146.1249999934]`. The receipt stores outward rational endpoints. No floating-point arithmetic, FLINT, builtin real or complex log, Gamma, zeta, or zero-count helper is used by this scalar replay.

The script also checks interval order, oddness and a width bound on rational test arguments0,1/2,3/4,1,2,1000 and their negatives. These checks exercise the reduction branches; they are not proofs of the analytic identities. The run returned `PASS_EXACT_SCALAR_REPLAY`.

## Remaining formal obligations

The result remains conditional on the pinned EM endpoint enclosure, the whole-path nonvanishing and branch argument, the normalized analytic count formula and its Binet allowance. Those dependencies are reviewed external/paper evidence and must still be proved in Lean. This scalar script discharges none of the higher-strip location, family-wide spectral or global-provider obligations.

The new formal work is finite: rational interval semantics, alternating-sum and atanh wrappers, the branch-specific `arg=arctan` adapter, finite range-reduction soundness and exact integer extraction. It should reuse the general interval plan rather than create a second incompatible arithmetic framework. A checker implementation and kernel performance evidence remain absent. These certificates must be discharged within the final theorem, never introduced as final mathematical premises.
