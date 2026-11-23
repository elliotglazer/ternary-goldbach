# Review of translated Hurwitz seed jets

2026-11-11. PASS for the paper derivation, finite shift and exact conditional cost counts. No correction to the author is required. The result is a new way to produce the fine seed enclosures from genuine coarse coefficients, not a completed seed producer or spectral certificate.

Reviewed author: `integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md`, SHA256 `861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895`. I verified that hash and all four input pins. The earlier P20 interface was reviewed in `REVIEW_R138000_HURWITZ_SEED_CONTRACTION_EFFICIENCY_2026-11-11.md`, SHA256 `CCA39412B798FA2A49AFD56755D67F527D745A8EB8EF43BB83D4CBCB2CD96201`. No prior artifact was changed.

## Differentiated remainder and domains

The actual function is f(alpha)=zeta(1/2+it,1+alpha), with normalized coefficients C_j=f^(j)/j!. Its identities follow by continuation from the absolutely convergent half-plane. For every real alpha on either segment, 1+alpha>=1; after P derivatives the Hurwitz series is absolutely convergent. The upper bound M_P=2(V+P)^P follows from the rising factorial bound and the first-term-plus-integral bound for the series. This does not differentiate the critical-line Dirichlet series term by term.

Apply Taylor's integral remainder to f^(k) through degree P-1-k, then divide by k!. The residual is bounded by M_P*delta^(P-k)/(k!(P-k)!), exactly as claimed. This is an estimate for each derivative, not merely the function value. Multiplying by |d|^k and summing k=0,...,19 gives a partial positive binomial sum bounded by M_P*(delta+|d|)^P/P!.

For the chosen left anchor, delta=1/(2D) and |d|<=1/(4D). The segments a to b and b to alpha remain in[0,1], including the first/last cells and either tie choice. No wraparound is used. Even fine anchors need no translation. At alpha=1 only the first20 old coefficients are consumed. Both signs of t satisfy the same bounds. The argument remains at fixed s=1/2+it; it supplies neither a complex-s panel bound nor a statement at the pole s=1.

The character factor is phi(c)/sqrt(c)<633. There is no additional division by phi(c). Thus the weighted derivative remainder has exactly the normalization1266/P! * [3(V+P)/(4D)]^P. All five band ratios are below15/16 for P27, P28 and P32. I independently verified their advertised shift bounds below2^-85,2^-90 and2^-110 respectively. The final P20 expansion still contributes its separate tail below2^-84. Adding both is necessary. The P24 calculation only demonstrates that this sufficient derivative envelope is too large in one band, not that actual P24 errors or every other P24 scheme fail.

## Finite shift and its errors

The increasing inner-index order uses the pre-update value of A_(j+1). The unpruned loop is the finite binomial translation. After a stage i, an omitted entry above i+19 cannot move far enough left in the remaining i stages to affect a final coefficient below20. The pruned count is sum_(d=1)^(P-1) min(d,20)=20P-210.

My exact symbolic check retained both the original coefficient index and the power of delta. Every consumed row equals binom(j,k)*delta^(j-k). A separate truncated-polynomial Horner construction gives the same rows. These checks pass for all three P values. They corroborate the general finite-loop proof, and yield330,350,430 stages per odd anchor.

The coarse coefficient uncertainty enters the final value by a nonnegative weighted sum bounded by sum eta_j*(delta+|d|)^j. With uniform coarse radius eta this is below2eta, hence below1266eta after the character sum. The max-norm shift-rounding recurrence is also safe: each stage increases previous error by at most1+delta and adds u_T. Since L_P<=430 and delta<=1/1024, its geometric amplification is below2. Evaluation contributes another factor below2, yielding2532L_P*u_T. The separate target Horner arithmetic contributes2532u_H.

The exact checks confirm the complete displayed alpha budget below2^-82 for eta=2^-100, u_T=2^-110 and u_H=2^-100, for each P. Those are required absolute contracts, not observed precision or automatically sufficient relative mantissa lengths.

In particular, a translated coefficient's analytic error can be much larger than the final displacement-weighted error. The fine-jet consumer must retain the individual differentiated bounds, or consume the proved weighted aggregate directly. It cannot label every translated coefficient with the coarse eta and invoke an unchanged uniform-seed contract. The author provides the required individual bounds and does not make that substitution.

Exact exponent scaling by delta is possible in a signed-exponent dyadic representation. Fixed-grid scaling may need rounding, covered only if included in the total u_T stage contract. Addition alignment, large coefficient magnitudes, numerator widths and proof serialization remain real costs. The final d is generally rational; rounding it requires the previously stated argument-error term. None of these costs is removed by counting a stage as a dyadic scale plus addition.

## Counts and decision supported

I recovered H=127989 and A=sum D*heights=717521408 from the pinned band metadata. P*A+20H independent coefficients suffice because no odd anchor uses alpha=1 as its left endpoint. The alternative P*(A+H) count is correctly identified as unnecessary extra endpoint orders.

For P28 the exact necessary count is20093159204, saving8610256896 coefficient slots relative to independent fine P20 seeds. It requires251132492800 shift stages, while the later P20 residue contractions remain unchanged. The P27 and P32 counts also match. These are coefficient slots, not independent special-function calls or complete proof costs.

The actual comparison C_extra(P)+C_shift(P)<C_odd20 is sound. Under a uniform slot/stage model it becomes c_seed/c_shift_stage>L_P/(40-P), giving330/13,175/6,215/4. High-order source coefficients can have different cost and magnitude, so this model is conditional. The P28 shift stages also cannot be subtracted from the saved original-P24 residue Horner stages as if both had the same price.

Reconstructing a midpoint once and sharing it among consumers is a valid DAG design. Recomputing it per residue would lose the stated cost. Coarse seed production, actual error proofs, stored operand widths, finite heads, conductor scaling, character transforms, interpolation and Turing completeness all remain separately required. No seed success, sign margin or end-to-end saving is inferred.

## Owned checks

`review_shifted_hurwitz_jets_20261111.py` SHA256 `9024915564FF50F7FDDC7093A9AAA838FCF1F66D20CD40718A6DAA63A33C74B4`.

`review_shifted_hurwitz_jets_20261111.json` SHA256 `5FD59DAF70F6B766E00FC95595AF320F5F8764C7F1E8A55E928DFAC6D7AC67CB`.

One exact integer/rational/symbolic run passed157 grouped checks. It imported no producer code and evaluated no Hurwitz values, roots, transforms, primes or zeros. No build was run. The author retained its own checks in tool output only; this review supplies a separate reproducible script and receipt.
