# Linked h1 and h2 integer sign proof

HOL4 checked both heights in one closed theorem at conductor 10004, from 4,801 supplied floor-inverse-root candidates and fixed phase increments. It verified each integer square inequality for the floor seed, formed each h1 grid120 complex state, advanced that same state to h2 and generated both grid100 raw heads. For each of the 4,800 CRT residues and each height it executed 19 mixed-grid Horner stages from the supplied P20 table, added the head, regridded to p81, transformed and checked all 2,301 completed integer sign margins. The code accepts both sign vectors in the same call. There are 153 opposite endpoint decisions across the two input vectors.

| Joint admission | CPU s |
|---|---:|
| Read and construct HOL terms | 1.400981 |
| Prepare typed-to-CV argument encodings | 0.117692 |
| Execute both source, state, transform and sign paths | 2.615255 |
| Decode Boolean | 0.000078 |
| Discharge residual premises | 0.000094 |
| Total through theorem storage | 5.135913 |

Including fresh startup, imports and export, the process took 35.57 s wall, 26.96 s CPU and peaked at 823,216 KiB RSS. The joint admission data object occupies 7,563,167 bytes. The extra generic theory build took 45.39 s wall and 12.03 s CPU, followed by a driver build of 20.44 s wall and 3.15 s CPU. All figures are for the single local worker. Both selected heights have 11 identically zero high-degree coordinate pairs in their low-height mixed-grid cache; other heights can involve wider nonzero intermediates.

Two further closed theorems checked the 9,600 concrete source pairs and 4,602 spectrum centers against independent native production references. H1 took 4.318274 CPU s through theorem storage, including 1.350421 s execution (28.28 s fresh wall, 20.88 s fresh CPU, 1,384,896 KiB peak). H2 took 4.523843 CPU s through storage, including 1.439853 s execution (33.78 s fresh wall, 24.59 s fresh CPU, 1,007,696 KiB peak). These diagnostics alone read the expected center vectors. Every saved theorem had empty hypotheses, with only DISK_THM oracle tags and standard HOL axioms in the ancestor audit.

The input includes 313,650 and 312,625 decimal bytes of packed coefficients at the two heights, 502,800 bytes encoding the 4,800 unit seeds and steps, one 105-byte conductor seed and step, the existing grid81 root rows, the named 2,301-phase table, two parity factors for each height, the sign masks and maximum radii of 13,308 and 13,397. All 4,801 upstream state rows and both sets of production heads were checked during native preparation. Floor inverse roots, state updates and raw head assembly execute inside HOL. The elementary grid122 phase increments, mixed-grid P20 values, analytic radii and completion factors still require formal links to their analytic specifications. Native P20 production and checking took 10.16 and 6.05 CPU s, respectively. The reusable HOL phase-encoding build previously took 21.45 CPU s. Native fixture preparation took 0.200 s wall.

C10004LinkedScript.sml defines the checked program. linked.sml checks its concrete instances. l02_admit.log and l02_admit.time record the successful joint proof; l03_id1.log and l03_id2.log record both exact identity proofs. The initial generic attempt needed explicit rounding-precondition lemmas. The diagnostic's Boolean tag needed explicit literal conversion; it affected neither the joint theorem nor its timing. The h1 full integer run using supplied grid100 raw heads is documented separately in c10004-full-integer.
