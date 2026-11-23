# Littlewood's identity with the canonical Euler logarithm

2026-11-11. This note reconstructs the identity needed by the family Turing argument. It supplies a paper proof using finite analytic factorization and Cauchy–Riemann equations, including zero ordinates and the right-edge limit. It is not a Lean theorem or a numerical zero certificate. No RH, simplicity, zero-list completeness, Gamma estimate, build, scan, or frozen-file edit is used.

## Exact statement and sources

Let chi be a primitive nonprincipal complex Dirichlet character of conductor Q>1, of either parity. Set f(s)=L(s,chi), the actual entire analytic continuation of its Dirichlet series. For t>50 define

\[
 I_\chi(t)=\int_{1/2}^{\infty}\log|f(\sigma+it)|\,d\sigma.
 \tag{1}
\]

At the finitely many zero abscissas in a bounded horizontal segment, assign any finite value to the real integrand. The integral is independent of that assignment. For a nonexceptional ordinate t, let S_chi(t) be 1/pi times the imaginary part of the logarithm continued horizontally from the Euler logarithm on Re(s)>1 to s=1/2+it. At exceptional ordinates one may use the average of the two one-sided limits, or any finite values. These choices give the same integral.

The conclusion, including exceptional endpoints, is

\[
 \boxed{\pi\int_{t_1}^{t_2}S_\chi(t)\,dt
       =I_\chi(t_2)-I_\chi(t_1)}\qquad(50<t_1<t_2).   \tag{2}
\]

Moreover I is locally Lipschitz on this height domain, S is locally bounded and measurable after the finite exceptional-value assignment, and I'=pi*S almost everywhere. The proof in fact works on any compact real height interval for an entire nonprincipal L-function, but (2) is the requested consumer domain.

The primary printed identity is Trudgian, *Improvements to Turing's Method*, [arXiv:0903.1885v3](https://arxiv.org/pdf/0903.1885), Lemma 3.4, equation (3.5), p12; the normalization is equation (3.2), p11. The local PDF `audit/trudgian_turing_0903_1885.pdf` has SHA256 `E8D021A3C083D0F07427760661478E47390D446D06714257DEE702246FACC878`. Both passages were read. The printed proof refers back to Littlewood's lemma; the detailed proof below does not import that reference as an unexplained premise.

The family consumer and endpoint convention are the accepted plans:

* `zero-sum/FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md`, SHA256 `740840E7576E988AF4C8F8053030BE59EB4EA18DE8C7E0D6B391BF7C9B1C5DEF`.
* `zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md`, SHA256 `6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4`.

Their independent review, `major-constants/REVIEW_FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md`, fixes the same Euler-normalized S in the two-sided count. No root-number argument is added to S here.

## 1. Euler normalization and its explicit tail

For Re(s)>1 define the absolutely convergent series

\[
 \ell_\chi(s)=\sum_{p\ \mathrm{prime}}\sum_{k\ge1}
                  \frac{\chi(p)^k}{k p^{ks}}.        \tag{3}
\]

The Euler product gives exp(ell_chi)=f there, and ell tends to zero at right infinity. Local uniform absolute convergence makes ell holomorphic. For sigma>=2, uniformly in t,

\[
 |\ell_\chi(\sigma+it)|\le\log\zeta(\sigma)
 \le\zeta(\sigma)-1
 \le2^{-\sigma}+\int_2^\infty x^{-\sigma}\,dx
 \le3\,2^{-\sigma}.                                \tag{4}
\]

Thus the Euler logarithm has both a uniformly vanishing right-edge value and an absolutely integrable horizontal tail. In particular

\[
 \int_R^\infty |\log|f(\sigma+it)||\,d\sigma
 \le\frac{3\,2^{-R}}{\log2}\quad(R\ge2).             \tag{5}
\]

The real-part identity Re ell=log|f| follows from exp ell=f, without choosing a principal logarithm of f. At Re(s)=2 the Dirichlet series also gives |f-1|<3/4. Consequently the Euler log there is the right-half-plane logarithm, continuously connected to 0 at right infinity. Continuing first from 2 to 2+it therefore gives precisely the same branch as (3). For nonreal chi the initial imaginary value at 2 need not be zero. Setting it to zero would be an incorrect normalization.

## 2. Factor actual zeros on a compact rectangle

Put a=1/2 and fix R>=2 and a compact height interval J containing [t1,t2] in its interior. Choose a slightly larger bounded open rectangle U containing [a,R]+iJ. Since f is entire and nonzero on the Euler half-plane, it is not identically zero. Its zeros in the closure of U form a finite set. Write them as rho_j=beta_j+i*gamma_j with their actual finite positive analytic orders m_j, and put

