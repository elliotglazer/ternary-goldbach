# Family evaluator interface and a complete conductor-5 pilot

2026-11-11. Research and external interval arithmetic only. No Lean build, native build, dependency installation, frozen-file change or full-family computation. This note does not establish Hcert for any production conductor.

## Result and chosen route

A complete shared contour certificate for all three primitive characters modulo5 has passed construction and replay on [.555,2] times [-12,12]. This tests a genuine new interface beyond the real conductor3 pilot: exact character indexing, a nonreal conjugate pair, common pole cancellation in a Hurwitz vector, a character DFT, and completeness for every primitive factor. Acceptance uses explicit Euler–Maclaurin with analytic remainder and FLINT elementary balls; builtin zeta is used only for diagnostic comparisons.

For production, the plausible stable route is to batch the pole-cancelled Hurwitz inputs at each complex s, transform over the unit group, then use per-character analytic models and exact winding. A concrete rational Taylor budget below reduces the residue-variable interpolation to16 initial powers and32 polynomial terms per unit residue at |s|<=1002. It does not yet produce the coefficient enclosures or a production runtime.

The alternate critical-line route would certify more than needed, but can replace off-line winding by sign changes plus an independently proved completeness count. Those are different evidence contracts; neither numerical sampling nor a published finite GRH claim is being inserted as a theorem.

## Exact family certificate format

The outer manifest fixes every active conductor c, Hcert(c)=min(Hp_old(c),10^8/c), real boundary111/200, and a rational T_c>=Hcert(c). A boundary at equality is sufficient if nonvanishing there is checked. Otherwise a slightly larger T_c must actually be certified; do not round the required height up and claim prior data cover it. There are150000 active conductors and5,543,640,188 primitive characters under the existing exact count manifest.

For each c>1 the arithmetic header contains a prime-power factorization, a verified decomposition of the unit group into cyclic coordinates, exact generators, a bijection from coordinates to units, and the dual character indices. Primitive-conductor and parity labels must follow from these exact character definitions. Counts alone cannot certify that no character index was omitted or duplicated. Conjugation maps a character to its inverse dual index; it is not silently applied inside the same nonreal character.

The analytic data may be organized by rational s-blocks shared across characters:

1. Certified Hurwitz or deflated-Hurwitz input models for every required residue, with their analytic domains, remainder bounds and elementary-function interval proofs.
2. An exact group-DFT convention and interval transform transcript, or a deterministic transform recomputed by the checker. Roots of unity and normalization must be enclosed. Character conductors and parity are checked independently of numeric values.
3. For each primitive output, a complete ordered partition of the rectangle boundary; rational image vertices shared by adjacent panels; and strict separating half-plane witnesses for the entire image of each panel and its two chosen vertices.
4. Exact rational polygon winding for each factor, or the sum of the factor windings. Since all primitive nonprincipal L-functions are entire, each winding is a nonnegative zero count with multiplicities. A zero sum then excludes zeros in every factor. Boundary nonvanishing is necessary for this argument.

The principal c1 entry uses zetaF=(s-1)zeta(s), with value1 at1, as in the reviewed zeta certificate. No raw-zeta product is treated as entire. The rectangle lies to the right of .555, so trivial zeros are absent. Known unconditional nonvanishing for Re(s)>1 reduces the relevant region to the critical strip, but does not by itself check the rectangle's remaining sides. A count above zero fails the exclusion certificate; it must not be interpreted as a rounding problem automatically.

Shared Hurwitz blocks need not force one global panel subdivision across billions of characters. Different character outputs can adapt independently while reusing the same analytic inputs. A union mesh would be controlled by the smallest value among all factors and may be unnecessarily fine. Complex conjugation can reuse negative-height data via the conjugate character, including reversed path orientation and shared real-axis endpoints. Multiplicities are supplied by the argument principle, with no simple-zero or spacing assumption.

## Pinned source and stable normalization

The exact identity is

    L(s,chi)=c^(-s) sum_(a in units mod c) chi(a) zeta(s,a/c).

