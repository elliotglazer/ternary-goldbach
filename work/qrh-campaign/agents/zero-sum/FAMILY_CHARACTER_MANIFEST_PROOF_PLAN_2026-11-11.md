# Character manifest and CRT proof plan

This note gives an exact coordinate scheme for every primitive complex Dirichlet character in the selected finite spectral task. It includes a proof of coverage through unit homomorphisms, rather than inferring coverage from matching counts. A small external integer checker tests the coordinate and conductor formulas at seven moduli. No Lean proof, spectral computation, new axiom, or approved declaration is supplied.

The selected profile remains

\[
 \widetilde c=\begin{cases}c&2\mid c,\\2c&2\nmid c,\end{cases}\qquad
 H_p(c)=200+\max\left(1000,\left\lceil\frac{704\cdot1200000}{7\widetilde c}\right\rceil\right),
 \quad H_{\rm cert}(c)=\min(H_p(c),10^8/c).
\]

The final height is rational; its second term must not be rounded upward. The target is every actual primitive character at conductor c, every zero with inclusive height |Im rho| <= Hcert(c), and Re rho <= 111/200. This arithmetic manifest supplies the character index and height. It supplies no zero information. Both ordinate signs and all zero multiplicities remain obligations of the analytic certificate.

## 1. Pinned source interfaces

Goldbach source is `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Mathlib source is `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`, commit `56a005855ea17e0b0958f73ec801ae140b0a1679`. Paths in this table are relative to that Mathlib root. These declarations were read; no compilation was run.

| Source | Existing declaration and use |
| --- | --- |
| `Mathlib/NumberTheory/DirichletCharacter/Basic.lean:39` | `DirichletCharacter R n := MulChar (ZMod n) R` |
| `Mathlib/NumberTheory/MulChar/Basic.lean:152,159,183` | `toUnitHom`, `ofUnitHom`, and `equivToUnitHom : MulChar R R' ≃ (Rˣ →* R'ˣ)`. Restriction and extension by zero identify actual characters with unit homomorphisms. |
| `Mathlib/NumberTheory/DirichletCharacter/Basic.lean:49,114,149` | `toUnitHom_inj`; `FactorsThrough χ d := ∃ h:d∣n, ∃χ₀, χ=changeLevel h χ₀`; `factorsThrough_iff_ker_unitsMap hd` identifies this with `(ZMod.unitsMap hd).ker ≤ χ.toUnitHom.ker`, under `[NeZero n]`. |
| `Mathlib/NumberTheory/DirichletCharacter/Basic.lean:245,291,306,310` | `conductor` is the infimum of the factor-through set; `IsPrimitive χ` means `conductor χ=n`; `primitiveCharacter` and `changeLevel_primitiveCharacter` recover every level character from its conductor. |
| `Mathlib/NumberTheory/DirichletCharacter/Basic.lean:357,365` | `mem_conductorSet_iff_conductor_dvd hd`; `conductor_changeLevel` preserves conductor when lifting to a positive multiple. `changeLevel_injective` and `FactorsThrough.existsUnique` give uniqueness. |
| `Mathlib/NumberTheory/DirichletCharacter/Basic.lean:532,535` | `Odd ψ := ψ(-1)=-1`; `Even ψ := ψ(-1)=1`. |
| `Mathlib/Data/ZMod/Basic.lean:876,889` | `unitsEquivCoprime`; `ZMod.chineseRemainder h : ZMod(m*n) ≃+* ZMod m × ZMod n` for coprime m,n. |
| `Mathlib/Data/ZMod/Units.lean:26,47` | `unitsMap` and its surjectivity for a divisor of a positive level. |
| `Mathlib/RingTheory/ZMod/UnitsCyclic.lean:198,249` | `ZMod.isCyclic_units_of_prime_pow p hp hp2 k`; `ZMod.orderOf_five n : orderOf (5 : ZMod(2^(n+2)))=2^n`. |
| `Mathlib/GroupTheory/OrderOfElement.lean:574` | `finEquivPowers` enumerates powers up to the exact order. |
| `Mathlib/RingTheory/RootsOfUnity/Complex.lean:93` | `Complex.isPrimitiveRoot_exp n hn` for exp(2*pi*i/n). |
| `Mathlib/RingTheory/RootsOfUnity/PrimitiveRoots.lean:138,566` | `IsPrimitiveRoot.pow_inj` for indices below the order and `eq_pow_of_pow_eq_one` give uniqueness and existence of character exponents. |
| `Mathlib/NumberTheory/MulChar/Lemmas.lean:61,73,79` | `star_apply`, `star_eq_inv`, `star_apply'` identify complex conjugation with the inverse character. |

