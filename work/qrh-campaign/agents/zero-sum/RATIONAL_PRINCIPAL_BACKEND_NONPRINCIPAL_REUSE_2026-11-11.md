# Reusing the rational principal panel backend for the nonprincipal family

2026-11-11. Research-only interface audit; no numerical run, scan, build, declaration, or new spectral claim. The principal pilot supplies a concrete exact-rational implementation pattern. It does not supply nonprincipal nodes or finite family coverage. The main missing producer is the generalized-characteristic signed-bucket evaluator, followed by certified character/Gauss transforms and a separately allocated nonprincipal panel ledger.

## 1. Evidence and scope

Paths are relative to `work/qrh-campaign/agents/`.

| Packet | SHA256 |
| --- | --- |
| `integration/RATIONAL_XI_PANEL_BACKEND_2026-11-11.md` | `7072D0D5EAECE93066F013799FC1B872B5E3A9CA4B5E589D299D458B7D115A32` |
| `integration/RATIONAL_XI_PANEL_CANDIDATE_RESULT_2026-11-11.md` | `B4D9BAECA29EC60B3B40ED7E17B3561A7EC6102C76CFBBD971D895DCAD44E35E` |
| `zero-sum/NONPRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md` | `C5DC28202A45083FD5AA928D7892205870CF5BDB5E6715FDF134D319F39A558A` |
| Its independent review | `788059421393EBE8B2390CC2498502228906D94E644A036C4E28930262BDFD94` |
| `major-constants/JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md` | `3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D` |
| Its independent review | `2F5645939D0F3EB3B90860B07BE4A343082F2E8EAE7578888998DB7661117F56` |

The read principal result records `POSITIVE_REAL_DISK`, 929 nonnegative P nodes and seven coefficients for one disk about 3/5+14i. Its frozen result note still labels independent numerical verification pending; this audit neither replaces that review nor depends on a broader acceptance status. The relevant new capability is its explicit rational arithmetic path and complete conditional error assembly. Even an accepted external replay is not formal checker soundness.

The nonprincipal bucket plan is pinned at `2EADB0ACEE2B3C8275D9C8CFA815E4E3E7CC39C3CB0EBA0A86763A4877F74F09`, review `FB6A7BD014A4417CD4D3AD2460C0785EDE3838226AA6F9013248863FB3135E70`. Its four-case c5/c8 pilot and independent review remain coefficient evidence at four fixed inputs, not a rational family producer.

## 2. Reusable components and their limits

| Component | Reusable interface | What does not transfer unchanged |
| --- | --- | --- |
| Integer/Fraction interval arithmetic | Outward real/complex operations; full-box reciprocal; integer-square-root bounds; Machin pi; certified exp/cis; exact dyadic centers and rational comparisons | Every parameter range, finite Taylor length, underflow threshold and allowed precision must be reallocated. Successful 320-bit arithmetic at the principal nodes is no uniform success theorem. |
| Modular-word engine structure | Exact T subtraction, certified upper-half-plane guards, per-step principal root, serialized operands and fail-closed replay | The principal three-type permutation is insufficient for arbitrary residue characteristics. Its four-S cap and sixteen-pair tail are specific to its seeds and P jets. |
| Finite coefficient arithmetic | Signed powers divided by j!, exact center products/sums, radius checks, zero-index handling | Nonprincipal weights/nodes have different phases, conductor scales and negative-frequency formula. |
| Taylor/panel acceptance | Bound a polynomial on an actual disk or segment, add a proved error radius, require a strict half-plane; exact shared vertices and polygon winding | The principal positive-real margin is not data for any nonprincipal character. Rotated half-planes or genuine winding may be necessary. |
| Receipt controls | Pin definitions, labels, target, arithmetic parameters and source inputs; reject omissions/duplicates and changed fields | The current principal receipt is not a complete standalone proof trace; some elementary events are reconstructed. A formal replayer must prove its recomputation sound or consume a complete checked trace. |

The inherited elementary operations are useful before FFT implementation: direct character sums and direct Fourier sums can establish the first rational nonprincipal packet. This is an implementation staging option, not a production-cost recommendation.

## 3. The genuinely new coefficient producer

For c>1 and a in {0,1}, the required full signed bucket is

`B_R,a(z)=sum_(n in Z, n=R mod c) n^a exp(-pi*n^2*z/c)`.

The accepted source adapter is `B_R,a(z)=c^a H_a[R/c,0](i*c*z)`. Its two real rational characteristics remain exact through T, S and characteristic translations. They generally leave the three classical theta types. The S law has the factor

`(-i*tau)^(-1/2) * exp(2*pi*i*alpha*beta) * (-1/tau)^a`.

Thus odd buckets need the exact negative reciprocal, and each residue needs its own characteristic phase. One word and its root factors may be shared across residues; residue-dependent phases may not be dropped. This is not the principal ordinary-tau-derivative jet transport, nor its final differentiated P reconstruction.

A rational bucket producer must return a complex rational center and a norm radius for the **full** bucket, covering the seed, all transformations, principal-root branches, reduced characteristic series, propagated tail and arithmetic. The accepted general bucket tail applies after reduced real characteristics lie in [-1/2,1/2] and terminal height exceeds 2/5; allocate it through `c^a` and the actual modular multiplier. No principal sixteen-mode or four-step bound is available merely because both algorithms stop near the same height.

Next use the manifest's exact CRT/unit-group indexing and positive exponent transform. For an actual primitive character of matching parity,

`C_chi = sum_(R unit) chi(R) B_R,a = 2 theta_chi`.

