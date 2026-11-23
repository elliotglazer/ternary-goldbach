# Streaming strict-sign brackets: bounded HOL4 candidate

This source implements a finite streaming producer/checker candidate. It is unbuilt, unexecuted and contains no actual function samples. It does not complete a Hardy-sign or zero-count theorem. Root retains exclusive control of builds. No new inventory, spectral evaluation or cost extrapolation was performed.

## Concrete representation and acceptance

Each input row is `(index,status)` with natural index and status0,1,2,3. Status0 means inconclusive;1/2 mean a supplied strict positive/negative claim;3 is an explicit break across which this stream may not bridge. A sign claim still requires a separate theorem about the actual named function. The checker rejects status>3, repeated/out-of-order indices and indices outside the closed declared window.

For a given function/channel and strictly increasing time map t(i)=t_base+Delta*i, Delta>0, start with no known sign, encoded anchor `(lower,0)`. On inconclusive status keep the previous anchor. On break clear it. On either definite status replace the anchor by the current sample. Emit `(old_anchor,current_index)` exactly when the two definite signs are opposite. Equal-sign samples replace the anchor without asserting that the interval between them is zero-free.

A numerical gap in indices is retained as a wide interval: it is not filled with invented samples. An inconclusive value inside a bracket does not invalidate opposite strict endpoint signs, provided continuity holds on the entire interval. If continuity/domain identity cannot cover a gap, emit a break row or separate the streams. No bridge crosses a break. The program never rounds an inconclusive status into a strict sign.

`consumes` is a linear validator for a proposed bracket list. Each emitted event consumes exactly its matching head; no event consumes none or two heads. At end of input the proposed list must be empty. The theorem candidate `consumes_iff_brackets` states its exact agreement with the deterministic producer for all input lists, not merely the toy examples. Its proof and the small simplification lemmas await compilation.

`accept` also checks the output chain: lower<=u<v<=upper, and each next left endpoint is at least the previous right endpoint. Adjacent open brackets may share a strict-sign endpoint, since that endpoint is not a zero. Their open interiors are disjoint. The output list is kept because downstream weight and source-binding proofs need its endpoints; `lower_count` is exactly its length. No count-only checksum replaces the output list.

`auxiliary_accept` strengthens only the emitted endpoints to lower<u and v<upper, matching the strict-inside auxiliary convention of the reviewed sparse certificate. It need not demand that every supplied sample is strictly interior; boundary samples may be present but cannot be endpoints of a counted auxiliary bracket under this variant.

## Exact combinatorial invariant and remaining proof obligation

The following is the direct inductive argument for the source algorithm, stated explicitly rather than disguised as an already compiled HOL theorem.

After each processed prefix:

- The anchor is absent or is a previously encountered definite sample after the most recent break. Its stored sign equals that sample's supplied status. Its index is at least the right endpoint of every emitted bracket, and at most the latest processed index.
- Every emitted pair consists of two input samples, in increasing order, with supplied opposite definite statuses. No break lies between its endpoints. No sample/endpoint has been invented or associated with a different channel.
- Consecutive emitted pairs satisfy v_previous<=u_next. Since input indices strictly increase, each pair has positive length. Hence the open intervals are pairwise disjoint.
- The recorded count equals the number of pairs emitted, not the number of all samples, all sign comparisons, zeros with multiplicity or unresolved intervals.

Induction cases are exact: status0 retains the state; status3 drops only the anchor; an equal definite sign moves the anchor right without emitting; a first definite sign installs it; an opposite sign appends one pair and makes its right endpoint the next anchor. The linear `chain` check independently enforces the length/order part even before this inductive invariant has been formalized. `consumes_iff_brackets` supplies producer-output identity. A HOL theorem exposing endpoint membership/opposite statuses from this invariant remains to be implemented; no current theorem exports an actual-zero lower bound.

The source `final_anchor` exposes the state needed between physical chunks. The intended exact split identity is

    brackets a s (xs++ys)
      = brackets a s xs ++ brackets a' s' ys,
    where (a',s')=final_anchor a s xs.

