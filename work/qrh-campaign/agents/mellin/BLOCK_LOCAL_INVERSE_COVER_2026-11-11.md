# Closed-slab inverse certificates and their conditional cost

2026-11-11. Research-only paper derivation. A separate inverse candidate on each complete closed slab is valid. It avoids requiring one pole dictionary extending over the total height. It does not prove uniform local approximation quality, spectral margins, bounded candidate size, or inexpensive high-height evaluation. No numerical evaluation, fit, scan, Lean command or frozen-file edit was performed.

This note reads the [global scaling analysis](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/zero-sum/GLOBAL_INVERSE_SCALING_LIMITS_2026-11-11.md) at SHA `DDAA08056E5159790D4E7C58BBF7F028538E1C885CF5E8A1E8D0CA0EF4C6C141`. It independently derives the local maximum-principle and finite-cover implication. The existing [family slab assembly](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/major-constants/FAMILY_STRIP_SLAB_ASSEMBLY_2026-11-11.md), SHA `5064865E9CE249A896B6B083278938E0E77762B88DE4539E038E624AC011FF93`, supplies the earlier geometry/count framework. The inverse route below needs its closed-cover geometry, not a new winding computation.

## 1. Local theorem: one candidate on the whole slab

Let `Q=[a,b]+i*[u,v]`, with a<b and u<v. Let f and B be holomorphic on an open neighborhood of Q. Suppose a real q satisfies `0<=q<1` and

`|1-f(s)B(s)|<=q` for every s on the complete boundary of Q.

Then the same inequality holds for every s in Q, and f is nonzero throughout **closed Q**.

**Proof.** The residual R=1-fB is holomorphic on the neighborhood and continuous on Q. Apply the maximum-modulus principle on the bounded open rectangle `U=(a,b)+i*(u,v)`. Its closure is Q and its frontier is exactly the four closed sides. Thus `|R(s)|<=q` on Q. At a zero of f, R would equal 1, contradicting q<1. This argument also gives `|f(s)B(s)|>=1-q>0`; it does not assume that B is already an inverse or even nonzero.

The actual source theorem [Complex.norm_le_of_forall_mem_frontier_norm_le](C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/Analysis/Complex/AbsMax.lean:404) takes a bounded U, `DiffContOnCl` for R, a frontier norm bound and membership in the closure. The rectangle closure/frontier identities and the holomorphic residual are the needed adapters. This is a paper application, not a new compiled declaration.

“One globally holomorphic candidate per slab” means one fixed B holomorphic across that entire slab and its interior, not just on its boundary panels. B need not be entire on all of C: a rational candidate is allowed when all its poles are proved outside Q, hence outside some neighborhood of Q. A finite pole list on Re(s)=1/2 has clearance at least `Delta=a-1/2>0` when a>1/2. A denominator merely known nonzero on the boundary is insufficient; an interior pole destroys the argument.

For a finite closed-panel partition of the boundary, different verified bounds q_p<1 may be used with the **same B**. Their finite maximum q<1 gives the theorem. Pointwise strict boundary bounds also have a strict uniform maximum by continuity and compactness, but an executable certificate must supply/check an effective bound; it cannot infer one from finitely many point samples.

## 2. Finite family cover theorem

Let C be the exact finite set of required source characters. For each chi in C let f_chi be its actual holomorphic continuation on the domain of interest. For each chi choose a finite collection of closed rectangles `Q_(chi,j)` and candidates `B_(chi,j)`. Require:

1. f_chi and B_(chi,j) are holomorphic on a neighborhood of that entire rectangle.
2. One candidate B_(chi,j) is used on all four sides, with a verified full-boundary residual bound q_(chi,j)<1.
3. The requested closed region R_chi is contained in the union of those Q_(chi,j).

Then f_chi is nonzero on R_chi for every chi in C.

**Proof.** Apply the local theorem to each pair (chi,j). Given s in R_chi, finite coverage supplies a j containing s. Its closed nonvanishing conclusion applies. No identity between B_(chi,j) and B_(chi,k), nor between their boundary approximations, is used. There is no gluing of B and no cancellation of residuals or polygons across slabs.

In particular, a strictly increasing rational height partition `-T=y0<...<ym=T` and slabs `[a,b]+i*[yj,y(j+1)]` cover the closed target rectangle. At an internal seam, either neighboring slab contains the point; at plus/minus T, the first/last slab contains it. If zero is a partition height, the real axis is included in both incident closed slabs. If a slab crosses zero, it contains the real axis in its interior. Either arrangement detects real zeros; omitting the real axis or verifying only open slab interiors does not.

