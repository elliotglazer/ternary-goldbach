# Natural-offset source review

13 November 2026. Independent source-only review of `NaturalOffsetRoundScript.sml`, SHA256 `76182607C9EE4B728EF4930E546119FB4B49C32520DE220D93B114EBD981A356`, and `README.md`, SHA256 `2A421F633000CE2BC7215A1B9F50B725083864AF5B97018B75CB72C30AC44156`.

Verdict: no mathematical statement or program-fidelity blocker found before a focused stock HOL4 build. The submitted tactic scripts remain uncompiled and may need ordinary proof repairs. This review performs no build, numerical evaluation, CV translation or dependency edit. It does not confer theorem acceptance or a speed claim.

## Algebra and natural subtraction

Write `a=A-B`, `b=E-B`, `c=C-S`, `d=D-S` as integer subtractions. Under the natural-number box hypotheses, their absolute values are bounded by `B,B,S,S`. The three shared products are exactly `P=(A+E)C`, `Q=E(C+D)`, and `U=A(D+2S-C)`. The inner subtraction in U is exact because `C<=2S<=D+2S`.

Expansion gives `P-Q=AC-ED` and `P+U=EC+AD+2AS`. Therefore the displayed real positive accumulator minus its negative accumulator is `ac-bd+2BS`; the imaginary difference is `ad+bc+2BS`. Each signed product coordinate is between `-2BS` and `2BS`. Both differences consequently lie in `[0,4BS]`, proving that the two outer natural subtractions do not truncate. This checks all three potential underflows, not only the subtraction inside U.

The code's `re_pos/re_neg/im_pos/im_neg` definitions agree with the shared-product `offset_raw` definition. `offset_raw_correct` states the required integer equalities for the actual natural pair. `offset_no_underflow` supplies the premises needed to move natural subtraction through the integer casts. The degenerate `B=0` case is allowed and sound: the box forces `A=E=0`. Positivity of `S` is needed only when division is used. No correctness is claimed for out-of-box inputs merely because the natural program is total.

## Exact rounding, output bias and negative ties

Let `q=(2R+S) DIV (2S)` and `r=(2R+S) MOD (2S)`. For `S>0`, natural division gives `2R+S=q*(2S)+r` and `0<=r<2S`. Hence

```text
2*(R-2BS)+S = (q-2B)*(2S)+r.
```

The same nonnegative remainder proves that integer floor division of the left side by `2S` is `q-2B`. This is precisely `offset_round_correct`, with output bias `2B`. It is valid for every natural R, independently of the raw-product range. It does not replace floor division by truncation toward zero.

For a signed half-tie `2r=(2k+1)s` and positive s, the numerator of `round_scaled s r` is `(k+1)*(2s)`, so the quotient is `k+1` with remainder zero. This argument applies to every integer k, including negative k. The proposed `round_scaled_half_tie` states that full result. The residual endpoint convention remains `-s<=2*(raw-rounded*s)<s`; it is inherited through exact equality rather than weakened to a symmetric enclosure.

For `R<=4BS`, `2R+S<(4B+1)*(2S)` establishes the natural rounded bound `q<=4B`. Decoding at bias `2B` gives coordinates in `[-2B,2B]`. The README correctly warns that the next operation must use the new bias and range. This is not a recurrence that can repeatedly assume the old B unchanged.

The final `offset_mul_round_correct` target is the actual pair of `BlockRound.round_scaled` results on `(ac-bd,ad+bc)`. It retains all four box bounds and `S>0`. It is a stronger interface than merely a close output or a valid residual and supports a future exact replacement at that interface. No theorem yet connects this pair to a complete butterfly, source producer or transform execution.

## Existing proof authority and source APIs

The definition and residual of `BlockRound.round_scaled` were read directly. `integerScript.sml:2244` supplies `INT_DIV_UNIQUE` with the positive-divisor remainder interval used above; it admits negative quotients. `INT_SUB`, `INT_ABS_MUL`, `INT_ABS_LE` and `INT_LE_MUL` support the proposed cast, box and polynomial arguments. `arithmeticScript.sml:3128` supplies `DIV_LE_X` with a positive divisor. The existing `RoundSpecialization` uses the same natural quotient/remainder to signed-floor proof pattern.

The following README pins were independently verified:

| Source | SHA256 |
|---|---|
| BlockRoundScript.sml | FF267EC688BDC4A4065DE0BD14D3BC109F60F2A0D86F99FAE89646D4212EF143 |
| RoundSpecializationScript.sml | 37CB4079D95F48B1F1FF9974525C909DDA21F829FD39FB341027EB9CD5380DAF |
| integerScript.sml | C35C81AF62A41E7AECD2CA571A97275F130EE8BD1D70A041BCB7651CB72C7D8C |
| arithmeticScript.sml | 5EF5AD4CC13DB74907AA557188BDA5F36F0219B1062E329D94D01FAC526C774D |

The candidate uses ordinary definitions, existing theorems, integer polynomial conversion and tactics. It introduces no axiom or evaluator modification. A later build must still check the final theorem types, empty hypotheses, ancestry and imported proof tags under the ordinary kernel.

## Cost and integration limits

The README's conservative raw bounds are valid: P,Q,U are at most `8BS`; the real accumulators are at most `14BS` and `12BS`; the imaginary accumulators at most `20BS` and `12BS`. These bounds precede cancellation. The new representation has three general products but also the displayed B/S products, sums, subtractions and two divisions. The source shares P literally; it does not automatically make the other scale products free.

Actual encoding/decoding, valid box proofs at each use, larger natural operand widths, optional power-of-two shifts, and any CV translation remain to be built and charged. A stored approximate root can exceed an exact unit-coordinate bound, so a caller must establish the literal `C,D<=2S` requirements rather than infer them from the ideal root. A different root bound needs its own proved adapter. No throughput, precision reduction or end-to-end savings follows from the source algebra alone.
