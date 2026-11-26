# Lean 4.35 source preflight and implicit arguments

AWS compiled twelve selected targets on the compact proof revision `e9f3c8ad`.
Their local import closure contains 193 GRH modules and 40 Goldbach modules.
The final compiler diagnostics list seven failed modules. None imports another
of the seven. Starting the next preflight with `Main` covers 601 additional
GRH modules before any of the expensive finite Goldbach computations.

| Module | First failing operation | Reproduction |
| --- | --- | --- |
| QuadField | Construct an embedding while the square root is unknown to the tactic | The full module checks with the quadratic Gauss sum specified. |
| AmaxStructure | Prove equality of two ring maps using an unspecified approximation | Naming the prime, approximation, divisibility witness, and intermediate algebra resolves both errors in the full module. |
| CongruenceLevel | Identify the principal congruence subgroup while the generator and the integral subring are unknown | The original and repaired definitions were compared in the finite-adèle setting. |
| ModuliPoint | Build a signed frame for a group action with an unspecified left factor | Using the input point’s frame checks in the complete module. |
| RightDerivatives | Export a derivative whose simplification referred to a private generated theorem | A public determinant equality supplies the rewrite. The complete module and seven axiom checks pass. |
| ExtendCharacter | Finish multiplicativity in an exact sequence | Rewriting the composite as scalar multiplication checks the complete theorem with reduced imports. |
| CocompactIntegrable | Apply the integral formula to one orbit | Supplying the subgroups and restricted sum bound checks in the full module. |

The same diagnostic had appeared in two earlier modules, RingActions and
MackeyFormula. Both repaired modules compiled in full. A scan of all 735
non-GRH sources singled out the call to `two_pow_dvd` in Saouter’s Theorem 2.
Its typed hypothesis supplies the missing information. The unchanged Paper,
ModPow, and Theorem2 sources compiled in 41.33, 40.67, and 55.56 seconds on
stock Lean 4.35.

Two external callers of `sum_comap` and one quotient-similarity caller passed
complete module checks. The Gauss-sum character call in Stickelberger’s proof
passed a focused test with the authentic helper type. The other
`embOfSqrt` call in AttachedDeterminant explicitly supplies the root.
Compiler checks and source inspections are identified separately in the
accompanying receipts.

The AWS receipt prefix records 29 errors spread across the seven modules.
The recovered 5d9a EBS archive now authenticates the complete error log and
the full receipt against the digest printed in the serial console. The
preflight took 719.21 wall seconds and 2,331.39 CPU seconds, with zero OOM
kills. The terminal record also lists each local target with a successful
Lake build line and the source hash at that revision. These results cover the source preflight.
The all-n theorem still needs a successful joint compile and both comparators.

The combined source revision is `d6b1bfd523e2c54b6e4bb72844deeddf8341879a`.
Five of the seven repaired modules passed complete native builds. The complete
character-index theorem and the CM congruence-level definition passed focused
checks. The Linux preflight builds all seven with their original imports.

An independent scan examined exposed definitions across all 794 GRH modules.
In the controlled QuadField test, the unchanged legacy source passed and the
converted exposed definition failed. The declaration-level compatibility
option let the tactic run but exposed a private simp theorem. Removing
`@[expose]` broke two definitional equalities elsewhere in the module.
Supplying the mathematical witness preserved both exposure and the original
proof of its square. The associated controls and search scope are recorded
here.
