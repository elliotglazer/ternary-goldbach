# Independent review of the new 32-window psi pilot

Verdict: PASS as external finite computation and source-level certificate design. An independently written sieve reproduced every one of the 256 new subcounts, all 32 window counts and prime-list hashes, and the cumulative prime-list hash. It also rechecked the prior eight subcounts. Independent rational logarithm bounds and source-formula checks reproduced every cumulative theta bracket and centering margin. No mathematical correction is required.

This is a NEW review artifact. The prior frozen 104-chapter package excludes this later pilot and has not been modified. No Lean build, canonical edit, or new count theorem was produced. The computation does not prove the complete finite gap or validate the separate spectral estimate above its endpoint.

## Frozen inputs and independent method

The producer artifacts are under `agents/prime-estimates`, relative to `work/qrh-campaign`.

| Artifact | SHA256 |
|---|---|
| `RESUME_PSI_MULTI32_2026-11-11.md` | `0b8107a4d9a712cfd407ed13795f545ea47d1690e9385cee6cb017df74e706c4` |
| `resume_psi_multi32_20261111.py` | `b7357f709717760f9256c6f7e05037b2d1667cde9feaa735f83f02b8198cf1e7` |
| `resume_psi_multi32_20261111.json` | `03b835d97be31aeaa9e48d9ae1a3275bd033767be8e07efacae5118820151d5d` |
| `resume_psi_multi32_20261111.resources.json` | `6126f20df072f00dde33a53f5dc4e752ab834774489365f0149fc16d050f5f5e` |
| Prior `resume_psi_short_gap_20261111.json` | `e8065467be53708445486b2f5ea5cbbe408b3a014cf2d1fa8746ec999485f595` |

The independent script `review_psi_multi32_new_20261111.py` neither imports nor executes producer code. It constructs one contiguous sieve over `(10^9,1008283069]`, instead of the producer's separate full and odd arrays for each window. It generates the complete small prime base by trial division, parses the actual PS3 literal lists, and marks multiples using modular offsets. It then compares all recorded subcounts and hashes, reconstructs the rational grid and theta chain, and checks the logarithms in two ways. The script exited zero and wrote `review_psi_multi32_new_20261111.json` in this review directory. Producer and prior files were not rewritten.

The independent code uses the same elementary divisibility principle as any Eratosthenes sieve. Independence here means a separate implementation and full-data comparison, not a new theorem establishing the correctness of Python or a substitute for kernel checking.

## Exact range, counts, and partition endpoints

The new interval is `(1000250000,1008283069]`. It contains 8,033,069 integer positions and 387,673 primes. The new prime-list hash is

`dbbfb40436f79be0f3a6b2e82e91084c8bbed41b8c6c21611ee58eb9f189f382`.

The earlier first window contains 12,008 primes. Including it gives 399,681 primes over `(1000000000,1008283069]`, a span of 8,283,069 integer positions. The independent sieve reproduced the prior first-window hash as well as its eight subcounts, so continuity is not based only on trusting a seed count label.

Each stored subwindow represents the open-left, closed-right interval `(n,n+width]`. The review checks its starting point, width, count and adjacency, rather than only the sum of its counts. All 256 new subwindows have width at most 32768 and partition their 32 parent windows. Together with the prior eight subwindows there are 264 candidate count equalities. This matches the interval convention of the source `cnt3_spec` and `thS_sub`.

The independently reconstructed grid is `a_0=10^9`, `a_(i+1)=min(5*10^9,a_i+floor(a_i/4000))`. It has exactly 6439 windows. The new rows have indices 2 through 33, with `a_33=1008283069`. Thus there are 33 externally checked windows in total and 6406 remaining. The remaining integer span is 3,991,716,931. The full grid has 125271 subwindows after splitting at widths 32768; 125007 remain after these 264 candidates. None of these counts says that any new subwindow has been proved in Lean.

## Complete base and the square boundary

The exact integer square root of the final endpoint is 31753, and

`31753^2 <=1008283069 <31754^2=1008316516`.

Independent exhaustive trial division finds 3415 primes through 31753. Parsing the eight actual `PS3b` lists gives exactly the 3401 of them at most 31622. The 14 additional primes match the producer list exactly:

`31627,31643,31649,31657,31663,31667,31687,31699,31721,31723,31727,31729,31741,31751`.

Every sieved integer exceeds every base prime. A prime in the interval is therefore not marked, while every composite has a least prime factor at most 31753 and is marked. This establishes the completeness argument for the external sieve, including the final endpoint.

