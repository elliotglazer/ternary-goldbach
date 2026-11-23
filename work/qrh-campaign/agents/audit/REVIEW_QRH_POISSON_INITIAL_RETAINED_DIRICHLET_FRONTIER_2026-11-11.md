# Review of the Poisson, initial-sieve, retained-window and Dirichlet synthesis

2026-11-11. **PASS for bounded source-research synthesis. No mathematical or scope correction requested.**

Reviewed [the coordinator synthesis](../../../qrh-blueprint/QRH_POISSON_INITIAL_RETAINED_DIRICHLET_FRONTIER_2026-11-11.md), SHA256 `0E6771676433E60D6622A15DC112BB3BDB15B4D466BDC6EF2DA87665996FAB50`, against all ten author/reviewer reports identified in its evidence table. Their ten hashes match. This review does not establish a compiled proof, a transitive axiom closure, or a validated global QRH provider.

## Mathematical and source checks

The original-Poisson summary preserves the distinction between the standard Fourier transform and the paper-normalized transform. Its covolume factor, conjugated trace frequency, positive radial Jacobian, and final K/|c|² prefactor agree with the reviewed identities. There is no second insertion of 4/3. Its account of finite Gauss transformation does not infer nonzero or unit norm merely from that transformation. The additional Z^(-D) in the squared-row identity, actual summability before rearrangement, and fixed finite prime-pool scope remain explicit. This advances the original-Poisson dependency of the initial cubic argument without claiming the specialized quadratic principal/error estimates.

The selected scalar summary preserves the actual theorem's quantifier order and restrictions. I reread `QuadraticSieve/PoissonConstants.lean:562` and its output-constant construction: the old sieve exponent, positive eta, derivative orders, seminorm data, B, C1 and profile are fixed before the varying scales and ideal. In particular, K>=1 is an independent premise. The nine allowances total 99921; the nested degree losses give 4*8*8+3=259, followed by the separate divisor loss to 260. Arbitrary nonnegative constants in the scalar inequality are not promoted to proven analytic estimates.

The initial-cubic summary keeps the exact finite carriers, arbitrary complex coefficients, unit ideal and zero-row cases. It uses cancellation only for a nonempty off-diagonal active support. Its distinct diagonal estimate, fixed nonnegative cutoff and finite ideal count correctly produce a fixed C0*(M+N²) bound. The ideal-row and full-element-row adapters are not identified with one another. I reread `CubicSieve/Majorant.lean:17–57`: the geometric bound applies for M>0, N>=1, with constant proportional to (M/N²)^(-3). It therefore gives no uniform assertion as M tends to zero. The 317-module header count remains dependency evidence, not proof-body coverage.

The retained-window statement matches `Inversion/InitialRetainedWindow.lean:21` through its quantified conclusion. Degree, tree factor and clipping threshold precede q; the positive constant and scale threshold follow q but precede the source, scale exponents and modulations. The exact parent, support and slot conditions have not been replaced by a weaker informal domain. In particular, eta>=0 and the upper bound on tau are preserved without inventing tau>0. The 4eta transport cost, subsequent 2delta<=6eta and final substitution yielding 15eta are consistent with the reviewed normalization. Rereading `Descent/CanonicalRankMoments.lean:20–31` confirms the adopted terminology correction: it is a quantified bound predicate on `normalizedColumnEnergy`, not that energy's definition. Four lower-rank inputs and their separate production remain visible.

The Dirichlet summary preserves the actual character and twist, including imprimitive Euler factors and the six-to-one generator normalization. I reread `Hecke/Dirichlet.lean:128–179`: continuation is on the complement of {0,1}; the ordinary endpoint theorem handles Re(s)>=1 with its pole exclusion; only 7/8<Re(s)<1 uses the Hecke product. No claim that norm pullback preserves nonprincipality is needed. Modulus one and the library's totalized zeta value at one are accurately distinguished from removal of the classical pole. The common-probe production is not proved by this export bridge, and the cached-versus-pinned Mathlib version mismatch remains disclosed.

These source checks supplement the detailed bounded arguments in the ten reports. They do not extend their lower cuts to every declaration in each hashed file.

## Independent byte reconciliation

All 150 Lean source-table entries match current bytes. The entry counts, retaining duplicates, are 17+0+22+0+22+3+32+0+27+27 in the order of the synthesis evidence table. Provider paths resolve under `work/openai-math/lean/OAI/NumberTheory/DirichletL`; the two cached Mathlib entries retain their separately disclosed location and version.

I also independently reconciled the three pinned receipts against their actual referenced files:

| Receipt | Entries reconciled | SHA256 |
|---|---:|---|
| Original Poisson | 17 Lean files plus 1 manifest | `941FD75E93083431826B090BCF6F58E9937DB0E1A3D7B079977F6614B3AB2DBB` |
| Retained window | 32 Lean files plus 12 supporting reports, then 2 extra Lean files | `871A799CA6AEB22F2284DD19CE61E85AA318DA4A079FE99AD37A9DAA835252B9` |
| Scalar review | 22 Lean files plus 3 artifacts | `882E851A12C15D1A8A569B17383C08EFF57BF1B94F97705D1FD98911FB6F5E1A` |

The counts describe repeated evidence entries, not distinct theorems proved. No author numerical script was rerun, and no analytic value was evaluated.

## Status boundary

The remaining positive-band, specialized quadratic, local-character/Gauss and detector/source inputs are not erased by this consolidation. General library foundations remain conditional on compatible kernel validation rather than being turned into a demand to reprove all Mathlib. Provider compilation/axioms, finite spectral evidence, formal prime/head replay and revised consumer assembly remain separate unfinished work.

The synthesis changes neither the unconditional target `TernaryGoldbachFrom (10^27)` nor the full statement's original inclusive `BinaryGoldbachInput` through 4e18. It introduces no replacement final premise or changed spectral reserve. The phrase that the inventory is under review describes the synthesis snapshot: its independent planning review subsequently completed. That timing update does not alter any mathematical conclusion or require mutation of the frozen inventory.

Only this new review was written. No Lean declaration, build, dependency change, frozen-artifact edit, or analytic evaluation was performed.
