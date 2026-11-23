# Independent review of the complete height-1500 head certificate

Date: 2026-11-11. Finding: **pass as an external interval certificate and paper-level mathematical derivation**. The finite-expression Taylor wrapper, its two separate error bounds, shared contour topology, complete counts, and exact head sum are sound. The data give N(1500)=1069 with multiplicity and Q_1500<1.668<2. The wider-strip consequence is accepted separately as a conditional implication; the required strip through one million is not established. No Lean theorem or new permitted assumption is introduced.

## Frozen inputs and validation scope

Reviewed files under `agents/mellin/`:

| File | SHA256 |
|---|---|
| `PSI_HEAD_COUNTS_CERTIFICATE_2026-11-11.md` | `ed9250bd7a7de3395543fbc06dd88ffc9227af352d690caa70f621c20a5f975b` |
| `psi_head_counts_20261111.py` | `d7f187fa357eaca184a2214f8952b396b9d2df42348580993005b7da00252a9a` |
| `psi_head_counts_20261111_h1500.json` | `82ad7acdffbcac24d190a98acb78bf66471249d09bfe2c43051add2aaec0d030` |
| `psi_head_moment_20261111.py` | `9bcf5ac3978582177e7e353109375168055f9883dcc1437b5125ff947d5597dd` |

I ran the complete frozen replay using the existing interval environment. It regenerated all 18300 Taylor blocks, checked all 18351 panels and 472 checkpoint contours, and exited 0. This is a full numeric replay of the author's evaluator, not merely a JSON consistency check.

Two additional independent scripts were written in `agents/moebius/`:

* `psi_head_review_20261111.py` imports no author code. It checks every rational segment, block membership, shared vertex, orientation and checkpoint assembly; recomputes winding with both the original and a perpendicular ray; and recomputes every cumulative Q fraction. It also independently checks the optional wider-strip scalar inequality using different Taylor truncation degrees for exp and arctan.
* `psi_head_taylor_review_20261111.py` independently constructs exponential Taylor coefficients by the recurrence `a_j=a_(j-1)*(-log n)/j`, rather than calling power-series exp. It uses N=512, M=36, K=28, outer radius 3/4 and 192-bit precision, instead of 500/32/24/1/128. It checks 132 selected blocks and all their 183 panels, including every original block that needed panel subdivision, the complete bottom, the last crossbar, and uniformly spaced blocks across the height range. All original half-plane witnesses pass without further subdivision. This selected alternative check is **not** represented as a second full numeric replay.

Both independent scripts exit 0 and save JSON receipts. Neither evaluator calls builtin zeta, L-functions, gamma functions, or zeta jets. FLINT elementary interval arithmetic and finite power-series operations remain external computational dependencies. No dependency installation, source mutation, or Lean build occurred.

## Analytic function and uniform EM error

The function is the pinned source's entire zetaF, with `(s-1)zeta(s)` away from one and value one at one (`Explicit/ZetaGrowth.lean:17–30`). The finite Euler--Maclaurin expression g in the author note is entire: all terms are polynomials times exponentials with positive-real base logarithms. The pole term has already become `exp((1-s)log B)`; no division by s-1 remains in g. Its Bernoulli coefficients and rising-factorial indices agree with the EM formula through B_(2M).

For actual sigma>=sigma0=-1/10, B=N+1>1 and sigma0+2M>1, the previously reviewed periodic-Bernoulli estimate gives

    |zetaF(s)-g(s)| <=
      4|s-1| |(s)_(2M)| B^(1-sigma0-2M)
      / (6^(2M)(sigma0+2M-1)).

It follows by integrating the norm of the remainder and using `2*zeta(2M)/(2*pi)^(2M)<4/6^(2M)`. The integral converges even at this negative sigma0. The factor |s-1| is retained. No factor depending exponentially on Im(s) is missing because the integration variable and base are positive real.

For a block centered at c of half-length h, S=|c|+h bounds |s|. Thus S+1 bounds |s-1| and each S+j bounds |s+j|. The product of those nonnegative quantities gives a uniform EM error on the whole block. The implementation uses these inequalities, not a center-only estimate. Its rational geometry supplies the actual sigma bound even when interval rounding extends slightly outside the domain. The eventual upper endpoint of the computed error interval is used as the added radius.

