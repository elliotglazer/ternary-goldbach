# Review of the independent conductor-eight pole-jet allocation

2026-11-11. **PASS as a paper derivation and sufficient accuracy contract.** No correction is required to the frozen version. No logarithm, exponential, jet, transform, model or other function value was evaluated in this review, and no evaluator or Lean code was implemented. The author’s scalar script was read, not executed by this reviewer.

## Frozen inputs

Reviewed `major-constants/C8_INDEPENDENT_POLE_JET_ALLOCATION_2026-11-11.md`, SHA256 `59C6448E26CDC8AD7DA944017C555B2F3B3F1A4D70E98B4B275585FA5BC46E48`.

Its exact-budget script `c8_independent_pole_jet_allocation_20261111.py` has SHA256 `8393F886D6D8BD9476874E929FD8386D37EA8AF0CA7169D63DD3203A97469A1F`; the saved receipt has SHA256 `3D2617D0CE1FEFE7604D4DB96409C53AC953C8ADE77EE056E4E954736FB87F7B`. I inspected their expressions and independently derived the bounds below. The receipt’s fifteen checks concern rational/factorial inequalities, not actual coefficient values.

The unchanged pilot is `zero-sum/NONPRINCIPAL_TENSOR_PILOT_DESIGN_2026-11-11.md`, SHA `3B4B21946F89CA503F03A2BBC030B73F556B31254BA643C427AFB1B39CA5A43B`, reviewed at `0046FAEEC56248F33F5AB9CD80E8C8675631FBF77679FE54CE436DD9A56FCFA3`. The correction’s entire source identity is the accepted pole-difference plan `3F73AF600725DDB51ED622577BF374251B38C408D0D52D4EA06CFCF1BDD60011`, reviewed at `39D7D84D0706FE27A7DEF211684FA1DCA4D9E3544AB1A496AE435DDF4E04F577`.

## Exact jets, including the removable point

The actual entire correction is

`P_a(s)=-(1/8)*integral_(log297)^(log X_a) exp((1-s)u) du`,

with X_a in (297,301,303,299). Away from 1 it equals the endpoint-power difference divided by 8(s-1). This retains the conductor factor and the source continuation convention. It is not an individual totalized Hurwitz finite part and has no extra 8^(-s), Gamma or parity factor.

At the center 1, integrating the normalized h-th derivative gives

`P_h(1)=((-log X_a)^(h+1)-(-log297)^(h+1))/(8*(h+1)!)`.

The sign and factorial are correct. In particular P_0(1) is negative for a>1. The last requested order h=29 requires power 30 and factorial 30!. A numerator Taylor-series implementation must retain degree 30 before removing its simple zero; retaining only thirty numerator coefficients would omit the last answer.

At an off-center point s0=1+q with q=+/-i/8, let N_h be the normalized coefficient of `X_a^(1-s)-297^(1-s)` at s0. Differentiating the entire product identity, or comparing normalized power-series coefficients, gives

`q P_h+P_(h-1)=N_h/8`, with `P_-1=0`.

There is no factor h because these are complex-s derivatives divided by h!, not ordinary derivatives or height derivatives. For q=+i/8 this becomes `P_h=-i N_h+8i P_(h-1)`; for q=-i/8 it is `P_h=i N_h-8i P_(h-1)`. Exact signed coordinate operations implement these identities without an uncertain complex denominator. The derivation can use a local disk smaller than 1/8; that restriction does not limit the resulting derivatives or the later finite-U outer-circle theorem.

For a=1, the endpoints coincide exactly and every P coefficient is zero. The integer-label branch is sound; a numerical near-zero log test would not be. There are ninety reference zeros, ninety nonreference coefficients at 1 and 180 nonreference off-center coefficients, totaling the required 360 P coefficients. The formula at 1 and the off-center recurrence identify the same entire P, without introducing a zero or pole into the nonprincipal L-function.

## Amplification through all thirty orders

The numerator error is divided by 8 and then by |q|=1/8, so its two factors cancel. Previous coefficient error instead acquires a factor 8. Including a complete arithmetic error eta_h gives

`e_h<=epsilon_N,h+8e_(h-1)+eta_h`.

For a uniform bound epsilon on the new error at each order, induction gives `e_h<=(1+8+...+8^h)epsilon`. Therefore the order-29 factor is exactly `G=(8^30-1)/7<2^88`. This is substantial absolute-error amplification; entirety of P does not remove it. The allocation correctly includes it rather than reusing a one-step bound at every output. It asserts no relative accuracy near small coefficients.

## Elementary input and rounding accounting

The final choices are delta=2^-240 and r=2^-224. Delta is an absolute elementary enclosure requirement, not a consequence of selecting 256-bit arithmetic. In particular, the exponential enclosure is relative to the exponential at its exact rational approximate argument; perturbation of that argument by the log error is charged separately.

