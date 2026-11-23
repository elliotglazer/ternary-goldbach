# Principal-character blueprint: local L2 error for the actual etaPlus smoothing

This chapter specifies a research route, not approved or frozen Lean declarations. Proposed statements below are mathematical obligations. Names such as P1–P8 are blueprint labels only. Existing symbols are identified precisely so that a later statement audit can compare any submitted Lean declaration with this chapter.

The pinned analytic source is `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The QRH source is `work/openai-math`, pinned by the campaign at `4eaee87548250b2682affda7d05d947c05554bae`. No new Lean implementation or compilation was performed for this chapter.

## Objective and scope

For every real x≥4.9e26, prove the integrated principal approximation

    integral_(delta in Icc(-4,4))
      || SsumG (1 : DirichletCharacter ℂ 1) (fP delta) x / (x : ℂ)
          - mellin (fP delta) 1 ||² ddelta ≤8e-6.                 (P8)

The integral is with respect to real Lebesgue measure. Division by x and the Mellin term are complex-valued; the squared norm and final integral are real. The smoothing is the repository's actual `TernaryGoldbach.Helfgott.etaPlus`, with bandlimit 200. Replacing it by etaO is only an intermediate comparison with an explicitly bounded Gaussian remainder.

P8 is sufficient for the independent LOWER major-energy input, after the unconditional character-orthogonality and coprime-removal steps in `agents/prime-estimates/L2_REPLACEMENT.md`. It is not the broad-twist principal estimate, the nonprincipal energy upper bound, or the cubic major-arc error bound. Completing P8 alone does not prove `TernaryGoldbachFrom (10^27)`.

The necessary global zero strip is 1/8≤Re rho≤7/8 at EVERY height. The source candidate is `OAI.riemannZeta_ne_zero_of_seven_eighths_lt_re`, `OAI/NumberTheory/DirichletL/Nonvanishing.lean:29`. Its statement excludes zeta zeros with 7/8<Re s. Combine it with the zeta/xi functional equation to obtain the lower endpoint. The character version is `OAI.DirichletCharacter.LFunction_ne_zero_of_seven_eighths_lt_re` at line 19, but it is not needed in this principal-only chapter. The provider's import and transitive-axiom audit must be completed separately; a source declaration is not itself a validation report. Local .996 or 23/24 strips do not satisfy this interface.

## Existing carriers and identities

| Mathematical object | Exact existing Lean object / source |
|---|---|
| etaPlus(r)=hH200(r) r exp(-r²/2) | `TernaryGoldbach.Helfgott.etaPlus`, Helfgott/Defs.lean:42 |
| etaPlus(r) exp(2pi i delta r) | `TernaryGoldbach.Explicit.fP (delta r : ℝ) : ℂ`, Explicit/EtaPlusMellin.lean:59 |
| Mellin transform | root `mellin (f : ℝ → ℂ) (s : ℂ)`, Mathlib/Analysis/MellinTransform.lean:91; integral on `Set.Ioi 0` of `(t : ℂ)^(s-1) • f t` |
| von Mangoldt twisted sum | `TernaryGoldbach.Explicit.SsumG`, Explicit/ExplicitFormula.lean:100; `∑' n : ℕ, (Λ n : ℂ) * χ n * φ (n/x)` |
| explicit-formula zero set | `TernaryGoldbach.Explicit.zerosRectD zetaF T : Finset ℂ`, Explicit/Datum.lean:81 |
| rectangle multiplicity | `TernaryGoldbach.Explicit.multRectD zetaF T rho : ℕ`, Explicit/Datum.lean:85 |
| xi square zero set / multiplicity | `TernaryGoldbach.Explicit.sqZeros T : Finset ℂ`, `mult T rho : ℕ`, Explicit/XiPartial.lean:471,475 |
| rectangle-to-xi order bridge | `multRectD_eq_mult`, Explicit/WeilBridge.lean:87 |
| rectangle zeros are nontrivial xi zeros | `zerosRectD_zetaF_strip`, Explicit/ZetaZeroSums.lean:39 |
| exclusion of a spurious zero at0 | `zetaF_zero_ne_zero`, same file:35 |
| positive real strip for xi zeros | `xiF_zero_re`, Explicit/ZeroFree.lean:97 |
| finite partial fractions with arbitrary error | `xi_partial_approx`, Explicit/XiPartial.lean:776 |
| unconditional limiting explicit formula with a fixed sequence | `explicit_formula_zeta_seq`, Explicit/ZetaExplicit.lean:122; existential wrapper `explicit_formula_zeta` at173 |

