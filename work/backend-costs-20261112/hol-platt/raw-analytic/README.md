# Raw integer pairs to complex multiplication

Status: prepared source, not built. No HOL process, dependency build, numerical evaluation or benchmark was run for this task. These proposed theorems are not yet reported as kernel-accepted.

## Exact interface

`RawPairRoundScript.sml` defines the internal theory `RawPairRound`, without changing existing theories or TG declarations.

    pair_value g (a,b) = (real_of_int a / real_of_int g,
                         real_of_int b / real_of_int g) : complex

    four_product_round s (ur,ui) (wr,wi) =
      (round_scaled s (ur*wr-ui*wi),
       round_scaled s (ur*wi+ui*wr))

The operation has four exact integer products, one subtraction, one addition and two calls to the existing `BlockRound.round_scaled`. No intermediate product is rounded. Signed and zero coordinates are allowed and there are no magnitude assumptions.

The main theorem `four_product_round_error` has only positive integer-scale premises `0 < g` and `0 < s`. Its conclusion is

    modu (pair_value g (four_product_round s u w) -
          pair_value g u * pair_value s w) <= 1 / real_of_int g.

The actual source expands `u,w` into their four integer coordinates. The companion `four_product_coordinate_errors` bounds each absolute coordinate error by `1/(2*real_of_int g)`. Thus the intended state grid `g=2^120` and step grid `s=2^122` give modulus error at most `2^-120`; an instantiation must prove these scales positive.

HOL's existing complex multiplication and Euclidean `modu` are used. The latter is not replaced by a different norm.

## Actual proof content and limits

- `round_scaled_real_residual` transports `BlockRound.round_scaled_residual` through the existing order-preserving integer-to-real embedding, yielding absolute residual at most `s/2`.
- `round_scaled_real_error` divides by positive `s` and proves a half-unit rounding error for the literal quotient `(2*r+s)/(2*s)`.
- `round_scaled_coordinate_error` also divides by the independent output grid `g`.
- `pair_value_exact_product` proves that the exact four-product integer pair on grid `s*g` denotes the actual complex product.
- `four_product_coordinate_errors` applies the proved rounding result to both actual product numerators.
- `modu_le_coordinate_sum` derives the coordinate-sum upper bound directly from the existing square-root modulus and `SQRT_MONO_LE`. The final theorem adds the two half-unit bounds.

There are no output-shaped error premises, placeholder proofs, new axioms or oracle calls. Complete ordinary tactic proofs are written, but their parsing and execution remain unvalidated. The first build must check mixed integer/real notation, integer-to-real simplification, and the field and square-root proof scripts. Writing the scripts does not establish their acceptance.

The modulus estimate deliberately uses the weaker coordinate-sum bound rather than a square-root-of-two refinement. It suffices for the present recurrence rounding allocation.

`RawStateHandoff.raw_mul` has the same polynomial numerators and divisor `5316911983139663491615228241121378304 = 2^122`. This helper deliberately does not import the handoff theory. Later integration must prove the definition equality and instantiate this theorem. No such imported equality is claimed here.

This proves rounding only. It supplies no enclosure of `exp(-i*(5/64)*log x)`, no enclosure of `x^(-1/2-it)`, no recurrence-source theorem and no L-function or sign result. Source uncertainty remains separate.

## Dependencies and inspected availability

Direct ancestors are `BlockRound`, `intreal` and `complex`. `BlockRound` already depends on `StageCheck`, `integer` and `list`; `complex` depends on `real` and `transc`. Proof libraries are `realLib` and `RealField`. Their arithmetic/field tactics construct ordinary proofs.

Checked source APIs include `real_of_int_num`, `_neg`, `_add`, `_sub`, `_mul`, `_lt`, `_le`; `COMPLEX_RE_IM_EQ`, `complex_mul`, `complex_sub`, `complex_add`, `complex_neg`, `RE`, `IM`, `modu`; `ABS_DIV`, `ABS_NEG`, `ABS_REFL`, `ABS_BOUNDS`, `REAL_LE_LDIV_EQ`, `REAL_POW2_ABS`, `SQRT_MONO_LE` and `POW_2_SQRT`. `RealField.sig` exports both tactics used by this file.

Installation inspected:

    work/backend-costs-20261112/hol4-setup/
      HOL-1de64f8521b4758508bd875fbaf11d1768261b92

`hol4-setup/.hol/objs/BlockRoundTheory.uo` exists. No `realTheory.uo`, `intrealTheory.uo`, `transcTheory.uo` or `complexTheory.uo` was found in that checkout's `sigobj`, `src/real/.hol/objs`, `src/real/analysis/.hol/objs`, or the corresponding flat source directories. The required sources exist. No missing dependency was built. A separate authorized installation/build step is required before compiling this helper.

API correction: `complexTheory.COMPLEX_TRIANGLE` is the polar identity `modu z * (cos(arg z),sin(arg z)) = z`, not a triangle inequality. The present proof does not use it.

## First root command

Run this only in the existing Linux HOL environment, from the repository root. The checks intentionally fail on the current missing-dependency snapshot. `--no_prereqs` prohibits an accidental dependency build. This command has not been executed.

```sh
cd work/backend-costs-20261112/hol-platt/raw-analytic
setup="$(cd ../../hol4-setup && pwd -P)"
hol="$setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92"
set -eu
test -f "$setup/.hol/objs/BlockRoundTheory.uo"
for name in realTheory intrealTheory transcTheory complexTheory realLib RealField; do
  found=no
  for directory in "$hol/sigobj" "$hol/src/real/.hol/objs" \
                   "$hol/src/real/analysis/.hol/objs" \
                   "$hol/src/real" "$hol/src/real/analysis"; do
    if test -f "$directory/$name.uo"; then found=yes; break; fi
  done
  if test "$found" != yes; then
    echo "Missing prebuilt dependency: $name.uo" >&2
    exit 2
  fi
done
"$setup/run.sh" "$hol/bin/Holmake" --no_prereqs RawPairRoundTheory.uo
```

Root should supply a fresh log/receipt name and record source/imported-object hashes using the existing runner convention. Generic theorem build time is not a numerical-throughput measurement. After acceptance, inspect the exact exported type and assumptions before joining the handoff.

## Source pins

SHA256 values observed during preparation:

| Input | SHA256 |
|---|---|
| `BlockRoundScript.sml` | `FF267EC688BDC4A4065DE0BD14D3BC109F60F2A0D86F99FAE89646D4212EF143` |
| `BlockRoundTheory.uo` | `13C336BFBF87AA3F7A581C15FD67EE33BD515A6FCCA0BBFAFAFEB2C0FC11A134` |
| `src/real/intrealScript.sml` | `BE5129D70712350B8EB694BA25910DFB81EA4D12659E2DFED8E78D2A1CF293F5` |
| `src/real/realScript.sml` | `46FFADCD4C9BCF9BBC67EE464AF001FFE6ACAFFF70FCA3660F4308152DADD66F` |
| `src/real/analysis/complexScript.sml` | `8ECCC7980AC18D66CECE52D203A973E6DB945EF6994465CC4CDE3701BFE28B2E` |
| `src/real/RealField.sig` | `219F9005221FC6C350DF5092F0304275A706B9B1C782A20EAF055105638480E7` |

Only new files in this owned directory were written. One attempted Python text-edit command failed to launch the Windows alias, running no Python and producing no proof artifacts; ordinary text operations performed the edits. The interrupted README write left no file; this document was then created after resumption.
