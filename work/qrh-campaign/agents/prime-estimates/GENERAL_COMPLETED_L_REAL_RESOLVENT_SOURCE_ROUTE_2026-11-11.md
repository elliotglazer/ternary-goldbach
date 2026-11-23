# Actual completed-L real resolvents from finite contour identities

2026-11-11. Source/paper research, with no builds, Lean declarations, numerical evaluations or frozen-file changes. This derives a route for every primitive nonprincipal character, including nonreal characters and central zeros. It avoids an infinite Hadamard product. The new formal adapters listed below remain to be implemented and checked; this report is not a kernel-validation claim or a new premise for Goldbach.

The concrete improvement is to subtract two existing Cauchy-residue formulas, at s and 1-conj(s), before taking real parts. This supplies the individual character's real zero sum. A finite zero-polynomial then supplies the horizontal log-ratio identity and the lower bound needed by the proposed moderate Turing allowance. A paired character product is optional, not necessary.

## 1. Prior coverage and the actual function

The older `integration/FAMILY_DETECTOR_REVIEW.md` identifies the correct real resolvent and explains how a hypothetical order-one Hadamard product would lose its real constant. It explicitly leaves that product and convergence unproved. The earlier `audit/TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md` instead proves a coarser local lower estimate by finite Blaschke removal; it does not prove this completed-L identity. Its warning that the zeta-specific XiPartial theorem is not already a character theorem remains correct.

The inspected external `IEANTN/HadamardLogDerivative.lean` has useful finite factor identities, but its final zeta formulas assume a Hadamard logarithmic-derivative hypothesis. Mathlib's `Analysis/Complex/Hadamard.lean` is a three-lines theorem. Neither supplies the missing generic factorization simply by import. The present route uses actual finite residue and factorization source instead.

Fix an actual primitive nonprincipal Dirichlet character chi of conductor q, with q>1 and parity e in {0,1}. Define the mathematical abbreviation

    f(s) = q^((s+e)/2) * completedLFunction chi s,
    h(s) = f'(s)/f(s).

The positive real base q uses its real logarithm in complex exponentiation. This is the actual entire source completion, multiplied by an everywhere nonzero entire exponential. It is not a definition by the totalized Gamma product at Gamma poles. On Re(s)>0, the source completed/usual relation and nonzero Gamma factor give

    f(s) = (q/pi)^((s+e)/2) * Gamma((s+e)/2) * L(s,chi),
    h(s) = .5 log(q/pi) + .5 digamma((s+e)/2) + L'/L(s,chi). (1)

`DirichletContinuation.differentiable_completedLFunction` makes f entire. `Nonvanishing.LFunction_ne_zero_of_one_le_re`, with the nonprincipal alternative, and the Gamma factor give f(s) != 0 on Re(s)>=1. In particular f(2)!=0. The primitive functional equation and conjugation give

    f(1-conj(s)) = W_chi * conj(f(s)),
    h(1-conj(s)) = -conj(h(s))                           (2)

where the derivative identity is used only off zeros. The source root number W is nonzero, in fact a unit. The q exponential in f is essential: omitting it leaves an extra conductor term in the logarithmic derivative transformation.

The conjugation adapter is a real formalization task. `MulChar.star_eq_inv` and `star_apply'` identify the coefficients. Conjugating the absolutely convergent Dirichlet series proves the identity on Re(s)>1; conjugating local power-series coefficients makes the doubly conjugated function analytic, and analytic uniqueness extends the identity. Equal parity and the Gamma identity give the completion version, or uniqueness applies to the entire completions directly. This is not a claim that a single already-exported LFunction-conjugation theorem was found.

Equation (2) transfers nonvanishing to Re(s)<=0. Thus all zeros of f lie in 0<Re(s)<1, including any zeros with imaginary part zero. In this strip (1) differs from L by an analytic nonzero factor, so their analytic orders agree. A trivial zero of the uncompleted even L at s=0 is not a zero of f: reflection transfers f(0) to the nonzero value at 1. Principal characters are outside this argument.

