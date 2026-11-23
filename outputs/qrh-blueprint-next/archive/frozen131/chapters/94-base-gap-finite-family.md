# Base-gap pointwise bounds from the original finite family

Research derivation, 2026-11-11, using ternary-goldbach commit23b2d68ca344203d4384e0aff7affa4ec034bef9. No Lean build, canonical edit or zero computation ran. This uses the ORIGINAL shared finite beta<=111/200 certificate through Hp(c), not the weighted alternative and not the proposed reduced heights.

The finite-family implication now covers the entire base gap for every reduced denominator q>=4. The exact largest scalar upper bound in that range is below .044797, at q=5, whereas the unchanged consumer has ghatY(y,150000)>.04712. The remaining reduced denominators1,2,3 pass up to the respective u cutoffs486477,972954,1068377. These overlap the separate high-u branches being certified by the moebius worker. This note alone does not assert that those high-u branches or their upstream TypeI/II replacements are proved.

A more conservative version using the previously available transform bound4 is retained in the script. It already covers149980 of150000 reduced denominators and all q>=32. The stronger result comes from the actual etaU Mellin moments and the finite reflected strip, which improve that constant to13/8=1.625.

## Exact normalization and the required source adapter

Set y=x/49>=10^25. In the source gap, write

    alpha=a/m+delta/y modulo integers,
    q=m/gcd(m,2), Delta=2delta, u=q*|Delta|=2q*|delta|.

The original rational denominator is m, not q. If m is odd then q=m<=150000; if m is even then m=2q<=300000. Thus odd q can arise from m=q or2q, while even q arises from m=2q. The actual sum is

    S_etaStar(alpha,49y)=sum_n Lambda(n) etaU(n/y) e(n alpha).

Its Mellin twist is delta=u/(2q) in absolute value. There is no further division by49.

One needs a parity-preserving version of the source gap extraction. `BaseGap2.gap_point` exposes a deliberately weaker conclusion, so it cannot itself supply the following sharp interval. The proof of that lemma and the definition of majorArcs give:

* For odd m, 600000/(49m)<=|delta|<600000/m.
* For even m, 1200000/(49m)<=|delta|<1200000/m.

Both become

    1200000/49<=u<1200000,
    dmin(q)=600000/(49q)<=|delta|<600000/q=dmax(q).

The stronger extraction is an explicit adapter still to formalize. The rational a/m remains reduced and the source unit-character expansion applies at modulus m. No rational with denominator q is substituted into that expansion.

## Shared-height containment, including both signs

For a u-prefix U<=1200000 use the etaU cutoff

    H(q,U)=ceil(max(250,(484/7)*U/(2q)))
          =max(250,ceil(242U/(7q))).

This guarantees H>=22pi*|delta| throughout that prefix and H>=250. At full gap U=1200000, H=ceil(290400000/(7q)); the250 floor is inactive for q<=150000.

For every primitive conductor c on the actual nonzero Gauss support, c divides m and

    qt(c)<=qt(m)=2q,
    Dc=1200000/qt(c)>=600000/q.

The original shared finite cutoff is

    Hp(c)=ceil(200+max(1000,(704/7)Dc)).

It dominates H(q,U). In fact its nonconstant term has coefficient422400000/(7q), larger than290400000/(7q), and its floor is1200 rather than250. This proof covers both possible original moduli for odd q and all eligible conductors. The script also checks containment on all1,094,045 supported conductor/modulus pairs.

Consequently every zero used below satisfies beta<=.555. The functional equation, with the conjugate-character correspondence where required, gives beta>=.445 as well: the reflected nontrivial zero has the same conductor and absolute height, and is covered by the same shared certificate. All primitive characters of that conductor are in the finite premise. This argument does not assert a real-character quartet for an individual complex character.

For the low sum use the source off-line Jensen argument, not a critical-line count lemma. A3.48 height window and the full0<beta<1 strip fit inside radius3 about2+iT. The existing polynomial data bound the multiplicity by400 in each required window. The cutoff heights are below4.2e7, within the range of the reviewed elementary BP/BPz2 estimates. Thus, for every primitive character,

    N(H)=ceil(400*(2H/3.48+2))

bounds the multiplicity in |gamma|<=H. This counts both signs and repetitions. It assumes neither simplicity nor spacing.

## The actual etaU transform is below1.625 on the finite strip

Let F_U(s,delta)=Mellin(etaU(t)e(delta*t))(s). Positivity gives |F_U(s,delta)|<=M_U(beta), where M_U is the untwisted real Mellin transform. The actual eta2-Gaussian convolution gives

    M_U(0)=4log(2)^2,
    M_U(1)=sqrt(pi/2).

