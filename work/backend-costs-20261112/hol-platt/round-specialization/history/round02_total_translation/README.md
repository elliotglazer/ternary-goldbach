# Positive-denominator rounding specialization

Status: source-only, unbuilt. No HOL process, evaluator call, benchmark, numerical fixture evaluation, or dependency edit was run for this packet. These are proposed ordinary HOL proof scripts, not yet accepted theory objects.

## Files and build order

1. `RoundSpecializationScript.sml`: proves the integer quotient identity, defines the alternate rounding and butterfly, and transports equality and the original local residual contract.
2. `RoundSpecializationCVScript.sml`: separately registers the new executable definitions with `cv_trans_pre` and proves their positive-denominator preconditions.
3. `Holmakefile`: points at the existing setup theories and stock CV automation. It adds no resource override.

The parent should compile the two theories in that order under the existing serialized build policy. The original `BlockRound` source, theory, translated equations, and all kernel/dependency files remain unchanged.

## Exact identity

For natural `a` and positive natural `d`, write `a = q*d + t`, where `0 <= t < d`. Then

```
-(a+1) = (-q-1)*d + (d-1-t),   0 <= d-1-t < d.
```

The source uses `arithmeticTheory.DIVISION` and `integerTheory.INT_DIV_UNIQUE` to prove this identity, then derives for positive `a`

```
(-&a:int) / &d = -&((a-1) DIV d) - 1.
```

The executable definition is

```
positive_den_div_one n d =
  if n < 0 then -&((Num (-n)-1) DIV d) - 1
  else &(Num n DIV d).
```

Its correctness theorem assumes only `0 < d`. `Num (-n)-1` is natural subtraction, but the negative branch has strictly positive magnitude, so it does not lose information by truncation. A zero numerator takes the nonnegative branch. Exact negative multiples are covered without a special MOD test.

`round_scaled_one s r` calls that function on the exact numerator `2*r+s` and natural denominator `Num (2*s)`. For `0 < s`, this denominator is positive and embeds back to `2*s`, so the result equals the existing `round_scaled s r`. The sign tested is the sign of `2*r+s`, not the sign of `r`.

The original rule is floor rounding after adding one half. Its half ties are toward positive infinity. Equality to the original function, and the transported residual interval `-s <= 2*(r-q*s) < s`, retain both tie endpoints. No alternate tie convention is introduced.

The alternate butterfly copies all three real products, presums, and output sums from `BlockRound`; only the two rounding calls change. `rounded_butterfly_one_correct` proves equality on all integer inputs at positive scale. `rounded_butterfly_one_residual` then reuses the original theorem. No local-error or precomputed-result hypothesis replaces computation.

## Execution hypothesis and limits

The pinned `cv_primScript.sml` represents integer `Num` by `cv_abs`, and its stock signed `cv_int_div` uses natural DIV plus MOD on a negative numerator and positive denominator. The new executable branch contains one natural DIV, with magnitude extraction, predecessor subtraction, negation, and subtraction of one. The only MOD in the new pure proof script is in the proof of the identity; it is absent from the definitions being translated.

After successful compilation, inspect the generated CV body and reachable equations to check that the active negative branch has the intended single `cv_div` and no `cv_mod` or signed `cv_int_div`. The code still uses stock trusted CV computation and stock theorem construction. This is not a replacement evaluator, an externally supplied answer, or a new axiom. It also does not establish a separate primitive-inference trace per arithmetic operation.

No speedup is claimed. One fewer explicit remainder site need not imply one fewer bigint division in every implementation, and the branch/magnitude/subtraction costs remain. This experiment does not hoist denominators or coefficient presums, change prepared literals, reuse a closed result, or remove any acceptance check. A later matched dependent-block experiment must keep the original workload, output contract, literal preparation accounting, and precondition/transport costs. The present packet stops at the alternate scalar and butterfly interface; it does not install a new dependent-block benchmark.

## Pinned source inputs

All paths below are relative to `work/backend-costs-20261112`. The HOL checkout is `hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92`.

| Source | SHA256 |
|---|---|
| `hol-platt/EVALUATOR_OPTIONS.md` | `893B055AC6854B1380309733F973A21A05DF207AE7739FDC814CE6CF1E740532` |
| `hol4-setup/BlockRoundScript.sml` | `FF267EC688BDC4A4065DE0BD14D3BC109F60F2A0D86F99FAE89646D4212EF143` |
| HOL `src/integer/integerScript.sml` | `C35C81AF62A41E7AECD2CA571A97275F130EE8BD1D70A041BCB7651CB72C7D8C` |
| HOL `src/num/theories/arithmeticScript.sml` | `5EF5AD4CC13DB74907AA557188BDA5F36F0219B1062E329D94D01FAC526C774D` |
| HOL `src/num/theories/cv_compute/automation/cv_primScript.sml` | `344DCC0FFB7071270819E366D027ADA5B449615EBE31A23B7CF7C6DC0CD8F28A` |
| HOL `src/num/theories/cv_compute/automation/cv_transLib.sml` | `182DABE3CDFD677E1EC8ED4DDD0E8EA3F6D6584D801CAE7F13EE01A203C5647F` |

Relevant declarations are `INT_NUM_CASES`, `NUM_OF_INT`, `INT_OF_NUM`, `INT_DIV`, `INT_DIV_UNIQUE`, `DIVISION`, `cv_Num`, and `cv_int_div_def`. They fix signed floor division and magnitude conversion. The proposed proof imports no custom axiom and contains no admitted proof. Successful elaboration and theory export remain for the parent's build.
