# Bounded continuation: next32 short-gap windows

Date: 2026-11-11. Scope: external research computation only. No Lean build, canonical edit, or full5e9 run. All frozen one-window artifacts were preserved. This note records32 additional grid windows after the independently reviewed first window and supplies concrete candidate data for later proof-producing replay.

## Result and exact range

The continuation covers

    (1000250000,1008283069],

with32 steps b=a+floor(a/4000), namely original grid windows2 through33. It visits8,033,069 integer positions and finds387,673 primes. Together with the prior first-window count12008, the externally checked range after the source seed contains399,681 primes. There are33 externally checked windows in total and6,406 of the original6,439 windows still without counts from this campaign task. None of the new counts is yet Lean-validated: there are still zero new Lean count proofs. The total externally computed span from the original seed is(1000000000,1008283069], containing8,283,069 integer positions;8,033,069 is only the new continuation span.

Every one of the32 cumulative theta checkpoint tests passed:

    a-a/24000 <= L_a <= theta(a) <= U_a <= a+a/24000,

where the middle enclosure is conditional on formal validation of the exact finite counts and the source-checker log bounds. The external arithmetic checks all succeed. These are computed enclosures propagated from the actual source seed, not an inference from the small width of the enclosure alone.

The smallest lower-side margin occurs at grid endpoint14, a=1003505688:

    L_a-(a-a/24000)=4981654870203/1000000000
                   =4981.654870203>0.

The smallest upper-side margin occurs at endpoint31, a=1007779118:

    (a+a/24000)-U_a=51765997617559/750000000
                   >69021.3301567.

At the final endpoint1008283069 the exact enclosure is

    L=126031491530669143/125000000,
    U=1008254720038862887/1000000000.

These are approximately1008251932.2453531 and1008254720.038863. The final bracket width is2787.793509743, compared with the original source seed width2687.878031513. Cumulative rounding and coarse per-window log weighting have therefore not consumed the checkpoint margin during this bounded pilot. This does not establish centering at later checkpoints.

## Frozen prior seed and reproducibility

The script reads `resume_psi_short_gap_20261111.json` and checks its exact SHA256 E8065467BE53708445486B2F5EA5CBBE408B3A014CF2D1FA8746EC999485F595 before using it. That prior window has an independent review at `moebius/RESUME_PSI_SHORT_GAP_REVIEW_2026-11-11.md`.

The source seed is still `SieveTab.stg2813`, `Prelim/PsiSieveMain.lean:28149`, with the true theta(10^9) bounds

    999967635190289132/10^9 <= theta(10^9)
                           <=999970323068320645/10^9.

The continuation does not merely copy a rounded theta result from the previous report: it recomputes the first-window rational update from these source fractions, count12008, the source lower log bound20723265833/10^9, and the prior checked upper log bound at1000250000. It checks that the resulting exact fractions equal the frozen prior output, then continues the same recurrence.

Files are `resume_psi_multi32_20261111.py`, deterministic `resume_psi_multi32_20261111.json`, and separate measured `resume_psi_multi32_20261111.resources.json`. The script supports `--check`: it recomputes the bounded calculation, compares the complete deterministic result with the saved JSON, and does not modify either output. The read-only replay exited0. Default generation mode writes these new multi32 files only. A rerun's wall-clock measurement is not expected to match the frozen resource measurement bit-for-bit.

The deterministic JSON is46498 bytes. It contains each exact interval, count, source-sized subcounts, successful log box, rational theta bounds, rational margins, and prime-list hash. There are256 new source-sized subwindows, each of width at most32768. Including the prior8 subwindows gives264 concrete candidate count equalities for all33 pilot windows.

## Completeness and independent representations inside the external calculation

The final endpoint has exact integer square root31753. The script builds all primes<=31753 in two ways:

1. Eratosthenes on every integer through31753;
2. direct trial division of each candidate n by every integer2 through floor(sqrt(n)), without using the first prime list.

Both lists agree and have3415 entries. It checks31753^2<=1008283069<31754^2 and that all sieved integers exceed the largest base prime. Hence every composite in the tested interval has a factor in this complete base list, and every prime in the interval survives division by it.

For each(a,b], the first segmented sieve uses a byte for every integer n=a+1+i and marks multiples starting at ceil((a+1)/p)*p. The second independently indexes only odd integers, computes the first odd multiple by a different floor/adjustment formula, and advances by2p. It uses the independently constructed prime list. The script compares the resulting prime/composite classification at every integer position, including even numbers and both interval edges, not merely the total count. It also checks every subwindow count sums to its parent window count.

This catches representation and boundary errors within the external program. It is not a substitute for a formal proof of the sieve and does not expand Python's trust into the final Lean theorem. The two sieves use the same mathematical divisibility principle, so agreement is not an independent theorem about the correctness of that principle; the mathematical completeness argument above remains necessary.

