# Principal RH height under the current arithmetic consumers

Date: 2026-11-11. Source/paper research only. No Lean build, source change, analytic value generation or new spectral certificate.

## Finding

This audit does not establish a smaller complete principal RH target. The current original-RH route uses principal RH through 100000000 in arithmetic estimates that survive the reduced nonprincipal family and the R=132900 major-arc cutoff. Reducing the principal plus/star remainder alone therefore does not reduce the complete requirement.

The clearest quantitative restriction is the chosen Gaussian unsmoothing recipe for `psi_plateau8`. With K=7 and the natural retuning delta=7/H, its sufficient relative upper-error expression already exceeds 49/H before the other positive errors. Keeping its 4.91e-7 allowance requires H>49000000000/491, between 99796334 and 99796335. This restricts that recipe and allocation, not the true error of psi and not all possible proofs. In particular K is adjustable; no optimization over K and delta is claimed here.

One lower-level restriction can be removed on paper: the off-line remainder in `WeilWindow.off_line_leH` admits the same `OffC` for H>=2000000, rather than H>=100000000. Section 4 gives the proof. The other arithmetic restrictions remain, so this is an adapter for later work, not a new complete spectral target.

## 1. Exact principal input and direct major-arc uses

Source locations below are relative to `work/ternary-goldbach/TernaryGoldbach/`; the final ledger pins their bytes. `Explicit/ZetaZeroSums.lean:21–29` defines `RHBelow H` using actual zeta zeros with 0<Re(s)<1 and |Im(s)|<=H, then extracts `rh_upto_1e8` from `Fact PlattGRH`. The predicate does not request a high-height zero list, simplicity, a reciprocal moment, or an exact zero count.

| Consumer | Actual input and restriction | Consequence of changing H |
|---|---|---|
| `MajorArcs/Prop942.lean:53–114`, `prop_9_4_2`; `Thm714.lean:572–589`, `thm_7_1_4_one` | Principal normalized plus error at x>=4.9e26, |delta|<=600000, currently H=1e8. Generic proposition requires H>=200+max(10*pi*|delta|,50), then uses the full height-dependent error. | Geometry alone allows a lower height. At the reduced principal arc |delta|<=4R=531600, it asks for 200+5316000*pi. This is not an error-budget proof. Both Gaussian tails in `errPZ` and their integrated consumer still need new bounds. |
| `MajorArcs/Cor713.lean:774–850`, `err933Z_le`, `cor_7_1_3'` | Star estimate at y>=1e25. Principal scalar envelope currently uses H=1e8, |delta|<=1200000 and bound 1e-17+4.7e6/sqrt(y). | The source geometric requirement H>=max(10*pi*|delta|,50) is weaker than 1e8. It does not establish that the old scalar envelope survives. Use the actual reduced arc domain in any replacement, retaining its reduced-modulus conditions. |
| `MajorArcs/Prop715.lean:230–364` | The phi1/phi2 explicit-formula errors and principal coefficient-energy theorem need principal RH only through 500. | A genuine low-head use; it does not require 1e8. |

The source extraction from a blanket `PlattGRH` assumption should eventually be localized to these exact predicates. Such localization cannot erase uses of `rh_upto_1e8` deeper in the arithmetic estimates below.

## 2. Surviving theta, psi and Mertens requirements

### Finite ranges and the unbounded theta statement

`Explicit/PsiRanges1e8.lean:20–1188` proves 22 adjacent, closed real-x ranges from 1e6 through 1e17. Each specializes the generic certificate at H=1e8 and Y1=4.9e7, with explicit smoothing parameters and scalar certificates. `Prelim/PsiTwoSided.lean:18–79` combines these with low finite arithmetic into `psi_two_sided` for integer 12<=n<=1e17. The old window condition Y1+13<=H/2 alone requires H>=98000026 if Y1 is kept fixed. A smaller H requires a new Y1 and all affected tail/certificate bounds. Existing range outputs cannot be inferred from a weaker RH premise by monotonicity.

`Prelim/ThetaExplicit.lean:27–31,387–719` proves, for every integer n>=1e12,

    |theta(n)-n| < n/(log n)^3 + epl(n)*n,
    epl(n) = 4.92e-7 when 120<log n<20000, and 0 otherwise.

Its finite branch uses the above cB table through 1e17. Its remaining branches explicitly consume `psi_plateau8`, `psi_range1_8`, and `psi_asymp8`. The final two handle log n>=20000 and log n>=35000 respectively. The source also integrates the plateau contribution in `sum_epl_div_le` and `epl_mul_log_le` at lines731–837. Its height dependence is therefore carried into finite constants as well as pointwise estimates.

