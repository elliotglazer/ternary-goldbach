# Resumed totient chain and spectral feasibility

Research review, 2026-11-11. Reference: calr3/ternary-goldbach at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build, source implementation, new axiom, or admitted proof was introduced. This note supersedes the historical claims that the second-choice totient repair is still mathematically open. It does not supersede their warnings about other Type I/II inputs.

The identified pointwise totient uses now have a complete paper replacement through all convolution scales and all layer ranges. One common correction, with total normalized cost below `1e-24`, suffices. The separate quotient-large-sieve use has a new elementary route in `work/qrh-blueprint/REGION_S_ELEMENTARY.md`. Neither result supplies the remaining prime/Mobius producers or the principal, nonprincipal, mixed, and base-gap estimates needed by the full theorem.

## 1. Finite arithmetic and the first choice

Set `B=2^1000`, `S=2^500`; write the analytic scale as `z=T^3`. These cutoffs are not conductor bounds on the whole problem.

The reviewed finite theorem is

```text
1 <= q <= B, 3 <= r, q <= r
    implies q/phi(q) < exp(gamma) loglog(r)+2.50637/loglog(r).
```

The real comparison radius r has no upper bound. The proof compares the prime divisors of q with the first k primes. The existing `SmallMertensProd.inv_2000` proves both the requisite finite product inequality and `theta(2000)>1000`. Since `1000 log 2<1000`, the comparison primorial cannot include all primes through 2000 when q<=B. The cases k<=3 use the existing unconditional bound by 3.75. The finite certificate's source closure was independently reviewed in `integration/GLOBAL_TOTIENT_FINITE_REVIEW.md`; extracting and kernel-checking the restricted theorem remain future work.

Globally, elementary prime-factor multiplication gives

```text
(q/phi(q))^4 <= (27/2) rad(q) <=16q,
q/phi(q) <=2q^(1/4).
```

Indeed `p^3/(p-1)^4<=1` for p>=5; the exceptional factors at 2 and 3 are 8 and 27/16. No prime-distribution estimate enters.

`FirstChoiceTypeII.typeII_rest_le` only needs `q/phi(q)<=7.2539 sqrt(T/6e6)` with q<=T. For q<=B use the finite theorem at r=T and the old algebraic comparison. Otherwise T>B>1e12, so

```text
2q^(1/4) <=2T^(1/4) <=.002 sqrt(T)
                         <=7.2539 sqrt(T/6e6).
```

The last comparison follows from `.002^2*6e6=24<7.2539^2`. Thus this internal first-choice repair preserves the original constants.

## 2. Every second-choice branch

Actual source `MinorArcs/SecondFinal.lean:72` chooses a new approximation with `q'<=T^2/349`. For T<=S all fresh denominators are below B, and the finite theorem supplies the old logarithmic comparisons, including those with comparison radius above B. For T>S use the raw estimates with `v=q'/phi(q')<=2sqrt(T)`.

The complete calculation and source review are in `SECOND_CHOICE_WEAK_TOTIENT.md` and `zero-sum/SECOND_CHOICE_WEAK_REVIEW.md`. The following are their actual normalized bounds, not replacements asserted for the old logarithmic helper statements:

| Contribution | Bound before division by T^3 |
|---|---|
| Type II M1, cases a1/b | `40(log T)^2 T^(11/4)` |
| Type II M2, cases a1/b | `88(log T)^2 T^(11/4)` |
| M3+M4 | `72(log T)^2 T^(5/2)` |
| Type II case a2 | `1.413(log T)^(3/2) T^(5/2)` |
| Type I1 | `12T^(5/2)+(.0407(log T)^2+6.1427 log T+9.8669)T^2` |
| Type I2 | `(.031(log T)^2+3185.8 log T+8455.3)T^2` |
| Assembly remainder | `9log T` |

All these estimates use T>=6e6. In particular `zeta3<=27` is the source bound for `1.27*zeta(3/2)^3`, not the numerical value of zeta(3). The M1 prefactors are bounded by `5T^(11/4)`, and the Type I1 bracket contains `2q'/phi(2q')<=2v`; these factors are already included.

After dividing by T^3 and using log T,T>=1, cases a/b give coefficient `11878.1813<12000`. The bridge case c uses the repaired first-choice theorem with `T/3.0001<=t<=T/3` and costs at most `456(log T)^2T^(-1/4)`. Consequently every second-choice branch at T>S satisfies

```text
|S_eta2(alpha,T^3)|/T^3 <=12000(log T)^2T^(-1/4).
```

The original hfun bound remains available below S. This is a genuine weakening of the pointwise theorem above the cutoff, not a purported proof that a power bound implies the old logarithmic comparisons.

## 3. One common envelope suffices

Define, for r>0,

```text
f(r) = (log r)^2/r^(1/4),
H(r) =12000 f(max(r,S)).
```

The already reviewed downstream first-branch correction is

```text
H1(r)=132 log^2(2max(r,B))/(2max(r,B))^(1/4).
```

