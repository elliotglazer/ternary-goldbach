# A unit-group transform for simultaneous character evaluation

2026-11-11. Research proof and implementation plan, submitted for independent review. A fixed exact sample s at a fixed modulus c can share its Hurwitz coefficients across all characters. The transform acts on the actual unit group, including its noncyclic two-primary factor. No numerical transform, all-family data, runtime experiment, Lean proof, build, or package modification is supplied.

The plan preserves the selected primitive-character manifest, Hcert, all spectral targets, and the original Goldbach root without new analytic premises. It changes how coefficient sums can be computed and certified. It does not prove nonvanishing, a contour winding, completeness, or saturation.

## 1. Source and manifest boundary

The target is `work/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Mathlib is at `56a005855ea17e0b0958f73ec801ae140b0a1679`, under `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`.

The accepted coordinate plan is `zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md`, SHA256 `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54`. Its independent review is `integration/REVIEW_FAMILY_CHARACTER_MANIFEST_2026-11-11.md`, SHA256 `EEE3BAE662500804EAEC0268A8612D0E01ED1C2FAF5D0208D442A97739794664`. These paths are relative to `work/qrh-campaign/agents/`. The review's generic-quantifier erratum applies: every ambient character, including an imprimitive one, is induced from its unique primitive conductor-label pair.

The following Mathlib interfaces were read directly.

| File and location | Exact role |
| --- | --- |
| `NumberTheory/LSeries/DirichletContinuation.lean:60,74` | `DirichletCharacter.LFunction` is `ZMod.LFunction`; equality with `LSeries` is only asserted for Re(s)>1. |
| `NumberTheory/LSeries/ZMod.lean:85` | `LFunction Phi s = c^(-s) * sum_j Phi(j) * hurwitzZeta(toAddCircle j,s)`. |
| `NumberTheory/LSeries/ZMod.lean:124,135` | Differentiability when s!=1 or the coefficient sum is zero; global differentiability for zero coefficient sum. |
| `NumberTheory/LSeries/HurwitzZeta.lean:89,97` | The source subtraction at s=1 is `1/(s-1)/GammaR(s)`, not just `1/(s-1)`. |
| `NumberTheory/LSeries/HurwitzZeta.lean:104` | `differentiable_hurwitzZeta_sub_hurwitzZeta` proves every difference of two source Hurwitz functions differentiable everywhere. |
| `NumberTheory/MulChar/Basic.lean:609` | `sum_eq_zero_of_ne_one` gives the vanishing character sum for a nonprincipal character. |
| `Analysis/Fourier/ZMod.lean:106,114,176` | `dft_apply` uses the negative exponent with no normalization; `invDFT_apply` uses the positive exponent divided by the length; `dft_dft` gives length times index reversal. |

Source-file SHA256 values are respectively `D756ABE5CB941F1210DC7DDDC90F68F120148BB6A45AC4E6C4282C3070FBC17D` for LSeries/ZMod, `5AA1270696F59F95417054D77E156BAB2DCD42F6AFDF7318CF1A2944298818B3` for HurwitzZeta, and `012663E2EB3A3F3196C6BCE04CB530D04E29C8DE8C65AFE703F2D707484EFE10` for Fourier/ZMod. These are source observations, not successful elaboration or axiom checks.

## 2. Exact array and character labels

Assume c>1. Factor c and use precisely the recorded generators, CRT order, and coordinate isomorphism from the manifest:

```
X = product_i ZMod(m_i),    n = product_i m_i = phi(c),
u : X ~= (ZMod c)^units.
```

An odd p^k contributes one coordinate of order `(p-1)*p^(k-1)`. A factor 4 contributes the sign coordinate of order 2. A factor 2^k with k>=3 contributes the two separate orders `2, 2^(k-2)` representing `(-1)^e*5^f`. A factor 2 contributes none. Factors are in increasing prime order, with the sign coordinate before the five-power coordinate.

For x in X let a(x) be the integer representative of u(x), with 1<=a(x)<c. Set `a0=a(0)=1`. Fix positive roots `omega_i=exp(2*pi*I/m_i)`. A label r in the same product denotes the actual source character

```
chi_r(u(x)) = product_i omega_i^(r_i*x_i),
chi_r(nonunit) = 0.
```

The manifest's surjectivity and uniqueness proof identifies these with every source character, rather than merely showing equal array sizes. Recorded generators and CRT inverses need their own exact arithmetic witnesses.

Use zero-based mixed-radix indexing with the last coordinate fastest:

```
index(x) = sum_i x_i * product_(j>i) m_j.
```

The same convention applies to input x and output r. A library's strides, digit reversal, axis order, and output permutation must be proved to realize this indexing. This is a Fourier transform of the unit-group coordinates, not the additive transform of all residues modulo c. Padding nonunits into a length-c additive DFT does not compute these character rows.

## 3. Coefficients and the actual L-function

At an exact s!=1 one may use the raw coefficient array

```
A_s(x) = hurwitzZeta(toAddCircle(a(x)),s).
```

Here `toAddCircle` is the source map on `ZMod c`, so its real representative is a(x)/c. Removing the zero nonunit terms from the source finite sum gives, for every label including the principal one,

```
LFunction chi_r s = c^(-s) * Tplus(A_s)(r),
Tplus(A)(r) = sum_x A(x) * product_i omega_i^(r_i*x_i).       (1)
```

This uses the actual definition and a finite reindexing. No interchange with a conditionally convergent Dirichlet series is required. Equality to classical Hurwitz coefficients can first be proved in Re(s)>1 and continued when constructing the numerical evaluator.

For the selected primitive rows at c>1 a useful alternative is the centered array

```
D_s(x) = hurwitzZeta(toAddCircle(a(x)),s)
           - hurwitzZeta(toAddCircle(1),s).
