# A Mertens window at height 88000000

Date: 2026-11-11. Paper/source research and exact scalar witnesses only. No special-function values, zero/prime computations, builds or source changes.

## Selected result

The concrete bottleneck selected here is `Prelim/MertensProduct.E1_win_num`, rather than the 22 finite psi/cB certificates. Its Gaussian explicit-formula input can be replaced by RH through 88000000 while retaining every numerical constant in its conclusion, provided its existing local-variation input is retained explicitly.

For a natural x>=10^12, suppose `RHBelow 88000000` and the following actual local bound hold, with the unchanged source definitions A=Aloc(x), B=Bloc(x):

    For every natural M>=x and every real t>=M,
    |E1Lambda(t)-E1Lambda(M)| <= A+B*log(t/M).

Then for every real Y>=x with log(Y/x)<=20001,

    |E1Lambda(Y)-E1Lambda(x)|
      <=1443/sqrt(x)+13/x+16/(log x)^3+8.4e-6.

Here E1Lambda is the source `E₁Λ`, not a new approximation. In fact the proof uses the local input only at M=x and M=floor(Y). The uniform form above matches `E1_local` directly.

This is a conditional decomposition of an existing proof, not a new final-root assumption. `E1_local` currently follows from theta/psi estimates using the old principal hypothesis. Those estimates still need their own weaker-height justification. The finite cB certificates and the numerical unbounded psi estimates also remain open. Neither the new plateau nor the pending zero-free candidate is used as an already accepted premise of this result.

## 1. Why the direct substitution fails to certify the output

The source uses a=2, b=0, H=10^8 and delta=8e-8. Take instead

    H=88000000, delta=8/H=1/11000000.

Thus delta*H=8, so the Gaussian factor above H remains exp(-32). The line and vertical terms fit their old allowances. But the source's two edge terms are 2*21.1*delta; enlarging delta raises the final constant obtained by the same coefficient comparison above 8.4e-6. The companion receipt checks this exact failure. It is a failure of that sufficient comparison, not a lower bound on the true Mertens error.

The needed repair is small and analytic: retain the term -log(v) during the edge integration instead of first replacing it by a power majorant.

## 2. Sharper small-v edge

Source locations are relative to `work/ternary-goldbach/TernaryGoldbach/`. `Prelim/MertensWindow.lean:516–533` already proves, before its final power simplification, for Y>=1 and 0<v<=1,

    |E1Lambda(Yv)| <= log(4)+4-log(v),
    |E1Lambda(Y)| <= log(4)+4.

The first bound explicitly treats both Yv>=1 and Yv<1; the latter case uses the exact `E₁Λ_of_lt_one` identity. Hence

    |E1Lambda(Yv)-E1Lambda(Y)| <= C-log(v), C=2log(4)+8.

`gsm_le_rpow:90ff` gives the actual smoothing bound

    0<=gsm(a,0,delta,v)<=exp(1/2)*v^(1/delta),

for a>=0, delta>0. Put r=1/delta. Since r>0, both v^r and (-log v)*v^r are integrable on (0,1], with

    integral v^r =1/(r+1),
    integral (-log v)*v^r =1/(r+1)^2.

The second identity follows by integration by parts, whose endpoint term v^(r+1)log(v) tends to zero at 0; alternatively use v=exp(-u) and the elementary integral of u*exp(-(r+1)u). These are ordinary convergent integrals. Thus the complete small-v edge is at most

    exp(1/2)*[C*delta/(1+delta)+delta^2/(1+delta)^2]
      <=1.6488*[(2*1.3863+8)*delta+delta^2]
      <=17.77*delta

for 0<delta<=1/11000000. The log(4) and exp(1/2) bounds are the existing source lemmas at `MertensWindow:535–545`; the last comparison is exact rational arithmetic.

The v>1 proof at `MertensWindow:606ff` is unchanged. In particular it still uses the actual local input, the floor at Y, and the exact Mellin moments. We therefore have the same `edge_le` conclusion except that 21.1*delta is replaced by 17.77*delta on the stated delta range:

    edge(Y) <= (2A+2B/floor(Y))*M1+2B*G+17.77*delta,
    M1=exp(delta^2/2)*(exp(2)-1),
    G=exp(delta^2*(3/2)^2/2)*(exp(3)-1)/(3/2).

All source integrability arguments are retained; the new majorant itself is integrable. No cancellation of an unsigned edge integral is assumed.

## 3. Full explicit-formula input at the new height

The generic `Explicit/PsiExplicit.tsum_gsm_leH:199` requires only H>0 and actual `RHBelow H`, not H>=1e8. For every y>=1e12 it bounds the smoothed error by

    sqrt(y)*LineB2H(2,0,delta,H)
      +y*TailBH(2,delta,H)+y^(-1/2)*Vg(2,0,delta)/(2*pi).

Each term is rechecked at the new parameters.

The line-count sum remains <=571 by restriction of the nonnegative sum through 3e10. With exp(delta^2/2)<=1.000001 and exp(1)<=2.7182818286, its majorant is

    1.000001*(2.7182818286+1)*1142 <4246.5.

