# The same zero-free coefficient down to height 88000000

Date: 2026-11-11. Paper/source theorem and exact rational witnesses only. No Lean/source edits, builds, zero data or analytic function evaluations.

## Result

The proof of `Explicit/ZeroFreeRegion.zero_free` extends to the following statement with its coefficient 11 unchanged:

    If xiF(rho)=0 and |Im rho|>=88000000, then
    Re rho <= 1 - 1/(11*log|Im rho|).

This uses the same analytic inputs as the existing source theorem. No finite RH hypothesis is needed for this zero-free statement. The newly covered closed annulus from 88 million through 100 million can therefore be handled by this estimate when splitting the explicit formula at H=88 million.

This is not yet a reduction of the complete principal certificate. The numerical mid-zero bounds in `PsiRange1` and `PsiAsymp` must be recomposed with the new split height. The finite cB tables and Mertens/E1 bounds remain separate requirements. No root premise or frozen artifact changes here.

## 1. Source proof and its threshold uses

Paths in the text are relative to `work/ternary-goldbach/TernaryGoldbach/`. `Explicit/ZeroFreeRegion.lean:421–543` proves the positive-ordinate theorem; lines546–554 pass to absolute ordinates by conjugation. The height is used in two places:

1. To obtain L=log(t)>=18.4 and hence bounds on sigma=1+0.31/L and kappa=(sigma-1/2)/1.1181. The later reciprocal, logarithmic and product bounds depend on this step.
2. To bound the terms proportional to 1/(j*t)^2, j>=1, by 1e-15.

The analytic lemmas called there do not have a 1e8 lower threshold. `vM_real_le:286` requires sigma>1. `vM_term_le:308` requires 1<sigma<=1.02 and tau>=10. `stech_wrap:379` and `stech_wrap_rho:388` require 1<sigma<=1.02, with an actual off-line zero for the latter. Their Stechkin domain follows from sigma<1.6181 and (sigma-1/2)^2+1.1181^2>=3/2. `vM_positivity:158` requires only sigma>1 and uses an actual convergent von Mangoldt series.

Thus replacing the two numerical steps, including their dependent constants, is sufficient at this source boundary. The deeper `xi_partial_approx`, Stechkin pairing, digamma and Dirichlet-series identities are retained source inputs, not independently re-proved in this note.

## 2. Replacement rational bounds

Set H0=88000000. A finite polynomial certificate gives log(H0)>18.29. Specifically, for u=29/100, put

    P10=sum_(n=0)^10 u^n/n!,
    U10=P10+[u^11/11!]/[1-u/12].

The positive exponential-series tail is at most the displayed geometric bound. Using the same source bound exp(1)<2.7182818286 as `log_1e8_ge:273`, the receipt verifies

    (2.7182818286)^18 * U10 < 88000000.

Hence exp(18.29)<H0 and L=log(t)>=18.29 for every t>=H0. This is an inequality certificate; no exponential or logarithm implementation is evaluated.

Assume for contradiction that beta=Re rho>1-1/(11L). The existing `xiF_zero_re` gives beta<1. The following rational table holds:

| Quantity | Bound used here |
|---|---|
| beta | beta>0.95 |
| sigma=1+0.31/L | 1<sigma<=1.01695<1.02 |
| kappa=(sigma-1/2)/1.1181 | 0.4471<=kappa<=0.46235<1 |
| 1/sigma | >=0.9833 |
| 1/(sigma/2+1) | >=0.6629 |
| log(sigma/2+2) | <=log(2.5085)<=0.9197 |
| 1/(sigma-beta) | >=2.4943*L |
| kappa*E1 | <=0.5945 |
| kappa*[1/(1.6181-beta)+1/(0.6181+beta)] | <=1.043 |

Here E1 is exactly the fixed real-axis expression in `vM_term_le`:

    1/1.6181 + 1/0.6181 - (log pi)/2
      + [log(2.80905)-2/1.6181-1/1.80905]/2.

The source inequalities log(pi)>=1.1447 and log(2.80905)<=1.0329 imply E1<=1.2857. Since kappa>=0, first multiply this bound by kappa, then use kappa<=0.46235. This proves the product bound without requiring E1 to be nonnegative. The pole bound uses beta<1 and beta>0.95, so both denominators are positive; its two upper reciprocals are 1/0.6181 and 1/1.5681.

For the distinguished pole, sigma-beta<(0.31+1/11)/L<0.40091/L. The exact product 2.4943*0.40091<1 gives the table's lower bound. All reciprocal multiplications use positive denominators.

The old tiny-term allowance is unchanged. For any real j>=1,

    [2+(11/2)*kappa]/(j*t)^2 <= 7.5/H0^2 < 1e-15.

This includes the full 1/t^2 contribution of `vM_term_le`; no such term is omitted.

## 3. Explicit final contradiction

