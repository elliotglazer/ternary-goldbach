# Exact finite mass at a reduced major-arc cutoff

2026-11-11. Source/paper audit for the original finite-RH route. No finite sum, factor table, analytic function or spectral data was evaluated; no source was edited or built. The proposed tail replacement is valid. A still smaller source-based alternative already exists for cutoffs divisible by1000: reuse the existing exact integer mass checkpoints directly.

## Identity, endpoints and signs

Let U=150000, let R be a natural number with 1<=R<=U, and write

    m(q) = (if Squarefree(q) then 1 else 0)/phi(q),
    S(R) = sum_{1<=q<=R, q odd} m(q),
    M(R) = sum_{q in Qset(R)} m(q).

These are the actual definitions `MajorArcs/SumMuPhi.mPhi:20` and `Prelim/SmallMuPhi.S:160`, with `MinorArcs/LargeSieveArcs.Qset:34`. For q>=1 the totient is positive. `SumMuPhi.moebius_sq_eq:22` identifies the numerator with the squared Mobius value; its sign is always nonnegative.

`SumMuPhi.sum_Qset_mPhi:69–106` proves M(U)=2S(U). Its body generalizes directly to natural R: the odd part of Qset(R) is the odd integers1<=q<=R; the even part is the injective image q=2k of1<=k<=R. The actual identity `mPhi_two_mul:49–66` gives m(2k)=m(k) for odd k and zero for even k. Thus

    M(R)=2S(R).

This pairing does not require R even, although the currently selected search uses even R. It requires the actual q-tilde condition and floor(2R)=2R, not a replacement of Qset by every modulus<=2R.

The finite interval is a disjoint union, so

    T(R) := 2 sum_{R<q<=U, q odd} m(q),
    M(R) = M(U)-T(R).

The lower endpoint is strict. If R is odd its term remains in M(R), not in T(R). The upper endpoint is inclusive; U is even so its odd-filtered contribution is zero. For the current even cutoffs the first possible tail term is R+1 and the last is149999. At R=U the tail is empty. Missing, repeated or shifted records would invalidate the equality.

`SumMuPhi.sum_Qset_mPhi_bounds:108–112` supplies M(U)>=13.597558. This is a lower bound, not an exact value. Therefore any certified rational **upper** bound Tplus>=T(R) gives

    M(R)>=13.597558-Tplus.

An underestimated tail, or subtraction from an upper rather than lower full mass, has the wrong direction. The full mass need not be reevaluated. Its proof is purely arithmetic and does not use finite RH.

## Reuse already available: exact integer checkpoints

Set D=10^18. `SmallMuPhi.Lt:102` is exactly

    Lt(K) = sum_{1<=q<=K, q odd squarefree} floor(D/phi(q)).

`S_approx:163–202` proves for every natural K

    Lt(K) <= D*S(K) <= Lt(K)+K.

The file contains closed checkpoint theorems c_0 through c_150 for K=1000*k. For example c_135:488 concerns135000, c_138:491 concerns138000, and c_150:503 concerns150000. These are theorem statements backed by the source `walkS_spec` and the preceding closed `w_k` computations, not unverified decimal data. This audit reads their source; it does not assert a fresh build has checked them.

For any coarse cutoff R=1000*k, generic Qset pairing and the lower half of S_approx immediately give

    M(R) >= 2*Lt(R)/D.

This avoids both the logarithmic loss and subtraction from the rounded full-mass lower bound. It is the smallest new mathematical adapter for the coarse grid. A new tail factorization is unnecessary there.

If the tail interface is preferred, the same two endpoint theorems give

    T(R) <= 2*(Lt(U)-Lt(R)+U)/D.

This weaker but sufficient error uses S(U)'s upper bound and S(R)'s lower bound. Do not subtract two lower bounds and claim an upper bound for the difference. A local proof using the exact floor difference improves U to the number of odd terms in the tail (or safely to U-R), because each nonzero rounding deficit is below1. That improvement is a new elementary interval-sum lemma, not already the displayed S_approx theorem.

For a fine cutoff R between coarse checkpoints A<=R<A+1000, one can extend the existing checkpoint Lt(A) with a short verified `walkS A (Lt A) (R-A)` computation. `walkS_spec:128–157` then yields Lt(R). Its state covers A+1 through R, so it has the right inclusive endpoint. No full recomputation through150000 is needed. This note does not authorize or execute that extension.

There is a cost qualification: SmallMuPhi currently imports Mathlib and contains the whole checkpoint chain. Reusing c_k avoids new discovery and new tail data, but importing the current file still carries its existing declaration/import closure. It is not a measured zero-cost proof or a claim that a new clean build skips all preceding checks.

