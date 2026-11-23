# Original trace-normalized Poisson identity: source audit

Date: 2026-11-11. Status: bounded mathematical/source audit, frozen for independent review. No Lean/Lake build, declaration, source edit, analytic evaluation or numerical computation. This is not a kernel-validity or full-provider claim.

## 1. Result and source cut

No normalization, frequency-coverage or summation-interchange defect was found in the inspected chain. The actual input identity is an equality of convergent lattice sums, obtained from one-dimensional Schwartz Poisson summation, affine change of variables, finite residue classes, exact finite Gauss transforms, Möbius mask dilation, and the finite overlap expansion. The physical-mode identification then uses the separately identified ray-conversion identities.

The fundamental trace-normalized identity is `GaussSum/SexticRadialPoisson.actual_radial_paper_poisson_trace:499`. The original input consumes it through `CubicSieve/SecondPoisson.masked_pair_second_poisson:83`, `CubicSieve/ChildTransfer.inputConjugateRow_smoothed_second_poisson:540`, and `Inversion/InitialRayAttachment.initial_input_physical:249`. These are exact identities; no spectral or size assumption replaces their analytic inputs.

All provider paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, at commit `4eaee87548250b2682affda7d05d947c05554bae`. Complete source-file hashes appear in §9. The provider's `lean/lake-manifest.json` records Mathlib revision `d13f23b723b8a846827a245b89c10fc7d3f11612`; this audit does not validate elaboration against that revision or the prepared target version.

Prior immutable cuts: high-radial coverage report `integration/QRH_HIGH_RADIAL_COVERAGE_AUDIT_2026-11-11.md`, SHA256 `D8188C5E8AA59E979BEC024567255CF28845215117F2426C70C31D93F60EBA4D`, review `moebius/REVIEW_QRH_HIGH_RADIAL_COVERAGE_AUDIT_2026-11-11.md`, SHA256 `0EC988BEE4AF8EF9A3FB17273AD0DACEF1D642F55F527D608ACF92C9D26D077B`; marked-zero report `integration/QRH_MARKED_ZERO_MODE_ANALYTIC_AUDIT_2026-11-11.md`, SHA256 `AC63CCA803785C2E4ECBE0AB8C9373206CA19ADE741BBD8A26B5AB5D168BF8DB`, review `moebius/REVIEW_QRH_MARKED_ZERO_MODE_ANALYTIC_AUDIT_2026-11-11.md`, SHA256 `E0E5A316FE5B64E0AF3E33F95CED30F2BABD5220559BE76DD66BBA13D17ED741`. Report paths are relative to `work/qrh-campaign/agents/`.

## 2. Plane Poisson is proved from convergent one-dimensional sums

`GaussSum/SecondPoissonScale.schwartz_poisson_zero:903` applies Mathlib's `SchwartzMap.tsum_eq_tsum_fourier` at zero. The source does not simply assert its two-dimensional analogue. `integer_pair_poisson:935` uses vertical and horizontal one-dimensional Poisson together with `iterated_poisson_pair_sum:919`, whose three explicit hypotheses are summability on `Z × Z` of f, its plane Fourier transform, and the intermediate partial Fourier transform.

Those hypotheses are discharged. `plane_schwartz_product_decay:745` uses the Schwartz seminorms of orders 0,2,4 to dominate a plane function by a constant times `1/((1+x²)(1+y²))`. `summable_int_cauchy_weight:703` compares the nonzero integers with the p=2 series; `summable_int_cauchy_product:719` takes its product. Hence both plane lattice sums are norm-summable (`plane_lattice_summable_norm:866`).

The partial transform is also genuine: `partialFourier_integrable:625` uses the integrable Schwartz function with a unit-modulus phase and the volume-preserving real-product model of C; `fourier_partialFourier:640` uses the integrable product Fourier identity. `partialFourierSchwartz_apply:653` applies Fourier inversion only after proving continuity, integrability, and integrability of its Fourier transform. A second horizontal derivative supplies the extra x-decay, while the plane Schwartz decay supplies y-decay (`inverse_horizontalSlice_product_decay:811` and `partialFourier_gaussian_summable_norm:853`). The name “gaussian” on this last theorem does not restrict f to a Gaussian: its binder is an arbitrary plane Schwartz function.

