# Actual raw logarithm result review

Run range03 is accepted for the actual range-reduced and finally rounded raw
logarithm. All eleven original exact conclusions passed the recorded-result
audit, with empty hypotheses, permitted import tags and standard HOL ancestry.
Four exact program types passed. All twenty-one expected-source, six run-source,
fifty-one dependency and three output bindings match. The original eleven
statements, two definitions and fixed audit are unchanged. The parent Horner
review hashes also match. The run rebuilt the theory and executed the audit.

The final theorem proves

    source_log_domain x 1 k /\ k <= 18 ==>
      abs (real_of_int (source_raw_log129 k x) / 2 pow 129 - ln (&x))
        <= 1 / 2 pow 128.

It uses the actual computed ln(2) center, actual reduced-input center and actual
final integer rounding. No approximate logarithm, numerator equality or rounding
accuracy is assumed. The source-domain gate and exponent limit remain explicit
requirements for every later concrete source input.

The generic numerator error is at most (k+1)*(7/(4*grid)+2^-135). Final
rounding adds at most 2^-130 on the output grid. The exact budget for k<=18
is proved strictly below 2^-128. Fixed precision and term count are unchanged.

Successful construction and audit phases consumed 55.57
CPU seconds and 190.566 container elapsed seconds.
All recorded experiment phases consumed 152.33 CPU seconds, including
failed diagnostics and construction, excluding untimed orchestration and file
handling. These are generic proof-development timings, not numerical throughput.

This is recorded-result review/reload, not independent whole-kernel replay.
Exponential phase production, analytic target joins, complete source/sign/count
blocks and the other required campaign strata remain open. No aggregate speed
credit is assigned. The frozen forecast is unchanged and the full goal remains
active. BUILD_NOTES.md records the failed attempts and proof-only repairs.

| Artifact | SHA256 |
|---|---|
| SourceLogRangeScript.sml | c3f719c28316555d1bc3b960fc969e4b9cf824a45e3d55702a6cd15ffb980926 |
| range_audit.sml | 941a6af7771a277e4d3838dd0e3eb04f41deda5d66d3184e3e25a05659d4c89f |
| source_expected.sha256 | 69e088cae2f3f463fc9cf63a1a5a317a771055869d91bc938131be1080d1a82b |
| .hol/objs/SourceLogRangeTheory.uo | 6697d04bcb7ac51fc4f2f72831d7ccb57fd63d7d605229c73ddd65050bee3116 |
| .hol/objs/SourceLogRangeTheory.dat | 8edd9e7e625ca5077286a7c14df20a0bb680153dfa23bffe682bf47e60ddddd3 |
| range03_audit.log | 34e167115ec80ab531b55b2190a008db86ca7cf9f2987454ed792cc6d62d1196 |
