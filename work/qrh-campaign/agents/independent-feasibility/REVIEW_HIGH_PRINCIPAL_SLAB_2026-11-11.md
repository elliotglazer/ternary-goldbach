# Independent review of the million-height endpoint slab

**PASS at paper-analysis plus complete independent external interval-computation scope.** All thirteen alternate models, all fourteen consumed whole-panel claims, all twenty-six incident numerical endpoint claims, exact shared vertices and winding zero passed. No correction to the frozen scientific candidate is requested. This establishes the stated closed local slab exclusion at that evidence level; it is not a Lean theorem or a full principal-strip certificate.

## Exact target and frozen inputs

The only target is the closed rectangle

`Q=[629/1250,2]+i*[1000000-1/8,1000000]`.

The numerical function is actual zeta, represented by the source entire function zetaF divided by s-1. This is not a Hardy-Z calculation, an xi/Gamma product evaluation, or a count inherited from the old top path.

| Artifact, relative to `work/qrh-campaign/agents/` | SHA256 |
|---|---|
| `zero-sum/high_slab_em_candidate_20261111.py` | `AA4496B7EE84D4BCA497B5BDFFC237A6DC0949F45C5F9E134B29498C5B58D084` |
| `zero-sum/high_slab_em_candidate_20261111_01.json` | `CF90E96C7531F57E455ABCE70D8D71FB06596E9E1490FADDBAFA6DE64FCB0B09` |
| `moebius/PRINCIPAL_HIGH_ENDPOINT_SLAB_DESIGN_2026-11-11.md` | `5163C4208A5FC6F670FF0EDBC149A43C38FA5246F1D6CA567C75E055DD7EA2C8` |
| `mellin/HIGH_SLAB_ZETA_SOURCE_ADAPTER_2026-11-11.md` | `C9C4CD0156CA987D5200DA3F4AACCF3C8F1B64BD0FEADCC3F6F12F5F10ED9ED5` |
| `audit/REVIEW_HIGH_PRINCIPAL_SLAB_PREFLIGHT_2026-11-11.md` | `1111EF1A55452E17059F51B662EA72B48A40354A3F7F59E2A1AC6A49AB2F1BD8` |
| `independent-feasibility/review_high_principal_slab_prepared_20261111.py` | `757C1D30A2D030CF46863DDF1D43D4F1169ACD67E802CB41181BC0C6B7A1A620` |
| `independent-feasibility/HIGH_PRINCIPAL_SLAB_REPLAY_PREPARATION_2026-11-11.md` | `4B37A3587F0C863F3F44053AE9B4748301E4C466F226404F7DF45AB722C884A8` |
| `independent-feasibility/coordinator_high_slab_replay_20261111_01.json` | `F636139AB834C8CBD06A4714DB713FDE905F6BD7FF913371EED91990ECF9D567` |
| `zero-sum/HIGH_SLAB_EM_CANDIDATE_RESULT_2026-11-11.md` | `54AB6E2D97A7B42E3C4F7D51CD15301EFED508C81285156968ED0D4F502B697A` |
| `independent-feasibility/high_slab_independent_replay_20261111_01.json` | `407D74A56EEEA8DE3483B3D8E31ED4FFA4A5895ACB262A8632F7EF74BD003C2E` |
| `independent-feasibility/audit_high_slab_saved_20261111.py` | `8442A4FE48631B7E933049FC429BEA6A3F01BA660F1FE6BE1B6D9C00F470549E` |
| `independent-feasibility/audit_high_slab_saved_20261111.json` | `E645087D3F1007E0AE050F89E746E83835D6E4ADFF441792F15A764834D15569` |

The producer's seven new models use N=333334, M=32, Taylor length 24 and outer radius 1 at 192-bit arithmetic. Six accepted top coefficient models are imported from the unchanged old receipt `9F8D349077CEA0598C50C61377C80A0098FFBB0EF723A0A68D85A18FC73AEC26`. Their entire source rectangles are enclosed on re-import and their EM/Taylor errors are bounded by the uniform replacements. The first top and bottom intervals are clipped at the exact new left boundary .5032; this is not the old stored endpoint .5.

