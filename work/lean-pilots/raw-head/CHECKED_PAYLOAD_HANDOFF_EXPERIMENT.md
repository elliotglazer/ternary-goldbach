# Checked producer-to-consumer payload handoff

13 November 2026 UTC. Bounded design from static source inspection only. No build, model execution, producer values or timing run. This is separate from `COMPUTED_BLOCK_EXPERIMENT.md`, whose matched full source-trace export remains unchanged.

**Question:** can the exact integer output of a checked raw-state producer feed a checked raw-head consumer without an intermediate literal-to-evaluator translation? The pinned HOL APIs support a plausible implementation. Its performance and complete analytic source closure are unproved here.

## Actual API evidence

Source root: `work/backend-costs-20261112/hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/num/theories/cv_compute/automation/`.

- `cv_repScript.sml:13`–`:17` defines `cv_rep p y f x` as `p ==> f x = y`. This is a proved representation relation, not a native-memory or hash oracle. `cv_rep_eval` at lines31–37 requires both that relation and a `from_to` theorem before yielding the decoded HOL equality.
- `cv_repLib.sml:18`–`:32` matches local and registered `cv_rep` theorems, instantiating the actual HOL term and encoder. Lines45–122 recursively discharge representation requirements; a bare cached byte array is not such a theorem.
- `cv_transLib.sml:973`–`:1002` implements evaluation: derive the representation of the closed term, obtain the type conversion theorem and code equations, run `cv_compute`, and normally decode the result with `EVAL`. Thus ordinary `cv_eval producer_term` followed by printing and redefining its result exposes a conversion boundary that a composed term can avoid.
- `cv_transLib.sml:1003`–`:1069` provides an explicit alternative: `cv_eval_pat (cvName name) producer_term` computes the represented result, defines a named cv value and corresponding HOL object, and saves a `[cv_rep]` theorem. It charges definitions, proof transport and registration; it does not make them free. Subsequent representation lookup can use that registered theorem. The exact generated term, preconditions and code equations must be inspected. `cv_eval_raw` alone merely avoids final decoding; its equality must still be connected to a later consumer.
- The current `DependentBlockScript.sml:24`–`:28` already passes one computed layer to the next. Its `block_accept` at lines104–110 uses a let-bound result internally. Translation/precondition proofs at lines122–148 show the existing mechanism. This establishes a source pattern, not a benchmark of a new raw-head handoff.

Use the simplest path first: one translated HOL definition `pipeline inputs = consume (produce inputs)` and one checked evaluation of its exact final-output claim. Do not decode, print or redefine `produce inputs` between the functions. No new trusted primitive is proposed. Whether the implementation shares rather than recomputes repeated subexpressions remains a measurement and source-inspection obligation.

## One matched end-output experiment

Reuse the separate recurrence experiment's eight bases,128 steps, state grid120, step grid122, four-product `mulStep`, inverse-root initializer and fixed tie rule. Both treatments use identical accepted seed/step integers and identical producer/consumer definitions. No new size sweep or alternate multiplication algorithm.

The consumer takes the producer's eight ordered traces and outputs the four raw heads with numerator bases `1,2,3,41`, denominator base61, at every height index0 through128. The common output is an ordered4-by129 array of **all516 actual integer pairs**, not a checksum. The eight-base producer remains the same in both treatments; no irrelevant base is silently removed from only one treatment.

For state numerators `u = Z[c,j]` and `v = Z[a,j]`, the exact grid100 consumer is

    (roundDiv (2^140) (c * (u.re*v.re + u.im*v.im)),
     roundDiv (2^140) (c * (u.re*v.im - u.im*v.re))).

This is nearest rounding of `c * conj(denote120 u) * denote120 v`: the product grid is240 and the output grid100. The conjugation sign and denominator are mandatory. It matches the raw-head producer audit's `c*conj(Bc)*Ba` identity; no approximate complex division or downstream conductor normalization is inserted. Prove the integer/denotation equality and rounding residuals generically before use.

