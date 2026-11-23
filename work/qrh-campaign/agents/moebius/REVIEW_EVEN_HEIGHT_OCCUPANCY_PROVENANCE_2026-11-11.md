# Even-height provenance in accepted occupancy and frontier metadata

2026-11-11. PASS: no correction is needed to the inspected frozen occupancy/frontier artifacts or their saved counts. The reported defect was misattributed to the old occupancy note. Its actual frozen line27 already reads:

> For c>10000, put d=531600/c and u=96/5 for odd c; d=1063200/c and u=191/10 for even c.

The note still hashes to `99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1`. This is not a silent repair. Both reporters subsequently confirmed that the mistaken even slope occurred only in the new, not-yet-issued power-two-normalization draft. That draft's correction and independent state-normalization review are separate from this provenance check.

## Actual calculation chain

`major-constants/combined_odd_even_height_inventory_20261111.py:33-43` sets qt=2c for odd c and qt=c for even c, then D=1063200/qt. Thus D is531600/c odd and1063200/c even. It selects u=19.2 odd and19.1 even, with floors240/255, and proves in its metadata recipe that the plus height dominates the base/star alternatives. The ordinary height node index is ceil(64H/5), with zero included in the node count.

The reconciled script consumes that combined-height receipt, preserves its residue/height/transform totals and checks19 times residue inputs against Horner stages. The minimal-theta builder deep-copies the large branch unchanged; its new selector concerns only the small branch. I inspected those bodies, not just file-name or string matches.

The subsequent independent reconstructions use the same correct parity distinction explicitly:

|Implementation|Actual location|
|---|---|
|prime-estimates/large_residue_bucket_occupancy_20261111.py|lines72-75, even factor1063200|
|moebius/review_large_residue_bucket_occupancy_20261111.py|lines90-96, even factor1063200|
|major-constants/newton_cost_frontier_20261111.py|lines40-43, even factor1063200|
|moebius/review_newton_cost_frontier_20261111.py|lines45-49, even factor1063200|

The author expressions use200+max(integer floor,ceil(rational slope)). The independent scripts use a single ceiling of the complete max expression. They agree because200 and both floors are integers. Both then form the same closed last index and clip it against each band, with e in{0,167,320,640}. No even-height factor is lost in those transformations.

The previous independent occupancy replay matched every weighted cohort/histogram and cost field using this correct formula, with1,117,805 checks. The previous independent frontier replay likewise matched40 guard cohorts and720 projected price subsets with1,899,281 checks. Their saved receipt hashes still bind the exact current author receipts. There is no reason to rerun those full inventories to resolve this attribution issue.

## Narrow receipt check

The new owned checker performed189 read-only hash and exact metadata comparisons. It verified12 frozen pins, checked the actual prose, compared all four combined/reconciled/minimal/occupancy totals, compared the saved independent occupancy cohort summaries and all40 saved frontier guard cohorts, and confirmed the unchanged author-receipt bindings.

|Auxiliary e|Unit residue/height inputs|Degree19 Horner stages|
|---:|---:|---:|
|0|59962061953248|1139279177111712|
|167|61153275496992|1161912234442848|
|320|62244626827488|1182647909722272|
|640|64527191701728|1226016642332832|

These are alternative scenarios, not quantities to add. Their established metadata scope is unchanged. This review does not certify any coefficient, prime, analytic value, spectral result or implementation, and does not accept the new state-normalization packet. No inventory generator, evaluator or build ran; no frozen file was changed.

## Pins

All full paths below are relative to the repository. The12 earlier artifact pins are also retained in the owned receipt, including the author/independent occupancy and frontier scripts and receipts, combined-height receipt, reconciled receipt and minimal-theta receipt.

|Artifact|SHA256|
|---|---|
|work/qrh-campaign/agents/prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md|99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1|
|work/qrh-campaign/agents/major-constants/combined_odd_even_height_inventory_20261111.py|4C1B0FA0DA303A5EE475493A8CE66EB3723B3C9DFD9369DF9687069AF3F3E154|
|work/qrh-campaign/agents/major-constants/reconciled_nonprincipal_schedule_20261111.py|2B7EDAEE20811B50A4810E6C690071D2F8AC57E95B852DE2C17619877E85ABFB|
|work/qrh-blueprint/build_minimal_theta_schedule_20261111.py|6174F5C37C0C9D54C566427CD9BBA7E7CF4EBE4A897FA0B491AA29FE5057AFBA|
|work/qrh-campaign/agents/moebius/check_even_height_provenance_20261111.py|1F3D564470BF3168D975F83A3C7C5DA6CA423A2A84DA297EB6375630A65DB537|
|work/qrh-campaign/agents/moebius/check_even_height_provenance_20261111.json|124E7BD2DBDCA89F442BB86CC1D9599DF7AF9000D031E431D1147C8A9DA7F8C1|

The accepted old count chain needs neither a numerical repair nor an occupancy-note erratum. Any corrected successor must continue to bind its own exact height formula and pass its separate review.