Indeed M_eta2(s)=4((1-2^(-s))/s)^2, interpreted continuously at0, and M_phi(s)=2^(s/2)Gamma(1+s/2). At1 the eta2 factor equals1; at0 the Gaussian factor equals1. These are the actual smoothing normalizations.

For0<=beta<=1, weighted AM-GM gives t^beta<=(1-beta)+beta*t. Integrating against the positive measure etaU(t)dt/t yields

    M_U(beta)<=(1-beta)M_U(0)+beta*M_U(1).

The endpoint integrals exist by the Gaussian-mixture representation. Since log2<.69315, the exact scalar calculation gives M_U(0)<1.922. The existing Gaussian constant gives M_U(1)<1.2534. The affine upper bound decreases with beta. On the finite reflected strip beta>=.445,

    |F_U(s,delta)|<.555*1.922+.445*1.2534
                  =1.624473<13/8.

This is uniform in height and real twist. Mellin independently checked the interpolation and normalization on paper. The actual convolution, integrability and AM-GM wrapper still need Lean proofs. The script certifies log2<.69315 by a positive Taylor lower sum for exp(.69315)>2, rather than floating logarithms.

With y>=10^25 and beta<=.555, each normalized zero factor has magnitude y^(beta-1)<=y^(-.445). Hence the primitive low residual is at most

    (13/8)N(H)y^(-.445).

The conservative branch replaces13/8 by4. At y0, the rational bound y0^(-.445)<7.5e-12 is verified by integer powers; this decreases at larger y. All oscillatory phases are bounded before summation.

## High-zero, contour and removal terms

The high-zero estimate must be recomputed at the base-gap twist, which can be600000. It is not the old mixed-moment etaU interval of size600000/49.

The actual eta2 convolution transfers the source Gaussian tail with prefactor2 and no plus-smoothing shift200. The source tail window bound, valid for both signs and multiplicities, gives Z3<400 and c3<53/H. Write G(d)=3+d/2.7. The two geometric denominators are at mostG, and H>=250, H>=69d imply G/H<1/39. Thus their window sum is bounded by

    800G+(106/H)G^2<803G.

For d<=600000 this is<180000000. The genuine source EA at H/(pi*d)>=22 is bounded by

    .588*22^2*exp(-.1065*22^2)<2e-20.

At d=0 use its zero value. For EB retain its correlation with H: since d<=H/(22pi), 803G<5H+2500. Therefore its contribution is at most

    2*.892*H*(5H+2500)*exp(-.1598H)<1e-11.

The function decreases for H>=250, so the comparison uses the floor250. Since y0^(1/8)>1333, global QRH on the high zeros gives the normalized primitive tail

    tail <=[2*180000000*2e-20+1e-11]/1333<2e-14.

Every displayed exponential comparison is certified by exact positive Taylor sums in the script. This is a paper application of the reviewed source tail machinery; its etaU convolution and good-height-limit bridges remain to formalize. Finite .555 is not used above H.

The larger twist also changes the safe vertical decay rate. On Re(s)=-1/2 the actual convolution and `GrExtend.norm_G_uniform_ext` give Kv<=900 and theta>=.28/(600001)>4e-7. The eta2 moment at-1/2 is<3. With DN(c)<150 and2/log2+4.8<8, source `ExplicitBoundGen.VgL` is bounded by

    V=900*8*[187*2/theta+2.6*2/theta^2], theta=4e-7.

After normalizing by y the contour contribution is at mostV*y^(-3/2). The possible zero-at-zero multiplicity is bounded by400, and its Mellin value by600, so its normalized residue is at most400*600/y. The exact rational check using sqrt(y0)>3e12 gives

    V/(3e37)+400*600/1e25<1e-18.

The principal pole is handled in the Fourier main term below, not in this remainder. We can therefore allocate3e-14 per primitive character for high zeros, contour and possible zero0 together.

For noncoprime removal retain the source `BaseGap2.sum_noncoprime_le` argument. It proves a normalized bound d0<=2e-9 for m<=300000 and all y>=1e25, including the ceiling/log terms. The weighted reconstruction spends (1+W_m)d0: once for removing prime powers from the additive sum and once inside the primitive-character sums. These are not silently absorbed into the3e-14 analytic remainder.

## Exact Gauss weights and the scalar envelope

Define

    W_m=[sum_(c|m, m/c squarefree, gcd(c,m/c)=1) n(c)*sqrt(c)]/phi(m).

