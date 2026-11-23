# Sharing a high-precision kernel across runtime precisions

2026-11-11. Root paper proposal, awaiting independent review. No inventory fold, numerical evaluation, root/kernel construction, build, declaration or proof emission is performed. This is a separate candidate setup schedule. It does not replace the independently built per-precision cache comparator in the current price preflight.

The conductor-local precision proposal can require several runtime precisions for one Bluestein leaf. Its conservative schedule constructs a separate full kernel FFT for each precision. The existing error interface admits a different producer: construct the full kernel once at the highest required precision, then derive each runtime cache by checked dyadic rounding. Runtime cache entries, exact coefficient sums, bindings and lifetimes remain separate.

## Source contracts

The accepted rounded-cache normalization paper and review supply the following quantities for a full Bluestein leaf n>=2:

    m=2n-1, P=2^k=nextPowerOfTwo(m), R=2k+4,
    A=1+3R, Q=3nPA+1, D_old=max(1,2k,PA,Q).

The exact unscaled kernel transform K has |K|<=m. A certified full kernel producer at precision H gives

    |Khat_H-K| <= PA u_H,  u_H=2^-H.

The accepted runtime proof at precision p requires a grid-p scaled kernel center B_p satisfying

    |B_p-K/P| <= (A+1)u_p,  u_p=2^-p,
    u_p<=1/D_old.

Its other hypotheses include the actual root/chirp enclosures and runtime gate errors at p, stored-input bounds, and the old peak guard. This proposal changes only the scaled-kernel producer. It supplies no runtime root or chirp certificate by implication.

Coordinatewise nearest rounding to grid p has complex error at most sqrt(2)u_p/2<u_p. The triangle inequalities below conservatively use u_p. A deterministic tie and zero convention must be fixed and bound to the produced objects. The proof does not require the high and low computations to return identical centers.

## Direct projection from the raw high cache

Let T_n be the nonempty finite set of required precisions for the same full kernel identity and lifetime. Set H=max T_n. For each p in T_n, define

    B_p=Round_p(Khat_H/P).

Since p<=H, u_H<=u_p. Therefore

    |B_p-K/P| <= A u_H+u_p <= (A+1)u_p.

The safety hypothesis at p implies safety at H, so the high producer can use the accepted full-kernel theorem. This argument applies when p=H as well as at lower precisions. It does not rescale an error by the number of cache users.

The strict stored-center bound required by the runtime width model also follows from the original argument. Since P(A+1)<Q and Q u_p<=1,

    (A+1)u_p < 1/P,
    |B_p| < m/P+1/P=2n/P<=1.

Consequently the runtime kernel mantissa still needs p magnitude bits. The point-product error recurrence, inverse factor P, final chirp error, normalized C_old/D_old contract and subsequent CT/tensor bounds consume the same hypotheses as before. The derived caches also meet the sharper C_new proof wherever that proof is independently admitted; this paper does not itself adopt a new CT recurrence.

The division by P is exact before rounding. If Khat_H has integer numerator on grid H, its exact scaled value has the same numerator on grid H+k. The output conversion discards H+k-p fractional bits. Its original numerator width and signed residual/range witnesses must be charged. It is not a grid-p operand merely because its target cache is grid p.

## Projection from an already normalized high cache

A second schedule first constructs the ordinary normalized high cache

    B_H=Round_H(Khat_H/P),
    |B_H-K/P| <= (A+1)u_H,
    |B_H|<1.

For p=H retain B_H itself. For each p<H independently set

    B'_p=Round_p(B_H).

This projection is directly from B_H, not a chain through intermediate precisions. Because the precisions are integers, u_H<=u_p/2 when p<H. Also A>=1. Hence

    |B'_p-K/P|
      <= (A+1)u_H+u_p
      <= ((A+1)/2+1)u_p
      <= (A+1)u_p.

The same strict norm argument proves |B'_p|<1. This establishes the same runtime enclosure and width contract. It does not establish B'_p=Round_p(Khat_H/P), since double rounding can change a center. Neither schedule inherits strict signs from an independently constructed low-precision cache. The complete radius is preserved through its sufficient enclosure contract, while any actual acceptance must use the new centers.

