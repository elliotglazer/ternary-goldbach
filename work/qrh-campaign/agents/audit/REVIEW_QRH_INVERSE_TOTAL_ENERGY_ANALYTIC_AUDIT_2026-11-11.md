# Independent review: inverse total energy and marked padding

2026-11-11. **PASS at bounded, conditional source-reading scope; no correction requested.** This reviews [the author report](<C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/zero-sum/QRH_INVERSE_TOTAL_ENERGY_ANALYTIC_AUDIT_2026-11-11.md>), SHA256 `8782F2CBAEF66F9C029DB2AE8EAEDD3BC785273A1CBC02390295765F3A53D05E`. All 35 source-table hashes independently match. The provider revision is `4eaee87548250b2682affda7d05d947c05554bae`.

The review independently reconstructs the actual-operator identities, full-frequency limit, zero/nonzero separation, padding and finite-row/Fourier energy transfer. It does not independently establish every physical reference, rank-energy, rapid-tail, Fourier or arithmetic estimate used below those steps. It neither validates the complete provider nor establishes new Lean proofs. No build, source change, numerical evaluation or spectral scan was performed.

## 1. The actual target and quantifiers

[InitialTotalEnergy.original_input_bound](<C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialTotalEnergy.lean:20>) bounds

`norm(sum_u Phi(norm(emb u)^2 / Z^m) * norm(Z^(-D/2) * inputConjugateRow(...,u))^2)`.

`inputConjugateRow` is the finite support-Mobius sum with actual coefficients, coprimality masks and conjugated finite squarefree rows. The initial test is `primeMark(A) * V(primeProductNorm(A)/Z^D)`. These are concrete function bodies, not an arbitrary energy field supplied by a hypothesis. The zero/nonzero assembly retains these bodies through exact finite-sum and Poisson identities.

The degree and pool multiplier are fixed before the modulus q. The allowed q-dependent constant and threshold precede Z, the sufficiently large finite pool, all slot data, the finite frequency set, and modulation. Nonnegative slot exponents, disjoint lists, bounded coefficients, periodic multiplicative character, live assigned windows and the separate product bounds remain requirements. The capacity relations imply `D<=cap`; they do not require `D>=0`. Nothing in the inspected proof replaces these conditions with the desired energy conclusion or uses an impossible case to discharge general live data.

The target permits complex Schwartz Phi. Its norm is essential. Positivity enters only later when restricting a specially chosen radial majorant to finitely many physical rows.

## 2. Full energy really is a convergent sum

[InitialPhysicalLimit](<C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialPhysicalLimit.lean:20>) first defines the frequency function by finite overlap/divisor sums. Its finite-sum identity uses precisely `finiteSource` of the chosen frequency set. Reassembly restores common indices only after showing the added terms vanish; it is not an unproved exchange of two infinite sums.

For fixed pool and fixed source data, [initialPhysicalMode_summable](<C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialRayAttachment.lean:298>) reduces the mode to [secondPairRadialMode_summable](<C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/QuadraticSieve/PrimePools.lean:472>). The active Gauss factor is bounded by the norm of one fixed canonical Gauss sum: both finite sextic factors have norm at most one. The Fourier scale

`K = Z^m / (norm(emb e)^2 * norm(emb n)^2)`

is strictly positive because the divisor generator and active prime product are nonzero. Absolute lattice summability of `paperRadialFourier Phi (K*norm(emb h)^2)` then proves complex summability of the mode. Finite overlap sums preserve it. The radial-summability body uses polynomial Fourier decay and a summable Eisenstein Cauchy majorant; it does not assign a useful value to a nonsummable `tsum`.

The quantitative finite bound covers **every finite nonzero-frequency subset** with one constant. [norm_tsum_of_finite_bound](<C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialHighFrequencyTailInfinite.lean:21>) passes that bound through `HasSum` by continuity of norm and closedness of the inequality. No uniform convergence rate over all pools or Z is needed: those are fixed during the limit, whereas the bound was already uniform. A bound at just one truncation would not suffice; that is not the source statement.

## 3. Scaling, zero mode and finite-mode budget

The physical kernel contains `Z^(-D)`, `Z^m/norm(emb n)`, and `1/norm(emb e)^2`. Here norm means the **Euclidean embedding norm**, not the algebraic norm; its square is the corresponding ideal norm. The Fourier argument uses the squared embedding norms above. The amplitude square is exactly `abs(Z^(-D/2))^2=Z^(-D)`. The conjugate window uses minus modulation, and the second ray column uses negative frequency.

[InitialZeroModePhysical](<C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialZeroModePhysical.lean:22>) kills off-diagonal active supports at frequency zero. Equal disjoint supports must both be empty. The remaining expression is exactly `Z^(-D) * truncatedSecondZero`, retaining the divisor-Mobius factor. Zero is removed from the nonzero sum and added back once.

