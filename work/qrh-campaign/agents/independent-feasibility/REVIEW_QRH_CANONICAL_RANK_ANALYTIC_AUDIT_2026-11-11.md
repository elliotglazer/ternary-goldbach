# Independent review of canonical rank energy existence

2026-11-11. PASS at bounded source and mathematical-review scope. I found no local defect in the inspected induction, actual child-radius and margin algebra, normalization, or quantifier ordering. No correction to the author report is required. This is not a compilation, axiom audit, or validation of the global QRH provider.

Reviewed author: `work/qrh-campaign/agents/major-constants/QRH_CANONICAL_RANK_ANALYTIC_AUDIT_2026-11-11.md`, SHA256 `2767A7CC08CC13239EFDBC5242D47505FC44028016251407B21A542CDC98FF4B`. I read the full report, compared it with the source bodies described below, and independently verified its 50 source/boundary hashes. Hash agreement binds the reviewed bytes; it does not validate uninspected declarations.

No Lean source, frozen report, or dependency was changed. No builds, declarations, analytic-function evaluations or production scans were run.

## Actual object and quantifiers

The source root is `work/openai-math/lean/OAI/NumberTheory/DirichletL/`. References below are relative to this root. The source repository is pinned at commit `4eaee87548250b2682affda7d05d947c05554bae`.

`Descent/CanonicalRankMoments.lean:19` quantifies over an actual base-ray twist, nonzero Eisenstein integer m, nonnegative N,V,M,Q, every subcollection of slots, every admissible finite label collection, and every real log-frequency s. Its conclusion is

    E_normalized <= A Z^(N+V+eps) (1+|s|)^(2 degree).

The hypotheses include M<=Mmax, N+V<=Fcap, the two inequalities

    c <= N+V-M-Q-z,
    c <= 4(N+V)-3M-6z,

and the actual norm identity |embedding(m)|^2=Z^Q. The two inequalities are `Descent/Basic.lean:13`, not a differently defined abstract admissibility predicate.

`Inversion/InitialClippedColumns.lean:199` defines E_normalized as a finite sum of squared norms of Z^(-(N+V)/2) times `finiteCanonicalMarkedRow`. The label weight is divisorCard(I)^(9+4K), by `Descent/SecondNormalizedEnergy.lean:35`, hence nonnegative. For Z>0 the normalization squares to Z^(-(N+V)). `Descent/Canonical.lean:16` defines the marked row using the actual `fixedChildRow` with coefficient primeMark*W(primeProductNorm/X). `childLogTest` is W(y)*logPhase(s,log y), not a replacement test function.

The normalized estimate therefore corresponds to an unnormalized weighted square sum bounded by A Z^(2(N+V)+eps)(1+|s|)^(2 degree). Its positivity is nonnegativity; no strict positivity follows for arbitrary W, empty labels or zero coefficients. The existence theorem does not assert a nonzero probe or supply the lower bound needed by a later contradiction.

`Descent/CanonicalCompleteNormalized.lean:17,39` preserves this normalization when replacing primaryGenerator by idealGenerator. I checked the actual mechanism in `Descent/CanonicalLongNormalization.lean:17-56`: a unit u relates the generators, and k -> u^4 k bijects the entire nonzero frequency ball. The equality is for the full squared sum, not pointwise equality at the same k. The deeper generator-transfer identity remains an arithmetic input.

`CanonicalRankExistenceData.lean:36` and `CanonicalEnergyExistenceData.lean:14` have the order

    exists degree,B>=1; forall q!=0; exists C>0,Z0>1;
    forall Z>=Z0, D>=B Z^L, slots, lists,H,a,z,base; ... .

Thus degree and B are independent of q. C and Z0 may depend on q and the fixed outer parameters, but not on D, the lists, coefficients, base, row m, labels or real frequency. No explicit numerical Z0 or uniform threshold over all conductors is produced. Allowing D to be any sufficiently large natural number avoids a hidden finite-pool restriction at this layer.

## Genuine induction and finite depth

Write d=cutoff>0. The actual schedules in `CanonicalRankExistenceData.lean:28-34` are

    M_n=3(n-1)d/4, F_n=L-15n eta,
    c_n=cstar/2+7n eta, e_n=62n eta.

