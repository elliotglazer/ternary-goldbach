# Independent review of the family Gaussian Fourier identity

2026-11-11. Verdict: PASS for the stated mathematical derivation and source-level proof plan. I found no blocking normalization, convergence, parity, phase, or contour-shift error. This is not a Lean proof, an axiom audit, a numerical certificate, or a proof of FFT sampling completeness. No Lean build or numerical experiment was run for this review.

The reviewed author file is `../zero-sum/FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md`, SHA256 `5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41`. Its bytes were checked unchanged at review completion. The source pins are Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. The author note and all frozen packages remain unchanged.

## Exact accepted statement

The domain is an actual primitive nonprincipal complex Dirichlet character chi of integer conductor c>1. Let a be its parity in {0,1}, k=a+1/2, and use the positive-exponent additive Gauss sum tau. Put W=tau/(i^a sqrt(c)) and fix one constant epsilon with norm 1 and epsilon^2 W=1. For real eta with |eta|<1 and b=pi eta/4, the input is

```
Lambda(s) = c^((s+a)/2) completedLFunction chi s
F_eta(t) = epsilon exp(b*t) c^(i*t/2) completedLFunction chi (1/2+i*t).
```

With the angular transform `(1/(2*pi)) integral F_eta(t) exp(-i*x*t) dt`, its value is

```
2 epsilon c^(-k/2) exp(k*u)
  * sum_{n>=1} n^a chi(n) exp(-pi*n^2*exp(2*u)/c),
u = x+i*b.
```

All the integrals and series in this assertion converge absolutely. Eta is real; u is the complex shift. The endpoints eta=+/-1, conductor 1, and imprimitive characters are outside this statement. No claim for those excluded cases follows by substitution.

## Independent normalization and phase checks

Mathlib's `completedLFunction` omits the conductor factor. `DirichletContinuation.lean:258` expresses L as the completion divided by its parity-dependent Gamma factor; `Gamma/Deligne.lean:48,69` supplies the GammaR formula and nonvanishing in the positive half-plane. Thus on Re(s)>0,

```
c^((s+a)/2) completedLFunction chi s
  = (c/pi)^((s+a)/2) Gamma((s+a)/2) L(s,chi).
```

At s=1/2+it, multiplication by c^(-k/2) leaves exactly c^(it/2). Dropping that phase would change the transform. Defining Lambda through the source entire completion is necessary: the naive totalized Gamma-times-L product is not a valid definition at every Gamma pole.

I independently differentiated the even Gaussian transform in the negative-exponent Fourier convention. The odd transform is

```
Fourier[v exp(-pi*z*v^2/c)](xi)
  = -i (c/z)^(3/2) xi exp(-pi*c*xi^2/z).
```

The coefficient is -i. At xi=m/c, the general parity formula contributes `(-i)^a sqrt(c) z^(-k) m^a`. The progression Poisson formula contributes 1/c, and the positive additive Gauss sum contributes tau. Their product is precisely W z^(-k), with no extra parity sign or conductor power.

The all-residue Gauss identity is essential. Mathlib `DirichletCharacter/GaussSum.lean:57`, `gaussSum_mulShift_of_isPrimitive`, includes nonunits and zero. A unit-only substitution would not suffice. The source's negative-exponent finite Fourier transform instead has chi-inverse(-m); the author correctly distinguishes that convention. The full integer theta series equals twice the positive-index series in both parities. The zero term vanishes because c>1 implies chi(0)=0. The two factors of 2 cancel in the theta functional equation.

Consequently the theta transformation is

```
theta_chi(z) = W z^(-k) theta_(chi inverse)(1/z), Re(z)>0.
```

Both z and 1/z stay in the right half-plane, so the principal powers used here are consistent. In the log-variable strip |Im(w)|<pi/4, `Log(exp(2*w))=2*w`; there is no hidden branch change in the decay estimates.

The source functional equation at `DirichletContinuation.lean:283` has the orientation `completion_chi(1-s)=c^(s-1/2) W completion_inverse(s)`. Conductor normalization and replacing s by 1-s give the author's equation for Lambda. Conjugating the theta integral gives `conj Lambda_chi(s)=Lambda_inverse(conj s)`, so on the critical line Lambda=W conj(Lambda). The phase equation implies epsilon W=conj(epsilon), hence epsilon Lambda is real even for a nonreal character. This uses a phase fixed for that character. It does not impose, or prove, compatibility with a separately selected phase for the inverse character. Any opposite-height reuse rule still needs that adapter.

## Absolute convergence and continuation

The termwise theta derivative bounds are valid on every compact subset of Re(z)>0: the relevant majorants are polynomial factors in n times a Gaussian. The transformed theta series gives the required decay as z approaches zero, which the defining positive-index sum alone would not provide.

For a closed strip |Im(w)|<=B<pi/4, d_B=pi cos(2B)/c is strictly positive. I checked both halves of the author's bound

