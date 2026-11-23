# Raw Type II comparison for the base-gap envelope

Research only, 2026-11-10. Pinned project commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. This note refines `BASE_GAP_TYPEII.md` and the broad central envelope in `agents/mellin/BASE_GAP_HYBRID.md`. It does not implement or compile Lean.

The concrete result is an integrated, uniform-in-scale paper bound using the original raw Type II square-root product. At the two requested reduced denominators, exact rational arithmetic certifies

| reduced Q | Q/phi(Q) | new raw upper bound | old broad U lower bound | certified relative gain |
|---:|---:|---:|---:|---:|
|90090|1001/192|<.067108|>.07637455|>12.13%|
|120120|1001/192|<.058903|>.06681927|>11.84%|

The exact comparison checked by the script is `U_raw_upper < (9/10)*U_broad_lower` for each Q. The new bound is valid for every y≥1e25 and every base-gap twist, **conditional on the original Type I/II input inequalities**. Those input inequalities still have `Fact PlattGRH` in the source; their separate replacement remains necessary. This is a paper proof plus an exact external arithmetic audit, not a Lean certificate or a completed Platt-free theorem.

At Q=120120 the new upper bound is below the starting-scale ghat allowance (approximately .06027). It is not automatically below ghat for every y: the latter decreases, while this particular uniform bound is fixed at the worst scale. The major-constants worker owns the y-dependent comparison and a finer binned classifier.

## 1. Normalization and exact hypotheses

Use the reduced denominator Q of 2alpha, not the denominator of alpha. Write

2alpha=A/Q+Delta/y modulo an integer,
u=|Delta|Q, and 1200000/49≤u≤1200000.

Equivalently, in the notation used by the Mellin and major-constants workers, D=Q|delta|=u/2 lies in [600000/49,600000]. At the scale z=wy,

t=max(2Q,wu/4)=max(2Q,wD/2), d=t/Q.

The parity-aware conversion and source arc endpoints are proved at paper level in `BASE_GAP_TYPEII.md`, section1. In the interval 1/20≤w≤8, for all y≥1e25 and Q≤150000, one has

z≥5e23,
Q≤z^(1/3)/6,
|w Delta|Q≤(4/3)z^(1/3).

These are the exact size and approximation hypotheses of the first branch of `PointwiseBound.theorem_3_1_1`; no minor-arc membership hypothesis is needed. `EtaStarBound.Approx2.rescale` supplies the correct wDelta scaling. In particular t≤2400000, and the underlying first-choice bounds also imply t≤z^(1/3)/3.

For the two denominators in this note, Q/phi(Q)=1001/192 exactly: phi(90090)=17280, phi(120120)=23040. These are integer factorizations, not prime-distribution estimates. Both numbers have the same six distinct prime divisors2,3,5,7,11,13.

## 2. The algebraic raw envelope

Set

C(z,t)=log(1+log(4t)/(2log(9z^(1/3)/(2.004t)))).

For v=Q/phi(Q), define

A_c(l)=(c+1/2)l+.002c+log2,
B(l)=.30214l+.7468.

Summing `FirstChoiceTypeI1.typeI1_first`, `FirstChoiceTypeI2c.typeI2_first`, and `FirstChoiceTypeII.typeII_first`, then applying the unconditional `Assembly.norm_S_le_parts`, gives

|S_eta2(alpha,z)|/z ≤ sqrt(v/t)*sqrt(A_C(log t)*B(log t))
                    +2.5257/sqrt t
                    +[13.2v+2(16.267log t+24.42)]/t
                    +3.77z^(-1/6)+3log z/z.             (R)

This is an exact algebraic sum of the existing bounds. There is no new analytic assumption in preserving the product, and the remaining term3log z/z is kept explicitly. The published simplified theorem instead applies `main_amgm`, replaces the leading coefficient by `(.27125C+.41415)log t+.8764`, and rounds the lower-order coefficient to3.8. That step can be bypassed because `typeII_first` is available before it.

For comparison, freezing C≤c and taking the published bound gives

F_c(t,v)=[((.27125c+.41415)log t+.8764)sqrt v+2.526]/sqrt t
         +2[v(3.25log t+7.82)+13.66log t+37.55]/t.

## 3. Monotonicity with a fixed C bound

The raw product permits the same cell method as the published bound; no uncontrolled differentiation of C(z,t) is necessary.

For fixed c≥0, both A_c(l) and B(l) are positive for l≥2. Their intercepts are nonnegative, so

A_c'(l)≤A_c(l)/l, and B'(l)≤B(l)/l.

Therefore

d/dl [A_c(l)B(l)exp(-l)]
=exp(-l)[A_c'B+A_cB'-A_cB]
≤exp(-l)A_cB(2/l-1)≤0 for l≥2.

Taking the nonnegative square root shows that `sqrt(A_c(log t)B(log t)/t)` decreases on t≥exp2. Every other t-dependent term in (R) decreases there: t^(-1/2) does, and `(a log t+b)/t` has derivative `(a-a log t-b)/t²≤0` for positive a,b and log t≥2. Hence a lower bound on t and an upper bound on C give a valid uniform upper envelope.

