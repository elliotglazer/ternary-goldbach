# Independent review of the actual base-gap source join

2026-11-11. **PASS as a conditional paper/source implication.** No substantive correction is required. Reviewed author file: `integration/BASE_GAP_ACTUAL_SOURCE_JOIN_2026-11-11.md`, SHA256 `F0BC1D7899044C27E819743BBA4B157D51F42848B87A51D37764CDB8B3B6C9E0`. Source revision: `23b2d68ca344203d4384e0aff7affa4ec034bef9`. I independently read the frozen join, current smoothing/zero-sum joins, original source contracts and earlier finite-family/full-join reviews. No evaluator, spectrum scan, Lean build, dependency modification or frozen-file edit occurred. This review does not repeat the earlier scalar enumerations or prove the finite spectral condition.

## Exact consumer and domains

The target is the base-gap branch of [MinorTotal.hv0](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/MinorTotal.lean:394): actual `|S etaStar x alpha|<=y*ghatY(y,150000)`, y=x/49. It is not the old stronger .0121*y statement. The off-larger-arcs branch and all higher-level `hvn` estimates remain separate Type I/II obligations.

The original [BaseGap2.gap_point proof](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap2.lean:185) contains the required parity information before its exported conclusion weakens it. Retaining that information gives original modulus m, reduced q=m/gcd(m,2), physical twist d, and u=2q|d| in `[1200000/49,1200000)`. The closed lower/open upper endpoints are correct. The character expansion still uses m and a/m, while the raw approximation of2alpha uses q. The exact source etaStar-to-etaU identity introduces no additional49 or frequency rescaling.

The new minimum-height calculation is correct for every inducing conductor, not only a favorable subset. From c|m, qt(c)<=qt(m)=2q, hence c<=2q. With U<=1200000, `ceil(242U/(7q))<=290400000/(7q)+1`, while the margin to50000000/q is at least59600000/1050000>1. The floor250 is also strictly below50000000/q. Therefore H<1e8/c and H<=Hp(c), so H<=the exact rational minimum Hcert(c). No upward rounding of Hcert occurs. Also22*pi*|d|<=242U/(7q)<=H. The active-conductor assertion uses the separate elementary fact excluding exact2-adic valuation1, not an unjustified assumption that all divisors are active.

## Actual analytic and finite-carrier transfer

The accepted smoothing join supplies absolute Fubini and parameter moments for the actual etaU mixture. Its factor `r^(s-1)dr` and argument d*r agree with the source. GoodSmoothing on the full strip[-1/2,3/2] uses3*Kdelta (or the valid larger8*Kdelta); the numerical vertical constant900 remains a distinct line estimate. The affine Mellin bound decreases with beta, so its maximum over[.445,.555] is `.555*1.922+.445*1.2534=1.624473<13/8`. It is uniform in real twist and ordinate.

The inclusive low carrier at outer height H+1 is finite and stable in both points and analytic multiplicities for outer T>H. The inverse-character functional equation is used only to obtain the lower real-part bound; it does not falsely reflect each nonreal character into itself. Real nontrivial zeros remain included. The possible zero at complex0 is separate, and the specialized zeta formula has the correct pole main term and no zero0 contribution.

I checked [ZeroSumGen.sum_multRectD_le](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Explicit/ZeroSumGen.lean:60). The proposed floor(ordinate/3.48) bins need at most2H/3.48+2 windows, their occupied centers lie within H+1.74, and `2^2+1.74^2<3^2` gives radius3 containment. This is a valid off-line specialization with actual multiplicity; the radius2.3 critical-line theorem is not used. The existing400 scalar bound and the3e-14 base-twist allowance remain quantitative inputs at their previously reviewed domains, not new results proved in this audit.

The stabilized source limit then yields the pointwise primitive residual estimate without exchanging limits and integration or requiring a measurable selection of good heights. No new RH or simplicity premise appears.

## Weighted wrapper and completion

The wrapper(W) follows directly from [BaseGap.totient_mul_norm_le](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap.lean:19), `Schar_primitive`, `Schar_sub` and `norm_Schar_le`. It correctly retains outer removal D and inner weighted removal W_m*D. Vanishing Gauss rows need no primitive residual premise. The principal term has coefficient |mu(m)|/phi(m), and all surviving residuals have weight |tau|/phi, not the squared weights used for major energy. Positivity of phi follows from m>0.

For odd q, the supported odd conductor families at m=q and m=2q coincide, with equal phi, absolute mu and Gauss norms; for even q only m=2q occurs. Thus the earlier exact-weight scalar table applies. Both the elementary character identities and the full primitive manifest coverage remain necessary formal adapters; sampled character representatives would not satisfy(W).

The substitution beta=d/y gives the exact physical smoothing twist because n*beta=d*(n/y). Applying both removals produces precisely(B). The q>=4 bound uses the previously reviewed all-scale scalar certificate. The q1,2,3 prefix endpoints486477,972954,1068377 overlap their high-branch lower endpoints190000,300000,300000. Together they cover the actual source interval; no equality at an uncovered endpoint is hidden. The high branches still require their original Approx2 and Type I/II hypotheses.

There is consequently no new conjectural estimate in this local join. What remains unproved is substantial: the actual all-character finite .555 certificate, the global7/8 provider closure, relevant quantitative scalar/analytic proofs in Lean, high-branch producer repairs, and implementation of the adapters. The local result cannot be substituted for the independent off-arc branch or for the full minor-arc proof. The intended large root has no mathematical premise, and the full Statement retains only original inclusive BinaryGoldbachInput; all current conditional inputs must be discharged internally.

## Direct source pins

| File under TernaryGoldbach | SHA256 |
|---|---|
| MinorArcs/BaseGap.lean | ABF8667E1A8D5C72AA81F1B3F40481933A1ABC5A1CE3FAA0BE9705AC8CAF418B |
| MinorArcs/BaseGap2.lean | AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E |
| MinorArcs/MinorTotal.lean | 6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742 |
| MinorArcs/Bombieri.lean | F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79 |
| Explicit/ZeroSumGen.lean | 9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389 |

Prerequisite joins read: zero-sum `600F627B397F7A8E83AE20578D8BA7A7C5EBEC536578EA5EC41D1E3AAC25ABDA`; smoothing `DDE8BB9C5782A91006A47E608F653A82E3BA195397D245C1304B485888F2F55D`. Earlier finite-family and full-join reviews remain evidence only at their stated paper/external-scalar scope.
