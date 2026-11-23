# Review of the high-conductor shared-height reduction

2026-11-11. **PASS for the fixed-beta .555 conditional paper argument and exact scalar certificate.** The revised heights satisfy all reviewed major-family and base-gap consumers. No finite spectrum, Lean implementation, or runtime saving is established. No correction to the final author note is required.

Author note: `zero-sum/SHARED_HIGH_CONDUCTOR_HEIGHT_REDUCTION_2026-11-11.md`, SHA256 **`E1B69EDF5B4F3EACD3A575EC23FCA360CE4C540753D8E38015F8F6FA5A6F34CF`**. Research paths here are relative to `work/qrh-campaign/agents/`.

The accepted profile keeps the old exact shared height for c<=100000. Above100000 it is50,000,000/c for odd c<=150000 and99,000,000/c for c divisible by4 with c<=300000. It retains the complete primitive family and beta<=111/200; it does not combine the height change with a real-part relaxation. All cutoff inequalities are inclusive, with no rounding down of these rational heights.

## Independent arithmetic evidence

I wrote and ran a separate scalar checker, without importing either producer script or any analytic-function evaluator. It exited0. Its15.7-second local elapsed time is a diagnostic of this scalar replay only, not a controlled comparison or a spectral/Lean estimate.

The checker verified all2415 stored conductor cells using stronger rational exponential bounds: the positive exp(1) polynomial through degree24, and the fractional exponent polynomial through degree20. It checked each new upper tail against the stored rational bound. It independently reconstructed primitive-character counts by divisor inversion of phi, rather than the producer's prime-power formula, and independently constructed the squarefree support through the Möbius divisor recurrence. Every active modulus satisfies the exact Gauss-weight identity sum c*a(c)=phi(q)^2.

It then reproduced all three new aggregate bounds exactly:

| Aggregate | Exact value reproduced |
|---|---|
| New high-conductor N energy | `10338958863784669627/100000000000000000000` |
| New high-plus / low-star energy | `836674143147024781473/8000000000000000000000000000` |
| New Aplus energy | `87753955642097904833/25000000000000000000000000000000` |

The fresh independent sums cover150000 active conductors and75000 changed conductors. They preserve the full all-character support, not just representative or large-weight rows. The independent script verifies the high-c base-gap inequality for every changed active conductor, the star-tail bound at330, and the complete Aplus, Astar, N, Ep and Astar+Cross comparisons. Its final square-root upper bounds use denominator10^14 rather than the producer's10^12.

The coarse `.0005` low mixed norm genuinely fails the combined cap; the replay independently confirms failure. The producer's original `FAIL_SUFFICIENT_SCALAR_BUDGET` receipt is preserved. Final acceptance uses the separately reviewed **direct** low `Cross<1e-9`, hence norm<.000032. I read `zero-sum/RESUME_FAMILY_MIXED_2026-11-11.md` section2 and `audit/RESUME_FAMILY_REVIEW_2026-11-11.md`; the latter independently accepts the actual plus-L2 times star-Linfinity derivation and Cmix<6.794e36. I also rechecked its exact .555 power comparison. This is a previously established stronger bound, not a newly assumed result or an inference from L2 alone.

With that bound, the independent Astar+Cross upper is

`2468279641189897925886257482307341568004601 / 6250000000000000000000000000000000000000000000000`,

which is below3.949248e-7 and below the unchanged9.5e-7 cap. All other caps pass. I separately read the frozen postprocessor and its receipt; its formulas use the same stronger input and preserve the failed coarse test rather than rewriting its status.