### The plateau restriction

`Explicit/PsiPlateau1e8.lean:104–203` establishes

    |psiR(x)-x| <= 4.91e-7*x + 1145*sqrt(x) + 4.2e10,  x>=1e17.

The chosen parameters are delta=7/1e8, K=7, y0=1e10. The upper-unsmoothing step uses

    [exp(delta^2/2 + K*delta)*x + ErrGH] / [1-2*exp(-K^2/2)]

plus the low-end correction. The displayed `ErrGH` majorant has only nonnegative terms, including 2.48e-10*x. For a retuned H with delta=7/H and the same K, set q=2*exp(-49/2), so 0<q<1. Already

    exp(delta^2/2+7*delta)/(1-q)-1 > 7*delta = 49/H.

This follows from exp(t)>=1+t and division by 1-q<1. Consequently keeping the displayed sufficient coefficient 4.91e-7 requires H>49000000000/491. Even the weaker requirement 49/H<4.92e-7 forces H>49000000000/492, between 99593495 and 99593496. Neither inequality is sufficient, since the tail and other positive terms have not been paid.

These statements concern retuning delta=7/H. If delta stays fixed while H falls, K*delta stays fixed but the off-line tail changes with delta*H; the above reciprocal obstruction is not the appropriate argument. If K also changes, both the smoothing displacement and exp(-K^2/2) loss change. A joint K/delta proof is a legitimate next experiment, with all upper/lower and finite-range errors retained.

### Unbounded domains cannot be discarded

`Explicit/PsiLarge.lean:42–80,121–205,373ff` splits the zero sum at H and uses a zero-free bound above it. The source requires H>=1e8. `Explicit/ZeroFreeRegion.lean:421–554` proves beta<=1-1/(11*log|gamma|) only for |gamma|>=1e8; its body uses log|gamma|>=18.4 and small rational error bounds from this threshold. This is an analytic restriction of the proved estimate, not merely an inherited `PlattGRH` binder.

`Explicit/PsiRange1.lean:415–477` uses the H=1e8 split to obtain the 2.1e-14 relative bound for every x>=exp(20000). `Explicit/PsiAsymp.lean:542–645` obtains the 0.2*x/(log x)^3 bound for every x>=exp(35000), again splitting at H=1e8 and higher analytic cutoffs. Lowering H leaves an annulus (H,1e8] that needs an explicit replacement estimate, or a separately proved lower-height zero-free bound. The fixed relative plateau cannot replace a decaying log-power bound for unbounded x.

### Downstream uses are actual estimates

| Source | Surviving mathematical output |
|---|---|
| `Prelim/LambdaMu.lean:306–352,761ff` | `psi_bounds`, `sum_vonMangoldt_lt`: global 1.03883*y upper bound; `sum_vonMangoldt_nonprime_lt`: 1.4262*sqrt(y), for all y>0. The proof recurses above 1e17 using `theta_explicit`, rather than truncating its domain. |
| `MinorArcs/EBound.lean:218–247`; `TypeI2Large:44`, `TypeI2Proof:753`, `TypeIIReduction:388` | These global prime/prime-power estimates enter the minor-arc coefficients and dyadic tail. EBound explicitly applies the nonprime estimate at 2^(j+1)*x for unbounded j. |
| `Prelim/MertensProduct.lean:363–545,639` | A separate Gaussian explicit-formula window uses delta=8e-8,H=1e8 and `TailB_win_le<=3e-13`; `E1_win_num` and `E1_var` preserve numerical variation bounds, in addition to consuming theta/epl. |
| `Prelim/MertensProduct.lean:942,1997,2220,2258` | Primorial estimates assemble into `div_totient_lt`: q/phi(q)<exp(gamma)*log(log r)+2.50637/log(log r), for r>=max(3,q). |
| `MinorArcs/BaseGap2:343`, `FirstChoiceTypeII:153`, `GBound:89`, `LSQuot3:121`, `SecondBridge:58`, `SecondTypeIIa:172`, `SecondTypeIIb:216` | Actual consumers of that totient bound. A finite small-q replacement may cover a particular base-gap call, but it does not automatically cover the other variable-q/r calls. |
| `Prelim/MertensLimit.lean:45,370`; `EOneBound.lean:136–270,462`; `EOneRanges.lean:20–153` | The smoothed E1 estimate uses the Mertens limit and another explicit H=1e8 zero-sum bound before producing numerical E bounds. Large smoothing delta can make this a less restrictive use, but its existing proof cannot simply be relabeled with a lower H. |

