# Review of the A-only star profile

2026-11-11. PASS at conditional paper, source-composition and exact metadata scope. No correction requested. Reviewed author `zero-sum/WSTAR_A_ONLY_REALLOCATION_PROFILE_2026-11-11.md`, SHA256 `657F88A8D9B2804527804384815612999E906A8DCB9604504F9D34C9CC4E96F8`.

The proposed squarefree beta<=.5357 condition suffices for the enlarged actual A allowance, assuming the retained analytic, principal and finite inputs. It supplies no location evidence for actual zeros. It removes a star-side spectral requirement for nonsquarefree conductors but does not reduce the current complete Tplus demand.

I read the full author note and scalar/metadata script, the independent cubic-reallocation review, and the original weighted-statistic definitions. I reused my independently reviewed floor300 and mixed-profile results. A separate read-only integer/Fraction calculation reconstructed the exponent inequalities, allocation, squarefree conductor/primitive-label counts and height/grid counts. It did not import or execute the author's script, regenerate a character transform, evaluate an analytic function, or run a build. Frozen files were unchanged.

## Support and actual weighted quantity

The statistic is the original Q_A, with weight sum mu(q)^2*c/phi(q)^3 over eligible q. Eligibility keeps the conductor divisor, squarefree coprime quotient and actual Qset condition. It is not an average over primitive labels or unit numerators. Inverse characters permute the full primitive family; both signs and all true multiplicities remain. No factor one-half is introduced.

If c is nonsquarefree then every multiple q of c is nonsquarefree, so each numerator mu(q)^2 is zero. A primitive conductor with exact 2-adic valuation one is excluded by the unit-group reduction modulo its odd part; a squarefree even modulus therefore contributes no primitive label. Thus the remaining nonprincipal conductors are precisely odd squarefree c>1 through R. For each, q=c and q=2c lie in Qset(R) and have squarefree quotients coprime to c. Their positive terms show that no such conductor can be deleted solely by this weight.

This support statement concerns A only. It does not delete nonsquarefree contributions from B or from the actual star residual. The replacement uses the separately reviewed direct bound B<1915, with its coefficient estimate and principal-only localization still required. The author correctly avoids inferring that direct B from the A support calculation.

## Exponent, threshold and uniform scale

Let Y=10^25. For beta<=5357/10000,

    Y^(2 beta-2) <= Y^-1 * 10^(357/200) < 61/Y.

The exponent follows from25*(2*.5357-1)=357/200. The final inequality is equivalent to61^200>10^357; I verified that integer comparison independently. It bounds each positive zero term, so the same comparison holds after summing true orders and nonnegative conductor weights. It neither pairs zeros nor assumes that a count upper bound locates them.

The saved floor300 baseline q0 is exactly1160130359892187791 divided by5*10^36. This is an upper bound for the weighted count divided by Y, not an unconditional upper bound on Q_A. The new finite location hypothesis is what gives Q_A<=61*q0. I checked

    (1e-5-8e-9)^2/(7e6)
      =1560001/109375000000000000000000,
    7e6*61*q0 < (1e-5-8e-9)^2.

With T_A<8e-9 the original inequality sqrt(A)<=sqrt(7e6*Q_A)+T_A therefore proves the strict A<1e-10 conclusion. The statement with a non-strict spectral threshold is safe because the remainder inequality is strict.

Every exponent2 beta-2 is negative. Replacing a later y>=Y by Y in its positive power term is consequently an upper bound. The finite carrier and its location condition stay fixed. The retained remainder proof is uniform in this unbounded scale, so the argument has no hidden upper bound on y.

The .5358 comparison is also described correctly. Here the analogous power is10^1.79, larger than308/5. The exact calculation7e6*(308/5)*q0>1e-10 shows that this particular count-upper-bound expression is too large. It proves neither a lower bound on actual Q_A/A nor failure of a .5358 theorem using a better estimate. The author's qualification is essential and sufficient.

## Floor300 tail and the full star residual

The reused floor300 proof applies on the full nontrivial strip0<beta<1. Its low-carrier Gram estimate, translated zero-count windows and high Gaussian tail did not require the narrower .5075 location. Raising the finite beta allowance to .5357 therefore changes the positive power statistic, not those analytic bounds. The exact height is unchanged, including the300 floor and the twist/height ratio. Restricting the nonnegative A remainder bound to squarefree conductors can only decrease it. Zero-at-zero, vertical and coprime-removal terms remain paid; the separately handled zero-at-zero term is not confused with a real nontrivial zero in the finite carrier.

