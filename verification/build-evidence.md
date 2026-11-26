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

## Lean 4.35.0 package routing and challenge

A fresh checkout of source commit `831a43890890f06e179f8e1d893e971a4647641d` used the stock Windows Lean 4.35.0 release and local checkouts matching all nine lockfile revisions. `lake --no-build query +Main:lean +GoldbachSolution:lean +GoldbachChallenge:lean` resolved the compact `Main` to `CompactGRH/src/Main.lean` and the challenge and solution to their corresponding package-root files. The compiler accepted `GoldbachChallenge.lean` with the expected warning for its trusted statement placeholder. Full solution elaboration and exported-proof kernel verification remain pending.

## Lean 4.35.0 analytic compatibility

The stock 4.35.0 compiler accepted the full `Totient` and `AtanCertificate` modules against pinned Mathlib. The totient proof uses the prime divisibility lemma and induction-case label from that release. The arctangent proof imports the derivative of a power. The audit of `arctan_enclosure` reported `propext`, `Classical.choice` and `Quot.sound`.

The compiler accepted four complete compact modules in focused builds with pinned dependencies. These were `Lib.General.LinearAlgebra.Base`, `Lib.General.Analysis.OstrowskiTaussky`, `Lib.General.Analysis.HolomorphicIntegral` and `Lib.General.Algebra.AdicRingHomExt`. The HolomorphicIntegral build took 305 seconds on the test machine after its module header gained `import all Mathlib.NumberTheory.Padics.Measure.Basic`. Its proof text matches the previously bundled version.

A focused 4.35.0 test reproduced the strong-induction step from `ScaledEval` with its dependent index bound. The compiler rejected the case label `ind` and accepted `h`. The full `ScaledEval` module still needs a 4.35.0 build.

Lean 4.35 compiled the complete generated numerical certificate in
`ProfileG1R12N1Data.lean` after exposing the six table helpers consumed by
its public definitions and privately importing `Init.Data.Array.Basic`.
Its five interval segments passed kernel reduction. The resulting
`ProfileG1R12N1.checked12` depends on `propext`, `Classical.choice`, and
`Quot.sound`. The same source repair covers 33 generated profile files and
698 named helpers. It preserves the certificate literals and proof bodies.
The full solution and its exported kernel replay remain pending.

The 657 entries in `ProfileG3R21N1.checked21` are checked in 14 adjacent
intervals, using the existing `Checked.join` theorem. The original single
check hit a 2,560 MiB process limit. The split proof compiled under a
1,024 MiB limit in 24.75 seconds on the same local Lean 4.35 installation.
It proves the same statement and uses the same certificate inputs.

Stock Lean 4.35 compiled the full Landau module in 16.85 seconds. In the
factorization proof the rational function is written as its finite-support
product. In the logarithm argument the ball's connectedness follows from
convexity. Both changes are inside proofs, and all theorem statements retain
their original types.

In `ValuationPair`, Lean 4.35 now compiles the full source without warnings.
A fresh import reports exactly `propext`, `Classical.choice`, and `Quot.sound`
for `U.map`, `U.mem_range_map`, `U.continuous_map`, `U.det`, and
`U.form_mul_inv_eq`. The same default tactic remains available on the
two declarations that use it.

Stock Lean 4.35 compiled the full HHFourier module in 30.84 seconds. The
proofs of `memLp_Kc` and `memLp_etaO` now pass the null-measurability
of the integration interval to `memLp_indicator_iff_restrict`.

## November 25 compact GRH build repairs

The AWS joint build exposed failures in the modular port. Local stock
Lean 4.35 compiled the full repaired ZpowSum, ContinuousCocycles, and Frames
modules. A fresh import of Frames reports the standard three axioms for
`IsSignedFrame.mul`. The original DiscreteUnits and ArtinDefs call sites
also elaborate against the new ContinuousCocycles object in focused checks.

The SemisimpleReps and MackeyFormula proof changes passed focused checks
of the residual goals. The CompactDualMeasure change moves the default
hypotheses onto their declarations. All three full modules require replay.
The joint proof and protected comparator remain pending.

Stock Lean 4.35 also compiled the full repaired RingActions module without
warnings and the original 243-line DiscreteUnits module against the repaired
ContinuousCocycles module. The export audit for DiscreteUnits reports only
the standard axioms. In MajorEnergy, AWS reported that `gcongr` had closed
the goal at line 49 before the next tactic ran. The redundant tactic has
been removed for the next source replay.

The original run reached its cgroup's memory pressure threshold while all
eight Power10Block modules were compiling. The package schedules those
eight modules in four pairs using Lake library dependencies. Their Lean
source, proof terms, and imports are unchanged. Other finite and analytic
modules retain their ordinary scheduling. Hosted timing remains pending.

Two further GRH modules use section-level tactic defaults of the same
kind. A focused Lean 4.35 test reproduced the Magnitudes error at the
original unqualified call to `nat_le_of_hasLogBound`. Attaching the
existing default to each comparison lemma resolved it. BumpConvolution
now attaches its original continuity default to the convolution declarations.
Both modules are inputs to Main and require full-module replay.

In the same diagnostic run, 32 simultaneous Lean jobs reached the raised
152 GiB memory threshold. Several GoldbachBand05 shards used about 5 GiB
RSS each. The package now also groups the later heavy finite modules in
sets of at most four. All four earlier Power10 pairs retain their previous
ordering. The schedule covers 384 finite modules and only changes the
Lake build graph. It preserves every Lean source file and all 415 finite
modules have a unique library owner.