Reflection R(s)=1-conj(s) preserves each zero's true analytic order. Explicitly, a local factorization f(rho+z)=z^m g(z), g(0)!=0, transforms to

    f(R(rho)+z) = W_chi*(-1)^m*z^m*conj(g(-conj(z))).

The last factor is analytic and nonzero at zero. This gives both order preservation and the correct reflection map without imposing gamma -> -gamma within a nonreal character.

## 2. Polynomial good heights from existing source

`Datum.ldatum_L` uses an exponential envelope BT. That envelope alone is insufficient for a vanishing large-square contour error. Replace just its growth data with the existing polynomial envelope

    B_q(T)=1400*q^9*(q+1)*(|T|+22)*(1.25*(|T|+11))^10.

`ZeroSums.norm_L_le_BP` proves the required bound on the radius-10 disk centered at 2+iT. `one_le_BP` gives B>=1400, `ZeroSumBound.BP_mono` gives monotonicity in |T|, and the center lower bound is the same .355 source bound already used by ldatum_L. The center upper bound is strict because the Euler bound there is at most pi^2/6<1400. Entirety, the zero-free strip -1<Re(s)<0, right nonvanishing, and the line-3/2 logarithmic-derivative bound can be taken from the existing `ldatum_L` fields.

For clarity, the new linear-growth field is elementary, not an assumed datum. With D_q=log(B_q(0)/.355)>0, factoring B_q(T)/B_q(0) gives

    log(B_q(T)/.355)
      = D_q + log(1+|T|/22) + 10log(1+|T|/11)
      <= D_q + (1/22+10/11)|T|
      <= D_q + 37 + 2.6|T|.

This completes the paper construction of `LDatum L_chi (BP q) D_q C3`. No new spectral assumption is needed. The stronger actual formula also shows log(B_q(k+1)/.355)=O_q(log(k+2)); hence the explicit `HkD` is O_q(log(k+2)^2).

`Datum.good_heightD` now supplies T in [k,k+1], with both horizontal lines at imaginary parts +/-T zero-free for L on -1/2<=Re(s)<=3/2 and with norm of L'/L at most HkD(B_q,k). It gives both signs for the same character in one choice. No intersection of independently chosen good-height sets is needed.

For k>=8 take the square

    Q_T = {z: |Re(z)-1/2|<=T, |Im(z)|<=T}.

On its right half, the portion with Re(z)<=3/2 lies on one of those horizontal lines. On the remaining portion, the absolutely convergent von Mangoldt logarithmic derivative gives norm <= C3 for every Re(z)>=3/2. The existing `norm_logDeriv_L_right` proves the line case; its same summand comparison with n^(-Re(z))<=n^(-3/2) proves the half-plane extension. This short extension remains a new adapter.

The source `XiPartial.norm_digamma_half_le` applied to z+e bounds the Gamma term by 16log(2+|z+e|)+4. Here Re(z+e)>=1/2 and |z+e|>=8 on the relevant boundary. Also |z+e|<=2k+4. Thus a sufficient boundary bound is

    M_q(k) = .5*|log(q/pi)| + 2 + 8log(2k+6)
             + C3 + HkD(B_q,k).

The left half follows from (2), whose reflection preserves the imaginary coordinate and sends it to the right half. The entire square boundary is zero-free for f, and |h|<=M_q(k). In particular M_q(k)/T -> 0. Constants may depend on q; the resulting identities hold for every fixed q, and a finite conductor family can take their maximum. No q-dependent finite RH height is used.

This reproduces precisely the analytic role of `XiPartial.xiF_sq_bound` and `MX_le`, using the existing character polynomial bound. It does not require a global order-one growth theorem for f.

## 3. Exact finite carrier and the central-zero safeguard

Do not reuse XiPartial's assertion that xiF(1/2)!=0 for f. A primitive character may have a central zero. Instead use the known nonzero anchor f(2), the ball radius 8T and the source finite carrier

    Z_T = zerosIn f 2 (8T) (4T), filtered by the strict interior of Q_T,
    m_T(rho) = (divB f 2 (8T) rho).toNat.

