# A strictly weaker weighted-excess certificate for the selected consumers

2026-11-11. Research-only conditional derivation. The current selected strategy and all frozen reports remain unchanged. No finite spectral assertion is proved here. No Lean declaration, build, numerical zero search or production timing was attempted.

There is a genuine weakening of the shared finite `.555` assertion that preserves the selected major, minor and nonprime bounds. Retain that assertion for conductors at most 100000. For larger active conductors, replace individual zero exclusion by the single positive weighted-excess bound `K<=6` defined below. It permits zeros as far right as the global `7/8` line and still gives the required `Aplus<=5e-7`, `Astar+Cross<=9.5e-7`, `N<=1.23`, the unchanged principal estimates, and the base-gap consumer.

This does not yet establish a cheaper production method. The new aggregate has no character-ownership requirement in its certificate data, but global QRH and the currently available counting bounds do not prove it or allow an entire character row to be skipped. The exact obstruction is described at the end.

## 1. Source and reviewed inputs

Use source commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`, the current consumer frontier in `mellin/CURRENT_CONSUMER_OBLIGATION_FRONTIER_2026-11-11.md`, and the selected minimum height

```
b=111/200, x0=49*10^25, y0=10^25,
Hcert(c)=min(ceil(200+max(1000,(704/7)*Dc)),10^8/c),
Dc=1200000/qt(c),  qt(c)=2c for odd c and c otherwise.
```

Active conductors are odd `c<=150000` and multiples of four `c<=300000`, including `c=1`. Major moduli form `Qset 150000`. Write `Dq=1200000/qt(q)`. Star uses its smaller actual cutoff `Hs(c)<=Hcert(c)`. All height endpoints are inclusive and every occurrence below has actual analytic multiplicity. Strict finite carriers must still be chosen outside these closed cutoffs.

The directly inspected source `MinorArcs/Bombieri.lean:27,78,135` supplies character Parseval, the inverse-character twist and its norm-square identity. Its `norm_sq_gaussSum` immediately following `changeLevel_apply_natCast` gives the exact support rule: a primitive conductor `c` contributes at `q=cr` precisely when `r` is squarefree and coprime to `c`, and then the Gauss norm squared is `c`. There is no unconditional imprimitive `|tau|^2=c` claim. `Explicit/ZeroSumGen.lean:59` counts actual rectangle multiplicities in a ball, not distinct roots.

Quantitative inputs are the already reviewed actual-smoothing arguments in:

- `RESUME_FAMILY_CAPS_2026-11-11.md`: global-strip Gram rows, diagonal bounds and second moments.
- `zero-sum/RESUME_FAMILY_MIXED_2026-11-11.md`, SHA `5E7FB33EDF2A65F058DC605A3054FE37DFDF14E9ACDCB8409A8211DCF1F9D09D`: in particular its stronger direct-modulus low bound `Cross_low<1e-9` at `.555`.
- `RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md`, SHA `79833F8D5D5856E000A96D3F5CCA9FC9E26CB3BAF637CDE089FEFDD703436BA7`: current high tails and full mixed remainder `<.000160001`.
- `zero-sum/RESUME_BASE_GAP_FINITE_FAMILY_2026-11-11.md`, SHA `09340D4135D7E895E6F3FDA660DE9A7F773A91FF41F3B88FC125C814884D5E74`: the pointwise consumer and actual etaU Mellin interpolation, together with its reviewed minimum-height containment and small-denominator high-parameter joins.

Their analytic formalizations are still required. This note uses them as paper derivations, not as new compiled theorems. The final required numerical conditions and the `.00009` representation-sum reserve are not changed.

## 2. The positive excess and an exact decomposition

For `z` equal to `x0` or `y0`, define

```
Delta_z(beta)=max(z^(beta-1)-z^(b-1),0),
k(beta)=max(x0^(1/8)*Delta_x0(beta), y0^(1/8)*Delta_y0(beta)).
```

Under global QRH, `1/8<=beta<=7/8`, so `0<=k(beta)<1`; it is zero exactly when `beta<=b`. For each primitive character of conductor `c>100000`, let

```
k_chi = sum_(rho nontrivial, |gamma|<=Hcert(c)) mult(rho)*k(beta),
K = sum_(active c>100000) sum_(chi primitive mod c) k_chi.
```

The proposed finite replacement is:

1. Retain `beta<=b` through `Hcert(c)` for every active `c<=100000`.
2. Prove `K<=6` for the remaining conductors.

The original uniform finite assertion implies this with `K=0`. The replacement does not imply the original assertion: it permits, for example, six repeated occurrences with `beta=7/8` in the large-conductor carriers while all other occurrences have `beta<=b`. Conjugate/inverse and reflection partners must of course be included consistently; three conjugate pairs are allowed by that example. This is a comparison of sufficient information requirements, not a claim that such zeros exist.

No zero or Mellin kernel is relocated. For an actual zero `rho=beta+i gamma`, keep the actual function `F_eta(rho,delta)` and split its scalar coefficient exactly as

```
z^(rho-1) = exp(i gamma log z) * z^(min(beta,b)-1)
          + exp(i gamma log z) * Delta_z(beta).
