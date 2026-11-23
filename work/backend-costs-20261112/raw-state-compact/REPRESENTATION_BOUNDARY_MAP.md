# Where compact checked execution could replace representation work

13 November 2026. Source-only mapping after compact02. No model execution,
new inventory, numerical evaluation or build. This note changes no frozen
forecast and assigns no saved hours.

## Identify the quoted row before applying the measurement

The approximately 1,994,587 planning core-hours refer to the model's
`literal_representation` row, not to a measured aggregate of all input and
output boundaries. Its saved value is 227.5367281304526 core-years.
`forecast-audit-20261113/end_to_end_model.py:77,119–122` constructs it from
149,894,993,255 **notional** 8192-operation blocks, the assumed reuse 100,
geometry 1.02, refinement 1.1 and 4.269485 seconds per fresh fixture payload.
The block numerator includes only:

| Included operation occurrences | Saved main count | What the count does not identify |
|---|---:|---|
| Large unit-root complex products | 920,122,241,148,146 | Distinct input vectors, root objects, or independent process lifetimes |
| Large cached-kernel complex products | 89,017,934,196,032 | Number of cache admissions or fresh coefficient translations |
| Small character and time butterflies combined | 218,799,609,396,458 | Number of Gaussian source arrays, time arrays or shard crossings |

These are exact counts of selected operations, followed by an assumed
operation-to-payload conversion. There is no saved bijection from these
notional blocks to 192-object payloads. Consequently, there is no exact
subdivision of the quoted hours into the physical boundaries below. Such a
subdivision cannot be recovered from operation totals alone.

The 4.269485-second anchor is specifically the median sum of
`translate_block_inputs` and `translate_block_coefficients`:
`hol4-setup/summarize_dependent.py:111–113`. The fixture has 128 complex inputs
and 64 complex coefficients. Its construction and translation are separate
at `hol4-setup/generate_dependent.py:92–109`. The benchmark already keeps
successive butterfly results internal and returns a bound/checksum contract,
not a full output array (`DependentBlockScript.sml:24–27,100–115`). Thus
compact02's smaller output does not directly replace this input-translation
anchor. The source-to-consumer fusion and the compact output are two distinct
requirements for a proposed replacement.

## Actual boundary map

All counts below are saved main-plus41 / e0 counts. They are not new folds.
“Internal candidate” means a possible checked program composition with the
same exact source/grid/error contract, not an implemented full pipeline.