| Artifact | SHA256 |
|---|---|
| Producer aggregation script | `BB53DC83F67E4868CF360F4C44D978EE40655BA5C1D2D17D05D81B45CACFACCE` |
| Producer aggregation JSON | `4E4127E970120A5BB5441CF0AF3F419F6262F616C9FA9E715A70C1E8D91CCA1A` |
| Producer cell JSON | `7E4A7D78A90E7ABFB08B5486F8DB003A01DFF11DEC4DA1ABB3AB602DFAF11AC2` |
| Producer budget postprocessor | `F644E2EFAC56BA3291F65D2C71E14DF648235309A35664373738037A7C842545` |
| Producer budget JSON | `E6B14CAA53D6A30A08048773088D60B2D69ADCCC9A813698DBC0FF66AED1CBFA` |
| `prime-estimates/review_shared_high_conductor_scalar_20261111.py` | `80D6CCCBAF58231CCDAC754E1E3B14DDD720120AE4D3D9F85A08086390343D24` |
| Same-stem independent JSON | `88599379A953B8A02F30E5F498B9747D6C4FE8287C376D374FBB7FC7437F1D9C` |

## Tail, count and all-scale source checks

For changed c, the previous shared cutoff is exactly10^8/c because Hp_old>=1200 and10^8/c<1000; Hs_old=1000. Thus both actual new low cutoffs are the proposed Hnew. Old positive count/Gram bounds remain valid when re-applied to the smaller low sets. The signed zero sum itself is not claimed to decrease.

The exact source Gaussian condition is H-200>=max(10*pi*Dc,50). Both parity endpoints and all cell corners satisfy it. The actual plus representation is split at |2*pi*xi|=100, with outer support through200. Its masses remain3.5 and.00625. In each band the count windows are based at H, not H-100 or H-200; only the Gaussian argument is shifted. I read `EtaPlusMellin.norm_mellin_fP_tail` and its floor-index proof, and the generic `ZeroSumGen.count_tail_windowG` and E2g expression. The separate two-band application is the same reviewed proof as in the common-height packet.

The new minimum330 is below the old common-height report's1000/3. This is not ignored: the author supplies a direct BP logarithm bound below228, using H<1000 and c<=300000, and log(10/3)>1. The actual polynomial definition has the claimed9th/10th powers and constants. The coefficient c3g is4.4*kappa/(H log(10/3)); kappa<=12 gives<53/H for every H>0. The source count theorem itself requires only positive base height, so there is no remaining hidden1000/3 restriction. The earlier cutoff proof also covered smaller heights. The star tail is freshly checked at330 rather than transported from an inapplicable old endpoint.

Cell corner directions are correct: D is maximized at lo, H minimized at hi, GB and GA increase under these replacements, EB decreases past50, and the EA scalar decreases for its ratio>=10. Replacing pi by22/7 lowers that ratio and increases the EA bound. The caps at2000 and40 likewise enlarge the decreasing envelopes. Positive Taylor lower bounds for exp become upper bounds after reciprocation; every stored rounding is upward.

The high tails include all multiplicities and both ordinate signs, in every finite explicit-formula carrier. The low range includes equality |gamma|=Hnew, and the complementary high range is strict. The removed band is charged to global QRH, never to an unproved extension of the finite .555 strip. The established good-height limit then applies. This is a conditional paper use of its analytic/source bridges, not a new Lean validation of them.

For each q, new complete high energy is bounded by old whole-family high energy plus fresh affected-conductor energy. This deliberately overcounts old affected tails; nonnegativity makes it valid. The mixed sum uses the same modulus and the two independent character indices. Its low-star coefficient still uses the old positive count proxy and the physical49 dilation. The Aplus factor retains mu(q)^2/phi(q)^2 in addition to the inner Gauss weight. It does not remove the even-conductor high tails from N or Cross.

The four residual tensor terms include star error times the enlarged high-plus norm through sqrt(300000*NT). Omitting or retaining the old87 bound there would be unsafe; the new formula includes the correct larger factor. Vertical, zero0 and prime-removal terms do not change with this nontrivial-zero cutoff. The star total error remains2e-12 because its new tail is still below1e-18. All estimates remain uniform in x>=4.9e26: the positive low and high envelopes have decreasing powers of x or y=x/49, while the source twist ranges stay fixed. No monotonicity of actual oscillatory sums is used.

## Every affected consumer and its cutoff

The review checked more than the major L2 upper bound:

* **Aplus, Astar, N and Cross:** all new complete errors fit the old consumer caps, using the direct low mixed bound just described.
* **Ep and lower J:** conductor1 and its principal tail are unchanged. The same local principal residual implies `(2.94-.00020001-1e-9)^2>8.6296`. The separate upper-J<=10 bridge still has its Ep/N inputs. There is no J circularity in the new tail estimates.
* **Base-gap pointwise etaU:** its actual cutoff remains `Hb(q,U)=max(250,ceil(242U/(7q)))`, with U<=1200000. It is not lowered to Hnew. For each nonzero-Gauss supported primitive conductor, qt(c)<=2q. Thus odd c<=q gives `c*Hb<=max(250c,290400000/7+c)<50000000`; even c<=2q gives `c*Hb<=max(250c,580800000/7+c)<99000000`. The strict comparisons hold at the largest admissible c and preserve the ceiling. Old c<=100000 comparisons remain untouched. Hence the complete dynamic low carrier remains inside the new inclusive finite certificate.
* **Base-gap tail/continuum and exceptional denominators:** because Hb itself and the physical twist are unchanged, the existing3e-14 primitive base-twist remainder,13/8 transform bound, both noncoprime errors and exact Gauss weights stay applicable. The q=1,2,3 prefix/high-branch overlaps are unchanged and involve only small conductors. The all-y comparison with ghatY remains the same conditional source join.
* **Principal prime and minor-energy estimates:** c=1 is preserved. The damped psi argument's shared height60343058, the finite RH/count head, and the actual-square minor-energy inputs are unaffected. This proposal does not replace any of those independent proof obligations.
* **Finite certificate geometry:** inverse characters have the same conductor and hence the same new height. Both signs, real nontrivial zeros and zeros exactly at rational Hnew remain included. The existing strict auxiliary carrier must still be chosen above Hnew. No floor(Hnew), omitted weak-weight row, or same-character reflection assumption is introduced.

The c<=100000 branch is exactly preserved, not just bounded below by a smaller number. The full active conductor family and final10^27/BinaryGoldbachInput scope remain unchanged.

## Pins, limits and interpretation

The source version is `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Fresh source hashes matched the author table: ZeroSumGen `9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389`; ZeroSumBound `A1294627F676EC49BED1BD86407A9460DC569B77AF8CBE8D65F1F49129BF17D4`; EtaPlusMellin `BA9CD4DFA03A6CB36482C52EB135C81D8BA3AD117510A96AF308B2D4FE8DD2BC`; HHFourier2 `B90303E4F7F4404F7587590A30982081EE026F74F307D866DF7443A9F3F38254`.

I read the current common-height source note/review, hashes `79833F8D5D5856E000A96D3F5CCA9FC9E26CB3BAF637CDE089FEFDD703436BA7` / `3536A5E362A7E72DB10A4DC909A972CECE2DD8E11BAA2F5B3DB1A1BDD90CAA87`, and the actual base-gap join `F0BC1D7899044C27E819743BBA4B157D51F42848B87A51D37764CDB8B3B6C9E0`. The direct low mixed source/review pins are `5E7FB33EDF2A65F058DC605A3054FE37DFDF14E9ACDCB8409A8211DCF1F9D09D` / `4FFC26AF43DA337652FC86167019328BB1D788379C0C84E43C7D8722A81ACF9C`.

The stated numerator barriers follow from the source applicability condition at the largest conductor:60m+12m*pi for even and30m+6m*pi for odd. They are limitations of this tail recipe, not impossibility results for other analytic methods. The optional character-weighted height proxy is only a proxy; this review's independent recomputation targeted the tail/count/budget certificate, not a separate re-enumeration of that optional proxy. No runtime, certificate-size or number-of-zeros conclusion may be drawn from it.

This pass is conditional on the existing reviewed smoothing/Gram/limit bridges and an eventual valid global provider and finite spectrum. It does not certify any new zero or implement the proposed profile in Lean. A simultaneous beta relaxation requires a separate combined-budget proof; the present pass is for beta=.555 only.
