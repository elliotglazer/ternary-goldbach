# Independent review of principal pilot scaling

2026-11-11. **PASS, with no mathematical correction requested.** The result concerns applicability and size of the selected sufficient error formulas, not actual quadrature/Taylor errors, universal computational lower bounds, or production feasibility. No theta, P, xi or other function value was evaluated. No scan or build was run.

## Pinned input and independent arithmetic

Reviewed `major-constants/PRINCIPAL_PILOT_PRODUCTION_SCALING_2026-11-11.md`, SHA256 `2AE2B7A7E130603E7C2C11EFE582177ABB72A0F37AE4FE842871B4C11E9EF63C`, under `work/qrh-campaign/agents/`. Its hash was checked. I read its cited Fourier/node-substitution formulas and contour-frontier note, and reconstructed the inequalities independently.

The review script `zero-sum/review_principal_production_scaling_20261111.py`, SHA256 `E20757D7465F047892A953621510BB0AA701A60897497CC8BF70170E4DB6B1A8`, passed 29 integer/Fraction checks. Its receipt is `zero-sum/review_principal_production_scaling_20261111.json`, SHA256 `D6FF139B805B203D6BF8C1C1F2F38544DD4D638EF232C4DAFA0493E46AA60168`. It independently computes the exact retuned A,M,D and successive remainder ratios. It imports no producer or numerical special-function library and writes only its own receipt.

## Fixed-parameter claim

For positive h,r and M, `exp(2*pi*r/h)-1<exp(2*pi*r/h)` implies

`Q0>2M exp(r*(T-2*pi/h))`.

At the pilot h=1/256, pi<4 gives `2*pi/h<2048`, and M>1/2. Hence Q0>1 for T>=2048. This proves that the old certificate cannot establish error <=1/10 at either selected production height. It does not prove the actual quadrature error exceeds 1.

For T>0 and a positive tolerance epsilon<=2M, Q0<=epsilon forces `T<2*pi/h`. Holding V=29/8 and K=V/h therefore gives `K>29T/64`. Both printed specializations, 453125 and 874974341/32, check exactly. Integrality may round these necessary bounds upward, but the note does not need that sharpening. They apply only to satisfying this envelope with the stated fixed V; they are not a sampling theorem for other algorithms.

## Retuned constants and scalar-only degrees

For U=T+1 and the reviewed retuned strip, `q=3/(4U)`. The positive-derivative discrete spatial bound requires `exp(2V)>=8U/3`. The already certified strict inequality `exp(29/4)<2048` therefore excludes the old V whenever U>=768, including equality at 768. The exact thresholds at the two heights are 8000008/3 and 160914824.

Keeping only positive terms in A gives `A>(32768/81)U^3`; multiplying by the `1/q^2` term in D gives `D>(524288/729)U^5`. These are strict algebraic lower bounds for U>0. The exact degree-six expression is

`D*rho^7/(1-rho)=D/(63*64^6)`.

Both stated integer lower bounds for it check. With the exact D, the independent arithmetic proves:

| Work height T | Degree immediately below minimum | Its scalar remainder | Minimum degree | Its scalar remainder |
| ---: | ---: | --- | ---: | --- |
| 1000000 | 17 | >1/10 | 18 | <=1/10 |
| 60343058 | 22 | >1/10 | 23 | <=1/10 |

Successive expressions differ by a factor of 64, so checking these consecutive degrees proves minimality among natural degrees. These are minima for the Cauchy expression **alone**, at rho=1/64, and leave no assigned coefficient, node, weight or polynomial-evaluation budget. The note correctly does not propose them as a complete production setup or assert that the true Taylor remainder needs those degrees.

## Actual zero-node operand, not merely an envelope

For these U, `theta=2/U` lies in (0,1), and `cos(theta)>=1-theta^2/2>1/2`. Thus the exact real part of the seed is in (-1,-1/2), making -1 its nearest integer. Translation gives

`t=1-cos(2/U)+i*sin(2/U)`.

Its imaginary part is positive and below 2/U<2/5, so it cannot already satisfy the terminal-height guard; its real part is below `(2/U)^2/2<3/5`. An S inversion is admissible. The exact identity

`|t|^2=4*sin(1/U)^2`

and positivity of sin(1/U) give `|1/t|=1/(2*sin(1/U))>=U/2>50/3`. This verifies the claimed actual failure of the old reciprocal bound. It does not imply numerical failure: absolute interval accuracy can still be refined, and a new transport analysis may succeed.

## Source applicability and remaining limits

The source interfaces apply to the actual entire normalized `F_b(s)=exp(-i*b*(s-1/2))*xiF(s)`, with center real part in the reviewed [0.4968,2] range, positive work height, and an admissible strip margin. The new b and r satisfy that margin using `sin(1/U)>=1/(2U)`. No additional derivative factorial, missing exp(r) factor, or principal normalization change appears in the note.

The general terminal-height theta theorem remains applicable, while its output error must be propagated through the new word. The sharper sixteen-pair tail may also be used if its exact terminal domain holds, but neither fact preserves the old transport factor or final node budget. Identical cached nodes can be reused only at identical exact b and frequencies, or with a separately proved perturbation estimate.

Finally, the contour-frontier qualifications are essential: coefficient accuracy supplies no uniform nonzero margin, actual boundary zeroes may obstruct the proposed strict exclusion design, and complete closed geometry, winding and source zero-order transport remain separate. The note preserves these distinctions. Its negative result concerns literal repetition of the small pilot and automatic reuse of its constants; it is not a negative conclusion about a redesigned evaluator or a runtime forecast.
