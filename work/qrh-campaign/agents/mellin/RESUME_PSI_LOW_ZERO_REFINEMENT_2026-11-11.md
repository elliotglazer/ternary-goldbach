# A low-zeta moment refinement for the psi gap

Research derivation, 2026-11-11. Source: ternary-goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean compilation, canonical edit, or zero computation. All finite spectral statements below are **new tasks to certify**, not known facts imported into the final theorem.

The strongest useful result here is a quantitative conditional reduction of the remaining prime interval from `[10^9,exp(35))` to **`[10^9,5*10^9)`**. In addition to the already proposed shared zeta strip through H=60343058 and global7/8, it suffices to certify low-zeta data through T=1000000 satisfying either of the following contracts:

1. Every nontrivial zero through T is on beta=1/2, and the both-sign multiplicity moment `sum m_rho/|rho|` through T is at most24.
2. More flexibly, every nontrivial zero through T has `.49<=beta<=.51`, and

\[
\tag{W}
\sum_{|\gamma|\le10^6}m_\rho
\frac{\exp(35\max(\beta-1/2,0))}{|\rho|}\le24.
\]

Contract2 avoids critical-line equality. The first is a simpler sufficient way of obtaining it. Both require a complete multiplicity-aware certificate; this task has not checked their truth. Neither should be added as a permanent assumption to Goldbach.

Under either contract, the paper argument below gives

\[
|\psi_R(x)-x|<.00981\,x/\log x<.01\,x/\log x
\qquad(x\ge5\cdot10^9).
\]

The new argument covers `5e9<=x<=exp35`; the existing conditional psi-tail report covers all larger x. At integers, psiR(n)=psiN(n), giving precisely the remaining Möbius envelope. The shared finite .555 spectral condition and genuine global provider remain unproved campaign inputs, not consequences of this refinement.

## 1. What improves the previous calculation

The prior report `integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md` replaces all low reciprocal-zero information by38 zeros per length3 window and bounds the two Mellin endpoints by2. These are valid but costly at small x. The present argument instead uses an actual finite reciprocal moment, retains the small lower endpoint `(y0/x)^beta`, and integrates the vertical-line factor directly rather than replacing it by its uniform maximum82.6.

These changes concern three separate costs. Merely enlarging the high cutoff would not improve the dominant low-zero term. Merely replacing2 by1 would also not suffice with the old coarse count. The vertical refinement leaves useful margin near the new threshold.

The following source interfaces are unchanged:

* `GaussSmooth.norm_intExp_le':355`: the numerator is `exp(a beta)+exp(b beta)`, divided by |rho|.
* `ZetaZeroSums.norm_Mg_strip_le:106`: the Gaussian ordinate factor is `exp(-delta^2 gamma^2/2)`.
* `ZetaExplicit.explicit_formula_zeta_seq:122` and its good-height limit: the actual smoothed prime sum, pole term, and nontrivial zeros.
* `PsiExplicit.norm_logDeriv_zeta_left:21`: on s=-1/2+it, the logarithmic derivative is bounded by `(2/log2+4.8)(40+2.6|t|)`.
* `PsiLarge.psi_upper_of_err:296` and `psi_lower_of_err:326`: the exact positive-smoothing sandwiches with the unconditional coarse bound psiR(y)<=4y.

Do not invoke the specialized RHBelow-H error theorem unchanged. The finite-rectangle triangle estimate must be proved with the three spectral ranges below and then passed through the same good-height sequence. This is analytic proof work still to implement.

## 2. Parameters and low range

Put L=log x. On the new finite range take

\[
22.33\le L\le35,\quad
K=\sqrt{L+10},\quad
\delta=\frac{.002}{L\sqrt{L+10}},\quad
a=\pm\frac{.002}{L},\quad y_0=1000,\quad b=\log(y_0/x).
\]

The exact inequality `exp(22.33)<5e9` makes this enlarged L range cover every x>=5e9 up to exp35. Both source sandwiches apply: delta>0, delta<=1, delta<=K, b<=-|a|, and y0 exp(|a|)<=x. The upper denominator `1-2exp(-K^2/2)` is positive.

For contract1, the normalized low-zero contribution is at most

\[
e^{\delta^2/2}
\left(e^{|a|/2}+\sqrt{y_0/x}\right)x^{-1/2}
\sum_{|\gamma|\le T}\frac{m_\rho}{|\rho|}.
\]

The deliberately enlarged Gaussian prefactor `exp(delta^2/2)` covers the exact beta-square factor. Dropping ordinate damping only enlarges this finite sum. The endpoint coefficient is uniformly `<1.002`, not2.

For contract2, use

\[
x^{\beta-1}\le x^{-1/2}\exp(35\max(\beta-1/2,0)),
\]

and `exp(a beta)<=exp(.51|a|)`, `exp(b beta)<exp(-.49(L-7))`, since log1000<7. This again makes the whole endpoint factor `<1.002`. Thus the same bound follows from W, with no phase or zero-spacing assumption:

\[
L E_{low}\le24(1.002)L e^{-L/2}<.00761.
\]

