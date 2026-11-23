# Total-translation repair review

2026-11-13. PASS for the repaired dependent experiment's bounded build and smoke attempt. This supplements, rather than changes, `REVIEW.md` (SHA256 `25664438A0A567E8BF92E69C197035BD0E48BE7445B38E2A1665E1ADF37B353D`). Source review and supplied build-receipt inspection only; I ran no HOL build, computation or benchmark.

## What changed

The mathematical core remains `37CB4079...80DAF`. The CV theory now applies plain `cv_trans` to `positive_den_div_one_def`, `round_scaled_one_def` and `rounded_butterfly_one_def`. This is appropriate: natural DIV defines a total function, even though its equivalence to the intended signed division requires positive scale. A translation precondition is not the same thing as that mathematical hypothesis.

The dependent theory likewise applies plain `cv_trans` to its layer, run and acceptance definitions. Its equality proofs still require positive scale; its acceptance predicate still includes `0 < s`. There is no invented always-true precondition or additional assumption. The driver computes and proves `positive_scale` in both arms. Only the old arm applies `block_accept_pre_ok`. Both arms then transport the actual checked acceptance result to the original `block_accept` and apply the original `block_accept_sound`. The resulting contract, bound, checksum and input data remain unchanged.

I compared the current driver to the archived prior driver. Its only changes are deletion of the alternate precondition selector and replacement of the precondition list by the old-only branch. All 788 quoted numeric literals exactly match the original `hol4-setup/dependent.sml`, in order. The four fixtures and five corruption controls remain intact. The generator's exact-occurrence replacements, numeric-sequence assertion and exclusive output writes preserve that binding; I read but did not execute it.

The old/one by stock/retained design and all previous cost qualifications remain. The retained object is a conversion over the same checked equation set, not a final-result cache. Compare old and one within the same evaluator mode to isolate the arithmetic change. Comparing old/stock with one/retained would combine two changes. Setup, preconditions, result transport, equation export, whole-process work and repeated-call evaluation remain distinct costs.

## Build evidence now available

Both `round03_*Theory.uo.time` records have exit status 0. The core log only scans and finds its existing result current; it does not show a fresh core proof reconstruction in round03. The CV log explicitly builds one theory successfully. Thus round03 supports successful reuse of the repaired core and successful construction of the repaired CV theory. It must not be presented as a timed fresh reconstruction of both.

The source and support check logs contain only successful checks. I independently rehashed all four objects against `round03_artifacts.sha256`:

| Object | SHA256 |
|---|---|
| RoundSpecializationTheory.uo | 4081646EF682EA6A3AE41F9AD32E5ECE46618E28366DFD4F9553A965D8289847 |
| RoundSpecializationTheory.dat | 3328728F6221AF004EEFCBF9E6D10489E3DA7A72E6D5B1AA4BECB4F4CD106E1E |
| RoundSpecializationCVTheory.uo | C17CAF24DB8FB171CE82C6984CB8BF39C4A70379A5B93ECD08CFB011C577F79D |
| RoundSpecializationCVTheory.dat | DBBD3F45D694B70F64E4DAE2A94074D9B6EDABD9C912E8FBC04BD07610457C8D |

The generated theory signature and loader expose all three `cv_*_def` and three `cv_*_thm` objects. Their bodies still need runtime inspection; loader names alone do not establish the generated arithmetic shape. The dependent theory, executable, controls and runtime results remain to be built/audited. The prior failed total-translation attempt remains archived and is not accepted construction evidence.

## Minimal actual-CV inspection before the arithmetic claim

A short root-run audit should import the pinned `RoundSpecializationCVTheory` and inspect these actual theorem objects:

* `cv_positive_den_div_one_def` and `cv_positive_den_div_one_thm`;
* `cv_round_scaled_one_def` and `cv_round_scaled_one_thm`;
* `cv_rounded_butterfly_one_def` and `cv_rounded_butterfly_one_thm`.

For each, check empty hypotheses and permitted tags, print the complete conclusion without truncation, and record the source/object hashes. Extract each definition's left-hand-side head from `SPEC_ALL`, then call the stock `cv_transLib.cv_eqs_for` on that head. The inspected implementation of this function recursively collects the registered code equations for every nonprimitive CV constant, with visited-head deduplication. Inspect every returned right-hand side, identifying constants by theory/name, not substring matching.

