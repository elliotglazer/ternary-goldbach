# Character transforms across 32 actual heights

The input comprises all 4,800 ordered unit residues for each conductor-10,004 height. The positive character transform keeps 2,301 primitive outputs per height. We use the same mixed-radix circuit with shared roots across heights. A signed vector is encoded as the integer sum of its entries times successive powers of $2^w$. Addition and scalar multiplication preserve that representation up to the declared magnitude bounds.

The original circuit rounds each general root product on grid 81. A power-of-two shift and a repeated binary mask perform exactly the same coordinate rounding on the packed vector. A signed bias prevents inter-lane borrows during that operation. A second circuit carries every root product exactly and rounds only at the output. Its nine root levels require 729 additional bits. Direct or special rotations on the other branch receive the same power-of-two scale before additions. The final centers require a separate analytic error bound.

| Actual heights 1–32 | Original rounding | Terminal rounding |
|---|---:|---:|
| Lane width | 200 bits | 848 bits |
| CPU to pack input | 0.141 s | 0.234 s |
| CPU to execute the transform | 0.234 s | 0.516 s |
| CPU to unpack and finish | 0.109 s | 0.188 s |
| Largest coordinate difference from independently computed scalar circuit | 0 | 66 grid units |

The exact agreement covers 73,632 complex outputs. Computing the original 32 scalar transforms separately took 2.19 CPU seconds. The native packed circuit with the original rounding took 0.484 CPU seconds including packing and unpacking. Source computation and file I/O lie outside both timings. No factor from this CPython implementation is applied to the historical model.

Across two low and two high heights the terminal-rounding circuit kept every one of the 9,204 completed signs with independently evaluated interval margins. In contrast to the CPython result, an ordinary HOL4 trial on the five-point leaves of a length-40 row found even the delayed packed circuit slower than its matched scalar implementation. Each of the 64 scalar leaves cost 416 microseconds on average, versus 647 at width four and 731 at width eight. The formal benchmark covers one leaf shape.

[Inputs and scalar oracle](../c10004-time-slab/receipt.json) · [Packed timing](slab32.json) · [Low/high timing](low-high.json) · [Interval verification](../c10004-delayed-accuracy/) · [HOL4 timing](../c10004-delayed-hol/REPORT.md)
