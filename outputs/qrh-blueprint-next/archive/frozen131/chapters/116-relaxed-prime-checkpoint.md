# Separate alternative checkpoint: theta(a) within a/10000

Date: 2026-11-11. This is an arithmetic-only research follow-on authorized after the frozen tight-checkpoint failure. It does not modify that run, generate new prime counts, claim the old theta bound false, or replace an accepted contract without independent review. No Lean was run.

## Mathematical sufficiency on the unchanged grid

Keep a_0=1e9 and b=a+floor(a/4000), ending at5e9. Consider the alternative checkpoint condition

    abs(theta(a)-a)<=a/10000.                            (C10000)

The source of the prime-power allowance is the separately reviewed full P6 repair, with exact public target NP(t)<1.4262sqrt(t) for t>0. For t>=1e9, sqrt(t)>31622 and the exact comparison1.4262/31622<17/360000 imply

    0<=psi(t)-theta(t)<17*t/360000.

For a<=v<=b, monotonicity of theta and this allowance give

    v-psi(v)<=b-theta(a)<=a/4000+a/10000=(7/20000)*a,

    psi(v)-v<=theta(b)+17*b/360000-a
      <=a/4000+(1/10000+17/360000)*b
      <=(572053/1440000000)*a.

Here b<=4001*a/4000. The two constants are both strictly less than1/2300. The upper margin is exactly

    1/2300-572053/1440000000=1242781/33120000000>0.

Using the source bound exp(1)>2.7 and the exact rational inequality2.7^23>5e9 gives log(v)<23 for every v<=5e9. Hence a<=v yields

    abs(psi(v)-v)<v/2300<.01*v/log(v).

The same reasoning works for real v between checkpoints, so the integer E consumer is preserved without an additional floor error. This is a different sufficient intermediate condition for the same E conclusion, with a complete algebraic derivation. It is not an added Goldbach assumption.

## Replay of all already computed endpoints, with no new sieve

`resume_psi_relaxed_checkpoint_20261111.py` reads the three frozen JSON artifacts for the first window, next32, and failed512-cap stress test. It verifies their hashes, reconstructs the exact chain from stg2813, checks all grid and subcell boundaries/card sums, repeats all actual source-checker rational log inequalities, and recomputes every theta interval. It then tests(C10000) at each of the538 computed post-seed endpoints. The seed itself also passes, so539 endpoints including the seed are checked.

All538 post-seed endpoints pass(C10000). The tight test theta+/-a/24000 fails at exactly index538 in the same data, preserving the earlier result. No prime-count generation or re-sieve is performed by this script. It only checks arithmetic implications of the already externally obtained data.

The requested first/best/worst summaries are:

| selection | grid index | endpoint | relevant result |
|---|---:|---:|---|
|first post-seed endpoint|1|1000250000|lower margin16626291602949/250000000; upper margin26170790754567/200000000|
|best relative enclosure error|418|1110140678|max(abs(L-a),abs(U-a))/a=14722024173411/1110140678000000000|
|worst relative enclosure error|538|1143945143|max(abs(L-a),abs(U-a))/a=11932620780281/285986285750000000|
|minimum absolute lower margin|14|1003505688|63519486670203/1000000000=63519.486670203|
|minimum absolute upper margin|415|1109308490|60848861305071/500000000=121697.722610142|

The worst relative error is approximately4.1725e-5, below the new radius1e-4; this number describes the certified enclosure endpoints, not an exact theta value. At the former failed checkpoint538, the new lower margin is16666007794719/250000000>66664.03 and the upper margin is78853296766351/500000000>157706.59.

The summary JSON also stores all538 new-condition margins and exact relative errors, so the extrema and every test can be independently replayed. The script exits0. Its success shows that existing data satisfy this proposed alternative condition and that the algebraic transfer to E has slack; it does not prove the remaining5901 uncounted windows will pass.

## Status

This is a proposed alternative certificate condition pending independent review. The tight-contract failure remains frozen and was only an enclosure rejection, not a forced violation by the true theta value. There are still538 externally counted windows,5901 uncounted windows, and zero new Lean count proofs. The spectral route from5e9 remains independently conditional. The original final10^27 bound and BinaryGoldbachInput are unchanged.
