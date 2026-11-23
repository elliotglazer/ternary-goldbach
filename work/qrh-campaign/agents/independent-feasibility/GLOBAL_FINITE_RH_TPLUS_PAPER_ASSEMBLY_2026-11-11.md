# A common finite-RH profile for the R132900 proof route

2026-11-11. Conditional paper assembly, **pending independent review**. The component authors and independent reviews are pinned below. This note joins their mathematical implications; it supplies no finite-RH certificate, numerical zero evidence, compiled theorem, or final axiom closure. Existing frozen files are unchanged.

The single nonprincipal requirement below suffices for the three inspected consumers: plus energy, the full mixed Wstar moment, and the actual base-gap envelope. It therefore defines a conservative computational comparator for the R132900 route. It does not establish that this comparator is cheaper than another route. Principal RH through 1e8, separate exact head data, finite arithmetic inputs and finite Goldbach coverage remain.

## 1. Common certificate and its domain

Fix R=132900, x>=4.9e26, and y=x/49>=1e25. For positive c put

    qt(c)=2c for odd c, and c for even c,
    Dc=8R/qt(c)=1063200/qt(c),
    uc=19.89 for even c>60000, and 23.3 otherwise,
    Tplus(c)=ceil(200+max(260,uc*3.1416*Dc)).

Every decimal in this definition denotes its exact rational value. Require `GRHUpTo chi Tplus(c)` for every primitive nonprincipal character of odd conductor 1<c<=R or conductor 4|c<=2R. This is the actual source predicate: every zero rho of chi.LFunction with 0<Re(rho)<1 and |Im(rho)|<=Tplus(c) has Re(rho)=1/2. It includes both signs, real nontrivial zeros, and the closed height boundary. It neither assumes simplicity nor enumerates a complete list of zeros.

The plus theorem is stated for every even conductor through 2R. The apparent difference is empty: if c=2d with d odd, reduction of units modulo 2d to units modulo d is an isomorphism by CRT. Every character factors through the proper divisor d, so none is primitive. This includes c=2,d=1. This algebraic exclusion must be implemented if the certificate enumerates only 4|c; it is not a numerical omission. Conductor 1 is handled separately by the retained principal requirement. Inversion preserves conductor and permutes the included primitive characters.

For an ambient character modulus q with qt(q)<=2R, its primitive conductor c divides q. If c is even, q is even and qt(c)=c<=q=qt(q). If c is odd and q odd, 2c<=2q; if c is odd and q even, the integer q/c is even, so 2c<=q. Thus qt(c)<=qt(q), and every inducing conductor and inverse label lies in the common domain. The same reasoning applies to the original base-gap modulus m. It does not replace m by the denominator obtained after doubling the phase.

## 2. Exact height dominance, including ceilings

The reviewed base-gap theorem requires

    Hbase(c)=ceil(27000000/c) for odd c,
             ceil(54000000/c) for 4|c.

Its unrounded expression is `(27000000/531600)*Dc` in both cases. Write zc=200+max(260,uc*3.1416*Dc). Since uc>=19.89, 3.1416>3, and

    19.89*3*531600 = 31720572 > 27000000,

we have zc>(27000000/531600)*Dc. Monotonicity of integer ceiling gives Hbase(c)<=Tplus(c). There is no extra ceiling unit to pay: both required heights are ceilings of the compared reals. The even exception at 60000 is covered by the smaller coefficient 19.89 throughout this argument.

The reviewed star requirement is

    Hstar(c)=ceil(max(300,(704/343)*Dc)).

We have zc>=460>300, and 19.89*3>704/343, hence zc>(704/343)*Dc. Therefore Hstar(c)<=Tplus(c), with the same closed-height convention. In particular

    max(Tplus(c),Hbase(c),Hstar(c))=Tplus(c).

This is a union of *properties* as well as heights. Restriction of ordinary finite RH gives beta=1/2 at both smaller cutoffs. It therefore supplies the star bounds beta<=.5075 at squarefree c and beta<=.62 at nonsquarefree c. A taller certificate proving only .62 would not supply the plus or base-gap RH premise.