The final anchor of the full stream similarly equals the final anchor of the second chunk. This follows by induction on xs and is specified but not proved in this source. Until that lemma and a bound state handoff exist, accept a logical whole stream. A chunked implementation must additionally bind the previous last input index, the previous last bracket endpoint and the exact function/grid identity; require the next first index strictly greater, not replay the shared seam row. It may reset and lose a bracket conservatively, but may not double-count a seam bracket. Carrying only a claimed integer count is insufficient.

## Semantic lower count: explicit inputs

To turn m accepted pairs into m distinct critical-line zeros, supply all of the following:

1. One fixed actual real-valued Hardy function F for this channel, or a proved strictly positive-factor sign-equivalent proxy. Every status1/2 must be bound to an actual theorem F(t_i)>0 or F(t_i)<0. Complete source, phase, interpolation and arithmetic radii must be included. A proof that a center is positive alone does not suffice.
2. Continuity on every complete closed bracket interval and the strictly increasing index-to-time map. Opposite strict endpoints then give an interior zero by the intermediate value theorem.
3. The actual zero/analytic-order correspondence from F to the L-function on the critical line. Each represented zero has positive integer multiplicity. Disjoint interiors give distinct zeros; the count contributes one per bracket, irrespective of its possibly larger true multiplicity.

The generic IVT/cardinality/order bridge is not provided by the current module. The proof argument above explains precisely what must be formalized. Even-multiplicity zeros, a zero exactly at a sample, missing central zeros, and closed top-boundary zeros may go unrepresented. An inconclusive sign at zero is not a central-order certificate. Equal endpoint signs prove no absence. Thus m is only a conservative lower count, never exact saturation.

For symmetric nonprincipal carriers, a real-character positive channel contributes2m; a nonreal channel pairs with the actual inverse character's positive channel, contributing the sum of the two counts. This needs the actual conjugation/function/phase identification. Do not double a complex character's own positive count. Central evidence is separate and can conservatively contribute zero.

## Weighted auxiliary evidence and strict closure

`weight_ticks upper bs` computes sum(upper-v). With auxiliary_accept, no natural subtraction truncates a negative term. For t(i)=t_base+Delta*i and H=t(upper), multiply the integer result by Delta to obtain sum(H-t(v)). Each interior zero gamma<t(v) contributes at least this weight to the relevant integrated count. Apply the real/nonreal channel factors only after the actual carrier correspondence is proved. Different grids need separate rational conversion, not a raw sum of ticks.

The reviewed finite-RH pair-deficit source permits K+2 only when K is supported on actual critical-line zeros, the total carrier is complete and finite with positive multiplicities, and it is invariant under rho ->1-conj(rho). With the actual Turing/phase upper bound it gives

    U=(Abar+2b-W)/h,  h>0,
    U<K+2, equivalently W>Abar+2b-h*(K+2).

The inequality is strict. Equality is failure/incomplete. The checker here supplies neither Abar, b, the actual carrier, reflection, nor the Turing theorem. The cited pair-deficit result is independently reviewed paper/source mathematics, not a supplied HOL4 implementation. No executable `K+2` acceptance is therefore added to this module.

Where those hypotheses are available, success proves finite RH while allowing one unrepresented critical multiplicity. It does NOT prove C=K or a complete zero list. Do not impose an extra exact-count requirement merely to use this lower-count stream. Conversely, an actual exact-count consumer must keep U<K+1 or a separate exact certificate. Principal positive-ordinate and symmetric counts must not be mixed. The current HOL4 implementation still has to prove these analytic joins; the module alone cannot remove that cost.

## Work and next bounded check

For n supplied rows and m emitted pairs, producer and validator each inspect rows once; emitted pairs are consumed once. Order/range and chain checks add linear passes; exact natural comparison/addition cost depends on index bit widths. Producer storage is O(m) in the simple functional list implementation, with recursion/stack and exported proof/representation costs not measured. Constant-state counting alone would lose endpoint evidence unless accompanied by a proved accumulator/streaming consumer. This is a candidate implementation, not a memory or runtime guarantee for the compiled evaluator.

