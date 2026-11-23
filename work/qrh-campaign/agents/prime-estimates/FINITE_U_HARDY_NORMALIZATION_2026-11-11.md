# From finite-U L-values to rigorous Hardy signs

2026-11-11. Paper/source derivation and exact scalar checks only. The new result is a finite elementary sign proxy for every primitive nonprincipal character and every real height. Its signs and zeros agree exactly with the source-normalized Hardy function. It needs no numerical Gamma magnitude and has no fixed additive analytic error floor for sign acceptance. A separate shifted formula supplies arbitrarily accurate values of a unit-normalized Hardy function when those values, rather than signs, are wanted.

This does not produce an L-value, phase table, sign, zero interval, count or runtime estimate. The finite-U arithmetic checks, character/phase certificates and all new Lean adapters remain to be supplied. The selected family and inclusive boundaries are unchanged; conductor one stays in its separate principal branch.

## 1. Actual source normalization

Let chi be an actual primitive nonprincipal complex Dirichlet character of conductor c>1, with parity a in {0,1}. Put

    alpha=(2a+1)/4, v=t/2, w=alpha+i*v,
    Lambda_chi(s)=c^((s+a)/2)*chi.completedLFunction(s).

On Re(s)>0 the actual source Gamma relation gives

    Lambda_chi(s)=(c/pi)^((s+a)/2)*Gamma((s+a)/2)*L(s,chi).

This equality follows by rearranging `LFunction_eq_completed_div_gammaFactor` using the nonzero Gamma factor. It does not define the source entire completion by a totalized Gamma product at its poles. On the critical line w has real part 1/4 or 3/4, so no such pole is present.

The exact source root number is

    W_chi=gaussSum(chi,stdAddChar)/i^a/c^(1/2),  |W_chi|=1.

Fix one phase epsilon_chi for the whole character, with |epsilon|=1 and epsilon^2*W=1. The reviewed two-chart construction from the finite Gauss sum supplies an exact definition and an enclosure procedure. An approximate unit or a phase chosen separately at each height is not a substitute.

The primitive functional equation and conjugation give

    Lambda_chi(s)=W_chi*Lambda_(chi^-1)(1-s),
    conjugate(Lambda_chi(s))=Lambda_(chi^-1)(conjugate(s)).

Hence Z_chi(t)=epsilon_chi*Lambda_chi(1/2+it) is real for every real t, including complex-character channels and t=0.

Let ell_Gamma be the analytic logarithm of Gamma on Re(w)>0, real on the positive axis and normalized by ell_Gamma(1)=0. It is the reviewed normalized Binet construction, not pointwise principal Log(Gamma(w)). Define

    theta_a,c(t)=v*log(c/pi)+Im ell_Gamma(alpha+i*v),
    H_chi(t)=epsilon_chi*exp(i*theta_a,c(t))*L(1/2+it,chi).

Then

    Z_chi(t)=A_a,c(t)*H_chi(t),
    A_a,c(t)=(c/pi)^alpha*|Gamma(alpha+i*v)|>0.             (1)

Thus H is real, continuous, and has exactly the same signs and zeros as Z. Its multiplier of L has modulus one. This is an explicitly changed positive normalization for a sign interface, not a claim that existing Z or tilted-F numerical boxes are H boxes. The prior Fourier normalization remains

    F_eta,chi(t)=c^(-alpha)*exp(pi*eta*t/4)*Z_chi(t).

Both extra factors are positive, so its signs also agree. Actual numerical values or absolute-error radii for Z or F would still require the magnitude A and those scale factors. They are deliberately unnecessary for the sign-only route below.

## 2. A uniformly positive phase proxy with no Gamma evaluation

The accepted normalized Binet proof gives, for every Re(w)>0,

    ell_Gamma(w)=(w-1/2)Log(w)-w+1/(12w)+E(w)-H_Binet(1),
    E(w)=-(1/3)*integral_0^infinity P3(fract x)/(w+x)^3 dx,
    |P3(r)|<=1/8 on [0,1],       H_Binet(1) real.

