# riemann-hypothesis

[![checks](https://github.com/Deicyde/riemann-hypothesis/actions/workflows/checks.yml/badge.svg)](https://github.com/Deicyde/riemann-hypothesis/actions/workflows/checks.yml)

A [Comparator](https://github.com/leanprover/comparator) setup for the Lean formalization
claiming a proof of the Riemann Hypothesis and of GRH for Dirichlet L-functions, announced on
2026-11-20 at <https://alpo.ge/remark.pdf>.

The submission ships no challenge file that imports only Mathlib and no Comparator config.
This repository is the submission, unmodified, plus those two files:

- [`src/Challenge.lean`](src/Challenge.lean) imports only Mathlib and states the five theorems.
- [`comparator.json`](comparator.json) is the Comparator config. The solution module is the submission's `Main`.

Everything else we wrote is in [`verification/`](verification/NOTES.md).

## Status

| Check | Result |
|---|---|
| Source is identical to the published tarball | pass (CI) |
| Challenge compiles against Mathlib alone | pass (CI) |
| No `sorry`, `axiom`, `native_decide`, `unsafe`, `implemented_by` or `opaque` in the source | pass ([scan](verification/static-scan.txt)) |
| All nine dependency pins are official upstream commits | pass ([notes](verification/NOTES.md#dependencies)) |
| **Comparator** (statements match, axioms, kernel replay, nanoda) | **running**; the build takes hours |

## The statements

`riemannHypothesis : RiemannHypothesis` uses Mathlib's own definition. The other four theorems
use four short definitions that `Challenge.lean` copies from the submission's `Statements.lean`:

- `riemannZeta_eq_zero_re`: RH again, written out.
- `LFunction_ne_zero_of_half_lt_re`: L(χ, s) ≠ 0 for Re s > 1/2, for every modulus and every
  Dirichlet character, except the trivial character at s = 1.
- `LFunction_eq_zero_re`: every zero of every L(χ, s) with 0 < Re s < 1 has Re s = 1/2.
- `LFunction_eq_zero_re_of_isPrimitive`: the same for primitive characters.

"GRH" here means Dirichlet L-functions only.

## Running Comparator

The project is on Lean `v4.33.1`. `lake comparator` and its paranoid mode need Lean 4.35 or
later, so this uses the standalone Comparator at its `v4.33.0` tag. With the
[tools](verification/NOTES.md#tools) built under `$TOOLS`, this is the command we run from the
repository root:

```bash
lake exe cache get    # Mathlib's official build cache; the only step that needs the network

TC=$HOME/.elan/toolchains/leanprover--lean4---v4.33.1/bin
systemd-run --user --pipe --wait --collect \
  --property=RestrictAddressFamilies=~AF_UNIX \
  -p PrivateNetwork=yes -p ProtectSystem=strict -p ProtectHome=tmpfs \
  -p BindPaths="$PWD" -p BindReadOnlyPaths="$HOME/.elan" -p BindReadOnlyPaths="$TOOLS" \
  -p PrivateTmp=yes -p NoNewPrivileges=yes \
  --working-directory="$PWD" \
  -E PATH="$TC:/usr/bin:/bin" -E HOME="$HOME" \
  -E COMPARATOR_LANDRUN="$TOOLS/landrun/landrun" \
  -E COMPARATOR_LEAN4EXPORT="$TOOLS/comparator/.lake/packages/lean4export/.lake/build/bin/lean4export" \
  -E COMPARATOR_NANODA="$TOOLS/nanoda_lib/target/release/nanoda_bin" \
  "$TC/lake" env "$TOOLS/comparator/.lake/build/bin/comparator" comparator.json
```

The first line of flags is the invocation from Comparator's README. The `-p` flags are extra
isolation; [the notes](verification/NOTES.md#sandbox) say why they are needed. Comparator
compiles all 175,187 files itself, which takes hours and about 100 GB of disk; read
[the build notes](verification/NOTES.md#building) first.

## Limits

- Comparator checks the challenge and the solution against the same Mathlib, so it cannot
  detect a modified Mathlib. The pin here is Mathlib's official `v4.33.1` tag.
- A passing run still trusts the Lean kernel and nanoda, Mathlib's definitions, Mathlib's
  official build cache, and the sandbox.

## License

The submission belongs to its author and was published without a license. It is mirrored here
unmodified, for verification only.
