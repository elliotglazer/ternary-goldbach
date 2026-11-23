# Major-arc final consumption join

2026-11-11. Research derivation against source commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean declarations, builds, evaluator runs, new spectral data or edits to frozen packets were made. The conclusion is a conditional paper assembly from the already identified spectral/analytic inputs, not an unconditional major-arc theorem.

The first remaining assembly issue after the accepted zero-sum and smoothing joins is the passage from actual character residuals to a single integrated cubic error with the source's arc carriers and x^2/49 normalization. Sections 2-6 give that passage. There is also a useful simplification: the removal step can bound its unweighted star residual directly from the reviewed low-star norm and pointwise remainder. It needs neither the older `MinorTotal` uniform-star estimate nor an argument circularly using the final major bound. No further numerical analytic estimate was found missing after these steps. The genuine unresolved inputs remain before this join: actual finite spectral certificates, global-provider validation, and formal proofs/replay of the stated analytic and scalar bounds.

## 1. Inputs retained, with their existing status

Use `ZERO_SUM_SOURCE_JOIN_2026-11-11.md`, SHA `600F627B397F7A8E83AE20578D8BA7A7C5EBEC536578EA5EC41D1E3AAC25ABDA`, and `ACTUAL_SMOOTHING_CONTINUITY_JOIN_2026-11-11.md`, SHA `DDE8BB9C5782A91006A47E608F653A82E3BA195397D245C1304B485888F2F55D`. The latter has independent review `D79E28D39B7289BF69D9A7BE9D1368A19960E2E113FE3FC91C724B78979C8952`. These establish the paper limit/measurability passage without exchanging an integral with an infinite zero sum.

The quantitative input packet is `RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md`, SHA `79833F8D5D5856E000A96D3F5CCA9FC9E26CB3BAF637CDE089FEFDD703436BA7`, with its reviewed finite-low and directed high-tail bounds. Its statement about passing by absolute convergence is superseded by the accepted zero-sum join. The low cutoff remains

    Hcert(c) = min(ceil(200+max(1000,(704/7)Dc)), 100000000/c),
    Dc = 1200000/qt(c).

This is inclusive and is not rounded upward after the minimum. Active primitive conductors are odd c<=150000 and multiples of four c<=300000, including c=1. The inverse-character reflection and actual multiplicities are retained. This paper does not certify their finite beta<=111/200 assertion, the global beta<=7/8 provider, or the scalar receipts in Lean.

The actual coprime estimates delivered by those inputs are

    Aplus_c <5e-7,  Astar_c <2.5e-7,  Cross_c <4.357e-7,
    hence Astar_c+Cross_c <9.5e-7;
    Ep <(.00020001)^2 <=1e-4,  Nnonprincipal <1.23.       (1)

Also available are the low-star vector integral <10000 and a scalar error <=dstar=2e-12 for each character after its actual primitive-to-coprime transfer. The larger common-height plus-tail is already included in Nnonprincipal and the mixed bound; it is not silently replaced by the older 2e-10 mixed remainder. Its mixed remainder norm is <.000160001.

## 2. Exact functions and finite measure spaces

Fix x>=4.9e26, y=x/49, Q=Qset(150000), Dq=1200000/qt(q), and Iq=(-Dq,Dq). Source definitions are `MinorArcs/LargeSieveWeights.lean:26` and `LargeSieveArcs.lean:31,34`. Every q is positive, q<=qt(q)<=300000, Dq>=4, and #Q<=300000. Put

    P(delta)=Fourier(etaPlus)(-delta),
    U(delta)=Fourier(etaU)(-delta/49),   m_q=mu(q)/phi(q).

Let s_b=S_etaPlus(x,b/q+delta/x)/x and v_b=S_etaStar(x,b/q+delta/x)/y. Here the source function order is `S eta x alpha`. Let s'_b,v'_b be the corresponding coprime-supported sums, with coefficients Lambda(n)etaPlus(n/x) and Lambda(n)etaU(n/y). `ArcCharsStar` and `MajorTotal.fourier_etaSC:360` identify the latter scaling with the actual etaStar, not a replacement smoothing.

Define r_b=s_b-m_q P and t_b=v_b-m_q U, and similarly r'_b,t'_b. The integrals below are over the finite disjoint union of (q,b,delta), q in Q, b in Bset(q), delta in Iq. Counting measure in the two finite indices and Lebesgue measure in delta make Cauchy-Schwarz and Minkowski ordinary finite-measure statements. Every actual function extends continuously to each closed interval, by the accepted smoothing join and the source summability lemmas. Products, squares and fourth-degree terms are therefore integrable. The open/closed endpoints are Lebesgue null and introduce no boundary terms.

