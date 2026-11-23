# Joint analytic threshold and major-arc cutoff

2026-11-11. Bounded source/paper research against `work/ternary-goldbach` commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build, declaration, source edit, prime/zero/L-function evaluation or production scan was performed. Existing frozen artifacts were not changed. The new scalar script uses integer arithmetic and rational Taylor inequalities only.

**Verdict.** There is a conservative conditional parameter route with `R=100000`, `N>=10^36`, unchanged smoothings and unchanged minimum height Hcert on retained conductors. Its finite nonprincipal family is odd c<=100000 and 4|c<=200000. The main new estimates below close the numerical major, lower-J, base-gap and minor requirements with the selected `.65*x*log x` square-energy bound. This is not a recommendation: at fixed binary B, adaptive ladder coverage grows by a factor about 10^9, whereas the number of active nonprincipal conductors falls only from149999 to99999. No smaller spectral workload is credited until the explicitly listed dependency refactors are proved.

The first source cell demonstrated here is N>=10^36. This is not an optimal threshold. The sufficient budgets starting at N=10^29,10^30,10^32 fail. In particular, an apparent pass at10^32 using the old `.640208` energy coefficient disappears after the current `.65` energy input is charged. R=75000 also falls outside the existing large-sieve layer theorem's R>=100000 hypothesis. Neither failure is an impossibility theorem for better estimates.

## 1. Exact domain and retained dependencies

Write x=N/c0, y=x/49, with the source c0=2+9/(196 sqrt(2pi)). `Helfgott/Inputs:57–64` gives x>=.49N and y>=N/100. Set Q_R={m>0:qt(m)<=2R}, where qt(m)=m for even m and2m for odd m. The new major set is exactly `majorArcs 8 R x`; its complement is the new minor set. Keep all actual etaPlus/etaStar functions, character inverse conventions and Gauss weights.

For every retained primitive conductor c, keep the old profile

    Hcert(c)=min(Hp_old(c),10^8/c).

Do not round the second argument upward. No height reduction or real-part relaxation is combined with this change. The finite bound remains beta<=111/200 at inclusive |gamma|<=Hcert; reflection supplies beta>=89/200. The global7/8 provider, principal head/count/psi obligations, and all actual smoothing/zero-sum adapters retain their previous status. This report does not validate them.

The only finite nonprincipal conductors newly dispensable, if the joins below are implemented, are odd100000<c<=150000 and multiples of four200000<c<=300000. There are exactly50000 such conductor indices. No primitive-row or actual panel count is inferred from that number. In particular a conductor count is not a runtime estimate.

`MinorTotal.minor_total` cannot be called as a black box: it has both the old set and a `Fact PlattGRH` binder. Nor is the newly exposed annulus bounded by the old major-arc character theorem. Instead use the source mixed-level proof at base R: at the base the arcs have scale x; at every higher level n>R they have scale y. Thus the annulus is included by the new layer argument, with only one base-gap character estimate at the new R. Higher levels use Type I/II bounds off y-scale arcs, not finite spectral assertions for every larger denominator.

## 2. Major estimates restrict through positive envelopes

For retained m, D_R(m)=8R/qt(m)<=D_old(m), while D_R(m)>=4 on Q_R. Each character occurring at such an ambient modulus has conductor dividing m, hence lies in the smaller family above. Keep the old low cutoffs and the actual kernels at their actual beta; the retained twist domains are smaller. Apply the accepted per-conductor low/Gram/tail estimates there, and bound their nonnegative arithmetic envelopes by the old full envelope sums. This does not assert monotonicity of a signed zero sum when zeros are removed, and it does not assume spectral information for deleted conductors merely to use an arithmetic majorant.

The accepted coprime caps Aplus<5e-7, Astar+Cross<9.5e-7, Nnonprincipal<1.23 and sqrt(Ep)<.00020001 therefore remain sufficient after this restriction. The same argument preserves the unweighted low-star norm<100 and full Estar integral<10001. The old measure bounds, removals, upper J<10, cubic dynamic loss .008778 and fixed Fourier loss .002834895 are conservative on the smaller set. This is the precise hereditary statement needed from `MAJOR_FINAL_CONSUMPTION_JOIN`, rather than a call to the old full major theorem.