```

The same actual kernel multiplies both terms. Any common minus sign in the explicit formula is retained on both sides. The first term defines an amplitude-capped actual-kernel sum; the second is its excess. This identity introduces no derivative in beta, no altered phase, and no virtual zero of a different L-function.

For all `z>=z0`, the excess is bounded by its endpoint value. For `beta>b`, put `a=1-b` and `t=beta-b`. Differentiating the difference shows it decreases when

```
log z >= log(a/(a-t))/t.
```

The right side is at most `1/(1-beta)<=8`, by integrating `1/(a-u)` on `[0,t]`. Here `log z0>8`. The case `beta<=b` is zero. Consequently

```
Delta_x(beta)<=x0^(-1/8)*k(beta),
Delta_y(beta)<=y0^(-1/8)*k(beta)
```

for every actual scale in the problem. This is a proof for the difference itself, not an invalid subtraction of two monotonic upper bounds.

## 3. Why the capped baseline retains the reviewed bounds

The squared-smoothing kernels used in the family report hold for `sigma=beta+beta'-1` throughout `[-3/4,3/4]`, and hence for all actual QRH-strip zeros. The actual ordinates, multiplicities and inverse labels are unchanged. The capped coefficient magnitude is at most `z^(b-1)`. Every Gram, Jensen and positive fourth-moment envelope used for the baseline therefore applies verbatim, including the direct two-character calculation giving `Cross_low<1e-9`. The source upper bound of 400 multiplicities per required ordinate window is not reinterpreted as spacing.

The baseline high zeros, possible zero-at-zero, contour, primitive-to-coprime corrections and principal pole subtraction are exactly the existing ones. In particular its full low/high mixed estimate is

```
sqrt(Cross_baseline)<sqrt(1e-9)+.000160001<.000192.
```

This deliberately uses the already reviewed stronger direct low estimate, rather than the looser factor-25 low allowance `.0005`. It changes no target and removes no term. Other baseline norms remain

```
sqrt(Aplus_baseline)<.0000700021,
sqrt(Astar_baseline)<.0004912,
sqrt(N_baseline)<.192000002.
```

The principal conductor is unaltered. Its `Ep`, q=1 local lower-J input, shared intermediate psi range and separate narrow-strip/moment obligation are identical to the selected route.

## 4. Exact arithmetic weights and excess norms

Let `R=21/4` and `C=100000`. The selected finite totient bound implies `c/phi(c)<=30030/5760<R`. For `c|q`, `phi(c)<=phi(q)`, so each supported weight `c/phi(q)<R`.

A character with active `c>C` induces with nonzero Gauss sum into at most two active moduli. If c is odd these are c and 2c. If c is divisible by four, only q=c remains: q=2c has noncoprime multiplier and q>=3c exceeds 300000. All affected q exceed C. Thus define

```
Bq = sum_(supported primitive chi at q, c>C) (c/phi(q))*k_chi^2.
```

Then

```
max_q Bq <= R*K^2,   sum_q Bq <= 2R*K^2,
sum_q Bq^2 <= 2R^2*K^4,   1/phi(q)^2 <= R^2/C^2 on this support.
```

These are the exact Gauss weights used once, followed by explicit upper bounds. They are not a claimed intrinsic `1/sqrt(c)` improvement to a primitive character error. All sums still retain independent character factors where required.

Set `X2=1/2125^2 > x0^(-1/4)` and `Y2=1/1333^2 > y0^(-1/4)`. Denote the excess character-vector energies by `Pq(delta)` and `Sq(delta)`. The actual diagonal Plancherel bounds from the family report are 4 for plus and `49*18=882` for star. Minkowski applied to the individual actual kernels gives

```
integral_R Pq <= 4*X2*Bq,
integral_R Sq <= 882*Y2*Bq,
sup Pq <= (3.95)^2*X2*Bq.
```

For excess zeros only, `beta>b`. The actual etaU interpolation is

```
|F_U(beta+i gamma,delta)| <= M(beta)=1.922-.6686*beta.
```

