# Independent review of the existing-mass-checkpoint cutoff

2026-11-11. **PASS for the conditional paper/source argument and saved-bound scalar composition. No correction requested.** This review binds `prime-estimates/EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md`, SHA256 `429562CD92AF356BD84EED1C253D0A9E95D434262DF08CCCAC8EAF3D15CE234D`.

The selected R=132900 candidate correctly uses the existing c_132 lower checkpoint and nonnegative finite-sum monotonicity. It retains the original finite-RH joint-final-margin route at N0=989*10^24. No new mass data, spectral premise, analytic branch, or finite-range ladder is inserted. The resulting normalized odd-prime representation lower coefficient exceeds .0013565.

I read the full author note and script, the actual SmallMuPhi and SumMuPhi source bodies, and the parallel source-interface note. An independent checker reconstructed the scalar compositions from the saved rational G bounds. It did not import or run the author script, regenerate logarithmic/analytic enclosures, evaluate totients or primes, or run Lean. This is not a fresh compilation or axiom audit of the existing checkpoint theorems.

## Source identity, checkpoint and direction

`MajorArcs/SumMuPhi.lean:20` defines mPhi(q) as the squarefree indicator divided by phi(q). Its theorem at22 identifies this indicator with mu(q)^2. For included q>=1, phi(q)>0; hence every summand is nonnegative.

The q-tilde/floor condition in `MinorArcs/LargeSieveArcs.Qset:34` matters. Generalizing the actual `sum_Qset_mPhi` proof at69–106 gives, for natural R>=1,

    sum_(q in Qset(R)) mPhi(q)
      =2 sum_(1<=q<=R, q odd) mPhi(q) =2 S(R).

The odd part is q<=R; the even part is q=2k with1<=k<=R. The existing `mPhi_two_mul:49–66` proves that its contribution is mPhi(k) for odd k and zero for even k. The even reindexing is injective and floor(2R)=2R. Thus this is not a claim that Qset contains every q<=2R, and the factor2 is paid exactly once.

`Prelim/SmallMuPhi.Lt:102` is the sum of natural quotients floor(10^18/phi(q)) over odd squarefree q<=K. `S:160` is the actual real sum above, and `S_approx:163–202` proves

    Lt(K)<=10^18 S(K)<=Lt(K)+K.

I checked the quotient-floor directions and the positive totient denominator in this induction. The source `phiTD_spec:35–98` proves its squarefree/totient alternatives under the no-smaller-prime-factor invariant, and `walkS_spec:128–157` transports the computed state across precisely q+1 through q+len. The closed walk declarations and checkpoint chain supply the reported source values. In particular,

    c_132:485: Lt(132000)=6734875660393277758.

It is obtained using w_131, not the walk starting at132000. This distinction prevents an off-by-one-block substitution. The cited c_133, c_134 and c_135 values also match their actual declarations.

Since the finite indexing sets are nested and the summands nonnegative,

    S(132000)<=S(132900),
    M(132900)>=2*6734875660393277758/10^18
               =3367437830196638879/250000000000000000.

No estimate for the additional900 positions is necessary. The missing formal adapter is ordinary finite-sum monotonicity plus generic natural-R Qset pairing. It is not a new numerical hypothesis.

The report's alternative tail identity has the correct endpoint convention R<q<=150000. Its upper-tail formula uses an upper S(150000) and a lower S(K); it does not subtract two lower bounds and mislabel the difference. Neither alternative is needed for the selected candidate.

## Actual analytic consumption and source domains

The only change to the prior joint envelope is the lower mass. The positive multiplier .638108 and division by1.00001 transport it to lower J_R and the actual prime-supported I_R. The original upper mass13.59756, upper J8.79, modulus cardinal bound300000, squared-weight bounds and all major error terms are retained. The singular Rankin loss22.1/R is a different quantity and is unchanged.

The minor expression uses G_Y(R)*(cl0*sD-j). Raising the lower j helps the true expression, but replacing G by an upper enclosure still needs a nonnegative upper factor. All nine such factors and the asymptotic one are positive in the saved rows and in my reconstruction. All base-gap, mass, J, I, singular, major, and joint-positivity guards agree.

R132900 is even and exceeds the original large-sieve floor100000. It has q<=265800<300000; the original arc geometry still gives wx>=4 and2w<=1200000/x. The original twist bounds therefore remain valid. Retaining q-tilde in the base-gap witness restricts primitive conductors to odd c<=132900 and4|c<=265800. The original inclusive heights1e8/c and max(1e8/c,200+7.5e7/c), inverse-character coverage and principal inputs are unchanged. No .555/global7/8 or .65-energy route is used.