The units CRT adapter can use the exact construction already appearing in `UnitsCyclic.lean`: `(Units.mapEquiv (ZMod.chineseRemainder h).toMulEquiv).trans .prodUnits`. Iterating it over a prime factorization requires a new packaged lemma, not a new CRT theorem.

## 2. The unit coordinates

Factor c as a product of pairwise coprime prime powers, in increasing prime order. At an odd prime power p^k choose a unit g of exact order m=(p-1)p^(k-1). The coordinate x in Z/mZ represents g^x. Existence follows from the source cyclicity theorem. A numerical manifest must also identify its particular g: check g is a unit, g^m=1, and g^(m/ell) != 1 for every prime ell dividing m. With a checked factorization of m, these equalities prove order exactly m. The source's abstract choice of a generator must not silently replace the recorded numerical generator.

For powers of two use these cases:

| Modulus | Unit coordinates |
| --- | --- |
| 1 or 2 | Empty tuple, trivial group |
| 4 | e in Z/2Z, representing (-1)^e |
| 2^k, k>=3 | (e,f) in Z/2Z × Z/2^(k-2)Z, representing (-1)^e 5^f |

For the last line, equality of two represented units modulo 4 forces the e coordinates equal, because all powers of 5 are 1 modulo 4. Cancel the signs; `orderOf_five` forces the f coordinates equal modulo 2^(k-2). The domain and target each have 2^(k-1) elements, so this injective homomorphism is bijective. This is a valid use of cardinality after identifying the actual map. Transporting the source ring-element order of 5 to its unit uses injectivity of the units coercion. No cyclicity of the full unit group at modulus8 or higher is asserted.

CRT then gives a specified group isomorphism

\[
 U_c=(\mathbb Z/c\mathbb Z)^\times\simeq\prod_i\mathbb Z/m_i\mathbb Z.
\]

For an implementation, the inverse residue map is sum_i u_i E_i modulo c, with E_i=(c/q_i)*inverse(c/q_i mod q_i). Checking the inverses and coprimality fixes the same CRT map used to order samples. Neither the residue order nor the order of factors can be inferred from an FFT library convention.

## 3. Every actual character has one label

For a tuple r_i with 0<=r_i<m_i, define on units

\[
 \chi_r(u)=\prod_i \exp(2\pi i r_i x_i(u)/m_i),
\]

and extend by zero on nonunits. Use `MulChar.ofUnitHom` for this extension. At c=1 the tuple is empty and the unique character is the level-one principal character; zero in ZMod1 is a unit, so the general extension rule remains consistent.

Here is the coverage argument. Restrict any source `DirichletCharacter ℂ c` to its unit homomorphism and compose with the inverse CRT coordinate map. The image of the i-th standard generator has m_i-th power1. `Complex.isPrimitiveRoot_exp` and `eq_pow_of_pow_eq_one` produce an r_i<m_i giving that value. Equality on the standard generators gives equality on every coordinate tuple, hence every unit. `MulChar.equivToUnitHom` gives equality of the actual characters. `pow_inj` shows the r_i are unique. Thus this construction is a bijection with all source characters, independent of the count formulas below.

Let L=lcm(m_i). A numerical row can store only integer exponents

\[
 e_r(u)=\sum_i r_i x_i(u)(L/m_i)\pmod L.
\]

Its meaning is chi_r(u)=zeta_L^e_r(u), with the fixed positive-exponent root zeta_L=exp(2*pi*i/L). For L=1 the unique row is constant1 on units. A transformed Hurwitz row must therefore use positive exponents; a library's negative-sign DFT outputs the inverse label unless corrected explicitly. The analytic identity is L(s,chi_r)=c^(-s) sum_a chi_r(a) zeta(s,a/c) in Re s>1, then continued analytically for nonprincipal characters. Common-pole cancellation uses sum_a chi_r(a)=0. It does not require identifying an individual deflated Hurwitz value at s=1 with Mathlib's different totalized convention.

## 4. Conductor, primitive labels, parity and conjugation

For p odd and label r at modulus p^k, the exact local conductor is

