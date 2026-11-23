# What changes between the small rational panel and production heights

2026-11-11. Research-only dependency check. No node or theta value, production grid, or spectral scan was computed. The few integer and rational comparisons below concern existing error formulas. They supply no runtime estimate and no lower bound for every possible evaluator.

Inputs read in full:

* `prime-estimates/NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md`, SHA256 `92E778B5D9C767D18461CD0B239F94FD38B15023B13576FFBBC2EFFE8D00E957`.
* `mellin/PRINCIPAL_NODE_TO_CONTOUR_FRONTIER_2026-11-11.md`, SHA256 `F5E5CE83EC1DD110CFBC9CF75B845C63BE2EAFF0D269297FBA2934D92998CDAD`.
* `integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md`, SHA256 `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571`, and the corrected Fourier envelope it cites, SHA256 `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`.

The small pilot has fixed `b=pi/4-1/33`, quadrature strip width `r=1/66`, `h=1/256`, `V=29/8`, `K=928`, degree 6, disk radius `rho=1/64`, and work height 14. Its scalar budget is an absolute error budget for that normalized function and disk. Repeating its arithmetic at another height does not preserve that budget.

## Dependency table

| Component | Keeping the pilot's fixed tilt | Retuning to the reviewed height-dependent tilt |
|---|---|---|
| Exact normalization | The same `F_b` remains well defined at every height. | Set `U=T+1`, `b=pi/4-1/U`; all old node values have the wrong exact argument unless they were produced for this same b. |
| Strip and Gaussian envelope | `r,kappa,A,M,D,q` remain fixed. | `r=kappa=1/(2U)`, `q=3/(4U)`; A, M, D grow with U. |
| Infinite trapezoid error | `Q0=2M exp(Tr)/(exp(2*pi*r/h)-1)` grows with T at fixed h. | `Tr<1/2`, but smaller r and larger M require a new h/error allocation. Positive coefficient orders use D, not M. |
| Spatial cutoff | The old spatial estimate is unchanged if V is unchanged. | The required derivative condition `q exp(2V)>=2` fails at the old V; choose a larger cutoff and verify the full S bound. |
| Cauchy remainder | D and the degree-6 remainder stay fixed. | D grows as U^5 in these envelopes. Degree or disk radius must change. |
| Reduced theta seed tail | The accepted `Im(v)>=2/5` theorem remains valid, for all three types. | Same theorem remains valid. Its error must be budgeted after the new modular transport, not before it. |
| Modular word and transport | Low-height bounds depend on the old seed range and V. | The old starting-height, four-inversion, and `|1/t|<=50/3` bounds do not transfer. Each new word and its propagation need certification. |
| Nodes and weights | Oscillatory phases now reach `T*V`, beyond the pilot's `203/4` phase range. | Larger V and A alter both node-error sums and center magnitude bounds; the old `2^-24` and `2^-48` allocations have no automatic justification. |
| Contour output | No positive half-plane margin was proved uniformly in T. | Same issue. New strict panel comparisons, shared vertices, complete coverage, and winding counts remain necessary. |

## 1. First quantitative obstruction: the old quadrature certificate

Keep the old b and all old quadrature parameters, and ask for error at most 1/10 at a center with ordinate T. Since `exp(z)-1<exp(z)`,

```
Q0 > 2M exp(r*(T-2*pi/h)).
```

Here `M>1/2`, `2*pi/h=512*pi<2048`, and `r=1/66`. Thus for every `T>=2048` the stated error upper bound Q0 is greater than 1. In particular it cannot establish the 1/10 budget at either T=1000000 or T=60343058. This is a rigorous failure of the existing sufficient bound, not a lower bound on the actual quadrature error.

More generally, for these fixed envelope constants, requiring `Q0<=epsilon` with `epsilon<=2M` forces `h<2*pi/T`. If V is held at 29/8, it therefore forces

```
K=V/h > V*T/(2*pi) > 29*T/64.
```

