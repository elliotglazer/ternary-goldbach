# Gaussian damping removes the extra low principal strip from this scalar budget

Research derivation, 2026-11-11. This is a conditional paper implication with rational scalar verification, not a Lean theorem or a new zero certificate. No zeta evaluations, zero/prime scans, or builds were performed. Existing frozen packets are unchanged.

With the already reviewed critical-line head through 1500, the shared finite principal strip `[.445,.555]` through `H=60343058`, and the existing global `7/8` tail input, the actual Gaussian smoothing gives

`|psiR(x)-x| < .0096*x/log(x)` for `5e9 <= x <= exp(35)`.

The previous shared-strip argument above `exp(35)` gives `.0081*x/log(x)`. Thus these conditional arguments yield the common `.01/log(x)` envelope for all `x>=5e9` without a further narrow strip through one million. The finite shared strip, head certificates, and analytic formalization obligations retain their existing status. This does not prove their spectral premises or complete Goldbach.

The new scalar total is below `.009569927135481`. In particular, the reserve below `.01` exceeds `.000430072864519`. No cancellation between complex zero terms is used. Only the positive majorant is averaged under the exact zero symmetry.

## 1. Inputs, actual source, and conventions

Use `A=1500`, `h=11/200`, and the positive-height closed count

`N(t)=sum_{0<Im(rho)<=t} mult(rho)`.

The accepted external head packets give critical-line location through A, `N(A)=1069`, and

`Q_A=sum_{0<gamma<=A} mult(rho)*(1/gamma-1/A) <417/250`.

Consequently the positive-height reciprocal head is less than

`H_A=417/250+1069/1500=3571/1500`.

Head references are `audit/PRINCIPAL_SIGNS_1500_REVIEW_2026-11-11.md`, SHA256 `A2961DEBB4BF2734FB048F1500D6E495E42B5DCB8439DD2412299F803A37FFFE`, and `moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md`, SHA256 `0BD2AF981C7F8A201F15597A7EE4C7B9812053C4987231C8EB02E5A6AA8BA491`. No information between heights 1500 and 2000 is consumed.

For all real `t>=A`, use the reviewed analytic count

`N(t)<=G(t)=t/(2*pi)*(log(t/(2*pi))-1)+5*log(t)+167/8`.

Its source packet is `mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md`, SHA256 `4648E4C454F4344D4F110E878F6CF619F5AC2128CAC91C2658E443FA3D1DF303`, independently reviewed in `major-constants/RESUME_PSI_ANALYTIC_COUNT_REVIEW_2026-11-11.md`, SHA256 `82B2A416EAE9E4F16F8147C92776AB7D5063355E3EABE828615281AA64D8C418`. This is the analytic count proof, not a cited historical finite verification. The same review, section 4, supplies the paper real-axis exclusion from `Xi.re_zetaF_half_ge:79` generalized to real `0<sigma<1` and the actual `ZetaGrowth.zetaF_eq`. Thus division by positive gamma does not silently omit real zeros.

The target repository is pinned at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Under `TernaryGoldbach/Explicit/`, the relevant files and whole-file SHA256 values are:

| Source | Actual role | SHA256 |
|---|---|---|
| `GaussSmooth.lean:355` | `norm_intExp_le'`, two actual endpoint exponentials divided by norm rho | `40ACFCF56E61C411BAF8DD3E7B5504B3DB48F34740B256A4D03F1CDBE37FEBA8` |
| `ZetaZeroSums.lean:106` | Gaussian ordinate damping in the Mellin majorant | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `ZetaExplicit.lean:122` | `explicit_formula_zeta_seq` and actual zero multiplicities | `A2252356B4A2FCE4BC0B2B0EFF9A26B43DFAEBA9B05DB94BFEAA444A423B94E2` |
| `PsiExplicit.lean:17` | unconditional left-line logarithmic derivative bound | `33A24C9E1606011AAC8930EC978BA027E90A2A66E0888DB18915ACC2FBF85BB1` |
| `PsiLarge.lean:296,326` | positive Gaussian upper/lower desmoothing | `D370555A164DA01E37E5BDB14EFA774DC79FE43682EED21D42C90BA2D1B165F2` |

Zero symmetry comes from `Xi.xiF_one_sub:24` and `XiPartial.xiF_conj:669`, with analytic-order transport and the nonzero Gamma/polynomial factors identifying actual nontrivial zeta multiplicities. These transports are mathematical proof steps, not an assertion that zero lists are symmetric merely because of a proposed input format.