Thus the uses of `tsum_prod` and `tsum_comm` in the two-dimensional proof have actual summability witnesses. They are not identities inferred from a default value of a nonsummable tsum.

## 3. Affine lattice, determinant and the full frequency carrier

`Poisson/EisensteinLattice.lean:58–133` proves the Fourier change of variables for a real continuous linear equivalence A of C. It uses

`inverseJacobian(A)=|det(A)^-1|`, `dualMap(A)=(A^-1)*`,

and the positive translation phase `exp(2*pi*i*<b,dualMap(A)w>)`. The Fourier integral itself has the negative phase. Haar-measure change of variables supplies the determinant. `affine_lattice_poisson:125` applies the preceding plane result to the affine Schwartz pullback.

For the Eisenstein basis `omega=-1/2+i*sqrt(3)/2`, the lattice map is `A_c(x+iy)=c*(x+omega*y)`. Its determinant is `|c|²*sqrt(3)/2`, so `eisenstein_inverseJacobian:234` is `2/(sqrt(3)*|c|²)`. The requirement c!=0 is explicit and protects both the linear equivalence and all modulus divisions. `actual_eisenstein_coset_poisson:246` reindexes each coset `b+c*O` by all integer coordinate pairs, not by a half lattice or by unit classes.

`actual_eisenstein_periodic_summable:293` bounds any finite residue-class weight P by `sum_r |P(r)|` times a norm-summable Schwartz lattice function. `actual_eisenstein_periodic_poisson:307` partitions the original sum by the finite quotient `O/(c)`. `GaussSum/QuadraticNormalization.tsum_periodic_weighted_partition:372` explicitly requires Summable. Its fiber map `w -> representative(r)+c*w` is bijective: injectivity uses c!=0, and surjectivity uses ideal membership. `fiber_tsum:499` is therefore an exact reindexing, with no multiplicity or missing associate factor.

On the dual side, `dual_lattice_summable_norm:336` obtains norm summability from the Fourier transform of the affine pullback and its nonzero Jacobian. `finite_phase_sum:350` then moves the finite residue sum inside the dual tsum using that witness and unit-modulus Fourier phases. It leads to `actual_eisenstein_poisson_explicit:452`, with frequency

`xi_c(k,l) = [k + i*(k+2l)/sqrt(3)] / conjugate(c)`.

The bijection `Poisson/OscillatoryGaussian.dualFrequencyEquiv:270` sends `(k,l)` to `eval(k+l,k)` and has inverse `(a,b) -> (b,a-b)` in Eisenstein coordinates. It is unimodular, covers all O, and sends zero to zero. No subset of the dual frequencies is discarded.

## 4. Trace convention and radial scaling

In `GaussSum/SexticRadialPoisson.lean:232–340`, the definitions are

`paperE(z)=breveE(z/eisLam)=exp(4*pi*i*Im(z)/sqrt(3))`,

`paperFrequency(u)=(2*i/sqrt(3))*conjugate(u)`,

`paperFourier(f,u)=(2/sqrt(3))*integral paperE(-z*u)*f(z) dz`.

Here `eisLam=1+2*omega=i*sqrt(3)` in this additive trace convention; it should not be confused with other good-prime parameters elsewhere. `ChineseRemainder/AdditiveCharacters.breveE_div_lam_eq_e:556` derives the exponential formula directly. The inner-product identity gives `FourierChar(<z,paperFrequency(u)>)=paperE(z*u)`. Consequently the explicit dual frequency is precisely `paperFrequency(embed(h)/embed(c))` under the bijection in §3.

