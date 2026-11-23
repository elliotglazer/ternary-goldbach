# A fixed conductor-eight character and height pilot

2026-11-11. Paper specification only. No code, manifest, numerical coefficient, transform, function value or model was produced. This does not authorize a run. It proposes one small test of the accepted finite-U adapter, entire pole-difference jets and uniform scalar allocation. Acceptance would concern coefficient and model enclosures, not nonvanishing or spectral coverage.

Preflight revision: this version supersedes pending design SHA256 `06109CC07C361FEE7B2F73CB23968D6E3E7D682ACBC73B13E1D616D7AA9881F3`. It adds mandatory independent full-containment certificates and a per-order head residual bound. It replaces the proposed precision ladder by one fixed attempt with explicit total resource scope. No numerical attempt has occurred under either version.

## 1. Accepted inputs and fixed scope

All paths below are relative to `work/qrh-campaign/agents/`.

| Input | SHA256 |
| --- | --- |
| `zero-sum/FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md` | `17D6A2E7478E3C03D8B9406C01A5AD93D4277E33B09009B6550D02357DE54BEC` |
| Its `mellin/REVIEW_FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md` | `9E6004112BFBD8F565FBD2A6871B2E9C123751B5F35C9DEEFE631F7997EAAD64` |
| `zero-sum/POLE_DIFFERENCE_JET_ENCLOSURE_PLAN_2026-11-11.md` | `3F73AF600725DDB51ED622577BF374251B38C408D0D52D4EA06CFCF1BDD60011` |
| Its `moebius/REVIEW_POLE_DIFFERENCE_JET_ENCLOSURE_2026-11-11.md` | `39D7D84D0706FE27A7DEF211684FA1DCA4D9E3544AB1A496AE435DDF4E04F577` |
| `major-constants/FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md` | `9D2AEE85DB76673ACE63D17057B1B2B3BEAEC925F9A38A9980171696FF4EC233` |
| Its `mellin/REVIEW_FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md` | `2D8AA8B58F64AC7DCF82887F6EECAF973F06EC0DD12EC68592F9DD243314C7CF` |
| `integration/UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md` | `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866` |
| Its `audit/REVIEW_UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md` | `222346A598FB72100005E065A6BFA77DCDE91B8B8F9F068847BE9DCBA0FB558D` |

The scalar review's endpoint correction applies: outer correction factors are at most T+33, not always strictly below it. They remain strictly below N, so all final constants are unchanged.

Use exactly

```
c=8, v=4, T=1,
J=3, s_j=1+i*(1/8-j/8), j=0,1,2,
s_base=1+i/8, Delta=-1/8,
N=37, M=16, K=30, R=1, rho=1/16,
p=32 time-residual terms, L=16 time-transform length,
Q=32 pole-moment terms.
```

Thus K denotes length, with normalized jet orders 0 through 29. The exact center s_1=1 is mandatory. The grid has the fewest centers that include zero height and both signs. The negative Delta tests the signed-height indexing rather than only conjugating a positive-grid output. The full closed disks of radius 1/16 are the analytic model domains. Their vertical diameter segments have shared endpoints at heights 1/16 and -1/16, with outer endpoints 3/16 and -3/16. There is no proposed rectangle, winding or nonzero test.

The scalar rule applies because cT=8<=10^8 and Re(s_j)=1 lies in [111/200,2]. The chosen T bounds center heights, not every point in their outer disks; those disks are already included in the scalar theorem. No weaker parameter choice is substituted to obtain a numerical success.

## 2. Exact noncyclic labels and principal exclusion

Use the source unit coordinates

```
u(e,f)=(-1)^e*5^f mod 8,   (e,f) in C2 x C2,
index(e,f)=2e+f.
```

In this order the unit representatives are `(1,5,7,3)`. Define the actual character label r=(alpha,beta) by

```
chi_r(u(e,f))=(-1)^(alpha*e+beta*f),
chi_r(nonunit)=0.
```

The exact character table is

| Label | Values at 1,5,7,3 | Conductor | Parity | Pilot role |
| --- | --- | --- | --- | --- |
| (0,0) | +,+,+,+ | 1 | even | Principal row excluded from actual-L outputs |
| (0,1) | +,-,+,- | 8 | even | Primitive nonprincipal output |
| (1,0) | +,+,-,- | 4 | odd | Nonprincipal imprimitive output at level 8 |
| (1,1) | +,-,-,+ | 8 | odd | Primitive nonprincipal output |

