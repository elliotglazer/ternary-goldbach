# Explicit density bounds do not establish the selected excess budget

2026-11-11. Bounded research result. No Lean build, spectral scan, new premise, or change to the selected strategy. The conclusion concerns the explicit bounds inspected here, not an impossibility theorem for analytic number theory or a lower bound on actual zeros.

The accepted implication from `K<=6` remains useful as a weaker information requirement. The available explicit density estimates inspected below do not prove this requirement. Their direct weighted comparison bounds exceed the target by many orders of magnitude. Both papers also use previously computed finite zero information in their proofs, so importing them unchanged would not remove that dependency. No reduction in production work has been established.

## 1. Fixed inputs and exact family

This note uses `WEIGHTED_EXCESS_CERTIFICATE_2026-11-11.md`, SHA256 `5039FA2BE3CD7062E99B75CC82F84F2B154E88714E19F140461FD954F8C67FF2`, and its independent review `audit/REVIEW_WEIGHTED_EXCESS_CERTIFICATE_2026-11-11.md`, SHA256 `D4F0619A50B3DF6BAFFCA051108F64A1DB2491F13BDB9CE31EF17C5F03C0B948`.

Put `b=111/200`, `a=7/8`, `x0=49*10^25`, and `y0=10^25`. The large-conductor set is

```
C = {c odd : 100000<c<=150000}
  union {c : 4 divides c, 100000<c<=300000}.
```

Its 75000 conductors carry 3695775113 primitive characters, by the already reviewed arithmetic census. This count includes every primitive label, with no division by conjugation or inverse pairing.

For every `c in C`, the selected height is exactly `Hcert(c)=10^8/c`. For odd conductors the old height is at least 1200, greater than `10^8/c`. For even conductors its nonconstant term alone is `(704/7)*1200000/c > 10^8/c`. Thus the actual heights lie in `[1000/3,1000)`. The upper cutoff is inclusive; neither a floor nor a ceiling is silently substituted.

All counts below include multiplicity, both signs of the ordinate, and real nontrivial zeros. The global QRH input restricts real parts to `[1/8,a]`. The unchanged finite `.555` requirement for `c<=100000`, the principal refinements, and all other roots of the selected proof remain required.

## 2. Exact density integral and a simpler sufficient inequality

For `b<=s<=a`, define

```
g_z(s)=z^(s-a)-z^(b-a),                 z in {x0,y0},
k(s)=max(g_x0(s),g_y0(s)),
D_C(s)=sum_(c in C) sum_(chi primitive mod c)
       # {rho : Re rho>s, |Im rho|<=10^8/c}.
```

The number sign includes analytic multiplicity. These are finite sums, so exchanging them with an integral requires no convergence assumption. Since `k(b)=0` and `k` is continuous, increasing, and absolutely continuous,

```
K = integral_[b,a] D_C(s) dk(s).                         (1)
```

For a zero with real part `beta`, the integral of `1_(s<beta)` is precisely `k(beta)`. In particular, zeros on the top line `beta=a` are included. Changing `>` to `>=` in the density definition changes only finitely many integration points. The measure `dk` has no atoms. No endpoint exception or factor two is missing.

An exact derivative version of (1) chooses `g_x0'(s)` where `g_x0(s)>g_y0(s)` and `g_y0'(s)` where the reverse inequality holds. At equality the choice is immaterial almost everywhere. There is no need to locate the internal crossing numerically.

For any proved majorant `D_C(s)<=B(s)`, the sufficient condition is

```
integral_[b,a] B(s) dk(s) <= 6.                          (2)
```

An easier, stronger condition that avoids the maximum is

```
integral_b^a B(s) [log(x0)*x0^(s-a)
                   +log(y0)*y0^(s-a)] ds <= 6.          (3)
```

Indeed, summing `k(beta)<=g_x0(beta)+g_y0(beta)` over the actual zeros gives (3) directly. This argument does not infer an ordering of Stieltjes measures merely from pointwise ordering of their primitives.

A conductor-resolved theorem can be inserted before summing in (1). A rectangular hybrid bound for conductors at most `Q` and heights at most `T` could be used with `(Q,T)=(300000,1000)`. Disjoint conductor blocks may instead use their own enclosing rectangles. Subtracting two cumulative upper bounds is not a valid bound for an annulus; a block estimate must be proved separately or bounded by the full larger rectangle.

## 3. What the target requires near the right edge

The rational-power checker encloses `k(s)` using integer powers and bisection, without evaluating any L-function. It gives the following necessary consequences of `K<=6`.

| Lower bound on real part | Maximum possible number of occurrences in this entire family |
|---|---:|
| `.60` | 48641230 |
| `.70` | 142316 |
| `.75` | 8001 |
| `.80` | 449 |
| `.85` | 25 |
| `.875` | 6 |

Each entry follows from `count*k(s)<=K`. These marginal conditions are not jointly sufficient; the integral in (2) accounts for all real parts at once. Their purpose is to quantify the missing input. In particular, a generic bound allowing thousands of rightmost zeros cannot establish this budget.

## 4. Two explicit primary-source comparisons

