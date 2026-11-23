# Domain clarification for the nonprincipal reuse audit

2026-11-11. This companion preserves the original audit at SHA256 `04BC725844FF3AB7B596BFAF65450F07376A06D557B056540C40CEE21A67D097`. It makes the domain of its section 4 explicit, as requested by the independent reviewer. No formula or accepted parent theorem changes.

Every section-4 ledger and bound is under these conditions:

* c is an integer greater than 1; chi is an actual primitive nonprincipal character of conductor c, and a in {0,1} is its matching parity.
* The coefficient center is s0=sigma+i*t0, with `111/200<=sigma<=2`, `|t0|<=T`, and `T>=1`.
* b is real and fixed throughout the packet. The strip width satisfies `delta>0` and `|b|+delta<pi/4`.
* The rational lower bounds satisfy `0<q_*<=cos(2(|b|+delta))` and `0<q_b<=cos(2b)`; in particular both are at most 1.
* `h>0`, K and d are natural numbers, V=Kh, and `0<=rho<1`. The spatial error additionally requires `(q_b/c)*exp(2V)>=1`.
* All reported node, weight, transform, normalization and rounding radii are nonnegative and bound the actual quantities in the units specified by the ledger.

In particular `D_sigma<=2c^4/q_b^2` uses the stated real-part and parity ranges. It is not asserted at arbitrary sigma. The entire Taylor-series argument then extends the resulting center-coefficient estimate to its indicated disk; it does not extend the original center hypothesis to arbitrary centers.

No node or character value, numerical scan, or formal proof was produced for this clarification.
