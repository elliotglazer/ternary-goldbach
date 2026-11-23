# Independent review of the primitive-associate construction

2026-11-11. **PASS for the bounded mathematical/source audit. No correction requested.**

I read the complete [author report](../prime-estimates/QRH_PRIMITIVE_ASSOCIATE_AUDIT_2026-11-11.md), SHA256 `BC53A637A1129D29A5C3BC037D72463B03ED26BFAA46261799DC9988B3306945`, and independently reconstructed the finite construction and its immediate consumers. All eleven OAI and seven cached Mathlib source hashes in that report match current bytes. The source baseline is `work/openai-math`, revision `4eaee87548250b2682affda7d05d947c05554bae`.

OAI paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`. This review used source reads and hashing only: no build, analytic evaluation, source change or finite spectral computation.

## 1. Exact result and character factorization

`IdealCharacter.lean:212` assumes an infinite commutative domain with principal ideals, a finite quotient A/M, a multiplicative residue character and invariance on global units. It returns one K containing M, K nonzero, and one unit-invariant primitive character on A/K. Its norm is at most the norm of M. The exact ideal-coefficient mask and equivalent principal-factor product hold for every ideal. There is no complex variable, height, zero-free region or asymptotic assumption in this result.

I read `FiniteConductor.lean` in full. At lines 18–36 the kernel criterion is proved by first descending the character to the image of the group homomorphism, then extending this character to the finite target abelian group. The latter is the substantive standard finite-group input `MonoidHom.domRestrict_surjective`, inspected at cached `GroupTheory/FiniteAbelian/Duality.lean:107`. The complex codomain supplies the required roots of unity. Neither this proof nor its unit-group application assumes that the original map on units is surjective.

The source's factorization definition is on units. Its equivalent test at line 53 says that chi(u)=1 whenever u-1 belongs to I. At line 94 it recovers the full element formula with the original source-unit test. The mask is indispensable: an old nonunit may become a unit in the new quotient. `MulChar.ofUnitHom` and the inverse unit-character equivalence have precisely the needed semantics; their cached definitions were inspected at `NumberTheory/MulChar/Basic.lean:159–190`.

## 2. Why maximality is enough

I read the maximal-descent proofs in both `FiniteConductor.lean:105–144` and `ConductorBounds.lean:55–93`. Ideals of a finite ring form a finite set, and the zero ideal is a factoring ideal. A maximal factoring ideal I can therefore be chosen, or chosen above an already specified factoring ideal.

If the resulting character on R/I factored through a nonzero ideal J, its preimage K in R would contain I. The kernel test shows the original character factors through K: every original unit congruent to one modulo K maps to a quotient unit congruent to one modulo J. Maximality forces K contained in I. Surjectivity of the quotient map then makes every element of J zero, contradicting J nonzero. This proves the actual predicate in `FiniteFourier.lean:18`.

The argument proves an inclusion-maximal factoring presentation, not a greatest factoring ideal, unique conductor, minimum norm among incomparable presentations, or algorithm computing a canonical conductor. The author expressly avoids those stronger conclusions. No inspected consumer requires them.

## 3. Quotient, norm and degenerate cases

`ConductorBounds.lean:35–46` supplies the ring equivalence A/K to (A/M)/I, where K is the preimage of I. Its action on the class of a is the iterated class of a. `ConductorPresentation.lean:37–50` pulls the actual character along this equivalence. In `CharacterTransport.lean:39–60`, a nonzero ideal is transported through the inverse equivalence, and its witnessing unit is transported back. Thus the exact primitive predicate, including its nonzero-ideal condition, is preserved.

The norm comparison uses a surjection of quotient rings, not a claim about the number of units. It follows from J contained in I and the equality between absolute norm and quotient cardinality. The final quotient is finite and inhabited, so its cardinality is positive. Since the ambient ring is infinite, its zero ideal has absolute norm zero; this proves K is nonzero in `ConductorPresentation.lean:77–86`. The infinity hypothesis cannot be discarded from that argument.

The top ideal remains permitted. In the one-element quotient the only ideal is both top and bottom, so the primitive predicate is vacuous. Its unique element is a unit and its multiplicative character value is one. This is consistent with `MulChar`: its zero law requires a nontrivial source. It is also consistent with the separate ideal function, which defines its value at the zero ideal to be zero. A principal residue character may descend to this top-ideal presentation. No zero-ring exclusion or spurious nonprincipal assumption is introduced.

## 4. Actual ideal coefficients and consumption

I read `IdealCharacter.lean`, `ResidueCharacter.lean` and `Hecke/IdealOperations.lean` in full. The generator-based ideal function is well defined under association because of global-unit invariance. Multiplicativity uses the domain and principal-ideal hypotheses. The equivalence between a unit modulo M and coprimality of its principal ideal with M is proved in both directions at `IdealCharacter.lean:26`; it converts the element mask to the exact ideal mask at line 163. The zero ideal is treated separately before that generator argument. Line 180 gives the equivalent principal-factor product identity, without losing its zero value.

Global-unit invariance of the new character follows by substituting an actual global unit into the source mask. This does not claim that all quotient units lift to global units. `Hecke/Family.lean:31–44` packages the returned modulus and character unchanged; its period is the positive quotient cardinality and need not be least. The actual Eisenstein ring supplies the PID and finite-quotient hypotheses. `Hecke/IdealOperations.lean:16–27` therefore gives one actual primitive Hecke character and the all-ideal identity.

The adjacent product construction is also coherent. The quotient by an intersection injects into the product of the quotients. This yields a cardinal bound without assuming comaximality or a Chinese-remainder isomorphism. `ResidueCharacter.lean` proves the unit test for the intersection and keeps both original nonunit masks in its exact product formula.

Finally, `Hecke/FiniteDeletion.lean:41` consumes exactly this all-ideal coprimality mask, using primes of the old modulus and coefficients of the new character. The existence quantifier for the new character precedes the universal complex-variable quantifier in `exists_primitive_same_zeros:135`. The nonpole disjunction in `exists_primitive_zero:147` remains explicit. I checked this matching and ordering; I do not count the already-reviewed analytic continuation, Euler-factor nonvanishing or pole treatment as newly proved here.

## 5. Remaining boundary

This removes the primitive-presentation construction itself from the list of unexpanded OAI mathematical inputs at the inspected scope. The lower inputs are ordinary finite-group character extension/roots of unity, finite maximality, quotient/ideal algebra, and the concrete Eisenstein PID and finite-quotient facts. Their use has been checked; no recursive audit of all library proofs is claimed.

The cached Mathlib revision is `56a005855ea17e0b0958f73ec801ae140b0a1679`, while the provider requests `d13f23b723b8a846827a245b89c10fc7d3f11612`. Compatible elaboration and transitive axiom validation remain open. Detector/energy production, other analytic source inputs, finite spectral evidence and final target assembly are not supplied by this finite algebraic construction. The selected family and final Goldbach premises remain unchanged.

The reviewed author report and its eighteen source pins are the evidence manifest for this review. No frozen artifact was modified.