All three nonprincipal labels are retained. The conductor-4 row is deliberately included as a test of the nonprincipal adapter beyond primitive rows. The primitive condition at level 8 is beta=1: the reduction kernel to units modulo 4 is {1,5}. Exact multiplication and kernel checks must identify these as the source characters, not just match a count. All rows are real and self-conjugate. This pilot therefore does not exercise genuinely complex character phases or a large CRT product.

The normalized positive group transform is the two-axis Walsh transform with total factor 1/4. It is not an additive DFT of length 8. An implementation may compute the principal transform row internally, but it must mark that value as a finite-array artifact, not as an enclosure of the actual principal L-function. In particular, common-pole cancellation is invalid for that row, and no actual value at s=1 is asserted for it. No Gauss factor, root phase or parity one-half occurs in this Hurwitz-based route.

## 3. Complete finite function and removable point

For a in `(1,5,7,3)`, let X_a=296+a, X_1=297, ell=log(297), and d_a=log(X_a/297). The endpoint bases in coordinate order are `(297,301,303,299)`. Define

```
U_a(s)=sum_(nu=0..36) (8nu+a)^(-s) + X_a^(-s)/2
       +sum_(m=1..16) b_m*8^(2m-1)*(s)_(2m-1)*X_a^(1-s-2m)
       +P_a(s),
b_m=B_(2m)/(2m)!,
P_a(s)=-(d_a/8)*297^(1-s)*exprel((1-s)d_a),
L_fin,r(s)=sum_a chi_r(a)*U_a(s).
```

Every base is positive. The 148 head bases are distinct integers between 1 and 295. All 16 Bernoulli corrections are mandatory. The factor 8^(2m-1), the normalized derivatives of the rising factorial, and the residue-dependent endpoint phases must remain in the model. Equivalently use `X_a^(-s)*(s)_(2m-1)/(37+a/8)^(2m-1)`; do not mix the two forms and drop a scale.

The actual nonprincipal L-function is compared with this finite entire expression by the reviewed EM identity and continuation. No additional 8^(-s), multiplication by s-1 or division by s-1 is allowed. At s=1, the P_a values and jets use the entire formula. Individual classical Hurwitz finite parts are not substituted for individual Mathlib totalized values. The common reference cancels only in the nonprincipal sum.

For every residue and center, retain all K normalized jets of the half endpoint, Bernoulli block and P_a. The rising factorial is an exact polynomial in the local variable; multiplication and truncation modulo z^30 must return exactly the retained coefficients. Higher-degree factors must not be shortened before contributions to retained degrees have been accounted for.

## 4. Actual time/character batching identity

For each head base n certify the real-log bin

```
x_n=L*Delta*log(n)/(2pi)=-log(n)/pi,
q_n=floor(midpoint(x_n)+1/2),
|x_n-q_n|<=5/8, k_n=q_n mod 16,
r_n=3*(Delta*log(n)-2pi*q_n/16),  y_j=j/3.
```

The full signed integer q_n and its certified residual are required. No unproved exact nearest-integer assertion is needed. For n=1 the exact log and residual are zero. The accepted bin lemma gives |r_n|<1 because L=16>=4J=12.

For each residue a, jet h and time-residual order m, form

```
A_(a,h,m,k)=sum_(nu:k_n=k)
 n^(-s_base)*(-log n)^h/h! *(-i*r_n)^m/m!,
0<=h<30, 0<=m<32, 0<=k<16.
```

Apply the positive normalized length-16 time transform and positive normalized C2 x C2 character transform. The retained head approximation is

```
Head_(r,h,j)=64*sum_(m<32)y_j^m
             (P_G P_16 A_(h,m))_(r,-j mod 16).        (B)
```

The requested time indices are exactly 0,15,14. The scale 64=4*16 is compulsory for these normalized transforms. In particular Delta<0 does not change the output label from -j to +j; its sign is already in q_n and r_n. At j=0 the contraction is exactly its m=0 term, with y_0^0=1. No Gaussian sampling scale is present.

The contraction parameters are the exact rationals 0,1/3,2/3. The latter two are not dyadic; either retain exact rational powers or enclose their arithmetic and charge it to the residual-contraction budget. An uncharged machine approximation is not the same finite map.

For a simple auditable first implementation, perform the group transform separately for every retained h,m,j after the time transforms, before contracting m. This uses more small group transforms than commuting contraction first, but directly realizes the per-mode error contract below. A changed schedule would require its own staged error allocation; this specification does not silently assume equivalence of rounded circuits.

## 5. Fixed Q32 pole jets and their separate arithmetic budget

Use the reviewed normalized formula

```
P_(a,h)(s)=-(d_a/8)*E*(-1)^h
   *sum_(k=0..h) ell^(h-k)*d_a^k/[(h-k)!k!] *phi_k(z),
E=297^(1-s), z=(1-s)d_a,
phi_k,Q(z)=sum_(m=0..31) z^m/[m!*(m+k+1)].
```

