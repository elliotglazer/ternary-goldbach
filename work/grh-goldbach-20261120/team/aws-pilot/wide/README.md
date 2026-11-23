# Binary Goldbach pilot at 4 × 10^15

The supplied workloads each have two consecutive shards ending at 4,000,000,000,000,000. Both shards reference the same persisted prime table theorem and the same tree of Lucas certificates for their anchor primes. The small workload covers 16,384 even targets. The large one covers 524,288.

Run these commands on a Linux x86-64 proof worker with elan, Git, Python 3.10+, a C compiler and GNU coreutils. Run them from the unpacked package's root. Use an empty run directory for each workload. Record the time, bytes transferred and storage used by the bootstrap independently of the per-shard observations.

```sh
elan toolchain install leanprover/lean4:v4.35.0
bash wide/bootstrap.sh
python3 wide/run_wide.py wide/w8192 run-small
python3 wide/run_wide.py wide/w262144 run-large
```

Return `receipt.json` and `WideAudit.log` from each run directory. The runner saves each successful module's source and artifact hashes, CPU time, elapsed time, peak RSS and object bytes. Re-run the same command to resume an interrupted build. The `Shared` stage checks the full table bit pattern. The `ReadTable` stage opens that persisted theorem in a fresh process. `Shard0` and `Shard1` both load it and test different anchor shifts. A valid final receipt includes the exact inclusive endpoint theorem's axiom audit. Compile with the pinned Linux Lean binary on Linux; Windows objects stay off this path.

The untrusted generator in `wide/generate.py` records the shifted source and coverage parameters in `workload.json`. `source.bin` is the little-endian odd-slot bitmap. Bit i of that file represents the proposed small prime 4,097 + 2i. Each table chunk has 512 slots. For the large workload, d = floor(sqrt(largest source number)) = 732. All proposed primes exceed d. For each chunk, Lean checks gcd(product of marked entries, d!) = 1 and that every entry lies strictly between 1 and (d+1)^2. A composite entry's least prime factor would divide both the product and d!, contradicting the gcd check. Lean then proves that the local and aggregate bitmaps are exactly those indicated by the certified entries. The upper shifts, both promoted interval boundaries, and the join between shards have their own proof. The generator omits all smaller source primes, and the coverage check determines whether the remaining source is adequate.

| Workload | Targets | Source bitmap | Source primes | Source chunks | Distinct anchors | Lucas nodes |
|---|---:|---:|---:|---:|---:|---:|
| w8192 | 16,384 | 1,536 B | 2,560 | 24 | 79 | 482 |
| w262144 | 524,288 | 33,280 B | 43,755 | 520 | 164 | 907 |

The source and anchor theory costs are shared across these two shards. The larger workload uses 262,144-target shards, the tile width in the earlier estimates. A complete verification through 4 × 10^15 would still need an initial range proof, a layout for reusing larger anchor pools, measurements across the whole distribution of targets, exception and retry costs, and certified gap-free aggregation of roughly 7.63 billion such tiles. The two pilot shards individually choose their anchors. These pilots cannot establish the planned fleet throughput, even after a successful Lean audit. Candidate spot prices, vCPU model, and host operating-system caches also affect resource estimates.
