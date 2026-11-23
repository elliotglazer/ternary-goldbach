# Finite cost scenarios and completed binary pilot: consistency review

Verdict: **PASS for the stated conditional accounting and measurement boundaries; no arithmetic correction requested.** This is not validation of the scenario success frequencies, production rates, implementation completion reserves, or full-range feasibility. In particular, the central Lean figure is a proposed implementation scenario, not a measured complete-pipeline prediction.

Reviewed author estimate: `work/qrh-blueprint/estimates-20261111/FINITE_COST_ESTIMATE.md`, SHA-256 `F03C9E49433988ECCEF97D6A10CCA073F7BD024F1B92511285CCD7D65CA1BFCE`. Reviewed new pilot report: `work/lean-pilots/binary/REPORT.md`, SHA-256 `20FBB99BECB49FF16E19ABE17EE7CE91542B53D8D0F92929A61B3979FFA6946D`.

## What the arithmetic checks establish

An independent read-only script reconstructed all 18 saved scenario/cutoff rows using rational rates and counts, with a relative tolerance of `2e-14` only when comparing the author's floating-point Fermi outputs. It passed 518 checks, including the new pilot's source concatenation, file hashes/sizes, and every recorded run's status/command/timing fields. It did not import or execute the author's writer, regenerate primes, run a new benchmark, or fold an inventory. Projected byte quantities are approximate scenario projections, not exact serialized lengths.

The checked finite count contracts are consistent:

- The full binary target count is `B/2−1`, including the initial interval and a final one-target block when applicable. Ceilings for 64-target words and `2^18`-target arithmetic tiles do not drop those endpoints.
- For `T=N0−1`, a successful odd-prime path starting at 3 with gaps at most `B−2` and final coverage `pK+B≥T` has the necessary lower bound `K≥ceil((T−B−3)/(B−2))`. The scenario multipliers above that lower bound are assumptions, not existence theorems.
- The fixed-L bitmap size and anchor-block count retain the initial/source obligation; a 512-anchor reserve does not establish that all blocks are covered.
- Generation and checking add, and the cold setup reserve is split once, not charged twice. The displayed fallback budgets add to rather than erase the baseline attempt work.
- The conservative direct supplied-root model has 44 modular squares, `P=65560`, `A=3256`, and 44 glue roles per rung. These are template categories before the separately assumed expansion/rate model. The natural-size restriction is compatible with the proposed Proth bound at `N0=9.89e26`; actual candidate certificates and full path coverage remain required.
- The central MM0 binary stream and ladder instruction-traffic projections have the units claimed. Executed header traffic is not serialized proof size, and a compact root payload is not the full arithmetic proof.

No scenario supplies missing coverage through an average, probability, or reserved CPU budget. The report explicitly rejects a scenario if an actual gap or resource bound exceeds its assumptions.

## Measurement reconciliation

The saved 3.399653-ms packed-equality figure measures warm prepared arithmetic. It does not itself prove source/anchor semantics or complete tile assembly. The saved 55.078125-ms prime-root figure measures kernel replay of a particular shared proof closure, including auxiliary declarations. It is not the time to generate/elaborate those proofs. The older report separately records a construction process, and explicitly distinguishes both measurements.

The new complete internal pilot is semantically stronger: it proves the actual 64-target interval with all primality, source-bit, shift, coverage, and endpoint obligations discharged. Independent semantic review `189FCB113A859B16919E6BF3E1AA394B890649833E6F9B619475021C437E3162` and exact-type/axiom receipt `53F77F6076373E1B156390629063DC1ACADACE14A73A555B6655D2CF1184E5D9` establish that scope. The standalone source is exactly the three audited components concatenated without imports of the concrete pilot modules; this was independently checked. Thus its reported full run does not merely time a reference to a previously compiled final theorem.

The actual standalone observation is 87.796652 seconds wall and 126.03125 seconds process CPU. The import-only observation is 12.872155 seconds wall and 12.71875 seconds CPU. Other work was active. These are different runs, and subtracting them is not a measured pure-kernel interval. The separately reported support/prime/coverage times overlap imported work and must not be summed as disjoint costs. Requested `-j 1` is not a license to replace measured CPU with wall time.

