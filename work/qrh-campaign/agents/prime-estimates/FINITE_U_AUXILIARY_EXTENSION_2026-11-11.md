# Finite-U EM allocation at arbitrary auxiliary heights

2026-11-11. Paper proof and exact scalar witnesses. This extends the reviewed finite-U Euler--Maclaurin allocation beyond cU<=100000000. It supplies explicit finite choices for the EM order, main-sum length, retained Taylor degree count, time-batching remainder and entire pole-difference moment order. It also gives a common main/auxiliary grid that reaches the critical line from the selected .555 or .56 centers. No L-function, theta function, zero, sign or Fourier array was evaluated. No Lean declaration, build, canonical edit or frozen-file change was made.

The existing arbitrary-height Fourier and FFT-precision extensions already remove their own cU cap. They do not give the finite-U EM allocation derived here. The new contribution is specific to the complete finite-EM function, including all conductor factors and pole-difference corrections. No claim about a practical production runtime or fixed machine-precision implementation follows.

## 1. Inputs and retained actual function

Let 2<=c<=300000 and let chi be an actual nonprincipal character modulo c. Primitivity is not needed for this evaluator identity, though the selected spectral manifest uses primitive characters. Fix an arbitrary finite real work height V>=0, an integer p>=0 and eps=2^(-p). For finite input certificates V is rational. There is **no bound on cV**. Every center s0 obeys

    111/200 <= Re(s0) <= 2,       |Im(s0)| <= V.

The target is the complete closed disk |s-s0|<=rho=1/16, and the Cauchy outer radius is 1. Thus the target real part is at least 197/400; the outer real part is at least -89/200>-1/2. This includes centers with real part .56 without changing the proof.

For integers N,M>=1 and unit representatives 1<=a<c, retain the exact adapter

    B_a=N+a/c, X_a=cN+a, X_1=cN+1, X=c(N+1),
    U_a(s)=sum_(nu<N)(c*nu+a)^(-s)+X_a^(-s)/2
          +sum_(m=1..M) b_m*c^(2m-1)*(s)_(2m-1)*X_a^(1-s-2m)+P_a(s),
    b_m=B_(2m)/(2m)!,
    P_a(s)=-(1/c)*integral_(log X_1)^(log X_a) exp((1-s)t) dt,
    F(s)=sum_a chi(a)*U_a(s).

Here (s)_r is the rising factorial and every positive-base power uses the real logarithm. F and P_a are entire. Away from 1,

    P_a(s)=[X_a^(1-s)-X_1^(1-s)]/[c(s-1)],

but the integral, not totalized division, defines it at 1. In particular P_a(1)=-log(X_a/X_1)/c, and only a=1 makes every P_a jet identically zero. There is no extra c^(-s) and no multiplication of L by s-1. Equality with the source L-function follows from the reviewed nonprincipal Hurwitz combination and continuation; it is not an identification of an individual ordinary Hurwitz finite part with the library's totalized value.

The reviewed general remainder, valid for sigma+2M>1, is

    |L(s,chi)-F(s)|
      <= sum_a (4/c)*X_a^(1-sigma)/(sigma+2M-1)
                         * |(s)_(2M)|/(6B_a)^(2M).             (1)

The factor 1/c in each term and v/c<=1 after summing v=phi(c) are retained. The last Bernoulli term has rising length 2M-1; the remainder has length 2M. Neither the bound nor the finite formula drops a correction.

## 2. A terminating EM rule, with an explicit search cap

Put u=ceil(V). For each candidate M>=1 set

    N_M=u+2M+4,      X_M=c(u+2M+5),
    E_M=4X_M/[36^M*(2M-203/400)].                            (2)

On the outer disk, |s|<=V+3. Every remainder factor has norm at most V+2M+2<N_M, and every retained correction factor is at most V+2M+1<N_M. These inequalities remain strict even at integer V. The remainder denominator is at least 2M-203/400>0 on the target disk. Since 1<=X_a<X_M and sigma>=197/400,

    X_a^(1-sigma) <= max(1,X_M^(203/400)) <= X_M.

This deliberately coarse bound handles sigma>1 correctly. Substitution in (1) gives the strict actual-L norm error <E_M on the full target disk.

The stopping test is the exact rational inequality E_M<=eps/8. It has a known finite search range. Let q be the positive-integer bit length of X_1^*=c(u+7), so X_1^*<2^q, and set

    M_cap=1+ceil((p+q+3)/4).                                (3)

At M=1, E_1<X_1^*. Also

    E_(M+1)/E_M
      =[(u+2M+7)/(u+2M+5)]*(1/36)
         *[(2M-203/400)/(2M+2-203/400)] <1/18<1/16.

