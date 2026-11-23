# Principal-height certificates with a retained ladder suffix

2026-11-11. Source and scalar research only. No new prime, zero, special-function or timing evaluation; no builds or source edits. The finite-RH gap theorem and its certified input are separate obligations. This note does not assume global RH or interpolate a theorem below its proved bootstrap height.

## 1. The analytic cutoff must include the gap-length condition

Let B>=4 be even, N=10^27, and suppose an analytic theorem plus its low-end patch proves ternary Goldbach for every odd 5<n<=C_B(H). The cutoff is an integer, clipped at N-1. It depends on both the spectral height H and B, not merely the largest x at which a theta estimate holds.

For example, if the theorem bounds theta at arguments through Y_RH(H), its two-endpoint error must additionally be smaller than B-4. If Y_err(B,H) is a proved upper endpoint for that inequality, a sufficient y-cutoff is

    Y_B(H)=min(Y_RH(H),Y_err(B,H),N-5),
    C_B(H)=floor(Y_B(H))+4,

provided the estimates apply on the required whole interval and the lower patch fills every gap. The base 3+(n-3) already covers odd n<=B+3. Use the larger contiguous covered cutoff, not a disconnected union with its holes omitted. Real/integer endpoint and strict inequality conventions belong to the analytic adapter.

For a direct relative prime-gap theorem, the condition is similarly the intersection of its x-domain with its proved gap length <=B-4 (or the parity-adjusted open-left version in the preceding coverage note). A table at one fixed H does not define a continuous family C_B(H).

The coordinated Johnston/Büthe/table route has a finite-RH bootstrap of approximately 3e12; preserve the exact height required by that theorem/certificate, which may be larger than the rounded headline. The alternative of **no added principal certificate** is a separate option with the explicit ladder. Heights below that bootstrap are not valid optimization candidates for this theorem by interpolation. A newly proved direct theorem can replace the restriction; section 8 treats its low-range coverage interface separately.

The analytic worker's frozen `PRINCIPAL_FINITE_RH_LADDER_REPLACEMENT_2026-11-11.md`, SHA256 `6ED412B2F17E25FFCFA649C4D6F0F4C2169EC9F93258164FA00DF9D9ED6FD570`, supplies a concrete conditional family: Johnston's range condition is `9.06*sqrt(X/log X)/log(log X)<=H`, together with the independent requirement `2*sqrt(X)*(log X)^2/(8*pi)<B-4` and its lower-range/bootstrap proof. Its reported H=9e12 supports X=N for B=1e16. The same report's CHL construction is a table route at the fixed height3000175332800, with additional analytic/table inputs, supplying B=2e16 after stitching. It is not a continuously varying H family. These are supplied analytic constructions awaiting their full formal and finite-spectral obligations; this cost note does not independently certify their transcendental constants. In particular the smooth H^2-log models below do not replace either exact condition.

## 2. Exact suffix and overlap

Write g=S*F for the chosen ladder stride, with F even, and let W_lad denote its candidate-window width. A certified ordinary or fallback prime for index i obeys

    (S*i-(W_lad-1))*F+1 <= p <= S*i*F+1.

Under `(S+W_lad-1)*F+2<=B`, it supplies a binary decomposition for every odd n in

    [i*g+5,(i+1)*g+3].                              (1)

Assume the analytic+base proof covers every odd n<=C, where B+3<=C<N-1. The first uncovered odd integer and required rung indices are exactly

    n_first=2*floor((C+1)/2)+1,
    i_first=floor((n_first-5)/g),
    i_last=floor((N-6)/g),
    K_suffix=i_last-i_first+1.                      (2)

If C>=N-1, the suffix is empty. Since g<=B-2 and n_first>=B+5, i_first>=1. Every larger odd target uses i=floor((n-5)/g), so its index lies in the complete consecutive range [i_first,i_last]. For even N,g, floor((N-6)/g)=floor((N-5)/g), matching the existing conservative index formula.

The proof needs no separately certified gap between a last analytic prime and a first explicit prime. The analytic branch already covers its targets; each suffix rung independently supplies the entire cell (1). The first retained prime may be below C. Discarding that rung because its prime is below the analytic cutoff would be incorrect: part of its target cell may lie above C. Likewise, retaining only indices strictly greater than C/g can omit the first uncovered targets.

