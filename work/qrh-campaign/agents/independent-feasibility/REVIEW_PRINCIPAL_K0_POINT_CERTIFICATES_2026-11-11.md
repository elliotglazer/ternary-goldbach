# Independent review of five complete K0 point calculations

2026-11-11. **PASS within the declared external arithmetic and paper-soundness scope.** I found no incorrect interval primitive, source-expression substitution, floor decision, or error allocation. Every one of the five points was independently evaluated, including all 79 main-sum terms. No subset of the retained points was substituted for the full check. No producer correction is requested.

This is not a Lean proof, an implemented trusted checker, a new sign chain, or a zero-count result. No builtin zeta, HardyZ, Gamma, Riemann–Siegel, indexed-zero, or zero-count function was used. No canonical/frozen file, dependency, or Lean resource setting was changed.

## Frozen inputs and new evidence

Paths below are relative to `work/qrh-campaign/agents/`.

| Producer artifact | SHA256 |
|---|---|
| `prime-estimates/PRINCIPAL_K0_POINT_CERTIFICATES_2026-11-11.md` | `309A465F31597E8B57C45D83F364E5132D3E96AE6490469C14E7013AB2398F9E` |
| `prime-estimates/principal_k0_point_certificates_20261111.py` | `9A84F801745C8F9DD7CAD2F0E41F7633F8AFB850895C68845D4119E675543A22` |
| Its same-stem JSON | `4FF92EBCE1BF9416215CEDB57680ABD2971441440FC0D052B6FC23BF48807385` |

The independent implementation is `independent-feasibility/review_k0_point_certificates_20261111.py`, SHA256 `97622AE1D4402C3BB73483C34438E493514570ED965C446A897419BEBE53BBCD`. Its JSON receipt has SHA256 `6E47B2F55AC7BC5DC897D294D32273031F8D1DA2982D3666F686466E64E824B9`.

The independent script imports no producer code. Its final run passed **556 interval-containment checks and 401 exact ledger/sign checks**. It also records a separate direct Euler–Maclaurin calculation at every point. In addition, I replayed the producer's complete `run()` function read-only; all deterministic fields matched the frozen JSON exactly after excluding the two timing fields in `resources`. The producer's file-writing main block was not called.

The analytic input is the assembled paper theorem at `independent-feasibility/PRINCIPAL_SIMPLE_PHASE_K0_PAPER_ASSEMBLY_2026-11-11.md`, pin `E14AC6ADC47771795B75142340962F9FEA95BC499049D7BBD0D4103B7019B6D6`, with independent review `A39ED6F31EE45499080BD95357B453F065F0FFEEE78AFDC9B794775460A73633`. The interval design is pinned at `E3B6843DA11022ACBC0A7BBAFA5B8C125CF38B88127B69DCB3B8FF6EB90B157A`, with my independent review `D483173A41EACEAB527579BB92A9F2795FB93161BAFAB47C2E249D264FD01197`. The present review checks that the actual computations instantiate those formulas; it does not upgrade their unimplemented soundness lemmas to Lean theorems.

## Exact inputs, branches, and source expression

The complete input list is fixed independently in the reviewer script. Each decimal is parsed as an exact rational, not as a binary float.

| Exact t | Certified N | Strict sign of all three final enclosures |
|---|---:|---:|
| 1500 | 15 | positive |
| 2000 | 17 | positive |
| 1659.153620177110 | 16 | positive |
| 1608.495438637974 | 15 | negative |
| 1608.495438637975 | 16 | negative |

The three enclosures in the last column are the producer K0-based HardyZ interval, the independent K0-based interval, and the independent EM/phase interval. These are five isolated sign checks; their ordering and signs do not constitute a sign-change chain or a count.

Both implementations certify the floor by `2*pU*N^2<t<2*pL*(N+1)^2`, using their own proved-by-formula Machin pi enclosures. They also enclose a=sqrt(t/(2*pi)) strictly inside (N,N+1). The two near-transition heights differ by exactly 10^(-12), and their floors are respectively 15 and 16. No midpoint floor is accepted without these tests. The small jump in Khat across this pair is allowed: no continuity of the truncated approximant is needed.