The high normalized numerator has H magnitude bits. A lower projection discards H-p bits and starts from that actual numerator. For the current p100 through108 proposal the shift is between one and eight, but signed arithmetic, residuals, range proofs and source identities remain paid. The high normalization still uses the wider raw FFT numerator and its H+k grid.

Exact cached sums C+D and D-C must be formed from each new B_p or B'_p. Independently rounding a high cached sum is not generally equal to the sum of rounded coordinates, so this proposal does not reuse those sums without a separate equality proof.

## Counts for a declared cache lifetime

No actual cache inventory is folded here. Let L be the set of full kernel identities required in one declared common lifetime. Distinct sign, chirp, full-plan or normalization identities remain distinct unless an exact checked adapter identifies them. For each n in L retain its actual precision set T_n and padded P_n. Put

    E_all = sum_(n in L) |T_n| P_n,
    E_high = sum_(n in L) P_n.

The independently built comparator performs one full kernel construction for every pair (n,p), p in T_n. Either shared producer performs one full kernel construction per n at H_n=max T_n. This removes repeated construction roles; it is not a claim that the remaining high construction has the cost of a lower one.

The direct-raw schedule performs E_all complex scale-and-round conversions. The normalized-high schedule performs E_high high scale-and-round conversions plus E_all-E_high high-to-low complex projections. Both retain E_all runtime complex cache entries and 2E_all exact real cached sums for the fixed three-product circuit. Conversions are two coordinate witnesses each. Root, chirp and source certificates used by the high FFT remain necessary. Root/chirp reuse in runtime transforms is a separate question with its own contracts.

The different round categories have different original operand widths and shifts. Equality of their occurrence totals does not give equality of their prices. Actual setup includes construction, rounding, enclosures, sums, source/public numeral bindings, key association, storage, loading and checking. Generation and checking need separate cost functionals.

Let F(n,p) be the complete cost of a certified raw kernel construction at p under the chosen ordinary-proof implementation. Let R_ind, R_shared and U_ind, U_shared denote all respective conversion and remaining costs. The conditional saving test is

    sum_n sum_(p in T_n) F(n,p) - sum_n F(n,H_n)
        > (R_shared-R_ind)+(U_shared-U_ind).

This comparison is between specified cold schedules. When old kernels have already been produced, their costs are sunk. Only future work, reuse and additional checking may be compared. No numerical saving is claimed from this inequality.

## Identity, order and proof obligations

Every derived object must be bound to the exact source kernel identity, P, high precision, runtime precision, sign/chirp convention, deterministic rounding, enclosure contract and lifetime. A shared producer digest is only an identifier. The ordinary proof must consume the high certificate and the particular projection witness.

A possible order constructs and checks one high cache, derives the required lower caches and their sums, and retains or exports their proofs for the actual runtime uses. If separate worker or theorem boundaries require replaying the high certificate, count the actual repetitions. This paper does not supply a stock MM0 import mechanism or assume shared local pointers survive resets. The high certificate plus all live projections, proof references and original arithmetic objects must fit the chosen memory schedule, or the schedule must pay storage, reloads or reconstruction.

The source theorem for each projection can expose the required low-grid enclosure and norm bound after consuming the high certificate. That is an ordinary proof-composition obligation, not permission to trust a low cache whose producer was run outside the checker. The existing full-pair cache inventory remains a valid conservative runtime-entry schedule even if this alternative producer is eventually implemented.

## Frozen sources and scope

Paths are relative to work/qrh-campaign/agents.

|Source|SHA256|
|---|---|
|independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md|FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9|
|integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md|09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA|
|major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md|1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A|
|independent-feasibility/REVIEW_CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md|15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2|

Root read these complete source contracts. The general inequalities above are the paper proof; no finite numerical experiment is substituted for them. The source pins are checked separately when freezing this note. Independent review remains required before adoption. Actual certificates, ordinary arithmetic libraries, exact bindings, sign success, count closure and full prices remain open.

DRAFT_ANCHORS: none created; repository-wide state not audited.
UNREGISTERED_SORRIES: none introduced; repository-wide state not audited.
DRAFT_IMPORT_VIOLATIONS: no imports changed; repository-wide state not audited.
SEALED_THIS_TURN: 0.