The factor one-half is valid only **after** character contraction. Individual signed residue buckets cannot be halved into positive buckets. A normalized character transform must have both output and error multiplied by phi(c). For bucket radii e_R and transform error e_char against the exact unnormalized transform of centers,

`E_C <= sum_R e_R + e_char`.

The manifest supplies the paper coverage/indexing argument, including noncyclic 2-power factors, conductor filtering, parity and inverse labels. A rational executable/checker must instantiate it; count agreement alone does not identify actual source characters. Actual root numbers require a separate certified positive Gauss transform and division by `i^a sqrt(c)`. The source primitive Gauss theorem proves their norm one. A rounded norm test cannot replace it. No square-root root phase epsilon or Hardy realness is needed for complex contour values.

## 4. Exact node-to-panel interface

Keep one entire function per contour packet:

`Z_b(s)=exp(-i*b*s)*Lambda_chi(s)`,

`Lambda_chi(s)=c^((s+a)/2)*completedLFunction_chi(s)`.

This uses the source continued completion. Put lambda=sigma+a, mu=1+a-sigma and `A_sigma=exp(-i*b*sigma)c^(lambda/2)`. At v>=0 the accepted G nodes are

`G(v)=c^(-lambda/2) exp(lambda*(v+i*b)) C_chi(v)`,

`G(-v)=W_chi c^(-lambda/2) exp(mu*(v-i*b)) conj(C_chi(v))` for v>0.

The second formula includes the inverse-character/conjugate-argument identity. It is not plain conjugation of G(v), and the reciprocal coefficient's -b does not switch the analytic target to Z_(-b). Mu can be negative. Count the zero Fourier node once using the positive formula, even though chi(0)=0 concerns a different integer theta index.

For `f_j=Z_b^(j)(s0)/j!`, the analytic cancellations give

`f_j=A_sigma integral (x^j/j!)*G(x)*exp(i*t0*x) dx`.

No extra ib or log(c) polynomial belongs in the derivative nodes. Choose new rational `q_*<=cos(2(|b|+delta))`, `q_b<=cos(2b)`, `M_*=2c^2/q_*^2`, `M_b=2c^2/q_b^2`. The accepted nonprincipal ledger is

`Q_j=2 M_* exp((T+1)delta)/(exp(2*pi*delta/h)-1)`,

`S_j=M_b exp(-(q_b/c)exp(2Kh))`, requiring `(q_b/c)exp(2Kh)>=1`.

These are not the principal Q/S constants or its derivative cutoff 2. Given G-node radii e_k, normalized weight radii d_jk and exact-sum error eta_j, the I-coefficient error is

`E_Ij=Q_j+S_j+h sum |x_k|^j/j! e_k+sum d_jk |g_hat_k|+eta_j`.

Then propagate the final A factor:

`E_j=c^(lambda/2) E_Ij + rho_A |I_hat_j| + rho_out,j`.

Alternatively direct Z nodes cancel the outside conductor power, but all quadrature and node errors must then be scaled consistently. The entire Taylor tail is `D_sigma*rho^(d+1)/(1-rho)` with `D_sigma=c^(lambda/2)M_b<=2c^4/q_b^2`; the bound holds for all center derivatives, so the disk argument does not assume an unjustified enlarged-slab Cauchy estimate.

The joint batching plan shares full buckets across characters and sigma values. Character and time transforms have separate error contracts. For the symmetric time grid, normalized positive inverse DFT output is scaled by hL; unnormalized positive output by h. The finite arithmetic error must include that final scaling. Folded arrays cannot be reused off-grid without a proved unfolding/interpolation identity. Retain both symmetric endpoints or account explicitly for the missing one.

## 5. What remains after a rational nonprincipal panel succeeds

1. **Formal identities and arithmetic soundness:** source theta characteristics, primitive reciprocity, continued completion, derivative quadrature/tails, finite transform and rational checker correctness remain proof tasks. Python success is not an allowed root premise.
2. **Actual data:** the selected family has 5,543,640,187 nonprincipal primitive labels. Neither a principal disk nor the four bucket inputs supply their required nodes, Gauss data, coefficients or contour tests. The separate conductor-one obligation remains separate.
3. **Finite geometric coverage:** bind each character to its selected Hcert(c), both signed ordinates, real-axis coverage and inclusive endpoints. All sides of every chosen closed slab need accepted panels and exact assembly. Different fixed tilts can support separate complete slab certificates; their raw image polygons cannot be canceled without conversion to a common function.
4. **Actual nonvanishing/count truth:** evaluators can refine absolute errors, but no upper bound proves a nonzero margin. A target allowing beta=.555 does not guarantee that its boundary is nonzero. Direct strip exclusion or multiplicity-aware allowed-region counts must handle this honestly. Critical-line sign saturation is a stronger optional certificate, not a termination theorem under the selected weak strip.
5. **Scale and evidence size:** shared buckets remove repeated coefficient work, not all per-character outputs or coverage obligations. Reduced series for phi(c) residues may cost more than one direct Gaussian pass at some conductors. The 77.7 MB principal receipt is one representation at one disk, not a production-memory or speed law.

The consequential next implementation step is therefore a small **exact-rational nonprincipal bucket-to-character-to-complex-panel packet**, preserving the reviewed c5/c8 labels and explicit Gauss normalization, with independently checked new nonprincipal error allocation. It should first establish the missing rational interfaces rather than inherit principal tolerances or assume FFT sharing proves coverage. This note does not authorize or execute that experiment.
