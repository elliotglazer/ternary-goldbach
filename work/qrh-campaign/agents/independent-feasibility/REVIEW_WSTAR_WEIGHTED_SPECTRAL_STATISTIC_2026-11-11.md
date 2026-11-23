# Independent review: weighted spectral statistic for Wstar

2026-11-11. **PASS at the stated conditional paper/source scope.** No correction to the frozen author is required. The actual-function implication, new full-strip Gram estimate, and exact supported conductor weights are valid. This does not establish any actual energy, finite spectral statistic, local-count input outside its proved domain, or high-tail budget. It provides no demonstrated computation saving and no Lean, transitive-axiom, or end-to-end proof acceptance.

Author: `audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md`, SHA256 **AFDBBF90157F5170666C481D512D475A1F719366C8FB785D312A213864C38D0B**. I read the complete report and companion scalar source, checked all eighteen table pins, reconstructed the arguments below, and ran only a new independent exact-rational/pin checker. No author code was imported or executed. No analytic values, characters, transforms, primes, or zeros were evaluated; no builds or source edits occurred.

## 1. The actual Wstar implication

Use the author's dimensionless plus twist delta, star scale y=x/49, and unit-numerator sum without averaging. The character identity in `MinorArcs/BaseGap.lean:19–41` has the inverse character label and a factor phi(q) on the additive side. Finite character orthogonality therefore gives exactly

    E_q = (1/phi(q)) sum_(psi != 1) |tau_q(psi)|^2
                         |Schar(psi^-1,coprime coefficients,delta/x)/y|^2.

This is an energy of the actual q-dependent coprime coefficients. Replacing it directly by unrestricted primitive sums would miss a removal term. `BaseGap.lean:78–88` justifies the primitive-character identity on coprime support; it does not remove that support for free.

The principal estimate uses `MajorArcs/Cor933.lean:480–520` at star twist delta/49. Its required height is below the retained principal RH height 10^8 because |delta/49|<=4R/49<1.2e6. The numerical simplification in `Cor713.lean:767–806`, localized to the principal character, yields the stated 1e-17+4.7e6/sqrt(y). At y>=10^25 this is strictly below 1.5e-6. `BaseGap2.lean:371–401` supplies the two removal budgets after scaling: outer 2e-9, inner at most 2e-9 because |mu|/phi<=1. Thus p=1.504e-6 covers the entire v term. The blanket finite-RH wrapper must still be replaced by this principal-only application in formal work; the paper argument does not retain its nonprincipal assumptions.

Writing Sp=x*s, the full star residual=y*(u+v), and d beta=d delta/x gives exactly

    49^2 Wstar/x^3 = sum_q integral sum_b |s|^2 |u+v|^2.

Apply Minkowski first to u+v and then to s=aP+r. The v norm is at most p*sqrt(j); the aP contribution is sqrt(A). For the r contribution, at each q,delta,

    sum_b |r_b|^2 |u_b|^2 <= (sum_b |r_b|^2) E_q <= rho^2 E_q.

Consequently the full bound is p*sqrt(j)+sqrt(A)+rho*sqrt(B), with no missing mixed term or phi factor. It uses neither an L2-to-L4 estimate nor independence. For A<=9e-12 and B<=9, the nonprincipal part is at most 5.655e-6, and its square is strictly below 8.79*(3.67e-6-1.504e-6)^2. This proves precisely the existing full Wstar target, conditional on the plus residual and major L2 inputs. The independent pointwise base-gap target is not discharged.

## 2. New full-strip Gram estimate

I checked the actual etaU mixture in `Cor933.lean:49` and the positive mass bound in `Eta2Moments.lean:154`. For a mixture pair, C=(r^-2+s^-2)/2 lies in [1,16], and r^-2*s^-2<=C^2. For sigma in [-1,1], the moment is bounded by

    (1/2) C^(-sigma/2) Gamma((sigma+4)/2) <= 6.

The elementary Gamma estimate is sound: for v in [3/2,5/2], the defining integral below 1 is at most 1 and above 1 is at most integral_1^infinity t^2 exp(-t) dt=5/e; e>5/2 gives a strict bound 3. The two mixture masses have product below 4, yielding 24.

For k=sigma+4 in [3,5], H=exp(kz-C exp(2z)),

    H'' = (k^2-(4k+4)C exp(2z)+4C^2 exp(4z)) H.

The two positive moment identities give an absolute-integral bound 4k(k+1) integral H, at most 120 integral H. Thus the Fourier decay bound is 2880/tau^2. Together with 24 this implies min(24,2904/(1+tau^2)); at tau=0 use the first bound. The boundary terms vanish at both infinities. Compact mixture scales and these positive majorants justify the integrations and differentiations. No [1/8,7/8] restriction was inherited.

Plancherel's Mellin parameter is rho+conj(rho')-1, giving sigma=beta+beta'-1 and tau=gamma-gamma'. The actual Fourier convention produces no additional 2pi coefficient. Changing d=delta/49 contributes 49. If every translated half-open window of length 3.48 contains at most 400 occurrences in the selected carrier, eight central windows contribute 3200*24, and the paired outer windows contribute at most 800*2904/(k*3.48)^2 for k>=4. The bound sum_(k>=4) k^-2<=1/3 gives a row norm strictly below 7000000 after multiplying by 49.

