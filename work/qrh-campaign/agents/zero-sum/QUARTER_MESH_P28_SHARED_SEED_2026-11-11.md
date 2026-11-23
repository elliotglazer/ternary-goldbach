# P28 on a smaller source grid, retaining the fine P20 grid

2026-11-11. Conditional paper construction and exact metadata. Replace only the V7000 final band's source mesh by D=4096, with P28 at every coarse endpoint. Keep N=2387, 64 Bernoulli corrections, and the existing fine mesh of denominator16384. The delivered P20 coefficients retain normalization8192, radius2^-100 for numerical error, and the isolated character-summed alpha error below2^-82. No analytic values, transforms, zeros, primes or builds were evaluated. This construction requires independent review and implementation; it is not a performance measurement.

This is distinct from simply halving the final evaluation mesh. A P20 target tail on a denominator8192 fine mesh fails the existing sufficient2^-82 bound at V7000, regardless of how accurately its source coefficients are produced. Retaining the old fine mesh avoids that obstruction.

## 1. Two meshes and an exact finite translation

Set D=4096, Q=8192=2D, V=7000 and P=28. The source anchors are a=j/D, 0<=j<=D. At each source anchor produce

    U_k(a)=f^(k)(a)/(D^k k!), 0<=k<P,
    f(alpha)=zeta(1/2+it,1+alpha), |t|<=V.

The required output anchors remain b=l/(4D), 0<=l<=4D. Their coefficients use the old normalization Q:

    V_k(b)=f^(k)(b)/(Q^k k!), 0<=k<20.

For each coarse interval use its left anchor for the quarter and midpoint, and its right anchor for the three-quarter point. In source coordinates tau=D(b-a) is respectively1/4,1/2,-1/4. Coarse output anchors have tau=0. Thus the exact finite approximation to V_k is

    2^-k sum_(j=k)^(P-1) binom(j,k) U_j(a) tau^(j-k).  (1)

Use the previously proved pruned Pascal translation loop, with its increasing inner order, at each of these three signed shifts. It has L=20P-210=350 updates. Negative tau is allowed by the algebraic identity; error estimates use abs(tau). All a-to-b segments remain in[0,1]. The right endpoint a=1 needs all28 source coefficients, since it supplies the last negative-quarter translation. It cannot use the old20-coefficient endpoint shortcut.

For a target alpha choose its nearest fine anchor with the fixed tie rule. Then |Q(alpha-b)|<=1/4, exactly as in the old final Horner interface. In source coordinates |D(alpha-b)|<=1/8. Hence

    |b-a|+|alpha-b| <=5/(8D).

No period wrapping or extrapolation is used, and both signs of t and t=0 are included.

## 2. Analytic errors and the unchanged final interface

The reviewed continued-Hurwitz derivative bound is |f^(P)|<2(V+P)^P on[0,1]. It comes from an absolutely convergent high-derivative series, not the critical-line Dirichlet series. Real-segment Taylor remainder therefore gives

    E_shift <=1266*[5(V+P)/(8D)]^P/P!,
    E_target <=1266*[(V+20)/(4Q)]^20/20!.               (2)

The factor1266 is twice the retained character amplification633, including c^-s. The target and shift errors are distinct and must be added. P28 satisfies the final allocation below; P27 fails this particular shift bound alone at2^-82. This is failure of a sufficient upper bound, not evidence of a large actual error or a proof that all P27 methods fail.

The final P20 records have numerical radius eta=2^-100 relative to (1), with the separate analytic shift bias (2), as in the existing shifted-seed contract. They are not claimed to be eta-balls around the exact derivative without that bias. Converting to raw coefficients would multiply errors by Q^k and is not the selected interface. New numerical centers need not equal or be contained in older saved centers.

## 3. Source EM, rounding and widths

Keep the complete scaled EM formula and exact gamma_r=6^(2r)B_(2r)/(2r)!, r=1,...,64. It contains the head, b^(1-s-k)/(s+k-1), half term and all corrections, with b=N+1+a in[2388,2389]. The pole denominator has norm at least1/2. Define R,E,lambda as in the reviewed scaled circuit, now using D=4096. The identity lambda_k E_k=R_k/b^k is unchanged.

