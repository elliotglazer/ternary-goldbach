# Termination limits of family sign saturation

2026-11-11. Paper analysis only. No scan, FFT, Lean build, dependency change or frozen-file edit was made.

The critical-line sign route is a sound stronger certificate, but it is not guaranteed to terminate from the selected beta<=111/200 premise. Ordinary disjoint sign intervals cannot account for allowed off-line zeros or excess multiplicities. The selected strategy already permits direct strip exclusion; this note does not identify an unsound change of target. It explains why direct exclusion needs to be an implemented acceptance path rather than an indefinitely postponed fallback.

## 1. The target and the three different claims

The current selected family target is: for every actual primitive character of each active conductor c, every nontrivial zero with inclusive height |Im rho|<=Hcert(c) has Re rho<=b, where

\[
 b=111/200,\qquad H_{\rm cert}(c)=\min(H_{p,\rm old}(c),10^8/c).
\]

The active manifest has150000 conductors and5,543,640,188 primitive characters. The final theorem is not allowed to retain this assertion as an extra premise; its actual evidence remains to be produced and formalized.

These statements must be distinguished:

* A certificate checker is sound: whenever it accepts a finite record, the selected finite-strip conclusion follows.
* A search eventually finds a certificate under specified analytic and approximation hypotheses.
* Such a certificate has actually been produced for the required character and height.

The reviewed Gaussian identity, alias bounds, root phases and arbitrary-height parameters contribute to the first two statements. They are not the third. Soundness of a sign-saturation checker does not imply that every true instance of the weaker strip target has a sign-saturation record.

This note uses the current minimum height, not the larger original-Hp target in the old rectangle strategy note. The original note's conductor-one Euler correction and the later minimum-height restriction are retained.

## 2. A precise obstruction to sign-only saturation

Let Cchi(T) be the closed total zero count with multiplicity and both ordinate signs. Let K be the lower count supplied by disjoint ordinary critical-line sign intervals, with an independently justified exact central contribution. Let U be a valid upper bound. The acceptance rule is

\[
                   K\le C_\chi(T)\le U<K+1.
\]

If the current method structurally misses an integer multiplicity D=Cchi(T)-K>=1, then U>=K+1. No increase in numerical precision can make this particular acceptance test pass without improving the kind of lower evidence being used.

### Multiple critical-line zeros

At a real-analytic zero of even multiplicity, the real Hardy function has the same sign immediately to either side. Ordinary opposite-sign bracketing cannot count that zero. At an odd zero of multiplicity m>=3, a small bracket supplies only the lower bound1. Disjoint intervals cannot each count the same zero, so the missing multiplicity is at least m-1. Finer sampling and more accurate values do not repair this limitation.

Exact multiplicity certificates can repair it, but they are a different input: lower derivatives must vanish exactly, and a derivative of the claimed order must be nonzero. An interval containing0 for a derivative is not a vanishing proof. The root-phase note states this distinction for the central point; it applies at noncentral multiple zeros as well.

### Off-line zeros that are permitted by the target

A zero at beta=.54 is permitted by beta<=.555. Its functional-equation reflection at beta=.46 is also permitted. Such zeros contribute to the total count but not to critical-line sign brackets. For a nonreal character, horizontal reflection within the same character uses both its functional equation and conjugation. Negative ordinates are transferred through the inverse-character channel; they are not discarded. A real character also has the usual conjugate pair of ordinates.

Thus a successfully saturated ordinary main sign list proves that all counted noncentral zeros are simple and on Re=.5. That conclusion is stronger than the selected strip. This is a strength of an accepted record, not a guarantee that the record can be found.

The following exact polynomial fixtures illustrate the logical distinction without asserting anything about actual Dirichlet zeros. Set delta=1/25 and

\[
 P(s)=((s-1/2-\delta)^2+1)((s-1/2+\delta)^2+1).
\]

Its four zeros are .54+/-i and .46+/-i, all strictly inside the permitted strip. It has real coefficients and P(1-s)=P(s). Yet

\[
 P(1/2+it)=(1+\delta^2-t^2)^2+4\delta^2t^2>0
\]

for every real t. For T>1 the total count is4 and the ordinary sign count is0. A right rectangle with left edge .555 has zero winding and accepts it immediately. Likewise `((s-1/2)^2+1)^2` has two double critical-line zeros and no sign changes; the cubic power has two order-three zeros, supplying two ordinary sign brackets for total multiplicity6. These are useful future checker fixtures, not counterexamples to GRH and not substitutes for arithmetic L-function evidence.

