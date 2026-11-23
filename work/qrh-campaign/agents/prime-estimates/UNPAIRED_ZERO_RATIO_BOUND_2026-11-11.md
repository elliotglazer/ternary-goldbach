# An unpaired zero-ratio integral bound

2026-11-11. Independent derivation of the scalar lemma proposed by major_constants. Verdict: the proposed inequality is correct, including real singularities and closed endpoints. This is a paper proof with a source API map, not a Lean theorem. No numerical function evaluation, scalar program, spectral computation or build was run.

## Statement and integral convention

For real a,y with 1/2 <= a <= 3/2, let z=a+iy and define

    J(a,y) = integral_0^1 [log|z+t| - log|z-t|] dt.

Then

    0 <= J(a,y) <= 4*a/(a^2+y^2) = 4*Re(1/z).           (1)

The same proof actually works for 0 < a <= 3/2. The stated closed strip suffices for a=3/2-beta with 0 <= beta <= 1. No pairing with a conjugate or reflected zero is needed.

The displayed difference is the intended real log-norm integral. Away from z-t=0 it equals log|(z+t)/(z-t)|. If y=0 and a belongs to [0,1], the denominator vanishes only at t=a. Assigning any finite value there does not change the integral. In particular, a formalization may use totalized complex division and real logarithm, provided it proves equality almost everywhere. It must not assert the quotient identity or the comparison below pointwise at that exceptional point.

If y is nonzero, both log-norm terms are continuous on [0,1]. If y=0, the numerator is strictly positive, and the only possible singularity is log|a-t|. This is absolutely integrable, including at a=1. A translation of the real logarithm's interval-integrability theorem suffices. Alternatively, both affine complex functions are real-meromorphic, so `MeromorphicOn.intervalIntegrable_log_norm` applies separately. Their integrable difference defines J. The difference is nonnegative almost everywhere because |z+t|^2-|z-t|^2=4at >= 0.

## Exact real-axis maximum

For any a>0, direct integration of the two real logarithms gives

    J(a,0) = F(a)
           = (a+1)log(a+1) + (a-1)log|a-1| - 2a log a. (2)

At a=1 the middle summand has value zero, and F(1)=2log2. The formula holds across the singularity: use the antiderivative u log|u|-u on each side, or the existing real `integral_log` theorem, which is valid for arbitrary real endpoints under Mathlib's even real-log convention. No improper differentiation under an integral is needed.

The function u log|u| extends continuously through zero with value zero. Hence F is continuous at a=1. Off a=1,

    F'(a) = log|1-1/a^2|.

For 0<a<1, this is log(1/a^2-1). It is positive for a<1/sqrt2, zero at 1/sqrt2, and negative for 1/sqrt2<a<1. For a>1 it is log(1-1/a^2)<0. The derivative sign criterion on each interval, followed by continuity at a=1, therefore proves that F attains its unique global maximum on a>0 at a*=1/sqrt2. In particular it is the maximum on [1/2,3/2], since 1/2<a*<1.

To evaluate it, put s=sqrt2. Then

    a*+1=(1+s)/s, 1-a*=(s-1)/s, (s-1)(s+1)=1.

Substitution in (2) cancels all log s terms, while log(s-1)=-log(s+1). The remaining coefficient is 2, so

    J(a,0) <= 2log(1+sqrt2) < 2.                       (3)

The strict comparison needs no numerical logarithm: sqrt2<3/2, so 1+sqrt2<5/2, whereas the first three nonnegative exponential-series terms give exp(1)>=1+1+1/2=5/2. Strict monotonicity of exp/log gives log(1+sqrt2)<1.

## Two-region proof

Write r^2=a^2+y^2>0. For t in [0,1] away from the possible singular point,

    log|(z+t)/(z-t)|
      = (1/2)log(1 + 4at/((a-t)^2+y^2)).               (4)

For fixed a,t>=0, adding y^2 decreases the nonnegative fraction in (4). Thus J(a,y)<=J(a,0), by an almost-everywhere comparison of integrable functions. This also covers y=0.

If r^2<=2a, (3) gives

    J(a,y)<2<=4a/r^2.

Equality r^2=2a belongs to this case, so there is no omitted meeting point.

