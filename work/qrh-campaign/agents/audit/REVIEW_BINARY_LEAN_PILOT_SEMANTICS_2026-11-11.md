# Binary Lean pilot: independent semantic and kernel audit

Verdict: **PASS for the completed internal 64-target pilot**, at the exact source and object pins below. This is not approval of a new public frozen anchor, the full finite binary range, a production coverage strategy, or a runtime extrapolation. The current user-authorized pilot work permits an internal complete prototype; the separate public declaration/manifest approval remains outside this verdict.

## Exact target and binders

`work/lean-pilots/binary/BinaryPilot.lean:600` exports `BinaryPilot.binary_interval` with the exact type:

```lean
∀ n : Nat, 3999999997356523524 ≤ n → n ≤ 3999999997356523650 →
  Even n → ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ n = p + q
```

The independently reconstructed target is the 64 even integers in this closed interval. Its size is `(3650−3524)/2+1=64`, with the shared decimal prefix understood exactly as displayed above. Both primes are ordinary natural-number primes, and the equality is in `Nat`. No distinctness or ordering of the summands is demanded or silently supplied.

| Expanded input | Bin | Mathematical source |
|---|---|---|
| `n : Nat` | SOURCE | Arbitrary natural target in the explicitly proposed internal interval |
| lower bound | SOURCE | Inclusive lower endpoint 3999999997356523524 |
| upper bound | SOURCE | Inclusive upper endpoint 3999999997356523650 |
| `Even n` | SOURCE | Binary Goldbach claim for every even target in that interval |

Counts: SOURCE 4; STANDING 0; TYPING 0; RULED 0; EXCESS 0. There are no other implicit or instance inputs in the elaborated export. In particular, no source-mask, primality, anchor, coverage, `Fact`, or certificate-existence premise remains. The existential summands are outputs, not inputs.

## Source semantics and actual composition

I read the support and generated assembly, the certificate generator without executing it, and the decisive Mathlib Lucas theorem body. The support uses ordinary `Nat.Prime`; its `lucasNat` bridge at `BinarySupport.lean:8` transports exact `Nat.powMod` equalities into `ZMod p` and applies `lucas_primality`. That theorem proves primality from full order `p−1`, with a nontriviality check for every prime divisor of `p−1`. The generated file proves each factorization identity and each modular test in Lean, and recursively supplies the prime-factor proofs. Its base is `Nat.prime_two`. Generator-side factorization or primality proposals are not accepted as mathematical evidence.

`SliceCertificate` at support line 19 contains the actual source base/mask, anchor, source positive-bit primality proof, anchor primality proof, and exact origin connection. These are valid conditional helper inputs. Each concrete structure in `BinaryPilot` supplies their proofs; they do not leak into the final theorem. `sliceMask` at line 30 is the literal shifted low-width mask. `slice_sound` proves that each retained bit gives an actual pair of primes summing to the exact target. `unionMasks`/`union_bit` at lines 44/46 use finite bitwise OR, and `certified_tile` at line 58 applies the actual supplied source certificate selected by an OR bit.

The 12 concrete source slices per tile are assembled at `BinaryPilot.lean:584–598`. Both 32-bit OR coverage equalities are proved by reduction. The first tile starts at 3999999997356523524, the second at 3999999997356523588. Thus the first covers indices 0 through 31 and the second 32 through 63; there is no missed or duplicated even target at the seam. The final proof uses the parity witness to establish the exact quotient index in the appropriate tile.

Source masks are one-sided: a set bit must prove primality. Zero bits need no compositeness proof. The external trace explicitly lacks a formal primality certificate, but the pilot independently constructs all positive-bit and anchor proofs, so that trace label does not become an axiom. The generator-selected roots number 164, supported by 644 Lucas/Pratt nodes. This is one particular complete coverage word, not evidence that every production tile has the same size, reuse, or cost.

The literal project definitions (`SliceCertificate`, `sliceMask`, `unionMasks`, the finite prime lists and slice lists) match their source roles on their full declared carriers. There is no fallback actual-source definition or arbitrary choice used to replace the target predicate. Definition audit: BODY_MATCH OK; PUBLIC_CARRIER OK for these internal helper carriers; WELL_DEFINEDNESS N/A_LITERAL; CHARACTERIZATION N/A_LITERAL; CHOICE_INDEPENDENCE N/A; DEFINITION_VERDICT PASS at internal scope.

