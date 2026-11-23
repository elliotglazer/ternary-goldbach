# Translated zero mass from the actual digamma function

This is a paper proof and source map, dated 2026-11-11. No Lean declaration, build, spectral evaluation, prime calculation, or frozen artifact was changed. The new step is a justified passage from the Euler Gamma approximants to the actual logarithmic derivative of Gamma. Pointwise convergence of the approximants alone would not justify that passage.

The resulting bound, for every real c, is

    Re(logDeriv xiF (2+i*c))
      < 101/40 + (1/2)*log(1+|c|/2)
      < 3 + (1/2)*log(1+|c|/2).                         (1)

Consequently, for every real U and every finite S contained in `zerosRectD zetaF U`,

    sum_(rho in S) (multRectD zetaF U rho : Real)
      * (2-Re(rho))/((2-Re(rho))^2+(Im(rho)-c)^2)
      <= 3 + (1/2)*log(1+|c|/2).                       (2)

No RH, QRH, finite zero certificate, zero-count estimate, low-height exclusion, simplicity assertion, or restriction on c enters this result. Formula (2) is a finite-carrier statement with the original source multiplicities. It is not an assertion that an unproved infinite zero expansion may be differentiated or rearranged.

The source-order passage from (1) to (2) is proved separately in [FINITE_MASS_ORDER_TRANSPORT_2026-11-11.md](../zero-sum/FINITE_MASS_ORDER_TRANSPORT_2026-11-11.md), SHA256 `C62CB504C15A02CB954C35F8F5DAB5B551C483014F6FEE1F957FF37C444C5E0D`. Section 6 records precisely what is used from it.

## 1. Source status and the missing step

