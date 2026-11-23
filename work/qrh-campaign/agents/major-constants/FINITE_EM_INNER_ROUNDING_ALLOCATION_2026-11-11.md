# Inner rounding for the fixed finite-EM elementary certificates

2026-11-11. New paper schedule and exact scalar bounds only. No elementary value, evaluator, function model, transform or proof checker was run. The schedule replaces the unrounded elementary polynomial evaluations in one accepted design; it does not alter the source functions or assert that an existing receipt passes.

## 1. Inputs and interfaces that stay fixed

The accepted outer elementary allocation is `FINITE_EM_RATIONAL_ELEMENTARY_BUDGET_2026-11-11.md`, SHA256 `50D1FFB0385A0F2FCE3BA9EF3BBB4FFD3BAC5A0103E95A8329E79A25D524A541`, independently reviewed at `prime-estimates/REVIEW_FINITE_EM_RATIONAL_ELEMENTARY_BUDGET_2026-11-11.md`, SHA256 `462A5D3FA54E3E2841FDCE066AF70C1180CB8AC2FE72DB23AA9DC59E19EFBB7A`.

The motivating cost note is `independent-feasibility/FINITE_EM_RATIONAL_PROOF_COST_DESIGN_2026-11-11.md`, SHA256 `19DB61735647D0267954692733C2CF045B977D540A4CF55B5DBDB1145EE82CB8`. Its unrounded sufficient denominator `d^512*512!` was a bound for one evaluation schedule, not a necessary denominator size. The new schedule below avoids that product in each elementary-polynomial evaluation.

Keep the fixed principal pilot's centers, integer bases through 1025, and

```
eta=2^-1024, epsilon=2^-512.
```

Canonical log and pi centers still have absolute error below eta. The complex exponential primitive at its exact rational input still has norm error below `2^16*eta<epsilon`. The later actual-log perturbation, moment, FFT, correction and whole-panel bounds therefore retain their existing interfaces. This is not permission to round every later primitive operation on a new grid.

The new inner gate has norm error at most

```
delta=2^-1040=eta/65536,
inner coordinate grid step delta/2=2^-1041.
```

Each gate first forms its prescribed affine or quadratic expression exactly over rational real/complex numbers, then chooses a dyadic center on that grid with norm error at most delta. Coordinatewise nearest rounding suffices; signed integer comparisons certify its error. A uniform norm error can be padded into coordinate intervals. Conversely, any rectangle error used as a norm error must include its norm conversion. No floating-point rounding mode is an implicit premise.

The canonical elementary output grid remains `eta/2=2^-1025`. Final real log/pi rounding is bounded by eta/2, and final complex rounding by eta, as in the accepted budget.

## 2. Exponential polynomial, exact identity and propagated error

The primitive's Taylor polynomial has 513 terms, degrees 0 through 512. Define exact nested values

```
V_512=1,
V_k=1+z*V_(k+1)/(k+1), k=511,...,0.
```

Finite substitution gives `V_0=sum_(j=0..512) z^j/j!`. More generally `V_k=sum_(j=0..512-k) k!/(k+j)!*z^j`, which proves both the factorial normalization and the recurrence. The terminal 1 is exact; the 512 affine updates each have one new delta gate.

For |z|<=R, the local error at gate k propagates to the final value with factor at most `R^k/k!`. Thus

```
|Vhat_0-V_0| <=delta*sum_(k=0..511)R^k/k! <=exp(R)*delta.
```

Use `<81*delta` at R=4, from exp(4)<3^4, and `<3*delta` at R=1/2. The same proof bounds the error of each intermediate nested suffix by exp(R)*delta because `(k+1)...(k+j)>=j!`. In particular the approximate suffix norms are below 82 on R=4. This proves the algorithmic error by an exact recurrence, rather than assuming the high-degree polynomial is well conditioned.

The source Taylor tail is unchanged. The accepted source plan uses pinned Mathlib `Complex.exp_bound'`, `Analysis/Complex/Exponential.lean:407`, with `|z|/(n+1)<=1/2` and norm tail `2*|z|^n/n!`. Here n=513. The Horner error is additional to that analytic tail, not a replacement for it.

### Four real squarings

For the fixed complex primitive, the real part x lies in [-8,0]. Apply the polynomial at z=x/16, with R=1/2. Its initial total error is

```
e0=2*(1/2)^513/513!+3*delta.
```

