# Shared finite EM jets on a regular vertical grid

2026-11-11. Paper derivation and proposed finite checker contract. No logarithm table, phase, moment array, FFT, model, special-function value or contour was evaluated. No build or source change was made. The construction batches the **same finite Euler–Maclaurin expression** used by the high-endpoint slab. It does not assume nonvanishing or relative accuracy.

## 1. Exact problem and parameters

Fix integers N,M,K,J>=1, B=N+1, rational real sigma,t0,Delta, and

`s_j=s0+i*j*Delta`, `s0=sigma+i*t0`, `0<=j<J`.

Signed Delta is allowed, including downward grids and Delta=0. The finite expression is

`D(s)=sum_(n=1..N) exp(-s*log n)`,

`R(s)=1/2 + sum_(k=1..M) [B_(2k)/(2k)!] B^(1-2k) (s)_(2k-1)`,

`g(s)=(s-1)D(s)+exp(-s*log B)*((s-1)R(s)+B)`.

This is exactly the entire pole-cancelled finite g in the accepted top and high-slab evaluators. The main sum includes every n from 1 through N; the last Bernoulli rising factorial has length 2M-1. The separate actual zetaF remainder uses length 2M. K means retained normalized derivatives of orders 0 through K-1.

The accepted source/formula pins are `zero-sum/EM_TOP_HORIZONTAL_2026-11-11.md` (`C8062D1BB197EF9A2FD8450BEAAF7E093B1448865751D0DB30623394C76F13BF`), its producer (`F0F7B331D8C3515C88845DB08A735AF9A071CC9A3D3025A46919C400FEE03D10`), and `moebius/PRINCIPAL_HIGH_ENDPOINT_SLAB_DESIGN_2026-11-11.md` (`5163C4208A5FC6F670FF0EDBC149A43C38FA5246F1D6CA567C75E055DD7EA2C8`). This note does not import the eager old producer.

Choose L=2^d to be the smallest power of two at least 4J, so `4J<=L<8J`. Only the first J output labels are consumed. Let p>=1 be the residual exponential Taylor length, distinct from M and K.

## 2. Bins that terminate even at exact boundaries

For each n put `ell_n=log n` and `x_n=L*Delta*ell_n/(2*pi)`. Construct a rational enclosure [l_n,u_n] for this actual real number with width at most 1/4. Let `xhat_n=(l_n+u_n)/2` and set the exact integer

`q_n=floor(xhat_n+1/2)`, `k_n=q_n mod L` in {0,...,L-1}.

Then `|x_n-xhat_n|<=1/8`, `|xhat_n-q_n|<=1/2`, and therefore `|x_n-q_n|<=5/8`. Define the **actual**, not rounded, residuals

`delta_n=Delta*ell_n-2*pi*q_n/L`, `r_n=J*delta_n`.

Consequently

`|r_n|<=5*pi*J/(4L)<=5*pi/16<1`.

The last inequality follows from pi<22/7. Let Rstar=5*pi*J/(4L), or use the rational upper bound 55/56. Keep the full integer q_n in delta_n: replacing it by its residue k_n would lose this estimate.

This rule never decides whether the exact x_n lies on a nearest-bin boundary. Only a rational floor is decided, and either permitted label works. Width refinement of certified log/pi enclosures terminates for each finite input because pi is nonzero and these arithmetic operations are continuous. The same uncertainty must be retained when enclosing r_n and the coefficients below. A label accompanied only by an unverified floating midpoint is insufficient. For n=1 or Delta=0 no division by log n or Delta occurs; ordinary zero-power conventions apply.

## 3. Exact finite transform identity and residual error

The normalized h-th derivative of D at s_j is

`S_h(j)=sum_n n^(-s0)*(-ell_n)^h/h! * exp(-i*j*Delta*ell_n)`.

Set `y_j=j/J`, and for 0<=h<K, 0<=m<p define

`A_(h,m,k)=sum_(n:k_n=k) n^(-s0)*(-ell_n)^h/h! * (-i*r_n)^m/m!`.

Every original summand belongs to exactly one bin; empty bins are zero. The factorials h! and m! have distinct roles and each appears once. Since q_n-k_n is a multiple of L,

`exp(-i*j*Delta*ell_n)=exp(-2*pi*i*j*k_n/L)*exp(-i*y_j*r_n)`.

Expand only the last factor through degree p-1 and interchange finite sums. With the normalized positive transform

`P_L(A)_v=(1/L)*sum_(k=0..L-1) A_k*exp(2*pi*i*k*v/L)`,

the resulting approximation is exactly

`T_h(j)=L*sum_(m=0..p-1) y_j^m * P_L(A_(h,m,*))_((-j) mod L)`.

