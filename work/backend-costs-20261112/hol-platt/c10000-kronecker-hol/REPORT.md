# One actual length-500 transform by exact integer convolution in HOL4

Stock HOL4 computed all 500 complex p307 outputs of the conductor-10000 Gauss-axis slice in 0.130528 CPU seconds cold and 0.141977 warm. The prior two-FFT evaluation took 0.403917 and 0.303648 CPU seconds on the same mathematical input, respectively. The new timings are 3.09 times faster cold and 2.14 times faster warm. Both implementations use supplied p307 root and input centers. They have different rounding schedules and their output integers differ. The full output comparison for the new circuit includes all 1,000 signed coordinates.

## Input, integer arithmetic and output

The 500 source centers correspond to exp(2πir/10000), with r congruent to 1 modulo 16 and to 2^j modulo 625. The supplied chirp p_j approximates exp(πi j²/500). Its period is 500 since the length is even. The Fourier identity writes the output as p_k times the circular convolution of x_j p_j with conjugate(p_j). Read inputs.tsv and chirps.tsv from the adjacent c10000-bluestein-hol directory. In HOL, round the prechirp coordinates to p307 with ties toward positive infinity. Use exact integer arithmetic through the entire circular convolution, then round once after the postchirp. Direct 448-bit ball evaluation of the same true Fourier outputs found a worst-case ceiling of 57 p307 grid units. The companion c10000-kronecker-error receipt contains that numerical analytic check; the HOL result is an arithmetic theorem on the supplied literals.

Let B=2^632. Encode a length-500 signed integer vector as the exact integer sum of its entries times B^j. The observed maximum signed component of either true convolution output is bounded by 1000 times the largest prechirped component magnitude times the largest chirp component magnitude. This conservative bound has 624 bits, strictly below B/2−1. Each individual complex component sums at most 1,000 real products. No carry bound is needed on the three intermediate integer products, since the algorithm combines them exactly before digit extraction.

For packed signed real and imaginary inputs X,Y,U,V, the kernel computes P=XU, Q=YV, and R=(X+Y)(U+V). The resulting polynomials evaluated at B are P−Q and R−P−Q. Reducing modulo B^500−1 folds the linear convolution cyclically. The packed actual cyclic vector C lies strictly between ±(B^500−1)/2, by the coefficient bound and the geometric series. Thus the centered remainder returns C exactly. Centered radix extraction then recovers each unique signed output coordinate. The Python reference checked all 250,000 complex terms using direct circular indexing. Its four packed input integers and two folded result integers matched the six supplied signed hexadecimal operands from c10000-kronecker/operands.json. The two input arrays per component were 315,668 to 315,675 bits. inputs.json pins all sources and the expected outputs.

The first complete implementation performed a serial base conversion and extracted one digit at a time. Its full kernel cost 0.301226 seconds. The faster implementation packs adjacent pairs at each of nine levels, then splits the two centered results with a balanced tree using exact quotients and remainders. It drops the twelve padded positions when it applies the 500 postchirps. The two implementations exported theorems kr_actual_full_500 and kt_actual_full_500. Each theorem gives the exact entire public output list for this instance, with no hypotheses, empty explicit axiom tags and only approved disk-theorem oracle tags. A separate checked packed congruence theorem binds both cyclic result polynomials. A generic HOL theorem connecting these algorithms to mathematical circular convolution under their bounds and a HOL root/source enclosure proof remain open.

| Conversion measurement, CPU seconds | Input-to-CV preparation | CV kernel | Decode and discharge | Exact output check |
|---|---:|---:|---:|---:|
| Pack + 4 check residues | 1.832535 | 0.100969 | 0.000115 | 0.000003 |
| Pack + 3 integer products + residues | 2.056898 | 0.113899 | 0.000133 | 0.000006 |
| Both full cyclic congruences with expected raw coefficients | 2.990724 | 0.209622 | 0.000184 | 0.000005 |
| Sequential full output | 2.411469 | 0.301226 | 1.219441 | 0.004995 |
| Balanced full output, cold | 1.969662 | 0.130528 | 0.526615 | 0.002606 |
| Balanced full output, warm | 1.708408 | 0.141977 | 0.419879 | 0.004768 |

The three kernel diagnostic rows include stock evaluation overhead and their stated checks. The 12.93 ms difference between the product and control rows includes a change in the number and size of small-modulus reductions. The two balanced output rows use the same Stock CV equations with fresh conversions in one process. Input term creation and loading before these timers took 0.218414 CPU seconds. The full balanced run, including source translation, both evaluations and theory export, took 13.62 user and 6.38 system CPU seconds, 47.71 wall seconds and 1,195,180 KiB peak RSS. The congruence run took 16.12 user and 6.55 system seconds, 52.24 wall seconds and 1,065,992 KiB peak. The serial full-output run took 15.39 user and 5.45 system seconds, 48.54 wall seconds and 838,376 KiB peak.

The comparison prices one length-500 axis at one precision. The previous FFT stores a normalized length-1024 spectrum. The new circuit needs the chirp coefficients but avoids both FFTs and their spectrum normalization. No family-wide savings are charged here. Other axis lengths, coefficient magnitudes, precision grids, accumulation radii, input production, and sharing across conductors all affect adoption.

The reproducible sources are KronScript.sml, KronFullScript.sml and KronTreeScript.sml. Successful logs are k03.log, full01.log and tree01.log, with matching time, status and SHA receipts. The bounded WSL runners use one worker and keep the rest of the workspace read-only. The first two attempts selected an unnecessary precondition translation and then lacked the integer-literal evaluator; both are recorded in the corresponding failure logs.

## Repeated three-product measurement

KronProductsScript.sml packs the same four integer inputs once and computes their three ordinary signed products 0, 1, 8, or 24 times inside one stock CV invocation. Each iteration adds the three results, reduces the sum modulo 65,521 and accumulates this checksum. The arithmetic result was checked for every requested iteration count. The independent exact congruence and full output runs establish correctness separately.

| Repetitions | Input preparation CPU seconds | Kernel CPU seconds |
|---:|---:|---:|
| 0 | 2.314824 | 0.063521 |
| 1 | 1.832364 | 0.101358 |
| 8 | 1.763010 | 0.092259 |
| 24 | 1.827428 | 0.148905 |

The marginal CPU time per three-product group is 3.592 ms between 0 and 8, 3.540 ms between 8 and 24, and 3.558 ms between 0 and 24. These prices include the operand sums, result sum, checksum and loop. The one-repetition value varies noticeably. No claim of a sub-millisecond measurement precision follows. The earlier native GMP triple measured 2.71 ms. The successful prod01 run used 16.05 user + 6.25 system seconds, 47.95 wall seconds and 1,183,960 KiB peak RSS.
