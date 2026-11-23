# Guaranteed dyadic cancellation in the Horner displacement

2026-11-11. Conditional paper derivation. No gcd, conductor, unit, anchor or coefficient enumeration; no metadata/price fold, function evaluation, build, declaration or proof emission. Frozen source and cost artifacts are unchanged.

The common power of two in F and c can be removed from the Horner displacement before multiplication. With checked divisibility and the same signed nearest rule, every rounded accumulator and exported center is identical to the original circuit. This specializes the earlier exact-target cancellation interface; the current guarded frontier explicitly did not price it. No saving or production schedule is selected here.

## 1. Actual displacement and tie conventions

Fix an admitted prefix and coefficient-grid vector from the current guarded frontier `integration/GUARDED_RESIDUE_EVALUATION_FRONTIER_2026-11-11.md`, hash `C24D4CB1338EDDFD46398C5B6D2BB1CA80CA61500B648B1A41039BFEECB6CA8D`, and review `zero-sum/REVIEW_GUARDED_RESIDUE_EVALUATION_FRONTIER_2026-11-11.md`, hash `31FEFFBA372D36CB37854EC628EC17D257A9B7CAD51BB761E962DFF1D6FF19ED`. The same actual source object, height, fine anchor, prefix K, grids and rounding policies remain fixed.

Write F=2D_out=2^f and alpha=a/c. For the current fine grids F is one of 1024,2048,4096,8192,16384. The ties-down anchor is

    k=floor((2F*a+c-1)/(2c)),
    (2k-1)c < 2F*a <= (2k+1)c.

The second line follows from the integer floor inequalities; it is equivalent to the lower bound `(2k-1)c+1<=2F*a`. It gives

    r=F*a-k*c,  v=2c,
    h=D_out*(a/c-k/F)=r/v,
    -c<2r<=c,  -1/4<h<=1/4.                         (1)

This is the ties-down convention explicitly supplied in section 8 of `EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2`. Its initial section uses the alternative ties-up convention. Do not mix their anchor indices or source arrays. The absolute bound |r|<=c/2 holds in either convention, but identical-center claims here keep the actual anchor fixed.

Anchor ties are distinct from product-round ties. The signed Horner witness uses nearest ties toward positive infinity, expressed by a closed lower and open upper residual interval. This product rule is unchanged.

## 2. Guaranteed conductor/grid cancellation

Supply a checked factorization of the power of two only:

    c=2^tau*d,  d positive and odd,
    nu=min(tau,f),  g=2^nu,
    c0=c/g=2^(tau-nu)*d,
    r0=2^(f-nu)*a-k*c0,
    v0=2*c0.                                        (2)

All exponents are nonnegative. Direct distributivity proves

    r=g*r0,  v=g*v0,  r/v=r0/v0.                    (3)

Thus neither a gcd computation nor divisibility of an accumulator is required. Even the divisibility of r can be established by the direct formula for r0 instead of first constructing a wide r and dividing it. The checked c and F identities, exact products/subtraction and source binding are still work.

Dividing the proven geometry (1) by positive g gives

    -c0<2r0<=c0,   |r0|<=c0/2,
    |r0|<=floor(c0/2),  v0=2c0.                    (4)

These are post-geometry bounds. They may be used for subsequent Horner products only after (1)–(3) have been proved. One must not use the small difference r0 as the size of either raw term in `2^(f-nu)*a-k*c0`.

Under the current c<=265800 cap, inherited global bounds were |r|<=132900<2^18 and v<=531600<2^20. Consequently the reduced factors have strict magnitude capacities

    |r0|<2^(18-nu),  v0<2^(20-nu).                 (5)

All current nu<=14. These are conservative bounds, not observed operand lengths. The selected even-conductor family has 4 dividing c, hence nu>=2; the odd family has nu=0. This states a uniform mathematical bound only and supplies no population or operation-cost count. A tighter per-conductor cap can use (4). No additional residue-specific factor, odd gcd or zero-operand shortcut is credited.

The case r0=0 remains valid: the product is exactly zero, canonical signs must represent zero consistently, and the same nearest rule returns zero before the coefficient addition. The generic circuit still works. A special zero shortcut requires its own checked branch and price; it is not silently subtracted.

## 3. Combine with stage alignment exactly once

At degree j let the input coordinate be M/2^b_next, the next coefficient be n_j/2^b_j and delta=b_j-b_next>=0. A common downward shift of an admitted grid profile does not change delta; taking a prefix changes which stages exist. The top converted coefficient is copied exactly and has no product round.

The original coordinate to round is

    r*M*2^delta/v.

The remaining dyadic exponent of v0 is e=tau+1-nu because d is odd. Define

    beta=min(delta,e),
    w=v0/2^beta=2^(e-beta)*d,
    P0=r0*M,
    X=P0*2^(delta-beta).                            (6)

