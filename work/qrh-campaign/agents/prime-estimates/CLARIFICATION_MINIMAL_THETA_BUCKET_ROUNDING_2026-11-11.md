# Clarification: minimal-theta bucket rounding

This clarification corrects one sentence in section 3 of `MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md`, SHA256 73337A5EB2688E5B1A5196A901232A314D89F3E48B5EEFC013CA178A8FFA238A. The original remains unchanged. Its sentence beginning “Shared-grid bucket accumulation remains exact” is incorrect and must not be used.

The retained schedule uses rounded bucket additions, not an exact-accumulation shortcut. Read the sentence as follows:

> The schedule retains at most hT rounded bucket additions, each with complex norm error at most epsilon/(32 C Bpref n0). This error allocation is required independently of the character-transform error. All those operations and their rounding costs remain charged.

## Source and error budget

`NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md`, lines 133--145, requires

`delta+gamma <= epsilon/(32 C Bpref n0^4)`

and per-addition norm error

`u_bucket <= epsilon/(32 C Bpref n0)`.

For each parity and retained frequency, at most n0 terms are accumulated. Hence bucket-addition errors have l1 sum at most epsilon/(32 C Bpref). The propagated Gaussian-term errors have the same upper bound, yielding total input l1 error at most epsilon/(16 C Bpref). The exact character matrix has unit-modulus entries, so each output receives at most this l1 error, without another phi(c) multiplier. Intrinsic transform error, prefactor error and final multiplication rounding remain separate and retain their stated allocations.

`WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md`, line 84, explicitly charges hT rounded additions and rejects an exact-accumulation shortcut. Its main theta128 aggregate is 7,969,016,316,193 such additions (line 96). Here h is the number of present parity channels and T is the Gaussian-term upper schedule summed over frequencies. The script `small_family_theta_inventory_20261111.py`, line 122, records `bucket_additions_upper=h*T`.

## Why the minimal-theta refinement still satisfies the budget

The refinement fixes C=44, Bpref=2*3^33 and n0=8192. Its epsilon(theta)=2^-80/(4*3^theta). Therefore

`u_bucket(theta)/u_bucket(128)=3^(128-theta)>=1`

for every selected integer theta in [64,128]. This is an exact algebraic comparison, requiring neither function evaluation nor interpolation of endpoint checks. One may retain the old smaller per-addition tolerance unchanged, or use the new larger allowance and the same l1 proof. If norm error is obtained by rounding coordinates separately, the existing conversion from coordinate error to complex norm remains required.

The minimal-theta script recomputes epsilon and the Gaussian seed budget but does not include u_bucket in its eight-entry `tolerances` dictionary. Its 239,968 direct rational tolerance comparisons concern exactly those eight recorded quantities. The bucket inequality above is a ninth, separately derived comparison; it must not be represented as an additional executed test in that frozen receipt.

The h and T values are unchanged because the selected N equals N128, X and n0 are fixed, and conductor/parity data are fixed. Thus every hT count, including the main aggregate above, is inherited unchanged. The six explicitly replayed aggregate categories in the minimal-theta script were not intended to delete other retained categories. The corrected claim is that this schedule includes all earlier rounded bucket operations and their complete error allocation.

Other unchanged final-rounding allocations from the backend are also not entries in that eight-entry dictionary. The prefactor-product allowance epsilon/(32C) and time-output rounding epsilon/16 only increase when theta decreases; the final Y-product allowance tau/4 is fixed. The omega allowance epsilon/[16N(2Wbar^2+2)] also only increases: for Wbar=A/theta and fixed N, a unit increase in theta changes the relevant ratio by at least 3theta^2/(theta+1)^2>1 in the decreasing-theta direction, for theta>=64. This observation preserves those inherited requirements; it does not add any new executed checks or claim optimal precision.

## Scope and pins

This is a wording correction and explicit preservation of an existing budget, not a successor algorithm. No parameter, selected tilt, loop count, script, receipt, or frozen dependency changes. No evaluator or build was run for this clarification. The main note and this clarification must be read together in its independent review.

| Retained artifact | SHA256 |
|---|---|
|NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md|6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043|
|WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md|74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE|
|small_family_theta_inventory_20261111.py|4FD7D0F84E3057F74B7F151ABEA73A392739CEA48B12B0B04F1A3F71913A98C2|
|small_family_minimal_theta_20261111.py|0B0656A46461D397B9A459BEFEFC9686640FDCBC4EA5C6CD73E19BB2C3B1C5E0|
|small_family_minimal_theta_20261111.json|25E4BF80119B05A5C0FF25BDB7AECACEBC7495B5A00097B991E11C3DBF77D422|
