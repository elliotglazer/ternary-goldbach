# QRH replacement research

The user asks to summon eight Astra agents and begin a QRH replacement proof for the PlattGRH hypothesis in calr3/ternary-goldbach, branch cde-moebius.

## Pinned target

Repository is ../ternary-goldbach relative to this directory, checked out at 23b2d68ca344203d4384e0aff7affa4ec034bef9. It is read-only for workers in this first research round. No AGENTS.md or CLAUDE.md was found in its tree. Lean and Mathlib are v4.35.0. No project dependencies have been downloaded here. Do not launch a full project build. The integration worker owns environment discovery and dependency setup.

The desired eventual result is the existing TernaryGoldbach.Statement, every odd natural n > 5 a sum of three primes, with only BinaryGoldbachInput as an external mathematical hypothesis. The large-case target is TernaryGoldbachFrom (10 ^ 27), with no PlattGRH. These targets are research objectives, not newly approved frozen declarations. Do not create draft anchors, modify existing declarations, introduce sorry or axioms, or treat assumptions of missing estimates as proof progress.

The existing final assembly has major-arc constant 1.049, minor-arc constant 1.0376 and margin 0.0114 x^2/kappa, at x >= 4.9e26. PlattGRH supplies Re(rho)=1/2 for primitive characters of odd conductor q<=300000 to height 1e8/q and even conductor q<=400000 to max(1e8/q,200+7.5e7/q). It also gives zeta RH to 1e8. The cde-moebius branch proves its Mobius profile using prime estimates still dependent on PlattGRH.

## QRH source

https://github.com/openai/math/blob/main/lean/OAI/NumberTheory/DirichletL/Nonvanishing.lean exports OAI.DirichletCharacter.LFunction_ne_zero_of_seven_eighths_lt_re for all positive moduli and characters, Re(s)>7/8, excluding the principal pole. It also exports the zeta version. The comparator config is lean/ComparatorChallenges/DirichletSevenEighths.json. This needs a pinned source and dependency assessment before import. The integration worker owns retrieving that source.

QRH alone gives Re(rho)<=7/8 and cannot supply equality 1/2. zero_sum_boundG in Explicit/ZeroSumGen.lean uses the equality in both the x^rho factor and Mellin bounds on the critical line. We seek a genuine replacement of estimates. Critical question is whether the numerical argument closes at 1e27, or requires more finite verification.

## Workflow

Read the applicable Lean workflow/proof/search skills. Workers own only their assigned directory under agents/. Use source citations with paths, lines and commit. Research notes and numeric scripts belong there. No central source modifications, dependency repins, commits, full builds, or nested agents. Report proved lemmas, compiled checks, numerical experiments and unproved mathematics separately. Internal generic lemmas are allowed in owned scratch files when their hypotheses are explicit and useful, but do not represent them as a discharged source-level obligation. Never introduce a hypothesis that simply restates the intended result. Coordinate shared requirements through the parent.

Provide a bounded first-round handoff with exact formulas, reproducible numerical checks where possible, sharp obstructions, next mathematical step, and required validation. Use whole sentences and avoid promotional claims. No closure claim without an independent review and actual term-level verification.