The accepted scale argument N>=N0 implies x>4.9e26 and y>1e25, including the threshold endpoint. Thus the nine old scale cells and asymptotic branch cover the complete required range without extending a cell below its proved domain. The exact original nonprime normalization remains

    49*c0^2*6.7e6*log(N)/sqrt(N)
       <=20618162523/7784250095800.

The final assertion is the joint major-minus-minor-minus-nonprime coefficient, not preservation of the old minor constant1.0376. The previously identified final NumericsGoal/MinorTotal/Main adapters are still required; no old broad-Platt theorem can be used as a black box to claim the reduced dependency set.

## Independent scalar reconstruction

The independent checker verifies all source/report/script/receipt pins, reads the actual c_k declarations, and binds all nine Y values to their source theorem sections, including cell1 at3e25. It separately parses the old chain coefficients, log weights, sD and tail scalars. A literal comparison also verifies that the author's copied scalar engine differs from the accepted engine only at the lower-mass assignment.

Using the saved rational G bounds as enclosures, it reconstructs45 finite-cell compositions,5 asymptotic compositions and50 row guards. All exact rational lower masses, J/I bounds, singular and major bounds, base gaps, minor upper bounds, final margins and pass/fail flags match. This validates their composition; the unchanged rational log/root enclosure algorithm was source-reviewed previously and is not independently rerun here.

The selected exact final margin is

    17454234627055702473150105611895106422794893597
    /12867056213564954145112500000000000000000000000000
       in(.0013565,.0013566).

Four additional exact comparisons verify the quoted I lower fraction, base-gap fraction and .0135043 bound, the other finite margins>.02317, and asymptotic margin>.2729. Cell0 controls every saved row. The132000 failure is retained;132900 passes using the132000 lower checkpoint. No new cutoff was searched in this review.

The optional fresh-tail arithmetic is also conservative: there are8550 odd positions in(132900,150000];8550*193=1650150 potential odd trial-divisor tests;8550/2^64<2^-50. These are merely a possible certificate design and coarse work count. The selected proof does not produce or require that new tail certificate.

## Efficiency and remaining scope

Source reuse is not zero-cost compilation: the current SmallMuPhi file contains the full closed-walk declarations and their proof dependencies. The author's warning that truncating at c_132 would not remove later w_i declarations is accurate. A future import/layout optimization must be assessed separately.

R132900 removes2100 more eligible nonprincipal conductor indices than R135000, but this review does not turn that into a character count, runtime or end-to-end proof saving. It does not justify another tiny cutoff search. The actionable next work is the already stated source-interface and certificate-cost assessment; no automatic refinement follows from the available margin.

## Frozen artifacts

Paths below are relative to `work/qrh-campaign/agents/`, except the source paths marked separately.

|Artifact|SHA256|
|---|---|
|`prime-estimates/EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md`|`429562CD92AF356BD84EED1C253D0A9E95D434262DF08CCCAC8EAF3D15CE234D`|
|`prime-estimates/source_mass_joint_cutoff_20261111.py`|`F243DD01285D8FA78F72A38AFFF1F2842436D4110F1E7B616B2111DB6712488A`|
|`prime-estimates/source_mass_joint_cutoff_20261111.json`|`67F6C3BAE93EDE7BD93C49A4EC8B442671A921D9E71B5AEC4925031261984FC9`|
|`integration/EXACT_MASS_TAIL_SOURCE_JOIN_2026-11-11.md`|`7BCBA7142E2B069ABEFB3F1FD6490DE00F3BFCEC0E4D6FAC1140DB88F048DE8E`|
|source `TernaryGoldbach/Prelim/SmallMuPhi.lean`|`7ECE1D48D9679ECF529A5566C79D06FADB3CA70CCAF057ADAA020D6AA390BADF`|
|source `TernaryGoldbach/MajorArcs/SumMuPhi.lean`|`7AC4662598355DDA40720B43956223BD3C5456D503B206A77D48E4569ADE18A4`|
|`major-constants/review_source_mass_cutoff_20261111.py`|`022E3762CDA2576CF6A648F3F51C4429E05931C6BDDB2F685BC9CD14A65EC31D`|
|`major-constants/review_source_mass_cutoff_20261111.json`|`29DE5E5D537EACF9290F9EBA8C5A48ABB5F1F936CA26B3DC178E67DD0EFA1BC4`|
