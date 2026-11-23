# Independent q=1 finite-spectrum and high-twist review

This review concerns the reduced denominator of `2 alpha`, not the original denominator of alpha. It checks a conditional combination of a finite-zero explicit formula and the raw first-choice Type I/II envelope. Neither the finite spectral assertion nor the Platt-free analytic producers are proved here. No Lean build or canonical source edit was performed.

Verdict: PASS as a conditional paper and scalar certificate. Both exact replays passed and matched every field of the frozen producer JSON. The combined estimates cover every required q=1 twist and every y>=10^25, subject to the spectral and analytic inputs explicitly retained below. No mathematical correction to the frozen producer argument is required.

Frozen inputs, relative to `agents/moebius`:

| File | SHA256 |
|---|---|
| `RESUME_Q1_GAP_2026-11-11.md` | `be08109b6433b3db1cf349a15418283765abe2cdd62930f3917bb1ca21f02782` |
| `resume_q1_finite_budget.py` | `4ed49d4a487d82fe9d1e7895961742905d49ff3f046f6f2f87c2804d101d8189` |
| `resume_q1_finite_budget.json` | `966da9027baf278366c881e3e74c4e849cf8010764c0ec3c188bcd0eb19d2701` |
| `resume_q1_high_certificate.py` | `04b6bafc9a5e6012f4d7e44bef09239798cec33f8009aecf9c183fa890ca386a` |
| `resume_q1_high_certificate.json` | `55f8e1ab0a7acab34bf6b91c8b3227ef1245c1296035b6595b52acf3dfdf33fc` |

The final additions in the producer note supersede its earlier obstruction-only status. The old obstruction remains valid for that positive raw envelope at small u; the new finite-zero argument uses a different bound there.

## Exact normalization and geometry

`Helfgott/Defs.lean:55` and `MinorArcs/EtaU.lean:26` give `etaStar(t)=etaU(49t)` for positive t. The zero summand vanishes because `Lambda(0)=0`. Consequently

`S_etaStar(alpha,49y)=sum_n Lambda(n)*etaU(n/y)*e(n*alpha)`.

There is no extra factor 49 multiplying this sum. Its normalization is division by y, where `y>=10^25`.

If the reduced denominator of `2 alpha` is one, the original arc denominator is one or two. The parity-specific arc radii give, in either case, `alpha=A/2+d/y` with

`600000/49 <= |d| < 600000`.

For the original odd denominator one, use the radius `600000/x`; for the original even denominator two, use `1200000/(2x)`, with `x=49y`. The enlarged arcs at scale y give the corresponding strict upper endpoint. Thus `Delta=2d` and `u=|Delta|` satisfy `1200000/49<=u<1200000`.

The relaxed conclusion of `BaseGap2.gap_point` loses a factor two at original denominator two. Its proof retains the sharp parity-specific radii, which must be used for this lower twist bound. The error in `2 alpha` is less than `1200000/y<1/2`, so A is its unique nearest integer. An integer shift of alpha changes no sum.

When A is even, this is the ordinary twisted principal sum `S_d(y)`. When A is odd, the exact identity is `-S_d(y)+2*sum_(2|n) Lambda(n)etaU(n/y)e(nd/y)`. Only powers of two contribute to the correction. The existing noncoprime estimate bounds that correction by `4e-9*y`. It does not introduce any new character conductor.

## Finite branch, through u=190000

The actual etaU twist is `d=u/2` in absolute value, hence at most 95000. Dividing by 49 again would be incorrect. The proposed cutoff is

`H=ceil((484/7)*95000)=6568572`.

It is at least `22*pi*95000` and is below both the older shared principal cutoff 60343058 and the reduced 22-pi shared cutoff 41485915. The branch therefore asks for no extension of the shared finite zeta assertion `beta<=111/200`. Equality at H belongs to the low-zero part. The certificate itself remains unproved.

For the low count, use fresh radius-three Jensen disks at the centers of length-3.48 ordinate intervals. They contain every point with `0<beta<1` in the interval, since `2^2+1.74^2<3^2`. The source `count_line_windowG` requires `beta=1/2` and cannot be used directly here. The unconditional `sum_multRectD_le` and the polynomial logarithmic bound instead give multiplicity at most 400 per interval. At most `2H/3.48+2` intervals suffice, giving the integer upper count `N=1510017352`. No zero simplicity assumption occurs.

The actual convolution Mellin transform is

`F_U(s,d)=integral_(1/4)^1 eta2(v)*v^(s-1)*Gr(s,dv,0) dv`.

There is no real-part shift by two. For `0<=beta<=1`, weighted arithmetic-geometric mean gives `t^(beta+1)<=(1-beta)t+beta*t^2`. Its Gaussian integral is less than two. The eta2 moment is at most `4*log(2)^2<2`. Hence `|F_U|<4` for every real twist and ordinate. Under the finite strip, the normalized low-zero sum is bounded by `4*N*y^(-89/200)`.

The exact comparison `(7.5e-12)^200*(10^25)^89>1` proves the endpoint bound `.04530052056`. The exponent is negative, so this endpoint bounds every larger y, irrespective of the phases `y^(i gamma)`.