\[
 c_p(r)=\begin{cases}1&r=0,\\p^{\max(1,k-v_p(r))}&r\ne0.\end{cases}
\]

Indeed, for 1<=j<=k, the reduction to U_(p^j) is surjective and its kernel is generated by g^phi(p^j). Triviality on that kernel is m | r*phi(p^j), equivalently p^(k-j) | r. Reduction to modulus1 additionally requires r=0. Apply `factorsThrough_iff_ker_unitsMap`; this derives the conductor for the actual source definition. For k=1 primitive labels are r!=0; for k>=2 they are p not dividing r.

At 2^k the local conductor is1 for k<=1. At k=2 it is1 for e=0 and4 for e=1. At k>=3 it is

\[
 c_2(e,f)=\begin{cases}
 1&f=0,e=0,\\4&f=0,e=1,\\2^{k-v_2(f)}&f\ne0.
 \end{cases}
\]

For reduction to 2^j with j>=3 the kernel is generated by 5^(2^(j-2)); the condition is 2^(k-j) dividing f. Reduction to4 kills the 5 factor and requires f=0. Reduction to2 or1 also kills the sign and requires e=0. Hence the primitive labels are e=1 at4 and f odd, either e, at2^k with k>=3. No character is primitive at conductor2, or at a level whose exact two-adic exponent is1.

For a divisor d of c, CRT identifies the global reduction kernel with the product of the local kernels. A product character is trivial there exactly when each local character is trivial on its kernel, since the other coordinates can be set to1. Consequently chi_r factors through d exactly when the product C of the local conductors divides d. This gives conductor=C using the source factor-through characterization. It also proves that the global primitive predicate is the conjunction of the local primitive predicates. No unproved equality between two different definitions of conductor is left implicit.

Conjugation negates every coordinate modulo its order, so the partner is uniquely specified and has the same conductor and parity. A character is real exactly when 2*r_i=0 modulo m_i for every coordinate. The sign at -1 is (-1)^a, where

\[
 a=e+\sum_{p\text{ odd}}r_p\pmod2.
\]

The term e is present only for the sign coordinate of the 2-primary factor. This formula follows because -1=g^(m/2) at an odd prime power, and has 2-primary coordinates (1,0). It matches the source `Even` and `Odd` predicates. A certificate may reuse the conjugate partner's analytic work only through a proved functional-equation/conjugation adapter. The manifest does not erase the negative-ordinate channel or count a nonreal pair as one character.

## 5. Active conductors and exact counts

In Goldbach `MinorArcs/LargeSieveWeights.lean:26`, qt(q)=q for even q and2q for odd q. `LargeSieveArcs.lean:34` defines Qset(R) by q>=1 and qt(q)<=2R. At R=150000 the ambient moduli are even q<=300000 and odd q<=150000.

If c divides an ambient q then qt(c)<=qt(q): the only mixed-parity case has c odd and q/c even, hence2c<=q. Every primitive character of an ambient modulus induces from its source conductor c, by `primitiveCharacter_isPrimitive` and `changeLevel_primitiveCharacter`. The nonempty active conductor set is exactly

\[
 \{c\le150000:c\text{ odd}\}\ \cup\ \{c\le300000:4\mid c\}.
\]

Every conductor in this set already occurs at its own allowed modulus. There are150000 conductors, including1. The primitive character count a(c) is multiplicative, with a(1)=1 and

\[
 a(p)=p-2,\qquad a(p^k)=p^{k-2}(p-1)^2\quad(k\ge2).
\]

These formulas follow by counting the primitive coordinate conditions, including p=2. The external checker recomputes the local formulas and verifies sum_(d|n) a(d)=phi(n) for every1<=n<=300000. Its totals are:

| Quantity | Exact count |
| --- | ---: |
| Active primitive characters | 5,543,640,188 |
| Odd conductors | 3,695,775,215 |
| Conductors divisible by4 | 1,847,864,973 |
| Even characters | 2,771,820,069 |
| Odd characters | 2,771,820,119 |

For the parity check, b(c)=sum_primitive chi(-1) is multiplicative. Its odd-prime local values are b(p)=-1, b(p^k)=0 for k>=2; its two-primary values are b(2)=0, b(4)=-1, b(2^k)=0 for k>=3. At1, b(1)=1. The checker also verifies sum_(d|n)b(d)=1 for n=1,2 and0 thereafter. The even and odd primitive counts are (a+b)/2 and(a-b)/2.

