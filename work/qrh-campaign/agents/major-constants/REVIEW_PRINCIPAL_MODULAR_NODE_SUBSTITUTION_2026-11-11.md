# Independent review of principal modular-node substitution

2026-11-11. **PASS at paper-composition and source-fidelity scope.** No required mathematical correction was found. This review does not certify any new quadrature grid, Taylor packet, panel, spectral result, or Lean declaration.

## Frozen input and source boundary

The reviewed file is `integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md`, SHA256 `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571`. The complete note was read independently. Its six input hashes were checked against the local files.

The accepted corrected quadrature source is `integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md`, SHA256 `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`, with review `ECBC1125309A4AA81EBFF709A9637A0AD7D554A1ABBAF9E350AAF2969F3A85D2`. In particular the corrected discrete derivative-tail threshold is 2, and normalized versus unnormalized FFT scales are distinct. The original version rejected on these points is not an input here.

The modular kernel source and its review are pinned at `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D` and `9C2C4348EC29A5C3B4ACD6221CFE96F011C191395877E3654FC69DD81C7987ED`. The four-node pilot and review pins are `F0833712D50FBE36BDC8E29173A277CCBDC2C0CBAF4A1F7CA86F4F80B28E752D` and `DC6B6117AD793BF2983231373F54710A65E65F3E73A7E9B73CDB86664D38BA9F`. That pilot is evidence for four external coefficient evaluations only. It does not supply the arbitrary node hypotheses in the proposed composition theorem.

