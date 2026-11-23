# Fourier interpolation rate

Take coarse-node step as the unit for the independent variable. The real Fourier sum has terms `a_j cos(w_j x) + b_j sin(w_j x)`. For a negative-exponent transform, use its signed frequencies or reverse the sign of the sine coefficient. A translation of the coarse origin rotates each coefficient. Its new real-plus-imaginary absolute sum is at most twice the old one, since sine and cosine each have absolute value at most one. The certificate charges that factor of two.

`FourierJet.finitejet_diffl` differentiates the actual trigonometric functions at every real point and every order. `finitejet_bound` gives `n cap omega^k` when each coefficient has real-plus-imaginary absolute sum at most `cap` and all frequencies have absolute value at most `omega`. `finitejet_taylor` gives the finite Taylor polynomial about zero with the order-k derivative evaluated at a point between the origin and the argument in absolute value. The frequency ceiling in the kernel is `omega = 44 J / (7 N)` for `J=68267`, `N=524288`, using `2 pi < 44/7`. The global coefficient allowance is `C=(2J+1)(2*1250000^2+1)`.

For one stencil put `x=f/4096`, let `u_i=1-r/2+i`, and write the normalized weights as `v_i=w_i/den`. Choose `K=2r+64`. Taylor expansion gives the following uniform interpolation bound divided by the translated coefficient allowance:

```
E = sum over 0 <= m < K of
      omega^m/m! * |x^m - sum_i v_i u_i^m|
    + omega^K/K! * (|x|^K + sum_i |v_i u_i^K|).
```

For m below K the Taylor coefficient is common to every node, so subtraction occurs before taking the absolute value. Each evaluation has its own terminal Taylor remainder. The terminal term therefore sums absolute values. The supplied 55 sets of actual weights also cancel the first r exact moments.

`check_moment_rates.py` performs the rational calculation on every row. `MomentRatesScript.sml` performs the independently formulated integer calculation using each original `StencilReceipt.kernel_i` constant. It proves the finite inequalities equivalent to `2 E <= omega^r (r/2)!²/r!`. The same finite certificate serves every channel that meets the coefficient allowance. The stronger bounds specific to the four available coefficient columns are recorded in `coefficient-mass.json`. They apply to the stored integers, and to true coefficients only if their enclosure errors are also included.

For the integer calculation set `U=44J`, `V=4096*7N`. Initially the list of (signed coefficient, scaled node) is (den,f) followed by (-w_i,4096u_i). On pass m the first component at each node is its original signed coefficient times its scaled node to power m. Let D_m be the absolute sum of those signed components, using the sum of absolute values instead at the terminal pass. The recurrence is `A_m = m V A_(m-1) + U^m D_m` with initial accumulator zero. Thus `E=A_K/(den V^K K!)` for positive den. The frequency and stencil certificate are shared. Verifying the coefficient bound against true model data, the identification of the true model with the supplied Fourier coefficients, and the coarse-node enclosures are channel inputs unless an independent uniform analytic theorem establishes them for the family.
