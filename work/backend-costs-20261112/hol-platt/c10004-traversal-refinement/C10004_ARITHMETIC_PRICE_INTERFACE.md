# Arithmetic price interface for the selected c10004 transform

This is a source-traced count and scalar model comparison, not a proved cost theorem or performance measurement. The small counter follows the accepted reference's exact fuel-6 node splits, leaf output loops and special-root branches. It does not evaluate numerical inputs. The reference source hash is pinned in c10004_operation_count.py and the JSON result.

The selected outer tensor has 2400 omitted length-2 nodes, 60 omitted length-40 nodes and 39 omitted length-60 nodes. General root products are 178 per length-40 call and 360 per length-60 call, giving 24720. Complex adds/subtracts are 1, 279 and 479 respectively, giving 37821. Quarter turns total219. There are also12921 identity actions and no separate negation actions in this traced schedule; length-2 subtraction is already in the add/sub count. Cache-entry preparation is not counted as transform arithmetic here.

| Role | Count | Existing planning factor per reference butterfly | Nominal CPU seconds |
|---|---:|---:|---:|
| General complex unit-root product | 24720 | 0.25 | 0.0557950 |
| Complex addition or subtraction | 37821 | 0.02 | 0.0068292 |
| Quarter turn | 219 | 0.005 | 0.000009886 |
| Sum of these roles | | | 0.0626341 |

The price uses the frozen HOL anchor0.073960/8192 seconds per reference butterfly and the existing model's planning type factors. The width/type factors remain unmeasured assumptions. Campaign auxiliary and refinement allowances are not applied to this single scheduled transform. No global inventory is regenerated or changed.

The forecast already assumes production adapters. A speedup against the approximately2-second tx08 public reference calls is therefore not itself a reduction against the model. The public calls also generate their synthetic inputs, construct caches, perform guards, and prove a Boolean output property. Their time and the0.0626-second arithmetic subtotal have different boundaries. A matched benchmark must retain both the complete call price and any justified internal separation before replacing model rows.

Excluded from this scalar subtotal are list traversal, copies/allocation, source and actual-root generation, root-cache construction, public guards, source contractions, completion and sign radii, count closure, term admission, export and retries. Their ownership remains in the full model or unresolved production work. The independent source trace has not been verified in HOL or cross-checked against an instrumented run. Even confirmation of this local count and price would not establish a whole-campaign improvement or a1:2 ratio.
