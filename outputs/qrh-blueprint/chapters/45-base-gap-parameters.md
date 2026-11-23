# Q=90090: a concrete Vaughan-parameter refinement for the smallest twists

Research only, 2026-11-10. Source pin: `calr3/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean/source implementation or compilation. The numerical model in `base_gap_90090_parameters.py` evaluates the **parameterized source inequalities**, not retuned coefficients of the final simplified bound. Numerical integrations are diagnostics, with no certified quadrature remainder or all-y comparison.

## Finding

A specific available refinement is

T=z^(1/3), q=90090, t=2q,
V_new=floor(72T),
U_new=floor(T²/(144sqrt(2q))).                         (P16)

This multiplies the first-choice V by16 and divides its U by16, keeping UV approximately z/(2sqrt(2q)). It is allowed by the existing parameterized lemmas in the small-twist range. It decreases the important logarithmic correction in the Type II main term; the leading Type I cost, proportional to UV, stays nearly fixed.

At y=1e25, replacing the central w interval[.05,2.5] by the full source inequalities at(P16), and retaining the old raw first-choice bound on[2.5,8], gives a diagnostic normalized etaStar bound of **.05705692840**. This is below the starting-scale consumer allowance around.06027 by about.00321. The same calculation at the original U,V gives.05940041185. Thus part of the improvement comes from using the full unsimplified source lemmas, and the parameter change gives a further reduction of about.00234348 in the integrated bound. The claim is not that changing U,V alone in the simplified formula proves the result.

The range singled out here is

1200000/49≤u:=|Delta|q≤26000,
y≥1e25,
2alpha=A/q+Delta/y modulo an integer.

It includes the smallest permitted gap twist and an interval beyond it. The parameterized proof hypotheses hold on the central w interval for every y≥1e25; the numerical crossing has only been evaluated at the starting scale. Proving the all-y crossing and certifying the integration remain bounded research/formalization tasks. The original Type I/II prime and Möbius producer obligations remain unchanged.

## 1. How much improvement is needed?

The best previous fine numerical integration of the raw first-choice envelope at the minimal twist was.06365269401, with tails cut at.001 and8. Against the approximate actual allowance.06027, the required gain is

.06365269401-.06027≈.00338269401,

or about5.3143% of that upper envelope. This measures slack in an upper bound, not the size of the actual exponential sum.

For a fair comparison with the new central interval, using the same[.05,8] range and the same trivial tails gives an old raw value.06435884605. Its slightly larger value is caused by the larger low-w tail bound. Every comparison below explicitly retains the common .05 cutoff and both tails.

At w=1,y=1e25, the old raw normalized bound is.05091352224. Its main pieces are

| piece | normalized value |
|---|---:|
| raw Type II square-root product | .04186837875 |
| Type I2 term2.5257/sqrt(2q) | .00595015766 |
| reciprocal-totient terms | .00038194444 |
| logarithm-over-t terms | .00245619428 |
|3.77z^(-1/6) remainder | .00025684711 |

The Type II main product contributes about82.2%. Eliminating the entire uniform power remainder would recover only a small fraction of the required gain. A useful change must reduce the Type II product or recover additional Type I simplification losses; it cannot just shave the3.77 constant.

## 2. Existing parameterized source APIs

All project paths in this note are relative to `TernaryGoldbach/`.

### Type I1

`MinorArcs/TypeITotal.lean:101`, `typeI1_le`, uses arbitrary real U with

- `Approx2 alpha z Delta_z A q H`;
- sqrt3≤U;
- U≤min(z/4,z/exp1);
- U≤H/2.

Its conclusion is the full four-part expression

z/(2q)*minInv(32,pi*Delta_z)*[(2q/phi(2q)+2.67)+log(z/U)*muBound(U,q)]
+z/(2q)*logFourierBound(Delta_z)*muBound(U,q)
+32*(1/2-2/pi²)*[U²/(4qz)*log(sqrt(e)*z/U)+1/e]
+bound_4_41(z,q,U).

Here `muBound`, `logFourierBound`, `bound_4_41` are exactly their source definitions (`TypeITotal.lean:24,29`, `TypeI.lean:177`). The model includes every term of `bound_4_41`, including both sqrt(z) log(z) errors. Since q=90090 is even, 2q/phi(2q)=q/phi(q)=1001/192.

### Type I2 in the small-twist range

`MinorArcs/TypeI2Sum.lean:300`, `typeI2_le_small`, uses arbitrary real U,V with

- the same `Approx2`;
- qV≤H,16V≤H;
- U≥1,V≥2.5e7,UV≤z;
- |Delta_z|≤1/(2c2), where c2=6pi/(5sqrt32).

Its conclusion is

z/(2q)*minInv(32,pi*Delta_z)*muBound(min(H/(2V),U),q)*log(Vq)
+32*(1/8-1/(2pi²))/z *
 [U²/q*(.511V²+Vq log q)+(2U+q)*.511V²]
+1.0064*coefUV(cPlus(z,U,V))*UV
+1.0064*coefQ(z,q,U,V,cPlus(z,U,V))*H.

`cPlus`, `coefUV`, and `coefQ` are the exact definitions at `TypeI2Sum.lean:173,176,181`. In particular `coefQ` is not suppressed. The coefficient1.0064 and the .511 weighted-moment constant retain their original analytic producer obligations.

### Type II

`MinorArcs/TypeIITotal.lean:331`, `typeII_637`, uses arbitrary natural U,V with

- |2alpha-A/q-k|≤1/(qH);
- z>0,U≥1,V≥2e6,V≤z/U;
-3.5z/U≤H;
-2exp(1)q≤V.

Let

lambda=log(z/(UV)),
Phi=log(2q)*log[log(z/(2qU))/log(V/(2q))],
Z=zeta3≤27,
K=2/pi²+Zsqrt(z/V)/U.

Its exact normalized bound is

sqrt[(lambda+Phi)(.60428lambda+.0924+8Zsqrt(z/V)/U)]/sqrt(2phi(q))
+4sqrt(Kq/(2phi(q)z))*
 [2sqrt(z/U)+sqrt(log(2q))*(2e sqrt(2q)+4sqrt((z/U)/log(z/(2qU))))]
+8*1.4262*sqrt(K*(1/2+1/U))/sqrt V.                    (II)

The model sets Z=27, the existing unconditional upper bound `FirstChoice.zeta3_le`; it does not use an approximate zeta value. Monotonicity in Z is immediate since all affected coefficients and terms are nonnegative. This theorem does not need |Delta_z|<8; the stronger small-twist condition is used for Type I2.

### Assembly

`MinorArcs/Assembly.lean:64`, `norm_S_le_parts`, is unconditional and applies to any natural U,V with z≥1 and V≤z/4:

|S_eta2(alpha,z)|≤|I1|+|I2|+|II|+3log z.

Natural U,V from(P16), cast to real in the Type I lemmas, fit this common decomposition. No cancellation between different decompositions is assumed.

## 3. Why the parameter change helps

Temporarily ignore the harmless integer floors and hold P=UV fixed. Then lambda=log(z/P) is fixed, while

Phi(V)=log(2q)*log[1+lambda/log(V/(2q))].

For V>2q and lambda>0 this decreases strictly as V increases. The Type II main term therefore improves through its first factor. The competing zeta correction is

8Zsqrt(z/V)/U=8Zsqrt(z)*sqrt(V)/P,

which increases as sqrt(V). At the starting scale this correction is small: it is about.00180555 at the original choice and.00722221 at(P16), compared with.60428lambda+.0924≈4.17. The gain in Phi dominates that increase.

At w=1 the relevant quantities are:

| choice | lambda | Phi | zeta correction8Zsqrt(z/V)/U |
|---|---:|---:|---:|
| original |6.744002996|7.012271607|.001805552|
| V times4,U divided4 |6.744002996|6.249183941|.003611104|
| V times16,U divided16 |6.744002996|5.638561925|.007222207|

The leading Type I2 term `coefUV*UV` stays almost fixed. Changes in `log(Vq)` and `log(z/U)` are divided by2q, and are small. The exact lower-order Type II terms are also evaluated rather than being frozen at3.2z^(-1/6).

This is a genuine change of Vaughan parameters permitted by the general lemmas. The specialized `typeI1_first`, `typeI2_first`, and `typeII_first` cannot be invoked unchanged at(P16); the argument must return to the three parameterized results above.

## 4. Full pointwise cost at the starting scale

The following rows use z=1e25 and Delta_z=1200000/(49q), include every term in the three source inequalities, and include integer floors in U,V (subject to floating representation in this exploratory model):

| V multiplier, inverse U multiplier | Type I1 | Type I2 | Type II main | Type II rest | total |
|---:|---:|---:|---:|---:|---:|
|1|.0001994318|.0054494736|.0407384092|.0001213468|.0465086613|
|4|.0002071257|.0054571587|.0396009408|.0000674150|.0453326402|
|16|.0002148196|.0054648439|.0386759395|.0000468534|.0444024564|
|64|.0002225135|.0054725291|.0379193289|.0000491789|.0436635503|

The missing3log z/z term is about1.73e-23 and is included in the model's total. The choice16 is a moderate explicit candidate with ample size margins; no claim of global optimality is made.

Even the first row is smaller than the old raw first-choice value.0509135222. A notable source of that difference is the bound in `FirstChoice.typeII_main_le`, which permits the zeta correction to be as large as.2355, while the actual general expression here gives.00180555. The specialized Type I1 logarithmic term is also much larger than its full `muBound` expression at this q. Thus preserving the full source formulas is worthwhile before tuning parameters.

## 5. Uniform verification of the theorem hypotheses on the targeted band

Consider y≥1e25, .05≤w≤2.5, z=wy, q=90090, u∈[1200000/49,26000], and Delta_z=w Delta. Then z≥5e23 and T=z^(1/3)>79000000, since79000000³<5e23. Set H=3T²/4 and use(P16).

The exact size restrictions have generous elementary margins:

- `U≤T²/(144sqrt(180180))<H/2`.
- `qV≤q*72T≤H`, since it is enough that96q≤T;96*90090=8648640<79000000.
- `16V≤1152T≤H` since T>79000000.
- `UV≤z/(2sqrt(180180))<z`, hence V≤z/U.
- V≥72T-1>2.5e7 and V≥2e q.
- V≤z/4 because72T≤T³/4 at these T.
- U≥T²/(144sqrt(180180))-1≥T²/61200-1, since sqrt(180180)<425. This exceeds(14/3)T for T≥79000000; hence3.5z/U≤3T²/4=H. It also gives U≥sqrt3.
- U≤z/4 and U≤z/e follow directly from U≤T² and T>79000000>e,4.

The rational approximation remains valid: `|Delta_z|q=wu≤65000`, whereas `(4/3)T>105333333`. It also has q≤H. Coprimality and the exact phase identity are inherited from the same reduced rational approximation.

Finally

|Delta_z|≤(2.5*26000)/90090=65000/90090≈.72150072,
1/(2c2)=5sqrt32/(12pi)≈.75026360.

The strict comparison can be proved with sqrt32≥5.65 and pi≤22/7; no numerical transcendental approximation is necessary. Therefore the small-twist Type I2 theorem applies everywhere in this rectangle. Both `minInv(32,pi Delta_z)` and `logFourierBound(Delta_z)` are on their constant branches there; their exact source values are1 and2-log4. In the numerical regime `muBound` is also1, but the model evaluates its full definition rather than silently imposing that claim for all y.

For w∈[2.5,8] switch back to the old first-choice decomposition pointwise. There is no requirement that U,V remain fixed throughout a Mellin integral: one integrates a bound on the same S_eta2 at each w. Here |wDelta|≤8*26000/90090<8, so t=2q throughout this upper interval, and all original approximation conditions still hold. On w<.05 or w>8 use the existing trivial17 bound. These three regions cover the full Mellin integral.

## 6. Integrated comparison using the actual smoothing measure

The smoothing weight is phi(w)=w²exp(-w²/2). The model uses composite Simpson integration with4000 panels separately on[.05,2.5] and[2.5,8], and adds the same analytic tail upper bound

17*.05³/3 +17*(8+1/8)exp(-32)≈.0007083333351.

The output is:

| parameter multiplier on central interval | central I1 | central I2 | central II main | central II rest | upper-w old raw | total including tails |
|---:|---:|---:|---:|---:|---:|---:|
|1|.0002255335|.0061468504|.0458497722|.0001306113|.0063393111|.0594004118|
|4|.0002342111|.0061555190|.0445840154|.0000722839|.0063393111|.0580936738|
|16|.0002428888|.0061641877|.0435524567|.0000497508|.0063393111|.0570569284|
|64|.0002515665|.0061728563|.0427062221|.0000515343|.0063393111|.0562298237|

The former raw bound with these same tails is.0643588461. The16-choice recovers about.00730192 of that bound. About.00495843 comes from full source formulas at the original parameters, and a further.00234348 comes from the actual parameter change. These improvements are not counted twice.

The numbers are diagnostic, not certified upper bounds: floating floors, logarithms, roots, and the quadrature remainder must all be enclosed. The agreement of4000 and8000-panel runs in the displayed digits is a consistency check, not a proof. The full model and results are saved as `base_gap_90090_parameters.py`, `base_gap_90090_parameters_results.json`, and `base_gap_90090_integrated_results.json`.

## 7. Next bounded certificate and unresolved conditions

The specific proposed next step is to certify(P16) only on the small-twist rectangle above, using source `typeI1_le`, `typeI2_le_small`, `typeII_637`, and `norm_S_le_parts`. Preserve all definitions of `muBound`, `coefUV`, `coefQ`, `bound_4_41`, zeta3, and kap1. The exact source analytic inputs are inherited; none is replaced by an assumed better constant.

A practical finite certificate can bracket U,V using their floor intervals on each w/y cell, split at the few min/max branches if necessary, and use the exact Gaussian bin masses already developed for the raw comparison. The wide margins in section5 make verifying the structural hypotheses inexpensive compared with estimating the logarithmic main term. For the unbounded y range, retain the formulas in lambda and log(V/(2q)); the Type II Phi decreases as y grows at fixed q,w and approximately fixed UV/z, while the floor and error terms shrink. That suggests an asymptotic comparison, but monotonicity of the complete expression relative to the decreasing ghat allowance is not yet proved and must not be assumed.

This route does not solve the entire q=90090 base-gap region. It addresses the explicit smallest-twist band u≤26000; other D cells belong to the existing raw/final classifier or the character-bound complement. It also does not discharge the prime/Möbius producer hypotheses carried by the source Type I/II lemmas. Those remain separate campaign obligations. The completed result here is the identification and full numerical costing of one source-permitted parameter change with sufficient apparent margin to close the starting-scale small-twist case.
