# Independent review: actual middle-frequency estimates

2026-11-11. **PASS at the bounded source/mathematical cut below; no correction required.** I read the complete author report `integration/QRH_MIDDLE_FREQUENCY_ANALYTIC_AUDIT_2026-11-11.md`, SHA-256 `1B4B178F58A8DE23573F978D0C302F2AD2D02FEC5D31474BD9DE81B264F1348B`, and checked its central implications against the actual proof bodies. This is not a Lean build, elaborated-axiom check or validation of the entire QRH provider. No analytic values were evaluated and no source or prior frozen report was changed.

Source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL`, intended commit `4eaee87548250b2682affda7d05d947c05554bae`.

## 1. Actual functions and carriers

`Poisson/LatticeEnvelopes.lean:166–201` defines nonnegative real `originalMiddleAt` and `dualMiddleAt` by summing norms of the actual finite coefficient sums. The frequency carrier in the four audited theorems is precisely the nonzero Eisenstein lattice. This is neither the full lattice nor a freely truncated finite set.

The original radial argument is `sqrt(M/b_i)*q(h)/(de)` with outside factor `sqrt(M/b_i)/(de)`. The dual argument is `sqrt(F*n_j*n_k/(M*b_i))*q(h)/(de)` with outside factor `sqrt((M/F)/b_i)/(de)`. The dual kernel depends on both columns and cannot be moved outside their sum. The source uses separation to handle that dependence.

The source theorem allows the coefficient vectors to vary arbitrarily with the lattice point, subject only to coordinatewise norm domination by fixed vectors. Since the carrier is discrete, no measurability hypothesis on this variation is being omitted. Constants selected after the fixed Schwartz function and decay order precede the scales, finite families and coefficient vectors. The admissibility, injectivity and norm-window hypotheses stated in the report match the consumed source contracts.

## 2. Genuine summability and the two scale regimes

I independently reconstructed `GaussSum/MixedConversion.lean:548–721` and `LatticeEnvelopes.lean:79–126`. The lattice Cauchy sequence is genuinely summable: the exact integer-coordinate equivalence and the quadratic norm inequality compare it to a product of two summable one-dimensional Cauchy sequences. The proof uses this summability before a `tsum` inequality.

For `0<t<=1`, the complete lattice bound gives

`t sum_h (1+t*q(h))^-2 <= 4(1+pi)^2`.

For `t>1`, nonzero lattice points satisfy `q(h)>=1`, and the elementary pointwise comparison

`t/(1+t*q)^2 <= 4/(1+q)^2`

gives the fixed unscaled Cauchy-mass bound. Removing the zero point is essential: its contribution multiplied by `t` would be unbounded as `t` grows. Adding the two regime constants yields the report's `L=4(1+pi)^2+4*eisensteinCauchyMass`.

Consequently, whenever `f>=0` and `(1+t*q(h))^2*f(h)<=C`, `nonzero_lattice_envelope_sum` proves both `Summable f` and `t*sum f<=L*C`. A default value for a nonsummable series is never used. No cancellation across frequencies is claimed.

## 3. Exact source and dual normalization

`SpatialDerivatives.lean:199–218` bounds the nonnegative outside factor by `2*sqrt(M/B)/(D1*D2)`, before applying it to the sum of norms. Taking decay order two:

- Original: `t=sqrt(M/B)/(D1*D2)>0`. The numerator of the Cauchy envelope is `2*t*C_W*sqrt(Bcost)`. Summation cancels exactly `t`, leaving `2*L*C_W*sqrt(Bcost)`.
- Dual: `t=N*sqrt(F/(M*B))/(D1*D2)>0` and `r=M/(F*N)>0`. `LatticeEnvelopes.lean:266–272` proves `sqrt((M/F)/B)=r*N*sqrt(F/(M*B))`. Thus the numerator is `2*t*r*C'_W*sqrt(Bcost)`. Summation cancels only `t`; the factor `M/(F*N)` remains.

The source proof at `LatticeEnvelopes.lean:215–262,277–340` uses coordinatewise coefficient domination before summing. There is no omitted cardinality or extra factor of `N`, and no division by the coefficient energy. Empty pools and zero coefficients are covered.

## 4. Separation uses the actual phase and radial kernel

I read `DivisorBlocks.lean:392–493,623–708`, `PrincipalDifference.lean:181–290` and `SpatialDerivatives.lean:77–174`.

`radial_matrix_kernel_transfer` obtains a single Schwartz Fourier coefficient function for the whole bounded logarithmic rectangle. It establishes integrability of every matrix entry from the unit-modulus continuous phases and the integrable coefficient function before interchanging each finite sum and integral. The sum of row norms is bounded through its uniform phase estimate, so the argument does not introduce a hidden matrix-cardinality factor.

