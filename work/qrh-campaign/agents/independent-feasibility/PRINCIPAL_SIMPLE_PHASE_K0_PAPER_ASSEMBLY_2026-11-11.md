# A simple-phase K0 approximation to the actual Mathlib Hardy Z

2026-11-11. This assembles the reviewed paper proofs listed below into one all-real-parameter result. It does not assert a Lean theorem, a checked interval evaluator, an approved declaration or dependency graph, a sign chain, or a finite zero certificate. No build, scan, special-function evaluation, or frozen-file change was made. The new result in this note is the composition, including the explicit adapter to Mathlib's actual definition.

## 1. Statement and conventions

For every **real** t>=1500, put

```
a = sqrt(t/(2*pi)),       N = floor(a) in the natural numbers,
z = 1 - 2*(a-N),          q = sqrt(pi)*z,
tau = 1/sqrt(8*t) = 1/(4*a*sqrt(pi)),
theta0 = (t/2)*log(t/(2*pi)) - t/2 - pi/8,
thetahat = theta0 + 1/(48*t),
sigmaN = -(-1)^N.
```

All square roots and fractional powers of positive reals mean their positive real values. Here N>=15, so sigmaN also equals the integer sign (-1)^(N-1); its definition above avoids a natural-predecessor convention. Since 0<=a-N<1, the exact parameter domains are **-1<z<=1** and **-sqrt(pi)<q<=sqrt(pi)**.

Let F be the continuous, indeed analytic removable extension on the real interval [-1,1] of

```
cos(pi*(z^2+3/4)/2) / cos(pi*z).
```

Its values at z=+/-1/2 are both 1/2. This is not totalized division at these points. The reviewed Gaussian/Mordell integral defines the extension independently of that quotient. Define the real approximant

```
Khat(t) = 2 * sum_(n=1..N) cos(thetahat-t*log n)/sqrt n
          + sigmaN * a^(-1/2) * F(z).
```

The assembled paper conclusion is

```
abs(Mathlib.hardyZ(t) - Khat(t)) < (451/1000)*t^(-3/4)
                                              for every real t>=1500.       (A)
```

The `Mathlib.` prefix here identifies the library function in prose; its actual source declaration is the global `hardyZ`, not a declaration named `Mathlib.hardyZ`. The proof below uses no finite-height restriction, no finite RH premise, and no sharp high-order theta expansion.

## 2. Pinned proof ledger

Paths in this ledger are relative to `work/qrh-campaign/agents/`. A producer and its independent review together specify the reconstructed paper proof being consumed; a review label alone is not an extra mathematical hypothesis.

| Component | Producer SHA256 | Independent review SHA256 |
|---|---|---|
| Normalized analytic Gamma logarithm: `moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md`, section 2 | `0A2F4766FCB77668C5461E8A63B97327EF2E6F595E66F805544A7EFA49A4A028` | `integration/REVIEW_PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md`: `A4401782284FFF48DFFBA27BB9DE2EFAF20E6BECB09A4F3737BDD220EA739547` |
| Coarse phase: `prime-estimates/COARSE_GAMMA_PHASE_FOR_GABCKE_2026-11-11.md` | `C7B701CF5B02D34142E30F38D1FFE573AE30167A561B9A759FD9964F41FC6E79` | `independent-feasibility/REVIEW_COARSE_GAMMA_PHASE_FOR_GABCKE_2026-11-11.md`: `DE019E48942C1999785FA8F14BC4CD65CAD7C4423038965FA0DEF96DD8BC75D0` |
| Special Mordell identities: `moebius/MORDELL_SPECIAL_CASES_PROOF_PLAN_2026-11-11.md` | `7BA678E0C8D7A25B4598228066B44A0CFADF402606EEFE4F6EB52C1C9F6DB050` | `independent-feasibility/REVIEW_MORDELL_SPECIAL_CASES_2026-11-11.md`: `4046A11E67FC3090D09ABA87270D3895355974B49163C397341EE1F0E2EE6A92` |
| Exact RS identity and saddle: `moebius/RIEMANN_SIEGEL_IDENTITY_PROOF_PLAN_2026-11-11.md` | `724FB84B60B9E3CFD178486BD52950A00709DC0D2CB7AA56C3E4193C426234E5` | `independent-feasibility/REVIEW_RIEMANN_SIEGEL_IDENTITY_2026-11-11.md`: `FA2C974BF1199A2C1888B9096BC20AB2F656AB25763A46A743894069B931F16A` |
| Fixed Gaussian moments: `mellin/K0_GAUSSIAN_MOMENT_PROOF_PLAN_2026-11-11.md` | `A3BD9C855E57DD70D828E093E83E760B2832AD4B8E6E00CED608629A087CE97A` | `integration/REVIEW_K0_GAUSSIAN_MOMENT_PROOF_PLAN_2026-11-11.md`: `89D6AA63BF0D1F0014976D4E18F2E502F8323F94B5CBEEC5749F7A0BAC77BEB7` |
| K1 remainder: `major-constants/K1_REMAINDER_PROOF_PLAN_2026-11-11.md` | `0008EECFA0408799E48B506A04F97BEF41EB55FE75D5A138CDF105F415CE107F` | Combined review below |
| Fixed-coefficient/indented-contour join: `major-constants/K0_COEFFICIENT_CONTOUR_JOIN_2026-11-11.md` | `B484CC05689773705AC91AE6D3938FE6D605AF850404106845A4E7CC0B8816D1` | `independent-feasibility/REVIEW_K1_REMAINDER_2026-11-11.md`: `3AAA75B9D0CEDDAA7FA64E7B5AFC27126FCCAE099B64F1443912B192956165D7` |