## 2. Retain damping and pair the actual scalar majorant

Put

`L=log(x)`, `22.33<=L<=35`, `a0=.002/L`, `delta=.002/(L*sqrt(L+10))`, `q=delta^2/2`, `b=log(1000)-L`.

The two source smoothings use `a=+a0` or `a=-a0`. The actual per-zero error majorant, normalized by x, is

`exp(q*(beta^2-gamma^2))*(exp(a*beta)+exp(b*beta))*exp((beta-1)*L)/|rho|`.

First replace `1/|rho|` by `1/|gamma|`, and `exp(q*beta^2)` by `exp(q)`; these are positive upper bounds in the critical strip. Only then pair `rho` with `1-conj(rho)`. They have the same positive gamma and the same multiplicity. For `t=beta-1/2`, averaging `exp(v*t)` over that involution gives `cosh(v*t)`. No equality of the original norms `|rho|` and `|1-conj(rho)|` is asserted. Fixed points at beta=1/2 satisfy the same averaging identity; multiplicities are not divided or discarded.

For the a endpoint, the paired factor is bounded by

`exp(-L/2)*exp(a0/2)*cosh(h*(L+a0))`.

Here `L+a>0` and `|L+a|<=L+a0`. For the b endpoint the L dependence cancels inside the beta exponent:

`exp((beta-1)*L+b*beta)=exp(-L)*1000^beta`.

Its paired factor is at most `sqrt(1000)*exp(-L)*cosh(h*log(1000))`. On the head use t=0, hence cosh=1. Separate conjugation gives the factor 2 for the two ordinate signs. Therefore, writing

`D_delta=sum_{A<gamma<=H} mult(rho)*exp(-q*gamma^2)/gamma`,

the entire through-H error satisfies

`E_zeros <= 2*exp(q) * [ exp(-L/2)*exp(a0/2)*(H_A+cosh(h*(L+a0))*D_delta) + sqrt(1000)*exp(-L)*(H_A+cosh(h*log(1000))*D_delta) ]`. (1)

This consumes only the head critical-line result and the shared strip above A. It does not replace beta by a virtual zero or hypothesize favorable phases.

## 3. An elementary damped count bound

Let `f(t)=exp(-q*t^2)/t`. For any finite V>A, closed-count partial summation gives exactly

`sum_{A<gamma<=V} mult(rho)*f(gamma)=f(V)N(V)-f(A)N(A)+integral_A^V (-f'(t))*N(t) dt`.

Since `-f'>0`, replace N by G except for the exact lower endpoint. Integration by parts then gives

`sum <= (G(A)-1069)*f(A)+integral_A^V f(t)*G'(t) dt`.

Now `G'(t)=log(t/(2*pi))/(2*pi)+5/t>0`. Extending this ordinary integral to infinity is an upper bound. It does not extend the finite beta-strip hypothesis to any zeros above H. The right side converges because of its Gaussian factor. Since `G(A)>=N(A)`, replace `f(A)` by `1/A`.

Set `R=1/delta=500*L*sqrt(L+10)` and `Z=log(R/(2*pi))`, `ell=log(A/(2*pi))`. Throughout this range `R>A`. Drop the Gaussian factor only on `[A,R]`. Its logarithmic part integrates to `(Z^2-ell^2)/(4*pi)`. Bound the entire `5/t^2` part by `5/A`.

For the remaining logarithmic integral substitute `v=t/R`. Its contribution is `(Z*I0+Ilog)/(2*pi)`, where

`I0=integral_1^infinity exp(-v^2/2)/v dv`,
`Ilog=integral_1^infinity exp(-v^2/2)*log(v)/v dv`.

There is a short bound with no numerical quadrature. Set w=v^2. On `[1,2]`, `1/w<=(3-w)/2` because `(w-1)(w-2)<=0`; on `[2,infinity)`, `1/w<=1/2`. Thus

`I0 <= (1/4)*integral_1^2 (3-w)*exp(-w/2) dw + (1/4)*integral_2^infinity exp(-w/2) dw = exp(-1) < .368`.

Also `log(v)<=v^2/2` for v>=1, so `Ilog <= exp(-1/2)/2 < .304`. Consequently