Specifically distinguish `cv$cv_div`, `cv$cv_mod` and `cv$cv_if`. The stock `cvSyntax` constructors/destructors provide their exact identities. Follow all helper definitions, including integer sign, magnitude, arithmetic and constructors. Fail the claimed no-MOD property if any reachable execution branch contains `cv_mod`; do not merely inspect the top wrapper or search the source definitions. No additional signed-division helper may be overlooked.

For the one-DIV claim, count execution branches rather than all syntactic occurrences. Charge a conditional's test and its selected branch, with the maximum over the two alternatives for a bound. Charge strict operands and called functions with their multiplicities. Treat let-bound values according to actual CV execution, and reject unanalysed recursive helpers rather than assigning them zero cost. Stock `Compute.sml` gives `cv_if` a conditional execution form; its unselected branch is not evaluated. The intended result is one natural division per `positive_den_div_one` call, one per `round_scaled_one`, and two for the two rounded coordinates in a butterfly. The numerator, sign handling, subtraction and other arithmetic still cost work.

For context, inspect the actual reachable old signed-divide definition by the same method. A difference in branch shape supports a structural operation comparison, not a measured speedup. When the dependent executable is available, its already-exported equation sets should additionally show that the one arm calls these inspected definitions rather than an old signed-divide implementation. A whole closure is not a dynamic trace: calls from bounds, checksums or translation/decoding must not be attributed to each rounded coordinate without their own call paths.

This inspection can run separately from timings. Do not hide its cost inside a faster arm or add it only to one measured arm. If it fails to confirm the intended shape, the semantically correct experiment can still be evaluated, but it must be described as an alternate total rounding implementation, not as a confirmed one-DIV implementation.

## Current pins

| File | SHA256 |
|---|---|
| ../RoundSpecializationScript.sml | 37CB4079D95F48B1F1FF9974525C909DDA21F829FD39FB341027EB9CD5380DAF |
| ../RoundSpecializationCVScript.sml | 269681276C74C1EE027CD31A8C146EE38D896BC7CE1C4166DB24E90EB72CD336 |
| RoundDependentScript.sml | C85284EF8AE1748077D3301F48AA005498A48AA32D9D61E7771AFFD6496A0D9A |
| round_dependent.sml | 026690424A64D4BD73E605FEA3975E995301E3E5C3E3860C73CABC12DC02BC25 |
| prepare_driver.py | 8AAEE688073C01692BF0FB2873FB19EA1CB46E8C1FABC191F5819C3665C6059F |
| source_binding.json | A0994CD22154AD05A5DE0F7E820A70D77A74A6E65E56BDE5C0D113E7420105AE |
| run_round_dependent.sh | 428538F936BA2D9FED80DDBE20DC74B160DCFAEED93504C4AA85A53E462B6590 |
| ../round03_artifacts.sha256 | 4CEF9BAE04673CB5614BE6DC5C62493CCCA4B288DD75E400BF99BDC189F02E8D |
| ../round03_sources.sha256 | 50223C50C1E166D2CEEC4F744325026E957EB15F2D7477FC887FA02A7D6B1103 |
| ../round03_support.sha256 | BACD08AB476554F12346A63C316849DFF1448642263D141716D0BE25357CDB16 |
| ../round03_source_check.log | 3BDF7CEA1B56C0612FF3CC4B6E70704B5F8AB583B5547CE31604BA743BE2A7C2 |
| ../round03_support_check.log | 9A4B658BD7BBD4D9708DCEB46CE7A777FF45CBB636A26C9B240E26F2A509B5E6 |
| ../round03_RoundSpecializationTheory.uo.log | CD046BDB2C2A805F6A277703A00DFC016BC3E6BF51A585387B26D4AA180A1583 |
| ../round03_RoundSpecializationCVTheory.uo.log | E41425DF2845926B3FCD82C291C0C5081271FB53CF5CF0DC4B0CCF562911F4B2 |
| ../round03_RoundSpecializationTheory.uo.time | 67242FD487E6BEF50F6D32EDED148B5D729773225130ED5C28D0EE469568F421 |
| ../round03_RoundSpecializationCVTheory.uo.time | E6F123FF0ADE60EF62646995370B1FA84ACF5AE94A18ED87894944AD21C1FE2C |

No timing ratio or campaign saving is concluded. The unchanged 4 GiB, 600-second, sequential runner remains suitable for the bounded attempt, subject to the original receipt and control gates.