Thus the output sign is negative, implemented by reversing the index of the positive inverse DFT. The final factor is **L**, not 1, omega, or a Gaussian sampling scale. The actual j/J is retained in the outer polynomial; it is not replaced by a residue representative. There is no Poisson/time alias estimate here: the DFT reindexes a finite sum exactly, and the only analytic approximation in this identity is the residual exponential polynomial.

For real theta, repeated real FTC gives the integral Taylor remainder

`exp(-i*theta)-sum_(m<p)(-i*theta)^m/m!`

`= (-i)^p/(p-1)! * integral_(0..theta) (theta-v)^(p-1)*exp(-i*v) dv`.

For negative theta reverse orientation and take absolute values. Since the integrand's exponential has modulus one on the real segment, the norm is at most `|theta|^p/p!`. Exact r_n and y_j are real, so this sharper bound applies even though their numerical enclosures are complex boxes. Enclosure uncertainty is charged separately, not inserted as an imaginary exact residual.

Write `C_sigma=sum_(n<=N)n^(-sigma)` and choose Lambda>=log N. Uniformly for all j,

`|S_h(j)-T_h(j)|<=C_sigma*Lambda^h/h!*Rstar^p/p!`.                 (1)

This proves the new time-grid/frequency-rounding identity and its absolute truncation bound without a Riemann–Siegel evaluation or a spectral premise.

## 4. Arithmetic error and finite precision

For each actual A_(h,m,k), the input packet supplies a rational complex center ahat_(h,m,k) and a proved norm radius epsilon_(h,m,k). Include log, pi, phase, residual-power, log-power and finite bucket-summation errors. Dependencies between reused quantities require no independence assumption.

Let alpha_(h,m) bound the computed **normalized** transform's error relative to the exact transform of these rational centers. Let beta_(h,j) bound all final Horner and L-scaling rounding. Then the computed Shat satisfies

`|S_h(j)-Shat_h(j)| <= E_hj`, where

`E_hj = C_sigma*Lambda^h/h!*Rstar^p/p!`

`       +sum_(m<p)y_j^m*(sum_(k<L)epsilon_(h,m,k)+L*alpha_(h,m))`

`       +beta_(h,j)`.                                            (2)

The input error has no extra L after the sum over bins: normalization and final multiplication cancel. The FFT arithmetic error does have L. beta includes final scaling; a bound on unscaled Horner output alone must first be multiplied by L.

The accepted normalized radix-two contract is `moebius/FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md`, SHA `6E303D60C855E2CAD444EBC4EB3B1A3BD192D9BEAFAE0448F3F6D63CD9CDAC2E`, review `B98A0735B223EBA01922044733750DC13A3C806B531AA1894D54589B68A88B0D`. Its source positive convention is Mathlib `Analysis/Fourier/ZMod.lean`, `invDFT_apply`. The arbitrary-stage rounding extension is SHA `DA25013DFEAAACEFEAC5CF173A45B632C03BE42D1412A4EDD9D9A44E77CA4870`, reviewed at `2D3A8B62D027353636C656318E587E73DF8860982A11E3EE105F532B03982118`. New application support: `integration/FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md`, SHA `170C8F976A8AF8B299E4AB737E6924260B3B1D8328FA54C0F2BF7F6E9720F997`.

Specifically, if Bline bounds the norms of the rational input centers and all local rounding/twiddle errors are at most q, the normalized transform error is at most

`(q*Bline/2+q)*sum_(v<d)(1+q/2)^v <= d*q*(Bline+2)`

when q<=1/(d+1). For an unnormalized line allowance tau, choose a dyadic

`q<=min(1/(d+1), tau/[2L(d+1)(Bline+2)])`.

The accepted finite Machin/Taylor construction then supplies twiddle enclosures with sufficient precision. No old 36-stage cap or fixed-bit prescription is imported.

For any positive rational desired per-jet error eta, a simple terminating allocation is: choose p so (1)<=eta/4 for every h<K; require each epsilon<=eta/(4pL), each alpha<=eta/(4pL), and beta<=eta/4. Formula (2) then gives E_hj<=eta. A rational bound on C_sigma and Lambda suffices for choosing p; with Rstar<1, p! tends to infinity. Elementary input enclosure refinement and the finite arithmetic error rules supply the other tolerances. This is a correctness/termination interface, not a claim that a chosen bit precision or resource cap will satisfy it. The phase n^(-s0) may require log accuracy proportional to 1/|t0|; bin accuracy also depends on L*|Delta|. Neither cost is suppressed.

## 5. The remaining finite EM terms are included

For each j form the degree-(K-1) truncated polynomials

`R_j(z)=1/2+sum_(k<=M) [B_(2k)/(2k)!] B^(1-2k)(s_j+z)_(2k-1)`,

`Q_j(z)=(s_j-1+z)R_j(z)+B`,

`C_j(z)=exp(-z*log B)*Q_j(z)`.

