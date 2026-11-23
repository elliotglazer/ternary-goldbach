# Review of the finite-zero/source-limit join

Verdict: **PASS as a conditional paper transfer argument.** The final author note is `../zero-sum/ZERO_SUM_SOURCE_JOIN_2026-11-11.md`, SHA256 **600F627B397F7A8E83AE20578D8BA7A7C5EBEC536578EA5EC41D1E3AAC25ABDA**. It supersedes B94C9E9A only by making the principal vertical integral explicit. The argument does not need absolute convergence of an infinite zero series, a measurable selection of good heights, or an interchange of a limit and an integral.

No finite spectral assertion, smoothing estimate, global provider, or scalar major certificate is proved by this join. Their statuses remain unchanged. No Lean build, analytic-function evaluation, zero scan or native process probe was performed in this review.

## Carrier and source limit

I checked the actual definitions at `Explicit/ExplicitFormula.lean:298,302` and `Explicit/Datum.lean:81,85`. The inner carrier radius is exactly `T+3`, with strict rectangle sides; multiplicity is the natural cast of the analytic divisor on the outer ball of radius `2(T+3)` centered at 2.

For a nontrivial zero with `|Im rho|<=H`, the inequality `|rho-2|<H+2<T+3` holds for every `T>H`. Thus both the reference carrier at `H+1` and every later filtered carrier contain the zero, including zeros exactly at either ordinate endpoint. Conversely, the source classifications restrict filtered carrier members to actual nontrivial zeros: `ZeroSums.zerosRect_cases:159` for primitive nonprincipal characters and `ZetaZeroSums.zerosRectD_zetaF_strip:39` for zetaF. A real nontrivial zero is retained; only the complex number zero is split off.

`Datum.mem_zerosIn_of_zeroD:169` supplies the finite-order/support argument using entire analyticity and nonvanishing at 2. `ExplicitFormula.divB_eq_of_mem:384` then identifies the divisor values on the two containing balls. Applying `toNat` proves multiplicity stability, not just equality of distinct-zero sets. The possible zero-at-zero contribution stabilizes separately. No monotonicity of the good-height sequence is necessary because its lower bound `k+1` eventually exceeds H.

The signs were checked against `explicit_formula_gen:988` and `ZetaExplicit.explicit_formula_zeta_seq:122`. Write the finite full sum as `Z0+L+U` and `p=-L/z`. Its source limit gives

`-U/z -> R-p+(Z0+V)/z`.

Taking norms of this pointwise limit yields (2), then adding the primitive-to-coprime error yields (3). In the principal case, **V is the integral of hZeta**, not hIntD zetaF. The latter would include the logarithmic derivative of `s-1`. This was the only clarification requested; the final author note now states the separate principal definition and pole separation explicitly. ZetaF has no zero at zero or one, so no such zero is included in the principal low sum.

The finite high bound is also source-compatible. `ZeroSumGen.count_tail_windowG:121` counts both signs in radius-three windows throughout the open critical strip. Its proof requires H>0, `PolyDatum`, and the stated high-envelope hypotheses, not a critical-line condition. The selected cutoffs exceed 50 in any case. Replacing the high factor `z^Re rho<=z` by `z^Re rho<=z^theta` preserves every positive-multiplicity comparison and the E2g geometric constants. The old critical-line E1g/count_line_windowG argument is not being reused for the .555 low set.

## Measurability and the integrated join

The actual prime sums are continuous in twist by uniform convergence: `MajorArcs/ArcChars.summable_cP:30` gives the etaPlus norm majorant; `Helfgott/Decay.summable_etaStar:251`, together with the etaStar/etaU rewriting actually shown in `MinorArcs/BaseGap2:258-265`, supplies the etaU majorant. Multiplying by character values and oscillatory phases never enlarges those bounds. This uses the summability statement and algebraic rewriting, not the enclosing conditional base-gap theorem.

For each of the finitely many low zeros, the Mellin term is continuous in delta by dominated convergence with majorant `|eta(t)| t^(Re rho-1)`. The principal main term similarly needs the finite moment at 1. These are requirements on the actual smoothing, and their adapters remain to be formalized as the note says. A fixed-delta GoodSmoothing hypothesis alone does not establish joint delta continuity. Nor does a left-line bound establish its full-strip decay hypothesis: the source definition at ExplicitFormula:51 explicitly requires the strip `-1/2<=Re s<=3/2`. The note preserves these obligations.

Once `w=R-p` is measurable, the proposed radial truncation is valid also at b=0 or w=0. The set `|w|<=b` is measurable, and on its complement the divisor `|w|` is strictly positive. Directly, `|h|=min(|w|,b)` and `|w-h|=max(|w|-b,0)<=d`. It is immaterial whether h equals a zero-series limit. No measurability assertion about the good-height choices or vertical-integral parameterization is used.

All terms in the five-term tensor expansion are measurable and have the stated finite squared-norm bounds before Minkowski is applied. There is no circular assumption that the actual residual already lies in the desired product L2 space.

## Character weights and constants

The use of `(psi^-1).primitiveCharacter` matches `MinorArcs/Bombieri.sum_char_mul_S:78`. `norm_sq_gaussSum:135` gives exactly the eligible-conductor weight c, including the vanishing imprimitive cases. Applying `parseval_chars:27` to the unit-modulus standard additive character gives `sum_psi |tau(psi)|^2=phi(q)^2`; consequently the normalized weights sum to phi(q), not 1. This confirms the error-vector norm `d*sqrt(phi(q))`. Inversion preserves conductor. The existing finite conductor grouping supplies the same actual primitive counts a(c), with no new conductor saving.

The first product term retains the same-q bound `sum_q Tq*Sq`, and the Sq input retains the factor 49 from the star twist scaling. The remaining squared estimates are exactly `300000*10000`, `300000*.002`, `300000*.025`, and the stated weighted measure. Their chosen norm caps 55000, 25 and 87 are strict upper bounds. The finite-low product bound .0005 is an independent retained input; it is not inferred from ordinary second moments.

With d0=2e-15 and dstar=2e-12, the four additional terms sum to

`4175009/12500000000000000 = 3.3400072e-10`.

The resulting square is less than 4.357e-7. Adding the separate Astar<2.5e-7 input remains below 9.5e-7. All finite aggregate inputs were compared with `RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md` at its pinned version; their values and conditional status are unchanged. No monotonicity of an oscillatory zero sum is asserted when endpoint envelopes are used.

## Reproduction and remaining scope

The independent script `review_zero_sum_source_join_20261111.py`, SHA256 **B498AC55EBCEBCE9B137932E1FFEB500729770DDD98BB41CC7B7E7A8DBB4C226**, checked all 16 source/note hashes listed by the author and ten exact rational comparisons. Its receipt is `review_zero_sum_source_join_20261111.json`, SHA256 **8721E9CED0822BC3BF14619C7D8821ACC884B785DC278C1DBFB4BB684EF8A0DF**. It contains no special-function, FFT, or zero evaluations.

No further mathematical correction is required in the final note. The remaining work is the stated Lean implementation and the independently open spectral, provider, smoothing/Gram and finite-arithmetic inputs. This review accepts the join between those inputs and the mixed bound; it does not mark those inputs proved or weaken the final unconditional target.