```

Every D_s(x) is entire in s by the source difference theorem, and D_s(0)=0 exactly. For r!=0 the root sum is zero, so

```
Tplus(D_s)(r) = Tplus(A_s)(r),
LFunction chi_r s = c^(-s) * Tplus(D_s)(r)                  (2)
```

holds for every s, including s=1 with the source convention. All primitive characters at c>1 are nonprincipal, so every selected output uses (2). A finite Euler--Maclaurin evaluator can certify this difference directly, or subtract two analytically deflated Hurwitz functions. If the latter uses the ordinary subtraction 1/(s-1), the difference agrees away from 1 and hence at 1 by holomorphic continuation. It must not identify the individual finite parts with Mathlib's individual totalized Hurwitz values. The common difference removes that issue.

For r=0, centering changes the transform by `n*A_s(0)`. Recovering the principal row away from 1 requires adding this term, or evaluating that row separately. At s=1 the raw source principal value has its own totalization and is not a holomorphic principal L-value. This plan makes no claim that an ordinary finite-part evaluator returns it. Conductor one remains the separate zeta/pole-normalized branch.

One can also subtract any common coefficient or use a proved parity-paired array. Such choices need the same algebraic cancellation proof and a new error bound. They must not silently delete a principal row or assume that complex character values are real.

## 4. Tensor factorization and signs

Apply the unnormalized positive transform along each axis in turn. After processing the first j axes the exact intermediate array is

```
A^(j)(r_1,...,r_j,x_(j+1),...,x_d)
 = sum_(x_1,...,x_j) A(x) * product_(i<=j) omega_i^(r_i*x_i).
```

The formula follows by induction using only finite sum distributivity. At j=d it is Tplus. Axis transforms commute after the corresponding index identifications. No cyclicity of the whole group is needed.

For a source `ZMod.dft` call on one axis,

```
Tplus_m(v)(r) = ZMod.dft(v)(-r)
              = m * ZMod.dft.symm(v)(r).