The producer correctly identifies a real failure of the old base. The integer `31627^2=1000267129` lies strictly inside the first new window `(1000250000,1000500062]`. The review checks that 31627 is prime, that no PS3 prime divides its square, and that the extended sieve removes it. Thus extending only the height hypothesis of the old PS3 primality characterization beyond this square would be false.

The required future formal step is a completeness proof for the 131 additional candidate integers `31622<n<=31753`, followed by a characterization using the genuinely enlarged base. `Nat.minFac_prime`, `Nat.minFac_sq_le_self`, and `Nat.minFac_dvd` then support the usual proof below the strict endpoint `31754^2`. The original `prime_iff_PS3` and `cnt3_spec` cannot be called unchanged.

The existing 66000-bit pattern length is sufficient for this bounded extension because `32768+31753=64521<66000`. The base patterns and their specification need extension, but `maskP_spec`, `orP`, and `pcL 7` need no new bit width. This claim concerns the bounded pilot only, not the eventual base through 70710 for the full gap.

## Source seed and exact logarithms

Source references are relative to `work/ternary-goldbach/TernaryGoldbach`, campaign pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

`Prelim/PsiSieveMain.lean:28149`, `stg2813`, contains the actual terminal `InvT` at `10^9` with numerators 999967635190289132 and 999970323068320645. `Prelim/PsiSieve.lean:418` defines `InvT` as a bracket for `thS`, and `SmallPsiTable.lean:216,249` gives scale `10^9` and the prime-log sum. Hence the seed used here is the theta bracket actually stated in the source; the public sieve theorem's strict endpoint does not remove that terminal invariant.

The review rebuilds the first-window update from these seed fractions, the independently recounted 12008 primes, and the prior log box. It obtains exactly the frozen prior theta fractions before processing any new window. No decimal approximation to a previous theta value is used.

For every new endpoint, the stored log box has denominator `10^9` and width exactly `20/10^9=2e-8`. The source checkers are `SmallPsi.chkStep` and `SmallMertens.chkLow`. Their formulas use the lower and upper exp(1) approximations 2.7182818283 and 2.7182818286, respectively; `T12` has terms of degree 0 through 11, and its upper remainder is `13*f^12/(12!*12)`. The review re-evaluates these exact formulas in Horner form and checks both inequalities. The existing soundness theorems have the required directions.

Independently, the review range-reduces each endpoint to `[1,2]` and bounds its logarithm by the positive atanh series with 48 terms and the rational tail

`2*z^97/(97*(1-z^2))`, where `z=(v-1)/(v+1)`.

It combines this with separately bounded log 2 and confirms that every stored box encloses the result. This uses no floating or Decimal logarithm in acceptance. The source and first-window boxes are checked by the same two methods.

## Cumulative theta centering

For each exact count c on `(a,b]`, monotonicity of log gives the sound recurrence

`L_b=L_a+c*lower_log(a)`, `U_b=U_a+c*upper_log(b)`.

The independent reconstruction matches every stored rational L and U, and every comparison with `b-b/24000` and `b+b/24000`. This checks centering itself, not merely the width of the bracket.

The smallest lower margin is at grid index 14, endpoint 1003505688:

`4981654870203/1000000000 =4981.654870203>0`.

The smallest upper margin is at grid index 31, endpoint 1007779118:

`51765997617559/750000000>0`.

The final exact bracket is

`L=126031491530669143/125000000`,

`U=1008254720038862887/1000000000`,

with width `2787793509743/1000000000`. All 32 new endpoint tests pass. These checked values support the already reviewed short-grid interpolation on the computed interval, conditional on the corresponding count/log proofs and the separately retained prime-power estimate. They imply no centering claim at a later unsieved endpoint.

## Resource claims and remaining proof boundary

I independently recomputed the integer resource counters: 20,889,317 marking assignments with repeated marks, and maximum payload 409765 bytes for the producer's simultaneous full, odd and base bytearrays. The latter explicitly excludes Python objects, lists, temporary slices, allocator overhead and RSS. The historical wall and CPU measurements are producer observations, not independently reproduced facts about that run. They are correctly described as Python timings and are not extrapolated to Lean or to the entire gap.

The external pilot is complete and independently reproduced. The next formal work is the extended-base completeness theorem, its count specification, the 256 new concrete count equalities, source-checker log equalities, and exact theta recurrence. The prior eight count equalities also remain uncompiled in this research campaign. The remaining 6406 grid windows have no counts supplied by this pilot. The separate analytic estimate beginning at `5e9`, its finite spectral certificates, and the final Goldbach theorem remain outside this review and are not established by these data.
