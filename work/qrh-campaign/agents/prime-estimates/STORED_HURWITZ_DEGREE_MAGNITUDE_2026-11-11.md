# Degree-sensitive bounds for stored Hurwitz coefficients

2026-11-11. Source-bound paper analysis and exact rational envelope metadata only. No Hurwitz, coefficient polynomial, elementary, prime, zero or transform value was evaluated. No builds, source declarations or frozen mutations were made. This supplies magnitude bounds for later arithmetic pricing; it changes neither the error allocation nor the selected spectral/height requirements.

**Result.** The exact high-order jet bound survives the actual finite shift and its numerical errors. Every stored degree1..19 coefficient in both selected band classes has norm below8, including subsequent direct conversion to any grid with at least70 fractional bits. Stronger factorial envelopes give much smaller high-degree accumulators: the degree19 Horner input is below2^-48 in the first four bands and2^-57 in the final band. Degree0 remains larger, but it enters only the last exact addition and never a later Horner product.

These are bounds for the STORED finite-polynomial coefficients, not an identification with exact derivatives at the fine anchor. Their numerical error and the separate analytic finite-shift bias are treated differently below. No runtime saving or replacement operation schedule is claimed.

## 1. Actual selected objects and domains

The first four bands are (V,D,N)=(500,512,220),(1000,1024,387),(2000,2048,720),(5000,4096,1720), with P27 coarse source coefficients, output normalization D, fine anchor denominator2D and m64 corrections. The rightmost coarse endpoint needs only P20 because no midpoint beyond1 is requested. The final band is V7000, sourceD4096,N1500,m159,P28 at every coarse endpoint, output normalization8192 and fine anchor denominator16384. These are the selected reconciled source interfaces, not the superseded V10000 final band.

Write s=1/2+it, |t|<=V, coarse alpha a in[0,1] and z=1+a. The exact coarse normalized jets are

    U_j(a)=(-1)^j (s)_j zeta(s+j,1+a)/(D^j j!).          (1)

The selected continued-Hurwitz derivative identity and actual finite EM formula are inherited from the pinned source reports. All heights including negative t and zero, and both real alpha endpoints, remain included. Nothing here supplies a new black-box numerical evaluator for(1).

Let Utilde_k denote the coefficient obtained by translating the FINITE exact coarse Taylor polynomial. In the first four bands,

    Utilde_k=sum_(j=k)^(P-1) binom(j,k) U_j(a) tau^(j-k),
    |tau|<=1/2,                                       (2)

with tau0 or1/2. At the rightmost endpoint tau=0, so the available twenty coefficients suffice. A P27 envelope still bounds this smaller unshifted case without inventing extra inputs.

In the final band,

    Vtilde_k=2^-k sum_(j=k)^27 binom(j,k) U_j(a) tau^(j-k),
    tau in{0,1/4,1/2,-1/4}.                           (3)

The negative quarter uses the right coarse endpoint at the three-quarter fine position. Thus the ACTUAL source contract has |tau|<=1/2, not3/4. The factor2^-k changes the output normalization to8192 and is essential for the bounds. The original stored delivered centers approximate(2) or(3), with the separately recorded numerical errors. They are not automatically exact fine-anchor jets.

## 2. Exact coarse jets of positive degree

For j>=1, Re(s+j)=j+1/2>1. The absolute Hurwitz Dirichlet series at z>=1 has

    |zeta(s+j,z)| <=sum_(n>=0)(n+z)^(-j-1/2)
       <=1+integral_1^infinity x^(-j-1/2) dx
       =1+1/(j-1/2)<=3.                             (4)

The integral comparison follows termwise from decreasing positive powers: for n>=1, (n+1)^(-sigma)<=integral_n^(n+1)x^-sigma dx. Its convergent sum gives the stated explicit bound. This is an analytic inequality proof, not a numerical evaluation. Positive real bases have norm x^-Re(s+j), so the estimate is uniform in the sign of t. Degree0 is deliberately excluded from(4).

Every rising factor required for j<P is at most V+32 in norm. Therefore, with A=(V+32)/D,

    |U_j(a)| <=3 A^j/j!, j>=1.                        (5)

The first-four A are all below5/4. The final source A=7032/4096 is below7/4; after output postscaling, A/2<7/8. This uses the true coarse jets only as intermediate objects in the finite translation, not as the final stored centers.

