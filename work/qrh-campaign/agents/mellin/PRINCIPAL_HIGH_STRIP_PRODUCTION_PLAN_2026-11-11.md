# Producing the remaining principal strip certificate

Research plan, 2026-11-11. No high-zero scan, Lean build, dependency change, or frozen-file edit. The scalar script performs only exact arithmetic. The plan proposes evidence to generate and prove sound; it does not make an unfinished certificate a hypothesis of the final Goldbach theorem.

## Decision

Use a critical-line sign chain as the first production candidate. An accessible primary theorem now supplies a fast explicit evaluator for this route: Gabcke's corrected thesis gives finite Hardy-Z approximations with numerical remainder bounds. This avoids the unresolved Arias de Reyna Part I source-access gap. It does not make FLINT's different auxiliary-function implementation formally justified.

The required location assertion remains

\[
1500<|\operatorname{Im}\rho|\le10^6
\quad\Longrightarrow\quad .4968\le\operatorname{Re}\rho\le.5032.
\tag{S}
\]

The accepted external low certificate proves critical-line location and simplicity through1500, with N(1500)=1069. The separately accepted explicit-EM top count gives N(10^6)=1747146 with actual multiplicity and no zero on the top boundary. It now uses no RS evaluation. Its independent review is `independent-feasibility/REVIEW_EM_TOP_HORIZONTAL_2026-11-11.md`; the producer is `zero-sum/EM_TOP_HORIZONTAL_2026-11-11.md`.

Consequently, precisely **1746077 additional** disjoint strict sign changes on [1500,1000000] suffice. Equality with the total multiplicity count proves the stronger finite RH and simplicity there, hence(S). If this sign search cannot be completed, that is not a contradiction to(S): a multiple critical zero or off-line zeros within the allowed strip could defeat the stronger sign route. Keep direct contour exclusion as the second route.

## 1. Accessible explicit critical-line evaluator