### Very close zeros and exact grid hits

Two distinct simple critical-line zeros can lie between consecutive grid points and give no net sign change across that cell. A fixed grid or a fixed minimum cell size has no completeness guarantee without a proven separation bound. For finitely many distinct simple zeros in a compact domain there is a positive minimum separation, but no effective value is supplied by the selected strip statement.

Fair refinement and increasing precision can eventually find brackets around every such simple zero, provided the evaluator converges and sample selection can avoid zeros. Requiring every preselected sample to have a strict sign can instead hang forever at a sample that is exactly a zero. The producer should allow unknown samples, change sampling locations, and accept only the selected strict brackets plus a total-count certificate. The central point remains separately handled.

These observations concern termination, not invalid acceptance. A complete count prevents a missed close pair from silently producing a successful record.

## 3. The auxiliary zone can obstruct saturation independently

Use the reviewed normalization

\[
 C_\chi(t)=G(t)+S_\chi(t)+S_{\bar\chi}(t),\qquad G=2\theta_a/\pi,
\]

in its almost-everywhere/closed-count form. Let A(t) count zeros newly added between T and t in both positive channels. Put

\[
 I_A=\int_T^{T+h}A(t)dt,\quad I_S=\int_T^{T+h}(S_\chi+S_{\bar\chi})(t)dt.
\]

If B is the sum of the two valid absolute integral bounds and W is the lower auxiliary weight from known intervals, then the exact excess of the proposed upper bound over the true base count is

\[
 U-C_\chi(T)=\frac{B-I_S+I_A-W}{h}.                                    \tag{1}
\]

Both terms in the numerator are nonnegative. An auxiliary zero of uncounted multiplicity m at gamma in(T,T+h) contributes m(T+h-gamma) to I_A-W. For example, if m>=2 and gamma<=T+h/2, then U-Cchi(T)>=1. Even a perfectly saturated main critical-line list cannot pass U<K+1 in that case.

An off-line reflected pair or an even-multiplicity zero can create precisely this missing auxiliary weight. Increasing h does not cure it automatically: for a fixed missed zero at gamma>T, its normalized missing weight is m(1-(gamma-T)/h), tending to m as h grows. Larger auxiliary-height Fourier parameters prove that values can be enclosed on a larger grid; they do not prove that those values supply the missing zero weight.

If all auxiliary zeros are simple, on the critical line and bracketed with sufficiently small intervals, then W can approach I_A. For the published logarithmic Turing allowance B(h)=O(log(c(T+h))), B(h)/h tends to0. Under those extra conditions a large enough h can provide a margin for saturation. Neither the needed auxiliary zero structure nor the existence of that margin follows from the finite .555 target below Hcert. The newer elementary Turing allowance must likewise be used with its actual growth and constants, not with an assumed useful margin.

A rigorous alternative is to obtain auxiliary lower weight from complex zero-count boxes, regardless of their real parts or multiplicities. A box in the positive auxiliary region with zero count m and upper ordinate v contributes the certified lower weight m(T+h-v). This uses a different producer and the same count identity. It can reduce a Turing deficit, but does not by itself make an ordinary main sign list account for multiple or allowed off-line main zeros.

## 4. Endpoints and what conditional termination can mean

The closed-count addendum is important: it permits the integrated upper inequality without requiring a nonzero top horizontal boundary. It does not make an uncounted zero at |gamma|=T disappear. If all main brackets are strictly below T and no endpoint multiplicity is supplied, such a zero leaves an integer deficit and prevents saturation.

A search may choose a rational T>Hcert and avoid its zero ordinates. This is valid only when the enlarged computation and its certificate are actually supplied. It must still include all zeros exactly at the original closed height Hcert. Selecting a top boundary below Hcert, or rounding Hcert downward, is not an adapter.

A useful conditional search theorem for the ordinary sign route would need at least:

1. Every noncentral zero through the chosen T is simple and on the critical line, and the exact central contribution is available.
2. No unaccounted zero occurs exactly at its open-list endpoint T.
3. Some auxiliary zone and lower-weight certificate give U<Cchi(T)+1 with a positive margin.
4. The value and integral enclosure methods can reach arbitrarily small valid errors, and the search fairly refines locations, analytic truncations and arithmetic precision.

Under these assumptions there is finite sign/count evidence and a fair search can find it. They are not proposed as new final hypotheses. Proving them uniformly would introduce stronger number theory than the selected target, so they cannot be silently used to claim termination of the full-family run.