For the original ladder, g=111616*2^45 and W_lad=2048. For the smaller-B designs, use their actual S,W_lad, not those old constants. The old fixed-stride hints are not automatically certificates for the new windows. The smaller-B source also needs new index/exponent-width bounds; deleting a prefix does not make a large absolute suffix index fit the old 28-bit bound.

## 3. What existing chunks can really be omitted

`Ladder/Check.lean:88,91` defines `ChunkOK(i0)` for 4096 rungs and `RunsOK(a,n)` for n consecutive such chunks. `Ladder/Spec.lean` ends with `prime_of_runsOK`, consuming an arbitrary positive start a together with its absolute index and Proth-size bounds. Thus the mathematical source interface already permits a suffix; it does not require all earlier rungs.

In the current alignment, chunk j covers rung indices

    [1+4096*j,1+4096*(j+1)).

For a nonempty suffix retain exactly chunks

    j_first=floor((i_first-1)/4096),
    ...,
    j_last=floor((i_last-1)/4096).                    (3)

All earlier chunks can be omitted from the dependency graph. Reusing whole chunks adds fewer than 4096 rungs at either end relative to the exact suffix. Those extra checks count as real work. A new boundary chunk with a smaller batch or a generic extraction theorem could reduce the excess, but its implementation must be supplied.

There is an important source-level distinction: `Ladder/Main.lean` imports `Ladder/Data.lean`, which imports all 128 data modules. Merely using `ladder_prime` only for high indices still imports and builds the complete old data closure. To save end-to-end proof work, a future suffix assembly must import only selected data modules and construct the needed `RunsOK` proof, avoiding the all-data aggregate.

The current generator `scripts/gen_ladder.py` allocates 485 or 486 chunks per module. Reusing an unmodified module containing j_first can therefore retain up to almost 1,990,656 extra front rungs, rather than fewer than 4096. Omitting whole earlier modules is safe; omitting declarations inside a still-imported module does not save that module's build. Repartitioning at a chunk boundary is a future source change, not performed here. The exact saved generation, build, import and checking costs depend on whether already-built artifacts or a fresh full build are being priced.

The current `prime_of_runsOK` also requires a+4096*n<=2^28 and `111616*(a+4096*n)<=2^45`. These remain valid for a contained suffix of the old dataset. They must be rederived for an altered ladder. No untrusted shard list or omitted-index hash substitutes for the complete range proof in (3).

## 4. Exact cost comparison

At fixed B,L and binary anchor policy, binary cost is common. A hybrid choice has

    Cost(H)=AddedPrincipal(H)+GapTheoremAndScalars(H)
            +LowPatch(H)+SuffixGenerationAndChecking(H)
            +ChangedAssembly(H).

The suffix term is the sum of costs of the actual retained rungs/chunks, including failures and fallback certificates. It is not automatically K_suffix times the old average cost. If high windows are harder or batches have fixed overhead, preserve that distribution. AddedPrincipal includes strengthening any previously weaker strip certificate, not just extending its height. A previously proved genuine finite-RH prefix can be reused only through a sound proof import.

Compare this with the complete explicit ladder (no added RH). Also compare it with the smallest admissible height that eliminates the suffix, if any. If the gap estimate saturates below N, compare its saturation height; further principal computation that improves no retained target and has positive cost is dominated within that theorem family.

For original B=4e18 the complete old ladder has 254638308 rungs. The candidate smaller bounds B=1e16 and 2e16 have respectively 181029996372 and 90804183483 rungs in the earlier mixed-window design. At the same fraction of target range covered analytically, the potential rung savings therefore differ by factors of roughly 711 and 357. These are counts, not costs. Principal proof cost can be common across these B choices only if the same exact theorem and certificate actually supply the corresponding gap inequalities.

## 5. Interior optima under the illustrative smooth model

Let X(H) denote the effective contiguous target coverage, before clipping at N. Freeze a constant complete rung cost c_r, stride g, and all other terms. Put lambda=c_r/g and model the added principal cost as c_s*H*log H. Before full coverage the variable part is

    f(H)=c_s*H*log H + lambda*(N-X(H)).              (4)

This is a conditional shape model, not a finite-RH theorem or runtime forecast. Its derivative satisfies

    f'(H)/(log H+1)=c_s-lambda*R(H),
    R(H)=X'(H)/(log H+1).