Truncating all products modulo z^K is exact for the retained coefficients. Construct rising factorials successively by multiplying by s_j+r+z, accumulating at odd lengths. The exponential coefficients are `(-log B)^h/h!`. Thus the correction does not require any additional long Dirichlet sum.

The remaining base phases are `b_j=exp(-s_j*log B)`. Evaluate b_0 and the unit step `w=exp(-i*Delta*log B)` once, then use the exact recurrence b_(j+1)=b_j*w. If their approximations have errors e_0 and epsilon_w and each product incurs nu_j, then with A_B=B^(-sigma),

`e_(j+1)<=(1+epsilon_w)e_j+A_B*epsilon_w+nu_j`.

Use its finite geometric-sum bound, including the case epsilon_w=0; no division by epsilon_w is required. This explicitly charges the B phases. It neither assumes an exactly unit rounded step nor omits accumulated error. If a retained coefficient of C_j has center Chat_hj and radius gamma_hj, its product with b_j has error at most

`chi_hj=e_j*|Chat_hj|+A_B*gamma_hj+product_rounding_hj`.

All gamma bounds come from the displayed finite polynomial algebra with interval log B and exact rational Bernoulli factors. For each normalized coefficient of the full g, compute

`ghat_hj=(s_j-1)*Shat_h(j)+Shat_(h-1)(j)+bhat_j*Chat_hj`,

where the h-1 term is zero for h=0. If nu_hj now bounds the final assembly rounding, then

`|g^(h)(s_j)/h!-ghat_hj| <= |s_j-1|E_hj + E_(h-1,j) + chi_hj + nu_hj`. (3)

This includes every endpoint and Bernoulli term. Polynomial factors varying with j were not incorrectly put into fixed DFT coefficients.

## 6. Whole panels and a useful high-height scalar choice

To use these jets on an actual panel with |s-s_j|<=rho, sum the coefficient errors in (3) with weights rho^h. Add the finite-g outer-circle Taylor remainder and the **actual-point** Euler–Maclaurin remainder for zetaF. Finally divide the complete enclosure by the full nonzero s-1 box. Formula (3) alone is not a whole-panel theorem. Outer-disk finite-g bounds do not authorize actual-zeta EM estimates on that disk.

For the existing high-height parameters N=333334, M=32, K=24, sigma>=629/1250 and rho<=1/8, the residual truncation alone has a better weighted bound. Interchanging finite positive sums gives

`sum_(h<K)rho^h sum_(n<=N)n^(-sigma)(log n)^h/h!`

`<=sum_(n<=N)n^(-(sigma-rho)) <=sum_(n<=N)n^(-3/8)`

`<(8/5)N^(5/8)<8192`.

Multiplication by s-1 and the previous-jet term enlarge this weighted error by at most |s_j-1|+rho. If |s_j-1|>3rho, division by the actual |s-1|>=|s_j-1|-rho costs a ratio less than 2. Hence the **added quotient error from residual truncation** is

`<16384*Rstar^p/p! <=2^14/p!`.                                 (4)

The sufficient p=32 makes (4)<2^-100. This does not say that every one of the 24 individual jet errors is below 2^-100. Arithmetic in (2), correction errors, original finite-g Taylor error and original EM error remain separate. Independent support is `major-constants/EM_VERTICAL_BATCH_SCALAR_SUPPORT_2026-11-11.md`, corrected SHA256 `44C53A6F71D9B00368568D35C08D2ED69EC9ECA746AE61E2DDC8A79C5BA2C52F`; its exact script is `79D62492632A784D58019302F01C310849BB2B4A1D6AB4D782852F1DFCEA204C`, receipt `B68C8861B4F646C4EC43DEC00E5D364C33A1CEDF8C6F0C5FC976E72210F6F26F`. That note states positive Delta, a sufficient subset of the signed-Delta proof above; its scalar estimates depend only on the same absolute residual bound.

For example, if each normalized transform output has a combined moment-input/FFT radius at most `2^-104/(Lp)` and the output-center contraction is exact, its main-sum jet arithmetic radius is at most 2^-104. Since `sum_(h<K)rho^h<=8/7`, the quotient arithmetic contribution is at most `(16/7)*2^-104`. The corrected exact check gives `2^14/32!+(16/7)*2^-104<2^-100`. This optional allocation does not include separately rounded contraction, EM corrections or final assembly; add their bounds from (2) and (3). The superseded factor 128/63 is not used.

A concrete downward-grid application is sigma=629/1250, t0=1000000-1/16, Delta=-1/8. J centers then describe adjoining left-side vertical panels of radius 1/16, ending at the already tested upper height. Existing finite-g and actual-point scalar upper bounds remain applicable while all these target heights stay within the old bound. This is a candidate evaluator grid only: the additional panels' values, rotations and zero-exclusion margins are unknown. Horizontal crossbars at several different real centers need separate vertical batches; their cost must be added before claiming a closed multi-slab cover.

