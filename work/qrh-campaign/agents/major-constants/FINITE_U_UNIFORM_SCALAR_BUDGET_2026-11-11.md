# Uniform finite-U outer, Taylor and EM bounds

2026-11-11. This closes a paper-level scalar bound missing from the accepted character/height composition. It evaluates no function, Fourier transform, Taylor model or spectral panel. It supplies no nonvanishing margin, family certificate, Lean proof or runtime estimate. The selected strategy is unchanged.

## 1. Inputs and exact scope

The source adapter is `zero-sum/FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md`, SHA256 `17D6A2E7478E3C03D8B9406C01A5AD93D4277E33B09009B6550D02357DE54BEC`. Its independent review is `mellin/REVIEW_FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md`, SHA256 `9E6004112BFBD8F565FBD2A6871B2E9C123751B5F35C9DEEFE631F7997EAAD64`. Both were read in full. The underlying EM derivation is `EM_SOURCE_PROOF_PLAN_2026-11-11.md`, SHA256 `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485`, sections 2.1 through 2.3. Those sections prove the periodic-Bernoulli remainder with the actual retained indices. They remain unimplemented analytic lemmas.

Fix an integer conductor `2<=c<=300000`, a real height bound `T>=0` with `c*T<=100000000`, and a center `s0=sigma0+i*t0` satisfying

```
111/200 <= sigma0 <= 2,       |t0| <= T.
```

The rule applies in particular to all selected nonprincipal primitive conductors with `T<=Hcert(c)<=100000000/c`. It also holds for nonprincipal imprimitive characters modulo c, although that extension is not needed. Conductor one stays in its separate principal branch. Nothing here permits a principal character modulo c to use nonprincipal pole cancellation.

The primary parameters are

```
M=16, N=ceil(T)+36, outer radius R=1,
target radius rho=1/16, K=30 retained coefficients, orders 0,...,29.
```

The target is the full closed complex disk `|s-s0|<=rho`, not only a vertical segment. Its real part can be less than 1/2:

```
Re(s)>=111/200-1/16=197/400=:sigma_min.
```

All radius-one outer disks have real part at least `-89/200>-1/2`. Their points have `|s|<=T+3`, by `|s0|<=T+2`. Target-disk points also have `|s|<T+3`. Thus every factor of the length-32 remainder rising factorial has norm below `T+34<N`, and every factor of a retained correction of length at most 31 has norm below `T+33<N`. These bounds do not require T to be an integer.

## 2. Preserve the actual conductor scaling

Write `v=phi(c)`, use actual unit representatives `1<=a<c`, and put

```
B_a=N+a/c, X_a=cN+a=c*B_a,
X_1=cN+1, Xmax=c(N+1), d_a=log(X_a)-log(X_1).
```

The entire residue adapter is exactly

```
U_a(s)=sum_(nu=0..N-1)(c*nu+a)^(-s) + X_a^(-s)/2
       +sum_(m=1..M) b_m*c^(2m-1)*(s)_(2m-1)*X_a^(1-s-2m)
       +P_a(s),
b_m=B_(2m)/(2m)!,
P_a(s)=-(1/c)*integral_(log X_1)^(log X_a) exp((1-s)*u) du.
```

The nonprincipal finite entire function is `L_fin,chi=sum_a chi(a)*U_a`. There is no extra c^(-s), no multiplication by s-1, and no subsequent division by s-1. The source `ZMod.LFunction` is defined at pinned Mathlib `NumberTheory/LSeries/ZMod.lean:85`; its positive-base conversion is in `LFunction_eq_LSeries` at line 95, and zero-sum entirety at lines 124 and 133. I re-read those source statements. The version is `56a005855ea17e0b0958f73ec801ae140b0a1679`, source SHA256 `D756ABE5CB941F1210DC7DDDC90F68F120148BB6A45AC4E6C4282C3070FBC17D`.

For corrections, the exact algebra is

```
c^(2m-1)*X_a^(1-s-2m)=X_a^(-s)/B_a^(2m-1).
```

In particular the significant ratio is the rising-factorial size divided by B_a, not by X_a. For the EM remainder, the accepted formula becomes exactly

```
R_a(s) <= (4/c)*X_a^(1-sigma)/(sigma+2M-1)
                  * |(s)_(2M)|/(6*B_a)^(2M).       (E1)
```

