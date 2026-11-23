# QRH replacement progress

The objective is the original ternary Goldbach theorem without PlattGRH, retaining BinaryGoldbachInput for the finite cases and the large-case threshold 10^27. It is not yet proved. There is not yet a complete quantitative strategy for all the remaining major-arc and finite-range estimates.

The target is calr3/ternary-goldbach, branch cde-moebius, commit 23b2d68ca344203d4384e0aff7affa4ec034bef9. Local work uses codex/qrh-replacement. Eight Astra workers have contributed research or independent review.

## What Lean has checked

Three new helper theorems passed compilation and axiom checks using Lean 4.35.0 and Mathlib 56a005855ea17e0b0958f73ec801ae140b0a1679. Each depends only on propext, Classical.choice and Quot.sound.

- QrhNumeric.lean contains qrh_low_exp_absorb and qrh_low_rpow_absorb. For x >= exp(35000), the latter bounds 1e24*x^(7/8) by 5e-5*x/(log x)^3. SHA256: 600b3f9f7e1cd2ff568ef4fce268d02b44357f4d8c1fc00ba2bdc5f4a003ce7b.
- QrhMellin.lean contains norm_mellin_lt_of_gaussian_envelope. The envelope 3.15*v*exp(-v^2/2) implies Mellin norm < 3.95 for 0 <= Re(s) <= 1. SHA256: a63e71f7521b781fc0cccecdef6af43f2297b0a915c273213b36887380f3cda0.

The source files and audit logs are beside this report. Copies in the local source branch match the recorded hashes. No new analytic prime estimate or Goldbach theorem has passed Lean validation.

## Principal-character numerical milestone

The proposed argument groups zeta zeros into conjugation/reflection quartets and controls their sum using positive weighted zero mass at s = 2. It targets the lower major-arc L2 bound, which is one part of the full proof.

A complete interval calculation checked all 2,750 finite-height cells. The largest certified ratio is 83.571300906, below the required 85. The calculation uses 128-bit Arb/Acb enclosures for algebraic Gauss nodes, weights and elementary functions, with explicit quadrature, truncation and interpolation errors. It completed in 52.43 seconds on one thread with exit 0. Independent source review found no mathematical defect in these error bounds. Root separately verified the exact cell sequence and hashes, and replayed every final cell inequality at 160-bit precision.

- Checker SHA256: 3f511989a4e0f9f4d9206ceaf5c61ccda80a30303c87484d6292b0cb42e57a67.
- Full cell-log SHA256: e81a9c76af44eb09c8e4fa04f03e360c3ba5e0ed0250daa7d8aa3f2da58116f1.
- Aggregate canonical cell-record hash: 06d59f3d77455c573f3ce4d52cfe381c5dc4a3307b40cd946f003aa102795ed7.

The principal-l2 directory contains the research derivation, checker, complete records and independent review. Analytic bounds handle heights outside [16,75], including a reviewed actual-smoothing bound below 80 for heights at least 250.

A separate exact rational calculation bounds the weighted mass below 0.07. The complete, uncompiled XiMass.lean draft uses a finite von Mangoldt sum >= 0.56945 and Euler's constant >= 0.576715 to obtain Re(xi'/xi)(2) <= 0.0698425. Independent source and arithmetic review passed.

Together, these ingredients support a proposed squared principal error below 8e-6 on delta in [-4,4], uniformly for x >= 4.9e26, assuming the global 7/8 QRH theorem. The mathematical reductions, certificate replay and final assembly still need Lean proofs. External Arb output must not become an axiom or an assumed premise. This computational milestone is not a Lean theorem.

## Other replacement drafts

An independent local route is intended to remove PlattGRH from two existing far-range prime estimates without needing QRH:

- Every nontrivial zeta zero has |Im(rho)| >= 2.39, using an existing integral representation and the functional equation.
- Zeros with |Im(rho)| <= 1e8 have Re(rho) <= 249/250, using the existing Stechkin inequalities and a new low-height estimate.
- A sharper zero-count bound is 3e10. Combined with Gaussian Mellin bounds, this produces low-zero error 3e10*x^(249/250).
- A shared explicit-formula draft is intended to preserve psi_range1_8 from exp(20000) and psi_asymp8 from exp(35000), while removing their Platt premises.