**Materialized boundary:** evaluate the producer, decode its entire1032-pair trace, construct the literal trace definition and establish its exact equality to the producer. Translate that literal into the consumer's evaluator representation; evaluate the consumer. Compose the producer equality and consumer result into the common closed theorem `pipeline inputs = literal_final_heads` with exact dimensions/order. Charge all intermediate decoding, construction, binding, translation and proof composition. This is a deliberately explicit source/consumer boundary, not a claim that every existing HOL implementation uses it.

**Fused boundary:** evaluate the translated `pipeline inputs` directly, proving equality to the same literal516-pair final output. The producer's result stays inside the evaluator; its intermediate HOL trace literal is neither an input nor an exported claim. The final literal output, its decoding/equality and all seed/source bindings remain mandatory. Both variants prove the same end-output proposition and generic integer residual/recurrence consequences. The existing full-trace recurrence test is a different contract and cannot supply the denominator for this speed comparison.

For reuse by several later consumers, the `cvName` path is a possible *separate* follow-up: retain the computed representation theorem and compare its registration/reload cost with fresh translation. Do not add it to the initial two-treatment experiment or assume persistent cross-process state. A name that expands to the original producer may still induce recomputation unless the registered evaluated representation is actually selected.

## Analytic gate and trust boundary

The current actual log/step/source proofs are Lean artifacts, not HOL analytic theorems. A HOL integer-program correctness and end-output equality experiment must label its initial/step integers as the matching source fixture; that alone does not prove they approximate `integerPower`. It may close the computational handoff question while leaving an explicitly unpriced analytic port. Do not call its closed integer theorem a closed analytic raw-head theorem.

To upgrade it, prove the HOL positive-real logarithm/complex-exponential identities, actual seed and step enclosures, accumulated recurrence error, and raw-head error/rounding join. Then discharge every premise for the concrete fixture and export the corresponding analytic bound on all final heads. Include that port's library and concrete acceptance costs. Neither the source hash nor a Lean theorem name is a cross-foundation proof. Ordinary HOL axioms, hypothesis/oracle audits and exact source/grid/output binding remain required.

Controls must reject a changed seed, step, base/denominator label, source row/index, final head and final array shape. Check negative-round and tie cases independently. Resource failure is not mathematical rejection. Audit exact final theorem equality between variants, not just matching native arrays. Preserve failed attempts and require both implementations to satisfy the same resource limits.

## Measurements and what they would replace

Record generic library/translation cost, actual seed/step generation and admission, untrusted intermediate/final proposal generation, literal construction, representation derivation, evaluator execution, final decoding/binding, proof composition, export bytes, live memory and cold process costs separately. Report full first admission and the incremental handoff with shared source costs explicitly identified. A source computed solely inside acceptance is still paid there; do not subtract it again as a free initializer. Repeated runs of the same named object measure warm reuse, not fresh-payload translation.

The required comparison is the total extra boundary cost versus any extra fused execution/library/output cost, for the same final theorem. Eliminating the intermediate translation while increasing recomputation or final proof construction may lose. No refund follows merely from fewer literals or theorem declarations.

The 227.5367281304526-core-year HOL planning proxy in `end_to_end_model.py:119`–`:122` charges a fresh192-object input/coefficient translation per100 notional8192-operation spectral blocks. Its 4.269485-second anchor sums two `cv_trans` calls, excluding separately timed literal construction (`hol4-setup/summarize_dependent.py:111`–`:113`). This raw-head test measures a concrete different boundary. Even success does not replace that whole row.

Evidence that could replace the proxy is: an actual spectral dependency partition; exact data/coefficient identities; counts of **fresh translations and retained/reloaded representations by lifetime**; matched source-to-consumer analytic joins; and measured construction/translation/binding costs for those actual widths and sizes. Distinguish root-cache admission from runtime input admission so a shared coefficient is not refunded twice. Include process/shard reloads and exact seam/error transport. The four-head consumer tests the mechanism, not those population counts or a transform's source payload. No forecast, speed factor, larger experiment or automatic adoption is authorized by this design.