My earlier floor review is `REVIEW_WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md`, SHA256 `422940369A04ED695A45EF28F20F154349932CEBC0242EEEE15FF3373D5CE6A4`. Its acceptance covers the high tail below5e-15 and complete per-character remainder below2e-12, with the weighted A remainder below8e-9. It does not permit arbitrarily lowering Hstar.

The cubic-reallocation review `audit/REVIEW_PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md`, SHA256 `AD993398C6E41DCCE3A9826C0FA5BF6DA89A3B0139672429D7BD61E797DE9F0E`, supplies the changed rho=5.12e-7 and moment allowance. I independently checked44.722 squared>2000,2.964 squared<8.79 and

    1.902e-6 + 1e-5 + 5.12e-7*44.722
       < 2.964*1.194e-5.

The1.902e-6 is already an integrated principal norm. The resulting bound concerns the full mixed Wstar, including principal and cross terms, through the existing Minkowski argument. It does not reuse the older, smaller Wstar-only allowance. The separate cubic-reallocation review verifies that the new Wstar and Wplus allocation together spend no more than the original cubic budget. Its direct-B implication and lower source hypotheses remain attributed to that review and its independent coefficient review; they were not reproved here.

## Metadata and demand union

Using an independently constructed smallest-divisor table, I summed prod(p-2) for primitive labels and prod(p-1) for unit labels at odd squarefree conductors. This reproduced53861 conductors and2532069219 primitive labels in total, including49806 and2517716220 above10000. The small-branch differences agree with the author. I also reconstructed all height ceilings, label-height sums, grid-node sums and the large-branch residue-input count11554576707360.

The largest squarefree Hstar is363700 at c=3. This is compatible with the earlier full-family maximum545549 at nonsquarefree c=4, which is absent from this A statistic. Above10000 every A height is300, so the hypothetical5/64 grid has3841 nodes. These statements do not certify those nodes or turn a real-part strip into a sign-grid theorem.

I read the author's reuse of the pinned character-circuit definitions. I did not independently regenerate the five G/A/Q/N/S operation totals in this review. Their role is only a hypothetical isolated evaluation schedule with the previously reviewed fixed circuit, not a proved weak-strip certificate or a cost saving. No analytic conclusion here depends on those operation totals.

For every remaining c, the plus condition is ordinary RH at a height larger than Hstar. Indeed its lower floor is460>300 and its positive coefficient23.3*3.1416 exceeds704/343. Integer ceiling monotonicity preserves the comparison. I checked the displayed heights for every squarefree conductor as a separate metadata test. Ordinary RH on that taller closed carrier implies beta<=.5357 on the smaller one. Hence removing this separate A demand does not lower the present global spectral union. Nonsquarefree conductors and the base-gap/principal inputs remain where the other consumers require them.

The claimed improvement is therefore a conditional simplification of the isolated A input. Actual spectral certification, complete finite carriers, true-order accounting, direct-B prerequisites, source localization and the full proof-system implementation remain open.

## Evidence pins

The read-only check verified the author pin and these four files in addition to the previously accepted floor-review dependency:

| File | SHA256 |
|---|---|
| `zero-sum/wstar_A_only_reallocation_20261111.py` | `815E1348E9D4C1AF39E5F6A185F5534A1C096C2A520E64EDB747F47E2595FAC5` |
| `zero-sum/wstar_A_only_reallocation_20261111.json` | `7C04E9D875083A922B6EE9689F4B74969F55C6C3B6E5B5620D825F63A3BD91D8` |
| `zero-sum/wstar_floor300_metadata_20261111.json` | `7750B7D1BB25A96D9B4F54A75C4090B9C7ECE591D905DEDC7D244FBA12CCDAD5` |
| `audit/REVIEW_PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md` | `AD993398C6E41DCCE3A9826C0FA5BF6DA89A3B0139672429D7BD61E797DE9F0E` |

Paths in this table are relative to `work/qrh-campaign/agents`. The integer/Fraction check ran inline and wrote no new certificate or author output. Its exact test expressions and independently reproduced counts are recorded above.
