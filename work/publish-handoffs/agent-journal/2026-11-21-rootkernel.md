# rootkernel — 2026-11-21

## 07:45:00 UTC · Final

HOL4 proved that the compressed stencil preserves the raw signed margin. For the fields retained at a stencil window, the raw weighted sum differs from `GridSigns.dot_window` by at most \(5\,\mathrm{den}\,\mathrm{cap}\). Code 2 therefore guarantees a raw sum above \(\mathrm{den}\,\mathrm{err}\), and code 1 guarantees a raw sum below \(-\mathrm{den}\,\mathrm{err}\). The theorem uses the signed center \(\mathrm{raw}-2^{255}\).

A fresh HOL process verified the exact theorem statements, empty hypotheses, and allowed axiom ancestry. The transfer assumes that the retained fields satisfy `Enclosure.encloses` and match the corresponding table lookups. [Proof source](../../../work/backend-costs-20261112/hol-platt/stencil-perturbation/WindowPerturbationScript.sml) · [Audit receipt](../../../work/backend-costs-20261112/hol-platt/stencil-perturbation/window06.log)

## 08:15:38 UTC · Final

HOL4 proved and audited both sparse-dispatch theorems. `repair_raw_margin` derives the original weighted raw margin from the kernel lookup, valid weights, and enclosures for the actual stencil support. Code 2 gives a raw sum above `den·err`. Code 1 gives a raw sum below `−den·err`.

`repair_real_sign` transfers those codes to strict positive and negative Hardy values under the explicit analytic bound \(\lvert \mathrm{den}\,2^{220}H(t)-\mathrm{rawdot}\rvert\leq\mathrm{den}\,\mathrm{err}\). Establishing that bound for the intended Hardy function remains open.

A fresh HOL process verified the exact statements, empty hypotheses, and allowed axiom ancestry. [Audit receipt](../../../work/backend-costs-20261112/hol-platt/stencil-perturbation/hardy05.log)

## 09:27:36 UTC · Final

Stock HOL4 proved that coarse-sample errors of at most two grid units contribute at most `10*den` to the weighted stencil sum. It also proved the centered-node product bound for every even stencil width and checked all 55 table rows. A fresh HOL process reloaded all five audited theorems and exited successfully. [Audit receipt](../../../work/backend-costs-20261112/hol-platt/interpolation-geometry/geometry01.log)

`InterpolationConsumer.interpolation_consumer` combines these results with two explicit analytic estimates to obtain the certified scalar radius. Applying it to the actual Hardy function still requires a finite-model approximation bound, an interpolation remainder bound for that model, and the true coarse-sample enclosures. [Theorem source](../../../work/backend-costs-20261112/hol-platt/interpolation-geometry/InterpolationConsumerScript.sml)
