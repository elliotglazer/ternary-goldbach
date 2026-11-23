# Finite zero bounds to actual mixed character residuals

Research proof, 2026-11-11. No Lean declaration, build, numerical evaluation, zero scan, dependency change or frozen-file edit was made. The source revision is `23b2d68ca344203d4384e0aff7affa4ec034bef9`. All bounds on actual smoothing functions and all finite spectral information below remain inputs with their existing proof status. This note proves a transfer implication; it does not prove the finite certificate or validate the global seven-eighths provider.

The new join removes an unnecessary convergence obligation. The common-height major report says that its finite-rectangle bounds pass to the limit by an absolute-convergence argument. The hybrid report offers absolute convergence or Fatou without giving the integrated mixed transfer. Neither is needed here. Stabilize the finite low-zero sum, take the source explicit-formula limit separately at each twist, and split the resulting measurable residual by radial truncation. The exact same-modulus, two-character mixed bound then follows by finite-dimensional inequalities and ordinary integration. There is no choice of measurable good-height sequences, interchange of an integral and a limit, or assertion that the infinite zero series converges absolutely.

## 1. Scope of the selected spectral inputs

The current consumer frontier retains a global actual-L zero bound `beta <= 7/8` and an inclusive finite bound `beta <= 111/200` through

    Hcert(c) = min(Hp_old(c), 100000000/c),
    Hp_old(c) = ceil(200 + max(1000, (704/7)*Dc)),
    Dc = 1200000/qt(c),
    qt(c) = 2c if c is odd, and c otherwise.

The active primitive conductors are odd c<=150000 and multiples of four c<=300000, including c=1. The finite condition quantifies over every actual primitive character and every nontrivial zero, not a list of sampled zeros. The certificate height is the rational minimum as written; it is not rounded upwards. Major low cutoffs are Hplus=Hcert and Hstar=min(Hs_old,100000000/c)<=Hcert.

The inverse-character functional equation supplies the lower bounds 1/8 and 89/200. Its map is `(chi,rho) -> (chi^-1,1-rho)`, not a same-character reflection for a general nonreal character. Conductor and absolute ordinate are unchanged, so the finite certificate for the inverse character is available at the same cutoff. The pinned provider-compatibility note gives the analytic nonzero local factor and the order transport. No conjugation or positive-height doubling is used in the proof below.

The principal psi route additionally needs its own low-zero and narrow-strip inputs. The current frontier records closed low-height information through 2000 and the remaining narrow-strip target `[.4968,.5032]` up to 10^6, as well as the weighted-count target. Nothing here deduces those inputs from .555 or seven-eighths. At c=1 the same transfer uses the zeta-specific explicit formula, with its pole subtracted. It does not identify the principal psi consumer with the major mixed consumer.

## 2. Exact source carrier and multiplicity stabilization

For primitive nonprincipal chi use f=chi.LFunction. For the sole primitive principal case use f=zetaF, the entire continuation of `(s-1)*zeta(s)`. These are the source functions, not completed functions or supplied zero lists.

`ExplicitFormula.lean:298,302` defines `zerosRect chi T` and `multRect chi T`; `Datum.lean:81,85` defines the generic analogues. Both take analytic-divisor zeros from the ball centered at 2 of radius `RT(T)=2(T+3)`, with the inner norm restriction `|rho-2|<T+3`, and then impose

    -1/2 < Re(rho) < 3/2,       -T < Im(rho) < T.

The multiplicity is `(divB f 2 (RT T) rho).toNat`. For the nonprincipal source, `ZeroSums.zerosRect_cases:159` gives an actual zero which is either rho=0 or lies in 0<Re(rho)<1. For zetaF, `ZetaZeroSums.zerosRectD_zetaF_strip:39` gives the strict nontrivial strip with neither rho=0 nor rho=1.

Fix H>0 and put T*=H+1. Define Z_H by filtering the source carrier at T* to `rho != 0` and `|Im(rho)| <= H`. Use the multiplicity m_H from that same reference carrier. This is a finite object with no enumeration premise. It contains every actual nontrivial zero through the inclusive height H. Indeed such a zero obeys

    |rho-2| <= |Re(rho)-2| + |Im(rho)| < 2+H < T*+3.

The outer-ball condition follows too. An entire function nonzero somewhere has finite analytic order at every point; a zero has positive order, hence belongs to the divisor support. This is exactly the argument in `Datum.mem_zerosIn_of_zeroD:169`. The nonzero-at-2 inputs are already among the source L/zeta data.

For every T>H, the same filtered carrier is Z_H, and its multiplicities equal m_H. Membership follows from the same geometry. For the multiplicities apply the existing `ExplicitFormula.divB_eq_of_mem:384` to f itself on the two containing balls, then apply `.toNat`. No reflection of the balls is required. Equivalently, both divisors equal the same finite analytic order. This also proves stability of a possible rho=0 contribution for T>0. Do not infer stability merely from equality of sets of distinct zeros.