```
|h(v+i*y)| <= 2 c^(-k/2) C_a(d_B)
               exp(k*|v| - d_B*exp(2*|v|)).
```

For v<0 the factor exp(-2kv) from the theta functional equation combines with exp(kv) to produce exp(k|v|). This bound is uniform in the closed strip and has faster than polynomial decay at both real ends. Cauchy estimates on a slightly larger closed strip supply the same qualitative decay for derivatives. The finite radius shifts the real coordinate in the bound, but does not remove the two-ended decay. In particular h_b and its first two derivatives are integrable and tend to zero at both ends.

The Mellin integral is entire because the two-end theta estimates dominate arbitrary fixed real powers and logarithmic factors uniformly on compact sets of s. The only exchange of the theta sum and integral occurs in Re(s)=sigma>1. The sum of the integrals of norms is bounded by

```
Gamma((sigma+a)/2) (c/pi)^((sigma+a)/2) sum_{n>=1} n^(-sigma),
```

which is finite. This agrees with the explicit absolute-integrability hypotheses in `MellinEqDirichlet.lean:24`, `hasSum_mellin`, and with `LFunction_eq_LSeries` at `DirichletContinuation.lean:74`. The source nonprincipal completion is entire at line 249. The identity theorem then extends the Mellin equality to the critical line. No critical-line Dirichlet series is interchanged with an integral.

## Contour shift and inversion

The substitution y=exp(2v) gives dy/y=2dv, producing the leading factor 2 in h. It yields `F_0(t)=integral h(v) exp(i*t*v) dv` exactly. On the rectangle between heights 0 and b, the exponential factor is bounded by exp(|t|B) for each fixed t. The uniform two-end estimate makes both vertical edges vanish. The orientation works for either sign of b.

Since `exp(i*t*(v+i*b))=exp(-b*t) exp(i*t*v)`, the shifted inverse transform is `exp(b*t) F_0(t)`. The positive tilt therefore requires the positive imaginary shift. Neither a conjugate character nor an extra root number appears in this shift.

Two integrations by parts give the t^(-2) bound, and the L1 norm of h_b bounds the transform near t=0. These prove absolute integrability of F_eta. The substitution t=2*pi*y then cancels the angular normalization factor 1/(2*pi), yielding `Fourier(FourierInv h_b)=h_b`.

One implementation detail should be made explicit when using the named source theorem. At `Fourier/Inversion.lean:184,193`, even `fourier_fourierInv_eq` takes `Integrable (Fourier h_b)` as its second hypothesis. Equation (12) first gives the inverse transform. The needed forward-transform premise follows immediately from

```
Fourier h_b(y) = F_eta(-2*pi*y),
```

and affine change of variables, or by applying the same two integrations by parts to the negative-exponent transform. Thus the author's claim that the premises follow from the derivative decay is correct. This is a proof adapter to implement, not an absent analytic hypothesis or a requested correction to the frozen note.

## Source support and remaining work

The checked source interfaces support the proposed route. The Gaussian formulas at `Gaussian/FourierTransform.lean:208,228` allow complex Gaussian coefficients with positive real part. `FourierTransformDeriv.lean:784` requires integrability of f and v*f for differentiation of its transform; line 792 requires integrability of f and its derivative and differentiability of f. The Gaussian and h_b estimates provide those hypotheses. The Poisson theorems at `PoissonSummation.lean:190,201,215` provide shifted unit-lattice formulas, so the progression r+cZ still needs the author's stated scaling adapter. `MulChar/Lemmas.lean:73,79` supplies conjugation as character inversion. The target `Explicit/LGrowthLeft.lean:221` proves the root number has norm 1 under primitivity, without a Platt premise.

The finite Gaussian error bounds are also correct. The ratios of the positive majorants decrease with n. For parity zero the first omitted ratio is exp(-d(2M+3)); for parity one it is `(M+2)/(M+1)` times that exponential and must separately be below 1. The geometric series bound multiplies by the full prefactor `2 c^(-k/2) exp(k*x)`. Character zeros do not invalidate this argument because it bounds positive majorants rather than dividing actual character terms. Reciprocal-argument evaluation at negative x needs the same theta equation and inverse-character data.

The following work remains open and is not certified by this review:

- Implementing the parity-unified progression Poisson formula, character theta transformation, entire Mellin identity, uniform strip estimates, and inversion adapters in Lean.
- Connecting interval character and root-phase data to these exact source functions and proving all rounding bounds.
- Proving discrete FFT periodization, interpolation, and alias-error bounds, then producing and checking the actual finite data.
- Proving the separate count-completeness result and any partner-phase reuse rule.
- Handling the principal conductor-one row through its separate theta constant and pole corrections.

This identity introduces no zero-free premise, does not certify a family height, and does not change Hcert. It also does not replace the remaining kernel checks or make any assertion about the eventual exported theorem's axiom dependencies.