For each character psi modulo q define the normalized coprime residual e_psi,+ or e_psi,* by subtracting P or U only for psi=1. The twisted character is psi^-1. The exact residual Parseval identity is

    sum_b |r'_b|^2 = Eplus(q,delta)
       = sum_psi |tau_q(psi)|^2 |e_psi,+|^2/phi(q),       (2)

and likewise for Estar. To derive it, apply source `Bombieri.parseval_chars` to b -> s'_b-m_q P. `sum_char_mul_S` gives the transform tau_q(psi) times the inverse-character sum. The transform of the constant is zero for psi!=1 and is phi(q)m_q P=mu(q)P for psi=1. `MajorTotal.gaussSum_one_eq:75` identifies tau_q(1)=mu(q), giving (2) even when mu(q)=0. No division by mu occurs. `sum_Bset_eq_units` transports the source unit-residue carrier to Bset(q).

The exact weight from `MinorArcs/Bombieri.norm_sq_gaussSum:135` is c when q/c is squarefree and coprime to c, and zero otherwise. All sums here retain this indicator. Primitive conversion uses (psi^-1).primitiveCharacter and its already budgeted removed-prime terms. There is no factor 1/sqrt(c) and no primitive Gauss identity imposed on an imprimitive character.

In this notation,

    Aplus_c = sum_q integral_Iq |m_q U|^2 Eplus,
    Astar_c = sum_q integral_Iq |m_q P|^2 Estar,
    Cross_c = sum_q integral_Iq Eplus Estar.             (3)

These are exactly the actual quantities in (1), not newly postulated variants.

## 3. Upper and lower J without the cubic bound

Let g_q be the normalized coprime principal plus sum. Put Jc=sum_q integral_Iq sum_b |s'_b|^2, and define J similarly using s_b. Orthogonality gives

    Jc = sum_q mPhi(q) integral_Iq |g_q|^2 + Nnonprincipal,
    integral_sum Eplus = Ep+Nnonprincipal <1.2301.        (4)

Here mPhi(q)=mu(q)^2/phi(q), so Ep is exactly the principal residual contribution. This supplies the unweighted Eplus bound without assuming J.

The unconditional source Fourier and finite sums give

    M0=.640208*13.59756=8.70526669248,
    Mlow=.6392*13.597558.

See `EtaPlusL2.integral_fourier_etaPlus_Ioo_bounds:199` and `SumMuPhi.sum_Qset_mPhi_bounds:108`. The integral of each squared removal error is at most the measure of the arc-residue space times its pointwise bound. In particular

    W=sum_q 2Dq*phi(q) <=7.2e11,                        (5)

since each term is <=2.4e6 and #Q<=300000. `ArcChars.norm_S_sub_coprime_le:314` gives |s-s'|<=1e-15, hence the integrated squared error <=7.2e-19.

For positive t,u, two applications of |a+b|^2<=(1+t)|a|^2+(1+1/t)|b|^2 yield

    J <=(1+u)[(1+t)M0+(1+1/t)Ep+Nnonprincipal]
           +(1+1/u)*7.2e-19.

At t=.0034,u=1e-6, (1) gives J<10. No use of the cubic integral or of a minor-arc bound appears in this proof.

For the lower bound, discard the nonnegative nonprincipal energy, restrict Fourier energy to the actual arcs Dq>=4 and use reverse triangle twice. Since sqrt(Mlow)>2.94, sqrt(Ep)<.00020001 and sqrt(7.2e-19)<1e-9,

    sqrt(J) >=2.94-.00020001-1e-9,
    J >8.6296.                                         (6)

This is the weighted principal argument; one must not replace Ep by only a q=1 norm without the separate coprime comparison for other q. The actual stronger Ep estimate in (1), not merely Ep<=1e-4, is used for (6).

Finally delta=x beta and the source arc partition identify J with x^-1 times the actual major integral of |S_etaPlus|^2. Source `MajorTotal.integral_majorArcs_eq:27` applies to its continuous real periodic integrand. This recovers the exact lower-energy consumer and a relaxed upper bound 10x, without calling the conditional `L2Major.l2_major_bounds:309` unchanged.

## 4. Noncircular full-sum removal