With W=7160 and N=ceil(W/3), the old per-order actual-function EM remainder still gives

    Remainder <=108*2389/127.5*2^-128 <2^-116.

Every required rising factor is bounded by W for P28. The E factors are below1/2, so their error remains2u. Lambda factors are at most6/4096 and retain error2u. The change is the R recurrence. Put A=(V+32)/D<7/4. Its first factor acts on exact R_0=1; all later factors are below7/8. Thus e_next<=(7/8)e+u proves R error<=8u. Also A^k/k!<2 for all k, so true |R_k|<2 and the old loose stored bound |Rhat_k|<=5 remains safe.

Use the same base-power radius delta=2^-118 and complex absolute gate error u=2^-122. The source head error is now

    5N delta+(5NP+8N+1)u,

where8N replaces the old3N R-error contribution. The endpoint error is unchanged:

    (2b+1)delta+(16b+255)u.

After one final addition and the EM remainder, the exact resulting seed error is

    (448264581/2852126720)*eta <eta/4.                (3)

All exact additions require aligned dyadics and adequate integer capacity. These are absolute complex errors, not unconverted coordinate halfwidths.

Each translation update has error u_T=2^-110. To bound the delivered coefficient error, multiply its row by2^-k. For abs(tau)<=1/2,

    sum_(j>=k) 2^-k binom(j,k) abs(tau)^(j-k) <=2.

For a single injected gate error, each entry of the remaining positive suffix is bounded by the complete positive translation matrix. Its scaled entry is at most binom(j,k)/2^j<=1. The usual prefix>=identity argument proves the suffix domination even at an interior injection; for signed tau, take absolute matrices first. Consequently every delivered coefficient has error at most

    2*seed_error+350u_T+u_C <eta,
    u_C=2^-110,                                     (4)

where u_C pays one final rounding after the exact2^-k scale. The exact ratio in (4) is937081221/1426063360. Coarse output anchors satisfy the same bound without translation. No independence of errors is assumed.

The final Horner interface is unchanged. Coefficient radii contribute at most633*(4/3)eta=844eta. Its multiplication/addition rounding with u_H=2^-100 contributes1688u_H. Therefore

    E_alpha <=E_target+E_shift+844eta+1688u_H <2^-82.  (5)

The exact fraction of the budget is stored in the receipt and is less than .16. Shift rounding is already inside (4); it is not charged a second time in (5). All rational target displacements remain exact or need their own argument error.

No larger stored-center cap is needed. The finite EM coefficients have majorant C*A^k/k!, C=3N+5=7166. Translation by abs(tau)<=1/2 gives at most2C*exp(A/2)<6C, since exp(1)<3. Every partial positive loop is bounded by that full translation. The crude perturbation bound2^P*(seed_error+350u_T)<1 proves all work centers are below6C+1<2^16. This cap does not cover multiplication numerators or division denominators. They still need the existing exact-rational and dyadic gate contracts. No relative-precision or limb saving is asserted.

## 4. Shared arguments, heights and elementary setup

Use exactly the comparator's final height counts21901,22068,22221,22541 for main and+167/+320/+640. The last height432705/64<7000 remains covered. The lower four bands are unchanged. Their finest source grid already has D4096 and endpoint1722; hence it is a subset of the new final grid

    x=1+j/4096, 0<=j<=2388*4096.

The union now has9781249 points instead of19562497. This changes source arguments, not the number of final fine-anchor outputs or residue contractions. The reviewed log144, fine-state/step140, initialization120 and state-to-EM122 allocations remain sufficient on the smaller x<=2389 and t<=7000 domain, with fewer than128000 updates. EM copies must still not feed the fine recurrence.