Then w>0 and

    X/w=r*M*2^delta/v.                              (7)

All divisions in (2) and (6) are proved exact power-of-two identities. There is no division or valuation assumption on M. The guaranteed displacement reduction alone is obtained by beta=0; choosing (6) also consumes the available alignment cancellation.

The signed witness supplies integers L,R and natural S,C satisfying

    V=L*w,
    R=X-V,
    S=2R+w,
    S+C+1=2w,
    M_new=L+n_j.                                   (8)

With S,C>=0, these equations imply `-w<=2R<w`. Therefore L is the unique nearest integer to X/w with the same product tie rule as the original schedule. Multiplying the inequality by `g*2^beta` gives exactly

    -v<=2*(r*M*2^delta-L*v)<v.                     (9)

Conversely the original nearest L satisfies the reduced inequality by (7). Its reduced R is integral; S=2R+w and C=2w-S-1 are natural and satisfy (8). Thus the reduced witness system is both sound and complete for the same rounding decision, including negative ties. No numerical error allowance is consumed by cancellation.

Induction from the identical converted top coefficient now proves identical M_new at every stage: the rational product is the same, deterministic nearest rounding gives the same L, and the same coefficient is added exactly on the same grid. The output re-encoding to grid100 and any later exact embedding are also unchanged. This is an identical-center statement for one fixed coefficient/grid circuit, not an identification of different converted source arrays or different K choices.

Consequently the accepted prefix conversion/product error, genuine Taylor target remainder, finite-shift bias and numerical source terms remain exactly as before. The isolated complete alpha contract is unchanged. Head, character transform, conductor scaling, completion, interpolation, signs and completeness remain separate.

## 4. Raw capacities precede the nearest-range conclusion

Retain the accepted source-specific magnitude recurrence for this exact prefix and grid:

    C_j=Z_j+(3/4)*2^-b_j,
    A_(K-1)=C_(K-1),
    T_j=A_(j+1)/4+(3/4)*2^-b_j,
    A_j=C_j+T_j.

Define positive rational bounds

    mu=2^b_next*A_(j+1),  lambda=2^b_j*T_j,
    eta=2^b_j*C_j,        rho=c0/2.

The existing integer range interface gives |M|<mu, |L|<lambda and |n_j|<eta. Together with the already proved (4), sufficient RAW bounds are

    |P0| < rho*mu,
    |X|  < Xcap=rho*mu*2^(delta-beta),
    |L*w|< Vcap=lambda*w,
    |R|  < Rcap=Xcap+Vcap,
    |2R+w| < 2*Rcap+w,
    |M_new| < lambda+eta.                           (10)

The input/sign/range obligations must bind the actual supplied integers and stage. These raw sums are used for signed-add proof operands before accepting the small residual interval. Neither the cancellation of X and Lw nor the final small S is a substitute for (10).

For the natural guard, choose B=ceil(log2(2w)). Independently require encoded S,C<2^B. Every correct witness has S,C<2w<=2^B, so these rejection caps preserve completeness. Before checking the guard equality, its natural sum satisfies

    S+C+1<=2^(B+1)-1.

Thus B+1 magnitude bits suffice for that raw guard sum. In a global conservative implementation one can instead use `B=21-nu-beta`, from `2w<2^(21-nu-beta)`. The exact bound or the conservative bound must be selected consistently with its proof. Signed storage adds its sign convention, and all exact shifts retain their actual input/output capacities.

For a positive rational cap U, a convenient strict magnitude capacity is the least integer b>=0 with U<=2^b, when the integer is already proved to have magnitude <U. Product templates must use the capacities of their actual operands, not the rounded product's width. The reduced first product uses r0 and the INPUT-grid M; the witness product uses w and the OUTPUT-grid L. The remaining alignment shift is delta-beta. Raw doubled residuals and the exact coefficient addition use (10). The stored accumulator widths do not shrink merely because its identical product has a cheaper representation.

The generic stage still has two natural product proofs and four natural addition proofs per coordinate, together with its signed bridges, nearest implication and shifts. Cancellation alone deletes no stage or required product equality. Template prices can change at byte boundaries, but that requires a separate matched repricing with setup and bindings charged.

## 5. Do not count alignment cancellation twice

Let ell=nu+beta be the TOTAL divisor power removed from the original v. Equation (6) gives

    ell=min(tau+1,nu+delta).                         (11)

The current guarded frontier and its joint-prefix inputs use the uncancelled schedule, so their comparison reference has removed power zero. The older signed schedule also offers a separate optional one-bit alignment rule `gamma_1=min(delta,1)`. It must be compared with ell, not charged again after ell has been used.

For a comparator that ALREADY cancels the full available alignment power, put `gamma=min(delta,tau+1)`. The additional denominator reduction is only

    ell-gamma=min(nu,max(0,tau+1-delta)).            (12)