## Finite Taylor jets and Cauchy remainder

The producer sets `ctx.cap=24` and creates `acb_series([point(c),1],prec=24)`. These are coefficients through degree 23 of g(c+z), with ball enclosures; the precision parameter here denotes formal-series truncation, separately from 128-bit coefficient precision. This interpretation agrees with the [python-flint series documentation](https://python-flint.readthedocs.io/en/latest/acb_series.html). The finite expression is evaluated only by addition, multiplication and exponentials, so no meromorphic zeta-series operation enters the coefficient generation. Rounding of the rational center encloses the coefficients at the exact center rather than replacing that center by an unchecked float.

The outer bound M_o is valid on the complete disk |s-c|<=R, with R=1. Put S_o=|c|+1 and sigma_o=Re(c)-1. Then

* |s-1|<=S_o+1;
* |exp(-s log n)|=n^(-Re(s))<=n^(-sigma_o), also for n=1;
* each rising-factorial factor is bounded by S_o+j;
* the final pole-cancelled exponential is bounded by B^(1-sigma_o).

Taking absolute values of every Bernoulli coefficient gives precisely the author's M_o. This is a bound for the **finite entire function g**, which is defined on that disk even where sigma<-1/10. No EM validity or zeta nonvanishing is presumed on the outer disk. The actual zetaF-to-g error is used only on the inner contour block.

Cauchy's coefficient estimate for g yields |a_j|<=M_o/R^j. Summing the geometric coefficient tail from j=K gives

    |g(c+z)-sum_(j<K) a_j z^j|
      <= M_o (h/R)^K/(1-h/R),   |z|<=h<R.

Here every block has h<=1/10, so the denominator is positive. The producer uses K=24, R=1. Its interval polynomial encloses the true coefficients, so Horner evaluation plus the Cauchy tail and the separate EM error encloses zetaF throughout each subpanel. Subdivision retains the same block error, a conservative choice. The alternative evaluator verifies the same argument with K=28, R=3/4 and different N,M.

This analytic justification, the full numeric replay, and the selected alternate coefficient calculation together support the wrapper. They do not prove FLINT or Cauchy's theorem inside Lean.

## Shared contours, complete counts, and carriers

The independent arithmetic audit reconstructs the integer grid starting at 14*1024 and adding floor(n/100), clipping the final step at 1500*1024. It finds exactly 472 checkpoints and 471 cells. There are 1417 paths: one bottom and three new paths per checkpoint. All 18300 blocks occur exactly once in the stored path decomposition. Each block and panel is a directed subsegment of its parent, with exact adjacency and no omitted interval.

The bottom goes left-to-right along height zero. Each right prefix goes upward. Each crossbar goes right-to-left at its own checkpoint. Left prefixes are stored upward, so their crossing contributions are subtracted when forming the counterclockwise rectangle. The identity

    W_j = cross(bottom) + right_prefix_j
          + cross(crossbar_j) - left_prefix_j

therefore describes the full closed contour `[-.1,1.1]+i[0,t_j]`. Every reused input vertex has one identical rational image vertex across all incident blocks and paths. This includes both endpoints of each crossbar and both bottom corners.

Each panel image and its polygon endpoints lie in a common strict coordinate half-plane. Convex interpolation gives a nonzero homotopy panel by panel, compatible at all shared vertices. The exact winding uses rational determinants and half-open crossing rules; a straddling zero determinant is rejected. The independent audit rotates the crossing ray by 90 degrees and obtains the same assembled winding at **every** checkpoint, not only at 1500.

Boundary nonvanishing excludes zeros on every crossbar and on the real bottom. Thus interior counts equal the closed positive-ordinate count `0<gamma<=t_j`; no half-weight convention occurs. The entire function's analytic zero orders are nonnegative, and the argument principle counts all of them. No critical-line membership or simplicity is assumed.

The real range extends slightly beyond the critical strip. Source `Explicit/ZetaDatum.lean:190` excludes zetaF zeros for -1<Re(s)<0; `Explicit/ZetaPoly.lean:205` excludes Re(s)=0; and `zetaF_ne_zero_one_le` at line 240 excludes Re(s)>=1, including the removable point. These are unconditional source facts. Inside the critical strip, the factor s-1 is analytic and nonzero, so zetaF and zeta have the same zero orders. Consequently the winding is the actual nontrivial-zero count, not an assumed carrier match. The certified bottom also removes real zeros from this particular counting region.

The base count is N(14)=0 and the terminal count is N(1500)=1069. Monotonicity checks are consistent, but do not substitute for the separately verified contour at each checkpoint. This head certificate does not locate individual zeros.

## Exact head integral

With the zero-free base height, integration of each positive-ordinate indicator gives

    Q_A = sum_(0<gamma<=A) m*(1/gamma-1/A)
        = integral_14^A N(t)/t^2 dt,  A=1500.

At a zero exactly at A the summand is zero; this identity remains valid. On each grid cell, monotonicity gives N(t)<=N(t_j), so

    Q_A <= sum_j N(t_j)*(1/t_(j-1)-1/t_j).

The independent script recomputes every term and cumulative fraction from the newly recomputed winding integers. Its exact fraction agrees with the frozen JSON and is strictly below

    833975893977619/500000000000000
      = 1.667951787955238 < 1.668 < 2.

No logarithm, floating-point ordinate, or approximate quadrature enters this step. In particular Q_A is the boundary-corrected head integral, not the raw reciprocal sum; adding the terminal N(A)/A prematurely would change the consumer.

## Separately checked wider-strip implication

The analytic count input is the reviewed paper theorem

    N(t) <= t/(2*pi)*(log(t/(2*pi))-1)+7/8+5log(t)+20,
    t>=1500,

not the older sharper Rosser-style coefficients. I verified the frozen analytic note hash `4648e4c454f4344d4f110e878f6cf619f5ac2128cac91c2658e443fa3d1df303` and the independent major-constants review hash `82b2a416eae9e4f16f8147c92776ab7d5063355e3eabe828615281aa64d8c418`. That review explicitly covers all real closed heights, without historical finite-zero inputs. Its Lean formalization remains pending. I use its reviewed mathematical contract here; this is not a second full proof audit of that analytic theorem.

For A=1500 and T=10^6, boundary-corrected partial summation gives

    sum_(0<gamma<=T) m/gamma
      = Q_A + N(T)/T + integral_A^T N(t)/t^2 dt.

The count majorant bounds the last two terms by the stated F contribution plus `[5(log A+1)+20]/A`. This retains zeros at both endpoints correctly. If the separate finite strip `|beta-1/2|<1/400` through T is established, reflection averaging multiplies the both-sign ordinate moment by at most `(1+exp(35/400))/2`. Conjugation doubles the positive-ordinate moment, cancelling that denominator 2. Real zeros have already been excluded, and `1/|rho|<=1/|gamma|` is then valid. The zero bijections must preserve multiplicity in a formal proof.

The independent script proves the needed log bounds by positive exponential Taylor sums with explicit tails, bounds pi by Machin's identity and alternating arctan tails, and uses a fresh exponential enclosure at 35/400. It independently obtains

    W35 < 23952656684027/10^12
        = 23.952656684027 < 23.953 < 24.

Thus the wider strip (.4975,.5025) is a valid **sufficient remaining target**, when combined with this head certificate and the reviewed analytic count theorem. This computation does not establish that strip, and the head counts alone cannot establish it. No replacement of an existing frozen spectral premise is silently made.

## Disposition and remaining formal work

No mathematical correction is required. Accept the actual external head data, complete numeric replay, independent rational replay, and the separately qualified wider-strip implication. Keep the selected independent Taylor check's scope explicit: 132 blocks, not the full data set; the full analytic replay used the frozen producer's evaluator.

Remaining Lean work includes the exact source-function identification, Euler--Maclaurin and Bernoulli bound, finite Taylor coefficient enclosure and Cauchy tail, interval arithmetic soundness, argument principle and multiplicity transport, and rational grid integration. The finite narrow strip through one million remains a genuine spectral certificate task. Neither this JSON nor the analytic-count report may become a permanent unproved hypothesis of the final theorem. Canonical sources and frozen packages were left unchanged.
