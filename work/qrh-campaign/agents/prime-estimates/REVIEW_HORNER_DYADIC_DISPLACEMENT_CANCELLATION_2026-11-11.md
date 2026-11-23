# Independent review: dyadic Horner displacement cancellation

2026-11-11. PASS at conditional paper/source scope, without correction. No gcd, conductor, residue, unit, coefficient or price enumeration was performed. No numerical function evaluation, inventory fold, build, declaration or proof emission was performed. Frozen artifacts were not changed.

Reviewed author: `audit/HORNER_DYADIC_DISPLACEMENT_CANCELLATION_2026-11-11.md`, SHA256 `18121A5D92E796CD2779EFD1824C2794F704C4036D71E7704EE2FF4C8A857C9A`. Paths below are relative to `work/qrh-campaign/agents`.

## Exact geometry and source identity

I reconstructed the ties-down floor formula from its integer inequalities. For positive c, the stated k gives `(2k-1)c < 2Fa <= (2k+1)c`; therefore `r=Fa-kc` satisfies `-c<2r<=c`. With `F=2D_out`, the actual normalized displacement is `h=r/(2c)`, lying in `(-1/4,1/4]`. This is precisely the alternative convention in `EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2`, section 8, lines 166--171. Its earlier ties-up convention does not identify the same coefficient object at a tie. The author correctly fixes the actual anchor and converted source array throughout.

Writing `c=2^tau*d` with d positive odd and `nu=min(tau,f)` makes all exponents in the direct r0 formula nonnegative. Expanding it proves `r=2^nu*r0` and `2c=2^nu*v0`. Dividing the established geometric inequality by the positive factor proves the reduced geometry. There is no need for an accumulator divisibility premise or an untrusted gcd result. The factorization and the direct numerator identity still require exact proof.

The caps `|r0|<2^(18-nu)` and `v0<2^(20-nu)` follow by dividing the existing strict global caps. They concern the reduced difference, not either term used to construct it. The current family filter can also be checked directly in `major-constants/combined_odd_even_height_inventory_20261111.py`, lines 29--30: odd c is capped at 132900, and admitted even c is divisible by four, within the outer cap 265800. This script was read, not executed. Thus the stated even-family guarantee nu>=2 is correct; no population count follows from it.

## Stage equivalence, including both signs and ties

Put `e=tau+1-nu`, `beta=min(delta,e)` and `w=v0/2^beta`. The exact equations imply

    r*M*2^delta = (2^nu*2^beta)*X,
    v = (2^nu*2^beta)*w.

This proves equation (7) without rounding or changing the target grid. The natural slack equations give `0<=S<2w`, hence `-w<=2(X-Lw)<w`. Multiplication by the positive common factor recovers the original residual inequality exactly. Conversely the original nearest integer yields an integral reduced residual and natural S,C, so the new witness is complete as well as sound.

The closed lower/open upper endpoints select nearest ties toward positive infinity for negative and positive products alike. This is independent of the anchor tie convention. The zero-displacement case is admitted by the same equations and canonical zero policy; a cheaper zero branch is not implicitly priced.

Starting at the same converted top coefficient, deterministic rounding and exact same-grid coefficient addition prove equality of every accumulator by induction. The prefix K, coefficient conversion grid and original coefficient object must remain fixed for this statement. The author correctly does not equate different prefixes, different conversion arrays or previously computed spectral outputs. The preserved source/prefix/target error contract is a consequence of identical centers, not a new allowance.

## Raw capacities and acceptance order

The A/T/C recurrence matches `SHORT_OUTPUT_HORNER_PREFIX_COMPOSITION`, section 3, and the signed schedule's inherited range obligations. In particular the first product uses the input-grid M; the witness product uses the output-grid L. A small accepted residual cannot bound their unchecked input products.

Given the proved geometry and actual encoded stage ranges, I independently obtain every bound in equation (10) by multiplication and triangle inequality. The positive cap rho=c0/2 is valid even when the actual numerator is zero. The exact alignment shift remains delta-beta. The bounds on raw R and 2R+w precede use of the slack guard and account for uncancelled subtraction operands. The exact coefficient addition uses lambda+eta; no accumulator-width reduction follows simply from rewriting its product.

For `B=ceil(log2(2w))`, valid S and C are below 2w and therefore below or equal to the enclosing power with the required strict encoded cap. Independently enforcing each `<2^B` gives `S+C+1<=2^(B+1)-1` before the equality is checked. The global alternative `B=21-nu-beta` follows from the strict reduced denominator cap. Both are sufficient; neither permits a wrapped raw sum or a range inferred only from the equality being validated.

Two natural product proofs and four natural addition proofs per coordinate remain the declared generic arithmetic skeleton. Signed bridges, shifts, range/tie proofs, numeral construction and source binding stay separate. This report does not validate their implementation or assert that a nominally narrower operand saves complete ordinary proof work.

## Comparison boundary and no double credit

I checked the current guarded author and its independent review: their selected stage retains rM and Lv with raw alignment and expressly assumes no conductor-specific cancellation. The original signed schedule offers only the separately priced optional one-bit alignment cancellation. Thus the new guaranteed conductor/grid factor is an unpriced option relative to that current guarded baseline.

Algebraically, the total removed denominator exponent is

    ell=nu+min(delta,tau+1-nu)=min(tau+1,nu+delta).

Against full old alignment cancellation `gamma=min(delta,tau+1)`, splitting delta at `tau+1-nu` and `tau+1` yields exactly

    ell-gamma=min(nu,max(0,tau+1-delta)).

When delta>=tau+1 the completed numerator and denominator agree with the already alignment-reduced representation. A smaller unshifted r0 multiplication can still change representation work, but it is followed by a compensating larger exact shift. That is not another reduction of the completed quotient witness.

More strongly, `MATCHED_NORMALIZED_RESIDUE_COST_COMPARISON`, section 2, already admits exact target cancellation by `min(v_2(r),v_2(v))`, followed by remaining alignment cancellation. Since the new g divides both r and v, a comparator which actually proves and prices that full target reduction already contains this guarantee. The author's no-additional-credit warning is essential and correct, including its separate r=0 convention. No new aggregate association or cost saving can be extracted from the old five-band totals alone.

Reuse is restricted to the exact conductor/grid/divisor/numerator objects in an available checked context. Geometry can be height-independent; coefficients and their converted arrays are different objects. Proof setup, raw construction of r0, repeated context admissions, remaining shifts and new divisor bindings remain required. This is a sound conditional adapter, not a production choice or an end-to-end speed claim.

## Evidence and scope

The author hash and all nine source hashes in its frozen snapshot matched. I read the indicated geometric, stage, prefix and comparison interfaces and the guarded independent review. The supplementary family-filter source hash is `4C1B0FA0DA303A5EE475493A8CE66EB3723B3C9DFD9369DF9687069AF3F3E154`. Only file hashing and text inspection were run; all mathematical checks above are paper derivations. No author or predecessor numerical script was imported or executed.

The verdict establishes the exact cancellation, nearest-center equivalence, raw-capacity interface and comparison restrictions. Ordinary proof implementation, complete producer/checker pricing, saved-row associations and any selected savings remain open.