The function L exp(-L/2) decreases for L>2, so this is an endpoint proof, not a sample grid. Its checked endpoint upper value is approximately .007604484795.

The moment includes both ordinate signs and true multiplicities. A zero on the real axis, if present in a candidate carrier, is not silently omitted: |rho| is positive under the certified beta range and its reciprocal contributes normally. No minimum ordinate or simplicity assertion is used.

## 3. Intermediate zeros: shared finite strip only

For `T<|gamma|<=H`, retain only the shared finite strip `.445<=beta<=.555`. The translated xi-mass bridge from the principal chapter gives at most38 zeros, with multiplicity, per length3 interval through H. Its assumptions and pending formal proof are exactly those in the existing psi-tail note.

Partition each sign into bins beginning at T. Since gamma>=T+3k,

\[
\sum_{T<|\gamma|\le H}
\frac{m_\rho e^{-\delta^2\gamma^2/2}}{|\rho|}
\le \frac{76}{T}e^{-\delta^2T^2/2}
\frac1{1-e^{-3\delta^2T}}.
\]

The76 is the two-sign count; no further factor2 is missing. Use `(1-exp(-z))^-1<=1+1/z` and the uniform lower bound

\[
\delta^2\ge\delta_{min}^2
=\frac{.002^2}{35^2(35+10)}.
\]

Even dropping the entire favorable factor x^(-.445), and bounding the Mellin endpoint coefficient by2.001, gives

\[
L E_{mid}\le35(2.001)\frac{76}{T}
e^{-\delta_{min}^2T^2/2}
\left(1+\frac1{3\delta_{min}^2T}\right)<10^{-12}.
\]

The rational check gives an upper diagnostic about4.283e-15. Therefore the stronger low certificate is needed only through one million, not throughout the shared height. Endpoints at T belong to the low certificate; high bins cover the strict complement. Counting a boundary twice would only enlarge the upper estimate, but completeness must still be proved.

## 4. Global QRH tail

For |gamma|>H keep the existing Gaussian high-tail calculation with x^(-1/8), `Z3g(BPz2,H)<180`, and `c3g(10,H)<1e-6`. The new delta is at least the old `.001/L^(3/2)` because `4L>=L+10` on this range. The Gaussian damping is therefore stronger and its geometric inverse denominator smaller. The coefficient2.001 still bounds the Mellin endpoints uniformly.

The prior uniform proof extends to L>=22.33 without changing its `L E_high<2e-9` allowance: on `[22.33,200]` it used only L<=200 and discarded exp(-L/8); above200 the polynomial-times-exponential argument is unchanged. The companion script rechecks both endpoint allocations exactly. Counts already include both signs and multiplicities, and all inequalities hold on every finite explicit-formula carrier before taking a limit.

## 5. A sharper vertical integral from the same source bound

The source proof bounds `(40+2.6|t|)/sqrt(1/4+t^2)` by82.6 before integration. Instead, for `0<delta<=1`, split the reciprocal term at |t|=1 and |t|=1/delta. One obtains

\[
\begin{split}
I_\delta&=\int_{\mathbb R}
\frac{40+2.6|t|}{\sqrt{1/4+t^2}}e^{-\delta^2t^2/2}\,dt\\
&\le240+80\log(1/\delta)+\frac{2.6\sqrt{2\pi}}\delta.
\end{split}
\]

Indeed, |t|/sqrt(1/4+t^2)<=1 gives the exact Gaussian integral for the2.6 term. The40 term contributes at most160 on [-1,1], at most80log(1/delta) on the middle region, and at most80 on the tail: after u=delta|t|, use `1/u<=u` for u>=1 and `integral_1^infinity u exp(-u^2/2)du<1`.

Using the actual endpoint factor on Re s=-1/2 gives the normalized vertical bound

\[
E_{vert}\le\frac{2/\log2+4.8}{2\pi}
e^{\delta^2/8}
\left(e^{|a|/2}x^{-3/2}+\frac{x^{-1}}{\sqrt{1000}}\right) I_\delta.
\]

The x^-1/sqrt(y0) term is retained. It cannot be treated as x^-3/2. On this finite L range, `1/delta<120000`, `log(1/delta)<12`, `sqrt1000>31`, and `sqrt(2pi)<2.51`. The leading coefficient, including the tiny exponentials, is below1.34. Thus

\[
L E_{vert}\le1.34(240+80\cdot12+6.526\cdot120000)
L\left(e^{-3L/2}+e^{-L}/31\right)<.00016.
\]

Both exponential factors decrease after the lower endpoint. The checked endpoint bound is about .000151886771. This is a genuine new integrated estimate derived from the existing pointwise source theorem; it is not an assumed better logarithmic-derivative bound. Its integrability and domain splits need a Lean proof.

## 6. Complete desmoothing budget and all-x scope

Let E be the sum of the three zero ranges and the vertical contribution, normalized by x; put `r=exp(-(L+10)/2)` and `a0=.002/L`. The source sandwiches give

