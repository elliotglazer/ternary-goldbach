# Rational proof cost design for the fixed small EM experiment

Date: 2026-11-11. Scope: paper design, saved-data inventory and exact integer/rational scalar checks. No evaluator was imported or run for this task; no new logs, exponentials, transforms, models, Lean files or proof builds were computed.

## 1. Recommendation and the two acceptance statements

Implement the direct finite-g route first for the actual-image theorem. The first useful slice is j=7: all 16 normalized complex derivatives, the entire last vertical panel, and its canonical endpoints 7 and 8. Then extend the same checker to all 128 coefficients and all 17 images, supplying and checking every input. The first slice is deliberately incomplete evidence for the full fixed experiment.

There are two distinct possible conclusions:

* **Actual-image acceptance:** the 128 normalized coefficients of the specified finite function g lie in the immutable exported squares, and actual zeta lies in the same eight closed vertical-panel and nine endpoint rectangles.
* **Batch-record acceptance:** additionally, the 1,024 saved bin choices, all 12,288 moment disks, and all 3,072 consumed normalized-transform disks have their declared mathematical meanings and error bounds.

Direct evaluation of g can prove the first conclusion without certifying bins, residual moments or transforms. It cannot prove the second conclusion. Removing those internal claims is legitimate only when the promised theorem is actual-image acceptance; it is not a retrospective proof of the saved batching algorithm. Both conclusions still need the source EM identity, finite-g Taylor bound, exact input binding and a successful closed arithmetic check. Neither is a zero-count or nonvanishing theorem.

The complete fixed target remains Re(s)=629/1250 and Im(s) in [1999,2000], with eight centers c_j=629/1250+i(2000-1/16-j/8), j=0,...,7. The j=7 center is 629/1250+i*31985/16, its panel is [1999,15993/8], and endpoints 7 and 8 both belong to model 7. Arbitrary complex-disk coordinate-square transport is not substituted for the accepted purely imaginary-offset calculation.

## 2. Pinned evidence and measured artifact sizes

Paths in this note are relative to work/qrh-campaign/agents. The inventory companion verifies every listed source pin before inspecting its bytes.

| Artifact | SHA256 | Bytes |
|---|---|---:|
| integration/FINITE_EM_RATIONAL_CHECKER_BLUEPRINT_2026-11-11.md | F6B784776E24F767FA3A45C3006394F0E718FF491712077FC9EBDC74EDE92F22 | 28,963 |
| major-constants/FINITE_EM_RATIONAL_ELEMENTARY_BUDGET_2026-11-11.md | 50D1FFB0385A0F2FCE3BA9EF3BBB4FFD3BAC5A0103E95A8329E79A25D524A541 | 16,007 |
| integration/small_em_batch_candidate_20261111_01.json | 2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E | 8,058,388 |
| independent-feasibility/small_em_batch_independent_replay_20261111_01.json | 2D0CF58A1825978455B029ABE3A73382745955D7EE1A74106A8FF98116A3EE80 | 6,155,890 |
| integration/small_em_batch_candidate_20261111.py | 23D358590279AA810EAE764D3FEEA0756C51DF8CF0EA6F05B457A192BB82822C | 34,401 |
| independent-feasibility/review_small_em_batch_prepared_20261111.py | A6F6A8C78B4DC70F657564D19398ADF2E9F8922B005969B7ABAAA62BFBBC5A9A | 34,402 |

The completed external experiment was reviewed in audit/REVIEW_SMALL_EM_BATCH_COMPLETED_2026-11-11.md, A276BF8B60ADA46BB4C618E50EC8E26CDBF4922258AD407DC6C3F9335C3CF697. Its FLINT computations and independent enclosure tests are evidence about this experiment, not rational proofs of its elementary leaves.

Compact JSON serialization of only parameters, analytic budget, all g squares and final images occupies 68,025 bytes; the corresponding j=7 subset occupies 10,799 bytes. These are encodings of old target data, not proof terms, new witnesses or lower bounds on certificate size. The full candidate's moment and transform sections alone occupy 4,352,286 and 1,808,107 compact bytes. Most retained dyadic mantissas are at most 192 bits; the old correction section contains rational denominators up to 1,998 bits. These observations do not predict the representation of a future 1,025-bit-grid rational checker.

There are 1,920 nonzero moment claims and 10,368 exact-zero claims. The saved bins are q=0 for n=1..2, q=-1 for n=3..10, q=-2 for n=11..50, q=-3 for n=51..244 and q=-4 for n=245..1024. Empty buckets may be represented implicitly only after the checker proves the complete partition and defines them as zero. This is a possible compression, not permission to skip consumed assertions.

## 3. What is shared mathematically