The primary Gabcke text underlying the reconstructed contour and coefficient arguments is the corrected thesis at <https://d-nb.info/1072293277/34>, retained as `mellin/gabcke_1979_corrected_2015.pdf`, SHA256 `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`. In particular, the special Mordell proof includes parameters 1, 1/2 **and 2**. The original K0 blueprint predates some of these proofs and uses a sharper theta input; that old theta input and its historical open-status statements are not premises here.

The pinned Mathlib revision is `56a005855ea17e0b0958f73ec801ae140b0a1679`, inspected at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`. The target repository revision recorded by the upstream notes is `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Relevant actual source declarations are:

* `Mathlib/NumberTheory/LSeries/HardyZ.lean`: `hardyZ` (line 76), `ofReal_hardyZ` (79), and the product manipulation in `abs_hardyZ` (85).
* `Mathlib/NumberTheory/LSeries/RiemannZeta.lean:154`: `riemannZeta_def_of_ne_zero`.
* `Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean:46`: `Complex.Gammaℝ`, with `Gammaℝ_def` and `Gammaℝ_ne_zero_of_re_pos`.
* `Mathlib/Analysis/SpecialFunctions/Gamma/BohrMollerup.lean:307`: **`Real.eq_Gamma_of_log_convex`**. This corrects the extra `BohrMollerup` namespace in the producer's prose; that auxiliary namespace has ended before this declaration.
* `Gamma/Basic.lean`: `Complex.Gamma_ofReal`; `Gamma/Deriv.lean`: analyticity on the right half-plane; `Gamma/Beta.lean`: Gamma reflection, duplication and nonvanishing. These are the source ingredients used by the reviewed normalized-Gamma and exact-RS proofs.

## 3. Construct the phase and prove the actual HardyZ adapter

For u>0 let

```
k(u) = (1/(exp u-1) - 1/u + 1/2)/u,
R(zeta) = integral_0^infinity exp(-zeta*u)*k(u) du,
H(zeta) = (zeta-1/2)*Log(zeta) - zeta + R(zeta),
L(zeta) = H(zeta)-H(1),                         Re(zeta)>0.
```

Here `zeta` is only a complex variable name, not the zeta function. The bounds 0<=k<=1/12 follow by clearing positive denominators. For the lower bound the numerator is `(u/2-1)*exp u+1+u/2`, with coefficients `(n-2)/(2*n!)` for n>=3 and lower coefficients zero. For the upper bound it is `(u^2/12-u/2+1)*(exp u-1)-u`, with coefficients `(n-3)*(n-4)/(12*n!)` for n>=5 and lower coefficients zero. Both series are nonnegative.

Uniform exponential domination on compact sub-half-planes makes R analytic, permits differentiation, and gives `|R(zeta)|<=1/(12*Re(zeta))`. On positive real x the reviewed construction computes

```
H''(x) = sum_(n>=0) 1/(x+n)^2 > 0,
H'(x+1)-H'(x) = 1/x.
```

The first series comes from a positive geometric series and Tonelli; integration on [x,x+1] telescopes to the second. Thus `H(x+1)-H(x)-log x` is constant, and tends to zero as x grows, since its main part is `(x+1/2)*log(1+1/x)-1` and its remainder difference tends to zero. The positive real function `exp(H(x)-H(1))` is log-convex, equals 1 at 1, and satisfies the Gamma recurrence. Bohr–Mollerup identifies it with Real.Gamma. Analytic uniqueness, with accumulation along the positive real interval inside the connected right half-plane, proves

