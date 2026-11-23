# Independent review of joint character and Fourier batching

2026-11-11. **PASS at the stated paper-derivation and exact finite-algebra scope. No correction requested.** The frozen plan has the correct off-critical normalization, parity weights, inverse-character labels, signed-frequency factors, error propagation and conditional operation counts. It does not establish a successful spectral contour or a practical full-family workload. None of the analytic or computational adapters is promoted to a Lean theorem by this review.

## Frozen inputs and checks

The reviewed author note is `../major-constants/JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md`, SHA256 `3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D`. Its script is pinned at `BADF7BBAE39D39E3676F284F13E934365D0350FFC633F66571BC171B0208E462`, and its receipt at `DB9D5DEB34FCDF492719BABA442BAE4C7B1546F1F6EF10FC4DB03AB8004B5357`.

I read the complete note and script, checked the predecessor formulas in the Gaussian, off-critical, full-right-slab and alias notes, and reread the actual completion/root-number declarations in Mathlib's `NumberTheory/LSeries/DirichletContinuation.lean:249,258,271,283` and `TernaryGoldbach/Explicit/LGrowthLeft.lean:221`. Source pins remain Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`.

New independent files in this directory:

* `review_joint_character_fourier_20261111.py`, SHA256 `4459FEA00C268944548236B44BAC796F77F240AED8C28631E5AFC1AB4AD8E5EB`.
* `review_joint_character_fourier_20261111.json`, SHA256 `DC36274DA2F6A9E5A82D056352107F39BAC3B7FC84AB18BF3B7B2DD057457722`.

The checker exited zero. All 12 pinned files matched. It replayed the author's 32 assertion checks without executing the receipt writer, then passed 120 independently coded rational-complex checks. Those cover cyclic character coordinates modulo 5, product coordinates modulo 8, extension by zero on nonunits, inverse-label conjugation, two-channel finite reordering, folding, and zero/Nyquist multiplicities. They contain arbitrary rational data, not Gaussian or spectral values. The analytic conclusions below follow from the written argument, not from sampling those finite examples.

The pending tilted companion was not used as an accepted input. The present plan derives its required tilted bounds directly from the reviewed Gaussian identities.

## Actual function, parity and character direction

The domain is an actual primitive nonprincipal character of conductor `c>1`, parity `a` in `{0,1}`, and `111/200<=sigma<=2`. The source completion is entire for a nonprincipal character. It is not replaced globally by a totalized Gamma product. On this positive-real-part slab, its Gamma factor is analytic and nonzero, so the completion and L-function have the same zeros and orders.

The source root number is the positive-additive Gauss sum divided by `i^a sqrt(c)`. Its norm-one theorem assumes primitivity, as required here. Starting from the Gaussian transform with odd coefficient `-i`, progression Poisson and primitive Gauss orthogonality give

`theta_chi(z)=W_chi z^(-a-1/2) theta_inverse(1/z)`.

The full integer theta series is twice the positive-index series: the terms at `m` and `-m` agree for the matching parity, and the zero term vanishes at `c>1`. Thus neither an extra factor two nor an extra odd-parity sign belongs in this reciprocity formula. The all-residue Gauss identity is required, including its zero value at nonunit frequencies. It is not valid to apply this step to arbitrary discarded imprimitive outputs.

For `lambda=sigma+a`, the angular Fourier kernel is

`G_sigma(x)=2 c^(-lambda/2) exp(lambda(x+ib)) theta_chi(exp(2(x+ib)))`.

The factor `c^(it/2)` in the equivalent source-completion expression for F, the positive imaginary shift `+ib`, and the inverse convention `F(t)=integral G(x)exp(ixt)dx` are all present. The conversion

`exp(-ib sigma)c^(lambda/2) F_sigma(t)=exp(-ib(sigma+it)) Lambda(sigma+it)`

is exact. Therefore the output is one fixed entire function `K(s)=exp(-ibs)Lambda(s)`, not a collection of differently scaled nonholomorphic restrictions. This conversion includes both the phase and the conductor modulus. No Hardy realness is used off the critical line.

