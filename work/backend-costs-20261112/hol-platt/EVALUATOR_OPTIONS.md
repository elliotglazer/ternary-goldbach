# HOL4 evaluator options for the dependent arithmetic block

## Conclusion and scope

The measured 128-layer ratio is about 19.7, but the existing measurements do not identify a 19.7-fold arithmetic-kernel penalty. They time `cv_eval` plus theorem transport and precondition closure against compiled C++/GMP. The pinned implementation exposes removable preparation work, interpreter/data-structure work, and different signed-division schedules. It does not establish their individual time shares or a route to historical Platt cost.

This is source-only research. No build, benchmark, numerical evaluation, dependency edit or candidate execution was performed. Only this report was written. Source checkout commit is `1de64f8521b4758508bd875fbaf11d1768261b92`. The older measured report is retained unchanged. The ongoing source/transform/closure program in RESEARCH_PLAN remains necessary.

## What was measured

DEPENDENT_BLOCK_REPORT records 128 layers, 64 butterflies per layer, 8192 butterflies, and a maximum retained coordinate size of 418 bits for the P343 fixture. Pooled median HOL CPU is 73.960 ms versus native 3.747830 ms. HOL observations span 64.013–123.944 ms, and the three process medians differ substantially. The smaller-depth medians are nonmonotone. Those facts rule out treating a fitted fixed intercept or a per-operation ratio as measured evidence.

HOL timing includes `cv_eval`, closure of its precondition, and checks that the resulting equation names exactly the requested term and returns true (`dependent.sml:33–44`). The existential mathematical conclusion is derived separately and cheaply. Native timing includes input copying, all layers, output bounds and checksum; decimal parsing is outside it. The native every-coordinate reference comparisons are validation outside the timed `accept` call, not a second full output comparison inside each timed call (`dependent_native.cpp:54–79`).

The result is an existential final vector with the full inductive local-residual contract, length, bounds and checksum. The checksum is not an injective encoding of the vector. This is not a certified FFT: the arbitrary coefficient schedule, rotation and increasing coordinate widths are not an actual Platt transform or a measured production precision profile.

Named literal preparation separately costs median 4.269485 CPU seconds per fresh HOL process. It is not inside each 73.960 ms call. It must nevertheless be charged when new payloads require new representation proofs. Neither its removal nor a reuse factor is established by the block timings. The whole-process time, imports and export are separate again.

## What the evaluator actually does

1. `cv_transLib.sml:973–1002` obtains a representation theorem for the closed requested expression, a from/to theorem, relevant CV equations, and a fresh `cv_compute cv_eqs` conversion. It applies the conversion and finally EVAL to return to the original result type. Here that result is boolean, so final decoding does not reconstruct all 128 output pairs into HOL integer syntax. The final vector is used internally before a compact acceptance result is returned.
2. `cv_computeLib.sml:132–146` caches the initialization that checks characteristic equations and symbols. This is real existing caching; proposing to cache those again is not a new optimization. In contrast, each invocation with code equations passes through `Thm.compute` and `Compute.term_compute` to build the code vector for that equation set.
3. `Compute.sml:621–639` gathers function symbols, validates/destructs equations, translates bodies to indexed expression trees, then returns a conversion. Each application parses the supplied term, executes the tree and reifies its result. Retaining this conversion can retain the validated code vector. It does not automatically retain already evaluated literal argument values or prove a new call without execution.
4. Execution (`Compute.sml:71–158`) interprets `Const`, `Var`, `Monop`, `Binop`, `App`, `If`, and `Let`. Variables use recursive linked-list environment lookup. Applications evaluate a list of arguments and reverse it to form a new environment. Let extends that list; pairs are heap objects; arithmetic wraps and unwraps `Num`. This is substantially different from the native loop's direct accesses and mutable GMP temporaries. The code vector lookup is indexed, not a linear function-name search on every call.
5. Arithmetic uses `Arbnum`, whose Poly/ML core opens `IntInf` (`portableML/poly/Arbnumcore.sml:8–23`). It is not Peano successor arithmetic at each multiplication. The inspected source does not establish equality of the underlying bigint implementation, allocation pattern or instruction mix to this C++/GMP baseline. Do not infer that from the common phrase “arbitrary precision.”

`Thm.sml:1515–1561` is particularly important to the trust and cost interpretation. It rejects equation theorems with hypotheses, merges their tags, invokes the internal evaluator and constructs one `Count.Compute` theorem for the resulting equality. It does not issue an externally visible primitive theorem for each arithmetic gate. This is the stock HOL4 trusted computation primitive, with checked characteristic equations. Its acceptance is ordinary for this pinned HOL4 kernel; it is not an independently replayed trace of elementary inference steps. Saved `.dat` loading likewise remains the existing HOL4 import trust model.

