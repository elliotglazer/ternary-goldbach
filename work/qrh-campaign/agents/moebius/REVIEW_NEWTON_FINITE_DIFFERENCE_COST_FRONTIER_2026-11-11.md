# Review of the Newton finite-difference cost frontier

2026-11-11. PASS for exact occupancy metadata and the conditional price model, with no correction. This review binds `major-constants/NEWTON_FINITE_DIFFERENCE_COST_FRONTIER_2026-11-11.md`, SHA256 `CBB69E55DE08F9CDAFDA7F37D3B15DB594E56C6388DFDF6F87211E32A93CCB99`. It does not adopt a selected subset, measured prices, runtime saving, arithmetic implementation or spectral result.

I read the complete author note, script and receipt, the reviewed Newton initializer, the ten-guard extension and its independent review, and the prior occupancy contract. An owned checker independently reconstructed every guard cohort and projected price subset using integer metadata. No coefficient, polynomial-function, analytic, prime, zero or transform values were evaluated. No builds or frozen-file edits occurred.

## Geometry and counts

The five values F=2Dout are1024,2048,4096,8192,16384. In particular the final source grid4096 does not replace its delivered Dout8192. The ties-down cells retain the open-left/closed-right convention. Their nonempty count is c-1 for c<=F and otherwise F-1+1[c>=2F]+1[c>2F]. Hence either admitted guard has b=F+1. The guards c>20F and10F<c<=20F partition the admitted family without overlap.

The new-only guard relies on the separately proved finite-polynomial support and raw-width extension AFA91F89, independently reviewed at0FC18017. It is not inferred merely from a cheaper initialization count. Conversely phi(c)>10b implies c>10F by bounding every cell length by10 when c<=10F. That implication needs all nonempty integer buckets, not just useful unit buckets. The old phi(c)>20b screen is not retained as an unnecessary restriction on the newly proved domain.

Every nonunit position is charged through a=c-1-b advances, and every nonempty bucket is initialized even if it has no unit output. The old comparator evaluates only phi(c) units. Thus the comparison does not inflate the baseline by pretending that it evaluates nonunits. The exact height ceilings, parity restrictions, five band clips and four alternative auxiliary extensions agree with the previously reviewed occupancy metadata. The scenarios must not be summed.

I independently derived phi through Mobius inversion of the divisor identity, reconstructed125400 conductors and sum phi=7133015232, and checked all40 guard cohorts and720 strict projected subsets. All operation fields and reserves agree with the receipt. This also confirms the main table and the absence of any selected third-band candidate in the listed projections. That absence is limited to those prices and this circuit; it is not a general impossibility statement.

## Circuit and prices

Per bucket the reviewed circuit has190 general products,357 additions,357 shifted-operand occurrences and19 coefficient prescales. Each advance adds19 additions. Per height its cost vector is therefore

    (190b,357b+19a,357b,19b,b,phi(c)),

with the fifth component bucket setup and the last final complex conversion. These complex-coordinate labels require consistent scalar expansion on both sides. Neither a shift nor a wide prescale is a free operation. The powers used for prescales can be shared with exact geometry binding; the coefficient-dependent products cannot be shared merely because two conductors use the same source array.

The author's saving expression

    19w phi(c) C_H + D
      -w[190b C_G +(357b+19a) C_A +357b C_S
           +19b C_P +b C_K +phi(c) C_R] -T

correctly separates the complete old stage, all six new operation classes, baseline-only credit D and other differential costs T. Its normalized formulas follow from a=c-1-b. Equality selecting fallback is consistent. A proven upper price for the new circuit and lower price for the baseline yield a sufficient saving test; a difference of unrelated upper estimates would not. The note explicitly makes that distinction.

The18 sections set p in{1,2,4}, z in{0,1/16,1/4}, f in{0,1}. Their saved reserve numerator is exactly

    16(19-f)R -3040p B -(16z)(357B+19A).

The same positive reserve must still pay shifts, prescales, setup, conversion, binding, storage, traffic, policy and proof costs. It is not a second saving available in addition to those costs. The phi>10b condition is the otherwise-free p=1 projection, not a sufficient full-price decision. With nonzero baseline credit D or another product price it is not a universal necessary condition either. The author's stated qualifications preserve this scope.

A source cache can couple decisions. Summing positive individual savings optimizes only the separable priced model after costs have been assigned consistently. It need not optimize a real shared-cache schedule. The note correctly retains the actual source-object union, retention/recheck costs and a20-conversion-per-bucket unshared alternative rather than charging both or assuming free reuse.

## Widths and baseline changes

The old guard uses signed b_grid+400/b_grid+401 state/advance capacities; the new-only guard uses b_grid+406/b_grid+407. At b100 these are500/501 and506/507, respectively. At b122 they are522/523 and528/529. General factors retain19 magnitude bits. These are sufficient maximum capacities, with stage-dependent widths permitted if proved and priced. A single price row across both guards is hypothetical, not a conclusion that their actual costs match.

The b100 representation requires its own checked coefficient conversion and source binding. Norm accuracy alone does not imply grid membership. Each distinct retained array can be converted once, while eviction/reconstruction and its original input widths remain charged. Final rounding is paid per unit output, and its wide divisor is not treated as an old narrow addition.

The prospective b100 rounded-product/exact-add Horner circuit is a different comparator. The frontier leaves C_H symbolic and explicitly permits a reviewed replacement. No deduction from the selected operation ledger or end-to-end dominance follows from its present tables. Shared seed work, the separate finite head, character transforms, sign/count completeness and analytic foundations remain outside this local saving expression.

## Independent evidence and pins

Owned checker `moebius/review_newton_cost_frontier_20261111.py` passed1,899,281 exact checks. It uses independent Mobius inversion and direct ceiling/bucket formulas, not an import of the author program. It compares all mathematical aggregate fields, rather than reproducing the author's ordered row-digest serialization. The check began from the completed receipt before the note freeze; its consumed receipt hash matches the final frozen receipt. The author's2,065,413 assertions were read but not rerun.

|Artifact under work/qrh-campaign/agents|SHA256|
|---|---|
|major-constants/NEWTON_FINITE_DIFFERENCE_COST_FRONTIER_2026-11-11.md|CBB69E55DE08F9CDAFDA7F37D3B15DB594E56C6388DFDF6F87211E32A93CCB99|
|major-constants/newton_cost_frontier_20261111.py|3AD9E2B2C9A6F35649CB9CDA86A4876C40442B54C07E01B746854CBD3B5AFC4E|
|major-constants/newton_cost_frontier_20261111.json|81853F0B8E8994AA81ABC711667C9F29E2018C579A82860FEC97B35CAFF1DD3F|
|moebius/review_newton_cost_frontier_20261111.py|F20E951CCE576235541CEE3F2C2DC0DDB1B973F7D51185A4972C1F91E842F5A8|
|moebius/review_newton_cost_frontier_20261111.json|9605F0E7667F6FD238ED5F306D037DD651CD1EC20FACDFB7E8FE464C248830AE|

The six full predecessor pins embedded in the author receipt also matched. Acceptance is limited to the stated conditional frontier and exact metadata. Concrete ordinary-rule arithmetic prices, cache schedules, output certificates and actual numerical success remain open.