If R is increasing, f' can change sign only from positive to negative. Any interior stationary point is a maximum, and a minimum on an admissible closed height interval occurs at an endpoint. A sufficient exact differential test is

    H*(log H+1)*X''(H) > X'(H).                     (5)

For the illustrative family X(H)=a*H^2*(log H)^p, a>0,p>=0, R is increasing for log H>=1. Writing l=log H, the numerator of R' after positive factors are removed is

    2*l^3 + 3*p*l^2 + (p^2+p)*l + p*(p-1).

It is positive: for l>=1, the last two terms together are at least 2*p^2, and 2*l^3>0. Thus the smooth model has **no minimizing interior height** in this range. One should compare the allowed bootstrap height, the full-coverage or gap-saturation height, and the separate no-added-RH option.

The same conclusion holds for X(H)=a*H^2*(log H)^p*(log log H)^q with p,q>=0 and log H>=4. Let e=2+p/l+q/(l log l). The logarithmic derivative of R with respect to l is

    e-1 + e'/e - 1/(l+1).

Here -e'/e<=2/l, since it is a weighted average, with an additional nonnegative denominator term, of 1/l and (1+1/log l)/l. Hence the derivative is at least `1-2/l-1/(l+1)>0`. This includes the commonly suggested H^2 times positive logarithmic factors as a model; it does not establish that the available analytic theorem has that exact range function or that its constants have this monotonicity.

The result can also be read economically: the model's saved ladder work accelerates with H faster than the marginal spectral cost. Paying part of the high-height certificate generally loses to either stopping at the bootstrap or completing it. A larger principal cost with different convexity, a different actual X(H), a height-dependent arithmetic algorithm, or nonuniform ladder costs can invalidate that conclusion; test (5) or the exact marginal comparison rather than declaring endpoints optimal by analogy.

## 6. Floors, tables and genuine hybrid candidates

The exact suffix cost is a staircase. Between two changes of i_first or an imported chunk boundary, increasing H saves no ladder work. If all other H-dependent costs are increasing, only the **least admissible H** reaching a new useful cutoff is worth considering. Thus the discrete candidate set consists of bootstrap/theorem breakpoints, earliest certified chunk-removal heights, and the full-coverage or saturation endpoint. Arbitrary intermediate heights are unnecessary.

For uniform per-rung cost and g>=4, the exact K_suffix in (2) differs by less than two from (N-C)/g on the nonempty suffix. This follows directly from the two floors and n_first-C in {1,2}. Consequently the exact rung model differs from the smooth length approximation by less than 2*c_r. A possible interior improvement due solely to this rounding is bounded by 4*c_r when comparing two choices. Whole-chunk or whole-module rounding has a larger explicitly bounded fringe, plus real batch/import overhead. These bounds do not apply to arbitrarily varying per-rung fallback costs.

If an analytic source provides only a table at fixed H, there is no continuum to optimize. Evaluate the available certified points and their actual ranges. If distinct analytic formulas govern successive ranges, each formula boundary is an additional candidate. If the two-endpoint error bound imposes a B-dependent ceiling X_gap(B)<N, principal heights beyond the first attainment of that ceiling give no benefit in this route. If the lower validity threshold creates a gap, fill it first before using a contiguous C in (2).

The approximately-3e12 bootstrap of the coordinated Johnston/Büthe/table route is therefore material. The continuous model cannot justify a much smaller intermediate height such as 1e9 within that route. For B=4e18, a valid bootstrap-height table may already cover the full target range, in which case only no-added-RH versus that complete replacement remains. For B=1e16, the same table may give a strict prefix and make bootstrap-plus-suffix a real endpoint candidate. These are conditional scenarios until the analytic worker supplies the exact table/domain and all dependencies.

## 7. Bounded next decision

Obtain from the analytic packet a table of `(B,H,contiguous C,low patch,extra analytic inputs)`, not just the largest x at which an error bound holds. Convert every row by (2) and (3), including actual module import overhead for the original ladder. Compare no added RH, every valid bootstrap/table breakpoint, and the first full-coverage height. Only after those discrete costs overlap should a small measurement of a complete principal certificate block and a complete suffix batch be requested.

The companion exact-integer script records hypothetical quarter/half/three-quarter cutoffs for the three ladder shapes, checks first/last cell bounds and chunk alignment, and binds the read source files. Those cutoffs are not claimed analytic coverage. It runs no prime search or analytic evaluation. The analytic theorem's exact X(H), finite RH proof, source formalization and actual costs remain open inputs to the final selection.