Overlapping rectangles are also valid in cover mode: prove exact set inclusion in their finite union. Positive-area overlap creates no double-counting problem because **no counts are being added**. Gaps, however small, invalidate coverage. A convenient checker refines all rational coordinates to a common grid and verifies that each required grid cell is contained in a certified rectangle. Different characters may have different covers; a common grid is a batching choice, not a theorem hypothesis.

For the selected family, the character manifest must bind every primitive nonprincipal character at each required conductor, not merely its number or an approximate label. The current cutoff is the prescribed Hcert(c). A cover through T_c>Hcert(c) certainly covers inclusive `|Im(s)|<=Hcert(c)`; equality T_c=Hcert(c) is also mathematically sufficient if that closed boundary is certified. The shared-family assertion includes nontrivial real zeros. Conductor one requires its separately identified entire xi/pole-removed function and zero-equivalence proof; raw zeta is not holomorphic across its pole.

If only nonnegative ordinates are evaluated, use the exact identity `L(conj(s),chi^-1)=conj(L(s,chi))`. To obtain both signs for a nonreal chi, the positive-height cover for chi inverse is also required. Its reflected **closed nonvanishing result** supplies the negative cover for chi. The real-axis seam remains covered. Reflection in 1-s, with the actual inverse-character functional-equation factor, supplies the lower real-part bound only after its source conditions are checked.

Exclusion on `[111/200,2]` is stronger than the desired `Re(rho)<=111/200`, since it also excludes equality. A true zero on that boundary prevents such an inverse certificate but need not contradict the desired weak strip. The finite-cover theorem does not resolve that distinction.

## 3. Aggregate residuals may also be local to one slab

The reviewed [family product/inverse plan](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/zero-sum/FAMILY_PRODUCT_CERTIFICATION_FEASIBILITY_2026-11-11.md) permits one group-algebra candidate per conductor. On each slab it may be a different candidate. Its primitive scalar residuals must be exactly `R_chi=1-L_chi B_chi` for that slab, with each B_chi holomorphic throughout it.

A full-boundary group coefficient l1 bound q<1 implies `|R_chi|<=q` for every primitive chi. Alternatively, a verified positive moment `sum_chi |R_chi|^(2k)<=q<1`, k>=1, implies each scalar residual is strictly below one. A common scalar bound q^(1/(2k))<1 then applies; one need not compute the root numerically to prove the implication. Different panels may use different positive k and bounds, with a finite maximum of their scalar consequences.

Apply maximum modulus to the **holomorphic scalar residuals**, not to the l1 norm, moment, conjugate coefficients or squared norms. Those are only boundary tests. The same candidate per slab is still essential. All transform normalization, primitive projection, inverse labels, and analytic/rounding errors remain part of establishing the boundary test. This cover theorem supplies no saving in the number of actual character factors by itself.

## 4. Why unrelated panel candidates fail

There is an elementary counterexample even when every candidate is entire. Take `Q=[-1,1]+i*[-1,1]` and f(z)=z. Split every side into four closed panels of length 1/2. For a panel with midpoint m, set its candidate to the constant `B_p(z)=1/m`. Since |m|>=1 and |z-m|<=1/4 on that panel,

`|1-z B_p(z)|=|m-z|/|m|<=1/4<1`.

All sixteen panel tests succeed, yet f has a zero at the center of Q. There is no single residual to which maximum modulus applies on all four sides. This failure is not caused by poles or numerical errors. In contrast, independent candidates per **complete closed slab** each establish a genuine interior nonvanishing theorem before their conclusions are combined.

## 5. Parametric costs: which quadratic factor disappears

Fix a conductor c with n primitive outputs and v=phi(c) unit-group inputs. Let slab j have length ell_j and actual ordinate range up to U_j=max(|yj|,|y(j+1)|). Use a pole spacing delta_p and padding p_j on a line strictly outside the rectangle. A local pole grid obtained by retaining the grid points inside `[yj-p_j,y(j+1)+p_j]` has at most

`P_j <= floor((ell_j+2p_j)/delta_p)+1`

points when it is the intersection with one fixed arithmetic grid. Other dictionaries have their own explicit P_j. This count is not a theorem that such a dictionary approximates the inverse well.

Let M_j be the number of fitting samples, d_j the residual-model degree, J_j the number of accepted/refined boundary models, and pbit_j their working precision. With a common pole basis across the n characters, the prototype's literal local-array sizes are

`M_j*(P_j+1)` for the fitting matrix, `n*M_j` for its right-hand sides, and `n*(P_j+1)` for candidate coefficients.

Its local inverse-jet coefficient accumulation costs

`n*(d_j+1)*P_j*J_j`

