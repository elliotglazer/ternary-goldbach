# QRH deleted-mode energy and divisor-mass audit

2026-11-11. Conditional local-source PASS, awaiting independent review. This is a read-only mathematical source audit. No Lean build, declaration, numerical evaluation or scan was performed. Paths below are relative to work/openai-math/lean/OAI/NumberTheory/DirichletL/. Exact source hashes appear in the final table.

## 1. Result and scope

The two targets are Descent/SecondDeletedModeEnergy.actual_second_deleted_mode_branch_energy:18 and Descent/SecondActualMass.actual_second_normalized_mass:35. The inspected proofs do more than assume an abstract energy or divisor bound: the deleted-mode estimate reduces to an explicit injection of actual source fibers into finite ideal-divisor choices, followed by weighted Cauchy; the mass estimate reduces to a finite ideal count and a proved small-power divisor estimate.

No missing multiplicity, uncharged source cardinality, default infinite-sum argument or normalization error was found in this path. The source functions and their punctures remain actual throughout the transport. Deletion is justified by exact zero columns, not by ignoring complex summands. The surviving squarefree filter is justified by nonzero source coefficients.

The result remains conditional on the stated source admissibility, prime-generator hypotheses and eventual child moment bounds. This audit does not prove the four child moments, the full provider, or the foundational local Gauss/primary-generator identities. Section 7 identifies the residual cut precisely. All sums in the two target arguments are finite; there is no additional limiting or summability obligation in these arguments.

## 2. Actual source, child map and repeated fibers

Descent/SecondSourceEncoding defines MarkedSecondSource with a cube, first common set and divisor, actual second-expansion data, quotient ideal, old ideal-prime assignments and new generator-index assignments. Descent/ActualSecondEnergy:16,19 defines the child and the outer-triple image. In symbols, the child is

\[
c(x)=(\gamma(x),f(x),k(x)),\qquad
\Gamma=\{\gamma(x):x\in S\}.
\]

The finite image \(\Gamma\) forgets repetitions, but they are charged by the fiber count before projecting energy onto \(\Gamma\). Replacing the source sum by an unweighted image sum would not be this proof.

ActualSecondSourceConditions requires cube admissibility, disjoint first common/cube support, first and second divisor containments, the old-slot divisibility and new-slot membership rules, and a nonzero quotient. The generator hypotheses include nonzero primary generators, maximal prime ideals, pairwise coprimality, injectivity of the prime-ideal label map and the primary congruence. The norm bound for the actual signed weight additionally uses residue characteristic different from two and \(\|\Psi(a)\|\le1\).

The map to SecondOriginalSource is injective on admissible cubes. Its proof in SecondSourceEncoding:31 recovers the cube from its product ideal and three divisor keys, then recovers finite subsets using injectivity of their prime products. Eisenstein/SmoothTests.cubeDivisorKey_injective_on_product:601 recovers the right prime product by cancellation against the nonzero left product, then recovers both exponent functions and both bit subsets. Admissibility is essential to the bit-subset interpretation.

Descent/SecondSourceTuples.originalSecondTuple_injective:94 then recovers the eight ideal coordinates, residual subsets and all assignments. The frequency is transported by
\[
k\longmapsto (u^4v)k,
\]
an injective unit multiplication; it is not discarded. The source validity proof uses the actual cube-product factorization, the radical divisibility of cube support, and the old/new assignment support conditions. It does not simply posit that the encoded tuple is valid.

## 3. Explicit divisor encoding and energy projection

Write \(d(I)\) for the number of ideal divisors of a nonzero ideal \(I\). Inversion/SecondFibers.Valid records exact label, cube-split, extracted-common and row equations. For a fixed child \((\gamma,f,k)\), its proof encodes a valid tuple by:

* Four divisors of \(f\).
* One divisor of \((\gamma.q0\,f)^2\).
* Three divisors of \(\gamma.q0\,f\).
* One divisor of \(\gamma.q0\,f\,\gamma.quotient\) for each old assignment.
* One divisor of \(f\,\gamma.residual\) for each new assignment.