Multiplicity is handled by repeated rows in the finite Gram matrix. Schur's inequality then has one multiplicity factor on its right side, while correctly retaining all diagonal and off-diagonal copies on the left. The phases y^(i gamma) are not discarded. Monotonicity in y follows solely from beta<1.

The 400-occurrence hypothesis must hold for every translated window used by the row argument, with true multiplicities and both ordinate signs. It is not implied by a count on a fixed grid or by critical-line spacing. `Explicit/ZeroSumGen.lean:59` supplies a generic finite disk estimate, whereas its subsequent critical-line window argument uses a smaller radius and cannot be reused unchanged. For the full strip, the radius-2.7 geometry is compatible with horizontal distance at most 2 and vertical half-width 1.74. The old family-cap proof has a specified conductor/height domain. Extending the selected cutoff beyond it requires a new uniform count proof, as the author explicitly states.

## 3. Supported weights and smoothing bridge

I inspected the actual `Bombieri.norm_sq_gaussSum` body at lines 135–175. It gives |tau|^2=c exactly when q/c is squarefree and coprime to c, and zero otherwise. Combining it with Parseval and the main coefficient square gives c/phi(q) for B and mu(q)^2*c/phi(q)^3 for A. Primitive inversion preserves labels; no conjugation halving is justified. Complete closed carriers must include real nontrivial zeros and true orders.

Every nonsquarefree conductor has omega_A=0 because each inducing q is then nonsquarefree. This includes all primitive conductors divisible by four. It does **not** remove those characters from B, plus, or the separate base-gap target. The high-odd formulas with only q=c,2c are conditional on precisely that eligible-modulus set, and their A formula also requires squarefree c.

The |P|<1 bridge is the existing source-derived pointwise smoothing argument, not a theorem supplied merely by `EtaPlusL2.lean`. `mellin/PointwiseSmoothingTail.md` obtains |etaPlus-etaO|<=.00221*t*exp(-t^2/2) from the weighted Fourier tail. `EtaCirc.lean:18,30` defines etaO, supported on [0,2], bounded by [t(2-t)]^3. Its integral is 32/35, so the L1/Fourier bound is 641547/700000<1. These are actual smoothing functions and require no zero hypothesis. Extracting the supporting formal lemmas remains work; this review does not reclassify that paper bridge as compiled.

## 4. What remains open

Finite vector Minkowski gives sqrt(A)<=sqrt(G*Q_A)+T_A and sqrt(B)<=sqrt(G*Q_B)+T_B. The stated four thresholds yield 3e-6 and 3, hence the desired A and B. The remainder must include all omitted nontrivial zeros, any zero at the complex number 0, the vertical integral, and primitive-to-coprime removal. A real nontrivial zero and the exceptional point 0 are different cases.

The algebraic finite-carrier/measurable-residual transfer in `ZERO_SUM_SOURCE_JOIN` is reusable; its old QRH-dependent tail estimates are not. No absolute convergence of a high-zero series or old 2e-12 remainder is established by this report. Uniform control for all x>=4.9e26 still requires either the four new spectral/remainder inequalities or direct actual-energy estimates A and B, alongside the retained plus/base-gap/principal inputs.

The finite layer-cake identity includes its baseline Y^-2*N_omega and is valid with strict beta>s because the exceptional s form a finite set. The density comparison is correctly a lower bound on one proposed sufficient upper-bound expression, not on the actual statistic. Conductor 3 forces a uniform weight cap W>=3/4; the displayed additive term then exceeds the A threshold by over 10^33. This refutes that crude comparison as a closing argument, not every weighted density method. No actual certificate size or generation-cost reduction follows yet.

## 5. Exact evidence and scope

New independent checker `review_wstar_weighted_scalars_20261111.py` SHA256 **B059A031B469ADDD5F0FBE28A975E3766DF2E1B6315E1C0D0FA44048A3FB4F5E**; receipt `review_wstar_weighted_scalars_20261111.json` SHA256 **A70342A41EFD0BE8C28F1B880AB166B2BC2EDBB550E4FFB72EDC52DD397924F8**. All 24 exact comparisons and all 18 author table pins passed. The receipt contains the complete pinned source table. These checks concern constants, polynomial identities and bytes, not analytic estimates on actual prime or zero data.

Additional directly inspected supporting files:

| File | SHA256 |
|---|---|
| agents/mellin/PointwiseSmoothingTail.md | 77E452E1D87CD8E63788D96201F926299AA65459EDEF05D2EF26DD430F63296C |
| TernaryGoldbach/MajorArcs/EtaCirc.lean | 92491AA65FAE2EFACE1797174018FFEA43C11DD827F83B0A4B0958B54BB0D3CE |
| TernaryGoldbach/MinorArcs/BaseGap.lean | ABF8667E1A8D5C72AA81F1B3F40481933A1ABC5A1CE3FAA0BE9705AC8CAF418B |

The useful result is a valid conditional reduction of the full Wstar consumer to two actual integrated energies, and then to explicit weighted finite spectral targets with separately visible tails. The mathematical task of proving those energies or targets remains open. Frozen author and prior artifacts were preserved.
