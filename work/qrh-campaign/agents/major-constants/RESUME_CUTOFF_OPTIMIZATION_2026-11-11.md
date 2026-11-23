# Smaller finite spectral heights, with the same beta=.555 budget

Research derivation,2026-11-11, at source23b2d68ca344203d4384e0aff7affa4ec034bef9. No Lean process, canonical edit or finite-zero computation was used. The reviewed family report remains unchanged. This note proposes a smaller finite-height contract; it still requires actual spectral certificates and the analytic bridges identified in RESUME_FAMILY_CAPS_2026-11-11.md.

## New sufficient profile

Keep the selected upper real part b=111/200 and the entire active primitive family. For Dc=1200000/qt(c), replace the previous heights by

    Hplus_new(c)=ceil(200+max(300,(484/7)Dc)),
    Hstar_new(c)=ceil(max(250,(484/343)Dc)).                     (H)

Thus the large-conductor floors become500 for plus and250 for star. The factor484/7=22*(22/7) retains the source Gaussian requirement with a22pi twist ratio. The previous factor704/7 used32pi and floors1200/1000. Every new height is no larger than its old counterpart. A single spectral certificate through Hplus_new(c) covers the star height too.

All reviewed low-zero inequalities remain valid with their old constants: the new low sets have multiplicity bounded by the smaller Nnew(c)<=Nold(c), while every remaining zero is now included in the newly bounded QRH tail. No claim is made that the zeros between new and old cutoffs satisfy the finite beta bound.

Selected examples:

| c | old Hplus | new Hplus | old Hstar | new Hstar |
|---:|---:|---:|---:|---:|
|1|60343058|41485915|1231487|846648|
|3|20114486|13828772|410496|282216|
|4|30171629|20743058|615744|423324|
|100|1207058|829915|24630|16933|
|1000|120886|83172|2463|1694|
|10000|12269|8498|1000|250|
|100000|1407|1030|1000|250|
|149999|1200|500|1000|250|
|300000|1200|500|1000|250|

## Tail proof using the actual twist denominator

Write d=Dc for plus and d=Dc/49 for star. Put T=Hplus_new-200 for plus and T=Hstar_new for star. Then T>=22pi*d and T>=300 or250 respectively. The Gaussian source tail applies because T>=max(10pi*d,50); the plus bandlimit shift200 remains explicit.

Source ZeroSumGen.count_tail_windowG at121 bounds both signs and multiplicities in4.4 windows. Its polynomial data give

    Z3g(B,H)<400, c3g(kappa,H)<53/H,

with the correct Dirichlet BP(c),kappa11, or zeta BPz2,kappa10. The elementary logarithm estimates in the hybrid note remain valid because our heights are smaller; they do not require H>=1000 for this particular bound.

Crucially retain the d-dependent geometric denominator. For BOTH rhoA and rhoB let

    G(d)=3+d/2.7.

Then (1-rhoA(d))^-1<=1+pi(d+1)/(1.93*4.4)<=G(d), and (1-rhoB)^-1<3<=G(d). Using only1+(d+1)/2.7 for rhoB would fail near d=0; the added3 avoids that error.

Since H>=250 and H>=69d, G(d)/H<1/39. For d<=4 use H>=250; for d>=4 use H>=69d and G/d<=3/4+1/2.7. Therefore each geometric window sum is bounded by

    800G+(106/H)G^2 <803G.                                    (W)

For plus d<=600000, this is<180million. For star d<=600000/49 it is<4million. This replaces the previous uniform1e10 estimate and permits the lower heights.

At T/(pi*d)>=22, the genuine source EA satisfies

    EA(T,d)<=.588*22^2*exp(-.1065*22^2)<2e-20,

with EA(T,0)=0. The scalar envelope decreases past22. Multiplying(W) and the actual smoothing prefactors130 for plus and2 for star bounds the EA contributions. No source mass, spacing or finite-RH input is used.

For EB it would be wasteful to multiply the floor value by the largest-d geometric sum. Since d<=T/(22pi), pi>3.14 and(W),

    803G(d)<5T+2500.

Consequently its coefficient sum is at most the smoothing prefactor times

    .892*T*(5T+2500)*exp(-.1598*T).

This expression decreases for T>=250: its logarithmic derivative is at most2/T-.1598<0. Evaluating at the respective floors yields coefficient bounds<4e-13 for plus and<1e-11 for star. The script certifies these and the EA comparison by positive exponential Taylor sums, without numerical quadrature.