This retains the factor 1/c before summing the v unit representatives. The nonprincipal cancellation removes the common pole symbolically. Summing individual reference-subtraction error boxes would unnecessarily change this bound. Source totalized Hurwitz values at s=1 are handled by continuation of the entire nonprincipal combination, as in the accepted adapter, not by substituting an individual finite part at 1.

## 3. An outer-circle bound for the entire finite function

All integer bases in the Nv head terms lie in `[1,cN)`. On the outer disk, every such term has norm at most `sqrt(Xmax)`. Hence the head contributes at most `v*N*sqrt(Xmax)`. The half term contributes at most `v*sqrt(Xmax)/2`.

The universal Bernoulli bound from the reviewed source proof is `|b_m|<=4/6^(2m)`. The sharper ratio here is below 1, but the following coarse bound also applies whenever the correction factor size divided by `N+1/c` is below 4:

```
sum_(m>=1) [4/6^(2m)]*4^(2m-1)
 =sum_(m>=1)(4/9)^m=4/5.
```

Therefore all corrections contribute less than `(4/5)*v*sqrt(Xmax)`. The exact scalar script also checks every finite Bernoulli coefficient used by the primary rule and the optional comparison by its rational recurrence.

For the pole difference, `0<=d_a<1/N`: use `log(1+x)<=x` with `x=(a-1)/(cN+1)`, treating a=1 separately. Since outer real parts are at least -1/2 and every base is at least 1, the integral representation gives

```
|P_a(s)| <= (d_a/c)*Xmax^(3/2) < Xmax^(3/2)/(c*N).
```

This is independent of height and remains regular at s=1. It is not an evaluation algorithm for the P_a jets.

Combining the four contributions yields the useful conductor-sensitive outer bound

```
|L_fin,chi(s)| < sqrt(Xmax)*[v*N+(13/10)*v+(v/(c*N))*Xmax].   (O1)
```

The unit character coefficients have norm one; no cancellation or average over characters was used. Since v<=c, N>=36 and cN<Xmax, (O1) is at most

```
Xmax^(3/2)*[1+23/(10*N)].                              (O2)
```

The ceiling inequalities give

```
cN <100000000+37c,
Xmax=c(N+1)<100000000+38c<=111400000<2^27,
sqrt(Xmax)<2^14.
```

Consequently `Xmax^(3/2)<2^41`, and the bracket in (O2) is below 2. Thus the uniform outer bound is

```
|L_fin,chi(s)|<2^42 on every closed radius-one outer disk.    (O)
```

## 4. Actual-point EM and finite-function Taylor errors

On the target disk, sigma>=197/400 and `sigma+31>0`. In (E1) the rising-factorial ratio is strictly below `6^-32`. For sigma<=1 the endpoint power is largest at Xmax; for sigma>1 it is largest at the smallest base. Instead of incorrectly applying the first statement throughout sigma<=2+rho, use the uniform bound

```
X_a^(1-sigma) <= Xmax^(203/400)
              =sqrt(Xmax)*Xmax^(3/400)<2*sqrt(Xmax).
```

The last strict inequality follows from `Xmax<2^27` and `27*3/400<1`. It applies to all target real parts, including sigma>1. Summing (E1) therefore gives

```
|L_chi(s)-L_fin,chi(s)|
 < [8*(v/c)*sqrt(Xmax)/(31+197/400)]*6^-32
 < [8*2^14/(31+197/400)]*6^-32 <2^-70.                 (E)
```

The factor v/c is present in the first line and only then bounded by 1. No large v loss is hidden in the final constant. On a target set with sigma>=1/2 one can replace the factor 8 by 4 and the denominator by 63/2, but the primary result uses the full disk version (E).

Take the exact normalized coefficients `a_h=L_fin,chi^(h)(s0)/h!`. Entirety and (O) imply the ordinary Cauchy bound on the unit circle. For the first K=30 coefficients,

```
|L_fin,chi(s0+z)-sum_(h<30)a_h*z^h|
 <=2^42*(1/16)^30/(1-1/16)<2^-77.                     (T)
```

There is no factorial missing here: a_h already includes h!. The EM identity is used only on the target disk, while (O) is solely a finite-function bound. Adding (E) and (T) gives a uniform complex norm error below `2^-69`. If both analytic errors are inserted as coordinate-square padding, their aggregate norm is bounded by `(3/2)*(E+T)<2^-68`. The square conversion is explicitly charged.

## 5. Conditional completion of a finite batching implementation

