# Bounded adversarial checks of the rational xi receipt

2026-11-11. **PASS for the specified consistency and rejection controls.** The genuine one-node PARTIAL packet passed the actual backend's `--check`. Six modified copies were rejected. A separate rational structural checker passed the full receipt and rejected nine targeted mutations. This is not the independent full analytic replay, which is a separate task.

## Pins and executed scope

| Artifact | SHA256 |
|---|---|
| Author candidate `integration/rational_xi_panel_candidate_20261111_01.json` | `1B55E8A2665EF872056DE9747670E6F47017863A49D9E2C9A2D6604B6F74D09F` |
| Actual backend `integration/rational_xi_panel_backend_20261111.py` | `DEE8AC9AA39F25023C77003BC2AAA5970388A016207AD5A8EE0DF8F6D912F84A` |
| Independent test script `audit/adversarial_rational_xi_receipt_20261111.py` | `956C6F4CF45FC736E9A91E9FE72280AD6AA8EB54746DA109217044CC91F43EAC` |
| Test receipt `audit/adversarial_rational_xi_receipt_20261111.json` | `FA983570121F58883424F2798D78C0905CF7AEF4A625F167D76F63D0D9E14989` |

Paths are relative to `work/qrh-campaign/agents`. The candidate and backend hashes were checked both before and after the experiment. All new packets, authorization copy and subprocess logs are under `audit/rational_xi_adversarial_20261111/`; each test packet and log hash is in the test receipt. The author candidate was not edited.

The test script exited 0. No Lean command ran. No new grid point was evaluated: the actual backend evaluated **node 0 only**, on six invocations, with one additional target-mutation invocation rejected before node computation. Each invocation also performs its normal exact scalar-budget replay. The full 929-node analytic calculation was not duplicated.

## Independent full-receipt arithmetic and structural checks

The separate checker does not import author code. It binds the exact target independently, including T_input=32, T_work=14 and b=pi/4-1/33. It checks the complete ordered 929-node list and 1857 signed-weight rows, with seven orders each.

For every saved P box it verifies endpoint order, reconstructs the canonical 2^-32 midpoint-floor center, recomputes the exact L1 center-to-box radius, and checks the node radius and center norm limits. For weights it checks integer center shapes, seven orders, the claimed nonnegative radius bound, and the exact zero-node weights. **It does not establish the analytic truth of the P boxes or the weight-radius claims.**

It independently reconstructs all 12,999 signed complex center products, using conjugation for negative P nodes, and recomputes the seven coefficients at denominator 2^96. It then recomputes U, the real margin, the accepted scalar error field, positive-disk status and the constant-image winding fields. The exact margin is

`38298917929334686432095733439357895762079 / 2722258935367507707706996859454145691648`,

which exceeds 1/10. This arithmetic conclusion is conditional on the enclosures; it is not a new independent xi evaluation.

The following separate mutations were rejected at substantive consistency checks, not merely by comparing the whole candidate hash:

| Mutation | Rejection |
|---|---|
| T_input changed to 14 | Exact-target comparison |
| Last positive node removed | Complete unique node sequence |
| Node 1 replaced by node 0 | Complete unique node sequence |
| Last signed weight removed | Complete unique signed-weight sequence |
| Signed weight row duplicated | Complete unique signed-weight sequence |
| Node-zero real center increased by one grid unit | Canonical center recomputation from its saved box |
| Node-zero radius replaced by zero | Exact center-to-box radius recomputation |
| First signed weight's real center increased by one grid unit | Exact coefficient reconstruction |
| Constant coefficient's real integer increased by one | Exact coefficient reconstruction |

These are targeted single-mutation controls. A coordinated replacement of claimed analytic boxes, centers and sums is not ruled out by structural arithmetic alone.

## Actual backend replay on a valid partial packet

I constructed the positive control by copying the genuine target, pins, authorization and scalar budget, retaining only the original node-zero record, removing the full assembly, and setting status PARTIAL. The actual frozen backend was invoked with `--check`, this owned packet, the copied exact-target authorization, and a 90-second cap. It exited 0 with exactly `MATCH`, one node, status PARTIAL. It did not promote that prefix to a panel certificate.

Starting separately from that valid prefix, these mutations each exited nonzero:

- T_input changed from 32 to 14: rejected by the saved exact-target comparison.
- First modular translation integer changed from -1 to 0.
- Theta tail field changed to zero.
- P-box real interval replaced by [0,0].
- Node real center changed by one grid unit.
- Node radius changed to zero.

The last five reached `AssertionError: replay node mismatch 0`. None was a timeout or infrastructure failure. The subprocess logs and exit codes are preserved. The valid run took about 1.50 seconds; the corrupted runs took about 1.35–1.58 seconds each. These are bounded control timings, not full-grid performance estimates.

## Interpretation

The backend does **not** interpret a saved modular word or tail flag as proof. It recomputes node zero from exact target inputs and pinned implementation, including the dynamic word and arithmetic, and compares the resulting record. Thus changing word/tail metadata is rejected by reproducibility equality. This is a useful control, but does not independently prove the modular identity or analytic tail theorem.

Similarly, the full structural checker recomputes consumed center sums rather than trusting saved coefficients. It still takes the analytic enclosures as claims. The separately assigned independent arithmetic/analytic computations supply a different evidence gate; the coordinator reported both had passed as this review was finalized, but their outputs were not audited in this task. These tests neither replace those computations nor extend the candidate beyond its single specified disk and rectangle. No high-height spectral conclusion, global provider, or Lean proof follows from this receipt-control review.
