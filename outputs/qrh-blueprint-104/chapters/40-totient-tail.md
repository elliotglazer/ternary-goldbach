# Replacing the downstream GBound totient input with a monotone envelope

Research proof, 2026-11-10. No Lean compilation. The companion diagnostic is `global_totient_tail_check.ps1`. This is a paper replacement for the sharp global totient input in the off-larger-arcs argument. It assumes the existing Type I/II theorem with its current constants and a proved finite totient bound through q<=2^1000. The Type I/II theorem's remaining Platt-dependent inputs must still be replaced separately. The base-gap theorem is also a separate input.

Scope correction after the upstream dependency review: the assumed Type I/II theorem itself uses the global totient bound in `FirstChoiceTypeII`, `SecondTypeIIa`, `SecondTypeIIb`, `SecondTypeI1`, and `SecondBridge`. This note replaces only its downstream use in GBound. It does not yet remove the global totient dependency from the full pointwise theorem. `TYPEII_TOTIENT.md` proves a paper repair for the first-choice use and identifies the unresolved second-choice uses. The 1e-60 calculation remains conditional on the stated pointwise theorem and does not include an unproved additional second-choice error.

## Result

Let T=2^1000, let g(y,r) and ghat(y,r) be the existing algebraic functions, and define

    H(r)=132 log^2(2 max(r,T))/(2 max(r,T))^(1/4),
    g_new(y,r)=g(y,r)+H(r),
    ghat_new(y,n)=ghat(y,n)+1.398 H(n).

Then the off-larger-arcs pointwise proof works with ghat_new using only the finite exact totient bound for q<=T and the elementary inequality q/phi(q)<=sqrt(2q) for larger q. H is nonnegative and nonincreasing. The sum g_new satisfies the same scale comparison used in the source convolution proof.

For all x>=4.9e26, retain the source's r2 choices: the existing finite-cell choices through x=4.9e101, and r2=floor((x/49)^(1/4)) thereafter. Replacing ghat by ghat_new in the exact `Mexpr` definition increases it by less than

    185*2^(-250)*(7*701^3+61*701^2+96*701+384)
      < 1e-60.

This includes the initial level, every discrete middle level, and the terminal contribution. The source final bound 1.0376 still follows whenever its old or recomputed algebraic numerical certificate gives Mexpr<=1.037. No recomputation of cell entries is necessary for this additive estimate; the proof consuming the cells must admit the explicitly bounded addition.

## Source interfaces

The relevant files under `work/ternary-goldbach/TernaryGoldbach/MinorArcs` are:

* `PointwiseBound.lean`, `theorem_3_1_1`, for the first and second pointwise branches.
* `GBound.lean`, `norm_S_eta2_le_gx`, for exactly where q/phi(q) enters.
* `Prop1123b.lean`, `norm_S_eta2_le_of_not_mem`, for the fresh approximation at every scale wy.
* `LinftyLevels.lean`, `gx_scale_le`, `hfun_scale_le`, and `norm_S_etaStar_le_of_pointwise_Ici`, for the convolution.
* `Thm1321.lean`, `thm_13_2_1_repaired`, whose g input can be any nonincreasing function satisfying the pointwise bounds.
* `MinorTotal.lean`, `Mexpr` and the concluding inequality with t=5e-4.
* `NumericsFinal.lean` and `NumericsAsymp.lean`, for the finite-cell range and r2=floor(y^(1/4)), with r2>=y^(1/4)/2 in the unbounded range.

The finite totient premise is described in `GLOBAL_TOTIENT_ROUTE.md`: the existing `SmallMertensProd` kernel, the elementary exchange lemma, and a small primorial cutoff certificate give

    1<=q<=T, r>=max(3,q) ==> q/phi(q)<Fr(r).

The elementary global alternative follows by multiplying p/(p-1)<=sqrt(p) over odd prime divisors. The possible prime 2 costs one additional factor sqrt2, and rad(q)<=q.

