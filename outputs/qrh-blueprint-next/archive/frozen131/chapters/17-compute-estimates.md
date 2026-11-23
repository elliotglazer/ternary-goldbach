# Estimating certificate checking and Lean build time

Correction, 2026-11-11: the numerical Lean-versus-MM0 ranking in the earlier conversation is withdrawn. No comparable optimized certificate implementations or representative benchmarks established that ranking. The historical scenarios below are arithmetic illustrations of unsupported assumptions, not current planning estimates. In particular, neither 2,500 core-years for Lean nor a larger MM0 extrapolation establishes the runtime of an efficient implementation.

Lean's kernel directly evaluates supported natural-number arithmetic, while MM0 checks explicit derivations. This can affect computation and proof-file costs, but it supplies no established speed ratio for a shared-block Goldbach certificate. Both systems can use mathematical compression, shared primality information and proved checker correctness. The concrete run still needs checked evidence. See [Lean natural numbers](https://lean-lang.org/doc/reference/latest/Basic-Types/Natural-Numbers/) and [Carneiro's MM0 paper](https://arxiv.org/abs/1910.10703).

Core-hours measure cumulative CPU time. Build time usually means elapsed wall time. They coincide only approximately for one continuously busy core. Every estimate must identify hardware, Lean version, checker, input sizes, and whether dependencies are already built.

## Measure the right work

Separate five quantities:

1. External search and certificate generation.
2. Lean elaboration and proof construction.
3. Kernel checking, including computation performed by reduction.
4. Serialization, import, and file I/O.
5. The shared library and analytic-proof build.

A normal Lean build can interleave elaboration and kernel checking. Measure their total first; only assign separate phase times when a profiler or controlled replay actually isolates them. An independent kernel replay is an additional validation run, not free work already included in the initial build.

For a standard-axioms-only result, untrusted external programs may generate hints, but the resulting proof must establish their correctness. `native_decide` is not a way to estimate the same acceptance path: the official tactic documentation states that it uses an additional axiom. `decide +kernel` checks by kernel reduction. See [Lean tactic reference](https://lean-lang.org/doc/reference/latest/Tactic-Proofs/Tactic-Reference).

## A workload model

Partition the intended computation into input classes j, with N_j blocks in each class. Measure representative block CPU time c_j and memory m_j. Then estimate total CPU work as

    W = W_shared + sum_j N_j*c_j.

Measure both fixed per-file overhead and marginal cost as block size grows; a tiny block dominated by import time is not representative. Classes should cover numerical bit lengths, ordinary and difficult certificates, and low and high endpoints. Certifying only a high-end sample does not verify coverage of the full domain; the sample is for performance estimation only.

For P physical cores, CPU work alone gives the lower bound W/P on wall time. Dependency order adds a critical-path lower bound. Memory and disk bandwidth can impose further limits. An engineering forecast may use

    wall time approximately W / (P*measured_efficiency) + uncovered serial/I/O overhead,

provided the overhead is not already counted in the efficiency measurement. Prefer a measured task schedule with per-module wall durations and memory caps when dependencies are substantial. Do not equate a requested thread count with effective parallelism.

Measure CPU time for the entire process tree, not only its launching shell. On this campaign the current project driver's `time.monotonic()` timings are wall times. They cannot retrospectively be relabeled core-hours. The recorded `lean -j 2` option also does not establish that two cores were continuously occupied.

## Current calibration and limits

The pinned repository reports approximately 55 microseconds of kernel checking per prime-ladder rung. About 254 million rungs therefore give about 3.9 core-hours of checking, consistent with its reported four hours. Its reported full ladder run is about five one-core hours including search. These are source-reported measurements, not a benchmark reproduced here. [Pinned README](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/README.md#L119)

The historical binary-Goldbach verification's roughly 770 core-years concern a different native program, hardware, and task, including minimal partitions and statistics. There is no measured conversion factor from that workload to a future Lean checker. [Original paper](https://denisevellachemla.eu/empirical-verification-of-the-even-CG.pdf)

The proposed binary verifier and denser adaptive ladder therefore need their own measurements. The earlier model combining 770 core-years with five core-hours illustrates the cutoff tradeoff only. Its calculated optimum is not a runtime forecast.

## A principled later experiment

Once implementation is authorized, first prove the chosen block checker's soundness and audit its axioms. Benchmark fixed representative inputs with at least three increasing block sizes and several numerical endpoints. Record CPU and wall time, peak memory, certificate bytes, artifact bytes, and which dependencies were reused. Repeat enough to identify noise, then test several simultaneous independent blocks to measure throughput and memory pressure. Reserve a larger unseen block to test the extrapolation.

Publish a range with separate ordinary-case and difficult-case costs. Change the forecast when the checker, certificate format, hardware, chunk size, or proof architecture changes. A fast native search benchmark does not replace a kernel-checking benchmark. A warm import of prebuilt artifacts does not establish fresh proof-checking time.

No new timing benchmark or Lean compilation was run to write this plan.

## Earlier sieve-based Fermi scenario

The following is an uncalibrated scenario, retained to show its assumptions. It is not an established estimate for direct Lean verification and should not be compared with the later per-witness MM0 scenario as if the algorithms were the same.

For a direct kernel-checked verification of binary Goldbach through 4e18, use a provisional central planning figure of roughly2500 core-years. A deliberately broad factor-ten range is250 to25000 core-years. This is a judgment-based order-of-magnitude estimate, not a measured forecast or a confidence interval.

The central arithmetic is770 historical core-years, divided by an assumed10-fold improvement in hardware throughput, divided by an assumed3-fold saving from checking existence without the original extra statistics, multiplied by an assumed100-fold kernel-checking overhead. This gives2567 core-years. The kernel multiplier is the largest unsupported assumption; changes in certificate design could put the true cost outside the stated range.

At1000 continuously available physical cores and assumed70 percent parallel efficiency, the central figure is approximately3.7 years elapsed. At100 cores it is approximately37 years. Storage, memory bandwidth, and serial assembly could make these estimates worse. This concerns the direct4e18 verification; it does not include mathematical proof development or establish a feasible certificate architecture.

The estimate reinforces the reason to study a smaller binary cutoff and a denser ladder. It does not justify treating the earlier toy optimization of those costs as an implemented runtime prediction.

## MM0 scenarios and correction

The later conversational estimate for binary Goldbach through10^8 assumed roughly50 million witnesses, around1000 elementary proof steps per witness including amortized supporting evidence, and around30 million checked steps per second. Those are planning assumptions, not a benchmark. They give roughly30 minutes of checking on one core, with a deliberately broad5-minute to5-hour range. Proof generation and development are additional work.

Scaling that same per-witness design to4*10^18 multiplies the work by40 billion. The resulting central figure is2.3 million core-years, with the stated range becoming approximately380,000 to23 million core-years. This is a projection of that design, not a lower bound on formal verification or a forecast for optimized MM0.

The earlier2500-core-year scenario instead started with an optimized native sieve and multiplied by an unsupported100-fold checking overhead. The large discrepancy is evidence that neither estimate calibrates an efficient proof-producing sieve. It is not evidence that MM0 is slower than Lean.

A shared block certificate can change the work per integer drastically. Both provers can benefit from better algorithms and shared evidence. MM0's explicit proof format may give additional checking advantages, but no benchmark here establishes a speed ratio against an equally optimized Lean checker. Proving a sieve program correct does not by itself certify a particular native execution; the run still needs checked evidence. A useful experiment must measure block proof size, generation time, verification time, and memory separately, then test scaling on larger unseen blocks.
