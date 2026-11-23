# Shorter final-band head with more EM corrections

2026-11-11. Conditional paper construction and exact rational metadata. One sufficient replacement at fixed D is **(V,D,N,m)=(7000,8192,1500,256)**, with coarse P27 and final P20. It preserves the selected coefficient and isolated-alpha error contracts. No Hurwitz, exponential, prime, zero or transform values were evaluated; no Lean source or build was changed. The comparison is with V7000/D8192/N2387/m64, not the older V10000 band. No D4096 change is combined with this result.

The smaller head is paid for by a weaker but still contracting E recurrence and192 additional Bernoulli terms per coefficient. Below, both costs and every changed error term are included. This is one conservative pair, not an optimal N/m search.

## 1. Exact coefficients and the actual remainder

For s=1/2+it, |t|<=7000, a in[0,1], z=1+a and b=N+z, retain the actual scaled normalized derivatives

    U_k(a)=(-1)^k(s)_k zeta(s+k,1+a)/(D^k k!), 0<=k<P<=32.

The implemented order is27, except the final coarse endpoint requires20. Now1501<=b<=1502. The continued Hurwitz EM identity and periodic-Bernoulli remainder are exactly those of the reviewed shared seed circuit, valid since Re(s+k)+2m>1 and |s+k-1|>=1/2. In particular k=0,t=0 is covered; no pole is omitted.

Set W=V+32+2m=7544 and r=17/20. The complete rising product in the kth remainder is (s)_(k+512). Every relevant factor has norm<=W. The same Bernoulli Fourier bound, valid for every positive integer m, gives

    |U_k remainder| <=4 sqrt(b)/(k+511.5)
          * (W/(bD))^k/k! * (W/(6b))^512.

Here W/(bD)<1 and W/(6b)<17/20. Thus for every k in the required range

    remainder <= R=4*1502/(511.5)*(17/20)^512 <2^-116.    (1)

The inequality is an exact rational power comparison. It uses the scaled coefficient directly; reusing the old raw factor3^k/k! would waste the D^-k benefit. No asymptotic expansion is treated as a convergent series: (1) bounds the actual finite EM remainder after256 corrections.

## 2. Complete finite circuit and changed contraction

Keep delta=2^-118 for the certified elementary powers B_x=x^-s, and complex absolute gate error u=2^-122. Put eta=2^-100. Retain the exact formulas

    R_k=(-1)^k(s)_k/(D^k k!),
    D_k=sum_(n<N) B_(n+z)*(n+z)^(-k),
    E_ell=(s)_ell/(6b)^ell,
    lambda_k=(-1)^k(6/D)^k/k!,
    gamma_j=6^(2j)B_(2j)/(2j)!, 1<=j<=256,
    S_k=sum_(j=1)^256 gamma_j E_(k+2j-1),
    Z_k=b E_k/(s+k-1)+E_k/2+S_k/6,
    F_k=lambda_k Z_k,
    U_k^(EM)=R_k D_k+B_b F_k.                         (2)

The identity lambda_k E_k=R_k/b^k proves the normalization. The pole-type term, half term and all signed corrections are retained. The largest stored E index is P+510:537 at P27 and530 at P20. Its final update uses the preceding index. The remainder's rising-product length is different and has already been charged in W.

All E update factors have norm<r, hence a per-update u error gives

    |Ehat_ell-E_ell| <=u/(1-r)=20u/3<7u.

The original2u bound must not be reused. The R and lambda recurrences still have errors<=3u and<=2u, respectively, because (V+32)/D<5/4 and6/D<1/2. Head reciprocal factors remain<=1. Exact accumulations use the common dyadic grid with sufficient integer capacity; exact rational factors and divisions are followed by the named rounding gate. A nearest coordinate grid of step u has Euclidean rounding error<u.

The general Bernoulli bound gives |gamma_j|<4 also for65<=j<=256. Round each gamma_j to absolute error<=u once and reuse it. These192 new rational constants and their proofs are setup work, not free analytic inputs. The exact Bernoulli recurrence through index512 and subsequent normalization supply the targets; no special-function evaluation is needed to define them.

Since |E_ell|<=r^ell,

    |S_k|<=4*r/(1-r^2)<13.

With |Ehat|<=2, each rounded gamma-E product has error<=4*(7u)+2u+u=31u. The full sum error is<=7936u. Rounding the three Z components separately yields errors at most(14b+1)u,5u,1324u, respectively, and consequently

    |Zhat-Z|<=(14b+1330)u,
    |Z|<=2b+3, |Zhat|<=2b+4.

The last bound uses the proved Z error<1. Multiplying by lambda with one rounding gate gives

    |Fhat-F|<=(18b+1339)u.

The final endpoint product, using |Bhat_b|<=2, has error at most

    (2b+3)delta+(36b+2679)u.                         (3)

The head estimate remains

    5N*delta+(5NP+3N+1)u.

Adding (1), (3) and one final rounded addition gives at P27

    |Uhat_k-U_k| <=10507delta+263753u+R <eta/4.       (4)

The exact script also checks the conservative P32 head version, replacing263753 by301253. It too is below eta/4. Thus the final P20 endpoint is covered without a separate, uncharged exception. No old m64 endpoint constant is reused.

## 3. Magnitudes, elementary leaves and final alpha error