This follows by splitting at delta=tau+1-nu and delta=tau+1. In particular, if delta>=tau+1, the old and new divisors both equal d and the aligned numerators are identical:

    (r/g)*M*2^(delta-(tau+1-nu))
       = r*M*2^(delta-(tau+1)).

There is then no further reduction in the aligned numerator or the Lw witness product. The first unshifted multiplication may use a smaller r0, followed by a compensating larger exact shift; those are different proof/representation costs, not another nu-bit reduction of the completed stage.

The earlier `integration/MATCHED_NORMALIZED_RESIDUE_COST_COMPARISON_2026-11-11.md`, section 2, already permits a stronger exact-target reduction by `min(v_2(r),v_2(v))`, followed by alignment on the remaining denominator. If that reduction has actually been proved and priced, the guaranteed g in (2) is already included. It earns no additional credit. This note makes a conductor/grid-guaranteed specialization usable without per-residue valuation discovery; it does not replace or double-count that earlier framework.

## 6. Setup, reuse and future metadata

Required ordinary obligations are concrete:

* Bind positive c, F=2D_out, f, tau,d and the exact identities/oddness in (2). No general factorization oracle is needed, but the supplied power-of-two witness must be checked.
* Bind the actual numerator a, its required unit/residue label, the chosen ties-down anchor k and the source coefficient array at that anchor. Prove (1) before using the narrow bound (4).
* Prove the direct formula for r0 and the two scaling identities (3). If constructing r0 from two large terms, budget their products and raw subtraction before applying its geometric bound. Alternatively supply a bounded r0 and check its defining identity with full-sized operands.
* At each distinct delta, prove the positive reduced divisor w and the exact shift/quotient identity (7). Then check the ordinary signed products, reconstruction, caps, guard, tie and exact addition in (8), including canonical zero.

The conductor/grid denominator object depends on `(c,F,nu)` or its equivalent checked identity. The stage divisor additionally depends on delta and beta. The numerator object depends on `(c,a,F,k)` and the tie convention. Such geometry is independent of source height and coordinate, so reuse across stages, coordinates or heights is mathematically possible when those exact objects remain available in the same checked context. It is not a freely retained global proof. Divisor doubling, signed decoding, references/imports, cache resets and source/label binding remain work. A source coefficient conversion cache is a different object and is not eliminated.

For future conservative pricing, a grouped association by band/F, conductor power-of-two class, actual admitted K/grid profile and each stage delta can use (5), (6) and the existing A/T/C bounds. It need not discover an actual r or evaluate coefficients to derive sufficient widths. However the current five-band aggregate frontier does not retain those conductor/grid associations. A later authorized saved-row join would need them and the old/guard weights; none is run or requested here. A tighter exact-factor or target-specific price would require additional bound identities, not an inference from the aggregate count.

Complete comparison must include geometry witness production/checking, new or shared divisor objects, remaining shifts, all raw signed/range work, source-conversion lifetimes, output adapters and witness discovery. The guarantee is exact rational cancellation and identical deterministic centers with the raw-width interface (10). There is no selected saving, aggregate count, runtime winner or new spectral conclusion.

## Frozen source snapshot

Paths are relative to `work/qrh-campaign/agents`. The indicated source sections were read. No companion computation is needed for the general algebra above; only hashes were checked in this task.

|Source|SHA256|
|---|---|
|moebius/SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md, sections 1–3|531DD23307CED3ED958198C750393D933287809B9E42EF738888370AA4DE4474|
|independent-feasibility/REVIEW_SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md|40AE12EEFE142B932820F6462E6DE7CE127679A0CE220010148C698E984BBFF1|
|prime-estimates/SHORT_OUTPUT_HORNER_PREFIX_COMPOSITION_2026-11-11.md, sections 1–4|716B9E5FFE726D629E97F2CA85CA972D351051A209CB0D5DC0B6CAC21F60C98B|
|integration/REVIEW_SHORT_OUTPUT_HORNER_PREFIX_COMPOSITION_2026-11-11.md|1F536DA236937B61AAF4E44B995956A06E090CFC91A00B40D9CF5896CC96CB03|
|moebius/JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md, sections 2–3|AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63|
|integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md, sections 1 and 8|691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025|
|integration/MATCHED_NORMALIZED_RESIDUE_COST_COMPARISON_2026-11-11.md, section 2|4E01AE12B9224898AF3CF169389B83B0BFFAE2FF0FDB74083B094BEB6735C54C|
|integration/GUARDED_RESIDUE_EVALUATION_FRONTIER_2026-11-11.md|C24D4CB1338EDDFD46398C5B6D2BB1CA80CA61500B648B1A41039BFEECB6CA8D|
|zero-sum/REVIEW_GUARDED_RESIDUE_EVALUATION_FRONTIER_2026-11-11.md|31FEFFBA372D36CB37854EC628EC17D257A9B7CAD51BB761E962DFF1D6FF19ED|