The z^m/m! array is shared across all k. At the exact rational center s=1, E=1 and phi_k(0)=1/(k+1) may be used exactly. For a=1 all P jets are exactly zero. Neither branch is selected by a numerical proximity test.

Here is a fixed analytic bound, with no function evaluation. Since

```
exp(6)>sum_(j=0..7)6^j/j!=2101/7>297,
ell<6, ell+1/37<7, W=2/37<1/16,
sum_(h>=0)7^h/h!=exp(7)<3^7<2^12,
```

the reviewed prefactor bound 9/2 gives, for every retained normalized P jet,

```
tail <= (9/2)*(Llog^h/h!)*W^32/[32!*33]
      < 2^15*2^-128 = 2^-113,  Llog<7.                (P)
```

This deliberately uses the parent T=1 bound rather than a new smaller-height estimate. At s=1 the moment tail is actually zero. The fixed Q32 bound does not certify any finite arithmetic.

Require complete finite arithmetic for each P jet to have Euclidean error at most 2^-85, including log input enclosures, z, E, all moments, the binomial convolution and its final prefactor. Adding (P) is then strictly below 2^-84. All centers are exact rational complex points, and requested budgets are positive rationals, so the reviewed effective-input condition holds. A fixed maximum precision can still fail; such failure must be reported, not repaired by an unrecorded parameter increase.

For each residue and jet, allocate at most 2^-84 to each of the half-endpoint block, the complete sum of 16 Bernoulli terms, the complete P block, and their final addition arithmetic. This gives a residue correction radius at most 2^-82. Contracting four residues against the exact signs contributes at most 2^-80. Allow another 2^-80 for that signed-sum arithmetic, giving a full character correction coefficient error at most 2^-79. This is smaller than the scalar allocation's 2^-77 allowance. The Bernoulli block allowance includes its term construction and its summation; it is not an allowance per term.

## 6. Complete coefficient and disk error ledger

Use the scalar allocation's moment and normalized two-axis circuit budget

```
epsilon=2^-79/(p*v*L)=2^-90.                           (A)
```

Every serialized moment-input center must enclose its exact moment within epsilon in Euclidean norm. Every required normalized circuit output must be within epsilon of the exact normalized transform of those serialized centers. This second statement includes twiddle and arithmetic errors, not the already-counted input uncertainty. Exact C2 roots are signs; length-16 roots need certified elementary enclosures. A library's opaque transform or special-function output is not accepted as a proof operation.

For containment slack, require the author's own certified error for each of those moment centers and circuit centers to be at most epsilon/4, then publish the canonical Euclidean ball of radius epsilon about that exact rational center. An independent checker must certify containment of its independently reconstructed enclosure in that published ball. Agreement of center approximations or overlap of two enclosures is insufficient. This stricter internal arithmetic requirement does not enlarge any error allowance in (A).

For each h,r,j, the 32-mode contraction of the input errors is at most 2^-79. The circuit errors after the factor 64 and the same contraction are at most 2^-79. Their sum is at most 2^-78. Allow 2^-79 for final residual contraction/scaling arithmetic, at most 2^-79 for the complete corrections from section 5, and 2^-77 for final coefficient assembly. The total per-coefficient finite arithmetic is at most 2^-76, hence strictly below the parent allowance 2^-75.

The analytic batching residual stays separate. The accepted weighted head bound gives

```
sum_(h<30)rho^h W_h <2^18,
weighted time-residual error <2^18/32!<2^-99.          (R)
```

This weighted error is uniform for each retained nonprincipal character and its target disk; it is not charged again inside the circuit-input error. To publish complete coefficient enclosures rather than only a weighted polynomial estimate, also use the following per-order bound. Every head base has log(n)<6, and Re(s_j)=1. Consequently

```
W_h=sum_(all 148 bases n) n^(-1)*(log n)^h/h!
   <148*exp(6)<148*3^6<2^17,
R_h=2^17/32!<2^-99.                                   (R_h)
```

The inequality for every h follows by bounding one nonnegative term of the exponential series by its sum. The final factorial inequality is the exact integer comparison 32!>2^116. No numerical exponential value is required. Thus the published final coefficient center has distance at most `2^-76+R_h<2^-75` from the exact normalized coefficient of L_fin,r. Publish a Euclidean ball of radius 2^-75 for each of the 270 normalized L_fin,r coefficients. These are not the 360 residue U_a coefficients. The P-moment analytic tail is already inside the complete correction budget; the main per-order residual is now inside these final coefficient balls.