For the high zeros, the etaU mixture contributes a factor at most two to the source `EA/EB` tail. There is no bandlimit-200 shift. With `D=95000` and `G=3+D/2.7`, both geometric inverse denominators are bounded by G. The source counts give `800G+106G^2/H`, which is less than `803G` because `G/H<1/39`. Thus the larger twist has been charged its actual geometric coefficient, rather than the old smaller star-arc coefficient. The exact Taylor check bounds `EA` at ratio 22 by `2e-20`. The EB bound at 250 dominates the actual H value by exponential-polynomial monotonicity. After the global QRH saving `y^(-1/8)`, using `1333^8<10^25`, the normalized high error is below `1e-14`. This high estimate needs the genuine global 7/8 theorem, not only the finite assertion.

`MinorArcs/EtaU.norm_fourier_etaU_le` and `BaseGap2.fourier_const_le` give `|Fourier etaU(-d)|<=1.016/d^2<7e-9`. The sign convention matches the source `e(nd/y)` twist. For the vertical contour, the mixture moment at real part -1/2 is `16*(sqrt(2)-1)^2<2.746`; `MajorArcs/Cor713.Vz_le` is unconditional and bounds the Gaussian vertical constant by `1e17` for the required twists. Dividing by `2*pi*y^(3/2)` gives the safe bound `5e16*y^(-3/2)`. This is below `5e-21` using the script's coarse `sqrt(y)>=10^12`. The zeta contour has no zero-at-zero residue. Its pole term is exactly the Fourier term already included.

All finite-branch errors decrease with y. Together with parity, their scalar total is about `.0453005313362`, below the reviewed uniform lower bound `.04712` for `ghatY(y,150000)`. The etaU GoodSmoothing, Fubini, and actual explicit-formula wrappers remain substantive formalization obligations.

## High-twist monotonicity and compact scale coordinate

For `190000<=u<=1200000` and `.02<=w<=8`, write `z=wy` and `t=wu/4`. Then `t>=950` and `t<=2400000`. The approximation error satisfies the first-choice condition because `t<T/3`, where `T=z^(1/3)>58000000`. Also `T>=6e6`, `q=1<=T/6`, and the assembly condition `V1(T)<=z/4` holds. The q=1 totient ratio is one. These facts permit the existing raw first-choice source shape, but do not remove its unresolved analytic producers.

For fixed z, put `ell=log t`, `a=.5*log(4t)`, `v=log(9*z^(1/3)/(2.004*t))`, and `C=log(1+a/v)`. Here `ell>6` and `v>4`. The leading square is

`[C*(ell+.002)+a]*(.30214*ell+.7468)/t`.

Differentiate with respect to ell. Since `a'=1/2`, `v'=-1`, and `log(1+r)>=r/(1+r)`,

`C'/C <= .5/a+1/v <= 1/ell+1/v`.

The logarithmic derivative of the first bracket is at most `2/ell+1/v`; that of the second is at most `1/ell`. The logarithmic derivative of their product divided by t is therefore at most `3/ell+1/v-1<3/6+1/4-1<0`. This proves monotonicity of the full variable-C expression. Freezing C first without this argument would not justify reducing all u to 190000. Every remaining t-dependent term is a nonnegative combination of `t^(-1/2)`, `1/t`, and `log(t)/t`, and also decreases. Thus it suffices to certify u=190000 for every y.

Set `r=1/log(9*y^(1/3)/601200)`. The complete all-y domain maps into `0<r<=rmax`; including r=0 makes a compact closed interval. On a w bin `[l,h]` at the fixed twist, freeze `t` between `l*190000/4` and `h*190000/4`. The C denominator is bounded using

`v = 1/r + log(300000/t)+(log w)/3`.

The script bounds the last two terms downward and the numerator upward. Its assertion `1+hr*rmax>0` keeps all denominators positive. The resulting upper bound `log(1+aq*r/(1+hr*r))` increases in r, including when hr is negative. Its value at each cell's upper r endpoint is therefore safe. The consumer lower bound increases in r, so its lower endpoint is safe. All source remainder terms and `3*log(z)/z` are retained.

The w partition has 399 bins covering `[.02,8]`; the r partition has 128 cells covering the whole closed scale interval. The Gaussian masses use the previously reviewed rational Simpson bound with fourth-derivative allowance 84. The omitted tails are bounded by `17*.02^3/3` and `17*(65/8)*1e-13`. Independent replay reproduced every saved row, including minimum positive gap `.000338635937`. The independent variable-C argument above also corroborates the producer's slightly different valid derivative estimate.

## Join and proof status

The finite branch includes u=190000 and the raw branch starts there, so there is no missing twist endpoint. Together their domains cover every reduced-q=1 base-gap point at every y>=10^25. This is a conditional coverage statement. It does not count other denominators, enlarge the major arcs, or certify the overall Goldbach theorem.

The finite branch uses the same unproved principal finite strip already required by the major route. The high branch uses the existing Type I/II input package, whose Platt-free replacement remains separate. The scalar results cannot be used to hide either requirement as a new final hypothesis.

`resume_q1_review_replay_20261111.py` re-executed both producer scripts with writes redirected into this review directory and verified that their source JSON files remained unchanged. Its JSON pins the scripts and saved outputs and records the positive worst margin. The redirected per-script JSON and logs are retained beside it. The rational interval library and Gaussian Simpson enclosure remain the previously reviewed mathematical interfaces, not compiled Lean theorems. The present result supplies no finite zero data and does not settle the separate prime/Möbius envelope interval `[1e9,exp(35))`.