The source `GRHUpTo.mono` is exactly the needed restriction map. A complete finite carrier with true analytic orders is still used in the star proof; a partial list of sign changes is not substituted for it. No exact-list assertion is inferred from the common RH predicate.

For comparison only, the reviewed plus proof establishes Tplus(c)<Hold(c), where Hold is 1e8/c for odd c and max(1e8/c,200+7.5e7/c) for even c. Its ceiling-safe inequalities separate odd c<=R, even c<=60000, 60000<c<=125000, and c>125000. All hold on closed ranges with a full unit of overshoot. This fact controls a positive low-zero *bound function*, not an assumed RH interval between Tplus and Hold. The new tails were independently re-estimated. Tplus has minimum 460; conductor 4 is included and has Tplus(4)=19456569. The star maximum is Hstar(4)=545549, not the old erroneous 363700 prose bound.

## 3. Plus: the original bound supplies the relaxed integrated hypotheses

The reviewed explicit-height Prop942/Thm714 proof gives, uniformly in the unbounded scale x>=4.9e26 and |delta|<=Dc,

    |Schar chi (Lambda*etaPlus(./x)) (delta/x)|/x
        <=(7.5e-8+7.7e6/sqrt(x))/sqrt(c).

It retains E0/x, E1/sqrt(x), E2 and the vertical term. E1 is compared monotonically with its old explicit numerical bound; E2 is recomputed at the new height. Full-strip tails, rather than global QRH, handle higher zeros.

Primitive induction, |tau_q(psi)|<=sqrt(c), and the source coprime removal give the actual inverse-character coefficients the bound 4.25e-7*x. Consequently the exact energy

    Eplus_q=(1/(phi(q)*x^2))*sum_(psi!=1)
       |tau_q(psi)|^2 |Schar(psi^-1,coprimePart(q,cP(x)),delta/x)|^2
        <=(4.25e-7)^2=1.80625e-13<7.02e-13.

This counts all nonprincipal ambient labels, including imprimitive labels and zero Gauss coefficients; no squarefree restriction is imposed here. Character Parseval gives a sum over unit numerators, not an average over them. The retained principal error is 2.83e-7*x, and the outer removal is 1e-15*x. The independently reviewed direct-plus conversion thus supplies

    sum_(b in Bset(q)) |Sp-Ap|^2 <=(rho*x)^2,
    rho=8.85e-7,
    Sp=S etaPlus x (b/q+beta),
    Ap=(mu(q)/phi(q))*Fourier(etaPC)(-beta*x)*x,
    |beta*x|<=8R/qt(q).

Its stronger intermediate bound is 7.83e-13*x^2<rho^2*x^2. The original smaller plus estimate could also be retained; using the relaxed interface makes the joins explicit.

On the actual finite tagged arc space, let Z=integral|Sp-Ap|^2, X=integral|Sp|^2, Yp=integral|Ap|^2. Here these are physical integrals, so

    Z/x<.006^2, Yp/x<=a=.640208*13.59756<2.951^2,
    X/x<2.957^2=8.743849<j=8.79.

The Z estimate integrates the already-summed residual: 16R*rho^2*sum_q(1/qt(q)) with the last sum<=19. There is no extra phi(q). These are precisely the normalized plus premises used by the weighted-principal Wstar budget.

## 4. Star: restriction to Hstar and the full mixed moment

For the star calculation choose its own complete closed carrier through Hstar, even though the common certificate extends farther. At |d|<=Dc/49 its reviewed full-strip Gaussian tail is <5e-15. With the zero-at-zero/vertical contribution and primitive-to-coprime removal, its complete per-character remainder is <2e-12. The weighted remainder norms are TA<8e-9 and TB<.00048. Keeping this smaller carrier is essential to reuse the reviewed count metadata; silently enlarging it to Tplus would require new count bounds.

