# Q90090 small-twist certificate on a closed scale interval

Research result, 2026-11-10. This note certifies a smaller closed rectangle permitted by the assignment. It does not assert the desired all-y extension. Source pin remains `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

The exact rational interval script `base_gap_90090_certificate.py` proves the numerical comparison on

    q = 90090,
    1e25 <= y <= 1.1e25,
    1200000/49 <= u = q*|Delta| <= 26000,
    2*alpha = A/q + Delta/y modulo an integer.

Here q is the reduced denominator of 2*alpha. On the central smoothing interval .05 <= w <= 2.5, set z=w*y, T=z^(1/3), H=3*T^2/4 and

    V = floor(72*T),
    U = floor(T^2/(144*sqrt(180180))).

Use the full parameterized Type I1, small-twist Type I2 and Type II bounds, with zeta3 <= 27. On 2.5 <= w <= 8, use the original raw first-choice envelope. Use the existing trivial coefficient 17 on both omitted tails. The same exponential sum is bounded separately at each w; changing the decomposition at w=2.5 is legitimate.

The integrated normalized upper bound is at most

    58645373527 / 10^12 = .058645373527.

The independently derived lower envelope for ghat is at least

    59771184079 / 10^12 = .059771184079.

The script evaluates the difference before directed rounding and certifies a gap greater than

    1125810553 / 10^12 = .001125810553.

Thus this rectangle satisfies the unchanged base-gap consumer, conditional on the original analytic inputs of the three Type I/II lemmas. It does not increase the all-y, all-twist denominator count. No Lean compilation was performed.

## Source formulas and hypotheses

The complete formulas are those transcribed in `../moebius/BASE_GAP_90090_PARAMETERS.md`, sections 2 and 5, and implemented term by term in that worker's diagnostic `formula` function. The present script independently implements rational interval versions of:

- `TypeITotal.typeI1_le`, including every term of `bound_4_41`, both square-root error terms, and c1=1+8*log(2)*U/z;
- `TypeI2Sum.typeI2_le_small`, including both `coefUV` and `coefQ*H`, cPlus=1+8*log(2)*U*V/z, and the quadratic U,V correction;
- `TypeIITotal.typeII_637`, including both remainder terms, with zeta3 replaced upward by 27;
- `Assembly.norm_S_le_parts`, including 3*log(z)/z after normalization.

The harmless replacements muBound <= 1, minInv <= 1, and logFourierBound <= 2-log(4) are applied only where their multipliers are positive. In particular z/U>1 and V*q>1. No claim that muBound equals 1 for all scales is needed. Integer floors are enclosed by flooring the two endpoints of an interval for their arguments; they are not evaluated in floating point.

The structural hypotheses hold on the larger domain y>=1e25, .05<=w<=2.5, and the stated u-band, as proved in the source-formula note. Explicitly T>79000000, H=3T^2/4, qV<=H follows from 96q<T, and 16V<=H is weaker. The bounds

    T^2/61200 - 1 <= U <= T^2/(144*sqrt(180180))

imply sqrt(3)<=U, U<=min(z/4,z/e,H/2), and U>14T/3, hence 3.5z/U<H. Also V>=72T-1>2.5e7, V<=z/4, UV<z, and V>2eq. The approximation condition follows from |w*Delta|q=wu<=65000<(4/3)T. Finally

    |w*Delta| <= 65000/90090 < 5*sqrt(32)/(12*pi) = 1/(2*c2),

using sqrt(32)>5.65 and pi<22/7. This verifies the small-twist branch throughout the central interval. On the upper interval w<=8, |w*Delta|<8 and t=max(2q,wu/4)=2q, so the original first-choice formula applies with its original hypotheses.

These structural checks do not remove the Platt-dependent prime and Moebius producer inputs of the Type I/II inequalities. Those remain separate obligations.

## Exact integration and elementary enclosures

The central interval is split into 98 bins of width .025. For each bin [a,b], the script evaluates the entire normalized source expression on the interval z in [a*1e25,b*1.1e25]. Every interval arithmetic operation is rounded outward. The resulting constant upper bound is multiplied by an upper bound for the exact Gaussian mass on that bin. Therefore no derivative estimate for the complicated Type I/II expression, and no sampling assumption, is needed.

The upper interval [2.5,8] is split into 110 bins of width .05 and treated in the same way with the raw first-choice expression. The Gaussian masses use the already reviewed Simpson certificate for phi(w)=w^2*exp(-w^2/2), with global |phi''''|<84 and remainder 84*(b-a)^5/2880. This is the sole quadrature step, and it has an explicit analytic remainder.

The tails are bounded by

    17*.05^3/3 + 17*(65/8)*1e-13
    = 34000000663 / 48000000000000,

using exp(32)>1e13. The same tails are retained for every tested rectangle.

Logarithms and roots use the previously reviewed directed rational utilities from `base_gap_binned.py`. Pi is enclosed through Machin's identity pi=16*atan(1/5)-4*atan(1/239), with 30-term alternating rational sums and their next-term remainders. The exponential constant e is bounded by its degree-30 rational Taylor polynomial and the geometric remainder (1/31!)*(32/31). These analytic identities and series bounds need their ordinary Lean proofs or existing library lemmas when the certificate is formalized.

Each interval arithmetic endpoint is additionally rounded outward to a dyadic rational retaining approximately 80 significant bits. This controls denominator growth. The direction is determined by exact integer division; it does not use binary floating-point rounding. All asserted comparisons and all interval calculations use fractions. Decimal diagnostic output is not used to decide success.

For the consumer lower bound, evaluate the previously proved a*R(y,300000)+b envelope on the full y interval and take its lower endpoint. This accounts for the decreasing allowance as y increases; it does not reuse the value at y=1e25.

## Smaller checked intervals and the unresolved range

The same script also records these independent checks:

| y interval | normalized upper | ghat lower | certified gap greater than |
|---|---:|---:|---:|
| [1e25,1.01e25] | .057528077099 | .059804313752 | .002276236653 |
| [1e25,1.05e25] | .058030174621 | .059789217142 | .001759042522 |
| [1e25,1.1e25] | .058645373527 | .059771184079 | .001125810553 |

The range y>1.1e25 is not certified here. An all-y proof must control the decreasing Type II logarithmic correction, the floor errors and the Type I logarithms together with muBound saturation, relative to the decreasing ghat allowance. Treating the endpoint success as monotonic success would leave a real gap.

Likewise u>26000 is outside this small-twist certificate. The independent raw-tangent result covers a large-u region but leaves a middle interval. The parent campaign is investigating parameterized large-twist bounds for that interval. This note neither assumes those bounds nor counts them as proved.