The newer etaU coefficient-energy application reuses `theta_explicit` and the LambdaMu outputs. Replacing one major-arc error does not remove this arithmetic route. The unchanged lower threshold N0=989*10^24 is a lower bound on the final odd input; it supplies no upper bound on the x,y or dyadic variables in these theorems.

## 3. Head facts and blanket wrappers

Principal RH through H implies RH through any smaller nonnegative height; it does not imply a particular zero count or reciprocal sum. The RH500 use of Prop715 is a selected original-source head requirement. `Explicit/IEANTNBridge.lean:22–35` also packages RH through 1894438.5122, but a repository search found no call of its exported `riemannHypothesisUpTo_of_platt` outside that file; it is not asserted here to be an independent selected-root consumer.

The separate damped common-psi route has additional exact N1500=1069 and Q1500<1.668 data, plus shared-strip/global hypotheses. Those remain real obligations where that route is selected. They do not appear in the original psi/plateau/Mertens bodies traced above, and they cannot be substituted for them without importing and verifying the rest of that different proof. Conversely an RH-only principal receipt must not be advertised as establishing these exact head statistics. Analytic window/count bounds such as `Z3g BPz2 H` are also distinct from a certified exact zero count.

## 4. A complete lower-height off-line window adapter on paper

Keep every premise and the conclusion of `Explicit/WeilWindow.lean:99–234`, except replace 1e8<=H by 2e6<=H. In particular H<=3e10, 0<ell<=1, integer m>=2, |T0|<=H/2 and T>=1 remain. This lemma bounds a finite sum of actual zeros strictly above H, with true multiplicities; it does not assume RH itself.

The existing proof bins by floor((|gamma|-H)/4.4). It gives the same pointwise majorant and count bound

    E*f(k)^2, E=4^m*exp(m*ell)*64, f(k)=1/(H+4.4k)^2,
    count(k) <= 2*Z3g(BPz2,H)+2*c3g(10,H)*(k+1).

`Explicit/ZeroSumGen.lean:81` defines c3g(10,H)=44/(H*log(10/3)). Keep its H dependence. The already proved log(10/3)>=1.2039 implies c3g(10,H)<=36.6/H. The upper-height hypothesis still gives Z3g(BPz2,H)<=210.6. The source's fiber inequalities and finite sum estimate therefore bound the coefficient after removing 4^m*exp(m*ell) by

    F(H)=64*[421.2/H^2+(73.2/H)*(1/(8.8H)+1/H^2)]
                 *[1/H^2+1/(4.4H)].

Writing u=1/H gives a polynomial with positive coefficients in u^3,u^4,u^5. Thus it decreases with positive H. Exact rational arithmetic verifies F(2000000)<1e-15. No logarithm or zero was numerically evaluated. This proves precisely the unchanged `OffC=4^m*exp(m*ell)*1e-15` bound.

The proof of `weil_windowH:259ff` then transfers with the same new threshold, assuming `RHBelow H` and its other hypotheses, including exp(2*m*ell)<2. Its limit is the actual Weil formula; the finite on-line sum is dominated using nonnegative on-line window terms. No default infinite-sum value is substituted. This transfer does not assert that downstream Gaussian/window lemmas with additional hardcoded thresholds have already been generalized.

## 5. Consequence and next bounded proof

The present complete principal target remains 1e8. This audit finds no justification for silently replacing it by the much lower height sufficient for a single plus or star geometric condition. It also finds no mathematical necessity theorem for 1e8.

The most direct next research step is a joint rational K,delta search in the actual upper/lower plateau formulas, with the complete height-dependent tail retained. A successful plateau is only one requirement: re-certify the finite cB intervals, the Mertens/E1 windows, and the missing zero-free annulus or its substitute, then verify all resulting numerical consumer constants or explicitly reallocate them in the unchanged root. Retaining old numerical conclusions is the cheapest interface; changing them requires another complete root-budget check. No QRH7/8 provider or new final-root premise is introduced here.

## Evidence

`principal_height_consumer_metadata_20261111.py` performs nine exact rational checks and hashes 32 source files. Its JSON records the full rational value and positive margin for F(2e6), the two necessary plateau thresholds, and the source ledger. These checks are metadata and elementary arithmetic only, not a Lean verification or an analytic evaluation. The source bodies cited above were inspected; deeper explicit-formula, zero-count and smoothing foundations are reused as source inputs, not proved anew in this audit.