The exact finite weights are omegaA(c)=sum_eligible_q mu(q)^2*c/phi(q)^3 and the separate B weights from the reviewed statistic. Nonsquarefree c has omegaA(c)=0; it is still present in B and in every other consumer. The floor300 analytic-count metadata bounds the line comparison by

    QAline<2.321e-19, QBline<1.753e-12.

These are upper comparisons from analytic counts and finite arithmetic, not numerical zero counts or location evidence. Ordinary RH supplies the stronger line location. For direct reuse of the mixed-profile proof it is sufficient to weaken to QA<=(12/5)QAline and QB<=1e6*QBline. The reviewed Gram constant G=7e6 and remainder norms then give

    sqrt(A)<=sqrt(G*QA)+TA<2e-6,
    sqrt(B)<=sqrt(G*QB)+TB<6.48,
    A<4e-12, B<42<62.

The coefficient powers are bounded at y=1e25 and decrease for all larger y; no finite upper scale is inserted. Central zeros and multiplicities remain in the count/Gram carrier. High zeros use only 0<beta<1 and the full-strip tail.

Now let Ss be the actual full star prime sum and As=(mu(q)/phi(q))*Fourier(etaUC)(-beta*y)*y. The weighted-principal allocation, using the plus bounds in section 3 and the retained principal estimate, proves

    Wstar=integral |Sp|^2 |Ss-As|^2,
    sqrt(49^2*Wstar/x^3)
        <1.902e-6+sqrt(A)+8.85e-7*sqrt(B).

The 1.902e-6 is already an integrated principal norm; multiplying it by sqrt(j) again would be incorrect. All principal, removal and cross terms are paid by this formula. Its reviewed A4e-12/B62 row gives 49^2*Wstar/x^3<=j*(3.67e-6)^2. This is the full mixed moment, not a bound only on a primitive residual or separate unweighted energies.

The same plus residual gives Wplus=integral|As|^2|Sp-Ap|^2 and

    49^2*Wplus/x^3<=49*rho^2*(7.78*2.85).

The exact cubic identity and Cauchy--Schwarz yield error <=sqrt(X*Wstar)+(sqrt(X)+sqrt(Yp))*sqrt(Wplus). The integrated-cubic contract bounds this by precisely the old cubic allowance after normalization by x^2/49. The Fourier-tail allowance is added unchanged. Physical periodic arc partition, integer N, integrability and singular-series/main-term bounds are retained; tagged integration alone does not establish them.

## 5. Base gap: retain the original modulus and reach ghat directly

For every y>=1e25 the original modulus m and signed displacement satisfy

    odd m<=R:   4R/(49m)<=|d|<4R/m,
    even m<=2R: 8R/(49m)<=|d|<8R/m.

The actual sum is Lambda(n)etaU(n/y) with phase d/y. There is no additional factor49 in its error normalization. The primitive-conductor argument of section 1 gives |d|<=Dc. The common certificate restricts to Hbase, and the reviewed Cor933 calculation gives sqrt(c)*err933New<.02357<.024 uniformly in y. The high-zero term is recomputed on the full strip; comparisons at 1e8/c concern only explicit numerical bound functions.

After the exact Gauss square cancels 1/c, Efull_m<=.024^2. Coprime restriction costs at most d0=2e-9 per normalized character coefficient. Since sum_psi|tau_psi|^2=phi(m)^2, vector Minkowski gives

    sqrt(E_U,m)<=.024+d0*sqrt(phi(m))<=.024001032<.029.

The separate principal residual, Fourier main term and outer/principal removals then give the actual pointwise bound

    |S etaStar x alpha|/y
        <.024001032+.000544+.000002+.000000004
        =.024547036<.03<ghatY(y,R).

The cases m=1,2 have empty nonprincipal energy but still consume the principal estimates. Both signs and the closed lower gap boundary are included. The source MinorTotal:395--403 requires ghat, so this is sufficient. It does not establish the older .014 or .0121 intermediate guard; those wrappers must be bypassed as in the reviewed aggregate consumer map.

