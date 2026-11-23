# Interpolation error in grid units

`InterpolationConsumer.interpolation_consumer` bounds the difference between the target and the normalized signed integer stencil dot product by the certified integer radius. Its two analytic hypotheses bound the approximation by a finite model and the interpolation of that model. The target and coarse samples use grid units with scale `Q = 2^220`.

`CenteredProduct.centered_product_bound` bounds the absolute product of distances from a point in `[0,1]` to the centered `2h` nodes by `(h!)²`. `StencilGeometry.all_55_nodes` checks the integer-scaled products for the actual table. `WeightedSample.certified_coarse_samples` propagates a two-unit coarse-sample error through the certified weights, giving `10*den` before division by `den`.

`RadiusBudget.radius_real` supplies the arithmetic needed by a retained-sign consumer. With `A = 512*4*3^64*2^80`, `D = (7*524288)^r*r!` and `M = (2*68267+1)*(2*1250000²+1)*(44*68267)^r*((r DIV 2)!)²`, `radius_ok r err` implies `10 + Q*(5*524288*D + A*M)/(A*D) ≤ err`. Multiplication by the positive denominator supplies the retained margin budget.

Applying this result to the actual Hardy function still requires the finite-model approximation error, the interpolant remainder bound for that model, and the true coarse-node enclosures. The node-product theorem supplies the geometric factor in the remainder estimate.