| Actual boundary and saved count | What can remain inside one checked computation | What must still be supplied, retained or exported |
|---|---|---|
| **Large source to residue contraction.** 14,367,196,500 P20 coefficient deliveries;28,734,393,000 shared coordinate conversions;60,254,515,577,760 residue evaluations with19 Horner stages each. Ledger: `WIDTH_RESOLVED_LEDGER.md:60–68,89–105`; model:15,20–29. | The EM/head/correction program, finite translation, coefficient-grid conversion and Horner consumer can share the actual generated coefficient object. A coefficient need not become a fresh literal for every residue or stage. | Elementary seed/log/step and Bernoulli correctness, exact anchor/height/index selection, source error bounds and original-center conversion remain. Coefficient caches shared across conductors or process shards need a proved lifetime and identity, or recomputation. Existing counts are deliveries/conversions, not evidence that they are currently repeated literal imports. Their arithmetic rows stay charged. |
| **Large raw head and assembled transform input.** Conservative23,815,680,000 shared integer-state updates;1,528,006,797 conductor-height cache entries;60,254,515,577,760 raw-head products/assemblies. Input grid adaptation has54,067,011,555,562 rounded conversions,1,954,722,891,838 identities and4,232,781,130,360 exact embeddings. Ledger:58,70–79; model:16–19. | Generate the integer states, conductor factors, raw heads, add the finite polynomial and regrid immediately into the character-transform input representation. This is the closest production extension of the handoff mechanism. No full raw-state/head array is logically required as an externally printed theorem. | Actual positive-base power identities and enclosures, seed/step acceptance, the polynomial source, precise unit-residue ordering and input-error propagation. A high-height restart requires its certified state or recomputation. Compact02 has only eight seed/step pairs and the integer head consumer; it has none of the EM, regrid, character or analytic joins. |
| **Large fixed coefficients to transform.** 363,202,368 normalized kernel entries,150,746,135 chirp entries and726,404,736 exact pre-sums; nonchirp-root identity count is still an assumption. Ledger:46–56; model:63–68,93,125–126. | A certified root/chirp/kernel producer can feed the same evaluator object directly to all consumers within its actual lifetime. Exact pre-sums can stay internal. Deterministic generation permits retaining a compact seed/angle descriptor instead of importing each coefficient value. | Exact angle/sign/precision/cache key, root enclosure and normalized-kernel setup error. Reuse across separately checked processes still needs an accepted cache representation and reconstruction/import, unless the kernel is recomputed. Root and setup arithmetic are not erased. The separately charged cache-translation row may overlap assumed runtime coefficient translations, but only an object-level map can identify that overlap. |
| **Small theta source through character and time transforms.** 8,542,028,172,242 Gaussian unit gates;128,941,391,789,290 character butterflies;89,858,217,607,168 time butterflies;9,237,783,904,256 complex time outputs. Ledger:111–152; model:30–38,42–57. | Gaussian recurrences, bucket accumulation, character output, conjugate copies, time transforms and sign tests could form one checked source-to-output computation. Neither the intermediate character array nor every time sample must cross a literal boundary if all its consumers execute before release. | The actual elementary, root-number, phase and tail certificates; precision241–534 roles; transform lengths through2^30; exact frequency ordering. Full arrays may be required internally. The memory/partition design is unproved. Postponed interpolation needs retained samples or recomputation; an already emitted sign mask cannot reconstruct sample magnitudes. Large-branch or compact02 widths do not price this branch. |
| **Transforms to actual signs and completeness.** 36,468,561,640,066 large completion/sign occurrences and1,775,431,871,117 small primitive grid outputs;4,351,723,951 primitive labels for closure. Ledger:114,154–165; model:39–41,78,113–124. | Apply canonical completion, certified error radii and strict sign tests before export. A proved per-label sign/interval/count checker can consume these internally and export an indexed successful conclusion plus explicitly inconclusive/repair requests. This is where compact final output is mathematically relevant. | Integer-coordinate signs are insufficient. A real source-bound interval must exclude zero; canonical phase and ordering must match the target. Counts need the complete sign/interval record, endpoint/central treatment and Turing/completeness proof. Output only a count is sufficient only after that checker's soundness and all coverage premises are proved. No current compact theorem supplies these facts. |
| **Process/shard boundaries and repairs.** Notional shard groups and startup are assumptions at model:94,128. Actual off-grid queries and cache lifetimes remain unknown. | A producer and all consumers placed in one checked process can avoid a roundtrip through fresh literals. A checked persistent representation may also avoid translation while it remains valid in the same context. | At each real cut, transfer enough accepted state/cache/sample data and metadata to resume, or pay recomputation from certified starts. Serialization, readback trust, term identity and error-state binding remain. The model's reuse 100 is not evidence that any particular partition fits memory. Delayed/adaptive repairs prevent discarding numerical values merely because a coarse sign was emitted. |

The assembly and grid conversion in the second row are important: directly
feeding the raw-head masks to a character transform is impossible because the
transform needs the numerical inputs. Compactness belongs after the last
numerical consumer, not at every intermediate edge.

## What actually crosses a proof boundary

No mathematical requirement forces every arithmetic intermediate or array
coordinate to be a separately decoded numeral. A proved source program and a
proved consumer may compose internally. The required external boundary is
instead the complete parameter/source premise and the final statement needed
by the next proof consumer. For the proposed spectral program this includes
conductor/character and interval identity, grid and precision, exact source
initialization, cache/plan binding, and an adequate final sign/count theorem.
These items may themselves be computed from smaller certified descriptors,
but their construction and correctness cannot be replaced by a file hash.

Any *chosen* external source or checkpoint must cross a checked boundary. If
the implementation supplies decimal coefficient tables, restarting states,
root caches, samples for later interpolation or proposed zero intervals,
their interpretation and proof obligations remain. If it instead regenerates
them internally, charge that generation and all source/error proofs. Nothing
here establishes that the entire spectral computation fits one process.

Final finite-RH/count statements and exception status must remain available to
the overarching proof. An output theorem can quantify over internally
computed arrays without listing them, provided it proves the needed semantic
property. A mask with no source/error binding, or a count with no completeness
proof, is not such a theorem. Principal and finite-binary/ladder obligations
are separate from the quoted representation-row numerator and cannot receive
an automatic discount from this experiment.

## Keep the neighboring model charges distinct

* `cache_input_translation`, model125, separately prices
  363,202,368+24,654,496 entries with reload assumptions1/3/10 and a
  fixture-average per-object price. A real internal-cache replacement must
  cover production, precision binding, lifetime and reloads. Do not subtract
  the same coefficient import once here and again from the192-object proxy.
* `serialization_and_root_assembly`, model136–139, combines hypothetical
  per-notional-block evidence with a pass over small raw arrays
  (9,237,783,904,256*52 bytes), large kernel data (363,202,368*28 bytes), and
  the binary source(8,590,000,128 bytes). Compact outputs could challenge the
  first term; internal small time samples could challenge part of the second,
  but only after their later consumers and actual shard cuts are accounted
  for. They do not eliminate binary source data. These assumed sizes are not
  measured compact-theorem sizes.
