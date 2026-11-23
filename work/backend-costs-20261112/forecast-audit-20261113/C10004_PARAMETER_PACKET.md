# Saved parameters for the c=10004 source-to-sign block

This packet identifies the existing metadata for the experiment proposed in `INDEPENDENT_FEASIBILITY.md` (SHA256 `2345AB9D8E5E093DF53A1EADB83EADFEF07AE279971693B7E5A8DF213D55C006`). It does not implement the block, produce values, choose new transform decompositions, enumerate units or certify signs. Only saved rows, their small dependency closure and source descriptions were read. JSON references below are zero-based; most source JSON files occupy one physical line, so a JSON path is more precise than a line number.

The block is concrete at the level of dimensions, precision contracts and arithmetic plan. It still needs actual certified source/root objects and a bound unit-to-character coordinate map. It has **no Bluestein leaf**: this experiment cannot calibrate normalized Bluestein kernel production.

## Conductor and height row

All agent-relative paths in this packet start at `work/qrh-campaign/agents/`.

`integration/transform_structural_manifest_20261111.json`, 25,110,201 bytes, SHA256
`A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637`, contains:

```
$.conductor_fields =
 [c,phi,primitive,H,J,ordered_axes_n_q,
  scenario_major_band_minor_height_nodes]

$.conductors[2] =
 [10004,4800,2301,6578,84200,
  [[2,2],[40,40],[60,60]],
  [6401,6400,12800,38400,20199,
   6401,6400,12800,38400,20366,
   6401,6400,12800,38400,20519,
   6401,6400,12800,38400,20839]]
```

The row ID is2. The factorization stated by the feasibility proposal is4·41·61. The saved unit dimension is4800 and the primitive output count is2301. Ordered local axes are the sign axis modulo4, then lengths40 and60. The last array gives five source-band node counts in each extra-node scenario0,167,320,640. H=6578 is the certificate target; J=84200 is the number of main coarse nodes, including index0. Its last main sample is at index84199, not84200.

For the proposed entry block, use exact time indices0,1,2 on \(t_j=5j/64\). Index0 initializes the retained source state; the requested positive-height outputs are at5/64 and5/32. At each requested height, all4800 unit inputs and all2301 primitive channels remain required. Thus the two requested heights have4602 output-channel occurrences. Certifying index0 initialization is not permission to import an arbitrary initialized state. Whether index0 also exports all transform outputs is a separate benchmark choice and must be counted if implemented.

## Precision: two distinct saved contracts

The matched priced baseline is p81. `major-constants/combined_conductor_precision_rows_20261111.json`, 9,568,390 bytes, SHA256
`2B9C245DCA582C93BFFCB022CEE858D09B07637D1D1D1F37D5C1FE5BDF94DBCB`, gives:

```
$.fields = [source_row_id,c,phi,primitive,S_mix,S_sharp,S_tight,
            S_base,D_local_old,p_mix,p_sharp,p_comb,rho]
$.rows[2] = [2,10004,4800,2301,54,54,54,91774,1267201,100,100,81,1]
```

Input contract hash:
`376BBDC2EAC98F5AC3C28AEBFD5D6FAA80DD9989B081E4DA8A8AC79B3F270F91`.
Kernel contract hash:
`F40998CB9F4C41271BDD69EAB97FEF5B89D3B3800A72C9525AC4EA393B3628C6`.

This is the combined8828 error/16384 width contract with actual grid100 source assembly and one conversion to p81, retaining both old safety guards. It is not the old uniform p100 mixed/sharp choice. The arithmetic/data capacities are not81 bits merely because the fractional grid is81. Source, input conversion, root and accumulation magnitudes remain part of the contract.

The later independently reviewed mean186/runtime692 assignment instead records:

```
major-constants/mean186_exact_tensor_rows_20261111.json
$.fields = [source_row_id,p_new]
$.rows[2] = [2,75]
```

