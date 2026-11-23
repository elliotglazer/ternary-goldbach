# Independent review of the finite-RH ladder replacement

2026-11-11. Verdict: PASS for the conditional source interfaces and exact scalar/coverage deductions in routes A and B, and the final section 6 Kadiri–Lumley alternative at the same conditional scope. This does not certify finite RH, replay the CHL/KL parameter computations, prove the cited analytic theorems in Lean/MM0, or establish a cost advantage. The fresh intermediate-coefficient Johnston proposal is outside this verdict.

The author report is `independent-feasibility/PRINCIPAL_FINITE_RH_LADDER_REPLACEMENT_2026-11-11.md`; its final pin is recorded below. I read the whole report, its scalar source, the actual finite Goldbach consumer, Johnston v2, corrected CHL v3 and Büthe v4 primary statements and relevant proof dependencies. I reran only the integer/Fraction scalar script, directing output to my own file. No prime or analytic-function evaluations, builds, source changes, or spectral computations occurred.

## Actual consumer and endpoint proof

`TernaryGoldbach/Helfgott/SmallCases.lean:21–45` uses a prime p in the closed interval [n-B,n-4] and binary Goldbach through B. Its existing B is 4*10^18. A replacement at smaller B requires a new internal parameterized helper; it cannot silently change the definition of `BinaryGoldbachInput` in `Statement.lean`.

For even B and odd n>B+3, n>=B+5, so y=n-B>=5 and x=n-4>=B+1. A prime in [y,x] is odd; n-p is even and lies in [4,B]. For 7<=n<=B+3, the original 3+(n-3) branch works. The terminal N=10^27 is even, so the actual largest odd target is N-1. Bounds through real N are sufficient without an extra interval above N.

Define theta*(t) using weight one for primes p<t, one half for p=t, and zero for p>t. For x>y, the difference has coefficient one on primes strictly between the endpoints and one half on either prime endpoint. Therefore positivity directly proves a prime in CLOSED [y,x]. It does not by itself prove the open-left conclusion (y,x]. The author now uses the sufficient closed conclusion. All integer-to-real casts and natural subtractions occur with positive established bounds.

The low-end patch correctly includes y=599. For y<=599, theta*(y)<=599 log599<4193, whereas x>=B+1 and the proved error budget gives theta*(x)>4193. Thus no separately enumerated low ladder or specific patch prime is required by this construction. A certified fixed-prime patch is an alternative, not an additional input.

## Primary-source gates

