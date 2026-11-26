# Bounded Goldbach through the second certificate band

At the commit and Lean toolchain specified in `receipt.json`, from the repository root, run `lake build +GoldbachBand02Prefix:olean`. The production source `GoldbachBand02Prefix.lean` proves that every even integer from 4 through 21,945,377,792 is a sum of two primes and prints its axioms.

Run `lake env lean PATH_TO/F17bBand02TernaryPrefix.lean` to check that every odd integer greater than 5 through 21,945,377,795 is a sum of three primes. The proof applies binary Goldbach to `n - 3` and adds the prime 3.

The receipt records source and compiled-object hashes for all 52 ancestors of the production binary join. It includes a fresh exact-source compilation of the last shard and the production join and a fresh check of the ternary corollary. Both theorems report `propext`, `Classical.choice`, and `Quot.sound`.