Consequences:

* Zeros exactly at either ordinate +H or -H belong to Z_H, although each source outer rectangle is strict. The high part is H<|Im(rho)|.
* A real nontrivial zero with Im(rho)=0 and 0<Re(rho)<1 belongs to Z_H, with its full multiplicity. It is different from the possible trivial zero at the complex number 0.
* The source good heights lie in [k+1,k+2], so eventually T_k>H. Neither nested carriers for the first finitely many k nor a monotone sequence is needed.

## 3. The actual finite estimate replacing the critical-line bound

Write M_delta(rho) for the actual smoothing Mellin transform, and z>=1 for its physical scale. Suppose the low zeros obey Re(rho)<=b, the high zeros obey Re(rho)<=theta, and a uniform low transform bound is K_delta. For any outer T, the triangle/count proof gives

    |sum_(rho in zerosRectD f T) m_T(rho) M_delta(rho) z^rho|
      <= G0_delta*Z3g(B,0) + z^b*K_delta*N_H
         + z^theta*E2g(B,kappa,H,EB,EA,rB,rA).                 (1)

Here N_H bounds the sum of low multiplicities, not their distinct cardinality. The zero0 term is omitted for zetaF. The EB,EA>=0 and 0<=rB,rA<1 hypotheses, plus the actual pointwise high Mellin envelope, are exactly those of `ZeroSumGen.zero_sum_boundG`. The radius-three high-window count `count_tail_windowG` already works throughout 0<Re(rho)<1 and counts both signs. Its weighted geometric sum is

    E2g = EB*(2*Z3g/(1-rB) + 2*c3g/(1-rB)^2)
        + EA*(2*Z3g/(1-rA) + 2*c3g/(1-rA)^2).

In the source proof replace only `z^Re(rho)<=z` on the high part by `z^Re(rho)<=z^theta`. On the low part use the stated finite bound, or retain the exact finite sum for the Gram estimates. The identity `|z^rho|=z^Re(rho)` is `norm_cpow_x`. Natural multiplicities are nonnegative after casting, so every comparison preserves its direction.

This derivation does not reuse `count_line_windowG`, its radius 2.3, E1g, or the hypothesis Re(rho)=1/2. Formula (1) is a valid coarse replacement of sqrt(z)*E1g by z^b*K_delta*N_H and of z*E2g by z^theta*E2g. The major Gram calculation uses the exact low sum instead of the coarse middle term. For the selected exponents, normalization by z produces z^(-89/200) on a low triangle bound and z^(-1/8) on the high bound.

## 4. Pointwise limit with the correct signs and principal term

For each fixed character, twist delta and positive scale z, define

    p_chi(delta) = -sum_(rho in Z_H) m_H(rho) M_delta(rho) z^(rho-1).

The minus sign agrees with the explicit formula. Let S_chi be the actual `SsumG`, and put

    R_chi = (S_chi - 1_(c=1)*z*M_delta(1))/z.

For nonprincipal chi, `explicit_formula_gen:988` supplies a sequence T_k in [k+1,k+2] and

    full_zero_sum(T_k) -> -S_chi - V_chi,
    V_chi = (1/(2*pi))*integral hIntG on Re(s)=-1/2.

For c=1, `ZetaExplicit.explicit_formula_zeta_seq:122` instead supplies

    full_zero_sum(T_k) -> z*M_delta(1) - S_chi - V_chi,
    V_chi = (1/(2*pi))*integral hZeta on Re(s)=-1/2.

Thus V_chi denotes the source's hIntG integral for a primitive nonprincipal character and its hZeta integral for c=1. The principal term is not the generic hIntD integral for zetaF: that logarithmic derivative also contains the s-1 factor. The specialized zeta formula has already separated that factor to produce the displayed pole main term.

After the stabilization in Section 2, the negative normalized high part therefore converges to

    R_chi - p_chi + (Z0_chi+V_chi)/z,

where Z0_chi=m(0)M_delta(0), or zero when f(0)!=0. In the zeta case Z0_chi=0. If every finite high part has norm<=b_chi(delta), continuity of the norm gives

    |R_chi(delta)-p_chi(delta)|
      <= b_chi(delta) + |Z0_chi+V_chi|/z.                    (2)

The hypotheses needed here are actual GoodSmoothing, the actual finite high envelope and the separate zero0/vertical bounds. GoodSmoothing includes the source's full strip requirements; a bound on the left vertical line alone is insufficient. In particular the earlier full-strip constant issue cannot be bypassed with this limit argument.

