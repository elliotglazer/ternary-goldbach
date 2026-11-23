# Independent review of nonprincipal backend reuse

**PASS as a research/interface audit when read together with the domain companion.** No nonprincipal computation, pilot implementation, Lean build, anchor, new theorem or spectral claim was produced. The original audit alone omits explicit hypotheses needed to interpret its section-4 bounds; acceptance includes the companion below.

Reviewed files, under `work/qrh-campaign/agents/`:

| File | SHA256 |
|---|---|
| `zero-sum/RATIONAL_PRINCIPAL_BACKEND_NONPRINCIPAL_REUSE_2026-11-11.md` | `04BC725844FF3AB7B596BFAF65450F07376A06D557B056540C40CEE21A67D097` |
| `zero-sum/RATIONAL_PRINCIPAL_BACKEND_NONPRINCIPAL_REUSE_DOMAINS_2026-11-11.md` | `3BA3C7C01445D362A69DFBEDC6058D889F335F0510ECAA30D3EBBC75AE975B65` |
| Accepted node composition | `C5DC28202A45083FD5AA928D7892205870CF5BDB5E6715FDF134D319F39A558A` |
| Its independent review | `788059421393EBE8B2390CC2498502228906D94E644A036C4E28930262BDFD94` |
| Accepted joint batching plan | `3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D` |
| Its independent review | `2F5645939D0F3EB3B90860B07BE4A343082F2E8EAE7578888998DB7661117F56` |
| Accepted characteristic-bucket plan | `2EADB0ACEE2B3C8275D9C8CFA815E4E3E7CC39C3CB0EBA0A86763A4877F74F09` |
| Its independent review | `FB6A7BD014A4417CD4D3AD2460C0785EDE3838226AA6F9013248863FB3135E70` |

All listed hashes were checked. The reuse audit, domain companion, node-composition text and review, characteristic construction, and batching formulas/review were read against one another. This is an audit against accepted source interfaces, not a fresh formal proof of their analytic ingredients or a recount of the primitive-family manifest.

## Required clarification

The original shorthand “new rational q_*<=cos(...), q_b<=cos(...)” does not itself exclude negative q, and the conductor bound is not valid at arbitrary sigma. I requested explicit hypotheses. The separately frozen companion now states primitive nonprincipal c>1 and matching parity, 111/200<=sigma<=2, |t0|<=T with T>=1, delta>0, |b|+delta<pi/4, positive q_* and q_b bounded by the indicated cosines, h>0, natural K,d, 0<=rho<1, the spatial cutoff, and nonnegative actual-error radii. This resolves the omission without changing any formula or the original bytes.

## Independent formula checks

Writing n=R+ck gives B_(R,a)=c^a H_a[R/c,0](ic z). The odd characteristic inversion multiplier is -1/tau: differentiating the even characteristic identity cancels the phase/value contributions and leaves that reciprocal times H_1. It is not an ordinary tau derivative of classical theta3. Consequently the principal three-type state machine and P jet reconstruction do not implement this new producer. Shared words and root factors do not eliminate residue-dependent characteristics and phases.

Matching parity pairs n and -n, so contraction over unit residues gives C_chi=2 theta_chi. The zero term vanishes because c>1. Halving individual buckets would be incorrect. Since |chi(R)|=1 on units, the unnormalized transform input-error bound is sum_R e_R; normalized outputs and their errors both require multiplication by phi(c). Root-number normalization remains the actual positive Gauss sum divided by i^a sqrt(c), with unit norm from primitivity.

The positive and negative G formulas match the accepted source. Multiplication by A_sigma gives, respectively,

`exp(i*a*b)*exp(lambda*v)*C_chi(v)` and

`W_chi*exp(-i*(a+1)*b)*exp(mu*v)*conj(C_chi(v))`.

This directly checks both conductor cancellations and phases. Differentiation in sigma produces v on the positive branch and -v on the negative branch; it therefore gives the signed x^j/j! moment, with no residual ib or log(c) polynomial. Neither G(-v)=conj(G(v)) nor a change of analytic tilt is valid. Mu may be negative.

For q>0 put d=q/c. The common kernel envelope and |x|^j/j!<=exp(|x|) give the two-sided moment bound

`(4c/q)*integral_0^infinity exp(2u-d*exp(2u)) du = (2c^2/q^2)*exp(-d) <= 2c^2/q^2`.

On displaced lines the additional moment factor costs exp(delta), yielding the stated Q_j. The spatial majorant has logarithmic derivative 2-2d*exp(2u), hence cutoff d*exp(2Kh)>=1 and the stated S_j. These are new nonprincipal constants, not the principal P derivative cutoff or budget. The two product-error decompositions and final A multiplication give exactly E_Ij and E_j; no mixed term is missing. Since lambda<=3 and c>1, c^(lambda/2)M_b<=2c^4/q_b^2. Bounding every true center coefficient this way justifies the entire Taylor tail without assuming a value bound on an enlarged real slab.

The symmetric finite synthesis scales an unnormalized positive DFT by h, or the normalized positive inverse DFT by hL. Output error must include that scaling. Signed endpoints, zero once, exact factorials, inverse labels, and the W diagonal prevent an unsupported single-channel or off-grid reuse. The audit preserves these distinctions.

## Reuse and evidence limits

Exact interval operations, elementary enclosure methods, finite integer sums and strict polynomial tests can be reused as implementation components. Their generic formal soundness is still unproved. Successful principal precision, four-inversion cap, sixteen-mode tail, radius allocations and positive margin do not transfer. The new bucket, Gauss/character transform, conductor/phase conversion and nonprincipal error allocation remain to be implemented and checked on actual inputs.

The original principal result note's pending wording is historical; the later full principal review has passed. This does not strengthen any nonprincipal claim in the reuse audit. The four bucket cases remain coefficient evidence only. Sharing work is not evidence of a production speedup, common adaptive time mesh, nonzero boundary margin, or complete family coverage. The proposed next pilot is a reasonable bounded interface test, not authorization to run it and not a proof that production computation is practical.

No additional correction is requested. Acceptance is bound to both the original audit and its domain companion; neither supplies new permitted premises at the final theorem.
