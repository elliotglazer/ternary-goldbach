# Finite-EM sharing across character labels and exact heights

2026-11-11. Paper interface and gap analysis only. No coefficient, transform, function value, scan or Lean build was computed. The main finite sums admit a joint character/time transform. This is a new finite-EM adapter, not a reuse of the Gaussian theta sampling identity or its constants. It neither supplies family data nor guarantees nonvanishing or practical savings.

## 1. Accepted inputs and actual function

The main inputs, under `work/qrh-campaign/agents/`, are:

| Input | SHA256 |
| --- | --- |
| `moebius/FINITE_EM_VERTICAL_BATCHING_2026-11-11.md` | `814AD0B3012FDA4FD81B485139257409E81E6EAC8FA44FD6824A7D21F02C8818` |
| `integration/UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md` | `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866` |
| `major-constants/JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md` | `3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D` |
| Corrected finite-EM scalar support | `44C53A6F71D9B00368568D35C08D2ED69EC9ECA746AE61E2DDC8A79C5BA2C52F` |
| Its independent scalar review | `4A7FF42F81E202C7842BEF8A0F294D1CB11F3F9812D91ECC282D39DCE32B0126` |

The Gaussian joint plan supplies useful transform scheduling/error conventions, but its Gaussian tails, Gauss factors, parity split, Fourier scales and root phases are not used below.

Fix c>1 and the accepted exact CRT coordinate isomorphism for its unit group G, of size v=phi(c). Unit representatives a satisfy 1<=a<c. Use the manifest's actual positive-exponent source characters and retain its primitive nonprincipal labels; this includes noncyclic 2-primary factors. The source `ZMod.LFunction` definition is

`L(s,chi)=c^(-s) sum_(a unit) chi(a) hurwitzZeta(a/c,s)`.

I re-read `NumberTheory/LSeries/ZMod.lean` at the pinned Mathlib revision. Its residue-class proof uses positive-real complex-power multiplication, and its entire continuation for coefficient sum zero is explicit. All bases in the construction below are positive reals, with real logarithms. Equality to classical Hurwitz expressions is first justified in Re(s)>1, then continued through the nonprincipal combination. No conditionally convergent critical-strip Dirichlet series is interchanged with an integral or transform.

## 2. New entire finite-EM residue adapter

Choose common N,M>=1. For each unit a write

`alpha_a=a/c`, `X_a=cN+a`, `X_1=cN+1`, `d_a=log(X_a)-log(X_1)`.

Truncate the Hurwitz main sum at nu=0,...,N-1. Multiplying its entire finite expression by c^(-s) converts every main base to the positive integer `n=c*nu+a`; it does not leave a second external c^(-s) factor. Put `b_m=B_(2m)/(2m)!` and define

```
U_a(s) = sum_(nu=0..N-1) (c*nu+a)^(-s)
       + X_a^(-s)/2
       + sum_(m=1..M) b_m*c^(2m-1)*(s)_(2m-1)*X_a^(1-s-2m)
       + P_a(s),

P_a(s) = [X_a^(1-s)-X_1^(1-s)]/[c*(s-1)]
       = -(d_a/c)*X_1^(1-s)*exprel((1-s)*d_a),
exprel(z)=sum_(k>=0) z^k/(k+1)!.
```

The exprel expression defines P_a at s=1, where `P_a(1)=-d_a/c`; P_1 is identically zero. Thus every U_a is entire. The factor `c^(2m-1)` in the correction follows from `c^(-s)(N+a/c)^(1-s-2m)` and must not be dropped.

Away from 1, this subtracts the same meromorphic term `X_1^(1-s)/(c*(s-1))` from each scaled Hurwitz coefficient. The common term vanishes after summing against a nonprincipal character. Equivalently, the exact source coefficient differences equal the differences of these analytically deflated coefficients by continuation. This avoids equating an individual ordinary finite part at s=1 with Mathlib's individual totalized Hurwitz convention, whose correction includes GammaR. Only the common difference/nonprincipal combination is identified.

The numerical finite approximation to L is therefore

`L_fin,chi(s)=sum_a chi(a) U_a(s)`.

Do **not** mechanically multiply the entire nonprincipal L-function by s-1 as in the principal zetaF producer: that would introduce a zero at 1 and require a separate removal. No such multiplier or quotient is needed in this adapter. Likewise, if an alternative implementation retains unscaled Hurwitz jets, multiplying all jet orders by c^(-s_j) alone is wrong: order h needs convolution with `(-log c)^ell/ell!`. Absorbing the scale into positive bases implements that convolution exactly.

For sigma+2M>1, the standard explicit Hurwitz EM error, multiplied by c^(-sigma), is bounded by

`R_a(s) <= 4*c^(2M-1)*|(s)_(2M)|*X_a^(1-sigma-2M)`

`             /[6^(2M)*(sigma+2M-1)]`.

