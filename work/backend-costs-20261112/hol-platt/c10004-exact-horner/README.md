# Exact evaluation of the translated polynomial

At one height and fine cell the selected source supplies 20 complex integer coefficients on mixed dyadic grids. Align them to grid 94 by exact left shifts and call the resulting integers $C_j$. For unit $a$ in cell $k$ the polynomial argument is $r/v$, where $r=1024a-10004k$ and $v=20008$. The selected anchor gives $|r|≤5002$. Leading coefficients that are exactly zero may be removed. The resulting degree is $d$.

For each real coordinate start with $N_d=C_d$. Descending in $j$, compute $N_j=rN_{j+1}+v^{d-j}C_j$. The final numerator is the exact value of the finite polynomial on grid 94 times $v^d$. A single division gives the nearest integer with ties towards positive infinity. In the original mixed-grid circuit each product was rounded at its stage grid. Output centers can therefore differ. The analytic checks below include that difference.

The scaled coefficient columns depend only on the conductor, cell and heights in the slab. The residual varies with $a$. Several heights and both real coordinates fit in one signed integer polynomial in $2^w$. Multiplication by the common residual and addition then operate on all those coefficients at once. The script bounds every intermediate using $|r|≤5002$ before selecting the byte width $w/8$. Only the terminal operation extracts lanes and divides. The tests compare the packed result to a direct scalar power sum and to the original evaluator.

| Eight consecutive groups of eight heights | First 64 heights | Last 64 heights of band 1 |
|---|---:|---:|
| Height indices | 1–64 | 6337–6400 |
| Cells and distinct units | 2 and 7 | 2 and 7 |
| Number of complex outputs | 448 | 448 |
| Highest nonzero degree over each slab | 9 | 19 |
| Lane width | 232 bits | 376 bits |
| Largest old/new coordinate difference on grid 94 | 1 | 1 |
| Median native wall time per 448 outputs with reusable columns | 0.673 ms | 1.283 ms |

At low height, preparing both cells, evaluating and extracting outputs took 2.787 ms cold. Preparing columns is charged once only when their kernel-approved representation is reused. The prepared low and high results cost about 1.50 and 2.86 microseconds per complex output in CPython. Both measurements exclude analytic source construction and formal acceptance. The high slab uses the original band-1 P27 source, checked against 1,728 independent Hurwitz coefficient enclosures. Each of the 448 terminal-rounding outputs met the selected local requirement $633|e|<2^{-82}$, with maximum error below $6.393·10^{-29}$. The low slab's existing checked maximum, plus the Euclidean effect of one grid94 unit per coordinate, also meets that requirement. These independent tests concern the stated cells.

[Low timings and comparisons](receipt.json) · [Band-edge interval checks](edge-receipt.json) · [Source slab](../c10004-p20-slab/) · [HOL scalar and packed experiments](../c10004-lane-horner/)
