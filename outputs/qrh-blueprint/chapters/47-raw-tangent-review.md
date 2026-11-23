# Raw square-root tangent review

Independent research review, 2026-11-10. Pinned project commit23b2d68ca344203d4384e0aff7affa4ec034bef9. No Lean compiler or source implementation. The previous binned and coverage pins remain unchanged in BASE_GAP_CLASSIFIER_REVIEW.md.

Reviewed new artifacts:

- major-constants/BASE_GAP_BINNED.md, raw tangent addition: SHA256A946F00D59ACCA4664D146E9B67BE0CD6A2A2E985533C436001749A4B8671481.
- major-constants/base_gap_raw_tangent.py: SHA256CC2AF66E2F6B5C4B8EDDE1C7DD9749D5E1C0B977F4ED7F680A5DFE64B7803873.
- major-constants/base_gap_raw_tangent.json: SHA256C41D3CE0568611F2A54F9A309D40B9C3AD835DB50CEA7E5119767D6C3E5B5BAE.

## Verdict

The raw tangent extension passes source and paper-level review. It supplies the stated partial-twist sufficient region, uniformly in y>=1e25, conditional on the existing Type I/II producers. It does not certify every twist at Q=90090 and does not increase the all-twists denominator counts. Negative comparison margins outside the passing region are failures of this upper-envelope test, not impossibility results.

## Exact source product and remainders

Inspected FirstChoiceTypeI1.typeI1_first, FirstChoiceTypeI2c.typeI2_first, FirstChoiceTypeII.typeII_first, and Assembly.norm_S_le_parts. The three Type I/II producers have Fact PlattGRH requirements. The assembly is unconditional but has its explicit V<=x/4 premise. At the first-choice V1, that premise follows by the same elementary estimate used in FirstChoiceFinal; the present scale z>=1e23 is more than sufficient.

Write C=Cxt(z^(1/3),t), v=Q/phi(Q), and ell=log(t). Dividing the exact raw sum by z gives

sqrt((v/t)*[(C+.5)*ell+.002*C+log2]*[.30214*ell+.7468])
 +2.5257/sqrt(t)
 +[13.2*v+2*(16.267*ell+24.42)]/t
 +3.77*z^(-1/6)+3*log(z)/z.

The product comes from log(4t)/2=.5*ell+log2. The remainder coefficients are exact sums:13.2=2*(3.8+2.8),16.267=1+15.267,24.42=2.96+21.46, and3.77=.014+.556+3.2. The source3*log(z) assembly residue is retained. No AM-GM or rounded3.8 remainder from the later simplified theorem is needed.

For fixed C>=0 and ell>=2, the two positive affine factors A(ell),B(ell) satisfy A'<=A/ell and B'<=B/ell. Therefore the derivative of A*B*exp(-ell) is nonpositive. This proves the required decreasing behavior in t before taking the square root. The remaining terms have the same elementary monotonicity. Replacing C by a valid nonnegative cell upper bound and t by t_min is therefore legitimate; the proof does not differentiate the original C(z,t) expression.

## Affine envelope and tangent direction

The prior reviewed kappa inequality gives C(z,t)<=kappa*(r-.41415)/.27125, where r=R(y,300000) is in[.41415,.583405]. Thus the square of the leading upper bound is the script's affine q(r)=qa*r+qb. Although qb can be negative, q(r)>0 on each r cell; qa>0 and the script checks q(rlo)>0.

For every h>0 and q>=0,
sqrt(q)<=q/(2h)+h/2
follows exactly from(sqrt(q)-h)^2>=0. Hence choosing h as an upper rational square root of q at the midpoint remains safe. It need not equal the square root, and no incorrect rounding of a derivative is involved. The resulting slope ta=qa/(2h)>0 and intercept tb=qb/(2h)+h/2 give a global affine majorant on the cell.

The script combines the tangent with all positive remainder terms before enlarging the Gaussian mass. Its check of positivity at rlo suffices on the cell because the affine slope is positive. This avoids the invalid inference that a possibly negative expanded constant can independently be multiplied by an upper mass. The rounded upper logarithm and roots also substitute in positive expressions. The term3*log(lY)/(lY) is a valid upper bound because log(z)/z decreases for z>=lY>=1e23.

## Domain, integration and finite test

The source parity reduction and Approx2 parameter remain those previously reviewed: reduced denominator Q of2alpha, D=Q*abs(delta), scale z=w*y, twist2w*delta, and t=max(2Q,wD/2). For the tested rectangles Q>=90090, w in[.01,8], and D in[600000/49,600000], all first-choice approximation and size conditions hold. The kappa, positive Gaussian panel masses, Simpson remainder and omitted tails are the same reviewed ones from base_gap_binned.py.

The raw script divides the common r interval into eight equal rational cells, retaining sixteen D cells and161 w panels. The difference between the ghat lower envelope and each integrated tangent bound is affine in r. Its two endpoint values therefore control the entire r cell and every corresponding y. The union of the r cells covers the full all-y reference interval; there is no finite-y cutoff or unverified extrapolation.

D cells7 through15 are exactly the range
13200000/49<=D<=600000.
The actual gap has D<600000, so including the right endpoint is harmless. The script certifies all these nine cells for both tested Q rectangles. The seven lower D cells do not pass this particular comparison.

## Independent replay and status

check_raw_tangent.py executed the unchanged source with its output redirected by an audit-owned __file__ path, leaving peer artifacts untouched. The generated result matched the complete stored JSON. It then parsed every exact A,B,r endpoint and independently recomputed the affine margins, verifying the downward-rounding direction. The passing indices and threshold were also checked exactly.

Reproduced minimum downward-rounded margins:

- Q=90090, v<=1001/192, D>=13200000/49:417893791/500000000000=.000835787582.
- 90090<=Q<=150000, v<=1001/192, same D range:786242533/1000000000000=.000786242533.

The saved exact A and B strings permit rational replay; floating worst_gap fields are diagnostics and do not decide acceptance. The decision uses exact downward-rounded gap strings, so a positive decision implies a positive exact margin. No change to the prior73578 all-twists coverage count is justified by this partial region alone.

This is a valid paper deduction from the current Type I/II source inequalities and previously reviewed analytic enclosure lemmas. The source producers still need their Platt-free proofs; tangent/partition/Simpson/source specialization still need formalization and exact-type/axiom checks. A later full Q90090 rectangle will require its own separately pinned review.
