# A pointwise nonprincipal aggregate for the R132900 base gap

2026-11-11. Source/paper research and exact rational budget checks only. No prime sum, character value, zero, integral or transform was evaluated. No Lean build or source change occurred.

There is a precise aggregate substitute for the nonprincipal character estimates in the base gap. A uniform Gauss-weighted coprime energy bound of169/1000000, together with the retained principal estimate, preserves the current intermediate bound below.014. If one targets only the actual MinorTotal consumer,841/1000000 suffices instead. Both are new unproved pointwise requirements. The inspected generic and integrated source estimates do not establish either without restoring the nonprincipal finite-RH input.

This report complements the direct etaPlus residual-energy target. It does not replace that target, the major-star/mixed estimates, J upper, off-gap minor-arc inputs, or the principal spectrum.

## 1. Actual consumer and full parameter domain

Put R=132900, x>=4.9e26 and y=x/49>=10^25. The needed implication is

    alpha in majorArcs 8 R y, alpha not in majorArcs 8 R x
       implies |S etaStar x alpha| <= y*ghatY(y,R).        (1)

The source `MinorTotal.lean:395–403` uses exactly this kind of implication at its hardcoded150000; the original `.0121*y` theorem is merely one sufficient input. The reviewed natural-R source-mass route retains ghatY(y,R)>.03 and checks the stronger base-gap guard<.014. The old scalar gap upper is not multiplied into the final minor budget: its role is to justify the same ghat envelope. Below we give both a guard-preserving target and the weaker direct-consumer target, without claiming the latter preserves the old `.014` predicate.

Retain the parity information in `BaseGap2.gap_point:185–227`. The selected original denominator m and unit numerator a obey:

    m odd: 1<=m<=R,       4R/(49m)<=|d|<4R/m;
    m even: 2<=m<=2R,     8R/(49m)<=|d|<8R/m;
    alpha=a/m+d/y modulo integers.

The lower distance is closed and the upper distance is open. The reduced denominator for2alpha is q=m/gcd(m,2), so q<=R. This q is not the modulus m of the character expansion. Equivalently 8R/49<=2q|d|<8R. The aggregate conditions below hold for every y>=10^25 and every d in these two signed ranges, not only at grid points or for a selected rational numerator. They therefore cover any rational selected by the major-arc membership argument. Uniformity in the unbounded y parameter is part of the obligation.

Define actual coefficients b_y(n)=Lambda(n)*etaU(n/y), viewed in C, and b'_m=coprimePart(m,b_y). `BaseGap2.S_etaStar_eq_expTsum:229` gives exactly S etaStar x alpha=expTsum b_y alpha. There is no additional49 factor and no replacement of d by d/49. The source supplies absolute summability and

    D_m(y):=sum_n |b_y(n)-b'_m(n)|/y <= d0:=2e-9          (2)

for m<=300000, y>=10^25, by `sum_noncoprime_le:38` and its ceiling/log specialization at the end of the base-gap proof. Thus the smaller current domain is covered.

## 2. Exact coprime aggregate and dimension loss