At T=1000000 this is `K>453125`; at T=60343058 it is `K>874974341/32`. It is a necessary condition for satisfying this particular bound while keeping this V, not a sampling lower bound for other quadratures, contour shifts, batching methods, or exact cancellation arguments. No production grid was generated.

## 2. Retuning avoids that exponential, but does not preserve the other constants

Use the already reviewed height-dependent tilt with `U=T+1`. The analytic parameters give

```
C=3/(2U), z0=9/(4U), q=3/(4U),
A=(2048/C^2+96/C)*(1+z0)/z0,
M=A/q, D=A*(1/q+1/q^2).
```

For the derivative spatial tail one must have

```
exp(2V)>=8U/3.
```

The pilot already proves `exp(29/4)<2048`. Consequently its V=29/8 cannot satisfy this requirement once `U>=768`. At the two selected work heights the required lower bounds on `exp(2V)` are respectively `8000008/3` and `160914824`. This is an applicability condition of the derivative discrete-tail lemma, before even testing whether the resulting S bound is small.

Furthermore,

```
A > (32768/81)*U^3,
D > (524288/729)*U^5.
```

These follow by retaining positive terms in the displayed exact expressions. With rho=1/64, the old degree-6 Cauchy bound is `D/(63*64^6)`. Exact rational substitution gives a value greater than `166121368759826019885` at T=1000000, and greater than `132910297322471857771573276285` at T=60343058. Those are lower bounds on the conservative remainder expression, not actual Taylor remainders.

With the same rho, the smallest degrees making this Cauchy expression alone at most 1/10 are 18 and 23, respectively. This calculation does not allocate any room to coefficient, node, weight, or polynomial-evaluation errors, so those degrees are not proposed complete parameter choices. The check used only the exact rational expressions for C, q, z0, A, D and successive powers of 1/64.

## 3. A concrete modular transport change

At the zero Fourier node and the retuned positive tilt, the exact seed is

```
tau=-cos(2/U)+i*sin(2/U).
```

For either large selected U, its nearest integer translation adds 1. The translated value is `t=1-cos(2/U)+i*sin(2/U)`. The elementary identity

```
|t|=2*sin(1/U)<=2/U
```

gives `|1/t|>=U/2`. Thus even this explicitly identified first S input cannot satisfy the pilot's `|1/t|<=50/3` bound. This is an actual operand inequality, unlike the preceding observations about upper error expressions. It does not predict interval failure or runtime; it shows that the old transport constant cannot be reused.

The accepted general reduced-jet tail remains available, but the number of modes and working radii must be chosen using the new word's exact transport. The sharper fixed16-mode tail is a separate reviewed or reviewable input; even if retained, its multiplication by the low-height `2^104` propagation factor needs a new justification. The general checker should propagate actual matrices and intervals rather than assuming that factor.

## 4. What a production blueprint still needs

Choose the exact function normalization and complete contour geometry first. Then allocate the full Taylor-panel error, including separate Q0/Qj, admissible S0/Sj, weighted node radii, weight-center errors, summation error, and the Cauchy remainder. Select h, V, degree and radius from that allocation. Certify every exact node and every finite transform scale; FFT output ordinates cannot be silently rounded to arbitrary panel centers.

The node table can be shared across centers when b, h and K agree, with center-specific weights. Separate contours may use different b values and transfer their counts individually to xi; their image edges cannot be concatenated without normalization. Reuse of an old node needs exact equality of its input, or a separately proved perturbation bound.

Finally, no parameter calculation proves a positive spectral margin. A whole closed panel must pass its strict rotated-half-plane test. A contour must have all shared vertices, seams, orientation and winding verified. An actual boundary zero, or a positive winding count, is not repaired merely by tightening arithmetic. These are the remaining mathematical and finite-data gates identified by the accepted frontier.

The first obstruction to literally repeating the low pilot is therefore already the quadrature expression in section 1. The other sections explain why the standard retuning does not permit reuse of the remaining scalar budget. They establish no negative verdict on the feasibility of a redesigned production evaluator.
