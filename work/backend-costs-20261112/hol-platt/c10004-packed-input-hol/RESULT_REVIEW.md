# Packed input admission at conductor 10004

HOL4 proved that the two packed source payloads decode to the 4,800 original ordered integer pairs at each height. Both packed sign admissions passed the same 2,301 guards per height as the shared-phase benchmark. The kernel used a 96-bit two's-complement decoder with least-significant coordinate first. Each selected natural literal contains 16 complete pairs; 300 literals represent one height. The source integers and analytic meaning of the coefficient, root and radius data remain external inputs.

On the first 256 source pairs of h1 the benchmark compared 4 pairs (8 coordinates) and 16 pairs (32 coordinates) per literal. After one warm-up per width, three alternating runs at each width gave median summed conversion/evaluation CPU times of 0.381 and 0.285 s, including exact comparison to the same literal prefix. The choice of 16 pairs applies to these runs. Calibration took 20.42 s wall and peaked at 786,384 KiB. Native packing took 0.012 and 0.013 s for the selected h1/h2 text files of 277,540 and 277,538 bytes.

| Admission | Height | Read and construct terms, CPU s | Prepare CV, CPU s | Execute packed decoder, tensor and signs, CPU s | Decode Boolean, CPU s | Total through storage, CPU s |
|---|---:|---:|---:|---:|---:|---:|
| Eager packed arguments | 5/64 | 0.582 | 3.550 | 0.695 | 0.00010 | 5.070 |
| Eager packed arguments | 10/64 | 0.574 | 3.384 | 1.447 | 0.00012 | 5.861 |
| Instantiated argument template | 5/64 | 0.486 | 0.0536 | 0.577 | 0.00009 | 1.350 |
| Instantiated argument template | 10/64 | 0.525 | 0.0386 | 0.616 | 0.00015 | 1.427 |

The template run derives a representation equality for a list of 300 fresh natural variables by EVAL once (0.00282 CPU s); applying kernel INST to the literal payload costs 0.00044 and 0.00029 s. Stock CV builds code equations from the checked function and schematic arguments. Stock CV then executes on the kernel-certified concrete encoding. Both changes are included in the timing. The previous unpacked shared-phase preparation was 3.444/3.572 CPU s, with totals through storage of 4.244/4.653 s. Charging just the template preparation omits about half a second per height spent reading and constructing term numerals.

The fresh two-height template process took 25.04 s wall, 18.37 s CPU and 1,004,036 KiB peak RSS including bootstrap and export. The corresponding eager packed process took 31.44 s wall, 25.38 s CPU and 1,488,652 KiB. The unpacked shared-phase process took 27.55 s wall, 21.59 s CPU and 1,344,076 KiB. The packed predicate build took 39.48 s wall, 9.93 s CPU; the template driver build took 24.47 s wall. The reusable shared-phase cache is priced in the adjacent shared-phase report. Measurements cover these two heights in fresh local processes, with the second height sharing caches.

Standalone CV execution of the decoder alone took 0.262/0.341 CPU s at h1/h2. Expanding its result to an ordinary HOL list added 2.533/3.851 CPU s; the diagnostic consumed 1,721,020 KiB peak RSS. The fused Boolean admissions avoid that expansion. Separate full input identity admissions produced exported closed equalities for both heights, consumed 44.02 s wall and peaked at 2,102,008 KiB. The template admission data object is 3,820,497 bytes. All concrete proofs have empty hypotheses, only DISK_THM oracle tags, and standard HOL ancestry.

The source and timings are in C10004PackedScript.sml, packed.sml, template.sml, decoder.sml, packing.json and the p02, p03 and p04 logs. p01_theory.time records the successful generic build. The initial p01 calibration driver required replacing a sort library unavailable in the pinned environment. run.sh runs calibration and both eager checks. template.sh and decoder.sh accept their own run label and the calibration width file.