At n=0, M_0=-3d/4. The proof of `canonical_rank_negative` in `CanonicalRankMonotone.lean:17` contradicts 0<=M<=M_0. This deliberately vacuous base case is valid. It is not a proof that the real energy vanishes.

At rank n+1 the four compactly supported child profiles are obtained before invoking the induction hypothesis, which is universally quantified over profiles and positive-support intervals. Every recursive call is at n. Their degrees are added, their B constants are combined with 1+hi, and their positive C constants are added only after q is fixed. There is no recursive reference to the rank n+1 conclusion.

For a parent state, the four children fit

    M_child <= M_parent-3d/4 <= M_n,
    F_child <= F_parent+15eta <= F_n,
    c_n <= c_parent-7eta.

These are exactly `actual_rank_successor_caps`, not approximate inequalities. `canonical_rank_restrict` has the correct direction for margins: a larger requested margin gives a smaller state domain. Subslot restriction composes inclusions, and the product bound persists because H_i>=1. All four child bounds apply to the same inherited pool and base family.

The top-level choice has no eta/depth circularity. Set csmall=min(c,1), then d=csmall/1000, then

    n=ceil(4 Mcap/(3d))+1, Ddepth=n+1,
    eta=min(1,d/32,csmall/200000,csmall/(28Ddepth),
            1/(30Ddepth),eps/(800Ddepth)).

This is the actual construction in `RecursionParameters.lean:43` followed by `CanonicalRankDepthParameters.lean:19`. In particular eta>0, M_n>=Mcap, 15n eta<=1, 7n eta<=c/2, and 62n eta<=eps/4<eps. With L=Fcap+1, F_n>=Fcap and c_n<=c. `canonical_energy_of_rank` restricts to exactly the requested final state domain and weakens only the allowed loss. The top theorem can be vacuous for incompatible requested state parameters, but it does not force every final state to be empty. Establishing an actual admissible nonzero input for a later application is separate.

## Actual progress and child-state interfaces

The row drop is tied to a nonempty actual long bin. In `CanonicalLongGeometry.lean:19`, ell=log_Z(normLogScale j), r=N-3ell. A witness in progressingCubes gives ell+V>=d-eta, while the bin's actual cube norm gives r>=-eta, ell>=0 and ell<=L. Since eta<=d/32,

    ell+V>=d/2, eta<=(d/2)/16.

`CanonicalLiveBinRank.lean:15` therefore invokes the child theorem with terminal cutoff d/2. It does not pretend the possibly negative r is nonnegative. The actual column exponent is clipped by max(0,...).

`FirstCanonicalChildren.lean:41` supplies nonnegative actual row and label exponents, the actual clipped total bound F_child<=F_parent+15eta, and row drop 3(d/2)/2. `GlobalRetainedGatesRank.lean:16` gets a witness from membership in an actual cell before calling its row-decrease theorem. Empty bins/cells do not need a decrease witness; they contribute no such recursive term.

The underlying algebra in `Basic.lean` is independently consistent. If g-theta>=-2eta, j<=2ell+3eta and A,t>=0, then

    M-childM = 4ell+2A+2t+2(g-theta)+2V-j-eta
             >= 2(ell+V)-8eta >= 3d_terminal/2.

Here d_terminal=d/2. The last inequality uses eta<=d_terminal/16. The displayed expression follows `childM=M-2*decrease-2ell+j+eta` with decrease=ell+A+t+g-theta+V.

I also independently inspected the additional correlated-radius calculation in the frozen author report. `SecondCorrelatedCutoff.lean:30` defines the retained radius as

    |embedding(d_first)|^2 * (Norm(E)/Norm(G))^2 * Lcol^2 * H/Y.

`SecondCutoffScale.lean:13,46` bounds these factors by powers with exponents deltaFirst+eta, 2(theta-g+2eta), 2(r-A-B-t+4eta), tau, and -(Hphysical+12eta+tau). Their sum is

    2(r-A-B-t-g)-Hphysical+deltaFirst+2theta+eta.

