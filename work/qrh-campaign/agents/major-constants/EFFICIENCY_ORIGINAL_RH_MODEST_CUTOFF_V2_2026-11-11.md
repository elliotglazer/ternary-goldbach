# A modest major-arc cutoff reduction in the original finite-RH route — corrected version 2

2026-11-11. Paper/source derivation with exact rational scalar checks. Source baseline: `work/ternary-goldbach`, HEAD `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean source was changed or compiled; no prime, zero, or L-function values were evaluated. This is a separate report from `EFFICIENCY_MAJOR_CUTOFF_THRESHOLD_2026-11-11.md`: that earlier report used the QRH route. This report does not use its .555 strip, global 7/8 bound, .65 energy replacement, or 1.0404 major constant.

**Version correction.** Independent reviewer qrh_integration found that the v1 scalar parser matched only `Y := 1e...` and did not bound its search to the current theorem. It therefore skipped cell1's actual `Y := 3e25` and used cell2's `1e26`, understating cell1's bound. The v1 report SHA `D4CA567BCAFAC04709B18B1B0EF892721C473B32F51C2901086A5ED609D8F03F`, script and receipt are preserved unchanged but are superseded for all-cell acceptance. This version uses a new script and receipt: each theorem section ends at the next theorem, exactly one complete scientific literal is required, all nine actual Y values are asserted, and the source section hashes and parsed values are serialized. The corrected R140000 cell1 upper bound is G<=.0616144 and minor<=1.0100535. Cell0 still controls the global bound, so the final table and conclusion below are unchanged. No source proof or analytical estimate was altered.

## Result and exact scope

The original finite-RH argument admits the paper-level candidate **R=140000**, retaining the original smoothing, the domain x>=4.9e26, and both final constants

    major >= 1.049*x^2/49,     minor <= 1.0376*x^2/49.

The rational check actually gives major>1.0492 and minor<1.031819 in these normalized units. All nine finite scale cells and the asymptotic branch are covered. This is not an assertion that the existing hardcoded Lean theorems already accept R=140000: their arc, spectral-hypothesis and numerical interfaces must be generalized as specified below.

Consequently the existing final nonprime argument and positivity are unchanged at N>=1e27. The independently reviewed threshold weakening to N0=989*10^24 also composes: it proves x>4.9e26 at that endpoint and preserves the original nonprime proof. No extension of the first numerical cell below its old x floor is used.

The smaller nonprincipal spectral domain is conditional on localizing the actual finite-RH premises, rather than retaining `[Fact PlattGRH]` through old wrappers. The mathematical reconstruction below supplies the new minor-domain estimate; it does not transfer an omitted annulus using the removed characters. No successful finite-RH computation, lower runtime, or strategy adoption is claimed.

## 1. The original spectral contract and the restricted domain

`MajorArcs/GRH.lean:32` defines GRHUpTo using the actual Mathlib L-function: every zero with 0<Re(s)<1 and inclusive |Im(s)|<=T lies on Re(s)=1/2. The original height supplier at lines43–67 is:

* odd conductor c: T=1e8/c;
* even conductor c: T=max(1e8/c,200+7.5e7/c).

For this candidate retain these heights for every primitive character at odd c<=R and at 4|c<=2R. Conductor1 and all other original principal prime-estimate requirements are unchanged. Inverses are included because the contract quantifies over every primitive character. There is no primitive conductor with exact 2-adic valuation1.

The source arcs have q-tilde=q for even q and 2q for odd q, and Q_R={q>=1:q-tilde<=2R}; see `LargeSieveWeights:26`, `LargeSieveArcs:34–40`. A character inducing a term on an arc has conductor c|q. If c is odd then c<=R: for odd q this follows from q<=R; for even q, q/c is an even positive integer, so c<=q/2<=R. Even primitive c has 4|c and c<=2R. This is also the domain needed in the base-gap proof. When generalizing `BaseGap2.gap_point:185`, retain q-tilde<=2R from `mem_majorArcs_iff`, rather than throwing it away and retaining only q<=2R.

`Thm714`'s primitive cases (lines568–690) use precisely the original odd/even heights, including the 200+7.5e7/c branch above c=125000. `Cor713.cor_7_1_3` (lines802 onward) uses only 1e8/c. The reduced arc widths do not enlarge their twists: |delta|<=8R/q<=1.2e6/c, and the plus normalization similarly remains inside its old case bounds. Reuse the proofs with these local RH assumptions, not their global PlattGRH instance.

The large-sieve and higher minor levels do not introduce finite-RH assumptions for their larger rational denominators. In particular `LSQuot3:35–51` uses PlattGRH through the principal estimate `psiN_le`; keep that principal dependency. The original Type I/II and total-energy bounds are retained. This is not a claim that all imports bearing PlattGRH can simply be deleted.

## 2. Recompute lower J; do not inherit the old rounded lower bound

Write mPhi(q)=mu(q)^2/phi(q). For even R in this report, the old pairing argument in `SumMuPhi:69` gives

    S_R := sum_{q in Q_R} mPhi(q) = 2 sum_{odd q<=R} mu(q)^2/phi(q).

The old finite mass certificate at `SumMuPhi:108` is S_150000>=13.597558 and <=13.59756. For odd q<=150000 there are at most five distinct prime divisors, because 3*5*7*11*13*17=255255. Thus q/phi(q)<=15015/5760=:C. Convexity of 1/t gives 2/q<=integral_{q-1}^{q+1}dt/t. The disjoint odd-centered intervals tile [R,150000], so

    S_R >= s_R := 13.597558 - C*log(150000/R).                 (1)

The rounded-up log used by the script only weakens this lower bound. No new summation over characters or spectral data enters (1).

The proof body of `L2Major.Jq_bounds:99` remains valid on the reduced arcs. Its geometry needs wx>=4 and 2w<=1200000/x; now wx=8R/q-tilde>=4 and 2w<=8R/x<=1200000/x. Its actual lower bound per q is

    (.63907-.000962)*mPhi(q)*x - 3.6e-9*x.

Hence, using the conservative cardinality bound |Q_R|<=300000,

    J_R/x >= jfull_R := .638108*s_R - .00108.                (2)

The upper bound J_R<=8.79*x also remains valid by summing the same upper estimates on this subset with the old upper mass/cardinality bounds. This does not use monotonicity of a complex major integral.

For the actual prime-supported sum a1 used by the minor arcs, repeat `MinorTotal.I0_ge:277–316` with t=1e-5. The nonprime coefficient energy is <=8e-11*x on the whole period, and therefore on the new arcs. The full norm-square triangle inequality gives

    I_R/x >= j_R := (jfull_R - 100001*8e-11)/1.00001.        (3)

At R140000 this gives j_R>8.56077. Neither 8.6294 nor 8.6296 is used as the new lower bound. The gain over the old rounded lower bound comes from retaining the more precise existing Jq constants, not a new L-function estimate.

## 3. Original major consumer, including all error terms

The singular-series proof `Singular.expansion_ge:298`, product lower bound at440 and positive product upper bound at570 yields, for these R>=200,

    C_R >= 2*(.6606*(1-1/199) - 22.1/R).                     (4)

Generalize the odd/even pairing in the proof; its error tail is 22.1/R. The nonnegative squared-weight sum still has upper bound2.85, and S_R<=13.59756. The original `MajorTotal.per_modulus` and `major_total:974–1054` then give normalized lower bound

    .800689*C_R - E,
    E = (3.67e-6 +49*8.85e-7/9)*8.79
        +(9*8.85e-7*7.78/2 +49*2.03e-5)*2.85
        +49*8.85e-7*.640208*13.59756/9.                      (5)

Every error in (5) is retained: plus/star approximation, upper J, squared Gauss/Mobius weights, Fourier comparison and finite-arc tail. Their local proof conditions wx>=4, q<=300000 and x>=4.9e26 were preserved above. Coprime removal is part of the original per-modulus bounds. Formula (5) exceeds1.0492 for all four rows below, so the old final constant1.049 survives.

## 4. New minor domain, original energy and base gap

Use the actual domain (0,1] minus majorArcs(8,R,x). The total prime coefficient energy is bounded by the original `MinorTotal.T_le:216`, with

    sig(x)=(.640208+366.91/sqrt(x))*log(x)-.021095,
    Dx(x)=log(2*sqrt(x/784))+1.33258.

There is no replacement by .65*x. The generic large-sieve result `Thm1321.thm_13_2_1_repaired:153` permits R>=100000, with the original r2 and size conditions. Its base mass is now (3).

The star-sum base gap is rebuilt from `BaseGap2.norm_S_etaStar_le_gap:240` using the restricted characters described in section1. The gap has

    4R/(49q) <= |delta| <= 8R/q,    q<=2R.

The original Fourier bound, q/phi(q)<5.53, character error E1<=1.4874e-6, removal error D/y<=2e-9, and sqrt(q)<=548 imply

    |S_etaStar|/y <= 1.016*49^2*5.53/(8R)
                       +548*(1.4874e-6+2e-9)+2e-9 < .014. (6)

This replaces the old .0121 base-gap scalar; it is not silently inherited. It is still below ghatY(y,R). Indeed log(2R)>12, sqrt(2R)<548, Rfunc(y,2R)>=.41415, and Fr(R)>3 imply

    ghatY(y,R) > 1.398*((.41415*12+.8764)*1.7+2.526)/548
               > .03.                                    (7)

Here Fr>3 follows from exp(gamma)>=1 and v+2.50637/v>3 for v=loglogR>0. Thus the original decomposition into the base gap and higher minor levels is valid with the new R.

Let G_y(n)=ghatY(y,n) and s=sig(x)/Dx(x). The new numerical expression is

    G_y(R)*(cL(R)*s-j_R)
      +s*sum_{R<n<r2}G_y(n)*log((n+1)/n)
      +G_y(r2)*(sig(x)-cL(r2-1)*s).                         (8)

No omitted annulus is bounded using the old major pointwise theorem. Instead use antitonicity of G_y and the exact telescoping sum on R<n<=150000. Since cL(n)=log(2*(n+1))+2,

    cL(R)+log(150001/(R+1)) = cL(150000).

Consequently (8) is at most

    G_y(R)*(cL(150000)*s-j_R)
      +the unchanged old chain above150000 and its tail.   (9)

This is why the existing numerical chains are reusable while the old minor theorem is not. All their prime inputs and original principal RH dependencies remain; they do not consume the removed nonprincipal conductors.

For each of the nine cells in `NumericsCells`, the corrected script reads its rational s, cL, chain and tail bounds, and constructs a fresh upper bound on G_Y(R) using the exact premises of `NumericsCore.ghatY_le_num:55`. Their asserted Y values, in order, are 1e25, 3e25, 1e26, 1e27, 1e28, 1e30, 1e34, 1e42, 1e58. Positive atanh log series with an explicit geometric remainder, integer root brackets and directed rational rounding supply those premises. In particular Y>=1e25, R>=670, R<=floor(cuberoot(Y))/6 and positive denominator logs are checked. `ghatY_mono_y:145` extends each value across the whole cell. The asymptotic branch at `NumericsAsymp.asymp_goal:385` retains s<=1.2947, chain<=.165282706731081808+.00084+1.398e-10 and tail<=.00022, with a fresh G_1e58(R). Thus this is a continuum certificate, not endpoint sampling.

Finally apply the unchanged prime-power split in `MinorTotal.minor_total:323`:

    minor coefficient <=1.0005*(9) +2001*22.75*8e-11.       (10)

The same exact code checks every finite cell and the asymptotic branch against1.0376. The following displays weaken the certified bounds in the safe directions:

| R | lower I_R/x | lower major coefficient | upper minor coefficient, all x>=4.9e26 |
|---:|---:|---:|---:|
| 150000 | 8.67553 | 1.0492 | 1.004895 |
| 148000 | 8.65320 | 1.0492 | 1.010050 |
| 145000 | 8.61914 | 1.0492 | 1.017991 |
| 140000 | 8.56077 | 1.0492 | 1.031819 |

The script's `ceil_1e7` is always an upper display of its exact rational field, even for a field named `lower`; it must not be quoted as a certified lower bound. The lower displays in this table are rounded down separately. The old rounded minor target1.0376 is preserved; no downstream theorem needs the stronger displayed minor constant.

## 5. N0 composition, final positivity and actual work saved

The frozen `EFFICIENCY_LOWER_ANALYTIC_THRESHOLD` and its independent review already check the source weakening to N0=989*10^24. Explicitly

    c0=2+9/(196*sqrt(2*pi)) <989/490,
    (989/490)*(4.9e26)=N0,

so N>=N0 implies x=N/c0>4.9e26 and y>1e25. The first cell and every square-root error used here are therefore unchanged. The accepted weakening checks (6.9)^32<N0, (2.64)^64<N0, N0>1e26 and the full original nonprime/crude-positivity proof. This script repeats the three elementary threshold comparisons, but does not replace that source audit.

Since this report preserves major1.049 and minor1.0376, the original strict nonprime comparison below .0114*x^2/49 suffices without any revised final constants. The optional stronger .00271 allowance recorded in the receipt is also valid at N0 by the earlier report, but is not needed to close the theorem. The actual circle integral, nonprime removal, parity and positive representation extraction remain the original `Inputs`/`Main` consumers, with the new arc partition and localized finite-RH supplier.

Compared with the already restricted R150000 original family, R140000 removes odd indices 140000<c<=150000 and multiples of4 with280000<c<=300000. It reduces eligible nonprincipal conductor indices from149999 to139999; these are index counts, not primitive-character counts, zero counts or operations. Heights of retained characters are not reduced. A production manifest must count actual primitive rows with those heights before claiming a spectral workload reduction. Relative to the full original Platt hypothesis, localizing the family itself is a separate required refactor.

At fixed N and binary cutoff B, this R change does not enlarge the explicit-prime-chain target N/B. It adds no finite interval requiring a new ladder. If the separately accepted N0 weakening is also implemented, its existing 61484-chunk partial ladder plan replaces62168 old chunks; this report adds no further ladder saving. No principal finite-RH height or uniform prime-gap certificate is altered.

## 6. Remaining proof work and verdict

The numerical and paper implication closes for R140000 at the old x floor. It still requires new source-level interfaces: parameterized Q_R/arc decomposition and disjointness; local finite-RH inputs in Thm714/Cor713 and their character consumers; the recomputed J_R/I_R and singular-series bounds; the base-gap proof (6); and the new numerical goal (8) consuming the old chains as scalar lemmas. Endpoint sets are the original open arcs and measurable (0,1] partition; omitted arc endpoints have no spectral interpretation and all count/character domains above are inclusive.

Keeping the old `[Fact PlattGRH]`, `minor_total`, `I0_ge` or `major_total` as black boxes would not establish the advertised family reduction. Conversely there is no remaining numerical failure in the checked all-consumer envelope. This is a conditional candidate for independent review, not a validated provider, compiled formal theorem, measured speedup, or recommendation to adopt it.

## Frozen source and scalar pins

Paths below are relative to the workspace root. Source SHA256 pins identify the proof bodies used; they do not assert compilation or foundational validation.

| Path | SHA256 |
|---|---|
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/GRH.lean` | `89C6DF8490955EEA8F4141498BCA6D163355C2E7765C9ECD09F8CEE5B257A070` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Thm714.lean` | `7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Cor713.lean` | `11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcChars.lean` | `0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcCharsStar.lean` | `B95DE4A83BAF37008B21FCFF90A0188AA230548C8776DE6C5F2905C19DA9DF10` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/L2Major.lean` | `8C9424D92074ABB35DF00273D598F5A3F95C49A34F07F4146DD83FD2B6F3A5FC` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/SumMuPhi.lean` | `7AC4662598355DDA40720B43956223BD3C5456D503B206A77D48E4569ADE18A4` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Singular.lean` | `152DC0302216E9E2B23E9DFCA7FE1BCA2087F275662F9988FC524D101C1B8DB9` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/MajorTotal.lean` | `106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/LargeSieveWeights.lean` | `4577368FF4AD237E00D04259B813AFE2755ED165766070711CA33FB75E6F2304` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/LargeSieveArcs.lean` | `0794C8853D9B1AA91EFEC3C9D91F5F1EFCECB98B484C701C360DD8EF5AC592BF` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap.lean` | `ABF8667E1A8D5C72AA81F1B3F40481933A1ABC5A1CE3FAA0BE9705AC8CAF418B` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap2.lean` | `AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/MinorTotal.lean` | `6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/LSQuot3.lean` | `4E1105C3A734EF94CBFFA81AF2128D0525092F95F0E4E6F8B8ED8E0B983542BD` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/Thm1321.lean` | `46E2E0919EEC0310EFCA401EFA7DD7FD9C7690E1337BB5996A6597DDDA342F2A` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/NumericsCore.lean` | `4E2D5351E5BFD0350FBD3B378B123CA1F7155943D467CB4788554800B657F6F8` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/NumericsCells.lean` | `5192960AD541DCF981C630F538B35EC63FE966A61044AF31576AB83C93A41139` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/NumericsAsymp.lean` | `8A07C9A4D8822D4EB1680DF8E382308260CC62B92B8A7AB5C708B3B3F58243FF` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/NumericsFinal.lean` | `27DB90B71D4B3ACBF7F3BB84374733A4E9601170A770C83E8006CCB2465B95A4` |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/Inputs.lean` | `5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83` |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/Main.lean` | `DD5E20E51EC7C699CAC00A497C34FEF687E7E5B4562D3B1D8B981ECE54F4261D` |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/Numerics.lean` | `059874D201ECC571583118A56BA6193D6D8B49016C227988CBC83FA0F34648DB` |
| `work/qrh-campaign/agents/major-constants/EFFICIENCY_LOWER_ANALYTIC_THRESHOLD_2026-11-11.md` | `99D06335D5F8AF1D9AB0916A84BB60AE2ECF060B5FDF04C0134AB9BCB860F786` |
| `work/qrh-campaign/agents/audit/REVIEW_LOWER_ANALYTIC_THRESHOLD_2026-11-11.md` | `CA5489EB8F7357CC4E4FC73FC96FACF700388DD513D3BC84495A246892FFD7D8` |
| `work/qrh-campaign/agents/major-constants/original_rh_modest_cutoff_scalars_v2_20261111.py` | `69B5CB77F324040E534DAD50B76E489F24F51AB2B79DA34AE09477E72F711C99` |
| `work/qrh-campaign/agents/major-constants/original_rh_modest_cutoff_scalars_v2_20261111.json` | `7E3136E7DCE05A89022B12EEE7CE9A3B94B0AF1E83B3FF413319E4701300FC50` |
