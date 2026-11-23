# Raw-head state fixture independent audit

Verdict: PASS for exact untrusted-data agreement with the pinned source definitions. All 1,032 proposed state pairs (2,064 coordinates), all eight setups and all seventeen count fields match an independent exact reconstruction. No discrepancy found. This is not Lean kernel acceptance of those concrete literals, a compiled-proof audit, or a performance comparison.

Only this audit file was written. The reviewer did not import or execute the proposal generator, invoke Lean, run a benchmark, alter the fixture or generate proof files. Independent recomputation used Python arbitrary-precision integers and exact rational arithmetic. It computed the specified finite integer programs, not transcendental function values. The fixture and all pinned sources were rehashed after restoration and remain unchanged from the recomputation.

## Frozen inputs

All paths below are relative to `work/lean-pilots/raw-head`.

| File | SHA256 |
|---|---|
| `generate_state_fixture.py` | `1184BE11036B39C3B8E80D634B6BDB0BB92B88052B8D7D052B7438E8B64CDAFE` |
| `state_fixture.json` | `01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9` |
| `fixture.json` | `6B3BFB1F685C50BC4588C499FBAAA27B68763FC18604ED3E74ACFED9B44BE93B` |
| `RawLogHorner.lean` | `B8F3D80805063D22C653D1949732DE0B67E92BE329512EABD1198A88E8A67AAD` |
| `RawLogAssembly.lean` | `BDF4C5DABB9F68EA9E5754452CE0C228EDA801A9F144A4648F415E7C900485D7` |
| `RawInverseRootProducer.lean` | `AB4B5B6721C03D37E87DC09732865B27A42161C8B7B686EEC50EEF48B676353B` |
| `RawExpInteger.lean` | `F4964C22363D290F96A17900CD72D2F193DBBD211F52651A1E2A49D5F78CB53B` |
| `RawStepProducer.lean` | `A30763650701C171C20B3EB6908F0918A95F1A64A2F0BEBB557D0D42070F53AE` |
| `RawDyadicProduct.lean` | `95C2BB6F0D336646DA77C29BECF76655EC14AE4B66CFBED06CCEBEB1B7E4214A` |
| `RawStateProducer.lean` | `E5335116BA0B90DD92D500FCD0EFA5A89586D08C334D64C0F9EC01AB12D9B961` |
| `STATE_SOURCE_AUDIT.md` | `3710C2FCF56DDFD1C846B0FA06ABA4948E9A9F2225413BC2DF9D0912285D9768` |
| `EXTENDED_SOURCE_AUDIT.md` | `3F30ABA29F289FB11B653E2A3942D98E7E53F15CABDE09658EA11E7DACEDD46E` |

The state fixture is exactly 122,237 bytes. Its source fixture is exactly 2,120 bytes; both the saved source hash and generator hash agree with the actual bytes. JSON was parsed with arbitrary-precision integer tokens. A separate duplicate-key-rejecting parse passed; all scalar leaves are strings or integers, with no Boolean, floating-point, null or nonfinite numeric entries. Consumers must preserve this exact integer interpretation rather than decode coordinates through binary64.

## Ordered source and time coverage

The eight bases are exactly, in order,

    1, 2, 3, 41, 61, 10004, 262144, 265800.

This order agrees between the original fixture, `base_order`, the generator's fixed tuple and all eight saved rows. Each row's `base_index` is its zero-based position. For each base the reviewer independently obtained k by successive powers of two, verified k<=18 and 2^k<=x<=2*2^k, and matched the original numerator x-2^k and denominator x+2^k. All bases are positive and at most265800. Natural truncated subtraction therefore equals ordinary integer subtraction in the logarithm argument.

Each row contains exactly129 pairs indexed j=0..128, in increasing order. The file is base-major, not time-major. Index0 is the initial pair and index128 follows exactly128 updates. The exact time is real 5*j/64: the last retained height is10. Thus all indices satisfy the source theorem's j<=90000 domain; no extrapolation or negative-height adapter is used. The complete comparison covered every coordinate at every index, not merely endpoints, checksums or selected rows. No missing or duplicated row/index was accepted.

## Independent arithmetic reconstruction

The independent check used a different rounding expression from the generator. For an exact rational q=n/d with d>0 it first formed floor quotient a and remainder r by `divmod(n,d)`, then returned a+1 if2r>=d and a otherwise. This equals floor(q+1/2), including negative ties toward positive infinity. Six separate boundary examples included -3/2,-1/2,1/2,3/2 and values on either side of -1/2. The generator's `(2*r+d)//(2*d)` agrees with Lean's signed Euclidean `roundDiv` because its denominator is positive. It is not truncation toward zero.

For the logarithm, the reviewer directly reconstructed the source recursion, with zero terminal value and45 affine levels, using the exact rational map

    h <- nearest(2^137/(2k+1) + (A/B)^2*h).

A final nearest round of2*A*h/B gives `logCenter`. This matches the generator's single combined integer numerator/denominator at every level; it does not introduce an extra round of either summand. The shared log2 center at A=1,B=3 was computed once and matched both files. Each base's grid129 center was independently formed as nearest((k*log2+logCenter(A,B))/256), matching the original fixture and new row.

