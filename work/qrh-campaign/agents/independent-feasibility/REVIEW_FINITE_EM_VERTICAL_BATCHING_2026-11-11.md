# Independent review of finite-EM vertical batching

2026-11-11. **PASS at paper-proof and conditional checker-interface scope. No mathematical correction required.** The signed-grid moment identity, absolute error composition, complete finite-g correction, and declared operation counts are valid. The downward-grid application retains the domain qualifications stated below. No logarithms, phases, moments, transforms, model values, function values, panels, or builds were evaluated in this review.

## Frozen inputs and independent checks

Paths in this table are relative to `work/qrh-campaign/agents/`. Each input hash was checked from the actual bytes. I read the full main, corrected scalar, transform, and companion review notes, and inspected the old finite-EM producer expression and relevant Mathlib definitions without importing or executing that producer.

| Input | SHA256 |
|---|---|
| `moebius/FINITE_EM_VERTICAL_BATCHING_2026-11-11.md` | `814AD0B3012FDA4FD81B485139257409E81E6EAC8FA44FD6824A7D21F02C8818` |
| `major-constants/EM_VERTICAL_BATCH_SCALAR_SUPPORT_2026-11-11.md` | `44C53A6F71D9B00368568D35C08D2ED69EC9ECA746AE61E2DDC8A79C5BA2C52F` |
| Its scalar script | `79D62492632A784D58019302F01C310849BB2B4A1D6AB4D782852F1DFCEA204C` |
| Its scalar receipt | `B68C8861B4F646C4EC43DEC00E5D364C33A1CEDF8C6F0C5FC976E72210F6F26F` |
| `integration/FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md` | `170C8F976A8AF8B299E4AB737E6924260B3B1D8328FA54C0F2BF7F6E9720F997` |
| `zero-sum/REVIEW_EM_VERTICAL_BATCH_SCALAR_SUPPORT_2026-11-11.md` | `4A7FF42F81E202C7842BEF8A0F294D1CB11F3F9812D91ECC282D39DCE32B0126` |
| `audit/REVIEW_FINITE_EM_VERTICAL_DFT_CONTRACTS_2026-11-11.md` | `F2DC3A12F4474E8469D45C741E0F1A7FBA5A1CAF61AEF6A1509749FDE8BFD406` |

My new standard-library script `independent-feasibility/review_vertical_batch_exact_20261111.py`, SHA `3D54B92ED497B150843281F319E9BFBE88FBE1748DDE69AB93D15EB51B8A5624`, passed 4,687 exact checks. Its receipt has SHA `D83B90662066115BAFF7253193D4316EF254740E2B4E047C26EFA03263AF1EBA`. These checks cover rational label boundaries of both signs, residue labels, factorial and weighted budgets, downward-grid endpoints, and independently reconstructed operation counts. They are finite algebraic diagnostics supporting the paper derivation, not actual logarithmic bin or transform certificates. No producer script was executed or changed.

## Grid, labels and finite identity

Require positive integers N, M, K, J, p and exact rational sigma, t0, Delta. There is no positivity restriction on Delta. The least power of two L at least 4J satisfies 4J<=L<8J and is nonzero. With x=L*Delta*log(n)/(2*pi), a rational enclosure of width at most 1/4 supplies midpoint error at most 1/8. The rational floor q=floor(midpoint+1/2) satisfies |x-q|<=5/8, also at a half-integer and for negative x. No decision about the exact transcendental bin boundary is needed. Certified refinement terminates because pi is nonzero and only finitely many continuous elementary inputs are requested.

Use k=q mod L only as the bin label. The residual r=J*(Delta*log(n)-2*pi*q/L) retains the full signed q. Then |r|<=5*pi*J/(4L)<55/56<1. Delta=0 and n=1 require no exceptional division. Their zero powers follow the ordinary convention.

For every integer j in 0,...,J-1,

`j*Delta*log(n)=2*pi*j*q/L+(j/J)*r`.

The first exponential is unchanged when q is replaced by its residue k. Multiplying the truncated second exponential by `n^(-s0)*(-log(n))^h/h!`, and partitioning the finite n-sum, proves the displayed moment identity. The answer is `L*sum_m (j/J)^m P_L(A_hm)_{-j mod L}` for the positive normalized transform. No input conjugation, frequency-rounding error, infinite alias estimate, or extra phase appears. The h! and m! occur exactly once. The true grid and true j/J remain unchanged.

I read the actual `dft_apply` and `invDFT_apply` at Mathlib `Analysis/Fourier/ZMod.lean:106,114`. Its byte hash is `012663E2EB3A3F3196C6BCE04CB530D04E29C8DE8C65AFE703F2D707484EFE10`. The positive transform is normalized and the negative one is unnormalized, as required. The main note consumes reviewed transform contracts, not an already implemented source FFT theorem for these new moments.

## Residual and arithmetic errors

Apply real Taylor's integral remainder to f(u)=exp(-i*theta*u) on [0,1]. Its p-th derivative has constant norm |theta|^p. Integrating the nonnegative kernel gives exactly |theta|^p/p!. This proves the sharper real-phase bound for both signs of theta without exp(|theta|). Actual residuals are real; uncertain enclosures enter the moment arithmetic budget separately.

Mathlib `Analysis/Calculus/Taylor.lean:535`, hash `0AB79A53A36F87AB2A69D907D7999D2516CC4C085799E306F97D8480AE8CA18A`, has the required complete real normed target, including complex numbers. Identifying its derivative and polynomial expressions with the explicit exponential remains an unimplemented formal adapter.

