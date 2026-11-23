# Independent high-principal-slab preflight review

2026-11-11. **PASS for the mathematical design, new source adapter and static scientific implementation, with one nonblocking output-size bookkeeping correction noted below.** This is permission-neutral preflight evidence for a separately authorized bounded attempt. No producer was imported or executed, no analytic values were evaluated, and no numerical success, Lean proof or broader spectral coverage is asserted.

## Pinned inputs

All paths below are relative to `work/qrh-campaign/agents/`. The following hashes were independently read from disk.

| Input | SHA256 |
| --- | --- |
| `zero-sum/high_slab_em_candidate_20261111.py` | `AA4496B7EE84D4BCA497B5BDFFC237A6DC0949F45C5F9E134B29498C5B58D084` |
| `zero-sum/HIGH_SLAB_EM_PRODUCER_PREPARATION_2026-11-11.md` | `DB32269D56AB94F38E3361A7B2BBA6C0CD0BD2425810BBF9CC80E1DE137EA8EA` |
| `moebius/PRINCIPAL_HIGH_ENDPOINT_SLAB_DESIGN_2026-11-11.md` | `5163C4208A5FC6F670FF0EDBC149A43C38FA5246F1D6CA567C75E055DD7EA2C8` |
| `mellin/HIGH_SLAB_ZETA_SOURCE_ADAPTER_2026-11-11.md` | `C9C4CD0156CA987D5200DA3F4AACCF3C8F1B64BD0FEADCC3F6F12F5F10ED9ED5` |
| `major-constants/HIGH_PRINCIPAL_SLAB_SCALAR_SUPPORT_2026-11-11.md` | `5176DAF690017CF8889BF14F22A882CF93B713B76D126983AAB7359BA8ECB060` |
| `major-constants/check_high_slab_scalars_20261111.py` | `E4D3AC6451D16F8DBFC460112F63AA667DF4A85672D3A41D42458F6321E0E499` |
| Scalar receipt | `3E23393B1DBD5EEFB186F8D0D6C624E71F12E3433B184A10EEBB218FA6E11E17` |
| Old `zero-sum/em_top_horizontal_20261111.py` | `F0F7B331D8C3515C88845DB08A735AF9A071CC9A3D3025A46919C400FEE03D10` |
| Old top receipt | `9F8D349077CEA0598C50C61377C80A0098FFBB0EF723A0A68D85A18FC73AEC26` |
| Independent full-six-block top review | `6E2E1C0F3283F62CF68FCCC8E90AB67F5626288353E7B9A6921BCE695425CA4E` |
| `major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md` | `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B` |

## Scientific implementation

The fixed target is exactly `[629/1250,2]+i[1000000-1/8,1000000]`. The source binds six old top models and precisely seven new models: six bottom models, plus the left model centered at `.5032+i(T-1/16)`. There is no model on the right side. The numerical library is imported only inside the authorization-gated execution function. The old eager producer is never imported. No zeta, Hurwitz, Gamma, Riemann–Siegel or zero oracle appears in the new implementation.

The finite entire expression agrees term by term with the reviewed old producer and scalar note: sum through N=333334; B=N+1; half term B^(-s)/2; 32 Bernoulli corrections with rising-factorial lengths 1,3,...,63; final multiplication by s-1 and addition of B^(1-s). Length 24 means ordinary Taylor coefficients g^(j)/j! for j=0,...,23. No second factorial is inserted. Exact rational Bernoulli recurrence and interval series operations retain the coefficient uncertainties.

The old JSON's source hash, status, model parameters, six centers, block intervals and coefficient lengths are checked. `ri` at line177 constructs an interval and then checks its exact exported endpoints enclose BOTH original rational endpoints. This prevents midpoint-only reuse, including rounded-midpoint uncertainty. The four bounds of every consumed complex coefficient box are preserved. Old error upper endpoints are compared with the larger uniform replacements; they are not treated as exact centers. Old endpoint/image boxes are unused, so they need not be re-imported.

The error decomposition is correct. The finite-g outer disk may cross Re(s)=1/2, whereas the actual EM remainder is used only on actual slab panels. The entire-g Cauchy tail is 2^(-21)/7 on top/bottom and 2^(-44)/15 on the left. The separate EM allowance is 2^(-38). Both are inserted before division by the whole s-1 box. The checked positive imaginary lower bound excludes a denominator zero. Independently boxing s and its offset loses correlation but only enlarges the enclosure. Coefficient and arithmetic errors remain in the intervals; the scalar bound 2^(-42) is not misused as a bound for their total radius.

The scalar derivation is consistent: outer real part >=-1/2, norm <=T+3, rising factors <T+66, square-root bounds <578, correction geometric sum <4/5; actual EM factors have length64 and denominator sigma+63 >=127/2. I checked these reductions and the displayed rational Taylor identities; I did not rerun the scalar script or Bernoulli table in this review.