If r^2>2a, then a>0 and a<=3/2 imply

    y^2 = r^2-a^2 > r^2*(1-a/2) >= r^2/4 > 0.

Here the strict inequality follows by multiplying r^2>2a by a/2>0. In particular this case contains no real singularity. The elementary inequality log(1+u)<=u for u>=0, applied to (4), yields

    log|(z+t)/(z-t)| <= 2at/((a-t)^2+y^2) <= 2at/y^2.

Integrating and using integral_0^1 2t dt=1 gives

    J(a,y) <= a/y^2 <= 4a/r^2.

Together with nonnegativity this proves (1). Negative y causes no new case, since all expressions depend only on y^2. At a=3/2 the final weak comparison remains valid; the earlier inequality is strict. At a=1,y=0, the endpoint logarithm is handled by (2), not by (4) at its undefined point.

## What this supplies to a zero sum

For an actual zero rho=beta+i*gamma with 0<=beta<=1, put a=3/2-beta and y=t-gamma. For every finite collection with nonnegative true multiplicities m_rho,

    sum_rho m_rho J(3/2-beta,t-gamma)
      <= 4 sum_rho m_rho Re(1/(3/2+it-rho)).            (5)

The inequality includes a zero with gamma=t; no zero-free ordinate assumption is needed for this scalar integral. It neither changes multiplicities nor assumes a reflection-invariant collection. A countable passage is justified by monotone convergence/Tonelli once the corresponding positive resolvent sum is proved finite. This positivity does not itself identify that sum with a logarithmic derivative.

The actual completed-L Hadamard factorization, its normalization and any real constant in the resolvent identity remain separate obligations. So do the passage from products to the compact horizontal integral, the Gamma and Euler terms, and the normalization of the canonical argument used in Turing's theorem. This note does not certify a full lower horizontal bound, a numerical Turing constant near 20, or a conductor-uniform theorem. It removes only the need for zero pairing in this particular scalar comparison.

## Existing source interfaces and missing assembly

The source inspected is Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, physically at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib`. The following exact interfaces were read or located there.

| Source | Relevant interface | SHA256 |
| --- | --- | --- |
| `Analysis/SpecialFunctions/Integrability/Log.lean:48` | `MeromorphicOn.intervalIntegrable_log_norm`, including poles/zeros | `33FCE16F5E4A33E64411AF26FD082D6229B9576A40DBEFF295E31475BB223964` |
| `Analysis/SpecialFunctions/Integrals/Basic.lean:278-307` | `integral_log_from_zero`, `integral_log`, with `intervalIntegrable_log'` | `C629B331C62CB55824B5EF101AF0630125C376418CFCC52C729D5800D436551B` |
| `Analysis/SpecialFunctions/Log/NegMulLog.lean:45` | `Real.continuous_mul_log`, all real inputs | `AC0F7ED62CEDBD2AA3F2A1FE33B54D24AFCE21D61D300B191E17B11975C80CB3` |
| `Analysis/SpecialFunctions/Log/Deriv.lean:53` | `Real.hasDerivAt_log` at nonzero real inputs | `898A82A8DE19D9E3CF6D15B72334B9F01C778BA3A61FF686F5E6336F6DCC3665` |
| `Analysis/SpecialFunctions/Log/Basic.lean:307` | `Real.log_le_sub_one_of_pos` for (4) | `6E146766B49DD1EC13244087B3BFC64BEC34325D3A30DF2E35972B848811D94C` |
| `Basic/Complex/Basic.lean:516,686` | `Complex.normSq_apply`, `Complex.inv_re` | `C46DF05B286BD59A4725D02B9BCFA8AD9C50C7898C73FB116C11D60B758EEAE3` |
| `Analysis/Complex/Exponential.lean:249` | `Real.sum_le_exp_of_nonneg` | `564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0` |

`Analysis/Complex/Exponential.lean:249`, `Real.sum_le_exp_of_nonneg`, supplies the three-term exp(1) bound. The required new formal work is the affine log integral substitution, almost-everywhere quotient/comparison adapter, derivative-sign maximum proof, and the elementary two-region inequalities above. These are ordinary real-analysis assemblies. Their elaboration and kernel proofs have not been checked in this task.
