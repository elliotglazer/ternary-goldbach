# Bounded Goldbach in Lean 4.35

The binary proof applies to every even integer from 4 through 21,408,506,880. The ternary proof applies to every odd integer greater than 5 through 21,408,506,883. It applies the binary theorem to `n - 3` and uses 3 as the third prime.

The two Lean files import the finite binary certificates in commit `f17b38415535507fe31ba15eba396ef7fbd863af`. The source and compiled public-object hashes of all project ancestors match their successful Lean 4.35 build receipts. The wrapper receipts record fresh native Lean compilation and the three standard axioms. Their timings cover the wrappers with existing input objects. The independent two-kernel benchmark through 10 billion is a separate result.

Run `python replay.py PATH_TO_CHECKOUT` with the pinned project's Lean toolchain installed and the pinned Mathlib available. This builds the production dependencies before it checks both statements. The repository's definitions `TernaryGoldbach.TernaryGoldbachUpTo` and `TernaryGoldbach.IsSumOfThreePrimes` expand to the proposition stated in the ternary file.
