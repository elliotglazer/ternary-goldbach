# Principal zero count: a finite source and proof ledger

2026-11-11. Bounded source research and paper derivation only. No Lean build, implementation, approved anchor, new assumption, numeric regeneration or frozen edit. This note specifies ordinary missing proof tasks; none may become a permanent premise of the final theorem.

The normalization `N(T)=1+theta(T)/pi+S(T)` and the Binet allowance used by the accepted packets are mathematically consistent. The main missing formal blocks are a normalized Gamma logarithm with its phase bound, an exact quarter-contour argument calculation, and analytic-order/carrier transport. Existing source facts make these finite tasks. Two useful simplifications are detailed below: real-axis nonvanishing from the existing sawtooth formula, and a normalized Binet construction that avoids evaluating the real Stirling constant.

## Inputs and source scope

Target source: `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Mathlib revision: `56a005855ea17e0b0958f73ec801ae140b0a1679`, inspected at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`.

Read dependencies, relative to `work/qrh-campaign/agents/`:

| Artifact | SHA256 |
|---|---|
| `mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md` | `4648E4C454F4344D4F110E878F6CF619F5AC2128CAC91C2658E443FA3D1DF303` |
| `mellin/PRINCIPAL_COMPLETENESS_ROUTE_2026-11-11.md` | `AC1FA5C0308D24C9CB19FEBF6A2C231B42C6E25113E534D4C23FE62E4CE2D92C` |
| `audit/PRINCIPAL_COMPLETENESS_ROUTE_REVIEW_2026-11-11.md` | `FB268AD7ACE08954435194D51BF6FC3C358AE7838E8CCFAE7087B0E0F84EAA11` |
| `independent-feasibility/REVIEW_EM_TOP_HORIZONTAL_2026-11-11.md` | `6E2E1C0F3283F62CF68FCCC8E90AB67F5626288353E7B9A6921BCE695425CA4E` |
| `major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md` | `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B` |
| `independent-feasibility/REVIEW_POLYGON_CROSSING_PROOF_2026-11-11.md` | `F75647007C294E13132B984A0F6241B516D5113D789AECA922B4DA265A5E73F0` |

The older completeness design predates the accepted EM top experiment. Its statement that no top certificate exists is historical, not current status. This note does not rerun or newly certify N(1000000), head counts, or sign files. Their arithmetic remains separate from the analytic bridge considered here.

## 1. Exact analytic objects and zero carrier

Use the source functions, not alternate entire completions:

- `Explicit/ZetaGrowth.lean:17,19,22,30`: zetaF is `(s-1)zeta(s)` updated to 1 at s=1, with its off-pole identity and entire differentiability.
- `Explicit/Xi.lean:19,21,24,28`: xiF is `s(s-1)completedRiemannZeta₀(s)+1`, entire, reflection invariant, and equals `s Gammaℝ(s) zetaF(s)` for Re(s)>0 and s!=1. It omits the conventional factor 1/2.
- `Xi.lean:37,40,43,51,56`: values at 1 and 0 are both 1; xiF has no zeros in Re(s)>=1 or Re(s)<=0; its zeros in the open critical strip are precisely zeta zeros.
- `Explicit/XiPartial.lean:669`: xiF conjugation. The source proof uses the completed-zeta conjugation theorem; it introduces no finite RH premise.

Define the intended count in mathematical prose as the sum of **actual analytic multiplicities** of xiF zeros with `0<Im rho<=T`. The source strip theorem already forces `0<Re rho<1`. Because xiF(2)!=0, no analytic order is infinite. Compactness and isolated zeros give a finite carrier at bounded T. On this carrier the multiplicities equal those of zetaF and zeta: their local quotients are analytic and nonzero.

Do not identify this count with an arbitrary finite set of apparent numerical roots. The source `Explicit/Landau.lean:25,31` defines `divB` and `zerosIn` through the meromorphic divisor, while `Explicit/Datum.lean:92,97` defines `zerosRectD` and `multRectD` on an **open** rectangle. The needed adapter is: whenever a chosen ball contains the closed counting rectangle and its boundary is zero-free, its filtered divisor support is exactly the actual zero carrier; `(divB ... rho).toNat` equals the finite positive analytic order. This is independent of the auxiliary center/radius.

Pinned Mathlib ingredients are `Analysis/Analytic/Order.lean:107,118,190,524,588` (local factorization, finite order, germ congruence, product order, composition with nonzero derivative), `Analysis/Meromorphic/Divisor.lean:79,99` (analytic-point divisor and finite compact support), and the non-top order identity theorem already used by `Landau.factor_ball:40`. The reviewed polygon/rectangle bridge supplies the argument-principle carrier skeleton. A conjugation-order wrapper was not found in the scoped search: prove it by conjugating the local factorization, using that `z -> conjugate(g(conjugate z))` is analytic. Holomorphic reflection `s ->1-s` uses the nonzero-derivative composition API.

