# Fixed Horner profiles with stored degree envelopes

2026-11-11. This is a conditional arithmetic-cost refinement using reviewed stored-coefficient bounds. It contains exact rational metadata only. No coefficient, function, prime, zero or transform values were evaluated. No Lean/MM0 build, new declaration, profile search or frozen-artifact edit was made.

The three existing grid profiles have the following product-proof subtotals under the SAME declared byte-schoolbook template. Each row is one complete degree19 complex polynomial evaluation at one unit residue and height.

|Fixed profile|Previous common coarse widths|New first-four-band widths|New final-band widths|
|---|---:|---:|---:|
|Uniform100|17632|12562|11872|
|Root linear|16252|11272|10552|
|Previously optimized15442|15442|10702|9970|

These are proposed ordinary-PA template events, not elapsed time, executed MM0 opcodes or Lean reductions. The difference from the old column is respectively5070/4980/4740 in the first four bands and5760/5700/5472 in the final band. Conversion, addition, shift, comparison, numeral, binding and storage costs remain separate. The previously optimized profile is the cheapest of these THREE fixed choices under this subtotal; no optimality under the new magnitude-dependent objective is claimed.

## 1. Objects and reviewed source boundaries

The source is prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md, SHA256 `9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2`, independently accepted by major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md, SHA `1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6`.

Its first four bands have source parameters V,D,N equal to500/512/220,1000/1024/387,2000/2048/720 and5000/4096/1720, with P27 and m64. The final band has V7000, sourceD4096,N1500,P28,m159 and output normalization8192. The original fine-anchor, height, output and source-error contracts are retained. The first-four bound includes the rightmost unshifted P20 endpoint without requesting absent higher coefficients.

Let z_j be the ACTUAL stored center of the finite translated coarse polynomial. It is not identified with an exact fine-anchor derivative. The final source translation has actual displacement0,1/4,1/2 or−1/4 and postfactor2^-j. The source proof bounds those finite polynomials first, then adds their numerical coefficient errors. Its separate analytic finite-shift bias remains in the downstream function enclosure and is not erased by this pricing calculation.

For u=2^-100, u_T=2^-110, R=2^-116 define

    W=4u+330u_T,
    Eflat=2^27*(u/4+330u_T).

The consumed strict stored-center bounds are

    Z0(first)=5170+R+W,
    Zj(first)=6*(5/4)^j/j!+min(4^j*W,Eflat), 1<=j<=19;
    Z0(final)=4507+9/2+R+u,
    Zj(final)=(15/2)*(7/8)^j/j!+u, 1<=j<=19.

Thus numerical source uncertainty is included in every Z_j. The first-four minimum combines the separately proved weighted and flat numerical bounds; it is not an observed cancellation. The final eta allowance already includes the postscale and output rounding. No new error allowance is inferred from the smaller magnitudes.

## 2. The three unchanged circuits and their errors

The grid vectors, listed in increasing degree0..19, are

    uniform100 = [100]*20;
    root_linear = [100,100,98,97,96,95,94,93,92,91,
                   90,89,88,87,86,85,84,83,82,81];
    fixed_15442 = [100,100,100,100,97,95,95,95,89,87,
                   87,87,81,79,79,79,71,71,71,71].

Every ORIGINAL stored z_j is rounded directly to its selected grid2^-b_j, with nearest ties toward positive infinity in each coordinate. A variable-grid profile must not obtain its coefficients by an uncharged intermediate b100 conversion. Write e_j=(3/4)2^-b_j, a strict Euclidean bound for coordinate nearest rounding. Initialize the highest converted coefficient without an additional round. For j18 down to0, round the product by the real displacement h=r/v to grid b_j, then add the converted coefficient exactly on that grid. There is no extra final output round.

The inherited displacement domain is v=2c>0, |r/v|<=1/4, c<=265800. Hence |r|<=132900<2^18 and v<=531600<2^20. For every fixed profile, the evaluation error relative to the ORIGINAL stored polynomial is strictly below

    sum_(j=0)^19 (2 if j<19 else1)*e_j*4^-j.

Dividing by u gives the exact sufficient envelopes

|Profile|Error envelope in units u|Retained cap|
|---|---:|---:|
|Uniform100|2199023255547/1099511627776|8/3|
|Root linear|5505015/2097152|8/3|
|Fixed15442|5253/2048|8/3|

All inequalities against8/3 are strict. The same source/EM, numerical coefficient, analytic shift, character aggregation and target remainder charges therefore remain. This is not a fresh8/3 allowance to add to a previous coefficient conversion; conversion and all nineteen product rounds are already in the displayed sum.

## 3. Profile-specific accumulators and nearest-round witnesses

