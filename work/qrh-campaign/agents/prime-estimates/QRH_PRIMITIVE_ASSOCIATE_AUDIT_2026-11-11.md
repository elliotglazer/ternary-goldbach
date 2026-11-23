# Actual primitive-associate construction

2026-11-11. This audit reconstructs the finite algebra behind `IdealCharacter.exists_primitive_associate` and its exact input to `Hecke/FiniteDeletion`. No mathematical defect was found in the inspected construction. It supplies a primitive quotient presentation with the stated norm bound and source mask. It does not prove a unique least conductor, validate the whole provider, or repeat the analytic finite-deletion proof.

OAI paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, revision `4eaee87548250b2682affda7d05d947c05554bae`. The inspected Mathlib cache is `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib`, revision `56a005855ea17e0b0958f73ec801ae140b0a1679`. The provider manifest requests a different Mathlib revision, `d13f23b723b8a846827a245b89c10fc7d3f11612`. These source comparisons do not establish compatible elaboration.

## 1. Exact output and domains

`IdealCharacter.lean:212` works over an infinite commutative domain A with principal ideals. It assumes only that A/M is finite, a multiplicative character chi on A/M, and `UnitInvariant M chi`, meaning chi is one on the images of every global unit of A. It returns an ideal K and character phi on A/K such that:

* M is contained in K, K is not the zero ideal, and phi is unit-invariant and `IsPrimitiveOnIdeals`.
* `Norm(K) <= Norm(M)`.
* For every ideal I, including the zero ideal, the old ideal coefficient equals the new coefficient if I is coprime to M, and is zero otherwise.
* Equivalently, the old ideal coefficient is the product of the principal character coefficient at M and the new coefficient at K.

The modulus inclusion is in ideal order. For integer moduli it corresponds to K dividing M, not the reverse. The character, modulus and identities are chosen before any complex variable s. There is no zero, height, strip, asymptotic estimate or nonvanishing premise in this theorem.

The finite-ring construction needs only a commutative finite ring. Dedekind-domain and infinite-ring hypotheses enter the absolute-norm and nonzero-modulus transport. The principal-ideal-domain hypothesis enters when residue characters become multiplicative functions of ideals. Mathlib's `IsPrincipalIdealRing.isDedekindDomain` supplies the intervening instance, with an explicit domain hypothesis.

## 2. Factorization is on units, with an explicit source mask

`FiniteConductor.lean:40–46` defines the unit map induced by R to R/I and says a character factors through I when its homomorphism on R units factors through that map. It does not assume the quotient unit map is surjective.

The general lemma `exists_character_factor_iff:18` proves factorization through a homomorphism q into a finite abelian group H exactly when `ker(q) <= ker(chi)`. For the reverse implication it first descends chi to the image of q using `MonoidHom.liftOfSurjective`. It then extends that image character to H using Mathlib's `MonoidHom.domRestrict_surjective`. This second step is essential if q itself is not surjective.

At the actual complex codomain the extension theorem applies: finite abelian groups have nonzero finite exponent, and the complex field has the required roots of unity. The inspected library proof uses finite abelian duality and cardinalities of the restriction kernel. This is a standard finite-group input, not an analytic Hecke theorem.

`factorsThroughIdeal_iff:53` identifies the kernel test with the concrete condition

`for every unit u, u - 1 in I implies chi(u) = 1`.

Here `quotientUnits_eq_one_iff:48` is the exact quotient-ring equality. The two conversions between `MulChar` and homomorphisms on units are inverse. `factorization_with_source_mask:94` then proves, for every ring element a,

`chi(a) = if IsUnit(a) then phi(a mod I) else 0`.

On units this is the factorization equation; on nonunits it is `MulChar.map_nonunit`. Dropping this test would give a false general formula, because a nonunit of the old ring can become a unit in a smaller quotient.

## 3. Maximal descent proves primitivity

`FiniteFourier.IsPrimitiveOnIdeals:18` means that each nonzero ideal J has a unit u congruent to one modulo J for which the character is not one. By the kernel criterion this is equivalent to having no factorization through a nonzero ideal. It is not a new numerical definition of conductor.

The ideals of a finite ring form a finite type: the map taking an ideal to its underlying subset is injective, and the set of subsets is finite. Factoring through the zero ideal is available. More generally, `ConductorBounds.exists_primitive_quotient_above:84` starts from any factoring ideal J and chooses an inclusion-maximal factoring ideal I above J with `Finite.exists_le_maximal`.

For completeness, the contradiction in `primitive_of_maximal_descent:55` is as follows. Suppose the resulting phi on R/I factors further through a nonzero ideal L of R/I. Pull L back to an ideal K of R. Then I is contained in K. A unit congruent to one modulo K maps to a quotient unit congruent to one modulo L; phi is one there, so chi is also one. Thus chi factors through K. Maximality gives K contained in I. Any element of L has a preimage r in R, and r then belongs to I, so the element of L is zero. This forces L to be the zero ideal, a contradiction.

