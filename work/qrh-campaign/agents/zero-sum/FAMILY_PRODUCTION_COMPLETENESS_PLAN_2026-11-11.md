# Full-family production plan: batched signs with certified completeness

2026-11-11. Research only: no production computation, build, dependency change, Lean proof or historical-GRH import. This plan targets every active primitive character through Hcert(c)=min(Hp_old(c),10^8/c), with the same inclusive heights and beta<=.555 conclusion. It complements the accepted local alpha/Cauchy experiments; it does not extrapolate their timings.

Status correction carried forward: the final paragraph of the frozen EM-top note is stale about[14,1500]. The accepted low sign-plus-count package now supplies that external principal strip. Head counts alone would not. No EM-top numerical change is required. Its independent alternative review also passed. These principal results do not certify any nonprincipal family rectangle.

## Proposed acceptance contract

Use one of two certificate kinds per conductor/conjugation orbit:

* A direct right-rectangle certificate for every character: whole-panel nonvanishing and zero winding to the right of .555, including gamma0. This is the weaker spectral statement actually needed.
* A critical-line sign certificate plus an independently bounded total count: all zeros through the checked height are accounted for on Re(s)=1/2. This proves a stronger statement, and can exploit batching along height. An unresolved sign or a count mismatch is not success.

Both kinds must cover the exact arithmetic manifest of150000 active conductors and5,543,640,188 primitive characters. The manifest contains unit-group coordinates, exact conductor/parity tests, conjugation/inverse indices, rational Hcert and every checked height T>=Hcert. Optional Turing zones extend above T and are separately listed; their samples are not silently claimed as extra certified height. All ledger entries must be present and explicitly PASS, with geometric/count checks. A process exit code0 is not an acceptance criterion.

The author's public source offers useful algorithms, not a ready certificate for this manifest. The research examined `djplatt/code` at commit `1f19fcbefa33d2fe5949ddbcd4d3df75deca6819`; this is a pinned current repository snapshot, not an assertion that it is the exact historical run. No historical output files or compilation configuration have been authenticated.

## Primary-source map