```
exp(L(zeta)) = Complex.Gamma(zeta),     Re(zeta)>0.             (1)
```

L(1)=0 and L is real on positive reals. This constructs the branch; it is not an assumption of an unspecified logarithm of Gamma. In particular H(1) is real and cannot shift the phase. Principal `Log(Gamma(zeta))` is not being used.

Set s=1/2+i*t and w=s/2=1/4+i*t/2. Define

```
theta(t) = Im L(w) - (t/2)*log pi,
ell = L(w) - (s/2)*log pi.
```

Since pi>0, its principal complex logarithm equals the real log pi. The definition of Gammaℝ and (1) give

```
Gammaℝ(s) = exp(ell),
norm(Gammaℝ(s)) = exp(Re ell) > 0,
Gammaℝ(s)/norm(Gammaℝ(s)) = exp(i*theta(t)).                   (2)
```

These equalities follow by splitting the complex exponential into its positive real modulus and unit-modulus imaginary factor. There is no unknown sign or winding integer. Also s!=0 because Re(s)=1/2. The actual library identity `riemannZeta_def_of_ne_zero`, together with Gammaℝ(s)!=0 from (2), implies

```
completedRiemannZeta(s) = riemannZeta(s)*Gammaℝ(s).
```

Now apply the actual `ofReal_hardyZ` theorem, not merely `abs_hardyZ`:

```
(hardyZ(t) : Complex)
 = completedRiemannZeta(s)/norm(Gammaℝ(s))
 = exp(i*theta(t))*riemannZeta(s).                            (3)
```

Thus the normalized rotated zeta in the contour proof is the exact complex coercion of the real Mathlib function, including its sign. The source's realness theorem justifies `ofReal_hardyZ`; alternatively the exact RS identity proves the same realness. Equality of absolute values alone would not prove (3).

## 4. Coarse phase bounds, with no sharp theta theorem

The reviewed phase proof derives its remainder from this same R, rather than introducing a second Gamma normalization. Let P2(r)=r^2-r+1/6 and P3(r)=r^3-3*r^2/2+r/2, extended periodically from [0,1]. An explicit unit-cell Laplace integral and its geometric sum give

```
R(w) = 1/(12*w) - (1/2)*integral_0^infinity P2(fract x)/(w+x)^2 dx
     = 1/(12*w) - (1/3)*integral_0^infinity P3(fract x)/(w+x)^3 dx.
```

The first exchange is absolutely integrable for Re(w)>0. The second uses integration by parts on each integer cell; P3(0)=P3(1)=0 eliminates every cell boundary. With |P3|<=1/8 and y=Im(w)>0, splitting at x=y gives `integral |w+x|^-3 dx <=3/(2*y^2)`. Hence at w=1/4+i*t/2 the remainder after 1/(12*w) has norm <=1/(4*t^2).

Extracting the imaginary part of `(w-1/2)Log w-w+1/(12*w)` gives the first correction 1/(48*t). The errors in log(1+1/(4*t^2)), atan(1/(2*t)), and the reciprocal term total at most 23/(384*t^3). Therefore, for all t>=1500,

```
|theta-thetahat| <= 1/(4*t^2)+23/(384*t^3) < 13/(50*t^2),
|theta-theta0| < 1/(40*t) = tau^2/5.                         (4)
```

The second follows from `1/48+13/(50*t)<1/40`. These inequalities hold on the entire unbounded range. They do not use the fine Gabcke phase formula or the finite-range main-sum bound 80.

## 5. Exact RS identity, coefficients, and the endpoint join

The special Mordell proof reconstructs its identities by Gaussian integration and finite contour shifts; removable parameter values follow from the integral's holomorphy. The exact RS proof first works on the real interval 1<s<2, avoiding division by `1+exp(-i*pi*s)` at odd integers. Its ray/Fubini majorant and Gamma–Laplace branch calculation are explicit. On the rotated ray the logarithm identity is `Log(lambda)=log(2*pi)+Log(u)+i*pi/4`, and the origin arc is O(rho^(s-1)). Gamma reflection/duplication and analytic uniqueness then extend the identity to the critical line. Conjugation uses the same normalized Gamma factor as (2), giving `Z=2 Re(exp(-i*theta)*B)` with Z as in (3).