For the main coefficient, `Singular.expansion_ge:298` is already generic in R. Its product lower bound at440 applies for R>=200. The positive product in the remainder for R<=150000 is at most its old22.1 bound at570. The even/odd pairing proof at199–240 generalizes without changing its summands. Consequently for odd N and200<=R<=150000,

    sum_(m in Q_R) coefN(N,m)
       >= 2*(.6606*(1−1/199)−22.1/R).

At R100000 this exceeds1.314. At R75000 this particular lower bound is below1.314; that only prevents inheriting that rounded constant without reallocation. Since D_R>=4, the source Fourier comparison at `MajorTotal:561` and the actual Cmain lower bound at942 remain available. The complete major result for R100000 is thus still

    (1.314*.800689−.002834895−.008778)*x²/49
       =1.040492451*x²/49 >1.0404*x²/49.

The coprime-to-full derivation, including the Estar term, is essential here. No major estimate is inferred from the eventual minor estimate.

## 3. A new lower J_R, not the old13.597558 mass

Let S_R=sum_(m in Q_R) mu(m)^2/phi(m). The elementary even/odd pairing in `SumMuPhi:51–107` gives S_R=2 sum_(odd q<=R)mu(q)^2/phi(q). Its old finite arithmetic certificate says S_150000>=13.597558; it supplies no direct lower bound of that size at a smaller R.

For odd q<=150000, q has at most five distinct prime divisors: the first six odd primes have product255255>150000. Each p/(p−1) decreases with p, so

    q/phi(q) <= (3/2)(5/4)(7/6)(11/10)(13/12)=15015/5760=:C.

Prime powers do not increase this ratio. For even endpoints R and150000, convexity of1/t gives 1/q <=(1/2) integral_(q−1)^(q+1)dt/t for each intervening odd q. The adjacent intervals partition [R,150000]. Therefore

    S_R >=13.597558−C*log(150000/R).

For R100000, log(3/2)<.406, giving the exact rational lower mass in the receipt. The .6392 Fourier-energy lower bound applies on every D_R>=4. Reverse triangle with the actual principal residual and full-sum removal gives

    sqrt(J_R) >=sqrt(.6392*S_R)−.00020001−1e−9
                >2.831−.00020001−1e−9,
    J_R>8.0102.

Here J_R=x^−1 integral_(Ioc(0,1) intersect majorArcs8 R x)|S_etaPlus|². The last square comparison is checked rationally. Apply the source prime-supported square split with t=1e−5 and integral|a2|²<=8e−11*x; since

    8.01*(1+1e−5)+(1+1e5)*8e−11 <8.0102,

the actual prime-supported base integral satisfies I_R>8.01*x. This is the new lower-energy input. The old8.6294 is not reused.

## 4. New base gap using only the smaller family

The parity-preserving geometry behind `BaseGap2.gap_point:185–227`, with R substituted before its weakening, gives q=m/gcd(m,2)<=R and

    8R/49 <=u=2q|d|<8R,   d=(alpha−a/m)y.

For R100000 use the full prefix U800000 and

    H(q)=max(250,ceil(193600000/(7q))).

The floor250 is inactive for q<=100000. This is an integer cutoff and H>=22pi|d|. The old Hp dominates it, and H<50000000/q<=10^8/c for every supported c|m: the same minimum-height argument as the accepted base-gap source join has more slack. Thus all low zeros used here lie in the retained Hcert profile, including inverse labels and central nontrivial zeros.

The accepted actual etaU explicit-formula bound and its off-line Jensen count are

    E(y,H) <=(13/8)*N(H)*y^(−89/200)+3e−14,
    N(H)=ceil(400*(2H/3.48+2)).

Their domains |d|<=600000, H>=250 and c<=300000 include this smaller case. The exact weighted character reconstruction has W_m=sum|tau|/phi(m)<=sqrt(m)<=sqrt(2q); the first inequality follows from character Parseval/Cauchy, not an average error assertion. Set

    K=800*(193600000/7)/3.48,
    Ecount=800/3.48+801.

Ceiling bounds give N(H)<=K/q+Ecount. Since sqrt(2q)/q<=3/2 and sqrt(2q)<448, the exact scalar check proves W_m*N(H)<10^10 simultaneously for every q. This correlation is necessary; multiplying the independent maxima of W and N wastes too much.

