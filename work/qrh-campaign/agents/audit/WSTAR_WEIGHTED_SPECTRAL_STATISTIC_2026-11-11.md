# A weighted spectral statistic sufficient for the actual Wstar target

2026-11-11. Research derivation, not a proved actual energy bound. No Lean build, source change, prime or L-function evaluation, zero computation or transform evaluation occurred. The companion checks only twelve rational comparisons. The proposed route is not adopted here.

The plus target already proved sufficient for the consumer has a further use: it removes the need to bound a two-character product directly when proving Wstar. Two integrated nonprincipal star energies suffice. One has the strong major-main-term weight mu(q)^2/phi(q)^2. A finite weighted zero statistic can imply both, with separately stated remainder budgets. This avoids a formal requirement to evaluate every character, but neither the statistic nor its full-family remainders are established. The previously inspected explicit density majorants remain far too large under a direct cumulative-count comparison.

## 1. An actual-function reduction with all cross terms

Fix R=132900, x>=4.9e26, y=x/49 and Dq=8R/qt(q). Integrals in this report use the dimensionless plus twist delta in [-Dq,Dq]. The star Mellin twist is delta/49. Put

    s_q,b(delta)=S etaPlus x (b/q+delta/x)/x,
    P(delta)=Fourier(etaPC)(-delta),
    a_q=mu(q)/phi(q), r_q,b=s_q,b-a_q*P.

Retain the proposed plus bound, which implies sum_b |r_q,b|^2<=rho^2 with rho=8.85e-7, and its reviewed consequence sum_q integral sum_b|s_q,b|^2<=j=8.79. These are inputs to this reduction, not new conclusions about actual primes.

Expand the actual star sum using the exact coprime coefficient sequence Lambda(n)*etaU(n/y). Let u_q,b be its normalized nonprincipal additive part. Its energy is

    E_q(delta)=sum_b |u_q,b(delta)|^2
      =(1/phi(q))*sum_(psi!=1)|tau_q(psi)|^2
          *|Schar(psi^-1,coprimePart(q,Lambda*etaU_y),delta/x)/y|^2.

The inverse labels and the factor 1/phi(q) follow from the source finite-character identity and Parseval. E_q is the sum over unit numerators, not their average. It is not the unrestricted primitive-character energy.

Write the full normalized star residual as

    S etaStar x (b/q+delta/x)/y-a_q*Fourier(etaUC)(-delta/49)
       =u_q,b(delta)+v_q,b(delta).

The remainder v contains the principal residual, its coprime removal and the outer removal. Principal RH through 10^8 gives the principal unrestricted estimate less than 1.5e-6 on this domain: the source error is 1e-17+4.7e6/sqrt(y), and sqrt(10^25)>3.16e12. The source outer removal is at most 2e-9; the principal inner removal is at most another 2e-9 since |mu(q)|/phi(q)<=1. Therefore

    |v_q,b|<=p=1.504e-6.

This bound is uniform in q, b, delta and unbounded y. Its use requires the principal-only Cor933 localization already identified in the consumer audit. The actual twists satisfy |delta/49|<=4R/49<1.2e6. No nonprincipal finite RH is used for this remainder.

Define two actual nonprincipal integrated energies

    A=sum_q (mu(q)^2/phi(q)^2) integral |P(delta)|^2 E_q(delta) ddelta,
    B=sum_q integral E_q(delta) ddelta.

Then, with the full Wstar of the root integrated cubic contract,

    sqrt(49^2*Wstar/x^3) <=p*sqrt(j)+sqrt(A)+rho*sqrt(B).       (1)

Indeed the change beta=delta/x cancels exactly the x and y factors. The principal/removal piece has L2 norm at most p*sqrt(j). For the nonprincipal piece, use s=a_q P+r and Minkowski. The main part has squared norm A. At fixed q,delta,

    sum_b |r_q,b|^2 |u_q,b|^2
       <=(sum_b |r_q,b|^2)*max_b |u_q,b|^2 <=rho^2 E_q.

Integration gives the other term in (1). This is a deterministic same-modulus bound. All principal/nonprincipal and main/residual cross terms are covered by Minkowski; no independence or cancellation is asserted. No bound of L4 by L2 is used.

A concrete sufficient allocation is

    A<=9e-12, B<=9.                                         (2)

It gives sqrt(A)+rho*sqrt(B)<=5.655e-6. The exact comparison

    (5.655e-6)^2 <8.79*(3.67e-6-1.504e-6)^2

proves the required Wstar target. These are sufficient allocations, not optimal ones. They are independent of the separate pointwise base-gap energy target.

## 2. A full-strip etaU Gram bound without global QRH

The earlier family Gram calculation used beta in [1/8,7/8]. That range cannot be silently retained in the present no-global-QRH route. The following coarse extension works on the unconditional nontrivial strip 0<beta<1.