For a general cell

Q∈[Q0,Q1], D∈[D0,D1], w∈[a,b], log y∈[L0,L1], v≤vmax,

put

zmin=a exp(L0),
tmin=max(2Q0,aD0/2),
tmax=max(2Q1,bD1/2).

Assume tmin≥exp2 and the denominator logarithm below is positive. Since the numerator log(4t) increases with t and the denominator log(9z^(1/3)/(2.004t)) increases with z and decreases with t,

C(z,t)≤c_cell:=log(1+log(4tmax)/(2log(9zmin^(1/3)/(2.004tmax)))).

Thus the exact raw analogue of the major-constants worker's cell envelope is

Ucell_raw=sqrt(vmax/tmin)*sqrt(A_c_cell(log tmin)*B(log tmin))
          +2.5257/sqrt tmin
          +[13.2vmax+2(16.267log tmin+24.42)]/tmin
          +3.77zmin^(-1/6)+3log zmin/zmin.              (C)

The last logarithmic term is decreasing for zmin≥exp1, satisfied here. Formula(C), integrated against a certified upper Gaussian bin mass, is ready for a y/D/Q cell checker. It preserves the real correlation as far as the cell endpoints permit. This general formula was sent to the major-constants worker; this note does not duplicate that worker's full classifier construction.

## 4. An eight-bin uniform envelope U_raw(Q,v)

For a small concrete comparison take y≥Y=1e25 and Q≤150000. Use the following bins and C bounds:

| a | b | c_i with C(wy,t)≤c_i |
|---:|---:|---:|
|.05|.25|.69|
|.25|.5|.66|
|.5|1|.64|
|1|2|.70|
|2|3|.72|
|3|4|.74|
|4|6|.78|
|6|8|.80|

For each row, zmin=aY and tmax=max(300000,300000b). In particular these C bounds hold for all allowed Q and all allowed D, not just for the minimum gap twist. They are stronger than the single broad C≤.98 bound because most Gaussian mass lies far from the extreme pair w=.05,t=2400000 used in the broad rectangle.

Let m_i=integral_a^b w²exp(-w²/2)dw, let l=log(2Q), and define

H_i(Q,v)=sqrt(v/(2Q))*sqrt(A_c_i(l)B(l))
         +2.5257/sqrt(2Q)
         +[13.2v+2(16.267l+24.42)]/(2Q)
         +3.77(aY)^(-1/6)+1e-20.

The1e-20 safely bounds3log z/z for every z≥Y/20: monotonicity reduces to z=Y/20; log(Y/20)<60; and3*60/(Y/20)<1e-20. All t-dependent terms were bounded at t=2Q using section3, so this bound is uniform over the full D interval.

The raw integrated envelope is

U_raw(Q,v)=.000709002 + sum_i m_i H_i(Q,v).             (Uraw)

This expression is valid for Q≥exp2/2; in particular it covers both requested Q. The original broad expression was first stated for Q≥100000, but its same elementary monotonicity proof applies at90090 as well because log(180180)>2.

The source's unconditional smoothing transport uses phi(w)=w²exp(-w²/2). Applying it to the piecewise bound on [.05,8], and to the trivial eta2 bound17 on both tails, yields

|S_etaStar(alpha,49y)|/y ≤ U_raw(Q,Q/phi(Q)).

This conclusion inherits the separate Type I/II hypotheses of(R). Piecewise constant bounds are measurable; the finite central interval is integrable, and the tails are integrable against phi. No infinite interchange beyond the already proved smoothing transport is introduced.

The tail constant is the same conservative value used by the broad envelope. Indeed

17 integral_0^.05 phi≤17*.05³/3,
17 integral_8^infinity phi≤17*(8+1/8)exp(-32),

and exp32>1e13 gives a sum less than.000709002. This avoids gaining apparent improvement by silently changing the tails.

## 5. Exact external certificate method and results

`base_gap_raw_comparison.py` uses `Fraction` for every asserted comparison. A floating logarithm is used only to choose candidate rational brackets at spacing1e-6; those brackets are subsequently checked by rational exponential bounds, so the assertions do not trust that floating result.

For positive rational x, exponential bounds use a Taylor polynomial of degree256 and the geometric tail

S_256(x)≤exp x≤S_256(x)+[x^257/257!]/[1-x/258].

All arguments satisfy x<258. Rational square-root brackets are obtained from integer square roots at denominator10^18. Integer cube/sixth-root lower bounds are obtained by exact power comparison and binary search.

For the C bound in each bin, take an integer lower bound on(aY)^(1/3), a checked upper bound Ln onlog(4tmax), and checked positive lower bound Ld onlog(9root_lower/(2.004tmax)). Then verify

exp(c_i)>1+Ln/(2Ld).

Every such inequality passed.

Gaussian masses use the Taylor polynomial for exp(-s): even truncations are upper bounds and odd truncations lower bounds for every s≥0, by the sign of the integral Taylor remainder. Integrating w² times the polynomial gives the exact rational expression