That file has1,398,171 bytes and SHA256
`D48BD451730EC4A506A136F63715E9A88352968CFAD27293122A9D10240E2132`.
Its input and kernel contracts are respectively
`A8D9ACE2A6375D19DA4C59A996D58D9A88BCE899F5DA619F7B5196EA1E7B593E`
and `0EEC8A8EF03B762019B25DE2805FDB9F2184134E3D10CEF2147FA2E4C461E013`.
The independent assignment review is `prime-estimates/REVIEW_MEAN186_EXACT_TENSOR_SAVED_ASSIGNMENT_2026-11-11.md`, SHA256 `C93394B2ED85475D7C42553681C110845AED3FDD4B7FB00A9456B7836884FC63`.

Do not merge these contracts. To match the currently priced forecast, the benchmark should state p81. A p75 experiment is a named successor requiring the genuine mean/fiber error proof, actual nonnegative head and representation radius sums, the grid100 producer and its one regrid. This packet does not choose or adopt that successor. Neither assignment contains actual values or a sign margin.

## Ordered plan and retained output coordinates

The manifest's `$.canonical_plan_sha256` is
`fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b`.
The precision artifacts bind the same canonical full-plan hash. Its relevant full-plan choices are:

| JSON path | Saved choice |
|---|---|
| `$.plan["2"].choice` | `["radix2"]` |
| `$.plan["3"].choice` | `["direct_prime"]` |
| `$.plan["5"].choice` | `["direct_prime"]` |
| `$.plan["10"].choice` | `["split",2,5]` |
| `$.plan["15"].choice` | `["split",3,5]` |
| `$.plan["20"].choice` | `["split",2,10]` |
| `$.plan["30"].choice` | `["split",2,15]` |
| `$.plan["40"].choice` | `["split",2,20]` |
| `$.plan["60"].choice` | `["split",2,30]` |

This is not one arbitrary length4800 FFT. It is the ordered tensor of the three local axes with primitive-prefix pruning. The saved request graph specifies partial-transform dependencies. Its fields are:

```
[n,q,kind,children_n_q_multiplicity_normfactor,local_five_counts,five_counts]
```

Here q=0 requests all outputs; q=n omits index0. The following exact request locations constitute the closure of the three top requests:

| Request index | (n,q), kind | Ordered children [n,q,multiplicity,normfactor] |
|---:|---|---|
|1|(2,2), pruned_two|none|
|69|(40,40), ct|[20,0,2,1], [2,0,19,40], [2,2,1,40]|
|103|(60,60), ct|[30,0,2,1], [2,0,29,60], [2,2,1,60]|
|0|(2,0), radix2|none|
|36|(20,0), ct|[10,0,2,1], [2,0,10,20]|
|17|(10,0), ct|[5,0,2,1], [2,0,5,10]|
|53|(30,0), ct|[15,0,2,1], [2,0,15,30]|
|27|(15,0), ct|[5,0,3,1], [3,0,5,10]|
|2|(3,0), direct_prime|none|
|6|(5,0), direct_prime|none|

These are metadata identities, not newly generated plans. All leaves are radix2 or direct primes3/5. There is no Bluestein cache for this conductor. Actual roots, direct-prime rows, CT twiddles and cache precision/bindings still need certification. A separate conductor would be needed to benchmark the Bluestein producer; selecting it is outside this packet.

The coordinate source is `zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md`, SHA256 `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54`, independently reviewed in integration at `EEE3BAE662500804EAEC0268A8612D0E01ED1C2FAF5D0208D442A97739794664`. The pruning theorem source is `zero-sum/PRIMITIVE_OUTPUT_PRUNING_EFFICIENCY_2026-11-11.md`, SHA256 `CB4085D00AED0BFDA9ADC1BB7306DB24EF052502C99F30D45E15AEF6EEC3F8B8`, sections1–3. Its historical height table is not used here; the actual height row is the manifest row above.

The positive-exponent DFT labels are (k4,k41,k61) with k4=1, k41=1..39, k61=1..59, giving1·39·59=2301 retained characters. Both members of every nonreal inverse pair remain. Inversion sends these labels to (1,−k41 mod40,−k61 mod60). The CT convention is input j=a+r b and output k=v+m u for n=rm, with phase decomposition jk/n=bv/m+au/r+av/n. Preserve this convention and the original character labels when flattening intermediate arrays.

