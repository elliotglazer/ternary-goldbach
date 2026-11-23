# Review of finite-EM character and height composition

2026-11-11. **PASS as a paper derivation and source-interface plan, with no correction requested.** This is not an implemented evaluator, a formal proof, or a family feasibility result. No transforms, function values, scans or Lean builds were run.

The reviewed author note is `zero-sum/FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md`, SHA256 `17D6A2E7478E3C03D8B9406C01A5AD93D4277E33B09009B6550D02357DE54BEC`. I read it completely and checked its hash, the relevant predecessor notes, and the actual Mathlib definitions below.

## Actual function and removable term

The source definition is `ZMod.LFunction Phi s = c^(-s) * sum_a Phi(a)*hurwitzZeta(a/c,s)`. Source Dirichlet characters vanish on nonunits, so restricting to the manifest's unit representatives is exact. The positive-base convention matters: the source proof of `LFunction_eq_LSeries` explicitly uses multiplication of complex powers of nonnegative real numbers. The proposed integer-base conversion has that same justification, not an unrestricted complex-power product law.

Write X_a=cN+a and B_a=N+a/c=X_a/c. Direct calculation gives

`c^(-s)*(nu+a/c)^(-s)=(c*nu+a)^(-s)`,

`c^(-s)*B_a^(-s)/2=X_a^(-s)/2`,

`c^(-s)*B_a^(1-s-2m)=c^(2m-1)*X_a^(1-s-2m)`.

The endpoint term before subtraction is `X_a^(1-s)/(c*(s-1))`. These equalities verify every displayed conductor factor and confirm there is no remaining external c^(-s). Absorbing it before taking normalized derivatives also incorporates all log(c) convolution terms. Applying only a scalar c^(-s_j) to already computed unscaled jets would not.

For d_a=log X_a-log X_1, the proposed difference is

`P_a(s)=-(d_a/c)*X_1^(1-s)*exprel((1-s)*d_a)`.

Since `exprel(z)=sum_(k>=0) z^k/(k+1)!` is entire and has value1 at zero, this is entire, has value `-d_a/c` at1, and agrees with `[X_a^(1-s)-X_1^(1-s)]/[c*(s-1)]` off1. Its sign is correct. The equivalent finite-interval integral is

`P_a(s)=-(1/c)*integral_(log X_1)^(log X_a) exp((1-s)v) dv`.

Here a>=1, so d_a>=0; a=1 gives zero identically. Positive bases also give d_a<1/N. These facts justify the displayed modulus and normalized derivative bounds, including the finite interval's endpoint maximum and factor `(max log X)^h/h!`. They do not furnish an exprel evaluator or bound its arithmetic cost independently of height.

At s=1, Mathlib's individual totalized Hurwitz values must not be confused with ordinary meromorphic finite parts. The inspected source subtracts `1/(s-1)/GammaR(s)` and separately proves that differences of two Hurwitz functions are entire. The author correctly retains the nonprincipal cancellation: the same pole subtraction occurs in every unit coefficient, and `sum_a chi(a)=0` removes it. Primitive nonprincipal rows at c>1 satisfy this hypothesis; no principal-row identity at1 is claimed.

A direct formal route avoids identifying any individual finite part. Prove the full nonprincipal EM identity first in Re(s)>1. On the connected half-plane `Omega_M={Re(s)>1-2M}`, the actual nonprincipal L-function, the finite entire sum `sum chi(a)U_a`, and the sum of EM remainders are analytic. The identity principle extends equality on Omega_M, including1. Thus the proposed removable formula introduces no `(s-1)L` zero and no extra assumption about the source's value at1.

## EM remainder and whole-panel domain

The periodic-Bernoulli bound in the reviewed EM source proof gives, for alpha=a/c in (0,1), N,M>=1 and sigma+2M>1,

`|R_H(s)| <= 4*|(s)_(2M)|*B_a^(1-sigma-2M)/(6^(2M)*(sigma+2M-1))`.

Multiplication by c^(-sigma) gives exactly the author's factor `c^(2M-1)*X_a^(1-sigma-2M)`. The remainder has rising factorial length2M, whereas the last retained correction has length2M-1. There is no extra |s-1|. The denominator is positive only on the stated strict half-plane; equality at its boundary is not included.

For a unit character |chi(a)|=1, the triangle inequality gives the full error `sum_a R_a(s)`. The common-reference remainder can be canceled symbolically using the zero character sum; subtracting it separately in every numerical box would generally give a larger error. At1 the same estimate follows from the analytically extended identity and continuity of the majorant.

The underlying EM remainder proof needs absolute integrability and local analytic domination, not merely a formal integral. Its integrand is a bounded measurable periodic Bernoulli factor times `(t+alpha)^(-s-2M)`. The strict half-plane gives an integrable power majorant. A smaller local real-part bound and a spare positive exponent absorb log(t+alpha) when differentiating. These are the obligations in the reviewed source proof; they remain formal implementation work.

The author separates two valid panel routes. Actual-L coefficient errors may come from a Cauchy estimate on a disk inside Omega_M. Alternatively one may approximate the entire finite U sum, prove a new finite-function Taylor bound on an outer circle, and add the actual-point EM error only on the tested segment. The second route does not require the actual EM theorem on the whole outer circle, but it does require the new U-based outer bound. No principal zetaF growth constant or fixed degree transfers automatically.

## Tensor identity, labels, and errors

The bases n=c*nu+a with 0<=nu<N and unit representatives 1<=a<c are distinct positive integers below cN. With the accepted rational bin witnesses, the exact real residual obeys

`j*Delta*log n=2*pi*j*q_n/L+(j/J)*r_n`, with `|r_n|<1`.

