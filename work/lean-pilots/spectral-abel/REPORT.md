# Finite Abel decomposition pilot

2026-11-11. Complete internal Lean proof and focused axiom check. No dependency build, source-cache edit, numerical L-function evaluation or new public frozen anchor.

`FiniteAbel.lean` compiles under the installed Lean4.35.0. The main theorem is `SpectralAbelPilot.LFunction_finite_abel` at line66, with precisely these hypotheses: q is a nonzero natural modulus, chi is a complex Dirichlet character with chi != 1, Re(s)>0, and natural N>=1. It proves

    chi.LFunction s =
      sum_{k in Icc 1 N} chi(k) * k^(-s)
      - psum chi N * N^(-s)
      + s * integral_{t in Ioi N} psum chi (floor_nat t) * t^(-(s+1)).

The function is the actual `DirichletCharacter.LFunction`; `psum` is the original `TernaryGoldbach.Explicit.psum`. There is no assumption of a tail formula, limit identity, finite-sum identity or numerical success. The integral is a complex Bochner set integral. The endpoint conventions are exact: finite k=1 through N inclusive; finite integral over (1,N]; tail integral over (N,infinity). N=1 is included.

The finite lemma `SpectralAbelPilot.finite_abel` at line19 proves the finite sum identity for an arbitrary complex coefficient sequence, using Mathlib's `sum_mul_eq_sub_integral_mul₀'`. An internal zero-at-index-zero sequence bridges its Icc0N convention to Icc1N without assuming chi(0)=0. The cpow derivative is established on t>=1 and its compact-interval integrability is proved from continuity. The main theorem then uses the actual LGrowth integral representation and its proved integrability, splits Ioi1 into Ioc1N and IoiN, and combines the identities. The negative boundary sign follows from this algebra.

## Validation and retained attempts

The final direct compile exited0 with no diagnostics in44.0929 seconds. The separate `Audit.lean` import/check exited0 in41.2030 seconds. Both theorem axiom closures are exactly

    [propext, Classical.choice, Quot.sound].

The source contains no `sorry`, custom axiom, `native_decide`, heartbeat override or extra theorem assumption. Tactics use ordinary checked terms. The axiom commands live in the separate probe rather than the proof module.

One initial shell attempt to call the WindowsApps `python` alias failed before starting Lean. The installed campaign Python then ran the first draft compile, which reported two ordinary elaboration issues: the Nat-to-Real-to-Complex cast in the finite Abel API needed normalization, and a subset lemma was supplied in the wrong form. Its42.0450-second log and failure receipt are retained. The wrapper also encountered a console-encoding error after writing that receipt; it was changed to UTF-8. The second source compile and separate audit both passed. No failed dependency artifacts were removed or rebuilt.

The runner invokes the installed executable directly with `-j 2 -R <owned-directory> -o <owned-olean> <owned-source>`. LEAN_PATH is the owned directory, the already validated integration artifact directory, and existing package `.lake/build/lib/lean` directories. It invokes neither Lake nor any dependency compiler. The new outputs are entirely within `work/lean-pilots/spectral-abel`.

Reproduction from the workspace root:

    work/qrh-campaign/interval-env/Scripts/python.exe work/lean-pilots/spectral-abel/run_lean.py FiniteAbel
    work/qrh-campaign/interval-env/Scripts/python.exe work/lean-pilots/spectral-abel/run_lean.py Audit

These are focused compilation wall durations on the shared host, not a full-library build or L-value evaluation benchmark. No final end-to-end timing estimate is inferred.

## Frozen handoff

| Owned artifact | SHA256 |
|---|---|
| FiniteAbel.lean | 98B68F87E5F4EB842E2B839C368F7066B958A6A266B3C42D995F576A3BD46310 |
| FiniteAbel.olean | CF847FC90C08F56287641D743697B685DD99596264D2EF4C0D75AC2FA3285123 |
| FiniteAbel_20261111_232309.json | 356F242FE08064957D79F7A280115F63B1CFDF70687AFB97EBBBA7EE17876AB3 |
| Audit.lean | C69897F910DBC09B7554449DD2847D84BC906E456590D17E1C0B97A23977EB9C |
| Audit_20261111_232403.log | B9B43357258C0A5750A0C288B47B583F3D6C6BE7B73941D3A6DFB7CAA2306DB7 |
| Audit_20261111_232403.json | DE1085F73CC32AC15205D07C80BFDC4BF599143D49629DFCB7E7886761F8D01C |
| run_lean.py | 48C6B5BC1C3208ECCF52B65D4312CCC516026F874B9941595680F566562BD85D |

Source dependencies inspected include `work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean`, SHA5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341, and its read-only cached olean SHA1F4140842770D4B6A8B9CFE93D724FF5C1B55111A2CAA57C5350BAEBE9EBB7FC. The pinned package's `Mathlib/NumberTheory/AbelSummation.lean` has SHABA9875F83280DCB6E92134D1560978A3C184031743FFD29D83B359CF93112FAA. The existing LGrowth success receipt records the installed executable and dependency provenance.

Integration can import `FiniteAbel` after adding this owned directory to LEAN_PATH. The remaining numerical spectral pilot is separate: this result gives the complete generic decomposition, but no quantitative tail norm, finite transcendental enclosure, sign certificate or zero-completeness claim. Integration owns the concrete chi4 specialization and its later evaluation proof.