## 5. Direct strip exclusion using the accepted polygon theorem

The fallback need not develop another winding-number proof. Reuse the accepted generic bridge:

* `major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md`, SHA256 `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B`.
* Its independent review `independent-feasibility/REVIEW_POLYGON_CROSSING_PROOF_2026-11-11.md`, SHA256 `F75647007C294E13132B984A0F6241B516D5113D789AECA922B4DA265A5E73F0`.

That paper proof identifies the exact rational polygon crossing integer with the source rectangle integral and hence with the actual zero count, including multiplicities. It uses `Explicit/RectResidue.lean:391`, `rectInt_logDeriv_mul`, at source commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The required factorization, side nonvanishing, center/radius conditions and divisor-to-multiplicity conversion are explicitly handled in the accepted proof. No new crossing convention is introduced here.

For each unresolved primitive nonprincipal character choose rational T>Hcert and form

\[
                    [b,2]+i[-T,T].                                    \tag{2}
\]

Use f(s)=the actual entire source L(s,chi), with no Gamma or root phase needed. The record must partition each side exactly once counterclockwise, provide shared rational image vertices including closure, and prove that each whole analytic panel image and both adjacent polygon vertices lie in its stated strict rotated half-plane. Endpoint samples alone are insufficient. The accepted exact crossing rule then gives its integer zero count. Accept zero count0.

This excludes every nontrivial zero with beta>b and |gamma|<=Hcert. It can succeed with multiple critical-line zeros or arbitrary off-line zeros to the left of b. It assumes neither RH nor simplicity. Existing source strip information or the explicit definition of the nontrivial-zero carrier supplies beta<1, so the right edge2 covers the forbidden part. For conductor1 use the entire source zetaF with its removable value at1, not raw zeta. The principal row still has its separate stronger low-zero requirements.

For a finite set of unresolved characters, the records can be batched but each factor's count must remain the count of that exact function. A sum of nonnegative factor counts equal to0 implies each count0. Directly multiplying many interval values can be poorly conditioned; the accepted strategy's factorwise polygon counts avoid assuming that a large product is well conditioned.

The existing actual-data precedent is `zero-sum/C3_RIGHT_RECTANGLE_PILOT_2026-11-11.md`, SHA256 `39024D30A685E6424EBDD8A11E4DC2236C5E00E2960C7D871C3E5E882305AC91`, and `moebius/C3_RIGHT_RECTANGLE_REVIEW_2026-11-11.md`, SHA256 `6FE3CD6106C81B1226CFE947C4F706B048CC80DD6EB6BE8A0A88ED63096FB205`. Its complete actual c3 rectangle [.555,2]+i[-33,33] had zero winding and independently checked whole panels. It certifies requested height32 externally, not Hcert(3), not another conductor, and not a formal implementation. It demonstrates this acceptance path without a critical-line sign list.

## 6. Honest limits of contour-search termination

Suppose the actual target-height zeros all satisfy the strict inequality beta<b. Local finiteness in a compact neighborhood then gives a positive spectral margin from the forbidden rectangle. It also permits a slightly larger top T>Hcert before any excluded nearby zero enters; a rational T can be chosen with nonzero horizontal boundaries. This is an existence argument, not a known numerical margin.

For a fixed zero-free closed boundary, continuity gives a positive minimum of |f|. Every boundary point has one of its real or imaginary coordinates bounded away from0 after a rotation in{1,-1,i,-i}. Uniform continuity, a finite cover and sufficiently accurate endpoint approximations therefore give a finite strict-half-plane record with shared rational vertices. A fair search over mesh refinements and convergent analytic enclosures can find it. The accepted polygon theorem then counts the whole empty rectangle.

The word convergent is substantive. Increasing floating precision while keeping a fixed positive analytic remainder does not necessarily shrink an enclosure to the true value. Fixed Euler-Maclaurin, alpha-Taylor or discrete-Cauchy truncation parameters may impose an error floor. A termination proof must allow their parameters to improve as well as subdividing and increasing arithmetic precision. The local accepted pilots do not establish this general producer-completeness theorem or an effective family-wide modulus of convergence.

The selected non-strict target permits beta=b exactly. Then the vertical side of(2) contains an allowed zero and strict half-plane certification cannot succeed there. Moving the side to b+epsilon only certifies beta<=b+epsilon and leaves an unproved sliver; finitely many such shifted certificates do not prove beta<=b. Moving left includes the allowed boundary zero and prevents zero winding. One needs additional exact evidence identifying such zeros on the boundary, with multiplicities and a justified factor-removal or equivalent local argument. Rational boxes shrinking toward b without an exact equality proof do not supply that evidence.

