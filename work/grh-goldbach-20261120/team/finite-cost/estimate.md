# Binary Goldbach through 10^16

## AWS budget decision, November 20

The total AWS spending ceiling for this project is **$10,000**, including the pilot. For the proposed localized route with binary bound 4×10^15, the planning estimate is $5,000–$7,000 for one production and verification run, including the pilot. The cutoff and the production checker still require proof and testing.

| Spending envelope | USD |
| --- | ---: |
| Benchmark pilot, all pilot charges | 200 |
| Binary verification workers after the pilot | 6,000 |
| GRH and Goldbach build/check, storage, transfers, logs and teardown | 1,800 |
| Uncommitted contingency, including applicable taxes and unexpected costs | 2,000 |
| **Total ceiling** | **10,000** |

The worker forecast at B=4×10^15 is $3,779. With the same region, price and mix of work, the $6,000 worker allocation permits about 1.59 times the modeled cost. Price an AWS pilot that includes full-block theorem acceptance, shared-table preparation, actual utilization and metered output. Scale only after the cutoff proof checks and the measured all-in forecast, including costs already incurred and outstanding commitments, fits within $8,000 before contingency. If the forecast exceeds that amount, resize or defer the run. Apply the same test to the 10^16 fallback, whose current $9,000–$12,000 range straddles the hard ceiling.

Billing basis: US East (N. Virginia), Linux c7a.8xlarge at $1.64224 per instance-hour for 32 physical cores, with 70% useful utilization and benchmark-core parity assumed. Control the maximum instance-hours of each batch using a fleet size limit, a fixed deadline and automatic termination of workers. Include residual storage/transfer charges after termination and keep a separate running spend ledger. AWS budget notifications can lag incurred charges. [AWS price feed](https://calculator.aws/pricing/2.0/meteredUnitMaps/ec2/USD/current/ec2-ondemand-without-sec-sel/US%20East%20(N.%20Virginia)/Linux/index.json) · [AWS Budgets timing](https://docs.aws.amazon.com/cost-management/latest/userguide/budgets-managing-costs.html)

Budget **about 100,000 physical core-hours** to produce and check all finite binary certificates once, after the checker is operational. The favorable and stress scenarios give **52,000 and 706,000 core-hours**. These are engineering scenarios. GRH, the analytic Goldbach proof, engineering hours, and a second independent replay have separate budgets.

The range contains 4,999,999,999,999,999 even integers. The model tests twelve power-of-two block lengths. The lowest modeled cost is at 8,589,934,592 consecutive integers per block, with 4,294,967,296 even targets in each full block. Each of 1,164,154 blocks gets up to 512 candidate anchor primes. One odd-prime table, estimated at 397 million positive bits in about 512 MiB, serves all the blocks. Only the **raw bit table** fits in this space. A Lean proof store for those bits is much larger. Shards require sound access to the specific table chunks they consume.

| Planning component | Core-hours |
| --- | ---: |
| Native prefix search for coverage | 9,659 |
| Lean coverage, including assembling each tile theorem from prior facts | 36,024 |
| Shared source primality proofs, once | 12,137 |
| Anchor primality proofs | 18,238 |
| Generating the source and anchor certificates | 5,515 |
| Initial range, exceptions, I/O, imports and final assembly allowance | 20,393 |
| **Total** | **101,966** |

The measured numerical Lean test took 3.40 ms per 262,144 even targets. Planning allows 6.80 ms for a complete coverage tile using prepared prime data. The sound general theorem interpreting the particular packed convolution and the large-tile workflow still need implementation. Native shift/OR took 0.608 ms on the same fixture with 188 selected anchors and prepared operands. Planning uses three times that for search and preparation. The prefix length and the halo needed for the proposed range are unverified. The prime rows use twice the 55.1 ms measured for kernel replay of a cohort of 32 roots, plus a generation allowance of 20 ms per root. Production import and assembly costs may exceed these allowances. The existing complete 1,024-target Lean proof required 209.5 CPU seconds for its batched incremental construction, with common support prebuilt. Scaling relies on reusing prime proofs and processing many more targets per operation.

Block length trades source size against the number of anchor certificates. The planning costs for spans of 2^32, 2^33 and 2^34 integers are 120,233, 101,966 and 105,320 hours. The earlier 2^36-even-target layout corresponds to 2^37 integers. In this model, that larger layout costs 313,323 hours because the shared source table consumes more prime certifications. A proved segmented sieve could change the source term and the preferred width.

| Physical cores comparable to the benchmark | Ideal hours | Hours at 70% utilization |
| ---: | ---: | ---: |
| 4,096 | 24.9 | 35.6 |
| 8,192 | 12.4 | 17.8 |
| 16,384 | 6.2 | 8.9 |

For a **12-hour** window the planning model needs 12,139 such cores at 70% utilization. For a **24-hour** window it needs 6,070. Available CPU hours are only one condition. The one-time table consumes about 14,340 core-hours including generation. For example, a four-hour table deadline requires 5,122 comparable cores at 70% sustained utilization. Early table ranges and the actual critical path must be measured on the candidate machines. Aggregate peak CPU throughput alone cannot establish either deadline.

For the fleet pilot, build a real source chunk and prove complete blocks at different positions, including one near the upper bound. Include the first range, both seam conventions, the final partial block and overflow/exception handling. Measure CPU seconds, elapsed time, serialized bytes and peak RSS, from generated data through kernel acceptance of the stated binary theorem. Check the axiom footprint and reproducibility of each stage. Keep one-time table work out of the per-block rate. The planning recurring cost is **271 CPU-seconds per full-equivalent block** including allocations for seams and assembly. At 70% utilization, the 12-hour criterion on 16,384 cores permits **381 CPU-seconds per block** after the modeled table cost, while the same deadline on 8,192 cores permits **168 seconds**. Recompute those thresholds with measured table and final assembly costs. Aggregate transfer rate must also support the observed bytes per block. At 19.07 billion tiles, even 4 KiB of output per tile means 78 TB before replication.

Reproduce the numbers with `python model.py`. The program writes `results.json` with exact counts, component formulas, grid outcomes, scenario settings, fleet thresholds and hashes of the calibration files. It uses a prime-number-theorem estimate for the source population and exact integer arithmetic for endpoint and shard counts. Each proposed prime and each covered even integer still needs proof.