Modulo L may be used in the first exponential only. The full signed q_n remains in r_n. This covers negative Delta, Delta=0 and n=1 without division by any of those quantities.

Expanding the residual exponential through p-1 terms and regrouping finite sums gives the tensor formula in the note. The source character kernel is positive in the unit-group coordinates, while the time exponential is negative. Therefore two normalized positive transforms require output `(chi,-j mod L)` and multiplication by vL. No input conjugation or inverse-character relabeling is needed on the character axis. A cyclic length-v transform is not a replacement for the CRT product group when that group is noncyclic.

For the true real phase theta=y_j*r_n, the integral Taylor remainder has norm at most `|theta|^p/p!`. Summing character-weighted terms gives W_h/p!, since y_j<1 and |r_n|<1. The weighted inequality follows from the exponential series:

`sum_(h<K) rho^h*(log n)^h/h! <= n^rho`.

For sigma>=111/200 and 0<=rho<=1/8, sigma-rho>=43/100>3/8. Extending to all integers up to cN and integrating the decreasing power gives the safe strict bound `(8/5)*(cN)^(5/8)`. The author does not import the principal numerical constant8192 or its quotient factor2.

The normalized tensor kernel has coefficient modulus1/(vL). Thus moment input error contributes `sum_(a,k) epsilon/(vL)` before final scaling, and `sum_(a,k) epsilon` afterward. Circuit error alpha, measured against the exact tensor transform of the rational centers, instead contributes vL*alpha. The residual-mode weights and final beta then give exactly the author's error formula. Correlations between repeated inputs require no independence assumption. A split two-stage implementation must bound the composed error, not simply add unscaled stage errors.

## Complete corrections and work counts

The tensor formula only covers the finite main sums. The author correctly retains the half endpoint, every Bernoulli term, the entire P_a, and all their normalized jets. The rising-factorial polynomial at a fixed height can be shared across residues, but X_a phases, coefficient weights and phase-step recurrences are residue dependent. Exact truncation modulo z^K preserves retained coefficients; the discarded Taylor part still needs its separate analytic bound.

I independently counted the displayed schedules. Time-first uses vKp time lines, vJK contractions of p modes, and JK character transforms after adding residue corrections. Character-first uses KpL character lines, n_prim*Kp retained time lines and n_prim*JK contractions; the corrections still cost JK character transforms unless a different proved scheme supplies them. All rows needed by a unit-group transform remain present even if only primitive output rows are retained.

The Nv initial phases and NvKp direct bin contributions have the correct residue factor. The correction envelope O(vJ(MK+K^2)) is conservative for rising factorial updates and exponential-polynomial convolutions, with exprel-jet certification and phase work explicitly additional. Dense tensor storage vKpL, or vpL moment storage under h-streaming, is a slot count, not a memory-byte or runtime estimate. No unproved machine-cost equality is used.

Finally, the compensating c powers in the remainder prevent treating X_a=cN+a as a free conductor improvement. The significant EM ratio is still controlled by |s|/(N+a/c), with the original 2*pi factor in the sharp formula. The author's warning against a free square-root-conductor cutoff is necessary and correct.

## Comparison with previous plans and source pins

The earlier unit-group plan proves finite character indexing and the source Hurwitz combination at a fixed s. The earlier vertical plan batches the principal finite EM main sum with zetaF's pole-removal corrections. Neither contains this scaled, entire U_a correction and its all-height character composition. The joint Gaussian plan has parity channels, primitive theta reciprocity, inverse labels on a reflected branch, root numbers and completion/tilt factors. None of those analytic identities or constants occurs here. This is a genuine finite-EM adapter built from shared finite-transform machinery, not a relabeling of the Gaussian evaluator.

Checked predecessor pins are `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866` for the unit-group plan, `814AD0B3012FDA4FD81B485139257409E81E6EAC8FA44FD6824A7D21F02C8818` for vertical batching, and `3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D` for the Gaussian joint plan. The inspected EM source review is `moebius/EM_SOURCE_PROOF_REVIEW_2026-11-11.md`, SHA `5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1`, reviewing the proof plan at `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485`.

The following actual files were read at Mathlib revision `56a005855ea17e0b0958f73ec801ae140b0a1679`:

| Source and relevant locations | SHA256 |
|---|---|
| `NumberTheory/LSeries/ZMod.lean:85,95,124,133`: definition, positive-base calculation, zero-sum entirety | `D756ABE5CB941F1210DC7DDDC90F68F120148BB6A45AC4E6C4282C3070FBC17D` |
| `NumberTheory/LSeries/HurwitzZeta.lean:89,97,104`: totalization correction and entire differences | `5AA1270696F59F95417054D77E156BAB2DCD42F6AFDF7318CF1A2944298818B3` |
| `NumberTheory/LSeries/DirichletContinuation.lean:60,74,97`: actual L definition, convergence range, nonprincipal entirety | `ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1` |
| `NumberTheory/MulChar/Basic.lean:609`: zero sum for a nonprincipal character | `1C31A9810F59DB8CDCDEEF50D20EFEAA0C70CF24B5C2448356AD1FF5EC240915` |
| `Analysis/Fourier/ZMod.lean:106,114`: unnormalized negative and normalized positive transforms | `012663E2EB3A3F3196C6BCE04CB530D04E29C8DE8C65AFE703F2D707484EFE10` |

Remaining obligations are the formal U/EM/source identity, proved exprel and correction enclosures, complete two-axis arithmetic traces, whole-panel bounds and actual family coverage. The paper derivation supplies none of those numerical packets or spectral margins. Its acceptance therefore changes no final theorem assumptions and establishes no family nonvanishing result.