Consequently E_(M_cap)<2^q*16^(-(M_cap-1))<=eps/8. One may take M_cap directly or choose the first passing M in 1..M_cap. This is a finite arithmetic rule, not a convergence-only prescription. Below, N=N_M and X=X_M for the chosen M.

## 3. Outer bound and the complete finite-function Taylor tail

On every radius-one outer disk, a positive-base term b^(-s) with 1<=b<X has norm at most sqrt(X). Because every retained rising-factor ratio to B_a is below 1, the old looser geometric bound using ratio 4 still applies for arbitrary M:

    sum_(m>=1) (4/6^(2m))*4^(2m-1)=4/5.

Thus all head, half and Bernoulli terms are bounded by sqrt(X)*(vN+v/2+4v/5). Moreover d_a=log(X_a/X_1)<1/N, so the integral defining P_a gives |P_a(s)|<X^(3/2)/(cN). This argument uses only the outer real-part lower bound -1/2 and is independent of height. Summing the pole corrections gives

    |F(s)| < sqrt(X)*[vN+(13/10)v+vX/(cN)]
           <= X^(3/2)*(1+23/(10N)) <2X^(3/2)<=2X^2.       (4)

Here N>=6 and X>1. This is an outer bound for **F**, not a claimed coefficient bound for L obtained by differentiating a pointwise EM error.

Let a_h=F^(h)(s0)/h!. The Cauchy estimate on radius one yields

    |F(s0+z)-sum_(h<K)a_h*z^h|
       <T_K=32X^2/(15*16^K)             (|z|<=1/16).        (5)

Choose K by T_K<=eps/8. If q_X=bit_length(X), the explicit cap

    K_cap=ceil((p+2q_X+5)/4)

passes, because T_K<2^(2q_X+2-4K). The finite search 1..K_cap or the cap itself is sufficient. Normalized coefficients already contain h!, so no additional factorial occurs in (5).

Equations (2) and (5) alone give an exact-polynomial approximation to actual L of error <eps/4 on every complete target disk. It does not require batching, arithmetic approximations or a zero-free disk assumption.

## 4. Explicit time-batching and pole-moment orders

If the accepted character/time tensor algorithm is used, its weighted main-sum bound for rho<=1/8 gives

    sum_(h<K)rho^h W_h <(8/5)(cN)^(5/8)<2X.

For a certified time grid with J centers, transform length Ltime>=4J and correct bin residuals, choose a time residual length P>=1 with

    R_P=2X/P! <=eps/8.                                    (6)

An explicit finite search cap is P_cap=p+q_X+5, since P!>=2^(P-1) for P>=1. This replaces the old fixed P=32 assertion. It does not authorize an unverified bin, DFT sign or transform normalization.

The entire pole-difference jets have their own moment order Q, distinct from P. Write ell=log X_1, d=log(X_a/X_1), z=(1-s0)d, E=exp((1-s0)ell). The accepted exact normalized jet is

    P_(a,h)(s0)=-(d/c)E*(-1)^h
       *sum_(k=0..h) ell^(h-k)d^k/[(h-k)!k!]*phi_k(z),
    phi_k(z)=integral_0^1 t^k exp(zt) dt.

Its Q-term approximation uses sum_(m<Q)z^m/[m!(m+k+1)]. The reviewed remainder is

    |phi_k-phi_(k,Q)| <= exp(max(0,Re z))*|z|^Q/[Q!*(Q+k+1)].

The present parameter choice supplies, without cV restriction,

    0<=d<1/N, |z|<1, |E|<=X,
    exp(max(0,Re z))<3, ell+d=log X_a<q_X.

Indeed |1-s0|<=V+1<N, while max(0,Re z)<=d<1 and exp(1)<3. Also X<2^q_X and log(2)<1. For every h<K, summing the pole-jet truncation errors over all unit residues, using v/c<=1, gives the common bound

    J_Q=3X*q_X^(K-1)/[N*Q!*(Q+1)].                        (7)

No cancellation or small individual character sum was used. Choose Q with J_Q<=eps/512. Let r=bit_length(q_X). Then

    Q_cap=p+q_X+(K-1)r+12

passes by Q!>=2^(Q-1), X<2^q_X and q_X<2^r. Thus Q is also selected by a bounded rational search. The exact d=0 branch remains available, but the bound is valid without exploiting it. These are errors in retained pole coefficients; the full omitted Taylor tail has already been paid in (5).

All half, Bernoulli and pole terms remain in the algorithm. Bernoulli numbers are exact rationals from their recurrence. Formula (7) pays the analytic moment truncation, but evaluating the finite expression still requires verified log, exponential, character-root and arithmetic enclosures.

## 5. A complete finite-arithmetic acceptance budget

The following is an explicit sufficient contract for future finite data, not a statement that a fixed binary precision or an old saved box already meets it. All errors in this paragraph are Euclidean complex norm errors, after any coordinate-box conversion.