Thus the basic contour search is a semidecision for a robust strict-strip situation, not an unconditional terminating decision procedure for every true instance of the closed .555 target. This is a limitation of the available certificate scheme and evidence. It is not a computability impossibility theorem about this particular finite family of arithmetic L-functions.

There is a parallel height-boundary issue for counterexamples: a positive zero count in a box wholly contained in beta>b and |gamma|<Hcert gives genuine counterevidence to the target. A forbidden zero just above Hcert does not. A box straddling the exact height boundary needs extra location information before it can be labeled a target counterexample.

## 7. Complex cluster counts can certify the weaker strip

If a producer already has a total count, another valid lower certificate is a disjoint family of complex rectangles or disks wholly inside beta<b, with exact zero counts summing to that total. These boxes may contain several zeros and need not touch the critical line. Multiplicities are handled by the argument principle. With nonzero boundaries and complete containment in the enclosing counted domain, count additivity and nonnegativity exclude any unaccounted zero outside the boxes, including to the right of b.

If f=L is used on a large enclosing rectangle, any trivial zeros inside it must be included consistently in both the total and the boxes. Alternatively use the source entire completion with its own evaluated function identity. This bookkeeping cannot be replaced by labeling every counted zero nontrivial. The simpler right-rectangle method avoids most of this extra work because its domain is to the right of b.

This cluster option supplies a genuine weaker-strip certificate in cases that defeat line signs. It is not a claim that the boxes have already been produced. As with direct exclusion, exact beta=b cases need separate boundary evidence.

## 8. Concrete change to the next action

Keep two explicit acceptance types in the family manifest: `LINE_SATURATION`, which proves a stronger result, and `STRIP_EXCLUSION`, which uses a certified zero-free forbidden rectangle. Both return the same selected finite-strip conclusion. Retain a third unresolved status; an indefinitely refined sign list must not be reported as progress toward inevitable acceptance.

The next bounded implementation experiment should exercise the already accepted polygon bridge as a fallback, rather than only improve FFT value throughput:

1. Use the exact polynomial fixtures in Section2 to verify that ordinary line saturation remains incomplete while right-strip exclusion accepts, including the multiple-zero fixture. These are interface tests, not L-function evidence.
2. For an actual-function test, reuse one exact primitive label from the accepted conductor101 Cauchy/alpha block and complete all four sides of the right slab [.555,2]+i[999.875,1000.125]. The existing left-side block is not by itself a closed contour. Supply the two horizontal sides, right side, shared vertices and exact count; transport the negative slab only with the proven inverse-character/conjugation rule. This bounded slab test validates the fallback connection without launching the full family or pretending to cover [0,Hcert].
3. Before any full run, specify fair refinement of truncation parameters, precision, sample positions and top boundaries. Character records should distinguish a structural count deficit, a small numerical margin, a suspected boundary zero, and a completed certificate. None of those diagnostics alone is a theorem about actual zeros.

The full-family spectral evidence is still absent. The accepted evaluator and counting rules now define several sound routes to obtain it, but no available theorem guarantees that the ordinary critical-line sign route will terminate under only the selected .555 hypothesis. Implementing the weaker-strip acceptance path addresses that mismatch without adding RH or simplicity to the final theorem.

## Sources read for this analysis

Current selected files: `work/qrh-blueprint/CURRENT_STRATEGY.md`, `work/qrh-blueprint/next-synthesis/SELECTED_STRATEGY.md`, and the minimum-profile corollary in `major-constants/RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md`.

Frozen method files: `FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md`, SHA256 `740840E7576E988AF4C8F8053030BE59EB4EA18DE8C7E0D6B391BF7C9B1C5DEF`; its endpoint addendum, SHA256 `6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4`; `FAMILY_ROOT_PHASE_PROOF_PLAN_2026-11-11.md`, SHA256 `27B8ED6864E51BECEFA5402CC49E85B8A11F7F3BA620E7A7D1E6A682BBDD8C68`; and `RESUME_SPECTRAL_CERTIFICATE_STRATEGY_2026-11-11.md` with its separate conductor-one erratum. The older rectangle note's larger height is not reinstated here.

The accepted polygon proof, its review and the c3 pilot/review are pinned in Section5. All newly proposed producer, termination and cluster adapters remain paper-level work. No new mathematical premise is proposed for the final Goldbach statement.