This follows directly from the reviewed periodic-Bernoulli remainder using 2pi>6. It is not the principal zetaF remainder: it has no extra |s-1|. The same subtraction defining U_a removes its pole without changing this error. Continuity supplies s=1. Consequently each actual character error is at most `sum_a R_a(s)`. A proof through centered differences can obtain the same bound by canceling the common reference remainder symbolically; independent numerical subtraction can instead incur an avoidable extra reference error.

## 3. Tensor identity for the main sums only

Fix exact centers `s_j=s0+i*j*Delta`, s0=sigma+i*t0, 0<=j<J, with real signed Delta, and K retained jet orders. Choose power-of-two L>=4J and residual length p>=1. For each of the Nv integer bases n=c*nu+a, certify a bin as in the accepted vertical plan:

`x_n=L*Delta*log(n)/(2pi)`, `q_n=floor(midpoint(x_n)+1/2)`,

`|x_n-q_n|<=5/8`, `k_n=q_n mod L`,

`r_n=J*(Delta*log(n)-2pi*q_n/L)`, `y_j=j/J`.

Then |r_n|<1. Keep the full q_n, not only its residue. The bases are at least 1, so all log(n)>=0; n=1 and Delta=0 require no special division or removed term.

For each residue and jet/residual order form

`A_(a,h,m,k)=sum_(nu:k_n=k) n^(-s0)*(-log n)^h/h! *(-i*r_n)^m/m!`.

Let P_G be the normalized positive unit-group transform (factor 1/v) using the actual CRT labels, and P_L the normalized positive length-L transform. Finite distributivity yields the main-sum approximation

`S_hat_(chi,h,j)=v*L sum_(m<p) y_j^m (P_G P_L A_(h,m))_(chi,-j mod L)`.

The transforms commute because they act on distinct finite axes. The character output label is positive chi, while the time label is **negative j**. The final scale is vL for these two normalized transforms. There is no remaining c^(-s), Gaussian frequency omega, or Fourier quadrature h. Using an unnormalized character transform removes v; using an unnormalized time transform removes L, with corresponding error rescaling.

No parity or Gauss-number factor appears in this Hurwitz route. All primitive labels are selected through the manifest after transformation. At the same complex s a nonreal character and its inverse remain separate outputs. Conjugation reuse requires the separate identity at conjugate(s), not an unsupported same-height identification.

## 4. Additional main-sum error

The accepted real-phase integral Taylor bound gives the exact extra h-jet error for every chi at most

`W_h/p!`, where `W_h=sum_(a unit,nu<N) n^(-sigma)*(log n)^h/h!`.

It applies to the exact real phases y_j*r_n; uncertain moment arithmetic has its own radius. For rho>=0,

`sum_(h<K) rho^h W_h <= sum_(a,nu) n^(-(sigma-rho))`.

On the selected real range sigma>=111/200 and rho<=1/8, a conservative bound is

`sum_(h<K) rho^h W_h < (8/5)*(cN)^(5/8)`,

because every retained integer base lies in [1,cN), the set has no duplicates, and sigma-rho>3/8. This is a worst-case triangle bound for each character; it uses no orthogonality cancellation. It does not reuse the principal constant 8192. As no multiplication/division by s-1 is needed here, there is no associated factor two in this main-sum L-polynomial error.

For a complete normalized tensor implementation, let epsilon_(a,h,m,k) bound moment-input error, alpha_(h,m,chi,j) bound its transform arithmetic relative to the exact normalized transform of centers, and beta_(h,chi,j) bound final contraction/scaling arithmetic. The numerical main-jet radius can use

`sum_(m<p)y_j^m [sum_(a,k) epsilon_(a,h,m,k) + vL*alpha_(h,m,chi,j)] + beta_(h,chi,j)`.

The input vL normalization cancels once; the normalized circuit error still needs vL. A staged implementation can use separate time and character error recurrences instead, but it must prove their final radius encloses this same finite map. Shared errors are not independent. A fixed p=32 or an old absolute output tolerance is not inherited: select p and arithmetic budgets using c,N,K,rho and the requested actual L error.

## 5. Complete corrections and panel semantics

The preceding tensor identity covers only the Nv-term main sums. For **every residue and height**, the following remain:

* The half endpoint and all M Bernoulli corrections, with factors `c^(2m-1) X_a^(1-2m)` and the actual rising factorial `(s_j+z)_(2m-1)`.
* Endpoint phases `X_a^(-s_j)`, which may use a certified recurrence with step `exp(-i*Delta*log X_a)` and accumulated error. The step is residue dependent, not one shared B phase.
* The common-pole-difference P_a and its K normalized jets. Use its entire exprel formula with a proved series/derivative remainder, or a proved equivalent integral representation. All parameter dependence and arithmetic must be enclosed.