For every input moment and every normalized two-axis output relative to the exact transform of the serialized centers, require error at most

    eta=eps/(512*P*v*Ltime).

The tensor scale v*Ltime and the sum of P residual modes give combined input/output error at most eps/256 per retained coefficient. Allow a further eps/256 for residual contraction arithmetic. The whole main coefficient error is then at most eps/128. This uses the actual normalized positive character/time transforms, the time index -j, and |j/J|^m<=1; the unnormalized scale cannot be dropped.

For the complete character-summed correction coefficient, allow eps/128, split as eps/512 for (7) and 3eps/512 for all finite arithmetic, root/phase/log enclosures and the half/Bernoulli/pole assembly. Allocate eps/64 for the final main-plus-correction assembly. Then every full retained coefficient differs from its ideal, time-truncated value by at most

    eps/128+eps/128+eps/64=eps/32.

The corresponding polynomial error is at most (16/15)*eps/32=eps/30 on the full disk. The time-truncation error (6) is separate. Allow a final eps/8 for polynomial evaluation and output serialization, including evaluation at arbitrary certified target points; this is not a free exact Horner operation.

Even if all three analytic errors E_M,T_K,R_P are inserted as componentwise square padding, their Euclidean error is at most (3/2)(E_M+T_K+R_P). Therefore the complete actual-L enclosure error is bounded by

    (3/2)(E_M+T_K+R_P)+eps/30+eps/8
      <=(9/16+1/30+1/8)*eps =173eps/240 <3eps/4.           (8)

Thus p=68 preserves a complete error below 2^-68, with room, at arbitrary finite V. Without time batching, omit R_P and its moment machinery. Different allocation choices are possible, but no implementation may silently reuse the old P32, Q32, fixed 512-bit elementary budget or 65536-bit work cap for these new parameters.

For fixed finite rational centers and positive budgets, the accepted elementary and pole-jet procedures permit refinement to the stated tolerances. This is point refinement: arbitrary immutable input boxes need not become accurate enough. No resource bound for that refinement, nor any proof that the saved finite programs implement these new formulas, is asserted. The analytic bounds (1)-(7) are unconditional mathematical implications of the stated function/domain definitions; (8) additionally specifies the finite arithmetic evidence still to produce.

## 6. One exact grid for main and auxiliary use

Let the requested auxiliary endpoint be U=T+h, with rational T>=H(c), h>0. Set

    V=ceil(32U)/32,
    s_j=b(c)+i*j/32,       0<=j<=ceil(32U),

using the selected b(c)=111/200 or 14/25. Apply all preceding parameters with **V**, not U or T. The last center can lie above the requested U by less than 1/32. Every center therefore satisfies the proved work-height bound. The finite function F uses the same N and M throughout both intervals; no normalization or coefficient convention changes at T.

For any t in [0,U], a nearest grid height has |t-j/32|<=1/64. Both selected center abscissae are within 3/50 of the critical line, and the exact inequality

    (3/50)^2+(1/64)^2 <(1/16)^2

puts 1/2+it strictly inside that center's target disk. This includes the main endpoint T, the auxiliary endpoint U and any intermediate rational sign-sampling point, even if they are not grid centers. Reflection or separately constructed negative centers must retain the actual inverse-character convention. The one-sided number of centers is exactly ceil(32U)+1. If time batching is used globally, choose Ltime>=4J; blockwise use is also possible with correct local indices and common source normalization.

This grid supplies a geometric way to evaluate actual critical-line L-values from the same finite-U family used near the forbidden-strip edge. It does not supply Hardy values by ignoring the completed-function factors. Gamma, conductor, root phase and any exponential scaling must still be enclosed, including their error multiplication. Exact real-valuedness of the selected Hardy normalization is an analytic theorem, not the fact that an imaginary interval contains zero. No sign or Turing saturation follows merely from (8).

Likewise this is not a full right-rectangle cover: the grid is one vertical column. Whole horizontal/vertical contour panels need their own coverage and strict half-plane checks. The Turing inequality D+2b_T/h<1 still depends on certified data. This extension removes an accidental evaluator-domain restriction; it changes neither the selected finite spectral height nor the final Goldbach assumptions.

## 7. Exact scalar witnesses and remaining work

The new script `finite_u_auxiliary_extension_20261111.py` uses only integers, Fractions and factorials. It checks the explicit search caps, all intervening EM ratio bounds, selected error tests, (8), and the critical-line grid geometry. No author evaluator is imported and no transcendental value is called. It first rounds each requested U upward to V as in Section 6.