Factor E_k out algebraically from each correction term in (2). The remaining products have total magnitude at most13. Without dividing by E_k, this proves

    |F_k| <=(2b+3)|R_k|/b^k,
    |U_k^(EM)| <=C*A^k/k!, C=3N+7=4507, A=(V+32)/D<5/4.

The previously reviewed positive Pascal-matrix shift argument therefore bounds stored shifted centers by4C+1=18029<2^16, including its perturbation allowance. E centers are<2, and the enlarged correction sum is<14. Exact Bernoulli numerators, rational division temporaries, integer products and phase arguments have their own larger widths; the16-bit magnitude bound is not a bound for those objects.

The exact function, D, P27/P20 orders and scaled displacements are unchanged. Therefore the two distinct true-function Taylor remainders remain1266*(5/16)^20/20! and1266*(15/16)^27/27!. The330 midpoint updates, u_T=2^-110, u_H=2^-100 and eta=2^-100 still give

    E_alpha <1266*(5/16)^20/20!+1266*(15/16)^27/27!
                +2532eta+633*330*u_T+1688*u_H <2^-82.

The delta supply can use the already accepted height recurrence: log error2^-144, initial B error2^-120, step/update errors2^-140, and separate EM-copy error2^-122, for fewer than128000 updates. Every new leaf has x<=1502, and the earlier bands have x<=1722; these are subsets of the previously proved domain. Initializing newly needed arguments at the final transition is permitted by the same height/domain proof. Rounded EM copies must not feed back into the fine recurrence.

## 4. Charge the extra corrections

For one final-band height, with D=8192 and the P20 endpoint retained, write K=27D+20=221204 and Q=26D+19=213011. The complete changed categories are:

| Per-height category | N2387/m64 | N1500/m256 |
|---|---:|---:|
|Head reciprocal real-times-complex scales NQ|508457257|319516500|
|Head complex additions NK|528013948|331806000|
|Bernoulli weighted terms mK|14157056|56628224|
|Bernoulli complex additions mK|14157056|56628224|
|E complex recurrence stages|1253522|4399634|
|Source coefficient slots|221204|221204|
|Midpoint updates|2703360|2703360|

The E count is(27+2m-2)D+(20+2m-2). Its increase384(D+1)=3146112 is retained. The head saves887Q scales and887K additions; the corrections add192K of each category. Thus the combined head/correction saving is146469589 real-times-complex scales and153736780 complex additions per height, before charging the additional E complex stages, factor construction and witnesses. Different gate kinds and widths have not been equated as equal-time operations.

For final-band length H multiply each row by H. The receipt records the combined-profile main and auxiliary lengths20199,20366,20519,20839. It does not add conductor FFT or residue-Horner savings, because neither changes here. R and lambda length, endpoint assembly count, P27/P20 slots and midpoint work remain unchanged. E buffers, if stored in full, grow by384 complex entries per active anchor. Setup now retains256 rounded gamma constants rather than64, plus the exact rational construction through Bernoulli index512. No bit-operation or runtime price is invented for this setup.

## 5. The argument set is no longer nested

N1500 is below the preceding band's N1720. A proof or implementation assuming monotone growth of the active x set must be changed. At the final transition:

* the preceding D4096 band has7049217 arguments through x=1722;
* the final D8192 band has12296193 arguments through x=1502;
* their intersection has6148097 arguments (the coarser points through1502);
*901120 preceding arguments are retired after their last use;
*6148096 new finer points are initialized at the transition.

The complete required union has13197313 arguments, compared with19562497 for N2387. Every retained state is updated at the transition; every new state is initialized at its actual first height. Retired states are never used later. Each individual argument still has a consecutive height interval of length<128000, so retirement does not change its recurrence error proof. This is a finite set/dependency argument, not an assumed zero cost for deletion or reinitialization.

For H final-band heights, there are H*12296193 final pairs/conversions and H*12296193-6148096 final recurrence updates. The earlier-band work is unchanged. Relative to the N2387 band, pair savings are H*7266304 and recurrence-update savings are H*7266304-6365184. Initial B/step-cis/step-grid certificate counts decrease by6365184 over the complete required union.

For a simple source-faithful log implementation, deliberately retain the entire fine D8192 log grid through1722, even though901120 fine points there are unused. This costs14098433 log outputs. The unchanged relative-radius block construction has959 anchors and21*(14098433-959)=296046954 nonanchor Horner stages. It is a prefix of the N2387 grid's partition, with its last block possibly shortened. The selected log precision is unchanged. This conservative log setup is charged separately from the smaller actual phase/state union; it avoids claiming an unproved sparse-anchor saving.

## Evidence and scope

The new seed_head_correction_tradeoff_20261111.py and JSON contain20 exact checks, all per-height and four-prefix counts, the set-transition identities, the log block count and six input SHA256 pins. The shared EM remainder, scaled-circuit semantics, midpoint error theorem and elementary/height-recurrence proofs are retained dependencies, not consequences of the metadata script. Source inputs include the V7000 retune, the original shared EM circuit, scaled precision report, P27 selection, height recurrence and combined-profile receipt. All predecessors remain unchanged.

This result is ready for independent paper/scalar review. It does not generate any seeds, establish a sign, guarantee Turing success, or show that more corrections are universally preferable. It supplies one complete fixed-D tradeoff with fewer head operations, explicitly greater correction work, and a corrected active-set contract.
