# Fixed-Q exceptional row count: mathematical source audit

2026-11-11. Coordinator-authored packet; **independent review pending**. This advances the counting boundary in the [exceptional physical-saving packet](QRH_EXCEPTIONAL_PHYSICAL_SAVING_AUTHOR_2026-11-11.md), SHA-256 `7AAB71EBE62B6BF513922FED1D46711E355565127CADB792104076A3CD5E1F0A`. It is a source argument, not a Lean build or a transitive axiom check.

## Exact target and hypotheses

The target is `SevenEighths.CenteredMomentFixedQForcingCount.actual_canonical_exceptional_count_fixedQ` in `Moments/FixedQForcingCount.lean:180`. The core producer is `actual_forcing_exceptional_count_fixedQ:122` in the same file. Both are present at provider commit `4eaee87548250b2682affda7d05d947c05554bae`.

Write `N` for ideal absolute norm, `F` for the source's forcing ideal, and `rad Q=commonRadical Q Q`. Under the actual target hypotheses, the bound is

```
#rows <= 768 * 6^omega(Q) * N(rad Q)^(2/3)
           * Cr^(1/6) * Z^((M - 4*log_Z(N F))/6),
```

where `omega(Q)` counts distinct normalized prime factors. The rows are a finite set of nonzero Eisenstein integers, with `N((z)) <= Cr*Z^M`; `Z>1` and `Cr>=0`. The row predicate is the actual `FixedInducingRow (childCharacter eta chi) Q m A z`, with `A=commonFrequencyGenerator C D * nonunitFrequencyGenerator C D U`. The target also requires supported `C`, `Q!=0`, `Q!=top`, `Q<=span{72}`, nonzero `m`, `lambda|m`, `2|m`, and `idealCoeff eta C!=0`. There is no `IsCoprime Q C` hypothesis. This target does not require supported D or equality of the prime supports of C and D; later consumers supply their own additional hypotheses.

The general producer instead takes an injective family of prime ideals `(p_i)`, exponent vectors and a subset V. For each forcing prime it requires exclusion of lambda and 2 and divisibility into `(e)`, where `elementCoeff eta e!=0`. These requirements are supplied in the canonical adapter using the common primes of C and D and `e=primaryGenerator C`.

## 1. The local residue mechanism

`FixedInducingRow` is not merely a congruence on the row label. It gives characters chi and psi, primitive psi, an actual induced-character identity, `Q<=psi.modulus`, and equality of chi with the row twist for every argument. The proof retains these witnesses. It does not assert that one fixed psi works for all rows, and it does not need uniqueness of primitive induction.

The key finite algebraic step is `CenteredExceptionalProfile.valuation_mod_six_of_unit_agreement:65`. Split each supported ideal I,J into its P-power part and its part prime to P. For every unit in `O/P`, CRT constructs n which has that unit as its P-residue, is 1 modulo Q and both complementary ideal factors, and is prime to a specified nonzero ideal K. To construct this n even when P divides K, split K into its P-power and its P-coprime part; prescribe 1 on the latter and a unit at P. No unjustified assumption `IsCoprime Q K` is needed.

If the two ideal-row characters agree on all such n, the complementary factors evaluate to 1. Therefore the actual sextic characters raised to the two P-valuations agree on every unit of the residue field. Their exact order six implies equality of the valuations modulo six. The good-prime and residue-characteristic-not-two hypotheses are essential for the exact-order statement.

For two exceptional rows, choose K to include the row mask and the source and induced-character moduli. On n=1 modulo Q the induced characters evaluate to 1. The source character value is nonzero because n was chosen prime to its modulus, so it can be cancelled. This gives equal residue classes modulo six outside the prime support of Q. The fixed numerator A cancels from the valuation congruence. The two-row argument does not require the source character to be unramified at P.

For a single row at a prime also coprime to the source-character modulus, strengthen the CRT condition to n=1 modulo that modulus. The source character itself now evaluates to 1. The same exact-order-six argument gives

```
v_P((A*z)) == 0 (mod 6).
```

When `v_P((A))==2 (mod 6)`, this forces `v_P((z))==4 (mod 6)`. The row conversion used here factors the numerator into a unit, powers of lambda and 2, and a supported primary part. The bad-prime factor is 1 on n=1 modulo 72, and the mask is 1 on arguments coprime to m. `Q<=span{72}` supplies that congruence in the required direction. Numerator factorization, row reciprocity conversion and the bad-prime periodicity are explicit lower source dependencies, not numerical inputs.

