# Review of post-transform closure and the auxiliary seed domain

2026-11-11. PASS at conditional paper and exact-metadata scope, with no correction requested. This review binds `integration/R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md`, SHA256 `F718551E44C343FB874AAD919290D002F402760B5B6B44772B534C087AF2D054`.

I read the complete author note, scalar source/receipt, the scaled Hurwitz seed construction, its shared EM parent, the height-recurrence review and the elementary-leaf baseline. I independently reconstructed the parameter extension and count identities. The d=2 finite-RH theorem has a separate assigned review; here its use remains conditional. No function, phase, root, FFT or zero was evaluated. No build or author-file change occurred.

## Counts and legitimate sharing

The large-branch counts match the frozen R132900 inventory: 125400 conductors, 4333246843 primitive labels and 66172730256514 coarse outputs. The three different cache scales are correct: two parity objects per global height, at most two parity objects per conductor/height, and one root phase per actual label. The first count is 255978, the second upper count is 5470446910, and conductor phase recurrences require sum(J)-125400=2735098055 updates. These are requested objects and updates, not existing values. Missing real-character counts prevent substituting n/2 for the orbit count.

For ordinary eightfold refinement of each channel's J nodes, J+7(J-1)=8J-7 gives the author's aggregate 8Q-7n. Only 7(Q-n) are new positions. This does not imply that any particular strict signs pass or that all positions are needed in the retained certificate. The dependency union of selected interpolation outputs can still contain most coarse inputs. I checked the five stated arithmetic savings and their exact per-output rational ratios against the stored totals. The report correctly keeps different operation categories separate and does not turn them into timings.

The phase split phi0=(t/2)log(c)+f_a(t) is exact for the reviewed proxy. For actual unit factors epsilon,q, errors e,f in their centers give

    |epsilon*q-epsilon_hat*q_hat| <= e(1+f)+f.

Splitting off the L error using the actual unit product yields r_L+|Lhat|[e(1+f)+f]+r_A. There is no missing factor multiplying r_L. The proxy supplies signs through a positive cosine identity; it does not supply values of the completed function required by a sampling theorem. The stated conversion from unit Hardy to F_eta retains pi^(-alpha), the Gamma magnitude and the tilt. This additional value-normalization work cannot be replaced by the coarse proxy's sign equivalence.

## Closure contract and exclusions

Each alternating run of k intervals uses k+1 endpoints. For b disjoint nonempty runs the count is k+b before any separately justified endpoint identification. Exact endpoint ordering and character/phase binding are necessary. Opposite signs yield a critical-line zero in the open interval, so disjoint interiors avoid double counting. Ordinary signs do not prove completeness, count even-order zeros or imply nonzero central values.

Real-character doubling and two positive inverse channels for nonreal pairs are correctly distinguished. The default central contribution zero is a valid lower count, not a central nonvanishing claim. The closed count retains real zeros, endpoint zeros and actual multiplicity. The interval upper endpoint v gives the lower integrated weight H-v; a midpoint cannot substitute for v. Count boxes need their own disjointness and actual zero-count proofs.

The canonical Gamma integral separates as [(H^2-T^2)/(2pi)]log(c)+A(1,a;T,H). This follows by integrating the conductor term t*log(c)/pi in 2theta/pi. Thus parity/endpoint sharing is legitimate. The elementary proxy phase cannot replace this analytic phase without an error allowance.

The d=1 inequality gives C<K+1 and hence C=K by integrality. The d=2 row is expressly conditional on the separate source theorem and must never export exact count. I have not broadened its acceptance here. All auxiliary surplus rows also remain conditional on the actual measured deficit. Increasing h does not supply K, W or Abar. The statement that a common unchanged post-processing cost cancels from an absolute comparison, while diluting a relative saving, is correct.

## Independent extension to V=10200

This is a new domain implication, not an application of the old V<=10000 statement without change. Take V=10200, D=8192, m=64, N=3454 and P<=32. Then N=ceil((V+160)/3), b=N+z<=3456, and V+160<3(N+1). The shared EM remainder argument therefore still has W/(6b)<1/2 for every real anchor z in [1,2], both signs of t and every required rising factor. Its rational remainder is

    216*(N+2)/(255*2^128) < 2^-116.

