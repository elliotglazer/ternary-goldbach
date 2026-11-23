# Independent review of the conductor-three toy rectangle

Date: 2026-11-11. Finding: **pass as an external interval calculation and paper-level argument-principle certificate**. The actual primitive conductor-three L-function is nonzero on and inside the rectangle `[111/200,2] + i[-33,33]`, under the reviewed analytic formulas and the interval-library arithmetic contract. In particular the proposed upper-real-part conclusion holds at requested height 32. This is not a Lean theorem, a certificate at Hp(3)=20114486, a result for another conductor, or a full-family performance estimate.

## Frozen inputs and replay

Reviewed files under `agents/zero-sum/`:

| File | SHA256 |
|---|---|
| `C3_RIGHT_RECTANGLE_PILOT_2026-11-11.md` | `39024d30a685e6424ebdd8a11e4dc2236c5e00e2960c7d871c3e5e882305ac91` |
| `c3_right_rectangle_20261111.py` | `24d676376d36e39b89b718956f36fc0c6b3d0a6169053e5926d6043893d2dd4f` |
| `c3_right_rectangle_20261111.json` | `27613ab3b75e26e5e1b20a4e66290cf425ffbd1b8e926c17b3487485275a0225` |

The existing interval environment is `work/qrh-campaign/interval-env/Scripts/python.exe`, with python-flint 0.9.0 / FLINT 3.6.0. Running the frozen script with `--replay` passed all 2950 panels and returned exact winding zero in approximately 0.879 seconds internally. This replay did not rewrite its input. No dependency was installed.

The independent script `moebius/c3_rectangle_review_20261111.py` does not import the producer. It checks the rational geometry and shared vertices independently and reevaluates the contour using a separately written Euler--Maclaurin evaluator with N=96, M=20, and 192-bit precision instead of N=80, M=24, and 128 bits. It uses direct Hurwitz pole terms on the contour, which avoids s=1, rather than the producer's exprel cancellation. Bernoulli coefficients come from interval Bernoulli evaluation instead of the producer's rational recurrence. It invokes no builtin L-function or zeta evaluator.

The alternative enclosure was initially inconclusive for 892 original panels; this is ordinary interval overestimation, not a failed analytic inequality. Subdivision, with the **same original separating half-plane on every subpanel**, verified all panels using 4004 leaves and at most three additional bisections. Thus the full original panel image is in its original half-plane by finite coverage. There were no unresolved panels. The script exits unsuccessfully if any remain. An independently rotated ray-crossing calculation gives four positive and four negative crossings, hence winding zero. The final independent run took approximately 3.280 seconds internally. Its JSON records all these results; these timings are bounded audit measurements only.

## Function and Euler--Maclaurin evaluator

There are exactly two characters modulo 3; the nonprincipal one takes values 1 and -1 on residues 1 and 2. It is the unique primitive character, since the other character induces from conductor one. Its entire L-function is

    3^(-s) * (zeta(s,1/3) - zeta(s,2/3)).

The identity initially follows from absolutely convergent series and extends analytically. Equal residues of the two Hurwitz poles cancel. There is no principal pole in this L-function and no use of an RH assumption.

The producer uses the correct Euler--Maclaurin terms through B_(2M), with `(s)_(2k-1)` and power `B^(1-s-2k)`, where B=N+a. The remainder integral after these terms has magnitude bounded by

    |(s)_(2M)| * sup|periodic B_(2M)|/(2M)!
      * B^(1-sigma-2M)/(sigma+2M-1).