`D_delta <= Dbar(L) = (G(A)-1069+5)/A + (Z^2-ell^2)/(4*pi) + (.368*Z+.304)/(2*pi)`. (2)

The strict decimal bounds are certified by positive Taylor sums in the script. The argument also handles zeros at A or H: A belongs to the head and is subtracted using its closed exact count; H belongs to the finite tail. There are no half-weights.

## 4. A continuum proof, not a grid of samples

On the full closed L interval, `Z>0` and

`Z'=1/L+1/(2*(L+10)) <3/(2L)`.

Moreover `R<125000`, `2*pi>6`, and `exp(11)>125000/6`, so `Z<11`. Formula (2) has

`Dbar'=(Z+.368)*Z'/(2*pi)>0`, and `Dbar'<3/L`.

The exact left-endpoint check gives `Dbar(22.33)>1`; hence everywhere `Dbar'/Dbar<3/L`. The count boundary discrepancy in (2) is independently positive; its sign was not reversed when dropping its damping.

The common factors `exp(q)` and `exp(a0/2)` decrease with L. The logarithmic derivative of `cosh(h*(L+a0))` is nonnegative and at most h, since `0<1+a0'<1` and tanh is at most 1. With `H_A>0`, logarithmic differentiation of the positive sum `H_A+cosh(h*(L+a0))*Dbar` gives an upper bound `h+3/L`. It follows that the first term of `L` times (1) decreases, because

`1/L-1/2+h+3/L =4/L+h-1/2 <0`.

The second term decreases as well: its cosh is constant, and its logarithmic derivative is at most `4/L-1<0`. Thus the maximum of the entire L-scaled through-H bound is attained at `L=22.33`. This includes the dependence of delta on L; no uniform delta minimum has replaced the actual damping.

## 5. Rational endpoint and complete allocation

The companion script uses Fraction arithmetic, Machin alternating arctangent brackets for pi, atanh log brackets after powers-of-two reduction, and positive exponential Taylor bounds. No floating transcendental value is an input to an acceptance check. The square root in R is eliminated using `log R=log500+log L+log(L+10)/2`. For the small lower-endpoint contribution, use the deliberately coarse `sqrt1000<32`, `log1000<7`.

| Quantity | Strict upper bound |
|---|---:|
| `Dbar(22.33)` | `5.009700139059211` |
| Main a-endpoint contribution to `L*E_zeros` | `.007379689772059` |
| Lower b-endpoint contribution | `.000002225792506` |
| Total through-H contribution | `.007381915564564` |
| All inherited other L-scaled costs | `.002188002001` |
| After upper-denominator factor `1.000001` | `.009569927135481` |

The inherited other costs, from `mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md` (SHA256 `33C01406E927F8F49F329AB52B967AA14B85B64DF7928A034C3028EFEEB91F61`), are high global tail `2e-9`, vertical `.00016`, shift `.002001`, leakage `.000009`, and cutoff `.000018`. The old `1e-12` intermediate allowance is retained unnecessarily: (1) already covers all zeros through H, so keeping it only enlarges the final bound. The same source sandwiches and positivity requirements apply. Their upper denominator is bounded by `1.000001`; applying it to the entire allocation is conservative.

The exact script also verifies `exp(22.33)<5e9`, so the enlarged logarithmic interval contains the desired interval. Above exp35, retain the existing shared-strip/global-tail proof from `integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md`, SHA256 `D4A026F5B7190F0AA577A70A88E7BFCB79740F9CA549EE9B7AC0EF0C782B3826`; no new all-x extrapolation is made from the present finite interval.

## 6. Scope and remaining work

This closes the scalar obstruction for this particular common psi envelope. It does not show that every use of a principal narrow-strip certificate elsewhere disappears. The head external certificates still require their proof/checker conversion, and the shared finite strip/global provider are not proved by this calculation. The formal implementation needs the actual multiplicity-preserving involution, closed-count partial summation, the elementary Gaussian integral bounds, and insertion into the existing good-height explicit-formula limit. These are explicit proof steps, not new permissible root assumptions.

The scalar work was coordinated with the main source derivation by prime_estimates and the symmetry derivation by zero_sum. The elementary I0 bound was supplied by root. The separate independent review is not replaced by these cross-checks.

Reproduce only the scalar receipt with `work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/major-constants/psi_damped_scalar_budget_20261111.py`. This command writes only the adjacent JSON receipt. It evaluates rational Taylor bounds, not analytic zeta/L values.