Already at y>=10^30, y^(−89/200)<5e−14, proved by integer powers. The principal Fourier term can be bounded with the deliberately weaker |d|>=4R/(49m), m<=2R, and the old elementary m/phi(m)<5.53 for m<=300000:

    |mu(m)|/(phi(m))*1.016/d² <=1.016*49²*5.53/(8R).

Both noncoprime removals are retained with d0<=2e−9. Thus the complete normalized gap bound is at most

    1.016*49²*5.53/(8R)
      +(13/8)*10^10*5e−14+448*3e−14+449*2e−9
       <.017676<.025.

For y>=10^30, the definition of ghat gives ghat(y,100000)>.03: R(y,200000)>=.41415, log200000>12, sqrt200000<448, and Fr(100000)>3, hence sqrt Fr>1.7. The latter follows from exp(gamma)>=1, positive loglog and v+2.50637/v>=2sqrt(2.50637)>3. These yield the lower bound written in the receipt. Consequently the gap is absorbed directly, for every q including1,2,3. No old exceptional small-q high-u branch or annulus theorem is needed for this candidate. This proves the actual required gap inequality, not the old stronger .0121 assertion.

## 5. New minor expression and the selected energy correction

Define s(x)=sig(x)/Dx(x) using the source sig only as an auxiliary scalar. With j=8.01 the new old-sig model is

    M_R = ghat(y,R)*(cL(R)*s−j)
       +s*sum_(R<n<r2) ghat(y,n)*log((n+1)/n)
       +ghat(y,r2)*(sig−cL(r2−1)*s).

This is the exact expression obtained by the mixed layer theorem with the new I_R. Its actual base region is majorArcs8 R x. Source `thm_13_2_1_repaired:153` permits R100000; its L² theorem uses Q0=n+1 and392, with the same r2 size conditions. This is why R75000 is not a direct substitution in the current source.

The scalar monotonicity of ghat and the telescoping log sum bound the extra interval R<n<=150000 by

    G_R*log(150001/(R+1)).

Together with cL(R), this is exactly cL(150000), since cL(r)=log(2(r+1))+2. Thus, if G_R>=ghat(y,R), each existing scalar cell's middle and top estimates gives

    U_R=G_R*(cl0*sD−j)+sD*old_chain+Gt*tau.

Only scalar cell pieces are reused, not their old `NumericsGoal`, actual minor conclusion or spectral instance.

The **current** actual-square input is T<=.65*x*log x. It cannot be replaced by the source sig. For log x>=60,

    sig/log x >=.640208−.021095/60>.6398,
    .65 log x <1.016 sig.

Every H-increment is nonnegative. Replacing T by this larger bound while keeping the negative I_R subtraction proves the sufficient selected scalar bound

    U_selected=1.016*U_R+.016*G_R*j+1e−20.

The final allowance covers the inherited remote totient correction. In the added interval below150000 its correction H(n) is constant, because max(n,2^500)=2^500. The old bound<1e−24 plus the extra possible loss H(100000)*8.6294 is <1e−20, using log2<.7. Thus it does not reintroduce a finite nonprincipal assertion at the removed conductors.

The scalar script certifies G_R with `NumericsCore.ghatY_le_num:55` using rational log brackets. For log z it range-reduces z=2^k*w,1<=w<=2, and uses80 positive atanh terms with exact geometric remainder. Nested logs use outward rational brackets first. Square and sixth/cube-root bounds are integer inequalities. No transcendental-library evaluation or special-function value is used.

| Source cell | Required N lower endpoint | G_R upper | U_R upper | Selected upper | Result |
|---|---:|---:|---:|---:|---|
|3|10^29|.070030|1.098853|1.125410|fails this sufficient test|
|4|10^30|.069349|1.072497|1.097440|fails this sufficient test|
|5|10^32|.068018|1.034447|1.059715|old-sig pass is insufficient|
|6|10^36|.066246|.978854|1.003006|passes|
|7|10^44|.064000|.929289|.952360|passes|
|8|10^60|.061817|.899216|.921526|passes|

Cell6 covers x in[4.9e35,4.9e43], cell7 to4.9e59 and cell8 to4.9e101. Above this, the actual asymptotic proof uses r2=floor(y^(1/4)), middle bound `.165282706731081808+.00084+1.398e−10`, sD1.2947 and tail .00022. Replacing only its base by G6 and j as above gives selected upper<.961379. The r2 geometric conditions are unchanged. Therefore all x>=4.9e35 are covered, not merely sampled endpoints.