## 2. Sixth-power normal form and the number 768

For every nonzero ideal I, define R by reducing each prime valuation modulo six and J by dividing each valuation by six. Unique factorization gives

```
I = R * J^6,        0 <= v_P(R) < 6.
```

R and J are nonzero. Fixing R makes `I -> J` injective; no choice of a sixth root of an element is involved. The norm identity gives

```
N(J) <= (H/N(R))^(1/6)       whenever N(I)<=H.
```

The source's finite ideal-count bound is `#S<=128*T` for a finite set of nonzero ideals with norm at most T, when T>=1. In a nonempty remainder fiber, its quotient ideal has norm at least one, so the required T>=1 follows from the fiber itself. If the fiber is empty, the desired inequality is immediate. This avoids adding 1 to the estimate or assuming every formal scale exceeds one.

There are at most six nonzero elements generating a given ideal. The source proves this by the injective map `z -> (rowUnit z, (z))`, retaining the unit coordinate; it does not incorrectly regard `z -> (z)` as injective. Thus

```
#{z : N((z))<=H, sixthRemainder((z))=R}
    <= 6*128*(H/N(R))^(1/6).
```

This is the source of 768. The linear ideal count is in absolute norm; no further square root is taken for the two-dimensional ambient lattice.

For primes outside `S=primeSupport Q`, the two-row residue argument fixes all remainder valuations. At primes in S there are six choices, 0 through 5. Coding each occurring remainder by its valuations on S is injective, giving at most `6^omega(Q)` remainders. This bound counts actual image remainders and does not assume every code occurs. `outside_fixed_support` verifies that every prime outside S is coprime to Q and contains neither lambda nor 2: both divide 72, and Q lies inside `(72)`.

## 3. The fourth-power forcing gain

The moving ideal is

```
Aideal = product P_i^min(c_i,d_i) * product_(i in V) P_i,
forcingSet = {i in V : c_i=d_i=1},
F = product_(i in forcingSet) P_i.
```

Prime-ideal injectivity is indispensable. It makes F squarefree and makes the valuation of Aideal exactly two at every forcing prime. Without injectivity, repeated copies could change both assertions.

First suppose a squarefree product G of forcing primes is coprime to Q. Nonvanishing of `elementCoeff eta e`, together with each such prime dividing `(e)`, implies coprimality with the old source modulus. The child modulus is the intersection of that modulus with `(12)`. Since `(12)` divides Q as an ideal divisor under `Q<=(72)`, primes coprime to Q are also coprime to `(12)`. Therefore they are coprime to the child modulus as well. This is how the single-row residue argument obtains its extra coprimality hypothesis; it is not inferred from the row predicate alone.

Every remainder R then contains G^4, so `N(R)>=N(G)^4`. With `H=Cr*Z^M`, the previous count gives

```
#rows <= 768 * 6^omega(Q) * Cr^(1/6)
           * Z^(M/6) / N(G)^(2/3).
```

The squarefree requirement matters: a residue of four only guarantees four copies of each prime in R. It does not guarantee the fourth power of a product containing that prime twice.

## 4. Removing the unwanted Q-coprimality premise

The fixed-Q proof partitions the forcing primes into

```
G = product of forcing primes coprime to Q,
E = product of forcing primes not coprime to Q.
```

The disjoint partition gives `F=G*E`. Every prime in E divides Q: for a nonzero prime ideal P in this ring, maximality and failure of coprimality give `Q<=P`, equivalently `P|Q`. Because E is squarefree, `E|rad Q`. Consequently

```
N(F) <= N(G)*N(rad Q),
N(G)^(-2/3) <= N(rad Q)^(2/3)*N(F)^(-2/3).
```

Substitution gives the exact target. The proof does not discard rows at the excluded primes or pretend that those primes still force fourth powers. It pays for losing them. If all forcing primes are excluded, G is the unit ideal and the bound reduces to the unsaved count after this loss is paid. If none are excluded, the coprime count applies directly; the fixed-Q theorem's displayed radical factor is then a valid but unnecessary weakening.

The factor `N(rad Q)^(2/3)` depends on Q. It can be absorbed into an existential constant chosen after Q, as the physical-saving adapter does; it is not a uniform constant over all Q. The condition `Q<=span{72}` is an ideal containment, not a numerical bound on N(Q), and supplies no such uniformity.

