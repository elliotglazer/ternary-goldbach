# Exact Riemann–Siegel integral and saddle substitution

2026-11-11. Paper derivation for the K0 blueprint, with explicit contour bounds and branch conventions. This is not a Lean result, zero-location assertion, or Riemann–Siegel error estimate. No build, numerical scan, dependency change, or frozen-file edit was made.

The proof uses the special Mordell kernel proved in `MORDELL_SPECIAL_CASES_PROOF_PLAN_2026-11-11.md`, SHA256 `7BA678E0C8D7A25B4598228066B44A0CFADF402606EEFE4F6EB52C1C9F6DB050`. It was pending audit when this task began. The independent paper review arrived before this note was frozen: `independent-feasibility/REVIEW_MORDELL_SPECIAL_CASES_2026-11-11.md`, SHA256 `4046A11E67FC3090D09ABA87270D3895355974B49163C397341EE1F0E2EE6A92`, verdict PASS. This is a reviewed paper dependency, not an implemented Lean theorem. The present continuation still needs its own independent review.

The primary source is Gabcke's corrected 2015 thesis, <https://d-nb.info/1072293277/34>, local PDF `agents/mellin/gabcke_1979_corrected_2015.pdf`, SHA256 `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`. Relevant printed pages are 66–68 for 4.1.6, 7–9 for the critical-line and finite-sum reduction, and 9–12 for the exact saddle substitution and endpoint convention. Pages 66, 67, and 11 were rendered and visually inspected across these two tasks.

## 1. Contours and the exact target

Let epsilon=exp(i*pi/4), eta=exp(3*i*pi/4), and D(u)=exp(i*pi*u)−exp(−i*pi*u)=2*i*sin(pi*u). All powers of u below use the principal Log on C minus the nonpositive real axis.

For 0<c<1 define four oriented lines, distinguished explicitly to avoid the ambiguity of arrow typography:

- L_c: u=c+epsilon*v, v increasing from −infinity to infinity, southwest to northeast.
- −L_c: the same line with reverse orientation, northeast to southwest.
- K_c: u=c+eta*v, v increasing, southeast to northwest.
- −K_c: the reverse line, northwest to southeast.

Define

\[
 A(s)=\int_{-L_c}\frac{e^{i\pi u^2}u^{-s}}{D(u)}\,du,
 \qquad
 B(s)=\int_{-K_c}\frac{e^{-i\pi u^2}u^{s-1}}{D(u)}\,du.             \tag{1}
\]

Neither line meets the branch cut or an integer pole. Their only real point is c>0. Their values are independent of c within (0,1), by the finite contour arguments below.

Put Gamma_R(s)=pi^(−s/2)*Gamma(s/2), where pi powers use the real logarithm. The target identity is

\[
 \boxed{\Gamma_R(s)\zeta(s)
       =\Gamma_R(s)A(s)+\Gamma_R(1-s)B(s).}                         \tag{2}
\]

This is Gabcke 4.1.6 with the orientations made explicit. It is a meromorphic identity. At a pole it means equality of meromorphic germs, not equality of arbitrarily assigned totalized values. In particular, using it on Re(s)=1/2 has no pole exception.

The first proof is restricted to **real 1<s<2**. Gabcke writes real s>1 while dividing by 1+exp(−i*pi*s); that factor vanishes at odd integers. Restricting the initial interval removes this unnecessary gap, and still suffices for analytic continuation to the required critical line.

## 2. Entire dependence on s and finite contour bounds

Here are bounds used repeatedly. On u=b+epsilon*v, with b in a fixed bounded positive interval,

    Re(i*pi*u^2)=−pi*v^2−sqrt(2)*pi*b*v.

On u=b+eta*v,

    Re(−i*pi*u^2)=−pi*v^2+sqrt(2)*pi*b*v.

