# A purely analytic count bound sufficient for the psi leaf

Research derivation, 2026-11-11. No finite zero data, Lean build, canonical edit, or change to frozen files. The argument below replaces the unreconstructed Rosser high-count input in `RESUME_PSI_SPECTRAL_LEAF_2026-11-11.md` by a much coarser bound derived directly from an elementary zeta growth estimate, Jensen, and the argument principle. This is a paper proof proposal with explicit formalization obligations, not a kernel theorem.

## Outcome and available budget

For the closed multiplicity count

\[
N(t)=\sum_{\substack{\zeta(\rho)=0,\ 0<\Re\rho<1\\0<\Im\rho\le t}}m_\rho,
\qquad
F(t)=\frac{t}{2\pi}(\log(t/(2\pi))-1)+\frac78,
\]

the following analytic bound suffices and is derived below:

\[
\boxed{N(t)\le F(t)+5\log t+20\qquad(t\ge1500).}
\tag{C}
\]

It uses no QRH, finite RH, or historical zero counts. The subsequent moment implication still needs the separately proposed finite strip and finite head certificate.

Set a=1500, T=1000000 and

\[
B_0=\frac{\log^2(T/(2\pi))-\log^2(a/(2\pi))}{4\pi}+\frac{F(a)}a.
\]

For any nonnegative A,B, the bound `N(t)<=F(t)+A log t+B` for t>=a, together with the frozen head target
`Q_a=sum_(0<gamma<=a) m*(1/gamma-1/a)<=2`, gives

\[
W_{35}\le (1+e^{.035})
\left[2+B_0+\frac{A(\log a+1)+B}{a}\right]
\tag{M}
\]

provided the finite strip is (.499,.501), the height14 exclusion holds, and reflection/conjugation preserve multiplicity. The integration by parts and endpoint corrections are exactly those in the preceding spectral-leaf note. In particular, the factor `1+exp(.035)` includes both ordinate signs and reflection averaging; no further factor2 is missing.

The exact maximum error budget is

\[
A(\log1500+1)+B
<1500\left[\frac{24}{1+e^{.035}}-2-B_0\right].
\tag{B}
\]

The right side is approximately69.55481675; the rational checker proves that replacing it by69.5 is safe. With B=10, the diagnostic maximum A is approximately7.163868. The following are certified rounded upper bounds from exact rational Taylor calculations:

| A | B | Upper bound for W35 |
|---:|---:|---:|
| 4 | 10 | 23.965 |
| 5 | 10 | 23.976 |
| 6 | 10 | 23.987 |
| 7 | 10 | 23.999 |
| **5** | **20** | **23.990** |

The selected (C) therefore preserves W35<24 with Q1500<=2. No change to the frozen psi sandwich is needed. None of the finite spectral hypotheses is asserted true by this calculation.

## 1. A disk bound from the actual source

Use `TernaryGoldbach.Explicit.norm_zetaF_le` (`Explicit/ZetaGrowth.lean:177`) and `zetaF_of_ne:19`. For Re(s)>0 and s!=1 they give

\[
|\zeta(s)|\le\frac{|s|}{|s-1|}+\frac{|s|}{\Re s}.
\tag{1}
\]

Fix t>=1500, and let |z-2|<=19/10. For s=z+it or z-it,

\[
\Re s\ge1/10,\quad |s|\le t+39/10,
\quad |s-1|\ge |\Im s|\ge t-19/10.
\]

Thus (1) is at most
`(t+3.9)/(t-1.9)+10(t+3.9) < 2+10t+39 <12t`.
The disk and a neighborhood avoid the zeta pole, so both translated zeta functions are analytic there. No continuation at the pole is being estimated inside this disk.

Define the analytic auxiliary function

\[
f_t(z)=\frac{\zeta(z+it)+\zeta(z-it)}2.
\]

It satisfies `|f_t(z)|<12t` on the disk. On real z it is `Re zeta(z+it)`, by conjugation symmetry. Its center is bounded below independently of t:

\[
f_t(2)\ge1-\sum_{n\ge2}n^{-2}=2-\zeta(2)>1/4.
\tag{2}
\]