The remaining tuple fields are determined by these choices. Specifically the common residual, cube residual and second cube are recovered by cancellation against proved nonzero ideal factors. The extracted common is determined by its product equation. The frequency is recovered from
\[
\operatorname{primaryGenerator}(d_1)
\operatorname{primaryGenerator}(d_2)\,\nu=k
\]
with both generators nonzero. Thus there is no additional number-of-frequencies factor in a fixed child fiber.

The resulting explicit injection proves
\[
\#\operatorname{fiber}\le
d(f)^4d((qf)^2)d(qf)^3d(qft)^{J_o}d(fr)^{J_n},
\]
where \(q=\gamma.q0,t=\gamma.quotient,r=\gamma.residual\). The elementary divisor-product surjection in Inversion/InitialFibers:60 gives \(d(IJ)\le d(I)d(J)\), without requiring coprimality. Hence this is at most
\[
d(f)^{9+J_o+J_n}d(q)^{5+J_o}d(t)^{J_o}d(r)^{J_n}.
\]
For \(J_o,J_n\le2K\), positivity of divisor counts gives
\[
d(f)^{9+4K}\,D_K(\gamma),\qquad
D_K(\gamma)=d(q)^{5+2K}d(t)^{2K}d(r)^{2K}.
\]
These are precisely the exponents in SecondSourceEncoding.actual_marked_second_source_fiber:83, TripleMass:11 and SecondCauchy:12.

Define the actual finite label-row energy
\[
E_P(\gamma)=\sum_{f\in\mathcal F}d(f)^{9+4K}
\sum_{k\in\mathcal R}|P(\gamma,f,k)|^2.
\]
ActualSecondEnergy.actual_second_energy_projection:80 groups a finite weighted source sum by its actual child. Every fiber is bounded by the preceding divisor weight. Applied with weights \(|w_x|\le1\), weighted Cauchy yields
\[
\left|\sum_{x\in S}w_x P(c(x))\overline{Q(c(x))}\right|
\le
\sqrt{\sum_{\gamma\in\Gamma}D_K(\gamma)E_P(\gamma)}
\sqrt{\sum_{\gamma\in\Gamma}D_K(\gamma)E_Q(\gamma)}.
\]

Nonnegative square energies justify extension to larger finite label/row/triple sets. The proof does not assert monotonicity of the original complex sum. If both energies are at most \(A\), the product of square roots is \(A\sum_\Gamma D_K\), not \(A^2\sum_\Gamma D_K\).

## 4. Deleted lists and the actual coefficient

Descent/SecondWeights:15 defines the signed weight as the squared norm of the actual input coefficient, ideal Möbius value, and actual common weight. The norm proof at line 29 bounds these three factors individually by one using the input, Möbius and common-weight theorems. No external coefficient is silently set to one.

SecondSquarefree:134 proves that a nonzero actual signed weight forces the actual child label squarefree. Its two mask consequences are coprimality of the second common ideal with the old label, and of the overlap ideal with their product. Together with the known squarefree factors they prove squarefreeness of the full child label. SecondVaryingSupported:16 first filters by nonzero weight with an exact equality of sums, then applies this property. It subsequently enlarges only nonnegative energies.

For list restoration, SecondParentLists.actual_parent_deleted_prime_killed:22 shows that each permitted deleted prime divides the raw inherited puncture times the raw child label. A deleted prime from cube or first-common support is present in their reconstructed product; a prime dividing the quotient is present in its chosen generator. The elementary identity behind the former is SecondFixedFamily.actual_second_extracted_support_killed:72, using
\[
\operatorname{generator}(E)\operatorname{secondMaskQuotient}(E,G)
=\prod_{i\in G}p_i
\]
and the cube radical divisibility.

Descent/Canonical.finiteCanonicalMarkedRow_restore_lists:82 proves equality term by term over each finite child column \(U\). If \(U\) avoids deleted primes, the mark is unchanged. Otherwise a deleted prime belongs to \(U\) and divides puncture times label, so the entire column vanishes on both sides. This is a genuine equality, valid for complex coefficients.