## 7. Explicit loops, work and storage

One concrete h-streamed implementation retains the N complex main weights W_n, initially n^(-s0), and updates them between h rows by `W_n <- W_n*(-log n)/(h+1)`. It also retains each n's real log/residual and full bin witness. For each h, allocate p length-L arrays. For each n, generate r_n^m/m! successively for m=0,...,p-1 and accumulate `W_n*(-i)^m*r_n^m/m!` into its unique bin. Transform these p arrays, evaluate their outer polynomial at all J values y_j, and store that h row. Repeating residual-power recurrence in each h row avoids a stored N-by-p table; that recomputation is counted below.

Ignoring reductions for exact zeros, this declared loop has:

| Counted work unit | Integer count |
|---|---:|
| Initial main complex exponentials | N |
| Real log inputs | N+1, including log B |
| Additional B base/step complex exponentials | 2 |
| Residual recurrence steps | NK(p-1) |
| Main log-weight updates | N(K-1) |
| Bin contributions, each a complex-real product and addition | NKp |
| Normalized radix-two butterflies | KpLd/2 |
| Output Horner steps | JK(p-1) |
| Exact-integer L output scalings | JK |
| B-phase recurrence products | J-1 |
| Common exp(-z log B) coefficient recurrence steps | K-1 |

There are also N bin-witness constructions and M exact rational Bernoulli/power weights to prepare. The table counts recurrence steps, not the potentially variable bit complexity of their rational divisions or exponentiation.

Each butterfly includes one complex twiddle product, two complex additions and normalization by 2. A recurrence step includes its real division; these are arithmetic work units, not equal-cost machine operations. Elementary phase/log evaluation and witness construction have their own precision-dependent costs.

For the correction polynomials let H_K=K(K+1)/2. A padded dense implementation, retaining all K positions at each rising-factorial step, uses at most

`J*((3M+2)K+H_K)`

complex-or-complex-real multiplications and the same number of additions for correction formation **and final g assembly**, in addition to the B-phase recurrence above. This bound comes from 2M-1 rising-factorial steps, M weighted odd-length accumulations, multiplication by s_j-1+z, one exponential-polynomial convolution, multiplication by b_j, and the main-sum assembly. It includes padded zero operations rather than assuming sparsity.

Working storage for the h-streamed schedule can be bounded by `N+pL+2JK+J+2K` complex slots, plus N log intervals, N residual intervals, N bin-witness records (each retaining its rational enclosure and full integer), O(M+K) real/rational constants, transform twiddle storage O(L), and the receipt/output format. This is a slot/record count, not bytes: precision, integer sizes and the fields of each witness matter. It is smaller than keeping KpL moment arrays simultaneously. Further m-streaming is possible, but would require a specified recurrence/cache schedule; no smaller storage claim is used here.

For N=333334, M=32, K=24, p=32, two exact one-line examples are:

| Work unit | J=1024, L=4096 | J=4096, L=16384 |
|---|---:|---:|
| Main bin contributions NKp | 256000512 | 256000512 |
| Old separate-center coefficient contributions JNK | 8192016384 | 32768065536 |
| Transforms Kp | 768 | 768 |
| Butterflies KpLd/2 | 18874368 | 88080384 |
| Streamed moment-array entries pL | 131072 | 524288 |
| Output contraction terms JKp | 786432 | 3145728 |

The h-streamed loop also performs NK(p-1) residual recurrence steps in both cases, rather than silently storing or reusing an uncharged N-by-p table. The corrections and all other table entries above remain additional costs.

The predecessor recomputes JN main exponentials and JNK main coefficient contributions on this single real-center line. The new construction uses N main exponentials, NKp bin contributions and Kp finite transforms. This is a concrete per-block shared evaluation scheme; it does not imply a particular runtime ratio. For fixed p and L=O(J), the displayed counts are O(NKp+KpJ log J) rather than O(JNK), apart from precision and elementary-function costs. The finite EM correction cost is still paid at every center.

## 8. Acceptance and remaining production risk

A future packet must bind the finite expression, exact center grid, bin witnesses, all input moment enclosures, normalized transform trace, every output error in (2), correction arithmetic and (3), and whole-panel errors and geometry. Closed-contour acceptance still requires actual nonvanishing panel tests and exact winding/another proved exclusion argument. Approximation error is not a lower bound for the function.

This derivation closes the specific algebraic batching gap: one need not rebuild an N-term exponential expansion independently at every regular vertical center of the same finite EM model. It does not supply those arrays, bound an optimized full-height workload, prove the chosen block's margins, replace the principal strip/family certificates, or implement the identities and arithmetic checker in Lean. Higher height can still increase N, required precision, correction conditioning and contour work. Those costs and actual spectral margins remain production questions.