## A fresh compact tail certificate, if needed

For a standalone finite tail packet, the mathematical checker boundary can be small:

1. Bind R,U,D and the exact odd interval. Use an index-implied sequence or a checked complete partition; every required q has exactly one record.
2. A zero record supplies an integer d>=2 with d*d dividing q. This alone proves non-squarefreeness; d need not be prime.
3. A nonzero record supplies strictly increasing certified primes p_i with product q. This proves squarefreeness and, by the coprime totient product formula, phi(q)=product(p_i-1)>0. A partial factor list or an unproved prime label is insufficient.
4. For the denominator t=phi(q), an integer u_q with D<=u_q*t gives 1/t<=u_q/D. Exact ceil witnesses can additionally check (u_q-1)*t<D, but minimal upper-bound soundness needs only the first inequality and u_q>=0. Sum the integers exactly and double once: Tplus=2*sum(u_q)/D.

Alternatively floor witnesses v_q*t<=D<(v_q+1)*t give an upper bound2*(sum(v_q)+n)/D, where n counts all possible nonzero rounding errors; using the complete odd interval count is safe. This avoids a huge common rational denominator and has a transparent rounding budget. A claimed exact rational sum is also valid if every term and rational addition is checked, but is not needed for J/I.

The source already provides another trusted-proof route to each record: `phiTD:17–26` and `phiTD_spec:35–98`. The latter proves both the squarefree/totient result and the nonsquarefree alternative under its explicit no-smaller-prime-factor invariant. `walkS` establishes that invariant at d=3 for odd inputs and treats fuel exhaustion as failure. A new bounded certificate must preserve those conditions rather than infer totients from an external factorizer's output.

## Exact consumption by J and I

Write mlow for either2*Lt(R)/D or13.597558-Tplus. The already inspected generalized per-modulus estimate from `L2Major.Jq_bounds:100–104` gives

    J_R/x >= .638108*mlow - .00108 =: jfull,
    I_R/x >= (jfull-100001*8e-11)/1.00001 =: j.

The second formula is the actual prime-supported removal argument at `MinorTotal.I0_ge:277–316`. The multiplier .638108 is positive and the divisor1.00001 is positive. Consequently an improved lower mass can only improve these lower bounds. If two independently certified lower masses are available, their maximum is a valid lower mass.

All other uses must keep their own direction. The original mass upper bound13.59756, major error upper bounds and cardinal upper bound300000 can remain unchanged; a new lower mass does not improve them automatically. The singular Rankin tail22.1/R is a different sum and is not replaced by T(R).

In the minor budget the dependence is `G_Y(R)*(cl0*sD-j)`, with G>=0. Increasing j lowers the exact expression. When replacing G by an upper numerical enclosure, however, the resulting scalar coefficient must still be nonnegative. Recheck this guard for every finite cell and the asymptotic branch; improvement of j does not license dropping the sign condition. The original sig, all old chain/tail terms, final triangle factors, and nonprime subtraction remain unchanged.

No finite-RH assertion enters the finite arithmetic certificate. Finite RH is still needed for the analytic Jq estimate, with the same reduced conductor/height localization as before. This mass replacement neither proves those spectral inputs nor changes their heights. It provides one sharper scalar input without giant computation or a new analytic branch.

## Source pins and remaining work

Paths below are relative to `work/ternary-goldbach/TernaryGoldbach`.

| Source | SHA256 |
|---|---|
| `Prelim/SmallMuPhi.lean` | `7ECE1D48D9679ECF529A5566C79D06FADB3CA70CCAF057ADAA020D6AA390BADF` |
| `MajorArcs/SumMuPhi.lean` | `7AC4662598355DDA40720B43956223BD3C5456D503B206A77D48E4569ADE18A4` |
| `MajorArcs/L2Major.lean` | `8C9424D92074ABB35DF00273D598F5A3F95C49A34F07F4146DD83FD2B6F3A5FC` |
| `MinorArcs/MinorTotal.lean` | `6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742` |
| `MinorArcs/LargeSieveArcs.lean` | `0794C8853D9B1AA91EFEC3C9D91F5F1EFCECB98B484C701C360DD8EF5AC592BF` |

New formal work is the natural-R Qset pairing, interval difference/rounding adapter if the tail route is used, closed acceptance of any genuinely new short computation, and insertion of the chosen mass lower bound into the already required localized J/I and numerical interfaces. No new cutoff success or fresh certificate acceptance is asserted here.
