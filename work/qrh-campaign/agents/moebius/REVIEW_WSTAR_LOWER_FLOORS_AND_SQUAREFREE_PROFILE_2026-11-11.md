# Independent review of the lower Wstar floors

2026-11-11. PASS at conditional paper/source and exact-metadata scope, without a new correction. The author correctly incorporates the previous H4 correction. This review accepts the floor300 remainder derivation and its conditional mixed-profile composition. It does not certify any actual zero-location bound, Wstar energy or end-to-end saving.

Author `zero-sum/WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md`, SHA256 `E1D58C8EC2EDB7FD8F3BF77F1D3833F3E400200D14AD30B396F59FA8CB5EE794`. Paths here are relative to `work/qrh-campaign/agents` unless stated otherwise.

| Artifact | SHA256 |
|---|---|
| zero-sum/wstar_floor300_metadata_20261111.py | 624B5414A2517C5AAE75C0D3179CC1509097CEC74696BBE9EA1A23AC914B5EC3 |
| zero-sum/wstar_floor300_metadata_20261111.json | 7750B7D1BB25A96D9B4F54A75C4090B9C7ECE591D905DEDC7D244FBA12CCDAD5 |
| zero-sum/wstar_floor500_metadata_20261111.py | 71FF612FEF6CFAC1EC747FBEFD67B744B07A60263A5C0D9BB02B3D52AF444073 |
| zero-sum/wstar_floor500_metadata_20261111.json | 4CAF3600A367B6DE55FEDF10D218007E86CBBC35C021828110825E7F3E8698A4 |

## Gaussian tail at floor300

The inherited actual etaU mixture, full-strip Gaussian theorem and growing multiplicity-window estimate were checked in `REVIEW_WSTAR_CUTOFF_BASELINE_TRADEOFF`, SHA256 `CD982E629643A2A58897663C471C168193E3E9E66D3079F5BDF686A2432A1F2A`. Here the changed premise is H>=300, while H>=32pi*D is retained. Both still imply the actual `ZeroSumBound.norm_G_tail:105` requirement H>=max(10pi*D,50).

The maximum remains H_F(4)=545549. The old polynomial-growth logarithm envelope covers this range, the small enlargement for translated low windows, and all c<=265800. Its Z3<400 does not require H>=1000. The generic `ZeroSumGen.count_tail_windowG:121` growth coefficient is still c3<53/H. Therefore at the smaller floor the bound is106/300, not the old .106. The author uses the changed coefficient correctly.

For the B Gaussian regime, (1-rhoB)^-1<3 gives

    S_B<2400+(106/300)*9<2404.

For the A regime the inherited G0=1+600001/2.7 gives

    S_A<=800G0+(106/300)G0^2<2*10^10.

Keeping these separate is necessary: multiplying the relatively larger EB(300) by the coarse A bound would not produce the stated tail allowance.

I independently checked finite positive rational Taylor sums showing exp(47.94)>267.6*10^18 and exp(.1065*32^2)>.588*32^2*10^44. The functions H exp(-.1598H) and u^2 exp(-.1065u^2) are decreasing on H>=300 and u>=32 respectively, by their elementary derivative signs. Thus EB<1e-18 and EA<1e-44 uniformly, not just at endpoints. Their mixture mass is below2 for every beta>0. Consequently

    tail<2*(2404*10^-18+2*10^10*10^-44)<5*10^-15.

At actual twist zero the A term vanishes; the positive uniform upper twist D does not create a division-by-zero case. The author's rho_A(D) is justified directly by the Gaussian theorem, with the coarser inherited D+1 denominator bound still a valid majorant. The geometric multiplicity growth applies for every high window and arbitrary finite source carrier. Passing to the positive majorant and the reviewed true-order explicit-formula limit is justified as before. No QRH factor is retained: y^(beta-1)<=1 is all that is used.

For the separate floor500 alternative, the positive Taylor sum at79.9 proves EB(500)<1e-31. The common bound2*10^10 is then small enough to give a tail below5e-21. This is a saved alternative, not an additional assumption in the floor300 proof.

## Other errors and low windows

The sharp vertical and zero-at-zero bounds do not depend on the floor; their twist, conductor and y domains are unchanged. `ArcCharsStar.coprime_split_star:85` and its character-twisted nonnegative majorant also remain applicable. Thus

    e<10^-12+10^-18+5*10^-15<2*10^-12.

The exact Gauss mass and unchanged reciprocal-totient bound give TA<8e-9 and TB<.00048. These are full primitive-to-coprime remainders, not just high-zero tails. Nontrivial real zeros remain in the finite carrier; the possible trivial zero at0 has its separate term. The principal residual is not included in this nonprincipal calculation.

The low Gram proof still uses translated3.48 windows over the whole strip, radius2.7, and true multiplicities. Its geometry4+1.74^2<2.7^2 and polynomial logarithm bound do not deteriorate when the floor decreases. No radius2.3 critical-line specialization or fixed400 bound at infinite height is introduced. The parent's G=7e6 therefore applies on these finite carriers under the same analytic-source interpretation.

## Independent finite metadata reconstruction

I rebuilt primitive counts by divisor inversion of phi, and traversed conductor/cofactor pairs subject to squarefreeness and coprimality. This differs from the author's factor-per-modulus routine. For each floor, the reconstruction checked all199350 Gauss-mass identities and exactly reproduced every directed total, including the separately rounded squarefree and nonsquarefree B contributions.

There are132899 active nonprincipal conductors, with129264 at floor300 and130718 at floor500. The exact maximum and its unique conductor agree. The floor300 A and B numerators are2320260719784375582 and17521273377323822834049091, over10^12*Y. The floor500 values are2323866993447313558 and29202700956717402761203761. Independent rounding of two B portions need not sum to the separately rounded direct B total; no such equality was assumed.

The count formula remains within its domain because .99H>=297>50. It is the same analytic averaged-count majorant with canonical phase, closed counts and true orders, not a numerical count or a first-term asymptotic. All displayed decimal upper bounds and the exact source receipt pins agree.

## Mixed profile and scope

For squarefree conductors, beta<=203/400 gives relative factor less than12/5. Nonsquarefree conductors have exactly zero A weight, so beta<=31/50 there affects only B. Using factor10^6 for all of B is conservative. The three exact baseline rows, floors1000,500,300, each satisfy the stated A4e-12/B42 comparisons after adding the full remainder norms. The updated integrated principal norm1.902e-6 is added once, and the reviewed A4e-12/B62 consumer row applies. The independent root-composition review records this implication separately.

The candidate plus-height comparison is elementary: 200+max(260,u*3.1416*Dc) exceeds300 and (704/343)*Dc when u>=19.89. Monotonicity of ceiling proves H300<=Hplus for these formulas. It does not validate the plus producer or eliminate a stronger real-part requirement at any height. The base-gap twist is different, and the floor300 packet supplies no base-gap conclusion.

Independent checker `moebius/review_wstar_lower_floors_20261111.py`, SHA256 `9F8EDAE3AA2C3E6D8CC508E096B7FA831CEA64EBB301F9DDD81169573239083F`; receipt `moebius/review_wstar_lower_floors_20261111.json`, SHA256 `8EE995BCC8597AC8F53AB9CCB5DDEED4426D40A0F4CED39A905BDA953C3BE231`. The combined check passed680656 integer/rational and hash assertions for this packet and the separately scoped root composition. No author program, special-function evaluator or transform was imported or executed. No frozen file was changed.

The finite location hypotheses remain unproved. The result is a source-supported paper remainder bound and an exact conditional budget, not a new spectral certificate, formal theorem or measured cost saving.
