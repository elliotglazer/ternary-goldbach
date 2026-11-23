# A quantitative prime-error input for the relaxed Möbius profile

Research result, 2026-11-11. Source: `work/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build or canonical edit. The new computation is an exact rational replay of a **conditional numerical implication**, not evidence that the required prime-error bound holds. Independent review is needed before treating the implication as a completed paper replacement.

## Result and unresolved input

A concrete sufficient input for the existing Schoenfeld strategy is

```text
For every integer v ≥ 1,000,000,000,
  |psiN(v) − v| ≤ (1/100) v / log(v).                 (P*)
```

Together with the reviewed unconditional P2 proof, existing finite Möbius/weight certificates, and the finite psi repair below 10^9, this input supports

```text
|sum_(n≤floor x) μ(n)/n| log x ≤ .03, 11815 ≤ x < 100000001;
|sum_(n≤floor x) μ(n)/n| log x ≤ .10, x ≥ 100000001.
```

The second conclusion is obtained by regenerating the cells and changing the infinite-tail constants. It does not preserve every stronger intermediate bound in the old profile. **(P*) is unproved.** It must be proved from actual prime/zeta information, not inserted as an extra assumption into Goldbach. This is a sufficient envelope, not a claim of mathematical optimality.

The companion `resume_mobius_input_20261111.py` ran successfully and wrote `resume_mobius_input_20261111.json` and `.log`. Acceptance decisions use Fraction arithmetic; displayed decimals below are diagnostics of exact comparisons. Source hashes of the generator, weight table and original cell files are recorded in the JSON. No Lean generator writer was called: only the read-only function prefix before `def run()` was loaded, with UTF-8 added to its file read. All output stays in this agent's directory.

## 1. What the induction actually needs

Write `M(n)=Σ_{k≤n}μ(k)`, `m(x)=Σ_{k≤floor x}μ(k)/k`, and `rho(v)=psiN(v)-v`. The unconditional identity `SchoenfeldStep.N_abs_le:27` bounds the auxiliary N-sum by

```text
|M(D)| + 1
+ sum_(2≤k≤Y) |Λ(k)-1| |M(floor(D/k))|
+ J(D,Y)
+ |rho(Y)| |M(floor(D/(Y+1)))|,

J(D,Y) = sum_(1≤m≤floor(D/(Y+1))) μ(m)^2 |rho(floor(D/m))|.
```

Thus the minimal input at this proof boundary is an upper bound on this **nonnegative weighted absolute error sum** and its boundary value. A signed mean prime estimate or a one-sided harmonic estimate cannot simply be substituted for it. A pointwise envelope is one convenient way to control J.

The existing `SchoenfeldJ.rho_le:34` uses the additive envelope

```text
2sqrt(v)
+ 1_(v≥10^9) 35.5sqrt(v)
+ 1_(v≥32000000001) 72sqrt(v)
+ 1_(v≥10^12) v*(1/log(v)^3 + 4.92e-7 + 1.4262/sqrt(v)).
```

Those latter terms come from conditional psi/theta results, not finite Möbius computation. Under (P*) replace them by the simpler additive majorant

```text
2sqrt(v) + 1_(v≥10^9) .01*v/log(v).                  (R*)
```

For v below 10^9, the finite psi repair supplies `|rho(v)|≤2sqrt(v)` for `v≥12`: SmallTab below 10^6, then the existing theta sieve plus the reviewed P6 bound give upper error at most `1.5262sqrt(v)` and lower error at most `2sqrt(v)`. For v≥10^9, (P*) supplies the second term alone. Keeping the first term there deliberately overcounts and simplifies the checker.

The boundary Y in the retained cell choices is at most 10^6, so the finite bound supplies `bTerm_le` without a global psi estimate. The proof must use the finite repair, not import the current conditional `bTerm_le:437` unchanged.

## 2. Exact cell experiment and the new J evaluator

Retain the source's 213 cell endpoints and Y choices, and split the one cell crossing 10^9 at exactly that integer. There are now 214 cells, covering `[100000001,T)`, with the same final T:

```text
T = 5273264915796702340408371151172679619749656857014800716447501879607296,
160.54 ≤ log T ≤ 160.55.
```

Below 10^9, only the original `2sqrt(v)` part is present. Above it, divide `[10^9,D]` into logarithmic pieces. For one piece `V≤floor(D/m)<W`, the source `eps_piece` argument works with `.01/log(V)` instead of `epsv(V)`, giving the normalized bound

```text
.01/log(V) * [kap*log(W/V)+.588],
kap ≤ 607927101855/10^12.
```

For the final piece use `kap*log(D/V)+1.166`. The pointwise replacement coefficient decreases on V>1; floor inequalities and `Sqf.Q1_diff_le/Q1` are unchanged. The old theorem's `V≥10^12` is a domain needed for its particular epsv input, not an obstruction to proving this new piece lemma from (P*) starting at 10^9.

The script selects piece locations using floating arithmetic only as candidate integers. Every logarithmic enclosure used in acceptance is then certified by the source's rational `logLo/logUp` checks. The first point is exactly 10^9, the final point is A, and points increase. Finite square-root and boundary contributions, the weight-table k-sum, and all source rounding directions are retained.

For a cell `[A,B)`, let L be its certified lower log A, d=(B-A)/B, I the prior N-weight sum, and X the normalized `1+k+J+boundary` majorant. The unchanged scalar induction conditions are

```text
X + (626+I)/A + nu*d/L^2 ≤ nu*(1-1/L),
nu/L + (626+I)/A + nu*d/L^2 ≤ eta,
I + nu*(B-A)/L^2 ≤ I_next.
```

The script regenerates nu, eta and I_next with exact outward rounding, checks every structural and scalar cell condition using the evaluator with the new X, and propagates `S=Σ|M(n)|/n`. For the real m-bound it uses the actual `MoebiusSch.mqv` formula

```text
[2eta + max((ub+S-eta*(A-1))/A,
            (ub+S-eta*(A-1))/B)] * ub ≤ .10,