All successful bounds are below1.037001. The selected final square split gives

    1.0005*1.037001+2001*22.75*8e−11
       =1.03752314232<1.0376.

The failed rows mean these explicit upper certificates do not close. They do not lower-bound the true minor integral or prove that a sharper mesh/energy/mass estimate cannot work.

## 6. Dependency closure required before crediting family removal

The following is a precise conditional proof ordering, not an adopted strategy or completed Lean proof.

1. Parameterize the actual major set, character/arc integrals and main coefficient in R. Prove hereditary *positive envelopes* for retained ambient moduli, with no finite premise on deleted conductors. Use section2 for the cubic and upper-J transfer.
2. Prove section3's reduced mass and actual I_R lower bound. Do not call the old `l2_major_14_7` or `I0_ge` unchanged.
3. Prove the parity gap extraction and section4's correlated weighted bound. Its only finite nonprincipal characters have c in the new family. Preserve actual characters, multiplicities, inclusive cutoffs, possible real zeros, and the global high-zero provider.
4. Rebuild the off-y-arc Type I/II input for levels n>=R under the same principal/arithmetic replacement lemmas. `LinftyLevels:358–410` consumes these estimates, not a character expansion for every n. Their already identified prime/Mobius/totient proof obligations remain; this report does not discharge them.
5. Rebuild `LSQuot3:37,75 -> LSQuot6:69 -> LargeSieveProof:378 -> Thm1321:153` without the blanket Platt instance. The displayed LSQuot3 spectral call is the ordinary scalar `psiN_le` used to bound a product of primes, not a nonprincipal L-zero theorem at its potentially large modulus q. Retain that principal estimate and the reviewed arithmetic quotient proofs. Merely calling these current instance-bound declarations would defeat family reduction.
6. Supply the new .65 energy, E-bound and the generic R,j version of `MinorTotal:382–518`; apply the rational cells above including the remote correction. Use the new actual region throughout.
7. Reassemble `Inputs`, `repSum_lower_bound` and the nonprime subtraction. The unchanged nonprime .00271 bound applies since N>=10^36>10^27. The same positive reserve1.0404−1.0376−.00271=.00009 follows. Finally cover the enlarged finite range so the root conclusion is not weakened or given a new premise.

Items1–3 and the scalar modification are the new paper steps supplied here. Items4–5 are retained source-proof obligations whose consumers must be explicitly refactored; no hidden full-family theorem is permitted there. Global all-conductor7/8 is unchanged. This is the distinction between a genuine smaller *finite* family and merely deleting entries from a data file while retaining old assumptions.

## 7. End-to-end cost obstruction

With the accepted adaptive chain contract, p0=3, gaps<=B−2 and terminal p+B>=N require at least ceil((N−B−3)/(B−2)) steps when that numerator is positive. Raising N from10^27 to10^36 therefore multiplies necessary covered length at fixed B by approximately10^9. Adaptive offsets avoid fixed-window waste but cannot eliminate this coverage requirement. With the original binary endpoint B=4e18, the scale grows from about2.5e8 to2.5e17 steps. These are coverage counts, not availability or timing claims.

The old fixed power45 direct-order domain does not reach10^36. A pure power-of-two universal certificate needs power60 to make the strict bound n<(2^60+1)^2 sufficient across that whole range: 2^118<10^36<2^120. Such a fixed-F ladder has every prime1 mod2^60, so actual gaps are multiples of2^60. In particular binary B=1e16 or2e16 is incompatible with a full chain consisting only of that one congruence class, since2^60>B−2. A mixed smooth-F/general-primality fallback is necessary there, with its own generation and proof costs. No original exponent45 timing is transferable.

Nor can the fresh Johnston gap frontier be extended for free: it was proved only to10^27, with H=4e10*Q and c/epsilon=Q*(L/2+6)*sqrt(x)/L^(5/2). At x=10^36, 72<L<83 gives

    c/epsilon >Q*36*10^18/(83²*10)>4e10*Q.

Thus even its required spectral-height domain fails with unchanged H, before checking its other error allocations. Raising H, increasing B, or replacing that finite-range method is separate work. The original binary B=4e18 can instead be retained, at the huge chain cost above.