The entire main sum uses precisely n=1,...,N with term `2*cos(thetahat-t*log n)/sqrt n`. The phase is `thetahat=(t/2)*log(t/(2*pi))-t/2-pi/8+1/(48*t)`. The correction is `-(-1)^N*F(z)/sqrt(a)` with z=1-2*(a-N). There is no missing factor 2, extra phase correction, or second rescaling of the analytic remainder.

For the stable F formula both implementations compute w=abs(z), A=(pi/2)*(w^2-1/4), B=pi*(w-1/2), and

```
F(z)=((w+1/2)/2)*sinc(A)/sinc(B).
```

The third height is close to the removable point z=1/2, but is not substituted by that exact value. Its actual entire expression is evaluated. Every sinc denominator interval has lower endpoint greater than 1/2, and every sinc argument interval lies inside [-2,2]. Clipping the w interval to [0,1] is justified by the exact floor domain. The equality to the source F and its removable values is the algebraic/continuity proof already independently reviewed, not a numerical inference from overlap.

## Primitive and rounding audit

The producer's elementary operations use exact signed Fraction arithmetic and outward rounding to denominator 2^128. Each rounding checks the actual rational inclusion. Negative endpoint floors/ceilings are handled with signed integer arithmetic. Multiplication uses all four corners; squaring and absolute value explicitly handle intervals containing zero. Division requires a strictly positive denominator interval in every use here.

The integer-root construction checks nonnegative squares against the rational input. The outer two-root operation for t^(3/4) and the separate root for sqrt(a) are not conflated. Perfect-square input bounds remain valid even if an upper endpoint is deliberately one dyadic unit too large.

Machin's identity uses a lower even alternating sum and its next partial sum at 1/5 and 1/239, with correct reversal for the negative coefficient. The log computation scales positive rational endpoints by exact powers of two into [1,2]. Its 48-term atanh sum has the full positive geometric tail `2*v^97/(97*(1-v^2))`. Applying endpoint monotonicity to log(t/(2*pi)) is legitimate because its whole interval is positive. The special input log(1) gives zero, without a singular alpha substitution.

Cosine subtracts 2*k times the whole pi interval, so its reduction includes pi uncertainty. It then checks the full reduced interval is inside [-4,4]. The midpoint polynomial contains exactly the even degrees below 48. Its tail `2*4^48/48!` matches `Complex.exp_bound'` at degree 48; the ratio premise is 4/49<1/2. Adding the reduced input radius is justified by cosine's global Lipschitz constant 1. Intersecting the output with [-1,1] preserves containment.

Sinc includes precisely the 16 terms through degree 30. The tail is `2*2^32/33!`, not a sine error divided by a potentially zero argument. It follows by integrating the degree-32 exponential error. Half the input radius is the correct extra term from the global sinc Lipschitz constant 1/2. These formulas apply even when an argument interval crosses zero.

The fixed cache of logs and roots covers n=1,...,18; the largest actual N is 17. Thus it covers all consumed entries here. This is a bounded implementation, not a generic evaluator at all rational heights or requested accuracies. The producer report explicitly makes that distinction.

## Independent complete rational replay

The alternative evaluator uses a different finite-arithmetic construction:

* 320-bit outward dyadic rounding instead of 128 bits;
* Machin truncation counts 40 and 16 instead of 24 and 8;
* 64 log terms, evaluated with rounded polynomial operations, instead of the producer's 48-term exact rational sum;
* a degree-80 cosine exponential bound and interval polynomial evaluation, instead of midpoint degree 48 plus a Lipschitz radius;
* 32 sinc terms and interval polynomial evaluation, instead of the producer's 16 midpoint terms.

The independent polynomial degrees are fixed, not increased while assuming uncontrolled interval-width convergence. The high rounding precision accommodates the finite Horner amplification. Its arithmetic operations verify the same exact outward-inclusion conditions. No Arb operation occurs in this Khat calculation.

For every point, the script verifies that the independently sound, narrower intervals are contained in the recorded producer intervals for a, z, the phase, sqrt(a), w, A, B, both sinc values, F, the correction, and Khat. For **each of all 79 main terms**, it independently checks the log, root, argument, reduced argument using the recorded reduction integer, cosine output, and full term. It also checks the recorded midpoint, input radius and tail identities. The largest independent Khat width is below 8.395*10^(-54).

