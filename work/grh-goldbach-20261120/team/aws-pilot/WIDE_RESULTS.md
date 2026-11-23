# Binary Goldbach through the final 16,384 even targets at 4 × 10^15

On 20 November 2026, Lean 4.35.0 accepted a closed theorem covering every even natural number from 3,999,999,999,967,234 through 4,000,000,000,000,000. Two adjacent 8,192-target shards share a persisted table of 2,560 small primes and a Lucas certificate tree for 79 anchor primes. The assembly checks the seam and the inclusive upper endpoint. The independent import of `WideGoldbach.endpoint_range` reported exactly `[propext, Classical.choice, Quot.sound]`.

The successful Windows run used 227.81 CPU seconds, 554.10 seconds elapsed and peak process RSS of 1.86 GiB. The 12 project artifacts totalled 7,159,080 bytes. These figures include rebuilding the new generic table and coverage lemmas, a dedicated import control and an independent axiom audit. They use previously checked generic Lucas and prime-bitmap modules and a warm Mathlib cache.

| Stage | CPU seconds | Output bytes |
|---|---:|---:|
| Three source-table modules plus exact aggregate bitmap | 78.80 | 3,560,608 |
| Separate process importing that table | 15.80 | 1,136 |
| Anchor primality, 482 Lucas nodes | 31.64 | 3,186,928 |
| Two coverage shards | 34.09 | 174,968 |
| Seam assembly and axiom audit | 32.70 | 48,312 |
| New generic table and coverage lemmas | 34.78 | 187,128 |

For each table chunk, one gcd certifies primality of all marked source entries. In this fixture each marked number exceeds 169 and lies below (169+1)^2. A composite would have a factor dividing 169!, so the product of the candidates could not be coprime to 169!. The exact bit pattern is independently checked and exported. Source build and bitmap assembly measured 30.78 ms per marked prime including imports. The earlier 55.08 ms estimate for individual larger Lucas roots would predict 141.0 seconds for the same count. The root sizes and evidence differ; a 1.79-fold ratio does not justify rescaling a full-range forecast.

The raw source bitmap occupied only 1,536 bytes. Its persisted proof artifacts were over 2,300 times larger, and a dedicated table import still took 15.8 CPU seconds. The per-shard CPU includes startup and importing Mathlib. Subtracting these times to estimate a large cluster's effective rate would require a matched repeated import control on its hardware.

A follow-up used the same first eight 512-slot chunks and reconstructed their offset lists inside Lean from the eight integer bitmasks. The original compiled module occupied 1,201,896 bytes and used 19.03 CPU seconds. The bitmask version occupied 96,704 bytes and used 22.16 CPU seconds. This reduced the artifact size by a factor of 12.43 in one matched batch. Both produced prime theorems for the same eight masks. The end-to-end run above retains the original modules. The A/B receipt is `wide/b8192-02/masked-sample.json`.

The portable package also contains two 262,144-target shards at the same upper endpoint, with 43,755 proposed small primes, 164 distinct anchors and 907 Lucas certificate nodes. WSL x86-64 regenerated all 524,288 targets' exact inputs and both anchor lists from scratch. This larger fixture retains its kernel run as a deployment measurement. See `wide/goldbach-4e15-wide-linux.tar.gz`, SHA-256 `ed5651a7520443ed5425345020f3382ce8b657e04d1fa95775b33ab7f711d626`.

The small source window does not span the full production source domain. In a separate Python benchmark at the far end of the proposed 2^36 odd-slot table, the square-root cutoff is 370,727 and the factorial occupies 790,452 bytes. Certifying the 20,808 marked candidates' products over 520 chunks took 7.22 CPU seconds after a 1.67-second factorial computation. The raw generator used a segmented sieve and never required a 2^37-sized array. The high-source kernel price remains open.

Production gates are a measured Linux replay at the intended tile width, a checked high-source implementation with an amortized shared factorial or equivalent, reduced checkpoint/import overhead, and measured reuse of certified anchors across many interior tiles. The pilot proves its two shard endpoints. A full proof must certify all tiles, the start of the range, exceptional witness choices and the final gap-free union. At width 262,144, that union has approximately 7.63 billion tiles. `wide/b8192-02/receipt.json` and `wide/b8192-02/WideAudit.log` preserve exact measurements and theorem evidence.
