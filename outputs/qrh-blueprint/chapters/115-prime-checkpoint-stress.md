# Bounded512-window stress test: first certificate failure

Date: 2026-11-11. This is a separate external research run after the frozen33-window pilot. The old pilot files and checkpoint contract were preserved. No Lean build, canonical edit, or full5e9 run occurred. The run was capped at512 new grid windows and200million new integer positions and stopped immediately on its first failed theta checkpoint test.

## Stop result and coverage

The fixed grid is b=a+floor(a/4000), and the unchanged checkpoint contract is theta(a) within a+/-a/24000. Starting from the frozen endpoint1008283069, the planned512-window endpoint was1145948545. The program stopped earlier:

| quantity | result |
|---|---:|
|new windows counted|505|
|new windows passing the tight checkpoint|504|
|first failed global grid index|538|
|last passing endpoint|1143659229|
|failed endpoint|1143945143|
|new integer positions visited|135662074|
|total positions after original1e9 seed|143945143|
|new primes counted|6522747|
|cumulative primes after original seed|6922428|
|new source-sized subwindows|4388|
|total windows externally counted|538|
|windows still without external counts|5901|
|new Lean count proofs|0|

The stop reason is `first_checkpoint_failure`, not either resource cap. Seven of the planned512 windows were not attempted. No further counts were generated after this failure. A separate arithmetic-only relaxation replay was subsequently authorized and is recorded elsewhere; it does not change the frozen tight-contract result.

## What failed, and what did not follow

At b=1143945143, the propagated exact theta enclosure is

    L=285974353129219719/250000000,
    U=571950915460383649/500000000.

Relative to b, this is

    -47730.483121124 <= theta(b)-b <= -43312.079232702,

conditional on future proof-producing validation of the externally checked count chain. The accepted radius for the unchanged contract is

    b/24000=47664.3809583333... .

The lower enclosure misses that target by

    L-(b-b/24000)=-49576622093/750000000
                 =-66.1021627906... .

The upper-side margin remains positive, exactly136464690286553/1500000000. The enclosure width is4418.403888422. Its midpoint error is-45521.281176913.

Thus the enclosure overlaps the permitted theta interval. The program records `actual_violation_forced_by_enclosure=false`. This is a failure of the current sufficient certificate test, not a demonstrated counterexample to the tight theta inequality, not a failure of E, and not evidence against the spectral route. Calling the midpoint the actual theta value would be unjustified. The actual theta value has only the displayed enclosure in this computation.

All earlier tight checkpoint tests in this chain pass. At the last passing endpoint1143659229 the lower margin is721994321573/500000000>1443.98. The calculation tested every endpoint and stopped at the first failure, rather than selecting a favorable terminal point.

## Count and logarithm verification method

The new script `resume_psi_stress512_20261111.py` pins the frozen multi32 JSON by SHA25603B835D97BE31AEAA9E48D9AE1A3275BD033767BE8E07EFACAE5118820151D5D and the initial one-window JSON by its previously reviewed hash. Before new counting it reconstructs all prior rational theta updates from the original stg2813 source seed, checks the prior endpoint grid, repeats the actual source rational log checks, and compares the resulting fractions with the saved bounds. Prior counts are not re-sieved in this run.

For the new windows it uses the same full-integer and independently indexed odd-only segmented sieves as the reviewed32-window pilot. All classifications are compared pointwise, including even numbers and interval endpoints. The complete base-prime list through the planned maximum square root is obtained both by Eratosthenes and by direct trial division using every candidate divisor; these lists must agree. Every(a,b] is partitioned into exact subwindows of width<=32768, with subcounts summing to the parent count.

The static base bound is33851 with3625 primes. The actual failed endpoint has square-root floor33822; the slightly larger static base is harmless because every sieved integer exceeds every base prime. Each composite has a factor in the list, and division by a larger base prime cannot remove a prime in the tested high interval.

Every new endpoint log box passed the actual rational `Small.chkLow`/`Small.chkStep` formulas. Boxes use denominator1e9 and width2e-8, inside the previously corrected1e-7 allowance. Decimal logarithms only propose boxes. Count accumulation and all theta comparisons use exact Fraction arithmetic. No floating approximation determines whether a checkpoint passes.

The JSON contains505 parent counts,4388 subcounts, all log boxes, exact theta fractions and margins, and per-window prime-list hashes. The cumulative new prime-list SHA256 is9129a5b83d638965804836e16f3e9c306098affa5a52a75e122cf8f433005b7d. It identifies the external output, not a Lean proof of the counts. The deterministic JSON is766049 bytes.

## The66000-bit pattern condition is crossed

There are two relevant notions of base bound; they must not be conflated.

First, the static base for the planned whole run has Pmax=33851. Already33851+32768=66619>66000. A Lean verifier using that one static base list for every block cannot use the old66000-bit pattern-length proof unchanged, even for the earliest block. A uniform pattern length70000 would satisfy the sufficient bound and has31718750 raw bytes for3625 precomputed masks, before Lean object overhead.

Second, if a verifier chooses only the base bound needed at each endpoint, the first failure of the conservative sufficient condition is global checkpoint398:

    endpoint1104604528,
    floor(sqrt(endpoint))=33235,
    33235+32768=66003>66000.

This event is recorded in the frozen JSON. It is a failure of that sufficient parameter inequality, not a statement that every possible implementation immediately produces a wrong count. If Pmax is instead the largest actual prime needed at that height, the corresponding inequality first fails at global checkpoint401, endpoint1105433188, where the largest needed prime is33247 and33247+32768=66015. Finite residual chunk widths or modular shifts may sometimes fit despite the conservative bound; a uniform proof should avoid relying on such accidents.

The program itself uses ordinary segmented arrays and does not invoke the source `pats3` masks, so it remains correct when the old mask-length interface becomes insufficient. Future formal replay must generalize the base-list completeness theorem and `orP_spec3` parameters and length, then prove the corresponding count specification. `maskP_spec`, `orP`, and `pcL_spec` remain usable generic ingredients. Merely changing a height premise on the existing PS3 theorem would be invalid.

## Measured work and preserved files

The separate resource record reports Python3.14.7,42.72979620000115 seconds internal wall time and42.546875 seconds process CPU time. It records353645108 full-sieve marking assignments, including repeated composite marks, and maximum simultaneous bytearray payload462723 bytes. The payload measure excludes lists, integers, temporary slices, allocator overhead and process RSS. These are external Python measurements only; they do not predict Lean runtime, proof size, or full-gap checking cost.

The run was launched through an interactive session and emitted progress every16 windows. The final process exit was0 after saving the explicit failed-certificate result. Exit0 means the program completed its specified stop protocol and internal checks, not that all checkpoints passed.

Frozen artifacts are `resume_psi_stress512_20261111.py`, `resume_psi_stress512_20261111.json`, and its separate `.resources.json`. The script has a read-only `--check` replay mode, but no such re-sieve was run after the coordinator froze the failure and prohibited further counting before review. The subsequent alternative-checkpoint script reads these existing fractions and counts only.

The original theta+/-a/24000 contract remains unchanged and this failed run remains visible. Possible next repairs include finer log weighting using the already stored subcounts or a separately reviewed sufficient checkpoint condition. Neither is silently substituted here. The full E target, remaining finite counts, spectral inputs, and Lean validation are still unresolved.
