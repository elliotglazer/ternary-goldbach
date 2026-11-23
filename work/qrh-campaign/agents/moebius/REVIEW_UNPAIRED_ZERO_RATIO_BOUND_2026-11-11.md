# Independent review: unpaired zero-ratio integral

2026-11-11. **PASS at the stated paper-lemma and source-API scope; no correction required.**

Author artifact: `prime-estimates/UNPAIRED_ZERO_RATIO_BOUND_2026-11-11.md`, SHA256 `D315AE5C7B98C8A8E1042FE548B7A5FB704CEB200CFA48E36509A5A23910DB1B`. I read the full frozen note, independently reconstructed its inequalities, and read the relevant pinned Mathlib declarations and immediate bodies. No analytic values, numerical tests, Lean declarations or builds were produced. This review establishes neither the completed-L Hadamard identity nor a Turing allowance.

## Integral and singular points

For a>0 and real y, set z=a+iy. The difference log|z+t|-log|z-t| is integrable on [0,1]: for y!=0 it is continuous; for y=0 the only possible singularity is the translated logarithm at t=a. That logarithm is absolutely integrable, including when a=1 is an endpoint. Changing the value at that singleton does not change the Lebesgue/interval integral.

The comparison using log|(z+t)/(z-t)| is only almost everywhere when z-t can vanish. The author explicitly retains this qualification. Norm squares differ by4at, so the integrand is nonnegative almost everywhere. Increasing y^2 decreases the ratio expression away from t=a. Thus the integral is bounded above by its y=0 value without either a pointwise false statement at a singularity or an unproved differentiation under the integral.

## Formula and unique maximum

Independent substitution in the primitive u log|u|-u gives

    F(a)=(a+1)log(a+1)+(a-1)log|a-1|-2a log a.

The linear terms cancel. This formula holds on both sides of a=1; the zero-times-log term is its continuous extension. Differentiating at a!=1 gives log|a^2-1|-2log a=log|1-1/a^2|. For0<a<1 the derivative changes from positive to negative exactly at a=1/sqrt2. For a>1 it is negative. Continuity at1 joins the two decreasing pieces, so this is the unique global maximum on a>0, not merely a stationary point.

Writing s=sqrt2, the two endpoint logarithms at the maximum use (s-1)(s+1)=1. Their log s coefficients cancel and the remaining coefficient of log(1+s) is2. Therefore F(a)<=2log(1+sqrt2). The bound sqrt2<3/2 and the three nonnegative terms of exp1>=1+1+1/2 prove the strict bound F(a)<2 without numerical logarithms. No endpoint at a=1/2 or3/2 creates a competing maximum.

## Split and constant4

Let r2=a^2+y^2. It is positive. When r2<=2a, the strict bound J<2 and4a/r2>=2 give the conclusion; equality at the splitting surface is included.

When r2>2a and0<a<=3/2, multiplying by a/2 gives a^2<(a/2)r2. Hence

    y^2>r2(1-a/2)>=r2/4>0.

There is no singularity in this branch. Applying log(1+u)<=u gives integrand<=2at/y^2. Its integral is a/y^2<4a/r2. The endpoint a=3/2 is valid; negative y is harmless. Thus the stronger claimed domain0<a<=3/2 really is supported, and the required closed domain[1/2,3/2] follows.

## Zero-sum scope

Substitution a=3/2-beta, y=t-gamma uses only0<=beta<=1. Every individual summand satisfies the comparison with4Re(1/(3/2+it-rho)). The denominator cannot vanish because its real part is at least1/2. Any finite list with nonnegative multiplicities is admissible, even if it is not invariant under reflection or conjugation. An ordinate gamma=t is also permitted; the preceding logarithmic singularity treatment covers it.

For an infinite collection, positivity permits monotone convergence after assigning a harmless value on the countable singular set. Finiteness of the positive resolvent sum is a separate requirement. This argument neither identifies that sum with a logarithmic derivative nor proves a canonical-product normalization, a constant term, or interchange for a different signed/complex series. The author states these boundaries correctly. No zero-pairing or simplicity hypothesis is hidden in the scalar result.

## Source verification

All seven source SHA256 values in the author's ledger were independently recomputed and match. They refer to the stated Mathlib tree at commit `56a005855ea17e0b0958f73ec801ae140b0a1679`. The declarations inspected are:

- `Analysis/SpecialFunctions/Integrability/Log.lean:48`: the real-meromorphic norm-log integral theorem is polymorphic in a real normed space, so it can accept complex-valued affine functions after their real analyticity/meromorphy is supplied.
- `Analysis/SpecialFunctions/Integrals/Basic.lean:278-307`: the all-real-endpoint log primitive uses Mathlib's even real logarithm and includes the zero endpoint.
- `Analysis/SpecialFunctions/Log/NegMulLog.lean:45`: continuity of x*log x on all real inputs supplies the missing-point extension.
- `Analysis/SpecialFunctions/Log/Deriv.lean:53`: derivative of log at a nonzero real input; it does not require positivity.
- `Analysis/SpecialFunctions/Log/Basic.lean:307`: log x<=x-1 for x>0.
- `Basic/Complex/Basic.lean:516,686`: actual norm-square and inverse-real-part formulas match the requested algebra.
- `Analysis/Complex/Exponential.lean:249`: the finite nonnegative exponential sum gives the three-term bound used above.

These APIs are ingredients, not an already implemented theorem for J. Affine substitutions, almost-everywhere equalities, monotonicity across the puncture, and the final real inequalities still need formal assembly. No additional source assumption or theorem-name mismatch was found.
