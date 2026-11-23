# Coarse inverse-square sum and the three-unit formula remainder

This companion to `RECIPROCAL_HEAD_REUSE_2026-11-11.md` replaces the sharp historical inverse-square input by a weaker consequence of the already reviewed height-1500 head. It requires no new zero locations, count checkpoints, Hadamard product identity, or analytic-function evaluations. The result is conditional paper arithmetic using the accepted external head and analytic count theorem; their formal checker bridges remain required.

## All-zero inverse-square bound

Use exactly the head/count conventions and pinned sources of the companion: A=1500, no nontrivial zero with |gamma|<=14, N(A)=1069, and Q_A<1.668. Conjugation preserves multiplicity. For positive ordinates in the head,

\[
 \sum_{0<|\gamma|\le A}\frac{m_\rho}{\gamma^2}
 <\frac2{14}\left(1.668+\frac{1069}{1500}\right)
 =\frac{3571}{10500}<.341. \tag{1}
\]

Here Q_A is the integrated count, so the boundary term N(A)/A is essential. The strict lower ordinate bound makes 1/gamma^2 <= (1/14)/gamma valid. This does not assume the head zeros lie on the critical line.

For U>A, Stieltjes summation and the closed count give

\[
 \sum_{A<|\gamma|\le U}\frac{m_\rho}{\gamma^2}
 =\frac{2N(U)}{U^2}-\frac{2N(A)}{A^2}
   +4\int_A^U\frac{N(t)}{t^3}\,dt.
\]

The count envelope N<=P+5logt+20 implies N(U)/U^2 tends to zero and the integral converges. Thus it proves summability as well as a bound. Dropping the negative A-boundary and integrating the envelope yields

\[
 \sum_{|\gamma|>A}\frac{m_\rho}{\gamma^2}
 \le4\int_A^\infty\frac{P(t)+5\log t+20}{t^3}\,dt
 =\frac{2\log(A/(2\pi))}{\pi A}
   +\frac{10\log A+187/4}{A^2}
 <\frac{12}{3A}+\frac{80+187/4}{A^2}
 =\frac{2723}{1000000}<.003. \tag{2}
\]

Only t>=1500 uses this analytic envelope. Combining (1) and (2) proves the unconditional-in-RH, multiplicity-weighted bound

\[
 \sum_{\rho}\frac{m_\rho}{\gamma_\rho^2}
 <\frac{7199183}{21000000}<.344<1. \tag{3}
\]

The sum ranges over all nontrivial zeros, with both ordinate signs. Real zeros do not occur by the head exclusion. No convention at A is lost: head and tail are respectively closed and open there.

## Explicit-formula adapter

[Büthe, arXiv:1410.7015v4, Proposition 2](https://arxiv.org/pdf/1410.7015v4) expresses the Logan-smoothed psi function using `a(rho)*(x^rho-1)/rho`, a constant `C1=-gamma_E/2-1-log(pi)/2`, the elementary trivial-zero term, and a remainder bounded by `8*eps*|log eps|`. Its domain includes `0<eps<1/10` and `log x>2/|log eps|`. [Büthe, arXiv:1511.02032v2, Proposition 2](https://arxiv.org/pdf/1511.02032v2) removes the `-1` using zero reflection and a sharp historical inverse-square bound. We replace that one input by (3), accepting a larger remainder.

For c>0, the actual even nonnegative Logan kernel eta has positive normalization lambda=integral eta(t)exp(t/2)dt. Its normalized Mellin factor is

`a(rho)=lambda^(-1)*integral eta(t)*exp((rho-1/2)*t)dt`.

Evenness gives a(1-rho)=a(rho). Since 0<Re(rho)<1, positivity and evenness also give

`|a(rho)| <= integral eta(t)cosh((Re(rho)-1/2)*t)dt/lambda <=1`.

Reflection rho->1-rho preserves actual analytic orders and each finite symmetric height carrier. Pairing that finite carrier, including any fixed points without division into distinct pairs, gives

\[
 \sum_{|\gamma|\le U}\frac{m_\rho a(\rho)}\rho
 =\frac12\sum_{|\gamma|\le U}
       \frac{m_\rho a(\rho)}{\rho(1-\rho)}.
\]

Because |rho(1-rho)|>=gamma^2, the right series is absolutely summable by (3) and its norm is less than 1/2. This supplies the symmetric-cutoff limit needed to remove the constant part of the zero summand. It does not assume absolute convergence merely from |a|<=1; the original smoothed formula retains its own convergence proof.

Now assume x>=10 and 0<eps<=10^(-4), as well as the original formula's domain. The elementary inequalities 0<gamma_E<1 and logpi<log4<1.4 give |C1|<2.2. Further,

`-log(1-x^(-2))/2 <=1/198<.006`,

and monotonicity of eps*|log eps| on (0,exp(-1)) gives
`8*eps*|log eps|<.008` from log10<2.5. Therefore

\[
 |\text{total remainder}|<.5+2.2+.006+.008=2.714<3.
\]

The modified formula is consequently

`x-psi_(c,eps)(x)=sum_rho m_rho*a(rho)*x^rho/rho + error`,

with error norm less than3. The kernel identities, original explicit formula, source zero reflection, and elementary Euler-constant facts remain analytic proof obligations. This note neither imports the sharp Rosser inverse-square bound nor claims those obligations are already formalized.

## Consumer allocation

Changing the uniform remainder bound from2 to3 increases a normalized `sqrt(x)*log(x)^2` error coefficient by at most `1/(sqrt(x)*log(x)^2)`. For the proposed range x>=10^16, logx>=36, the combined arithmetic is

`0.030686 + (2/25)/36^2 + 1/(10^8*36^2)`
`=442767289/14400000000 < .031`.

The consumer must apply this to the actual x used in the smoothed formula, or retain its exact displacement factor. This inequality is a budget component, not a verification of the author's whole prime-gap proof. It shows why recovering the unused sharp .05 sum is unnecessary at this allocation.

## Exact evidence

Companion note SHA256 `8EC98EEAC527630E0D3F558B63A0CE9897189DA389932FC7B0F536510EA9D27F` pins the head/count reports and exact conventions. The new script `inverse_square_head_reuse_scalars_20261111.py` passes eight rational assertions, including positive-series proofs for exp(1.4)>4 and exp(2.5)>10. It reads no zero data or evaluators.

Script SHA256 `9F968A0B0991C597558993BF011A0F40966083C70DAE293E4552ACAD352088B5`.

Receipt SHA256 `559DF9AB7EDC4EE8A3E9BCE0BD7685DEDF431D0321F916585AF38427B567923A`.