**Unresolved concrete map:** the saved conductor row lists axis lengths and restrictions, not the chosen primitive unit generators modulo41/61, a 4800-entry CRT residue ordering, or the final flat-index-to-actual-Dirichlet-character map. These cannot be inferred from the dimension or hash. The implementation must supply and prove the local generators, CRT bijection, flattening order and actual-character interpretation. No generator or unit array was invented or enumerated for this packet.

## Source and evaluator at indices0,1,2

All three heights lie in the first source band. The saved source profile is

```
major-constants/reconciled_nonprincipal_schedule_20261111.json
$.scenarios[0].large.seed_bands[0]:
V=500, D_source=512, D_output=512, N=220,
P=27, endpoint_P=20, m=64,
first_index=0, last_index=6400, heights=6401.
```

That receipt is130,504 bytes, SHA256
`0E83C9AB65725FBD34F0D34FC462E9EC805A040717DA92B1AB262CC7A9345397`.
It is a count/source-profile receipt, not a certified numerical jet. Full source generation remains P27; the finite translated delivery is P20. The final-band N1500/m159/P28 construction is irrelevant to these low-height nodes and should not be charged as if used here.

The matched evaluator record is `integration/guarded_residue_evaluation_frontier_20261111.json`, `$.selected_records.band1_K20_b94`. File SHA256
`DA5B4B1C09A5D6F10D8B1133AF5F2BD95E9711BDB309DD1F1FEAB4E8E7E1A5F7`.
It uses K20 and grids

```
[94,94,94,94,91,89,89,89,83,81,81,81,75,73,73,73,65,65,65,65].
```

It requires40 coordinate conversions from the original source array,19 complex Horner stages, and an exact six-bit export from grid94 to grid100. The output signed capacity is108 before,114 after that export. The saved record has the exact per-stage narrow product and residual capacities. Source conversion is shared only with a checked identity and lifetime for the same original coefficient array. A finite translated polynomial is not automatically the true fine Taylor jet; retain the reviewed source, translation and arithmetic error terms.

Raw input assembly additionally needs `(a/c)^(-s)`. The producer proposal is `integration/RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md`, SHA256 `FBBB538E0FC72865A9B4815A048992644AA0563AFC2DEA970FB9C3B4F7596EEE`, independently reviewed at `076A108101A9AC75BF481E9D7E1005E1351ABD2E3DB6221937A8D685F2FFE0BB`. Its exact identity is

```
B_x(t)=x^(-1/2) cis(-t log x)
c*conj(B_c(t))*B_a(t)=(a/c)^(-1/2-it).
```

Initialize inverse roots at zero and certify the shared log/cis step objects, then make index2 consume the retained index1 state. The head proposal's numerical caches are not supplied by these metadata files. The full all-integer pool is one conservative producer schedule; a benchmark using only the needed integers must state and certify that smaller dependency set instead of claiming the full-pool cost or importing unchecked states. The EM internal finite head is a different computation and does not replace this raw input.

## Remaining implementation gates

Before calling the block an actual source-to-sign benchmark, freeze:

1. The explicit unit/character maps and actual flattening order, with all4800 inputs and2301 retained channels bound to the saved tensor plan.
2. One precision contract: p81 for the matched priced baseline, or a separately declared p75 mean successor. Certify its complete input/grid/radius premises, not just its precision integer.
3. Actual height-zero initialization, source coefficient arrays, Bernoulli/constants, roots/twiddles, rounding witnesses and two dependent height updates. Bind elementary certificates to their exact arguments and grids.
4. The complete function interpretation, conductor factor, root phase and canonical real normalization for every channel. Positive DFT output alone is not a completed-L sign. Keep inverse channels and explicitly report inconclusive intervals where zero is not excluded.
5. Initialization, first admission, optional replay, caches, proof generation/translation, output bytes and peak memory as separate measured phases. This row does not exercise high-height source bands, small-family wide time FFTs, Bluestein, repair frequency or Turing completeness.

No metadata row supplies any of those actual numerical certificates. This packet closes the parameter lookup, not the source-to-sign proof.