* `native_discovery_generation`, model116, is an external preparation pass.
  Internal generation can replace demonstrated duplicate preparation; it
  does not remove the accepted source computation as well. Searches and
  failed/inconclusive paths still require an owner.
* Source arithmetic, cache setup, completion, off-grid work, closure, library
  proofs and startup have their own rows. The same algebra can be implemented
  with fewer representation roundtrips without making these tasks free.

## What compact02 establishes, and the next discriminating measurement

The accepted fixed experiment gives four masks for 1032 exact integer signs,
checked against the old 516-pair result. Its primary instrumented time changed
from 0.657195 to 0.053642 seconds and final decode from 0.543517 to 0.001258.
These are one-run, changed-output-contract observations, not a transferable
factor. The old full and new compact paths both already used only the same
eight seed/step inputs. Thus their difference measures output packaging,
not an additional reduction of the old input-translation proxy. Its
post-primary old-full validation includes a real 3.260686-second representation
step; that demonstrates the cost of reintroducing a full literal, not a cost
that can be erased from the experiment's complete validation total.

The mechanism could address most *types* of numeric boundary underlying the
proxy: generated transform data, generated coefficients, and final numerical
outputs. The evidence cannot determine what fraction of the quoted hours
those boundaries occupy. The missing object/lifetime graph is the controlling
uncertainty, not the ratio between the two compact02 decode timings.

A production measurement should therefore record, for one actual selected
conductor and bounded height block, separately:

1. External source/parameter and cache objects, each with a unique owner,
   exact grid/index identity and measured admission cost.
2. Internally generated coefficient and data arrays, all numerical consumers,
   peak live memory, release points, and any reconstruction across a cut.
3. Actual assembled inputs and certified roots flowing directly into the
   selected transform, followed by canonical interval sign/count checking.
4. Final proof/output bytes, failed or inconclusive status, source/library
   construction, first acceptance, and readback. A materialized comparator
   must prove the same final semantic result and use identical inputs.

The existing c10004 packet supplies a concrete first case: 4800 inputs,
2301 primitive outputs and axes 2/40/60, with no Bluestein leaf
(`C10004_PARAMETER_PACKET.md:106–159`). It cannot calibrate kernel-cache or
wide small-time boundaries; those remain distinct required cases. Do not
replace reuse 100 until actual input/cache lifetimes are measured. No new
experiment, numeric forecast or global saved-hours estimate is proposed here.

## Source bindings

Paths above are relative to `work/backend-costs-20261112/` unless named
otherwise. The accompanying pins below identify the inspected frozen model
and result evidence; original artifacts remain unchanged.

| Artifact | SHA256 |
|---|---|
| `forecast-audit-20261113/END_TO_END_MODEL.md` | `37D11CA50EFD9259021C2B6422C662D476FE683C6C5E1AA3B97C19288AEDE3FA` |
| `forecast-audit-20261113/end_to_end_model.py` | `4E35DBD5C8162B1989F54610431B5311AB9CF5AA403CEAF42E9F7C7A77E2D028` |
| `forecast-audit-20261113/end_to_end_model.json` | `C4B06CCA6CE42BEBC1152DD471E4C2668F21CF4804785D929586E3308DEF98D8` |
| `forecast-audit-20261113/WIDTH_RESOLVED_LEDGER.md` | `B15214CA3EF1668B5D10CB3ACC6864A5C16F5F9A7448869F55438069917A11C8` |
| `forecast-audit-20261113/WIDTH_RESOLVED_LEDGER.json` | `9FF298322516D178D4401DA23C779EEDD6F9E387934EF55BEEB037C250D0459B` |
| `forecast-audit-20261113/C10004_PARAMETER_PACKET.md` | `2B8102E8134B8BC9DA5BD93DD2105673EE6614B2D3D721B7E701F3A38C09F8EF` |
| `hol4-setup/generate_dependent.py` | `0F55B86B5231A0C17A858CFC167BD5BBAFEB3057C92A7BE7B4E5AE5987106046` |
| `hol4-setup/summarize_dependent.py` | `EC716F6442B9D70226D0DB7C08FACB71110A0E53EC4776323806C3CD6641E1FC` |
| `hol4-setup/DependentBlockScript.sml` | `1A57F4025ED1A7B9C5A823D5F6B73B2A7BE02B109F21AD13D24214EA52D9D665` |
| `raw-state-compact/RawCompactSignsScript.sml` | `1B26201077B2FEDB21712482F73531D02C40DAACEE2983820D97393D2577140D` |
| `raw-state-compact/compact_fused.sml` | `7CBC653BFB8C3EB826738311D504EA5442F05F99261B60BF4440290DA63CBE0B` |
| `raw-state-compact/RESULT_REVIEW.md` | `54B232E4EF22A02531D10CC16EDCE468538B409B763C6D88B9EC61C494FA4333` |