\[
 P(s)=\prod_j(s-\rho_j)^{m_j},\qquad g=f/P.
\]

The quotient has its removable values at these zeros and is holomorphic and nonvanishing on U. A holomorphic nonvanishing function on a simply connected rectangle has a holomorphic logarithm h, so

\[
 f(s)=e^{h(s)}\prod_j(s-\rho_j)^{m_j}\quad(s\in U).   \tag{6}
\]

Every rho_j has beta_j<R: the Euler product excludes all zeros with real part greater than 1. On a narrow connected neighborhood of the line R+iJ, each s-rho_j has positive real part and has its principal holomorphic logarithm. The difference

\[
 \ell_\chi(s)-\sum_jm_j\operatorname{Log}(s-\rho_j)-h(s)
\]

has exponential 1 and is therefore a constant multiple of 2*pi*i on that neighborhood. Add that constant to h once. This fixes the exact equality

\[
 h(R+it)+\sum_jm_j\operatorname{Log}(R+it-\rho_j)
       =\ell_\chi(R+it),\qquad t\in J.               \tag{7}
\]

This step determines the otherwise missing integer branch constant. The finite set used in (6) is the mathematically defined zero set of f on a compact region, not an assumed complete numerical list.

For t unequal to the gamma_j, the entire horizontal path a<=sigma<=R avoids these zeros. For each factor use the continuous argument

\[
 A_j(\sigma,t)=\operatorname{Arg}(\sigma-\beta_j+i(t-\gamma_j)),
 \qquad -\pi<\operatorname{Arg}<\pi.                 \tag{8}
\]

For t>gamma_j this path lies in the upper half-plane, and for t<gamma_j it lies in the lower half-plane. Thus (8) is continuous along the path even when its real part becomes negative. At sigma=R it agrees with the branch in (7). Uniqueness of continuation consequently gives

\[
 \pi S_\chi(t)=\operatorname{Im}h(a+it)
                    +\sum_jm_j A_j(a,t).             \tag{9}
\]

One may enlarge the exceptional set to all actual nontrivial zero ordinates in J, as in the published definition. That is still finite on J and changes no almost-everywhere statement. The finite-dimensional expression (9) proves measurability and local boundedness immediately. It does not assert that the principal argument of the whole value f(a+it) equals the right side.

## 3. A single zero contributes a Lipschitz log potential

For rho=beta+i*gamma with beta<R define

\[
 H_\rho(t)=\int_a^R\log|\sigma-\beta+i(t-\gamma)|\,d\sigma.
 \tag{10}
\]

This is finite also at t=gamma: the only possible singularity is an integrable log|sigma-beta|. For y=t-gamma!=0, differentiation under the compact integral gives

\[
 H_\rho'(t)=\int_a^R\frac{y}{(\sigma-\beta)^2+y^2}\,d\sigma
  =\operatorname{Arg}(a-\beta+iy)
      -\operatorname{Arg}(R-\beta+iy).               \tag{11}
\]

The sign follows from d Arg(x+iy)/dx=-y/(x^2+y^2). Also

\[
 |H_\rho'(t)|\le\int_{\mathbb R}\frac{|y|}{x^2+y^2}\,dx=\pi. \tag{12}
\]

For completeness, continuity at y=0 follows from the following explicit antiderivative for y!=0:

\[
 K_y(x)=\frac{x}{2}\log(x^2+y^2)-x+y\arctan(x/y).
\]

Its x derivative is log|x+iy|. For fixed x, K_y(x) tends to x*log|x|-x, with value 0 at x=0. Hence H_rho is continuous at gamma. Applying the derivative bound separately on both sides and joining at gamma proves that H_rho is pi-Lipschitz on J. In particular it is absolutely continuous and (11) is its derivative almost everywhere. There is no singular point mass in its first distributional derivative.

## 4. The finite-width identity and all branch jumps

Taking real parts of (6) and integrating gives, with equality of the integrands away from their finitely many zero points,

\[
 I_R(t):=\int_a^R\log|f(\sigma+it)|\,d\sigma
   =\int_a^R\operatorname{Re}h(\sigma+it)\,d\sigma
       +\sum_jm_jH_{\rho_j}(t).                     \tag{13}
\]

The first term is continuously differentiable on J, and the remaining terms are Lipschitz by (12). Therefore I_R is locally Lipschitz. Write h=u+iv. The Cauchy–Riemann sign is u_t=-v_sigma, so

\[
 \frac{d}{dt}\int_a^Ru(\sigma,t)\,d\sigma
        =v(a,t)-v(R,t).
\]

Combining this with (7), (9), and (11) proves