The new pilot uses 644 prime nodes, 164 roots, 12 high anchors, and 152 distinct source primes. Its producer reuses an existing selected cover and existing certificate data while proposing additional nodes. Its 0.067686-second generation observation excludes the historical anchor search and does not include Lean elaboration. None of these observations validates the finite model's 1/2/8 packed-checking multipliers, per-anchor generation budgets, fallback fractions, or source/exception reserves. Those remain explicit engineering assumptions. Conversely, naively multiplying this one pilot's cold cost by every 64-target word would discard intended source/support sharing and is not a justified replacement forecast.

The saved MM0 rate measures a schematic proof shape with arithmetic axioms and enlarged heap/store capacities. Its finish proposition is not the actual binary theorem. The new finite estimate accurately keeps ordinary-PA completion, resource admission, proof generation, semantic source binding and final composition conditional. A numerical completion factor does not prove those derivations or a legal stock schedule exist. The report's stock-fit row is therefore conditional, and its same-rule engineered row is a different unimplemented scenario, not an observed universal prover speed ratio.

## Use in a final estimate

The finite figures can be carried forward as labeled low/central/high conditional planning scenarios. They are not confidence intervals or upper bounds. The common analytic library, spectral production, principal data, proof translation for an MM0 target theory, and final integration remain separately charged and semantically open where not already proved. A representative positive-height spectral pilot cannot be replaced by the central chi4 milestone.

No correction to the displayed arithmetic is requested. The decisive caveat for any final summary is that complete semantic pilot acceptance and modeled scalable throughput are distinct results. In particular, a claimed fully measured end-to-end Lean/MM0 estimate would exceed the evidence reviewed here.

## Pins

| Artifact | SHA-256 |
|---|---|
| `estimates-20261111/finite_cost_scenarios.py` (under `work/qrh-blueprint`) | `C842CFE3897E1A503781241DEFE0416260134E151ECF1B6CE6900DF49F13664B` |
| `estimates-20261111/finite_cost_scenarios.json` | `48FC76488941526A4B2CA5B5198B06D6051DA67D78DFBA342C5F8B9374E9363B` |
| `work/lean-pilots/binary/results.json` | `C0C0B289849E2FDC7CAB8BBD5859A40A4FAEC2FB7EC263FD44F062A32C2EF0AA` |
| `work/lean-pilots/binary/CompleteBinaryPilot.lean` | `153341B41AB534824354323CEA6061C312C922F6EB73AF5FD3B1BF9853AC0B2F` |
| `work/lean-pilots/binary/CompleteBinaryPilot.olean` | `A4F0CE27803B6C70B564BF3EEC071CFA8BAD4B69D2C2E3AB26931CF8DD86D445` |
| `work/formal-goldbach-bench/prime-cert/REPORT.md` | `4F806BD887B187043AAC4180DBF40E2C9C78AD023F8248311BBDC397D43C2ACB` |
| `work/formal-goldbach-bench/lean/REPORT.md` | `7572D5C748668EFC8E163822C0FDBBB4602A1A796E8B3FDA8412F53739FAAB7E` |
| `work/formal-goldbach-bench/mm0/REPORT.md` | `E78BFC3A070EE69BEE9DAA7E93376759E8938E379C067A24AFF910B4E609C02B` |
| `work/qrh-blueprint/estimates-20261111/MM0_CALIBRATION_AUDIT.md` | `4BFCDFC88F2ABA0D87D1AA705778D32D2482916E429932F96EF3D6D27A0D8792` |
| `work/lean-pilots/audit/check_finite_cost_consistency.py` | `C3D676CB62AEAC71A68C53F5E5C966CDE6CD1C1A453047FF64B857FD312799A1` |
| `work/lean-pilots/audit/finite_cost_consistency_receipt.json` | `B2749F7B49952446287E305F176F6B45051DCF05E843A367B6A77C71D9B908CE` |

The receipt binds the two reviewed reports and records all 518 checks. No frozen author source or prior report was changed.
