# Exceptional physical saving: source audit and remaining producer cuts

2026-11-11. Coordinator-authored research packet. **Independent review pending.** This extends the [seeded Gaussian review](REVIEW_QRH_SEEDED_GAUSSIAN_SOURCE_ENERGY_AUDIT_2026-11-11.md); it is not a second independent review of that packet, a compiled theorem, or validation of the QRH provider.

## Scope and result

The target is `SevenEighths.CenteredMomentFiniteProfileExceptionalPhysical.original_budget_physical_saving_full`, at `Moments/FiniteProfileExceptionalPhysicalSaving.lean:23`. This is the finite `Sprofile` / `Profiles` version, not the older `Tests` version of the same suffix. The other target, `CenteredMomentFiniteProfileExceptionalFixedQ.actual_dyadic_exceptional_block`, is mapped through its actual adapters to explicit lower analytic and counting obligations.

I reconstructed the physical scalar saving, its nonzero-block witnesses, the local exponent inequality, and the finite-profile budget identity. No defect was found in these inspected implications. Lower correlation identities and the exceptional analytic estimate remain explicit dependencies. The source-level implication is conditional on those dependencies; no global closure is claimed.

Sources are pinned to the current bytes below under `work/openai-math/lean/OAI/NumberTheory/DirichletL/Moments/`. The provider checkout is `4eaee87548250b2682affda7d05d947c05554bae`. This audit does not resolve the provider/target Lean and Mathlib version mismatch.

## Physical scalar proof

Write `c=Norm C`, `d=Norm D`, `g=Norm(span commonFrequencyGenerator)`, `v=Norm(span nonunitFrequencyGenerator)`, `u=Norm(product over U)`, `p=Norm(commonRadical C D)`, and `f=forcingNorm C D U`. Write the four positive dyadic scales as `k,h,A,B`. Let `H>0` be the source volume, `K>0` the physical parameter, `a>0` the lower-support constant, and `Z>1`.

For an actual nonzero physical block, the source proves

```
k >= K*g*v/(c*d),     A >= a*H/c,     B >= a*H/d.
```

These are not additional free hypotheses about arbitrary dyadic scales. `physicalBlock_effective_window` extracts a nonzero summand and its first dyadic weight. `physicalBlock_column_witnesses` extracts nonzero coefficients on both columns and their dyadic weights; `raw_window_lower` uses multiplicativity of ideal norm and the assumed coefficient lower support. The strict upper dyadic support gives the stated weak inequalities. Cancellation in the full sum causes no problem: a nonzero finite sum has a nonzero summand. The converse is not used.

After the exact partition-normalizer identity, `centralPhysicalCost` equals

```
L = K*g/(sqrt(c)*sqrt(d)*u*sqrt(A)*sqrt(B))
      * h^(1/6)/(1+k*h/(A*B)) * H/(c*d) * p/f^(1/3).
```

For `x>0`, `x^(1/6)/(1+x)<=1`: for `x<=1` use `x^(1/6)<=1`; for `x>=1` use `x^(1/6)<=x`. Set `x=k*h/(A*B)`. Then

```
h^(1/6)/(1+k*h/(A*B)) <= (A*B/k)^(1/6),
(A*B)^(-1/3) <= a^(-2/3)*H^(-2/3)*(c*d)^(1/3),
k^(-1/6) <= (K*g*v/(c*d))^(-1/6).
```

Multiplying positive factors yields

```
L <= H^(1/3)*K^(5/6)*a^(-2/3)
       * g^(5/6)*p/(c*d*u*v^(1/6)*f^(1/3)).
```

The logarithm of the reciprocal of the final factor is exactly the source's `saving C D U Z`. This reconstructs `scalar_log_ledger` and `actual_physical_cost_bound` without treating the `linarith` call as the mathematical argument. Positivity is needed for all negative powers and logarithms.

## Why the local saving is at least one third

At a common prime, let its positive exponents in `C,D` be `c0,d0`, and let `n` be the proposition that it divides the divided frequency. The local ledger is

```
c0+d0 - 5*min(c0,d0)/6 - 1
  + [c0=d0 and 6 does not divide c0 and not n]
  + [c0=d0 and 6 does not divide c0 and n]/6
  + [c0=d0 and c0=1 and n]/3.
```

Here brackets denote indicator values. Nonzero local correlation supplies `c0 != d0 -> 6 divides min(c0,d0)`. Subtract `(c0+d0)/3`:

* Equal exponents `j` divisible by six: the difference is `j/2-1>=2`.
* Equal exponents not divisible by six, unit frequency: it is `j/2>=1/2`.
* Equal exponents, nonunit frequency, `j=1`: it is exactly zero.
* Equal exponents not divisible by six, nonunit frequency, `j>=2`: it is `j/2-5/6>=1/6`.
* Unequal exponents: writing `m=min(c0,d0)>=6` and `s=c0+d0>=2m`, the difference is `2*s/3-5*m/6-1>=m/2-1>=2`.

The last forcing term is essential: removing it at `c0=d0=1`, nonunit frequency, gives only `1/3`, below the required `2/3`.