For u>=B, `log(2u)/log u<=1001/1000`, and the exact inequality `(1001/1000)^8<2` implies `f(2u)<=f(u)`. Since f decreases above S,

```text
H1(r) <=132 f(max(r,B)) <=132 f(max(r,S)) <=H(r).
```

Therefore H, which is precisely the previous H2, covers both branches. There is no need to add H1 and H2. H is continuous and nonincreasing; rH(r) is increasing. Above S these facts follow from derivative signs `log r*(2-log r/4)<0` and `(3/4)(log r)^2+2log r>0`; below S they follow from the plateau. Thus

```text
H(min(1,w)n) <=H(n) max(1,1/w).
```

The actual source combines alternatives by a maximum: `LinftyLevels.lean:351` defines

```text
ghatY(y,n)=1.398 max(gx(y,n),hfun(y))+17(670/n)^3/3.
```

Its proof sets `M=max(gx y n)(hfun y)` at line 373 and calls `Prop1123b.norm_S_eta2_le_of_not_mem` at line 393 with separate first/second branch premises. Lines 395 and 399 use `le_max_left` and `le_max_right`. Replace that common M by `M+H(n)`; neither branch is added to the other.

For every w>=670/n, the source hypotheses give `z=wy>=2.16e20`, so T>=6e6. In the first branch the effective radius satisfies `min(1,w)n<=r_w<=T/6`; use the old gx comparison plus H1<=H. In the second branch use

```text
m=min(1,w)n <=(wy)^(1/3)/6=T/6.
```

This follows from the level hypothesis `n<=y^(1/3)/6`, separately for w<=1 and w>=1. If T>S, then `max(S,m)<=T`, whence the decreasing weak bound at T is at most H(m). For T<=S the old hfun estimate suffices. This does not assume the first-branch radius inequality in the second branch.

Hence both alternatives are bounded by `(max(gx(y,n),hfun(y))+H(n))*max(1,1/w)`. Integrating over the entire interval `[670/n,infinity)` adds at most `1.398H(n)`. The original small-w estimate `17(670/n)^3/3` is unchanged. No upper cutoff in w or global bound on its fresh denominator is required.

## 4. Initial, middle, and terminal layers for every x

Let r0=150000, m=r2, a=1.398, s=sig(x)/Dx(x). Raise the layer function to `ghatY(y,n)+aH(n)`. Its exact increase in `MinorTotal.Mexpr` is

```text
DeltaM/a = H(r0)(cL(r0)s-8.6294)
         + s sum_(r0<n<m) H(n)log((n+1)/n)
         + H(m)(sig(x)-cL(m-1)s).
```

For x>=4.9e26, the source energy and the proposed relaxed `.65*x*log x` alternative both permit `0<=sig<=log x`, `0<=s<=3`, `cL(r0)<15`. Put `Ls=log S` and `C=12000S^(-1/4)`. The three contributions are bounded respectively by

```text
45C Ls^2,
3C[Ls^3+4Ls^2+32Ls+128],
C Ls^2(8+4Ls).
```

For the middle sum, `H(n)log(1+1/n)<=H(n)/n<=integral_(n-1)^n H(t)/t dt`; extend to r0..infinity and integrate the plateau and decaying part exactly. This includes levels crossing S.

For the terminal term, retain the actual numerical witnesses. Finite cells through x=4.9e101 satisfy log x<235. Above that threshold the source chooses `m=floor((x/49)^(1/4))` with `m>=(x/49)^(1/4)/2`, giving `log x<8+4log m`. Above S the derivative of `H(m)(8+4log m)` has the sign of `-u^3+10u^2+16u`, u=log m. With u=12+v this is `-v^3-26v^2-176v-96<0`. Below S use the plateau. Thus the terminal bound is uniform, rather than a fixed tiny number multiplied by an unbounded log x.

Combining yields

```text
DeltaM <=1.398*12000*2^(-125)
                   *[7Ls^3+65Ls^2+96Ls+384]
       <16800*308121484/2^125 <1e-24.
```

The polynomial coefficient is 65, including the terminal constant 8. The companion `resume_totient_check_2026_11_11.py` checks the final inequalities with integers/Fraction and records input hashes; it passed. It does not validate the analytic lemmas in Lean.

Keep the original algebraic ghat and existing numerical cells unchanged. Adapt their consumer to the raised envelope. Any complete replay proving the old or relaxed-energy `Mexpr<=1.037` can use `Mexpr_new<=1.037001`; then the exact source final square split gives `1.03752314232<1.0376`. The relaxed .65 energy replay has its own parameter changes documented in `major-constants/MINOR_ENERGY_TOLERANCE.md`; it must not be inferred merely from this tail calculation. The base-gap provider remains separate and a bound by old ghat also bounds the raised function.

## 5. Other interfaces and the quotient branch