## 6. Retained R132900 joint budget and the proof work still required

The accepted source-mass route gives M_R>=3367437830196638879/250000000000000000 from the existing c_132 checkpoint and monotonicity. The lower major energy uses the principal Parseval projection, not a nonprincipal upper bound. It gives J_R/x>=.638108*M_R-.00108, followed by

    I_R/x>=(J_R/x-100001*8e-11)/1.00001.

This retains the nine minor scale cells, asymptotic branch, singular-series loss22.1/R, major Fourier tails, coefficient/nonprime errors and all unbounded higher-level arithmetic domains. The new plus and Wstar implications spend no additional cubic allowance, and section 5 proves the actual ghat premise. Thus the same joint major-minus-minor-minus-nonprime coefficient remains

    17454234627055702473150105611895106422794893597
    /12867056213564954145112500000000000000000000000000
      >.0013565.

This is the inherited conditional scalar margin, not an evaluated representation count. The joint budget does not require the old separately rounded minor constant1.0376. It retains N0=989*10^24 and the exact xOf(N) relation ensuring x>4.9e26. Its restriction recovers the large-N target at 1e27; the finite branch and overlap are unchanged.

The inspected all-consumer map accounts for the nonprincipal calls: explicit-profile plus replaces the old Thm714 odd/even wrappers, the mixed moment replaces the nonprincipal pointwise-star use, and the direct ghat argument replaces the nonprincipal Cor713/base-gap wrapper. Lower J is extracted from its principal-only proof. Calling any old bundled theorem under blanket `Fact PlattGRH` would retain unwanted assumptions. These are required source refactors, not completed declarations.

Principal RH through closed height1e8 is unchanged, including its Chebyshev/Mertens and other uniform arithmetic descendants. Separate exact head counts, reciprocal moments and finite source constants remain at their existing proof status; a finite-RH predicate does not certify their numerical values. The original inclusive BinaryGoldbachInput through4e18 and its finite ladder/coverage obligations are not replaced by a speculative cheaper scheme. No global QRH provider is used.

The comparator's nonprincipal spectral target is therefore Tplus on the stated primitive domain, counted once across the three consumers. An implementation must additionally cost and certify all Turing guard intervals, sample/interpolation domains, rounding, count endpoints and exceptional cases. This note supplies none of those numerical certificates and makes no runtime or zero-count forecast. Formalization of the analytic components, exact metadata/source constants, localizers and final standard-axioms closure remains open. Independent review of this assembly, and the coordinator's reconciliation of its component reviews, are pending.

## Evidence binding

The manifest below binds the component statements and reviews, the consumer chain, and selected actual source interfaces. It is generated from read-only SHA256 checks of the named files. Component receipts remain the evidence for their scalar and metadata calculations; no old writer was rerun. This assembly adds only the displayed rational dominance and implication checks.