These are the exact absolute Gauss weights. Each primitive character induces once; unsupported conductors have zero Gauss sum. The principal Gauss norm is |mu(m)|. The source character expansion with its pole isolated gives

    |S_etaStar|/y
      <= |mu(m)|/phi(m)*min(1.2534,1.016/dmin(q)^2)
         +(13/8)*N(H)*y^(-.445)*W_m
         +(1+W_m)*2e-9+W_m*3e-14.                 (B)

The two unconditional Fourier estimates are the source uniform norm bound1.2534 and delta^2 times the norm<=1.016. The formula keeps the actual principal Mobius factor. There is no assumed equidistribution or cancellation among characters.

For odd q, m=q and m=2q give the same phi, absolute Mobius value and W_m. The nonzero supported conductors are odd, because no primitive character has conductor congruent2 modulo4. The extra factor2 in m/c preserves squarefreeness and coprimality. For even q use only m=2q. The script checks this identity as well as

    sum_supported c*n(c)=phi(m)^2

at every active modulus. Cauchy-Schwarz over the phi(m) characters then gives W_m<=sqrt(phi(m))<=sqrt(q). For even q, phi(2q)=2phi(q)<=q; for odd q, phi(m)=phi(q)<=q.

The main term has the previously reviewed uniform bound .000481, obtained from |delta F_U(1,delta)|<1.129 and the unconditional finite totient bound m/phi(m)<=30030/5760. The enumeration instead uses the sharper exact main term in(B).

The complete original shared-height hypothesis suffices here. The weighted alternative from the preceding note controls integrated moments and does not by itself establish this pointwise bound.

## Exact enumeration and residual intervals

The script enumerates all150000 reduced q using m=2q and verifies the odd-modulus equivalence. It rounds sqrt(c) upward to multiples of10^-12 by integer square roots. Every resulting bound and acceptance test is rational; printed decimals are diagnostic only. Multiplicities use the exact ceiling N(H).

With transform cap13/8, (B) is below .04712 for every q>=4. Its largest passing value is approximately .04479688349038 at q=5. The only full-gap failures and their certified integer prefixes are:

| Reduced q | Original m | Full-gap upper diagnostic | Proven prefix u<= |
| ---: | --- | ---: | ---: |
|1|1 or2|.1162315497|486477|
|2|4|.0581157798|972954|
|3|3 or6|.0529251237|1068377|

The original gap lower endpoint1200000/49 is included. These upper prefixes are closed, while the overall gap upper endpoint1200000 is open. The script uses the ceiling H(q,U), so no fractional-height endpoint is lost.

The moebius worker's separately certified q1 high branch starts at190000. Their proposed high branch for q/phi(q)<=2 starts at300000 and includes q2 andq3. If that high branch and its upstream pointwise prerequisites are established, the overlaps above cover all u and all reduced denominators. This note does not replace its proof.

For comparison the conservative transform4 enumeration passes149980 denominators. Its20 failures are1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,19,23,29,31. The largest passing bound is .0460599655 at q12. All q>=40 also have a short independent check: from H<=290400000/(7q)+1 and N<=20000H/87+801, the low bound is at mosta/sqrt(q)+b*sqrt(q), where

    a=4*(7.5e-12)*(20000/87)*(290400000/7),
    b=4*(7.5e-12)*(20000/87+801).

Since b*150000<a, this decreases over[40,150000]. Using6.32<sqrt40<6.325 and sqrt150000<388, then reserving .000481+389*2e-9+388*3e-14, gives .045752287 as a strict upper bound. This supplies a simple analytic proof for the large-denominator part independent of the larger finite enumeration.

All bounds are uniform in y: the main and removal envelopes are fixed, y^(-.445), y^(-1/8), y^(-3/2) and1/y decrease, and the actual phases never enter an acceptance test. The comparison uses the reviewed lower bound ghatY(y,150000)>.04712, not the endpoint upper bound .060272 and not the weaker old surrogate .01398. The existing minor-arc envelope and numerical cells are unchanged.

## Remaining obligations and validation

The exact script `resume_base_gap_finite_family_20261111.py` exits0; its JSON records all tested constants, both transform variants, the residual moduli and prefix bounds. This is a sufficient-condition arithmetic certificate, not a Lean proof.

The finite .555 rectangles are still unproved. Other remaining proof tasks are the parity-preserving gap adapter, finite reflection adapter, actual etaU convolution/interpolation and explicit-formula bridges, off-line Jensen specialization, exact Gauss-support wrapper and finite arithmetic replay. The reviewed ghat lower envelope and the separately supplied high-u branch must also be formalized with their original prerequisites. No hidden Platt hypothesis is supplied in place of any of these tasks.