After the existing primitive-to-induced coprime comparison, the same statement is

    |R_(q,psi),coprime - p_(psi^-1).primitiveCharacter|
       <= b_c + d_(q,psi),       c=cond(psi)=cond(psi^-1).   (3)

Here d includes precisely the separately bounded zero0, vertical and removal terms, and b remains the selected nontrivial high-zero bound. The primitive principal pole is subtracted before this comparison. Equation (3) is pointwise; it permits a different T_k for every character and delta. It asserts no convergence of a reordered zero series and no uniform convergence in delta.

## 5. A measurable envelope split eliminates the remaining mixed-limit gap

To integrate (3), only the actual residual R and the finite low sum p need to be measurable. For the present smoothings they are continuous in delta. The source `MajorArcs/ArcChars.summable_cP:30` supplies absolute summability of the etaPlus coefficients. The etaU version follows from the unconditional `Helfgott/Decay.lean:251` theorem `summable_etaStar` and `etaStar_eq_etaU`, by the elementary rewriting displayed in `MinorArcs/BaseGap2.lean:258-265`. We use that rewriting, not the enclosing base-gap theorem with its PlattGRH binder. Character values and twists have norm at most one, so the sums converge uniformly in delta. Each finite Mellin term is continuous by dominated convergence using the finite absolute Mellin moment at its Re(rho). These moment/integral adapters must be formalized for the actual smoothing, but introduce no new zero hypothesis.

Let w=R-p, and let b,d be nonnegative measurable envelopes satisfying |w|<=b+d. Define

    h = w                         if |w|<=b,
        (b/|w|)*w                otherwise;
    e = w-h.

Both branches are measurable; the second has a strictly positive denominator. Directly,

    |h|<=b,       |e|=max(|w|-b,0)<=d,       R=p+h+e.       (4)

This remains valid when b=0 or w=0. The constructed h is an envelope component. It is not claimed to equal the high-zero series or the pointwise high-part limit. That identification is unnecessary for any norm estimate below. In particular this construction does not require measurability of the parameter-dependent vertical integral or of any selected good-height sequence.

This distinction resolves the vulnerable join: finite high-zero estimates first bound a measurable actual difference, and (4) provides the measurable components needed by the mixed Hilbert-space argument. Merely declaring a collection of pointwise limits to be an integrable high-zero function would have left this step unstated.

## 6. The exact common-height mixed estimate follows

For each active modulus q put Iq=(-Dq,Dq) and

    w_(q,psi) = |tau_q(psi)|^2/phi(q).

Form the finite character vectors by multiplying each scalar p,h,e,R by sqrt(w_(q,psi)). The character in p is `(psi^-1).primitiveCharacter`. `MinorArcs/Bombieri.norm_sq_gaussSum:135` gives |tau|^2=c exactly when q/c is squarefree and coprime to c, and zero otherwise. Inversion preserves c. Thus a conductor envelope t(c) gives

    |Hplus_q(delta)|_2^2 <= Tq
      = sum_eligible_c c*a(c)*t(c)^2/phi(q).

The full sum of weights is phi(q): character orthogonality applied to the unit-supported additive phase gives sum_psi |tau_q(psi)|^2=phi(q)^2. Equivalently, the exact eligible-conductor identity is sum c*a(c)=phi(q)^2. Therefore a uniform scalar error d gives |E_q|_2<=d*sqrt(phi(q)). No unproved 1/sqrt(c) saving is introduced.

Use (4) for the plus channel with b=t(c), d=d0; use the direct full error bound for the star channel, denoting it E*. The actual tensor identity at each q,delta is

    Rplus_q tensor Rstar_q - Pplus_q tensor Pstar_q
      = Hplus_q tensor Pstar_q + Eplus_q tensor Pstar_q
        + Pplus_q tensor Estar_q + Hplus_q tensor Estar_q
        + Eplus_q tensor Estar_q.                           (5)

Its coordinate indices are two independent characters of the same modulus. The tensor norm is the product of the character-vector norms. Integrate squared norms on each actual Iq and sum q, then apply Minkowski. The reviewed common-height packet supplies the following finite-low and scalar aggregate bounds:

    integral sum_q |Pplus_q|^2 < .002,
    integral sum_q |Pstar_q|^2 < 10000,
    integral_Iq |Pstar_q|^2 <= Sq,
    sum_q 2Dq*Tq < .025,
    sum_q Tq*Sq < 2.5e-8,
    max_q phi(q) <= 300000,
    sqrt(sum_q 2Dq*phi(q)^2) <= 180000000000.

The star bound Sq includes the factor 49 from delta/49. The five terms of (5) are consequently bounded in L2 by

    .00016,
    55000*d0,
    25*dstar,
    87*dstar,
    180000000000*d0*dstar,