## First-branch pointwise bound for large q

At scale z let r=max(1,|Delta|/8)q and t=2r. The first-branch domain gives q<=r and t<=z^(1/3)/3. For q>T use

    q/phi(q)<=sqrt(2q)<=sqrt(t).

In the definition of the source function R(z,t), the denominator logarithm has argument at least 27/2.004>exp(2). Since t>=2T, log(t)>=1 and log(4t)<=2log(t). Therefore

    R(z,t)
      <=.27125*log(4t)/4+.41415
      <=.135625*log(t)+.41415
      <=log(t).

Here log(1+u)<=u was applied with u>=0. Dividing the first branch of the pointwise theorem by z and writing L=log(t), its terms other than 3.8 z^(-1/6) are at most

    (L^2+.8764)t^(-1/4)
      +(6.5L+18.166)t^(-1/2)
      +(27.32L+75.1)t^(-1).

Since L>=1 and t>=1, this is bounded by

    (2+25.5+103.32)L^2 t^(-1/4)
      <132 L^2 t^(-1/4)=H(r).

The algebraic source g(z,r) is nonnegative term by term in this domain and contains 3.8 z^(-1/6). Consequently

    |S_eta2(alpha,z)|/z <=g(z,r)+H(r).

For q<=T the finite exact totient theorem gives the stronger existing bound by g(z,r). Thus the displayed new bound holds for every first-branch denominator. This argument uses no uniform upper bound on q_w selected at varying convolution scales.

## Monotonicity and scale comparison

For r>=T, the derivative of log^2(2r)/(2r)^(1/4) has the sign of

    log(2r)*(2-log(2r)/4),

which is negative because log(2T)>8. For r<T, H is constant, and the two definitions agree at T. Hence H is nonincreasing everywhere on r>0. Adding it to the source's g preserves the source's antitonicity on [670,z^(1/3)/6]. There is no upward jump at T.

The function rH(r) is increasing. Below T it is linear with nonnegative slope; above T its derivative has the sign of

    (3/4)log^2(2r)+2log(2r)>0.

It follows that for 0<w<=1,

    H(wn)<=H(n)/w.

For w>=1, H(n) is unchanged. Combining this with the existing algebraic `gx_scale_le` proves

    g_new(wy,min(1,w)n)
      <=[g(y,n)+H(n)] max(1,1/w).

## Convolution and all scale tails

Retain w0=670/n and the source conditions

    y>=1e25, 670<=n<=y^(1/3)/6, 2.16e20*n<=670*y.

For w>=w0 the source chooses a fresh Dirichlet approximation to 2alpha. Outside M(8,n,y), its effective radius r_w satisfies

    min(1,w)n<=r_w.

If its denominator is in the first branch, use the preceding bound and monotonicity. If it is in the second branch, retain hfun(wy) and its existing scale inequality. Since

    max(g(y,n)+H(n),hfun(y))
      <=max(g(y,n),hfun(y))+H(n),

the resulting pointwise coefficient is the source's coefficient plus H(n)max(1,1/w).

The source proves

    integral_w0^infinity max(1,1/w) phi(w) dw <=1.398,
    17 integral_0^w0 phi(w)dw <=17*(670/n)^3/3.

Here phi(w)=w^2 exp(-w^2/2). Thus the convolution coefficient increases by at most 1.398H(n), with exactly the same small-w tail as before. There is no omitted large-w cutoff or tail; the integral goes to infinity. This is also why the addition is retained even for finite cells: at enormous w, a fresh approximation could have a denominator above T even when the level n is small.

## Exact extra layer contribution

Put r0=150000, a=1.398, s=sig(x)/Dx(x), and m=r2. Linearity of the source `Mexpr` gives the exact difference

    DeltaM/a = H(r0)*(cL(r0)*s-8.6294)
      +s*sum_(r0<n<m) H(n)*log((n+1)/n)
      +H(m)*(sig(x)-cL(m-1)*s).

