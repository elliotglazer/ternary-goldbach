# Independent review: fixed-Q exceptional row count

2026-11-11. **PASS within the bounded source/paper scope; no mathematical correction requested.** The reviewed author report is `work/qrh-blueprint/QRH_FIXED_Q_ROW_COUNT_AUTHOR_2026-11-11.md`, SHA256 **05B4819F167FB47E57B770484E9E708ED7D7401AC30AF940DF7FD9AE1F0D9C6F**. Its bytes remain unchanged.

This review checks the actual counting implication and its immediate algebraic producers. It does not assert compatible elaboration, transitive axiom closure, a complete QRH proof, or removal of PlattGRH from the Goldbach development. No Lean/Lake command, source edit, analytic evaluation, or enumeration was used.

## 1. Evidence and exact target

All eleven source pins in the author's table match the actual raw file bytes. The three supporting artifact pins also match: the physical-saving author packet, local Gauss/character review, and deleted-mode mass audit. I read the relevant supporting passages on exact character order and the finite ideal-count bound, without treating their entire dependency closures as validated here.

Source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/` at the author-pinned revision. I independently read:

* Full `Moments/FixedQForcingCount.lean`, `Moments/SecondExceptionalCount.lean`, `Moments/Forcing.lean`, and `Moments/ChildRows.lean`.
* `CenteredExceptionalProfile.lean:17–492`, including the CRT construction, local character comparisons, actual row conversion, and finite remainder count.
* `CenteredExceptionalCount.lean:11–271,306–322,397–417`, covering the normal form, fiber counting, and scale conversion.
* `Moments/Canonical.lean:14–25`, `Mellin/InverseContour.lean:306–317`, `MeanSquare/UniformPolynomialHeight.lean:548–607`, `RowCompletion/PeriodicRows.lean:117–146`, and `ChineseRemainder/FrequencyLifts.lean:542–620` for the exact immediate adapters and lower boundary.

The final target is `CenteredMomentFixedQForcingCount.actual_canonical_exceptional_count_fixedQ` at `Moments/FixedQForcingCount.lean:180`; its general producer begins at line 122. The author preserves its hypotheses. In particular, C is supported, the old coefficient at C is nonzero, Q is nonzero and not top, Q is contained in (72), m is nonzero and divisible by lambda and 2, and every counted row is nonzero and satisfies the actual inducing-row predicate. The row norm is bounded by Cr*Z^M with Cr>=0 and Z>1. There is no Q–C coprimality premise, no supported-D premise, and no requirement M>=0.

The output retains both Q-dependent factors, `6^omega(Q)` and `N(rad Q)^(2/3)`. It is not a uniform bound with an absolute Q-independent constant.

## 2. The CRT probes do not assume the missing coprimality

`CenteredExceptionalProfile.split_at_prime:17` gives, for nonzero K,

    K = P^v_P(K) * K0,   K0 nonzero,   IsCoprime K0 P.

The construction in `exists_unit_probe:42` applies CRT to Q*K0 and P. Their coprimality follows from Q–P coprimality and K0–P coprimality. It prescribes 1 modulo Q*K0 and an arbitrary unit u modulo P. The resulting n is 1 modulo Q, prime to K0, and prime to P; it is therefore prime to all of K, including a possibly nontrivial P-power factor.

Thus the argument permits P to divide K and permits Q to share factors with K. It never requires `IsCoprime Q K`. The product Q*K0, rather than an unsupported simultaneous CRT decomposition of Q and K, is important here.

For `valuation_mod_six_of_unit_agreement:65`, split the two supported ideals I and J into their P-power and P-coprime parts. The probe is chosen to be 1 on both complementary factors as well. Their row-character values become 1, leaving the two powers of the actual sextic character at u. Equality for every unit yields equality of those character powers. `Moments/Canonical.lean:14–25` transfers exact order six through the injective Eisenstein-to-complex embedding. The lambda exclusion and residue-characteristic-not-two condition are retained; a sixth-power identity alone would not suffice.

This proves equality of P-valuations modulo six, not equality of the valuations themselves. The downstream remainder construction uses precisely that weaker conclusion.

## 3. Actual induction and the single-row forcing step

`FixedInducingRow` at `CenteredExceptionalProfile.lean:338–341` supplies actual characters chi and psi, primitive psi, an induced-coefficient identity, Q<=psi.modulus, and equality with the row twist for every argument. The proof is allowed to choose different witnesses for different rows. It does not need one global primitive character or uniqueness of induction.

In `local_rows_profile:125–153`, the avoidance ideal includes the row mask, old source modulus, and both row-character moduli. The CRT probe makes all required coefficients nonzero. On n=1 modulo Q, each induced character equals 1. The source character can then be cancelled because its coefficient at n is nonzero. This two-row comparison does not require the source character to be unramified at P.

The stronger one-row assertion correctly has an additional hypothesis. `local_row_valuation_zero:260–283` requires P coprime to the source modulus, uses Q*source.modulus as the congruence ideal, and forces the source coefficient itself to equal 1. The numerator valuation is then zero modulo six. `actual_row_forced_residue_four:302–317` subtracts the numerator's residue two and obtains residue four for the row ideal.

That additional coprimality is supplied in `Moments/ChildRows.lean:48–87`, not manufactured from the exceptional predicate. Nonvanishing of the old coefficient at e makes (e) coprime to the old modulus. A forcing prime dividing (e) is therefore coprime to that modulus. Q<=(72)<=(12), with ideal containment in that direction, makes a prime coprime to Q also coprime to (12). The child modulus is the intersection of the old modulus and (12); the product of those two ideals divides that intersection. Coprimality with the product therefore gives the needed child-modulus coprimality.

I checked the actual row conversion at `CenteredExceptionalProfile.lean:155–258,285–300`. Nonzero numerators admit the supported primary factorization. On n=1 modulo Q, Q<=(72) supplies n=1 modulo 72. The mask equals 1 on arguments prime to m, and the bad-prime twist equals its value at 1 by periodicity. Valuations of the unit, lambda, and 2 factors vanish at the good prime. Finally, the common fixed numerator is cancelled additively in the congruence. These steps use the actual row-reciprocity and numerator identities; they do not replace the row predicate by a guessed congruence.

## 4. Normal form, multiplicity, and small scales

`CenteredExceptionalCount.lean:11–114` defines the remainder and quotient by prime valuations modulo six and divided by six. For nonzero I it proves

    I = sixthRemainder(I) * sixthQuotient(I)^6.

Both factors are nonzero. Fixing the remainder makes the quotient map injective. This is ideal factorization, not a choice of sixth roots of elements.

The norm identity implies `N(quotient)<=(H/N(remainder))^(1/6)` whenever N(I)<=H. In `ideal_count_fixed_remainder:191–215`, the proof first separates the empty fiber. For a nonempty fiber, a quotient ideal has norm at least one, so the proposed scale is at least one. Only then does it apply `finite_ideal_count_real`. That theorem, at `Mellin/InverseContour.lean:306–317`, uses the exact floor and the underlying `64*(floor(H)+1)` estimate to obtain 128*H for H>=1.

Consequently there is no missing additive constant and no unsupported scale>=1 assumption. If H is below the remainder norm, the fiber is empty. If Cr=0, every row would have positive integer norm at most zero, so the row set is empty. Negative M does not disturb any of these comparisons because Z>1 makes Z^M positive.

The element count retains unit multiplicity. `MeanSquare/UniformPolynomialHeight.lean:554–597` proves injectivity of the map to `(rowUnit(z),(z))` on nonzero elements. It does not claim that z maps injectively to (z) alone. The six-element unit group and the ideal bound therefore give 6*128=768, as used at `CenteredExceptionalCount.lean:248–271`. No additional square root is applied to the absolute ideal norm.

`CenteredExceptionalProfile.lean:360–403` codes only occurring remainders by their valuations on the finite prime support of Q. Equality of these codes, combined with the two-row congruences outside that support, determines the full remainder. Each coordinate lies in Fin 6, yielding at most `6^omega(Q)` codes. No claim that every possible code occurs is required. `outside_fixed_support:446–475` obtains both good-prime exclusions and Q–P coprimality from the actual support complement and Q<=(72).

## 5. Forcing and the excluded-prime loss

`Moments/Forcing.lean:44–105` uses injectivity of the prime-ideal family twice: the forcing product is squarefree, and each forcing prime has valuation exactly two in the moving ideal. The single-row conclusion then places four copies of that prime in the sixth remainder. Squarefreeness is essential for concluding G^4 divides the remainder simultaneously for all good forcing primes.

The general fixed-Q producer does not apply this assertion at the excluded primes. `Moments/FixedQForcingCount.lean:20–107` partitions the forcing set into Q-coprime and non-Q-coprime primes, with products G and E. The exact product identity is F=G*E. For a nonzero prime ideal P, maximality converts failure of Q–P coprimality into P|Q. Squarefreeness then gives E|rad Q and hence

    N(F) <= N(G)*N(rad Q).

The good-prime count contributes `N(G)^(-2/3)`, from the fourth-power remainder saving followed by the sixth root. Since all norms here are positive,

    N(G)^(-2/3) <= N(rad Q)^(2/3) * N(F)^(-2/3).

`fixed_radical_power_loss:109–120` expresses exactly this inequality through log_Z and real powers. Its direction and exponent are correct. If no forcing prime is good, G is the unit ideal; the unsaved good-prime bound remains valid and the excluded-prime factor pays the loss. Empty forcing products likewise cause no undefined logarithm.

The canonical adapter at lines 180–209 supplies e=primaryGenerator(C), its nonzero old coefficient, the common-prime injection, good-prime exclusions, and divisibility into C. These are sufficient without adding Q–C coprimality or support conditions on D. The displayed radical factor is retained even when unnecessary; absorbing it is legitimate only into a constant chosen after Q. Containment Q<=(72) does not bound N(Q) above.

## 6. Scope and remaining proof boundary

The finite CRT, character-comparison, factorization/counting, forcing, and fixed-Q-loss composition is sound at the inspected source/paper level. No correction is needed to its mathematical statement or the displayed constant.

The following remain explicit lower obligations at this review depth:

* `rowTwist_extract_sixth_mask`, `idealRowHom_factor_numerator`, and the underlying reciprocity identities used by `RowCompletion/PeriodicRows.lean:133–146`.
* The bad-prime supplements and reciprocity-phase periodicity underlying `numeratorBadTwist_periodic`, together with the primary-factorization foundations.
* The standard ideal factorization, CRT, ideal-character, unit/generator, and finite-field foundations. The immediate applications were checked here. Relevant character-order and ideal-count work has separate accepted bounded reviews; this report does not turn those into a transitive kernel audit.
* Separate analytic paired-column and physical-saving inputs, and the remaining global-provider proof obligations. Row counting alone proves none of their analytic estimates.

The author's statement that the paired-column packet still awaits review records its earlier freeze state. The separate paired-column review is now available at `REVIEW_QRH_PAIRED_COLUMN_CANCELLATION_AUTHOR_2026-11-11.md`, SHA256 **9EDC8C82675399C8319C05C8A0FF6B7292DAC0099E664EDCA96FBD6F7A09F74E**. This is a status update, not a mathematical correction or modification of the frozen author report.

Only this new review file was written. Hash verification and source reads were performed; no new evaluator, scalar-test artifact, Lean declaration, build, or spectral computation was introduced.