Therefore changing the trusted evaluator or giving it an unverified native-answer shortcut is not an ordinary theorem-level optimization. The admissible options below leave this primitive unchanged and prove any new translated computation equivalent to the old mathematical function.

## Concrete work differences, without invented counts

`BlockRoundScript.sml:34–42` already uses three wide real products per butterfly. A proposal to replace four by three would not improve this baseline. Its mathematical gate schedule has three coefficient/data products and two signed floor divisions, plus presums, combining sums, output sums and scale arithmetic. For 8192 butterflies this is 24576 wide product sites and 16384 floor-division sites. These are source-level dynamic gate sites, not measured `IntInf` call counts.

`cv_primScript.sml:304–446` represents a nonnegative integer by `Num` and a negative integer by a `Pair` carrying its magnitude. Signed addition/subtraction chooses branches and may compare magnitudes; signed multiplication checks zero and signs before a magnitude multiplication. Those representation operations are additional interpreter nodes. Zero shortcuts can reduce actual bigint work, so even the 24576 sites need not mean exactly that many magnitude multiplications.

For positive denominator d, `cv_int_div` computes one magnitude DIV when its numerator is nonnegative, but a DIV plus a MOD and correction when it is negative. Native uses one `mpz_fdiv_q` per coordinate. Thus the translated two division sites can entail two to four magnitude division/remainder operations per butterfly, depending on signs, if those equations are executed without further specialization. The measured report does not record negative-numerator counts or the final translated call graph. There is no justified assertion that these divisions dominate time or that DIV/MOD each have the same native cost.

`round_scaled` spells out `(2*r+s)/(2*s)`. Native hoists `2*scale` once before the layer loop. Source HOL calls round_scaled twice per butterfly, so repeated scale arithmetic is a candidate for specialization; it is not evidence of two actual wide multiplications, since tiny constants, translation and runtime shortcuts matter. Coefficient presums wr+wi and wi-wr are also layer-invariant in both programs but remain in both inner loops.

`block_layer` builds a fresh linked result; `block_rotate` uses `xs ++ [x]`, traversing and rebuilding the list spine. Native uses two vectors with swap and an in-place rotation. This supports an allocation/dispatch hypothesis, not a numeric allocation count or an asymptotic win for this fixed vector size. The CV interpreter does not have a general memo table: retaining an equation for a nullary named literal avoids source proof regeneration but need not preserve its evaluated CV object between calls.

The result reifier caches the 256 small numerals (`Compute.sml:333–354`). Large returned values need numeral syntax construction, but this boolean-returning benchmark is already designed to avoid a large final syntax expansion. Replacing it by a raw-vector result merely to skip EVAL would change the measured contract and may increase that cost.

## Admissible options and their limits

| Option | Mechanism and required proof | Evidence and remaining uncertainty |
|---|---|---|
| Retain a prepared conversion for the exact equation set | Reuse stock `cv_compute cv_eqs`; keep representation/from-to theorems and apply ordinary transport afresh to each supplied term | Source proves code-vector construction is outside the returned conversion. Saving is unmeasured; exact code dependencies, context and term must remain bound. No cached final-answer theorem substituted for recomputation. |
| Positive-denominator signed quotient specialization | For integer n and natural d>0, prove n DIV d equals magnitude DIV for n>=0 and `-((a+d-1) DIV d)` for n=-a<0; translate that proved function | Removes the explicit MOD branch, trades it for addition/subtraction and possibly wider numerator. At a multiple of d and at negative ties the proof must preserve floor, hence existing round semantics. Cannot assume it is faster. |
| Hoist denominator and coefficient presums | Prove specialized butterfly with stored d=2s, wr+wi, wi-wr equals current butterfly; compute/cache these from the original bound coefficients | Same mathematical output; setup, storage, cache binding, changed input decoding and native matching implementation must be priced. Generic preconditions remain discharged. |
| Fuse traversal/rotation or retain encoded intermediate data | Prove exact list equality and residual-contract transport; use a suitable CV representation with ordinary representation theorems | Could reduce list allocation and decoding at boundaries. Does not permit an unchecked mutable buffer. The existing handoff work already tests a representation boundary, so do not repeat it as a “new” scalar benchmark. |
| Produce actual source/coefficient values inside the proved program | Use certified source definitions and cache their representation within the legitimate lifetime | Targets separately measured literal setup and import/export overhead. It is not a measured reduction of the 19.7 ratio and must retain actual analytic/source identities. |

Compilation of expressions to native code, adding a signed bigint primitive, or replacing the interpreter by another runtime would alter the trusted implementation unless a checked simulation/translation or a separate validated certificate is supplied. These may be research directions, but no present speed credit or ordinary-proof compatibility is established. Likewise an external GMP vector accepted through a hash or “oracle equality” is not an option.

## One useful next test

