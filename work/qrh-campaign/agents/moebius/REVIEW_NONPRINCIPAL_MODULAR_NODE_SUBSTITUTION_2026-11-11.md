# Review of modular nonprincipal node substitution

2026-11-11. **PASS at paper-composition scope. No mathematical correction required.** The full signed-bucket contract composes correctly with matching-parity characters, the two Gaussian frequency branches, the fixed holomorphic tilt, normalized derivatives, and Taylor/panel error bounds. The proof does not import the principal-xi kernel constants.

No numerical node, transform, contour, or spectral datum was generated in this review. The result is a composition theorem design with explicit remaining implementation and analytic obligations.

## Reviewed version and input pins

The final author file is `../zero-sum/NONPRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md`, SHA256 `C5DC28202A45083FD5AA928D7892205870CF5BDB5E6715FDF134D319F39A558A`. I read the complete mathematical text and checked the final unit-residue summation repair. The earlier pending hash `757651120E740FA46627FDCB2DA3263CC22A7E0E5A8B1A2AFA6DA5C76FD9A4FB` differs by that typesetting repair and is not the final review target.

I independently rederived the derivative, reciprocal, and tail identities before receiving the frozen text. The four producer pins in its dependency table were checked against disk:

* Joint character/Fourier plan `3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D`.
* Tilted right-slab evaluator `695BF1B9AE43BDDA950F111D8A484B35DE774578B6F5A14012763740E28848AE`.
* Modular signed-bucket plan `2EADB0ACEE2B3C8275D9C8CFA815E4E3E7CC39C3CB0EBA0A86763A4877F74F09`.
* Four-case modular bucket pilot `67B8600CE22CBCEA5C18AC9B969746A93901D694C3B54CD244425A443F6B8448`.

The relevant independent reviews include the joint-plan review `2F5645939D0F3EB3B90860B07BE4A343082F2E8EAE7578888998DB7661117F56`, my tilted review `DB9670A184F7CEF9AFA812263EC61592CB288E0F2863B63446D7415E6DA33469`, the bucket-plan review `FB6A7BD014A4417CD4D3AD2460C0785EDE3838226AA6F9013248863FB3135E70`, and my bucket-pilot review `BD769E12B182728E97033CDF2218600D67A862179EBC663425289D7490B2F50F`.

The existing source pins remain Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. The actual nonprincipal completion, source functional equation, Gauss norm, inverse-character identification, and positive Fourier convention are the previously audited objects. No new declaration is claimed to have been implemented.

## Full buckets, parity, and the two frequency branches

The bucket supplied to this interface is the complete signed infinite sum. Its modular reconstruction already contains the factor c^a from reindexing n=R+ck. A downstream multiplication by c^a would therefore be wrong. The contract explicitly excludes this duplication and requires all original-input, root, phase, reduced-tail, and arithmetic errors in each radius.

For matching parity, separating positive and negative integers proves

`C_chi(v)=sum_units chi(R)B_(R,a)(z_+)=2 theta_chi(z_+)`.

The zero term contributes nothing because c>1 and chi(0)=0. This is the only signed-to-positive factor one-half. It is not an identity for a single residue bucket. Opposite-parity outputs cancel and are not suitable positive-theta outputs. Primitive reciprocity is invoked only after discarding imprimitive labels.

At nonnegative x=v, the Gaussian prefactor 2 cancels the one-half above. The correct node is

`G(v)=c^(-lambda/2) exp(lambda(v+ib)) C_chi(v)`.

At x=-v<0, theta reciprocity changes the character to its inverse and the theta argument to exp(2(v-ib)). Since the weights n^a are real,

`C_inverse(exp(2(v-ib)))=conjugate(C_chi(v))`.

It follows that

`G(-v)=W_chi c^(-lambda/2) exp(mu(v-ib)) conjugate(C_chi(v))`.

Here lambda=sigma+a and mu=1+a-sigma. In particular, mu can be negative. Neither exponent may be replaced by the critical-line exponent. W is the actual positive-Gauss-sum root number, with its source primitive norm proof and its numerical error. The -b in the reciprocal coefficient does not change the analytic target from Z_b to Z_-b.

Multiplication by `A_sigma=exp(-ib sigma)c^(lambda/2)` leaves the positive phase exp(iab) and negative phase `W exp(-i(a+1)b)`. The outer conductor powers cancel exactly. The characteristic bucket's internal c^a remains part of C. These checks confirm equations (4)-(8), including both signs and every factor two.

## Derivatives of the one actual analytic function

The target is `Z_b(s)=exp(-ib s)Lambda(s)` with one fixed real b. It is entire; its exponential multiplier is nonzero. In the stated positive real-part range the source Gamma factor is analytic and nonzero, so the indicated comparison with actual L zeros and multiplicities is valid.

For each fixed real sigma, differentiation of G contributes `x+ib-log(c)/2`. Differentiation of A contributes `-ib+log(c)/2`. These constants cancel. Repeating the calculation gives

`Z_b^(j)(s0)/j! = A_sigma integral (x^j/j!)G_sigma(x)exp(it0 x) dx`.

The inserted power is the signed x^j. Its absolute value belongs only in error bounds. The ordinary derivative would require an additional j!; the note consistently works with normalized Taylor coefficients. Local Gaussian domination justifies all of these differentiations. No separate derivative of an approximate modular word is needed: modular data approximate values of the exact kernel, and derivatives are obtained from its moment integral.

## Independent nonprincipal moment and quadrature derivation

For either q=q_b or q=q_*, write A=2c/q and d=q/c. The established nonprincipal bound is

`|h_sigma(x+iy)| <= A exp(u-d exp(2u))`, where u=|x|.