[Platt's2013 primary paper](https://arxiv.org/pdf/1305.3087) supplies the following candidate interfaces: Theorem2.2 sampling/DFT; Theorem3.1 normalized count differences; Theorem3.3 a Turing integral bound; Lemmas4.1–4.2 unit-group transforms and Hurwitz parameter expansion; Lemmas5.1–5.6 Fourier evaluation and its two alias tails; Section6 upsampling. These are the reusable mathematical components, not the paper's final numerical GRH claim. Theorem3.3 displays the candidate bound1.8397+.1242*log(c*(T+h)/(2*pi)) for T>50. Its proof is referred to Rumely; the sharper constants discussed afterward are attributed to personal communication. We do not import those sharper constants.

A visual reading of the preprint's Theorem3.2 revealed a normalization hazard: its displayed common1/(h*pi) is not transparently consistent with the displayed integrals of integer counts and normalized S. It must not be copied into a checker without reconstruction. The convention-fixed derivation below instead starts from count differences. This is not a claim that the historical computation was invalid.

The pinned [large-conductor evaluator](https://raw.githubusercontent.com/djplatt/code/1f19fcbefa33d2fe5949ddbcd4d3df75deca6819/l-func/int-l-func5.11.cpp) contains Hurwitz-lattice Taylor error handling, unit-group/Bluestein transforms, parity-dependent completion and root-number phases. It checks whether the resulting imaginary interval contains0. That is a useful diagnostic, but real-valuedness in our proof must follow from the functional equation, not that numerical check.

The pinned [small-conductor Fourier evaluator](https://raw.githubusercontent.com/djplatt/code/1f19fcbefa33d2fe5949ddbcd4d3df75deca6819/low_q/f_hat_even1.6.cpp) includes primitive-index selection, conjugate mapping, root phases and explicit error additions. The neighboring odd implementation must be audited separately. A file name or version suffix does not prove either implementation matches the required theorem or all production parameters.

The pinned [upsampling driver](https://raw.githubusercontent.com/djplatt/code/1f19fcbefa33d2fe5949ddbcd4d3df75deca6819/low_q/low_upsam8-1.1.10.cpp) distinguishes real characters and conjugate pairs, invokes count checks, and writes unresolved states. The [shared header](https://raw.githubusercontent.com/djplatt/code/1f19fcbefa33d2fe5949ddbcd4d3df75deca6819/includes/upsample.h) contains multiple variants, including routines whose comments describe assumptions on unknown regions. It also uses the optimized Turing constants. These are reasons to reconstruct a small fail-closed checker, not execute the repository wholesale and trust a success message. The count arithmetic in the header separates pi-scaled gamma/log terms from integer-count integrals, consistent with the reconstruction below.

The [author's Arb demonstrator](https://raw.githubusercontent.com/djplatt/code/1f19fcbefa33d2fe5949ddbcd4d3df75deca6819/dirichlet_arb/dirichlet_arb.c) computes Gauss sums by a character DFT, forms inverse-root-number square roots, evaluates primitive outputs through Hurwitz DFT and applies gamma completion. It is a small fixed-modulus program, not a general completeness certificate. Its square-root convention requires a proof and branch handling if reused.

## Exact real-valued normalization

For a primitive nonprincipal character chi of conductor c, let a in{0,1} satisfy chi(-1)=(-1)^a. Define

    Lambda_chi(s)=(c/pi)^((s+a)/2)*Gamma((s+a)/2)*L(s,chi),
    W_chi=tau(chi)/(i^a*sqrt(c)).

The required analytic identities are |W_chi|=1, Lambda_chi(s)=W_chi*Lambda_barchi(1-s), and conjugation compatibility. Choose one constant epsilon_chi with |epsilon|=1 and epsilon^2*W_chi=1. Then

    Z_chi(t)=epsilon_chi*Lambda_chi(1/2+it)

is real for real t: the functional equation gives Lambda_chi=W_chi*conj(Lambda_chi) on the line. A strictly positive real scale, such as exp(pi*|t|/4), may be included to avoid gamma underflow without changing signs or zeros.

The certificate fixes epsilon once per character. It cannot independently flip a square-root branch between samples. Conjugate characters can use compatible phases, or a verified constant sign relating the two choices. The relation between negative ordinates of chi and positive ordinates of barchi includes these phases and any chosen positive scales. No assumption that a nonreal character is symmetric in t is permitted.

All Gauss sums are finite sums of exact roots of unity. A certificate can enclose a root-number square root in a fixed rational sector, then verify the analytic construction of that branch. An interval merely containing a square root does not establish epsilon^2*W=1; that equality follows from the defined algebraic/analytic operation and its proof. Likewise, an imaginary interval containing0 is not a proof of real-valuedness.

Gamma is evaluated or bounded with a certified formula on Re((s+a)/2)>0. For count phases, logGamma is the holomorphic logarithm real on the positive axis, continuously followed in that half-plane. Principal arg(Gamma) reduced separately modulo2pi is not a substitute. Stable scaled gamma, its explicit remainder and phase propagation are additional formal/numeric obligations absent from the current alpha/Cauchy pilot.

## Count convention and a sufficient Turing inequality

For T>0 with no zero at either boundary ordinate, let C_chi(T) count all nontrivial zeros of L(s,chi) with |Im(s)|<T, with multiplicity. This includes real zeros. It is not just a positive-ordinate count. Let

    theta_a(t)=(t/2)*log(c/pi)+Im logGamma((1/2+a+it)/2),
    S_chi(t)=canonical_arg L(1/2+it,chi)/pi.

The canonical argument starts at L(s)->1 on the far right and continues horizontally, with the usual one-sided values at exceptional ordinates. At nonexceptional t, this is a path convention, not an arbitrary principal argument at the endpoint. The proposed normalized-count lemma to prove is

    C_chi(T)=2*theta_a(T)/pi+S_chi(T)+S_barchi(T).             (1)

Here c>1 and chi is primitive nonprincipal. There is no zeta pole correction. To derive(1), apply the completed-function count-difference identity between -T and T. The constant root-number phase cancels; theta_a is odd; canonical conjugation gives S_chi(-T)=-S_barchi(T). Completed primitive nonprincipal Lambda is entire and its zeros are exactly the nontrivial zeros after gamma/trivial-zero cancellation. These analytic facts and the count-difference theorem are explicit proof obligations. The c1 zeta entry uses its separate established normalization, not(1).

This derivation fixes the factors of pi independently of the problematic preprint display. It also shows why unknown real zeros cannot be discarded: they contribute to the count between -T and T even though no positive-t sign scan sees them.

Choose h>0 and nonexceptional T,T+h. Let G(t)=2theta_a(t)/pi. Suppose a proved Turing theorem gives

    |integral_T^(T+h) S_chi(t)dt|<=B_chi,
    |integral_T^(T+h) S_barchi(t)dt|<=B_barchi.

The displayed older bound above is a candidate B, pending verification of its original theorem and all hypotheses; all active Hcert exceed50. No sharper unpublished constant is needed for the logical contract.

Find disjoint certified sign-change intervals (u_j,v_j) in(T,T+h), separately tagged by chi or barchi. Define the exact rational lower weight

    W=sum_j (T+h-v_j).

Each interval contains at least one critical-line zero gamma_j. Its contribution to the integral of the added-zero counting function is T+h-gamma_j>=T+h-v_j. Missing auxiliary zeros only increase that integral. Integrating(1) therefore yields the sufficient upper bound

    C_chi(T) <= U := [integral_T^(T+h) G(t)dt - W
                       + B_chi+B_barchi]/h.                (2)

An interval enclosure of the gamma integral supplies a rational upper endpoint for U. Formula(2) needs only lower sign counts in the auxiliary zone, not an assumption that every auxiliary zero has been found. This is a useful reduction in the required evidence. It is also the correct direction: the auxiliary zero contribution is subtracted.

For a self-conjugate character, the two contributions in(1) and(2) are the same and must both be included. Thus its positive auxiliary list contributes twice to W and its Turing allowance twice. For a nonreal pair, use each member's positive list once. All intervals must lie strictly inside the auxiliary range with certified nonzero endpoints.

## Main signs, central points and saturation

For chi nonreal, a main certificate consists of disjoint positive-t sign intervals for chi and for barchi below T, plus a central multiplicity r_chi if needed. Their total

    K_main=K_chi_positive+K_barchi_positive+r_chi

is a lower bound for C_chi(T). Negative zeros of chi correspond to positive zeros of barchi with the same multiplicities. For chi real, K_main=2*K_positive+r_chi. Conjugate-pair processing is not permission to halve this formula again.

The simplest central certificate is an interval proving L(1/2,chi) nonzero, giving r_chi=0. An interval containing0 proves nothing. If the value cannot be separated from0, the case remains unresolved or needs an exact zero/multiplicity proof (for example, an applicable symmetry plus a nonzero derivative of known order). Off-critical real zeros are not covered by a central-point check; they remain in C_chi and are excluded only by successful saturation or a separate real-axis certificate.

If a rational upper bound from(2) satisfies U<K_main+1, then integer-valuedness and K_main<=C_chi(T) imply C_chi(T)=K_main. Every counted zero is then accounted for by the disjoint critical-line intervals and central certificate. A hidden even-multiplicity zero, an extra zero within a sign interval or an off-line zero would increase the total and prevent saturation. This proves finite RH through T, hence the required .555 bound. No zero-spacing or simplicity hypothesis is used; simplicity of ordinary sign intervals would be a consequence of saturation.

To cover the requested inclusive Hcert, require T>=Hcert and certify no nontrivial zero on |gamma|=T. A top-path certificate for chi and barchi, with functional-equation transport, can do this. Alternatively use a rigorously justified one-sided counting convention and explicit boundary-zero treatment. A sign sample only at the critical-line endpoint does not exclude an off-line zero at the same height. Selecting a larger rational endpoint is allowed only when the enlarged count/sign computation is actually checked.

## Batching with a complete error budget

Large-conductor batches can reuse a pole-cancelled Hurwitz alpha lattice and apply a unit-group DFT, exactly as the accepted conductor101 experiment demonstrates locally. The mathematical inputs are actual L-function sample enclosures. The source growth bound(q+1)|s|/Re(s) supplies actual-L Cauchy models when the outer disk stays in Re(s)>0. Alpha Taylor error, s-model alias error, finite EM error and transform rounding remain separate quantities. DFT indexing must use the full CRT unit group, including the noncyclic2-power factor; prime101 is not a proof of that general adapter.

For small conductors and high t, a height-batched Fourier evaluator can supply the same sign-value interface. One reusable candidate is the parity-unified Gaussian Fourier identity, with u=x+i*pi*eta/4, |eta|<1:

    Fhat_a(x,chi)=2*epsilon_chi*c^(-(2a+1)/4)*exp((2a+1)u/2)
       *sum_(n>=1) n^a*chi(n)*exp(-pi*n^2*exp(2u)/c),

where F_a is the corresponding gamma-completed critical-line function with the positive exponential tilt. The identity, its contour shift and exact normalization must be proved before use. It is not an AFE length heuristic.

There is an elementary explicit truncation budget for this Gaussian sum. Put d=Re(pi*exp(2u)/c)>0 and truncate after n=M. For a0, the omitted absolute sum is at most

    exp(-d*(M+1)^2)/(1-exp(-d*(2M+3))).

For a1, use the first omitted term(M+1)*exp(-d*(M+1)^2) and ratio

    r=((M+2)/(M+1))*exp(-d*(2M+3));

when r<1, the tail is at most that first term/(1-r). These follow from successive-term ratios and |chi(n)|<=1. Multiply by the Fourier prefactor's modulus. This supplies only the Gaussian-series tail, not the frequency-periodization or time-periodization errors.

With transform length L=A*B an integer, time samples t_m=m/A and frequency spacing2pi/B, the unnormalized inverse DFT must be multiplied by2pi/B under the convention Fhat=(1/(2pi))*integral F exp(-ixt). If each folded frequency coefficient has error E_n, its output contribution is bounded by(2pi/B)*sum_n E_n. Add separately the time-periodization tail sum_(k!=0)|F(t_m+kB)|. The periodization theorem, both signed tails, gamma-decay inequalities, eta restrictions and positive denominators are obligatory. A machine FFT result without these bounds is not a sign enclosure.

Upsampling is optional for producing candidate sign locations. Acceptance can recompute those locations by EM/alpha models or a proved interpolation theorem. Unknown FFT signs remain unknown. It is unnecessary to serialize every failed search sample, but every accepted sign and every completeness inequality needs reproducible evidence and a sound evaluator.

## Comparison and bounded next task

The accepted alpha/Cauchy block method directly proves nonvanishing at sigma.555 without introducing root-number phase, gamma signs or Turing completeness. Its missing work is coverage of every required boundary and stable high-height coefficient construction. The sign route can exploit known height batching and gives a count-based stopping criterion, but adds gamma normalization, real/central-zero treatment, endpoint exclusion and a rigorous integrated-S bound. Neither route is established for all active characters by the current pilots.

The concrete next bounded task should freeze and independently prove the exact count lemma(1) and sufficient inequality(2), including the real-character specialization, before implementing a Turing checker. In parallel only if separately authorized, a modest composite conductor would test CRT character indexing, phase normalization and the pairing ledger. A small positive sign scan without a certified total upper count would not resolve the main remaining obligation.

Source-data work still needed: authenticate a release/configuration if reusing historical data; identify all imported constants and prove their stated domains; prove interval primitives; certify arithmetic character manifests and root phases; supply actual sign/count packets with an empty unresolved queue; and connect the resulting finite RH theorem to the campaign's source L-functions and inclusive Hcert. No runtime forecast, evidence-volume forecast or historical-GRH proof import is made here.
