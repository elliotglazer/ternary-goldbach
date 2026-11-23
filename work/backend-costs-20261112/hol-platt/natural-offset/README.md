# Natural-offset complex multiply and round

Prepared 2026-11-13. This is a source-only proof candidate. No HOL build,
translation, arithmetic evaluation, benchmark, or installed-source change was
performed. The algebra below is checked symbolically by hand; the submitted HOL
proof attempts still need a stock HOL4 build. No theorem from this candidate is
reported as kernel-accepted yet.

## Exact operation

Take natural numbers B,S,A,E,C,D, with S>0 and
A,E<=2B and C,D<=2S. Decode signed integer coordinates as

    a=A-B, b=E-B, c=C-S, d=D-S.

These four subtractions are integer subtractions in the specification, not
natural truncated subtractions. Define the executable natural products

    P=(A+E)*C
    Q=E*(C+D)
    U=A*(D+2*S-C).

The inner subtraction is exact because C<=2S<=D+2S. Define

    R=P+S*E+B*D+2*B*S - (Q+S*A+B*C)
    I=P+U+4*B*S       - (3*S*A+S*E+B*C+B*D).

Both displayed outer subtractions are natural subtractions. The hypotheses
prove they do not truncate. Their exact integer values are

    R=a*c-b*d+2*B*S
    I=a*d+b*c+2*B*S.

For the first identity, P-Q=AC-ED. For the second,
P+U=EC+AD+2AS. Substituting the offsets gives the stated expressions.
Every decoded input coordinate has absolute value at most its offset, so each
signed product has absolute value at most BS. Consequently 0<=R,I<=4BS.
This proves both outer non-underflow conditions, including B=0 and all closed
coordinate endpoints.

The result is the natural pair

    ((2*R+S) DIV (2*S), (2*I+S) DIV (2*S)).

Its decoding uses offset 2B. For every natural R, not just an R in the above
range, floor division and integral translation give

    ((2*R+S) DIV (2*S)) - 2B
       = floor((2*(R-2BS)+S)/(2S)).

Thus this pair decodes to the two existing `BlockRound.round_scaled`
applications on the actual signed complex product. There is no change of
rounding rule or chosen center. The rule rounds a half-tie toward positive
infinity, including negative half-ties. Its residual is exactly

    -S <= 2*(raw-rounded*S) < S.

It is not ties-to-even or ties-away-from-zero. The candidate also states the
generic identity `2*r=(2*k+1)*s ==> round_scaled s r=k+1` for positive s.
For R<=4BS, its natural rounded coordinate is <=4B, so decoded coordinates
remain in [-2B,2B]. The next operation must accommodate that new offset and
bound. It must not silently use the old B.

## Candidate and proof boundary

`NaturalOffsetRoundScript.sml`, 9,071 bytes, SHA256
`76182607C9EE4B728EF4930E546119FB4B49C32520DE220D93B114EBD981A356`.

The candidate imports `BlockRound`, `integer`, and `arithmetic`. It contains
literal natural definitions with shared P,Q,U in `offset_raw`, followed by
ordinary proof attempts for:

- the decoded input bounds and a generic integer absolute product bound;
- the algebraic identities and both non-underflow conditions;
- exact raw-pair semantics and its natural range;
- natural quotient versus actual `round_scaled`, with no raw-range premise;
- `offset_mul_round_correct`, the pair-level actual signed equivalence;
- natural rounded range, residual, and the generic signed half-tie identity.

The division proof uses natural `DIVISION`, casts its exact quotient/remainder
identity to integers, and applies `INT_DIV_UNIQUE`. It does not infer floor
division from truncation toward zero. The product-bound proof uses `INT_LE_MUL`
on nonnegative factors and `INT_ABS_MUL`; polynomial normalization is a HOL
conversion. There are no axioms, admissions, oracle calls, generated proof
instances, or changes to an evaluator. There is no CV translation in this
candidate. The current submission makes no claim that its tactic scripts have
compiled.

The endpoint is the same signed pair as two calls of `round_scaled` to
`(ac-bd,ad+bc)`. This is also the pair expression in the existing source
producer's `source_mul`; that source-specific wrapper and any whole-transform
substitution are deliberately not introduced here. Bounds for each actual
network operand, root approximation contracts, and propagation across stages
remain obligations of a later consumer.

## What may become cheaper, and what is still charged

The executable arithmetic above uses naturals throughout and can avoid the
per-coordinate signed integer CV representation and sign branches. The outer
two-coordinate pair still exists. Whether a proved natural CV translation is
faster has not been measured or established.

There are three general products P,Q,U, but they operate on larger positive
operands. Conservative bounds before cancellation are:

| Object | Natural upper bound |
|---|---:|
| A+E | 4B |
| C+D and D+2S-C | 4S |
| P,Q,U | 8BS |
| Real positive/negative accumulators | 14BS / 12BS |
| Imaginary positive/negative accumulators | 20BS / 12BS |
| R,I after proven subtraction | 4BS |
| Rounded numerator | 8BS+S |
| Rounded output coordinate | 4B |

The S- and B-multiplications, construction of BS, affine sums, subtractions,
two divisions, offset encoding/decoding, and proof-side input/range binding are
not free. If B and S are powers of two, some products can later be given proved
shift implementations. That is not part of this candidate. Repeated scale
products may be shared only with explicit definitions and reuse. Likewise a
fixed root bound other than exactly S requires a new offset formula, not an
unproved substitution into this theorem.

This experiment therefore tests one precise representation change under the
same rounding semantics. It does not yet lower the required numerical
precision, eliminate source generation, certify signs, or reduce the full
spectral work estimate.

## Read-only source pins

Paths below are relative to the repository root.

- `work/backend-costs-20261112/hol4-setup/BlockRoundScript.sml`:
  `FF267EC688BDC4A4065DE0BD14D3BC109F60F2A0D86F99FAE89646D4212EF143`.
  Actual `round_scaled_def` and its asymmetric residual.
- `work/backend-costs-20261112/hol-platt/round-specialization/RoundSpecializationScript.sml`:
  `37CB4079D95F48B1F1FF9974525C909DDA21F829FD39FB341027EB9CD5380DAF`.
  Existing cast/division proof pattern and negative numerator convention.
- `work/backend-costs-20261112/hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/integer/integerScript.sml`:
  `C35C81AF62A41E7AECD2CA571A97275F130EE8BD1D70A041BCB7651CB72C7D8C`.
  `INT_LE_MUL`, `INT_SUB`, `INT_DIV_UNIQUE`, `INT_ABS_MUL`, `INT_ABS_LE`.
- `work/backend-costs-20261112/hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/num/theories/arithmeticScript.sml`:
  `5EF5AD4CC13DB74907AA557188BDA5F36F0219B1062E329D94D01FAC526C774D`.
  Natural division and `DIV_LE_X`.

Only the new candidate and this note were written. No source fixture or
previous frozen report was changed.