### Real-axis nonvanishing without a new eta argument

For real 0<x<1, `ZetaGrowth.zetaF_eq:156` states

    zetaF(x)=x+x(x-1) Izeta(x).

Its sawtooth integrand is real and nonpositive on t>=1, and is integrable by `integrableOn_saw_integrand:64`. Thus `Re zetaF(x)>=x>0`. This is exactly the argument already specialized to x=1/2 in `Xi.re_zetaF_half_ge:78`, with x left variable. It proves xiF(x)!=0 through its nonzero Gamma factor. Outside (0,1), use the existing xiF strip exclusions and xiF(0)=xiF(1)=1. Hence **xiF has no real zeros**. No finite positive-height certificate is used to establish the contour's real-axis normalization.

For head rectangles using zetaF on [-.1,1.1], supplement this with `ZetaDatum.zetaF_ne_zero_strip:190`, right-half-plane nonvanishing, and zetaF(0)=1/2 from `Mathlib/NumberTheory/LSeries/RiemannZeta.lean:151`, `riemannZeta_zero`. This excludes spurious real-axis points and shows no trivial zero enters that head rectangle. For the large symmetric contour below, use xiF throughout, so all poles/trivial zeros are already removed correctly.

## 2. Normalized Gamma phase without determining the real Binet constant