First bound the star term needed in the product transfer. In the finite character/arc space give coordinate psi the weight |tau_q(psi)|^2/phi(q). The sum of weights is phi(q): exact character Parseval, or the eligible-conductor identity, gives sum_psi |tau|^2=phi(q)^2. A scalar error <=dstar for each coordinate is therefore a vector error <=dstar*sqrt(phi(q)), not <=dstar. By (5) its integrated norm is at most

    dstar*sqrt(W) <2e-6.

The low-star vector has integrated squared norm <10000, so Minkowski gives

    integral_sum Estar <(100+2e-6)^2 <10001.             (7)

This uses the actual coprime error already furnished by the common-height/zero-sum packet. It does not compare low sums pointwise by discarding oscillatory terms, nor assume a signed sum's norm is monotone in its set of zeros. In conjunction with (4), it replaces both coarse unweighted bounds in the historical removal ledger.

The unconditional source removal estimates are |s-s'|<=1e-15 and |v-v'|<=1e-12 (`ArcCharsStar.norm_S_star_sub_coprime_le:100`). Apply the square split with t=.01 and sum b. With a=1.01,

    Rplus:=sum_b|r_b|^2 <=a Eplus+bp, bp=3.03e-23,
    Rstar:=sum_b|t_b|^2 <=a Estar+bs, bs=3.03e-17.       (8)

These constants use #Bset(q)=phi(q)<=300000. They are intentionally the old, looser uniform constants. Also sum_q 2Dq<=3.6e11. The source bounds integral|U|^2<=381.22, integral|P|^2<=.640208 and sum_q |m_q|^2<=2.85 give

    Afull <=a Aplus_c+381.22*2.85*bp,
    Qfull:=Astar_full+Cross_full
      <=a^2(Astar_c+Cross_c)+.640208*2.85*bs
          +a*bp*10001+a*bs*1.2301+bp*bs*3.6e11.        (9)

The product line follows by expanding (8); all discarded terms are nonnegative and a<=a^2. The source facts are `MajorTotal.integral_norm_sq_fourier_etaUC_le:469`, `EtaPlusL2:116,148`, and `Singular.sum_Qset_mPhi2_le:655`. In particular (9) implies the previously reviewed full caps, with their safe rounding retained:

    Afull <5.050000000000330e-7,
    Qfull <9.817952468e-7.                              (10)

The new estimate for Qfull is actually below9.691e-7, but no tighter target or revised final budget is adopted. Equation (7) is the new simplification that removes the old transfer's extra MinorTotal uniform-star dependency.

## 5. Integrated cubic error with exact normalization

All the following steps occur on the finite arc-residue measure space of section 2. Let

    B=integral_sum_b |s_b+m_q P|^2,
    V=integral_sum_b |s_b|^2 |t_b|^2.

The exact identity is

    s_b^2 v_b-(m_q P)^2(m_q U)
       =t_b s_b^2 + m_q U r_b(s_b+m_q P).

The additive phase e(-N(b/q+delta/x)) has norm1. Triangle and two Cauchy-Schwarz inequalities therefore bound the absolute integrated normalized cubic error by

    sqrt(J V)+sqrt(Afull B).                            (11)

No per-modulus supremum or extraneous count of residue classes is introduced. Further,

    B<=2J+2M0<=37.41053338496,
    V<=2 Astar_full+2 Cross_full=2Qfull.                 (12)

For the second inequality first use |s_b|^2<=2|m_q P|^2+2|r_b|^2. Then sum_b |r_b|^2|t_b|^2 <=(sum_b|r_b|^2)(sum_b|t_b|^2), retaining the nonnegative off-diagonal terms. This is why a second-moment estimate alone is insufficient and the actual Cross input was needed. It is not an inference of L4 from L2.

Substitute (10) into (11)-(12). Exact squared comparisons give

    sqrt(37.41053338496*Afull)<.0043466,
    sqrt(20*Qfull)<.0044313,
    total dynamic loss <.0087779<.008778.               (13)

The physical scale is checked directly. Before changing variables the cubic is x^2*y*s_b^2*v_b. Since d beta=d delta/x, its arc integral equals x*y times the normalized integral, namely x^2/49. This same factor multiplies (13).

## 6. The actual main term and the major lower bound

Use the source `coefN` from `MajorArcs/Singular.lean:123,148`. Its exact identity is

    coefN(N,q)=m_q^3 sum_(b in Bset(q)) e(-Nb/q),

a real number represented in C on the right. Thus the phase-weighted normalized ideal main term in (11) is exactly the source main term; it is not a new singular series.