Johnston Theorem 3.2 gives the normalized theta error sqrt(t)log^2(t)/(8*pi) for t>=599 under its height condition. Its proof uses Proposition 3.1, whose finite-range initialization invokes RH through 3*10^12. That initialization is covered by route A's 9*10^12 certificate. Theorem 4.1's smaller displayed T condition does not remove its own bootstrap. No arbitrary interpolation in its coefficient table is justified. [Johnston v2, sections 2–4](https://arxiv.org/pdf/2109.02249v2).

Büthe Theorem 2 uses t>599, not t>=599. The repaired patch handles equality. Its finite lower-range and low-zero reciprocal-sum calculations remain proof obligations or must be replaced. A formal parametric theorem needs the smoothed explicit formula and all these subproofs, rather than an unchecked invocation of the published conclusion. [Büthe v4, Theorem 2 and Lemma 3](https://arxiv.org/pdf/1410.7015v4).

Corrected CHL supplies (x*(1-1/Delta),x] for the selected rows 55 and 60. Its exact height is 3000175332800. Required additional data include the actual multiplicity count N0=260000000 through T0=104537615 and the reciprocal-ordinate sum upper bound S0=21.98308. N0 is not merely an arbitrary upper bound: it is also subtracted in B1. Equation (9), parameter domains, density/zero-free/counting and prime-power estimates remain to be proved or certified. Its half-endpoint sum estimates retain the extra endpoint allowances. Rounded table entries alone are not a directed certificate; optimization need not be re-proved, but admissibility must be. [CHL v3, sections 2–5, equation (9), Table 2](https://arxiv.org/pdf/2103.05986v3).

All finite-RH interfaces must refer to every actual nontrivial zero through the inclusive consumed height. Positive-ordinate statements transfer to negative ordinates by conjugation; exclusion of real nontrivial zeros is a separate known zeta fact to include where needed. All count and reciprocal-sum expressions count multiplicity. A list of line zeros without completeness supplies neither the RH premise nor N0. Simplicity is unnecessary for the analytic implication, though a sign-saturation implementation may establish it as stronger evidence.

## Independent scalar and continuum checks

The script has 25 checks, all true on replay, and the saved objects are semantically identical. I inspected the finite positive exponential series and geometric remainder, the integer-power log comparisons, positive square comparisons and both rational row lengths. These are exact rational calculations, not sampled transcendental evaluations.

For J(t)=9.06*sqrt(t/log t)/loglog t, logarithmic differentiation with L=log t gives 1/2-1/(2L)-1/(L log L). At t>=599, L>6 and log L>1, so this is positive. The squared endpoint comparison at N therefore establishes the height condition throughout. E(t)=sqrt(t)log^2(t)/(8*pi) is increasing there. The replay gives

`2E(N) < 1529642615000000000/157 < 9.75*10^15 < 10^16-4`.

This also gives the low-end lower bound x-E(x)>4193. No monotonicity of x-E(x) is needed: x>=B+1 and E(x)<=E(N) suffice.

For route B, t/log t increases for t>e, so the Büthe condition through 10^24 follows from the endpoint comparison and T=3*10^12. The first gap bound is below B-4. For the next two ranges the strict scalar comparisons are

`(1.2*10^26)/10288400000 < 2*10^16-4`,

`10^27/76918400000 < 2*10^16-4`.

Together with exp55<10^24 and exp60<1.2*10^26, these cover the whole range with closed overlapping joins. The CHL prime is strictly greater than x-x/Delta and therefore greater than n-B. This is stronger than the closed interval required by the consumer. The first range uses the same y<=599 patch.

## Provisional formal interfaces and limits

The final author version adds Kadiri–Lumley Table 2 rows 46 and 59 at H=3.061*10^10. I checked these rows and the input list against the primary source, and independently checked six rational comparisons for the breakpoints 10^20 and 5*10^25, the Büthe seed height, and the two gap lengths at B=6*10^17. Both rational breakpoints strictly exceed their exponential thresholds. The source's strict x>x0 presents no gap. Rounded parameters still require directed certification, and density/free-region/counting inputs remain. The older Ramaré–Saouter comparison is background outside this bounded review. [Kadiri–Lumley v1, Theorems 1.1/3.2, section 3.3 and Table 2](https://arxiv.org/pdf/1407.7902v1).

The proposed direct-count simplification is valid without proving it is the smaller branch. At fixed parameters, adding the two count bounds C*N0 and C*(N(T1)-N0) cancels N0 exactly. More directly, apply the same per-zero bound to the whole low carrier and its conjugate, obtaining C*N_closed(T1). This removes the explicit N0/S0 data from that revised low bound. It does not establish the revised table margin. KL's text defines N with a strict height but also uses closed-height sums; formal work must use a consistent closed count, or derive its upper bound from the continuous analytic counting envelope by a right-limit argument. No assumption that T1 is not a zero is needed for that repair.

The necessary internal statements are: a complete actual-zero finite-RH property; a theorem producing the theta error uniformly on the stated real interval; positivity-to-closed-prime conversion for theta*; the finite-domain scalar bounds; and the binary/prime-window-to-ternary implication. CHL additionally needs typed admissible parameters, exact low-zero aggregates and the strict directed inequality producing each row. These are development interfaces, not proposed permanent final hypotheses or approved declarations.

The existing `BinaryGoldbachInput` implies `BinaryGoldbachUpTo B` for both proposed B by monotonicity. Alternatively, a newly certified smaller binary theorem can be consumed internally. Neither alternative licenses changing the final `Statement`, adding finite RH to its public hypotheses, or treating historical computation as a kernel proof. The large-range theorem and its nonprincipal requirements remain unchanged.

The published Platt–Trudgian height/count and core-hour figures are accurately described as historical computational evidence, not this workspace's certificate or a Lean/MM0 timing. [Platt–Trudgian, Theorem 1 and section 2](https://arxiv.org/pdf/2004.09765). A universal gap theorem removes the individual ladder-prime array, but its full analytic library and much larger complete principal certificate must be costed. No winner follows from the number of conductors or the scalar margins.

## Pins

All paths below are relative to the workspace unless explicitly identified as agent-local.

| Artifact | SHA256 |
|---|---|
| Author report | 6ED412B2F17E25FFCFA649C4D6F0F4C2169EC9F93258164FA00DF9D9ED6FD570 |
| Author `principal_finite_rh_ladder_scalars_20261111.py` | DE7D2030BC195F9887D265409506C909C1F0D6DA4F3D9E0F403232B978C0CD63 |
| Author scalar JSON | F03043BF58FC5E0F6F94405FC5FE262BE4863C0EABEFF969F064AF77909670BB |
| Own `review_principal_finite_rh_ladder_scalars_20261111.json` | 498E24553D47D43B17AFB82DA28F33AEFF57AF751D0A7378A8D8E801ED8553C0 |
| Own `review_kl_ladder_scalars_20261111.json` | 6A7CC865FC99C0BA1B642112EB4585C3F49498254822F4E90DC531330E752C48 |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean` | 61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359 |
| `work/ternary-goldbach/TernaryGoldbach/Statement.lean` | 3F61837D2C3A0DDE3A1997F05AF21C20C7FE6EE13E29891125495F6947596BF8 |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/Inputs.lean` | 5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83 |

Primary PDF versions and URLs, rather than local PDF byte hashes, identify the online source review. This review does not claim a full audit of every imported analytic proof in those papers.