Since `u^j/j!<=exp(u)`, the two-sided moment is at most

`2A integral_[0,infinity) exp(2u-d exp(2u)) du = (A/d)exp(-d) <= 2c^2/q^2`.

This proves the common bound M for all normalized orders, including j=0. The calculation uses the nonprincipal kernel directly. It does not reuse the principal differentiated-theta envelope.

On either displaced line w=x+i y, |y|=delta, the bound

`|w|^j/j! <= exp(|x|+delta)`

accounts for the complex moment factor. Also `|exp(it0 w)|<=exp(T delta)`. Because `|Im(w+ib)|<=|b|+delta`, q_* applies to h there. The line integral is therefore at most `M_* exp((T+1)delta)`. The two geometric Fourier tails of the infinite trapezoid identity give exactly

`Q_j=2M_* exp((T+1)delta)/(exp(2pi delta/h)-1)`.

This is a bound in I_j units. Its factor two counts the two shifted lines, and its extra exp(delta) is necessary for the normalized complex moment. At j=0 it is conservative.

For the omitted real nodes, the majorant is `A exp(2u-d_b exp(2u))`. Its derivative has sign controlled by `2-2d_b exp(2u)`, so the condition `d_b exp(2V)>=1` makes it nonincreasing beyond V. Integral comparison on both tails gives

`S_j=M_b exp(-d_b exp(2V))`.

The threshold one is therefore correct for this nonprincipal normalized-derivative envelope. It is not the principal-xi derivative threshold two. The finite sum retains both -K and +K, with h>0 and nonnegative integer K; the omitted tails begin beyond those endpoints. The quadrature and spatial terms already perform the two relevant infinite-to-finite truncations. Adding the older alias ledger on top would double count them.

## Finite error propagation and transform scales

All four triangle-inequality interfaces check:

* Bucket radii contribute sum_R e_R to the unnormalized character output, since actual character values have modulus one on units. Character-root and transform arithmetic errors contribute e_char in the same units. A normalized character transform requires multiplication of value and error by phi(c).
* For a node product, the split `p(C-C_hat)+(p-p_hat)C_hat` gives `|p|E_C+rho_p|C_hat|`. It needs no additional mixed term. Product rounding is then added. The exact prefactor norm can be replaced by a certified upper bound.
* For a weighted finite sum, the analogous split `w(G-g_hat)+(w-w_hat)g_hat` gives equation (13). The actual center uses signed powers, while its radius uses absolute powers. The errors of both reused frequency signs still contribute separately.
* Final multiplication by A is a distinct step, costing `c^(lambda/2)E_I+rho_A|I_hat|+rho_out`. An I-unit error is not already a Z-unit error.

A modular node encloses its whole infinite bucket, so there is no additional direct-theta cutoff error outside its radius. A mixed implementation may use direct nodes, but their direct tail must enter that same node contract exactly once.

The time-transform input already contains x_k^j/j!. At compatible grid times the unnormalized positive transform is multiplied by h, while the source normalized positive inverse transform is multiplied by hL. The contribution eta_j must include the corresponding final scaling and its rounding, measured in I_j units. The final A conversion still follows. The note explicitly states this, avoiding the previously repaired unscaled-DFT ambiguity.

The symmetric indices -K through K embed injectively when L>=2K+1. The zero node is present once, with x^0=1 and x^j=0 for j>0. It is unrelated to the theta summation index where chi(0)=0. A scheme using -K through K-1 must account for the missing positive endpoint. Off-grid values require the unfolded sum or a separately justified interpolation, not finite-DFT periodicity.

## Taylor disks, panel coverage, and termination

The moment calculation bounds every actual center coefficient by

`D_sigma=c^(lambda/2)M_b <= 2c^4/q_b^2`.

Because Z_b is entire, its Taylor series equals Z_b. Summing the coefficient errors through degree d and the geometric tail of the true coefficients proves equation (16) for 0<=rho<1. The proof remains valid when the disk crosses a real boundary of the original slab: it uses derivative bounds at its center, not an unsupported value bound on a larger Cauchy circle. This extends the analytic approximation of Z_b, not the source zero-equivalence claim to arbitrary negative real parts.

Only the computed centers need to lie in the given real-part range and satisfy |Im(s0)|<=T for this direct moment method. A different Cauchy-sampling implementation would have to cover its additional sample domain. A polynomial with the stated coefficient and remainder radii encloses every point of a panel; point exclusion alone is not accepted as a whole-panel proof.

For fixed admissible delta and q bounds, shrinking h sends Q_j to zero. Increasing K then sends S_j to zero while satisfying its monotonicity threshold. There are finitely many retained node computations and finitely many requested coefficients, so their modular and arithmetic tolerances can be refined to meet the weighted finite budgets. The all-orders estimate supplies the uncomputed Taylor tail. These are finite-accuracy existence arguments, not a nonvanishing or runtime guarantee.

Different b values still represent different analytic image functions. Their coefficients cannot be combined into one Taylor polynomial, and their raw contour images cannot be cancelled across seams without the established common-normalization or independent-count argument.

## Remaining scope

The review accepts the paper composition and its finite error contracts. It supplies no new node packet, actual character transform, root-number computation, polynomial, panel witness, or spectral result. In particular the four-case pilot remains evidence at its four coefficient inputs only.

Formal source wrappers, the modular evaluator, normalized derivative quadrature, interval arithmetic and finite transforms, actual node inequalities, and geometric assembly remain implementation or evidence obligations. Those inequalities must be proved for the requested data, not added as final assumptions. The principal conductor-one problem remains separate. No build, dependency change, canonical source edit, numerical scan, or contour computation was performed.