After each of the four real squarings, apply a delta gate. The exact comparison value is an exponential of a nonpositive real number and has magnitude at most 1. When the previous error e<1, the square error is at most `(2+e)*e+delta<=3*e+delta`. All four small-error premises follow from the displayed positive recurrence. Consequently

```
e4<=81*[2*(1/2)^513/513!]+283*delta<eta.             (Ereal)
```

Both the four polynomial-input scalings and the square identities are exact rational/algebraic transformations. The four new rounding errors have not been omitted from (Ereal).

### Imaginary phase and the final complex product

Retain the old exact integer reduction of a rational angle theta using the canonical pihat, with |k|<2^12 and reduced rational r=theta-2*k*pihat of magnitude below 4. The actual reduced angle differs by at most `2^13*eta`. The canonical pi error remains eta by section 4 below. The 513-term complex Horner polynomial at i*r therefore has error at most

```
ecis=2*4^513/513!+81*delta+2^13*eta.                (Ecis)
```

The true cis has norm 1, and the approximant has norm below 2. Form the product of the real-exp and cis centers exactly, then apply the existing final complex gate with error eta. The total primitive error is at most

```
2*e4+ecis+eta <2^16*eta<epsilon.                   (Ecomplex)
```

This accounts for the Horner gates, real squaring gates, pi error multiplied by the range-reduction integer, and final product gate. It does not silently change the separate bound for replacing actual logarithms in the input argument by their canonical centers.

## 3. Atanh logarithms and the internal log-2 cache

For an integer 1<=n<=1025, use exact `n=2^k*u`, `0<=k<=10`, `1<=u<2`, and `t=(u-1)/(u+1)` with 0<=t<=1/3. The accepted log polynomial is

```
2*t*sum_(j=0..511) (t^2)^j/(2j+1).
```

Compute it by the exact-target recurrence

```
v_512=0,
v_k=1/(2k+1)+t^2*v_(k+1), k=511,...,0,
output=2*t*v_0.
```

There is a delta gate after each affine update and one after the final multiply. A geometric error bound gives `|vhat_0-v_0|<=9*delta/8`. Since 2t<=2/3, the final polynomial error is at most

```
(2/3)*(9/8)*delta+delta=7*delta/4.                  (LogInner)
```

Compute log 2 by that same inner schedule. For reuse in `k*log2+logu`, retain its inner-grid center before any canonical eta/2-grid rounding. Using an already canonical-rounded log2 in this assembly and then multiplying its eta-scale error by ten is not covered by the proposed bound. The internal log2 center and its tail/error proof are a distinct cache entry.

Use exact rational assembly of k times this internal log2 center plus the internal logu center, and perform only then the final real canonical rounding bounded by eta/2. The combined old analytic tail is

```
Tlog=11*2*3^-1025/[1025*(1-1/9)]<eta/16.
```

The maximum coefficient sum is k+1<=11. Thus the complete log error is at most

```
Tlog+11*(7*delta/4)+eta/2<eta.                      (LogFinal)
```

Log1 remains exactly zero. The accepted coarse positive log/domain checks remain valid; no interval crossing zero is used to select an exact branch.

## 4. Machin arctangents

For t=1/5 or 1/239, the accepted 256-term alternating polynomial is computed using

```
v_256=0,
v_k=1/(2k+1)-t^2*v_(k+1), k=255,...,0,
output=t*v_0.
```

The signs give exactly `sum_(j=0..255)(-1)^j*t^(2j+1)/(2j+1)` after finite substitution. One delta gate per affine update gives error at most `25*delta/24`; one after the final t multiplication gives at most

```
(1/5)*(25/24)*delta+delta=29*delta/24.               (AtanInner)
```

Combine the two inner-grid outputs with the exact signed coefficients 16 and -4, then round the result to the canonical pi grid with error at most eta/2. The old analytic tail is `Tpi=20/(513*5^513)<eta/16`. The complete error is

```
Tpi+20*(29*delta/24)+eta/2
 =Tpi+(145/6)*delta+eta/2<eta.                     (PiFinal)
```

The negative Machin coefficient is retained both in computation and interval interpretation. The sum of absolute weights 20 appears only in the error bound. No new arctangent or pi approximation is assumed.

## 5. Denominator bounds for this fixed pilot