Root may build only the owned target with the existing setup runner and canonical Holmake, `--no_prereqs SignBracketStreamTheory.uo`, with the usual serial resource policy. No benchmark data or runner has been launched. First review/build should validate the generic proof and CV translations, then a tiny exact synthetic control list may check: empty, all unknown, repeated index, invalid status, equal-sign run, opposite signs across unknown/gap, explicit break, shared endpoint, leftover/omitted pair and endpoint-outside-window. Synthetic tests are not actual Hardy inputs and cannot establish zero counts. The meaningful later measurement must consume actual certified compact sign outputs and charge their binding plus the eventual Turing closure.

## Consumed sources

`work/backend-costs-20261112/hol-platt/RESEARCH_PLAN.md` SHA256 `6E1D7D3D6DD28C035F9044B423066DFB1C6F06BD28B35231F8AFDF56DFE75309`.

`work/qrh-campaign/agents/zero-sum/SPARSE_AUXILIARY_CERTIFICATE_SCHEDULE_2026-11-11.md` SHA256 `63E77B1CACD9209FB7D475F6CAA8C0D097281F6CA7B5F19475BD02827B8F0CCD`.

`work/qrh-campaign/agents/integration/R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md` SHA256 `F718551E44C343FB874AAD919290D002F402760B5B6B44772B534C087AF2D054`.

`work/qrh-campaign/agents/independent-feasibility/REVIEW_FINITE_RH_PAIR_DEFICIT_2026-11-11.md` SHA256 `97645AB7A3A9EC3B807DD4BFDD022175455A0F1DEF46F676141E6C587164C7E5`.

`work/qrh-campaign/agents/audit/LARGE_BRANCH_PRECISION_REPAIR_POLICY_2026-11-11.md` SHA256 `CEE051ACA50EBFF46E422E104B4978603FFD7CA427672B30FF8AC1529841D567`.

`work/backend-costs-20261112/hol-platt/count-stream/SignBracketStreamScript.sml` SHA256 `B75C3B83BC06C02EB12C528593D86A40CB91C9C93048D69D15C796F9480C9ED9`.


## Explicit producer-status adapter

Integration entry C10004_IMPLEMENTATION_ENTRY uses 0=negative,1=inconclusive,
2=positive, whereas this stream deliberately retains its earlier convention
0=inconclusive,1=positive,2=negative,3=break. The original stream source is unchanged.
ProducerSignAdapterScript.sml supplies an option-valued boundary: 0->SOME2,
1->SOME0,2->SOME1; every larger natural is NONE. It is not a cast, arithmetic
relabeling without bounds, or permission to reinterpret malformed3 as a break.
A break must be supplied by the stream's separately checked domain policy.

The generic source theorem strict_implications_preserved takes the actual
producer strict-sign implications as premises and transports exactly those
implications to the stream codes. The boolean parameters negative/positive can
be instantiated with F(t_i)<0 and0<F(t_i); no new real/Hardy theorem is asserted.
The producer's nonnegative radius and true enclosure hypotheses remain needed
at its classification theorem. Unknown_exact identifies inconclusive status
exactly. Row adaptation fails closed and preserves sample indices.

All-inconclusive inputs map to all stream zeros, emit no brackets, and have no
strict output. If the structural producer_accept succeeds, the lower count is
zero. That structural success is not a successful numerical/sign benchmark or
finite-RH closure. A numerical success policy must also demand an actual strict
sign certificate or the separately justified count surplus. No theorem here
claims that an unknown value equals zero.

All adapter theorems are unbuilt source candidates. No compiler acceptance is
claimed. The stream's T tokens occur only as the HOL true constant in empty/
singleton predicates; no binder or arithmetic variable is named T. The adapter
uses lower/upper/code/status names and never binds T. The type-fixed nat code is
explicit at the decoder boundary.

Producer entry pin: `39A56BC353085AEF781B510B06D8683DBFFEFC56D6E6DBB54F59ABD927609717`.
Adapter pin: `0EC64688BFF01CCE0EBBEDA41078259A8CA1ED354E7F3F1C0E1B61CF61884B05`.
