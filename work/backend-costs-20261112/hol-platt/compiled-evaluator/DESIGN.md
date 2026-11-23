# Compiling the HOL compute AST to SML closures

2026-11-13. Source-only proposal and isolated, **unbuilt** prototype. No HOL process, benchmark, theorem acceptance, or installed-kernel modification was performed. The Python preparation step only copied and transformed text after checking the source hash.

## Decision

This is a feasible next experiment: translate each finite `cexp` body once into an SML function `cval list -> cval`, link the functions through a private table, and retain that table with the existing prepared conversion. Recursive code remains recursive; the translator does not unfold calls. Repeated execution then avoids matching the `cexp` datatype at every visited expression.

There is an important limit to the proposed mechanism. **Stock `Monop` and `Binop` already store SML functions.** Their operator-enumeration dispatch is performed during AST construction, not on every arithmetic operation. The proposed compiler removes expression-constructor dispatch and traversal, not a second arithmetic opcode interpreter. It retains native `Arbnum` arithmetic, `Num`/`Pair` inspection and allocation, list environments, argument lists, indirect closure calls, and recursive program work. No speedup estimate is justified by the existing measurements.

## Pinned implementation and trust boundary

Paths in this section are under `work/backend-costs-20261112/hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/`.

| Source | Relevant facts |
|---|---|
| `src/thm/Compute.sml:79–175` | Internal values/expressions, interpreter, exact primitive semantics. |
| `src/thm/Compute.sml:577–646` | Characteristic-equation checks, parsing code bodies, then parsing and evaluating each requested term. |
| `src/thm/Compute.sig` | The opaque public interface exposes `term_compute`, not the internal AST. |
| `src/thm/Thm.sml:1515–1555` | The theorem-producing caller checks hypotheses/tags and result type, then uses `make_thm Count.Compute`. It does not replay every arithmetic operation as a separate ordinary inference. |
| `src/portableML/poly/Arbnumcore.sml:11–13` | Poly/ML numbers are implemented using `IntInf`. The stock evaluator already uses host arbitrary-precision integers. |

Compute SHA256: `7DAB9DD6E848FDFE2EB7869865031CFDADBA44A2FB3D7E74D98CEA77F712E059`.

Thm SHA256: `E0A9F3C274BAB9BE04922D83535A660833A6EF8409F9C02BA9610DDEDAE3FF45`.

Replacing `Compute.term_compute` inside this path changes a trusted implementation. Keeping its API and using the same SML runtime does not avoid that change. Differential tests can support an implementation audit but cannot establish universal equivalence. The experiment is deliberately a differently named structure with raw-value/raw-term outputs only; `Thm.compute` continues to refer to the original `Compute`.

## Exact translation

`ClosureCompiler.sml.inc` contains the proposed translator. The operational cases are:

* `Const`: produce `Num n` when invoked, without constant folding.
* `Var`: call the unchanged `env_lookup`. In particular, stock negative indices select the first entry, whereas an empty environment raises the stock error. Substituting `List.nth` would change this behavior.
* `Monop`: evaluate the compiled child and invoke the exact stored function.
* `Binop`: first evaluate the left child and apply the first stage of the curried function; only then evaluate the right child and apply the resulting function. This even preserves the order observable by arbitrary effectful functions embedded in a raw AST. The legitimate parser-generated primitive functions need no new arithmetic implementation.
* `Let`: evaluate its bound expression once and cons the value onto the same environment representation.
* `If`: inspect the condition once. Only `Num n` with nonzero `n` takes the first branch; `Num 0` and all pairs take the second branch. The unused branch is compiled but never evaluated.
* `App`: compile its argument expressions once. At runtime evaluate them left-to-right with the stock accumulator/reversal order, then obtain the function body and call it on exactly that argument list. Lookup remains after argument evaluation, preserving the stock order of exceptions. Tail-position calls remain syntactically tail-position calls.

`prepare_closures` allocates a private optional vector reference. Compilation closes over its lookup function but never calls it. Once all bodies have been compiled, it stores the complete vector and publishes only the expression compiler. Thus mutual recursion and self-recursion need no source unfolding or SML source generation. The reference is not exposed or subsequently modified. Its `NONE` failure must be proved unreachable for all published runners. Out-of-range function indices still use stock `get_code` and its exact exception; there is no eager validation of unreachable bad calls.

This initial design uses one table lookup/reference read per call. A later backpatched per-function cell might remove some overhead, but would add linkage obligations and is outside this prototype. There is no dynamic invocation of another compiler: the ordinary host SML compiler compiles the translator itself, and runtime translation constructs closures.

## Equivalence obligations before any trusted replacement