## Mathematical evaluation contract

The finite entire expression is the sum through N, the half term B^-s/2, the Bernoulli corrections `(B_(2k)/(2k)!)*(s)_(2k-1)*B^(1-s-2k)`, multiplied by s-1, followed by B^(1-s), where B=N+1. Retained coefficient indices are 0 through K-1 and represent normalized derivatives g^(j)/j!. The omitted EM rising factorial has length 2M, distinct from the last correction length 2M-1. No extra factorial or pole-removal factor is inserted downstream.

The producer's finite-g bound and actual-function remainder are separate: the outer Taylor disk can extend into negative real parts because finite g is entire. Actual EM is applied only at tested slab points, whose real parts exceed 1/2. This matters for the left model, whose target disk itself crosses 1/2. Each complete panel polynomial image receives both errors before division by the full s-1 rectangle. The positive imaginary lower bound excludes a zero denominator. Coefficient interval uncertainty, independent boxing of coordinates, Horner arithmetic and quotient arithmetic may widen the image but do not narrow its set of possible values.

The independent path deliberately recomputes all 13 models. Its old top receipt retained images and endpoints but no coefficient jets; it is therefore not used to evaluate the clipped top panels. Independent parameters are N=300001, M=36, K=26, outer radius 3/4 and 160 bits. The main coefficients start with scalar exp(-s0 log n), then obey a_j=a_(j-1)*(-log n)/j. This avoids the producer's series-exponential construction. The final pole-cancelled exponential is B times the B^-s series.

For these alternate parameters, each model receives its own finite-g outer bound and Cauchy tail, rather than borrowing the producer's 2^48 bound. The EM estimate uses actual-point floor 1/2 and |s|<=|s0|+h with rising-factorial length 72. The prepared code and plan spell out the whole formulas. Their domains were checked on source inspection: no actual-zeta remainder is used on the outer disk. No builtin zeta, Hurwitz, Gamma, Riemann-Siegel, indexed-zero or count oracle is called. FLINT elementary interval exp/log, arithmetic and finite polynomial operations remain external computational dependencies.

## Complete boundary, half-planes and winding

The frozen candidate contains fourteen accepted panels and fourteen attempts, with no subdivision: six bottom panels to the right, the analytic right edge upward, six top panels to the left, and the left edge downward. They form one exact CCW traversal with all corners and joins included. The right-edge proof is Re(zeta(2+it))>1/4, from absolute convergence and the strict tail bound zeta(2)-1<3/4; no numerical right model is required.

The candidate rotations in order are

`[-i,1,1,1,1,1,1,1,1,1,1,1,-i,-i]`.

Their convention is Re(u*z)>0. Thus -i certifies positive imaginary part, while 1 certifies positive real part. It would be incorrect to describe every panel as positive-real. Independent acceptance requires the same signed coordinate to be positive for the whole independently computed panel image, not merely a point sample or overlap with the producer image. Every numerical incident endpoint is also evaluated.

The exact shared surrogate polygon uses vertices among 2i,1+i,2. These vertices need not approximate actual endpoint values. Each lies in both incident open half-planes, as does the actual shared endpoint. Convexity permits the compatible local-log connectors. The two nonzero half-open positive-ray crossings are -1 and +1, with sum zero. Repeated image vertices and horizontal/zero-length image edges are allowed; every polygon edge is checked not to pass through zero. Domain segments themselves have positive lengths and no repeated traversal. Exact geometry, half-plane memberships and zero winding are separate checks.

The consumed numerical claims are whole-panel half-plane memberships. A separately computed image establishing the same strict half-plane is sufficient; it need not be contained in the producer's sharper image or prove equality of different finite-g coefficient lists. This review does not turn unused producer metadata or every advertised sharp margin into an independently proved claim.

## Actual source and closed zero exclusion