Substitution of `PhysicalExponents.firstPhysicalHeight=2r-2B-M+4ell+2V+deltaFirst-j` gives exactly childM. The tau terms cancel; the remaining padding is one eta. Positivity of Z, Norm(G), Y and nonnegativity of Lcol are present before the quotient and square comparisons. `ActualChildStateSupport.lean:31` transfers actual retained row membership through the actual multiplier; `ActualChildStateRadius.lean:15,53` then uses a nonzero lattice frequency of squared norm at least one to infer childM>=0 for live cells. No such inference is made for an empty cell. The analytic estimate on frequencies outside the retained radius is still a separate input.

For total width, `ActualChildState.lean:25,92` uses its actual transition and clipping bound. With clipping<=6eta the label addition makes delta<=10eta, so F_child<=F_parent+15eta. One must not apply the older delta<=6eta, +11eta lemma unchanged to this actual state. The source explicitly takes the larger allowance.

For margins, `SecondSharpPuncture.lean` bounds the norm of the actual inherited radical puncture by the parent radical norm times the actual quotient/cube/residual norms, then takes log_Z. It gives Q_child<=Q+ell+t+g-theta+4eta. Since A,V>=0 this is no larger than Q+decrease+4eta. `Basic.child_margins` then gives c_child=c-7eta. The actual nonzero puncture and norm identity enter the child `CanonicalRankMoments` call, rather than assuming a freely chosen child conductor width.

I checked these caller bodies and algebra. This is not a full proof audit of the ideal-factor, source-validity, second-cell clipping and frequency-nonzero producers they call.

## Cost and uniformity closure

For L>=1 and 0<eta<=1, eFirst=eta/(10L+32), eMass=2eta/(20(3L+16)+30), tau=eta and pi=8eta. The source checks

    eMass*(20(3L+16)+30)=2eta=pi/4,
    48eta+tau+pi+e_child+eta=e_child+58eta,
    (e_child+58eta)+(2L+16eta+1)eFirst<=e_child+60eta,
    2L eFirst<=eta,
    e_child+60eta+2L eFirst+eta<=e_child+62eta.

The potentially separate principal bound 3eta+eFirst(2L+7eta)<=e_child+60eta also holds. All divisions have positive denominators. The source uses these exact allowances in the completed step. No implicit loss is erased at the final conversion.

The short term has exponent F-cstar/256 and nonnegative coefficient Cs; the long term has exponent at most F+e_(n+1). Since Z>=1 and e_(n+1)>=0, `CanonicalCompleteBudget.lean:25` merges them under (Cs+Cb)(1+A). The polynomial height degree is enlarged by a maximum and then doubled to the convention used in `CanonicalRankMoments`; both are safe because 1+|theta|>=1. `childLogTest W theta=normTwistedSource W theta` follows commutativity of their two actual factors.

The reference cutoff is produced by a smooth compact cutoff equal to 1 on the required fixed interval. `Inversion/CanonicalReferenceThreshold.lean:34` uses Z0=2+exp((2+|hi|+|Alog|+|window|)/eta). Its positive eta guarantees every displayed scale gate eventually. Child profiles and support bounds precede this threshold, while q-dependent analytic constants and four child thresholds are combined afterward. No fixed threshold is secretly asked to dominate a subsequently arbitrary window or frequency.

## Scope and remaining proof cut

The inspected rank recursion, parameter schedule, normalized energy interface and caller-level actual progress are mathematically consistent. No circular invocation of the desired QRH conclusion appears in this bounded chain. This is not evidence that every transitive analytic input has been validated.

The finite aggregation itself was also inspected in `CanonicalCompleteState.lean` and `CanonicalLongTotal.lean`. The short contribution is separately bounded; when cutoff<=V, the source uses the short-sum identity at threshold at most one. Otherwise it invokes the short analytic estimate. The long contributions retain an actual live-bin hypothesis and use the supplied count estimate with two eps/2 factors. These bodies agree with the author report, but do not independently establish the deeper short-sum identity, split or counting theorem.

The next substantive work is the short/long estimate behind `actual_complete_state_from_children`, including the actual short squarefree estimate, finite physical/Poisson completion, two-pass retained/deleted decomposition and uniform integration/separation bounds. The actual ideal-factor and source-cell producers used by the child geometry also remain a deeper arithmetic cut. Their existence as named Lean declarations is not an independent proof review.