For T>=8 every point of Q_T has distance at most 2T+3/2<4T from 2. The hypotheses of `RectResidue2.rectInt_logDeriv_inv_sub` are therefore satisfied with c=2 and R=8T. No zero on Q_T's boundary is lost, since that boundary is zero-free. Every listed m_T is exactly the finite natural analytic order; it is not merely a positive lower multiplicity.

The square is preserved by R. Although the ball centered at 2 is not preserved by R, both reflected points belong to that same containing ball. The divisor-at-a-point formula, or the generic `WeilBridge.divB_eq_of_analyticOrderAt_eq`, converts true-order preservation into equality of m_T. Thus R permutes Z_T with weights preserved. This argument explicitly includes fixed points on the critical line and real zeros.

For increasing good heights T_j chosen in [2j+8,2j+9], the sets Z_Tj are nested and exhaust every zero. Their multiplicities stabilize because they equal intrinsic analytic orders, independently of the changing containing balls.

## 4. Two-basepoint contour and uniform real approximation

For s and v inside Q_T with f(s)f(v)!=0, subtract two applications of the existing residue theorem. With h=f'/f,

    (1/(2pi*i)) integral_boundary h(w)*[(w-s)^(-1)-(w-v)^(-1)] dw
      = h(s)-h(v)
        - sum_(rho in Z_T) m_T(rho)*[(s-rho)^(-1)-(v-rho)^(-1)]. (3)

The sign follows from the source theorem's summand (rho-s)^(-1). This is an identity for the actual f. It has no unproved exponential factor or arbitrary constant.

Suppose |s-1/2|,|v-1/2|<=M<=T/2. The distance from either point to each boundary point is at least T/2. Hence the difference kernel is bounded by 4|s-v|/T^2. The square has perimeter 8T. The source rectangle norm estimate, or its four side bounds, gives norm of (3)'s left side at most

    (16/pi)*M_q(k)*|s-v|/T.

Now take v=R(s). Equation (2) and the finite weight-preserving reflection of Z_T show that the real part of the right side of (3) is exactly twice

    Re h(s) - sum_(rho in Z_T) m_T(rho)*Re(1/(s-rho)).

Since |s-v|=2|Re(s)-1/2|<=2M, the absolute value of this real residual is at most

    (16/pi)*M_q(k)*M/T < 6*M_q(k)*M/T.                 (4)

Taking k arbitrarily large proves the needed uniform assertion: for each compact disk about 1/2 and each epsilon>0, a complete finite zero set Z_T contains all its zeros, with exact orders, and the real residual in (4) is at most epsilon at every nonzero point in that disk. There is no inverse minimum-modulus factor, so the bound is uniform even when the evaluation point approaches a zero. Only the singular expressions themselves are excluded until finite zero removal.

For Re(s)>1 all terms in the finite real sum are nonnegative. The nested exhaustion and (4) therefore establish convergence and the actual identity

    Re h(s) = sum_rho m_rho*(Re(s)-Re(rho))/|s-rho|^2.  (5)

This is an absolutely convergent real series. No claim of absolute convergence of the unsymmetrized complex series sum 1/(s-rho) is needed. There is no leftover real constant, because (3) and the exact reflection eliminate it at every finite stage.

## 5. Finite zero removal and the integrated ratio

Fix any real t, and choose a compact disk containing all points sigma+it with 1/2<=sigma<=5/2 in its interior; radius |t|+3 about 1/2 suffices. Let Z_T and epsilon be as above and put

    P_T(s)=product_(rho in Z_T) (s-rho)^m_T(rho).

There is an analytic g_T, nonzero on a neighborhood of the horizontal segment, with f=P_T*g_T there. This follows directly from the source `Landau.factor_ball`: factor all zeros in ball(2,4T), then multiply its nonzero remaining factor by the polynomial of the zeros excluded from the square. Those excluded zeros are outside the compact disk, so the extra polynomial is nonzero there. This uses the actual finite polynomial and exact analytic orders.