For |v|>=1, |D(u)| is bounded below by exp(pi*|v|/sqrt(2))−exp(−pi*|v|/sqrt(2)), independently of b. On any fixed compact portion of a chosen line, D is bounded away from zero. If s ranges over a compact subset of C and the line stays a positive distance from 0, its principal powers satisfy a bound of the form

    |u^(−s)|+|u^(s−1)| <= C*(1+|v|)^M.

This follows from |Arg u|<pi and the positive lower bound for |u| on that line. Derivatives in s insert powers of Log(u), which are also dominated by a larger polynomial. Thus (1) converges absolutely and defines entire functions of s by dominated parameter differentiation.

Finite horizontal connectors between two such parallel lines have bounded length. At their endpoints v=+/-R, the preceding estimates give

    integral norm <= C*(1+R)^M*exp(−pi*R^2+C'*R).

They vanish as R tends to infinity, locally uniformly in s. A strip whose real intercepts stay between successive integers contains no pole, and its intersection with the real axis lies on the positive axis. It therefore avoids the logarithm cut. The finite Cauchy theorem and these connector bounds prove contour independence within any interval (N,N+1), N>=0. The same bounds justify shifts crossing finitely many positive integers, with their residues retained.

## 3. Start from the audited-candidate Mordell kernel

The parameter-1 result of the preceding note is the entire, removably interpreted identity

\[
 \int_{L_{1/2}}\frac{e^{i\pi u^2+2\pi izu}}{D(u)}\,du
 =\frac{e^{i\pi z}-e^{-i\pi z^2}}{D(z)}.                           \tag{3}
\]

Take real 1<s<2. Multiply by z^(s−1) and integrate on z=eta*y, y>0, oriented outward from 0. Call the two terms on the right I_plus and I_minus, so the integrated right side is I_plus−I_minus.

The double integral on the left is absolutely convergent, as follows explicitly. Put u=1/2+epsilon*v and z=eta*y. Since eta=i*epsilon,

    Re(2*pi*i*z*u)=−pi*y/sqrt(2).

The mixed v*y term is purely imaginary. Also

    |D(1/2+epsilon*v)| = 2*|cos(pi*epsilon*v)| >= 2.

For the last inequality, |cos(a+i*a)|^2=cos(a)^2+sinh(a)^2>=1; this follows from cosh(2a)+cos(2a)>=2, for example by its nonnegative power series in a^4. Thus the absolute parameterized integrand is at most

\[
 \frac12\,e^{-\pi v^2-\pi v/\sqrt2}
              y^{s-1}e^{-\pi y/\sqrt2}.                            \tag{4}
\]

It is a product of two integrable functions. The y integral already converges for s>0. This proves the actual Fubini interchange, rather than relying on pointwise conditional convergence. The separate right-hand terms require s>1 near z=0 and have exponential or Gaussian decay at infinity.

## 4. The Gamma-ray evaluation and its principal branch

For Re(lambda)>0 and real s>0,

\[
 \int_0^\infty e^{-\lambda y}y^{s-1}\,dy
 =\Gamma(s)e^{-s\Log\lambda}.                                    \tag{5}
\]

A proof of (5) needs no unbounded ray-rotation assertion. For positive real lambda it is the real Gamma integral and a positive change of variable. Both sides are holomorphic in lambda on the connected right half-plane: local derivatives of the integral are dominated by y^(s−1+k)*exp(−delta*y), delta>0. Analytic uniqueness proves (5) throughout that half-plane. This supplies the Gamma-ray step in Gabcke by an equivalent Laplace-transform proof.

For u=1/2+epsilon*v set lambda=2*pi*epsilon*u. Then

    Re(lambda)=pi/sqrt(2)>0,
    −3*pi/4 < Arg(u) < pi/4,
    Log(lambda)=log(2*pi)+Log(u)+i*pi/4.                            (6)

The argument bound is the geometry of a line crossing the positive real axis: multiplication by epsilon puts that entire line in the right half-plane. Thus (6) has no hidden multiple of 2*pi*i.

On the ray z=eta*y, the principal power is z^(s−1)=exp(3*pi*i*(s−1)/4)*y^(s−1), and dz=eta*dy. Combining (5) and (6) gives

\[
 \int_{0}^{\eta\infty} e^{2\pi izu}z^{s-1}\,dz
 =e^{3\pi is/4}\frac{\Gamma(s)}{(2\pi\epsilon u)^s}
 =e^{i\pi s/2}(2\pi)^{-s}\Gamma(s)u^{-s}.                         \tag{7}
\]

Define C(s)=exp(i*pi*s/2)*(2*pi)^(−s)*Gamma(s). Fubini and (7) evaluate the left side of integrated (3) as

\[
 C(s)\int_{L_{1/2}}\frac{e^{i\pi u^2}u^{-s}}{D(u)}\,du
 =-C(s)A(s).                                                       \tag{8}
\]

The minus sign comes from the orientation in (1).

## 5. Evaluation of I_plus and absolute summation

For Im(z)>0,

    exp(i*pi*z)/D(z) = −sum(n>=1, exp(2*pi*i*n*z)).

On z=eta*y, the integral of the sum of absolute values is

\[
 \int_0^\infty y^{s-1}\sum_{n\ge1}e^{-\sqrt2\pi n y}\,dy
 =\frac{\Gamma(s)}{(\sqrt2\pi)^s}\sum_{n\ge1}n^{-s}<\infty,         \tag{9}
\]

using Tonelli and the positive Gamma integral. This uses only the absolutely convergent defining zeta series for real s>1. Equation (7) with u=n then gives

\[
 I_{\rm plus}=-C(s)\zeta(s).                                      \tag{10}
\]

No zero-free statement or estimate on zeros occurs in this step.

## 6. Moving I_minus to the full descending line

Let

\[
 h_s(z)=\frac{e^{-i\pi z^2}z^{s-1}}{D(z)},\qquad
 J_c(s)=\int_{K_c}h_s(z)\,dz=-B(s).
\]

For real 1<s<2, deform K_c to the line through 0 with direction eta, retaining a small arc on the side of the positive real axis. This operation is justified as follows, rather than by treating 0 as an ordinary point.

- At infinity use the Gaussian connector bounds in section 2, uniformly for real intercepts between 0 and c.
- Near 0, D(z)/z tends to 2*pi*i and the exponential tends to 1. Hence |h_s(z)|<=C*|z|^(s−2) in the slit disk. A detour of radius rho has length at most 2*pi*rho, so its integral is O(rho^(s−1)) and tends to 0.
- The intervening strip meets the real axis only in [0,c]. After excluding the small disk, it contains neither a pole nor a point of the negative real branch cut. The finite Cauchy theorem therefore applies before either limit is taken.

One can take the infinity limit first for a fixed detour, then let rho tend to 0. The resulting line integral is the sum of two absolutely convergent ray integrals at the origin.

The positive eta ray is I_minus. On that ray Arg(z)=3*pi/4, so

    Log(−z)=Log(z)−i*pi.

Substitution on the other half-ray, including its inward orientation and D(−z)=−D(z), gives exp(−i*pi*s)*I_minus. Therefore

\[
 J_c(s)=(1+e^{-i\pi s})I_{\rm minus},\qquad
 I_{\rm minus}=-\frac{B(s)}{1+e^{-i\pi s}}.                        \tag{11}
\]

The denominator is nonzero on the chosen interval 1<s<2. The exp(−i*pi*s) is the joint result of the power branch, denominator oddness, and ray orientation; it cannot be inferred from parity alone.

## 7. Gamma algebra and analytic continuation

Equations (8), (10), and (11), with the right side I_plus−I_minus, give

\[
 C(s)\zeta(s)=C(s)A(s)+\frac{B(s)}{1+e^{-i\pi s}}.                 \tag{12}
\]

Set C0(s)=(2*pi)^(−s)*Gamma(s). Then

\[
 \frac{e^{-i\pi s/2}}{1+e^{-i\pi s}}
 =\frac1{2\cos(\pi s/2)}
 =\frac{\Gamma((1-s)/2)\Gamma((1+s)/2)}{2\pi},                    \tag{13}
\]

by the Gamma reflection formula. Duplication gives

\[
 C0(s)=\Gamma_R(s)\,
       \frac{\pi^{(1-s)/2}\Gamma((1+s)/2)}{2\pi}.                  \tag{14}
\]

Substitution of (13) and (14) in (12), and cancellation of the nonzero common Gamma factor, proves (2) for real 1<s<2. The Gamma factors used here have no pole on that interval.

There are two legitimate continuation scopes:

1. **The exact K0 consumer.** On the connected open set {0<Re(s)<2} minus {1}, A and B are entire, Gamma_R(s) is holomorphic, Gamma_R(1−s) is holomorphic, and zeta is holomorphic. The difference in (2) vanishes on the real interval (1,2), which has accumulation points inside this domain. Analytic uniqueness proves (2) there. This already includes every s=1/2+i*t, t real.
2. **Gabcke's global statement.** Use the meromorphic continuation of Gamma and zeta, or apply holomorphic uniqueness on C with the discrete possible-pole set removed. That set is {0,−2,−4,...} union {1,3,5,...}. Its complement is connected. The identity extends across excluded points as equality of meromorphic germs. This last statement does not assign values at their poles.

For a Lean implementation, the first continuation is enough and avoids unnecessary global meromorphic infrastructure. It does not weaken any t>=1500 consumer. No assumed zero location is used in either continuation.

## 8. Actual critical-line phase and conjugate integrals

Set s=1/2+i*t, and let theta(t) be the normalized analytic Gamma phase

    theta(t)=Im(logGamma(1/4+i*t/2))−(t/2)*log(pi),

where logGamma is real on the positive axis. Gamma has no zeros in that half-plane, so

    Gamma_R(s)=|Gamma_R(s)|*exp(i*theta(t)),
    Gamma_R(1−s)=conj(Gamma_R(s)).

This uses the actual normalized logarithm, not a fresh principal argument at each t. Constructing that logarithm and its normalization is an explicit separate prerequisite. No asymptotic phase estimate is needed for the identity here.

Conjugating A(s) gives B(s). To check the sign, conjugation sends the northeast-to-southwest line −L_c to a southeast-to-northwest line; conjugating D inserts a minus sign. Reversing the resulting line yields −K_c, exactly the orientation defining B. Also conj(Log(u))=Log(conj(u)) on these lines, and −conj(s)=s−1. Thus

\[
 B(s)=\overline{A(s)}.
\]

Equation (2) now gives

\[
 \boxed{Z(t):=e^{i\theta(t)}\zeta(1/2+it)
        =2\Re(e^{-i\theta(t)}B(1/2+it)).}                          \tag{15}
\]

In particular Z(t) is real. The adapter to Mathlib's actual HardyZ uses its completed-zeta definition and Gamma_R(s)/|Gamma_R(s)|=exp(i*theta), as already identified in the K0 blueprint. Equality of moduli alone is insufficient.

## 9. Finite shift across integers and the exact main sum

For N>=0, move the northwest-to-southeast contour −K_c rightward by N. For the finite polygon, original line forward followed by the translated line backward is **counterclockwise**. The poles crossed are exactly 1,...,N, with

\[
 \operatorname{Res}_{u=n}
 \frac{e^{-i\pi u^2}u^{s-1}}{D(u)}
 =\frac{(-1)^{n^2}n^{s-1}}{2\pi i(-1)^n}
 =\frac{n^{s-1}}{2\pi i}.                                        \tag{16}
\]

The principal powers at positive n are the ordinary exp((s−1)*log(n)). The strip avoids the logarithm cut. The connector bounds of section 2 justify taking the infinite-line limit, yielding

\[
 B(s)=\sum_{n=1}^N n^{s-1}
       +\int_{N-K_c}\frac{e^{-i\pi u^2}u^{s-1}}{D(u)}\,du.         \tag{17}
\]

Here N−K_c denotes translation of the oriented line, not scalar multiplication. Inserting s=1/2+i*t in (15) proves

\[
 Z(t)=2\sum_{n=1}^N\frac{\cos(\theta(t)-t\log n)}{\sqrt n}
       +\Re I_N(t),                                               \tag{18}
\]

where I_N is twice exp(−i*theta) times the residual integral. The empty sum covers N=0.

## 10. Saddle location and the integer endpoint indentation

Take t>0, a=sqrt(t/(2*pi)), and N=floor(a). If N<a<N+1, contour independence within that interval moves the residual line to the line through a with direction exp(−i*pi/4), oriented northwest to southeast. No approximation to the integrand has occurred.

If a=N is an integer, a>=1. The residual contour must still keep the pole at a on its **right**. Define a finite detour as follows. Write delta=exp(−i*pi/4). Follow the straight line to a−rho*delta, use the circle

    u=a+rho*exp(i*phi),  phi decreasing from 3*pi/4 to −pi/4,

and then follow the line from a+rho*delta onward. Choose 0<rho<min(a/2,1/2). This is the northeast semicircle. It crosses the real axis at a+rho, between N and N+1, and keeps the pole on the right of the oriented path. It stays off the logarithm cut and all poles.

For every such fixed rho, finite contour deformation from the original line with intercept N+c gives the same integral. Infinity connectors are controlled as before. If a shrinking-detour formulation is preferred, write the local integrand as r/(u−a)+h(u), h holomorphic. The symmetric straight portions of the singular term have a principal value, the h arc tends to zero, and the circular contribution tends to **−i*pi*r**, because its angle change is −pi. Hence the limit exists and equals

    principal value of the straight line integral − i*pi*Res_at_a.

The detoured integral, not the bare principal value, is the residual term in (18). Replacing one by the other changes a half-residue contribution and is invalid at floor transitions. This argument does not use continuity of the finite approximant across a floor change.

## 11. Exact saddle substitution and the logarithm cut

Put alpha=−1/2+i*t and xi=u−a. Since a>0 and u avoids the principal-log cut,

    Log(u)=log(a)+Log(1+xi/a).

Define

\[
 \widetilde g(a,\xi)=
 \exp[\alpha\Log(1+\xi/a)-2\pi ia\xi+i\pi\xi^2].
\]

Direct expansion gives the exact factorization

\[
 e^{-i\pi u^2}u^{-1/2+it}
 =a^{-1/2}e^{i(t\log a-t/2)}e^{-2\pi i\xi^2}\widetilde g(a,\xi).
                                                                    \tag{19}
\]

Set

\[
 \tau=(8t)^{-1/2},\quad q=\sqrt\pi[1-2(a-N)],\quad
 U=e^{i(t\log a-t/2-\pi/8-\theta(t))}.
\]

Then a=1/(4*sqrt(pi)*tau), −sqrt(pi)<q<=sqrt(pi), and

\[
 I_N(t)=(-1)^{N-1}a^{-1/2}U S,
\]

where, before changing variables,

\[
 S=(-1)^{N-1}e^{i\pi/8}
   \int\frac{e^{-2\pi i(u-a)^2}\widetilde g(a,u-a)}{i\sin(\pi u)}\,du.
                                                                    \tag{20}
\]

The convention for (−1)^(N−1) when N=0 is the integer exponent, equal to −1. Equivalently use −(−1)^N throughout to avoid a natural-number predecessor interpretation.

Make the substitution

    u=N+1/2+i*v/(2*sqrt(pi)),
    u−a=i*(v−i*q)/(2*sqrt(pi)).

The original u path becomes a northeast-to-southwest v path. Moreover

    sin(pi*u)=(−1)^N*cosh(sqrt(pi)*v/2),
    du=i*dv/(2*sqrt(pi)).

Thus (−1)^(N−1)*du/(i*sin(pi*u)) contributes **−dv/(2*sqrt(pi)*cosh(...))**. Reversing the v path to southwest-to-northeast removes this minus sign. Also

    −2*pi*i*(u−a)^2 = i*v^2/2+q*v−i*q^2/2.

With

\[
 g(\tau,w)=\exp\left[
  \left(-\tfrac12+\frac{i}{8\tau^2}\right)\Log(1+2i\tau w)
  +\frac{w}{4\tau}-\frac{iw^2}{4}\right],
\]

we obtain exactly

\[
 \boxed{S=\frac{e^{i\pi/8-iq^2/2}}{2\sqrt\pi}
  \int_{\nearrow\,iq}
  \frac{e^{iv^2/2+qv}}{\cosh(\sqrt\pi v/2)}g(\tau,v-iq)\,dv.}       \tag{21}
\]

The logarithm cut in the w plane is precisely {i*r:r>=1/(2*tau)}. Indeed, 1+2*i*tau*w lies on the nonpositive real axis exactly there. Away from the detour the contour w=v−i*q is the slope +1 line through 0, and it does not meet this cut. For the small detour, the conclusion follows also from the original u path avoiding the negative real axis and the exact identity u=a*(1+2*i*tau*w).

At integer a, q=sqrt(pi). The affine map rotates the u detour, and the subsequent orientation reversal changes its side convention: the pole v=i*sqrt(pi) is now on the **left** of the southwest-to-northeast v path. The detour is the southeast semicircle, crossing the imaginary axis below the pole. Its oriented angle change is +pi. This is exactly Gabcke's endpoint convention in 1.2.1; it is not an optional prescription.

Equations (18) and (21) give a paper proof of the exact saddle representation used by the K0 blueprint, using the reviewed Mordell proof and the ordinary analytic prerequisites identified here. The new argument is pending its own independent review. No asymptotic series, error bound, or steepest-descent approximation has been invoked.

## 12. Remaining proof obligations and implementation scope

At paper level the preceding derivation accounts for the Fubini bound, absolute series interchange, Gamma transform and its branch factor, the detour at zero, the meromorphic identity, critical-line conjugation, finite integer residues, and the floor endpoint indentation. It remains subject to independent review, including the upstream Mordell note.

The exact Lean tasks are finite and explicit:

1. Real-parameter definitions for the four oriented lines and their principal powers, plus the local Gaussian majorants and entire parameter dependence.
2. The Mordell kernel (3), after its independent audit and implementation.
3. The actual product majorant (4), and the Tonelli calculation (9), before interchanging integrals or the series.
4. Laplace formula (5) by holomorphic uniqueness in Re(lambda)>0; the geometric principal-log identity (6); and the ray Jacobian in (7).
5. Finite Cauchy deformation with the origin removed, including the O(rho^(s−1)) arc bound and the exact ray factor in (11).
6. Gamma reflection/duplication algebra on 1<s<2, followed by analytic uniqueness on {0<Re(s)<2} minus {1}. The global meromorphic extension is optional for the K0 consumer.
7. Normalized analytic log-Gamma, its actual Gamma_R phase identity, and the existing Mathlib HardyZ adapter. This is an identity prerequisite, not the later quantitative phase-remainder theorem.
8. Counterclockwise finite residue shifts, the integer endpoint detour, and the exact affine substitutions (19)–(21), with integer signs interpreted correctly.

Available source primitives are those already pinned in the K0 blueprint: Gamma integral/reflection/duplication/nonvanishing, Gaussian integrability, dominated parameter differentiation, analytic uniqueness, and finite Cauchy/residue integration. Affine contour wrappers, the displayed domination proofs, and small-detour limits must be implemented. Their existence in this paper argument is not evidence that those Lean declarations already exist.

The K0 error analysis remains a separate task: the variation-of-constants remainder deformation, its four-range estimates, low moments/derivatives, and the explicit O(1/t) Gamma-phase control are not proved in this note. No production sign chain or finite zero certificate follows merely from (2) or (21).