For w=Dq/x, w*x=Dq>=4. `MajorTotal.main_comparison:561` bounds the unnormalized ideal Fourier integral's error from x^2*Cmain(N/x) by2.03e-5*x^2. `abs_coefN_le:716` and `sum_Qset_mPhi2_le` show that after summing q and dividing by x^2/49 the entire fixed error is at most

    49*2.03e-5*2.85=.002834895.                         (14)

This bound includes the source's actual smoothing comparison and omitted Fourier tails; it is not a second copy of the dynamic residual error.

For odd N and N/x=2+9/(8sqrt(pi/2))/49, unconditional source `Singular.sum_Qset_coefN_ge:619` gives sum coefN>=1.314, and `MajorTotal.Cmain_ge_num:942` gives 49*Cmain(N/x)>=.800689. The latter is positive, so multiplication preserves the lower bounds despite individual coefN being allowed to have either sign. Hence the normalized main contribution is at least1.052105346.

The source `MajorTotal.integral_majorArcs_eq:27`, `setIntegral_arc_eq_C:736`, `continuous_fI:754` and `fI_periodic:931` transport the finite arc sum to precisely

    Re integral_(Ioc(0,1) intersect majorArcs(8,r0,x))
          S_etaPlus(x,alpha)^2 S_etaStar(x,alpha)e(-Nalpha) d alpha.

The partition is used for the continuous real part of the complex integrand; it includes arcs crossing the fundamental-domain boundary through periodicity. No unjustified disjointness or positivity of the cubic is assumed. Equations (13)-(14) now give the explicit lower bound

    (1.052105346-.002834895-.008778)*x^2/49
      =1.040492451*x^2/49 >1.0404*x^2/49.                (15)

This replaces the conditional final assembly at `MajorTotal.major_total:974`; it does not derive the source's stronger1.049 conclusion.

## 7. Consumption boundary and remaining work

`Helfgott/Inputs.major_arcs_input:76` supplies the exact xOf ratio and xOf>=4.9e26 for N>=10^27. It must be rebuilt at1.0404, as previously agreed. The minor bound1.0376 and the nonprime bound are separate consumers. The source proof of `Helfgott/Numerics.final_inequality_crude:71` provides, with v=N^(1/64)>=2.64, the comparison

    normalized nonprime <=1.589e8*4.0804*49/(2.64^31)<.00271.

Thus1.0404-1.0376-.00271=.00009>0. This arithmetic is included only to ensure (15) is not mistaken for sufficient major-minus-minor positivity before subtracting nonprime representations. The independent minor-arc/base-gap inputs and BinaryGoldbachInput for the full root are unchanged.

After the accepted actual-residual estimates, the new derivation closes the source-level integrated consumption step on paper. Formal work still includes the residual Parseval helper, finite-measure inequalities, change of variables and revised exported constants. Before that point, the finite spectral certificates/global-provider validation and the smoothing/Gram/scalar proof obligations retain their prior status. Nothing in this report turns a successful mathematical implication into evidence that those concrete spectral inputs hold.

The earlier AVERAGING/FULL_TRANSFER budget .011670451 did not reserve the nonprime loss and is not used. Neither the source conditional per_modulus/pointwise_bound nor the source8.79 upper-J theorem is called with an erased PlattGRH premise.

## Exact scalar checks and pins

`major_final_consumption_join_20261111.py`, SHA `67AE43B1A1CF6B99E2E5BC39E471C496126CBCB31184078547762720D7D85D90`, performs17 independent Fraction-only checks. Receipt SHA `F8D33FF314748F3555CBD666CC39C8D35AD70EDD78B2AEFB71F0614B3B9BBF86`. It evaluates no smoothing, zeta/L function, spectral list or FFT. The checks cover (5)-(15), both J bounds and the final reserve.

| Source | SHA256 |
| --- | --- |
| MajorArcs/MajorTotal.lean | 106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A |
| MajorArcs/L2Major.lean | 8C9424D92074ABB35DF00273D598F5A3F95C49A34F07F4146DD83FD2B6F3A5FC |
| MajorArcs/ArcChars.lean | 0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF |
| MajorArcs/ArcCharsStar.lean | B95DE4A83BAF37008B21FCFF90A0188AA230548C8776DE6C5F2905C19DA9DF10 |
| MajorArcs/Singular.lean | 152DC0302216E9E2B23E9DFCA7FE1BCA2087F275662F9988FC524D101C1B8DB9 |
| MinorArcs/Bombieri.lean | F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79 |
| Helfgott/Numerics.lean | 059874D201ECC571583118A56BA6193D6D8B49016C227988CBC83FA0F34648DB |
| Helfgott/Inputs.lean | 5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83 |