The finite counterclockwise residue shift crosses exactly the integers 1,...,N. Its residues give the main sum with coefficient 2. The residual I_N has already absorbed that factor 2. The affine saddle substitution, with its orientation reversal and sine denominator, gives exactly

```
hardyZ(t) = 2*sum_(n=1..N) cos(theta-t*log n)/sqrt n
            + sigmaN*a^(-1/2)*Re(U*S),
U = exp(i*(theta0-theta)),
S = c(q)*integral_source e^(i*v^2/2+q*v)
                  *g(tau,v-i*q)/cosh(sqrt(pi)*v/2) dv,
c(q) = exp(i*pi/8-i*q^2/2)/(2*sqrt(pi)),
g(tau,w) = exp[(-1/2+i/(8*tau^2))*Log(1+2*i*tau*w)
                +w/(4*tau)-i*w^2/4].                       (5)
```

There is no additional factor 2 outside Re(U*S). The source contour is `v=i*q+epsilon*u`, u increasing over the real line, epsilon=exp(i*pi/4). Its logarithm cut in w is `w=i*r, r>=1/(2*tau)`; the straight line avoids it. At q=sqrt(pi), the contour has the southeast semicircle with increasing angle from -3*pi/4 to pi/4, leaving the pole on its left. A radius below both sqrt(pi)/4 and 1/(4*tau) avoids the other singularities and the cut.

Define P0=1 and P1(w)=w^3/3-i*w. The fixed Gaussian coefficients B0,B1 use the same c(q) and kernel in (5), replace g by P0,P1, and integrate on v=epsilon*u. The reviewed moment proof gives, on the **closed** interval |q|<=sqrt(pi),

```
|B0(q)| <= 1,                    Re B0(q) = F(q/sqrt(pi)),
|B1(q)| < 8/5,
Re B1(q) = F'''(q/sqrt(pi))/(3*pi^(3/2)),
|F'''(z)| <= 4*pi for |z|<=1,
therefore |Re B1(q)| <= 4/(3*sqrt(pi)).                       (6)
```