## Whole panels, geometry and exact winding

The initial 14 segments form the intended CCW rectangle: six bottom, right upwards, six top in reverse order, left downwards. The first top and bottom blocks are clipped at 629/1250. Every numerical panel is tested against its fixed model disk and the actual slab. Disk convexity extends the endpoint disk checks to the entire affine segment. Horner evaluation uses the whole varying coordinate interval, not just endpoints.

The four signs are correctly interpreted as complex multipliers in Re(u*z)>0: u=i uses -Im(z), u=-i uses Im(z). The right side has the independent bound Re(zeta(2+it))>1/4: the absolute Dirichlet series gives a tail smaller than 1/4+integral_2^infinity x^(-2)dx=3/4.

After all panels pass, exact joins, side directions, side lengths and the initial corner are checked. Subdivision preserves the parent traversal and never introduces another long model. For consecutive multipliers u,v the shared surrogate is conjugate(u)+conjugate(v), and both strict inequalities are checked. These vertices need not equal actual function values. The true endpoint and the surrogate lie in the same two convex half-planes, which permits compatible connector cancellation. Opposite rotations are rejected. Entire-panel containment, not endpoint overlap, supplies the analytic input.

The half-open positive-ray crossing rule has the correct signs, including ray vertices and constant image edges. Each polygon edge lies in its certified open half-plane, so it avoids zero. Only exact winding zero produces the zero-exclusion PASS; a nonzero winding has its own non-success status.

## New local-to-entire source adapter

I independently checked this adapter rather than importing it from the earlier globally entire polygon application.

Actual source [ZetaGrowth.lean:17](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/ZetaGrowth.lean:17), SHA `ED2158522FECDF70720AF464B28DE6E101666A3ED6AB7568729A5A8EA591E9E4`, defines zetaF with its removable value at1; lines19 and30 provide the product away from1 and global differentiability. Actual [RectResidue.lean:391](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/RectResidue.lean:391), SHA `6B9C3236C2B4470AA37D3948DAB163573A1A7AFDDE8E963EF127F815EB0B88CF`, requires globally differentiable f, a nonzero center, strict half-radius rectangle containment and closed-side nonvanishing. It cannot be applied directly to zeta.

The repaired paper argument is valid. Zeta is holomorphic near this boundary. The local logarithm/FTC and shared-connector proof gives its logarithmic integral from the polygon. On the boundary, zetaF'/zetaF=zeta'/zeta+1/(s-1). Principal Log(s-1) is holomorphic in the upper half-plane, so the second integral telescopes to zero around the rectangle. Apply the actual entire-function theorem to zetaF, h=1, c=2+i(T-1/16), R=4. The right-edge bound proves the center nonzero, and norm(s-c)<=1871/1250+1/16=15593/10000<2 verifies strict containment. Nonnegative actual analytic orders give interior exclusion from winding zero; panel nonvanishing adds the closed boundary. No RH or simplicity is used.

The local polygon extension, product-integral identity and divisor/actual-zero transfer are still formalization obligations. This review accepts their stated paper reduction, not existing Lean implementations. Closed ordinate T must not be silently inserted into a strict finite zero carrier: choose an outer height >T when using the strict bounds of WeilBridge.multRectD_eq_mult.

## Operational and evidence limits

The 180-second and 512-MiB checks are cooperative. They do not preempt an in-flight call or checkpoint. The memory statistic is peak working set, not every possible measure of committed memory. The 256-visit cap includes failed tests and the analytic right side; depth12 starts at zero. Detected caps and failed geometry/vertex checks retain incomplete states. Checkpoints are replaced atomically, but an external kill can lose the work since the preceding save. Replay regenerates numerical data and compares scientific fields; it is not an independent implementation, and an incomplete stopping location is not reproducible across machines.

Nonblocking issue in reviewed code line168: output_bytes measures the LF UTF-8 payload before Path.write_text, whose default Windows newline translation can emit more bytes. This affects size telemetry, not interval comparisons or replay acceptance. The author was asked to use explicit LF writing or rename the field. Any repaired hash must be separately recorded rather than silently substituting for the pin above.

The coordinator subsequently chose to preserve the frozen producer and interpret this field only as LF-serialized UTF-8 payload length, recording physical file size independently with a filesystem stat. That qualification resolves the reporting issue for the bounded attempt without changing any scientific field or input pin.

A successful future run would exclude zeros only in this final positive-height 1/8 slab and, with the stated conjugation/reflection adapters, its local reflected counterparts. It would not certify the remaining high strip, the c1 family height 60343058, or PlattGRH removal. Excluding the boundary beta=.5032 is a stronger sufficient local condition than the selected weak strip, so a boundary zero could obstruct this experiment without refuting that target. There is no new final theorem premise and no Lean or axiom-closure claim.