The rising-factorial polynomial at fixed j is common to all residues and can be shared. The residue-specific weights and endpoint exponentials are not common. Products are truncated modulo z^K to obtain exactly the retained jets. Terms varying with j cannot be placed in fixed moment bins without another derived identity.

A useful exact bound for the entire pole difference follows from

`P_a(s)=-(1/c) integral_(log X_1)^(log X_a) exp((1-s)v) dv`.

Thus on any vertical real-part bound sigma_min its modulus is at most `(d_a/c)*max(X_1^(1-sigma_min),X_a^(1-sigma_min))`, independent of height. This supports a finite-U outer-circle bound without a singular division near 1. Normalized derivative bounds gain `max(log X_1,log X_a)^h/h!`. It does not itself evaluate those derivatives. Although d_a<1/N for N>=1, the exprel argument can still have magnitude of order |t|/N, and its producer cost must not be assumed constant without a specified algorithm.

Two sound routes from corrected jets to actual L panels are available. Bound the actual EM remainder on a disk where sigma_min+2M>1 and use Cauchy to bound its derivative errors, then combine actual L Taylor coefficients. Or build Taylor jets for the entire finite `L_fin,chi`, bound its finite-function Taylor tail, and add the actual-point EM remainder only on the tested segment. The latter mirrors the accepted finite-g method but needs its **new U-based outer bound**. Neither route inherits the principal g constant 2^48, its (s-1) quotient, or its fixed Taylor degrees.

All final coefficients include correction arithmetic and character-transform errors. Whole-panel nonvanishing, shared rational vertices, closed geometry and winding remain separate. The finite approximation is not a proof of a spectral margin.

## 6. Literal schedules and unresolved cost

Write n_prim for retained primitive labels and let C_G(v) and C_T(L) denote costs of correctly normalized certified transforms at the actual working precision. They are not universal unit-cost assumptions. The bin-moment construction takes Nv baseline phases and NvKp contributions in a direct implementation, plus logs, residual recurrences, certified binning and input-error work.

A time-first schedule performs vKp time transforms, contracts the p modes at vJK locations, adds all residue corrections, then performs JK character transforms. Its symbolic transform/contraction work is

`vKp*C_T(L) + O(vJKp) + JK*C_G(v)`.

A character-first main-sum schedule performs KpL character transforms, keeps n_prim outputs, then n_prim*Kp time transforms and n_prim*JKp contractions. The corrections still need their own JK character transforms or a separately justified equivalent scheme. Its corresponding work is

`KpL*C_G(v) + n_prim*Kp*C_T(L) + O(n_prim*JKp) + JK*C_G(v)`.

The two schedules compute the same finite main term, but their error paths and working sets differ. Neither is uniformly preferable. A literal dense retained tensor has vKpL complex entries; h-streaming can reduce the moment arrays to vpL, but still needs a declared cache/output schedule and may retain Nv base data and n_prim*KJ outputs. These are slots, not bytes.

For straightforward per-residue corrections, a conservative arithmetic envelope is `O(vJ(MK+K^2))`, plus the **additional** cost of the vJ exprel-jet enclosures and endpoint phase/certification work. Sharing rising factorials reduces part of this bound, not the whole correction obligation. Arbitrary unit-group axis lengths also require the accepted certified Bluestein/direct-fallback machinery; a cyclic length-v FFT does not implement a noncyclic unit group.

Most importantly, integer-base absorption does not improve the EM truncation condition for free. In the displayed remainder the dominant ratio is still of the form `|s|/[2pi*(N+a/c)]`; writing X_a=cN+a does not turn this into a favorable ratio |s|/X_a without the compensating powers of c. Thus this adapter alone does not justify a square-root-conductor-height cutoff, fixed M, uniform precision or a family runtime forecast. Active heights, individual margins, correction conditioning and the number of contour batches remain consequential unknowns.

## 7. Concrete missing adapter and next proof boundary

The new proof task is finite and specific: identify the entire residue U_a with the common-pole-subtracted source Hurwitz combination, prove its c-scaled EM remainder, then compose the exact two-axis moment identity with correction jets and actual unit-group characters. Accepted character indexing and transform-circuit theorems can be reused. The Gaussian theta/Gauss/tilt machinery is not required for this route.

A future implementation must bind c, exact representatives/CRT labels, N/M/K, signed center grid, bin witnesses, positive bases, common reference, both DFT normalizations, complete correction data and every radius. It must reject principal-row misuse at s=1, omitted c powers, a second c^(-s) scaling, incorrect jet scaling, reversed character labels, omitted residual signs and uncharged correction phases. Conductor one stays in its separate principal branch.

This gives a valid paper route to sharing finite-EM work over both heights and characters. It does not compress the need to certify every selected primitive character through its exact Hcert, including real-axis and inclusive-height coverage. No all-family arrays, error radii, successful panels, proof-producing checker or feasibility estimate are supplied here.