The earlier coarse-phase note uses a height-dependent estimate. For the present purpose, the real part of w gives a simpler estimate valid also at t=0:

    |E(w)| <=(1/24)*integral_0^infinity (alpha+x)^(-3) dx
            =1/(48*alpha^2).                              (2)

Absolute convergence follows from alpha>0. There is no conditional interchange or asymptotic-height assumption in this step.

Because alpha>0, the principal logarithm of w has argument atan(v/alpha) and real part log(alpha^2+v^2)/2. Define the exact finite elementary phase

    phi_0(t)=v*log(c/pi)+(v/2)*log(alpha^2+v^2)
             +(alpha-1/2)*atan(v/alpha)-v
             -v/[12*(alpha^2+v^2)].                      (3)

Then theta(t)-phi_0(t)=Im E(w). This uses the normalized logarithm only in the proof, not in the numerical expression. The phase (3) is globally continuous and odd in t. Its denominator is positive, and real atan has no branch cut on its real argument.

Define the real proxy

    P_chi(t)=Re(epsilon_chi*exp(i*phi_0(t))*L(1/2+it,chi)). (4)

From (1),

    P_chi(t)=H_chi(t)*cos(phi_0(t)-theta(t)).               (5)

The global bound 1-x^2/2<=cos(x) gives the exact constants

| Parity | alpha | phase error bound | positive cosine lower bound |
|---|---:|---:|---:|
| even | 1/4 | 1/3 | 17/18 |
| odd | 3/4 | 1/27 | 1457/1458 |

Therefore P and H have exactly the same sign at every real t, and one vanishes if and only if the other does. This is not an additive approximation with error |L|/3 that must be subtracted from a sign margin. The analytic phase error appears inside a strictly positive factor in the exact identity (5).

In particular, a rigorous interval for (4) strictly above or below zero proves the corresponding Hardy sign. The proxy is a continuous real function, so opposite strict endpoint signs imply an interior L-zero. The phases are real analytic, and the cosine factor in (5) is nonvanishing, so local real zero orders are preserved as well. For sign-based lower counts it suffices to use existence and the later actual-L count. No assertion of simplicity or completeness follows from one sign interval.

## 3. Explicit finite error allocation for the proxy

Fix rational work height V>=0, c<=300000 and desired rational tolerance tau=2^(-p), p>=0. Only rational sample heights |t|<=V are evaluated here. The actual unconditional repository theorem `Explicit/LGrowth.lean:179`, `norm_LFunction_le`, yields

    |L(1/2+it,chi)| <=2(c+1)*|1/2+it|
                     <=B0=2(c+1)(V+1).

This is a source theorem with chi!=1 and positive real part, with no Platt or spectral hypothesis. Set B=B0+1. Use the accepted arbitrary-height finite-U allocation with precision parameter p_L=p+5, including the critical-line disk offset and the full polynomial/evaluation error. To avoid relying on a representation convention, allow a factor 3/2 when converting a coordinate error bound to Euclidean norm. The resulting L center Lhat can be required to satisfy

    |L-Lhat| <=(3/2)*2^(-p_L)=3tau/64<tau/16,
    |Lhat|<=B.                                            (6)

The stronger norm conclusion in the finite-U note is not needed. Its arithmetic contract must actually be checked; p_L alone is not a certificate. An observed rational upper bound max(1,|Re Lhat|+|Im Lhat|) can replace B in the following allocations once Lhat is fixed, but the uniform B above suffices without any values.

Put eta=tau/(64B). Require

    |epsilon-epsilonhat|<=eta,
    |phi_0-phihat|<=eta,
    |exp(i*phihat)-rhat|<=eta,