Thorner and Zaman define a cumulative primitive-family count with `q<=Q` and `|gamma|<=Q`, including multiplicity. Their Theorem 1.2 is restricted to `s>=39/40`, above our entire interval. Corollary 6.1 extends to `s>=0` with

```
B_TZ(s)=10^88*(10^421*Q^127)^(1-s), Q>=3.
```

Use `Q=300000`. The proof also uses finite computations: Lemma 2.2 invokes Platt, and Lemma 2.1 invokes a finite zeta verification. These are ordinary published mathematical inputs, but they are not discharged Lean inputs in this campaign. The starred exceptional-zero count cannot replace the unstarred count while dropping the excluded zero. [Primary paper, arXiv v4, pp. 1-3 and 21](https://arxiv.org/pdf/2208.11123v4).

For every `s in [b,a]`, elementary monotonicity gives

```
B_TZ(s)>=B_TZ(a)>10^[88+(421+127*5)/8]=10^220.
```

The checker proves `k(a)>.99`. Consequently the right side of (2), when formed with this published majorant, is greater than `.99*10^220`. This is a lower bound on the resulting comparison expression, not on `K`.

Ramaré's Theorem 1.1 gives, for `T>=2000`, `T>=Q>=10`, and `s>=.52`,

```
sum_(q<=Q) (q/phi(q))*sum_(primitive chi) N(s,T,chi)
 <= 20*(56*Q^5*T^3)^(1-s)*log(Q^2*T)^(5-2s)
       +32*Q^2*log(Q^2*T)^2.                            (4)
```

The count uses both ordinate signs. Since `q/phi(q)>=1`, this also bounds our unweighted subfamily after enlarging the height. The smallest global permitted choice is `T=Q=300000`, not `T=1000`. The paper's p. 4 minimal-range reduction explicitly uses finite GRH information. We do not import its separate zeta estimate or its constants. [Author's primary manuscript, Theorem 1.1 and notation, pp. 1-4](https://ramare-olivier.github.io/Maths/DensityEstimate-34.pdf).

The positive additive term of (4) is already greater than

```
32*(300000)^2*36^2 = 3732480000000000,
```

because `log(300000)>12`. Therefore its contribution to (2) alone exceeds `3695155200000000`. Discarding it to advertise a stronger density estimate would be invalid. The pointwise minimum of these two printed majorants still exceeds this latter integral bound.

These comparisons are deliberately generous: even treating both printed estimates as available inputs does not close (2). Their formal dependency issues cannot improve this numerical conclusion. Retooling their proofs for the short hyperbolic region is a new theorem, not an application of their stated bounds.

## 5. Why this is a limitation of the estimates

The inspected density inequalities allow, as abstract count data, four conjugate pairs at `beta=a`, ordinates `1,2,3,4`, for the real primitive quadratic character of conductor 100003, together with their reflected pairs at `beta=1-a`. This conductor is prime, active, and has height above 4. The right-half occurrences give `K=8*k(a)>7.92>6`. The data respect conjugation, reflection, the QRH strip, and the finite upper-count constraints used in these comparisons. All of the printed density right sides at the relevant parameters are far above 16. This is not a claim that any such zeros exist, nor that this artificial spectrum satisfies every identity of an actual L-function. In particular it contradicts the published finite-RH conclusions used inside these papers. It is a countermodel only to the extracted density inequalities, symmetries, and upper-count conditions, not to those papers with all their auxiliary results. It demonstrates that the selected upper bounds alone do not imply the desired conclusion.

As a scale diagnostic only, even the unasserted unit-constant function `B(s)=(Q^2*T)^(2*(1-s))` at `Q=300000,T=1000` gives about `199234` on integrating just the `y0` kernel in (3). That hypothetical formula is not cited as a theorem and is not needed for the exact obstruction above.

The bounded search also checked the primary research pages for newer explicit Dirichlet-family work. Kadiri lists a relevant manuscript as in preparation, without an available theorem there; no unpublished constants are used. [Author's research page, current research work](https://sites.google.com/view/habibakadiri). This is not a claim to have exhausted every density estimate.

## 6. Deliverable and remaining obligation

The exact missing analytic result is (2), or the stronger explicit integral inequality (3), for the actual hyperbolic family in section 1. A proof could combine certified conductor or real-part subregions with a density bound on their complement. All complement terms must remain present. The retained small-conductor and principal obligations would still be required. The present comparison supplies no algorithm that can skip primitive rows.

The companion `weighted_excess_density_feasibility_20261111.py` uses `Fraction` and integer powers for the asserted inequalities and the necessary-count table. Its decimal block is marked diagnostic. The JSON records the two frozen input hashes. It performs no spectral evaluation. Run it with the existing interval environment's Python. The primary Ramaré PDF and rendered p. 2 are saved as `density_ramare_primary_20261111.pdf` and `.png`. The page image confirms the coefficient `20` and the factor `56` inside the power; text extraction had concatenated them. The exact obstruction uses only the separately verified additive term. The accepted weighted implication, exact final numerical reserve, and selected proof requirements are unchanged.
