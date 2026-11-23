# Entire pole-difference jets with elementary moment enclosures

2026-11-11. Paper derivation and evaluator contract. No function values, coefficient arrays, implementation, transform, scan or Lean build were produced. This supplies the missing correction-jet algorithm in the finite-EM character/height composition. It supplies neither spectral margins nor a production cost estimate.

Review revision: this version supersedes the pending-review hash `390613DE23688F98C4A8C58FE870F8E501B6B425BC53535F5FCD190BD4D9C4DE`. Section 5 now states the effective point-input and positive-budget hypotheses required for its precision-termination claim. The analytic formulas and scalar bounds are unchanged.

## 1. Source contract and parameters

The immediate input is `zero-sum/FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md`, SHA256 `17D6A2E7478E3C03D8B9406C01A5AD93D4277E33B09009B6550D02357DE54BEC`. Its independent review is `mellin/REVIEW_FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md`, SHA256 `9E6004112BFBD8F565FBD2A6871B2E9C123751B5F35C9DEEFE631F7997EAAD64`. Paths are relative to `work/qrh-campaign/agents/`.

Fix integers c>1, N>=1 and a unit representative 1<=a<c. Set

```
X = cN+1,       X_a = cN+a,
ell = log X,   d = log(X_a/X),
z = (1-s)d,    E = exp((1-s)ell).
```

All logarithms are real logarithms of positive numbers. In particular,

```
0 <= d < 1/N,              d=0 iff a=1.                 (1)
```

For a>1, use `log(1+u)<u`, where `u=(a-1)/(cN+1)<1/N`; a=1 gives d=0 directly. Let K>=1 be the number of retained normalized jet coefficients, so indices are h=0,...,K-1. A jet means `P_h(s)=P^(h)(s)/h!`, not an ordinary derivative.

The actual correction from the accepted finite-EM adapter is the entire continuation

```
P_a(s) = [X_a^(1-s)-X^(1-s)]/[c(s-1)]
       = -(d/c) E exprel(z).                            (2)
```

The first expression is used only away from s=1. The second defines its value there. The factor 1/c and the minus sign belong to the already-scaled integer-base residue coefficient. No further c^(-s), Gamma, Gauss or parity factor is present here. The common meromorphic reference cancels only after nonprincipal character contraction. This construction does not identify an individual ordinary Hurwitz finite part at 1 with Mathlib's totalized Hurwitz value.

## 2. Integral formula and every normalized jet

The elementary entire identity

```
exprel(z) = integral_0^1 exp(zu) du
```

follows by uniformly convergent exponential series on the compact u interval. Thus

```
P_a(s) = -(d/c) E integral_0^1 exp(zu) du
       = -(1/c) integral_ell^(ell+d) exp((1-s)v) dv.     (3)
```

Compact-interval domination, locally uniform in complex s, permits every complex derivative under either integral. Define the entire exponential moments

```
phi_k(z) = integral_0^1 u^k exp(zu) du,   k>=0.
```

Then the exact normalized jet is

```
P_h(s) = -(d/c) E (-1)^h/h!
           * integral_0^1 (ell+du)^h exp(zu) du

       = -(d/c) E (-1)^h
           * sum_(k=0..h) ell^(h-k) d^k
               /[(h-k)! k!] * phi_k(z).                (4)
```

The binomial coefficients in the ordinary h-th derivative are precisely canceled by the normalization h!. Formula (4) retains the derivatives of E and z together. Multiplying every phi derivative by E without this convolution would be incorrect.

At s=1 one has z=0, E=1 and phi_k(0)=1/(k+1). In particular,

```
P_h(1) = (-1)^(h+1)
           * [(ell+d)^(h+1)-ell^(h+1)]/[c(h+1)!].       (5)
```

Formula (4), with exact rational moments at zero, avoids the subtraction in (5). P_0(1)=-d/c, so these jets are not generally zero at 1. For a=1, P_a and all jets are identically zero. That exact branch follows from the input a=1; merely obtaining a numerical interval containing d=0 does not justify it. Neither (3) nor (4) divides by z, d or s-1.

## 3. A common finite series and its sharp elementary tail

For Q>=1 retain the same Q powers for all moments:

```
phi_k,Q(z) = sum_(m=0..Q-1) z^m/[m! (m+k+1)].          (6)
```

The powers t_m=z^m/m! satisfy t_0=1 and t_(m+1)=t_m*z/(m+1), and are shared across all k<K.

Here is a remainder proof that uses Re(z), rather than replacing it by |z|. For real u in [0,1], Taylor's integral remainder along the real segment gives

```
exp(zu)-sum_(m<Q)(zu)^m/m!
 = (zu)^Q/(Q-1)! * integral_0^1 (1-v)^(Q-1) exp(vzu) dv.
```

Since `|exp(vzu)|<=exp(max(0,Re z))`, taking norms and integrating u^k gives

```
|phi_k(z)-phi_k,Q(z)|
 <= exp(max(0,Re z)) * |z|^Q/[Q! (Q+k+1)].             (7)
```

