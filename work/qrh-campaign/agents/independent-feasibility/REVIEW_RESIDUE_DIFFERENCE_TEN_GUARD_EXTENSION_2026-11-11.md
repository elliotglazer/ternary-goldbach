# Review of the weaker full-state residue guard

2026-11-11. PASS at conditional polynomial, geometry and width scope, without correction. This binds `major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md`, SHA256 `AFA91F89C51BFC62FAB135997C6ED9FC7FCEAE3FBF6062F973F65AE69ADAC054`. The optional b100 representation retains its separate source/grid acceptance condition. No selected occupancy counts, savings or execution are adopted. No analytic values, coefficient values, transforms, primes, zeros, builds or source edits were produced.

I read the complete new report and script, V2's relevant full-state and error sections, the complete Newton initializer and its independent review, and the optional coefficient-grid closure note. The exact Newton identity is a reviewed input. The new work here is its enlarged polynomial domain and the resulting bounds on live states and actual raw arithmetic.

## Guard, cell endpoints and exact polynomial

The geometry uses F=2Dout. In particular the final delivered Dout8192 means F16384, even though its source grid is4096. Ties toward the smaller anchor give

    (2k-1)c < 2Fa <= (2k+1)c,
    q(a)=Fa-kc, v=2c, -1/4<q(a)/v<=1/4.

The stated floor formula and open-left, closed-right bucket endpoints agree, including exact ties. These buckets partition every integer numerator from1 through c-1. Their maximum integer length is ceil(c/F), including clipping at the two physical endpoints.

If c<=10F, each nonempty bucket contains at most10 integers. Hence c-1<=10B_c and phi(c)<=10B_c. Contraposition proves the stated screen implication. It covers equality c=10F. B_c must count all nonempty integer buckets; changing it to unit runs, useful buckets or a selected partition would invalidate this proof without another argument. No actual totient or unit distribution estimate is needed.

Under c>10F, every physical numerator a in a fixed bucket and every support offset0<=t<=19 satisfy

    |q(a+t)/v| <=1/4+19F/(2c)<6/5.

The anchor remains fixed at its original bucket. Reassigning the auxiliary point to its nearest new anchor would change the polynomial. Auxiliary arguments can leave the cell or the physical alpha interval. The theorem evaluates the finite degree19 polynomial there, and does not consume a Hurwitz error theorem at those arguments.

For exact centers n_j/2^b, Q=2^b v^19 and the stated integer numerator I, the identity I/Q=P holds at every argument by finite algebra. The rational geometric sum through degree19 is below256. Thus supporting values have norm below256 C Q and differences of order j have norm below256 C 2^j Q. The latter uses the sum2^j of binomial magnitudes and permits arbitrary coefficient signs and cancellation.

This bound applies at each live physical numerator, not only the cell start. Full-state ascending updates therefore remain bounded through a short endpoint bucket. Nonunits still advance the state, and no advance after the final physical numerator is required. The pruned long-block alternative and its different operation counts are not substituted here.

## Newton raw products and widths

The accepted binomial-basis recurrence is algebraic and does not itself require c>20F. Its partial-stage invariant J_i permits the new bound

    |Delta^j J_i(0)|<256 C 2^(b+j)v^i.

Writing the new top first, descending through interior indices and updating D0 last preserves the old lower entries needed by this recurrence. Later traversal uses the opposite, ascending order.

At an interior update, separate raw-product bounds give the sum coefficient

    256 [1/4+j/20+j/40] <512.

This includes the raw operands before cancellation. Interior j<=i-1<=18, so its extra factor2 is offset by one fewer possible difference order. With C=2^16 and v^i<=v^19, the interior raw products and sums remain below2^43 Q. The new top uses the previous order i-1 and iF/v<i/20. D0 has raw sum coefficient at most64+1, safely below256. Initial coefficients and prescales also fit. Binary small-scale partial sums have the same coordinate sign and no greater magnitude than the final scale; no extra cancellation assumption is needed.

Consequently stored full states and Newton initialization temporaries fit the same2^43 Q bound. Traversal's raw addition has the conservative2^44 Q bound, after which the exact invariant restores the stored-state bound. These are six bits above the old screened full-state capacities. The actual-family factor estimate also retains the narrow factor width:

    |q0+jF|<=132900+18*16384=427812<2^19.

Small factors iF are below2^19 as well. These statements use the actual conductor and output-grid caps, not just the looser6/5 argument bound.

Since v^19 has at most362 bits, sufficient signed capacities are b+406 for live/Newton raw state, b+407 for traversal temporaries and b+379 for coefficient prescales. At b100 these are506,507,479; at b122 they are528,529,501. The final cancelled divisor has362 or384 bits at g100. These are conservative capacities conditional on the actual common grid. They are not claims about arbitrary encoded input integers, exact hardware layouts or minimum widths.

## Unchanged source error and optional requantization

Every exported unit remains in its original cell with |h|<=1/4. Exact difference arithmetic introduces no new rounding radius. Final signed nearest-grid conversion satisfies the retained two-sided integer inequality and gives complex error below2^-100. Its ordinary quotient/remainder proof is still required. The actual in-cell output bound and final divisor do not grow merely because auxiliary difference states are larger.

For original centers on a proved common grid, the source-to-polynomial errors remain unchanged and the final evaluation contribution is below633u_H after the inherited normalization. The optional b100 route uses new centers and must separately prove their grid, magnitude margin and source binding. At actual in-cell targets its center change is below(4/3)u_H, so the combined evaluation contribution is below1477u_H, less than the old1688u_H. There is no256 multiplier in that comparison because no approximate analytic value is required at auxiliary points.

This review checks that conditional composition and reads the grid note's specified interface. It does not replace the independent full source review of that representation packet. Norm accuracy alone does not imply grid membership. Any selected requantization needs its20 complex conversions and actual input-width costs, and original-center Horner remains the stated fallback. Running unchanged Horner on the new centers would require its own combined allowance.

The per-bucket Newton counts are unchanged, but the weaker guard does not price a newly admitted subset. All-numerator advances, zero-unit buckets unless separately removed, geometry, coefficient conversion, prescales, wide final division, storage and ordinary proof construction remain charged. The product-only screen now supplies the enlarged domain, not a cost theorem.

## Independent evidence

Owned script `independent-feasibility/review_ten_guard_difference_20261111.py`, SHA256 `E7D6F17929AA1B33DE47C805CE9577FCE965D13F942D5DAAD3B65F3DD637F0A9`, and final receipt `independent-feasibility/review_ten_guard_difference_final_20261111.json`, SHA256 `A7723C89E38D26A587898634BD2ADCD97360C0AE5B30FD8506453AD746C7B5E4`, pass40059 exact checks. The three author pins and four predecessor pins match. The author program was neither imported nor executed.

The checks independently use the closed geometric-series formula, all partial-degree and raw-product coefficient bounds, endpoint-constructed abstract bucket partitions with exact ties, guard boundary cases, actual maximum factors, signed capacities, final error comparisons and unchanged small-scale counts. The abstract partitions are not a selected-conductor occupancy scan. No actual coefficient or analytic polynomial samples occur. The full Newton polynomial identity remains the earlier reviewed input rather than being presented as newly proved by these checks.

The accepted result is the explicit c>10F full-state extension with its larger bounds and unchanged in-cell source contract. Concrete arithmetic certificates, a selected coverage manifest, representation acceptance, complete prices and spectral sign/count evidence remain open.
