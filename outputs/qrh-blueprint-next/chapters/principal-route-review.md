# Independent review of principal finite completeness

Date: 2026-11-11. Research/source review only. No Lean build, zero search, historical count lookup, or frozen-package edit.

## Verdict and pins

PASS as a mathematical certificate design, conditional on the explicitly listed analytic and evaluation bridges. No blocking error found. In particular, the elementary phase proxy is sound and can be used for a bounded 1069-sign experiment through height 1500. This review does not certify any sign file, a total count, or finite RH in Lean.

Reviewed `mellin/PRINCIPAL_COMPLETENESS_ROUTE_2026-11-11.md`, SHA256 `AC1FA5C0308D24C9CB19FEBF6A2C231B42C6E25113E534D4C23FE62E4CE2D92C`, and `principal_completeness_sizes_20261111.py`, SHA256 `64930AC92EFA60C47F58A52BD1C414A340468D907C094F340FB68156176A19C4`.

Re-read the underlying analytic-count note, SHA256 `4648E4C454F4344D4F110E878F6CF619F5AC2128CAC91C2658E443FA3D1DF303`, and its independent review. The exact scalar script exited 0 in this review, with output saved as `principal_completeness_sizes_review_20261111.log`, SHA256 `8A8B02A53851F75428645244CAA87CB250F1074D89C71F6FD9C7710BC147CCAC`. The script's imported rational helper was inspected, SHA256 `EE27337A4AFCC800AF92C678F7E1762A47909ACC9F6084B6CEF6361C1A023C4A`. Its older printed spectral implications are suppressed and are not premises of this new sizing calculation.

## Hardy normalization and the phase shortcut

