# Native workload baseline for a finite binary Goldbach proof

Research estimate, 2026-11-10. No compiler, Goldbach computation, or modern benchmark was run. This estimates the native computation component of an efficient MM0 construction, not the cost of elaborating or checking its proof object.

## Recommended planning number

For a modern, carefully optimized **CPU** implementation of the sieve-and-cover approach through `4e18`, use **100 physical-core-years centrally, with a broad 30–300 core-year range**, before MM0 proof-generation/checking overhead. These are assumed performance scenarios, not measured modern results or a lower bound. A GPU or a substantially different covering algorithm requires a separate estimate.

The native workload should enter the overall estimate as

    total work = native work + proof generation + proof checking + certificate I/O.

If generation/checking is summarized by a multiplier F relative to native work, write `100 F core-years`, with uncertainty in both factors. Setting F=1 merely because MM0 has a small or fast kernel is unjustified. A theorem verifying an algorithm does not by itself certify an arbitrary untrusted execution or permit its output to be asserted.

## Historical observations from the primary paper

Oliveira e Silva, Herzog and Pardi report about **770 one-core CPU-years**. Their production sieve used a modulo-30 wheel and assembly; near `1e18`, it took **8.7 cycles per odd integer** on a **2.83 GHz Core2 Q9550**, versus **10.5** on a **2.20 GHz Athlon64**. Minimal partitions plus statistics cost **9.707** and **8.226 cycles per even integer**, respectively. Work units covered `1e12` integers and took eight hours in 2001, versus about forty minutes in 2012. The original code was 32-bit; the authors expected only a few-percent gain from a 64-bit port.

They also recorded prime residue-class counts, partition and gap statistics, and checksums. Independent checking data took **20+10 core-years**. They duplicated the range through `3e17`, selected exceptional intervals, and about 4% of remaining intervals. The paper does not give a clean exclusive timing breakdown or unambiguously itemize these costs within the headline total. [Primary paper, sections 1.1–1.3, pp. 2038–2042](https://www.ams.org/mcom/2014-83-288/S0025-5718-2013-02787-1/S0025-5718-2013-02787-1.pdf); [accessible copy inspected](https://denisevellachemla.eu/empirical-verification-of-the-even-CG.pdf).

## Normalization calculations

There are approximately `2e18` target even integers. Using 365.25 days per year, the reference-machine cycle counts give the following extrapolation:

    sieve:       2e18 * 8.7   / 2.83e9 / 31557600 = 194.8 core-years
    partitions:  2e18 * 9.707 / 2.83e9 / 31557600 = 217.4 core-years
    sum:                                          412.2 core-years.

This extrapolates the local rate near `1e18` over the whole range and excludes unspecified extra work; it is not a reconstruction of the campaign's accounting. The second reference processor gives approximately 539.4 core-years. Independently, `4e6` work units times forty minutes equals about 304.2 core-years. These cross-checks explain why the headline heterogeneous total is a poor single-machine benchmark.

The central modern scenario assumes aggregate throughput improvements of **3 times for sieving** and **6 times for the coverage phase** relative to the Q9550 measurements:

    194.8/3 + 217.4/6 = 101.2 modern core-years.

The factors include clock rate, processor execution improvements, layout/vectorization, and avoiding unnecessary output; they must not be multiplied by those effects again. The coverage factor is more optimistic because the required output is only existence.

| Assumed scenario | Sieve throughput factor | Coverage throughput factor | Derived native core-years |
|---|---:|---:|---:|
| Conservative optimization | 2 | 2 | 206 |
| Central | 3 | 6 | 101 |
| Aggressive CPU implementation | 8 | 20 | 35 |

Widening these scenarios to 30–300 allows for parameter sensitivity, unsaturated per-core rates, and additional native bookkeeping. It is a planning range, not a confidence interval. It excludes failed implementations and generic per-integer primality testing, which could be much slower.

## What existence-only verification can save

An implementation can maintain a coverage bitset for a block: each certified prime `p` marks numbers `p+q` with certified prime `q`. It needs to certify that every target bit is covered, not which representation has the smallest `p`. Missing positions receive a fallback search. At block boundaries, the algorithm must include the necessary prime halo and explicit ownership of each target even integer.

This permits eliminating partition histograms, first-occurrence searches, gap moments, residue-class statistics, and most result storage. Word-wide shifted-bitset unions can be considered. However, replacing an indexed representation array with a boolean bitset alone does not guarantee a large speedup: it changes memory traffic, introduces bit operations, and can make repeated writes more expensive.

Within the same full-sieve architecture, completely eliminating the coverage phase would improve the reference two-stage total by only

    (194.8+217.4)/194.8 = 2.12 times.

That is an architecture-specific sanity check, not a universal lower bound: a sparse certified-prime covering method might avoid a full sieve. Such a method must be benchmarked at the high endpoint, where prime certification and interval startup differ from small examples.

The separately described historical cross-checks are a modest fraction of 770 years, not an explanation for orders of magnitude. Moreover, an MM0 proof must replace their assurance with actual certified computation; simply removing all checking does not produce a proof. Do not subtract their timing twice when starting from the two-stage cycle model, which already excludes unspecified extras.

## Conversion to wall time and the necessary pilot

At perfect scaling, the central native estimate is approximately 1.6 years on 64 physical cores, 143 days on 256, or 36 days on 1024. Divide by achieved efficiency, for example 0.7, to account for contention and idle time. These numbers exclude proof overhead. A physical core is not a hardware thread, and shared memory bandwidth can prevent linear scaling.

The informative pilot is an endpoint block near `4e18`, not the initial range near zero. Measure native time, proof-generation time, serialized proof bytes, MM0 checking time, and peak memory separately. Use a block large enough to amortize startup, then repeat with several block sizes and concurrent workers. Extrapolate from certified target integers per second, retaining startup and storage costs.

A pilot block of width `1e12` has `5e11` even targets and represents one four-millionth of the full computation. The central native model predicts roughly thirteen minutes per such block per core. That is a testable budget assumption, not an observed performance claim. An efficient proof architecture might stream many such block theorems and combine them with a short interval-coverage theorem. Whether its output/checking cost is close to native work remains the dominant unanswered MM0 question.