```

where ub is a certified upper log B. No endpoint-only sample replaces this cell inequality. The new profile is constant .10 throughout these cells, so the old .092/.09/.08/.035 transition checker is not reused.

Results for (P*):

| Quantity | Exact accepted bound / diagnostic |
|---|---:|
| Number of checked cells | 214 |
| Largest real m-profile bound | approximately .086371196202, asserted <.10 |
| S(T−1)/T | approximately .000134586824, asserted ≤.000135 |
| `(626+I)*(160.55)^2/T` | asserted ≤.022 |
| Maximum eta on cells intersecting `[10^57,T−1]` | .000158259840634, asserted ≤.037/160.55 |

These last three checks are essential: passing the m-profile cells alone would not establish a compatible infinite tail. The experiment also tried .005/log and .002/log envelopes; those pass the cell test, but the .01 case is the useful weaker sufficient input and has the complete matching tail checks below.

This is not a claim that the original `chkCell` theorem already accepts the changed rho evaluator. The future proof must establish soundness of the modified J evaluator and then the adapted cell checker. The reused structural conditions and exact numerical replay make that work concrete.

## 3. P2 eliminates the global lower-Mertens input in this tail

The current `SchoenfeldTailAux.sum_Lambda_div_Ioc:37` combines P2 with global P3 (`mertens_lower_nat`). Its only use in `SchoenfeldTail.G_tail_le:427` has lower endpoint a=10^6. In fact **no lower Mertens estimate is needed for this consumer**.

Let `G(y)=Σ_{2≤k≤y}|Λ(k)-1|/k`. By `aw_le`, positivity, P2 and `sum_inv_le_log`, for y≥10^6,

```text
G(y)-G(10^6)
 ≤ sum_(10^6<k≤y) Λ(k)/k + sum_(10^6<k≤y) 1/k
 ≤ log y + log y - log(10^6)
 ≤ 2log y - 13.8155.                                  (G*)