All bounds in this section are for rational centers and the exact expression immediately before a named rounding gate. They are not bounds on every auxiliary integer in a checker, all proof terms, or all raw interval-tail expressions.

The canonical logs and pi centers are on grid 2^-1025. The fixed center coordinates have denominators 1250 and 16. Therefore the real part of `-c_j*loghat(n)`, after division by 16 for real-exp range reduction, has denominator dividing `625*2^1030`. The unscaled imaginary part has denominator dividing `2^1029`. Subtracting `2*k*pihat` does not increase that latter bound. Twiddle arguments `2*pihat*k/32` also have denominator dividing `2^1029`. Thus a single common argument denominator is

```
d=625*2^1030.
```

An inner Horner value has both coordinates on grid 2^-1041. The exact exponential affine update

```
1+z*v/(k+1)
```

has coordinate denominator dividing `d*2^1041*(k+1)`. Since 1<=k+1<=512, its denominator is at most `d*2^1041*512`, which has bit length 2090. The maximal numerical product is a bound; it is not claimed to be one common divisor for every possible k+1. The gate resets the denominator to a divisor of 2^1041 before the next update. There is no accumulation of d^512 or 512! across the rounded loop.

For the log polynomial, the exact reduced t is `(n-2^k)/(n+2^k)`, not in general a dyadic. Its reduced denominator is at most 2049. The affine update has denominator dividing

```
den(t)^2 * 2^1041 * (2k+1),
```

and is at most `2049^2*2^1041*1023`, of bit length 1073. The final 2t multiply has denominator at most `2049*2^1041`. The inner log2 cache is dyadic after its final inner gate, so the exact k*log2+logu assembly has denominator dividing 2^1041.

For Machin, replace den(t) by 5 or 239 and use 2k+1<=511. The maximal affine-update denominator is at most `239^2*2^1041*511`, of bit length 1066. The final t multiplication is at most `239*2^1041`. The exact weighted Machin combination again has denominator dividing 2^1041.

Each rounded real square has pre-gate denominator dividing `2^2082`, of bit length 2083. Both factors in the final real-exp times cis product are inner-grid centers, so the product has the same bound. Canonical output rounding resets coordinates to a divisor of 2^1025.

These statements give pre-gate denominator bounds below 2100 bits for the new polynomial, square and product operations. They do not bound numerators by 2100 bits. For example, the approximate exponential suffix norm is below 82; a crude raw affine bound is 1+4*82=329, so its numerator can require roughly nine additional magnitude bits. The arithmetic comparisons for rounding can also multiply a raw denominator by a grid mantissa. Naive cross multiplication can therefore use substantially more than 2100 bits. Common powers of two may be canceled by a proved arithmetic rule, but that optimization is not assumed here.

The constant Taylor-tail inequalities still involve 513! and can be checked once as scalar lemmas; they are not fresh 2100-bit-per-operation claims. A checker may use their already proved dyadic upper bounds when padding outputs. This note also does not alter the larger exact moment or correction denominators identified in the cost note. It addresses only the elementary leaves.

## 6. Additional work and unchanged acceptance boundary

The log inner loop adds 512 affine rounding gates and one final multiply gate per reduced log polynomial. The internal shared log2 polynomial can be cached once. Each Machin component adds 256 affine gates and one multiply gate; the pi combination is exact before its canonical output gate. Each generic complex exponential uses 512 real Horner gates, four real-square gates, 512 cis Horner gates and its existing canonical complex product gate. These are explicit schedule counts, not a speed forecast or a complete bit-operation count. Exact zero or constant special cases can only be omitted with their exact input proofs.

The previous outer budget remains usable because (LogFinal), (PiFinal), and (Ecomplex) imply exactly its elementary interfaces and final grids. The later butterfly, moment, correction, polynomial and quotient schedules are untouched. Old source and data hashes are not changed. Actual rational witnesses, their signed rounding comparisons, and full containment in immutable target enclosures remain required. The fact that a new schedule has smaller sufficient denominators does not establish that the overall certificate is faster or smaller.

The companion `finite_em_inner_rounding_allocation_20261111.py` verifies 25 exact scalar and bit-length checks. It constructs no elementary values or intermediate Horner arrays. The new proof obligations are finite Horner identity/rounding-error induction and their certificate representation, followed by actual witness generation and checking under a separately authorized task. No root premise, spectral assertion, runtime limit or accepted strategy is changed.