Finally x0^(1/8)>2125 and y0^(1/8)>1333. Using the genuine global7/8 provider on all high zeros gives uniform normalized primitive tails

    |tail_plus|<3e-13, |tail_star|<1e-14.                      (T)

This calculation is uniform on each conductor's relevant twist interval and on every finite explicit-formula rectangle. It passes to the source good-height limit as in the reviewed hybrid argument.

## Revised perturbation budget

The reviewed contour plus possible-zero0 terms are<1e-18 per character. Source primitive-to-coprime errors remain<=1e-15 and<=1e-12. Thus total normalized pointwise perturbations are

    dplus<4e-13, dstar<2e-12.

The larger plus allowance is harmless. The reviewed direct-sum measures give

    R_Aplus<900000*dplus<=3.6e-7,
    R_Astar<600000*dstar<=1.2e-6,
    R_N<900000*dplus<=3.6e-7,
    R_Ep<3e-7.

Retain the old finite beta=.555 low estimates sqrt(Aplus_low)<.00007, sqrt(Astar_low)<.00049, Nlow<.001 and sqrt(Ep_low)<.0002. Minkowski gives all the same full coprime caps Aplus<=5e-7,Astar<=2.5e-7,N<=1.23,Ep<=1e-4.

For the mixed product use the actual low second moments integral sumLplus<.002 and integral sumLstar<10000. They still hold with the smaller low sets. The reviewed two-character perturbation argument gives

    Rmix <4e-13*55000 +2e-12*25 +(4e-13)*(2e-12)*180000000000
          =689067/31250000000000 <3e-8.

This is a norm allowance. With the selected factor25 mixed estimate Cross_low<2.5e-7,

    Cross_coprime <(.0005+3e-8)^2<7e-7.

The corrected Astar+Cross budget9.5e-7, upperJ10 and final major/minor/nonprime constants therefore remain unchanged. The tiny old remainder2e-10 is not claimed for the new profile; the new explicitly budgeted allowance is3e-8.

## Exact workload proxies, with their limits

The script enumerates the same150000 active conductors and5,543,640,188 primitive characters. Let a(c) be their exact primitive count. Two integer quantities are recorded:

* Weighted height sum sum_c a(c)H(c).
* Source-Jensen multiplicity upper proxy sum_c a(c)*ceil(400*(2H(c)/3.48+2)).

Neither equals actual zero count, computation time or proof volume. In particular, an argument-principle nonvanishing certificate need not serialize one record per zero, and the crude Jensen proxy need not be achieved by actual zeros.

| Profile | Weighted height sum | Jensen count proxy |
|---|---:|---:|
|old plus|7549963670988|1740063512485802|
|new plus|4187651193034|967116078377291|
|old star|5544014027074|1278926120257689|
|new star|1386617890178|323201722925456|

Exact comparisons give new/old weighted-height ratios below.555 for plus and.251 for star, and count-proxy ratios below.556 and.253. If one shared zero certificate reaches the plus height, the star row is not an additional independent verification workload; it describes the smaller part consumed by the star kernel.

For comparison ONLY on this same active family, the original parity-dependent Platt heights, rounded upward, have weighted-height sum6288129219481. The new plus sum is below.667 times that value. This excludes the other conductors in the original Platt proposition and compares a weaker beta strip with critical-line membership, so it is not a full-task or runtime comparison. Some individual new heights are larger: at conductor300000 the new500 exceeds the old parity-dependent450. No claim that the new proof-producing certificate is cheaper than Platt's computation follows from these proxies.

The JSON also prints a floating leading Riemann--von Mangoldt expression as an explicitly unproved diagnostic. It is not used in any acceptance assertion. Its usefulness is limited to scale orientation; the exact integer quantities above are the reproducible workload proxies.

## The same principal estimate supplies the lower-major-energy input

This is a source-definition corollary, independently checked with prime_estimates. In the actual Ep_coprime, the q=1 summand has mu(1)^2/phi(1)=1 and coprimePart1 is exactly the original sequence. Its interval is[-600000,600000]. Its residual is exactly

    S_etaPlus(delta/x,x)/x-Fourier(etaPlus)(-delta),

with the same pole subtraction and Fourier sign as the lower L2Major argument. Nonnegativity and interval restriction therefore give

    integral_[-4,4] |raw principal residual|^2
      <=Ep_coprime<(.0002+3e-7)^2<8e-6.

Thus the selected finite-family route does not require the separate2750-cell local kernel certificate. This is a local L2 implication, not a pointwise bound.