| c | Requested U | p | M | N | K | P | Q |
|---:|---|---:|---:|---:|---:|---:|---:|
| 2 | 0 | 0 | 2 | 8 | 4 | 6 | 9 |
| 300000 | 330 | 68 | 19 | 372 | 32 | 29 | 55 |
| 300000 | 1330 | 68 | 19 | 1372 | 33 | 29 | 56 |
| 149999 | 50000000/149999+1000 | 68 | 19 | 1376 | 32 | 29 | 55 |
| 4 | 100000000 | 68 | 19 | 100000042 | 33 | 29 | 53 |
| 300000 | 1000000000000+1/3 | 128 | 36 | 1000000000077 | 63 | 46 | 99 |

The last four work-height products exceed 100000000. The witnesses show that the scalar construction genuinely leaves the old domain. They are not speed comparisons or proposed full array allocations. The low-height first row is a mathematical endpoint check and is outside the primitive spectral production need.

Final script SHA256 `021046F6556AD7B7E1B1558D2F262D207853CC8F5154E9DC87933CF30983642C`; receipt `finite_u_auxiliary_extension_20261111.json`, SHA `978D65992310A5F871F2104F5E88D0BC6F18D4F13F759EEADFDF71FB7A2A89EB`. The final scalar run exited 0. Earlier draft receipts were revised before freezing to include the common-grid and pole-moment checks. No previous task's frozen artifact was modified.

Remaining formal work is the same source adapter and its integral/continuation/Cauchy proofs, now with the variable bounds above, plus a verified finite arithmetic checker. Remaining production work includes every actual coefficient, correction, normalized transform, polynomial enclosure, sign/half-plane margin and complete spectral acceptance packet. The selected high-conductor profile, inclusive 10^27 threshold and original BinaryGoldbachInput remain unchanged.

## Source pins and reused proof scope

Paths in this table are relative to `work/qrh-campaign/agents/`, except the explicitly marked root path. Source target `23b2d68ca344203d4384e0aff7affa4ec034bef9`; Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`.

| Artifact | SHA256 |
|---|---|
| `major-constants/EM_SOURCE_PROOF_PLAN_2026-11-11.md` | `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485` |
| `zero-sum/FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md` | `17D6A2E7478E3C03D8B9406C01A5AD93D4277E33B09009B6550D02357DE54BEC` |
| `mellin/REVIEW_FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md` | `9E6004112BFBD8F565FBD2A6871B2E9C123751B5F35C9DEEFE631F7997EAAD64` |
| `major-constants/FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md` | `9D2AEE85DB76673ACE63D17057B1B2B3BEAEC925F9A38A9980171696FF4EC233` |
| `mellin/REVIEW_FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md` | `2D8AA8B58F64AC7DCF82887F6EECAF973F06EC0DD12EC68592F9DD243314C7CF` |
| `zero-sum/POLE_DIFFERENCE_JET_ENCLOSURE_PLAN_2026-11-11.md` | `3F73AF600725DDB51ED622577BF374251B38C408D0D52D4EA06CFCF1BDD60011` |
| `moebius/REVIEW_POLE_DIFFERENCE_JET_ENCLOSURE_2026-11-11.md` | `39D7D84D0706FE27A7DEF211684FA1DCA4D9E3544AB1A496AE435DDF4E04F577` |
| Root `work/qrh-blueprint/turing-scalars/AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md` | `45E848935AC76C8450550DFE02279C697514BF227B37EA6FD25221B3F7C37F47` |
| `zero-sum/REVIEW_AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md` | `5EB56E2F86C5CE05CCA3491C237FE66F4C0053F656AD1401211A47406833DA21` |

The EM source proof maps the general periodic-Bernoulli integral to actual Mathlib Hurwitz zeta on Re(s)>1, then continues through its holomorphic domain. Its Section 2 uses retained lengths 2m-1 and remainder 2M for arbitrary M, not only M=16. The required elementary sources include `HurwitzZeta.hasSum_hurwitzZeta_of_one_lt_re`, `differentiable_hurwitzZeta_sub_hurwitzZeta`, the Bernoulli derivative/Fourier bounds in `NumberTheory/ZetaValues.lean`, interval integration by parts, and the complex power improper integral. These were already inventoried in that source plan; there is no existing checked complex Hurwitz EM evaluator theorem being claimed here.

The actual `ZMod.LFunction` definition is in `NumberTheory/LSeries/ZMod.lean:85`, with `LFunction_eq_LSeries` at 95 and `differentiable_LFunction_of_sum_zero` at 133. Nonprincipal character entirety is `DirichletContinuation.lean:97`. The finite-U source bound and normalization are those of the reviewed character-height composition Sections 2-4. Its Sections 5-6 explicitly keep all correction and transform arithmetic. The pole-jet plan's general formulas (4), (7) and (8), together with its point-refinement qualification, apply to the Q rule above. Neither the earlier arbitrary-height FFT rule nor the fixed small rational-EM elementary allocation automatically certifies this new finite circuit.