SecondModeParentLists:29,59 carries this statement to the canonical primary generator by equality of principal ideals. The result restores full parent lists inside the child polynomials while retaining the restricted/deleted lists in the extracted outer marks. It does not restore those outer marks without payment.

SecondVaryingLists:42,66 expands those marks exactly into slot assignments from the actual varying lists intersected with the common/overlap support. The varying assigned source is a filter of the base assigned source, and the coefficient product has norm at most one. Its new slot count is \(|J_1|+|J_2|\le2K\). Thus the same fiber bound applies; there is no missing list-cardinality factor.

Finally SecondDeletedModeEnergy:18 takes
\[
\mathrm{phase}(x)=w_x\,\mathrm{secondModeOuter}(x),
\]
whose norm is at most one, and applies the preceding estimate to the actual right and left child polynomials. SecondPhysicalRows.actual_second_row_ball:42 transports the cutoff exactly from the original frequency with its actual multiplier to the canonical child row with multiplier one. Both zero exclusion and radius are preserved by the squared-norm identity. The canonical row is not independently chosen.

## 5. Small-power triple mass, with uniform constants

QuadraticSieve/FiniteOperator.ideal_divisor_small_power:339 contains an elementary finite-prime split. For a fixed \(\epsilon>0\), choose a natural cutoff \(N\) such that \(n^\epsilon\ge2\) for \(n\ge N\), let \(\mathcal S\) be the finite set of ideals of norm at most \(N\), and put
\[
b=2^\epsilon>1,\qquad c=1+(b-1)^{-1}.
\]
For a prime factor \(P^e\), if \(P\notin\mathcal S\), then \(e+1\le2^e\le(NP)^{\epsilon e}\). If \(P\in\mathcal S\), the proved linear/geometric estimate gives \(e+1\le c\,b^e\le c(NP)^{\epsilon e}\). The divisor count injects into bounded multiplicities of the prime-factor multiset. Multiplying and using exact norm factorization gives
\[
d(I)\le c^{|\mathcal S|}(NI)^\epsilon.
\]
The constant is chosen before \(I\). This is an existence estimate; it supplies no useful computed numerical constant or uniform bound as \(\epsilon\downarrow0\).

TripleMass.ideal_divisor_power_small:19 applies that argument at \(\epsilon/(j+1)\), raises to \(j+1\), and uses \(d(I)\ge1\), yielding \(d(I)^j\le C_{j,\epsilon}(NI)^\epsilon\). Therefore
\[
D_K(\gamma)\le C_{K,\epsilon}(Nq\,Nt\,Nr)^\epsilon.
\]
There is no extra factor of three on the exponent: multiplication of the three individual norm powers gives the power of their product.

The finite ideal count is also explicit. Hecke/FiniteEulerFactors.idealsUpTo_card_le:430 injects ideals into chosen generators and then into Eisenstein coordinates. Arithmetic/LatticeCount:22,27,56,66 bounds \(a^2-ab+b^2\le D\) by a square lattice box, obtaining \(64(D+1)\). Mellin/InverseContour.finite_ideal_count_real:306 then gives \(128H\) for \(H\ge1\), including the floor correctly. Its fixed_triple_count:319 applies this separately to three coordinate images, giving
\[
\#\Gamma\le128^3BTR
\]
when the nonzero triple ideals have norms bounded by \(B,T,R\ge1\). Multiplying this count by the uniform bound for \(D_K\) proves
\[
(BTR)^{-1}\sum_{\gamma\in\Gamma}D_K(\gamma)
\le C'_{K,\epsilon}(BTR)^\epsilon.
\]

SecondActualMass:16 removes a potentially hidden lower-bound assumption. For an empty \(\Gamma\), the estimate is trivial. For a nonempty \(\Gamma\), every nonzero ideal has integer norm at least one, so the asserted norm bounds themselves imply \(B,T,R\ge1\). Thus the source version requires only positive \(B,T,R\), not an unsupported assumption on the real scale exponents.