1. **Publication and linkage.** For each original body index, the published vector contains exactly its translation under the same lookup. Compilation terminates on finite ASTs and never calls an unpublished runner. Code order and every `App` index are unchanged.
2. **Expression simulation.** Given related code vectors and identical environments, a terminating stock evaluation and the compiled runner return structurally equal `cval`s. Prove this by induction on evaluation derivations, with an argument-list lemma; AST induction alone cannot justify recursive calls.
3. **Evaluation order and exceptions.** Prove the same user/primitive exceptions occur in the same order. Include partial curried `Binop` application, pair-valued conditions, division/modulo by zero, argument evaluation before missing-code lookup, and unchanged variable lookup. The original stored functions are reused rather than reimplemented.
4. **Recursive behavior.** For a claim covering divergence, use a suitable operational simulation/bisimulation, not just equality on returned results. Tail-call shape is helpful for engineering but is not such a proof.
5. **Frontend preservation.** Retain characteristic-equation checks, code-equation parsing, numeral interpretation and `cv_to_term`. A future kernel patch must also preserve `Thm.compute`'s hypothesis checks, tag merge, type check and theorem construction boundary. The experimental duplicate frontend is not itself authorization to patch that path.
6. **Resources and state.** The semantic claim must exclude identical allocation, stack exhaustion, interrupts, or out-of-memory timing. Compilation visits unused branches and allocates closures before evaluation; consequently those resource behaviors can differ. Actual SML exception/GC/runtime assumptions must be explicit in an implementation audit. No persistent user-visible mutable state is introduced by the private linkage table.

The project needs to choose its assurance standard for this trusted change. A reviewed operational proof tied to the implementation and extensive differential testing is stronger than tests alone, but is not a kernel-checked compiler-correctness theorem. A formalized evaluator/translation theorem plus a trusted extraction/execution bridge would be a further project. Neither exists in this packet.

## Isolated prototype and later test boundary

`prepare_prototype.py` checks the pinned Compute bytes, writes exclusively into this directory and preserves installed source. It produced `CompiledComputeExperiment.sml` and `source_binding.json`. The generated structure has a different name and no opaque `Compute` ascription, so its AST is available for explicit test construction. It copies the stock interpreter, primitives and frontend unchanged, inserts the closure compiler, and adds a duplicated frontend named `prepare_term_comparison`.

For a fixed validated syntax configuration and raw code-equation list, `prepare_term_comparison` constructs one shared `code` vector. Its returned function parses a request once into one shared AST, compiles it outside the timed thunks, and returns:

* `stock_cval` and `compiled_cval`: the two raw evaluators;
* `stock_term` and `compiled_term`: the same evaluations followed by identical `cv_to_term` reconstruction.

`prepare_cval_comparison` also accepts a raw shared AST/code/environment directly. These entry points return no theorems. Raw code equations must not be confused with the authenticated, closed theorem inputs of `Thm.compute`.

The first later build should only establish that this isolated source typechecks in the pinned HOL environment. Before timing, exercise all constructors and primitive edge cases, nested `Let` shadowing, argument order, dead invalid branches, erroneous lookups, self-recursion and mutual recursion. Use bounded terminating programs for equality tests; divergence tests only provide bounded observations. A failing result or unexpected exception invalidates a sample. Parsing once and sharing an AST must be confirmed in the fixture, not inferred from equal printed terms.

For the actual workload, obtain the exact same code equations and request AST used by the existing dependent-butterfly fixture, compare complete returned values/terms, then time raw evaluation separately from term reconstruction and compilation. Include first-use compilation and retained use as separate rows; vary process/mode order and record GC and memory. Do not replace theorem acceptance with the compiled output during this experiment. Stock `Thm.compute` can independently supply theorem results where needed, but running it as verification would preserve its evaluation cost.

No SML typecheck or differential test has yet run. The generator's Python execution is only a source-preparation check. An initial `python` launcher attempt failed because the WindowsApps alias was unavailable; the existing `work/qrh-campaign/interval-env/Scripts/python.exe` then completed preparation successfully. No packages were installed.

## Cost and realistic limits

Let `S` be the total static AST size, `V` the number of runtime expression visits and `A` the number of dynamic function calls. Translation costs O(S) construction and retained closure storage, plus one traversal of each request AST. It replaces V constructor matches/traversals with closure calls; A calls still incur lookup and argument-list work. No claim follows about the sign of the constant-factor difference. The code-vector and request-AST lifetimes also affect retained memory; this fixture intentionally retains the original AST for comparison.

The reviewed prepared-eval smoke (`../prepared-eval/RESULT_REVIEW.md`) measured depth128 medians of 0.080017 CPU seconds stock versus 0.065880 retained, with overlapping sample ranges. Its retained evaluation/transport phase was about 0.040–0.047 seconds and did not isolate interpreter dispatch from arithmetic or reconstruction. Initial literal translation cost seconds. Those data neither predict a closure-compiler gain nor justify reducing representation, spectral-evaluation or whole-campaign costs.

This workload includes bigint products, signed-value branching, division and pair/list reconstruction. All remain. SML closures can themselves cost allocation, indirection and instruction-cache space. A translator may help repeated small control operations more than expensive bigint operations; that is a hypothesis for same-AST timing, not an observed result. Avoiding redundant divisions, specializing representations or changing arithmetic algorithms would be separate changes with separate correctness obligations.

The bounded next action is therefore **an isolated typecheck and semantic differential test, followed by the same-AST raw-evaluation experiment if it passes**. No installed-kernel change is proposed for immediate acceptance.

## Output pins

| File | SHA256 |
|---|---|
| `ClosureCompiler.sml.inc` | `08BC1B75AD3AB92D0B51DEF4A1787A3A106D18919F6786D0FBBFA38CB94D2015` |
| `prepare_prototype.py` | `6FE40ADF30E7433D0C2D6767F1DBC0AEE157B738B7DFEFB95F015E7982C16452` |
| `CompiledComputeExperiment.sml` | `F4CA87E8DAD81EBE6096051215286A16C3B9826F789995BAB916BB65F63A4915` |

These pins identify source candidates, not accepted evaluator binaries or proof artifacts.