The source and proposed relaxed energy coefficient .65 both satisfy the generous bounds

    0<=sig(x)<=log x,     0<=s<=3,     cL(r0)<15.

For the ratio bound use `Dx=.5 log x-log14+1.33258` and log x>60. Then Dx>log x/3. The sig bound follows immediately from its displayed source formula, and also holds if .640208 is replaced by .65.

Dropping the negative initial subtraction and bounding the terminal coefficient by sig gives

    DeltaM/a <=45 H(r0)
      +3*sum_(r0<n<m) H(n)*log((n+1)/n)
      +H(m)*log x.

All replacements have the correct sign, even if the original initial coefficient happened to be negative.

### The discrete middle sum

Since H(t)/t is nonincreasing and log(1+1/n)<=1/n,

    sum_(r0<n<m) H(n)*log((n+1)/n)
      <=integral_r0^infinity H(t)dt/t.

Let L=log(2T) and C=132*(2T)^(-1/4). The plateau has height H(r0)=C L^2. Direct integration yields

    integral_r0^infinity H(t)dt/t
      =C*[L^2*log(T/r0)+4L^2+32L+128]
      <=C*[L^3+4L^2+32L+128].

This bounds the discrete sum including the crossing of T. No unsummed endpoint is discarded.

### The terminal term

For x<=4.9e101, log x<235 and H(m)<=C L^2. Since 235<4L+4, this gives

    H(m)*log x <=C L^2*(4L+4).

For x>=4.9e101, the source uses m=floor(y^(1/4)) and proves m>=y^(1/4)/2. Therefore

    log x=log49+log y <4+4log(2m).

If m<=T, H(m)=C L^2 and log(2m)<=L. If m>=T, the function

    H(m)*(4log(2m)+4)

is decreasing: after setting u=log(2m), the derivative has the sign of `-u^3+11u^2+8u`, which is negative for u>=12. Both cases give the same terminal bound `C L^2*(4L+4)`.

This step is essential. A fixed bound H(m)<=H(T) alone would leave an unbounded log x factor and would not prove a global result.

### Total

Combining the preceding inequalities gives

    DeltaM <=1.398*C*[7L^3+61L^2+96L+384].

Use log2<.7 to obtain L=1001log2<701, use (2T)^(-1/4)<2^(-250), and use 1.398*132<185. Hence

    DeltaM <185*2^(-250)*2441347848 <1e-60.

The last inequality is checked by exact integer arithmetic in the companion script. The floating-point diagnostic is approximately 2.497e-64, but the proof uses only the much looser exact 1e-60 comparison.

## Numerical consequences and scope

The existing algebraic ghat function remains unchanged. Its cell evaluations and its asymptotic numerical estimate are therefore still evaluations of exactly the same expression. The new analytic theorem bounds the actual sum by that expression plus 1.398H. It is necessary to change the consuming inequality from Mexpr<=1.037 to Mexpr_new<=1.037+1e-60, or simply <=1.037001.

With the source t=5e-4, even the latter larger bound satisfies the exact inequality

    (1+5e-4)*1.037001
      +(1+1/(5e-4))*22.75*8e-11 <1.0376.

Thus the same final minor-arc constant survives. This calculation does not assert that a pending .65 numerical replay is already formalized; it says that any replay proving the same Mexpr<=1.037 has more than enough room for this additional error.

All finite cells receive a bounded plateau correction. The envelope begins decreasing only for n>T, which with m=floor(y^(1/4)) occurs in the range y roughly above T^4=2^4000. There is no gap between finite and unbounded x ranges. No change to major arcs, major averages, or base-gap geometry is required.

The remaining proof tasks are finite-totient extraction, translation of H's elementary calculus and scaling lemmas, adaptation of the fresh-approximation pointwise proof, and the final additive numerical estimate. All displayed bounds are paper deductions with an accompanying diagnostic; they have not been compiled in Lean. The independent review is requested separately.