The manifest key is `(c, tuple_of_local_labels)` in increasing prime order, restricted to the primitive subset. For an induced character at q, `conductor_changeLevel` forces c to be that character's actual conductor, and `changeLevel_injective` forces its primitive label unique. This avoids both omission and duplicate indexing across conductors. It does not assert that every primitive label has nonzero Gauss coefficient at every ambient q. The existing Gauss weights and their support must still be applied when that character is used in a sum.

Height dispatch uses this c, not q. The checker records, for example, Hcert(40)=2500000, Hcert(120)=2500000/3 and Hcert(300000)=1000/3. The c=1 row uses the separate pole-cancelled zeta function in the spectral certificate. The arithmetic uniqueness statement does not authorize treating raw zeta as an entire nonprincipal L-function.

## 6. Exact composite pilots

`family_character_manifest_20261111.py` uses only Python integer arithmetic, rational arithmetic and symbolic root exponents. It calls no zeta, Hurwitz, Gamma, floating-point exponential, or numerical root-of-unity routine. It checks:

* the actual residue-to-coordinate map is bijective and respects multiplication;
* every coordinate row is distinct;
* for every row and every divisor d of the modulus, the reduction kernel criterion holds exactly for the divisors divisible by the proposed conductor;
* negating the label conjugates every root exponent, and the sign at -1 agrees with parity.

| Pilot c | Coordinate orders | All characters | Primitive | Even/odd primitive | Real primitive |
| --- | --- | ---: | ---: | --- | ---: |
| 4 | 2 | 2 | 1 | 0/1 | 1 |
| 8 | 2,2 | 4 | 2 | 1/1 | 2 |
| 16 | 2,4 | 8 | 4 | 2/2 | 0 |
| 27 | 18 | 18 | 12 | 6/6 | 0 |
| 40 | 2,2,4 | 16 | 6 | 3/3 | 2 |
| 72 | 2,2,6 | 24 | 8 | 4/4 | 0 |
| 120 | 2,2,2,4 | 32 | 6 | 3/3 | 2 |

At c=40 the labels are (e,f,r5); the primitive subset has f=1, r5 in{1,2,3}, and either e. At c=120 the labels are(e,f,r3,r5); primitive means f=r3=1, r5 in{1,2,3}, and either e. The two real primitive characters have r5=2. This tests the noncyclic two-primary group, mixed CRT factors, and an actual nonreal conjugate pair. The27 and72 pilots additionally test the p-divisibility criterion at a nontrivial odd prime power.

The run exited0 in about1.2 seconds and the receipt says PASS. That timing is only for this arithmetic checker. It is not a forecast for5.54b analytic rows. The script checks300000 count entries but does not enumerate5.54b characters or produce the local generator manifest for all conductors.

## 7. Remaining proof and data work

The new Lean work would package the chosen local generator equivalences, the explicit two-power equivalence, their CRT product, the root-exponent character equivalence, and the kernel-based conductor formulas. The existing source theorems listed above supply the main abstract ingredients; the packaged statements and source-to-numeric indexing bridge are not implemented here.

A production data checker should require a checked factorization and order witness for each distinct local prime power; factor order and root sign; the exact primitive-label predicate; parity and conjugate-label maps; and the rational Hcert formula. It can validate the map generically rather than serialize all character rows. Any analytic result keyed by a tuple must still identify the exact L-function returned by this equivalence. FFT outputs require an explicit sign, permutation and normalization adapter. The total count then acts as an additional consistency check, not a substitute for that identification.

There is no reduction in the analytic obligation established here. All primitive labels still require the selected zero-exclusion evidence or a proved all-character certificate that covers them. This note makes such a certificate's indexing and completeness requirements concrete.

## Reproduction and pins

Run `work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/family_character_manifest_20261111.py` from the workspace root. It writes only its new adjacent JSON receipt.

* Script SHA256: `570FD7E9636BC9FF0337BEB80AE5053B581B6338C44462408BB225DF5EBF1F9B`.
* Receipt SHA256: `DF040A89B7E2D8856023B9D36169F741B1CD05B3DB6C5D8D1D30C27E855B6EB7`.

Independent review is requested from the integration worker. This note preserves all previously frozen packets. In particular, the earlier EM top report's stale low-strip status is already corrected in its separate accepted review; no numerical top packet changed here.
