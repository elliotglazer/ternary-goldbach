# Five complete rational K0 point enclosures

2026-11-11. All five requested point calculations completed with exact rational interval arithmetic. Every main-sum term, correction term, floor decision, and final radius check is retained. No builtin zeta, HardyZ, Riemann-Siegel, Gamma, or floating elementary evaluator was used. These are externally computed candidate arithmetic certificates with paper soundness arguments, not Lean proofs, a sign chain, or a new zero conclusion.

## 1. Frozen inputs and outputs

Paths are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
| --- | --- |
| New script `prime-estimates/principal_k0_point_certificates_20261111.py` | `9A84F801745C8F9DD7CAD2F0E41F7633F8AFB850895C68845D4119E675543A22` |
| New receipt `prime-estimates/principal_k0_point_certificates_20261111.json` | `4FF92EBCE1BF9416215CEDB57680ABD2971441440FC0D052B6FC23BF48807385` |
| Interval design `prime-estimates/PRINCIPAL_K0_INTERVAL_EVALUATION_PLAN_2026-11-11.md` | `E3B6843DA11022ACBC0A7BBAFA5B8C125CF38B88127B69DCB3B8FF6EB90B157A` |
| Its independent review `independent-feasibility/REVIEW_PRINCIPAL_K0_INTERVAL_EVALUATION_PLAN_2026-11-11.md` | `D483173A41EACEAB527579BB92A9F2795FB93161BAFAB47C2E249D264FD01197` |
| Analytic assembly `independent-feasibility/PRINCIPAL_SIMPLE_PHASE_K0_PAPER_ASSEMBLY_2026-11-11.md` | `E14AC6ADC47771795B75142340962F9FEA95BC499049D7BBD0D4103B7019B6D6` |
| Its independent review `prime-estimates/REVIEW_PRINCIPAL_SIMPLE_PHASE_K0_PAPER_ASSEMBLY_2026-11-11.md` | `A39ED6F31EE45499080BD95357B453F065F0FFEEE78AFDC9B794775460A73633` |

The analytic assembly proves on paper that the actual Mathlib hardyZ differs from Khat by less than `.451*t^(-3/4)` for all real t>=1500. The interval design gives exact elementary checker semantics and proves witness-generation termination for rational point inputs. This script implements a bounded fixed-precision instance for these five points, not a generic completed implementation of that termination theorem.

## 2. Exact points and complete numerical results

Every finite decimal in the height column denotes the exact rational number with that decimal expansion. Let [L,U] be the exact Khat interval in the JSON, M=(L+U)/2, and R_H its recorded positive rational HardyZ radius. The following Khat display intervals were rounded outward from [L,U] using exact integer comparisons. The final column is an upward-rounded bound for R_H, not the exact radius stored in the receipt.

| Exact rational t | N | Outward rational interval containing Khat(t) | R_H is below |
| --- | ---: | --- | ---: |
| 1500 | 15 | [0.52093069122659037811, 0.52093069122659037812] | 0.001949977 |
| 2000 | 17 | [0.79089676082112030683, 0.79089676082112030684] | 0.001571540 |
| 1659.153620177110 | 16 | [9.63934100401330522099, 9.63934100401330522100] | 0.001807936 |
| 1608.495438637974 | 15 | [-1.41173604782589432121, -1.41173604782589432120] | 0.001850474 |
| 1608.495438637975 | 16 | [-1.41173356959108403239, -1.41173356959108403238] | 0.001850474 |

The rational interval `[M-R_H,M+R_H]` in each receipt encloses the actual hardyZ value by the analytic and arithmetic proofs explained below. The table alone is not a new sign-chain or zero-count claim.

The third height is the nearest decimal of denominator 10^12 to the midpoint of the certified interval for `(4225/8)*pi`. The exact irrational height `(4225/8)*pi` has a=65/4 and z=1/2, a removable point of the original coefficient quotient. The chosen rational height has certified `abs(z-1/2)<10^(-10)`. The complete nonsingular coefficient was evaluated there, rather than evaluating the quotient of two small cosines.

The last two heights are respectively a downward and upward decimal rounding, with denominator 10^12, of the certified interval for `512*pi`. They lie on opposite sides of the a=16 boundary. Their separation is exactly 10^(-12). The certified floors are 15 and 16. The Khat values differ by about 2.48*10^(-6), consistent with its floor-dependent definition; no continuity of Khat is assumed or tested. The analytic target hardyZ remains the continuous function from the source.

## 3. Elementary interval calculations

The script uses Python Fraction as exact signed rational arithmetic. Before storing ordinary operation results, it rounds both endpoints outward to denominator 2^128. For a proposed lower numerator m and upper numerator n, it verifies the rational inequalities `m/2^128<=raw_lower<=raw_upper<=n/2^128`. Signed floor and ceiling are used, including for negative endpoints. Rounding errors are therefore already present in every later interval.

The parameters were fixed before the evaluations:

