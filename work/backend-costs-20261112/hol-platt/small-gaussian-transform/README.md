# Carrying Gaussian coefficients into the character transform

The conductor-10,000 test starts with the actual first Gaussian seed at 302 fractional bits. It builds 5,303 residue buckets, lifts them exactly to the 307-bit character grid, and returns one complex coefficient for each of the 1,600 primitive characters. The input seed and the three Fourier tables are concrete dyadic values. The exported HOL4 theorems establish exact integer results for those inputs. An independent 680-bit Arb calculation compared every output to the direct finite sum over its 2,122 retained coprime indices. The largest observed error bounds were 103,744,727 units of \(2^{-307}\) in even parity and 55,691,188,676 units in odd parity. The proof of the analytic input enclosures and the passage to the infinite theta series remain open. [Independent reference](matched.json) · [HOL4 computation](MatchedScript.sml)

The unit group is \(C_2\times C_4\times C_{500}\). Its coordinates use \(-1\) and 5 modulo 16, and 2 modulo 625. The primitive labels \((h,\ell,k)\) have odd \(\ell\) and \(5\nmid k\). The parity is \(h+k\bmod 2\). Pairing the residues \(r\) and \(10000-r\) reduces the calculation to four 500-point transforms, one for each choice of parity and \(\ell=1,3\). A separate eight-transform implementation tested the original 302-bit grid and full parity tables. Its output was checked against its own direct finite sums. [Matched fixture](reference.py) · [Eight-transform control](FusedScript.sml)

## Passing the values between processes

With the scheduled precisions and parity fold, the one-process proof took **7.52 CPU seconds** when the transform consumed the Gaussian table directly. Exposing all 5,303 ordinary HOL buckets, preparing them as input to the transform, and composing the two proofs took **107.95 CPU seconds**. The 14.35-fold ratio is for these stages of this block. The same kernel verified identical conclusions by both routes. The ratio excludes process startup and final theory export. [Paired kernel run](matched02.log) · [Cost calculation](results.json)

The Fourier root tables can be named and their exact evaluator encodings proved once. A producer then saves a theorem identifying the encoding of the complete character vector with its computed value. A fresh HOL4 process imports that theorem, uses it to reorder the four blocks of 400 coefficients, and exports the new encoding. Each process also compared all its output pairs to the independent integer reference. The diagnostic checks are timed separately. [Producer](DirectTransferScript.sml) · [Fresh consumer](ReadTransferScript.sml)

| Operation | Measured prover stage CPU seconds | Full process CPU seconds | Exported theory data |
| --- | ---: | ---: | ---: |
| Share the three conductor tables | 4.269 | 23.00 | 5,008,714 bytes |
| Produce the encoded 1,600-coefficient vector | 1.219 | 20.30 | 2,017,792 bytes |
| Reopen and reorder the vector | 0.275 | 18.97 | 3,031,154 bytes |

The full process includes startup, dependency loading, checks and export. It used 3.246 seconds on the producer's independent full-vector comparison and 3.343 seconds on the consumer's. The 0.275-second figure measures using the imported proof in memory. It does not include the cost of loading or writing a theory file. A separate producer exported the Gaussian table alone in 9,708,960 bytes. A fresh process consumed it to produce the same integer character vector. The fused producer avoids this intermediate file. [Timings and hashes](results.json)

The first materialized-table run and the separate Gaussian publication both completed in HOL4. Edits to the shell launcher during those runs caused errors after the kernel finished. The matched materialized-table proof was repeated with a stable launcher. The publication has the kernel's zero exit code, exported data and a successful independent import. The launcher now parses the complete run before starting the kernel.

## Scale of the transfer

The shorter schedule has 862,353,296,473 nontrivial small-conductor character coefficients. Expanding shared singleton values would add 91,317,349,462. At the declared precisions, storing each coordinate in whole bytes with 32 bits above the binary point would use 76.9 TB for one copy of the nontrivial coefficients. This is an illustrative format, and batching changes the peak storage. At 1,255 conductors the Gaussian precision exceeds the character precision, so their conversions require separate rounding analysis. [Count and precision inventory](boundary.json)

The subtotal of 628,472–629,001 core-hours leaves about 171,000 hours before twice Platt's historical total. Spending all that time on these coefficient transfers would allow 714 microseconds per complex value. At conductor 10,000 the measured in-memory reordering costs 172 microseconds per value, and the whole fresh consumer costs 11,856 microseconds per value including its diagnostic. The extent to which startup, export and input loading can be shared across frequencies is consequential. This experiment covers one frequency and one conductor. Its rate has not been added to the campaign total. The experiment also stops before applying the analytic prefactors and the time transform.