This is sufficient to prove the precise primitive predicate. The source does not prove that all factoring ideals have a common greatest element, that this maximal choice is unique, or that its norm is minimal among incomparable choices. The term "primitive associate" in the inspected consumers requires none of those stronger claims. No canonical least-conductor algorithm should be inferred from this existential construction.

## 4. Quotient transport, norm and zero-ring endpoints

Put R=A/M and K equal to the preimage of I under the quotient map. `ConductorBounds.quotientComapEquiv:35` constructs the actual ring equivalence

`A/K = (A/M)/I`

through the induced quotient homomorphism and its injectivity and surjectivity. On the class of a it is literally the iterated class of a. `ConductorPresentation.quotientCharacter:37` pulls phi back along this equivalence. `CharacterTransport.primitive_pullback:39` transports a nonzero ideal through the inverse equivalence and transports the witnessing unit back, so it preserves the exact primitive predicate.

Containment M<=K follows because elements of M map to zero. If J<=I, the surjection R/J to R/I gives `card(R/I) <= card(R/J)`. The source uses this cardinal inequality and the quotient equivalence to obtain the absolute-norm inequality. Setting J to the zero ideal gives `Norm(K) <= Norm(M)`. No strict norm decrease or unit-map surjectivity is needed.

The quotient R/I is finite and nonempty, even when it is a zero ring. Its cardinality is positive. Therefore Norm(K)>0. Since A is infinite, Mathlib's `absNorm_bot` is zero, and `ConductorPresentation.comap_ne_bot:77` proves K is not the zero ideal. The infinity hypothesis is used here; it must not silently disappear in a generalization to a finite ambient ring.

The top ideal is permitted. If M is top, R is the one-element ring, its only ideal is simultaneously top and bottom, and the primitive predicate is vacuous. Every ring element is a unit and a multiplicative character takes the unique element to one. This does not contradict a zero-preserving law: `MulChar` is a monoid homomorphism vanishing on nonunits, and its `map_zero` theorem requires a nontrivial source. The resulting K is top, with norm one, not the zero ideal of the infinite domain A.

Likewise, a principal residue character on a nontrivial finite quotient factors through its top ideal. This maximal choice gives the trivial quotient presentation. The construction does not improperly exclude the principal character.

## 5. From elements to ideals and to the actual Hecke character

`IdealCharacter.value:48` sets the coefficient of the zero ideal to zero explicitly. On every other ideal it evaluates the residue character on a chosen generator. Unit invariance makes this independent of associated generators. The product of two nonzero generators is nonzero in a domain; the principal-ideal product formula proves multiplicativity. These are the reasons for the actual domain and principal-ideal hypotheses.

`isUnit_mk_iff_isCoprime:26` proves that a modulo M is a unit exactly when the principal ideal generated by a is coprime to M. Its reverse direction constructs an inverse from a Bezout identity. Applying this to a generator converts the source unit mask to the ideal coprimality mask. At the zero ideal both sides are zero by definition, including the special case M=top, when the coprimality test is true. `ofResidue_one:139` and `ofResidue_finite_deletion:180` supply the exact principal-factor product identity. At modulus top the principal coefficient is one on every nonzero ideal and zero at the zero ideal.

Unit invariance descends directly. Substitute a global unit u into the source mask; it remains a unit modulo M, and the old value is one. The new value is therefore one. There is no attempt to lift arbitrary quotient units to global units.

For the actual ring `O = RingOfIntegers(CyclotomicField 3 Q)`, `Hecke/IdealOperations.lean:11` uses Mathlib's `IsCyclotomicExtension.Rat.three_pid`. Nonzero ideals have finite quotient rings. `Hecke/Family.Character.ofResidue:31` packages the returned modulus and residue without altering them. Its auxiliary positive integer period is the cardinality of O/K; `Nat.cast_card_eq_zero` proves that period belongs to K. This need not be a least period. It is one even for K=top, so positivity is preserved.

Consequently `Hecke/IdealOperations.exists_primitive_character:16` returns one actual Hecke character psi, primitive on ideals, with the norm bound and an identity for every ideal I. `Hecke/IdealBridge.idealCoeff:14` is definitionally the same `IdealCharacter.ofResidue` used to prove that identity.

The adjacent product version is consistent. The quotient by M intersect N injects into the product of the two quotients, so it is finite and its norm is at most the product of the two norms. This is an injection, not an assertion of a Chinese remainder isomorphism without comaximality. `ResidueCharacter.product_mk:117` proves the exact product of element characters, retaining both old nonunit masks. The primitive-product associate then follows by the same construction.

## 6. Exact finite-deletion consumption and remaining boundaries

`Hecke/FiniteDeletion.LFunction_eq_of_mask_right:41` consumes precisely this identity:

`idealCoeff chi I = if IsCoprime I chi.modulus then idealCoeff psi I else 0`.

For Re(s)>1, the existing Euler-series theorem removes the primes dividing the old modulus. The finite factor uses the old modulus chi.modulus and the new coefficients of psi. It does not remove all primes of the new modulus by a second, invented rule. Factors that already have zero new coefficient are simply one.

The already-reviewed analytic extension gives the equality for Re(s)>0 away from the pole, and separately handles the nonprincipal value at one. The returned psi is fixed independently of s. Thus `exists_primitive_same_zeros:135` states one psi and then all s with Re(s)>0 and s!=1. `exists_primitive_zero:147` uses the explicit nonpole disjunction. This audit verifies the algebraic input and those quantifiers, not a new proof of analytic continuation, factor nonvanishing or equality of analytic orders.

The inspected construction uses finite character extension, finite maximality, quotient algebra, principal ideal generators and finite quotient cardinalities. It does not consume the 7/8 theorem, any Hecke zero-free estimate, prime distribution, theta continuation or the finite spectral data. The lower library inputs remain the stated finite-group duality and roots of unity, standard ideal/quotient facts, and the actual cubic number-field PID and finite-quotient facts. Their use is distinct from compatible compilation and transitive axiom validation, which remain unperformed.

## 7. Source pins

| OAI source | SHA256 |
|---|---|
| `FiniteFourier.lean` | `593608AA6841DAA6404C9DE6000A43B2BC60043B5A234F364D41DEB4749D84AE` |
| `FiniteConductor.lean` | `693B875E247FFB58212E70B40D684137652E69ACD1E246D5E8CFA4810F6438DC` |
| `ConductorBounds.lean` | `12F3FE8723697640E5713B0792D364391CD6D7844F33857B2E00F259B9D56FED` |
| `ConductorPresentation.lean` | `F695F9AC909328E7A199E62C04895935727CD93E7A564FF48FEF93F77BBA95D4` |
| `CharacterTransport.lean` | `605DDF68C036A2601D3BABB8761C6F06E42CAEFAC6D31468683F470A0236E0C8` |
| `ResidueCharacter.lean` | `D37B8AC0F0DA1CF8D0A0D2DDF08650D2DBBBB7B1363B9A1557C92453E74C16F2` |
| `IdealCharacter.lean` | `6AAB22876E8326D3AB56F56692F371F58B5D99CA8779356D9D47287E7569725A` |
| `Hecke/Family.lean` | `B18557C5C055910287507F1ED2B1F7BB31EDE318CB62A2A10A3140F1995A9408` |
| `Hecke/IdealBridge.lean` | `D64B454F8DE573198F360DD4B4647DF87916020D4F89ECB44EB9B18D162A567F` |
| `Hecke/IdealOperations.lean` | `6760E7000AD9A8EC58BC78A52F598F20F292F17201161C36E50296D3D46B01F2` |
| `Hecke/FiniteDeletion.lean` | `8186CCBFBB6D3BD95E65AD807C852B82204C689664CDDEDAB2407035911AE72C` |

| Inspected Mathlib source and relevant entry | SHA256 |
|---|---|
| `NumberTheory/MulChar/Basic.lean`, structure:73, unit equivalence:159–190, zero law:234 | `1C31A9810F59DB8CDCDEEF50D20EFEAA0C70CF24B5C2448356AD1FF5EC240915` |
| `GroupTheory/FiniteAbelian/Duality.lean`, `MonoidHom.domRestrict_surjective`:107 | `90F6B3C5EEF7FDA9A8801D7E97D519604DEF893C3BD422A2FDC2A25B835E3B01` |
| `RingTheory/RootsOfUnity/AlgebraicallyClosed.lean`, enough-roots instances | `D23C811F3C3BB07B6E39B3614D953B5ED1886BBAC95477FFBCC4476D9913A8E6` |
| `Order/Preorder/Finite.lean`, `Finite.exists_le_maximal`:149 | `5FBC4430C40AAC496798113D9DF59C4787CAF4F7C39C7DB0132EB02470459D94` |
| `RingTheory/Ideal/Norm/AbsNorm.lean`, norm/cardinality:290, bottom:295, top:298 | `2507F0CAB94525D81BE5527CCFFF7DC8C02F32811F30A973645B7E262032BF52` |
| `RingTheory/DedekindDomain/Basic.lean`, PID instance:175 | `860C104FC6DAC8E0A68F9BCB78294329E0807CEF955275519E82D2AE79BCDFE2` |
| `NumberTheory/NumberField/Cyclotomic/PID.lean`, `three_pid`:35 | `6B27574CCF6556263F1A2993DEEEE4857FD87A8002BA3D7E64832DC90A754064` |

No Lean declarations, builds, analytic evaluations or changes to frozen sources were made. The final Goldbach statement and selected spectral family are unchanged.