The analytic result above does not assert numerical coefficient accuracy. For clarity, one complete sufficient finite-arithmetic allocation can be stated separately. The accepted weighted main-sum bound, valid for sigma0>=111/200 and rho<=1/8, gives

```
sum_(h<K)rho^h W_h < (8/5)*(cN)^(5/8)<2^18.
```

The last inequality follows by raising to the eighth power and using cN<2^27; the scalar script checks it exactly. Thus residual length p=32 incurs a polynomial norm error below `2^18/32!<2^-99`, with the reviewed real-phase remainder and no extra exponential factor. This applies to any certified signed time grid with L>=4J and the accepted bin witnesses. It is not an error allowance for an arbitrary unverified transform.

One explicit implementation contract is as follows. For each moment input and each normalized two-axis circuit output, require Euclidean error at most

```
epsilon=2^-79/(p*v*L).
```

The circuit-output error is measured against the exact normalized transform of the serialized centers. The accepted tensor formula gives at most `2^-78` after summing the p modes and multiplying by vL. Allow residual contraction arithmetic `2^-79`, complete character-summed correction coefficient arithmetic `2^-77`, and final coefficient assembly arithmetic `2^-77`. These include every P_a jet, half term, Bernoulli correction, conductor phase and character-transform error, not just the main sums. The total finite arithmetic per full coefficient is then below `2^-75`. The batching analytic tail is kept separate.

On any target complex disk, the coefficient arithmetic contributes below `(16/15)*2^-75` by the norm triangle inequality. A further final polynomial/serialization allowance `2^-75` leaves the total finite arithmetic below `2^-70`. Coordinate-box implementations must first convert their stated errors to these Euclidean budgets. This is a sufficient acceptance specification, not evidence that a given precision meets it. Any fixed-run limits remain binding.

With those finite contracts proved, the complete actual-L error is bounded by

```
(3/2)*(E+T) + 2^18/32! + 2^-70 <2^-68.                (F)
```

There is no s-1 quotient. The numerical correction enclosures and all finite arithmetic traces remain open obligations. In particular this note does not prove the new P_a jet evaluator, import a numerical library as a proof operation, or assert a spectral margin of size 2^-68.

## 6. Separate smaller-N comparison

The same proof also permits the independently suggested rule

```
M=32, N=ceil((T+66)/3), K=24, R=1, rho=1/16.
```

This is not the primary parameter choice. Now N>=22, the factor size is below `A=T+66`, and `A/(N+1/c)<3<4`. One has

```
Xmax<100000000/3+24c<=100000000/3+7200000<2^26,
sqrt(Xmax)<6400.
```

The outer argument gives `|L_fin|<2^40`. The full target-disk EM bound is

```
[8*6400/(63+197/400)]*2^-64 <2^-54.
```

The 24-coefficient Taylor tail is at most `2^40*(1/16)^24/(1-1/16)<2^-55`, so the analytic norm error is below `2^-53`. The factor-two full-disk endpoint-power allowance is retained. These are exact scalar comparisons, not a claim that the lower main-sum length is computationally preferable once correction, arithmetic, or conditioning costs are included.

## 7. Counts and proof boundary

For the primary rule, each residue has N head terms and 16 Bernoulli terms. A complete character transform uses all v residues, even if only primitive outputs are retained. At a height grid of J centers, retained degree count K=30 and p=32, the literal moment contribution count is `960*v*N`, dense tensor storage is `960*v*L` complex slots, and h-streamed moment storage is `32*v*L`. Time-first requires `960*v` length-L transforms and `30*J` unit-group transforms. The correction/exprel work remains additional as in the accepted adapter. These counts are symbolic; they omit precision, elementary enclosure, proof-record and adaptive-geometry costs.

The bounded arithmetic script `finite_u_uniform_scalar_budget_20261111.py` writes a JSON receipt. Its checks use only exact integers, Fractions, factorials and a finite Bernoulli recurrence. Five sample conductors illustrate the exact N and vN formulas at T=10^8/c; they are not a spectral scan. The parameter proof above is uniform and does not rely on those five examples. No conductors or character outputs are omitted from the mathematical scope.

Remaining formal work includes the source U/EM identity and continuation, entire P_a and its coefficient enclosures, Cauchy assembly, and finite transform arithmetic. Remaining numerical work includes every actual coefficient packet and all successful closed panels. The new result is the explicit uniform bound (O), the full-disk error (E), and their Taylor composition, conditional only on the previously stated mathematical function definitions and domain inequalities.