## Independent checks

The read-only `work/lean-pilots/audit/check_binary_source_binding.py` performed 145 exact checks against the original `b0-nearest-0` trace: all 12 masks, shifts, source bases, anchors, accumulated masks, both tile bounds/connections, root-set binding, and the complete even endpoint list. It performs no primality test or new coverage search. This metadata check supports provenance and geometry; the theorem's kernel proof supplies primality and coverage.

The separately owned transient `BinarySemanticProbe.lean` imported the completed `BinaryPilot` object and applied its export to the exact independently written type above. It also requested `#print axioms` for the final theorem, Lucas bridge, one concrete source-soundness theorem, and a large anchor theorem. Lean 4.35.0 exited successfully. Every printed axiom list was exactly:

```text
[propext, Classical.choice, Quot.sound]
```

There is no `sorryAx`, project axiom, or native computation acceptance axiom in this transitive closure. The probe used lowercase `-t 0`, which the actual executable's `--help` identifies as strict import trust checking. It is not uppercase `-T`, the allocation timeout option. My preliminary concern conflated those options and was retracted after checking the actual help. No heartbeat relaxation was found. The temporary Lean probe was deleted; its full text, command, hashes and output are retained in the receipt and log.

The probe's 16.7564-second wall observation includes strict checking/import and is **not** a standalone construction-time estimate. The author's separate complete-source measurement and any cost report require their own consistency review. No spectral claim is part of this binary verdict.

## Pins

All paths below are relative to the workspace root. SHA-256 values identify the exact inspected bytes.

| Artifact | SHA-256 |
|---|---|
| `work/lean-pilots/binary/BinaryPilot.lean` | `FF3C1F408E1E83C368DEF8788686731BD9A5323AFB0E6A40CE98837946FABEFD` |
| `work/lean-pilots/binary/BinarySupport.lean` | `690E5341CA663D37B93DDD3FAF37C115B80D0666A610D6D593AB3A629918F669` |
| `work/lean-pilots/binary/PilotPrimes.lean` | `6575142C02AFC8158631D43EB3C1CECB56AA8F690A13964A9A6338CBE7D7DE79` |
| `work/lean-pilots/binary/BinaryPilot.olean` | `6D8410A0EE3EF7CF03D53F40E85A940DD69833553245875EE59423E83AAE208B` |
| `work/lean-pilots/binary/BinarySupport.olean` | `BFCFEFB7108CCB22A7FC91273CBDAAB235DD797D822BBEB3223B146939FD3DE3` |
| `work/lean-pilots/binary/PilotPrimes.olean` | `0AE1DF9DD4B0DFCAE06F0AB75074E1326868CEE81DB10B9C5AC14627561154B8` |
| `work/lean-pilots/binary/pilot_manifest.json` | `0280C563EFE5D7FFA2273B81C96B399D8B8B8B90391275CC84AC4ADCB29D6347` |
| `work/formal-goldbach-bench/prime-cover/actual_trace.json` | `F073F27D03A88B84AA19825F7CF8BFC2E3028D4BF8F8843CE385B2A59ECFABC2` |
| `work/formal-goldbach-bench/native/pratt_certificates.json` | `E1ABF0B7A80C5DCBE872FFA38E444E2023D2E3E3338A8504E9F543DC1F53E0A5` |
| `work/lean-pilots/audit/check_binary_source_binding.py` | `3246DFFE42699C85591E79288875CF686B2008CCE90A8A2FE7A64E129F5FE642` |
| `work/lean-pilots/audit/binary_source_binding_receipt.json` | `954E663B8F0279B41704B848AD0F9B7420D737DC53C14461608E82E0D65BCD66` |
| `work/lean-pilots/audit/audit_binary_export.py` | `C21FF5F69870954FBB20733EA2CD33CC0DD2DB4428F40D6CD9EF454B54A9B456` |
| `work/lean-pilots/audit/binary_export_probe_receipt.json` | `53F77F6076373E1B156390629063DC1ACADACE14A73A555B6655D2CF1184E5D9` |
| `work/lean-pilots/audit/binary_export_probe.log` | `E34A28FB613EF6521F17514CE293007E5A3797FB96F3C29149E41504FBB0FA12` |

The executable hash and exact imported object hashes are also recorded in the probe receipt. Public manifesting/approval, full-range finite data, representative spectral certification, and provisional end-to-end cost conclusions remain separate obligations.