Primary source: [Wolfgang Gabcke, corrected electronic edition of his 1979 thesis](https://d-nb.info/1072293277/34), equation3.26 on printedp53, Satz3.2.2(a) on printedpp54–55, TableIII on printedp98, and Satz4.2.3(d) on printedp72. The local PDF is `gabcke_1979_corrected_2015.pdf`, SHA256 `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`. The coefficient table was rendered and visually inspected. The author's new preface explains the corrected electronic edition.

Let a=sqrt(t/(2pi)), N=floor(a), p=1-2(a-N). Gabcke's finite approximation is

\[
Z_K(t)=2\sum_{n=1}^N n^{-1/2}\cos(\theta(t)-t\log n)
 +(-1)^{N-1}a^{-1/2}\sum_{k=0}^{K}C_k(p)a^{-k}.
\tag{G}
\]

For t>=200, the coarse theorem gives

\[
|Z-Z_K|<c_Kt^{-(2K+3)/4},\qquad
(c_0,c_1,c_2,c_3,c_4,c_{10})=(.47,.43,.77,.90,2.12,25966).
\]

This uses part(a), not the tighter decimal-series bounds in part(b). K is the last correction index. These are real Hardy-Z coefficients, not the complex auxiliary coefficients in the preceding RS bridge note.

The normalized phase can be replaced by

\[
\widehat\theta=\tfrac t2\log(t/(2\pi))-\tfrac t2-\tfrac\pi8
 +\frac1{48t}+\frac7{5760t^3}+\frac{31}{80640t^5},
\quad |\theta-\widehat\theta|<\frac1{3322t^7}\quad(t\ge10).
\tag{P}
\]

Its branch must be the analytic log-Gamma normalized real on positive real arguments. Principal argument of Gamma is not this branch. The source's asymptotic identity fixes the intended normalization. A formal proof must establish(P), not import a numerical Gamma call.

The finite correction starts with

\[
F(p)=C_0(p)=\frac{\cos(\pi(p^2+3/4)/2)}{\cos(\pi p)},
\quad C_1=\frac{F^{(3)}}{12\pi^2},\quad
C_2=\frac{F^{(6)}}{288\pi^4}+\frac{F^{(2)}}{16\pi^2},
\]
\[
C_3=\frac{F^{(9)}}{10368\pi^6}+\frac{F^{(5)}}{120\pi^4}+\frac{F'}{32\pi^2},
\quad C_4=\frac{F^{(12)}}{497664\pi^8}
 +\frac{11F^{(8)}}{23040\pi^6}+\frac{19F^{(4)}}{1536\pi^4}
 +\frac{F}{128\pi^2}.
\tag{C}
\]

The parent has assigned an independent audit of this transcription and theorem scope. The paper theorem is accessible, but its proof is not yet formalized. In particular, the proof's finite coefficient bounds and scalar inequalities must be reproduced with checked rational enclosures; decimal tables are not proof oracles. None of the historical zero computations mentioned in the preface is an input.

## 2. A sound point checker and its exceptional points

For exact rational t, the checker should:

1. Certify positive elementary-function intervals for pi, log n, square roots, a, and a^{-1/2}. Certify a unique integer N with N<=a<N+1. If the floor interval straddles an integer, increase precision or use a proof covering both branches with the correct cutoffs.
2. Evaluate the real finite expression(G), with theta replaced by(P), in outward rational intervals. Derivatives in(C) are derivatives, so multiply series coefficients by their factorials.
3. Add the analytic Gabcke remainder and the propagated phase error. Accept a sign only if the resulting closed interval is strictly positive or strictly negative.

The phase allowance is elementary. On our whole range N<=398, and

\[
2\sum_{n=1}^N n^{-1/2}\le4\sqrt N-2<80.
\]

The cosine Lipschitz inequality therefore bounds phase substitution error by 80/(3322t^7), which is <1.5e-24 already at1500. The correction in(G) is theta-independent; no extra phase factor is inserted there. This avoids the invalid shortcut of replacing theta by theta0 inside the real part of the complex auxiliary function.

The following scalar consequences are checked by rational fourth-power comparisons in `principal_high_strip_plan_sizes_20261111.py`:

| t | K=0 remainder | K=1 remainder | K=4 remainder |
|---|---:|---:|---:|
| 1500 | <.002 | <.000047 | <4e-9 |
| 1000000 | <.000015 | <1.4e-8 | <7e-17 |

At1500, K=10 has coarse error <1.5e-14. Increasing arithmetic precision alone cannot remove a fixed analytic truncation error. Begin with K=0 or1; escalate correction order when necessary, then use an explicit EM point fallback if the available Gabcke truncation still cannot certify the sign. No promise is made that this fallback occurs rarely.

The points p=+/-1/2 are removable, with F=1/2, unlike the complex auxiliary F in the previous note. A useful stable identity, derived directly from(C), is

\[
F(1/2+u)=\frac{1+u}{2}
 \frac{\operatorname{sinc}(\pi u(1+u)/2)}{\operatorname{sinc}(\pi u)},
\qquad \operatorname{sinc}(v)=\begin{cases}\sin(v)/v&v\ne0,\\1&v=0.\end{cases}
\tag{R}
\]

Evenness handles p near -1/2, with the appropriate sign for odd derivatives. For |u|<=1/4, sinc(pi u)>=1-(pi/4)^2/6>7/8. Thus analytic series division has a denominator bounded away from zero. A production implementation can use(R) with a certified entire sine-series tail and derivative bounds; it must not silently treat a truncated sinc polynomial as exact. Away from these neighborhoods, ordinary quotient differentiation with certified nonzero denominator is sufficient. Finite approximation jumps at a integer do not justify continuity claims about the approximation. Continuity is needed only for actual Hardy Z.

## 3. Evidence format and completeness checks

A compact successful high sign chain contains exactly1746078 rational heights

\[
1500=t_0<t_1<\cdots<t_{1746077}=1000000
\]

with strict alternating certified Hardy-Z signs. The existing low endpoint has positive sign; the final sign is negative if all1746077 changes are present. Recheck both endpoints or derive their actual signs from the already justified phase/count interfaces. The endpoint parity is a useful consistency check, not a substitute for interval acceptance.

Each adjacent pair gives at least one actual critical-line zero by continuity. The intervals have disjoint interiors and their endpoints are nonzero. They therefore give at least1746077 distinct zeros above1500, each contributing at least one to the count. The independent EM count difference is exactly1746077. Equality eliminates every extra zero, including off-line zeros, and every multiplicity excess. No spacing, Gram law, indexed-zero count, or pre-existing finite RH statement is used.

Candidate-location software may be untrusted, but acceptance must be independent of its claims. A straightforward discovery phase uses a rational grid with adaptive subdivisions; two equal endpoint signs do not certify an empty interval. Stop only when the verified number of disjoint sign changes matches the independent count. If refinement or point precision reaches the agreed cap first, return INCOMPLETE with the exact uncovered intervals and reason.

For a hypothetical successful eighth-unit grid, the full grid has7988001 samples. A compressed accepted chain can encode its1746078 grid indices as uint32, using6984312 bytes, plus an optional one-byte evaluator-mode tag per sample using1746078 bytes. This is a conditional file-format size, not evidence that this grid suffices. Finer adaptive points require an explicit dyadic/rational representation and may increase the size. Per-point sign balls need not be trusted or stored: the checker can recompute them, while generation logs record margins and parameters.

Use chunk manifests with ordered endpoint overlap, source/algorithm hashes, exact parameter values, and a final count of accepted transitions. Chunk boundaries must not lose or double-count a sign change. A diagnostic generation receipt is separate from the final accepted chain. Kernel replay eventually requires sound rational interval arithmetic and proofs of(G),(P), not an Arb-ball premise or native-decision shortcut.

## 4. Quantitative comparison with direct exclusion

For direct exclusion take the exact rectangle

\[
[629/1250,2]\times[1500,1000000]
\]

in real/imaginary coordinates. Certifying its boundary nonzero and winding zero proves no zeros to the right of.5032 in the desired band; reflection gives the other half. Re(s)>=1 is already zero-free. The top path is available from the EM certificate, the bottom from the head boundary certificate plus the right-half-plane argument, and the sigma2 vertical path has positive real zeta. The costly new part is the left vertical edge. Requiring nonvanishing exactly at.5032 is a stronger sufficient certificate than(S), which allows zeros on that line. Moving the edge right without accounting for the intervening sliver is invalid.

Existing quarter-unit EM/Taylor geometry would need3994000 models on this edge. If block j uses N_j=ceil(upper_height/3), the exact total of finite Dirichlet-sum terms is666667163668. Constructing all24 coefficients per term entails16000011928032 coefficient contributions before correction and panel work. These are workload counts for that specified implementation, not measured lower bounds or a Lean runtime forecast. Shared log tables need at most333334 entries. Whole-panel nonvanishing can require extra subdivision near zeros; the quarter blocks are model domains, not a guarantee of one half-plane per block.

Storing every degree23 complex coefficient as four rational endpoints would produce95856000 complex coefficients, or383424000 rational endpoints. A streaming recomputation checker can avoid that storage. The previous64-sample Cauchy/RS model would instead use255616000 point calls for the same quarter-block cover, but its off-line RS theorem gap remains. Gabcke's critical-line theorem does not validate those off-line samples.

For the compressed sign route, the main sum has at most398 terms, giving a worst-case694939044 main-term contributions on the1746078 accepted points. Discovery work and failed points are additional. This comparison favors signs without extrapolating wall time from a handful of point evaluations.

Repeated grid values can share arithmetic. With a fixed grid step h, each n-wave obeys

\[
w_n(t+h)=w_n(t)e^{-ih\log n},\qquad w_n(t)=n^{-1/2}e^{-it\log n}.
\]

Precompute the398 log/square-root enclosures and step rotations, reanchor waves at bounded chunk intervals, and add a term when the exact N increases. Interval error must propagate through every multiplication; periodic reanchoring limits wrapping but no unexplained roundoff cap is permitted. This is an optimization to test against direct point evaluation, not a prevalidated fast algorithm. A compressed replay may evaluate each retained point directly instead of reproducing every discovery grid point.

## 5. Next bounded work and remaining analytic proof

The next useful prototype is an elementary Gabcke checker at a small fixed set of rational points: the two accepted endpoints, several interior heights, and points near p=+/-1/2 and an N transition. Check K0/K1/K4 enclosures against explicit EM point enclosures with independent parameters. No builtin zeta, RS, Gamma, or indexed-zero acceptance call is needed. Such a prototype resolves normalization, factorial and removable-point errors; it cannot establish the uniform analytic remainder theorem or predict full-chain success.

Before any long run, independently review the exact source theorem and finish the evaluator's interval semantics, including its fallback and INCOMPLETE status. Then set a bounded discovery pilot above1500 and report accepted changes, all inconclusive points, and actual memory/work. The parent must decide the full production budget after that evidence. No full scan is authorized or performed by this note.

Formal obligations remain substantial: the source-faithful RS integral derivation, Gabcke's explicit remainder and coefficient bounds, normalized Gamma phase approximation, elementary enclosure checker, floor and removable-point handling, and transport from the existing Mathlib `hardyZ`, `continuous_hardyZ`, and `hardyZ_eq_zero_iff` to the numerical formula. The reviewed all-zero count and its EM arithmetic must also be kernel replayed. These are proof tasks to discharge, never new allowed root assumptions.

The original selected strip plus the accepted low head implies W35<23.981<24 by `major-constants/PRINCIPAL_HIGH_STRIP_REFINEMENT_2026-11-11.md`. This note supplies an accessible evaluator route and finite production design; it does not yet prove the remaining high strip or move its status to complete.
