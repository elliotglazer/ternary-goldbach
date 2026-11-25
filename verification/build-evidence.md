# Local source replay, 25 November 2026

Lean 4.37.0-rc1, Mathlib 31ce06eaadf4a200c0e1407c5f10953cf606b8f8. The source project used the committed Lake manifest and a local cache of Mathlib and its dependencies.

| Lake target | Exit status | Lake jobs including cached prerequisites |
| --- | ---: | ---: |
| GoldbachChallenge | 0 | 1275 |
| +FastHex | 0 | 4 |
| +GoldbachNatPowMod | 0 | 4 |

GoldbachChallenge emitted the expected warning for the trusted theorem stub. GoldbachSolution and the full Comparator check are pending. The historical Lean 4.33.1 proof used a different GRH release.

The verifier must take its challenge module and comparator configuration from an independently pinned copy. Their SHA-256 digests below allow comparison with the independent statement handoff.

- `GoldbachChallenge.lean` — `f9e6190b4c77c9bf474c6d36748278af41140237432fff72e8084a4c572a382a`
- `comparator.json` — `073582e85645abd6e5949deb0531c11797ac9c1266073bf913b02d86173ebdcb`

The public EtaCirc port passed `lake build +TernaryGoldbach.MajorArcs.EtaCirc` on the same pins. Lake built PlancherelReal in 4.2 s and EtaCirc in 5.2 s, reporting 6,518 jobs including cached prerequisites. EtaCirc emitted two unused simp-argument warnings. Its source SHA-256 is `96347ec4fd98799d540929ab590fa734b5b7041c70e162c46eae603eca4d562f`.

The public RectResidue port passed `lake build +TernaryGoldbach.Explicit.RectResidue` (5,998 jobs including cached dependencies). Lake built Landau in 6.2 s and RectResidue in 4.3 s. A separate source replay checked the three Saouter modules, LadderCheck and LadderToQuadrillion. The transitive axiom list for `LadderToQuadrillion.gapCover` is `[propext, Classical.choice, Quot.sound]`.
