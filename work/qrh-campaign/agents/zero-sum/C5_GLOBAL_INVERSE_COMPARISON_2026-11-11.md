# Conductor-5 global inverse comparison

2026-11-11. This is a bounded external interval experiment on exactly the reviewed rectangle [111/200,2]+i[-12,12] and the three actual primitive characters modulo5. It does not certify a production Hcert rectangle, extend the height, change the target, or supply a Lean proof. No builtin zeta, Gamma, theta, or zero oracle is used by either new script.

## Character and evaluator contract

The fixed generator is2, residues are [1,2,4,3], and chi_k(2^j)=i^(k*j), k=1,2,3. Parities are odd, even, odd. The previous all-three-character certificate `c5_family_dft_certificate_20261111.py/json` uses the same rectangle, counterclockwise orientation, and actual L-functions. Its accepted original record has 3034 shared panels, 6064 vector panel calls and3034 distinct vertex calls, with windings [0,0,0]. Its recorded construction time4.63548 seconds is historical and is not a controlled timing comparison with this experiment.

The new checker imports the same four pole-cancelled Hurwitz Euler-Maclaurin expressions, with N64 and M20. It forms their primitive projection directly: scale by5^(-s), then subtract their common mean. This gives the group-algebra coefficients a_g(s), whose three primitive positive transforms are exactly the source L(s,chi_k). There is no new special-function formula. The inherited Bernoulli and logarithm constants retain their128-bit ball radii; subsequent acceptance operations use160-bit balls.

One initial candidate-generation run encountered an arithmetic-domain failure: the inherited exprel remainder attempted abs(z)^19 on a zero-containing real Arb interval and returned NaN at real-axis points. The local adapter preserves the same19-degree finite expression and the same analytic remainder estimate, but uses the positive exact upper radius R=abs(z).upper() in exp(R)*R^19/20!. This enlarges the bound safely and avoids that interval-power domain issue. Frozen evaluator files are unchanged. This is a finite-arithmetic adapter, not a repair to the analytic theorem.

## One fixed rational candidate

Untrusted candidate generation fits reciprocal L values by complex least squares using only points inside the authorized closed rectangle. It uses816 training points and1632 validation points; the latter are diagnostics, never acceptance. The matrix has a constant column and columns1/(s-p). The singular-value cutoff is1e-9. No fitted coefficient or sample residual is assumed correct by the checker.

The first trial has193 poles at p=1/2+i*j/8, -96<=j<=96. Its sampled residual maxima are approximately .438853,.129930,.438853 and it misses the chosen construction threshold .3. It is not a failed mathematical certificate, since the whole-boundary checker was not run on this first candidate.

The selected second trial has385 poles at p=1/2+i*j/16, -192<=j<=192. Its sampled residual maxima are approximately .137152,.031130,.137152. Every complex floating coefficient is then frozen as its exact binary rational. This conversion defines the candidate; it does not trust floating-point fitting as a proof. Candidate generation records1.08971 seconds after imports on this host.

For each k the rational function B_k(s) is a constant plus the385 frozen residues divided by the fixed linear factors. Its poles all have real part1/2, hence exact horizontal clearance11/200 from the rectangle. Set

    b_{2^j}(s) = (1/4) sum_{k=1}^3 i^(-k*j) B_k(s).

The checker computes these coefficient conversions with exact Fraction arithmetic before producing interval coefficients. Thus b is one fixed holomorphic group-algebra function on a neighborhood of the entire rectangle. No panel-specific inverse replacement is permitted. The principal transform of b is zero. The stored candidate has1158 complex rational coefficients; the explicit four-component conversion has1544, all sharing the same385 poles. The candidate receipt is157155 bytes.

## Acceptance rules

On the cyclic unit group, e=(3/4,-1/4,-1/4,-1/4) is the exact primitive projector. Convolution is unnormalized cyclic convolution. On each complete complex boundary segment the checker encloses

    r(s)=e-a(s)*b(s),
    Q1(s)=sum_g |r_g(s)|,
    Q16(s)=4*sum_g |r^{*16}_g(s)|^2.