## 6. Actual scale budget and normalization

All norms here satisfy \(N((z))=\|\operatorname{eisEmbedding}(z)\|^2\). The norm on the right is the Euclidean embedding norm, not the algebraic norm itself.

Eisenstein/SeedDefects.cube_label_norm_bounds:647 uses the exact identity
\[
(b_0j)^2=(\text{left cube product})(\text{right cube product})
(\text{squarefree label})
\]
and the active-support bound. With each cube product of squared norm at most \(Z^{\ell+\eta}\), active-support squared norm at most \(Z^{R+\eta}\), and \(Nj\ge Z^{j-\eta}\), SecondTripleBounds:51 obtains
\[
Nq_0\le Z^{\ell+R/2-j+5\eta/2}.
\]
The square root of the active-support squared norm explains \(R/2\). The positive denominator and nonzero labels are proved before division.

SecondPunctureBudget.second_residual_norm_eq_div:15 gives the exact norm quotient for \(E\subseteq G\). Thus the remaining bounds are
\[
Nt\le Z^{t+\eta},\qquad
Nr\le Z^{g-\theta+2\eta}.
\]
Their product is \(Z^\kappa\), where
\[
\kappa=\ell+R/2-j+t+g-\theta+11\eta/2.
\]
For every \(Z>0\), SecondActualMass:35 concludes
\[
Z^{-\kappa}\sum_{\gamma\in\Gamma}D_K(\gamma)
\le C_{K,\epsilon}Z^{\kappa\epsilon}.
\]
SecondOriginalMass:13 multiplies by the positive \(Z^\kappa\) and uses the real-power product identity to obtain \(C_{K,\epsilon}Z^{\kappa(1+\epsilon)}\). No sign assumption on \(\kappa\) is used. Empty sources and scales below one are handled by the preceding empty/nonempty argument, not by defining a divergent sum to be zero.

The target mass constant depends only on \(K,\epsilon\); it is chosen before generator family, finite source, units, all real scales and their admissible norm bounds. The deleted-mode estimate is finite and algebraic for its supplied windows and row functions. Analytic moment existence and eventual uniform child estimates enter only when the outer two-pass proof uses it.

## 7. Remaining cut and interpretation

The explicit source-to-tuple injections, divisor encoding, weighted projection, killed-column list identity, norm-budget algebra, lattice-count reduction and finite-prime small-power argument were reconstructed here. The following foundations remain imported:

* Ideal factorization, norm multiplicativity, principal-generator and Eisenstein coordinate identities, including the underlying prime-product exponent uniqueness. The inspected arguments use their exact nonzero/injective hypotheses.
* The local input/common Gauss-weight bounds and mask-zero identities used by SecondWeights and Canonical. Their consumption and the product-of-three bound were checked; the local finite-field proofs were not re-audited.
* The underlying cube label/bit factorization identities used to establish validity and the norm estimates. Their algebraic use was checked; this is not a new audit of every bit case in the foundational cube-label development.
* The actual child moment producers and the analytic Fourier/Poisson/rapid-tail foundations outside these two finite estimates.

No assertion of termination, runtime, numerical sharpness or full-provider proof follows. A useful next lower audit, if required, is the common Gauss-weight norm and mask-zero mechanism; repeating the already reconstructed divisor-cardinality wrapper would not resolve that cut.

## 8. Source pins

The following hashes pin files read for this bounded audit. A file entry does not claim that every theorem in the file was independently re-proved.