The inverse-root check did not call the generator's `isqrt`. It used integer binary search for the largest m with m*m*x<=2^196, verified the strict next-square inequality, and matched all eight saved grid98 candidates. This equals Nat.sqrt(floor(2^196/x)). The exact-square cases x=1 and x=262144 are included; the strict upper comparison uses m+1 and remains valid.

The exponential check recursively reconstructed the actual source `expIntegerHorner`, not the generator's descending loop. It starts at (2^131,0), uses72 affine levels with exact phase numerator p=-5*q and denominator d=2^135, and computes both output coordinates from the same immutable child pair. Its real and imaginary updates are

    nearest(2^131 - p*v/(d*(k+1))),
    nearest(p*u/(d*(k+1))).

They match all saved `step_inner_grid131` coordinates. This is the normalized73-term polynomial (degrees0..72), with the negative source phase, not73 updates. The final independent division by512 matches every saved grid122 step. Since2^135=64*2^129 and512*2^122=2^131, neither the phase nor the regrid has a missing power-of-two factor.

Initial grid120 states are exactly `(m*2^22,0)`, not newly rounded inverse roots. For every subsequent state the independent checker formed exact rational complex operands on grids120 and122, multiplied them using the four-product complex formula, multiplied by2^120 and applied one nearest round per coordinate. Both new coordinates depend on the old pair, so the check excludes an accidental sequential in-place update. It matched every stored pair. The same fixed step is used for all128 updates of a base; no lower-grid export feeds back. At x=1 the exact unit state remains constant, as expected, but nontrivial bases were all checked as well.

The two previous source audits establish the generic analytic interpretation of these programs. This Python agreement is still untrusted computational evidence; it is not a kernel proof that these particular JSON literals equal those programs or enjoy their analytic bounds.

## Exact schedule counts

| Field/category | Verified count |
|---|---:|
| Bases |8|
| Updates per base |128|
| States per base |129|
| State pairs |1,032|
| State coordinates |2,064|
| Complex state updates |1,024|
| State signed real products |4,096|
| State coordinate combining additions/subtractions |2,048|
| State coordinate rounds |2,048|
| Shared log2 computations |1|
| Log affine updates, including shared log2 |405|
| Log-center final rounds, including shared log2 |9|
| Grid129 export rounds |8|
| Inverse-root candidate computations |8|
| Exponential affine updates |576|
| Exponential coordinate rounds |1,152|
| Grid122 step coordinate rounds |16|

These are exactly the saved seventeen count fields. In particular8*129 is not the update count: eight initialization pairs plus8*128 updates yield1,032 pairs. The log setup counts9*45 affine updates and9 final log-center rounds, even when a base's reduced logarithm happens to be zero. The exponential setup counts8*72 updates and2 rounds each, not the downstream state multiplications. All setup is present in the proposal construction; it is not charged per height.

The counts describe the named high-level arithmetic schedule, not all arithmetic inside Python, Lean reduction, division/root search, signed proofs or a backend instruction stream. They omit, among other things, range selection, exact scales and shifts, cache/source equality proofs, integer parsing/serialization, quotient/remainder internals and proof transport. The generator also computes and compares old source setup values and checks adjacent squares. Those checks are work, even though the count fields are not a complete CPU ledger. Conversely a future implementation cannot infer free cross-run cache reuse from this one setup schedule.

## Generator and timing scope

The generator checks the original fixture hash before using its eight rows, rejects unexpected argument counts, checks exact field types and source order, bounds source input to1MiB and output to2MiB, and rechecks its own hash before publication. It refuses an existing output and publishes with exclusive creation. A failed write may still leave a partial file; the present complete pinned JSON is the object audited. These controls bind this fixed experiment, not an adversarially authenticated certificate.

`native_proposal_timing` is generated by the proposal script and was not repeated or calibrated here. Its interval begins inside main, includes source/self reads, hashes, validation, all shared setup, integer proposal generation and result construction, and ends before final JSON encoding/output publication and timing-record construction. Interpreter startup/imports are outside it. The file itself records that boundary and the possibility of zero CPU from timer resolution. No measured throughput, checker-to-producer ratio or end-to-end forecast is accepted from this audit.

## Remaining kernel and consumer gates

The generic source theorems were previously compiled and reviewed, but a concrete checker still must establish exact literal-to-program bindings for all required setup and state data and export the intended ordered coverage theorem. A source generator, Python recomputation or matching file hash cannot replace those proofs. Data import must retain exact signed integers, source identity, k, grid, step direction and j. Later corruption controls, axiom closure, complete exported type and timed replay boundaries require their own review.

New `generate_state_lean.py`, `RawStateFixtureData.lean` and `RawStateSources.lean` are outside this data-only verdict. Their existence is not reported as compiled acceptance. No review of CachedLoop, alternative multiplication formulas, proof certificates, capacities, guards, sign/count consumers or a larger inventory is implied. There is no request to change the generator or fixture.