The sign is correct. The left coefficient is multiplied by the conjugate of `logPhase(t,y_j)` and then enters the original term conjugated; the right coefficient is multiplied by `logPhase(t,z_k)`. Their combined multiplier is the positive `logPhase(t,y_j+z_k)`, while both coefficient norms are unchanged. The square-root passage uses nonnegativity of the norm sum and the squared finite-block bound.

For the original kernel the source proves `1/4<=middleRatio<=2`, and hence `abs(log(middleRatio))<=4`; the other two logarithmic variables are zero. For the dual kernel, two additional factors are `sqrt(n_j/N)` and `sqrt(n_k/N)`, with absolute logarithms at most four from the lower and upper column windows. The exact positive square-root identity reproduces the true dual argument. Both normalizations require `h!=0` to ensure the scale `R>0`. The report correctly distinguishes windows `(4,0,0)` and `(4,4,4)`.

The finite block cost at `DivisorBlocks.lean:84–140,202–285,511–514` includes `256^2*D1*D2`, both actual sieve norms, both support/divisor constants and both coefficient energies. Factoring the original row through its ideal divisor costs only factors of norm at most one. The quotient estimate invokes the finite coprime divisor-block and quotient-matrix restriction inequalities, then pays both ideal-pool cardinalities. Those underlying inequalities remain lower inputs; this review does not infer them merely from their names.

## 5. The old exponent and final gates

I independently read the full derivation at `FirstCoreCutoff.lean:501–611` and `LatticeEnvelopes.lean:346–462`. The square root of the cost is exactly

`E_eps(a0,b0) * sqrt(D1*D2*sieveNorm(B,N/D1)*sieveNorm(B,N/D2))`,

where `E_eps=256*supportConstant(eps)*divisorConstant(eps)*N^(2eps)*sqrt(Ea)*sqrt(Eb)`.

`HasSieveExponent.divisor_pair` uses the existing witness's reverse theorem. Its fixed reversal cost `262144` stays inside the chosen constant. `D_i<=N` ensures the smaller column lengths `N/D_i>=1`; `D_i>=1` bounds the loss factors by `(BN)^delta` and permits the elementary two-factor square-root comparison. The same loss `delta` is used in each factor; the subsequent square root restores a single `(BN)^delta`, not its square. No stronger exponent is assumed in this step, and no `alpha>=1/2` premise is needed here.

The source gate `D1*D2<=U*sqrt(M/B)` then gives `N+U*sqrt(M)*B^(alpha-1/2)`. The dual gate `D1*D2<=U*N*sqrt(F/(MB))`, after the retained factor `M/(FN)`, gives `M/F+U*sqrt(M/F)*B^(alpha-1/2)`. Positive-base real-power identities justify both forms. Later window consumers supply `2U`; the report does not silently insert it into these four producer statements.

## 6. Uniformity qualification and remaining foundations

The report's qualification concerning classical-choice constants is necessary and correct. `originalMiddleDecayConstant(W)` and `dualMiddleDecayConstant(W)` choose admissible witnesses after `W` is fixed. Existence of a separately controlled witness does not imply every chosen witness satisfies the same upper bound. A later theorem uniform in `W` needs its own explicit witness construction or comparison theorem.

At the current cut, `IdealQuotients.lean:305–436` constructs a compactly supported positive-log profile and its Fourier coefficient, with constants chosen before `R`. Its smooth cutoff, unlike the external interval selector functions, is what is differentiated. `RadialFourier.lean:394–424` supplies finite source-seminorm Euler bounds. I checked these contracts and their use; the derivative estimates and Fourier bounds underlying them remain named lower foundations, as do the finite coprime divisor-block/quotient restrictions and the base ideal/row/counting facts. The fixed-`W` four-theorem conclusion does not need the stronger unproved bound on every selected witness.

No spectral premise, new final hypothesis, sharp-sieve closure or full QRH proof follows from this review. The earlier masked-Poisson review remains a separate consuming assembly.

## Frozen evidence

All ten source pins and six supporting-report pins in the author report were independently rehashed and matched. The reviewed ranges above, rather than the mere presence of a file hash, delimit the mathematical inspection.

- `check_middle_frequency_source_20261111.py`: SHA-256 `19DC44C9321024B51BB673CBA725FA8EAD5EF553E506494BD96B8C4751C1AB6C`.
- `check_middle_frequency_source_20261111.json`: SHA-256 `B4A9DF10BCF7E604A05079BE84532050A04E8B27F83326F9CC8FA6990BD235FE`.

The checker only hashes files and writes the reconciliation receipt. It neither evaluates analytic functions nor invokes Lean.