The actual source identity `Cor933.etaU_eq:49` is a positive mixture of g(t)=t^2 exp(-t^2/2) with measure eta2(r)dr/r on [1/4,1]. `Eta2Moments.moment_one:154` bounds its mass by 1.92182<2. For two mixture variables r,s, put C=(r^-2+s^-2)/2. Then 1<=C<=16 and r^-2*s^-2<=C^2. For -1<=sigma<=1 the Mellin kernel pair has zero-frequency absolute integral

    (1/2)*r^-2*s^-2*C^(-(sigma+4)/2)*Gamma((sigma+4)/2)<=6.

To check this, C^(-sigma/2)<=4 and Gamma(v)<3 for 3/2<=v<=5/2. The latter follows by splitting its defining positive integral at 1, bounding by 1 below and t^2 above, and using 1+5/e<3. Integrating both mixing variables gives the bound 24.

For the logarithmic variable z, set k=sigma+4 in [3,5] and H(z)=exp(kz-C exp(2z)). Direct differentiation and positive Gaussian moments give

    integral |H''| <=4k(k+1)*integral H <=120*integral H.

Both integrations by parts have vanishing boundary terms: k>=3 at minus infinity and Gaussian decay at plus infinity. Hence

    |Mellin(etaU^2)(sigma+i*tau)|<=min(24,2904/(1+tau^2)). (3)

Tonelli, mixture differentiation and the integration-by-parts steps are justified by these positive Gaussian majorants on the compact r,s range. This is a new paper derivation; it is not claimed to be a compiled theorem or inherited from the narrower reviewed strip.

Choose finite closed low-height carriers Z_chi with actual multiplicities, both ordinate signs and every real nontrivial zero. Suppose that each character's chosen carrier has at most 400 occurrences in every half-open interval of length h=3.48. This is the off-line window-count input, not a critical-line count or spacing assumption. The earlier source count proof supplies such an input only in its checked conductor/height domain; choosing larger heights requires a new count bound.

For a fixed row, the eight windows with |gamma-gamma'|<4h contribute at most 3200*24. For the two windows at distance in [kh,(k+1)h), k>=4, use 800*2904/(k*h)^2. Since sum_(k>=4)1/k^2<=1/3, the absolute Gram row is at most

    800*(96+2904/(3*3.48^2)).

Fourier Plancherel uses sigma=beta+beta'-1 and tau=gamma-gamma'. The change of star twist from delta/49 to delta contributes exactly 49. Schur's finite-matrix bound therefore gives

    integral_R |sum_(rho in Z_chi) m(rho)
            F_U(rho,delta/49)*y^(rho-1)|^2 ddelta
       <=G*sum_(rho in Z_chi) m(rho)*y^(2beta-2),
    G=7000000.                                           (4)

The exact row comparison is checked in the receipt. Multiplicity means repeated rows and coefficients, so the right side has one multiplicity factor and the window count counts repetitions. Phases y^(i gamma) and actual kernels are unchanged. For y>=10^25, each coefficient square decreases because beta<1. No reflection bound or global 7/8 input is needed.

## 3. Explicit weighted finite spectral targets

For each primitive nonprincipal character chi of conductor c, choose a complete inclusive finite carrier Z_chi through some H_c, and define

    S_chi=sum_(rho in Z_chi) m(rho)*(10^25)^(2Re(rho)-2).

Conductor cutoffs must cover every character induced with nonzero Gauss weight into Qset R. Let q be eligible for c precisely when q belongs to Qset R, c divides q, q/c is squarefree and coprime to c. Define

    omega_B(c)=sum_(eligible q) c/phi(q),
    omega_A(c)=sum_(eligible q) mu(q)^2*c/phi(q)^3,
    Q_A=sum_(c>1) omega_A(c)*sum_(chi primitive mod c) S_chi,
    Q_B=sum_(c>1) omega_B(c)*sum_(chi primitive mod c) S_chi.

These are the exact supported Gauss weights, each used once. Inversion permutes primitive labels at fixed c. No halving by conjugation is allowed. Nontrivial real zeros and repeated zeros are included.

The important weight difference is exact: omega_A(c)=0 for nonsquarefree c. In particular every primitive conductor divisible by four disappears from Q_A, because all its inducing moduli have mu(q)=0. It remains in Q_B. For a high odd conductor with only q=c,2c eligible, the weights are

    omega_A(c)=2*c/phi(c)^3 if c is squarefree, otherwise 0;
    omega_B(c)=2*c/phi(c).

Thus the main-weighted target does not charge all conductors equally. At a squarefree prime conductor c, omega_A=2c/(c-1)^3, about 2/c^2. This is an arithmetic weight in the aggregate, not a per-character Mellin saving.