Also (V+32)/D<5/4. Thus the scaled rising-product recurrence and contracting E/lambda recurrences retain their original bounds, including the pole-term denominator |s+k-1|>=1/2. No correction term is omitted.

Let delta=2^-118, u=2^-122 and eta=2^-100. I reconstructed the seed error from its separate pieces, rather than only checking a collapsed expression:

    head <=5N*delta+(5NP+3N+1)u,
    endpoint <=(2b+1)delta+(16b+255)u,
    final addition <=u, and EM remainder <2^-116.

At P=32 their sum divided by eta is (291N+433)/2^22<1/4. The factorial magnitude argument still gives C<=3N+5 and every shifted stored center below 4C+1=41469<2^16. This retains the seed's stored-center width allowance. It does not bound exact multiplication numerators, divisions, proof terms, transform accumulators or total memory.

For P27 shifts, 3(V+27)/(4D)<15/16. The independently checked complete alpha allocation is

    1266*(5/16)^20/20! +1266*(15/16)^27/27!
       +2532*2^-100+633*330*2^-110+1688*2^-100 <2^-82.

This includes target truncation, coarse-to-midpoint truncation, seed errors, shift rounding and final Horner rounding. It still requires the actual source identities and conductor normalization. The resulting allocation is not a sign margin.

The old elementary-leaf domain must be generalized explicitly. Its proof extends because 3456<4096 retains k<=11, and (8/3)^9>3456 proves log(x)<9. For every p>=1, 10200*2^(-(p+17))<2^-p/8, and the approximate phase remains below 9*10200+1<100000. Thus its atanh/Machin/cis term lengths and inverse-square-root witness argument retain their sufficient error budgets. This is an argument about the whole new range, not generated elementary enclosures.

For the fine height state, J=130548<131072 and J*2^-140<1/2. The same geometric error proof yields

    final error/delta <=1/2+J/2^20+1/16 <11/16.

The step-generation error and initial leaf targets are unchanged; new arguments may initialize at their actual first-use height because the generalized direct-leaf range includes it. The state and step magnitudes remain below 2, so the stated 144-bit stored-coordinate formats remain sufficient. The converted EM copy must not replace the fine recurrence state. Negative-height reuse still needs the actual inverse/conjugation identity.

The worst endpoint is index 130548, height 10199.0625. The new argument union is (3454+1)*8192+1=28303361, adding 548864 arguments. These require binding, log/amplitude/step certificates, initialization and storage or regeneration. Their additional heights need new seed contractions and character outputs. They are not present merely because a previous global table existed. The h250 endpoint exceeds 10208, where the unchanged sufficient condition (V+32)/8192<5/4 fails. This is failure of this allocation, not impossibility of an alternative evaluator.

No interpolation guard is covered by this endpoint calculation unless its actual sample arguments also lie in the proved domain. Every guard extension must be rechecked. Likewise no revised fixed-width arithmetic implementation or actual containment in old immutable boxes follows from these new inequalities.

## Evidence and limits

Author scalar script SHA256 `359570B7483C112EE8B9035284481C36EF56E0B066BCB55608A8C9104DA23314`; receipt SHA256 `42270237BFEDBC8FFA0FDCE7F5CA913044CE5A0B9624AAFB11882FC48B39F881`.

Independent script `zero-sum/review_post_transform_extension_20261111.py`, SHA256 `897BC1D742030D10A81DD6815FF56BBA67303FE663EF839174C42A385F20F9D0`, completed 61 exact checks with `PASS_EXACT_EXTENSION_AND_METADATA`. Its receipt SHA256 is `0292AD69B04831459176A14E1F6619791CC8CC62C0A98525841132F5B8A4E7B8`. All 19 author receipt input pins matched. The script imports no author code. It reconstructs the error pieces and complete alpha budget, in addition to counts and conditional surplus arithmetic.

The reviewed artifact is a sound conditional interface and cost inventory. Actual elementary/seed/transform enclosures, root phases, interpolation normalization and guards, strict signs, weighted auxiliary evidence, canonical Gamma integrals and final closures remain absent. Unresolved characters or intervals reject full acceptance. Neither the arithmetic extension nor the d=2 conditional allowance proves termination, simplicity, original RH or a runtime improvement.