Later applications must still instantiate admissible actual states and establish any necessary lower bound or nonzero normalization. Target-toolchain elaboration, expanded statement comparison and transitive standard-axiom checks remain unrun. Nothing in this review removes the finite spectral, finite-prime, PlattGRH-replacement or final Goldbach implementation obligations.

## Inspected source pins

Raw SHA256 pins bind the bytes inspected. Full-file reading does not mean every imported theorem was independently established. Partial ranges below describe actual reading scope.

| Source | Reading scope | SHA256 |
|---|---|---|
| `Descent/CanonicalRankExistence.lean` | Full | `7B299DCB2DE3C671BC9C84E5E5D2F3D0CF2D3192D30CADF1A2041867EFD21427` |
| `Descent/CanonicalRankExistenceInduction.lean` | Full | `EAF8639E1BA4D9E8A89DC4FD6F1FB9471CFF5F7BDE7D646D255D0EFCAE374934` |
| `Descent/CanonicalRankExistenceData.lean` | Full | `D285834EBA420F8FFB3E696972C2680BEB23A7A97383FFC2EA2108372054F3CC` |
| `Descent/CanonicalRankExistenceSuccessor.lean` | Full | `D2843F8CBBD084E83E1682DD8FB9160F593F807C8C461E37BF54AA6A4D736745` |
| `Descent/CanonicalEnergyExistenceData.lean` | Full | `2E53E4682091E687689E7014833AD33F6983A888B92E2CE39CC5B337FFFA26E3` |
| `Descent/CanonicalCompleteRankNormalized.lean` | Full | `72AB6C4781B92B236F40893B69C6D2FEC4B1BF6DD7A2731950FE1BAE1F61CB6E` |
| `Descent/CanonicalRankDepthParameters.lean` | Full | `BB38E5DEDD665427C01B2225536493DFAA0BD775078BDEAAF76E9E828608E8FA` |
| `Descent/CanonicalRankEnergyMonotone.lean` | Full | `ED9E5927B3E1C3B89AC73E756FF4C09A38A251896827F9A5878E2B5B1090A3EE` |
| `Descent/CanonicalRankMoments.lean` | Full | `7311954BBB54718ACEC29DC50699F7D447AA5B27A9C660E1AE88B4EFD415F964` |
| `Descent/CanonicalRankMonotone.lean` | Full | `54BE93ED5C5E785B87DCC49D33E942E6ACB1A766BF248A2575BC859FB3F41C55` |
| `Descent/CanonicalCompleteNormalized.lean` | Full | `38844550D49193E746FA5B13EC5D986B8907EE01ED905EC8FC1A9D0AD7BC39D9` |
| `Descent/Basic.lean` | Full | `DFA8CB13C1C5D34E1AA629D46719B33E93194CF04380DBF65B00E064D33DFFBC` |
| `Descent/RecursionParameters.lean` | Full | `D2046807FF141FD4CEEA99987376A80427690201865E956FE0F7E6E56C546C5E` |
| `Descent/CanonicalRankPuncture.lean` | Full | `88CEB16E246C96376F153120FB4D57B6C460845D1709758334090235F1F03152` |
| `Descent/CanonicalRankFamilyGates.lean` | Full | `117BF4AC0B499BD5D61F1F09D5FFBBCF16BF063EE0D2154C4C20E38BDFC3C813` |
| `Descent/CanonicalCompleteBudget.lean` | Full | `461CDEB2A19F95627E7CCBDD029A404A895F4D8DEC49A9C5FDB45C64275C50BF` |
| `Descent/CanonicalChildSupport.lean` | Full | `20F71569AA1FE27C4D691B51765D2B6AF4EBDB5B0B0BECFB1BB28BCA998B08BC` |
| `Descent/CanonicalLiveBinRank.lean` | Full | `85E700FA983999972342803BA459FE29E7B0706C6F0A741582AEF5DBDBB2891F` |
| `Descent/CanonicalLongGeometry.lean` | Full | `D986FB9CAEB6ECC0ECC54E007D8CD3893922BB0A2522ACEAB91D2294D2A54CFA` |
| `Descent/FirstCanonicalChildren.lean` | Full | `BB257583B32E8DF63270DB0CFB1997AD598A7D84B4AA1C6EECFA4BC2570BD00A` |
| `Descent/GlobalRetainedGatesRank.lean` | Full | `A851EC142902DF2B0E327E432BEB772D83F0C8F20CFE6F08425579E5628FF5D3` |
| `Descent/ActualChildState.lean` | Full | `3103F38BE43A6467F35147F9CC83156370D52928F9B3F0DEA342E1782F6CDC46` |
| `Descent/SecondSharpPuncture.lean` | Full | `F0EE55623705FAFB04DB0E22EA028152C2277CD4A74C4374611013E6FB9422FC` |
| `Inversion/CanonicalReferenceThreshold.lean` | Full | `6EC6B1F8CF53AB89CDB9A5419FF0DEBD57BB9F3D3684A2AC42CCC4AAB62C832E` |
| `Descent/SourceDepth.lean` | Full | `653248A096C722B038C2E305FFF6FF7303AF576BDAA4A7991D41DAD267B5B6AB` |
| `Inversion/InitialClippedColumns.lean` | 121-244, especially definition at 199 | `19424723657E5E55AC5648A7ED4922A83AF977AD9448C9F599E4B9F5DAFF2B94` |
| `Descent/Canonical.lean` | 1-75 | `E6ECEECC674D0D979E656D94A5AABF549DADBFA5DA00F61FFC871A8BD32FD433` |
| `Descent/SecondSeparatedColumns.lean` | 1-35 | `255B8FA3DAF6B079559FAFF9C1EC806C35B4048868A603CBC91296C732459CFA` |
| `Descent/CanonicalCompleteRank.lean` | proof body from 77 to end; full signature through normalized wrapper | `ECFDC826302CAE631A60B05E36EC845BEF79B63B7D0B4F812D131073D99B4389` |
| `Descent/FirstLabelCellStepChildren.lean` | 1-108 | `8110CAA288516F6C454477292C87357472AD50A03394CCFFF3F01F05E012CE4D` |
| `Descent/GlobalRetainedGatesChildren.lean` | 49 to end | `F906C5A0EAD09F7C88144742441285E4230B878BD3F3209366A08B6B65E067C4` |
| `Descent/CanonicalLongNormalization.lean` | 1-97 | `8A8D43E83EC5F42FF0470DD5391BAD4F12CDAD90237CC43136DFA3C7B958042B` |
| `Descent/SecondNormalizedEnergy.lean` | 29-39 | `CCC23556F52E7CCBF521A54B022BCE64ED645F92317913CB2F47401144CE5F0C` |
| `Descent/SecondCutoffScale.lean` | Full | `1DCD4B002E78321BDBEE225577610996A6AD3BFB7C3A927FE6C7D1B679F6EE39` |
| `Descent/ActualChildStateRadius.lean` | Full | `367B354C5803FBE62615635B39DFE1B524FD65812C50F564C863D8AEBF08FE8A` |
| `Descent/ActualChildStateSupport.lean` | Full | `3C86C5A6A382E51A654A2689A33F21E98EDBA0F958581723AF6834F8C095B51B` |
| `Descent/PhysicalExponents.lean` | Full | `A872431FB5FA7D144735553D9988AA797E780F4679A73A53FB3491E341ABF509` |
| `Descent/CanonicalCompleteState.lean` | Full | `F40A5D850F6EBF8A7C41AFCE37E543B4632B64964FED7EBFAF91CB9241D929DB` |
| `Descent/CanonicalLongTotal.lean` | Full | `3195F9E7D9E43E913B9C01927F341CDAB90AB38611CDE3F63A6F5A9EFFE2409F` |
| `Descent/SecondTripleBounds.lean` | 1-50 | `170F93B84EAD643BD56E5B8D78421E4903EAD2160DF446AA1EE7B47C2ABE64B9` |
| `Descent/SecondCorrelatedCutoff.lean` | 1-43; definition and tail-theorem entrance only | `BBA86B2CCF9D2832C3BDE0C36466DFFA5961273D5A8E29D39EC272F68FD2878E` |

The table records 41 locally inspected source files, overlapping the author manifest. The author report covers additional boundaries; those additional entries were hash-checked, not all independently read in full. The reference cutoff and eventual-growth proof were read here beyond the boundary status given in the author report. Their remaining foundation is the smooth-cutoff existence theorem, not a QRH hypothesis.