complex coefficient products before rounding, tail tests and L evaluation. Thus the complete cover has that cost summed over j, rather than `n*(d+1)*P_global*J_global` with both global factors proportional to total height.

For a nonadaptive rectangular panel mesh with full panel sizes at most h_y vertically and h_x horizontally, width W=b-a, the initial model count is

`J_j=2 ceil(ell_j/h_y)+2 ceil(W/h_x)`.

Refinements increase it and must be counted. Seams are evaluated twice in this simple scheme; this introduces the horizontal-edge term per slab, not a logical defect. Values of the actual L-function may be cached at coincident nodes, but unrelated B candidates require their own residual evaluations.

**Conditional simplification only:** if ell_j, p_j, delta_p^-1, M_j, d_j, J_j and numerical costs are uniformly bounded independently of T, and the number of slabs is O(T), this particular inverse-accumulation work and total fitting-matrix input size become O(n*T). Streaming bounds peak fitting storage by the largest local matrix instead of a matrix with O(T^2) entries. These are consequences of explicitly stated uniform bounds, not bounds proved for the actual family.

Durable storage of all candidate coefficients is `n*sum_j(P_j+1)`. It can remain O(n*T), the same height order as the old global coefficient list, and overlap/padding can increase its constant. Block locality does not automatically compress the whole certificate. The dense solver's cost is another function `Fit(M_j,P_j,n,pbit_j)` to be summed, not silently equated with matrix-entry count.

The full work also includes

`sum_j [Fit_j + n(d_j+1)P_j J_j + LWork(c,U_j,J_j,d_j,pbit_j) + ResidualWork_j]`,

with appropriate v-dimensional shared transforms when used. This expression exposes, rather than hides, the remaining high-height and family-size dependence.

## 6. What locality does not bound

For a rational candidate with coefficient mass `W_j=sum |w_jk|` and pole clearance Delta>0,

`B0_j=|b_j0|+W_j/Delta`, `B1_j=W_j/Delta^2`

bound its norm and first derivative. On a centered disk of radius rho<Delta, a degree-d candidate remainder is at most

`W_j*(rho/Delta)^(d+1)/(Delta-rho)`.

Hence neither the model degree nor the arithmetic precision is uniformly controlled without coefficient and residual-slack information. A fixed pole spacing can have an irreducible approximation error; refining numerical precision alone cannot improve that approximation space.

The actual L evaluator still sees U_j, not merely ell_j. For the selected right strip with right endpoint 2, on a radius-1/4 neighborhood a source upper-growth bound gives a conservative

`M_j^L=(c+1)*(U_j+3)/(a-1/4)`

when a>1/4, and a Cauchy derivative bound 4M_j^L on the rectangle. Consequently `|(1-LB)'|<=M_j^L*(4B0_j+B1_j)`. If a proved midpoint residual is at most 1-mu_j, reserving at most mu_j/4 for arithmetic and at most mu_j/4 for derivative variation suffices. It may force panel size to shrink as U_j grows. Thus a quadratic dependence can reappear through conservative evaluation or derivative bounds even after the global-pole artifact is removed. Faster local analytic models may help, but no such uniform margin or cost bound follows from c5.

The weak strip target provides no positive distance of zeros from its boundary. Even the zero-free functions `f_epsilon(s)=s-(a-epsilon)` force `|B(a)|>=(1-q)/epsilon` whenever `|1-f_epsilon B|<=q<1`. Localizing height does not remove this example. For actual L-functions it is a warning about missing bounds, not a claim that the family realizes the worst case.

If f is already known zero-free on closed Q, its reciprocal is holomorphic on a neighborhood of Q. The reviewed Cauchy-approximation argument can then establish existence of some finite rational candidate. This is not a spectral proof and gives no uniform dictionary size, coefficient norm, slack or conditioning. Acceptance must use a produced candidate and a complete residual certificate, never that conditional existence statement.

## 7. Bounded next blueprint

The next implementation interface should consume: an exact character/function key; one closed rational rectangle; one fixed finite candidate with certified pole clearance; a complete closed-side panel partition; and full residual bounds below one, including all analytic and arithmetic errors. Its output is simply nonvanishing of the actual function on that closed rectangle. A separate exact finite-cover checker consumes those outputs and verifies every required character and target point is covered, including zero height and the inclusive top.

This architecture needs no agreement between candidates on neighboring slabs, no product winding and no multiplicity sum. Absence of zeros excludes every multiplicity automatically; the later source-carrier adapter still binds that absence to the actual L-function. It removes a genuine global-dictionary scaling artifact. The local candidate data, strict residual comparisons, all-height evaluator costs, total family coverage and kernel-checked implementation remain open.