## Finite batching and the two signed branches

Finite residue grouping gives the positive unnormalized unit-group transform of the buckets. The even bucket weights are 1 and the odd bucket weights are m. Both reuse the same Gaussian exponential and are independent of sigma. Nonunit terms vanish because actual characters extend by zero. The finite identity holds for all labels; analytic use retains only primitive labels of the matching parity.

For `x=-r<0`, let `w=-r+ib` and `mu=1+a-sigma`. The exponent after reciprocity is

`lambda-2a-1=-mu`.

Consequently the correct negative coefficient is

`2 W_chi c^(-lambda/2) exp(mu(r-ib)) theta_inverse(exp(2(r-ib)))`.

Conjugation of the direct buckets and negation of the character label give exactly the conjugate of the same positive-radius transform output. This proves the author's same-T cache formula, with its **distinct mu exponent and retained W factor**. In particular, mu can be negative at the right side of the slab. A same-character conjugation rule for G alone would be false off criticality. The separate critical-line corollary follows from `epsilon^2 W=1` and `|epsilon|=1`, hence `epsilon W=conj(epsilon)`.

The cache key must retain c, b, the exact frequency and the finite cutoff. Equality up to numerical rounding is not equality of arguments. The note observes this. Computing W once by a positive character transform of the additive exponential is consistent with the source convention; its input, transform and division errors still need certification.

For centered retained frequencies `-J,...,J-1`, the counts are `2J` signed indices and `J+1` magnitudes. Zero occurs once. The unpaired `-J` requires the magnitude-J theta value even though `+J` is omitted. The author's finite error sum counts each signed use of shared data, so conjugation reuse does not improperly halve the radius.

The alternate time-first schedule also has the correct exact identity:

`D_chi(U_plus)+W_chi D_inverse(U_minus)`.

Distributivity of finite sums proves it. It does not merge into one transform with one common diagonal factor. Its rounding proof must follow the actual time-first implementation; the primary schedule's radius statement is not automatically a proof for that implementation.

## Uniform analytic bounds and whole-panel conversion

I independently rederived the common bound. For `C=cos(2y)>0`, the Gaussian sum estimates yield the split-Gaussian prefactors

`sqrt(2)c^((1-sigma)/2)/sqrt(C)` and `4c^((1-sigma)/2)/(pi C)`.

If `0<q<=C<=1`, both are at most `2c/q`: use `c^((1-sigma)/2)<=c`, `q/sqrt(C)<=1`, and `4/pi<2`. Both real linear exponents, `sigma-1` and `-sigma`, are at most 1. Also `pi C/(2c)>q/c`. This gives

`|h_sigma(plus-or-minus r+iy)| <= Q_y(r)=(2c/q)exp(r-(q/c)exp(2r))`.

Writing `alpha=q/c` and substituting `u=exp(r)`, the two-sided zeroth moment is bounded by

`(4c/q) integral_1^infinity exp(-alpha u^2)du <= (4c/q) integral_1^infinity u exp(-alpha u^2)du <= 2c^2/q^2`.

The first absolute moment has an additional `log(u)` and obeys the same final bound because `log(u)<=u`. Both signs are already included. These estimates remain valid at sigma=1 and 2 and do not use the earlier invalid-at-endpoints factor `1/[sigma(1-sigma)]`.

Contour shifting to `+/-R0`, where `|b|<R0<pi/4`, gives decay rates `R0-b` on positive time and `R0+b` on negative time. Summing the corresponding copies yields exactly the stated Etime with arguments `P+t` and `P-t`. For frequency tails, the logarithmic derivative of Q is `1-2alpha exp(2r)`. Once `2alpha exp(2X)>1`, the geometric ratio and `1/(1-exp(-z))<=1+1/z` give

`Efreq <= 2 Q_b(X)(omega+1/(2alpha exp(2X)-1))`.

The negative omitted progression actually starts at `X+omega`; starting it at X is conservative. The theta cutoff ratio is likewise correct, and its different positive and negative scalar prefactors must both be retained. There is no additional phi(c) factor for the direct analytic theta tail, since that proof sums the actual coefficients with `|chi(m)|<=1` before any numerical bucket errors are introduced.

