# A joint principal plateau candidate at height 88000000

Date: 2026-11-11. One fixed paper candidate, with exact rational certificates. No special-function evaluation, zero data, prime evaluation, Lean build, or source edit.

## Result and scope

Assume the actual `RHBelow 88000000` predicate of `Explicit/ZetaZeroSums.lean:21`. The existing Gaussian explicit formula and unsmoothing inequalities imply, for every real x>=1e17,

    |psiR(x)-x| <= 4.91e-7*x + 1145*sqrt(x) + 4.2e10.

This is the same plateau output as `Explicit/PsiPlateau1e8.lean:120`, with a weaker RH height premise. The new parameters are

    H = 88000000, K = 13/2, delta = K/H = 13/176000000,
    y0 = 1e10, a0 = K*delta = 169/352000000,
    b = log(y0/x).

This does not lower the complete campaign's principal target. The finite psi tables, Mertens/E1 window estimates and unbounded zero-free-region transition identified in `PRINCIPAL_RH_HEIGHT_CONSUMER_AUDIT_2026-11-11.md` remain separate requirements. Only one candidate is checked; no optimality or runtime claim is made.

## 1. Exact source interfaces

All Lean locations in this note are below `work/ternary-goldbach/TernaryGoldbach/`. The relevant generic theorem is `Explicit/PsiExplicit.lean:199`, `tsum_gsm_leH`. It assumes H>0, `RHBelow H`, delta>0, b<=a, b<=0 and x>=1. Its conclusion is the actual Gaussian-smoothed prime-sum error, with

    ErrGH = sqrt(x)*LineB2H + x*TailBH + x^(-1/2)*Vg/(2*pi).

The definitions are at `PsiExplicit:47,110–117,196`. The proof uses `SsumG_gsm_errH:120` and the actual explicit formula, with finite zero sums first bounded uniformly. It has no premise H>=1e8. Thus the present candidate neither imports `rh_upto_1e8` nor needs the recent lower-height WeilWindow adapter.

`Explicit/PsiLarge.lean:296–370` supplies `psi_upper_of_err` and `psi_lower_of_err` with variable real K. Their bounds, writing E for the smoothed error, are

    psiR(x) <= 4*y0*exp(K*delta)
               + [exp(delta^2/2+K*delta)*x+E]/[1-2*exp(-K^2/2)],
    psiR(x) >= exp(-K*delta)*x - 2*y0-E-4*x*exp(-K^2/2).

The upper denominator must be positive; the lower call needs delta<=1 and delta<=K. These are checked below. No totalized division or limiting K choice is used.

## 2. Line and vertical-integral terms

Use either a=a0 or a=-a0. More generally the following bounds hold for |a|<=a0. The exact inequalities

    H<3e10, delta>=7/1e8, |a|<=a0<49/1e8

allow the structure of the old line and vertical-integral proofs to be reused, with the new delta substituted explicitly. They do not by themselves justify reusing any theorem whose type fixes delta; the bounds are reconstructed here.

For the line term, `Explicit/PsiPlateau.lean:204` proves the nonnegative weighted window sum through 3e10 is <=571. Its displayed theorem body uses 3e10; the nearby prose saying 3e12 is not used. Since `JlH 6 H=floor(H/6)+1` and H<=3e10, restricting this finite sum to H can only reduce it. The source log/count summands are nonnegative. Also

    exp(delta^2/2)<=1.000001, exp(a/2)<=1.000001,
    exp(b/2)=sqrt(1e10/x)<=0.000317.

The first two follow from `exp_small_le` at `PsiPlateau:104` and exact rational comparisons. The last is `exp_half_log_le:119` on the complete x-domain. Therefore

    LineB2H <= 1.000001*(1.000001+0.000317)*2*571 < 1143.

For Vg, use the exact formula at `PsiExplicit:47` and exp(-b/2)=sqrt(x)/1e5. The old elementary bounds remain unchanged:

    2/log(2)+4.8 <= 7.6856, sqrt(2*pi)>=2.5066,
    sqrt(x)>=3.16e8.

They are justified in `PsiPlateau1e8:47–102` using the source log(2) and pi inequalities, with the last inequality following by squaring. The new delta satisfies exp(delta^2/8)<=1.000001, and exp(-a/2)<=1.000001. Hence the entire vertical contribution is at most

    [7.6856*82.6*1.000001/(delta*2.5066)]
      *[1.000001/(3.16e8)+1e-5] < 37000.

This is a constant in the full error, not a multiple of x or sqrt(x). The factor 1/delta is retained. Its exact rational value is stored in the receipt.

## 3. Full Gaussian tail at the new height

The old `TailBH_1e8_le` is not invoked. From `Explicit/ZetaZeroSums.lean:526–535`, set

    t = 4.4*delta^2*H > 0, r=t/(1+t), g=exp(-K^2/2).

The elementary inequality exp(t)>=1+t gives

    1-exp(-t) >= r > 0.

The definitions in `PsiExplicit:116` and `ZeroSumGen:80–81` give the exact tail expression

    TailBH = [2*exp(delta^2/2+|a|)*g/H]
        *[2*Z3g(BPz2,H)/(1-exp(-t))
          +2*c3g(10,H)/(1-exp(-t))^2].