The standard Laplace Binet formula is documented in [DLMF 5.9.10_2](https://dlmf.nist.gov/5.9.E10_2). No such theorem was found in the scoped pinned Gamma/Stirling sources. The inspected Stirling file treats real factorial asymptotics; it is not a complex Binet theorem. The following direct construction targets exactly the phase needed here and avoids a proof of the constant `(1/2)log(2pi)`.

For u>0 put

    k(u)=[1/(exp u-1)-1/u+1/2]/u.

Prove `0<=k(u)<=1/12` by the two cleared-denominator exponential-series identities already reviewed in the analytic-count note. Their eventual coefficients are `(n-2)/n!` and `(n-3)(n-4)/n!`; low-degree cancellations must be proved, not sampled. Define for Re z>0

    R(z)=integral_0^infinity exp(-zu) k(u) du,
    H(z)=(z-1/2)Log z-z+R(z),
    L(z)=H(z)-H(1).

Here Log z is the principal logarithm on the right half-plane, not principal Log of Gamma(z). Uniform exponential majorants on compact sub-half-planes prove R analytic and permit two differentiations; they also give `|R(z)|<=1/(12 Re z)`. The integral and H are real on positive reals, so H(1) is real and L(1)=0.

For x>0, compute

    H''(x)=1/x+1/(2x^2)+integral exp(-xu) u^2 k(u) du
          =1/x^2+integral exp(-xu) u/(exp u-1) du
          =sum_(n>=0) 1/(x+n)^2 >0.

The last step uses the positive geometric series and Tonelli (or monotone convergence), followed by the elementary exponential moment integral. It supplies log-convexity of `f(x)=exp(H(x)-H(1))`.

Integrate this series on [x,x+1]. Positive terms telescope to

    H'(x+1)-H'(x)=1/x.

Thus `D(x)=H(x+1)-H(x)-log x` is constant. It tends to zero as x tends to infinity: the remainder difference tends to zero from `|R(x)|<=1/(12x)`, and the elementary main difference is `(x+1/2)log(1+1/x)-1`, which tends to zero. Therefore D=0. Consequently f is positive, f(1)=1 and f(x+1)=x f(x).

The pinned `Real.BohrMollerup.eq_Gamma_of_log_convex`, `Analysis/SpecialFunctions/Gamma/BohrMollerup.lean:307`, now proves f=Real.Gamma on x>0. Its hypotheses are precisely log-convexity, positivity, the recurrence and value at 1. `Complex.Gamma_ofReal` (`Gamma/Basic.lean:419`) and analytic uniqueness extend `exp(L(z))=Complex.Gamma(z)` to Re z>0. Use `AnalyticOnNhd.eqOn_of_preconnected_of_frequently_eq` from `Analysis/Analytic/IsolatedZeros.lean:238`: equality on the real interval gives accumulation at 1, not equality on an open complex neighborhood. Gamma is analytic there by `Gamma/Deriv.lean:65,77`; its nonvanishing is also available at `Gamma/Beta.lean:454`.

This constructs a single-valued analytic logarithm with L(1)=0 and real values on the positive real axis. It fixes the branch completely. The omitted real additive constant has zero imaginary part, so the phase is exactly the same one as in normalized Binet. No Stirling constant evaluation, choice of winding integer, or numerical Gamma log is needed. This is a new paper route awaiting independent review/Lean implementation, not an already available theorem.

The existing generic `Complex.exists_continuousOn_eqOn_exp_comp` in `Analysis/Complex/BranchLogRoot.lean:36` is an alternative branch-existence tool. It yields continuity, not immediately the needed quantitative phase bound. The explicit H construction above supplies both normalization and bound in one chain.

### The precise allowance consumed

Set `theta(t)=Im L(1/4+it/2)-(t/2)log pi`. For t>0, elementary real logarithm/argument identities give

    theta(t)=theta0(t)+(t/4)log(1+1/(4t^2))
              +(1/4)atan(1/(2t))+Im R(1/4+it/2),
    theta0(t)=(t/2)log(t/(2pi))-t/2-pi/8.

H(1) contributes no imaginary part. The two explicit corrections lie between zero and `3/(16t)`. The integral contributes at most 1/3 in absolute value. Hence `|theta-theta0|<=1/3+3/(16t)`. This gives the packet's `<1/8` allowance after division by pi at t>=1500, using only pi>3; it also gives `<.347` at t>=14 for the Hardy proxy. Preserve the original packet thresholds even though the estimates allow some strengthening.

To obtain Hardy realness, use xiF(1-s)=xiF(s) and conjugation at s=1/2+it. Its factorization becomes

    xiF(s)=-(t^2+1/4) pi^(-1/4) |Gamma(1/4+it/2)|
                  exp(i theta(t)) zeta(s).

The real factor is strictly negative, proving the rotated zeta value is real. This requires exp L=Gamma, not a small computed imaginary part. The sign proxy with theta0 follows from the positive cosine bound as in the accepted completeness review.

## 3. Exact +1 and factor-of-two normalization

Fix T>0 and assume, as a local theorem hypothesis to be discharged by its top certificate, that zeta is nonzero on `[1/2,2]+iT`. This is a certificate interface, not a proposed final root assumption. Reflection and conjugation then exclude all nontrivial zeros at both ordinates +/-T. XiF is zero-free on the vertical boundaries Re=-1 and Re=2 by its existing strip exclusions.

Let P be the piecewise straight path `2 ->2+iT ->1/2+iT`. Initialize the zeta argument at 2 to zero. The series bound `Re zeta(2+iu)>1/4` for all real u keeps the vertical segment in the right half-plane. It follows by the absolutely convergent Dirichlet series, separating n=2 and bounding the n>=3 tail by the integral from 2 to infinity. This fixes the initial branch without sampling the vertical segment.

Define pi*S(T) as the total continuous zeta-argument change along P. A finite half-plane top cover computes it by summing local logarithm endpoint differences; this is the reviewed polygon connector/FTC argument without a closed polygon. In the accepted EM top packet every image stays in Re>0, so the increments telescope and S(T) is the principal argument at the final zeta value divided by pi. Endpoint positivity alone would not justify that shortcut.

XiF(2) is positive: its factorization gives `2 zeta(2)/pi`. Along P, continue the logs of s and s-1 from their positive initial values; neither path meets their negative-real-axis cuts. At the final point s=1/2+iT,

    arg s+arg(s-1)=pi.

The Gamma/pi-power factor contributes theta(T), starting with zero phase at s=2. The zeta factor contributes pi*S(T). Thus the continuous xi argument variation on P is exactly

    A(T)=pi+theta(T)+pi*S(T).

This explains the +1 after division by pi. It is not calibrated from N(14), N(1500), or any historical zero count.

For the full contour, let J(s)=1-conjugate(s). XiF(J(s))=conjugate(xiF(s)). Follow P, then the reverse of J(P); this is the upper rectangle boundary from 2 to -1. Its xi argument change is 2A. Follow the reversed conjugate of that upper path to return from -1 to 2 along the lower boundary; its change is again 2A. The total counterclockwise change on `[-1,2] × [-T,T]` is therefore 4A.

The rectangle argument principle counts all its xi zeros with analytic multiplicity. There are no real zeros, all lie strictly between Re=0 and Re=1, and conjugation preserves multiplicity. Its total is exactly 2N(T). Therefore

    4A=2pi*(2N(T)),
    N(T)=1+theta(T)/pi+S(T).

All signs are fixed by the explicit counterclockwise traversal. No poles of zeta or Gamma are counted separately: the contour function is entire xiF, with xiF(0)=xiF(1)=1. Trivial zeros are absent by the xi strip exclusions. The polynomial factor in A accounts for the normalization that is sometimes described as the pole contribution.

The existing `Explicit/RectResidue.lean:391`, `rectInt_logDeriv_mul`, applies with h=1 and a large auxiliary ball; the reviewed polygon/rectangle ledger explains how to discharge its center and strict ball-inclusion requirements. Translate continuous argument increments to imaginary logarithmic-derivative integrals using local logs and FTC (`Complex/LogDeriv.lean:87`, `HasDerivAt.clog_real`; interval FTC at `FundThmCalculus.lean:1148`). A new symmetry/subdivision lemma must identify the four path integrals with the source's exact `rectInt` orientation. Do not replace that finite equality by a diagram alone.

## 4. Closed-height and finite-packet interfaces

At a certified zero-free ordinate T the open-rectangle residue count equals the closed count `0<Im<=T`, because the boundary contains no zeros. This applies to the accepted head/top endpoints after their enclosure checkers and source bridges are proved. The count formula itself is only asserted in this form at such heights; no half-weight convention is silently introduced.

For an arbitrary t>0, bounded-strip local finiteness gives epsilon>0 with no zero ordinate in `(t,t+epsilon)`. Thus the **closed** count N(u)=N(t) for t<u<t+epsilon, including all multiplicity at t. This right-local constancy extends both sides of continuous analytic count inequalities to t. Merely using N(t)<=N(u) would only extend upper bounds. The exact equation involving S(t) need not be assigned an artificial value at a zero ordinate.

The accepted head packet can use zetaF rather than xiF, but must prove equality of the two finite carriers and multiplicities in the critical strip. The source's `.toNat` divisor representation is safe only after finite analytic order and divisor nonnegativity are established. The sign-completeness packet then needs the ordinary finite-sum lemma: M disjoint brackets yield M distinct zeros of positive order, and equality with total multiplicity M forces no extra zero and every order equal to 1. Simplicity is a conclusion, never a premise.

## 5. Finite implementation ledger

These are proposed mathematical lemma tasks, not frozen Lean declarations or approved anchors.

| Order | Exact required conclusion | Main existing source / remaining work |
|---|---|---|
| 1 | Xi real-axis nonvanishing and xiF(2)>0 | Generalize `Xi.re_zetaF_half_ge` via `ZetaGrowth.zetaF_eq`; use Gamma positivity and existing strip exclusions. |
| 2 | Binet kernel measurable, between 0 and 1/12 | Exponential-series algebra with all coefficient signs; no finite sampling. |
| 3 | R analytic on Re>0, norm bound, first two real derivatives | `ParametricIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le`; uniform exponential majorants and moment integrals. |
| 4 | H'' positive series, H recurrence, exp(H-H1)=Gamma | Tonelli/FTC/telescoping, elementary limit, `convexOn_of_deriv2_nonneg` (`Analysis/Convex/Deriv.lean:215`), Bohr–Mollerup and accumulating-real-point identity theorem. |
| 5 | Normalized theta, phase allowance and Hardy realness | Algebra of principal Log on right half-plane, atan/log bounds, source xi identities. |
| 6 | Analytic orders finite, product/germ equality, reflection/conjugation invariance | `Order.lean`, source xiF(2)!=0, local factorizations; conjugation wrapper is new. |
| 7 | Divisor support equals actual bounded zero carrier, with equal multiplicities | `Landau.divB`, `zerosIn`, analytic divisor application and finite compact support; no guessed zero list. |
| 8 | Canonical P-argument initialized at zero and computed by panel endpoint logs | Dirichlet-series right-half-plane bound, local log FTC and finite additivity; consume actual endpoint balls. |
| 9 | Xi argument on P equals pi+theta+pi*S | Source factorization; normalized Gamma log; explicit endpoint polynomial argument sum. |
| 10 | Symmetric rectangle integral equals four times P's xi argument | Reflection/conjugation with orientation, source rectInt definition, subdivision/FTC. |
| 11 | Exact count equation at zero-free heights | `rectInt_logDeriv_mul`, tasks 1 and 6–10, finite conjugate pairing. |
| 12 | Closed-height right-local constancy and packet adapters | Finite zero support and no horizontal-boundary zeros; transport head/top/sign carriers. |

The reused rectangle/polygon paper proofs do not yet provide Lean terms. The interval arithmetic/enclosure proofs for accepted packets remain a separate prerequisite to discharging their local nonvanishing and strict-sign interfaces. The new Gamma construction above is a concrete way to prove the analytic obligation, not a claim that Binet or the count equation is already formalized. This bounded ledger ends here; no further numerical certificate is needed to refine these source tasks.