The normalized transform has input-error norm at most sum(epsilon_k)/L. Final multiplication by L cancels that denominator. A normalized arithmetic error alpha instead contributes L*alpha. Since 0<=j/J<1, summing their nonnegative polynomial weights proves equation (2), with final contraction and scaling errors in beta. Correlations among logs, labels and moments require no probabilistic assumption. The eta/4 allocations sum to eta. The stage-count-dependent precision prescription is a valid finite sufficient choice, not a fixed precision or runtime claim.

For the selected N, sigma and rho, extending the nonnegative derivative-weight sum bounds it by sum n^(-3/8)<8192. Multiplication by s-1 shifts the retained error coefficients once. The omitted degree-K product is not included in this bound; the finite-g Taylor remainder still controls the actual discarded Taylor series. If |s_j-1|>3rho, division costs a ratio below 2. Thus the new residual quotient error is below 2^14/p!.

The corrected arithmetic factor is 16/7, not 128/63. Independently checked exact arithmetic gives `2^14/32!+(16/7)*2^-104<2^-100`. This is a weighted norm bound. It is neither a per-jet bound of that size nor a complete error budget. If inserted as coordinate-square padding and subsequently measured in norm, its square-to-disk factor must be included. The independent exact check confirms that even 3/2 times this batching allowance fits with the old square allowance below 2^-42 on that allowance's original domain.

## Complete finite-g correction

The displayed R, Q and C reproduce every source half term, Bernoulli term and pole-removal term. Products modulo z^K preserve all retained normalized derivatives. Odd rising-factorial lengths end at 2M-1; the actual EM remainder separately has length 2M. Varying polynomial factors have not been inserted into supposedly fixed DFT moments.

The B-phase recurrence uses the actual unit step w, while its approximation may have norm greater than one. Its error recurrence follows by writing the next error as the old error times the approximate step plus the true phase times the step error. The finite sum version covers epsilon_w=0 without division.

For the correction product, the identity

`bhat*Chat-b*C=(bhat-b)*Chat+b*(Chat-C)`

proves the stated `e*|Chat|+A_B*gamma` error. No cross term is missing, because |Chat| is the computed-center norm. Equation (3) then includes the main jet, previous jet, all correction errors and final arithmetic. Reusing a correction or phase across blocks would need a new explicit contract; the note claims no such reuse.

## Whole-panel and signed-grid domains

The batching identity itself works on every specified finite signed grid. Its use for zeta needs separate target-domain EM bounds, entire finite-g outer bounds, a finite-g Taylor tail, complete coefficient/polynomial arithmetic, and sound division by the whole s-1 box. An entire finite-g outer disk may cross sigma=0. That does not authorize actual-zeta EM on that disk.

For the proposed downward left-side grid, centers are `.5032+i*(T-1/16-j/8)` and target vertical radii are 1/16. The union of actual ordinates is `[T-J/8,T]`. For J=1024 and 4096, the lower endpoints are exactly 999872 and 999488, respectively, both above 2^19. Thus these examples retain the old actual-point Re>=1/2 and norm bounds, the finite-g outer-disk bounds, and the original denominator lower bound. Horizontal crossbars require their own real-center batches and errors.

For an arbitrary signed grid, distinguish three conditions. Reusing the EM numerator and finite-g outer estimate requires their original real-part and absolute-height/norm bounds. The weighted batching quotient estimate separately requires |s_j-1|>3rho. Reusing the old final 2^-42 quotient allowance also requires the original actual |s-1|>2^19 lower bound. Merely continuing downward, or imposing t<=T without a lower or absolute bound, proves none of the last two conditions. This is the explicit reading of the author's restriction to targets staying within the old bounds, not a new unconditional extension.

## Work counts, storage and verdict scope

The h-streamed schedule has NKp contributions, NK(p-1) residual recurrence steps and N(K-1) main log-weight updates. It performs Kp normalized length-L transforms, KpLd/2 butterflies, JK(p-1) Horner steps and JK final scalings. Recomputing the residual powers is charged each h row; an N-by-p cache is not silently assumed.

Per center, with H=K(K+1)/2, a concrete dense correction schedule uses `(2M-1)K+MK+K+H+K+K=(3M+2)K+H` multiplications. These are rising factors, odd-term accumulation, Q, exponential convolution, B-phase multiplication and main assembly. Its additions are at most `(2M-1)(K-1)+MK+K+(H-K)+(2K-1)`, below the same displayed bound. This includes the extra B in Q. The claimed J multiplier and separate phase recurrence are therefore sound upper counts.

The stated storage is realizable with in-place transforms, two K-entry correction work arrays and stored output rows. Twiddles, log/residual intervals, full bin witnesses, rational constants and serialized receipts remain additional explicit records. Slot counts are not bytes, and the operation table is not a full bit-complexity or runtime forecast. Elementary phases, interval precision, divisions, rational growth, witness construction and storage traffic still matter. The baseline comparison concerns one fixed real-center line and the same N and K; it does not price a closed multislab cover.

This closes the paper algebraic/error reduction for sharing the finite main sum across a regular vertical block. No actual moment array, transform radius, new model, half-plane margin, winding, zero-free extension, principal/family provider, or Lean proof follows from it. The next numerical acceptance must bind all input witnesses and arithmetic errors, complete corrections and whole-panel tests to this contract. No such production evidence is claimed in the reviewed note or this verdict.