All bases are at most 303, their true logs are below 7, and the required log centers lie in [0,8]. The actual log of 1 is handled exactly. The normalized real powers and their relevant derivatives are bounded on this interval by exp(8)<3^8<2^13. This also bounds the derivative of the order-30 normalized power needed at s=1.

For the numerator phases exp(-q L), the log perturbation costs at most delta/8 because q is purely imaginary. Adding the elementary exponential error gives less than 2 delta. Split a phase/power product using the **true** phase times the power error and the phase error times the approximate power. One term’s error is then below `3*2^13*delta`; two endpoint terms are below `2^16*delta`. This split includes the dependence between reused inputs without an omitted cross term. One numerator gate adds r, and one recurrence gate adds another r.

Since `2^16*delta=r`, the uniform off-center error is

`E_off=3 G r<3*2^-136<2^-134`.

At 1 there is no phase uncertainty: the two normalized-power errors, divided by 8, give `2^11*delta`, followed by one gate r. Thus `E_one=(33/32)r<2^-223`. These bounds include every order and fit the accepted complete P-block allowance 2^-84.

The exact-between-gates schedule makes this accounting sound. A nearest coordinate grid of step r/2 has norm rounding error below r. A native interval implementation may use another schedule only if it proves the complete aggregate error of each gate is at most r. Treating r as only the last rounding while silently rounding many preceding operations is not covered. The finite rational elementary construction cited by the author supplies existence of sufficiently accurate enclosures; it neither establishes native-library accuracy nor overrides the fixed independent attempt’s precision or caps.

There is no Q32 moment tail in this independent path: the displayed derivative formulas are exact and its errors are elementary and arithmetic. It deliberately avoids the producer’s exponential-moment/binomial-convolution evaluation, though both paths may share underlying elementary arithmetic software. This is mathematical-path independence, not disjoint software trust.

## Full direct finite-U reconstruction

For each direct head or endpoint exponential coefficient, Re(s0)=1 and |s0|<2. The segment between a true nonnegative log and its nonnegative center keeps the exponential’s norm at most 1. Log replacement therefore costs at most 2 delta, followed by delta for the exponential itself. Splitting the product with its normalized log power gives at most `2^15*delta=:e` per coefficient. No time-bin residual or transform error occurs on this direct path.

The 37-term head block has bound 37e+r and the half endpoint e/2+r. For the Bernoulli block, each affine rising-factor polynomial has coefficient l1 norm less than 33: its largest constant term has modulus at most 31+1/8, and the z coefficient adds 1. The denominator 37+a/8 is at least 297/8>33. Together with |b_m|<=1, the sum of sixteen scaled rising polynomials has l1 norm below 16. Exact rational construction therefore bounds the convolution error by 16e+r. Truncation to degrees below 30 cannot increase that norm or affect retained coefficients. This is the actual conductor-scaled correction, not a replacement of its denominator by X_a.

After the residue-addition and character-sign gates, the author’s total is

`E_L=4*((37e+r)+(e/2+r)+(16e+r)+max(E_off,E_one)+r)+r`.

Here e=r/2 and E_off=3Gr exceeds E_one, so this simplifies to `(124+12G)r<2^-128`. It includes the head, half endpoint, all Bernoulli terms and the entire P correction. The resulting 270 coefficient enclosures concern the exact **finite L_fin function**. They are not derivative enclosures for actual L obtained from a mere pointwise EM bound. Actual L on a disk is recovered afterward using the separately reviewed finite-U Taylor tail and actual-point EM estimate.

## Containment and the unchanged execution boundary

The accepted producer center error, once proved from its actual data, is bounded by `A=2^-76+2^17/32!`. An independent radius 2^-128 leaves theoretical room because `A+2*2^-128<2^-75`. The second independent radius accounts for moving from the true coefficient to the independent center and then enclosing that center’s entire ball. The author correctly still requires a rational witness for `|q_h-C_h|+2^-128<=D_h<=2^-75` against the immutable saved center. Theoretical room is not a completed data comparison; overlap alone remains insufficient.

The independent D_h values enter the same full-disk coefficientwise containment test, with the unchanged EM and finite-U Taylor domains and the parent 2^-68 tube allowance. No principal s-1 quotient is used in that reconstruction. The division by q occurs only inside the off-center P derivative algorithm. Endpoint and conjugation comparisons remain auxiliary, not substitutes for full containment.

No further paper repair is needed. A future fixed 256-bit independent run must still demonstrate the elementary radii, every complete gate bound, all required coefficient/tube containments and resource compliance. This review does not accept saved coefficient data, authorize execution, predict that those limits will suffice, or establish any nonvanishing or spectral coverage.