`paperFourier_eq_standard:307` identifies the paper transform with `(2/sqrt(3))*standardFourier` at that transformed frequency. Its scalar absorbs the Eisenstein covolume factor, so `actual_eisenstein_paper_poisson:342` has prefactor `1/|c|²`, not `2/(sqrt(3)|c|²)` a second time. `eisTraceModChar_frequency:330` identifies the finite phase with the actual residue-class additive character at `h*r`; this also supplies representative independence.

`paperRadialFourier(W,t)=paperFourier(z -> W(|z|²),sqrt(t))` (`:426`). Rotation invariance is proved by an actual unit complex change of variables, with u=0 handled separately. Positive scaling K uses `a=1/sqrt(K)`, whose real Jacobian is K. Thus `paperFourier_radial_scaled:462` gives

`paperFourier(z -> W(|z|²/K),u)=K*paperRadialFourier(W,K*|u|²)`.

The standard frequency norm has a factor 4/3, but that factor is already part of `paperRadialFourier`; it must not be inserted again into its argument. `actual_radial_paper_poisson_trace:499` therefore reads

`sum_z P(z mod c)*W(|z|²/K) = (K/|c|²)*sum_h [sum_r P(r)*psi(h*r)]*paperRadialFourier(W,K*|h|²/|c|²)`.

All sums here are over the full lattice or finite quotient, K>0 and c!=0. The actual scaled radial test is a plane Schwartz function, constructed from W by a tempered proper composition and a continuous linear equivalence. No analytic continuation or numerical Fourier value is used.

## 5. Actual Gauss transform, modulus units and masks

`canonical_principal_gauss_transform:632` transports the finite quotient to CRT coordinates. `canonical_finite_prime_gauss_transform_scalar:114` applies the finite-field transform to local powers with `0<j_i<6`; `finiteSexticQuotientRow_inv_eq_star:132` converts the inverse row value to its conjugate, including zero values. The result is

`sum_r row(r)*psi(h*r)=conj(row(h))*G`, where `G=sum_r row(r)*psi(r)`.

The identity allows any additive character. It does not divide by G, require G nonzero, or require a norm-one Gauss theorem. Local multiplicative nontriviality is required and supplied by the canonical sextic-power theorem. The case h nonunit is part of the finite transform, not a cancellation of a zero row denominator. The empty local family is permitted and gives the trivial modulus case.

`canonical_radial_poisson:669` substitutes this transform into §4. `canonicalNormalizedGauss=G/|c|` (`:726`) is then a definition, so `canonical_radial_poisson_normalized:732` has prefactor `K*canonicalNormalizedGauss/|c|`. Only |c| is divided out and c!=0 is proved.

The actual product of chosen prime generators n may differ from the chosen generator c of the product ideal by a unit. `GaussSum/CubicTrace.canonicalNormalizedGauss_frequency_transport:457` retains its row phase. `gauss_weighted_radial_sum_transport:475` changes the full frequency variable by multiplication by that unit, preserving |h| and zero. `gauss_weighted_finite_radial_sum_transport:498` extends this to the finite divisor sum. Thus replacement by `canonicalProductGauss` is justified **inside those radial sums**; the source does not assert an unconditional pointwise equality of the two Gauss constants.

`PrimeRows/IdealGenerators.lean:98–290` supplies mask inclusion-exclusion and dilation. `tsum_rowCoprimeMask_subsets` uses Summable to interchange the finite subsets with the original tsum. Each ideal fiber is exactly a nonzero generator times O; the scale becomes `K/|e|²>0`. Applying normalized radial Poisson produces one factor `mu(E)*row(e)/|e|²` and the argument `K*|h|²/(|e|²*|n|²)`. No unit count or second dilation factor is inserted.

`CubicSieve/SecondPoisson.masked_pair_second_poisson:83` specializes the active row to the disjoint pair: it matches `conj(row_T)*row_S`, and the dual factor is `GaussProduct*row(e)*conj(row(h))`. Its prefactor is exactly `Y/|n|`. The active exponents satisfy the nontriviality hypotheses. All finite mask subsets and all lattice h remain present.