## 8. A new direct theorem can remove the initialization computation

The coordinator subsequently proposed deriving the theta estimate afresh for every t in [A,N], rather than importing the older small-t initialization. This is a **different analytic proof obligation**. Its finite spectral height and error constants are owned by the major-constants worker; none is proved by this coverage note. If that proof succeeds at a smaller height, the old approximately-3e12 bootstrap need not be inherited. It cannot be discarded merely on the basis of the cost model.

There is a useful exact coverage simplification when A is an integer >=2 and B is even with B>=2A. Bertrand supplies a prime p with A<p<=2A. Since p>A>=2, p is odd, so in fact p<=2A-1. For every odd n in [B+5,A+B],

    n-p is even,
    n-p >= B-2A+6 >= 6,
    n-p <= B-1, hence n-p<=B-2.

Thus the binary theorem through B proves the entire patch. The base prime 3 covers all odd n<=B+3; no odd integer lies between B+3 and B+5. The direct theta argument begins when n>=A+B, because its lower endpoint n-B>=A and its upper endpoint n-4 is also in the proved range. Both branches cover the common endpoint if it is odd. There is no need to compute or serialize the Bertrand prime.

For real A, replace it by the integer a=ceil(A), require a>=2 and B>=2a, and apply the same argument at a. This merely shortens the analytic application to a subset of its actual domain. In the proposed A=1e16,B=2e16 case, B=2A and the entire initialization patch therefore needs **zero explicit prime records**. It uses the existing proved existential theorem, not an extra assumption or a probable-prime assertion.

The exact target Mathlib API is `Nat.exists_prime_lt_and_le_two_mul` at `Mathlib/NumberTheory/Bertrand.lean:225`: for n!=0 it gives `exists p, Prime p and n<p and p<=2*n`. The strict upper endpoint above is derived using parity, not read incorrectly from that API. The inspected file at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/NumberTheory/Bertrand.lean` has SHA256 `91AED0AE5E324993157982FF06A5EB8002FD7224C2A3FA1B47DB937650CEF9DD`. Its large-n proof and final theorem body were read; no evaluation or build was run.

### Fallback when A is much larger than B

Before the lower threshold was improved, the proposed patch was A=1e20,B=2e16, C=A+B. It admits a small generalized Proth ladder, retained here only as a fallback design. For m>=1, put F=2^m and choose W_lad,S with S>=W_lad and `(S+W_lad-1)F+2<=B`. Use (1) and (2) with the terminal endpoint C instead of N. Every candidate is `(S*i-t)F+1`, 0<=t<W_lad. Require S*i<F (also for any padded rungs).

The existing source's Pocklington argument generalizes without assuming S*i-t is odd: for odd c>1, if c<(2^m+1)^2 and c divides `x^(2^(m-1))+1`, every odd prime factor is at least2^m+1, contradicting compositeness. The current `prime_of_cert` factors its base-3 divisibility condition to obtain this criterion. Its mathematical mechanism is visible at `Ladder/Spec.lean:39–80`; the actual checker hard-codes m=45, stride111616 and fixed exponent/index widths, so the m=34 version is a new implementation/proof task. Ordinary candidates may fail the base-3 criterion; successful existence or certified fallback primes in every required window remains an obligation.

Exact fallback parameters are

    m=34, F=17179869184, W_lad=2048,
    S=floor((B-2)/F)-2047=1162106,
    g=19964829057941504,
    C=100020000000000000000,
    i_last=floor((C-6)/g)=5009.

The coverage budget is19999996250161154<B. The last assigned odd target cell is

    [100003828751228993541,100023793580286935043],

which contains C-1. The maximum unpadded coefficient S*i_last=5820988954 is below F; F^2=295147905179352825856>C. There are5009 required windows, not the idealized5001 obtained by dividing C by B and ignoring window width. A 32-rung batching design pads to5024 windows (157 batches), whereas reusing the old4096-rung packaging pads to8192. The padded coefficient bound remains below F. The generalized widths are33 squarings for2^(m-1),21 bits for S,13 bits for these padded indices and11 bits per offset. All of these are exact integer size facts, not prime certificates or runtime evidence. The subsequent Bertrand patch supersedes this fallback when A<=B/2.
