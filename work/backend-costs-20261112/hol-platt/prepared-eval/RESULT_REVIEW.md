# Prepared conversion smoke: independent result review

Reviewed 2026-11-13. **PASS for the bounded prepared01 smoke experiment**, interpreted as source plus recorded runtime evidence. This reviewer ran no HOL process, build or native benchmark and performed no independent kernel replay of the exports. Small read-only checks reconstructed receipt arithmetic, hashes, expected log records and exported-name presence. The preceding source review remains `REVIEW.md`, SHA256 `1B942674A53EFD81AB1DB9571802B1A7495FEF51CC0C017FDAA61D4ED783927F`.

## Acceptance and provenance

The build invocation and each of stock, fresh and retained mode processes record exit0. There is one process per mode, in that order, with three calls at each depth1/8/32/128. All four expected positive results are checked against the exact stock equations by the reviewed source. All five changed propositions are proved false. Each mode logs the actual incompatible-closure rejection and final completion marker.

The four manifest groups contain8 source,6 project-dependency,3 toolchain and1 executable entries. This audit independently rehashed all18 currently available objects and matched the manifests. Their final check logs contain the corresponding18 successful `: OK` entries. Candidate sources match the repaired source-review pins. No source was changed by this audit.

Each process reports exactly the four allowed context axioms, `bool.SELECT_AX`, `bool.INFINITY_AX`, `bool.ETA_AX`, `bool.BOOL_CASES_AX`. Each has nine expected result-tag records: the four positive exports and five rejected claims. All nine record only `DISK_THM` in the oracle field and an empty direct-axiom tag field. This is the reviewed stock HOL import/compute boundary, not an absence of foundational axioms or a separately checked inference trace. Other exceptions or resource failures did not satisfy the controls.

The stock log has equation sets of sizes21,21,0 and42 member records. Fresh and retained each have sizes21,21,0,21,21 and84 member records. Every recorded member index is contiguous and names `prepared_equations_ID_INDEX`; every use refers to a recorded set of the matching size. All those theorem names and the nine result names occur in the corresponding export bytes. The source saves the actual closed equations. This audit checked name presence and file identity, not a second independent decoding or proof replay of their theorem bodies. The two21-member sets need not be treated as interchangeable just because their sizes agree.

Retained-cache results are exactly:

- HIT for checksum, bound and depth changes.
- MISS for changed input and changed coefficient definitions, followed by paid compatible prebuild and a proved false result.
- Explicit refusal to apply the fixture-8 conversion to the incompatible true-proposition equation set.

This is direct evidence that named payload changes can invalidate reuse. It does not establish a general cross-payload cache contract.

## Observations

All times below are CPU seconds. Medians use three calls in **one** process per mode; they are not medians across three independent processes or confidence intervals.

| Depth | Stock median | Fresh median | Retained median |
|---|---:|---:|---:|
|1|0.095864|0.046815|0.022245|
|8|0.040317|0.042328|0.028669|
|32|0.048277|0.046799|0.035963|
|128|0.080017|0.084220|0.065880|

At depth128 the stock samples are0.129052,0.080017,0.074727; fresh0.084220,0.079392,0.116842; retained0.065880,0.062857,0.109625. Retained's median is17.67% below stock's observed median, but their ranges overlap and process order is fixed. This percentage describes this smoke sample only. The small-depth nonmonotonicity and large individual outliers rule out treating these medians as a fitted per-butterfly law.

The retained depth128 prebuild takes0.029331 CPU seconds, including0.014369 discovery and0.013489 conversion construction. Its three evaluation/transport phases take0.040514,0.039758,0.047284; per-call discovery takes0.016788,0.013410,0.016285. Equation-identity checks take0.000613,0.000624,0.001028, with separate equation-recording work. Fresh depth128 conversion construction takes0.016983,0.014903,0.014352. These observations support the intended mechanism: a material repeated conversion-construction phase can be avoided, while discovery and execution/transport remain. They do not isolate raw interpreter time or bigint cost.

| Process | User+system CPU | Elapsed | Peak RSS, KiB | Export bytes |
|---|---:|---:|---:|---:|
|Stock|24.63|39.38|1,416,104|2,474,381|
|Fresh|22.76|35.70|1,584,320|3,291,786|
|Retained|22.89|34.77|1,618,148|3,291,786|

The build invocation records4.14 CPU seconds and44.21 elapsed seconds. It is a recorded build invocation with cached dependencies, not evidence of a clean build of the whole HOL library. The runner's virtual-memory cap is4GiB; these RSS observations are a different metric.

Fresh and retained export files are byte-identical. Stock's smaller export is expected because it records fewer audit equation sets; it is not evidence of weaker positive/negative output contracts. Export CPU is2.061379/2.133527/2.158161 for stock/fresh/retained. Original input-plus-coefficient translation alone is4.791424/4.239207/4.032122 seconds respectively. Changed-control translation incurs additional work.