The source explicit formula already supplies a sequence `T : ℕ → ℝ`, with `T k ∈ Icc (k+1) (k+2)`, whose finite zero sums converge to

    mellin phi 1*x - SsumG 1 phi x
      - (1/(2*pi) : ℂ) * integral_y hZeta phi x (-1/2+y*I).

Use this unconditional theorem directly. `norm_SsumG_fP_zeta_le` in EtaPlusBound.lean has an explicit critical-line hypothesis and is not the replacement interface.

## Dependency order

P1 (positive weighted zero mass) and P2–P5 (actual smoothing and quartet bounds) are independent branches. P6 combines them for finite zero sums. P7 passes through the explicit formula. P8 applies the numerical norm budget. The lower-major-energy transfer is downstream of P8 and uses no nonprincipal cancellation.

### P1. Positive weighted zero mass at s=2

For rho=beta+i gamma define the real weight

    w2(rho)=(2-beta)/((2-beta)²+gamma²).

The needed finite statement is

    sum_(rho in zerosRectD zetaF T) (multRectD zetaF T rho : ℝ)*w2(rho) ≤.07

for T>0. This formulation uses current finite carriers and does not require a new global enumeration or canonical multiplicity definition.

Proof: embed the finite rectangle zeros into a sufficiently large xi square. Apply `xi_partial_approx` at 2, take real parts, use `xiF_zero_re` to make every omitted weight nonnegative, transport multiplicities with `multRectD_eq_mult`, and send the arbitrary approximation error to 0. The resulting upper bound is `Re(logDeriv xiF 2)`.