This removes producer R1 from the pointwise boundary in `integration/TYPEII_REMAINING_INPUTS.md` by changing its consumers. It does not prove unrestricted `Prelim.div_totient_lt`. The seven prime/Lambda producers P1–P7 and Mobius producers M1–M2 still need their own all-range replacements. In particular P7 is the dyadic prime log-square moment from 2e6, not a lower-order term. The raw Type I/II declarations currently retain `Fact PlattGRH`; their literal source statements cannot yet be imported as unconditional results.

The Mobius worker confirmed that the current small-u q=90090 work uses general Type I/II estimates and exact totients, with those same producer obligations. The first-choice repair above remains useful for its upper-w region.

The separate `LSQuot3.regionS` use is covered by the parent's new `REGION_S_ELEMENTARY.md` route. I read its mathematical argument and found no defect. It proves the weaker global estimate `n/phi(n)<=15log(max(2000,log n))` by an Euler-product log-moment and Markov argument. It splits the actual consumer at log q=2000: finite lambda/theta checks reduce the first range to the existing Mertens certificate through 100000; the second range gives `X<=.3log q`, sufficient for the original `.4log(qR)+.86` target. My review here does not independently replay its finite tables or replace the separate statement audit. Together the two routes cover the identified sharp-totient consumers on paper, subject to those formalizations.

## 6. What still blocks the full QRH route

The local principal 2750-cell calculation concerns only twists [-4,4]. The broad upper-major energy uses twists through 600000. Its Mellin-tail source condition is `T0>=200+max(10*pi*abs(delta),50)`, which reaches about 18.85 million, not 250. The reviewed model in `mellin/MAJOR_UPPER_PRINCIPAL.md` places multiplicity 15 at the symmetric points `7/8 +/-100i`, `1/8 +/-100i`. It satisfies the stated strip, mass, and Jensen-count relaxation yet forces model principal energy above .000135, exceeding the proposed .0001 allowance. This is a counterexample to that relaxation, not to the actual zeta target or QRH. A height-40 certificate would not remove it.

The mixed cap also needs more than two separate L2 bounds. Fixed integrals A and B allow a product integral AB/epsilon on a set of measure epsilon. The exact same-modulus character weights and joint four-zero kernel in `zero-sum/BLUEPRINT_MIXED_MOMENT.md` identify what additional estimate is needed. No certified pair-density/kernel aggregate meeting the corrected budget exists in the reviewed files.

The final target still needs major>=1.0404, minor<=1.0376, and nonprime reserve .00271, leaving .00009. This does not permit importing older larger cubic budgets. A far-asymptotic prime theorem likewise leaves moderate ranges open.

## 7. Finite zero certificates as a bounded alternative

There are two distinct paths. Proving the exact current finite `PlattGRH` proposition would allow the existing analytic proof to consume a theorem instead of an external premise. This meets the no-Platt-assumption objective but is not a proof obtained from QRH alone. A QRH-first hybrid can instead certify only selected low-conductor, finite-height regions, then use the proved strip and explicit Mellin tails outside them. Such a hybrid still needs a demonstrated sufficient cutoff and a mixed aggregate. Neither is currently available.

The historical computation is a concrete mathematical precedent, not a formal certificate already in the repository. Platt reports 29,565,923,837 primitive L-functions, roughly 3.8e13 zeros and 400,000 core-hours; his Theorem 7.1 covers q<=400000 with the parity-dependent heights, at least the nonprincipal range required here. Its method combines rigorously enclosed critical-line sign changes with Turing completeness. These counts and timings do not forecast Lean replay. [Platt, Numerical Computations Concerning the GRH, Sections 3 and 7](https://arxiv.org/pdf/1305.3087).

For a formal version, prove certified L-value evaluation and remainder bounds, the completed-function normalization, a complete zero-count theorem, character enumeration and conductor reduction, and boundary/nonvanishing checks. Compare the count of certified distinct critical-line roots with the total count including multiplicity. Treat negative heights through the correct conjugate-character relation, and handle zeta, poles, central points and inclusive endpoints explicitly. Then replay finite witnesses with proved checking soundness. Reusing a published table or adding a `Fact` for its conclusion is not this proof.

For the weaker hybrid, one can aim to certify zero count zero in rectangles `[3/4,9/10] x [-H',H']` with H'>H and verified nonvanishing boundaries. Global QRH excludes the remaining region to the right; a contour-count certificate then supplies beta<3/4 up to H without locating every critical-line zero. This is a precise possible certificate interface, not a proof of a chosen rectangle. Compared with beta<=7/8, its squared x factor improves by x^(-1/4), about 2.13e-7 at x0. The required conductor/height rectangle must first be selected by a complete principal/mixed tail calculation. A small arbitrary certificate would leave the same gap.

The next bounded experiment should therefore determine a sufficient principal finite window using the actual broad kernel and certified tails, then compare right-edge exclusion with critical-line counting on that window. In parallel, keep the mixed kernel and same-modulus density problem explicit. If a modest hybrid does not close those estimates, a full proved finite-RH certificate has less new analytic uncertainty but a much larger computation and formal-checker project. Neither alternative justifies a completion claim today.