\[
U=4000e^{a_0-L}+
\frac{e^{\delta^2/2+a_0}-1+E+2r}{1-2r},
\qquad
D=1-e^{-a_0}+2000e^{-L}+E+4r.
\]

Both satisfy `|psiR(x)-x|/x<=max(U,D)`. The larger terms can be budgeted as follows, after multiplication by L:

| Contribution | Uniform upper allowance |
|---|---:|
| Low zeros through T | .00761 |
| Intermediate zeros through H | 1e-12 |
| High QRH tail | 2e-9 |
| Vertical line | .00016 |
| Main shift | .002001 |
| Gaussian leakage, using4r | .000009 |
| Low cutoff, using4000 | .000018 |
| Upper-denominator multiplier | 1.000001 |

The exact total is bounded by .009798011781002001, hence is below .00981. For the shift, expand the exponential in positive powers: `L*(exp(.002/L+delta^2/2)-1)` decreases as L increases, since every nonconstant term is a positive product of nonincreasing inverse powers of L and L+10. The remaining endpoint monotonicities are elementary `L exp(-cL)` comparisons. No continuum interval is left to numerical sampling.

At x=exp35 either this argument or the existing report applies. For larger x, use the latter report's proved-on-paper `<.0081/log x` bound under the same shared finite strip/global QRH. There is no claim that a fixed finite low moment alone controls all arbitrarily large x. The new local argument plus the old tail is the complete uniform conditional deduction.

## 7. A stringent target that would reach 10^9 directly

For completeness, a separate exact scalar test gives a sufficient data target on `[1e9,5e9]`. Keep finite RH through T=1e6 and impose the **additional** Gaussian reciprocal moment

\[
\tag{W_9}
\sum_{|\gamma|\le T}
\frac{m_\rho\exp(-\gamma^2/(2\cdot50000^2))}{|\rho|}\le10.8.
\]

Use fixed delta=1/50000, K=5.5, y0=1000. On the enclosing logarithm interval `[20.72,22.34]`, retain the same exact low endpoints, direct vertical integral and source sandwiches. The scalar replay gives a complete scaled budget below .009955109. Together with contract1 above for larger x, this would reach every x>=1e9.

**No feasibility claim is made for W9.** It is a stricter moment target, not evidence about actual zeros; this task has not even computed the actual weighted moment. It may fail when tested. Do not adopt it as an available certificate or infer it from the unweighted bound24. The actionable conservative route is the five-billion threshold with the explicit short prime interval left over. W9 records exactly what one particular absolute-value method would need to remove that interval; phase cancellation or a different smoothing could change the target.

## 8. What a finite certificate must contain

An ordinate table without completeness does not establish these moments. A proof-producing low certificate needs argument-principle/counting coverage of the entire low rectangle, with true multiplicities, plus either critical-line membership or beta boxes. For conjugate positive-height boxes `[ell_j,u_j]` of multiplicity n_j, contract1 can be bounded by

\[
2\sum_j\frac{n_j}{\sqrt{1/4+\ell_j^2}},
\]

with any real-axis zeros handled separately. For contract2, use each certified beta interval `[b_j^-,b_j^+]` and upper bound its contribution by

\[
\frac{n_j\exp(35\max(b_j^+-1/2,0))}
{\sqrt{(b_j^-)^2+\ell_j^2}}.
\]

Sum both signs explicitly or prove conjugation preserves orders before doubling. For W9 insert the decreasing Gaussian factor evaluated at ell_j. All transcendental enclosures need sound rational replay; external Arb results are not axioms. It is also possible to certify coarser height bins with counts, provided the resulting outward-rounded moment fits. No assumption of simplicity or pairwise separation is needed.

The tighter low beta information is mathematically stronger than shared .555 on this small rectangle, so it is a new spectral workload, not a free consequence of QRH. The moment requirements expose the needed quantitative data; they do not hide them inside a final psi error cap. No comparison of certificate runtime is claimed. The remaining prime interval `[1e9,5e9)` includes its lower endpoint, because the existing sieve has a strict upper endpoint at1e9.

## Exact evidence and remaining proof work

`resume_psi_low_zero_refinement_20261111.py` completed with exit0. All acceptance checks use rational arithmetic and positive Taylor bounds; displayed decimals are diagnostics. JSON values for long rational expressions are rounded **up** at denominator10^18.

| Artifact | SHA256 |
|---|---|
| Script | `702632F337600C7BC9E1B68DFE6AA2A89967A526F884861093A4BDF2F933D261` |
| JSON | `AF92F5DDCD6696153DEBCFF945EF0405DF587F53A250AD8A4EE24A178A24D689` |
| Log | `91B731EE1D17777F8E6405B8D4A8EC92C01ACD5C0521EBD21A9F0EFE9450AB06` |

Besides actual finite data, the missing formal interfaces are the true-multiplicity translated mass/count bridge, reciprocal-moment finite-sum application, the new vertical integral estimate, the QRH-powered high tail, common good-height limit, both source sandwiches and their monotone scalar adapters. No statement here asserts a completed Lean theorem or authorizes a result-shaped hypothesis in the final result.