and charge at most tau/16 for forming and serializing Re(epsilonhat*rhat*Lhat). All errors are Euclidean except the real phase error. A rectangular elementary enclosure must pay its norm conversion. The exact epsilon is unit; the stored center need not be. Since eta<=1 and |rhat|<=1+eta,

    |epsilon*exp(i phi_0)-epsilonhat*rhat|
       <=eta*(1+eta)+eta+eta <=4eta.

Here |exp(ix)-exp(iy)|<=|x-y| for real x,y. Therefore the final real center phat satisfies

    |P_chi(t)-phat|
       <=tau/16+B*(4eta)+tau/16=3tau/16<tau/4.             (7)

Thus [phat-tau/4,phat+tau/4] is a sufficient real output enclosure. A sign is accepted only if that interval excludes zero. Failure remains unresolved; refining tau is not promised to decide a zero value.

The phase tolerance above has a concrete elementary allocation. In (3), compute separate real centers for log(c), log(pi), log(alpha^2+v^2), and atan(v/alpha), each with error at most

    e=eta/[4(V+1)].

The sum of the absolute coefficients of these errors is at most (5V+1)/4. Their contribution is therefore below eta/2. Allow the remaining eta/2 for finite phase assembly and serialization. The rational reciprocal term in (3) can be formed exactly, or its rounding must enter that same assembly allowance. The positive log arguments, rational atan argument and real rational phihat satisfy the domains of the reviewed interval primitives. Log(pi) is enclosed by first enclosing pi and then using a sound positive-log enclosure, including input width; it is not a call to an unverified logarithm constant.

The finite Gauss-sum/two-chart algorithm refines the one fixed epsilon definition to eta. Rational exp/trig range reduction refines exp(i phihat) to eta. These are finite elementary procedures for effective exact inputs and positive error budgets. A new executable still has to implement them and prove its checker soundness. No old fixed precision, saved box, arithmetic size cap or wall-time allowance is silently inherited.

## 4. Optional accurate H-values and a shifted phase

If actual unit-normalized H values are needed rather than signs, (5) alone is insufficient. One can reduce the analytic phase error without evaluating Gamma by a finite shift J>=0.

The normalized logarithm satisfies

    ell_Gamma(w+J)=ell_Gamma(w)+sum_(j<J)Log(w+j).

For one step this follows from the source Gamma recurrence: the difference of the two sides exponentiates to one, is analytic on the connected right half-plane and vanishes on the positive real axis. Thus the constant multiple of 2*pi*i is zero. Induction gives the displayed formula. This extra log recurrence is not needed for the minimal J=0 sign proxy.

With A=alpha+J, Q=A^2+v^2, define

    phi_J(t)=v*log(c/pi)+(v/2)*log(Q)+(A-1/2)*atan(v/A)
              -v-v/(12Q)-sum_(j<J)atan(v/(alpha+j)).       (8)

Then |theta-phi_J|<=1/[48(alpha+J)^2]. In particular J=1 gives 1/75 and 1/147 for the two parities, with cosine lower bounds 11249/11250 and 43217/43218. These tighter constants are optional; J=0 already gives strict sign equivalence globally.

For a genuine H-value enclosure of tolerance tau, choose J with

    1/[48(alpha+J)^2]<=eta=tau/(64B).

This is an exact rational squared-bound test. The explicit finite cap J_cap=ceil(2B/tau) passes, and a smaller J can be found by integer square-root comparison or bounded search. This cap is an existence/work bound for the mathematical rule, not a recommendation to allocate that many terms.

Allocate eta each to epsilon, the finite phase (8), and its exponential. All J+1 atan terms and three log centers may use accuracy eta/[4(V+J+1)]; their absolute coefficients sum to at most 2(V+J+1), leaving eta/2 for finite phase assembly. The analytic phase error adds one eta, so the unit multiplier error is at most 5eta. The analogue of (7) is

    |H_chi(t)-hhat| <=tau/16+B*(5eta)+tau/16=13tau/64<tau/4.

