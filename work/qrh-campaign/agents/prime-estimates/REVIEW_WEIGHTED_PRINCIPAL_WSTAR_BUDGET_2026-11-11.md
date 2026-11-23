# Independent review of the weighted principal Wstar budget

2026-11-11. **PASS at conditional source/paper and exact scalar scope; no correction requested.** This review binds the coordinator's `work/qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md`, SHA256 `22A6A16880BE2FA5CB0FF393C533BD60B1AFCD32C751E5A0D64FE7ADAB7C40F7`. I read its complete argument, the predecessor weighted-statistic and integrated-cubic contracts, and the actual source normalization/removal/Fourier bodies. A separate 35-check rational replay matched all four saved allocation rows without importing or running the author's script. No analytic values, primes, zeros, transforms or Lean builds were evaluated.

## Actual functions and principal removal

The domain is R=132900, x>=4.9e26, y=x/49>=1e25 and |delta|<=8R/qt(q). The source has qt(q)>=2, so the star twist |delta/49|<=4R/49<1200000. Also q<=2R=265800<300000. These retain the principal Cor713 and coprime-removal domains for every scale, not only at the lower endpoint.

Write F for the unrestricted etaU coefficient sum at scale y and F'_q for its coprimePart. The actual normalized additive nonprincipal contribution is

    u_b = F'_q(b/q+delta/x)/y - a_q F'_q(delta/x)/y,
    a_q = mu(q)/phi(q).