This proof is valid for complex z of either real sign, including z=0. It is the complex-valued real-parameter Taylor argument, not a claim that complex phases are real. A possible formal ingredient is Mathlib's `taylor_integral_remainder` for functions R -> C, with n=Q-1; the compact-integral series and derivative adapters remain to be implemented.

Let rational bounds satisfy

```
D>=d>=0, W>=|z|, A>=max(0,Re z), E_A>=exp(A),
E_X>=|E|, L>=ell+d.
```

Replacing phi_k by (6) in (4) gives the exact finite expression P_h,Q. Its analytic truncation error has the following two bounds:

```
|P_h-P_h,Q|
 <= (d/c)|E| sum_(k=0..h)
       ell^(h-k)d^k/[(h-k)!k!] * E_A W^Q/[Q!(Q+k+1)]

 <= (D/c) E_X E_A * L^h/h! * W^Q/[Q!(Q+1)] =: T_h(Q). (8)
```

All summands used to majorize the error are nonnegative. Thus there is no cancellation assumption in (8). The first bound can be cheaper in a future implementation; the second provides a simple common-Q rule.

For any rho>=0, the retained polynomial errors obey

```
sum_(h<K) rho^h T_h(Q)
 <= (D/c) E_X E_A C_K(rho L) W^Q/[Q!(Q+1)],
C_K(v) = sum_(h=0..K-1) v^h/h!.                        (9)
```

This is the error in approximating the retained coefficients. It does not bound the omitted h>=K Taylor terms of P_a or of the full finite-EM approximation. Such a whole-panel Taylor remainder must still be added under one of the accepted parent composition's panel routes.

## 4. Bounded arguments on the selected strip

Suppose `111/200<=Re(s)<=2`, `|Im(s)|<=T`, and T>=1. The elementary inequalities

```
|1-s| <= T+1,
|z| <= (T+1)/N,
max(0,Re z) <= 89/(200N) < 1,
|E| = X^(1-Re(s)) <= X                                (10)
```

allow W=(T+1)/N, E_A=3 and E_X=X. Choose a rational upper bound L for ell+1/N. With D=1/N,

```
(D/c) E_X E_A = 3(cN+1)/(cN) <= 9/2.                  (11)
```

Hence T_h(Q) can be replaced by `(9/2)(L^h/h!) W^Q/[Q!(Q+1)]`. The small d compensates for the coarse X bound. If N>=gamma*(T+1), gamma>0 rational, then W<=1/gamma. This proves a height-independent bound for the moment argument under that explicit choice of N. It does not give fixed cost for the whole correction: L grows like log(cN), the phase of E contains t*ell, and precision depends on the requested error.

These are center-jet bounds in the stated strip. If an implementation evaluates moments at other s in a disk, it must enlarge (10) for that disk; no old sigma floor is silently inherited. Using center jets plus a separately proved entire-function Taylor tail does not require such disk evaluations.

For a positive prescribed tail budget, Q can be selected by rational arithmetic. Write

```
F_Q(W)=W^Q/[Q!(Q+1)],  F_(Q+1)/F_Q=W/(Q+2) for W>0.
```

Choose Q0>=1 with Q0+2>=2W. Thereafter each additional term halves this upper bound. Increase Q until (8) meets every allocated coefficient tail budget, or until (9) meets an allocated weighted polynomial budget. All other factors in those inequalities have fixed finite rational bounds at this stage, so the search terminates. W=0 gives zero moment tail for every Q>=1. The exact reference branch d=0 requires no moment search.

## 5. Elementary input and arithmetic enclosure contract

The output for each h is a rational complex center p_h and a rational radius e_h with `|P_h(s)-p_h|<=e_h`. The following is a construction specification, not a reported implementation.

The analytic identities above hold for every complex s. Effective arbitrary-precision evaluation here has a narrower input contract: s is either an exact rational complex center, or is supplied with an effective point-name that, on request, produces certified rational enclosures of s of arbitrarily small specified radius. The algorithm must have access to that refinement procedure. Requested coefficient error budgets, or the allocated weighted budget, are positive rational numbers. Any strip hypotheses used for the sharper bounds in section 4 must also be supplied or proved; otherwise use certified bounds for the actual point input in section 3.

A fixed positive-width input s-box can be propagated to an enclosure of the function's image, but increasing arithmetic precision need not shrink that true image. No arbitrary-output-precision termination claim is made for such an irreducible box or for an arbitrary complex s without an effective point-name. The existing exact rational pilot grids satisfy the point-input contract.

First enclose ell and d using positive real logarithms. For d put

```
u=(a-1)/(cN+1),  w=u/(2+u),
d=2 sum_(j>=0) w^(2j+1)/(2j+1).
```

Here 0<=w<1/3. Retaining j=0,...,R-1 has positive tail at most

```
2 w^(2R+1)/[(2R+1)(1-w^2)].                            (12)
```

For ell, exact binary range reduction X=2^e*y with 1<=y<2 reduces log(y) and log(2) to the same series with w<=1/3. The log(2) error is multiplied by the exact integer e. Thus both inputs admit rational interval enclosures of arbitrary absolute accuracy. This avoids a poorly conditioned numerical subtraction of two large logarithms to obtain d.