Off the finitely many zeros, (4) says |Re(g_T'/g_T)|<=epsilon. Analyticity and nonvanishing of g_T extend that inequality through the removed zeros by continuity. Along every horizontal unit segment,

    |log|g_T(sigma+it)|-log|g_T(sigma+1+it)|| <= epsilon.

This is the real fundamental theorem of calculus for log norm, not an assertion of a global complex-log branch. Integrate sigma from 1/2 to 3/2. Finite log-product additivity holds away from finitely many points. Local logarithmic integrability, already available through the meromorphic log-norm API, permits integration across all zeros and endpoints. Changing variables in the two intervals gives

    I_f(t) := integral_(1/2)^(3/2)
                [log|f(sigma+it)|-log|f(sigma+1+it)|] d sigma
      = -sum_(rho in Z_T) m_T(rho)*J(3/2-Re(rho),t-Im(rho)) + e_T,
    |e_T|<=epsilon.                                    (6)

The two shifted integrals have the same value as the J integral over symmetric offsets about 3/2; this is an equality after integration, not a pointwise equality of their integrands.

At s*=3/2+it, (4) also gives S_T<=Re h(s*)+epsilon, where S_T is its positive finite resolvent sum. The independently reviewed unpaired bound J<=4Re(1/(s*-rho)) therefore yields

    I_f(t) >= -4 S_T-epsilon >= -4 Re h(s*)-5epsilon.

Taking epsilon to zero proves

    I_f(t) >= -4 Re h(3/2+it).                         (7)

This finite argument is already enough for the lower-bound consumer. If the exact infinite log-ratio identity is desired, use the nested good-height sequence. Each J is nonnegative and at most four times the corresponding positive resolvent summand; (5) gives convergence, and (6) gives

    I_f(t) = -sum_rho m_rho J(3/2-Re(rho),t-Im(rho)).    (8)

No unjustified interchange through logarithmic singularities or infinite product is involved. The actual real-zero and central-multiplicity cases are included. Equations (5), (7), and (8) hold for all real t. Applying later Gamma estimates at t>50 is a separate domain restriction, not part of this contour lemma.

## 6. Remaining formal work and scope

The new source-level obligations are concrete:

1. Assemble f, its conjugation/functional-equation logarithmic derivative, the open-strip zero carrier and true-order reflection. Use the actual source completion at 0 and the Gamma poles.
2. Build the BP version of LDatum from existing fields and the explicit linear estimate above; prove HkD(BP,k)=O_q(log(k+2)^2). Extend the existing right-line von Mangoldt bound to its half-plane and assemble the square boundary estimate.
3. Extract the generic two-basepoint subtraction of `rectInt_logDeriv_inv_sub`, using the nonzero center 2. Reindex finite reflected zeros with exact orders and derive (4).
4. Implement the finite square-polynomial removal from `factor_ball`, real log-norm derivative and FTC, and the almost-everywhere finite product integration in (6). The zero-order and continuity arguments cannot be replaced by sampled nonvanishing.
5. For an exported infinite identity, add the nested exhaustion/nonnegative-series limit. The finite inequality (7) does not require this extra interface.

These steps give a complete paper route from the existing analytic source inputs. They are not already exported Lean declarations, and no transitive axiom or compatibility validation was performed here. The deeper Mathlib continuation/functional equation, nonvanishing, local analytic factorization and residue theorem remain genuine source dependencies. No RH, QRH, finite spectrum, simple-zero assumption or least-zero-height assumption is used. The proposed final Turing allowance also needs its separately derived Euler/Gamma bounds and canonical Littlewood/count normalization; this note does not approve its final numerical constant.

## Source pins

Repository paths below are relative to `work/ternary-goldbach/TernaryGoldbach/Explicit/`, at source commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

| File | Checked declarations | SHA256 |
| --- | --- | --- |
| `XiPartial.lean` | norm_digamma_half_le:270; norm_rectInt_le:205; xiF_sq_bound:361; xi_partial_frac:479; central anchor:627; xi_partial_approx:776 | `8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770` |
| `ZeroSums.lean` | BP:18; one_le_BP:21; norm_L_le_BP:32; zero_count_poly:76 | `3E5CD828CC6ADD2AF6D17F03F97E65F15720AEAF907826847EF191DEA8BCB72D` |
| `ZeroSumBound.lean` | BP_mono:228; log_BP_pos:240; log_BP_growth:244 | `A1294627F676EC49BED1BD86407A9460DC569B77AF8CBE8D65F1F49129BF17D4` |
| `Datum.lean` | LDatum:19; HkD:251; good_heightD:258; ldatum_L:698 | `42F14B373106D5508F73080BEC1E57992FDCBCB7A0460182AD396534463ACDDE` |
| `RectResidue2.lean` | rectInt_logDeriv_inv_sub:31 | `EC15FAFCAA6A472BFEABF71B1C79DFFD96F6CBF890EA80D77FAEE6F47427780B` |
| `Landau.lean` | divB/zerosIn:24-31; factor_ball:40; Pin:104 | `6D2A7B97640A49ECBC61F7406006214DB798E9989D8F25740DF3E42600520656` |
| `WeilBridge.lean` | analyticOrderAt_xiF_eq model:37; generic divB_eq_of_analyticOrderAt_eq:55 | `285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E` |
| `ExplicitFormula.lean` | C3/summable_C3:726-728; norm_logDeriv_L_right:739 | `8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35` |

Mathlib source root is `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib`, pinned commit `56a005855ea17e0b0958f73ec801ae140b0a1679`.

| File | Checked declarations | SHA256 |
| --- | --- | --- |
| `NumberTheory/LSeries/DirichletContinuation.lean` | LFunction_eq_LSeries:74; differentiable_completedLFunction:249; completed/usual relation:258; primitive FE:283 | `ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1` |
| `NumberTheory/LSeries/Nonvanishing.lean` | LFunction_ne_zero_of_one_le_re:397; value at 1:405 | `97D125ED132D6E39E61A6D9A8532E3460800FCE77569F5D621FC2B24E808B776` |
| `NumberTheory/MulChar/Lemmas.lean` | star_eq_inv:73; star_apply':79 | `8B72DD4496B40E0E4F5B9ED09E47FCC1777B597960F70FF14B6C43E8B5E0FF81` |

Prior-art files read, without promoting their retained assumptions:

- `work/qrh-campaign/agents/integration/FAMILY_DETECTOR_REVIEW.md`: `7B100AEFD46C0DAC5FA76EB3DD5A33819C51893037F663F02C6B7E25E0204F7A`.
- `work/qrh-campaign/agents/audit/TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md`: `A8D21679E5BF2C631D7399D73A70E85E3486EBC6A92CC1668C5060E77E2E11C9`.
- `work/qrh-dependencies/PrimeNumberTheoremAnd/PrimeNumberTheoremAnd/IEANTN/HadamardLogDerivative.lean`: `740A6A899A828847C4C0F8DD9A470CD46EE0A9B8A3D3E23A363BA0B49D23A392`.
- `work/qrh-campaign/agents/prime-estimates/FINITE_U_HARDY_NORMALIZATION_2026-11-11.md`: `06C9D3BF785BB183339D8EC64BE0B5AAD05331184C35356F575A8C126ADB724E`.
- `work/qrh-campaign/agents/prime-estimates/UNPAIRED_ZERO_RATIO_BOUND_2026-11-11.md`: `D315AE5C7B98C8A8E1042FE548B7A5FB704CEB200CFA48E36509A5A23910DB1B`; independent review `moebius/REVIEW_UNPAIRED_ZERO_RATIO_BOUND_2026-11-11.md`: `B42C970619E291A81BCFD1B3FBB39498CA471FB07F7DDC47B9DB8D52BAC8D3D4`.