## 3. Finite translation preserves factorial decay

For x>=0,x<3, define the rational majorant

    H(x)=1+x+x^2/[2(1-x/3)].

For every finite n, sum_(m=0)^n x^m/m!<=H(x): starting at m2, the successive positive term ratio is at most x/3, so the remaining finite sum is bounded by a geometric sum. In particular

    H(5/8)=569/304<2,
    H(7/8)=657/272<5/2.                              (6)

No exponential function evaluation is used. Applying binom(j,k)/j!=1/[k!(j-k)! to(2), for k>=1 the first-four ideal finite coefficients satisfy

    |Utilde_k| <=3 A^k/k! sum_(m=0)^(P-1-k)(A|tau|)^m/m!
                <6(5/4)^k/k! = I_k^first.             (7)

Similarly(3) and the ACTUAL half-step bound give

    |Vtilde_k| <(15/2)(7/8)^k/k! = I_k^final.          (8)

These estimates are for finite shifted polynomials, so no bound for the difference between an exact fine derivative and a truncated shift is needed to prove them. The analytic shift bias remains a separate actual-function error term when the output polynomial is consumed. It has not been set to zero or absorbed into the numerical eta radius.

## 4. Numerical errors of the stored coefficient vectors

Set eta=2^-100 and u_T=2^-110. In the first four bands every coarse source coefficient has error below eta/4. The P27 midpoint loop has330 complete-update gates. The reviewed nonnegative suffix-matrix argument gives the weighted vector bound

    sum_(k<20) 4^-k norm(center_k-Utilde_k)
       <= W=4eta+330u_T.                             (9)

The source part here deliberately retains the older loose4eta allowance. The bound is on the sum of norm errors, not only on a particular evaluation with cancellations; thus each slot has error at most4^k W.

A second bound follows from the SAME matrix proof: every suffix is entrywise dominated by the full positive translation, whose maximum row-sum is at most2^27. Initial maximum error is below eta/4 and each additive injection is at most u_T. Therefore every output slot also has error below

    Eflat=2^27*(eta/4+330u_T)<2^-73.                   (10)

This argument does not claim a blanket midpoint eta radius. Combining two independently valid upper bounds gives

    e_k^first=min(4^k W,Eflat).

No shift is used at coarse anchors, where the same conservative bounds hold. The positive-row argument uses complex norms and nonnegative coefficients, so there is no extra coordinate-to-complex conversion hidden in(9) or(10).

The reviewed joint final construction gives a different and stronger flat numerical guarantee directly:

    norm(center_k-Vtilde_k)<.557eta<eta=e_k^final.     (11)

It includes the output2^-k scaling and its following round. The selected m159 correction refinement explicitly preserves this output guarantee and its normalization; it does not change(3). Its numerical radius is relative to the FINITE translated polynomial, exactly the object bounded in(8).

For k1..19 define the common stored-center envelopes

    Z_k^first=6(5/4)^k/k! +min(4^k W,Eflat),
    Z_k^final=(15/2)(7/8)^k/k! +eta.                  (12)

Every actual stored center in the corresponding band class is strictly below its Z_k. These envelopes include the errors omitted by an exact-jet-only argument. They apply to all admitted center records satisfying the source contracts, not just a hypothetical ideally rounded producer.

## 5. Degree zero stays separate

The source finite-EM magnitude bound for U0 is at most3N+5 in the first four bands. Its actual remainder is below R=2^-116. Translating positive degrees adds less than3(H(5/8)-1)<5. With the numerical slot error at most W, a common first-four degree-zero stored bound is

    Z_0^first=3*1720+10+R+W=5170+R+W.                (13)

Smaller N give a tighter optional band-specific bound; this note uses the common maximum. In the final band the finite-EM constant is3N+7=4507; m159 preserves the old correction-magnitude proof. The added positive-degree translation is below3(H(7/8)-1)<9/2. Thus

    Z_0^final=4507+9/2+R+eta.                        (14)

The R term bounds true coarse U0 by the finite EM expression; the numerical delivered-center error is still added separately. This is harmless conservative accounting, not a false use of absolute convergence at degree0. Negative t and the endpoints retain the original EM denominator/domain conditions.

The only stage adding z'_0 is the last Horner stage. It affects the final exact addition and output width, but no subsequent product exists. Assigning the large Z0 to every high-degree multiplication would erase the useful structure in(12).

## 6. Direct grids and recursive Horner bounds

For any direct coefficient-conversion profile with b_j>=70, let e_j=(3/4)2^-b_j. Converting the ORIGINAL stored center at degree j gives norm below Z_j+e_j. Every converted positive-degree coefficient has norm below8, because the ideal maximum in(12) is7.5 for the first-four class and105/16 for the final class, with an explicit gap much larger than the numerical and conversion errors. This statement includes the actual stored errors; it is not based only on(7)–(8).

For the product-only-rounded Horner circuit define

    H_19=Z_19+e_19,
    T_j=H_(j+1)/4+e_j,
    H_j=Z_j+e_j+T_j, j18,...,0.                      (15)

Then H_j bounds the actual accumulator norm and T_j the rounded product norm. The first coefficient copy has only its conversion error. Later stages have one coefficient conversion and one product round; the addition is exact on the stage grid. This is a MAGNITUDE recurrence. The inherited evaluation-error recurrence, source approximation and final character-sum allowance must still be proved/consumed separately; smaller H_j does not authorize larger errors automatically.

The receipt gives a uniform version of(15) using e_j=(3/4)2^-70, valid simultaneously for all profiles with b_j>=70. It records the following strict powers, H_j<2^q_j:

|j|First-four q_j|Final q_j|
|---:|---:|---:|
|0|13|13|
|1|4|3|
|2|3|2|
|3|2|0|
|4|0|-2|
|5|-2|-4|
|6|-4|-7|
|7|-7|-10|
|8|-10|-13|
|9|-12|-17|
|10|-15|-20|
|11|-19|-24|
|12|-22|-28|
|13|-25|-32|
|14|-29|-36|
|15|-32|-40|
|16|-36|-44|
|17|-40|-48|
|18|-44|-53|
|19|-48|-57|

All positive-degree accumulator inputs are below16 in the first-four class and below8 in the final class, while H0 remains below8192. The exact rational H_j and T_j are retained for sharper profile-specific use. In particular, at a grid b19=71, the highest input needs at most24 signed bits in the first-four class and15 in the final class under these sufficient bounds; the old generic initial-coefficient estimate allowed88 signed bits. This is a width comparison, not a multiplication-cost or runtime ratio.

For actual stage pricing, the r*M input magnitude can use b_(j+1)+q_(j+1) bits, and a nearest witness L can use b_j+ceil_log2(T_j) with a valid strict-power certificate. Then price the actual factor widths and apply any alignment shift afterward. Some high-degree variable operands become shorter than the fixed3-byte factors, so the rectangular orientation must be reconsidered. Signed products, raw residuals, exact additions, comparison witnesses and grid conversions need their own complete capacities. The former generic-width subtotal or optimized-grid ranking cannot be reused unchanged.

## 7. Evidence and next gate

The source/metadata pins read and checked are:

- SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md: `251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231`, especially sections1,3–6 for normalized jets, numerical seed errors, factorial magnitude and both matrix bounds.
- major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md: `AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F`, sections1–3 for actual source/output normalization, shifts and numerical output radius.
- work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md: `E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9`, preserving the joint output/magnitude contracts with the selected correction count.
- major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md: `483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716`, section2 for the selected four P27 bands and final P28 band.

Owned script stored_hurwitz_degree_bounds_20261111.py, SHA256 `1F0D78DF0CF364A68DEE066D10CBA66C7B192A9C231AAB55B5B458A80B0BE6F5`; receipt same stem JSON, SHA `E947C32ED8EA30BA14ED64A7DFF83AA1C8E3F3F222AAD1AD8DAA8484013781BE`. All266 exact checks pass. The JSON retains ideal finite-polynomial bounds, numerical error bounds, stored envelopes, recursive magnitude bounds and strict-power certificates separately for each degree and band class. It contains no function or coefficient values.

Independent source/mathematical review remains required before any joined price comparison consumes these bounds. The new contribution is the proof that degree decay survives the ACTUAL finite coefficient producer and its numerical errors. Concrete ordinary-rule records, source formalization, exact output coverage and matched end-to-end cost comparisons remain outstanding.