The same direct-anchor log scheme has1002 anchors, one more than the comparator's1001. Its nonanchor degree21 work is205385187 Horner stages rather than410791416. Each point still needs its amplitude witness, initialization, step-cis certificate and step-grid conversion. Those point counts decrease by9781248; no new elementary accuracy theorem is assumed. The anchor lists are not claimed to be prefixes of one another because the mesh changed.

Raw dense state-plus-step storage at72 bytes per point becomes704249928 bytes, excluding proof data, alignment, worker copies and other arrays. This is not total memory. Bernoulli and pi setup are unchanged. The D4096 lambda table can reuse the existing first27 entries and add one entry; it is independent of height and anchor. The shared R recurrence adds one stage per final-band height.

## 5. Work comparison at identical requested outputs

For a final-band height, the new source count is P(D+1), rather than27*(2D)+20. Head reciprocal scales number N(P-1)(D+1), and head additions NP(D+1). E recurrence stages number(P+126)(D+1); Bernoulli terms and their accumulator additions each number64P(D+1). Endpoint assembly retains its old fixed operations per source coefficient and therefore decreases with this count. Its rational denominators and variable-width operations remain charged.

There are3D translations, each350 updates, versus2D translations of330 updates. All20*(4D+1) delivered coefficients receive one separately charged exact power-of-two scale and final round. The final fine P20 values, residue Horner stages, c^-s factors, character transforms, interpolation, signs and completeness work remain unchanged.

For the main schedule, including the unchanged lower bands:

| Category | D8192/P27 comparator | D4096/P28 source |
|---|---:|---:|
| Source coefficient slots |10065825048|7733631360|
| Head reciprocal scales |18746496140777|13393679213473|
| Head additions |19467550607228|13900604273972|
| E stages |57042481404|43407269220|
| Bernoulli terms |644212803072|494952407040|
| Translation updates |123005752320|157991285760|
| Fine-state updates |721276307853|507066976653|
| State-to-EM conversions |721295870350|507076757902|

The new final normalization adds7176957700 scales and7176957700 rounds on the main schedule. At+640, savings are5509239137864 head scales,5729625921096 head additions and220469329920 fine-state updates; costs increase by36007895040 translation updates and7386685700 final scales plus the same number of rounds. The receipt includes all four prefixes and all retained operation categories. Legacy P27 field names in that comparative JSON identify categories, not the new source order.

At fixed per-category prices, the alternative wins precisely when the weighted sum of saved work and setup exceeds the added translations, normalization, R stage and anchor work. A generic head rational scaling is not assigned the same price as a dyadic shift/add. Widths, proof construction, verification, traffic and actual adaptive behavior need their own prices. The arithmetic reductions are concrete; an end-to-end runtime conclusion is not supplied.

## 6. Evidence and limitations

Script `quarter_mesh_p28_seed_20261111.py`, SHA256 `E16148F355192110DE6A339572F1982F40396FEAE250398041B25016B52F262D`; receipt `quarter_mesh_p28_seed_20261111.json`, SHA256 `B78FB6A57D6261EEC59D08D8EA4D0121489644C5D09A52E4BBC51E35DD99A9BE`. The2205 exact checks cover pins, all28 EM/R bounds, coefficient and value budgets, three signed polynomial translation matrices, source-grid nesting, anchor partitions and four cost schedules. No author evaluator was run. An initial check of the unnecessary stronger E_shift<2^-85 failed before any receipt was written; the full required2^-82 budget already passed. The frozen receipt uses the actual sufficient bound only.

Main dependencies are the V7000 retune, SHA `8F08560DDB2BDFEBEABA0D4D5A44FCBCC625BFD43D1027AF05BF62233863FD9B`, the scaled seed proof `251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231`, and the shifted-jet proof `861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895`. Exact paths and additional selected-order/height-recurrence pins are in the receipt. This note adds the new mesh/normalization transport and error proof; it retains their continued-Hurwitz, EM, derivative, elementary and finite-rounding foundations.

Actual seed enclosures, cache/gate certificates and final sign/count evidence have not been produced. Existing fixed boxes are not claimed to contain the new centers. No change to a mathematical finite-RH height is inferred from this evaluator alternative.