The final squares use nonnegative upper norm bounds. Four convolution squarings compute r^{*16}; an additional convolution computes a*b. All products, additions, divisions, coefficient errors and EM remainders remain in interval arithmetic. A segment passes the corresponding test only if its resulting rigorous upper bound is strictly below1.

Finite orthogonality gives Q16=sum_{k=1}^3 |1-L(s,chi_k)B_k(s)|^32 for exact inputs. Therefore either complete boundary test bounds each analytic scalar residual strictly below1. Since every B_k is holomorphic throughout the same rectangle, maximum modulus then gives interior invertibility and excludes all zeros of each factor. The proof applies the maximum principle to scalar analytic residuals, not to the nonholomorphic norm or moment. This is the accepted product-feasibility criterion, not an inference from sampled residuals.

Starting from the four complete oriented edges, the checker recursively bisects failed segments. It maintains independent accepted partitions for Q1 and Q16, sharing every numerical evaluation. A test already accepted on a parent is not charged for its sibling test's later refinements. Both accepted partitions must independently satisfy the exact original `check_partition` geometry check before overall PASS is emitted. A partial boundary is explicitly incomplete.

Each vector panel call uses256 finite Dirichlet-term exponentials,385 rational reciprocals,1540 candidate coefficient products, and80 products in five four-component convolutions, in addition to the common EM/scaling/interval operations. These are source-loop counts, not equal-cost operations or a runtime model. This direct implementation does not use an FFT. It deliberately avoids individual character residual acceptance, but that does not imply less arithmetic than the original three-character polygons.

## Bounded result

The run terminated at its predefined30000-vector-panel limit after78.33574 seconds, before its180-second wall limit. Its status is `INCOMPLETE_DIAGNOSTIC`. Neither test completed the boundary. No global inverse certificate or new rectangle zero-exclusion claim results from this run. The process exits with code0 even for this recorded diagnostic; downstream acceptance must check the status AND complete geometry, not merely the exit code.

| Recorded quantity | l1 test | T16 test |
| --- | ---: | ---: |
| Accepted partial-boundary panels | 10,985 | 14,999 |
| Failed active panel tests | 10,985 | 15,001 |
| Maximum accepted dyadic depth | 16 | 17 |
| Last accepted endpoint | .555 - (16893/4096)i | .555 - (33783/8192)i |
| Exact covered boundary length | 4404661/102400 | 8809247/204800 |
| Total required boundary length | 5089/100 | 5089/100 |

Each accepted sequence covers the bottom, right and top edges, then a prefix of the descending left edge. Each covers about84.5% of the required perimeter. The remaining left-edge segment is unverified by this run. Accepted l1 bounds reach4294811517/4294967296; accepted T16 bounds reach4607723265950079205/4611686018427387904. The last attempted panel was [.555-(33783/8192)i, .555-(16893/4096)i], traversed downward. Its l1 test passed but T16 failed. The guard then stopped the next refinement; it did not report an actual zero or a pointwise residual above1.

There were30000 distinct combined group-EM/candidate evaluations and no new L-function vertex evaluations in the acceptance run. The source-loop totals are7,680,000 finite Dirichlet-term exponentials,11,550,000 rational reciprocals,46,200,000 candidate coefficient multiplications and2,400,000 products inside group convolutions. These omit lower-order/scaling operations and candidate fitting; they are not timing-equivalent units. The successful fitting run made1632 shared vector point evaluations, reused by both fits. The earlier real-axis failure and diagnostic probes were not included in its recorded timing. Their executed loop bounds account for another1037 vector evaluations:217 up to the failed initial point,818 in the all-training-point diagnostic, and2 targeted probes.

The acceptance receipt is13,755,462 bytes, including failed-attempt metadata and both partial partitions. The candidate receipt is157,155 bytes. These are diagnostic formats, not optimized proof-output sizes. In particular the large attempt log could be omitted from a final proof object. The old complete polygon receipt has3034 panels; this incomplete inverse attempt is substantially more expensive under the present representation/evaluator. That observation does not establish a lower bound for inverse certificates, or a controlled machine-speed comparison with the older timing.