Put N=1024, B=N+1=1025, K=16 retained derivative orders, J=8 centers, L=32, p=24 residual orders. The exact source-bound function is

    D(s) = sum_(n=1..N) exp(-s log n),
    C(s) = 1/2 + sum_(k=1..16) [B_(2k)/(2k)!] B^(1-2k) (s)_(2k-1),
    g(s) = (s-1)D(s) + exp(-s log B)*((s-1)C(s)+B).

In particular the final B term is necessary: it is the B^(1-s) correction. Derivatives are normalized complex-s derivatives divided by h!, not unnormalized vertical derivatives. The old halfwidths are coordinate halfwidths 2^-52.

Both designs can share one proof of each rational elementary primitive, pi, log 2, the 1,025 logs (log 1 is exact), the 16 exact Bernoulli factors, factorials, log-power recurrences, finite polynomial convolution, rectangle operations, and the EM/Taylor source adapters. A certificate DAG can name these results once and refer to them. Sound sharing requires explicit typed references or a verified DAG interpreter; hashes or an untrusted converter are not logical premises. No global kernel memoization is assumed.

For the batch statement, generic correctness of the positive normalized FFT, permutation and index (-j) mod 32 eliminates a need to reproduce the external independent direct-DFT cross-check inside the proof. It does not eliminate checking the numerical FFT arithmetic. Its 98,304 direct-DFT summands were an independence check of old centers, not a mathematical prerequisite once the verified FFT supplies that same transform theorem. The factor L=32 in reconstruction remains essential.

## 4. Explicit operation schedules, not timing forecasts

The following are counts for specified padded designs. They are not lower bounds. One complex product, one elementary series certificate and one rounding comparison are different units of work.

| Item | Rational batch | Direct, fresh phase at every center | Direct with checked height recurrence |
|---|---:|---:|---:|
| Elementary complex phase certificates | 1,024 main + 8 fresh B | 8,200 | 2,050 baseline/step |
| Main coefficient contributions | NKp = 393,216 moment contributions | JNK = 131,072 | 131,072 |
| Main log-power recurrence updates | N(K-1) = 15,360 | JN(K-1) = 122,880 | 15,360 |
| Residual-power updates | NK(p-1) = 376,832 | 0 | 0 |
| Height-phase products | 0 | 0 | (J-1)(N+1) = 7,175 |
| Normalized radix-two transforms | Kp = 384 | 0 | 0 |
| Butterflies | Kp(L/2)log2 L = 30,720 | 0 | 0 |
| Butterfly complex additions | 61,440 | 0 | 0 |

The batch counts use the new major budget's eight fresh B phases, not the old native producer's B-phase recurrence. The direct recurrence below is separately justified.

At the named gates, the batch uses 12,288 bucket roundings, 61,440 stage-output roundings, 128 final exact-Horner roundings, 128 correction roundings and 128 assembly roundings: 74,112 in total. Using 24 rounded Horner affine updates plus the final scaled-output gate instead gives 77,184. Exact Horner with one final gate is already permitted by the pinned budget and is the simpler proof schedule here.

The direct recurrence design uses 8,200 phase gates including rounded baselines, then 128 completed-main-sum, 128 correction and 128 assembly gates: 8,584. Elementary leaf gates and integer arithmetic inside gates are additional. Thus these totals cannot be divided to obtain a verifier speed ratio. The direct route has more elementary phase certificates than batching.

A common dense upper count for correction generation plus final coefficient assembly is J*((3M+2)K+K(K+1)/2)=7,488 multiplications, with at most that many additions under the retained schedule. This is not an additional independent copy of the assembly work already listed. Real scalings can be cheaper than general complex multiplication; this upper count does not price that distinction. The 17 final images use at most 17*(K-1)=255 complex Horner products and 255 additions, followed by 17 rectangle reciprocal/division operations and their positivity checks. Exact padding and comparisons are separate.

The elementary budget prescribes 512-term atanh formulas for reduced logs, 256 terms in each of two Machin arctangents, and 513-term real-exponential and cis formulas with four real-exponential squarings. A padded log design uses at most 1025*512 term visits plus 512 for shared log 2; exact log 1, powers of two and repeated reduced arguments allow removal of work. Each generic complex phase uses the two 513-term formulas; a unit-modulus step has real exponential exactly one. These are symbolic term counts. No rational witness generation or kernel execution has been measured.

## 5. A concrete direct phase-reuse error bound

This is a new paper alternative to the pinned budget's fresh phases, not a claim that its immutable old diagnostic phase balls are proved. Let epsilon=2^-512, eta=2^-1024. All elementary centers use grid 2^-1025; named subsequent gates use grid 2^-513, each with norm error at most epsilon. Fix Delta=-1/8 and each n=1..1025. The actual baseline exp(-c_0 log n) has magnitude at most one and the exact step exp(-i Delta log n) has magnitude one.