All positive real bases use real logarithms. No gamma factor is needed for this off-line route. The [FLINT3.6.0 all-character implementation](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/l_vec_hurwitz.c) computes Hurwitz inputs, multiplies by c^(-s), conjugates, applies its indexed DFT and conjugates back. It adds ceil(log2(phi(c))) working bits. At exactly s=1 it uses deflated inputs and marks the principal output indeterminate. This special case must not be mistaken for a general enclosure valid on a ball containing1; our implementation cancels the common pole analytically first.

The [DFT implementation](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/dft.c) uses a product transform with lexicographic Conrey indexing. Our pilot uses its own explicitly stated positive-sign four-point convention instead of assuming these labels coincide. A production adapter must prove the permutation and sign convention, especially for nonreal characters.

Write alpha=a/c, B_alpha=N+alpha, and choose a reference alpha0. Remove the same meromorphic term B_alpha0^(1-s)/(s-1) from every Hurwitz input. The difference of the two integral terms has the entire formula

    [B_alpha^(1-s)-B_alpha0^(1-s)]/(s-1)
      = -B_alpha0^(1-s)*d*exprel((1-s)*d),
    d=log(B_alpha)-log(B_alpha0), exprel(z)=(exp(z)-1)/z.

For nonprincipal chi the common subtraction sums to zero. This gives a stable formula at s=1 without computing two infinite pole enclosures and subtracting them. It also makes the branch choices explicit.

## Complete pilot and what it checks

Conductor5 is prime. Its units in generator2 order are [1,2,4,3]. Define chi_k(2^j)=i^(kj), k=1,2,3. These are exactly its three primitive characters; k1,k3 are odd and conjugate, k2 is real and even. The all-zero character is principal and is discarded. Exact roots [1,i,-1,-i] require no transcendental root-of-unity approximation.

At each input box, the pilot evaluates the four pole-cancelled Hurwitz inputs once and applies the three exact DFT combinations. All three characters must satisfy a half-plane test before a shared panel is accepted. A common Pochhammer vector is reused. Thus this is a real vector-evaluation test, not three separately relabeled conductor3 runs.

Parameters:128 bits, N64, M20, sigma floor111/200. The regular EM part consists of the first64 terms, the half endpoint, and the20 Bernoulli corrections. For B=N+alpha its remainder is enclosed by

    4*|(s)_40|*B^(1-111/200-40)/(6^40*(111/200+40-1)).

This follows from the periodic Bernoulli bound and the integral remainder; the analytic hypothesis is Re(s)>=111/200. The input ball may extend slightly past the exact rational path through outward rounding, but the claimed analytic domain is the actual path. Bernoulli numbers are computed as exact fractions. Exprel is expanded through degree18 with remainder exp(r)*r^19/20!, r=|z|. The pole-cancelled value at s=1 is finite for all three outputs.

The boundary is counterclockwise, with both heights included. Construction produced3034 shared panels from6064 vector panel calls and3034 distinct vector vertex calls, max subdivision depth14. The exact factor windings are [0,0,0]; their sum is0. Construction took4.635480s and replay1.410856s on this host. JSON size4,946,153 bytes. These are single-run timings for the pilot, not a family estimate.

`c5_family_dft_certificate_20261111.py --replay` recomputes every panel enclosure, validates the exact partition and orientation, shared vertices, signs and windings. Stored numeric image strings are not acceptance inputs. Builtin Hurwitz comparisons at three points and conjugation checks are diagnostics only. The claim is external interval exclusion for these three factors on this rectangle, pending independent review; it is not a formal theorem and is far below Hcert(5).

## Concrete residue-variable batching bound

The [FLINT precomputation evaluator](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/hurwitz_precomp_eval.c) evaluates a polynomial near a rational residue grid center after shifting by an integer A, then restores A initial powers. The [precomputation initializer](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/hurwitz_precomp_init.c) builds coefficients from (-1)^k(s)_k/k! times Hurwitz values at s+k. This is batching in alpha, not a claimed fast algorithm in height.