Differentiating in sigma gives `(x+ib-log(c)/2)G`. Differentiating the final scale contributes `log(c)/2-ib`, so both constant terms cancel. Thus

`K'(sigma+it)=A_sigma,a integral x G_sigma(x)exp(itx)dx`.

The stated bound `2c^4/q_b^2` follows from the first moment and `|A|<=c^(3/2)<c^2`. For a formal differentiation theorem at the closed slab endpoints, use the entire Mellin identity or first take a slightly larger compact sigma interval; Gaussian decay still dominates every fixed exponential and logarithmic factor there. This is a standard domination obligation, not an endpoint exception to the formula. Integration of this complex derivative bounds horizontal and vertical panel variation. An upper derivative bound alone supplies no positive value margin.

Every occurrence of q_R and q_b in the bound must retain the positive-rational condition introduced for q_y. In particular an arbitrary negative rational lower bound for cosine cannot be substituted into these formulas.

## Numerical error ledger

The exact unnormalized character transform has coefficient moduli one. Thus its input perturbation is `sum e_u`, not the maximum e_u and not a normalized average. The additional implementation error is measured against the exact transform of the centers. If a normalized transform is used, both its result and its error must be scaled by v.

The product bound is correct without a missing cross term:

`pT-hat(p)hat(T)=p(T-hat(T))+(p-hat(p))hat(T)`.

It gives `|p|E_T+rho_p|hat(T)|`, followed by multiplication roundoff. For the negative branch the prefactor error includes the root-number error. Correlations in reused pi, buckets or W cause no problem for deterministic triangle inequalities.

Folding adds all coefficient radii and any summation error. At a lattice point, the synthesis has scale omega for an unnormalized positive DFT, or omega*N for `ZMod.invDFT`. Therefore the radius contribution is `omega sum r_k`, followed by the time-transform error against exact center synthesis. No extra butterfly amplification applies to those already propagated input radii; internal center-arithmetic errors are a separate certified quantity. The final K product has the same valid decomposition and yields `c^(lambda/2)E_F+rho_A|hat(F)|+rho_out`.

The note correctly requires certification of actual frequencies `j*(2pi/P)`, not unverified rational substitutes. Such input errors belong in the relevant coefficient/prefactor construction. Off-grid values must use the unfolded polynomial or a separately proved adapter, because the folding exponential ceases to be one there.

## Work counts, closed contours and remaining obligations

For one conductor and one fixed frequency cache, the counts `R*Ntheta` Gaussian evaluations, at most `pR*Ntheta` bucket additions, `pR` character transforms of v entries, and `nR` retained primitive outputs are correct. There are then `Sn` time transforms, with `Sn*Nfreq` scalar combinations before sharing scalar prefactors. The time-first upper count `2pv` time transforms per sigma and at most `2p` character transforms per common output time is also valid. These are symbolic operation counts, not runtime predictions. A single nonempty parity need not pay for both parity transforms.

The distinction between shared frequencies and shared adaptive time nodes is essential and is respected. The model does not bound precision upgrades, failed panels, distinct tilts or grids, memory transposition, or external-record I/O. It cannot infer a throughput ratio merely from fewer repeated theta terms.

With one fixed b per slab, all its panels represent the same K. Different slabs may use different b only after their zero statements are transported through the explicit nonzero factors and combined geometrically. Raw polygon cancellation across different K functions is unjustified. Complete closed-side coverage, inclusive heights, actual multiplicities, inverse-character reflection and all-family label coverage remain obligations of the previously reviewed geometric assembly. No new example or bound in this plan supplies those data.

The outstanding work remains: source-to-manifest equivalence; implementation of the reviewed theta/Mellin/Poisson identities and uniform bounds; certified elementary bucket and root-number arithmetic; both checked transform normalizations and traces; the final holomorphic output and panel adapters; and actual successful complete contour records. The finite algebra checks and the paper construction do not replace any of these obligations, assume a spectral margin, or establish a new allowed root hypothesis.