Prepare one matched **conversion-lifetime experiment**, without editing HOL4 dependencies. It isolates code/representation preparation from execution rather than producing another undifferentiated scalar ratio.

Use exactly the existing depth-128 term, definitions, output proposition and controls. Outside timed application, obtain the exact CV representation theorem, required equations, from/to theorem, and prepared stock conversion once. Apply that conversion anew on each measured call, perform the same theorem transport and precondition closure, and check the exact requested original proposition. Do not reuse the theorem from a previous final evaluation. Assert empty hypotheses and the same permitted tags/ancestry; compare the resulting original proposition to the baseline and rerun all five corruptions through their correctly bound terms.

Record separately: representation/equation discovery, creation of the prepared conversion, each application including input parsing/evaluation/reification, return-to-original-type transport, precondition closure, and total first-call versus repeated-call cost. Fresh process trials and GC/allocation information, where the runtime already exposes it, should accompany CPU/wall values. Do not alter the kernel to insert timing callbacks; the conversion call is one measurement boundary, so parser/executor/reifier remain an unresolved combined phase unless a separately reviewed profiling tool can distinguish them. Retained conversion/code memory and cache invalidation on changed equations or imports must be reported.

This test is useful if the goal is repeated different calls sharing an equation set, not just repeated proof of an identical constant result. The first exact baseline call supplies the matched control; later distinct inputs require corresponding valid binding, not a new native-memory oracle. There is no speed assumption. If preparation is negligible, prioritize a separately proved single-quotient round specialization rather than repeatedly changing batch size. That successor would compare the identical full depth-128 function, with exact generic equality proved once and unchanged final contract; its diagnostic counters must distinguish negative-numerator DIV/MOD sites from total butterfly count.

## What remains needed for the Platt goal

No source inspection allocates the roughly 70 ms difference among interpreter dispatch, bigint work, GC, code preparation and theorem transport. There is no defensible factor to apply to the full weighted family. Actual FFT geometry, production precisions, root/kernel/source costs, signs, retries, zero counts and endpoint completeness remain required. The reported 19.7 ratio is neither an implementation lower bound nor a certified whole-proof upper bound. Even perfect elimination of repeated preparation cannot remove one-time source representation, library, export and finite prime-coverage costs.

## Source pins

The following files were read directly. Line references above use these bytes. Paths below are relative to `work/backend-costs-20261112`.

| File | SHA256 |
|---|---|
| `hol4-setup/DEPENDENT_BLOCK_REPORT.md` | `E24815D2D36AA4EDAF929FC12CB0541D1B31E26A1606C110D654CBCCBA788908` |
| `hol-platt/RESEARCH_PLAN.md` | `27702B07D92908236F9E69F5BA079602AF072AA85497AA03F97A0FE1B434D3FF` |
| `hol4-setup/source.json` | `BB2A6678BE0FCBBC7044673EDA0CD902EF4DF53392EE4B4A85E8F3EB97062D98` |
| `hol4-setup/DependentBlockScript.sml` | `1A57F4025ED1A7B9C5A823D5F6B73B2A7BE02B109F21AD13D24214EA52D9D665` |
| `hol4-setup/BlockRoundScript.sml` | `FF267EC688BDC4A4065DE0BD14D3BC109F60F2A0D86F99FAE89646D4212EF143` |
| `hol4-setup/dependent.sml` | `ECB62C8C7B1F1AAAA8DF9617DAF4145D7FCADBEEDD9CF8579D3F57962C5E1AB1` |
| `hol4-setup/dependent_native.cpp` | `69C79AE3FE466CCAB0B97914AFB8CC09A0BDAC8FB3BDAE94DF38D47FB6E99887` |
| `hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/thm/Compute.sml` | `7DAB9DD6E848FDFE2EB7869865031CFDADBA44A2FB3D7E74D98CEA77F712E059` |
| `hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/thm/Thm.sml` | `E0A9F3C274BAB9BE04922D83535A660833A6EF8409F9C02BA9610DDEDAE3FF45` |
| `hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/num/theories/cv_compute/cv_computeLib.sml` | `B66D57885CB0D2DCF49F5D5FEC665CB5FDCA4EDB9F726A2CED0AD579CDD08B6C` |
| `hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/num/theories/cv_compute/automation/cv_transLib.sml` | `182DABE3CDFD677E1EC8ED4DDD0E8EA3F6D6584D801CAE7F13EE01A203C5647F` |
| `hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/num/theories/cv_compute/automation/cv_primScript.sml` | `344DCC0FFB7071270819E366D027ADA5B449615EBE31A23B7CF7C6DC0CD8F28A` |
| `hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92/src/portableML/poly/Arbnumcore.sml` | `E68E8D60BA443C3CBFBF151EC69B6C61D5D20C36AAC757FE3812E9FB34580E86` |