The source root is `work/ternary-goldbach/TernaryGoldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Mathlib is the checked local source at commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, physically under `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib`.

The existing `Analysis/SpecialFunctions/Gamma/Digamma.lean` defines `Complex.digamma` to be `logDeriv Complex.Gamma`, and proves `Complex.digamma_one = -Real.eulerMascheroniConstant`. It does not contain the real digamma series used below. `Gamma/Beta.lean` proves pointwise `Complex.GammaSeq_tendsto_Gamma`, but that theorem is not a derivative-convergence theorem.

The earlier translated-mass discussion in `mellin/RESUME_PRINCIPAL_2026-11-11.md`, SHA256 `950BD0EC1A67A9591626D5FA527867D127929E7A2028CD7B39A4C1438005F22C`, gives the desired real series without completing this formal join. The present proof supplies local uniform convergence and then uses an existing Weierstrass theorem. It avoids a new differentiation-under-the-integral theorem with a log(t) majorant, although that would be another valid route.

## 2. Local uniform convergence of the Euler approximants

For an integer N>=1, put

    G_N(s) = N^s * N! / product_(k=0..N) (s+k).

This is exactly `Complex.GammaSeq s N`, with complex power and the finite product over `Finset.range (N+1)`. For Re(s)>0 the existing theorem `GammaSeq_eq_approx_Gamma_integral` states

    G_N(s) = integral_(0..N) (1-t/N)^N * t^(s-1) dt.       (3)

Define, on the measure space (0,infinity) with restricted Lebesgue measure,

    q_N(t) = if 0<t<=N then (1-t/N)^N else 0.

The following facts, with these same endpoint conventions, are already established inside the proof of `approx_Gamma_integral_tendsto_Gamma_integral`:

* For t>0, q_N(t) tends to exp(-t). For all sufficiently large N, the indicator is one, and `Real.tendsto_one_add_div_pow_exp (-t)` gives the limit.
* For every N>=1 and t>0, 0<=q_N(t)<=exp(-t). Inside the interval use `one_sub_div_pow_le_exp_neg`; outside, q_N is zero.
* Each integrand is measurable, and its integral agrees with (3). The source proof uses `integrable_indicator_iff`, `Measure.restrict_restrict_of_subset`, and the conversion from an interval integral to an Ioc set integral. The endpoints have the same values or measure zero, as appropriate.

Fix real 0<a<=b. For all s with a<=Re(s)<=b and all t>0,

    |t^(s-1)| = t^(Re(s)-1)
      <= W(t) := t^(a-1)+t^(b-1).                        (4)

The equality is `Complex.norm_cpow_eq_rpow_re_of_pos`. For 0<t<=1 the first summand bounds the power; for t>=1 the second does. These comparisons require no bound on Im(s).

The real function exp(-t)*W(t) is integrable on (0,infinity). This follows by adding `Real.GammaIntegral_convergent` at a and b. Define the real, nonnegative error

    J_N = integral_(0..infinity) (exp(-t)-q_N(t))*W(t) dt.

Its integrands are measurable, converge pointwise to zero, and lie between zero and exp(-t)*W(t). Thus `MeasureTheory.tendsto_integral_of_dominated_convergence` gives J_N -> 0. To use its natural-number indexing without an N=0 exception, apply it to N=n+1.

Both complex integrands in (3) and the Gamma integral are integrable. Subtract their integrals and use (4) and the norm-of-integral inequality to obtain, simultaneously for all s in this strip,

    |G_N(s)-Gamma(s)| <= J_N.                            (5)

Here `Complex.Gamma_eq_integral` identifies the limiting integral with the source Gamma function. Equation (5), together with J_N -> 0, proves uniform convergence on the entire closed strip a<=Re(s)<=b. This is stronger than compact convergence and is independent of imaginary height.

For any s0 in the open set H={s : 0<Re(s)}, choose a=Re(s0)/2 and b=3*Re(s0)/2. The open ball of radius Re(s0)/2 about s0 lies in that strip. Restrict (5) to this neighborhood. The existing `tendstoLocallyUniformlyOn_of_forall_exists_nhds` now gives locally uniform convergence on H.

Every G_N, N>=1, is holomorphic on H. The numerator N^s is entire in s because N is nonzero; the factorial is nonzero; and each denominator factor s+k has positive real part. These facts use ordinary finite product and quotient differentiation. Therefore the existing theorem

    TendstoLocallyUniformlyOn.deriv

in `Analysis/Complex/LocallyUniformLimit.lean:154` applies on the open set H and gives G_N' -> Gamma' locally uniformly. The theorem's hypotheses are locally uniform convergence, eventual `DifferentiableOn` on H, and `IsOpen H`; all have just been supplied. `Complex.Gamma_ne_zero_of_re_pos` and continuity of division then give, at each s in H,

    G_N'(s)/G_N(s) -> Gamma'(s)/Gamma(s) = digamma(s).     (6)

This is the only derivative-limit passage in the proof. It is not inferred from `GammaSeq_tendsto_Gamma` alone, and no interchange of an infinite sum and a derivative is used.

## 3. The actual digamma series, with convergence justified

Finite differentiation gives

    G_N'(s)/G_N(s) = log N - sum_(k=0..N) 1/(s+k).       (7)

This calculation uses `HasDerivAt.const_cpow`, `logDeriv_mul_const`, `logDeriv_div`, and `logDeriv_prod`. Their nonzero-factor hypotheses hold on H. The logarithm of the positive real integer N is the real logarithm, embedded in C. No logarithm of Gamma is chosen.

Let v be any real number and subtract (7) at s=1 from (7) at s=1+i*v. The log N terms cancel exactly:

    G_N'/G_N(1+i*v) - G_N'/G_N(1)
      = sum_(n=1..N+1) (1/n - 1/(n+i*v)).               (8)

For every n>=1,

    1/n - 1/(n+i*v) = i*v / (n*(n+i*v)),
    |1/n - 1/(n+i*v)| <= |v|/n^2.                      (9)

The denominator has norm at least n^2, since |n+i*v|>=n. The majorant in (9) is summable by `Real.summable_nat_pow_inv` at exponent 2, after shifting the natural index to n+1. The comparison theorem `Summable.of_norm_bounded` proves absolute convergence of this complex series. Alternatively, apply it once to its norm to use `hasSum_iff_tendsto_nat_of_summable_norm` directly.

Now (6), (8), and uniqueness of limits identify the series with the actual digamma difference. The finite upper endpoint N+1 causes only a fixed shift of the partial-sum index; it is not an omitted first term. Since `Complex.digamma_one` is already proved from the source Gamma derivative at one,

    digamma(1+i*v)
      = -EulerGamma + sum_(n>=1) (1/n - 1/(n+i*v)).      (10)

Taking real parts gives

    Re(digamma(1+i*v))
      = -EulerGamma + sum_(n>=1) v^2/(n*(n^2+v^2)).      (11)

This operation is justified either by continuity of real part applied to the finite partial sums in (8), or by `Complex.hasSum_re` after (10). It does not assume an interchange theorem for a conditionally convergent series. Absolute convergence was established first. At v=0 every summand is zero, so this proof includes that case without division by v.

## 4. A uniform elementary real-part bound

For fixed v define, for t>0,

    f_v(t) = v^2 / (t*(t^2+v^2)).

This is continuous, nonnegative, and antitone. For example its derivative is

    -v^2*(3*t^2+v^2)/(t^2*(t^2+v^2)^2) <= 0.

For every integer M>=1, `AntitoneOn.sum_le_integral` with x0=1 and a=M-1 gives

    sum_(n=1..M) f_v(n) <= f_v(1) + integral_(1..M) f_v(t) dt.

The case M=1 has an empty remaining sum and a zero integral. A primitive on t>0 is

    F_v(t) = log t - (1/2)*log(t^2+v^2)
           = -(1/2)*log(1+v^2/t^2).

All logarithm arguments are positive. The finite-interval fundamental theorem of calculus gives the integral as F_v(M)-F_v(1). Since F_v(M)<=0 and f_v(1)<=1,

    sum_(n=1..M) f_v(n) <= 1+(1/2)*log(1+v^2).

Pass to the convergent partial sums from Section 3. Finally,

    1+v^2 <= (1+|v|)^2,
    (1/2)*log(1+v^2) <= log(1+|v|).

The existing `Real.one_half_lt_eulerMascheroniConstant` implies EulerGamma>=0. Inserting these inequalities in (11) yields, for every real v,

    Re(digamma(1+i*v)) <= 1+log(1+|v|).                 (12)

Only finite-interval integrals were used in the sum comparison. There is no additional improper-integral limit or integrability assertion hidden in (12).

## 5. The completed-zeta logarithmic derivative and its constant

Put s=2+i*c. `Xi.xiF_ne_zero_of_one_le_re` gives xiF(s)!=0. The source theorems `Xi.logDeriv_xiF` and `ZetaDatum.logDeriv_zetaF_eq` give exactly

    logDeriv xiF(s) = 1/s + 1/(s-1) - (1/2)*log pi
                     + (1/2)*digamma(s/2) + logDeriv zeta(s).   (13)

The first theorem requires Re(s)>0, s!=1, and xiF(s)!=0. The second requires s!=1 and zeta(s)!=0; the latter is `riemannZeta_ne_zero_of_one_lt_re`. All hold at Re(s)=2. Formula (13) therefore concerns the actual source xiF, not an unidentified completion or a logarithm with an unspecified additive constant. The source normalization differs from some traditional definitions of xi by a nonzero constant, which does not change its logarithmic derivative; (13) is used directly.

Here is a deliberately coarse bound on its last term. At Re(s)=2 the existing `ArithmeticFunction.LSeries_vonMangoldt_eq_deriv_riemannZeta_div` and `LSeriesSummable_vonMangoldt` imply

    |logDeriv zeta(s)| <= sum_(n>=2) Lambda(n)/n^2
                      <= sum_(n>=2) log(n)/n^2.          (14)

`LSeries.norm_term_eq` gives the exact norm n^-2; `ArithmeticFunction.vonMangoldt_le_log` supplies the second inequality. The n=0 L-series term is defined to be zero, and Lambda(1)=0, so neither contributes. This is the same norm-comparison method as `XiPartial.norm_logDeriv_zeta_le:247`, with exponent 2 rather than its coarser exponent 3/2.

For a complete bound on the right side of (14), f(t)=log(t)/t^2 is nonnegative and antitone on [2,infinity). Its derivative is (1-2*log(t))/t^3<0 there, since the existing `Real.log_two_gt_d9` implies log(2)>1/2. For every integer M>=2, the finite sum/integral comparison gives

    sum_(n=2..M) log(n)/n^2
      <= log(2)/4 + integral_(2..M) log(t)/t^2 dt
      <= log(2)/4 + (log(2)+1)/2
       = 1/2 + (3/4)*log(2) < 41/40.                  (15)

The primitive is -(log(t)+1)/t. Its value at M is nonpositive. The last strict inequality uses `Real.log_two_lt_d9`, in particular log(2)<7/10. The empty cases M=0,1 are zero. Thus nonnegative partial sums are uniformly bounded. `summable_of_sum_range_le` and `Real.tsum_le_of_sum_range_le` provide the summability and bound if (14) is expressed with a real tsum. One can instead take limits of the finite norm sums from the already summable von Mangoldt series. Neither version assumes the result of (15) as a numerical oracle.

Taking real parts of (13), use

    Re(1/(2+i*c)) = 2/(4+c^2) <= 1/2,
    Re(1/(1+i*c)) = 1/(1+c^2) <= 1,
    log(pi) >= 1,
    Re(digamma(1+i*c/2)) <= 1+log(1+|c|/2).

The log(pi) inequality follows from existing `ZeroFreeRegion.log_pi_ge`, whose unconditional proof gives 1.1447. To avoid importing that downstream file into a lower-level helper, derive only log(pi)>=1 directly from Mathlib's `Real.exp_one_lt_d9`, `Real.pi_gt_d6`, and `Real.le_log_iff_exp_le`: exp(1)<3<pi. No zeta or zero information enters that scalar fact.

Together (12)--(15) yield

    Re(logDeriv xiF(2+i*c))
      < 1/2 + 1 - 1/2 + (1/2)*(1+log(1+|c|/2)) + 41/40
       = 101/40 + (1/2)*log(1+|c|/2)
       < 3 + (1/2)*log(1+|c|/2).

Both strict gaps are uniform in c. In particular there is no large-height assumption and no separately patched range near c=0.

## 6. Exact multiplicities and the finite mass conclusion

The separately pinned transport proof establishes, for every finite S of strict-strip zeta zeros with true orders m(rho), and every sigma>1,

    sum_S m(rho)*(sigma-Re(rho))
      /((sigma-Re(rho))^2+(c-Im(rho))^2)
      <= Re(logDeriv xiF(sigma+i*c)).                    (16)

It starts from the existing `xi_partial_approx` at a finite bound containing both S and the evaluation point. The approximation supplies a square parameter T>0, inclusion of S, and error at most epsilon. Square membership itself places each selected zero in the required divisor disk. Applying `WeilBridge.divB_eq_of_analyticOrderAt_eq` and `analyticOrderAt_xiF_eq` then transports `multRectD` to the square multiplicities. It does not apply the stronger convenience lemma requiring T>=1.

Every omitted zero term has nonnegative real part because the source xi zeros have 0<Re(rho)<1. This includes hypothetical real strict-strip zeros. No low-height exclusion or pairing argument is needed. Letting epsilon decrease proves (16) by a real-order contradiction. The weights are actual analytic orders, not one per distinct point and not an assumed simple-zero list. The origin and the pole at one are excluded by the actual values xiF(0)=xiF(1)=1. A requested inclusive zero height can be put in a strictly larger auxiliary source rectangle.

Set sigma=2 in (16), then apply (1). This proves (2). The square on c-Im(rho) is unchanged when written Im(rho)-c. The empty S and every real U are allowed; nonempty source membership supplies any needed positivity of U inside the transport proof.

This join discharges the translated-mass input used by the P4-only coarse moment argument in `PRIME_CONSUMER_SOURCE_JOIN_2026-11-11.md`, SHA256 `B5F377CEED926B70B22E2539086D5C423D474A065D3E10F56D93C93108377B61`. It does not replace the sharper reciprocal-moment certificates needed by other consumers, or prove their finite spectral inputs.

## 7. Existing interfaces and the remaining formal work

All names below were checked in the local pinned source. They are existing interfaces, not proposed theorem names.

| Existing source | Interface and use |
| --- | --- |
| Gamma/Beta.lean:230,249,273 | `Complex.GammaSeq`, `GammaSeq_eq_approx_Gamma_integral`, `approx_Gamma_integral_tendsto_Gamma_integral`; actual definition and reusable indicator/DCT proof details |
| Gamma/Basic.lean:66,87 | `Real.GammaIntegral_convergent`, `Complex.GammaIntegral_convergent`; both endpoint majorants and complex integrability |
| Gamma/Basic.lean; Gamma/Beta.lean:454 | `Complex.Gamma_eq_integral`, `Complex.Gamma_ne_zero_of_re_pos`; actual limit and nonzero denominator |
| Pow/Real.lean:337 | `Complex.norm_cpow_eq_rpow_re_of_pos`; uniform imaginary-height bound |
| MeasureTheory/Integral/DominatedConvergence.lean:58 | `MeasureTheory.tendsto_integral_of_dominated_convergence`; measurable sequence, integrable majorant, a.e. domination and a.e. convergence are all explicitly supplied in Section 2 |
| Topology/UniformSpace/LocallyUniformConvergence.lean:233 | `tendstoLocallyUniformlyOn_of_forall_exists_nhds`; convert the strip bound to local uniform convergence |
| Analysis/Complex/LocallyUniformLimit.lean:154 | `TendstoLocallyUniformlyOn.deriv`; justified derivative convergence on the open half-plane |
| Pow/Deriv.lean:205; Calculus/LogDeriv.lean:89,94,104 | `HasDerivAt.const_cpow`, `logDeriv_div`, `logDeriv_mul_const`, `logDeriv_prod`; finite identity (7) |
| Gamma/Digamma.lean:47,50,56 | `Complex.digamma`, `digamma_def`, `digamma_one`; normalization in (10) |
| NumberTheory/Harmonic/GammaDeriv.lean | Existing Gamma derivative-at-one proof behind `digamma_one`; no reliance on the missing series |
| NumberTheory/Harmonic/EulerMascheroni.lean:169 | `Real.one_half_lt_eulerMascheroniConstant`; in particular the nonnegativity used in (12) |
| Analysis/PSeries.lean:324; Normed/Group/InfiniteSum.lean:111 | `Real.summable_nat_pow_inv`, `Summable.of_norm_bounded`; absolute convergence in (9) |
| Analysis/Complex/Basic.lean:601 | `Complex.hasSum_re`; continuous real-part passage, if not done directly on finite sums |
| Analysis/SumIntegralComparisons.lean:132 | `AntitoneOn.sum_le_integral`; exact finite sum indices in Sections 4 and 5 |
| MeasureTheory/Integral/IntervalIntegral/FundThmCalculus.lean:1148 | `intervalIntegral.integral_eq_sub_of_hasDerivAt`; continuous derivative on each positive compact interval |
| Topology/Algebra/InfiniteSum/Real.lean:89,99 | `summable_of_sum_range_le`, `Real.tsum_le_of_sum_range_le`; optional passage from (15) to the real tsum |
| NumberTheory/LSeries/Dirichlet.lean:435 | `ArithmeticFunction.LSeries_vonMangoldt_eq_deriv_riemannZeta_div`; actual zeta logarithmic derivative |
| NumberTheory/ArithmeticFunction/VonMangoldt.lean:152 | `ArithmeticFunction.vonMangoldt_le_log` |
| Analysis/Complex/ExponentialBounds.lean:83,86 | `Real.log_two_gt_d9`, `Real.log_two_lt_d9`; monotonicity and rational constant in (15) |
| Explicit/Xi.lean:40,142; Explicit/ZetaDatum.lean:222 | `xiF_ne_zero_of_one_le_re`, `logDeriv_xiF`, `logDeriv_zetaF_eq`; source completion in (13) |
| Explicit/XiPartial.lean:247,776 | Existing L-series norm-bound proof pattern; existing finite xi partial-fraction approximation |

The genuinely new formal lemmas are, in order: the uniform GammaSeq strip bound and its local-uniform consequence; the finite GammaSeq log derivative identity; the convergent digamma difference series; the real-part estimate (12); the elementary zeta logarithmic-derivative estimate (15); the combination (1); and the finite true-order transport already proved on paper in the companion note. These are proof obligations with complete arguments above, not additional assumptions on the consumer. Their elaboration, kernel checking, and transitive axiom audit have not been performed.

There is no new unresolved mathematical convergence or interchange step in this route. The remaining risk is formal implementation and source integration. A natural dependency order keeps the Gamma convergence and digamma lemmas Mathlib-only, adds the zeta estimate next, then combines them with `Xi` and the existing `XiPartial` transport. Re-proving only log(pi)>=1 from Mathlib avoids an import back-edge through `ZeroFreeRegion`.

## 8. Source pins

These SHA256 values bind the inspected files. Mathlib paths are relative to its `Mathlib` directory; repository paths are relative to `TernaryGoldbach`.

| File | SHA256 |
| --- | --- |
| Analysis/SpecialFunctions/Gamma/Beta.lean | `C166D25802EDF2883DB91226CFF7B5F5432BB9E8DCF1A0EDD88932D59C3E724C` |
| Analysis/SpecialFunctions/Gamma/Basic.lean | `924736ACB968C113FAF74DD1BE6D125C3BC67EBA9492A2965A043172A3D6A136` |
| Analysis/SpecialFunctions/Gamma/Digamma.lean | `B655A09AB766589BCD06D3430CF132AE991306CD0696819FE878485A350EA63E` |
| NumberTheory/Harmonic/GammaDeriv.lean | `3E7AF8EC14165D69D42003E929EAF0B007A1FEA31009D7A29FC2DC910628C9F3` |
| NumberTheory/Harmonic/EulerMascheroni.lean | `C8C780E787B6CABBACD9725A01D4707AC249DCC4BBE072AE1C2645E0500288FB` |
| Analysis/Complex/LocallyUniformLimit.lean | `35ADD7BE2D223A47559B37C00ED2E523235B13A029DC5972969EC22AAF6C9CC9` |
| Topology/UniformSpace/LocallyUniformConvergence.lean | `6E2A1871E1792CD18ABAA3C62B9C3B699CEBE5C39FD5AB5EB77DD98C7C3E51B2` |
| MeasureTheory/Integral/DominatedConvergence.lean | `7549EC24A64E6979304CA8883FDA00178452003FB8A7C54F90BA01310B4CBFE9` |
| Analysis/Calculus/LogDeriv.lean | `0065F998836BFF68A16C9E2908F207C291FEA2629ACEDC086D66FAE13919716D` |
| Analysis/SumIntegralComparisons.lean | `1730871A353CEB7203C68C96CCA1BB91809D634CA5ED0E67E16327F2F7711C8C` |
| Analysis/PSeries.lean | `0F91D19F174CA14C95168B2264862AAA5291C8AA7A8DF9E0AA76A0F9F7F4CAD2` |
| Analysis/Normed/Group/InfiniteSum.lean | `1E406AE108C0540A4E898833C43B4F257FC8662C00A8BCC3F3071A1D89471DF7` |
| NumberTheory/LSeries/Dirichlet.lean | `1CF383A7235B0A936689818238A1D2161D9ABA6CB6C812D1A659346B19DD3446` |
| NumberTheory/ArithmeticFunction/VonMangoldt.lean | `0F99C7B3411DD763CBD323492BECF817FEBD2448DC26F91C5AB065F125A0227D` |
| Analysis/Complex/ExponentialBounds.lean | `81912243C4328F7B626BAE92A660BEACDDA14DC8E6E1E014F054E59294F4F773` |
| Explicit/Xi.lean | `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F` |
| Explicit/XiPartial.lean | `8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770` |
| Explicit/ZetaDatum.lean | `F657B07B406241C98F2484641D867BEB63BCC792A56CA4D54CE0257BB20E50D5` |
| Explicit/ZeroFreeRegion.lean | `AC367CDA6777165DF4AF22BA1BA1530B8A280B77CA55F1918562376DE69C0EAB` |

Only source reads, source-name searches, and hashes were used for this note. Every scalar estimate is derived symbolically above; no numerical function output is an input to the proof.