The Bernoulli Fourier bound gives a factor at most `2*zeta(2M)/(2*pi)^(2M) < 4/6^(2M)`. The elementary estimate zeta(2M)<2 follows from the integral bound for its positive series; pi>3 suffices. Both M=24 and the independent M=20 satisfy all convergence conditions. See the [Euler--Maclaurin representations](https://dlmf.nist.gov/25.11#iii) and [Bernoulli Fourier formula](https://dlmf.nist.gov/24.8.E1).

Since B>1 and the actual contour has sigma>=111/200, replacing sigma in the final scalar factor by 111/200 increases that factor. The rising factorial is separately enclosed over the whole input ball. The exact formula used in the producer is therefore a valid upper bound:

    4*|(s)_(2M)|*B^(1-111/200-2M)
      / (6^(2M)*(111/200+2M-1)).

A positive-real integration base has no hidden imaginary-exponential factor: the norm of `(t+a)^(-s-2M)` is exactly `(t+a)^(-sigma-2M)`. The complex remainder disk is safely enlarged to a square by adding the upward-rounded error to both coordinate radii.

The rational contour points satisfy the domain restriction exactly. A ball enclosing them can extend slightly left through outward rounding; this does not invalidate the proof because the analytic remainder is claimed only for actual contour points. Arithmetic over the larger ball still encloses all those points. The report explicitly states this restricted-domain contract, and the geometry checker enforces it.

## Pole cancellation and elementary arithmetic

Writing B1=N+1/3, B2=N+2/3 and d=log(B2)-log(B1), the difference of the two pole terms is exactly

    B1^(1-s) * d * exprel((1-s)d).

The sign is correct: `(B1^(1-s)-B2^(1-s))/(s-1)` equals this expression. The exprel polynomial has terms z^k/(k+1)! for k=0,...,18. Its omitted tail is bounded by `exp(r)*r^19/20!` for r>=|z|, including z=0 by continuity. Thus the producer has no spurious singularity at s=1. The independent evaluator's direct pole divisions are safe because all contour points and accepted panel boxes stay away from s=1.

The interval constructor must retain uncertainty in a supplied midpoint and add an upper bound for an uncertain radius. The installed constructor passes both bounded probes described in the author report; the independent script repeats them. The [python-flint documentation](https://python-flint.readthedocs.io/en/latest/arb.html) describes outward radius rounding. These checks supplement, rather than prove, the library's general enclosure semantics. Both implementations remain external computations relying on that arithmetic contract.

The producer's four builtin Hurwitz/known-value comparisons are diagnostics only. The replay does not call them, and the independent evaluator does not use them. No builtin zero finder, critical-line list, or hidden spectral oracle participates in acceptance.

## Coverage, homotopy, and winding

The exact contour starts at `(111/200,-33)` and follows bottom, right, top, left. The independent geometry check verifies adjacency, bounds, positive boundary orientation, closure, and separate edge lengths

    289/200, 66, 289/200, 66.

Thus all four full edges are present. The input is not a sampled portion or a positive-height-only contour.

Each original panel has one strict axis-sign witness for its whole image. Its two rational image vertices satisfy the same sign, so the whole polygon segment lies in that open half-plane. Adjacent panels share exactly the same rational vertex, including the final closure. Straight interpolation of the true image to its polygon segment stays in the common half-plane. At junctions the homotopies agree, giving a homotopy of closed curves avoiding zero. The vertices need not be certified as exact endpoint values; their membership in both neighboring half-planes and their shared identity are sufficient. This is why replay can safely ignore the diagnostic image strings and recompute the witnesses.

The producer computes winding by rational determinant signs and half-open real-axis crossing rules. Those rules handle vertices on the ray without double counting. A crossing edge with zero determinant would pass through the origin, already excluded by its strict half-plane witness. My rotated-axis crossing calculation is independent and agrees. All integer arithmetic here is exact; there is no rounded sum of numerical arguments.

Holomorphy of the nonprincipal L-function on a neighborhood of the closed rectangle and boundary nonvanishing allow the argument principle. Its zero count is nonnegative and equals the zero winding, so there are no interior zeros. The boundary witnesses exclude boundary zeros too. Requested ordinates +/-32 are strictly inside +/-33; real zeros and both signs are included. A nontrivial zero at the requested height must therefore have real part strictly below .555. No simplicity, conjugation reduction, or critical-line hypothesis is required.

## Disposition

No mathematical correction is required for this frozen toy experiment. The analytic evaluator, whole-panel enclosure, polygon homotopy, exact winding, primitive-character identity, pole handling, and complete contour coverage pass review. This is concrete externally checked data for one small rectangle, stronger evidence than an uninstantiated checker specification. Formalization of the evaluator, interval arithmetic, analytic continuation and argument-principle bridge remains separate work. No production-height or full-family spectral obligation is discharged. No Lean build, canonical source edit, or frozen artifact modification occurred.
