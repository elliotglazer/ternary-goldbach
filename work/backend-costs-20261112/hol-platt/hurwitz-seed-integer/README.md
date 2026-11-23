# Integer construction of the 320-bit Hurwitz coefficients

The large-conductor calculation uses translated local expansions of the Hurwitz zeta function. Translation already has a HOL4 price. The starting coefficients need their own justification. This experiment uses the existing groups of 16 cells, the existing degree on each height band, and the 640-index guard. It also allows one complete extra group per height for the single endpoint cell.

For grid size `f`, center `a` and height `s = 1/2 + 5ij/64`, the desired coefficient of degree `m` is

    (-2/f)^m (s)_m ζ(s+m,a) / m!

Each of the six native cases used the upper endpoint of its height band. The integer producer and an independent 510-bit Arb evaluation agreed on both 320-bit coordinates of every coefficient. The six comparisons contain 326 complex coefficients. The two adjacent-height tests additionally cover all phases through the Euler–Maclaurin cutoff in the first and last bands. [Integer producer](produce.py), [single-height receipts](integer.json), [adjacent-height receipts](linked.json)

## Elementary phases

For each rational `X = a+n`, compute `X^(-1/2)` and a single complex step `exp(-5i log(X)/64)`. Multiplying by that step advances from one height to the next. The fixed schedule contains 142,344,283,445 phase occurrences. It requires at most 9,671,976 starting pairs when each center is kept for its height band. Duplicate starts across bands are included in that bound. The finite sums require 2,287,498,853,490 terms and 100,148,382,680 Euler–Maclaurin corrections. These are operation counts.

The inverse square root uses two integer square inequalities. To compute the logarithm, reduce the argument to `y` between 1 and 2 and evaluate 144 terms of the inverse hyperbolic tangent series at `(y−1)/(y+1)`. Its modulus is at most 1/3. With scale 2^416, the omitted logarithm tail is below one working unit. Each Horner step incurs at most one unit of rounding, propagated by a factor at most 1/9. The complex exponential uses 96 Horner steps at an imaginary argument of modulus less than one. Its Taylor remainder is bounded by 1/97!, and the sum of the rounding errors is less than three working units. Allowing for the logarithm error and final reduction gives a complex step error below two units on the 384-bit grid. [NIST series formula](https://dlmf.nist.gov/4.38.E5)

The true step has modulus one and the true initial magnitude is at most one. With `S=2^384`, a binary or successive product for height `j` has error bounded by `(1+2/S)^(2j+1)−1`. The exponent counts the copies of both the original operands and the multiplication roundings, including the duplication incurred by squaring. The geometric majorant bounds the result by `4(2j+1)/S` throughout the schedule.

## Finite sums

For each degree the integer evaluator either truncates the absolutely convergent series or applies Euler–Maclaurin at an explicit cutoff. Higher inverse powers reuse the previous power by multiplying by the exact rational `1/X` and rounding once per coordinate. Each complex multiplier in the Euler–Maclaurin corrections is an exact Gaussian rational. The rounded accumulator multiplies each Bernoulli coefficient as an exact rational before summation. The finite formula and the periodic Bernoulli remainder are standard. [NIST Hurwitz zeta formulas](https://dlmf.nist.gov/25.11#iii)

[audit_bounds.py](audit_bounds.py) recomputes the truncation bounds at every degree, checks the finite Bernoulli series identities, and combines arithmetic error with final two-coordinate rounding. Its inequalities use exact fractions. The resulting all-heights estimates depend on the elementary and Euler–Maclaurin error arguments above. The native comparisons are independent checks on the implementation.