respectively. For the first term, square its norm and use `sum_q Tq*integral_Iq |Pstar_q|^2 <= sum_q Tq*Sq`. The other four follow from phi(q)<=300000 and the displayed integrals. This retains the q-dependent arc restriction and all Gauss weights. No all-modulus Cauchy bound replaces the first same-q sum.

At the existing d0=2e-15,dstar=2e-12, their last four terms sum to

    4175009/12500000000000000 < 1e-9.

Thus the full mixed remainder norm is <.000160001. Combining with the already derived finite-low tensor norm <.0005 gives

    Cross_coprime < (.0005+.00016+4175009/12500000000000000)^2
                  < 4.357e-7.

This proves the transfer of the existing numerical ledger, conditionally on its finite-low and scalar inputs. It does not reprove their numerical certificates. In particular this is a genuine product-space estimate, not an inference of a fourth moment from ordinary second moments. Together with the separate actual Astar<2.5e-7 input it preserves Astar+Cross<9.5e-7. The later coprime-to-full transfer remains a different step.

## 7. Remaining proof tasks and why this is one new join

The previously pinned base-gap ledger already derived the pointwise limit step. The provider note already derived inverse-character reflection and local-order transport. Those results were checked here rather than proposed as new work. The new integrated transfer is Sections 5-6, based on the exact stabilization and signs in Sections 2-4. It replaces the common-height report's unexpanded absolute-convergence sentence by a finite-carrier argument valid for the actual source limits.

For a Lean implementation the remaining local tasks are: filtered-carrier stabilization via `divB_eq_of_mem`; application of the existing explicit-formula `Tendsto` to (2); actual residual/finite-Mellin continuity; the elementary measurable radial split (4); and the finite tensor norm/Minkowski calculation (5). No global infinite-zero sum needs to be defined. The old `zero_sum_boundG`, `norm_SsumG_le_gen` and zeta analogue cannot be applied unchanged because their finite-RH binder is stronger than .555.

The substantive unclosed inputs remain the actual finite spectral certificates, validation of the global provider, the selected smoothing admissibility and Mellin/Gram bounds, and formal replay of the scalar major bounds. This note neither assumes those conclusions proved nor changes the unconditional final theorem into a conditional one. All estimates are pointwise in x>=4.9e26, y=x/49; endpoint bounds on decreasing positive envelopes do not assert monotonicity of oscillatory zero sums.

## Source pins

Paths in the first table are relative to `work/ternary-goldbach/TernaryGoldbach/`.

| Source | SHA256 |
| --- | --- |
| Explicit/ExplicitFormula.lean | `8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35` |
| Explicit/Datum.lean | `42F14B373106D5508F73080BEC1E57992FDCBCB7A0460182AD396534463ACDDE` |
| Explicit/ZeroSumGen.lean | `9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389` |
| Explicit/ZeroSums.lean | `3E5CD828CC6ADD2AF6D17F03F97E65F15720AEAF907826847EF191DEA8BCB72D` |
| Explicit/ZetaExplicit.lean | `A2252356B4A2FCE4BC0B2B0EFF9A26B43DFAEBA9B05DB94BFEAA444A423B94E2` |
| Explicit/ZetaZeroSums.lean | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| Explicit/WeilBridge.lean | `285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E` |
| MinorArcs/Bombieri.lean | `F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79` |
| MajorArcs/ArcChars.lean | `0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF` |
| Helfgott/Decay.lean | `55764C16ACFB4CD3C94C23F581AA77EDC3B774C6A87ED384C67FC553D6288D8A` |
| MinorArcs/BaseGap2.lean | `AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E` |

Existing research inputs, relative to `work/qrh-campaign/agents/`:

| Note | SHA256 |
| --- | --- |
| major-constants/RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md | `79833F8D5D5856E000A96D3F5CCA9FC9E26CB3BAF637CDE089FEFDD703436BA7` |
| integration/PROVIDER_COMPATIBILITY_CUT_2026-11-11.md | `4F2209C5D0D7F861426E5469A37B878CC4920756276F177C69D3C21D99E6F78C` |
| integration/RESUME_BASE_GAP_INTERFACE_LEDGER_2026-11-11.md | `43C2090F15C68D177618D1A7E65119DCE9F0BEC631214D1DB3962FB55FE75701` |
| independent-feasibility/RESUME_HYBRID_CERTIFICATE_2026-11-11.md | `D9D4807F8465EBDA115F0675F4A9EE4DBFF30EED85719AADA963B5F2C0E49B2F` |
| mellin/CURRENT_CONSUMER_OBLIGATION_FRONTIER_2026-11-11.md | `517D24E49F9F2DD8AA4E339C6EEF440070937FD94D2C9EB5ADE366A89604FF5B` |