| Source relative to root | SHA-256 |
|---|---|
| Descent/SecondDeletedModeEnergy.lean | 55B44575568F809370907E7F03BF241BB76A0F6E8B350C04F734E666856F473D |
| Descent/SecondActualMass.lean | 36C2E69E0E7764AA2A3F9F3A25AAC82C854F807FE6330CF33E85241AD4E2CAFF |
| Descent/SecondOriginalMass.lean | F2D61082640D94B533DED131C52990D32B04F9CFF01F9229A1908758FEC25567 |
| Descent/SecondSourceEncoding.lean | 26AC3ABD1B604AD8BB03DEB629255DE71184D957539919ACBB4EC07062C77519 |
| Descent/ActualSecondEnergy.lean | E78E302940BF511CA42D1ECA39412540454ED30EE59239AD3103304FDC7C1614 |
| Descent/SecondSourceTuples.lean | B6FB39319252CDBC2A0D7093EA632CAB8C289C54D96B522DD6477FAD3658713F |
| Descent/CubeSource.lean | 87604C5C2DC0980D7F9E616370B38DB8DE487F1145968132B5DD084F2FA71705 |
| Descent/TripleMass.lean | 46A20139596A3B3A9D004D859DF10C982151278CC9417E6F4226E63ED9CB6B08 |
| Descent/SecondCauchy.lean | 02469487013E1172713DE912C12EEE79A03FE03C2F67651225714D6B84C48566 |
| Descent/SecondWeights.lean | 631D042C2F43009C1C9F56B9617AA1BCC82357F41171DA5A228DD1FB98E4F663 |
| Descent/SecondSquarefree.lean | A3D4E48DA0BF0CD7EBF4AA3D0ADC11F73837527ED21A12676DF7283D51618A77 |
| Descent/SecondParentLists.lean | 7C6215B76E2078E2A075C02999AE06023D3BC7E53CF0EFF32E007545BB2A05E3 |
| Descent/SecondFixedFamily.lean | 7B12115B485D985394D8301A9EA6256D5D5E4DD75D52FA903C074ECEC8791D05 |
| Descent/Canonical.lean | E6ECEECC674D0D979E656D94A5AABF549DADBFA5DA00F61FFC871A8BD32FD433 |
| Descent/SecondModeParentLists.lean | 6D6D64757ABA1A0EF5DC530DE6A07E9F4F08C70E863584ACCA6AAEC755C29A39 |
| Descent/SecondVaryingLists.lean | 59E4D9488E6C7A9015D74C0094378EE2F6004E10F26C98CA690117422BF09D1C |
| Descent/SecondVaryingSupported.lean | E6622014243527DF0CD07E34C1723CE9E47B69236A50433B3A6FAB9FFE086553 |
| Descent/SecondPhysicalRows.lean | 9C071751612E3DA0C80D36FC463D3CA5B9974CA1A6D6BADB04F6FC765B2FE348 |
| Descent/SecondTripleBounds.lean | 170F93B84EAD643BD56E5B8D78421E4903EAD2160DF446AA1EE7B47C2ABE64B9 |
| Descent/SecondPunctureBudget.lean | 6B923BEF204ED06AD2723947386DC1588853C32F06888AA1D4E2BF8248F4CAE3 |
| Inversion/SecondFibers.lean | 41A7EA2C6BEFE0234928D35C99EA879E1B687A24D165625C4DFAC85F46F2B5C1 |
| Inversion/InitialFibers.lean | BD6F4D9D556064F27324CAA77410B09C717BC2AB06D4D463D0F12A3B2696024D |
| Eisenstein/SmoothTests.lean | B31EF93C0E6E790F5269B0B72059EA605CBA7538B7F443114234469EA614C0CC |
| Eisenstein/SeedDefects.lean | A60BCC07E52B038B206FA3C2C16ABDC35F149F71B9276D131A2B6BECA9363F10 |
| QuadraticSieve/FiniteOperator.lean | 4A8A56A5AC5A218C00616F40749B33A1942DC65F579BB6DF216F039EC2BA32BF |
| Mellin/InverseContour.lean | 07583B9AD1732A76889CA43FA78BDD98E902E0B41612F68D6CFB5ED4C5166D20 |
| Hecke/FiniteEulerFactors.lean | 4F65030622460B1636D6F66C43FB8175E8EF3244502BDBA48C3AAFACB2452716 |
| Arithmetic/LatticeCount.lean | AD7A616017D5EFD2D01A5F38C49C86EAF2F081A0E74CFA17196E5A8010BFD69F |