Write F_j for Re(-zeta'/zeta)(sigma+i*j*t), represented by the source's convergent von Mangoldt L-series. Its nonnegative trigonometric-polynomial combination is

    0 <= 18*F_0+30*F_1+17*F_2+6*F_3+F_4.

The polynomial identity is `ZeroFreeRegion:147–176`; its weights are unchanged. The source proof obtains this inequality from the actual series, not a formal positivity assumption.

The real-axis bound has a useful exact cancellation: its 1/sigma cancels (1/2)*(2/sigma). Consequently the new bounds give

    F_0 <= (100/31)*L + c0,
    c0=-(1.1447)/2+(0.9197-0.6629)/2=-0.44395.

For every nonzero j among 1,2,3,4, the non-distinguished part of `vM_term_le` is at most

    0.27645*(L+log j)+c,
    c=0.5529*(0.36-1.1447/2)
       +0.46235*0.20604/2+0.5945+1e-15.

To justify replacing 1-kappa by 0.5529, its multiplier (L+log j)/2+0.36-log(pi)/2 is nonnegative: use L>=18.29, log j>=0 and the source log(pi)<=1.2. To bound it above afterwards, use log(pi)>=1.1447. These are two distinct uses; an inequality is not multiplied by an unverified sign.

At j=1, `stech_wrap_rho` subtracts at least

    2.4943*L+0.9833-1.043.

At j=2,3,4, `stech_wrap` subtracts a nonnegative quantity. With log2<=0.6932, log3<=1.0987 and log4=2log2, the positive combination above is therefore at most m*L+C, where

    m=18*(100/31)+54*0.27645-30*2.4943,
    C=18*c0+54*c
       +0.27645*(17*0.6932+6*1.0987+2*0.6932)
       +30*(1.043-0.9833).

The exact receipt verifies m<0 and m*18.29+C<0. Thus m*L+C<0 for every L>=18.29, contradicting the nonnegative series combination. The receipt stores the exact negative value and its positive contradiction margin. No value at a zero or special-function sample is used.

This proves the positive-ordinate theorem including t=H0. For a negative ordinate, `xiF_conj` gives an actual zero at the conjugate, with the same real part and positive ordinate |Im rho|. Applying the just-proved statement yields the absolute-ordinate result. Since H0>0, log|Im rho| is positive throughout the domain.

## 4. Downstream consequence and remaining gates

`Explicit/PsiLarge.lean:42–80` uses `zero_free` to prove `rpow_re_le_zf` and `mid_sum_le`. The same arguments now work when their lower height is 88 million: for x>1 and H0<=|Im rho|<=Gamma,

    x^(Re rho) <= x*exp[-log(x)/(11*log Gamma)].

The monotonicity is valid because log Gamma>=log|Im rho|>0. The coefficient 11 and the shape of the mid-zero majorant do not change. In particular the annulus (88 million,100 million] has a source-faithful analytic bound without additional RH data.

However `PsiRange1` and `PsiAsymp` specialize further numerical expressions at H=1e8. Moving that split to 88 million changes the number/weight of mid zeros and height-dependent denominators. Their final constants have not been re-certified here. The separately accepted plateau candidate at H=88 million does not by itself settle those unbounded estimates, the finite cB ranges or Mertens/E1. The complete principal target therefore remains unchanged pending those joins.

## Evidence

The companion `zero_free_88m_scalar_certificate_20261111.py` checks 20 rational inequalities and pins six source files. The finite exponential tail bound and all subsequent arithmetic are exact. The proof does not add an axiom or a formal declaration. It is a source-faithful paper adaptation awaiting independent review and later implementation.

| File | SHA-256 |
|---|---|
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZeroFreeRegion.lean` | `AC367CDA6777165DF4AF22BA1BA1530B8A280B77CA55F1918562376DE69C0EAB` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZeroFree.lean` | `E8096BB9CACE76603D8B14429596279046D0E9F99DFDBD6E4BDCF8368A89084A` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/XiPartial.lean` | `8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiLarge.lean` | `D370555A164DA01E37E5BDB14EFA774DC79FE43682EED21D42C90BA2D1B165F2` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiRange1.lean` | `F474C24F28ED3D14774A170F19EF312AE132124D727ABD438478C4AF89BBE026` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiAsymp.lean` | `2EEE8AAAC78360010044AB5964058ADB5998FB30EFAC3000352ED6D2114D047D` |
| `zero_free_88m_scalar_certificate_20261111.py` | `09FF3DCE0E4F6415D748A6E0FA0EFFBA8535909B284CCDBA660CF77E1422B53B` |
| `zero_free_88m_scalar_certificate_20261111.json` | `66A18E1631BDEB7D6DDD60480B45C121F1DF59473C0D918EEE98BE9906BC020A` |
| `PRINCIPAL_JOINT_PLATEAU_CANDIDATE_2026-11-11.md` | `CDE39E8AFDB868AFE2F5258BD154C79A36D43F1DBB0EE527DA633BD452EC0BB8` |
| `PRINCIPAL_RH_HEIGHT_CONSUMER_AUDIT_2026-11-11.md` | `207EEAF68F7FB51351B4C37E991A09664F1B7852CCE29D82C75B2D4B8B776D63` |
