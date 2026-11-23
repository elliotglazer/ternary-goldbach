# All sparse raw samples at conductor 10000

HOL4 checked every archived 220-bit-grid raw center required by the sparse certificate for labels 3, 6667, 11 and 9091. The 71,325 label/sample decisions span 51,996 tick positions and 1,331 tiles, including all interpolation stencil inputs. The kernel verified that each computed interval lies in the half-open bin for the exact signed integer read from sparse-count/raw-{label}.txt. It checked the absolute index at each requested position, consumed the four masks in order, used a twiddle once at coinciding ticks, and exhausted the per-label raw streams. The six sequential heaps saved all 1,331 closed tile theorems in 167 archives, reread every archive and matched each conclusion to the original. The archived files total 174,520,381 bytes.

| Cost over all required outputs | CPU s |
|---|---:|
| Shared evaluation schema setup | 0.708 |
| Read operands and exact raw targets, construct HOL numerals | 41.590 |
| Kernel argument encoding | 0.219 |
| CV final-butterfly arithmetic and bin/mask checks | 16.894 |
| Finish equality proofs and audit tags | 0.208 |
| Name and write all tile theorems | 44.269 |
| Reread and compare every theorem | 20.879 |
| Complete measured proof drivers | 125.833 |

Across all six cold admission processes the OS measured 180.11 user plus 28.11 system CPU seconds and 263.66 seconds wall time. Peak RSS was 2,099,844 KiB. The preceding generic checker build took 60.38 s wall and 17.97 s CPU; the shard driver build took 19.78 s wall and 2.96 s CPU. The native ingress took 20.05 s wall and 20.00 s CPU, including all eight penultimate 262,144-point half-transforms and selection of the operand precision. Each tile used 224–248 fractional bits, sufficient here for the exact 220-bit floor bin. The midpoint operands, excluding the existing target files, occupied 17,159,337 bytes. The four sparse raw target/mask files occupied 4,741,142 bytes.

Final-stage CV execution cost 237 microseconds per decision. Quoting the two sets of input numerals cost another 583 microseconds. These measurements replace the earlier four-tile estimate for an exact-raw interface. The faster head-only pilot checked a coarser block-floating output. The final-stage operator used a fixed positive margin bound for real and imaginary input perturbations of one local grid unit.

The experiment checks a conditional FFT interface. The half-transform coordinates and trigonometric twiddle enclosures come from native Arb and native label/tick association. HOL verifies the supplied tick/mask routing, arithmetic, exact raw-bin outcomes and ancestor/closed-theorem audits. It has no upstream proof of those half-transform or twiddle enclosures. The expected raw fields supply values against which computed bins are checked; the full standalone quotation charge would change for an in-kernel producer/consumer. No interpolation sum was replaced by a sign.

The first disk-writer attempt needed a saved theorem dependency tag. The next single-heap run reached tile 815 before losing throughput near the 4 GiB virtual-memory ceiling. The final six-heap run repeated all 1,331 tiles under the bound. FullButterflyScript.sml specifies the checker, full_shard.sml performs admission and disk reread, full_prepare.py derives the operands from the actual spectrum, and full_summary.py verifies the run coverage and creates full-verified.json and full-proof-archives.sha256. All successful logs have prefix b06.
