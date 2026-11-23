# Independent review of finite-EM vertical DFT contracts

2026-11-11. **PASS at source/interface and paper-algebra scope. No correction required.** I read the frozen note and the relevant transform proofs and actual Mathlib definitions, and independently derived the sign, scale, finite moment identity and error bounds below. No FFT, coefficient, analytic function value, scalar script or Lean build was run.

The reviewed input is `integration/FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md`, SHA256 `170C8F976A8AF8B299E4AB737E6924260B3B1D8328FA54C0F2BF7F6E9720F997`. All paths in the following table are under `work/qrh-campaign/agents/`; each hash was checked from disk.

| Source contract | SHA256 | Independent review SHA256 |
| --- | --- | --- |
| `moebius/FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md` | `6E303D60C855E2CAD444EBC4EB3B1A3BD192D9BEAFAE0448F3F6D63CD9CDAC2E` | `B98A0735B223EBA01922044733750DC13A3C806B531AA1894D54589B68A88B0D` |
| `major-constants/AUXILIARY_FFT_ROUNDING_EXTENSION_2026-11-11.md` | `DA25013DFEAAACEFEAC5CF173A45B632C03BE42D1412A4EDD9D9A44E77CA4870` | `2D3A8B62D027353636C656318E587E73DF8860982A11E3EE105F532B03982118` |
| `integration/ARBITRARY_LENGTH_CHARACTER_DFT_2026-11-11.md` | `FFF8C45E75DA6EF89D13E657C0E7C05713F861FCF7FFE47E87497C7ED624F5F1` | `7DFADC932B61242CB39C8F840948ACCE8BED43A6F01D58860805A19B691BCA37` |

## Exact algebra and source convention

The actual [Mathlib ZMod source](C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/Analysis/Fourier/ZMod.lean:106), SHA `012663E2EB3A3F3196C6BCE04CB530D04E29C8DE8C65AFE703F2D707484EFE10`, has negative-exponent unnormalized dft at line106 and positive-exponent normalized invDFT at line114. The note's first line citation is two lines early; its quoted definition is correct. Its ambient binder requires nonzero length. The proposed L=2^d supplies that. These are identities for finite functions, not a library FFT correctness theorem.

For P_L(a)_j=(1/L) sum_k a_k exp(2*pi*i*k*j/L), evaluating at -j modulo L and multiplying by L gives exactly the unnormalized negative transform. Neither input conjugation nor an additional phase is needed. Bit reversal and normalized simultaneous butterflies belong to the separate reviewed implementation invariant; the sign cannot be inferred merely from a routine named FFT.

For each positive base n, let lambda=log n and Delta*lambda=2*pi*q/L+r/J. Then

`exp(-i*j*Delta*lambda)=exp(-2*pi*i*q*j/L)*exp(-i*(j/J)*r)`.

Replacing q by q modulo L in the first exponential is exact because j is an integer. It is not valid in the residual r. Multiplying the residual Taylor polynomial by n^(-s0)*(-lambda)^h/h! and summing over the finite disjoint bins yields precisely the note's

`L*sum_(m<p) (j/J)^m * P_L(A_(h,m,*))_((-j) mod L)`.

Both factorials occur once: h! normalizes the s-derivative, while m! is the residual-exponential coefficient. The bins partition the original finite summands, including empty bins. This paper identity is valid for all specified integer j, not a heuristic frequency approximation. It does not make the finite Dirichlet polynomial periodic. It is not a derivative theorem for the whole Euler–Maclaurin expression.

## Residual labels and error composition

The rational label rule avoids an undecidable nearest-half-integer comparison: q=floor(xhat+1/2) gives |xhat-q|<=1/2, and the certified |x-xhat|<=1/8 gives |x-q|<=5/8. Therefore |r|<=5*pi*J/(4L)<=5*pi/16<1 when L>=4J. The actual log and pi uncertainty must still be enclosed in both the label proof and coefficient construction. This works for negative or zero Delta too; no division by Delta occurs. J>=1 is essential to y=j/J. At n=1 the powers have their ordinary 0^0=1 convention.

Since 0<=j/J<1, the exponential Taylor remainder has norm at most exp(R)*R^p/p!. Multiplication by the derivative weights and summation gives C_sigma*Lambda^h/h! times this quantity. This uses finite C_sigma and Lambda bounding the actual logs; no infinite-series convergence hypothesis is being borrowed. The note correctly refuses the sharper factor2 without its separate ratio condition.

For input-center radii epsilon_k, the normalized transform error is at most (sum epsilon_k)/L. The final exact scale L cancels that denominator, giving sum epsilon_k, not L times that sum. Conversely a normalized arithmetic error alpha is multiplied by L. The outer weights y^m are nonnegative, so summing y^m times these bounds is valid. All correlations from shared logs, pi, labels and rounding are harmless under this deterministic triangle-inequality argument.

The bound B is explicitly for rational centers, not just true coefficients. B can be supplied by the actual coefficient bound plus the maximum input radius. The exact normalized stages have norm at most B. With twiddle and per-output rounding errors <=q, their recurrence is

`E_l <= (1+q/2)*E_(l-1) + q*B/2 + q`.

Expanding gives the displayed R_d. If q<=1/(d+1), then d*q/2<1/2 and the elementary binomial/geometric bound gives (1+q/2)^d<2. Hence R_d<=d*q*(B+2). The proposed further restriction q<=tau/[2*L*(d+1)*(B+2)] gives L*R_d<=tau/2. At d=0 there is no butterfly error. The moment adapter itself requires L>=4J and hence never needs d=0, but the generic recurrence handles it correctly. A dyadic q with these properties exists for every finite set of positive budgets. This is termination of finite precision selection, not a runtime bound.

The allocation tau_(h,m)=tau_h/(2p) is conservative: arithmetic is at most half each such allowance, and y^m<=1. It leaves room rather than automatically proving the other error budgets. Input coefficient errors, residual truncation and final polynomial rounding must still be checked separately. Exact rational final arithmetic can remove the last rounding term; an ordinary rounded Horner implementation cannot omit it.

## Applicability and remaining work

The accepted Bluestein option has unnormalized positive external output. Output reversal alone makes it negative. Its three normalized internal transforms require the separately derived L^2 convolution scale, not a new external m factor. This optional path is unnecessary for the proposed power-of-two batching; the two methods are alternatives, not cumulative requirements.

The contracts are applicable to a finite-EM batching plan, but do not yet establish that plan. It must supply the actual grid and positive bases; complete bin labels and residual enclosures; every moment coefficient with finite summation errors; the chosen p/h ranges and total allowance; a checked transform schedule; and the varying EM correction factors. In particular factors such as (s)_r or s-1 cannot be silently absorbed into coefficients advertised as independent of j. Final error division by s-1, if used, needs its own complete denominator enclosure. Values at the grid points alone provide no closed-panel coverage or nonvanishing.

No fixed Fourier-alias scale 2*pi*L/P, Gaussian bound, 36-stage limit, or 180-bit prescription is smuggled into this finite-Dirichlet application. A subsequent character transform has a different axis and must amplify the accumulated errors by its own operator norm. The note correctly leaves both joins explicit.

There is no new final premise, spectral certificate or claim of Lean validation. The finite moment identity and error analysis are sound paper reductions; implementation refinement, concrete finite acceptance, actual-function error composition and production feasibility remain separate gates.