The pinned input estimates give baseline error below 2^13 epsilon before its named rounding. After that rounding e_0 <=8193 epsilon. A fresh step certificate has error below 2 epsilon, including log perturbation. Exact multiplication followed by one named gate therefore gives

    e_(j+1) <= (1+2 epsilon)e_j + 3 epsilon.

For j<=7 this is less than 2^15 epsilon. The companion checks this finite rational recurrence exactly. It is not an assumption that approximate steps are unitary.

Use the pinned estimates |loghat(n)^h/h!|<=2^45 and log-power error <2^46 epsilon. Each main summand error is below (2^15*2^45+2^46)epsilon <2^61 epsilon. The sum of 1,024 terms plus a completed-sum gate is below 2^72 epsilon.

For the full B correction, the exact polynomial Q has coefficient l1 norm below 2^48, while the truncated log-exponential coefficient array has l1 norm below 2^13 and perturbation below 2^13 epsilon. The reused B phase therefore gives correction error bounded by

    2^48*(2^15*2^13+2^13)epsilon + epsilon <2^78 epsilon.

Exact assembly, including S_(h-1), and its final gate is below 2002*2^72 epsilon+2^78 epsilon+epsilon <2^84 epsilon=2^-428<2^-53. For h=0 take S_-1=0. There is no residual p=24 truncation in direct evaluation.

This establishes sufficient accuracy of the proposed construction, not containment in arbitrary saved squares. New exact rational witnesses must actually be produced and their full enclosures compared to every immutable target. The same caution applies to batch input/output disks. An old successful FLINT run or overlapping intervals cannot replace that comparison.

## 6. Denominators: common grids prevent an unnecessary product

Write b=1025 and g=513. These bounds concern rational centers in the specified schedules; raw intermediate rationals are not silently rounded. If direct interval arithmetic is used instead, its endpoint schedule needs the corresponding bound.

On this grid the residual is exactly

    rhat_n = -loghat(n) - q_n*pihat/2.

It has denominator dividing 2^(b+1). At fixed h,m, every moment summand has denominator dividing

    D_(h,m) = 2^(b*(1+h+m)+m) h! m!.

Thus all 1,024 summands share a denominator. A uniform common denominator is 2^(39b+23)*15!*23!, of bit length 40,113. Summing N terms adds operations and possible numerator magnitude (at most log2 N=10 extra bits when summand magnitudes are uniformly bounded), not N copies of an unrelated denominator. A naive Fraction implementation can still incur costly GCD normalization or large temporary cross-products; these are implementation costs, not necessary exponential denominator growth.

After a moment gate the center is on grid 2^-g. An exact normalized butterfly with a twiddle on grid 2^-b has denominator dividing 2^(g+b+1)=2^1539. A stage gate resets it to grid g. Without intermediate gates, five stages instead have denominator dividing 2^(g+5*(b+1))=2^5643: growth with depth, not the number of butterflies.

Exact 24-term Horner at y=j/8 has common denominator 2^(g+3*23)=2^582 before multiplication by 32; cancellation may reduce it further. The direct main coefficients with phase grid g share 2^(g+15b)*15!, of bit length 15,929. One unrounded height-step product has denominator dividing 2^(g+b)=2^1538; its gate resets g. Omitting those gates would instead add O(Jb) denominator bits and requires an appropriate unrounded schedule, not the same gate count.

For the correction define D_c=10000, a common denominator of every real and imaginary center coordinate. Rising polynomials of length at most 31 have coefficient denominators dividing D_c^31. Let D_f be the least common multiple of denominators of the 16 exact factors [B_(2k)/(2k)!]*1025^(1-2k). The saved exact factors give D_f bit length 443. Then sufficient common denominators are

    D_R = lcm(2,D_c^31*D_f),
    D_Q = D_c*D_R,
    D_E = 2^(15b)*15!.

Their bit lengths are 855, 869 and 15,416. Every retained convolution coefficient has denominator dividing D_Q*D_E; the sum does not require multiplying sixteen unrelated copies. A fresh elementary B phase adds 2^b, giving bit length 17,309 before its gate. The direct recurrence's phase grid g gives a denominator 512 bits shorter. After the correction and main-sum gates, final assembly has common denominator D_c*2^g before its final gate.

