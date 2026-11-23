# Full P20 magnitude scope below grid70

2026-11-11. Narrow immutable companion to `FULL_P20_INPUT_MAGNITUDE_5691_2026-11-11.md`, SHA256 `718CFC0DDAA0594A2AB26ADDCEBA09E472E07C1ED21FD8058821957251EAC223`, independently reviewed at42985BB1. The prior report's three grid100 profiles remain its exact frozen scope. This companion extends only the magnitude implication and explicitly joins the existing full P20 fixed-grid94 candidate. No current cost or assignment baseline is changed.

No actual coefficients, functions, roots, transforms, signs, zeros or primes were evaluated. No inventory, profile search, build, declaration or proof emission occurred. The fixed arithmetic checks below reconstruct six already-declared domain cases, not a new optimization.

## 1. The scope gap and the actual interface

The current guarded full P20 comparator need not use b0=100. The reviewed joint-Horner source AEAB2BDC permits a prefix of a fixed shape with a common grid offset. For the full P20 fixed shape at b0=94, the actual grids in degree order are

    [94,94,94,94,91,89,89,89,83,81,
     81,81,75,73,73,73,65,65,65,65].

It converts each ORIGINAL stored coefficient directly, copies the top converted coefficient, performs19 rounded real-displacement products and19 exact additions, and exports its grid94 result exactly to grid100 by a six-bit numerator shift. The export is a new representation of the same computed value, not the older grid100 computation. It introduces no numerical error, but all sign, range, shift, canonicality and identity proofs remain paid.

Consequently the old b>=70 accumulator table is not directly applicable to this profile. Its source Z_j bounds remain applicable, because they concern stored finite-polynomial coefficients independently of the destination grid. The joint-Horner paper sections2–3 supplies the correct fresh recurrence for grids below70. The5691 base paper used that recurrence but stated its numeric conclusion only for three b0=100 profiles. The extension below fills this scope gap without reverting to those more expensive profiles.

The separate short-guard admission6DF38245 specifically checks K18/b94 and K19/b93 at its new endpoint. It must not be cited as if it alone checked K20/b94. The full P20 candidate instead uses the general joint-Horner formula, which is valid throughout each declared band, with the fixed six checks in section3 below. Its final declared7000 domain already contains the guard cap26525/4.

## 2. Magnitude theorem for full P20 with min b>=60

Retain the same actual stored source vectors, their finite translations and numerical errors, and the source Z_j envelopes from9B777E02. Let all20 selected coordinate grids satisfy b_j>=60, and let b0<=100 for the exact output-to-grid100 adapter. Require the actual product-only-rounded schedule above and an exact displacement of absolute value at most1/4. No intermediate coefficient conversion or extra final round is allowed without its own charge.

For every integer b_j in this range, nearest coordinate rounding has Euclidean error below

    e_j=(3/4)*2^-b_j <= e60=(3/4)*2^-60.

This is a fresh elementary rounding statement; it does not invoke the source note's separate b>=70 accumulator conclusion. The full P20 recurrence still unrolls exactly as

    A0=sum_(j=0)^19 Z_j/4^j
          +sum_(j=0)^19 m_j*e_j/4^j,
    m19=1, m_j=2 for j<19.

The second sum is strictly below `(8/3)*e60=2^-59`. This counts20 direct conversions and19 product rounds; all additions and the export are exact. A b0 below100 changes the export shift, not this numerical sum.

With the same notation R, W, eta and rational majorant H from the base paper, the sufficient bounds are now

    A0_first < 5170+R+20W+6*(H(5/16)-1)+(8/3)*e60
              < 10345/2,

    A0_final < 4507+9/2+R+(4/3)*eta
                 +(15/2)*(H(7/32)-1)+(8/3)*e60
              < 9027/2.                                  (1)

These strict rational inequalities retain ample slack. The full source object, numerical coefficient error, output normalization8192 in the final band, negative shifts/heights and endpoint qualifications are unchanged. There is no identification of the finite translated vector with exact fine-anchor derivatives.

The head bound `<517`, exact grid100 assembly, single p80..108 regrid and augmented1 therefore give the SAME bounds5691 uniformly and5032 for the final-band producer. The generic error/width consequences of the base paper follow only after the actual source/profile contracts are bound. No new data widths, operation totals or prices are computed here.