Direct source checks at pinned target commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`:

- `Explicit/Xi.lean:19,24,28,56` defines xiF without the conventional factor 1/2 and gives reflection, the completed-factor identity, and nontrivial zero equivalence. SHA256 `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F`.
- `Explicit/XiPartial.lean:669` gives xiF conjugation. SHA256 `8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770`.
- `Xi.lean:132` expands GammaR as pi^(-s/2)*Gamma(s/2). On the critical line the Gamma argument has positive real part, so the factor is finite and nonzero.

For s=1/2+it, 1-s=conj(s). The two xi identities therefore make xiF(s) real. Also s(s-1)=-(t^2+1/4). If L is the analytic logarithm of Gamma on Re(z)>0 normalized on positive reals, exp(L)=Gamma gives

    xiF(1/2+it) = -(t^2+1/4)*pi^(-1/4)*|Gamma(1/4+it/2)|*Z(t).

The real factor is strictly negative. This proves Z is real; its continuity follows from the analytic factors and absence of the zeta pole on this line. The missing conventional 1/2 has no sign or zero effect. These statements require the normalized analytic Gamma logarithm, not a pointwise principal log of Gamma values.

Re-expanding the stated Binet identity gives the two corrections to theta0,

    (t/4)*log(1+1/(4t^2)) + (1/4)*atan(1/(2t)),

plus the imaginary remainder. For t>0 the corrections are nonnegative and at most 3/(16t); the Binet integral has norm at most 1/3 because Re(z)=1/4 and its kernel lies in [0,1/12]. Consequently |theta-theta0|<=1/3+3/(16t)<.347 for every t>=14. This is a valid extension of the previous note's use at t>=1500: neither the Binet domain nor these estimates impose that higher threshold.

For real Z,

    Re(exp(i*theta0)*zeta) = Z*cos(theta0-theta).

The elementary inequality cos(x)>=1-x^2/2 gives a strict lower bound greater than .939 from |x|<.347. Thus the proxy V has exactly the same signs and zeros as Z on the whole interval. A positive or negative certified real enclosure for V is sufficient. Bounding a computed imaginary part close to zero is neither used nor sufficient for Hardy realness.

## Independent total count and horizontal argument

The existing analytic-count derivation fixes N(T)=1+theta(T)/pi+S(T) by the argument principle and xi symmetries, not a finite-count calibration. I checked its normalization: on the path P from 2 to 2+iT to 1/2+iT, the continuous endpoint arguments of s and s-1 sum to pi. Gamma and pi-power contribute theta, and zeta contributes pi*S. The four reflected/conjugated boundary pieces have equal xi argument variation; the enclosing rectangle counts 2N(T). Hence the factor and +1 are correct. Real-axis zero exclusion and analytic multiplicity transport remain explicit analytic proof obligations of this formula.

On Re(s)=2 the absolutely convergent Dirichlet series gives Re(zeta)>=2-zeta(2)>1/4. Separating n=2 and bounding the strictly decreasing tail from n=3 by integral_2^infinity u^-2 du proves the last inequality. Thus the initial vertical argument remains in the right half-plane and equals the principal endpoint argument; no unknown integer is carried up the vertical segment.

For each horizontal panel, rotating its entire image into Re>0 gives one analytic principal-log branch on that panel. The difference of endpoint imaginary logarithms is its actual continuous argument increment. Adding increments is valid even when successive panels use different rotations. Adding unadjusted principal endpoint arguments would not be valid. Actual endpoint enclosures inside both incident half-planes support the overlap and interval evaluation. Arbitrary rational winding-polygon vertices do not by themselves supply these zeta endpoint enclosures.

Nonvanishing of the path covers the right half of the critical strip, including beta=1/2. Reflection and conjugation send a hypothetical left-half zero at ordinate T to a right-half zero at that same ordinate. Hence no nontrivial zero is on the full top boundary; this justifies the closed count and avoids half-weight conventions. Moving T requires recomputing this certificate and matching all sign intervals to the new endpoint.

The count-phase enclosure is F(T)+S(T)+[-1/8,1/8] for T>=1500. The example widths give total width less than .51, but width less than 1 alone is not an acceptance test. The required ceil(lower)=floor(upper)=M check, together with the analytic containment theorem, identifies the unique integer. If that test fails, a midpoint round is not a substitute.

For the proposed six quarter-unit top blocks, centers range from real part 5/8 to 15/8. Radius 1/2 therefore keeps Re>=1/8 and |s|<=T+3, |s-1|>=T-1/2. The source zeta-growth inequality gives the claimed bound 8*(T+3)+2 at T>=1500. The source is `ZetaGrowth.lean:177`, SHA256 `ED2158522FECDF70720AF464B28DE6E101666A3ED6AB7568729A5A8EA591E9E4`. This only supplies an outer analytic bound; it does not guarantee a nonvanishing panel cover or successful argument precision with 384 evaluations.

## Completeness and compression

M pairwise disjoint open brackets with strict opposite signs of continuous V produce M distinct critical-line zeros. Endpoints may be shared because their values are nonzero. Each zero has positive analytic multiplicity, and the independently counted complete carrier has total multiplicity M. Equality excludes every extra zero and every extra unit of multiplicity. This proves simplicity as a consequence, including exclusion of even-multiplicity zeros missed by sign changes. No Gram-law, spacing, local uniqueness, or derivative-sign premise is needed.

The height-14 exclusion and top nonvanishing are still necessary to cover the closed target interval without omitted boundaries. The count N(T) must count all nontrivial positive-ordinate zeros with actual multiplicity, not only line zeros. The height-1500 count certificate cannot itself supply critical-line location or calibrate an unproved count formula.

Compression is sound for an ordered list of certified nonzero signs that contains both 14 and T and has exactly M sign changes. Maximal constant-sign runs number M+1; keep one point per run while keeping 14 and T in the endpoint runs. For separately supplied brackets, signs at the merged ordered endpoints must first be certified. Any additional transition across a gap would force a new distinct zero and contradict the already matched complete count. Unknown signs cannot be discarded using this argument. Compression says nothing about how many search samples or how much precision are needed to find a successful list.

## Two-sided sizing and limits

The selected earlier theorem (C) is only an upper bound. The new note correctly supplies the missing argument for a lower bound. At heights off all zero ordinates, the absolute bound for S and the absolute Binet error give |N-F|<5*log(t)+20. Entire nonzero xiF has only finitely many zeros in any bounded closed strip. For any fixed closed height t, some epsilon>0 therefore has no zero ordinate in (t,t+epsilon), so N(u)=N(t) on that interval, including zeros exactly at t. Let u decrease to t and use continuity of the majorant to obtain both non-strict inequalities at t. Merely knowing N(t)<=N(u) would establish only the upper side; the new local constancy is the needed stronger fact.

The replay confirms 1747057<=N(1000000)<=1747234 as analytic sizing bounds, not an exact count. A successful compressed chain would therefore have between 1747058 and 1747235 samples. The 3999944 quarter-unit blocks, 255996416 point samples at 64 per block, RS main-sum length 398 at height one million, and product 695399530 are arithmetically correct. They do not bound adaptive discovery, low-height fallback, remainder evaluation, precision, or certificate generation time. An endpoint T'>1000000 would require updated sizing.

The proposal's warnings against indexed-zero, historical Rosser/Gram shortcuts and backlund_s count circularity are appropriate. This review did not repeat the separate FLINT implementation audit. It treats a certified zeta point evaluator as a distinct contract still requiring its numerical and analytic proof bridge.

The bounded sign experiment may proceed using the elementary phase proxy and the independent existing total count at 1500. A successful external result would provide new finite evidence only. Formal Hardy realness, normalized Binet, exact point enclosures, argument/count transport, strict signs and the global multiplicity comparison must still be implemented and checked before a Lean finite-spectrum conclusion is available.