These drafts passed mathematical source review but remain uncompiled. Their eventual integration must preserve the existing public conclusions, constants and ranges. Removing these premises alone would leave other finite-range and major-arc uses of PlattGRH.

## Build checkpoint

The compiler was deliberately stopped when the user moved all eight agents to research for the Lean blueprint. There are 24 successful module receipts, through ZetaDatum. ZetaExplicit was interrupted and has no success receipt. No compilation was restarted during the blueprint phase.

The audited driver validates source hashes, complete artifact inventories, dependency receipts, compiler identity, options, package paths and the project manifest. It stages new outputs and publishes a success receipt only after a successful exit. Sixteen older outputs have explicit validated provenance; later outputs have generation receipts. Cached external packages remain read-only.

Any later restart must check the validated receipts and current resources first. Earlier concurrent compilation exhausted committed-memory headroom. An import-only Statement candidate remains uncompiled and unlanded.

## Research blueprint

The assembled research package is in ../qrh-blueprint/README.md, with an offline HTML edition, detailed chapters, a proposed dependency map, and leanblueprint-format LaTeX source. All eight researchers contributed. This is not yet a complete mathematical strategy: nonprincipal and mixed bounds, moderate prime/Mertens inputs, and the minor base-gap estimate remain open.

New minor-arc research gives a substantially easier sufficient energy target: T(x)<=.65*x*log(x). An exact rational replay of all nine numerical cells and the asymptotic envelope permits that coefficient after recomputing the coefficient-dependent values. A separate actual-smoothing QRH argument proposes Mellin constants172/566 and coefficient below.64621. Independent review found no mathematical defect in its paper derivation, conditional on the separately tracked global QRH strip and weighted-mass theorem; all small rational checks pass. It is not a Lean theorem. The prime-power error now has an independently reviewed unconditional paper derivation with coefficient7.2935825615541e-11<8e-11, including summability. All17 rational checks pass; its Lean assembly remains outstanding.

The primary corrected numerical package uses upper energy J<=10, major coefficient 1.0404, minor coefficient 1.0376, and nonprime reserve .00271. Its final positive reserve is .00009. Earlier exploratory budgets that spent the whole major-minus-minor difference on cubic error omitted the nonprime subtraction and are superseded. The package records exact coprime residual targets and their removal corrections. Its rational arithmetic was checked, but the analytic targets remain unproved.

## Full-goal obstacles

The direct base-gap branch now has an exact rational sufficient classifier covering49,034 reduced denominators, with the entire list independently reproduced. Five additional binned rectangles passed independent paper/source review, including the smooth denominator120120. These remain conditional on the Type I/II inputs. The source audit identifies ten producer interfaces still requiring full-domain replacements. The global totient research separates an elementary finite-range extraction throughq<=2^1000 from a proposed weaker remote-tail argument; no global replacement is claimed yet. See the latest blueprint chapters29--36.

- The major-arc cubic estimate still needs quantitatively sufficient nonprincipal averages and mixed fourth-moment control. Extending the new weighted-mass method alone does not fit these budgets. Explicit local zero information or another cancellation argument is needed.
- The new principal route addresses the lower major-arc energy. It does not establish the required upper energy bound or the cubic error bound.
- Finite-range prime, Mertens and Mobius estimates retain Platt dependencies. Exact integer replay suggests a relaxed Mobius profile would preserve a downstream constant, but the profile itself remains unproved.
- Raising the analytic threshold would leave a finite-coverage gap and would not meet the current objective.
- The public QRH theorem itself remains uncompiled here. The pinned source is openai/math 4eaee87548250b2682affda7d05d947c05554bae, using Lean 4.34.1. The public 7/8 theorem has a 2,943-module total closure; a smaller internal 23/24 provider has a 301-module closure but does not supply the exponent required by the principal route. Compatibility drivers have only been dry-run. External patched sources are isolated locally.

## Proof accounting

DRAFT_ANCHORS: 0
UNREGISTERED_SORRIES: 0 introduced by this campaign
DRAFT_IMPORT_VIOLATIONS: 0
SEALED_THIS_TURN: 0
CHECKED_HELPERS: 3

The goal remains active and incomplete.

