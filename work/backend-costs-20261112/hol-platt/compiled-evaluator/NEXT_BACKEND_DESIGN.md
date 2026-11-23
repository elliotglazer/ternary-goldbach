# Next backend: typed integer block lowering

2026-11-13. Source-only feasibility proposal. No implementation, build, benchmark, equivalence proof or measured speedup is claimed. The earlier isolated closure experiment remains unchanged.

## Recommendation

The smallest defensible next experiment is **one typed implementation of the existing dependent block**, using signed arbitrary-precision integers and two private arrays of complex integer pairs. Keep the stock parser, exact source-equation binding and theorem wrapper. Initially return raw values only and compare against the stock evaluator. Do not start with a general CV compiler, arbitrary mutation of CV graphs, fixed-width machine arithmetic, or a new FFT algorithm.

This changes more than dispatch: it removes repeated CV sign decoding, pair construction, list traversal and layer rotation. Native big-integer arithmetic is already present in stock `Arbnumcore` through `IntInf`; replacing that component alone is not the proposed gain. Whether removing the remaining overhead closes a major factor gap is unknown. No source inspection can establish historical-scale hours.

## Why this subset has a precise source contract

The inspected `cv_typeScript.sml` encodes a nonnegative integer as `Num n`, a negative integer as `Pair (Num abs_n) (Num 0)`, a complex pair as another `Pair`, and a list as nested pairs ending in `Num 0`. The `cv_primScript.sml` implementations of signed add, multiply and division consequently branch through this representation. Its existing `cv_int_add`, `cv_int_sub`, `cv_int_mul` and `cv_int_div` theorems relate these computations to typed HOL integers; division has an explicit nonzero denominator condition.

This is not a license to decode every `Pair` as an integer. For example, noncanonical negative zero and malformed nested pairs have observable stock CV behavior; decoding and re-encoding can change their structure and later tests. A fast path must validate canonical representations, the exact selected program, argument types and all preconditions. Unknown programs or failed checks use the untouched stock evaluator. Do not replace function calls merely because their names look like integer operations.

The typed selected entry is the exact `DependentBlock.block_accept s ws n xs b expected` function with `s > 0` and `length xs = 2 * length ws`. The proposed lowering covers its actual bound and checksum tests as well as its block run. Source equivalence is required to this function, not merely to `block_contract`: many different outputs could satisfy a loose residual condition. Returning a matching checksum alone is not evidence of identical output arrays.

## Concrete implementation plan

1. **Validate and decode once.** Bind the actual closed input term and ordered code equations to the selected definitions and existing typed/CV transport theorem. Check canonical integer/list encodings, positive scale and equal lengths. Decode s, b, expected, n, ws and xs without changing their values. Validate all array lengths and machine-index conversions before allocation; an unrepresentable length falls back or fails without a theorem. Cache only program/translation artifacts keyed to the exact equations and representation, not prior arithmetic results.
2. **Use direct integer arithmetic.** For each adjacent pair u,v and coefficient w, compute the existing three-product formula: `t=wr*(vr+vi)`, `a=vi*(wr+wi)`, `c=vr*(wi-wr)`, then `qr=floor((2*(t-a)+s)/(2*s))` and `qi=floor((2*(t+c)+s)/(2*s))`. Output `(ur+qr,ui+qi)` and `(ur-qr,ui-qi)`. Preserve these integer operations and the positive-denominator floor convention, including negative half ties. A truncating quotient is wrong. Establish the precise host division bridge; it must not be assumed from an API name. Bigints remain unbounded, with resource failure aborting the request rather than producing a value.
3. **Two private buffers, one logical rotation.** Let the even length be L. At every layer start, reading the current buffer through its current offset must equal the source list. Read logical position i at physical `(offset+i) mod L`. Compute every adjacent pair from the old buffer into the other buffer at unrotated physical output positions i and i+1. Swap buffers only after the entire layer, and set the new logical offset to `1 mod L` to represent `xs ++ [x]`; do not accumulate the old offset when output was written in this unrotated layout. The next layer still uses ws from its first coefficient, as the source does. Handle L=0 without modulo zero. No coefficient/source buffer is mutated. Prove that all reads precede any possible overwrite of their source and that no array escapes until completion.
4. **Preserve the final consumers.** Evaluate `block_bound` with the exact source `within` predicate on every coordinate. Compute checksum in logical list order; a reverse fold `acc = r + 3*i + 9*acc` matches the recursive definition. Reconstruct a canonical result only at the boundary if requested. The diagnostic experiment must compare the complete final arrays as well as the final Boolean with stock, even if production later exports only the Boolean.
5. **Retain a fallback and isolate compilation.** A hand-written, small SML worker compiled by the existing toolchain is the first candidate. It avoids runtime source generation and a new general compiler. The dispatcher must require the exact supported source contract; unrelated CV requests retain stock behavior. Start in a separately named, raw-output structure as in the closure experiment. No experimental result enters a theorem constructor.

This subset is intentionally restricted. The source `block_layer` has additional short/unequal-list branches; the fast path does not discard them globally. Its validated equal-length domain avoids them, and all other calls stay on stock. Similarly, arbitrary effectful raw AST functions are outside the typed pure subset. A future general typed compiler needs a type/shape analysis with preservation under every call, not merely a type guess for the initial inputs.