| File | SHA-256 |
|---|---|
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZetaZeroSums.lean` | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZeroSumGen.lean` | `9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/WeilWindow.lean` | `E62BC53DCE170675C2D4814FB47BBC92C5457103A2ABF4F0C66326BD4C2328BE` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiRanges1e8.lean` | `26BDF0EEEAD4C7628B3205ECF1B52BB05A914E492A3721DCA6B784F6FE3C1120` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiPlateau1e8.lean` | `F5BEB066695D24085A74706C9FFE3219A2A053E2C1854FC3E209BD0CD78E392C` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiLarge.lean` | `D370555A164DA01E37E5BDB14EFA774DC79FE43682EED21D42C90BA2D1B165F2` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiRange1.lean` | `F474C24F28ED3D14774A170F19EF312AE132124D727ABD438478C4AF89BBE026` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiAsymp.lean` | `2EEE8AAAC78360010044AB5964058ADB5998FB30EFAC3000352ED6D2114D047D` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZeroFreeRegion.lean` | `AC367CDA6777165DF4AF22BA1BA1530B8A280B77CA55F1918562376DE69C0EAB` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/IEANTNBridge.lean` | `54E839497E66C7444A7B03BA5C62096E7C526BF2999EF5888CC5BB17481D72FE` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/PsiTwoSided.lean` | `9E2790AC0B3707D4A51B79735711BC9D7470694E8BFE6B96762E38F39F929E3C` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/ThetaExplicit.lean` | `F30571CFFF146129180D9A1865BAE879027CB5E1F9BCC4B3C8D1912983A45F93` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/LambdaMu.lean` | `45A40A3209665061FF2F4F28F7CDDD1C012BCEE66FA90E555859A22D38D8568E` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/MertensProduct.lean` | `8182DC2B990DC8D65AC76D3CC55847B26922E2062CD154C14367D5DB97F71A0F` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/MertensLimit.lean` | `B4FBB30EE6BCEEAFE847F14271AA91DCDEB2E735B8176D1083446F70139159DB` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/EOneBound.lean` | `ADD1130F3FBBB4EA2AAFB7A7F769FBD565E14DB13B2F6500245E14023106DC65` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/EOneRanges.lean` | `E3BAEA29E0AF75E9EE6526ACFE648DE39628144A0E944324D0ED40C544751F24` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Prop942.lean` | `35B170971DBD0F1C6646CD86ECE8C3A86021085C1B07730141CD6311D9CA5716` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Thm714.lean` | `7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Cor713.lean` | `11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433` |
| `work/ternary-goldbach/TernaryGoldbach/MajorArcs/Prop715.lean` | `CD026A3D01FD8578484E43A48888885C2DC3BF696B2F7ACB89BB525E4E064DF0` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/EBound.lean` | `EB4A44BA2A0422BC346A73EED0828BDD32AF9597F24515ED763331DFF776F17F` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/TypeI2Large.lean` | `8139C79397A42791C2FC929A380AF440BCF2B3CDDCE45CB847CDE1C36E74B09A` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/TypeI2Proof.lean` | `085A1CF1B2A1B8A46B55C81CD2479F151314F1768E0B399D72C8D94DBE2A0E66` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/TypeIIReduction.lean` | `CBA5FAE640F519546892CF647FBE6EDED0845363C55334485E10303491EAC690` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap2.lean` | `AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/FirstChoiceTypeII.lean` | `F42E8C2D1B28F362A9ACA5DED7DF6B3025E4B0A58EAF6A4D66DC2C3FE935E5C2` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/GBound.lean` | `79070A7DD3B3B755A34C3C39690674193CBCF439238D763EB4982889E5B52491` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/LSQuot3.lean` | `4E1105C3A734EF94CBFFA81AF2128D0525092F95F0E4E6F8B8ED8E0B983542BD` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/SecondBridge.lean` | `816CA4F58B8B53C270A935F2A9BB47CA51114963B85D0FBB4EB982FC6FBD089D` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/SecondTypeIIa.lean` | `41C4ED65E94CA2ED22A871CD534D14C064CECD3F571B8181185070E41FE3C43C` |
| `work/ternary-goldbach/TernaryGoldbach/MinorArcs/SecondTypeIIb.lean` | `F1EDE13B41A3F39DAB25B1EF10D750C7DA9278B681500628D006435CE01DF11A` |
| `principal_height_consumer_metadata_20261111.py` | `5F44A6C1CB303450235C94DBA1B3419424C2A508249C07B3613CEB994F7B5BE7` |
| `principal_height_consumer_metadata_20261111.json` | `DE7F46C08544A2EDE1548935591E12159EC785C995E1B8F79276A8286484642F` |
