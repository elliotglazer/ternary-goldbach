# Review of the c10004 live-data schedule

13 November 2026. PASS as a conditional architecture and packed-capacity schedule. No required mathematical or count correction found. This is not acceptance of an implemented source-to-sign producer or a replacement numerical forecast. Review was limited to source reading, hashes, selected saved metadata rows and fixed integer arithmetic. No unit list, values, roots, signs, program or benchmark was generated or run.

The reviewed author is C10004_LIVE_DATA_SCHEDULE.md, SHA256 56019E9D091270F46C3C4DCBE17390C2CBFD336135C94675A7F61FCC222F850F. All eight entries of its source ledger match. I additionally checked the saved conductor/precision rows, the nine listed plan choices and the selected Horner record directly in their original JSON files, without rebuilding an inventory or plan.

## Checked instance and counts

The saved conductor row 2 is c10004, phi4800, primitive2301, with ordered requests (2,2), (40,40), (60,60). Its baseline combined precision row is [2,10004,4800,2301,54,54,54,91774,1267201,100,100,81,1]. The schedule correctly chooses p81 with the original combined8828/width16384 contract and both old guards, not the later p75 mean contract. Indices 1 and 2 are positive heights 5/64 and 5/32; index 0 supplies initialization. They lie in the first band V500, D512, N220, m64, P27 with P20 endpoint/delivery.

For anchors alpha=j/512, j=0..512, the EM head arguments are n+1+alpha with n=0..219, and endpoints are 220+1+alpha. Their union is covered by the consecutive mesh x=1+k/512, k=0..221*512. Its cardinality is exactly 113153, including the upper endpoint x=222. This is a complete conservative argument pool, not 113153 distinct coefficients at each anchor. The separate integer pool 1..10004 covers all possible unit numerators and the conductor argument. Including its nonunits is an explicit schedule choice. No cross-pool reuse is assumed because the grids and error contracts differ.

Streaming 512 P27 coarse jets plus one endpoint P20 jet gives 13844 source coefficients per height. The 1025 fine cells deliver 20500 slots per height. These numbers do not force simultaneous storage. The coarse finite polynomial must remain live until both its even cell and shifted midpoint consumers finish. The midpoint vector is a translated finite polynomial with its own paid error, not an exact fine Taylor jet. The saved K20/b94 record has exactly the listed twenty grids, output signed width108 and six-bit exact embedding to grid100 with signed width114.

The ties-down formula gives (2k-1)c < 2Ga <= (2k+1)c, including exact-boundary ownership. For G1024, the resulting h=512a/c-k/2 satisfies -1/4<h<=1/4. There are 1025 possible cells and hence 1026 prefix offsets. Both endpoint cells fit the stated source loop. This verifies the index geometry, not an actual sorted unit map.

The tensor sizes are 4800, 2400, 2340 and 2301. Retaining the modulo4 label1 and nonzero labels of lengths40/60 gives these sizes exactly. Both inverse-character channels remain. The specified A/B writes fit their reservations: axis2 writes2400, axis40 writes2340, and axis60 writes2301. Since each axis reads and writes distinct buffers, there is no implied overwrite of an unconsumed input. Actual CRT generators, permutations and arithmetic dependencies still require proof.

The saved plan uses radix2, direct3/direct5 and the listed CT splits only. The nine conservative root-table lengths sum to185. These are table slots, not185 distinct angles and not evidence that roots have been produced. There is no Bluestein leaf or kernel in this instance.

There is a concrete indexing join to prove against the currently unrun candidate hol-platt/c10004-map/C10004MapScript.sml, SHA256 0773AC5249A66AF85814F7694063D53759AEF19C41D6172BE06DA906FD60AC6E. That source encodes inputs as i=j4*2400+j41*60+j61, whereas this schedule stores them at n=2*(40*j61+j41)+j4. Directly reusing its unit_map as the proposed buffer would therefore be wrong. For 0<=n<4800 the required old index is 2400*(n mod2)+60*((n div2) mod40)+(n div80). A proof must establish this coordinate permutation, its bijection, the corresponding residue lookup and DFT transport, or change the implementation layout consistently. The final retained-label order does agree, with index59*(k41-1)+(k61-1). The candidate map also proposes generators6 and2 modulo41/61; their source presence is not a successful certificate. The author's explicit qualification of addressing as proposed makes this a missing implementation join rather than a false count in the schedule.

## Checked widths and storage qualifications

The persistent EM state/step allocation follows the grid140/grid142 recurrence source, including retained accumulated errors and separate lower-grid EM copies. Four signed144 fields per argument give 8147016 bytes. Four signed124 fields for each raw integer argument give640256 bytes. The raw source independently justifies signed131 conductor centers, signed247 update witnesses and signed254 head witnesses; these are not all live-array widths. The schedule retains exact grid100 assembly and the conservative subgrid conversion contract.

From the saved CT splits and the accepted peak recurrence, K2=4, K3=6, K5=10, K10=40, K15=60, K20=80, K30=120, K40=160 and K60=240. The whole ordered tensor has K=max(8,640,38400)=38400 with ceiling binary logarithm16. Substitution of p81 and width exponent14 gives signed113 stored coordinates, signed194 exact ordinary products/combinations and signed197 three-product temporaries; signed114 presums are also retained. These rely on the old error/peak guards and actual coefficient rounding contract, not on p81 alone. Root centers at grid81 fit signed83 and their exact sums fit signed84.