The whole processes include twelve positive calls, stock references, negative controls, metadata and theory export. They are not the cost of one production block. Likewise, the retained0.065880 median excludes prebuild and initial literal preparation. Stock/fresh metadata discovery precedes the first call, and earlier depths run in the same process. Nested phase sums must not be added again to process CPU. Logging, GC and uninstrumented work explain why phase sums need not equal their enclosing timer. No GC cause is inferred for a particular outlier.

## Decision and campaign scope

Retain this as a successful mechanism test. Do not change a whole-campaign cost row yet. The observed gain is in repeated conversion setup for fixed named data; it neither removes initial representation nor demonstrates reusable equations for new payloads. The latter limitation is observed, not hypothetical: both changed-payload controls miss.

The highest-value next step is the already planned producer/consumer handoff or a proved parameterized input interface that keeps program equations fixed while supplying fresh data. It should count input representation, source binding and cache lifetime. Translation here costs seconds while one depth128 call costs tenths of a second or less. More tuning of this fixed fixture alone cannot establish a reduction in the campaign's large representation row.

If a stable estimate of the narrow prepared-conversion benefit is needed for that next design, run the unchanged full three-process-per-mode protocol with its varied order and preserve all calls. That would improve repeatability evidence only; it would not close the fresh-input, actual-root/source, transform-error or counting gaps. There is no need to rerun it merely to generate a more favorable median.

No new native run occurred. The older native accept-loop timing excludes decimal parsing and proves no theorem. It must not be divided into the new warm HOL median and advertised as a full production overhead. Source enclosures, actual spectral maps, roots/kernel setup, sign repair, principal and nonprincipal counts, finite coverage and formal-library work receive no discount from this experiment. A later mapped implementation may replace only the demonstrated conversion-preparation part of a computational-acceptance price, and must not refund the same work again as separate setup.

## Evidence pins

All paths here are relative to this directory. Source pins are in the preceding review and the verified source manifest. The full executable hash is `35F96034A097FC31F9B07D313A718EBECD615DA739ED468D59104117D0B8B5FA`.

| File | SHA256 |
|---|---|
|prepared01_sources.sha256|BA930A92831E18A5551E6F846EBD76B8C37CEA6291AE6C1BF627D2FC1B239E9C|
|prepared01_source_check.log|9E71C7F9D7F6E2A93350925BBFD4A597550CD6167CC46F41FFBCBC73449DAB49|
|prepared01_dependencies.sha256|F301270460F2554404779C7FBA2B0C5EDAADC94278C02CF738FF77010850B5C6|
|prepared01_dependency_check.log|1E704EABF47A3A201EE80B74916B661BD654C50B9E44B5A9C44BFE7485A280CF|
|prepared01_toolchain.sha256|F3E37EF6CB76AD38D2000B2A2DF578134E0CE5FE1D02092A8B27371DE24128F5|
|prepared01_toolchain_check.log|4E247F5CD71B69702EF85420B5EE7CDB53D6CC92787E7692F1FA618F479A26C3|
|prepared01_executable.sha256|9882E4856E7B244C1BCD5F88D66012C84C44F96CB896784D3009C0EE015A08C9|
|prepared01_executable_check.log|B3D1A2A60C48B9A4ADC80D6F230327320C5F34FBA12D542D2006B0241280EA55|
|prepared01_build.time|2A3171CCF8C35E6C0FB8C9520FB288563DC607565BC4EF510BA065EA61F8C2BD|
|prepared01_build.log|CD046BDB2C2A805F6A277703A00DFC016BC3E6BF51A585387B26D4AA180A1583|
|prepared01_stock_1.log|BBCCC50290B5A4C201FA1EC0F43DF936FFB20F6C195662B593A1A3DD5D96D3D5|
|prepared01_stock_1.time|34B81D298F379F8AF7495ABE97C92E28DCE60716F62A62C2D06E499F7B0FAEAD|
|prepared01_stock_1.dat|E9D0B6836D856BD485B312FD7E4E92530DFB03D721DF8F0A58D91BA80E5F6F81|
|prepared01_fresh_1.log|E88291674508B5D260F010E25DFF9A8146B2840735C8A72FF5AC20C5C082FA75|
|prepared01_fresh_1.time|714FB9DB85242F40E1F92847EDAA2D4FCBEB34B558393C84A1F7B6D2B7AC2948|
|prepared01_retained_1.log|1172CE762EE1034EBB1560DCF8DE573003B32E0FCA067F1269AD1FA21C1F9AB5|
|prepared01_retained_1.time|7A85050109530491F5193D8A2BBA7ECD67D70281B6C1A3BEA17B94F798EDC535|
|prepared01_fresh_1.dat and prepared01_retained_1.dat|C592B94C310633E7AF47076198C06FCF5D84FD0CFF67AEA6254A661E19D1785C|

Only this report was written. The candidate source and runtime artifacts remain unchanged.