\[
 I_R'(t)=\pi S_\chi(t)-\operatorname{Im}\ell_\chi(R+it)
 \quad\text{for almost every }t\in J.                \tag{14}
\]

The fundamental theorem for absolutely continuous functions yields the exact finite-width relation, for arbitrary endpoints in J:

\[
 I_R(t_2)-I_R(t_1)
  =\pi\int_{t_1}^{t_2}S_\chi(t)\,dt
      -\int_{t_1}^{t_2}\operatorname{Im}\ell_\chi(R+it)\,dt.
 \tag{15}
\]

Here is the explicit branch accounting at an ordinate gamma. In (9), each factor of order m with beta>a has argument changing from -pi to +pi at the left endpoint and contributes a jump +2*pi*m. A factor with beta=a changes from -pi/2 to +pi/2 and contributes +pi*m. A factor with beta<a contributes no jump there. The right-endpoint factor argument is continuous because R-beta>0. The analytic h has no jump. Thus

\[
 S_\chi(\gamma+)-S_\chi(\gamma-)
   =2\sum_{\substack{\rho:\operatorname{Im}\rho=\gamma\\\operatorname{Re}\rho>a}}
       m_\rho
      +\sum_{\substack{\rho:\operatorname{Im}\rho=\gamma\\\operatorname{Re}\rho=a}}
       m_\rho.                                      \tag{16}
\]

All these jumps occur in the derivative of the continuous function I_R; none is a jump of I_R itself. This explains why there is no extra zero-weight or endpoint term in (15). For primitive chi, the accepted completed-functional-equation reflection rho -> 1-conj(rho), preserving multiplicities within the same character, makes (16) equal the full multiplicity at that positive ordinate. That reflection is useful for the count interpretation, but it is not used to prove (14) or (15).

The average of the two one-sided S values exists at every exceptional ordinate. Setting S to that average agrees with the usual convention and preserves (15). Any finite assignment at the exceptional points gives the same integrals. Endpoint zeros therefore require no zero-free perturbation premise.

## 5. The right-edge limit and regularity of the full I

By (5), I_R(t) tends uniformly in t to I_chi(t), with error at most 3*2^(-R)/log2. By (4),

\[
 \left|\int_{t_1}^{t_2}\operatorname{Im}\ell_\chi(R+it)\,dt\right|
 \le3(t_2-t_1)2^{-R}\longrightarrow0.
\]

Let R tend to infinity in (15). This proves (2) with the stated positive sign and factor pi.

To obtain local Lipschitz regularity of I without an unjustified uniform-limit inference, first fix R=2 in (9). It bounds S on any compact J. Formula (2), already valid for every pair of endpoints in J, then gives

\[
 |I(v)-I(u)|\le\pi\sup_J|S|\,|v-u|.
\]

Thus I is locally Lipschitz and I'=pi*S almost everywhere. This also proves the integrability and endpoint adapter required by the family completeness plan. There is no dependence on parity or a Gamma branch in this proof.

## Source interfaces and remaining formal work

The actual source function is `DirichletCharacter.LFunction chi`, equivalently `chi.LFunction`. In the pinned Mathlib file `NumberTheory/LSeries/DirichletContinuation.lean`, `LFunction_eq_LSeries` at line 74 identifies it with the Dirichlet series for Re(s)>1, and `differentiable_LFunction` at line 97 gives entire differentiability for chi!=1. These are the carriers used here. The primitive nonprincipal implication, Euler-product identity, and construction of its holomorphic log series must be connected explicitly to these symbols. A completed L-function or a numerical evaluator cannot silently replace f in (1).

The remaining implementation work is finite and substantive:

1. Construct the Euler log (3), its exponential identity, and the uniform estimates (4)–(5) for the source L-function.
2. Factor the actual finite zero set in a bounded rectangle with analytic orders, remove those zeros, and construct a holomorphic logarithm on the simply connected rectangle. Prove the normalization (7), including its constant multiple of 2*pi*i.
3. Define horizontal continuation and prove (9). If using an existing argument-continuation abstraction, preserve the Euler initial value rather than resetting its integer branch.
4. Prove the log-potential lemma (10)–(12), the almost-everywhere derivative identity, and the absolutely continuous fundamental theorem application (15).
5. Supply the integrability and negligible-exceptional-set wrappers for the exact family-count consumer, then take the quantitative right-edge limit.

These are analytic proof tasks, not additional permitted hypotheses of the final Goldbach theorem. No analytic step in the paper derivation requires RH, finite spectral evidence, simplicity, or either parity separately. The horizontal upper and lower estimates can now be applied to the actual I values at any endpoints; their difference bounds the integrated S through (2). This note does not supply those numerical horizontal estimates or a full Turing constant by itself.