## Acceptance and trust are separate decisions

There are two sound architecture choices, with different costs:

**Keep the installed trusted implementation unchanged.** The native worker is an untrusted producer. Its result is accepted only after the stock evaluator rechecks the exact result or an ordinary HOL proof/checkable execution certificate establishes it. Generic source equivalence does not supply that concrete execution fact. Replaying the whole computation can erase the expected checking-time saving; a compact certificate with a genuinely cheaper checker would be a separate, presently unproved optimization. A transcript hash or a successful external process is not a proof.

**Deliberately extend the trusted evaluator implementation.** After establishing and auditing the source/representation/array invariants, wire the validated typed fast path beneath the existing `Thm.compute` boundary. Preserve closed code-equation checks, hypothesis checks, tag propagation, result type and exact input equality. No new mathematical axiom need be introduced into HOL's theory, but the trusted implementation now includes the fast-path validator, integer/division bridge, array worker, encoding, host compiler/runtime and their binding to the executed artifact. A bug there can create a false theorem. It is incorrect to call this an unchanged trusted base merely because the theorem API and logical axioms are unchanged.

A proved compiler can reduce implementation uncertainty only with an exact source-to-artifact chain and its stated machine/runtime assumptions. Its theorem does not by itself assert that a particular external binary ran on these inputs and returned this output. That last execution/transport fact still needs checked evidence or an explicitly trusted execution bridge. The same applies to a theorem proving the two-buffer mathematical algorithm correct: the theorem does not automatically certify a host array loop.

The current proposal recommends raw experimental implementation first and leaves this acceptance choice explicit. It neither patches the installed kernel nor adopts a new axiom/oracle.

## What this can and cannot remove

Write current time as `P + D + R + A + O`, for preparation, AST dispatch, representation/list work, big-integer arithmetic, and final reconstruction/checking. Closure compilation primarily attacks D. The typed array worker targets D and much of R; it retains A, input binding and the required output work. With setup C and remaining non-arithmetic cost U, the prospective ratio is `(P+D+R+A+O)/(C+A+U)`, before any duplicate verification.

For a desired factor F on repeated execution, the fraction of old time spent in unchanged arithmetic alone must be below `1/F`; retained checking and setup tighten that necessary condition. Thus neither this proposal nor a general CV compiler justifies a large-factor claim without separating representation work from arithmetic. If A dominates, this design cannot meet the target even with perfect dispatch removal. Smaller precisions, fewer operations, faster multiplication or a different proof certificate would then be separate projects with separate mathematical contracts.

Compared with alternatives: emitting SML for untyped CV bodies removes dispatch but retains boxed arithmetic/list behavior; private arrays of CV nodes alone retain signed-CV arithmetic and introduce aliasing risk; a general typed compiler could cover more programs but requires materially more validation and semantic proof than this one worker. The narrow block worker is therefore the smallest experiment that tests both major overhead hypotheses together. It is not a certified FFT, a general spectral evaluator or a forecast.

A later authorized experiment should record decode/validation, typed arithmetic loop, encode/check, compilation and stock reference separately; bind exact source/input/output and executable bytes; test negative division/ties, zero layers/empty arrays, repeated rotations and malformed fast-path inputs; and preserve complete-output differential checks. No new run is requested by this note.

## Source pins

Local source is sufficient for this proposal; no external compiler-correctness claim is imported. Paths below are relative to `work/backend-costs-20261112/hol4-setup`, except the prior review.

| Source | SHA256 |
|---|---|
| `DependentBlockScript.sml` | `1A57F4025ED1A7B9C5A823D5F6B73B2A7BE02B109F21AD13D24214EA52D9D665` |
| `BlockRoundScript.sml` | `FF267EC688BDC4A4065DE0BD14D3BC109F60F2A0D86F99FAE89646D4212EF143` |
| `StageCheckScript.sml` | `019B156330F9E3623529F46705F7B5C4682C8E74456E293598F620EEE34AF26C` |
| `HOL/src/thm/Compute.sml` | `7DAB9DD6E848FDFE2EB7869865031CFDADBA44A2FB3D7E74D98CEA77F712E059` |
| `HOL/src/thm/Thm.sml` | `E0A9F3C274BAB9BE04922D83535A660833A6EF8409F9C02BA9610DDEDAE3FF45` |
| `HOL/src/portableML/poly/Arbnumcore.sml` | `E68E8D60BA443C3CBFBF151EC69B6C61D5D20C36AAC757FE3812E9FB34580E86` |
| `HOL/src/num/theories/cv_compute/automation/cv_typeScript.sml` | `FCE3DFB523A5445EB8C24276A497DEBACDE76BB6F7E1330A3A26D0A3E28D67A4` |
| `HOL/src/num/theories/cv_compute/automation/cv_primScript.sml` | `344DCC0FFB7071270819E366D027ADA5B449615EBE31A23B7CF7C6DC0CD8F28A` |
| `compiled-evaluator/REVIEW.md` | `04585762F957E620831B952A2109D62FF89C04DE3C40F49530627EF5CDA029B9` |