`SecondLedger.local_nonzero_of_global` obtains nonzero local correlations from the product-of-norms identity with all three pairwise coprimality conditions. `nonzero_unequal_min_six` invokes the unequal prime-power vanishing theorem; for the reversed ordering it also uses correlation norm symmetry. These are retained lower arithmetic obligations, not results of this scalar calculation. `SecondCanonical` verifies their supported, good-prime and odd-characteristic hypotheses for the actual common-prime family.

Summing the local inequalities with nonnegative weights `log_Z(Norm prime)` gives `saving >= (log_Z c+log_Z d)/3`. To use this for the physical block, `physicalBlock_canonical_witness` obtains an actual row with its canonical partition and nonzero common correlation. It uses `sectorFrequency_zero_of_common`: zero common correlation would force the corresponding weighted sector sum to vanish. Thus the local saving is justified by the actual block, not merely by an arbitrarily chosen partition.

Consequently

```
centralPhysicalCost <= H^(1/3)*K^(5/6)*a^(-2/3)
                        * Z^(-(log_Z c+log_Z d)/3).
```

## Exact finite-profile budget join

Let `P=profileFactor Sprofile s profiles J Q Ksource` and
`E0=2*epsilon+delta-max(r-min(log_Z c,log_Z d),0)`. The exact source budget at row exponent `log_Z h` is

```
sourceBudget = P * Z^E0 * (c*d)^theta
                 * h^(1/6)/f^(2/3) * H^2/(c*d).
```

`profileMass_self` produces one volume factor; the source budget already contains another. After multiplication by `outerScalar*normalizer/H` and division by `1+k*h/(A*B)`, the expression is exactly

```
P * Z^E0 * (c*d)^theta * centralPhysicalCost / (p*f^(1/3)).
```

The additional `f^(1/3)` in this denominator must not be lost in the equality. Since it is the norm of a nonzero ideal, `f>=1`; it can subsequently be dropped in an upper bound. Substituting the physical bound above gives precisely `original_budget_physical_saving_full`. `P>=0` uses `Ksource>=0`; the proof does not require `theta<=1/3` because it retains `(c*d)^theta` and the full column power saving. It also retains the coefficient lower-support assumption, `Kphysical>0`, `a>0`, `Z>1`, supported `C,D` with equal prime supports, nonzero row labels, and the actual nonzero block. The surrounding saved theorem handles zero blocks separately.

## Dyadic producer map and constant dependencies

The inspected chain is

```
FixedQDyadic.actual_dyadic_exceptional_block
  -> FixedQRows.actual_physical_exceptional_block
  -> FixedQBlock.actual_original_exceptional_block
  -> FixedQPair.actual_canonical_original_pair
  -> FixedQWindow.actual_canonical_common_window
  -> FixedQCanonical.actual_common_canonical_bound.
```

The dyadic adapter restricts to the exact finite `dyadicRows`, whose discarded summands are zero; it takes `Cr=1`, `M=log_Z h`. The physical adapter uses the exact block normalization. The block adapter uses the exceptional kernel estimate and filters the right divisor pool at `Norm L<=Hcap/Norm D`; the discarded coefficients vanish. It preserves inverse ray character and reflected row `-z`. The pair adapter uses the actual reflection identity, opposite window shifts, and `mass_phase`, paying `(1+2*pi)^(4*J)` and the weighted density integral squared. These steps do not themselves produce the lower analytic exceptional estimate.

In `FixedQCanonical`, the bound with `rows.card` is multiplied by `FixedQForcingCount.actual_canonical_exceptional_count_fixedQ`. That count includes

```
Norm(commonRadical Q Q)^(2/3)
  * 768 * 6^(number of distinct normalized factors of Q)
  * Cr^(1/6) * Z^((M-4*log_Z f)/6).
```

The first factor is absorbed into `Ksource` **after Q has been fixed**. No uniform bound over arbitrary Q has been proved here, and no coprimality premise `IsCoprime Q C` has been inserted. The older non-FixedQ physical-block theorem does carry that premise, so it is not an interchangeable substitute.

Throughout this chain, `J,Sprofile` are chosen before Q, actual source data and row sets; kernel constant `Ck` is chosen from `W,decay,2J`. `Ksource` and the eventual Z threshold can depend on Q. The four individual lower scale inequalities and both expanded-conductor bounds remain intact. Ideal containment `Q <= span{72}` is preserved in its original direction; it is not interpreted as a numerical upper bound on `Norm Q`.

`SecondExceptionalKernel` passes through an actual weighted paired-row bound, retaining the Mobius sum, inverse character and reflected row. Its ray-character expansion pays a factor 256 from `phaseTable_mass`. Its underlying analytic `whole_kernel_paired_row_estimate` and arithmetic expansion identities are explicit lower dependencies; this packet does not claim them proved from first principles.

## Validation and next work

The [scalar script](exceptional_physical_scalar_20261111.py) has SHA-256 `23341FE8AF4A0F24AEC3F84529ABFB6ADE6A222123940A350799DACB40BCCD87`. It passed 192 admissible local-exponent examples, 486 positive-rational physical inequalities after taking sixth powers, and the negative control for the missing forcing term. It evaluates no L-function, zero, prime sum or transcendental function. These finite checks are safeguards; the general proofs are the arguments above.