## 6. From the original energy to physical modes

`CubicSieve/ChildTransfer.inputConjugateRow_sq_overlap:179` expands the actual squared finite source row. It reindexes each pair by common support G and disjoint residual U,V, uses multiplicativity on disjoint supports, and turns the common row square into the coprime mask. No diagonal or residual pair is dropped.

`maskedSecondSource_summable:460` has a direct norm majorant: the mask is <=1, and the product row times the radial Schwartz function is summable. `inputConjugateRow_smoothed_overlap:476` proves each of the finitely many G,U,V functions summable before using `Summable.tsum_finsetSum`. Arbitrary finite source coefficients are allowed; no source-coefficient bound is needed for this equality. Substituting §5 gives the exact `inputConjugateRow_smoothed_second_poisson:540`, with `maskedSecondDual` defined at :527.

`Inversion/InitialRayAttachment.initial_input_physical:249` sets Y=Z^m>0 and H=`initialTest(mark,V,Z,D)`. The original normalized square has factor `|Z^(-D/2)|²=Z^-D`; this is the sole extra normalization. It is pulled through the convergent expression, not replaced by `Z^-2D` or by a modulus-dependent factor. `normalized_overlap_mode:224` then identifies each dual summand with the actual physical mode through the kernel and ray identities inspected in the marked-zero audit.

The unbounded frequency carrier is O throughout. `initialPhysicalMode_summable:298` separately supplies norm summability by the positive radial scale, bounded finite Gauss/row coefficients, and the radial Fourier lattice majorant. `InitialPhysicalLimit.physicalFrequency_hasSum:49` takes finite arithmetic sums of these witnesses; `original_input_zero_nonzero:76` separates h=0 exactly, and `nonzero_frequency_norm_le:92` passes all finite nonzero-frequency bounds to that genuine sum.

## 7. Zero and retained-window compatibility

The frequency bijections and unit multiplications preserve zero. Its actual off-diagonal vanishing and signed density are the marked-zero audit's identities, with no alteration to the prefactor derived here. The h=0 case is not justified by the high-radial estimate.

For each finite nonzero frequency set, `InitialPhysicalReassembly.finite_physical_reassembly:141` restores the full finite source. The dyadic retained/high split is then the exact finite identity `InitialDyadicAssemblyTail.actual_physical_retained_tail:180`. Its windows are physical weights, not a replacement dual lattice. The previously reviewed coverage proof supplies uniform finite bounds before `InitialPhysicalLimit` takes the infinite-frequency conclusion. This order avoids interchanging an infinite family of dyadic decompositions without justification.

Every prime pool and mask family in this chain is finite. The infinite variables are lattice source/frequency points. This audit asserts no limit over prime pools and no uniform summability norm across arbitrary modulus/source data; exact identities and individual summability are sufficient for these steps, while the later analytic estimates separately establish their required uniform constants.

## 8. Remaining foundations and status

The bounded audit reconstructed the analytic route rather than merely listing imports. Its remaining lower inputs are specific:

* Mathlib's one-dimensional Schwartz Poisson summation, Fourier inversion under the stated integrability conditions, product Fourier/Fubini identity, continuous linear change of Haar measure, and Schwartz transform/composition APIs. The OAI bodies show where their hypotheses are supplied; this task did not reprove or kernel-check those library theorems.
* The canonical local sextic character's nontrivial powers and finite-field Gauss transforms. `Arithmetic/EisensteinEmbedding.canonicalSextic_pow_ne_one:471` reduces to the sextic character order. `Poisson/EisensteinLattice.gauss_transform_finite_crt_scalar:563` explicitly factors the additive character across CRT coordinates and handles zero coordinates; its local input is `ShortDraftFiniteGaussFourier.product_gauss_transform`. The exact consuming transform and zero/nonunit cases were inspected; the character-order and local finite-field foundations remain separate.
* Actual Eisenstein coordinate, quotient and ideal-generator identifications. The explicit affine determinant, bijections and phase calculations were read; their complete transitive algebraic foundations were not audited here.
* The product-generator Gauss conversion and later finite ray expansion have their own arithmetic foundations. Unit transport at the radial-sum interface was checked, and the actual physical normalization was matched; this does not certify every deeper reciprocity/conversion theorem.