An independent simple remainder sufficient for a prototype is available. For positive real alpha, differentiation gives

    partial_alpha^K zeta(s,alpha)=(-1)^K(s)_K*zeta(s+K,alpha).

For sigma+K>1, the final Hurwitz series converges absolutely. Taylor's integral remainder along a real alpha interval, with alpha>=A and offset |d|<=h, yields

    |R_K| <= |(s)_K|*h^K/K! *
       [A^(-sigma-K)+A^(1-sigma-K)/(sigma+K-1)].

The same estimate holds after subtracting1/(s-1), since that term is independent of alpha. At s=1 the regularized coefficient must be evaluated by a pole-cancelled formula. For a complex s-ball, use a proved lower sigma bound and upper bounds on every |s+j|; no center-only estimate is sufficient.

For the exact region sigma in[.555,2], |t|<=1000, take |s|<=1002, A16,16 equal alpha-cells on[0,1], h=1/32, and K32. The bracket is less than2*A^(-K), giving the rational bound

    E <= 2*product_(j=0..31)(1002+j)/(512^32*32!)
       <2.660e-26.

Even300000 absolute DFT terms contribute less than7.978e-21 before the harmless c^(-sigma)<=1 factor. `family_hurwitz_grid_budget_20261111.py/json` checks this with exact fractions. This is an absolute interpolation error only; rounding and coefficient-evaluation errors require their own allocation. It does not assert relative accuracy near a zero.

For each fixed s this design has512 precomputed coefficients, then16 initial-power evaluations and a31-multiply Horner polynomial per residue, followed by the group DFT. It is a specific implementation target for large conductors whose heights are modest. It avoids a separate long EM tail for every residue. Computing the512 coefficient enclosures, controlling the s-direction over panels, and adapting to small values are still substantial work. No runtime or full-family proof-size claim follows from these operation counts. At larger heights the displayed parameter budget does not apply; parameters and coefficient evaluators must change.

## Critical-line alternative and remaining production obligations

[Platt's primary paper](https://arxiv.org/pdf/1305.3087) uses rigorous interval evaluation, Fourier methods and completeness machinery. A critical-line certificate would need a root-number/phase normalization making the completed function real, exact character indexing, opposite-sign enclosures on disjoint intervals, and an independent upper zero count matching the resulting lower count. Counts must include multiplicity, endpoint treatment and both ordinate signs. Nonreal chi and its conjugate cannot be conflated. Turing bounds, gamma branches and gamma-argument variation are analytic theorems to supply, not labels on an FFT output. Sign changes without completeness do not exclude missed off-line zeros.

For the present off-line contract, the next useful bounded test is the16-cell alpha-precomputation at a moderate conductor and height, with coefficient enclosures independently checked against direct EM and a complete modest contour. It should measure sharing and conditioning, not merely point throughput. The conductor5 pilot resolves the indexing/pole-cancellation contract but does not test that scaling optimization.

Production still requires all manifest indices, entire-factor correspondence, proved interval elementary operations, EM/precomputation or stable high-height remainder theorems, s-block analytic bounds, complete contours and exact winding. An all-character transform saves arithmetic; it is not a compressed proof that unsampled characters are zero-free. No weighted-average substitute is used, since pointwise base-gap requires every eligible character.

A correction carried forward from the frozen production note: sqrt(10^8/(2*pi)) is about3989.423, so its floor is3989 and its ceiling is3990. The earlier wording 'the square-root length is at most3989' was too strong. No verified family evaluator or conclusion relies on that heuristic length.

For future s-block models, the independent production-wrapper review supplies an existing-source alternative to Rademacher: the repository's `ZetaGrowth.norm_zetaF_le` yields M=400000802 on the two previously sampled zeta disks. The same64-sample alias formula then gives error below2.9e-11, and independent replay still accepts those two local blocks. This removes the need for a new Rademacher proof in that specific wrapper. It does not give a Dirichlet-family growth theorem or guarantee acceptance on future blocks; those domains and errors must be checked separately.