Let z_chi be the finite negative zero sum in (4). The exact normalized coprime character value differs from z_chi by a remainder e_(q,psi). It must include all omitted high nontrivial zeros, the possible zero at the complex number 0, the vertical term, and primitive-to-coprime removal. Do not identify this remainder with an absolutely convergent high-zero series without proof; the reviewed pointwise-limit/measurable-residual transfer is sufficient.

Form the remainder character energy

    D_q(delta)=(1/phi(q))*sum_(psi!=1)|tau_q(psi)|^2*|e_(q,psi)(delta)|^2,
    T_A^2=sum_q mu(q)^2/phi(q)^2 *integral |P|^2 D_q,
    T_B^2=sum_q integral D_q.

Using the actual smoothing bound |P|<1, (4), and vector-valued finite Minkowski gives

    sqrt(A)<=sqrt(G*Q_A)+T_A,
    sqrt(B)<=sqrt(G*Q_B)+T_B.                             (5)

Consequently the following finite statistic and separate remainder conditions imply (2):

    Q_A<=4/(7*10^18), Q_B<=4/(7*10^6),
    T_A<=1e-6, T_B<=1.                                  (6)

The first square roots are at most 2e-6 and 2, respectively. All inequalities are uniform for x>=4.9e26 once the same uniform remainder bounds hold. The source |P|<1 bridge is an actual etaPlus smoothing estimate; etaPC is its complex coercion, not a different seed function.

This is one concrete sufficient spectral statistic, with numerical thresholds, that has no requirement to evaluate every character individually. It is not an established certificate. In particular the old 2e-12 star remainder was derived using specific finite-height/global-strip hypotheses. It cannot be inserted into (6) after dropping those hypotheses. A new high-tail estimate on 0<beta<1, a sufficiently large finite cutoff with valid local counts, or a direct actual-remainder energy theorem is still required. The four inequalities in (6) deliberately expose that gap.

## 4. Density comparison and its limitation

For either weight omega and the finite carriers above, put

    N_omega=sum_(c,chi,rho) omega(c)*m(rho),
    D_omega(s)=sum_(c,chi,rho:Re(rho)>s) omega(c)*m(rho).

Finite summation gives the exact identity

    Q_omega=(10^25)^(-2)*N_omega
       +2*log(10^25)*integral_0^1 (10^25)^(2s-2)*D_omega(s) ds. (7)

This accounts for both signs and all multiplicities. The baseline term cannot be discarded. The strict inequality in D changes only finitely many integration points. There are no nontrivial zeros on beta=1 in the source carrier; an upper bound remains sensitive to zeros approaching that line. A density theorem with a global 7/8 premise is not available merely because older reports used that route.

The previously reviewed `WEIGHTED_EXCESS_DENSITY_FEASIBILITY` packet establishes why the inspected printed density estimates cannot simply be reused. For example the Ramaré comparison has the positive additive term 32Q^2 log(Q^2T)^2, with T>=Q and T>=2000. Enclosing the present moduli by Q=300000 and taking T at least the largest chosen finite height leaves this term greater than 3732480000000000. Larger T does not reduce it. Its finite-computation dependencies also remain explicit.

Suppose one uses only that unweighted cumulative bound and converts it by D_A(s)<=W*D_all(s), with W any uniform upper bound for omega_A. Then W>=3/4, since conductor 3 already has eligible q=3 and 6, each contributing 3/8. On [.52,1], the measure in (7) has mass 1-(10^25)^(-.96)>1/2. Thus the additive term alone contributes more than

    (3/4)*(1/2)*3732480000000000

to the resulting Q_A comparison. This exceeds the threshold 4/(7*10^18) by more than 10^33. It is a lower bound on the sufficient comparison expression, not on actual Q_A or actual zeros. No claim that density theory itself is impossible follows. Removing or separately certifying small conductors can change this particular multiplier, but would still need a fresh weighted/blockwise calculation. Subtracting two cumulative upper bounds to manufacture an annular bound is invalid.

The old K<=6 excess certificate is not a solution to (6). It assumed the global QRH strip, retained small-conductor finite information and had a different consumer allocation. Its existing density failure is relevant warning evidence, not a proof that the new actual Wstar bound fails. Conversely the mu(q)^2 factor genuinely removes nonsquarefree main terms; it does not justify deleting them from B or from the base-gap target.

## 5. What large-sieve work would have to prove

The new actual-function targets A and B are a more direct opportunity than a blanket zero-density majorant. A theorem for the actual coprime nonprincipal star sums could establish them without any zero enumeration, and (1) would consume it without a two-character product array. It must preserve the restricted twists, the q-dependent coprime coefficients, the exact Gauss support, the main weight in A, and the unbounded scale.