There is an even stronger direct lower argument. The unconditional source main energy is at least .6392*13.597558>2.94^2. Reverse Minkowski in the weighted principal space, discard nonnegative nonprincipal energies, and apply the full/coprime norm correction<1e-9. Then

    Jfull >=(2.94-.0002003-1e-9)^2>8.6296.

The source facts and definitions are recorded in prime-estimates/L2_REPLACEMENT.md: L2Major.lean:309 is the consumer, its arithmetic weight bound occurs near340, and MinorTotal.I0_ge at274 uses the lower constant. This implication needs the ordinary character Parseval, arc-disjointness, and norm transfer bridges, but no new low-zero estimate beyond the selected family certificate. UpperJ and lowerJ now use the same Ep estimate in this branch.

## Reproducibility and status

Run `python work/qrh-campaign/agents/major-constants/resume_cutoff_optimization_20261111.py`. Exact rational assertions pass for the Gaussian bounds, geometric denominators, all revised caps, finite count/height comparisons and the lowerJ corollary. Source-derived analytic comparisons are explained above; a Python assertion is not their Lean proof.

The finite beta=.555 spectral certificate remains unproved, as do the previously listed actual-smoothing analytic bridges. This task improves a sufficient finite domain and its fully accounted numerical budget. It does not produce zero locations, a certificate checker, or a completed PlattGRH replacement. Independent bounded review has been requested.

## Frozen corollary for the original reviewed height profile

This corollary is independent of adoption of the reduced profile(H). Under the ORIGINAL reviewed family heights and its proved-on-paper implication Ep_coprime<(.0002+1e-8)^2, put epsilon=.00020001. The exact source identities are:

* MinorArcs/BaseGap.lean:71 defines coprimePart(q,a)(n) by Nat.Coprime n q, so coprimePart(1,a)=a.
* MinorArcs/LargeSieveWeights.lean:26 defines qt, giving qt(1)=2. LargeSieveArcs.lean:34 defines Qset;1 belongs to Qset150000 and D1=600000.
* MajorArcs/ArcChars.lean:33 identifies S etaPlus x alpha with expTsum(cP x) alpha. Its Schar_one_eq_expTsum at161 identifies the coprime principal character sum. Thus g1(delta)=S etaPlus x (delta/x)/x exactly.
* MajorArcs/SumMuPhi.lean:20 defines mPhi; mPhi(1)=1. The unconditional sum_Qset_mPhi_bounds at108 gives the lower weight13.597558.
* MajorArcs/EtaPlusL2.lean:199, integral_fourier_etaPlus_Ioo_bounds, gives Fourier energy>=.6392 for every interval radius>=4. Reversing the Fourier argument sign preserves its symmetric interval integral; L2Major.integral_main_term at65 records the sign/scaling convention.

Writing Ep exactly as sum_q mPhi(q) integral_Iq|gq-P|^2, with P(delta)=Fourier(etaPlus)(-delta), shows by nonnegative summands that its q1 term dominates the raw principal local[-4,4] integral. Hence that integral is<epsilon^2<8e-6. Closed/open endpoints make no difference to these integrals. No principal pole is lost and no extra factor x or49 is introduced.

For the direct weighted lower energy, let M=sum_q mPhi(q) integral_Iq|P|^2. Then M>=.6392*13.597558>2.94^2. Exact character Parseval, discarding the nonprincipal energies, and reverse Minkowski give sqrt(Jcoprime)>=sqrt(M)-sqrt(Ep)>2.94-epsilon. The actual full/coprime difference has squared direct-sum norm at most7.2e11*(1e-15)^2=7.2e-19, by ArcChars.norm_S_sub_coprime_le at314 and sum_q2Dq*phi(q)<=7.2e11. Its norm is<1e-9. Therefore

    Jfull>(2.94-.00020001-1e-9)^2>8.6296.

The exact scalar checks are appended to the script. The source consumer is L2Major.l2_major_bounds at309; MinorTotal.I0_ge at274 needs its lower side. This replaces the analytic estimate within that consumer, not a direct invocation of its existing Platt-dependent theorem. The algebraic and measure-theoretic bridge must still be implemented, and Ep still depends on the unproved finite spectral certificate and supporting analytic lemmas. The independent2750-cell local kernel route is unnecessary in this selected original-height branch.

Freeze status: the original reviewed profile remains the selected parent route. The reduced profile is a separate proposal pending independent review. Its enlarged high tails3e-13/1e-14 and mixed norm allowance3e-8 must not be combined with the original profile's2e-10 mixed remainder claim.