Most importantly, this is not an accuracy-admission theorem for arbitrary grid60 profiles. Their evaluation error can exceed the alpha allowance. A usable profile must separately satisfy its actual complete alpha inequality, with its source, finite-shift, numerical coefficient and evaluation terms. Neither (1) nor a small stored magnitude supplies that missing accuracy. Any raw-stage or signed-witness capacity must also be derived for the actual grids; old b>=70 tables are not inherited automatically.

## 3. Exact join for the existing full P20 fixed b94 profile

For this particular profile, min b=65 and b0=94 meet the extended magnitude theorem. Its evaluation error is bounded by the exact finite expression

    E20 = sum_(j=0)^19 m_j*(3/4)*2^-b_j*4^-j
        = (5253/2048)*2^-94.

Use the accepted general source contract

    Alpha=T20(V,D_out)+S_class+N_class+633*E20,
    T20=1266*((V+20)/(4D_out))^20/20!,
    S_first=1266*(15/16)^27/27!,
    N_first=2532*2^-100+633*330*2^-110,
    S_final=1266*(5*7028/(8*4096))^28/28!,
    N_final=844*2^-100.

The companion checks `Alpha<2^-82` for the four declared first-band pairs `(500,512),(1000,1024),(2000,2048),(5000,4096)`, the final declared pair `(7000,8192)`, and the final guard pair `(26525/4,8192)`. These are six fixed rational substitutions into the reviewed continuum bound, not height sampling. Only the positive target Taylor term varies with V, so the declared endpoint covers all relevant absolute heights in that band's source interface. Guards must still be routed to their actual source band. The final source S/N remain based on7000/source4096 even at the smaller guard cap.

The original source production still supplies all20 output slots through P27/P28 and the selected EM/finite-shift schedule. Source work is not reduced by using the b94 evaluation grid. Exact grid100 export does not improve accuracy or preserve earlier signs; subsequent raw-head assembly and transform-input regrid retain their separate contracts and costs.

Thus the tighter magnitude bound can join the full P20 fixed b94 interface without silently substituting a b100 evaluator. This is a source/error compatibility statement, not a new assertion about every profile admitted by a prior search. Other profiles can use section2 only with their own independently admitted full-alpha and representation interface.

## 4. Evidence and frozen dependencies

Owned `full_p20_grid60_magnitude_20261111.py`, SHA256 `1F28B6C9577B0894069DC132DF72521B2A2B4FAD0515D213350D9CE99D27CA2D`, checks21 fixed assertions, including seven input hashes, both e60 magnitude inequalities, the exact b94 shape/E20/export, all six complete alpha inequalities and both final augmented bounds. Its first run produced the2827-byte exclusive receipt `full_p20_grid60_magnitude_20261111.json`, SHA256 `4158B1FBF599616A15EBD7978AB7C36EEDCB2C596355D6EE295689C35EF222D2`. It imports no writer and reads no large JSON, source coefficient or inventory.

|Input relative to agents unless marked blueprint|SHA256|
|---|---|
|independent-feasibility/FULL_P20_INPUT_MAGNITUDE_5691_2026-11-11.md|718CFC0DDAA0594A2AB26ADDCEBA09E472E07C1ED21FD8058821957251EAC223|
|zero-sum/REVIEW_FULL_P20_INPUT_MAGNITUDE_5691_2026-11-11.md|42985BB1A88F4F70A3C9C37584725C34D04EDFE9DBEFF8BAE19E1F79E7B44E8C|
|prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md|9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2|
|moebius/JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md|AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63|
|independent-feasibility/REVIEW_JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md|84B062431F1A7C49C2191E8C4576A6CC6B870A431A5BB3E7BBDDF59150F437D7|
|blueprint/SHORT_GUARD_HORNER_DOMAIN_ADMISSION_2026-11-11.md|6DF38245BECCD8A35B94F98787C4DEF64EEB9EFCF9FB07E54E1D9EC554C48DF2|
|major-constants/REVIEW_SHORT_GUARD_HORNER_DOMAIN_ADMISSION_2026-11-11.md|4D313FBFEC13EBC9D80490C5CC995228D67E71F211F865113A67969A60BB82E9|

This companion leaves the5691 paper and its review unchanged. It does not assume the pending smaller coarse-EM degree0 bound; a future such producer may replace Z0 only through its own complete source proof. That producer should retain the present distinction between the generic magnitude grid range and separately admitted full alpha/error profiles.
