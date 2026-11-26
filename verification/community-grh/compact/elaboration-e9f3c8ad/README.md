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
| ExtendCharacter | Finish multiplicativity in an exact sequence | The original source leaves a goal after simplification. |
| CocompactIntegrable | Apply the integral formula to one orbit | The original conversion leaves subgroup arguments undetermined. |

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
The full log and receipt remain on EBS. The attached diagnostic record
identifies the bytes available on the serial console and the digest required
to authenticate the full receipt. These results cover the source preflight.
The all-n theorem still needs a successful joint compile and both comparators.
