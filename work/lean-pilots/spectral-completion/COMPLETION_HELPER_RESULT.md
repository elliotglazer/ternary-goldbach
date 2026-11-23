# Positive-height completion helper

Date: 2026-11-11. Status: compiled internal prototype, not a new approved campaign anchor.

The actual Gamma factor at the first positive coarse-grid height is enclosed without an assumed
Gamma box or a numerical Gamma oracle. `GammaEnclosure.lean` proves, for

```
G = exp(I * ((5/128) * log(4/pi))) * Gamma(3/4 + I*(5/128)),
```

that `G.re >= 3/4` and `|G.im| <= 1/4`. The expression inside the phase exponential is the
cast of a real number. All Gamma and exponential functions are the actual Mathlib functions.

The proof uses `Real.convexOn_Gamma`, the recurrence, and the convergent Euler integral.
Convexity gives `16/15 <= Gamma(3/4) <= 4/3`, `Gamma(1/4) <= 4`, and `Gamma(5/4) <= 1`.
The global bound `|log x| <= x^(1/2) + x^(-1/2)` follows from `Real.two_mul_le_exp`.
The vertical Gamma perturbation is at most `25/128`. The phase perturbation is at most
`(5/384)*(4/3)`, giving total distance `245/1152 < 1/4` from the real `Gamma(3/4)`.
Every integral comparison and rational inequality is checked by Lean.

`CompletionFactor.lean` defines `samplePoint = 1/2 + I*(5/64)` and proves the exact identity

```
4^(samplePoint/2) * Gammaℝ(samplePoint+1)
  = exp(log(4)/4 - 3*log(pi)/4) * G.
```

The scale on the right is the cast of a positive real number. The exported helper
`SpectralCompletion.completed_product_positive` states that for an arbitrary complex `L`,
`L.re > 1/4` and `|L.im| < 1/2` imply positivity of the real part of
`4^(samplePoint/2) * (Gammaℝ(samplePoint+1) * L)`.
This is a composition helper: its L-box premises must be discharged by the separately proved
actual Dirichlet L-value. It does not assert that the full spectral pilot or its reality proof
is finished. Integration owns the actual character, completed-L identity, L box and reality.

## Checked artifacts

| File | SHA256 |
|---|---|
| `GammaEnclosure.lean` | `1CCA415D6FA64E24F052F0426C36BB68A373E30166F9234C61A5C7D11DD7B920` |
| `CompletionFactor.lean` | `F1BF6D24853A20EE9524E839907E8B2C8ABCA270148435B9A3A465743E805359` |
| `GammaEnclosure.olean` | `44E872A63EC3006FB97D4DE93293C1B923032DFC4C530032B68CDE490E767B41` |
| `CompletionFactor.olean` | `A85208E246EC6CF876FEC3BEB79DE3D68AEB6EB1C021C843E39B8CECA9179843` |
| `AuditProbe.lean` | `748D04408FD918265F245AB2A43878A045C7E8DD19C20C74EAF8A06F5D5D74A5` |
| `run_lean.py` | `723A427287DC510C0B4D62068F577C01A3FDAF5DDCCDC4DBFF4D36AA66B0D1BB` |

The exact-type probe independently instantiates the closed box and fully unfolds the sample
point, phase and scale in the completion identity. `#print axioms` for the closed Gamma box,
factor identity and positive-product helper reports precisely
`[propext, Classical.choice, Quot.sound]`.

## Validation and timing scope

Direct installed Lean 4.35.0, single worker, `-t 0` trust level, ordinary default heartbeat and
recursion limits; read-only cached dependencies. No dependency builds, `native_decide`, custom
axioms, `sorry`, proof-emission shortcuts or canonical source changes. The lowercase `-t`
option is the trust-level option, not a timeout override.

| Successful command following `lean.exe -j 1 -t 0` | Wall seconds | Process CPU seconds | Receipt |
|---|---:|---:|---|
| `-o GammaEnclosure.olean GammaEnclosure.lean` | 27.6975654 | 27.4375 | `run-1794468668032363500.json` |
| `-o CompletionFactor.olean CompletionFactor.lean` | 24.3310515 | 24.15625 | `run-1794469666459402700.json` |
| `AuditProbe.lean` | 23.5301795 | 23.265625 | `run-1794469707148746200.json` |

Each matching `.log` retains the actual output. The first command constructs the Gamma proofs;
the second constructs the adapter proofs while importing the compiled Gamma helper. The probe
is an import/type/axiom check, not a second construction measurement. These wall times include
strict imported-module checking and process overhead, and cannot be treated as pure kernel
cost or extrapolated to a full spectral certificate. Earlier exploratory failures are preserved.
An initial runner decoding failure was repaired by explicitly selecting UTF-8; it is not a
successful proof run. Minor tactic/linter suggestions in the successful Gamma log are not
axioms or unproved goals.

All writes are confined to `work/lean-pilots/spectral-completion/`. The completed binary pilot
is unchanged. This helper is handed to the integration worker for the actual unconditional
positive-height export, and to the independent source and semantic auditors.