```

Consequently a multidimensional negative-exponent transform must reverse every output label, or a normalized multidimensional inverse transform must be multiplied by n. There is no extra 1/n in (1) or (2), and the c^(-s) factor is unrelated to DFT normalization. Reversing labels means r_i maps to (-r_i mod m_i); it is the manifest's inverse-character map.

At c=40 the dimensions are `(2,2,4)` and the positive kernel is `(-1)^(e*x_e+f*x_f) * I^(r*x_5)`. Primitive rows have f=1, r in {1,2,3}, either e. At c=120 dimensions are `(2,2,2,4)` and primitive rows have f=r_3=1, r_5 in {1,2,3}, either e. These are noncyclic examples, not single length-phi(c) cyclic transforms. Replacing `(2,2,4)` with cyclic length 16 gives different characters.

Orthogonality gives an exact consistency identity

```
sum_r |Tplus(A)(r)|^2 = n * sum_x |A(x)|^2.
```

It can diagnose convention errors but does not by itself certify each row. In particular, a permutation or conjugate-label error can preserve this identity.

## 5. Primitive extraction and shared work

Compute all n transform outputs, then retain the manifest's primitive labels. At an odd prime p, retain r!=0; at odd p^k, k>=2, retain p not dividing r. At 4 retain its nontrivial sign; at 2^k, k>=3, retain odd five-power label and either sign. Combine these local predicates. Level c with exactly one factor of 2 has no primitive rows.

Each retained record carries `(c,r,s,coefficient-proof-id,transform-proof-id)` and the exact source-character identification. Parity is the sign coordinate plus the odd-prime labels modulo 2; the inverse label negates all coordinates. These metadata checks remain necessary even if only primitive outputs are serialized. A nonreal row and its inverse are distinct outputs at the same complex s. They are not generally complex conjugates there; the conjugation identity relates samples at s and conjugate(s).

This shares n coefficient evaluations per sample rather than independently redoing them for each character. Even without a fast transform it avoids repeated special-function evaluation. A naive direct sum for every row still costs n^2 scalar terms. Direct transforms one axis at a time cost on the order of `n*sum_i m_i` terms. Certified fast transforms for each axis would reduce this to on the order of `n*sum_i log(m_i)=n*log(n)` arithmetic operations, provided suitable algorithms for the actual lengths are implemented.

The lengths p-1 need not be smooth. A prime-length axis requires a separately justified algorithm such as Bluestein with certified chirps/convolution, Rader with a checked permutation, or a direct fallback. Nothing in this note proves that an arbitrary FFT library is correct or gives its rounding error. The natural first proof can use the finite tensor definition while a later executable refinement proves an efficient butterfly schedule computes it.

Memory for a single in-place transform is on the order of n complex balls plus tables/workspace, not n^2 stored character entries. Reuse applies only to the same exact s at the same c. Character-specific adaptive contour nodes do not automatically share an array; batching common nodes or fixed panels would be an additional scheduling choice. This plan supplies no speed or total family cost measurement.

## 6. Certified errors

Use complex disks or enclosing rational rectangles with a proved conversion to norm radii. For a fixed sample suppose `|A(x)-ahat(x)|<=eps_x`. With exact roots the input uncertainty of every output is at most

```
E_input = sum_x eps_x.                                    (3)
```

This worst-case bound needs no independence assumption. An identical coefficient error reused across rows must not be treated as statistically independent. For centered coefficients, independently subtracting balls gives `eps_x<=eps_raw_x+eps_reference`; direct difference evaluation or symbolic cancellation of a common offset may improve that bound, but requires its own proof.

At any certified butterfly, let an exact input z satisfy `|z-zhat|<=E`, and let the exact unit-modulus root w have midpoint what and `|w-what|<=delta`. The product enclosure may use

```
|w*z - round(what*zhat)| <= E + delta*|zhat| + eta_mul.
```

Here eta_mul bounds actual rounding in the multiplication. This follows by splitting `w*(z-zhat)+(w-what)*zhat`; there is no missing delta*E term with this particular split because |w|=1. Addition sums the incoming radii and its own rounding bound. For a direct m-term axis transform with maximum incoming radius E and midpoint norm Amax, a valid uniform update is

```
E_next <= m*E + m*delta*Amax + eta_axis,
```

where eta_axis includes every operation's rounding and summation error for that output. For an actual fast-transform circuit, propagate the local product/addition bounds through its exact schedule instead; the direct-axis formula must not be substituted as an unproved FFT error theorem. Certified convolution refinements need their normalization, chirp, and convolution errors included.

Finally let p=c^(-s), with certified `|p|<=P`, `|p-phat|<=eps_p`, and transformed midpoint vhat with radius E. A safe final L-ball radius is

```
P*E + eps_p*|vhat| + eta_final.                            (4)
```

For exact s, `|p|=c^(-Re(s))`; the real exponential bound must itself be enclosed. For uncertain sample coordinates, first bound the same analytic sample expression on its input ball or include a derivative-based perturbation bound. Evaluating the center alone does not certify every point in a sample ball or an entire contour segment.

A row ball excluding zero proves only nonvanishing at its certified sample set. Contour nonvanishing, winding, logarithm continuation, and the multiplicity-aware completeness consumer still require their existing separate analytic enclosures.

## 7. Implementation obligations and rejection tests

The future proof order is the manifest coordinate equivalence, exact unit-sum reindexing, centered-Hurwitz identity, tensor finite-sum theorem, source DFT sign/scaling adapter, executable transform refinement, then the enclosure propagation theorem. A coefficient provider can independently prove balls for each source difference, including Euler--Maclaurin truncation and elementary-function rounding. Neither branch needs the spectral theorem it will later help certify, so this order introduces no logical cycle.

An executable record must bind c and its checked factorization/generators/CRT map, dimensions and flattening order, the exact sample s, coefficient interpretation, roots/sign/normalization, circuit and working precision, propagated error bounds, output-label permutation, and primitive-selection predicate. Library output without these links is candidate data only. A pure-kernel checker would need proofs for its integer/rational operations and the relevant finite formulas; those are not supplied here.

Before any spectral use, require the following tests in addition to general correctness proofs:

* A delta input at coordinate y gives exactly `product_i omega_i^(r_i*y_i)` at label r. An order-four axis detects a negative-sign swap which order-two axes cannot.
* The constant-one array has output n at r=0 and zero at every other label. This detects normalization but not all permutations.
* Full `(2,2,4)` and `(2,2,2,4)` test arrays compare the tensor outputs with direct sums using the recorded actual-residue character table. Do not compare only two implementations sharing the same mistaken flattening convention.
* Corrupt one CRT generator, inverse-label mapping, twiddle sign, normalization, or primitive predicate. Source identification or the exact transform check must reject it.
* Check a centered array at s=1 against an independently established source difference identity. Do not use a principal finite-part row as a test oracle for Mathlib's totalized principal value.
* Increase coefficient or twiddle radii and verify output enclosure propagation. A small midpoint residual alone cannot validate a ball bound.

These are specified tests, not experiments run for this note. The general source-to-transform proof, a certified coefficient engine, efficient circuit implementation, all actual selected samples, and the full spectral/completeness evidence remain to be produced.