The accepted uniform scalar results give actual-point EM error E<2^-70 and finite-function Taylor tail Tay<2^-77 on each full disk. The entire finite function has outer bound 2^42 on its radius-one disk. These are finite-U constants, not the principal zetaF constants.

The complete coefficient balls contribute less than `(16/15)*2^-75` to a radius-1/16 polynomial. Allow another 2^-75 for each final polynomial evaluation and serialization. If EM and Taylor disk errors are inserted by coordinate-square padding, explicitly charge the factor 3/2. A complete sufficient actual-L error is therefore

```
(3/2)*(E+Tay) + (16/15)*2^-75 + 2^-75 <2^-68.         (F)
```

Neither (R) nor (R_h) is added again in (F). Both are bounds on the same head approximation; the chosen coefficient certificate already includes (R_h). Likewise, no second P-moment tail is added after its correction block.

All stated arithmetic budgets are Euclidean norm budgets. Rectangular interval outputs must prove an appropriate norm conversion, for example by using their L1 radius. No coordinate radius may silently be reused as a Euclidean radius.

An accepted output is a rational complex polynomial of degree at most 29 plus the stated uniform actual-L error on each disk. The disks may contain zeros. Neither a positive margin nor pairwise interval overlap proves the analytic enclosure; the source identity and complete error ledger do that.

## 7. Mandatory independently checkable output packet

The future producer must serialize enough rational data for deterministic reconstruction, not only a PASS label or floating-point summaries.

1. Record the source/design hashes, exact parameters, unit coordinate table and all four character rows. Verify multiplication, parity, the conductor-4 reduction kernel, the primitive flags and explicit principal-output exclusion.
2. Record all 148 integer bases, certified log/phase enclosures, complete signed q_n, k_n and r_n bin witnesses. Record their mapping to residue coordinates. Prove every input-error bound in (A), including finite accumulation of the contributions to each moment bin. Independently rebuild every exact moment from the defining positive-base sum, using fresh elementary enclosures and the fixed certified q_n. Require the entire independent enclosure to lie in its published epsilon ball, including zero or unused slots.
3. Record the 61,440 complex moment centers or a lossless deterministic reconstruction from retained elementary input enclosures and exact formulas. Retain the elementary length-16 roots, transform normalization, time-index map and enough stage information for an independent circuit-error proof. Separately reconstruct every consumed normalized two-axis output by its direct finite DFT applied to the exact serialized rational moment centers, using independently enclosed roots. Its whole enclosure must lie in the published epsilon ball. This checks the exact-center transform error, not an error against already uncertain moment balls. Circuit-operation checks and these independent output checks are both required. A file hash alone is neither proof.
4. Retain all 12 residue/center correction packets, with their 30 normalized jets split into half-endpoint, complete Bernoulli block and P block. Include exact Bernoulli coefficients, rising-factorial construction, endpoint log/phase enclosures, Q32 moment data or lossless reconstruction, analytic tails and arithmetic radii. Preserve all 90 a=1 P zeros and the exact s=1 identities.
5. Record the 270 final normalized L_fin,r coefficient centers and canonical radius-2^-75 balls for the nine nonprincipal character/center models, with their complete error ledgers. Record the principal row as excluded, even if a finite transform artifact is retained for circuit replay. No principal L enclosure is emitted.
6. Independently reconstruct the unbatched finite-U jets at the same three centers from the finite positive-base sums and full corrections. Use direct character sign sums, without the time-bin transform, with a distinct arithmetic path and higher precision. Include all analytic moment errors of that independent reconstruction. Each complete independent coefficient enclosure must lie in the corresponding published radius-2^-75 ball. Overlap or matching digits does not meet this condition. A failed containment check gives no independent certification even if both enclosures could be valid.
7. Independently certify each entire actual-L disk tube, not just sampled points. If q_h and r_h are an independent direct finite-L coefficient center and Euclidean radius, C_h is the published center and a rational D_h bounds `|q_h-C_h|+r_h`, require both `D_h<=2^-75` for every h and

   `sum_(h<30)rho^h*D_h + E_ind + Tay_ind + e_eval <2^-68`.

   Here E_ind and Tay_ind are independently checked valid analytic norm bounds for the actual EM remainder and finite-U Taylor tail, and e_eval<=2^-75 covers any final polynomial evaluation or serialization. For the exact polynomial graph itself e_eval can be zero. The reviewed E and Tay are available as conservative analytic bounds after independently checking their domain and scalar premises. This coefficientwise inequality proves uniform containment of the actual function in the published polynomial tube on the full disk. An interval overlap at a finite set of points does not prove this statement.