For each of the six band/profile cases compute rational bounds

    C_j=Z_j+e_j,
    A_19=C_19,
    T_j=A_(j+1)/4+e_j,
    A_j=C_j+T_j,  j18,...,0.

C_j bounds the converted coefficient, T_j bounds the rounded product and A_j bounds the resulting accumulator. These bounds use the actual profile's e_j rather than the source note's common b70 majorant. Each coordinate magnitude is bounded by the Euclidean norm, so no missing square-root-of-two factor enters the integer capacities.

At stage j an input coordinate is M/2^b_(j+1). Set delta=b_j−b_(j+1)>=0. The exact rounding numerator and nearest witness satisfy

    X=r*M*2^delta,
    -v <= 2*(X-L*v) < v.

The closed lower and open upper endpoints implement nearest ties toward positive infinity for both signs. The two numerical product proofs are r*M BEFORE the exact alignment shift and L*v. The product-input magnitude caps are

    |M| < 2^b_(j+1)*A_(j+1),
    |L| < 2^b_j*T_j.

The receipt records for every cap a certified integer w with cap<2^w and cap>=2^(w−1). This supplies magnitude width w; signed wrappers need their additional sign representation. Neither the shift nor the signed witness comparison is included in the multiplication subtotal.

There is also a universally available cancellation when delta>0, since v is even. Put t=min(delta,1), v'=v/2^t and X'=r*M*2^(delta−t). The original inequality is equivalent to

    -v' <= 2*(X'-L*v') < v'.

The same L is checked. The actual v' factor still occupies3 bytes under the global cap, so this cancellation changes no product subtotal in the table. It reduces alignment and witness sizes where applicable. More cancellation t=min(delta,v2(v)), or additional cancellation involving r, needs its own divisibility witnesses and conductor-specific accounting. None is credited here.

All raw widths are bounded BEFORE residual cancellation. For the recorded choice t the receipt separately bounds

    |r*M| <=132900*capM,
    |X'| <=132900*capM*2^(delta−t),
    |L*v'| <=capL*531600/2^t,
    |X'-L*v'| <=capX+capLv,
    |2*(X'-L*v')| <=2*(capX+capLv).

The last two comparisons cannot borrow the much narrower accepted residual until that residual has actually been proved. Exact coefficient additions use C_j+T_j=A_j. The large degree-zero coefficient appears ONLY at the final addition. There is no following product to which Z0 should be applied.

## 4. Matched product template and exact widths

Section3 of integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md specifies the proposed ordinary-PA rectangular byte-schoolbook template

    M(m,n)=5*m*n+2*n+1,

where n is the row count. Let bytes(w)=ceil(w/8), with at least one byte. Choose the smaller operand as the row count. At each complex stage the charged subtotal is

    2*[M(max(bytes(18),bytes(wM)),min(bytes(18),bytes(wM)))
       +M(max(bytes(20-t),bytes(wL)),min(bytes(20-t),bytes(wL)))].

There are nineteen stages and76 real product proofs in every case. Magnitude bytes are distinct from signed wrappers. Both r and v are bounded globally; any finer conductor stratification remains unpriced.

The previous coarse totals are independently reconstructed under the SAME template: input width b_(j+1)+17 except the first input b19+16, and rounded-product witness width b_j+15. This gives17632,16252,15442 respectively. The new totals therefore reflect only changed sufficient operand capacities, with the actual product orientation reconsidered where needed.

|Band/profile|M magnitude-bit range|L magnitude-bit range|Maximum signed exact-add/output capacity|Maximum signed doubled raw residual, uncancelled|
|---|---:|---:|---:|---:|
|First four, uniform|52..104|50..102|114|124|
|First four, linear|33..104|32..102|114|124|
|First four, fixed15442|23..104|21..102|114|124|
|Final, uniform|43..103|41..101|114|123|
|Final, linear|24..103|23..101|114|123|
|Final, fixed15442|14..103|12..101|114|123|

All stagewise exact fractions, signed capacities and the cancelled variant are saved. In the final fixed15442 case, stage18 has two-byte M and L, and stage17 has two-byte L. With the fixed factors occupying3 bytes, these products use M(3,2)=35, not M(2,3)=37. Across both coordinates this saves12 events compared with retaining the old orientation, explaining9970 instead of9982. No truncation of an actual integer is authorized by this model: a future ordinary proof must establish its range and representation.

## 5. Costs that remain outside the subtotal

Each polynomial still has nineteen exact complex coefficient additions, nineteen complex product rounds and all required source/output bindings. There are twenty direct complex coefficient conversions per DISTINCT stored source array and selected grid vector. They may be shared across consumers only when the exact source object, grid vector and checked-context lifetime agree. The original source encoding may be wider than the new delivered coefficients, so these conversions are not priced as if their inputs were already narrow.

