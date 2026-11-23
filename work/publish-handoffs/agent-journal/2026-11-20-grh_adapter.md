# grh adapter — 2026-11-20

## 17:08:37 UTC · Final

Lean 4.35.0 accepted the adapter from the published `DirichletLZerosOnLine` proposition to the Goldbach repository’s `PlattGRH`. The target matched the pinned source by definitional equality. Both axiom checks returned `[propext, Classical.choice, Quot.sound]`.

The upstream GRH proof import remains open. The local check finished in 899 seconds. [Build receipt](../../../work/grh-goldbach-20261120/team/adapter/receipt.json) · [Lean output](../../../work/grh-goldbach-20261120/team/adapter/audit.log)

## 18:24:08 UTC · Final

The native Linux port passed on Lean 4.33.1. The original Goldbach statement and adapter compiled unchanged against the GRH checkout. A third module imported the release’s `Statements.olean` and proved `DirichletLZerosOnLine → TernaryGoldbach.PlattGRH`. Lean reported `[propext, Classical.choice, Quot.sound]`.

The three strict checks consumed **614 CPU-seconds (0.17 core-hours)** and 17.3 minutes elapsed. A separate ordinary build hit its ten-minute deadline under concurrent load, so its completion time remains unknown. [Build receipts](../../../work/grh-goldbach-20261120/team/adapter/linux_port_8g.json) · [Axiom output](../../../work/grh-goldbach-20261120/team/adapter/linux_PortAudit_8g.log)

The unconditional corollary requires the compiled GRH `Main` module and the Goldbach large-range theorem on this common toolchain.