This supplies arbitrary absolute accuracy for H, conditional on the stated finite arithmetic checks. It supplies neither the positive amplitude A in (1) nor a value of source Z/F without further multiplication. The sign proxy avoids this J growth entirely and is the recommended interface when the consumer asks only for endpoint signs.

## 5. Inverse channels, central points and the count formula

The same c and parity occur for chi and chi inverse. Both theta and every fixed-J phase in (8) are odd in t. Let kappa=epsilon_chi*epsilon_(chi^-1). The source Gauss/conjugation identity and unit-square relation imply kappa is exactly +1 or -1. The exact inverse-channel identities are

    H_chi(-t)=kappa*H_(chi^-1)(t),
    P_chi(-t)=kappa*P_(chi^-1)(t).                         (9)

The second also follows directly from L-conjugation and (4), without a numerical Gamma phase. For a nonreal orbit, defining the partner epsilon as the conjugate of the representative gives kappa=1. Independently chosen valid phases need the exact kappa identification. For a real character there is one channel and kappa=epsilon^2=W in {+1,-1}; one cannot assign it two different phases.

The previous tilted-F value relation additionally contains exp(-2bt), with b=pi*eta_tilt/4. Equation (9) is for H and the new proxy, not for those tilted values. Sign reuse is valid after the exact kappa adjustment; copying old absolute-error radii between different normalizations is not.

Everything above holds at t=0. A proxy enclosure containing zero supplies no exact central vanishing or multiplicity. If a central zero is forced or otherwise proved, the usual derivative/order evidence remains necessary. A nonzero central value does not exclude off-critical real zeros. Those are still part of the complete actual-L count.

Most importantly, the canonical Turing term remains

    G(t)=2*theta_a,c(t)/pi,

with theta defined by the normalized analytic log Gamma, not phi_0 and not an independently reset principal argument. Replacing endpoint sign evaluation by P is legitimate because (5) proves exact sign and zero equivalence. Replacing theta by phi_0 in the count identity without an integration error would be false. The already reviewed canonical count, Gamma-phase integral enclosure, both channel S allowances, central contribution and integer saturation all remain required. The new result simplifies the **sign-value producer only**.

## 6. Evidence, exact sources and remaining formal lemmas

The scalar-only script `finite_u_hardy_normalization_20261111.py`, SHA256 `03C27E09FD35195A8765263B0C9BEF63D41FAFE25E90DF2AD2EA425B79D63272`, returned exit 0. Its receipt `finite_u_hardy_normalization_20261111.json` has SHA `DD5C2BC8A872A3308476CF8781582FCC9FC74B6CF96BCFF9C5D1F1E9DB9D7421`. It checks the four J=0/1 rational phase/cosine bounds and four complete allocation examples, including c=300000,V=60343058,p=128. It evaluates no phase, Gamma value, L-value, sign or array. The proof of the uniform statements is the argument above, not a finite sample of heights.

The repository pin is `23b2d68ca344203d4384e0aff7affa4ec034bef9`; target Mathlib is `56a005855ea17e0b0958f73ec801ae140b0a1679`. Inspected source interfaces:

| Source | Exact role |
|---|---|
| `NumberTheory/LSeries/DirichletContinuation.lean:209,213,249,258,271,283` | Parity Gamma factors, entire nonprincipal completion, division relation, actual root number and primitive functional equation. SHA `ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1`. |
| `Analysis/SpecialFunctions/Gamma/Deligne.lean:48,69` | `Gammaℝ_def` and `Gammaℝ_ne_zero_of_re_pos`, permitting the critical-line rearrangement. SHA `C49C714067E797E8DD0F40CCBF39593C754C1DF3AD5A54C7A6F17188F97C7F45`. |
| `Analysis/SpecialFunctions/Gamma/Basic.lean:312,356` | `Complex.Gamma_add_one` and `Gamma_conj`. SHA `924736ACB968C113FAF74DD1BE6D125C3BC67EBA9492A2965A043172A3D6A136`. |
| `Explicit/LGrowth.lean:179` | Actual nonprincipal `norm_LFunction_le`, with positive real part. SHA `5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341`. |
| `Explicit/LGrowthLeft.lean:221` | `norm_rootNumber`. SHA `59B0B227CC2D9472C6389231E8CC3998698F1F3E59139A8D110F32FF64F2F3D4`. |
| `Analysis/SpecialFunctions/Complex/Arg.lean:217,399`; `Trigonometric/Arctan.lean:133` | `tan_arg`, right-half-plane argument range, and `arctan_tan` justify the explicit Log(w) phase in (3)/(8). |
| `Analysis/SpecialFunctions/Trigonometric/Bounds.lean:125` | `Real.one_sub_sq_div_two_le_cos`. SHA `5C2774AD86530B27F4E5A475667BD093812EA03C7DBABEDB5224D2BE234B268B`. |
| `Analysis/Complex/Trigonometric.lean:514,952` | `Complex.exp_mul_I` and `norm_exp_ofReal_mul_I`. The real-angle Lipschitz bound follows by integrating derivative i*exp(ix), whose norm is one. |

Reused author/review pins, with paths relative to `work/qrh-campaign/agents/` unless marked root:

| Packet | Author / review SHA256 |
|---|---|
| `prime-estimates/FINITE_U_AUXILIARY_EXTENSION_2026-11-11.md`; root `work/qrh-blueprint/REVIEW_FINITE_U_AUXILIARY_EXTENSION_2026-11-11.md` | `F96610CCC7D7F1B094DB3B9D3D287858AD7C0C38D819AB9B39AFA89946A6B855` / `CB10FD297B823A9F08454D5E054D8080AE9AE08DE01953ADB9F4DEF93C2AE265` |
| `zero-sum/FAMILY_ROOT_PHASE_PROOF_PLAN_2026-11-11.md`; `prime-estimates/REVIEW_FAMILY_ROOT_PHASE_PROOF_PLAN_2026-11-11.md` | `27B8ED6864E51BECEFA5402CC49E85B8A11F7F3BA620E7A7D1E6A682BBDD8C68` / `3281EC031C7605198842766E038C9C2DB66E8E81A2EC55DBF8BBC258E588FEB1` |
| `zero-sum/FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md`; `integration/REVIEW_FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md` | `5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41` / `098171B14232E392AAA0C4BDD083C0E737D459315E23039F624C862B8E06C577` |
| `prime-estimates/COARSE_GAMMA_PHASE_FOR_GABCKE_2026-11-11.md`; `independent-feasibility/REVIEW_COARSE_GAMMA_PHASE_FOR_GABCKE_2026-11-11.md` | `C7B701CF5B02D34142E30F38D1FFE573AE30167A561B9A759FD9964F41FC6E79` / `DE019E48942C1999785FA8F14BC4CD65CAD7C4423038965FA0DEF96DD8BC75D0` |
| `moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md`; `integration/REVIEW_PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md` | `0A2F4766FCB77668C5461E8A63B97327EF2E6F595E66F805544A7EFA49A4A028` / `A4401782284FFF48DFFBA27BB9DE2EFAF20E6BECB09A4F3737BDD220EA739547` |

The normalized Binet construction is a reviewed proof for the whole right half-plane despite its original principal-count filename. Only its general logarithm and periodic-cubic remainder are used; no principal zero certificate or sharp high-height theta approximation is assumed. New formal lemmas are the real-part remainder estimate (2), the parity-general proxy identity and positivity (5), the explicit product/error rule (7), and the optional normalized-log recurrence for (8). Existing source identities and reviewed paper arguments supply their mathematical inputs; they do not make these new lemmas kernel checked.

The exact character manifest, finite root-of-unity and epsilon enclosures, finite-U arithmetic certificates, and complete count data remain open implementation/production obligations. No result here changes the full-family target, the selected finite heights, the original BinaryGoldbachInput or the inclusive 10^27 final threshold.
