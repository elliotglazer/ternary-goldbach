# Uniform source-state bounds accepted

Bounds01 passed construction and the fixed three-root reload audit on its first attempt. This is a recorded-result review, not an independent whole-kernel replay.

The generic theorem bounds the full scalar recurrence by initialError + 3*n*delta over a finite prefix whose proposed upper envelope is at most one. The proof keeps the multiplicative delta*error term. The raw corollary proves the strict 2^-96 bound through 90000 actual SourceArithmetic.source_state updates, using grid 2^120, step grid 2^122, initial error 2^-98 and step error 2^-120. A single induction and rational endpoint check suffice; the proof does not unfold 90000 stored updates or evaluate a geometric power of that degree.

Initial accuracy, step accuracy, unit exact step, initial exact norm at most one and the exact target recurrence remain explicit premises. No initial/log/exponential producer, complete analytic source, transform, sign or zero count has been accepted by this module. No campaign cost reduction follows from this small generic build.

All three roots passed exact conclusion, empty hypothesis, import tag and standard HOL ancestry checks. Eleven expected-source pins, six run-source pins, forty-nine dependency/tool pins and three output pins were rehashed and matched. All phase statuses and the container exit are zero. Successful phase CPU totals 32.80 seconds; container elapsed time 134.0588710 seconds. Imported dependencies are separate. No process remains live for bounds01.

The source and audit statements were frozen before this first build and did not change. The full research goal and cost forecast remain unchanged. Next is discharging the producer premises, starting with the integer inverse-root initializer and then the logarithm/exponential step.

## Accepted bindings

- `SourceStateBoundsScript.sml`: `2f61ad317295da157d033b194af670319b39e469beb86b28304ba8b081db5e49`
- `state_bounds_audit.sml`: `c46255ff3a70135e98b9de1d614465360ab18aab8ca2a177eca39b98309710ac`
- `source_expected.sha256`: `fcee00d4963c18ba0373f41d741b8a77af86ff912b2163b22198b412c613fb61`
- `.hol/objs/SourceStateBoundsTheory.uo`: `75606397c24864ecfd1759fcf9b2b32c68f48b9cf8af9380fb6ceaf8ab68e000`
- `.hol/objs/SourceStateBoundsTheory.dat`: `dff2d717c5752681fd75fba9e52683d7e4408330a8cb56a9901254d01b72fcac`
- `bounds01_audit.log`: `a943f2e54e7a4171f0099a6e1aa115e42216ac97950b27ea4da15a7517d144fe`