* Machin pi uses even alternating partial sums of 24 terms at 1/5 and 8 terms at 1/239, each paired with the next partial sum for the upper bound. The negative coefficient in `16*atan(1/5)-4*atan(1/239)` reverses the second interval correctly.
* Logarithms use exact binary scaling to 1<=y<=2. For v=(y-1)/(y+1), 48 terms of `2*sum v^(2j+1)/(2j+1)` have the nonnegative tail bound `2*v^97/(97*(1-v^2))`. The sign of the integer coefficient of log(2) is handled by interval multiplication. A log of a nondegenerate interval uses its two rational endpoints and monotonicity.
* A square root uses an integer square root of `floor(q*2^256)`. The resulting dyadic pair is checked by nonnegative squared bounds. For an interval the lower endpoint supplies the lower root bound and the upper endpoint supplies the upper root bound. Perfect-square inputs remain sound; no exact-root recognition is needed.
* Cosine reduces the full argument interval by an integer multiple of the certified 2*pi interval. The chosen integer may come from a rational midpoint estimate, but acceptance requires the resulting entire interval to lie in [-4,4]. The rational midpoint polynomial has terms of degrees 0,2,...,46 and error `2*4^48/48!`. The reduced input radius is added by cosine's Lipschitz bound 1. The resulting interval may be intersected with [-1,1]. The pi uncertainty in the reduction is included.
* Sinc uses 16 terms `sum_(j<16) (-1)^j*c^(2j)/(2j+1)!` at the rational midpoint c of an interval in [-2,2]. Its error is `2*2^32/33!` plus half the input radius. This is the integrated exponential tail and the sinc Lipschitz estimate from the reviewed plan.

No implementation primitive needed for these five computations was replaced by an Arb value or an unproved decimal constant. Python's integer square root is checked by the explicit squared inequalities. The interval operations, series tails and interpretation as actual elementary functions still require Lean soundness proofs before these candidate certificates can be used by a formal theorem.

## 4. Floor and correction certificates

For each point, the pi interval [pL,pU] and candidate N satisfy the exact strict tests

`2*pU*N^2<t<2*pL*(N+1)^2`.

These tests certify the actual floor. The computed a interval is also checked to lie strictly inside (N,N+1). The script never uses a midpoint floor without these tests. It derives z using that fixed N.

The correction uses the exact reviewed identity

```
w=abs z,
A=(pi/2)*(w^2-1/4),   B=pi*(w-1/2),
F(z)=((w+1/2)/2)*sinc(A)/sinc(B).
```

Every computed sinc(B) interval has lower endpoint strictly greater than 1/2, checked as a rational comparison before division. The receipt retains w, A, B, both midpoint/tail/input-radius records, their output intervals, the prefactor, and F. It also retains sqrt(a), the integer sign `-(-1)^N`, and the resulting full correction interval. This covers the near-removable point without a heuristic threshold or a special value substituted at a nearby height.

## 5. All terms and final budgets

The receipt retains all 79 main-sum terms across the five points. Each record contains n, log(n), sqrt(n), the full theta-minus-t-log(n) interval, the cosine reduction integer and reduced interval, the polynomial-tail allowance, the cosine output, and the final term `2*cos(...)/sqrt(n)`. The per-point record also retains the theta log argument, its log interval, and thetahat. Thus an independent implementation can reconstruct the complete sum rather than compare only a final midpoint.

For each t define the rational allowance eta=19/(1000*t). Every full main or correction term has width less than eta/(N+1). The script adds them with outward rounding, then checks the final arithmetic radius r=(U-L)/2 satisfies r<=eta. This final check includes the rounding from every sum operation. It also directly checks the stronger consumer form by exact fourth powers:

`r^4*t^3 <= (19/1000)^4`.

All quantities are nonnegative, so this proves `r<=.019*t^(-3/4)`. The largest observed arithmetic radius is below `6.506*10^(-28)`, many orders below its allotted allowance. This small radius is evidence for these parameters and points only, not a general precision guarantee.

For the HardyZ radius, the script encloses `t^(3/4)` using two positive square roots of the exact rational t^3. If bL is the positive lower endpoint, it sets R_H to an upward dyadic rounding of `(47/100)/bL`. Independently of that construction it checks

`R_H>0` and `R_H^4*t^3 >= (47/100)^4`.

Thus R_H is a rational upper bound for `.47*t^(-3/4)`. The actual enclosure follows from

```
abs(hardyZ(t)-M)
 <= abs(hardyZ(t)-Khat(t)) + abs(Khat(t)-M)
 < (.451+.019)*t^(-3/4)
 = .47*t^(-3/4) <= R_H.
```

The stored `[M-R_H,M+R_H]` uses exact rational addition. No arithmetic error is left outside this inequality. Arbitrarily refining the Khat interval would not remove its analytic HardyZ remainder, and this task makes no claim that sign decisions will succeed for other points.

## 6. Reproduction and resource scope

Run the new script with ordinary Python to reproduce the candidate data. It writes only its adjacent new JSON receipt. Its finite run guards against exceeding 590 seconds of measured computation. This run exited zero; the tool reported 0.669 seconds for the process, and the script recorded 0.199 seconds of wall time from its initial setup marker. Its recorded CPU time was 0.1875 seconds for the main run after shared constant/cache preparation. These are external Python measurements, not predictions of Lean checking time. No live computation remains.

The receipt's resource fields naturally vary on replay. Exact mathematical fields, parameters, inputs, and interval endpoints are deterministic. The independent reviewer has the exact frozen heights and complete records for a separate higher-precision rational replay and an optional direct finite Euler-Maclaurin comparison with the actual function. Neither a numerical overlap nor a special-function oracle is an input to the certificate construction here.

The outstanding formal work is the generic interval checker, the elementary series/rounding soundness wrappers, the finite-expression bridge to Khat, and the separately reviewed analytic assembly. The arithmetic experiment has no missing numerical primitive for these five points. It does not close those Lean obligations or certify any finite zeta spectrum.