Subtracting a_q times the actual etaU Fourier main term from F(b/q+delta/x)/y leaves u_b plus

    v_b = (F-F'_q)(b/q+delta/x)/y
          + a_q [F'_q(delta/x)/y-Fourier(etaUC)(-delta/49)].

This verifies the placement of the factor a_q. The inner principal error and inner removal have this factor; the outer removal does not. In particular nonsquarefree q deletes the principal projection but does not delete the outer correction.

`ArcCharsStar.coprime_split_star:84ff` and `norm_S_star_sub_coprime_le:100ff` actually give the stronger removal bound 1e-12 on the normalized scale. Weakening each to 2e-9 is legitimate. The principal-only body at `ArcCharsStar.lean:225ff`, invoking `cor_7_1_3'` at modulus one, has unrestricted error at most 1e-17+4.7e6/sqrt(y). The rational lower square-root witness 3.16e12 and y>=1e25 make this less than 1.5e-6. Hence the proposed

    |v_b| <= 1.502e-6 |a_q| + 2e-9

is valid under the retained principal-RH input. The current bundled source statement still has its PlattGRH wrapper; the principal-only localization remains a formal implementation obligation. This review does not import the whole bundled nonprincipal estimate or assert that wrapper has already been removed.

The earlier exact finite-character Parseval identity includes inverse-character labels, Gauss weights and the factor 1/phi(q). Its E_q is a **sum** over unit numerators, not an average. The new proof does not change that definition or require a new root-phase convention.

## Fourier normalization and weighted norm

All norms in the new note use counting measure on q,b and Lebesgue measure ddelta on the finite intervals. With physical beta=delta/x, Sp=x*s and the star residual equal to y*(u+v),

    Wstar = (x^3/49^2) * integral |s|^2 |u+v|^2.

Similarly physical plus X and Z divide by x to give the dimensionless X and Z in the new note. No factor 49 is missing in the plus Fourier integral; P(delta)=Fourier(etaPC)(-delta) uses the plus twist. The star delta/49 appears in the definition of u and its energy, as it must.

From s=a_q P+r, multiplying by a_q gives a_q*s=a_q^2 P+a_q*r. Since phi(q)>=1 and |mu(q)|<=1, the second term has norm at most sqrt(Z)<.006. The square of the first norm has weight

    card(Bset q) * |a_q|^4 = phi(q)*mu(q)^4/phi(q)^4
                              = mu(q)^2/phi(q)^3.

`MajorTotal.card_Bset_eq:162` and `norm_moebius_div_sq_le:166` provide the actual counting/Mobius normalization. `EtaPlusL2.integral_norm_sq_fourier_etaPC:148` identifies full Fourier energy with integral etaPlus^2, and `integral_sq_etaPlus_bounds:115` bounds that integral by .640208. Restriction to each finite interval preserves the upper bound. These smoothing statements do not use nonprincipal RH. Thus the phi^-3 weight and the absence of an extra numerator average are correct.

Multiplying the pointwise v bound by |s| and applying scalar domination and L2 Minkowski proves

    ||s*v||_2 <= p1 ||a*s||_2 + d0 ||s||_2.

The previously reviewed plus target supplies Z<.006^2 and X<=j=8.79 on this same tagged space. They are conditional actual-function inputs; this review has not proved the plus target. The new integrated constant pbar is not a pointwise constant and is not to be multiplied by sqrt(j) a second time.

## Finite Euler-product bound

For squarefree q, phi(q) is the product of p-1 over its distinct prime divisors. Injecting these finite factor subsets into all subsets of primes at most 2R bounds M3 by the indicated product. The empty subset accounts for q=1; the p=2 factor is exactly 2 and accounts for possible even squarefree factors. No bijection between Qset and every subset is asserted or needed.

The odd-prime map p to (p-1)/2 is injective into positive integers. Its term is 1/(8k^3). The author's decreasing-integral bound gives sum k^-3<=3/2. An independent fully finite alternative is

    1/k^3 <= 1/[2k(k-1)] = (1/2)(1/(k-1)-1/k), k>=2,

since k^2>=2(k-1). Telescoping bounds every finite sum from k=2 by 1/2. Adding k=1 proves the same 3/2 bound for every finite prime set without a numerical zeta value or even an infinite-series interchange. Therefore the odd-prime weight sum is at most 3/16.

For a finite list of nonnegative weights with total S<1, the author's induction proves product(1+u)<=1/(1-S); denominators stay positive at every prefix. It follows that M3<=2/(1-3/16)=32/13. This argument does not need certified individual primality data, an enumerated prime list, infinite Euler-product convergence or RH. It uses standard unique factorization, totient multiplicativity and Mobius squarefree support as mathematical library inputs; their formal assembly into this new inequality is still needed.

## Exact budget and rows

Independent rational comparisons give

    .640208*(32/13)<1.256^2,
    ||a*s||_2<1.256+.006=1.262,
    p1*1.262+d0*3=1.901524e-6<1.902e-6.

The old nonprincipal main/residual split still gives ||s*u||_2<=sqrt(A)+rho*sqrt(B), including the same-modulus bound max_b|u_b|^2<=E_q. Combining it with the preceding principal estimate by Minkowski includes every cross term. It does not use an independence assertion, cancellation, or an L4-from-L2 inference.

For each row the independent checker formed the positive rational reserve

    r = (3.67e-6)*2.964 - 1.902e-6 - sqrt(A_bound)

and verified r^2-rho^2*B_bound>0. Since 2.964^2<8.79, this proves the required Wstar inequality. The exact squared reserves are:

| A bound | B bound | Positive squared reserve |
|---:|---:|---:|
| 9e-12 | 45 | 72815121/156250000000000000000 |
| 4e-12 | 62 | 64344859/625000000000000000000 |
| 1e-12 | 81 | 3387437/19531250000000000000 |
| 0 | 102 | 423419859/625000000000000000000 |

All four are alternative sufficient allocations, not evaluated energies. The last requires A=0 because A is nonnegative. The first increases the previous B<=9 allowance to B<=45 without changing the plus target, principal height, source functions or final integrated-cubic budget.

Even at A=0 the weaker ceiling using sqrt(j)<3 is 9217296/87025<117.6. Consequently the previously inspected direct-sieve comparison tending above 117.6 remains insufficient for this allocation. This is a statement about those sufficient comparison expressions, not a lower bound on B, a disproof of these targets, or a universal obstruction to other methods.

One additional **conditional consequence**, not an edit to the frozen author note: the earlier statistic bounds Q_A<=4/(7*10^18), Q_B<=4/(7*10^6), with G=7000000, give sqrt(G Q_A)<=2e-6 and sqrt(G Q_B)<=2. Keeping T_A<=1e-6 but relaxing the previously sufficient T_B<=1 to T_B<=4 yields A<=9e-12 and B<=36<45. Thus the improved principal treatment permits a fourfold remainder-norm allowance for B with those same finite statistics. No new bound on actual T_B is established; the full-strip Gram/window domains, actual finite statistics and uniform high-tail remainders remain required.

## Acceptance limits and pins

The proof is uniform on the stated continuum of x and delta. It supplies no actual A, B, Q_A, Q_B, plus energy, or tail certificate. It does not settle the independent base-gap target, the lower major-arc energy, the selected principal/head certificate obligations, physical arc assembly, or formal checking. Neither an aggregate numerical saving nor a runtime conclusion is inferred.

Paths below are relative to `work`, except owned evidence under `qrh-campaign/agents/prime-estimates` and Lean paths under `ternary-goldbach/TernaryGoldbach`.

| Artifact | SHA256 |
|---|---|
| `qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md` | `22A6A16880BE2FA5CB0FF393C533BD60B1AFCD32C751E5A0D64FE7ADAB7C40F7` |
| `qrh-blueprint/check_weighted_principal_wstar_20261111.py` | `C11E879B7E7996991BD955089AB9A4D5CE00401D65FB5DEBB24E4FBE6B8D52EF` |
| `qrh-blueprint/weighted_principal_wstar_20261111.json` | `EBB08B9D8FDDA3055E89ECBF9F8AF33FBE2ECD4A2D73E5A100D686CC02554D37` |
| `qrh-blueprint/INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md` | `943DE38EE628CFA9E7221100E75933D101C7593B613945F19B7CBDF90E97C128` |
| `qrh-blueprint/PLUS_RESIDUAL_TO_MAJOR_L2_UPPER_2026-11-11.md` | `F3EBC1B68CC57B607496D9E6445137A08A0F17C3202D986301F8EC25F14F4663` |
| `qrh-campaign/agents/audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md` | `AFDBBF90157F5170666C481D512D475A1F719366C8FB785D312A213864C38D0B` |
| `qrh-campaign/agents/independent-feasibility/REVIEW_WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md` | `85849ED642AEED600A71F41E56D4C7DC86ACAB23F338E19979CD15B58B8D60DE` |
| `qrh-campaign/agents/audit/DIRECT_STAR_B_SOURCE_OBSTRUCTION_2026-11-11.md` | `8C137D3E513B732E9664447F069539B8643B6678E6EAC57FFC706DFCD50A06FE` |
| `MajorArcs/MajorTotal.lean` | `106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A` |
| `MajorArcs/ArcCharsStar.lean` | `B95DE4A83BAF37008B21FCFF90A0188AA230548C8776DE6C5F2905C19DA9DF10` |
| `MajorArcs/Cor713.lean` | `11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433` |
| `MajorArcs/EtaPlusL2.lean` | `0E86FF780F7F4A817F3093787D24D0C5DC10290B56B8555C7EA62362E049D949` |
| `review_weighted_principal_wstar_scalars_20261111.py` | `986FAE9C1053C6FD2BAF0D156B03D60BFAC509D39CE7BA35665D7C99AD47BDDB` |
| `review_weighted_principal_wstar_scalars_20261111.json` | `12B463F2CAF5D5043A728F1F43E8CB9249A7A886159DF2099DEA0E67AEBC39B6` |

The owned script reads the frozen JSON but imports no producer code. Its 35 checks concern rational constants, source-domain inequalities and the four norm allocations only. Paper identities and the actual-function semantics were checked separately above; they are not inferred from a PASS string.