M_N(a,b)=sum_(k=0)^N (-1)^k [b^(2k+3)-a^(2k+3)]/[2^k k! (2k+3)].

Thus M_257≤m_i≤M_256. Every upper-lower gap is less than1e-100; no quadrature-error assumption occurs. The m_i upper bounds are positive. Rounded informational values are .0050701227921,.0335650094449,.2104169645119,.6765237146699,.2909860082774,.0352894436468,.0014211446890,.0000000938528.

Using upper log/sqrt/root brackets in H_i and M_256 for m_i gives:

| Q | exact-audited U_raw upper, shown in decimal | same-bin published bound upper | broad envelope lower, shown in decimal |
|---:|---:|---:|---:|
|90090|.06710723589574415|.06980251565155819|.07637455824266524|
|120120|.05890221913998414|.06096894876226506|.06681927261464421|

The 'broad envelope' here is exactly

1.254*[((.68log(2Q)+.8764)sqrt v+2.526)/sqrt(2Q)
       +(v(3.25log(2Q)+7.82)+13.66log(2Q)+37.55)/Q+.000428]
+.000709002.

Its **lower** bracket is used solely to certify the percentage improvement in upper-bound formulas; it is not a lower bound on the actual exponential sum. The script asserts the exact inequality U_raw_upper<.9*U_broad_lower, and also the convenient rational roundings U_raw<.067108 and U_raw<.058903.

The improvement does not come entirely from avoiding AM–GM. Using the same bins, the raw product reduces the published bound by about3.86% at90090 and3.39% at120120. Binning C accounts for the rest of the gain relative to the broad single-rectangle envelope. Therefore it would be inaccurate to claim a10% improvement from the raw product alone.

## 6. What this establishes and what still needs proof

The gain is permitted by actual source hypotheses, not by changing any prime/Möbius constant:

- first-choice `typeII_first` exposes the raw product before `main_amgm`;
- the source decomposition exposes separate .014,.556,3.2 remainder coefficients and3log z;
- the actual base-gap approximation, correctly rescaled, is valid throughout [.05,8];
- the gap's upper twist and finite Q range bound t separately in each w bin;
- source smoothing transport allows the piecewise positive pointwise envelope to be integrated.

For Q=120120, the certified uniform value.058903 is below the starting-scale allowance near.06027, whereas this note's same-bin simplified bound.060969 is not. This makes the raw product materially useful for that crossing. For Q=90090, the certified.067108 still exceeds the starting allowance; this eight-bin envelope does not cover it. Finer correlated D/w/y cells may improve either result and are owned by major-constants.

A fixed upper bound valid for every y does not prove comparison with a decreasing ghat allowance for every y. Completing the direct branch needs either y bins using(C), plus an asymptotic bin, or another uniform comparison retaining the common y dependence. The exact arithmetic script is external evidence, not a Lean kernel check. The actual Type I/II producer estimates still need their no-Platt proofs; `BASE_GAP_TYPEII.md`, section6, and integration's producer audit track them. No new assumption may be carried into the final Goldbach statement.

## Coordination update: finer classifier and affine use of the raw bound

After this comparison was completed, the major-constants worker reported that its finer161-bin/16-twist-cell calculation already proves the published-bound classifier for120000≤Q≤150000 and v≤1001/192 against the actual allowance for all y, with positive margin. That result has its own artifact and verification boundary. Accordingly the eight-bin raw improvement here is a useful benchmark and a possible way to lower the classifier boundary; it is not necessary to cover120120 once that stronger classifier is accepted. Statements above about the published bound failing at120120 refer only to this note's eight-bin bound.

For the major worker's affine comparison, put c_ref=C(y,300000). If its analytic estimate gives C_i≤k_i*c_ref in a cell, the raw square-root term is

sqrt(P_i*(a_i*c_ref+b_i)),
P_i=(v/tmin)*(.30214log tmin+.7468),
a_i=k_i*(log tmin+.002),
b_i=.5log tmin+log2.

This is an increasing concave function of c_ref≥0. Its tangent at any fixed c_star≥0 is an explicit affine upper bound, since a positive concave square-root function lies below its tangent. Thus the raw bound can be inserted into the same affine all-y comparison architecture without a separate y grid. The tangent coefficients are sqrt(P_i*(a_i*c_star+b_i)) and P_i*a_i/[2sqrt(P_i*(a_i*c_star+b_i))]. Their positive denominators follow from tmin>1. Taking a weighted sum of these tangent bounds and adding the lower-order terms gives the integrated affine raw envelope.

A separate floating Simpson diagnostic with20000 panels on[.001,8], at y=1e25 and the minimum allowed gap twist, gives about.0636526940 forQ90090 and.0562544937 forQ120120. The omitted-tail bounds are added, but the Simpson error and floating roundoff are not certified in that diagnostic. It suggests the raw product alone will still not cover90090 at the smallest twist against a.06027 allowance. A correlated-twist classifier can nevertheless cover larger twists. No impossibility claim about the true exponential sum follows from this upper-envelope diagnostic.