It decreases with beta, and `M(b)=1.550927<13/8`. Therefore

```
sup Sq <= (13/8)^2*Y2*Bq.
```

For the two weighted second moments use the existing Fourier bounds `|U|<=1.2534`, `|P|<.917` and their multiplier `mu(q)^2/phi(q)^2`. This yields squared norm coefficients, multiplying `K^2`,

```
Aplus_excess <= [2R^3/C^2 *4*1.2534^2*X2] K^2,
Astar_excess <= [2R^3/C^2 *882*.917^2*Y2] K^2,
N_excess <= [8R*X2] K^2.
```

No exceptional zero is charged the full old `N(c)` in these diagonal/Minkowski bounds. This is the substantive improvement over applying the previous conductor-energy fourth-moment envelope to a sparse exceptional set.

## 5. Complete mixed perturbation

The baseline low energy in each individual modulus can be bounded without enumerating its zeros. From the original count proxies,

```
Np(c) <= 277000 + 28000000000/c,
Ns(c) <= 231000 + 567000000/c.
```

Indeed `ceil` contributes at most one at each step, `qt(c)>=c`, and the coefficients follow from `20000/87`. With `sum_supported c*n(c)=phi(q)^2` and `sum_supported n(c)<=phi(q)`, put

```
Yb=5.625e-23 > y0^(-.89), Xb=Yb/31 > x0^(-.89),
Jp=23000*Xb*(277000*300000+28000000000)<5e-9,
Js=4998000*Yb*(231000*300000+567000000)<2e-5.
```

The `Xb` step uses the exact inequality `31^100<49^89`. Thus the baseline low plus/star integral is at most Jp/Js for every q.

The common-height receipt bounds every primitive plus high tail by `4406144734183/10^18`. Including the non-high plus remainder `2e-15` gives a pointwise primitive allowance `h=4.411e-6`. The entire star remainder is `ds=2e-12`. The Gauss identity gives baseline high-plus energy at most `phi(q)*h^2` and star remainder energy at most `phi(q)*ds^2`. Also `2Dq*phi(q)<=2400000`.

Expand the full tensor exactly into baseline plus the five added terms. The squared coefficients below multiply `K^2`, except the last, which multiplies `K^4`:

| Added tensor term | Squared norm coefficient |
| --- | --- |
| Plus excess times baseline low star | `2R*(3.95)^2*X2*Js` |
| Star excess times baseline low plus | `2R*(13/8)^2*Y2*Jp` |
| Star excess times baseline high/remainder plus | `2R*(13/8)^2*Y2*h^2*2400000` |
| Plus excess times baseline star remainder | `2R*4*X2*300000*ds^2` |
| Plus excess times star excess | `8R^2*(13/8)^2*X2*Y2` |

The last line uses `integral Pq<=4X2 Bq`, `sup Sq<=(13/8)^2Y2 Bq` and `sum Bq^2<=2R^2 K^4`. This is an actual two-character product bound. The other lines use one pointwise factor and one integrated factor, with the same modulus q retained before taking explicit bounds. There is no inference of L4 from L2 alone and no assumed phase cancellation.

Exact rational comparisons give norm coefficients respectively below

```
.0000267, .00000027, .000027, .000000000004, .00000852.
```

Consequently

```
sqrt(Cross_full) < .000192 + .000053970004*K + .00000852*K^2.
```

For second moments the additional norm coefficients are below `.0000003`, `.00000348`, and `.0031`, respectively. At `K<=6` the exact script proves

```
Aplus < 5.15554156441e-9 <5e-7,
Astar < 2.622259264e-7,
Cross < 6.765720910820e-7,
Astar+Cross < 9.387980174820e-7 <9.5e-7,
N < .044352361 <1.23.
```

The separate historical allocation `Astar<=2.5e-7` is not claimed. It is not a selected consumer premise: the required combined target is `Astar+Cross<=9.5e-7`, and that target is retained. The same coprime-to-full transfer and final major `1.0404` calculation therefore apply, subject to the existing formalization obligations.

## 6. The pointwise base gap also fits

This is the consumer that an unqualified second-moment replacement would miss. Its original modulus is m, reduced denominator `q=m/gcd(m,2)`, physical etaU scale y, and twist delta with `u=2q|delta|`. Its low cutoff is below Hcert for every supported conductor, by the two reviewed height containments. Its excess is therefore a positive sub-sum of the same k_chi budget.

The capped baseline requires a small additional observation because high-right zeros can have reflected partners below `.445`. For every global-strip beta, `M(beta)>1` and

```
d/d beta [M(beta)*y^beta]
 = y^beta*(M(beta)*log y-.6686)>0.
```

