# Actual base-gap source join

2026-11-11. Paper/source derivation against `work/ternary-goldbach` commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`, rechecked read-only. No Lean run, numerical evaluator, runtime probe, source edit or frozen-artifact change. This note is a conditional mathematical join, not a completed theorem or a new allowed root premise.

The recent actual-smoothing and finite-zero transfer arguments fill the analytic gaps identified by the old interface ledger. The remaining local assembly can be made exact: a support-only character estimate, the inclusive minimum-height restriction, and the existing three exceptional-denominator joins imply the bound actually needed in `MinorTotal`. No additional spectral margin, simplicity or cancellation assumption is needed for that implication. The required finite spectrum itself is still not supplied.

## 1. Exact endpoint and notation

Source paths in this note are relative to `work/ternary-goldbach/TernaryGoldbach/`. `MinorArcs/MinorTotal.lean:395–403` needs the following on the gap:

    x >= 4.9e26, y = x/49,
    alpha in majorArcs 8 150000 y,
    alpha not in majorArcs 8 150000 x
      implies ||S etaStar x alpha|| <= y * ghatY(y,150000).       (J)

Its current proof instead calls the Platt-dependent `BaseGap2.norm_S_etaStar_le_gap` (:240–245), with the stronger conclusion `.0121*y`, and then `ghatY_r0_ge` (:206). The proposed replacement is directly (J); the source theorem with `.0121` is not proved by it. The off-larger-arcs branch of `hv_of_split` is separate and remains dependent on its own Type I/II repairs.

Retain the information before weakening in `BaseGap2.gap_point:185–227`. It gives a positive original modulus m, an integer a coprime to m, and d=(alpha-a/m)y. For odd m<=150000,

    600000/(49m) <= |d| < 600000/m;

for even m<=300000, replace both numerators by 1200000. Put q=m/gcd(m,2), Delta=2d, u=q|Delta|. Then

    1<=q<=150000,  1200000/49<=u<1200000,
    |d|=u/(2q),  alpha=a/m+d/y.

Odd m gives q=m and numerator 2a for the reduced approximation to 2alpha. Even m gives q=m/2 and numerator a. Odd q permits m=q or 2q; even q permits only m=2q. Character expansion is at m, while the raw Type I/II approximation is at q. These are different objects.

`BaseGap2.S_etaStar_eq_expTsum:229` identifies the actual sum with coefficients

    b_n = (Lambda(n)*etaU(n/y) : Complex),
    S etaStar x alpha = expTsum b alpha.                       (S)

There is no additional factor 49 and no rescaling of alpha. `Decay.summable_etaStar:251` and the positive-argument identity `EtaU.etaStar_eq_etaU:26` give norm summability; handle n=0 by Lambda(0)=0. The old ledger's norm-summability concern is already corrected by its review: for complex sequences, `summable_norm_iff` also supplies the needed conversion.

## 2. Minimum height, with the complete support quantifier

For a chosen prefix 1200000/49<=U<=1200000 and u<=U define

    H = max(250, ceil(242U/(7q))),
    qt(c) = 2c if c is odd, and c otherwise,
    Hp(c) = ceil(200 + max(1000, (704/7)*(1200000/qt(c)))),
    Hcert(c) = min(Hp(c), 100000000/c).

The finite premise required here is: **every actual primitive character of each active conductor c**, and every actual nontrivial zero rho with |Im rho|<=Hcert(c), obeys Re rho<=111/200. Hcert is a rational minimum, not its ceiling. The active conductors are odd c<=150000 and multiples of four c<=300000, including c=1 with its zeta interpretation.

Fix any character psi modulo m with nonzero Gauss norm. Its primitive character chi=(psi inverse).primitiveCharacter has c=cond(psi)=cond(psi inverse), c|m and c>0. The character-manifest proof covers this **possibly imprimitive** psi; the word “primitive” before “character of an ambient modulus” in its section 5 is not a restriction of the quantifier. A conductor cannot have exact 2-adic valuation one: for odd d the unit reduction U(2d)->U(d) is an isomorphism, so every character at 2d factors through d. This follows either by CRT with U(2) trivial or by the reviewed local conductor formulas.

In fact qt(c)<=qt(m)=2q needs only c|m, not nonzero Gauss support. If both are odd or c is even it is immediate; if c is odd and m even, m/c is a positive even integer, hence 2c<=m. Consequently c is active and c<=2q. The two height comparisons are:

* Hp(c)>=200+422400000/(7q). Since ceil(z)<=z+1 and 242U/(7q)<=290400000/(7q), this dominates ceil(242U/(7q)); its floor 1200 dominates 250.
* The difference 50000000/q - 290400000/(7q) is 59600000/(7q), at least 59600000/1050000>1. Thus ceil(242U/(7q))<50000000/q. Also 250<50000000/q because q<=150000. Therefore H<50000000/q<=100000000/c.

It follows that **H<=Hcert(c)** without rounding Hcert. Also pi<22/7 gives 22*pi*|d|<=242U/(7q)<=H. All characters on the nonzero support, including inverse characters and c=1, therefore satisfy exactly the same low/high split and tail cutoff. No omission based on a small positive weight is allowed.

## 3. Actual etaU and inclusive finite zeros

For real d define f_d(t)=etaU(t)e(d*t) and M_d(s)=mellin(f_d)(s). The accepted actual-smoothing note proves continuity, absolute moments and the dominated-parameter differentiation/Fubini argument on Re(s)>-2, with

    M_d(s) = integral_[1/4,1] eta2(r) r^(s-1) Gr(s,d*r,0) dr.

This is the same r^s dr/r expression as the old ledger, not a change of normalization. `GMellin.norm_G_le_strip:86` on [-1/2,3/2], monotonicity of Kdelta in |d|, and `Eta2Moments.moment_3half:176` yield GoodSmoothing(f_d,3*Kdelta(d),.28). The reviewed simpler support bound 8*Kdelta(d) is equally sufficient. Neither qualitative constant replaces the quantitative left-line bound 900 or the high-zero tail budget.

The same actual moments give, by t^beta<=(1-beta)+beta*t and positivity,

    |M_d(s)| <= (1-beta)*4log(2)^2 + beta*sqrt(pi/2) < 13/8
       for 89/200<=beta=Re(s)<=111/200.                       (M)

The rational upper calculation is .555*1.922+.445*1.2534=1.624473<1.625. This estimate is uniform in real d and Im(s), not a critical-line statement.

For nonprincipal chi take f=chi.LFunction; for c=1 take f=zetaF, the entire pole-cancelled function. Define the low carrier by filtering `zerosRectD f (H+1)` to nontrivial zeros with |Im rho|<=H, with its actual `multRectD`. Every such actual zero is in that carrier: 0<Re rho<1 gives |rho-2|<2+H<(H+1)+3, and the ordinate bounds are strict at H+1. For any outer T>H the filtered carrier and its multiplicities agree. `Datum.mem_zerosIn_of_zeroD:169` supplies membership; `ExplicitFormula.divB_eq_of_mem:384` supplies divisor equality on the two containing balls. This is equality of actual multiplicities, not just distinct-root sets.

Apply the finite bound to chi and chi inverse. The local nonzero functional-equation factor at 0<Re rho<1 sends rho to 1-rho for chi inverse; its absolute ordinate and conductor are unchanged. This gives beta>=89/200. No same-character reflection or positive-height doubling is used. Multiplicity reflection is not needed for this inequality: the low carrier retains its original multiplicities and Jensen counts them. If explicitly transporting orders, use the reviewed local-factor/derivative-minus-one argument, then each point's own divisor ball.

One useful source-level specialization is still to package the off-line low count. Partition by floor(Im rho/3.48), not by a critical-line theorem. Each occupied interval's midpoint t has |t|<=H+1.74 and each root is within radius 3 of 2+it, since 2^2+1.74^2<9. Apply `ZeroSumGen.sum_multRectD_le:60` with radius 3 and the reviewed BP/BPz2 bound of 400 per window. There are at most 2H/3.48+2 windows. Hence the actual multiplicity sum is bounded by

    N(H)=ceil(400*(2H/3.48+2)).

The scalar bound 400 and its required height/conductor ranges are those already checked in the finite-family review; no new evaluation is asserted here. This specialization does not use `count_line_windowG`, its radius 2.3, or finite RH.

The accepted finite-zero transfer now applies pointwise: good heights eventually exceed H, the low sum stabilizes, and the high part has a bound independent of outer height. `explicit_formula_gen:988` and `ZetaExplicit.explicit_formula_zeta_seq:122` then give

    |SsumG chi f_d y - [c=1]*y*M_d(1)| / y
       <= E(y,H) := (13/8)*N(H)*y^(-89/200) + 3e-14.          (R)

Here 3e-14 is the already reviewed **base-twist** high-zero/vertical/zero0 allowance: |d|<=600000, global beta<=7/8, left-line decay>=4e-7 and bound900. It is not the smaller major-star twist interval. The nonprincipal zero at the complex number 0 is separated; real nontrivial zeros at ordinate 0 remain in the low carrier. The zeta formula subtracts its pole main term and has no zero0 term. Equality |Im rho|=H belongs to the low part, while the high part has strict H<|Im rho|. No measurable choice of good heights, infinite-series rearrangement or uniform-in-d limit is required for (R).

## 4. The missing weighted source wrapper, proved on paper

Here is the smallest reusable algebraic contract; it avoids asking for primitive estimates on zero-weight characters. For norm-summable complex coefficients b, put b'=coprimePart(m,b), and assume

    sum_n |b_n-b'_n| <= D,
    |Schar ((psi inverse).primitiveCharacter) b beta
       - [psi=1]*M| <= E_psi
       for every psi with w_psi:=|gaussSum psi stdAddChar|>0.

Assume each E_psi>=0 on that support, m>0, and the rational numerator is a unit mod m. Then

    |expTsum b (a/m+beta)|
      <= D + w_1*|M|/phi(m)
           + (1/phi(m))*sum_(w_psi>0) w_psi*(E_psi+D).       (W)

Proof: split b=b'+(b-b'); the outer remainder is <=D by unit modulus of e. `BaseGap.totient_mul_norm_le:19` bounds the coprime sum by the weighted character norms. `Schar_primitive:78` changes each coprime character to its inducing primitive character. `Schar_sub:64` and `norm_Schar_le:47` bound the inner removal by D. The residual hypothesis and triangle inequality give |Schar psi^-1 b' beta|<=[psi=1]|M|+E_psi+D. Terms with w_psi=0 vanish without applying that hypothesis. Sum and divide by the positive phi(m). Integer translates of a/m are handled by periodicity as in `BaseGap2:267–282`. This proves (W), including both removals, without the lossy sqrt(m) step of `norm_expTsum_le_of_chars:93`.

`Bombieri.norm_sq_gaussSum:135` gives w_psi=sqrt(c) exactly when m/c is squarefree and coprime to c, and zero otherwise. At psi=1 it gives w_1=|mu(m)|. The primitive-character/changeLevel bijection in the reviewed manifest therefore gives

    W_m := sum_psi w_psi/phi(m)
         = sum_(c|m, squarefree(m/c), gcd(c,m/c)=1)
                    a(c)*sqrt(c)/phi(m),

where a(c) counts all actual primitive characters, not sampled representatives. For odd q, no conductor with exact 2-adic valuation one contributes at m=2q; its supported odd conductors are exactly those at m=q. Adding the factor2 to m/c preserves the support conditions, phi(2q)=phi(q) and |mu(2q)|=|mu(q)|. Thus W_(2q)=W_q, including the principal coefficient. For even q use only m=2q. This proves the parity transfer used by the finite table.

Apply (W) with beta=d/y, M=y*M_d(1), E_psi=y*E(y,H), and D<=y*2e-9. Direct summand algebra gives Schar chi b (d/y)=SsumG chi f_d y. Also M_d(1)=Fourier(etaU)(-d); the plus sign in e(d*t) accounts for the minus Fourier argument. The result is precisely

    |S etaStar x alpha|/y
      <= |mu(m)|/phi(m)*min(1.2534, 1.016/dmin(q)^2)
           + W_m*(13/8)*N(H)*y^(-89/200)
           + W_m*3e-14 + (1+W_m)*2e-9,                    (B)

with dmin(q)=600000/(49q)>0. The Fourier bounds and removal estimate are unchanged source/paper inputs. Neither the squared Gauss weights from the mixed-major argument nor an extra factor49 appears in this pointwise bound.

## 5. Completion of the conditional join, and the actual remaining hole

Use U=1200000 for q>=4; the reviewed finite-family scalar certificate makes (B)<.044797<.04712<ghatY(y,150000) for every y>=1e25. For q=1,2,3 use the finite prefixes and raw high branches below; both conclude the same (J).

| q | Closed finite prefix upper U | Closed high-branch lower u |
|---:|---:|---:|
| 1 | 486477 | 190000 |
| 2 | 972954 | 300000 |
| 3 | 1068377 | 300000 |

All prefixes start at 1200000/49. These overlap strictly and cover the source's open upper endpoint 1200000. The high proofs keep their exact `Approx2` hypotheses at scale w*y, including q<=Q0 and the approximation error bound, and the original Type I/II producer constants. Their needed q/phi(q)<=2 for q=2,3 does not identify this ratio with 2q/phi(2q). Multiplying by y>0 and (S) finishes (J).

Thus there is no new local mathematical premise left between the latest smoothing/finite-zero arguments and the reviewed scalar base-gap inequalities. The missing wrapper (W), inclusive restriction and low-count specialization above are proof work rather than an additional conjectural estimate. The old description “actual etaU admissibility and pointwise limit unresolved on paper” is now stale, although their Lean implementations are still absent.

The smallest genuine **spectral** hole is an actual all-character certificate for beta<=111/200 through Hcert(c), with source-function/character/order coverage. Even the exceptional q=1 route needs the c=1 finite strip through its selected prefix cutoff (or another proved estimate of equivalent strength); the finite data for low principal heights do not imply it. This note does not derive that spectral assertion. Global seven-eighths provider closure, the high-branch Type I/II producer replacements, all scalar certificate replays in Lean, and formalization of the wrappers remain separate obligations. Neither summability, a zero count upper bound, nor the good-height limit can supply the missing finite strip.

The final root remains unchanged: `TernaryGoldbachFrom(10^27)` has no mathematical premise; the full Statement retains only the original inclusive `BinaryGoldbachInput` through 4e18. The conditional inputs in this note must be discharged internally, never appended to those roots.

## 6. Evidence pins

All hashes below were checked in this read-only pass. Reviews retain their stated paper/source scope; no compiled status is inferred. Paths are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| major-constants/ACTUAL_SMOOTHING_CONTINUITY_JOIN_2026-11-11.md | DDE8BB9C5782A91006A47E608F653A82E3BA195397D245C1304B485888F2F55D |
| moebius/REVIEW_ACTUAL_SMOOTHING_CONTINUITY_JOIN_2026-11-11.md | D79E28D39B7289BF69D9A7BE9D1368A19960E2E113FE3FC91C724B78979C8952 |
| zero-sum/ZERO_SUM_SOURCE_JOIN_2026-11-11.md | 600F627B397F7A8E83AE20578D8BA7A7C5EBEC536578EA5EC41D1E3AAC25ABDA |
| moebius/REVIEW_ZERO_SUM_SOURCE_JOIN_2026-11-11.md | ABD7473796D65689D1F4D4C58988B1D252BFA534425E36F99DEE50E1D59711F6 |
| zero-sum/RESUME_BASE_GAP_FINITE_FAMILY_2026-11-11.md | 09340D4135D7E895E6F3FDA660DE9A7F773A91FF41F3B88FC125C814884D5E74 |
| audit/RESUME_BASE_GAP_FAMILY_REVIEW_2026-11-11.md | 973B7B90B892E2514D3C3A6953880F784964D0E22BEE19D628877940FE0D7E73 |
| zero-sum/RESUME_SPECTRAL_CERTIFICATE_STRATEGY_2026-11-11.md | 9EADB2E516E16C33AB0B0B618C771723712716ABA38B54F4965A37BF158A46CB |
| moebius/SPECTRAL_CERTIFICATE_STRATEGY_REVIEW_2026-11-11.md | 2E39BDF6741A252F6A9F6DE8F9812AFFB5611D431AE424543536B4A48D0922CE |
| zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md | 53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54 |
| integration/REVIEW_FAMILY_CHARACTER_MANIFEST_2026-11-11.md | EEE3BAE662500804EAEC0268A8612D0E01ED1C2FAF5D0208D442A97739794664 |
| audit/RESUME_FULL_BASE_GAP_JOIN_REVIEW_2026-11-11.md | B6DC3340E6287135D4F393A6B49A1FD3DBBB8712B45822BC1A0D934AE9F9A97B |
| independent-feasibility/RESUME_SMALL_Q_HIGH_REVIEW_2026-11-11.md | F3EC07159059587EA4031B2FD06BFF74BDC1491048DAD986BE79201A29ED3F54 |
| independent-feasibility/RESUME_Q1_FINITE_REVIEW_2026-11-11.md | 364E835BC52A02779D587F40AAA6CC1FBC9BE579F01614D978A7FD4DFF1CAD4E |

Directly inspected source-file pins:

| Source | SHA256 |
|---|---|
| MinorArcs/BaseGap.lean | ABF8667E1A8D5C72AA81F1B3F40481933A1ABC5A1CE3FAA0BE9705AC8CAF418B |
| MinorArcs/BaseGap2.lean | AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E |
| MinorArcs/MinorTotal.lean | 6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742 |
| MinorArcs/Bombieri.lean | F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79 |
| Explicit/ZeroSumGen.lean | 9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389 |
| Explicit/Datum.lean | 42F14B373106D5508F73080BEC1E57992FDCBCB7A0460182AD396534463ACDDE |
| Explicit/ExplicitFormula.lean | 8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35 |
| Explicit/ZetaExplicit.lean | A2252356B4A2FCE4BC0B2B0EFF9A26B43DFAEBA9B05DB94BFEAA444A423B94E2 |
| Explicit/GMellin.lean | B35DEB66E13608081839069DDCF4368E6FF6CF680D2B04B8F7871662399EAABB |

Independent review of this new assembly is requested. The source statements, reviewed paper arguments, external scalar certificates and missing formal proofs remain distinct.
