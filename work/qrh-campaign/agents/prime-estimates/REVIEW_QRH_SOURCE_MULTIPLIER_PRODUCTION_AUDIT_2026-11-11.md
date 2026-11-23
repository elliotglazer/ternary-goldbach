# Independent review: actual source multiplier production

Date: 2026-11-11. Verdict: **PASS for the bounded source and mathematical argument.** No mathematical correction is required. One citation location is corrected below. This is not a build, elaboration, transitive-axiom or complete QRH-provider validation.

## Frozen subject and method

Reviewed `../zero-sum/QRH_SOURCE_MULTIPLIER_PRODUCTION_AUDIT_2026-11-11.md`, SHA-256 `5CD375FB47C1E1203F062AA3AB1EBE98D92CEED94A0E07B8F372D96D72DCB5D9`. All seventeen source hashes in its final table match the current files. The OAI checkout is pinned at `4eaee87548250b2682affda7d05d947c05554bae`.

I independently read the actual local rational definitions, coordinate norm estimates, denominator arguments, normal-product proof, finite-exclusion construction and final consumer. I reconstructed the algebra and constants before comparing the frozen report. I also inspected the four relevant Mathlib analytic interfaces listed below. No Lean or numerical evaluator was run; no author or source file was changed.

## 1. The exact consumer and local factor

`Detector/FinalAssemblySource.lean:58` has the conjunction stated in the report: the actual excluded-prime coefficient mask, analyticity of `sourceCorrection eta S` on `7/8 < re(s)`, and its distance at most `1/2` from one. It assumes the actual `SourceExclusions S`; the existence of those exclusions is proved separately rather than incorporated as an arbitrary nonzero-multiplier premise.

`PrincipalSignalComparison.lean:336–353` specializes `globalClosedCorrection` at `w=1`, `z=1/6`. The local factor in `Detector/HighEulerRational.lean:25` uses the actual ideal coefficient, actual primary-generator phase, and `v=1`. The global index is one copy of each prime ideal outside S. There is no generator or unit multiplicity hidden in this index.

The report preserves the conjugation in the sixth-power angular phase. The norm estimates only require phase and character coefficient norms at most one, so zero coefficients are allowed. Supported-prime arguments are needed for identification with the principal-local expression; the numerical local bound itself does not divide by a character coefficient or assume primitivity, a real character, or a principal character.

The continued local expression has denominators `1-R`, `1-V`, and `1-D`, but no denominator `1-W`. Thus its analyticity is not being inferred from a raw quotient at a potentially singular point. The source certifies the required nonzero denominators before invoking the algebraic identities.

## 2. Independent cancellation and exponent check

With the report's coordinates, direct expansion gives

\[
 P_*+D=\frac{R((1-q)+(1-V)(W-D))-KV}{(1-R)(1-V)}
\]

and

\[
 F-1=\frac{D(V+W-VW)-VW+(1-V)(1-W)(P_*+D)}{1-D}.
\]

The cancellation of the first-order D contribution is essential. Applying triangle inequalities before that cancellation would not justify the claimed summable exponent.

For `Q >= 4`, `Re x >= 7/8`, `Re w >= 9/10`, and `Re z >= 4/25`, the coordinate decay exponents are respectively `24/25`, `221/100`, `9/10`, `7/8`, and `31/40` for V, R, W, D, K. Each of R,V,D is at most `Q^(-1/2) <= 1/2`. The four product exponents KV, DV, DW, VW are

\[
347/200,\quad367/200,\quad71/40,\quad93/50,
\]

all greater than `17/10`. Setting `T=Q^(-17/10)` gives the independently checked chain

\[
 |P_*+D|\le28T,\qquad (1+|W|)|P_*+D|\le56T,
\]

\[
 |F-1|\le2(3T+T+112T)=232T\le240T.
\]

This agrees with `CorrectionBounds.lean` and `GlobalRegion.lean`; no additional scalar assumption is used. The local bound holds on the stated closed real-part region. Analyticity in x is asserted on the open half-plane; this review does not promote the separately proved one-variable results to joint analyticity in three variables.

## 3. Summability and an actual uniform exclusion set

The source uses the nonnegative majorant `b(P)=240*absNorm(P)^(-17/10)`. `GlobalCorrection.lean:25` restricts `fullIdealWeight_summable_norm` at exponent `17/10` to the injective prime-ideal subtype. The full-ideal proof at `QuadraticSieve/DyadicColumns.lean:209` in turn uses an injective ideal-generator map and the lattice summability estimate with real exponent `-2*(17/10)<-2`. There is no prime-density, finite-zero or QRH premise on this route. Those lattice and ideal-generator facts remain lower source inputs, not newly proved foundations of this review.

