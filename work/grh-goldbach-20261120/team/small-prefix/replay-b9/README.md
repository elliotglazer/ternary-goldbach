# Finite binary Goldbach in Lean

Each `PowerK.lean` proves that every even natural number between 4 and 10^K inclusive is the sum of two primes. There are nine independently compiled prefix theorems, for K from 1 through 9. Each proof includes the case 4 = 2 + 2. The separate axiom audit of all nine returned `propext`, `Classical.choice` and `Quot.sound`.

## Measurements

Each row measures a fresh local Lean 4.35.0 process using `-t0 -j1 -M3000` on Windows x86-64, against cached Mathlib and compiled support. CPU time includes user and system time. The producer runs before Lean. The native column times a second implementation which sieves the large summand and checks all even targets.

| Inclusive bound | Even targets | Dedicated Lean build, CPU seconds | Lean elapsed seconds | Independent native scan, CPU seconds |
| ---: | ---: | ---: | ---: | ---: |
| 10 | 4 | 8.27 | 8.34 | |
| 100 | 49 | 9.88 | 9.90 | |
| 1,000 | 499 | 11.67 | 11.92 | |
| 10,000 | 4,999 | 11.19 | 11.32 | |
| 100,000 | 49,999 | 12.39 | 12.50 | below clock resolution |
| 1,000,000 | 499,999 | 13.25 | 13.29 | 0.016 |
| 10,000,000 | 4,999,999 | 19.00 | 18.90 | 0.047 |
| 100,000,000 | 49,999,999 | 37.64 | 35.72 | 0.53 |
| 1,000,000,000 | 499,999,999 | 174.66 | 151.00 | 9.47 |
| 10,000,000,000 | 4,999,999,999 | | | 145.63 |

For 10^9 the producer used 13.53 CPU seconds including writing the source. Building the four reusable checker modules used 47.86 CPU seconds. Together with the 174.66 CPU seconds for the concrete theorem, that gives 236.05 CPU seconds, about 0.066 core-hours on this machine. This accounting starts with compiled Mathlib, PrimeSupport, PrimeBitmap and Table. The separate nine-theorem axiom audit used another 12.14 CPU seconds. Peak memory for the billion-bound build was 2.22 GiB. The compiled theorem module occupied 18,479,016 bytes.

## How Lean verifies the range

The source table maps bit index i to the small odd number 3 + 2i. The producer chooses some of these bits and splits them into segments. In each segment Lean proves that the marked numbers lie below (d+1)^2 and that their product is coprime to d!. A composite number in that range would have a prime factor at most d. The certificate only needs to establish primality of marked entries.

Each interval supplies a short list of odd prime anchors. Lean checks anchor primality in batches, using a modular inverse of the fixed factorial modulo the product of the proposed anchors. In the initial interval the anchors already belong to the certified source table. Shifting the source bits by the anchor offsets and taking their bitwise union marks all even sums they represent. Lean checks that every required bit is set. The interval theorems join at exact endpoints.

For 10^9 this takes 23,418 small source primes and 258,685 anchor occurrences across 3,815 intervals. Eight intervals per reduction kept memory within the configured limit. The final row stops at the requested even endpoint. `Controls.lean` checks that the verifier rejects a composite source entry, an empty cover and a damaged modular inverse.

## Replaying the source archive

Extract the ZIP, install the toolchain named in `lean-toolchain`, and run the following commands from its root. The Mathlib manifest pins commit `56a005855ea17e0b0958f73ec801ae140b0a1679`.

```sh
lake exe cache get
python replay.py --power 9
```

The replay script rebuilds the project's support and the selected prefix, then prints the axioms of its theorem. Use `--upstream` to include the supplied original `TernaryGoldbach/Statement.lean` and its typed adapter. This file comes from commit `23b2d68ca344203d4384e0aff7affa4ec034bef9` of calr3/ternary-goldbach. The generated proofs and their Python producer require no NumPy. The optional independent native scan uses NumPy.

```sh
python generate.py 8 --out regenerated
python scan.py 8 9 10
```

The archive includes the Lean sources, exact dependency pins, benchmark receipts and recorded axiom output. The certificate producer supplies integers and proposed witnesses. Lean proves their mathematical meaning from the ordinary library definitions.
