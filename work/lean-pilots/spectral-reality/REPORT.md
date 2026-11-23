# Actual completed chi4 reality pilot

This internal Lean pilot proves, for every real `t`,

```lean
SpectralRealityPilot.normalized_completed_chi4_real (t : ℝ) :
  ((4 : ℂ) ^ (((1 / 2 : ℂ) + Complex.I * t) / 2) *
    SpectralPilot.chi4.completedLFunction
      ((1 / 2 : ℂ) + Complex.I * t)).im = 0
```

The character is the existing `SpectralPilot.chi4`, imported from `CentralChi4`.
The completed function and complex power are the actual Mathlib definitions.
There is no extra phase, assumed root number, realness premise, spectral hypothesis,
or unnormalized-real-part replacement. `Audit.lean` also checks the exact `t=5/64`
specialization used by the positive-height pilot.

## Proof dependencies

1. `chi4_odd` and `chi4_inverse` follow from the existing exact character values.
2. `chi4_primitive` uses conductor divisibility by four. Conductor one contradicts
   nonprincipality. Conductor two contradicts oddness, since minus one equals one
   modulo two. The remaining bounded integer cases leave conductor four.
3. `chi4_completed_central_ne_zero` uses the already proved positive central
   `LFunction` value and the actual completed/gamma quotient identity.
4. `chi4_rootNumber` applies the primitive functional equation at `s=1/2`, uses
   self-duality, and cancels this nonzero completed value. Thus the root number is
   proved to be one without a separate numerical Gauss-sum computation. The
   imported central certificate is proved by the `LGrowth` integral and positivity;
   it does not depend on this functional-equation argument or the new reality theorem.
5. `chi4_LFunction_conjugate` proves conjugation on `Re(s)>0` using the actual
   `LGrowth.LFunction_eq_mul_Iint` identity, real partial sums, complex conjugation
   through the integral, and real-positive-base complex powers.
6. `chi4_completed_conjugate` uses the odd gamma factor `Gammaℝ(s+1)` and its
   conjugation theorem. Nonvanishing follows from positive real part.
7. On the critical line, conjugation of `s` is `1-s`. The functional equation and
   `4^((1-s)/2) * 4^(s-1/2) = 4^(s/2)` prove that the normalized completed
   value is fixed by conjugation. Its imaginary part is therefore zero.

## Validation scope

Only owned pilot modules are compiled, directly with installed Lean 4.35.0 and
`-j 2`, against existing read-only dependency artifacts. No Lake build, dependency
rebuild, heartbeat override, `native_decide`, custom axiom, or `sorry` is used.
No public frozen declaration is changed. Compile and axiom receipts are recorded
below. Final source compile passed without warnings in 43.448 seconds; the separate
audit passed in 44.279 seconds. Every listed helper and the final theorem has exactly
the axiom set `[propext, Classical.choice, Quot.sound]`.

Earlier draft logs are retained: two failed elaborations concerned tactic cleanup,
conjugation notation, beta reduction and numeral casts; one successful draft had
unused-tactic warnings; a cleanup attempt exposed an unclosed rational identity.
The final proof closes that identity with `norm_num`. These are author iterations,
not independent proof reviews.

This theorem proves reality, not positivity at a positive height, a zero-free
interval, multiplicity, or a finite-RH certificate. Those remain separate consumers.

## Frozen files and reproduction

All following hashes are SHA256. Paths without a prefix are relative to this directory.

| File | Hash |
|---|---|
| `Chi4Reality.lean` | `D1CFC512A3271DF46D961A2E5FAD0FA159CCBC974786CCBDFCEF7D4635555C21` |
| `Chi4Reality.olean` | `2B7CB69F4629E191553D9A3EEEAAE00649422DAC27C46553ACFF6267DE8460AB` |
| `Chi4Reality_20261111_234849.json` | `EF660255F18DA6D38145B9318D22B9D9D9CDEC5E3D416C7A64B70FBBA3A76367` |
| `Audit.lean` | `D6939EC80B57BD3E5734B6E8CF82FF3D1116223520CF273C56CAF342C7EC46E7` |
| `Audit_20261111_234941.log` | `B2E18CD27938EC6BC23B3630E7D7C7BD3B4F901A5203878842E185D258CA2346` |
| `Audit_20261111_234941.json` | `EFDA4A3CFF53779A1C06122E928EB76BD47F7CC39CC4EBF26568821BD7EDF47E` |
| `run_lean.py` | `6298E82F58010FCEFD15375FFCF829505ADBF96A2F6CDC7561B12561259EC4CA` |
| `../spectral/CentralChi4.lean` | `DADBA753B6475CD5ED9C48F0CC1312709F60DE8FCCF7291C5CC797A844A89D22` |
| `../spectral/CentralChi4.olean` | `B7FB59F14A902F4E4712DF2485EE9760D417CCAFFCB118252321FD38CC480607` |

Run from the workspace root:

```powershell
& 'work/qrh-campaign/interval-env/Scripts/python.exe' work/lean-pilots/spectral-reality/run_lean.py Chi4Reality
& 'work/qrh-campaign/interval-env/Scripts/python.exe' work/lean-pilots/spectral-reality/run_lean.py Audit
```

The runner invokes `C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe`
with `-j 2 -R <owned-directory> -o <owned-artifact> <owned-source>`.
Its `LEAN_PATH` includes this directory, `../spectral`, the existing integration
project artifacts, and existing package `build/lib/lean` directories. It does not
invoke Lake. Installed version is Lean 4.35.0, commit
`eb6cafb7290e8bd5f2937522d8d804f58f02bafc`.

Declaration locations: primitive at line25, root number at line53, completed/gamma
identity at line84, generic reality at line102. This author validation is separate
from the independent semantic review and integration's full closure check.
