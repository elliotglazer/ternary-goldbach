# Partial timing snapshot for the November 26 AWS source build

At 01:27:38 UTC, Lake had reported **10,344 of 10,575 jobs** for source revision `0b68b493791e5f7569021f0cd13454151af47584`. Ten distinct source targets had failed. Other jobs continued. The snapshot records 20 distinct error locations, the last job header and the digest of the log up to that point. The worker was still running when it produced the snapshot. [Worker snapshot](ec2-d69a0b0a-source-timings.json)

| When Lake printed the completion | Memory pressure threshold / hard limit | Successful timed headers | Sum of module elapsed times |
| --- | --- | ---: | ---: |
| Before the 00:42:20 UTC checkpoint | 60.8 / 62.72 GiB | 238 | 1.12 hours |
| After the checkpoint, through capture | 152 / 176 GiB requested for diagnosis | 305 | 14.53 hours |

The later 305 completions appeared in **45 minutes 18 seconds**. Lake times each module separately. Jobs overlap, their timers include waiting, and some later completions began under the original memory limits. Adding module times therefore double-counts elapsed time. The two groups also contain different modules, so comparing them cannot establish how much the extra memory sped up the build.

At the checkpoint, the AWS service had used **2.86 core-hours**, including setup. The operating system attributed 1.17 core-hours to user code and 1.69 to system work. This snapshot has no later CPU counter. A Palomar runtime estimate requires a complete run under its resource limits. [Memory-change record and CPU counters](ec2-d69a0b0a-diagnostic-memory-change.json)

The worker checked the first 81,282 log bytes against the SHA-256 recorded before the memory change. The snapshot also carries the SHA-256 of all 242,565 bytes read by capture. The published snapshot's own SHA-256 is `c41a58367190639acac7f360306b5f23fe959c44ac883a56009626a56287d8aa`.
