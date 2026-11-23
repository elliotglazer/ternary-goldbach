# Fused conductor-10004 integer sign checks

HOL4 evaluated the actual 4,800-input p81 tensor at heights 5/64 and 10/64, passed its outputs directly to an integer predicate and exported one closed Boolean equality per height. Every one of the 4,602 expected completed signs passed. The subsequent Python cross-check counted 1,732 positive and 569 negative signs at the first height, and 1,679 positive and 622 negative at the second. The two tables differ at 153 channels.

| Height | Read and construct HOL input, CPU s | Encode arguments and prepare CV, CPU s | Execute tensor and guards, CPU s | Decode Boolean, CPU s | Discharge, CPU s | Total through theorem storage, CPU s |
|---|---:|---:|---:|---:|---:|---:|
| 5/64 | 0.473234 | 7.725888 | 0.729775 | 0.000132 | 0.000075 | 9.399101 |
| 10/64 | 0.221954 | 8.504172 | 0.727175 | 0.000097 | 0.000076 | 9.914515 |

The same single worker ran both heights. It started from the pinned HOL state and loaded previously built generic theories. The first height used a fresh process and the second shared its caches. The timed replay including startup and export took 47.60 s wall, 33.04 user CPU s and 6.87 system CPU s, with 1,635,304 KiB peak RSS. The preceding predicate theory build took 51.34 s wall and the audit module build took 22.97 s wall. The exported theory data occupied 5,240,911 bytes because the closed statements contain literal inputs and coefficient tables.

The earlier full-output replay took 46.06 s wall and used 2.674 and 2.776 CPU s to decode the complex arrays. Boolean decoding costs less than 0.2 ms per height. Encoding the extra per-channel coefficient and radius records brings total wall time to 47.60 s in this single pair of runs. Input representation remains the largest measured per-height cost.

## Mathematical scope

Let r,i be the p81 spectrum center, e its supplied coordinate radius, a,b the rounded p81 center of the complex phase times the height- and parity-specific completion factor, and s the supplied sign. For every channel the HOL predicate checks e ≥ 0, s ∈ {−1,1}, and

    s (a r − b i) > (|a| + |b|) e + |r| + |i| + 2 e.

The right side bounds the projection error in squared grid units if the input coordinate errors are at most e and each multiplier-coordinate error is at most one grid unit. Product expansion gives the terms from perturbing the input, perturbing the multiplier, and perturbing both simultaneously. The native coefficient generator used 176-bit Arb intervals and strictly enclosed each coefficient within half a grid unit of the stated integer. The native minimum guard margins divided by 2^162 were approximately 0.05471460 and 0.02048119.

The closed HOL theorems establish the strict integer inequalities with the supplied guards. Their application to exact completed L-values still requires formal source/root, radius and phase/completion adapters. Counts and endpoint comparisons were computed independently from the two sign tables. The fused replay reads only literal roots, inputs and guards. Its theorem hypotheses were empty, with DISK_THM as the sole oracle tag and the four standard HOL axioms in the ancestor audit.

## Files

* C10004FusedScript.sml defines the integer predicate and its CV translation.
* guards.py reads the native reference and writes all coefficient, radius and sign rows. check.py independently validates them using the earlier full-output replay.
* fused.sml and run.sh reproduce the timed replay. f02_replay.log, f02_replay.time and checks.json contain the measurements and checks.
* artifacts.sha256 binds the run inputs, outputs and sources. The initial translation log f01_theory.log records that stock CV required an explicit integer absolute-value definition. The final source uses a sign test.
