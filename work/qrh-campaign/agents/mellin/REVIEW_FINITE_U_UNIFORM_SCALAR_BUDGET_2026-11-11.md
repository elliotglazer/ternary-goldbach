# Review of the uniform finite-U scalar budget

2026-11-11. **PASS for the stated outer, EM, Taylor and conditional arithmetic bounds.** One harmless strict-endpoint wording correction is recorded below. No final constant changes. This is a paper and exact-rational review, not a coefficient evaluation, numerical model, spectral certificate or Lean proof.

Frozen author inputs:

| File under major-constants | SHA256 |
|---|---|
| `FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md` | `9D2AEE85DB76673ACE63D17057B1B2B3BEAEC925F9A38A9980171696FF4EC233` |
| `finite_u_uniform_scalar_budget_20261111.py` | `25BF32F802D2FDD3B3042D44A1D3675863CC457896CA92AFDF8244715A476E5C` |
| `finite_u_uniform_scalar_budget_20261111.json` | `FAAE4C0DD298F161513AC4A15935CF75CA40E863A4BDBB66DB322404607D3303` |

I read the complete note and script, checked all three hashes, and independently reconstructed the scalar implications. My standard-library script `review_finite_u_scalar_20261111.py`, SHA `E6091D37456C2FDA4C3CA1A9143D59161EE868F5AE64853171109817354ED3A2`, passes 76 exact checks. Its saved receipt has SHA `D1EEA68B8F6C9F25830F4E359946DB1BBAD794FFDE5694089E094856EB82135B`. The author script was not executed, and no frozen file was changed.

## Domains, ceilings and the endpoint correction

The primary rule has 2<=c<=300000, T>=0, cT<=10^8, |Im(s0)|<=T, 111/200<=Re(s0)<=2, N=ceil(T)+36, M=16, K=30, R=1 and rho=1/16. Hence

`T+36<=N<T+37`, `N>=36`, and `Xmax=c(N+1)<10^8+38c<=111400000<2^27`.

On the closed outer disk, Re(s)>=-89/200>-1/2 and |s|<=T+3. On the target disk, Re(s)>=197/400 and |s|<=T+2+1/16<T+3. The full target disk is therefore covered even when its real part is below1/2. The absolute EM condition sigma+31>0 holds throughout that disk.

The note's phrase that every retained outer correction factor is "below T+33" needs to read **at most T+33**. At the allowed T=0, s0=2, outer point s=3, the last factor for m=16 is |s+30|=33. The required bound is nevertheless `|s+j|<=T+33<N`, so the ratio to B_a=N+a/c is strictly below1. The target remainder factors satisfy the claimed strict bound `<T+34<N`. This correction affects neither the outer estimate nor any remainder.

## Independent outer bound

I used the same entire residue U_a and its integral pole difference as the reviewed composition packet. Positive integer bases and Re(s)>=-1/2 give the head bound `vN*sqrt(Xmax)` and half-endpoint bound `(v/2)*sqrt(Xmax)`.

The correction identity is exactly

`c^(2m-1)*X_a^(1-s-2m)=X_a^(-s)/B_a^(2m-1)`.

The rising-factorial ratio is below1 in the primary rule. Thus a sharper bound than needed is `sum_m 4/6^(2m)=4/35` times `v*sqrt(Xmax)`. The author's common bound uses ratio<4 instead, giving the valid geometric sum4/5. With the half term this is13/10. That looser estimate also covers the optional comparison rule.

For P_a, the real integration interval is ordered because a>=1. The estimate d_a<1/N follows from log(1+x)<=x, with a=1 giving zero. Its integral representation then gives

`|P_a(s)|<Xmax^(3/2)/(cN)`.

Summing unit-character norms yields precisely the author's (O1), and v<=c gives (O2). Since Xmax<2^27, sqrt(Xmax)<2^14 and `1+23/(10N)<2`, the claimed2^42 bound on the complete finite entire L sum follows. My separate rational check bounds its bracket by `335395000/3<2^27`, which also suffices. This is an absolute per-character bound, with no cancellation assumption.

## Actual EM and Cauchy errors

The scaled Hurwitz EM remainder rewrites as

`(4/c)*X_a^(1-sigma)/(sigma+31) * |(s)_32|/(6B_a)^32`.

This verifies the factor1/c before summing v residues. The target rising-factorial ratio is below6^-32. Because sigma>=197/400 and X_a>1,

`X_a^(1-sigma)<=Xmax^(203/400)<2*sqrt(Xmax)`.