The profiles have respectively0,18,7 nonzero alignment shifts, with total shift distances0,19,29. Under the guaranteed even cancellation, the remaining distances total0,1,22. The saved summary key `guaranteed_cancelled_alignment_bits` means this REMAINING distance after guaranteed cancellation, not the number of bits removed. Its stage-level input is explicitly named `remaining_alignment_bits`; removed distances would instead be0,18,7. This definition preserves the already saved receipt without giving its abbreviated key a false meaning. Divisor extraction, exact shift identities, zero padding, signed wrappers, residual addition/subtraction, nearest-tie comparisons, quotient discovery, coefficient additions and final serialization all remain charged separately. Degree0 raises the final exact-add/output capacity to114 signed bits even though no multiplication consumes it.

A complete price should therefore retain separate terms for the displayed product subtotal, source-array conversion, alignment/cancellation, additions and comparisons, numeral and term representation, proof references/unification, setup/library cost, source-binding/coverage and data traffic. The event template is a specified possible ordinary-rule schedule; no executed MM0 arithmetic library or Lean kernel benchmark is claimed. Its product savings cannot be equated to full proof-size or runtime savings. No full-family weighting has been recomputed in this packet.

The same stored-degree information can sharpen finite-difference initialization. At partial Newton stage i its coefficient set is z_(19−i),...,z19; a valid stage bound may use their maximum converted envelope. Before inserting the next coefficient, the old partial polynomial and the new coefficient need separate bounds. Consequently comparing this refined Horner subtotal to an unchanged blanket-wide finite-difference cost would not settle the efficient circuit choice. That competitor requires its own refined widths and complete cost comparison. Analytic foundations, seeds, source generation and spectral acceptance obligations are unchanged.

## 6. Evidence, pins and next gate

Owned script fixed_horner_degree_envelope_costs_20261111.py has SHA256 `22D456ADE5596011FF01145F384C2FA0A93D86C29E4A8EB97AE2C24FDA1B1162`; receipt of the same stem has SHA `4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9`. All3354 assertions pass. The script reconstructs the source rational envelopes without importing the author program, checks twelve frozen pins, reconstructs all six profile recurrences and114 stage records, checks the unchanged error caps and reproduces the old matched subtotals. It performs no new profile optimization or numerical function evaluation. The writer fails if its output already exists, preserving the receipt.

The checked inputs, besides the source note and its review in section1, are:

|Artifact|SHA256|
|---|---|
|prime-estimates/stored_hurwitz_degree_bounds_20261111.py|`1F0D78DF0CF364A68DEE066D10CBA66C7B192A9C231AAB55B5B458A80B0BE6F5`|
|prime-estimates/stored_hurwitz_degree_bounds_20261111.json|`E947C32ED8EA30BA14ED64A7DFF83AA1C8E3F3F222AAD1AD8DAA8484013781BE`|
|prime-estimates/OPTIMIZED_BYTE_HORNER_GRID_PROFILE_2026-11-11.md|`A27CD526DB41C599F43912626827062EDC454F887A722782FF3953BE5BFFCE29`|
|prime-estimates/optimize_degree_horner_grids_20261111.json|`9BA037D7AAFB7A0F053C109ABD9751112B586805236A14D9467EFD29B32871CE`|
|independent-feasibility/REVIEW_OPTIMIZED_BYTE_HORNER_GRID_PROFILE_2026-11-11.md|`A9D0D867D68FE902E0270A988DCED8E1D2A0B711EF9F4A99A2EEB24ABCA92A0B`|
|work/qrh-blueprint/DEGREE_DEPENDENT_HORNER_GRID_PROPOSAL_2026-11-11.md|`0249787E3EC22DAC609C28FE62CE847A8389CDB6D81ADD5A65D783A872A5DE12`|
|prime-estimates/REVIEW_DEGREE_DEPENDENT_HORNER_GRID_2026-11-11.md|`D475972DB3EBDEC46D1AAB5DC5D4CBD7D7C157936E333ECE46737F45C34DC5E9`|
|audit/B100_PRODUCT_ONLY_HORNER_2026-11-11.md|`84E9E1491DE668337E0DACFCFFFBA7F6CDEBDAE6479929EB6CC097D2535D9A6C`|
|moebius/REVIEW_B100_PRODUCT_ONLY_HORNER_2026-11-11.md|`1C1902623E32D7D565A3173FE852E4B4340A154EC71AE6F462196C7CAA65AD7A`|
|integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md|`3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227`|

Independent review of this repricing remains required. Implemented ordinary-rule range/rounding records, actual input certificates, complete coverage and an end-to-end cost comparison remain separate gates.