```

This is weaker than the old subtraction 26.8787, but the final tail comparison already discards almost all of that subtraction. With L=log D, l2=.82L-.6933 and y≤D^.18, replace the k-sum coefficient by `.36L-13.8155`. The only relevant bound for its first eta component is

```text
(.36L-13.8155)*nu/(.82L-.6933) ≤ .36nu/.82,
```

which follows from the exact inequality `13.8155*.82>.36*.6933`. For its second component, simply use `.36L-13.8155≤.36L`, as the original proof does. The coefficient remains positive for L≥160.54. Therefore the original tail scalar formula is still a valid upper bound. P2 removes P3 from this particular tail; it does **not** prove P3 or remove P3 from Type I2.

## 4. A matching infinite tail, including all terminal data

Use the same T, split exponent .18, U0=10^57, nine additional exponent pieces, and finite weight bound `G(10^6)≤19.925014134314`. Change the tail parameters to

```text
nu_infinity=.037, b=.060, K0=.022, Sf/T=.000135,
eta(L)=.037/L+.060/L^2.
```

The regenerated cells provide the required etaMax comparison on `[U0,T)`. Above T, `M_of_N` and the source inverse-log-square sum imply the second coefficient `1.013*.037+.022=.059481<.060`. Thus both parts of `M_unif` are supported, instead of assuming a uniform M-bound that was never checked.

(P*) supplies `|rho(v)|≤.01*v/log v` on all tail arguments; those arguments are at least 10^12 in the unchanged tail geometry. It supplies the boundary rho value as well. The source `jV` formula is linear in its old .00985 coefficient; replace it by .01, and use (G*) for the k-sum.

The exact new tail inequality at L0=160.54 is

```text
1e-9 + (.037*1.013+.022)/L0^2
+ 19.925014134314*eta(L0-14.5089)
+ .037*.36/.82
+ .36*.060*L0/(.82L0-.6933)^2
+ jV_(C=.01)(L0,.18,expL)
+ .01*eta(.82L0-.6933)/(.18L0-1e-9)
 ≤ .037*(1-1/L0).
```

The Fraction check passes with positive margin. The source monotonicity proofs for the rational terms use positive coefficients and ordered positive exponents, so the same arguments apply to these positive replacements. This supplies the numeric step for strong induction on N(D), after the analytic and checker adapters are formalized.

Finally retain the real-floor estimates and inverse-log sums in `MoebiusSch.m_tail:302`, but substitute the new nu,b,Sf. The displayed bound for `|m(x)|log x` is approximately **.097126813339<.10**. The script asserts this with rational arithmetic including the `1e-60` and `1e-30` error reserves, not merely with rounded decimals. The terminal S contribution is now `.000135*160.55`; retaining the old `.0000362` after regenerating cells would be false.

The .03 interval needs no new induction: `MoebiusProfile.m_small_real` covers `[11815,2160535)`, and unconditional `MoebiusSch.m_mid` covers `[2160535,100000001)`. At 100000001 the new .10 cell profile takes over. At T the new tail takes over.

## 5. Why the available coarse estimates do not close (P*)

The new P2 theorem controls `ΣΛ(n)/n` from above. It helps (G*) but supplies neither side of the pointwise difference `psiN(v)-v` at the accuracy required by (P*). At v=10^9, (P*) asks for relative error approximately .00048255; at 10^12, approximately .00036191. Both upper and lower errors matter in J.

Using only the coarse Chebyshev upper bound `psiN(v)≤1.43v` and nonnegativity gives the absolute-error majorant `|rho(v)|≤v`. This provably cannot make the current absolute-value cell mechanism certify .10 once D reaches the unknown range. The m=1 term belongs to J and contributes the majorant D by itself. Hence X≥1. Dropping all other nonnegative costs from the scalar induction gives

```text
nu ≥ 1/(1-1/L),     eta ≥ nu/L ≥ 1/(L-1).
```

For S≥0, ub≥L>1, the actual mqv formula is at least eta. Its certified profile is therefore at least `eta*ub≥L/(L-1)>1`, already ten times the desired .10. Even a two-sided relative-error majorant .43 would fail this same test. This is a failure of that coarse-majorant implementation, not a lower bound on actual Möbius sums and not an impossibility theorem for other methods or cancellation before taking absolute values.

An eventual fixed-power error at enormous v also cannot be substituted for (P*) without covering every intermediate integer from 10^9 to its crossover. The new route pinpoints that missing arithmetic task rather than assuming the old `rho_le`, `rho_C5`, or a supplied m-profile as a free premise. It needs no unrestricted global P3, no full old theta envelope, and no direct coprime-Ramaré shortcut.

## Implementation and review boundary

The prospective proof work is now finite and explicit: formalize the reviewed P2/P6 finite repairs; prove actual (P*) or an adequate weighted-J substitute; prove the new monotone piece evaluator from that input; replay the 214 cell and profile checks; replay etaMax/K0/Sf; parameterize the tail constants and use (G*); then feed the relaxed profile into the previously reviewed G2/Liouville adapters. The original G2 .0082 assertion is not preserved automatically; its separate .0089 adapter remains necessary.

All new numerical files are reproducible evidence for this implication. They do not prove (P*) or the final no-Platt theorem, and no declaration has been frozen or added to the canonical Lean source.
