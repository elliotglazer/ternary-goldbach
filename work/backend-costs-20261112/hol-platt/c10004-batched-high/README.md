# Shared high-height Hurwitz evaluation

At coarse indices 84198 and 84199, the four-cell implementation matched all 9,600 direct p81 source pairs. The single-threaded run took 8.109375 CPU and 9.13969 wall seconds, including the first high phase, adjacent step factors, setup for both coefficient tables, TSV formatting and comparison. The separate direct evaluations took 46.47 CPU seconds. The observed ratio was 5.73 for this pair.

## Construction and truncation

Use ζ(s,α)=Σ_{n=0}^{M−1}(n+α)^(-s)+ζ(s,M+α). Store the 64 terms for each of the 4,800 residues at the actual initial height, together with their 307,200 adjacent-height unit factors. Each head term uses the same log to construct the cold phase and the step. The second node multiplies each retained complex term by its own step, then sums it. A longer run would need to retain each updated product and check interval width over the subsequent steps.

For each of four equal cells with midpoint b, use the Taylor series in d=α−b, |d|≤1/8. At order k, multiply ζ(s+k,M+b) by (−1)^k(s)_k/k!. The disk of analyticity around b extends to the nearest singularity at −M, so the expansion converges on each cell. The high imaginary part matters in bounding rising factorials. Write C for the number of cells, D=1/(2C), and P_k=∏_{r=0}^{k−1}(6580+r)/(r+1). For both heights |s+r|≤6580+r. For k≥2 the absolutely convergent Hurwitz series and the decreasing-function integral estimate give

    |ζ(s+k,M+b)| ≤ M^(-k-1/2)(1+M/(k-1/2)) ≤ M^(-k)(1+M/(k-1)).

The first omitted term of order K is bounded by T_K=P_K (D/M)^K (1+M/(K−1)). Every successive majorant ratio is at most r_K=(6580+K)D/[M(K+1)] since both the elementary ratio and the last correction factor decrease. With K=87 the rational geometric bound T_K/(1−r_K) is below 5.157×10^-36 for M=64, C=4. The script adds this full bound to both coordinates before testing strict half-ulp containment. This is a degree-86 polynomial with 87 terms per cell.

## Precision and measured work

The per-residue arithmetic uses 224-bit Arb enclosures. High derivatives need tighter absolute accuracy for their small Hurwitz factors. The adaptive schedule evaluates ζ at precision max(224,178+bitlength(num)−bitlength(den)) where num/den=P_k D^k. The guard is a performance choice. Correctness of the exported p81 pairs follows from the final interval check including the analytic tail. Each height uses 348 midpoint Hurwitz evaluations.

| Four-cell run | Wall seconds | CPU seconds |
|---|---:|---:|
| Cold high-height terms and step factors | 2.473 | 2.171875 |
| First height, coefficient table | 2.629 | 2.171875 |
| First height, all residues and formatting | 0.791 | 0.703125 |
| Second height, coefficient table | 2.236 | 2.125000 |
| Second height, all residues and formatting | 1.004 | 0.937500 |

This prices a cold first height at 5.046875 CPU seconds and its adjacent successor at 3.0625 CPU seconds. Production timings include 86 Horner steps and the 64-term head per residue. The single-threaded Python process also holds the source state in memory; peak memory was unmeasured. The comparison covers actual source generation at these two heights. It gives no estimate for materializing or formally checking these coefficient enclosures in HOL4 or for the production P20 schedule.

An initial M=32, eight-cell trial at uniform 224-bit precision failed the strict rounding test. The successful eight-cell run used 704-bit Hurwitz coefficients and took 22.59375 CPU seconds for both nodes, with a separate 1.0625 CPU seconds of cold setup included. receipt.json records that earlier run. adaptive.json records the four-cell run and current generator hash. Run batch.py with --adaptive using the campaign interval-env Python interpreter.