8. Evaluate the accepted polynomials, not new center models, at the six vertical endpoints per character counted with multiplicity across the three segments. There are 18 endpoint records in total. Each published endpoint ball has radius 2^-68 and center equal to the serialized polynomial evaluation, whose arithmetic error is at most 2^-75. Independently reconstruct an actual-L enclosure there from the direct model and its proved error, and require full containment in that published ball. Shared endpoints use identical rational coordinates and the same actual character. In addition, record shared-endpoint overlap, real-character conjugation between the positive and negative centers, and imaginary-zero checks at s=1. These latter tests are auxiliary consistency checks and cannot replace any containment or operation proof.
9. Report every failed budget, timing and operation category. No nonzero, sign, winding, GRH or family-coverage status is allowed.

The independent direct reconstruction is limited to the same 12 residue/center packets and nine character/center models. It must not add conductors, heights, contours or a zero search. The eventual code and receipt format require a separate preflight before execution.

## 8. Literal size, proposed caps and acceptance boundary

The fixed padded counts for one complete batched generation are:

| Item | Count |
| --- | ---: |
| Head bases | 148 |
| Head contributions across K*p | 142,080 |
| Dense moment slots, v*K*p*L | 61,440 |
| Positive normalized length-16 time transforms, v*K*p | 3,840 |
| Positive normalized size-4 group transforms, K*p*J | 2,880 |
| Required per-mode tensor outputs, v*K*p*J | 11,520 |
| Residue/center correction packets | 12 |
| Bernoulli term-series packets, 12*M | 192 |
| Retained nonprincipal coefficient outputs, 3*J*K | 270 |
| Polynomial endpoint evaluations | 18 |

The count of 2,880 small group transforms follows the explicit per-mode schedule in section 4. It is not the smaller count obtained by commuting rounded contraction first. Arithmetic within each transform, elementary functions, correction jets, interval endpoints and precision refinements must be counted separately. Sparse zeros may reduce actual operations but do not change the target array identities. The exact s=1 and a=1 shortcuts may reduce moment work; report their use rather than implying that all 12 P packets require generic evaluation.

If a later run is authorized after separate code review, the producer is one frozen attempt at 192-bit arithmetic. There is no automatic precision escalation, restart or second generation. Its total deadline is 180 seconds measured from process launch through final output and status serialization, including imports, setup, elementary input construction, all moment/circuit/correction work and self-checks. An external supervisor must enforce that deadline; an internal timer alone is insufficient for an uninterruptible operation. Retained partial checkpoints count toward this one attempt. Any later retry requires a new explicitly authorized version.

The producer's memory budget is 512 MiB peak working set for the complete process tree, and its aggregate retained output budget is 64 MiB, including receipts and logs. No worker subprocess is needed or permitted by this design. The eventual preflight must bind the OS peak-working-set measurement and its supervisor to the actual process, with monitoring from launch through exit. Missing, invalid or incomplete telemetry is INCOMPLETE, as is any recorded overrun, even if a coefficient computation has finished. A supervisor stops work on a detected breach. Sampled monitoring is not a claim that transient overshoot was physically prevented; acceptance requires complete OS peak telemetry below the limit. Final receipt space must be reserved within the output budget. Streaming by h is permitted if reconstruction data remain complete.

The independent check is a separate frozen 256-bit attempt with a 300-second total launch-to-exit deadline, 512 MiB peak-working-set budget and 64 MiB retained-output budget, under the same fail-closed monitoring policy. It must check all required records, not sample them to fit the cap. It may use direct finite transforms and direct jets; it must not call the author's evaluation routine as its independent calculation. Missing proof, containment failure or a cap is INCOMPLETE or a specific diagnostic failure, never PASS. Producer time and independent time are reported separately. Both jobs still require future static review and explicit execution authorization. These stops are not evidence of feasibility or a performance forecast.

Budget failure, a cap, missing output data or incomplete arithmetic validation gives INCOMPLETE, with the partial data preserved. A contradictory exact identity or failed consistency check gives a distinct diagnostic failure. A future successful status should state only that all nine actual-L disk models satisfy the specified enclosure contract, conditional on the reviewed analytic adapters and a sound implementation of its elementary arithmetic. It must not state that those disks are zero-free.

No missing paper estimate is apparent for this fixed design. The new tasks would be implementation, static review, authorized execution and independent data validation. The principal batching packet remains a separate input pattern; its zetaF normalization and numerical coefficients are not imported here. The proposed test exercises a noncyclic group, signed time bins, all nonprincipal rows, the removable point and complete corrections. It does not establish full-family scaling, complex-character conditioning or any part of the remaining spectral coverage.