An unweighted second moment is not interchangeable with A at no cost, and an average per character is not E_q. A global large-sieve theorem applied to unrestricted coefficient sums needs a proved transfer to these q-dependent coprime sums and the principal subtraction. The earlier pointwise-plus large-sieve obstruction is not automatically an obstruction to these integrated star targets: integration changes the problem. No explicit source theorem meeting A<=9e-12 and B<=9 has been identified in this audit.

The bounded next mathematical target is therefore either a direct proof of (2), or a weighted density/Gram proof of (6) together with its no-global-QRH remainder bounds. The latter is now an explicit finite spectral condition rather than a demand for individual RH, but no reduction in actual certificate-production cost has been demonstrated. The separate plus and base-gap targets and the retained principal certificate remain required for the final theorem.

## Pins and checks

The companion `wstar_aggregate_spectral_budget_20261111.py` creates only a new exact-rational receipt and refuses to overwrite it. Its twelve checks include the principal allowance, full-strip Gram constant, spectral thresholds and the stated density-comparison obstruction. They do not test actual A, B, Q_A, Q_B or the remainders.

| File | SHA256 |
|---|---|
| [THREE_AGGREGATE_CONSUMER_SUFFICIENCY_AUDIT_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/THREE_AGGREGATE_CONSUMER_SUFFICIENCY_AUDIT_2026-11-11.md) | 78119012C8BA40AFC93AB523B84DD441CD19D3FBC76F12418C41DD081B3C9F28 |
| [INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-blueprint/INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md) | 943DE38EE628CFA9E7221100E75933D101C7593B613945F19B7CBDF90E97C128 |
| [PLUS_RESIDUAL_TO_MAJOR_L2_UPPER_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-blueprint/PLUS_RESIDUAL_TO_MAJOR_L2_UPPER_2026-11-11.md) | F3EBC1B68CC57B607496D9E6445137A08A0F17C3202D986301F8EC25F14F4663 |
| [WEIGHTED_EXCESS_CERTIFICATE_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/major-constants/WEIGHTED_EXCESS_CERTIFICATE_2026-11-11.md) | 5039FA2BE3CD7062E99B75CC82F84F2B154E88714E19F140461FD954F8C67FF2 |
| [WEIGHTED_EXCESS_DENSITY_FEASIBILITY_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/major-constants/WEIGHTED_EXCESS_DENSITY_FEASIBILITY_2026-11-11.md) | 37505FDC4F83F99727FE636654E4803E3EB1EBF7C1B35FBF4E8C627097A72C90 |
| [REVIEW_WEIGHTED_EXCESS_DENSITY_FEASIBILITY_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/REVIEW_WEIGHTED_EXCESS_DENSITY_FEASIBILITY_2026-11-11.md) | 1C63512867F844E4FD66D51394A411B5951C5AB198F33B1B1AF2A341E20E47D9 |
| [RESUME_FAMILY_CAPS_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/major-constants/RESUME_FAMILY_CAPS_2026-11-11.md) | 2990B5B5D7ABA1B8262FB18800CA5CE61DC347B7C5748405A5886D9EE45BBAF3 |
| [ZERO_SUM_SOURCE_JOIN_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/zero-sum/ZERO_SUM_SOURCE_JOIN_2026-11-11.md) | 600F627B397F7A8E83AE20578D8BA7A7C5EBEC536578EA5EC41D1E3AAC25ABDA |
| [AGGREGATE_NONPRINCIPAL_BASE_GAP_TARGET_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/zero-sum/AGGREGATE_NONPRINCIPAL_BASE_GAP_TARGET_2026-11-11.md) | CFDA417AFFF112EBDF7BBB822FE7C884F3F8FCB4307BBC2F5AAC3B6856D5D264 |
| [wstar_aggregate_spectral_budget_20261111.py](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/wstar_aggregate_spectral_budget_20261111.py) | 04572B4D626C1811CE7AEC2B15848C14B88D8AF31390DCA111E3D95E850ADA8C |
| [wstar_aggregate_spectral_budget_20261111.json](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/wstar_aggregate_spectral_budget_20261111.json) | 1E30486CC8EB5683E1B486EAD7B3D70F7AD9B309EF863B4B059C10250D6031CB |
| [Cor933.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/Cor933.lean) | 554F00DE4FA6F8F0B6B184F8E8535B8AC5C28C0DB47FA2A95119B6BA4899F66E |
| [Cor713.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/Cor713.lean) | 11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433 |
| [Eta2Moments.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/Eta2Moments.lean) | 3DDC63BE9937E6022B77B80238CC1666A3B122161CC0CFA02081E0E9A2DF0871 |
| [EtaPlusL2.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/EtaPlusL2.lean) | 0E86FF780F7F4A817F3093787D24D0C5DC10290B56B8555C7EA62362E049D949 |
| [Bombieri.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/Bombieri.lean) | F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79 |
| [BaseGap2.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap2.lean) | AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E |
| [ZeroSumGen.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/ZeroSumGen.lean) | 9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389 |