## What the limitation does and does not show

The saved sampled maxima below.138 are not bounds between sample points. They cannot certify that the exact residual has uniformly small variation on the missing segments. The saved acceptance log records pass/fail decisions and accepted norm bounds, not enough center-and-derivative data to quantify what fraction of the refinement came from true residual variation versus interval overestimation.

There are identifiable sources of overestimation in the implemented formula. It independently encloses each rational reciprocal and coefficient sum, then encloses a*b, discarding common-s correlations; it applies four interval convolution squarings for T16. Analytic cancellation in 1-L*B is therefore not retained at the center before widening the panel. The T16 partition was finer in this run, despite the exact moment criterion being potentially stronger than an l1 criterion. This is evidence about this evaluation method, not a proof that the exact moment test is intrinsically worse.

One bounded follow-up would keep the SAME frozen candidate and examine only a few of the saved difficult panels with a centered analytic model of r(s), multiplying L and B Taylor coefficients before adding the panel remainder. For B(s)=b0+sum_j w_j/(s-p_j), the exact degree-d expansion at s0 has coefficients (-1)^m sum_j w_j/(s0-p_j)^(m+1), m>=1, with the corresponding m=0 constant. On |s-s0|<=rho<min_j|s0-p_j|, its tail is bounded by

    sum_j |w_j| rho^(d+1) /
       (|s0-p_j|^(d+1) (|s0-p_j|-rho)).

An explicit EM Taylor model for L with its own analytic error would complete the product model. This targets the discarded correlations directly. It remains a proposed diagnostic, not a claim that the models will pass or that the missing boundary is certified. The capped run was not extended.

## Frozen artifacts and replay

All paths below are in this report's directory. No inherited file was edited.

* Candidate generator `c5_global_inverse_candidate_20261111.py`: SHA256 `3F86D07FB695EAD08F677E7C1F9BBDFE9D9BB0FF5F74F269D9B0B3DA0AEB321B`.
* Frozen exact candidate `c5_global_inverse_candidate_20261111.json`: `02C623629D3DF9218AFB7689F39698AF5C4F4D6FB6776056C4B275220D148E6E`.
* Acceptance program `c5_global_inverse_certificate_20261111.py`: `D51E0EBDAAA3F7176151D02E05C35E88CC48C2B02862AB967955B6D3746392A8`.
* Capped acceptance receipt `c5_global_inverse_certificate_20261111.json`: `7FAA8640C48E48C6BB03CE3AA0921CE77042F42A464E1F371221E888AEE946EA`.
* Exact coverage summary `c5_global_inverse_summary_20261111.json`: `1D2E0AFCD7E558C3BA91B1B359AFAF773585E975578DF169EA2B0FE763637F9E`.
* Read-only partial replay `c5_global_inverse_partial_replay_20261111.py`: `437392A1550BFF8E5D13C6F9B6DBC3C28DB1353784BED6F6EE605DB741EB63BA`.
* Inherited evaluator `c5_family_dft_certificate_20261111.py`: `C5125697833CC998C79D854F73D8D6D80B442C6972885C1AC35675F128851FC8`.
* Inherited complete polygon receipt `c5_family_dft_certificate_20261111.json`: `E2CB12AD11F75CF64957864B1D64E88B347611EB09C4A3C419BF95B07A5D60E2`.

For read-only replay use the existing `work/qrh-campaign/interval-env/Scripts/python.exe` on `c5_global_inverse_partial_replay_20261111.py`. Its `--structure-only` option checks hashes, exact prefix geometry and every stored accepted-bound inequality without redoing interval arithmetic. That option passed. Without the option it recomputes every distinct accepted panel bound, with a cache shared between methods; it still emits an INCOMPLETE status and `full_rectangle_certified: false`. The original acceptance program's `--replay` is intentionally only for a complete PASS receipt and rejects this diagnostic. Candidate regeneration is not needed for checking: the binary-rational coefficients are the untrusted witness being checked.