The quantifier order of `exists_uniform_global_cutoff` is correct. A finite prime set F first makes the complementary sum less than `1/6`. Taking `N=max(4,sup_{P in F} absNorm(P))` then works for every S containing all prime ideals of norm at most N. Its outside-prime subtype injects into the complement of F, so nonnegative summation supplies the required bound. N is chosen independently of eta, S and all complex parameters.

`exists_source_exclusions` adjoins the finite small-prime set to an initial finite prime set containing the fixed bad primes. It retains primality and bad-prime inclusion. Enlargement only improves the complementary sum. This establishes existence, not an effective numerical cutoff or a bound on a resulting conductor. The optional joint cutoff with `FirstTail` remains a separate condition.

Citation correction only: `smallPrimeSet` is **defined at `Detector/PrincipalProduct.lean:102`**, with membership at :105; :111 is the following existence theorem. The author's mathematical description is unchanged.

## 4. A convergent product and a consistent analytic logarithm

For each factor, `|F_P-1|<=b(P)<=sum b<=1/6`. In particular it is nonzero and lies in the disk centered at one of radius `1/2`, contained in the slit plane. The principal complex logarithm is therefore one consistent analytic choice throughout the full open x half-plane.

The source estimates `|log F_P| <= (3/2)b(P)`. It proves absolute summability, obtains a `HasSum`, exponentiates it to a `HasProd`, and uses `exp(log F_P)=F_P` on finite products. Hence the displayed infinite product is the convergent product equal to `exp(sum log F_P)`. It is not relying on the default value of an unproved `tprod`.

The bound on the log sum is `1/4`. The library inequality `|exp z-1|<=2|z|` for `|z|<=1` then gives `|H-1|<=1/2`; in particular `|H|>=1/2`. For analyticity, the same summable majorant is uniform throughout the domain. The actual theorem `Complex.differentiableOn_tsum_of_summable_norm` derives locally uniform convergence and differentiability of the sum from these hypotheses. It is stronger than pointwise convergence and requires exactly the open-domain and uniform-bound conditions supplied here. Exponentiation and pointwise equality recover analyticity of the actual product.

The additional library inspection used the locally available Mathlib revision `56a005855ea17e0b0958f73ec801ae140b0a1679`. It confirms mathematical interfaces; it does not establish compatibility with the provider's separately pinned dependency revision.

| Mathlib file and interface | SHA-256 |
|---|---|
| `Analysis/Complex/LocallyUniformLimit.lean:171`, `differentiableOn_tsum_of_summable_norm` | `35ADD7BE2D223A47559B37C00ED2E523235B13A029DC5972969EC22AAF6C9CC9` |
| `Analysis/SpecialFunctions/Complex/LogBounds.lean:212`, `norm_log_one_add_half_le_self` | `1E405D6DF243BB02EE99D57443305943E2FDAAF16273E4EE30549DA32C4280BA` |
| `Analysis/Complex/Exponential.lean:441`, `norm_exp_sub_one_le` | `564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0` |
| `Analysis/Complex/Basic.lean:683`, `mem_slitPlane_of_norm_lt_one` | `ACEAA006FA6A7AF44C2C2777F47FCE2ABC42B0087CBCD4A3C98CEBE4CEFB0F35` |

## 5. Acceptance boundary

The reviewed construction supplies the actual analytic, nonvanishing multiplier and its contraction bound, uniformly in character and imaginary height, for every admissible exclusion set. It does not consume the desired seven-eighths zero-free conclusion or an improved sieve exponent.

The report correctly keeps H built from eta distinct from the signal L-function's character `eta.excludePrimes S`. The coefficient mask and principal-local identification do not by themselves establish the full physical high-series factorization, a low probe estimate, a high approximation estimate, or nonvanishing of the physical probe. Those remain separate source obligations. Ideal arithmetic, angular-factor bounds, lattice summability and library analytic facts are retained foundational inputs.

All seventeen author source pins were checked, plus the four disclosed library pins. This acceptance closes the selected multiplier source argument at paper level only. Compatible provider compilation, transitive kernel-axiom validation, downstream formalization and the finite-spectrum certificate gates remain open.