| File | SHA256 |
|---|---|
| `work/qrh-campaign/agents/major-constants/PLUS_FINITE_RH_HEIGHT_REDUCTION_2026-11-11.md` | `3F91F39B485607833A5FADD061BEC7602B1DCC02C77B8FB82CA10B6C076FA6A0` |
| `work/qrh-campaign/agents/audit/REVIEW_PLUS_FINITE_RH_HEIGHT_REDUCTION_2026-11-11.md` | `55690D3DE67252888EB84C29F40674CAA126E3C5B4E43F4D56CB3AD20421A4E9` |
| `work/qrh-campaign/agents/independent-feasibility/BASE_GAP_REDUCED_FINITE_RH_HEIGHT_2026-11-11.md` | `776CD34413ECC389D10CE510913C694C6D6C34E8555FFE0D66702582B3A23898` |
| `work/qrh-campaign/agents/integration/REVIEW_BASE_GAP_REDUCED_FINITE_RH_HEIGHT_2026-11-11.md` | `2E902497CE7445F78CEF7A2F229D0A9042FAF4FB573AB1A01B79D05331635076` |
| `work/qrh-campaign/agents/zero-sum/WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md` | `E1D58C8EC2EDB7FD8F3BF77F1D3833F3E400200D14AD30B396F59FA8CB5EE794` |
| `work/qrh-campaign/agents/moebius/REVIEW_WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md` | `422940369A04ED695A45EF28F20F154349932CEBC0242EEEE15FF3373D5CE6A4` |
| `work/qrh-campaign/agents/moebius/REVIEW_MIXED_CONDUCTOR_WSTAR_PROFILE_2026-11-11.md` | `8713202EA752207E7B0C5DC80FD6A68BD7A3A1FC5DF30E5F44BF9B1D252E30FD` |
| `work/qrh-campaign/agents/prime-estimates/REVIEW_WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md` | `52C3D991DE018E5B21682DD498819A5DDC66BDE484A43969DDB54026CE4E40D5` |
| `work/qrh-campaign/agents/major-constants/DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md` | `E69701B4AE8145B016015A2C355151DFAA5D4946D2281BAE3CC08A86422196B1` |
| `work/qrh-campaign/agents/prime-estimates/REVIEW_DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md` | `89DEB7CACE2D0AC4030C349D5E8E715C0B8DFFC69A7D33383D701DAB836F6B12` |
| `work/qrh-campaign/agents/audit/REVIEW_INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md` | `9F9A63CE08823181851D0C169039CD79AF00295C1B4666ED5B7D799F05946197` |
| `work/qrh-campaign/agents/audit/THREE_AGGREGATE_CONSUMER_SUFFICIENCY_AUDIT_2026-11-11.md` | `78119012C8BA40AFC93AB523B84DD441CD19D3FBC76F12418C41DD081B3C9F28` |
| `work/qrh-campaign/agents/moebius/REVIEW_THREE_AGGREGATE_CONSUMER_SUFFICIENCY_2026-11-11.md` | `4AD1F28880997030F9F5EF0ABACC637461203E50397964D1247A63D6651E65B5` |
| `work/qrh-campaign/agents/prime-estimates/EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md` | `429562CD92AF356BD84EED1C253D0A9E95D434262DF08CCCAC8EAF3D15CE234D` |
| `work/qrh-campaign/agents/major-constants/REVIEW_EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md` | `0B224BB58D88D63D9F787D88CA1CB33CA85C411DB8B733307064AE8D82EA84BD` |
| `work/qrh-blueprint/MIXED_CONDUCTOR_WSTAR_PROFILE_2026-11-11.md` | `42A5373CDA2DABBCC10722CBA8D2704A7D2E6DAFD601B94EC5F599856249BBA0` |
| `work/qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md` | `22A6A16880BE2FA5CB0FF393C533BD60B1AFCD32C751E5A0D64FE7ADAB7C40F7` |
| `work/qrh-blueprint/PLUS_RESIDUAL_TO_MAJOR_L2_UPPER_2026-11-11.md` | `F3EBC1B68CC57B607496D9E6445137A08A0F17C3202D986301F8EC25F14F4663` |
| `work/qrh-blueprint/INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md` | `943DE38EE628CFA9E7221100E75933D101C7593B613945F19B7CBDF90E97C128` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/GRH.lean` | `89C6DF8490955EEA8F4141498BCA6D163355C2E7765C9ECD09F8CEE5B257A070` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Prop942.lean` | `35B170971DBD0F1C6646CD86ECE8C3A86021085C1B07730141CD6311D9CA5716` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcChars.lean` | `0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap2.lean` | `AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/MinorTotal.lean` | `6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/MajorTotal.lean` | `106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A` |

The displayed dominance, energy conversions, root-allocation margin, base-gap sum and inherited joint-margin comparison were also checked by exact `Fraction` arithmetic in a read-only inline calculation. No analytic evaluator or metadata enumeration was used.
