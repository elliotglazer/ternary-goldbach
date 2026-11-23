# Last time-FFT butterfly, projected head and strict sign in one HOL conversion

For the actual conductor-10000 spectrum and Conrey label 3, HOL4 checked 256 sample projections and signs without reading a full-width final sample. The selected coarse ticks were 0–63, 32640–32703, 65536–65599 and 84224–84287. The conjunction all_256_actual_samples was exported. It includes 130 positive and 126 negative decisions. A second closed theorem rejects a changed expected sign. All 256 block-floating heads independently matched the original GridSigns tile file, and the signs matched the original sign table.

| Selected outputs | Construct literal terms, CPU s | Execute and check claims, CPU s |
|---:|---:|---:|
| 1 | 0.000410 | 0.000436 |
| 16 | 0.005705 | 0.006704 |
| 64 | 0.024557 | 0.032149 |
| 256 | 0.105741 | 0.178940 |

The compiled theorem schema cost 0.156343 CPU s once. Saving the 256-claim conjunction added 0.087083 CPU s. Each subset was spread across the four selected tiles. On this run the per-output execution cost ranged from 0.42 to 0.70 ms, separate from term construction and storage. Each requested output needs just its own final butterfly. The two native 262,144-point half-transforms were computed in full for every requested subset, so this experiment provides no evidence of comparable savings in those earlier FFT stages.

## Data boundary

prepare.py reads all 68,268 stored Hermitian spectrum rows. It reconstructs the even- and odd-indexed arrays and uses 384-bit Arb to enclose the two half DFTs. These FFTs plus input assembly took 4.391 s wall. Native validation and file production took 4.409 s wall and 4.328 s CPU overall. The final butterfly receives five signed integer centers at scale S = 2^256 for Re(E), Re(O), Im(O), Re(W), Im(W), where W = exp(−2πik/N). Native Arb checks each coordinate is within one grid unit. The HOL input also supplies the target block exponent, short signed head and expected strict sign code. The native comparison alone uses the full-width final grid.

HOL calculates the real numerator z = S E_r + W_r O_r − W_i O_i and integer error allowance R = S + |W_r| + |W_i| + |O_r| + |O_i| + 2. Given the five coordinate enclosures, expansion of the two products bounds the exact real butterfly by z ± R in squared grid units. The predicate checks that both ends lie in the proposed head's half-open bin of width 2^(292+exponent). It then calls the existing GridSigns strict_code using its original coarse radius plus one block unit. The generic HOL theorem proves transference of the integer interval inequality to any point inside it. The preceding FFT enclosures, root/exponent linkage and real error interpretation are still native evidence. Earlier-stage outputs exported as ordinary HOL integers would move the representation cost upstream. This pilot prices a final-stage handoff compatible with retaining preceding-stage CV representations inside a larger kernel evaluation.

The check uses a separate theory and read-only copies of the inputs from the grid-sign pipeline. The actual spectrum SHA256 is a89151a1c6c6aa09044537c0eaadbd5407e7f6ca61dae3f7ee7d33e07d31523e. FinalButterflyScript.sml contains the predicate and interval implication. FinalButterflyPilotScript.sml creates and audits the concrete conjunction, with empty hypotheses, only DISK_THM oracle tags, and an ancestor whitelist of the four standard HOL axioms. prepare.json, b01_pilot.log and b01_pilot.time bind the native inputs, timings and process costs.