This bounded experiment demonstrates a possible mathematical family reduction and explains why it is not presently a credible efficiency improvement. It does not justify a global win from the decaying x/y terms. No further tuning or recommendation is made.

## Evidence

The owned script is `major_cutoff_threshold_scalars_20261111.py`; its JSON receipt contains exact rational numerators/denominators and outward decimal display integers. It records both old-sig and selected-energy quantities so the failed intermediate proposal remains visible. Source hashes and artifact hashes follow. Source locations are relative to `work/ternary-goldbach/TernaryGoldbach`; source reading is not a compilation claim.

| Source | SHA256 |
|---|---|
| Helfgott/Inputs.lean | 5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83 |
| Helfgott/Numerics.lean | 059874D201ECC571583118A56BA6193D6D8B49016C227988CBC83FA0F34648DB |
| MajorArcs/Singular.lean | 152DC0302216E9E2B23E9DFCA7FE1BCA2087F275662F9988FC524D101C1B8DB9 |
| MajorArcs/SumMuPhi.lean | 7AC4662598355DDA40720B43956223BD3C5456D503B206A77D48E4569ADE18A4 |
| MajorArcs/MajorTotal.lean | 106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A |
| MinorArcs/MinorTotal.lean | 6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742 |
| MinorArcs/GBound.lean | 79070A7DD3B3B755A34C3C39690674193CBCF439238D763EB4982889E5B52491 |
| MinorArcs/LinftyLevels.lean | 12605A6C6B8E97BA5ABADEC4F761E322F8C04E8D4C6557AC5BE1084194EA6409 |
| MinorArcs/NumericsCore.lean | 4E2D5351E5BFD0350FBD3B378B123CA1F7155943D467CB4788554800B657F6F8 |
| MinorArcs/NumericsCells.lean | 5192960AD541DCF981C630F538B35EC63FE966A61044AF31576AB83C93A41139 |
| MinorArcs/NumericsAsymp.lean | 8A07C9A4D8822D4EB1680DF8E382308260CC62B92B8A7AB5C708B3B3F58243FF |
| MinorArcs/BaseGap2.lean | AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E |
| MinorArcs/Thm1321.lean | 46E2E0919EEC0310EFCA401EFA7DD7FD9C7690E1337BB5996A6597DDDA342F2A |
| MinorArcs/LargeSieveProof.lean | FB71222C80D0377BDF6739529E527F4BE6A0C908286FF87F0EC19D67DDE9CAF1 |
| MinorArcs/LSQuot3.lean | 4E1105C3A734EF94CBFFA81AF2128D0525092F95F0E4E6F8B8ED8E0B983542BD |
| MinorArcs/LSQuot6.lean | DC67FC28217D1212FD67A920C6AC62003F13EAC9F0FB26200EDA426CD43CB2AE |
| Prelim/MertensProduct.lean | 8182DC2B990DC8D65AC76D3CC55847B26922E2062CD154C14367D5DB97F71A0F |
| Ladder/Spec.lean | 0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F |

| Supporting artifact | SHA256 |
|---|---|
| work/qrh-campaign/agents/major-constants/MAJOR_FINAL_CONSUMPTION_JOIN_2026-11-11.md | 280FDC53E61066E050DD98D4A004A9435510CC67686A59354750E0F7DE188F64 |
| work/qrh-campaign/agents/major-constants/RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md | 79833F8D5D5856E000A96D3F5CCA9FC9E26CB3BAF637CDE089FEFDD703436BA7 |
| work/qrh-campaign/agents/integration/BASE_GAP_ACTUAL_SOURCE_JOIN_2026-11-11.md | F0BC1D7899044C27E819743BBA4B157D51F42848B87A51D37764CDB8B3B6C9E0 |
| work/qrh-campaign/agents/mellin/CURRENT_CONSUMER_OBLIGATION_FRONTIER_2026-11-11.md | 517D24E49F9F2DD8AA4E339C6EEF440070937FD94D2C9EB5ADE366A89604FF5B |
| work/qrh-campaign/agents/major-constants/major_cutoff_threshold_scalars_20261111.py | FADB3975E0AD84136CC47DD80737F9DAF9BF3C054FC3AD8EBBE92394E784467E |
| work/qrh-campaign/agents/major-constants/major_cutoff_threshold_scalars_20261111.json | C2D84EC047B8953768A38877CEF0DFC5AD56299B1F4E3AFB3C679A028A679D6C |