Given the coefficient-mass and zero-density estimates identified in the author report, put X=`Z^D`>0 and Y=`Z^m`>0. Their product is `C*Y*X^epsilon` after the X inverse normalization. Choosing epsilon=`loss/(L+1)`, with `D<=L` and `Z>=1`, gives `C*Z^(m+loss)` even when D is negative. This normalization and exponent comparison check independently.

For nonzero modes, the source splits finite physical sums into retained windows and a rapid tail. It pays the retained exponent `m+11eta+pi+(epsilon+4eta)` and the window-count loss, giving `m+15eta+pi+epsilon+loss`. The tail specializes to `C_tail*Z^(-1)` and is absorbed using the nonnegative target exponent and height factor at least one. The constants add; no cancellation is assumed. This verifies the assembly and use of the retained/reference and tail theorems, not their entire underlying analytic proofs.

## 4. Finite-row and logarithmic-integral transfer

This independent review goes one step inside the Fourier-energy leaf listed conservatively by the author. [finite_rows_le_input_norm](<C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialInputRadial.lean:31>) proves summability, takes real parts, uses `Re Phi>=0` globally and `Phi=1` on [0,1], then applies `Re z<=norm z`. Phi need not be real everywhere for this implication.

[InitialTotalRows](<C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialTotalRows.lean:18>) preserves coefficient bounds under unit-modulus logarithmic twists. [InitialMarkedInputEnergy](<C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialMarkedInputEnergy.lean:18>) expands a finite row to establish the required integrability. [InitialOverlapHeight](<C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Inversion/InitialOverlapHeight.lean:14>) divides by the strictly positive `(1+abs(t))^J`, applies finite-dimensional integral norm control, and pays the squared Schwartz Fourier moment. The constant does not gain an uncharged number-of-rows factor. The exact excluded-tuple Fourier identity and its underlying inversion/moment bounds remain separate analytic inputs.

The later complete-pool choice is finite and made after the tuple data. This is compatible with the earlier bound's uniformity over every sufficiently large pool. It is not an infinite-pool limiting argument.

## 5. Padding and assigned-tuple cost

[padded_source_energy](<C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Dictionary/InverseMarkedReferencePaddedEnergy.lean:15>) chooses rho=`min(epsm/4,1/4)`, gap=`rho/4`, eta=tau=`rho/400`, and pi=epsilon=loss=`rho/16`. Thus the total exponent cost is `49*rho/40 <=49*epsm/160 < epsm`.

With E the total slot exponent and G an assigned-subset exponent, `0<=G<=E<1/2` and `r-eta<=rr<=r` imply `D=rr+E-2G>=-2`. The strict original capacities supply fixed margins after replacing the row-radius exponent 1 by `1+rho`; the threshold therefore need not depend on an unrecorded distance from a strict endpoint. The parent capacity and eta/tau inequalities also hold.

The assigned-subset estimate pays `(2^K*assignedConstant(K,2))^2`. In source `assignedConstant(K,b)=(128*b)^K`; the factor comes from actual list cardinality and coefficient bounds, canceled by the assigned normalization, then a finite weighted triangle inequality. It is independent of U and absorbed into the allowed constant. The eventual `2^K<=U^eta` is paid separately. All admissibility, excluded-prime, live-window and character requirements are retained.

## 6. What remains open

The local implications above do not establish `canonical_marked_energy_exists`, the full `actual_physical_reference_bound`, or `original_physical_tail_rapid`. Their noncircular proofs and quantitative uniformity remain substantive next work. The foundational second-Poisson/finite-Gauss identities, polynomial Fourier decay and lattice summability, divisor subpower estimate, excluded-tuple Fourier inversion and Schwartz moment bounds likewise require their own validation where not already independently covered. The finite-row/integral subarguments checked here narrow that last cut; they do not eliminate it.

The author correctly preserves these boundaries. No bound here follows merely from `CertifiedBand` or from a wrapper named `source_moments`. Terminal-band production, the other provider branches, actual elaboration, expanded types and transitive standard-axiom validation remain open. The intended Goldbach roots and the original sole binary input for the full statement are unchanged.

`DRAFT_ANCHORS: 0 created; UNREGISTERED_SORRIES: 0 introduced; DRAFT_IMPORT_VIOLATIONS: 0 introduced; SEALED_THIS_TURN: 0`.

## Independent source pins

Paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL`. They identify the source bodies read for this review, not a compiled closure.

| File | SHA256 |
|---|---|
| `Inversion/InitialTotalEnergy.lean` | `15B1B715C4449310DE64E31FA4852233EE85E7B57C1D03F44ED3F78CEE5616F8` |
| `Inversion/InitialFiniteEnergy.lean` | `A93012D7C56AAFEF323F21058B632584D99C60E4032033ECD5EF3DBE525F6981` |
| `Inversion/InitialPhysicalLimit.lean` | `E134A6C0CC9C484B4495535FBAA298B7F4926DE068A058BDD8E16ED93C1F7241` |
| `Inversion/InitialPhysicalReassembly.lean` | `2B3024A6AB5EE3D35BECCF45FFE078B4C520A1C94198657E41DDE1FA1FAAB973` |
| `Inversion/InitialHighFrequencyTailInfinite.lean` | `DC799D17448ADB67FBDA35D045CF12B0E7D07366206BED350BD6D52FB533EEC8` |
| `Inversion/InitialRayAttachment.lean` | `24DBF037655CB31F79DF0CAC21FF529255A43F5A5C93DBE78054D558E5601613` |
| `QuadraticSieve/PrimePools.lean` | `5C7D9F908A6A5EA19F52E9FE2E514170FB986E5F10298CC041B945139132A11F` |
| `CubicSieve/ChildTransfer.lean` | `8312D6CA7409662A55C69D3CBA179EBB047E352E55CFFCF5CFF7C62096310AE2` |
| `CubicSieve/SecondPoisson.lean` | `53007B41EE56A39DD8DA4877EB3890D90C1D6F353727683001FA018D7FDCCF39` |
| `GaussSum/SexticRadialPoisson.lean` | `8DB6F0F3B850868F18706630A4F8F1DA42A345D2F0D32949B8D4CC6CB0F5D21C` |
| `Poisson/RadialFourier.lean` | `86D5DEB861723EBF182C8A8489EFD29320F97049F4CCB471684C827F931C8E58` |
| `Inversion/InitialZeroModePhysical.lean` | `FF709042F545ED380D504D0D9E61EE03BC75AF2CC0074F99C3365157002A54DE` |
| `Inversion/InitialZeroModeBudget.lean` | `54EF5B0F8B3BBF3C5D8CF7E68411F6B539A2D05A89DDB34D84F744F0C68E4637` |
| `Inversion/InitialMarkedReserve.lean` | `E7D3537999024AED5699992EE7FBA17702527714B44C87CB635984E4547A6055` |
| `Dictionary/InverseMarkedReferencePaddedEnergy.lean` | `AF3C645DF35997C69F960CFE313241A7F9931B48C130BBB8E854973F0E05ED26` |
| `Dictionary/InverseMarkedReferenceSourceEnergy.lean` | `BD28C13F2C3FB93EBADD64C958BED2FD9AEA8F466DB7C7EC231CCFED5345D159` |
| `Inversion/InitialResidualUniformEnergy.lean` | `598BECA7B45B91BCD522B0BAC65FEF736749D6F5B0345FE1749CE6E947BC5FCF` |
| `Inversion/InitialResidualPool.lean` | `B7B753B2BF4E83E9FEB811B830848BEC14A190FA63839D762999622C28F75071` |
| `Inversion/InitialResidualTupleEnergy.lean` | `443C2F7F23BC040396E382A310E683D3E50AF430BD7D10AD33A7F6784CB2B4B3` |
| `Inversion/InitialTotalFourier.lean` | `4BF56C66A5A7E4501927F1A4234F7E82F328491CE1014CE1A9FF014C22ACA39E` |
| `Inversion/InitialTotalRows.lean` | `7066DA0AB40C101B3FD76095B844F66829D82CC4C36EDFFA652371834A094D51` |
| `Inversion/InitialInputRadial.lean` | `4F4F2D99F5F9CCD356586DECE1B231FFA8B9B89FAB955DE1011EBFADB71EC77E` |
| `Inversion/InitialMarkedInputEnergy.lean` | `DBB26874E9A1A9123FB6D7521695A525D8DC053C95C2DD35FAEB8AC68966A6DF` |
| `Inversion/InitialOverlapHeight.lean` | `4771B24D7373EFC16D5F4AB5C65BC155823BADE57A61DC1BBE25E869A67B19B5` |
| `Descent/CommonMeasure.lean` | `A81F6E623099CF7A0F87239B4A73B34B4B22E97835CB35109CE838C04F3DEE1E` |
| `Dictionary/InverseMarkedReferenceEnergy.lean` | `EA06B886C68E3B55855A5897D301658A7A91B5D41E541AD109EDB0CD5AF796F7` |
| `Dictionary/InverseMarkedReferenceMass.lean` | `2A5E8A48820D32198EEC154EE9FB6B195DED813E566D57FFAA4AFD4EC4925610` |
| `Dictionary/InverseAssignedCount.lean` | `5873921FB334175C127EA53E4A291C8D5B79D946A4B84D32B5D139B1AED277A3` |
| `Inversion/InitialConjugateEnergy.lean` | `972BD444968E35B24F1C678046F2C1223D087F41ED259992B25CD7ABC191998C` |