No new final premise, corrected source theorem or numerical input is proposed. The present result is a coherent source-level proof cut supporting the original Poisson identity and its zero/retained consumers. Build compatibility, expanded theorem types and permitted transitive axioms remain independent validation gates.

## 9. Whole-file source pins

Paths below are relative to the provider source base stated in §1, except the separately labelled manifest.

| Source | SHA256 |
|---|---|
| `GaussSum/SecondPoissonScale.lean` | `60105F7CBAACC19CEC0704164673538A6924E7201F224C321580179FF88FD31A` |
| `Poisson/EisensteinLattice.lean` | `CC52C9B695ECEC6ECD54AD79C8870CD36A53E99D94BF6B3D5F3A04093DC99D69` |
| `Poisson/OscillatoryGaussian.lean` | `783ADF9A66F51BE283351FF2098D41FF066CE526137C94E643A93660953E9B68` |
| `GaussSum/SexticRadialPoisson.lean` | `8DB6F0F3B850868F18706630A4F8F1DA42A345D2F0D32949B8D4CC6CB0F5D21C` |
| `ChineseRemainder/AdditiveCharacters.lean` | `A4BFF8663A80E4B542438F5FEA067CA22B69C4F3333FACCFAA320187C3BF2D96` |
| `GaussSum/QuadraticNormalization.lean` | `84DB4FE43213ABBD92EDA4B7A94884909C58591081AF5117B88420A350B2DA31` |
| `PrimeRows/IdealGenerators.lean` | `FFD100322A61D78A44F28CE7EDEA6E7CC756D7055C5710B42809B1B2AA016949` |
| `GaussSum/CubicTrace.lean` | `C64A17DA1132F4B89D8218AEF6F199DC9DE6DA78F23CF0A79FFACB8F9E23833C` |
| `CubicSieve/SecondPoisson.lean` | `53007B41EE56A39DD8DA4877EB3890D90C1D6F353727683001FA018D7FDCCF39` |
| `CubicSieve/ChildTransfer.lean` | `8312D6CA7409662A55C69D3CBA179EBB047E352E55CFFCF5CFF7C62096310AE2` |
| `CubicSieve/RayCoefficients.lean` | `7661899BF8E3F925540E7B251995B5AEC8DF88AD6E75A8DC10A0FF4DA65C5D8F` |
| `Arithmetic/EisensteinEmbedding.lean` | `37D3AFD1026BDB466677BCC0FAC8173B93B59865AACEF456D9CE5CABD362242C` |
| `Inversion/InitialRayAttachment.lean` | `24DBF037655CB31F79DF0CAC21FF529255A43F5A5C93DBE78054D558E5601613` |
| `Inversion/InitialPhysicalLimit.lean` | `E134A6C0CC9C484B4495535FBAA298B7F4926DE068A058BDD8E16ED93C1F7241` |
| `Inversion/InitialPhysicalReassembly.lean` | `2B3024A6AB5EE3D35BECCF45FFE078B4C520A1C94198657E41DDE1FA1FAAB973` |
| `Inversion/InitialDyadicAssemblyTail.lean` | `803B67774E526D6089F223DB95C774428B2830963242029E150C4A8F2CC11C69` |
| `QuadraticSieve/PrimePools.lean` | `5C7D9F908A6A5EA19F52E9FE2E514170FB986E5F10298CC041B945139132A11F` |
| `work/openai-math/lean/lake-manifest.json` (outside B) | `B61E36D7FB579F9EB682AFC4623E871934189E1248C4C92E69F9E9E2E6FC0227` |