For each ambient character psi modulo m write

    w_psi=|gaussSum psi stdAddChar|,
    r_psi(y,d)=Schar(psi^-1,b'_m,d/y)/y,
    E_U,m(y,d)=(1/phi(m))*sum_(psi!=1) w_psi^2 |r_psi|^2. (3)

The principal ambient character is excluded exactly. The primitive ancestor in a source adapter is `(psi^-1).primitiveCharacter`. All inverse labels are retained. Define Dnp_m as the number of nonprincipal ambient characters with w_psi>0; this finite count is at most phi(m)-1.

The exact character identity in `BaseGap.totient_mul_norm_le:19–42` has unit phases psi(a^-1). Its nonprincipal part therefore satisfies

    |(1/phi(m))*sum_(psi!=1) psi(a^-1)*tau_psi*r_psi|
       <=sqrt(Dnp_m/phi(m))*sqrt(E_U,m) <=sqrt(E_U,m).     (4)

Indeed Cauchy--Schwarz on the Dnp_m terms gives squared norm at most Dnp_m/phi(m)^2 times sum w_psi^2|r_psi|^2. This proves the normalization and pays the dimension. Zero-Gauss terms require no residual estimate.

There is also an exact interpretation of (3). Remove the principal term from each coprime additive sum at a/m+d/y, divide by y, and call the resulting finite unit-numerator function R_m(a). Orthogonality gives

    sum_(a unit modulo m) |R_m(a)|^2 = E_U,m.             (5)

This follows by expanding the two finite character sums; distinct characters have zero inner product on units and each character has squared norm phi(m). It is the same character orthogonality used by `Bombieri.parseval_chars:26` and the source additive identity. In particular (3) is a SUM over unit numerators, not their average. Replacing it by a normalized average requires multiplying by phi(m) before applying a supremum bound. It is also pointwise in d, not an integral over d.

The sharper Dnp_m/phi(m) factor can be retained in a modulus-dependent certificate. The uniform target here safely drops it. At m=1 or2 there are no nonprincipal characters and (3) is zero; these moduli still require the principal piece below.

## 3. Principal piece and exact sufficient budgets

Let F(d)=Fourier(etaU)(-d), and let e1(y,d) bound the unrestricted principal residual

    |Schar(1 mod1,b_y,d/y)/y-F(d)|.

Keep the principal-only sufficient estimate e1<2e-6 on the full domain. The existing source derives the sharper `1e-17+4.7e6/sqrt(y)` from the principal GRHUpTo input through10^8: `Cor713.err933Z_le:774`, followed by the q=1 branch of `cor_7_1_3':807–835` and `Cor933.cor_9_3_3:490`. Its blanket wrapper has a PlattGRH binder, so using it here requires the already planned localization to the principal input. This report does not call that wrapper without its premise or certify the principal spectrum. The needed twist condition is satisfied since |d|<4R<1.2e6.

The coprime principal residual differs by at most d0. The principal Gauss norm is |mu(m)|, which can be zero. Splitting the outer noncoprime part once and using (4) gives

    |S etaStar x alpha|/y
       <= d0 + |mu(m)|/phi(m)*(|F(d)|+e1+d0)
                    +sqrt(Dnp_m/phi(m))*sqrt(E_U,m).     (6)

No `(1+W_m)d0` is needed for the nonprincipal part in (6), because (3) already uses the exact coprime coefficients. Applying a primitive unrestricted estimate instead needs the extra removals in section4.

For completeness the following main-term improvement is purely source/elementary, already derived in the earlier base-gap work. `MajorTotal.norm_fourier_etaUC_le:475` gives |F|<=1.2534, and `EtaU.norm_fourier_etaU_le:52` with `BaseGap2.fourier_const_le:168` gives d^2|F|<=1.016. Hence |d F(d)|<1.129, since1.2534*1.016<1.129^2. For m<=265800<300000,

    m/phi(m) <=30030/5760.

This does not need the Platt-dependent global totient wrapper. The elementary proof uses `MertensProduct.div_totient_eq_prod:2129` and `exch:2156`: seven distinct prime factors would have product at least510510, while at most six factors maximize the decreasing p/(p-1) product at2,3,5,7,11,13. The prior base-gap report/review supplies this finite comparison; no new prime evaluation was performed.

The weaker of the parity lower bounds then yields, including the absolute Mobius factor,

    |mu(m)|*|F(d)|/phi(m)
       < (30030/5760)*1.129*49/(4R)
       =55376321/102067200000 <.000544.                  (7)

Also |mu(m)|/phi(m)<=1. Thus the following two complete uniform sufficient conditions follow from (6):

| Nonprincipal energy bound, every allowed m,y,d | Resulting upper for |S|/y | Consumption |
|---|---|---|
| E_U,m<=169/1000000=(.013)^2 | .013546004 | below current .014 guard |
| E_U,m<=841/1000000=(.029)^2 | .029546004 | below .03<ghatY(y,R) |

The bound consists of .000544 for the Fourier main term,2e-6 for the retained principal residual,4e-9 for outer and principal removals, and the displayed nonprincipal square root. It uses all signs of d and includes the lower boundary of the gap. The existing source-mass scalar lower envelope is435635673/13700000000>.03. Its natural-R formal adapter remains part of the previously identified implementation work.

## 4. Conductor-only and unrestricted alternatives

`Bombieri.norm_sq_gaussSum:135` gives w_psi^2=c precisely when c=cond(psi), m/c is squarefree and coprime to c; otherwise it is zero. The source character manifest gives the primitive/changeLevel bijection, including imprimitive ambient characters. Thus (3) can be written exactly as

    (1/phi(m))*sum_(c>1, c|m, squarefree(m/c), gcd(c,m/c)=1)
            c * sum_(chi primitive mod c)
                 |Schar(chi,b'_m,d/y)/y|^2.              (8)

Inversion merely permutes the primitive labels. The inner quantity in (8) still depends on m through b'_m. A conductor-only array of unrestricted sums is a different object and must not be substituted without the correction below.

Put f_chi=Schar(chi,b_y,d/y)/y and A_c=sum_(chi primitive mod c)|f_chi|^2. The direct weighted-l1 alternative is

    L_m=(1/phi(m))*sum_(supported c>1) sqrt(c)
                                       *sum_chi |f_chi|. (9)

It implies

    |S|/y <= main + (|mu(m)|/phi(m))*e1
                          + L_m +(1+W_m)d0,
    W_m=(sum_psi w_psi)/phi(m).                          (10)

Each removed inner character sum costs at most d0 by norm summability; the extra outer removal remains. Exact Parseval applied to the unit-modulus additive character gives sum_psi w_psi^2=phi(m)^2. Therefore W_m<=sqrt(phi(m))<=sqrt(q)<365 on this domain. The equality of squared Gauss mass is also equivalent to the supported-conductor identity sum_c c*n(c)=phi(m)^2. No conductor has been skipped because its positive weight is small.

Two useful sufficient bounds for (9) are

    L_m <= (1/phi(m))*sum_(supported c>1) sqrt(c*n(c)*A_c),
    L_m <= sqrt(1-mu(m)^2/phi(m)^2)
                              *sqrt(sum_(supported c>1) A_c). (11)

The first is character Cauchy--Schwarz within each conductor; the second is Cauchy--Schwarz over all supported primitive labels and the exact Gauss mass after excluding the principal. Thus either L_m<=.013, or the simple unweighted condition sum_supported A_c<=.013^2, preserves the .014 guard. Its resulting bound is .013546732. Replacing .013 by .029 gives .029546732<.03 for the direct consumer. These alternatives account for both removals and are independent of the m-dependent coprime definition in (8).

If data supply only a mean square per character, dimension reappears: with A_c<=n(c)*epsilon^2, (11) only gives L_m<=sqrt(sum_supported n(c))*epsilon. A common per-character error bound can instead use W_m*epsilon, again as large as roughly sqrt(phi(m))*epsilon. There is no dimension-free implication from a small normalized character average. A global sum over all4351723951 nonprincipal labels would suffice by positivity, but would be much stronger than the per-modulus supported-divisor conditions; it is not the intended cheapest certificate.

There is a weighted-energy conversion too. For unrestricted Efull_m=(1/phi(m))*sum_supported c*A_c, finite Minkowski and the removal estimate give

    sqrt(E_U,m) <=sqrt(Efull_m)+d0*sqrt(phi(m)).           (12)

The full weighted coefficient mass was used to overbound the nonprincipal mass. Equation(12), not equality of the two energies, is the permitted conversion. It is uniform but does not itself prove either energy is small.

## 5. What the source does and does not establish

With the original nonprincipal finite-RH assumptions retained, `PartIICited.cor_7_1_3:45` gives

    |f_chi| <=1e-17+4.7e6/(sqrt(c)*sqrt(y)).

Using its actual conductor dependence in (9) is stronger than taking a uniform maximum. If Dnp_m is the supported nonprincipal label count,

    L_m <=1e-17*W_m + (4.7e6/sqrt(y))*Dnp_m/phi(m)
         <1.5e-6,

since Dnp_m<=phi(m), W_m<365 and sqrt(y)>=3.16e12. Thus existing conditional source estimates easily meet the new target. This is not an aggregate replacement for finite RH: the theorem explicitly obtains those estimates from that spectral premise. Reusing it for the nonprincipal part would restore the obligation being removed.

Without that premise, the inspected source supplies the exact finite identities, smoothing estimates, removals and large-sieve/Gram machinery, but not the required uniform pointwise energy. The unconditional trivial `MinorTotal.norm_S_etaStar_le_uniform:49` is22.75*y, far above the consumer. Positivity of etaU, norm domination and that trivial bound only give E_U,m<=phi(m)*22.75^2, which does not approach the thresholds. Integrated second/fourth moments do not imply a supremum in d without a proved additional localization/derivative argument. Averaging over moduli or characters similarly cannot discard a bad individual supported modulus.

The earlier QRH/weighted-certificate reports already identify the related absolute-zero-sum obstruction. We do not rerun that argument or claim that global beta<=7/8 forces (3), (9) or (11). A small count, an entire conductor product, or cancellation of an unweighted character sum does not establish these nonnegative actual-prime energies. Conversely failure of those upper-bound methods is not a lower bound on the actual energy or a proof that the new targets are false.

The concrete open join is now narrow: prove a uniform actual etaU coprime residual-energy estimate (3) on the full stated continuum, or a sufficient supported-conductor estimate (9)/(11), without the nonprincipal finite-RH theorem. This is separate from major_constants' etaPlus energy7.02e-13 and from its other major-arc requirements. Principal finite-RH and its localization remain explicit inputs here. No statement about zeros, their simplicity or omitted central/real zeros is hidden in (3); any later explicit-formula proof must retain the actual multiplicities and boundary conventions of its source.

## 6. Evidence and source pins

The exact scalar script checks only the main/residual/removal allocations and the retained rational ghat lower envelope. It proves no actual energy bound. It exited with `PASS_EXACT_AGGREGATE_BASE_GAP_BUDGET`.

Paths in the first table are relative to `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
| integration/BASE_GAP_ACTUAL_SOURCE_JOIN_2026-11-11.md | F0BC1D7899044C27E819743BBA4B157D51F42848B87A51D37764CDB8B3B6C9E0 |
| audit/REVIEW_BASE_GAP_ACTUAL_SOURCE_JOIN_2026-11-11.md | 0344BEB11D9006FC28BE76EE8ED2CD63AC3050B8E3217697F9C7FCD161351DAE |
| prime-estimates/EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md | 429562CD92AF356BD84EED1C253D0A9E95D434262DF08CCCAC8EAF3D15CE234D |
| zero-sum/aggregate_base_gap_scalar_20261111.py | C0B1B6DE9CC81078C8B28F0951E242230AABAB27C33BE4DB8C9187F452512E25 |
| zero-sum/aggregate_base_gap_scalar_20261111.json | 9294FFC92906A64457909CAF8610288FC6BEBF8A6649A8C2848D80827B8CB263 |

Direct source reads, relative to `work/ternary-goldbach/TernaryGoldbach`:

| Source | SHA256 |
|---|---|
| MinorArcs/BaseGap.lean | ABF8667E1A8D5C72AA81F1B3F40481933A1ABC5A1CE3FAA0BE9705AC8CAF418B |
| MinorArcs/BaseGap2.lean | AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E |
| MinorArcs/Bombieri.lean | F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79 |
| MinorArcs/MinorTotal.lean | 6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742 |
| MajorArcs/MajorTotal.lean | 106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A |
| MajorArcs/Cor713.lean | 11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433 |
| Prelim/MertensProduct.lean | 8182DC2B990DC8D65AC76D3CC55847B26922E2062CD154C14367D5DB97F71A0F |

The prior `BASE_GAP_QRH`, `RESUME_BASE_GAP_FINITE_FAMILY`, `RESUME_WEIGHTED_CERTIFICATE` and `BASE_GAP_ALTERNATIVES` were consulted to avoid recycling their unsuccessful no-spectrum deductions or mistaking their older .01398 target for the current consumer. Their proposed spectra and alternative Type I/II branches are not premises of the aggregate implication above.