Next author tasks are the actual finite-profile analytic producer `FiniteProfileExceptionalCommonSymmetry.actual_common_better_side` (which calls `actual_common_exceptional`) and the forcing row-count theorem `FixedQForcingCount.actual_canonical_exceptional_count_fixedQ` (which calls `actual_forcing_exceptional_count_fixedQ`). Separate arithmetic dependencies are the unequal prime-power vanishing and product/sector correlation identities. Their interfaces were inspected here; their full lower proofs were not closed. Independent review of this packet is pending because the available reviewer agents remain stopped on usage limits. No build, new declaration, spectral scan, or claim of PlattGRH removal was made.

## Source pins

Every name in this table has suffix `.lean` and is relative to the Moments directory named above. A file hash pins bytes, not proof status. Main scalar bodies and named adapters were read; `FixedQForcingCount` was inspected at its final canonical theorem, `ProductCRT` at the product-norm interface, and `Unequal` at the named vanishing theorem, not as full-file audits.

| File | SHA-256 |
|---|---|
| FiniteProfileExceptionalPhysicalSaving | FC1ADE59A5727993749A11915501114E2003B741D2D6D6C90ECB61F99E58B8E5 |
| FiniteProfileExceptionalPhysicalBudget | B1303CA0749CD742BB1DE1CD087F7DE849CE1729C16343ACEEE1847AD17D63E9 |
| SecondPhysicalLedger | C36270B7D0B84A99193BC2DAAD72BCE6827FD7B91EED87F23D01D1124106B35A |
| SecondCanonicalLedger | 45F0591BFD629E83B09F507C83EF6E33DD15107270099CCEBA3CD1F4F92FA2D7 |
| SecondCanonical | DCF40AA287513A189BF8D913EC53F94ECBE6A830BB60EAA00671DBD3553E57CF |
| SecondLedger | A9FF63ABBA85AE56F0954DD3D6417D25F072140646256D5352446A9DF8491AC0 |
| SourceBlockWindows | AEB43E9AD740D2E6DB30182D10DE517AD1DB048F1E650F48E09A6EE42E42AE86 |
| SourceDyadicShell | 43F3C01A1956DCAB083DCF860ADA54C2CE5CD101ACABC9B5B7A1DECED3FDD3DE |
| SecondExceptionalPhysicalSaving | D56F3F9E231FDA9EA297ACA883E2581C402F314B715178D076F9DA22FC305684 |
| FiniteProfileExceptionalPhysicalBlock | D2F8DAD354530A138A18E38915474A80CD3453BB08FA735F788468AE9BED393C |
| FiniteProfileExceptionalFixedQDyadic | 7002D30BFB80C8260B1BAF8E27D97D1B07CD182D47352C964F6695471247B24D |
| FiniteProfileExceptionalFixedQRows | 6A672C532C88A4C1B20FEBDCC6B6646AE4FF926E9F11D3C760132D87B139158C |
| FiniteProfileExceptionalFixedQBlock | 8BE071692E002AAFAD50EF95FB4FB15C0733499FF409E2EA6B2EF93124722B94 |
| FiniteProfileExceptionalFixedQPair | AA87A43C89888FA1666549C024A4A6D4A5E1F3FA997F9D8BFDFC310BDED0F7D3 |
| FiniteProfileExceptionalFixedQWindow | 87827C9A3F4C715AE412B246680977CF37164DADFB64F99716F92FFEEB1723AA |
| FiniteProfileExceptionalFixedQCanonical | AB1C0262F85D8F84818B46860D1E3B111C676CB37137D467414EB42C5E07BC32 |
| FiniteProfileExceptionalCommonSymmetry | 2DBDC6B649C7A0A1E915D9A911E1975C330ACA7689E47E7EDF2E66B0796E308E |
| FixedQForcingCount | 66BE9392CC220CA1AA97A170C7450EDDAC94D45AC053B07B3F2C06B491543C87 |
| SecondExceptionalKernel | 78CB304D0B4871E7E626105DC497663F17348293CF984BA239821E2619DBA3CA |
| SecondPhysicalBlock | 799E1737525FE3584426FE94CAE9D1F8DDD20812D03F5D1779D054233980D28F |
| SecondDyadicRowSupport | 7E05626870E9AAA2911D7D70114C6292721C7C7C641FC65EB459AB3A9E9D2585 |
| SecondSectorFrequency | BA917C7041F8A0395C7224F6CC52D7D0C033F8D083C46E69DE1DDAA03D1734CC |
| SecondCanonicalScalar | 12DC9B1300452A13499ACF0AF63D751A91A3CCDC6069F126139FE468739CE8D7 |
| Unequal | 454DE77D83492F993B3A423FD620521B5240C720DB6913975764D8616BF79A01 |
| ProductCRT | 7183CD7035483F02A0264301C5205046452171999DC8E84E23D0DF595647FA87 |
