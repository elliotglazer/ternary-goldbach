# Error of exact circular Bluestein at conductor 10000

For the actual length-500 Gauss slice, the 500 terminally rounded outputs differed from their analytic Fourier targets by at most 57 units on grid 2^-307. The bound through the exact postchirp, before the final rounding, was 56 units. Both maxima were attained as enclosure ceilings at index 186. Every comparison used a direct 448-bit Arb sum of the exact unit inputs and true Fourier roots. The previous FFT-based normalized Bluestein outputs also passed their archived radii against these direct sums.

## Uniform proof

Let n=500 and p_j=exp(πij²/n). Since n is even, p is n-periodic and p_k p_j conj(p_(k−j))=exp(2πijk/n) for all integer j,k. The implemented kernel is the exact conjugate of the *rounded* chirp modulo n. Write r for an upper bound on the norm errors of each stored unit input, chirp, prechirp rounding and optional postchirp rounding. Input and true chirps have unit norm. Copying, conjugation, integer multiplication, circular reduction, addition and the exact denominator changes add zero error.

For a fixed j,k, expand the product of the stored source and three chirps relative to the exact unit factors. The sum of all nonconstant perturbation terms has norm at most (1+r)^4−1, with no independence assumption. The prechirped source product also undergoes one rounding. Its error is multiplied by the stored kernel and the stored postchirp, giving a further bound r(1+r)^2. Therefore every exact postchirp output has error at most

    n [(1+r)^4−1+r(1+r)^2].

Terminal rounding adds r once. With S=2^307 and r=1/S, rational upward rounding gives uniform radii of 2,501 and 2,502 grid units, respectively. When all coordinates use nearest rounding, r=(707107/1000000)/S safely majorizes 1/(√2 S). The improved radii are 1,768 and 1,769 grid units. A circuit satisfying only the looser unit-norm error contract must use the first bounds unless it separately establishes the tighter errors.

The experiment uses residues r_j congruent to one modulo 16 and 2^j modulo 625. Sources are exp(2πi r_j/10000). audit.py computes the circular convolution by a direct nested loop of exact integer products. It rounds the prechirp to p307 and forms the postchirped integer numerator at grid921. Relative to p307 the final divisor is 2^614. expected.tsv stores the rounded p307 pair and both per-output analytic radius ceilings. receipt.json records uniform caps and the expected table's digest.

The periodicity argument generalizes to other even lengths. For odd n, this same chirp is antiperiodic. An implementation can instead use p_j=exp(2πi h j²/n) for 2h≡1 mod n and verify the new chirp table and identity. A stride in the Fourier exponent requires the corresponding stride in the chirp identity. Subgroup, residue ordering and denominator changes require independent verification before transfer. Inputs of norm at most B with absolute error r instead of unit norm give the more general product perturbation bound (B+r)(1+r)^3−B; the prechirp and terminal rounding terms stay as above. None of these extensions have been timed here.