I re-read the source target `Explicit/Xi.lean` at commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`, SHA256 `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F`. It defines the unhalved xi at line 18 as `s*(s-1)*completedRiemannZeta0(s)+1`, proves entirety at line 20, and supplies the product and zero-location relations afterward. No factor 1/2 can be inserted. The composition uses the already reviewed differentiated-kernel identity, rather than a new interchange of the critical-line zeta series.

## Function identity, kernel nodes and signs

The fixed-b function is exactly

`F_b(s)=exp(-i*b*(s-1/2))*xiF(s)`
`=integral_R P(v+i*b)*exp((s-1/2)*v)dv`.

It is entire. Changing b with the differentiation variable would change its derivatives; the note correctly holds b fixed through every Taylor disk and panel. The same applies when assembling a contour from several panels.

The modular formula reconstructs the full accepted kernel. At tau=i*exp(2w), it is

`P(w)=exp(w/2)*(6*tau*theta3'(tau)+4*tau^2*theta3''(tau))`.

Using `theta3'=2*pi*i*sum_{n>=1} n^2 exp(pi*i*n^2*tau)` and the corresponding second derivative gives exactly the coefficients -12*pi and 8*pi^2 in the producer. It neither omits nor adds a theta constant. Although the final expression uses two derivatives, the modular transport must retain the value component that enters the derivative transformation rules. That obligation belongs inside each node radius.

For negative v, evenness gives `P(v+i*b)=P(-v-i*b)`. It does not give `P(-v+i*b)` without a separate conjugation identity. The note preserves this distinction. At v=0 the true kernel value is evaluated once with full trapezoid weight h. For derivative order zero, `0^0=1` is the polynomial convention; positive derivative orders have zero weight at that node. A ball containing zero is never a proof that its actual kernel value vanishes.

Every supplied radius must enclose P at the exact node and exact b, including errors in the initial point, modular word, roots, reduced series, reconstruction and rounding. Different valid modular words at different nodes are allowed because their outputs represent the same P; they do not change the fixed-b analytic function.

## Quadrature and discrete spatial tails

For the normalized Taylor coefficient f_j, differentiation under the accepted Gaussian integral yields the weight `v^j/j!`. No derivative of P is needed when differentiating in s. The kernel differentiation needed to construct P is a separate operation.

On a displaced quadrature line w=v plus or minus i*r,

`|w|^j/j! <= exp(|w|) <= exp(|v|+r)`.

The original exponential factor contributes at most `exp(3|v|/2+T*r)`, and P contributes the accepted `A*exp(|v|/2-q*exp(2|v|))`. For j>=1, the product is bounded by `exp((T+1)r)` times the integrable majorant `A*exp(4|v|-q*exp(2|v|))`; using exponent 4 is a harmless relaxation of 3. Its integral is at most D. For j=0 the tighter majorant integrates to M. The two shifted Fourier tails therefore give exactly

`Q0=2M exp(T*r)/(exp(2*pi*r/h)-1)`,

`Qj=2D exp((T+1)r)/(exp(2*pi*r/h)-1)` for j>=1.

The extra exp(r) and the division by j! are both present in the correct places.

For real u>=V, the logarithmic derivative of the point majorant `exp(2u-q*exp(2u))` is `2-2q*exp(2u)`. It is decreasing once q*exp(2V)>=1. The derivative majorant uses 4 in place of 2 and needs q*exp(2V)>=2. Integrating the two real tails with R=exp(2V) gives

`S0=(A/q)exp(-qR)`,

`Sj=A exp(-qR)*(R/q+1/q^2)` for j>=1.

The discrete sum comparison applies to the omitted samples k=K+1 onward on each side, comparing each sample with its preceding interval. It needs the stated monotonicity starting at V=Kh. The continuous integral alone would not require this threshold. Thus the corrected threshold is substantive and is correctly carried into the new note.

## Substitution and arithmetic errors

For each exact weight w and node value P, center p, and weight center w_hat,

`w*P-w_hat*p = w*(P-p)+(w-w_hat)*p`.

This gives the weighted modular-node contribution B_j and the separate `sum d_(j,k)|p_k|` term. There is no missing mixed term. The factor in B_j is the exact absolute weight

`h*|v_k|^j/j!*exp((sigma-1/2)*v_k)`.

The signed v_k^j remains in the actual center calculation. Replacing it by its absolute value there would corrupt odd derivatives. The positive and negative exponential weights may differ, so symmetry of the nodes alone does not justify doubling one side's numerical error.

The sum error eta_j is measured against the exact rational center products. Combining these errors with Q_j and S_j proves the displayed E_j. Radius computations may use certified outward upper bounds for norms and exponentials, as the note permits. Correlation between shared constants or node computations does not affect these deterministic bounds.

The old direct-theta truncation term is correctly absent. A modular ball already represents the full P, with its reduced-theta tail included. Adding the old global direct truncation estimate would double-account for a different intermediate approximation. Conversely, omitting Q_j or S_j would be wrong: modular evaluation changes neither the infinite trapezoid approximation nor the omitted v nodes. A direct-sum node can be mixed in only when its own e_k includes its full tail and arithmetic error.

## Taylor disks, panels and recovery

The coefficients are f_j=F_b^(j)(s0)/j!, so the polynomial needs no further factorial division. On the unit disk about s0, the real-part displacement increases `|Re(s)-1/2|` from at most 3/2 to at most 5/2. The same D envelope bounds F_b there. This bound is independent of Im(s), because the defining integration line is real. Cauchy's estimate therefore gives |f_j|<=D and the geometric tail `D*rho^(d+1)/(1-rho)` for 0<=rho<1.

The coefficient perturbations add `sum E_j*rho^j`. A numerical enclosure of the polynomial on the entire parameter segment must still include its own arithmetic error. The note requires a whole-polynomial enclosure rather than sampling it. An enclosure excluding zero proves panel nonvanishing. If a downstream polygon checker requires one of its strict rotated half-planes, that additional half-plane test must be performed or the panel refined; nonvanishing alone is not automatically that particular certificate format.

The first-order alternative uses |F_b'|<=D on the original strip. It is valid only for a segment staying there, as stated. There is no claim that either panel test must succeed at a boundary zero.

The optional point recovery multiplies by `exp(i*b*(s-1/2))`, whose modulus is `exp(-b*Im(s))`. This may amplify errors for the opposite ordinate sign. The producer's explicit M_m bound correctly accommodates that possibility. Its product-error formula is the same valid split as above. Recovery of xi derivatives would require a Leibniz convolution; the note claims only point recovery and does not incorrectly scale each derivative separately.

The FFT paragraph also preserves exact normalization. At the indicated grid, the finite coefficient sum equals h times the positive unnormalized DFT, or h*L times the normalized one. The order-j factorial is already in the array. A transform error must be measured after this scale and after including input-center construction errors once. Only ordinates covered by the selected T inherit Q_j; finite-array periodicity gives no periodicity of xi.

## Exact diagnostics and acceptance scope

The independent script `review_principal_node_substitution_20261111.py` passed 99 rational checks of product-error identities, zero-node weights, normalized Taylor algebra, geometric remainders and the distinct monotonicity thresholds. It evaluates no analytic function, kernel, quadrature or spectral point. These are supplementary checks; the analytic justification is the argument above and the pinned accepted inputs.

- Script SHA256: `7C5DCADD54E979563EFF7A11186B1A7BECD9C4689915BCD4515E2C56CE74ABAE`.
- Receipt `review_principal_node_substitution_20261111.json` SHA256: `02825ED5102478C9BEFA9E7C9037E0CEE30D7A6F89D8F662AB49485773EEE5C5`.

This accepts a composition rule from proved full-kernel node balls to proved point, coefficient and panel enclosures. The four-node external pilot does not instantiate a general quadrature grid. The actual node data, elementary arithmetic soundness, analytic quadrature and modular adapters, finite arithmetic implementation, and complete contour/zero-count assembly remain required. No new final-root premise, finite spectral truth, or production performance claim is introduced.