The exact identity from `Explicit/Xi.lean:142`, `logDeriv_xiF`, is

    Re(xiF'/xiF)(2)=3/2-log(pi)/2-EulerGamma/2-sum_n Lambda(n)/n².

The 3/2 includes the pole-removing factor of zetaF. The scratch `TernaryGoldbach.Explicit.XiMass.re_logDeriv_xiF_two_le` is a draft interface for the bound .07, not assumed proved by this chapter. A finite certificate using 333 prime-power terms through 2000 gives upper bound .0698425. The independent rational calculation in `joint_principal_model.py` uses 303 primes and gives .06981243158646303. Both routes require their analytic and arithmetic bridges to become closed Lean proofs.

### P2. Actual smoothing versus the compact model

Let etaO be `TernaryGoldbach.MajorArcs.etaO` from MajorArcs/EtaCirc.lean:33; on[0,2] its value is

    [r(2-r)]³ exp(-(r-1)²/2).

The required pointwise comparison, for r>0, is

    |etaPlus(r)-etaO(r)|≤.00221*r*exp(-r²/2).

Use `TernaryGoldbach.MajorArcs.integral_gL''_sq_le`, MajorArcs/HHFourier2.lean:195. Extract the weighted identity

    integral (2pi xi)^4 |Fourier(gC)(xi)|² dxi ≤368

from the Fourier-derivative/Plancherel proof of `tail_fourier_gC_le'`. Cauchy–Schwarz gives Fourier-tail L1 norm at most sqrt(368/(3pi*200³))<.00221. Full inversion, together with `hH_eq_fourier` or `hH_eq_fourier_K` in HHFourier.lean, gives P2. The complete Gaussian tail is retained.

A second extraction from the first-derivative energy 19.5 gives

    integral_R |Fourier(gC)| ≤3.01.

The exact constants, inversion interfaces and rational checks are in PointwiseSmoothingTail.md and TwistBounds.md. These extractions are new analytic obligations despite relying on proved source ingredients.

### P3. Compact Gram and parameter-control lemmas

For sigma real, let M^O_(sigma,gamma)(delta) denote the Mellin transform of etaO(r) exp(2pi i delta r) at sigma+i gamma. These are ordinary complex-valued functions on real delta. Define

    D(gamma)=integral_-4^4 |M^O_(7/8,gamma)(delta)|² ddelta,
    C(gamma)=integral_-4^4 M^O_(7/8,gamma)(delta)*M^O_(7/8,gamma)(-delta) ddelta,
    N0(gamma)=sqrt(2D(gamma)+2|C(gamma)|).

Prove that N0 is the maximum over real phase phi of the L2 norm of

    exp(i phi)M(delta)+exp(-i phi)conj(M(-delta)).

No supremum differentiability assertion is needed. The phase identity is a 2-by-2 real Gram calculation; it automatically covers the phase gamma*log x.

Plancherel in delta gives the following uniform compact bounds on 1/2≤sigma≤7/8:

    ||partial_sigma M^O||_2 <.313,
    ||partial_gamma M^O||_2 <.313.

The common squared moment is bounded by the exact rational number

    19896184597/266250045600+1024/45045 <.313².

Consequently `|N0(g)-N0(g')|≤.626|g-g'|`. P2 and full-delta Plancherel give an actual-minus-compact leading-pair error<.00313. A reflected pair contributes less than 1e-9 after its x^(-3/8) factor for x≥4.9e26.

Put A=N0(gamma)+.00313 and

    F(A)=A if A≥.626/61,
         (.626/61) exp(-1+61A/.626) otherwise.

Maximizing exp(-61d)(A+.626d), d=7/8-beta≥0, gives this F. The use of 61 is justified by log x≥log(4.9e26)>61. This controls beta uniformly without discretizing it.

### P4. Quartet estimate for every beta, gamma and x in the intended domain

For x≥4.9e26,1/2≤beta≤7/8,gamma≥0, let Q be the FOUR-TERM sum of `x^(rho-7/8)*mellin(fP delta)rho` at beta±i gamma and1-beta±i gamma, including repeated points in degenerate cases. Define

    w(beta,gamma)=2(2-beta)/((2-beta)²+gamma²)
                 +2(1+beta)/((1+beta)²+gamma²).

The target is

    ||Q||_(L2[-4,4])≤85*w(beta,gamma).                 (P4)

Its exact inverse Fourier integrand is

    2*x^(beta-7/8)*etaPlus(r)
       *(r^(beta-1)+x^(1-2beta)*r^(-beta))
       *cos(gamma log r+gamma log x).

The two reflected real parts have the SAME phase. Furthermore `w≥6/(gamma²+225/64)`.

On0≤gamma≤250, P3 reduces P4 to the scalar inequality

    (gamma²+225/64)/6 * [F(N0(gamma)+.00313)+1e-9] ≤85.       (G)

On0≤gamma≤16, full Plancherel gives N0≤1.8 and (G)<77.991. On75≤gamma≤250, rotating the compact finite segment[0,2] by angle1/2 while RETAINING its connecting arc gives

    |M^O|≤262 exp(27-gamma/2)+1268/(gamma-16pi)^4.

This yields (G)<65.395 on[75,100] and<56.483 on[100,250]. The cubic vanishing at r=2 is essential to the fourth-power arc denominator.

For gamma≥250, use the ACTUAL etaPlus Fourier convolution, angle.17, and cutoff B=gamma/2 until400, then B=200. The bounds are

    |M|≤4sqrt184/gamma²+800000 exp(-.085gamma), 250≤gamma<400;
    |M|≤800000 exp(-.17(gamma-200)), gamma≥400.

The quartet coefficient sum is at most1+x^(-3/4); its weighted ratio is<80 throughout this range. These are new contour lemmas with exact rational certificates in the parent `principal_high_height.py`; they are not an application of the older tail theorem outside its stated threshold.

### P5. Finite certificate for16≤gamma≤75

The existing computational certificate divides[16,40] into 2400 cells of width .01 and[40,75] into 350 cells of width .1. For a cell[a,b], center g and half-width h, the checked condition is

    (b²+225/64)/6 * [F(U_g+.626h+.00313)+1e-9] <85,

where U_g is a rigorous upper bound on N0(g). All 2750 cells passed; the largest bound is 83.571300905827202546089902080922956536 at[26.54,26.55].

The checker uses 47 u-panels and 26-point Gauss rules after truncating log r at-4, plus a 180-point delta Gauss rule. It explicitly carries analytic errors below 6.574e-13 and 1.363e-17, the pair tail below 2.2e-6, and all Arb node/weight/function uncertainty. Source hash is `3f511989a4e0f9f4d9206ceaf5c61ccda80a30303c87484d6292b0cb42e57a67`; cell-record hash is `06d59f3d77455c573f3ce4d52cfe381c5dc4a3307b40cd946f003aa102795ed7`. Root independently replayed completeness, hashes and final inequalities.

This is a complete external interval computation, NOT a kernel theorem. `joint-principal-cells.jsonl` and `joint_principal_certificate.py` are evidence, not Lean assumptions.

For kernel replay, prefer the rational moment-defect route in FORMAL_CERTIFICATE_PLAN.md: positive rational nodes/weights close to Gauss, exact moment checks, and a proved Taylor remainder bound. This avoids formalizing algebraic Gauss roots. Verify every elementary-function enclosure and finite dot product with a proved fixed-point checker; importing U_g as unproved constants is forbidden.

Concretely, for rational nodes t_i in [-1,1], nonnegative weights w_i summing to 2, and mu_k equal to 0 for odd k and 2/(k+1) for even k, set Delta_k=mu_k-sum_i w_i*t_i^k. If f is analytic on a neighborhood of the closed disk with center c and radius R, is bounded there by M, and 0<h<R, then q=h/R gives the proposed reusable estimate

    |integral_(c-h)^(c+h) f - h*sum_i w_i*f(c+h*t_i)|
      ≤ h*M*(sum_(k<n) q^k*|Delta_k| + 4*q^n/(1-q)).

Cauchy's coefficient bound proves this directly. The u-rule uses n=52 and q≤1/4; the delta-rule uses n=360 and q=1/2. Rational node replacement requires fresh certified function evaluations. The existing Arb values cannot be substituted unchanged. A closed fixed-point checker must prove outward rounding, exp/sin/cos enclosures, pi and log 2 range reduction, Gram sums, and final norm comparisons. Repository precedents are `chkStep`/`log_lt_of_chk` in Prelim/SmallPsi.lean and `chkLow`/`le_log_of_chk` in Prelim/SmallMertens.lean; these are arithmetic patterns, not a finished interval evaluator.

Recombining the existing certified U_g values with the same Lipschitz inequality produced a 243-center cover without a new Gram evaluation. It is a compression observation, not yet an exported or kernel-checked replacement certificate. Replaying those centers directly still entails 53.45 million complex quadrature products. A second-derivative Gram interpolation is a research option for further compression; it must operate on the Gram matrix rather than assume N0 is twice differentiable.

### P6. Finite zero sums: avoid orbit quotients

For each T>0, prove invariance of `zerosRectD zetaF T` under conjugation and rho↦1-rho, and invariance of `multRectD` using the xi order bridge and functional equation. These are missing formal interfaces, not hypotheses to leave in the final specialized theorem.

The functional identities already exist as `xiF_one_sub` (Explicit/Xi.lean:24) and `xiF_conj` (Explicit/XiPartial.lean:669). `xiF_zero_one_sub_conj` (Explicit/ZeroFree.lean:102) supplies the composed zero symmetry. For membership, use the rectangle definition, `mem_zerosIn_of_zeroD` (Explicit/Datum.lean:169), and the strict height inequalities. For multiplicities, `analyticOrderAt_xiF_eq` (Explicit/WeilBridge.lean:38), `divB_eq_of_analyticOrderAt_eq` (line55), and `multRectD_eq_mult` (line87) provide bridges; the symmetry of analytic order still needs a proof. No inspected source theorem already supplies the whole finite-set-and-multiplicity invariance claim.

A convenient Lean proof avoids choosing orbit representatives or dividing integer multiplicities. Average the finite sum over the four commuting symmetries:

    sum_S m(rho)f(rho)
      =(1/4)*sum_S m(rho)*[f(rho)+f(conj rho)+f(1-rho)+f(1-conj rho)].

Apply P4 after replacing beta by max(beta,1-beta) and gamma by|Im rho|. The same four permutations show that the sum of quartet weights is four times the original weighted mass. The 1/4 cancels, giving

    ||sum_(rho in zerosRectD zetaF T)
        (multRectD ... rho : ℂ)*x^(rho-7/8)*mellin(fP delta)rho||_2
       ≤85*.07=5.95.

This averaging proof handles beta=1/2 and gamma=0 automatically: repeated points occur on both sides with exactly the same factors. No zero spacing, simplicity, zero-free gap or special-case integer division is required. The proposed 2.39 gap remains uncompiled and unnecessary for this chapter.

### P7–P8. Limit, vertical remainder, and lower-energy transfer

Apply `explicit_formula_zeta_seq (goodSmoothing_fP delta)` with the same sequence `goodSeqD ldatum_zeta` for every delta. This fixed sequence is explicit in the existing theorem, so no delta-dependent choice is needed. Establish measurability of each finite transform sum, then apply Fatou to its nonnegative squared norm on `Icc (-4) 4`. The pointwise limit supplied by the explicit formula and the uniform P6 bound give the required L2 bound. An alternative is to prove absolute convergence in the Hilbert space from the positive weighted mass. Use the source's `zerosRectD_zetaF_strip` to exclude trivial zeros and 0; the pole residue is exactly x*mellin(fP delta)1.

On |delta|≤4, `thP delta=.005`: use `thetaD delta=0.28/(1+|delta|)` and `thP delta=min (thetaD delta) (1/200)`. The prefactor in `norm_mellin_fP_uniform` is <106000. `norm_integral_hZeta_le_gen` (Explicit/ExplicitBoundGen.lean:71), instantiated with `Kv=106000` and `theta_v=.005`, and `VgL` (line28) give normalized vertical error ≤3e10*x^(-3/2), hence L2 norm <1e-28 at the starting x. The main term identity `mellin(fP delta)1=Fourier(etaPlus)(-delta)` and `SsumG`/`Helfgott.S` equality are elementary but still need exact bridge lemmas with casts and summability checked.

The principal error norm is therefore at most 5.95*x^(-1/8)+1e-28. A simple rational final budget is 2125^8<4.9e26 and5.95/2125=.0028. Even allowing .00001 for the vertical term gives squared norm<(.00281)²=7.8961e-6<8e-6. Every estimate improves as x increases.

For the downstream lower bound, retain only the principal term in the exact character orthogonality identity and restrict every major arc to|delta|≤4. The finite sum of `mPhi` is≥13.597558, and the main Fourier energy is≥.6392. The square-splitting and coprime-removal calculation then yields the required lower bound 8.6296 for normalized major energy. The existing combined theorem is `TernaryGoldbach.MajorArcs.l2_major_bounds`, MajorArcs/L2Major.lean:309; its lower side is the replacement consumer. `MinorArcs/MinorTotal.lean:277`, `I0_ge`, is downstream. The draft `principal_le_sum_units_sq` in QrhL2Structure.lean isolates the needed unconditional character-energy inequality, but its presence in scratch is not a compilation claim.

## Status and first research-to-proof handoff

| Component | Current status |
|---|---|
| Pinned definitions, explicit formula, xi partial fractions, Fourier derivative energies | Existing source theorems; exact import/axiom validation belongs to integration |
| Global 7/8 provider | Exact candidate public symbol identified; independent transitive validation required |
| Weighted mass numeric constant | Exact finite arithmetic evidence and scratch Lean draft; not promoted here |
| P2–P4 analytic assembly, finite-segment contour, P6 symmetry/averaging, P7 limit | Detailed paper proof route; new formal interfaces required |
| All 2750 Gram cells | Complete reviewed Arb computation and independent root replay |
| 243-center compression | Existing-data coverage recombination; no kernel certificate |
| P5 kernel replay | Not implemented; rational rule and interval-checker soundness remain |
| P8 and lower-J replacement | Consequence of the listed obligations, not claimed Lean-proved |

The first bounded formal target should be the normalized 26-node rational quadrature certificate through degree51, with a proved moment-defect checker. It tests exact arithmetic size without importing the full analytic stack. In parallel, a separately scoped proof task can establish the finite symmetry-averaging lemma and specialize it only after the actual zero-set and multiplicity invariance lemmas are proved. No task should begin by postulating the Gram bound or weighted mass as a new external fact.

The chapter leaves the broad-twist principal estimates, all nonprincipal energy upper bounds, etaStar/cross terms, and final 10^27 assembly to their respective blueprint sections.