The cumulative newline-separated ASCII prime-list SHA256 for the32 new windows is

    dbbfb40436f79be0f3a6b2e82e91084c8bbed41b8c6c21611ee58eb9f189f382.

Hashes identify the computed data. They are not count or primality proofs.

## An actual source interface problem: the old base list fails immediately

Unlike the first pilot window, this continuation cannot reuse the unchanged PS3 list. The prime31627 was absent from PS3, which contains primes only through31622. Its square

    31627^2=1000267129

lies inside the first continuation window(1000250000,1000500062]. A sieve using only the old PS3 primes would incorrectly retain that square. Merely widening `prime_iff_PS3`'s height premise past this square would be false.

The complete base extension for this bounded continuation consists of14 primes:

    31627,31643,31649,31657,31663,31667,31687,
    31699,31721,31723,31727,31729,31741,31751.

For later proof-producing replay, prove a finite completeness theorem for the extra list on31622<p<=31753 and combine it with the existing `mem_PS3`. This needs only131 extra candidate integers, but their classification still needs kernel verification. `Nat.minFac_prime`, `Nat.minFac_sq_le_self`, and `Nat.minFac_dvd` then give the prime/no-base-factor characterization up to the strict height31754^2=1008316516, which exceeds the continuation endpoint.

The existing pattern length66000 is still sufficient:32768+31753=64521<66000. Thus no larger-bit pattern or wider popcount is required for this bounded pilot. The `orP_spec3` proof must be parameterized or copied with modulus bound31753; the base list must actually be extended; the count function must use the extended patterns. `maskP_spec`, `orP`, `pcL 7`, and the generic `pcL_spec` remain the same underlying constructions. After proving the new count specification, each of the256 candidate count equalities can be kernel-checked separately and combined by finite interval-card addition.

This is a small source-interface change relative to the eventual full70710 base bound, but it is substantive. The new count data cannot be certified by calling the existing `cnt3_spec` unchanged. No source declaration was edited during this task.

## Actual source-checker log bounds and cumulative theta arithmetic

At every new endpoint b, the script proposes rational log endpoints with denominator10^9 and width20/10^9=2e-8, below the corrected1e-7 allowance. Decimal logarithms are only candidate-generation hints. Acceptance evaluates exactly the existing rational formulas:

    EHpow(a)*[T12(f)+f^12*13/(12!*12)] <= b,
    b < ELpow(a)*T12(f),

using upper exp(1) approximation2.7182818286 and lower approximation2.7182818283. These match `Small.chkLow` and `Small.chkStep`; their existing soundness theorems yield the log inequalities. The script repeats the corresponding checks for the source seed log interval and the first-window endpoint. Every one of the32 new endpoint boxes passed. This bounded task therefore produces successful boxes, unlike the full-gap design, which only specifies a width ceiling.

For each window(a,b] with certified candidate count c, update

    L_b=L_a+c*lower_log(a),
    U_b=U_a+c*upper_log(b).

Each summand log p belongs to that interval for a<p<=b. All bounds and comparisons use exact Fraction arithmetic, including the checkpoint target b+/-b/24000. There are no floating-point accept/reject decisions. The deterministic JSON records reduced rational strings for every theta bound and margin, so an independent reviewer can reconstruct the complete chain without accepting the author's script.

## Measured workload, not Lean timing

The first complete run's separate resource file records Python3.14.7 on the supplied host:

- Wall compute time1.4871516000021074 seconds and process CPU time1.46875 seconds.
- Independent base construction0.03379029999996419 seconds.
- Both sieves, pointwise comparison and hashing1.4374131000004127 seconds.
- Exact new log checks0.008409900012338767 seconds.
- Full-sieve marking assignments, counting repeated composite marks:20,889,317.
- Maximum simultaneous bytearray payload409765 bytes.

The bytearray figure excludes Python lists/integers, temporary slice payloads, allocator overhead and process RSS. It is not a measured peak process-memory claim. The tool's process launch/collection overhead is also outside the internal wall timer. No Lean runtime, proof-term size, or full-gap wall-clock estimate is inferred from these numbers. Exact kernel evaluation of large natural bit operations has a different execution and memory model from Python bytearray slices.

The read-only `--check` replay also exited0 and reproduced the entire deterministic output; its separate transient timing was not written over the frozen first-run resource record.

## Status and next proof-producing boundary

This pilot confirms cumulative theta centering for32 more windows and exposes the precise base-prime extension needed immediately after the first window. It provides256 concrete count candidates and32 successful rational log boxes. A future Lean task can now target the finite extra-prime completeness theorem, generic extended count specification, and those bounded count declarations without discovering new numerical targets first.

The remaining6,406 grid windows have not been counted by these pilots. No new count has been proved in Lean. The proposed spectral estimate starting at5e9 remains a separate conditional research result and is not validated by this computation. The full envelope E, and hence the original final Goldbach theorem with10^27 and the original BinaryGoldbachInput, are not claimed complete.
