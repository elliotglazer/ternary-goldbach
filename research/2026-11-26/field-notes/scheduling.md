# Reconstructing the cold source schedule

These estimates were written after the finite and GRH source roots passed. They predict a fresh *project* build against pinned dependencies. Their inputs are the individual Linux source times recorded at the tested revisions. A duration printed for a module measures elapsed time in that invocation. Summing durations of overlapping invocations does not measure the CPU consumed. [Warm Linux proof receipt](https://github.com/elliotglazer/ternary-goldbach/tree/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/joined-theorem-3ca2fcf7)

## The finite branch

The 732-module conditional root used 525 accepted inputs from four earlier runs (454, 11, 20 and 40) and rebuilt 207 in 1,358.682 seconds. Git blobs and module names bound every timing observation to the planned input. Summed module durations came to 15,072.163 seconds. The full binary theorem occupies 415 of these 732 modules. The remaining closure includes the analytic proof and its numerical rows. [Finite source receipt](https://github.com/elliotglazer/ternary-goldbach/tree/e735b1634f13ad9d8c4ba4c8876963ac9e1a6810/verification/community-grh/compact/finite-terminal-22f442fa)

The model included the 98 finite batches. Each batch after the first waits for every specified object of the previous one. At each scheduling step it selected a ready module with the longest remaining dependency path. At their recorded individual durations, four frontend slots gave 93.98 minutes for the complete finite schedule. Thirty-two slots gave 91.27. The shared Band06 and Band05 common modules alone occupied 18 minutes 45 seconds and 12 minutes 54 seconds on that path. [Public scheduling measurements](https://github.com/elliotglazer/ternary-goldbach/tree/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/finite-interval-scheduling)

The terminal run's newly compiled tail took 22.64 minutes against a four-slot prediction of 20.51. Applying that ratio to the cold model gave 103.78 minutes, rounded to 105, with a planning range of 90–150 minutes. An interrupted predecessor provided a looser check at 83.60 elapsed minutes for a 73.09-minute modeled subset. Its final successful module might have finished before the interruption. One earlier run measured a 48-GiB pressure threshold and 64-GiB hard limit. The successful terminal finite run lacked a separate hardware-capacity sample. The range expresses a scheduling judgment conditional on successful compilation.

## The combined root

The combined model used timing observations for all 1,528 imported project modules at `3ca2fcf7`. Thirteen log sources supplied 794 GRH times and five supplied the 732 finite times. The two final adapters took 26.65 and 2.81 seconds. The independent branches can overlap. The existing 37.321-second warm join checked the retained inputs, compiled the two adapters and imported the closed theorem. [Exact final proof and receipts](https://github.com/elliotglazer/ternary-goldbach/tree/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/joined-theorem-3ca2fcf7)

| Simultaneous frontends in the model | GRH minutes | Finite minutes | Combined minutes |
|---:|---:|---:|---:|
| 2 | 105.6 | 133.4 | 231.6 |
| 4 | 53.1 | 94.0 | 116.1 |
| 6 | 35.7 | 92.4 | 96.0 |
| 8 | 26.9 | 91.8 | 94.2 |
| 32 | 26.1 | 91.3 | 91.8 |

Two partial replays ran about 8–10% slower than the simulated four-slot schedule. The November 26 forecast budgeted 120–135 minutes for cold project compilation, with a 105–160-minute operating range in the absence of sustained memory reclaim or duplicate work. The model assumes that admitting extra processes preserves each task's recorded speed. Under 64 GiB that assumption weakens as concurrent frontends increase.

Three prior rehearsals spent 81–105 measured seconds between the end of provisioning and the challenge export. They exclude the fresh registry setup. The early source forecast also lacked measurements for exporting the full solution and replaying its full proof. For the later protected run's actual frontier and its clock, see the [operator chapter](../rehearsal.md) and [12:40 UTC snapshot](../evidence/performance-1240.json). An elapsed-time forecast for project modules alone cannot classify a hosted attempt.