Next enclose z=(1-s)d and E=exp((1-s)ell), then the finite expression (4) with (6), using outward rational complex arithmetic. A fully elementary complex exponential algorithm is enough. For example, on a bounded input disk |v|<=R_v, its power series has tail at most `exp(R_v) R_v^p/p!` after p terms. A rational bound for exp(R_v) can itself be obtained by a geometric majorant of its real exponential series after its terms have ratio <=1/2. This proves existence and termination without a special-function oracle. Range reduction and certified sine/cosine can improve the cost, but are not required for this paper contract.

The crude exponential construction is not a practical uniform high-height algorithm. A phase-reduced implementation must certify its reduction and elementary trigonometric errors. In particular, uncertainty in ell is multiplied by |1-s| before exponentiation. One useful sensitivity bound is

```
|exp(v)-exp(w)| <= |v-w| exp(max(Re v,Re w)),            (13)
```

obtained by integrating exp along the straight segment. It shows why keeping the exponent's real part controlled matters even when its imaginary part is large. The exact input phase, any certified range-reduction integer, and rounding still count as work.

Every finite operation above is continuous in the input intervals, and its divisions are by positive integers or c. With Q fixed and the point-input contract just stated, refining the enclosure of s, the elementary input enclosures and arithmetic precision makes the enclosure of the finite expression arbitrarily narrow. Thus a sufficient selection procedure for positive rational budgets is:

1. Fix rational upper bounds in (8) and choose Q so its analytic tail is at most half the requested error for each coefficient, or half a specified weighted budget.
2. Refine input and arithmetic precision until the finite-expression output box, including the final prefactor multiplication, has the remaining allocated radius.
3. Add the analytic tail T_h(Q) once, after all arithmetic propagation.

For a rectangular complex output box, its maximum L1 distance to the reported center is a rational upper bound for its Euclidean radius. Add T_h to that radius. If analytic disk errors are instead padded separately into both coordinate intervals, account for that conversion; do not silently interpret a coordinate radius as a Euclidean radius. No statistical independence of errors is used.

If the identity s=1 is supplied or follows from exact rational input, use exact E=1 and moments 1/(k+1), while enclosing the real logarithms as before. An arbitrary point-name does not generally decide equality to 1, and this shortcut must not be selected by a numerical equality or proximity test. The generic formula works without deciding whether s=1. At a=1, output exact zero jets using the exact integer input identity.

## 6. Error transfer to characters and panels

For each residue let e_(a,h) be the full radius from section 5. Since every unit character value has norm 1, direct character contraction contributes at most

```
sum_(a unit) e_(a,h)
```

to its h-th coefficient. A normalized positive unit-group transform additionally requires its numerical circuit error multiplied by v=phi(c), and a separately enclosed final scaling. The input errors themselves are summed once. This is the parent transform contract, with no Gaussian Fourier scale and no parity one-half.

At a panel radius rho, these correction-coefficient errors contribute at most `sum_(h<K) rho^h sum_a e_(a,h)`. The complete finite-U polynomial still includes main-sum and Bernoulli correction errors, its own omitted Taylor tail, and the actual EM remainder. Equation (9) cannot replace any of those. A certified polynomial enclosure is not by itself a nonvanishing or winding certificate.

## 7. Literal operation counts and remaining work

For one nonreference residue and one center, with common Q and K, a direct finite-moment implementation uses the following counts, ignoring harmless initialization differences:

* Q-1 complex multiplications to form t_m recursively and Q-1 divisions by positive integers.
* KQ complex divisions by positive integers m+k+1 and at most KQ complex additions to obtain all moment sums.
* Two length-K real factorial-normalized power arrays for ell and d. These require at most 2(K-1) real multiplications and integer divisions; they can be cached across heights. The ell array is also common across residues.
* K(K+1)/2 real-complex multiply-and-add terms for (4), after caching the real weights `ell^(h-k)d^k/[(h-k)!k!]`. Computing those weights takes the same number of real products per residue and can be shared across heights.
* K final complex multiplications by the common prefactor -dE/c, with exact alternating signs.

The common E is computed once per conductor, N and center, rather than once per residue. Each d is computed once per residue and N. Each z still depends on residue and center. With v residues and J centers the direct correction moment/convolution work is `O(v J (KQ+K^2))` arithmetic operations, plus those common computations and caches. For variable Q, replace JvQ by the actual sum of selected Q values. This is an additional cost to the parent main-sum transforms and Bernoulli corrections.

These counts are not bit-operation costs. They omit neither the need for logarithm/exponential certification nor the possibility of precision refinements, but price them separately. Arbitrary-height phase reduction, input bit lengths, final tolerance and output size can grow. Bounded W alone does not establish bounded precision, bounded Q for unbounded ell, or a useful wall-time estimate.

The next implementation obligations are the compact-integral derivative identity, the normalized moment tail, rational elementary input enclosures, and a checker for the final coefficient/transform radii. The accepted source continuation still supplies the identification with actual nonprincipal L-functions. No stronger finite zero hypothesis is introduced, and no family coefficient evidence is supplied by this note.
