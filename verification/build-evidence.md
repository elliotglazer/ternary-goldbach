# Historical Lean 4.37 source replay, 25 November 2026

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

The CircleMethod port and its public consumer passed `lake build +TernaryGoldbach.MinorArcs.Montgomery` (18,298 jobs, including cached dependencies).

Focused public Lake targets passed for `ProfileTape16positive`, `ProfileTape1positive`, `ProfileTape1touching`, `ProfileTape2positive`, `ProfileTape2touching`, `ProfileTape4positive`, `ProfileTape8positive`.

The SmallPsi target passed in 17 seconds (18,292 jobs including cached prerequisites). A recursive finite sum is proved equal to the original Taylor sum. The imported 586-case check and the von Mangoldt bound each use the standard three axioms.

The public ScaledLiteral Lake target passed on the pinned dependencies.

The public SingularBase Lake target passed on the pinned dependencies.

The public ExpLookup Lake target passed on the pinned dependencies.

The Totient public Lake target passed on the pinned dependencies.

The TernaryGoldbach.Helfgott.Defs public Lake target passed on the pinned dependencies.

The ScaledEval Lake target passed with the pinned Mathlib strong induction recursor.

The SingularWindow Lake target passed after selecting the three nonnegative finite product comparisons.

The public SmallMertens Lake target rebuilt both the exported Taylor-sum equality and its majorant consumer.

## Compact GRH dependency metadata on Lean 4.35.0

The immutable community mirror reports root tree `5eb1240f03e791edd3fc7aa84a3a7d8dc3997b7f` and compact subtree `dba7a002d3863a6fdeeefe0528b1a232e732b8d5`. The upstream compact lockfile SHA-256 is `1390a02c1729c30db51ee0b19ea7199a129ed899ac571a48956da719573590ae`. The initial compact metadata commit c81ce0b6 included all nine upstream dependency records and a direct GRH dependency. The bundled package uses those nine records. The compact `src/Main.lean` declares the two names used by the Goldbach application. Full Lean 4.35 elaboration of that application remains pending.

## Source-bundled compact candidate

The compact upstream Main lacks a Lean `module` header. Lean 4.35 rejects importing such a module from the Goldbach module system. The local CompactGRH library declares Main and Statements as its roots and covers Lib and New. Its 794 files were checked against the port manifest, and its module names are disjoint from the 735 Goldbach module names. The project lockfile uses the nine upstream dependency records. The earlier external-GRH dependency was removed. Full elaboration on 4.35 is pending.

The joint worker validated all 794 packaged paths and converted hashes against `CompactGRH/source-manifest.json` using its source-manifest reader.