For the last strict inequality, split off n=2 and dominate the n>=3 tail strictly by `integral_2^infty u^-2 du=1/2`. This proves zeta(2)<7/4 without any evaluation of pi or zero data.

## 2. Jensen counts real-part crossings

Let n be the total analytic multiplicity of zeros of f_t in the closed disk centered2 with radius3/2. Jensen gives

\[
n\le\frac{\log(12t/|f_t(2)|)}{\log((19/10)/(3/2))}
<\frac{\log(48t)}{\log(19/15)}.
\tag{3}
\]

This is directly the shape of Mathlib's `AnalyticOnNhd.sum_divisor_le` (`Analysis/Complex/JensenFormula.lean:389`): positive inner radius, larger outer radius, analytic on a neighborhood of the closed outer disk, nonzero center, and a sphere norm bound with M>=1. Its conclusion counts the **closed** inner disk and does not require zero-free outer boundary. It already handles endpoint roots at z=1/2. The analytic multiplicities in (3) belong to f_t, not to zeta; they only bound the number of distinct real-part crossings.

Assume initially that t is not the ordinate of any nontrivial zeta zero. Along the horizontal segment from2+it to1/2+it, zeta is nonzero. The real roots of f_t on [1/2,2] partition it into at most n+1 open intervals. On each interval Re zeta has constant nonzero sign, so any continuous argument changes by at most pi between its endpoints. Taking endpoint limits and summing absolute changes gives

\[
|\Delta_{2+it\to1/2+it}\arg\zeta|\le(n+1)\pi.
\tag{4}
\]

Repeated or tangent real-part roots only increase the upper n. The function f_t is not identically zero by (2), so there are finitely many such roots on the compact segment.

Along Re(s)=2, the same Dirichlet-series estimate shows Re zeta>1/4. The argument starting at the positive number zeta(2) stays in (-pi/2,pi/2). If S(t) is the total continuous zeta argument along `2 -> 2+it -> 1/2+it`, divided by pi, then

\[
|S(t)|\le n+3/2.
\tag{5}
\]

This is the elementary real-part-crossing/Jensen method, without Backlund's doubled-zero refinement, powers of zeta, subconvexity, or numerical S(t) bounds.

## 3. Gamma phase with a deliberately coarse analytic remainder

Use the analytic logarithm of Gamma on Re(z)>0, normalized to be real on the positive real axis. It must not be replaced by the pointwise principal logarithm of Gamma(z). Binet's Laplace formula is

\[
\log\Gamma(z)=(z-1/2)\log z-z+\tfrac12\log(2\pi)
+\int_0^\infty e^{-zu}
\left(\frac1{e^u-1}-\frac1u+\frac12\right)\frac{du}{u}.
\tag{6}
\]