The existing monotonic analytic count estimate gives Z3g(BPz2,H)<=210.6 since H<=3e10. Also log(10/3)>=1.2039 and 36.6*1.2039>44 imply c3g(10,H)<=36.6/H. Both quantities are nonnegative. Finally exp(delta^2/2+|a|)<=1.000001 follows from 1+2*(delta^2/2+a0)<=1.000001. This sharper use of the actual shift replaces the old uniform |a|<=1 estimate.

Consequently

    TailBH <= C_tail*g,
    C_tail = [2*1.000001/H]*[421.2/r+(73.2/H)/r^2] < 5.

The proof retains both the ordinary window count and the linear-in-window count term. Neither is discarded.

For g use one finite positive-polynomial certificate. Put v=K^2/2=169/8 and P80=sum_(n=0)^80 v^n/n!. Positivity of the exponential series implies exp(v)>=P80. The exact receipt checks

    P80*(7/10^10)>1.

Thus g=1/exp(v)<7e-10, without an approximate evaluation of exp. All denominators in this argument are positive. It follows that

    TailBH < 3.5e-9.

Combining Sections 2–3 produces the uniform bound needed at both shifts:

    ErrGH(+-a0,b,delta,H,x) <= 1143*sqrt(x)+3.5e-9*x+37000.

## 4. Both unsmoothing inequalities and the whole real domain

Let gbar=7e-10, d=1-2*gbar>0, e=delta^2/2+a0, and Eexp=1+e+e^2. Since 0<=e<=1, `exp_small_le2` at `PsiPlateau:262` gives exp(e)<=Eexp. Define exact rational numbers

    c_up=(Eexp+3.5e-9)/d-1,
    c_lo=a0+3.5e-9+4*gbar.

The receipt checks c_up<4.91e-7 and c_lo<4.91e-7, with their positive rational margins recorded. It also checks

    1143/d<1145,
    4e10*(1+a0+a0^2)+37000/d<4.2e10,
    2e10+37000<4.2e10.

For the upper bound, divide the complete nonnegative error majorant by d and keep all three terms. Use exp(a0)<=1+a0+a0^2 for the low-end correction. For the lower bound, use exp(-a0)>=1-a0 and retain the four-gbar unsmoothing loss. The inequalities above give exactly the claimed common plateau constants.

The source domains hold for every x>=1e17. In particular y0*exp(a0)<=y0*(1+a0+a0^2)<=1e17<=x. Also y0/x<=1e-7, and log u<=u-1 for u>0 yields b<=1e-7-1<=-a0. Thus b<=a for both shifts and b<=0. Positivity of delta, H and y0, delta<=1, delta<=K, K>=0, x>=1 and d>0 are explicit. No upper bound on x or integrality assumption on x is introduced.

## 5. What this changes and what it leaves open

The candidate improves this one sufficient plateau recipe from RH height 1e8 to 88e6 while retaining every output constant and its unbounded domain. It demonstrates why the earlier 49/H restriction was only a fixed-K restriction.

It does not reprove the 22 finite psi ranges, their Y1 choice, the separate Mertens/E1 smoothing constants, or the zero-free transition used for x>=exp(20000). The theta theorem therefore cannot yet be assigned a weaker complete spectral premise. The source's blanket Platt binders must also be replaced by exact localized inputs in a future formal implementation; no such implementation has been performed. The overall root statements, original binary input, nonprincipal family and principal certificate target are unchanged by this note.

## Evidence and source boundary

`principal_plateau_joint_candidate_20261111.py` checks exactly this fixed tuple. It uses `fractions.Fraction` for 25 scalar checks, including the complete line, tail, vertical, upper and lower budgets. Its sole exponential certificate is a rational finite polynomial lower bound, not a call to an exponential implementation. The JSON stores each majorant, both relative margins and seven source hashes. Existing explicit-formula, Gaussian smoothing, analytic zero counts, log/pi inequalities and exponential series facts remain the named analytic inputs. The result is a paper derivation plus scalar evidence, not a kernel-checked new theorem.

| File | SHA-256 |
|---|---|
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiExplicit.lean` | `33A24C9E1606011AAC8930EC978BA027E90A2A66E0888DB18915ACC2FBF85BB1` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiLarge.lean` | `D370555A164DA01E37E5BDB14EFA774DC79FE43682EED21D42C90BA2D1B165F2` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiPlateau.lean` | `9138464FF2638DEEB39EAA58E7FB39F0CFD68895CE599CCB189EF3F6EE8F8D4D` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiPlateau1e8.lean` | `F5BEB066695D24085A74706C9FFE3219A2A053E2C1854FC3E209BD0CD78E392C` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiRange.lean` | `69E94599D2120C5FCE3B737E623C2F355654FB5989CE0FF8E9A035513EB30037` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZetaZeroSums.lean` | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZeroSumGen.lean` | `9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389` |
| `principal_plateau_joint_candidate_20261111.py` | `0FF34B0508C8A268C9AF99C31DFE79D298A66B237671CE8F132F63FEC689A0FF` |
| `principal_plateau_joint_candidate_20261111.json` | `91C743E7070DEE7CED577B3243489A55858B2BD8177992210EDD31505D52FBC5` |
| `PRINCIPAL_RH_HEIGHT_CONSUMER_AUDIT_2026-11-11.md` | `207EEAF68F7FB51351B4C37E991A09664F1B7852CCE29D82C75B2D4B8B776D63` |