The modulus estimate and real-part estimate are distinct. The first-correction identity follows by differentiating `exp(i*x^2/2)*Ftilde(q+x)`: b1=Ftilde', b3=Ftilde'''+3*i*Ftilde', so B1=b3/3-i*b1=Ftilde'''/3. Gaussian domination permits these derivatives on neighborhoods of the entire closed interval, including the removable F points. Hyperbolic norm identities give |B0|<=1 and |F'''|<=4*pi. Shifted moments b1,b3 each have bound 2/sqrt(pi), yielding |B1|<=8/(3*sqrt(pi))<8/5.

Crucially, the separate contour-join proof equates these **fixed** coefficients to the coefficients on the actual source contour before subtraction. In the interior a finite pole-free parallelogram and Gaussian connector decay prove equality. At q=sqrt(pi), the same argument uses a southeast notch excluding the pole; equality holds at each fixed sufficiently small radius. For B0 the normalized residue is `exp(-3*i*pi/8)/pi`: its arc tends to `exp(i*pi/8)`, while its symmetric straight principal value is zero. Thus B0(sqrt(pi))=exp(i*pi/8). Discarding this arc would invalidate (5)-(6) at every integer a. B1 has a removable quotient at that pole.

Only after subtracting the matched B0 and tau*B1 on this common contour may one use the residual's double zero. The K1 proof establishes

```
S = B0 + tau*B1 + E1,              |E1| < (21/5)*tau^2.       (7)
```

For completeness, its analytic mechanism is as follows. With P2(w)=w^6/18-5*i*w^4/6-3*w^2/2 and Rg=g-1-tau*P1, direct differentiation gives

```
(1+2*i*tau*w)*Rg' - tau*(w^2-i)*Rg = tau^2*P2',
Rg(0)=Rg'(0)=0.
```

Variation of constants is taken on radial segments avoiding the logarithm cut. The double zero makes the residual quotient O(w) at the endpoint pole, so its arc is O(rho^2) and now does disappear. On the straight contour the four ranges in u, split at -sqrt(t)/4, 0, sqrt(t), leave Gaussian decays with exponents 1/4, at least 17/36, 1/2, and 11/50. Polynomial factors are explicitly integrated. The two middle normalized bounds are below 1.82 and 2.31; each tail is below .001. The incomplete-Gamma tail inequality is applied with a>=1 and X>a; all these estimates hold for every t>=1500. Their sum is below 4.132<4.2, proving (7), not merely an asymptotic assertion. The pinned combined review checks both this proof and the necessary coefficient join.

## 6. True-phase K0 error and exact scalar arithmetic

Since t>=1500, tau<1/40. The unit-circle exponential inequality and (4) imply

```
|U-1| <= |theta0-theta| < tau^2/5.
```

Using |U|=1, (6), and (7),

```
U*S = B0 + tau*B1 + E2,
|E2| <= |E1| + |U-1|*(|B0|+tau*|B1|)
     < [21/5 + (1/5)*(1+(8/5)/40)]*tau^2
      = (551/125)*tau^2 < (441/100)*tau^2.                    (8)
```

Combining (5), (6) and (8), the error when retaining only F in the correction but leaving the true phase in the main sum is strictly below

```
a^(-1/2) * [4*tau/(3*sqrt(pi)) + (441/100)*tau^2]
= t^(-3/4) * [(2*pi)^(3/4)/(3*pi)
              + (441/100)*(2*pi)^(1/4)/(8*sqrt t)].           (9)
```

Here is a rational upper bound, so no special-function numerical call is part of this step. Let r=198/125. Using 157/50<pi<22/7, r^4>44/7, and sqrt(t)>38,

```
bracket in (9)
 < r^3/(3*(157/50)) + (441/100)*r/(8*38)
 = 3317717799/7457500000
 < 45/100.                                                   (10)
```

The elementary strict pi bounds can use the usual existing rational pi bounds; in particular no zero data or numerical Gamma evaluation is involved. The displayed fraction, r^4 comparison, (8), and the final fraction below were independently replayed with Python `fractions.Fraction` during this assembly, without creating a new script or modifying an existing receipt. This is an arithmetic cross-check of the displayed proof, not a kernel certificate.

## 7. Replace the true phase in the finite sum

For any real x,y, |cos x-cos y|<=|x-y|. The finite sum for N>=1 satisfies

```
sum_(n=1..N) n^(-1/2) <= 1+integral_1^N x^(-1/2) dx
                       = 2*sqrt(N)-1.
```

This uses monotonicity of x^(-1/2) on each unit interval; it remains valid at N=1. Since N<=a and 2*pi>1,

```
2*sum_(n=1..N) n^(-1/2) < 4*sqrt(N) <= 4*a^(1/2) < 4*t^(1/4).
```

Multiplication by the first inequality of (4) gives an error below `(26/25)*t^(-7/4)` when theta is replaced by thetahat. The F correction is unchanged. Consequently (9)-(10) imply

```
|hardyZ(t)-Khat(t)|
 < [45/100 + (26/25)/t] * t^(-3/4)
 <= [45/100 + (26/25)/1500] * t^(-3/4)
  = (16901/37500)*t^(-3/4)
  < (451/1000)*t^(-3/4).
```

This proves (A). The upper coefficient before the last rounding is 0.450693333..., valid on the whole unbounded range.

## 8. Closed endpoints and exact scope

At t=1500 all estimates are valid, and the strict inequalities have rational slack. When a is an integer, z=1 and q=sqrt(pi): the source indentation and its B0 arc were explicitly retained in section 5. No continuity of the piecewise finite approximant across a floor transition is assumed. The excluded value z=-1 is not produced by floor(a); the closed moment bounds nevertheless cover it. At z=+/-1/2, the analytic removable F, not division by zero, is used. All logarithms log n have n>=1 and all fractional real powers have positive bases.

I found no remaining mathematical join missing from this assembled paper chain after including the separate coefficient-contour supplement and proving (3). Ordinary prerequisites such as Cauchy deformation, analytic uniqueness, dominated integration and the Gamma identities have the explicit uses and domination arguments recorded in the pinned component proofs. They have not been replaced by a new hypothesis that already asserts a K0 error estimate or a finite spectral conclusion.

Formalization remains substantial: implement the normalized Gamma construction and phase bound; the special Mordell contours and removable values; the exact RS ray identity, residue shifts and saddle substitution; the Gaussian moments; the common indented-contour subtraction; and the four-range remainder estimates. Then implement (3), the scalar arithmetic, and this composition for an author-approved declaration. Existing source primitives do not mean these new adapters have been checked by Lean.

An interval evaluator additionally needs proved rational enclosures for every finite term and an explicit rounding allowance. A strict sign certificate requires its own retained-point checks and a count/completeness argument. Neither an evaluator, a sign chain, RH to any new height, nor the Goldbach theorem is concluded by (A). The accepted earlier experiments and their separate analytic dependencies are unaffected by this new note.