For `beta<=b`, its capped coefficient is its original coefficient, so the product is bounded by `M(b)*y^(b-1)`. For `beta>b`, the coefficient is capped at `y^(b-1)` and `M(beta)<=M(b)`. Hence every baseline term still obeys the old `13/8*y^(b-1)` bound. This covers beta below `.445` without importing a nonexistent finite reflected strip. The other baseline base-gap terms are unchanged.

For the excess, the actual absolute Gauss reconstruction gives

```
|excess additive sum|/y
 <= (13/8)*y0^(-1/8)
    *sum_(supported c>C,chi) sqrt(c)/phi(m)*k_chi
 < (13/8)*R*K/(1333*316),
```

because `phi(m)>=phi(c)`, `c>C` and `sqrt(C)>316`. This uses the Gauss reconstruction weight, not a suppression of the primitive error itself. The baseline bound for every q>=4 is below `.044797`. At K<=6 the total is below

```
2365117277/52653500000 < .044919 < .04712 < ghatY(y,150000).
```

For q=1,2,3 all supported conductors are at most 6, so their actual low sums are unaltered. Their finite prefixes and high-u joins remain as selected. Thus the full base-gap consumer survives. The global-QRH minor-energy proof is unchanged, and c=1 retains all psi and principal-J information.

## 7. What this reduces, and the remaining production obstruction

The arithmetic census gives 75000 retained uniform conductors containing 1847865075 primitive characters, and 75000 weighted conductors containing 3695775113 primitive characters. These sum to the original 5543640188. This is not a count of saved evaluations.

The large-conductor certificate no longer needs to attach each zero to an individual character. If a nonnegative finite rectangle/count decomposition covers all actual zeros in these carriers, an upper sum of `multiplicity*k(upper beta)` proves K. For each c>1 the product of its primitive L-functions is entire; in the nontrivial strip its orders add with no pole cancellation. Thus conductor-product rectangle counts can supply the required aggregate in principle. The varying Hcert heights and all shared boundaries still require complete coverage. No degree or evaluation cost reduction follows merely from writing a product.

A precise positive zero-density formulation is available. Let `N_c(t)` count all occurrences with `beta>t` in the c-carrier. Since k is continuous, increasing and vanishes at b, finite layer-cake integration gives

```
K = sum_(c>C) integral_[b,7/8] N_c(t) dk(t).
```

An ordinary-integral sufficient majorant replaces `dk(t)` by

```
[log(x0)*x0^(t-7/8) + log(y0)*y0^(t-7/8)] dt.
```

This is because `k(beta)<=g_x(beta)+g_y(beta)`, where each g is the corresponding nonnegative integral from b to beta. It is a stronger, explicit density requirement, not an identity for dk. Counts at isolated beta boundaries do not alter this continuous integral; a finite rectangular certificate must still overcount boundary zeros safely. No such density estimate is currently proved in the campaign.

The current global strip and 400-per-window Jensen information cannot certify K<=6 for an unchecked character. At the smallest selected height, even the crude total-count upper bound is above 77000. Substituting `k<=1` therefore gives a bound vastly above six for one row. More sharply, 14 right-edge occurrences in the low carrier, paired consistently with their left reflections and conjugate/inverse labels, are compatible with those location and window-count upper bounds. At beta=7/8, `k(beta)>1/2`, so their contribution already exceeds six. This is a countermodel to those aggregate inequalities sufficing, not a claim about actual Dirichlet zeros or a logical insufficiency theorem for QRH plus all arithmetic structure.

Accordingly this derivation provides a strictly weaker finite information target and a new sparse-excess estimate covering every selected consumer. It does not yet justify omitting any entire character from production. A genuine production reduction now requires a proved aggregate density/count method establishing K without evaluating the relevant primitive factors individually, or a sharper analytic estimate that controls whole unchecked families. Neither numerical evidence nor hypothetical average cancellation is supplied here.

## Exact scalar receipt

Run `weighted_excess_budget_20261111.py` in this directory. It uses Fraction arithmetic and integer power checks for every sufficient numerical comparison, plus a bounded conductor/totient-factor census. No actual zero or L-value is evaluated. Script SHA256: `CB1AE496E413B0D8C4AA16492BB618121FA30A90CED7E13B3386EC9C90E4D178`; JSON SHA256: `D960FA57A3EB80B7B3E2025D35E4159960EB58EF2EDC59513BB30A2F5DE71DDB`.

Independent mathematical review is requested before treating this as an accepted alternative. It is not adopted in the selected strategy and is not a new premise allowed in the final Goldbach theorem.