The stated domain and branch are essential. [NIST DLMF, equation5.9.10_2](https://dlmf.nist.gov/5.9.E10_2) supplies this analytic identity; it contains no finite zeta information. Proving or importing a kernel-checked version is an outstanding formal task.

Here the kernel admits the elementary bound

\[
0\le k(u)=\left(\frac1{e^u-1}-\frac1u+\frac12\right)/u\le1/12\qquad(u>0).
\tag{7}
\]

For clarity, both inequalities can be proved just by positive exponential-series coefficients. Clearing positive denominators, the lower inequality is equivalent to
`(u-2)exp(u)+u+2>=0`. Its coefficients vanish through degree2 and equal `(n-2)/n!` thereafter. The upper inequality is equivalent to
`(u^2-6u+12)exp(u)-u^2-6u-12>=0`. Its coefficients vanish through degree4 and equal `(n-3)(n-4)/n!` thereafter. Absolute convergence justifies these finite polynomial multiplications and rearrangements.

Consequently the remainder in (6) has norm at most `1/(12 Re z)`. At z=1/4+it/2 this is at most1/3. Put

\[
\vartheta(t)=\Im\log\Gamma(1/4+it/2)-(t/2)\log\pi.
\]

Expanding the main term of (6), and using the principal logarithm of z in the right half-plane,

\[
\vartheta(t)=\frac t2\log\frac{t}{2\pi}-\frac t2-\frac\pi8
+\frac t4\log\left(1+\frac1{4t^2}\right)
+\frac14\arctan\frac1{2t}+\Im R_\Gamma(z).
\]

Use log(1+v)<=v and arctan(v)<=v for v>=0. For t>=1500,

\[
\left|1+\frac{\vartheta(t)}\pi-F(t)\right|
\le\frac{1/3+3/(16t)}\pi<1/8.
\tag{8}
\]

This needs only pi>3. A sharper complex Stirling error is unnecessary. Mathlib's inspected `Analysis/SpecialFunctions/Stirling.lean` concerns real factorial asymptotics; it is not a ready-made proof of (6).

## 4. Counting identity, normalization, and closed heights

For t not a zero ordinate, the argument principle for the completed xi function, its functional equation, and conjugation give

\[
N(t)=1+\vartheta(t)/\pi+S(t).
\tag{9}
\]

The zeta argument is the path-continuous one fixed above, not the principal argument at the endpoint. The +1 is the contribution from the pole in the usual contour normalization. One can instead work throughout with the entire source `zetaF` and xi, tracking the polynomial factors explicitly. The standard proof uses their analytic functional equations, Gamma nonvanishing in the right half-plane, the Dirichlet-series/Euler-product region, and nonvanishing of zeta on the real interval(0,1). The latter follows from the alternating eta series and introduces no positive-height count. All nontrivial multiplicities enter through the argument principle.

For a primary account of this analytic contour calculation and the real-part-crossing step, see §2, equations(2.1)–(2.5), of [Trudgian's paper](https://arxiv.org/pdf/1208.5846). Only those analytic steps are used here; the paper's numerical all-height S bound and finite computations from §1 are not used. Formula(9) and the branch/multiplicity transport still require a source-faithful Lean implementation.

Combining (3), (5), and (8) yields

\[
|N(t)-F(t)|<\frac{\log(48t)}{\log(19/15)}+\frac{13}8.
\tag{10}
\]

The rational scalar checks prove `exp(2/9)<19/15` and `exp(4)>48`. Thus, for t>=1500,

\[
\frac{\log(48t)}{\log(19/15)}+\frac{13}8
<\frac92\log t+18+\frac{13}8
<5\log t+20.
\]

This proves (C) at nonzero ordinates. For arbitrary t, choose a sequence t_j decreasing to t, with t_j not zero ordinates. Such heights exist because xi's zeros are locally finite and lie in a fixed vertical strip. The closed count obeys `N(t)<=N(t_j)`, including every zero at height t with its full multiplicity. Taking the limit on the continuous majorant gives (C) with a non-strict inequality. No half-weight convention is used, and no assumption that1500 or1000000 avoids zero ordinates is needed for this count bound.

## Status and smallest formal targets

The script `resume_psi_analytic_count_20261111.py` passes exact rational scalar checks, including (B), the final moment table, the disk constants, and the gamma-error arithmetic. It reuses only scalar helpers from the frozen spectral-leaf checker, with no writes and no zeta evaluation. It verifies low-degree coefficient cancellation in (7); positivity of every later coefficient is supplied by the displayed symbolic formulas, not inferred from finite samples.

The mathematical derivation has replaced the Rosser-constant task by these explicit analytic obligations:

1. Apply the existing zetaF growth and Jensen divisor APIs to f_t; relate real-part roots to continuous argument variation.
2. Establish normalized complex log-Gamma/Binet (6) and the elementary kernel bound(7), or prove the weaker phase inequality(8) by another analytic route.
3. Formalize (9), matching actual xi/zetaF multiplicities and the continuous argument branch; extend to closed heights by right limits.
4. Combine with the already described partial-summation and reflection argument.

Steps1–3 are not proved Lean declarations in this report. The small finite zero-free rectangle, stronger finite strip through one million, and Q1500<=2 are still separate unproved certificate tasks. The count bound itself introduces no finite-data premise and no new allowed root assumption.