For the full Gaussian tail set t=4.4*delta^2*H and r=t/(1+t). The inequality exp(t)>=1+t gives 1-exp(-t)>=r>0. The source analytic count bounds Z3g<=210.6 and c3g<=36.6/H give

    TailBH <= [2*7.3892*1.3e-14/H]
                 *[421.2/r+(73.2/H)/r^2] <3e-13.

Here exp(delta^2/2+2)<=7.3892 uses the existing exp(2)<=7.3891 bound, and exp(-delta^2 H^2/2)=exp(-32)<=1.3e-14 is the existing `PsiPlateau.exp_neg32_le`. Both window-count terms and all factors of H are included. The old height-specific tail lemma is not relabeled.

Finally the existing Vg argument, using y>=1e12, gives

    y^(-1/2)*Vg/(2*pi)
      <=[7.6856*82.6*1.000001*(0.3679+1)
          /(delta*2.5066*10^12)]*sqrt(y)
      <0.0044*sqrt(y).

Consequently the old complete error allowance remains valid:

    ErrGH(2,0,delta,H,y)<=4247*sqrt(y)+3e-13*y.

The moment bounds also remain M1>=6.389 and G<=12.724. Positivity of M1 is explicit, so the later division is legitimate.

## 4. Exact final coefficient comparison

`Prelim/MertensProduct.lean:250–251` defines

    A=3/x+2/(log x)^3+28.16/sqrt(x)+9.84e-7,
    B=1/(log x)^3+4.92e-7.

Apply `MertensWindow.E1_window` to the full error from Section 3, and the new edge bound at Y and x. The exact same algebra as `MertensProduct:531–624` yields

    |Delta E1Lambda| <=4A+4B/x
       +[8494/sqrt(x)+3e-13*log(Y/x)+4B*G+35.54*delta]/M1.

All numerator terms are nonnegative. Since log x>=27, B<=1/4. Thus the coefficients after substitution are at most

    sqrt term: 4*28.16+8494/6.389 <1443,
    inverse-x term: 4*3+1 =13,
    inverse-log-cube term: 8+4*12.724/6.389 <16,
    constant: 4*9.84e-7
      +[3e-13*20001+4*12.724*4.92e-7+35.54/11000000]/6.389
      <8.4e-6.

These comparisons are rational. In particular 35.54/11000000<3.376e-6, so the improved two-edge contribution fits even the original final proof's allowance. The resulting statement has the full original domains: integer x>=10^12, real Y>=x, log(Y/x)<=20001. There is no absolute upper bound on x or Y.

## 5. Remaining dependency, precisely

The selected Gaussian-window dependence on RH through 1e8 has been replaced on paper by RH through 88 million plus a proved tighter edge estimate, with unchanged output constants. The local input has not been weakened, proved from RH88 alone, or silently dropped. Its existing producer is `MertensProduct.E1_local:262–329`, via `E1_core` and the global theta/psi bounds. Retaining that producer's numeric output under weaker principal data is still required.

Likewise `E1_var:639ff` combines this window with `E1_diff` above exp(20000); that other branch has not been re-certified here. The finite psi/cB certificates and unbounded psi scalar estimates are untouched. The zero-free H88 candidate is not needed in this window proof and its independent status does not affect this result.

No complete principal-height or end-to-end cost reduction follows yet. This resolves one concrete numerical bottleneck without changing the desired Mertens window interface.

## Evidence

The companion `mertens_window_88m_scalar_certificate_20261111.py` and JSON contain 20 exact checks, all displayed majorants, the final constant margin and eight source hashes. No analytic-function implementation is called. The new logarithmic edge integral is proved on paper above; the script checks its resulting rational allowance, not integrability by computation.

| File | SHA-256 |
|---|---|
| `work/ternary-goldbach/TernaryGoldbach/Prelim/MertensWindow.lean` | `DE134E2DE88E9B16D252F4AC2DB2E0F930A69E9CA2CF4DB45634F748E3934034` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/MertensProduct.lean` | `8182DC2B990DC8D65AC76D3CC55847B26922E2062CD154C14367D5DB97F71A0F` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/PNTMertens.lean` | `4AA483982E40BF82955B2D4A561FBC86D1206BDD5769B81B2EAFFBF25BED83E2` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiExplicit.lean` | `33A24C9E1606011AAC8930EC978BA027E90A2A66E0888DB18915ACC2FBF85BB1` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiPlateau.lean` | `9138464FF2638DEEB39EAA58E7FB39F0CFD68895CE599CCB189EF3F6EE8F8D4D` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiPlateau1e8.lean` | `F5BEB066695D24085A74706C9FFE3219A2A053E2C1854FC3E209BD0CD78E392C` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZetaZeroSums.lean` | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZeroSumGen.lean` | `9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389` |
| `mertens_window_88m_scalar_certificate_20261111.py` | `A7F7ECA6A1582A9EFEA536279B428F9A0063E2DB46ED33071A75AB8680C1DEB7` |
| `mertens_window_88m_scalar_certificate_20261111.json` | `F41188D02C2C25CF3272760C64AEAE5E08BE1A29BE3B804E05FE0235031D1085` |
| `PRINCIPAL_RH_HEIGHT_CONSUMER_AUDIT_2026-11-11.md` | `207EEAF68F7FB51351B4C37E991A09664F1B7852CCE29D82C75B2D4B8B776D63` |