These are denominator bounds, not complete bit-operation bounds. Numerators also depend on magnitudes. The pinned moment-center bound 2^80 and correction norms provide appropriate fixed magnitude estimates; an unscaled rising product may be as large as 2^341 in coefficient l1 norm. Elementary-series witnesses have their own exact rational denominators (odd atanh inputs, factorials and rational range-reduction data). For example, a 513-term exponential polynomial of a rational argument with denominator d (degrees 0 through 512) has common denominator d^512*512!. For a complex argument, first choose a common denominator for both coordinates and the same formula applies. If d=2^1025, this sufficient unreduced denominator already exceeds 524,800 bits before output rounding; rational phase inputs can additionally contain factors from sigma=629/1250, range reduction or real scaling. This is a common-denominator bound, not a claim that every reduced answer has that size. Naively evaluating the polynomial exactly may therefore be costly even though its returned center is dyadic. Atanh witnesses similarly involve powers of their reduced rational argument and the odd summation denominators. Alternative inner rounding would require its own proved error schedule and is not silently assumed. Their precise witness representation remains to be selected. Rounded dyadic leaves keep those heterogeneous denominators from propagating into every downstream moment. The note does not bound final proof-term bytes from denominator bits alone.

## 7. Certificate structure and verification work

A useful representation stores the fixed mathematical template, primitive certificates, shared dyadic centers, and explicit rounding/error inequalities. Three sound implementations have different storage/work profiles:

1. An explicit proof DAG proves rational arithmetic nodes and reuses named results. Its source size depends on sharing and proof combinators, not just arithmetic counts.
2. A reflective checker proves its soundness once and verifies finite witnesses by closed computation. A small proof expression can still entail substantial kernel reduction; that work is not removed by the word reflection.
3. A compressed template generates ordinary checked steps as a stream. This can avoid materializing every repeated instruction, but the expanded arithmetic must still be justified by the checker. A new arithmetic shortcut requires a soundness theorem and an explicit trusted-implementation boundary.

No choice here is automatically a stock MM0 artifact or an existing Lean implementation. Both systems can represent the mathematics; their accepted computation mechanisms and engineering choices must be specified before comparing cost. There is no established runtime ratio or fundamental capability separation in these symbolic counts.

For direct phase reuse, an n-major schedule needs one log, its 16 real normalized powers, a baseline, a step and a current phase, together with 128 accumulated main coefficients. After all eight center contributions for this n, that temporary state can be discarded. This avoids retaining N-by-p moment contributions. The final correction and images are small fixed arrays. Batch bucket accumulation similarly need not retain all 393,216 terms; 12,288 bucket centers suffice for a dense schedule, with proved empty buckets potentially compressed. Certificate input, arithmetic temporaries and kernel proof dependencies are additional storage. A proof checker does not automatically discard them merely because the numerical algorithm streams.

Certificate generation must find rational elementary witnesses and produce enough accuracy to fit the immutable targets. Acceptance must verify the exact input expressions, elementary remainder proofs, algebraic transformations, rounding inequalities, all required containment statements and final images. Generation and verification have different work; the existing native elapsed times measure neither future kernel verification nor rational certificate production. Serialization can also be compressed or streamed, so old JSON bytes are not a mandatory output-volume floor.

## 8. Smallest meaningful next slice and remaining obligations

For j=7, direct acceptance needs 1,025 phase expressions, 16,384 main coefficient contributions, all correction terms, all 16 exported squares, one complete panel and two endpoints. It exercises the full correction and analytic join at the largest time index without requiring an FFT proof. Its exact target-data subset is already identified, but its rational elementary witnesses and closed checker proof do not yet exist.

After that slice, all eight models and all 17 images must actually pass the same typed checker. If batch-record certification is also required, add a separate theorem for the bins, moments and normalized transforms; the direct-g result is an independent check of outputs, not a substitute for that theorem. This staged recommendation retains the full actual-image target and states explicitly which stronger algorithmic claim is postponed.

The source-to-g adapter, rational elementary soundness, fixed typed-data binding, EM/Cauchy interfaces and successful closed finite checks remain formalization tasks. No new analytic conclusion-shaped premise is proposed. The final Goldbach statement and its existing permitted inputs are unchanged. This design supplies arithmetic schedules and bounds, not a Lean proof, a standard-axioms certificate, a production throughput estimate or a spectral extension.

## Companion evidence

independent-feasibility/finite_em_rational_cost_inventory_20261111.py SHA256 B638E79245CADF189561F81D37393369A5A7D527628410C2462BA58386B35CB9.

Matching JSON SHA256 58FBCA32FBC3D472649EA4B3E31C6C9EB864408A83082346789F3E1FCD6B0782.

The script checks pinned bytes, saved-data sizes and partition counts, integer common denominators, symbolic schedule counts and the seven-step rational error recurrence. It does not evaluate an elementary function or establish any new target-value containment.