I inspected the actual target definitions and signatures. `Explicit/ZetaGrowth.lean:17` defines zetaF by updating (s-1)riemannZeta(s) to 1 at s=1; `zetaF_of_ne` and `differentiable_zetaF` provide the exact product away from 1 and global differentiability. This slab is far from 1, so actual zeta is holomorphic on a neighborhood of its closure.

`Explicit/RectResidue.lean:391`, `rectInt_logDeriv_mul`, requires a globally differentiable counted function. It cannot be directly instantiated with zeta. The reviewed local polygon/log proof first gives the logarithmic integral of zeta on this boundary. The identity

`zetaF'/zetaF=zeta'/zeta+1/(s-1)`

holds there. Principal Log(s-1) is holomorphic throughout this upper-half-plane neighborhood, so its derivative integrates to zero around the closed boundary. Therefore zetaF has the same zero winding. The source argument principle applies to entire zetaF with h=1, center c=2+i*(T-1/16), and R=4. The analytic right-edge bound makes zetaF(c) nonzero, and the rectangle lies strictly in the radius-two ball because its L1 distance from c is at most 15593/10000<2. Zero winding and nonnegative actual analytic multiplicities exclude interior zeros; the half-plane tests exclude boundary zeros. Division by nonzero s-1 transfers the full closed result to zeta.

This source adapter is a reviewed paper derivation, not a claim that its local-log or product-integral glue has been implemented in Lean. `WeilBridge.multRectD_eq_mult` has strict ordinate premises. Any later finite-carrier use must choose an outer height strictly above T; closed slab exclusion alone does not relax those premises.

## Completed numerical verdict and scope

The coordinator ran the frozen independent script once. It exited successfully with `PASS_ALL_13_MODELS_ALL_CONSUMED_PANELS_WINDING_ZERO`, all thirteen fresh models and fourteen panel checks. The receipt stores 338 normalized coefficient boxes, fourteen unique endpoint coordinates and twenty-six incident numerical endpoint enclosures. The analytic right edge is the remaining panel. All consumed top panels were freshly evaluated, not merely sampled or inferred from the old total count.

I read the completed receipt, recomputed its hash, and ran the separate saved-data audit in the table. That audit imports no evaluator and computes no new function values. It checks all model centers, alternate parameters and ordered coefficient/error boxes, every panel's exact consumed domain and original disk, all independent half-plane margins and incident endpoint memberships, full side lengths, shared vertices, every crossing and winding zero. These checks passed. They supplement rather than replace the independently constructed analytic enclosures.

The minimum independently certified signed-coordinate lower margin across the fourteen panels is exactly

`27705752783371153338760490306785725667581690417 / 182687704666362864775460604089535377456991567872 > 3/20`.

The crossing list is `[0,-1,0,0,0,0,0,0,0,0,0,1,0,0]`. Thus the reviewed local-to-entire argument gives **no zeros of actual zeta anywhere in Q, including all sides, corners, and both heights**. This does not assert that every panel is positive-real; three use positive imaginary part. Nor is the displayed margin asserted to be the minimum actual modulus throughout the interior.

The independent receipt records about 132.30 seconds and peak working set 69324800 bytes under its 300-second/512-MiB caps. These are observations from one complete run, not a controlled comparison, formal cost bound or production extrapolation. The result receipt occupies 221485 bytes. No duplicate model run was launched during this final review.

Acceptance excludes zeros only on this final 1/8-high slab and, with separate conjugation and functional-reflection arguments, its local reflected counterparts. It does not establish the rest of the principal strip through one million, the conductor-one family height 60343058, any nonprincipal family certificate, provider validation, or PlattGRH removal. The old author result's pending-review sentence records its earlier freeze and is superseded by this separate review without changing those bytes. This is external interval evidence plus paper analysis, not a verified rational checker, Lean theorem or controlled production-runtime comparison.

The producer's `output_bytes` field is an LF-payload count, not physical Windows file length. The immutable candidate occupies 204498 bytes while that field reports 200234. This documented telemetry qualification does not affect the scientific fields or frozen hash.