Containment by itself is not the soundness argument: the reviewer derives its own enclosures using the audited elementary formulas, and the producer's formulas are separately audited above. The containment checks then transfer those valid enclosures to the recorded boxes and test the complete instantiation. The additional exact producer replay confirms all its deterministic arithmetic records, not merely the final midpoint.

## Final arithmetic and analytic allowances

For each source row, the review recomputes M=(L+U)/2 and r=(U-L)/2 from the actual stored Khat endpoints. It checks eta=.019/t, 0<=r<=eta, and `r^4*t^3<=(.019)^4`. All factors are nonnegative, so this is exactly sufficient for r<=.019*t^(-3/4). The final width includes all summation roundings. The reported maximum producer arithmetic radius below 6.506*10^(-28) is consistent with the receipt.

The analytic theorem gives strict error .451*t^(-3/4), so the center M has total error strictly less than .47*t^(-3/4). The producer constructs its positive rational radius R_H by rounding up .47 divided by a positive lower bound for t^(3/4). The review independently checks the lower/upper fourth-power bounds and `R_H^4*t^3>=(.47)^4`. It also checks the final stored interval is exactly [M-R_H,M+R_H]. No unaccounted arithmetic allowance is left outside this radius.

The .47 factor here is derived from the new .451 paper assembly plus explicit arithmetic allocation. It is not imported from the old sharp-theta Gabcke pilot. The coarse normalized phase is sufficient, and no builtin Gamma value or assumed numerical theta branch is used.

## Separate direct EM check of actual HardyZ

As a diagnostic independent of the K0 expansion, I evaluated all five points with direct explicit Euler–Maclaurin at B=900, M=44 and 224-bit Arb arithmetic. The finite sum is over 1<=n<B, with the endpoint term B^(-s)/2, pole term B^(1-s)/(s-1), and corrections

```
(B_(2k)/(2k)!)*(s)_(2k-1)*B^(1-s-2k),      1<=k<=M.
```

Bernoulli coefficients are generated by exact rational inversion of `(exp(z)-1)/z`; no Bernoulli or zeta oracle is called. At s=1/2+i*t, the conservative periodic-Bernoulli remainder used in the previously reviewed direct-EM route is

```
E = 4*|(s)_(2M)|*B^(1/2-2M)/(6^(2M)*(2M-1/2)).
```

It follows from the bound `|B_(2M)(fractional part)|/(2M)! <=4/(2*pi)^(2M)`, pi>3, and integrating x^(-1/2-2M) from B to infinity. Here 2M-1/2>0, and s-1 is nonzero. The implementation inserts a Cartesian square of radius E, which contains the complex error disk. The largest E is below 1.547*10^(-38).

To recover actual HardyZ without Gamma evaluation, compute the elementary proxy P=Re(exp(i*thetahat)*zeta). The exact normalized-Gamma adapter proves `P=hardyZ(t)*cos(thetahat-theta)`. The accepted coarse phase gives delta=.26/t^2 and hence

```
1-delta^2/2 <= cos(thetahat-theta) <= 1.
```

The lower bound is positive at every input. Dividing the proxy interval by this positive cosine interval therefore encloses actual HardyZ. Only elementary Arb exp/log/sin/cos/root operations occur in this secondary diagnostic; its arithmetic library is external and unverified here. The resulting maximum actual-HardyZ interval width is below 4.300*10^(-14).

Every EM/phase interval is contained in both the producer HardyZ interval and the independent K0-based interval. The script checks strict signs for all three enclosures at all five points. These agreements corroborate the normalization and the floor-change handling, but are not used to prove the K0 remainder theorem or to replace the elementary rational soundness argument.

## Resource and completion scope

The final independent run recorded about 0.65 seconds internally. A preliminary t=1500 check and an earlier full run before adding the final report pin/sign assertions also completed; no new heights were introduced. Total computation was far below the ten-minute bound. No timing from these tiny instances is a forecast for a full chain, an optimized implementation, or kernel replay.

The bounded arithmetic experiment is complete and its reported enclosures are supported by the reviewed paper mathematics and full independent replay. Remaining formal work is the elementary checker and source-expression interpretation, the analytic assembly, and their Lean composition. Proving the five outputs in Lean would still not prove a zero count or close the remaining spectral range. No such completion is claimed here.