The source work reservations, including154 endpoint slots through index153, sum to12762 packed bytes. The A/B transform buffers total216000 bytes. The proposed depth-first340-slot line/recursive scratch totals10200 bytes. This scratch is plausible for the declared sequential child schedule, but an actual allocation or functional-evaluation proof is still required; the schedule correctly does not present it as a property of current HOL evaluation.

Independent fixed arithmetic reproduced all listed subtotals and the total9075977 bytes, or72607816 bits, before the34-byte conductor factor. The resulting9076011-byte enumerated reservation excludes elementary/raw arithmetic workspace, completion, repair and control scratch. It also excludes HOL constructors, proof terms, sharing tables and garbage-collection overhead. In particular no bound on total process memory follows from this sum. The first fixed-arithmetic review command had a PowerShell comma-precedence error; it produced no artifact, and the corrected parenthesized command reproduced these totals. No numerical computation was retried.

## Sign contract and retained radii

Two heights give4602 statuses, needing9204 payload bits and hence1151 packed bytes with two bits per status. The fixed height/character order and row lengths are part of the theorem. A strict negative conclusion requires the certified upper endpoint below zero; a strict positive conclusion requires the lower endpoint above zero. Otherwise the status is inconclusive, not a zero assertion. No malformed encoding may be accepted.

All source, input-regrid, intrinsic transform, scale, phase and completion errors must remain available until each final sign test. Uniform radii may be shared only after their theorem applies to these exact objects; otherwise the per-output radius computation remains. Inverse phases cannot be replaced by arbitrary unit factors. compact02 supports only the integer-level packing mechanism. It supplies no such analytic interpretation or guarantee of a successful strict sign.

The author explicitly changes the old plan's full center-radius export to a status export. That is legitimate as a new target, but any comparison must implement the same new target on both sides. A consumer needing discarded enclosures must retain a specified checkpoint or pay recomputation. No zero-count or Turing conclusion follows from this block.

## What this can replace, and what is still missing

The schedule gives a concrete alternative to repeatedly translating fresh arbitrary integer payloads: a checked program can derive its large internal arrays from a small fixed specification and certified producers, then export statuses. There is no mathematical requirement to serialize each intermediate array and import it again. However, this note alone cannot replace a measured translation term in the forecast. It gives neither the generator, the whole-program denotation theorem, nor measured proof construction/sharing costs. Supplying113153 seed pairs externally instead of generating them internally would still require charging their literal input and enclosure witnesses once.

The following interfaces are specifically needed before that replacement is demonstrated:

1. **Index construction.** A checked finite generator for the unit list, actual local generators, CRT bijection, positive-DFT labels, sorted cell offsets and scatter map. Prove complete coverage, uniqueness, no missing writes and correspondence with the saved pruned plan.
2. **Elementary initialization.** Actual rational-argument log, inverse-root and cis producers for the EM mesh, with the finer grids and complete radii above; the actual integer raw-head producers with their separate grids; certified Bernoulli/rational constants and root/twiddle generation. Small input syntax is not permission to assume these arrays.
3. **Persistent source denotation.** Prove the two dependent height updates preserve each pool's error and grid invariants. Instantiate the full finite EM formula and remainder, P27 finite translation/P20 delivery, fixed-grid Horner, exact grid100 head assembly and one p81 conversion. Bind source coefficients and cache identities without radius resets.
4. **Transform and completion.** Prove this exact rounded/pruned circuit's character interpretation and intrinsic bound, then actual L identity, conductor scaling, Gamma/root-number completion and real Hardy normalization. Construct every phase and radius used in the strict tests. Existing local arithmetic correctness is insufficient.
5. **Internal representation.** Supply a single checked evaluator or compositional representation-preserving interface that passes internal arrays without literal decode/re-encode. Prove the intended buffer reuse and characterize actual copying, object retention and proof dependencies. Cache equality and allocation cannot be inferred from mathematical extensional equality alone.
6. **Final consumer and experiment.** Prove status soundness against those exact real functions and fixed labels. Predeclare a strict-sign success/refinement policy, corruption controls, checkpoint policy and identical output contract for compared implementations. Measure source production, all acceptance/translation stages, completion, export and process memory; charge reusable libraries and optional replay separately.

No forecast, selected plan or source file was changed. The checked result is a coherent bounded design with explicit missing producer/proof interfaces, not a numerical or performance result.

## Additional selected metadata bindings

| File under work/qrh-campaign/agents | SHA256 |
|---|---|
| integration/transform_structural_manifest_20261111.json | A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637 |
| major-constants/combined_conductor_precision_rows_20261111.json | 2B9C245DCA582C93BFFCB022CEE858D09B07637D1D1D1F37D5C1FE5BDF94DBCB |
| integration/guarded_residue_evaluation_frontier_20261111.json | DA5B4B1C09A5D6F10D8B1133AF5F2BD95E9711BDB309DD1F1FEAB4E8E7E1A5F7 |

The author's eight source pins and the previously frozen parameter packet supply the remaining source bindings. No full-inventory reconstruction was performed.