The last comparison uses Xmax<2^27 and 27*(3/400)<1. It remains valid when sigma>1; one must not instead assert monotonic increase in X_a for a negative exponent. After summation, v/c<=1 gives the exact rational cap

`E=25/47805430413243680925696<2^-70`.

The entire finite function, not the actual L-function, supplies the radius-one Cauchy bound. Its normalized coefficients already contain h!. For degree29, the full tail is at most

`Tay=2^42*(1/16)^30/(1-1/16)=1/283341988972178712821760<2^-77`.

The actual EM error is required on the target disk only. Outer-circle analyticity and bounds belong to the finite U expression; no improper-integral theorem is silently applied outside its stated domain. The nonprincipal source identity and its analytic continuation across1 remain the reviewed composition obligation.

If E and Tay are inserted independently in both coordinate directions, the resulting norm is bounded by sqrt(2)*(E+Tay), and sqrt(2)<3/2. The author's square-padded bound below2^-68 is valid. My exact check even gives `(3/2)*(E+Tay)<2^-69`; the stronger comparison is not needed to accept the frozen claims.

## Conditional finite arithmetic

The weighted main-sum bound is below `(8/5)*(cN)^(5/8)<2^18`; the eighth-power rational comparison verifies it. Therefore the accepted real-phase residual Taylor construction with p=32 contributes less than `2^18/32!<2^-99`. This presumes the certified bins and tensor identity, not an arbitrary transform implementation.

For each h,m, there are vL input entries. With epsilon=2^-79/(pvL), their summed error is2^-79/p. The normalized tensor circuit's epsilon output allowance becomes the same quantity after the vL scale. Summing p residual modes gives2^-78. Adding contraction2^-79, complete correction2^-77 and assembly2^-77 gives

`11*2^-79<2^-75`

per full normalized coefficient. Multiplying by the target powers and summing gives at most `(16/15)*2^-75`. The additional final polynomial allowance2^-75 still leaves all finite arithmetic below2^-70. These must be Euclidean radii; coordinate boxes need a prior conversion. All P_a jets and correction phases are included in the correction allowance, not omitted because the main sums were batched.

The full expression

`(3/2)*(E+Tay)+2^18/32!+2^-70<2^-68`

passes exact comparison. This is a sufficient contract for a future arithmetic packet. Neither the author nor this review supplies that packet, a precision meeting those allowances, or a nonvanishing margin larger than the final error.

## Separate smaller-N rule and counts

For M=32 and N=ceil((T+66)/3), N>=22. Outer correction factors are at most T+65<T+66, and target remainder factors are below T+66. Hence their ratio to B_a is below3, so the remainder ratio to6B_a is below1/2. The ceiling gives `Xmax<10^8/3+24c`, and both Xmax<2^26 and sqrt(Xmax)<6400 hold. The outer prefactor then gives2^40. I independently verified the claimed EM<2^-54, Taylor<2^-55 and analytic norm<2^-53. This option has its own accuracy and is not substituted into the primary allocation.

The primary counts960vN,960vL,32vL,960v time lines and30J character lines follow directly from K=30,p=32 and the accepted schedule. They omit no residue factor, but remain symbolic operation/storage counts. Corrections, exprel enclosures, elementary inputs and adaptive geometry cost additional work. My script verifies the five illustrative totients by integer factorization, independent of the author's residue enumeration; those examples are not the basis of the uniform proof.

## Analytic and source status

The accepted composition note is pinned at `17D6A2E7478E3C03D8B9406C01A5AD93D4277E33B09009B6550D02357DE54BEC`, with my prior source review `9E6004112BFBD8F565FBD2A6871B2E9C123751B5F35C9DEEFE631F7997EAAD64`. It records actual Mathlib `ZMod.LFunction`, entire Hurwitz differences, nonprincipal character cancellation, and transform conventions. The EM source plan is `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485`; its paper review is `5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1`.

My Bernoulli check constructs B_n/n! by the formal reciprocal of `sum z^j/(j+1)!`, rather than copying the author's binomial recurrence, and verifies every used even coefficient through64 against4/6^n. This is exact scalar support for the reviewed analytic formula, not an independent replacement for its formal proof.

The result closes the stated uniform scalar estimates with the endpoint correction above. Source-to-U continuation, finite P_a/jet evaluation, Cauchy assembly and arithmetic semantics still need formal proofs. Actual coefficient enclosures, successful panels, closed coverage and spectral nonvanishing remain unsupplied. No c1 principal or broader family conclusion follows from these scalar bounds alone.