All bases in the negative powers above are positive norms of nonzero ideals. At `Cr=0`, the row norm bound and nonzero-row assumption force the row set to be empty, consistent with the right side being zero. Negative M is allowed. No height, conductor or positivity hypothesis beyond the stated source hypotheses has been silently added.

## Evidence and remaining boundary

I read the full FixedQForcingCount, Forcing, ChildRows and SecondExceptionalCount files, the profile chain through `fixed_support_exceptional_count`, and the normal-form/count bodies listed below. This supplies a complete mathematical assembly of the row-count estimate conditional on the identified lower algebraic identities. No numerical spectral information is used in this assembly.

Existing research already covers related lower ingredients: the [local Gauss/character review](../qrh-campaign/agents/major-constants/REVIEW_QRH_LOCAL_GAUSS_CHARACTER_AUDIT_2026-11-11.md) checks the actual sextic character's exact order under the exclusions; the [deleted-mode mass audit](../qrh-campaign/agents/zero-sum/QRH_DELETED_MODE_MASS_ANALYTIC_AUDIT_2026-11-11.md) describes the lattice ideal-count bound. I inspected the actual adapter bodies here rather than assuming that a similarly named result suffices. These references do not establish a new independent review of this packet or a kernel check.

Remaining lower source obligations are the exact row-reciprocity/numerator conversion, bad-prime periodicity and the standard ideal/unit infrastructure to the extent not already reconciled in the accepted provider audits. The inspected `rowTwist_eq_actualPeriodicRow_primary` explicitly calls `rowTwist_extract_sixth_mask` and `idealRowHom_factor_numerator`; that is the next precise boundary, not an unspecified exceptional-row assumption. The separate finite-profile analytic paired-column estimate from the preceding packet remains open. No mathematical premise is being added to the final Goldbach theorem; all these dependencies remain internal obligations.

No new evaluator or enumeration was run. No Lean code, anchor, dependency, toolchain or frozen strategy was changed. The source proof still needs independent review and compatible elaboration/axiom validation. PlattGRH is not removed from the target development.

## Pins and inspected ranges

Source paths are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL`. Ranges describe reading scope, not line-range hyperlinks. Hashes pin entire files without asserting that every declaration in them was audited.

| Source | Read scope | SHA-256 |
|---|---|---|
| Moments/FixedQForcingCount.lean | Full | 66BE9392CC220CA1AA97A170C7450EDDAC94D45AC053B07B3F2C06B491543C87 |
| Moments/SecondExceptionalCount.lean | Full | 3A106520EA72A180B715627762F933D891F758233061CC1ED9F68A70F9549A3B |
| Moments/Forcing.lean | Full | 0F2DD98253B9A31D370767FFE8CA881342B52899692E3FB65776B46AD25C960E |
| Moments/ChildRows.lean | Full | 9D0E2FC641436660CE4AB0763EF0A8785EFF3213680729AB268A4774528B2E0C |
| CenteredExceptionalProfile.lean | 1-492 | F3B9FB4EE81B83B191F4E11100B56CFE3F2251FC89B4E0308FB7E30FF78B8506 |
| CenteredExceptionalCount.lean | 1-271, 306-322, 397-417 | DEE01FA2DB940FF3A29181D5C915FFB8C097AF29C94E232CDC9B01A904FAE27B |
| Moments/Canonical.lean | 14-27, order-six adapter | 7F0E2D5F8D990D394C1932B80DB6422D788579E126F83540CC92152D6FCFF9CC |
| Mellin/InverseContour.lean | 306-317 | 07583B9AD1732A76889CA43FA78BDD98E902E0B41612F68D6CFB5ED4C5166D20 |
| MeanSquare/UniformPolynomialHeight.lean | 548-607 | 402E50E9AFA51CB3CE58D49196C506469E05DE8E789A7ACD58AC5BAEF11215BE |
| RowCompletion/PeriodicRows.lean | 117-146 | 2FDB280F40315D3196A079CF9DE94BC2FFCC9B83BC9E273347A82ED5CA6408DE |
| ChineseRemainder/FrequencyLifts.lean | 542-620; periodicity body only partly inspected | 90D96A53BC7F9FD83ECFA84086374EB9D4A40F9F86DA274A33F429C68C157174 |

Supporting report hashes: local-character review `9AF6579598742F09593A93BBE5F380C54D89A89CCE64DFC94F49893D115C8B7E`; deleted-mode mass audit `B7575C743474BBF80AA421937AFDAD10590EA76BE21FB421B6225DDEC8CAA859`. Only the relevant supporting sections were read this turn.
