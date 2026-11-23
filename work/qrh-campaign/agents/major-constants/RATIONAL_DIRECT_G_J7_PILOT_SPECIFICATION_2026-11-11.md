# One rational-only direct-g acceptance experiment at j7

2026-11-11. Paper preflight, not execution authorization. No elementary values, evaluator code, coefficient arrays, transforms or Lean files were produced. This specifies one producer attempt and one mandatory independent verification attempt. It makes no runtime prediction.

## 1. Immutable target and exact claim

Use the existing candidate `integration/small_em_batch_candidate_20261111_01.json`, SHA256 `2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E`, as untrusted proposed output data. The target consists of exactly:

* `g_jets[7]`: all sixteen normalized complex-s coefficients G(h,7), h=0,...,15, inside their unchanged coordinate squares of halfwidth 2^-52;
* `panels[7]`: the unchanged rectangle for every actual zeta value on Re(s)=629/1250, Im(s) in `[1999,15993/8]`;
* `endpoints[7]` and `endpoints[8]`: the unchanged rectangles at heights 15993/8 and 1999, both owned by model 7.

The center is exactly

```
c=629/1250+i*31985/16.
```

The panel is c+i*[-1/16,1/16]. Its upper endpoint is index 7 and its lower endpoint is index 8. The immutable specification also fixes N=1024, B=1025, M=16, K=16, outer radius 1, and target radius 1/16. Coefficients are derivatives in complex s divided by h!, not height derivatives.

Acceptance concerns only direct finite-g and actual-zeta images. It does not certify any old bin, residual moment, FFT, normalized-transform disk, B-phase recurrence, other center, other panel or nonvanishing assertion. It is an incomplete first slice of the larger actual-image objective; the other seven centers still require their own acceptance instances.

The old file hash binds the intended bytes. The mathematical target is the separately checked literal parameters and exact target endpoints. A future Lean theorem would require a verified interpretation of those literals; a hash or Python decoder is not a theorem.

## 2. Accepted paper inputs

All paths are relative to `work/qrh-campaign/agents/`.

| Input | SHA256 |
| --- | --- |
| `integration/FINITE_EM_RATIONAL_CHECKER_BLUEPRINT_2026-11-11.md` | `F6B784776E24F767FA3A45C3006394F0E718FF491712077FC9EBDC74EDE92F22` |
| `audit/REVIEW_FINITE_EM_RATIONAL_CHECKER_BLUEPRINT_2026-11-11.md` | `C62EEA09A4C1871E15FAB18EB3A3525777022E106F1AB39318F674D0272B448F` |
| `independent-feasibility/FINITE_EM_RATIONAL_PROOF_COST_DESIGN_2026-11-11.md` | `19DB61735647D0267954692733C2CF045B977D540A4CF55B5DBDB1145EE82CB8` |
| `zero-sum/REVIEW_FINITE_EM_RATIONAL_PROOF_COST_DESIGN_2026-11-11.md` | `022C335200DCD43E6E9639E978F122F5619199B3EBCC2B98F7B997C1328C8D8E` |
| `major-constants/FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md` | `60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9` |
| `zero-sum/REVIEW_FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md` | `E2AFC3467382506F4D68CDB9E7AA0307C911B0F2195032E505C4EC8E69D6401B` |
| `major-constants/FINITE_EM_RATIONAL_ELEMENTARY_BUDGET_2026-11-11.md` | `50D1FFB0385A0F2FCE3BA9EF3BBB4FFD3BAC5A0103E95A8329E79A25D524A541` |
| `major-constants/EM_SMALL_BATCH_FULL_BUDGET_2026-11-11.md` | `47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23` |

Their pinned source remains Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. The source EM, elementary-function, finite coefficient and Cauchy bridges are retained. An external successful experiment would remain conditional on these paper derivations and sound implementation until those bridges and the closed arithmetic acceptance are formalized.

## 3. Complete finite expression

For all sixteen orders compute the coefficients at c of

```
D(s)=sum_(n=1..1024) exp(-s*log n),
C(s)=1/2+sum_(m=1..16) b_m*B^(1-2m)*(s)_(2m-1),
Q(z)=(c-1+z)*C(c+z)+B,
g(c+z)=(c-1+z)*D(c+z)+exp(-c*log B)*exp(-z*log B)*Q(z),
b_m=B_(2m)/(2m)!.
```

The exact B in Q supplies the pole-removal term B^(1-s). The half term and every signed Bernoulli term are required. The last correction has rising length 31; the EM remainder has length 32. Powers B^(1-2m), factorials and Bernoulli coefficients are exact rationals.

The producer forms rising coefficients by the reviewed old-array affine recurrence. It forms every exponential coefficient from `E_n,h=exp(-c*log n)*(-log n)^h/h!`, sums the head directly, and uses exact truncated convolution for Q times the B exponential. For h=0 set D_-1=0; for all h use `(c-1)*D_h+D_(h-1)+correction_h`. No p=24 residual approximation is used in this direct route, so its analytic batching tail is not added.

## 4. Producer arithmetic and required leaves

The producer uses only integer/rational arithmetic and the accepted finite elementary series. No FLINT/Arb, mpmath, floating-point log/exp/trig, built-in zeta, or opaque special-function answer may supply arithmetic evidence. Floating-point OS telemetry is not an arithmetic input.

For every n=1,...,1025, require a log record and a phase record for exp(-c*log n). The n=1 records are the exact identities 0 and 1; powers-of-two reductions may reuse the proved log2 cache, but no required record is omitted. B=1025 has its own required phase for the complete correction. There are no FFT twiddles in this experiment.

Use the accepted producer parameters

```
eta=2^-1024, epsilon=2^-512, inner delta=2^-1040.
```

Logs use 512-term atanh Horner with the unfinalized inner-grid log2 cache. Pi uses two 256-term arctangent Horner evaluations and exact Machin combination. Real exp uses a 513-term normalized Horner polynomial after division by 16 and four rounded squarings. Cis uses exact integer period reduction against the canonical pi center and a 513-term complex Horner polynomial at the reduced rational argument. All inner gates are those of the accepted inner-rounding note. Canonical elementary centers use grid 2^-1025.

Every canonical log has norm error below eta; each complex exponential at its exact rational argument has error below 2^16*eta<epsilon. The separate log-input perturbation is retained when constructing the actual phase exp(-c*log n). Publish each actual phase center with radius `2^13*epsilon`, not merely epsilon: the latter would forget the log-input uncertainty. These phase radii are checked against the actual positive-base powers.

The main log powers, direct sums, rising-polynomial construction and convolutions are exact rational arithmetic between named gates. A completed head coefficient, a completed full correction coefficient and a final assembled coefficient may each have one rounding of norm at most epsilon, with grid step epsilon/2. No other finite-g rounding is admitted unless a new proved aggregate bound is part of a separately reviewed version.

The accepted bounds imply a direct head coefficient error below 2^70*epsilon and complete correction error below 2^78*epsilon. Exact assembly and its last gate give

```
|computed_G_h-actual_G_h| <2^84*epsilon=2^-428.
```

This follows from phase error below 2^13*epsilon, log-power magnitude at most 2^45, log-power error below 2^46*epsilon, 1024 head terms, the scaled Q norm below 2^48, and the B exponential coefficient l1 bound below 2^13. It uses no direct-height recurrence or time transform. Publish a fresh norm ball of radius 2^-420 around each new G center; the looser radius leaves explicit independent-containment room. The immutable old coefficient squares are not replaced by these new balls.

## 5. Mandatory independent rational construction

The independent job uses a separately implemented forward-term and sum elementary algorithm, not the producer's normalized Horner evaluator. It recomputes pi, all 1025 logs and all 1025 actual phases from their exact inputs. It may share the mathematical source identities, but must not call or import the producer's evaluator routines or treat its leaf centers as known values.

Choose fixed independent parameters

```
deltaI=2^-1080, etaI=2^-1056, epsilonI=2^-544.
```

The independent inner grid is 2^-1081 and its canonical elementary grid is 2^-1057. Its outer named gates use grid epsilonI/2 and norm error at most epsilonI. The finite lengths remain 512 log terms, 256 arctangent terms and 513 exponential terms. The following bounds justify this distinct schedule rather than borrowing the producer's Horner error formula.

### Forward exponential

Start exact term u_0=1 and accumulator S_0=1. For j=1,...,512 compute `u_j=z*u_(j-1)/j`, round with error at most deltaI, then compute `S_j=S_(j-1)+u_j` and round with error at most deltaI. The exact target term is z^j/j!. If |z|<=R, its term error obeys

```
e_j <= (R/j)*e_(j-1)+deltaI, e_0=0.
```

Unrolling bounds e_j by exp(R)*deltaI, since every product of consecutive positive integers is at least the factorial of its length. Accumulating all 512 perturbed nonconstant terms and 512 sum gates gives polynomial error at most `512*(exp(R)+1)*deltaI`.

For R=1/2 this is below 2048*deltaI; for R=4 it is below 41984*deltaI. Add the same analytic Taylor tails as the producer. Four rounded real squarings give

```
e_real <=81*[2*(1/2)^513/513!]+165928*deltaI<etaI.
```

The small-error condition before every square follows from this positive bound. The independent pi error is at most etaI, and |k|<2^12 still holds, so the cis error is at most

```
2*4^513/513!+41984*deltaI+2^13*etaI.
```

One exact final product and canonical rounding at most etaI preserve complex primitive error below 2^16*etaI<epsilonI. Both term and sum roundings are counted.

### Forward logarithms and arctangents

For logs, form rounded powers a_j=t^(2j+1) by starting from t and repeatedly multiplying by exact t^2, with one deltaI gate per power. Their errors are at most 9*deltaI/8. For each j compute `2*a_j/(2j+1)` with a deltaI gate, then add it to the accumulator with another deltaI gate. The complete 512-term error is at most

```
512*(2*(9/8)+2)*deltaI=2176*deltaI.
```

Cache the independent internal log2 result before canonical rounding and assemble k*log2+logu exactly. The at most eleven weighted copies therefore contribute at most 23936*deltaI. Adding the unchanged log tail and final etaI/2 rounding gives error below etaI.

For each Machin component use rounded signed powers `a_j=(-1)^j*t^(2j+1)` with ratio -t^2. Their error is at most 25*deltaI/24. Division by 2j+1 and each accumulator update add one deltaI gate. The 256-term error is at most `(2336/3)*deltaI`. Weighted by 16 and 4, it is at most `(46720/3)*deltaI`. The unchanged Machin tail and final etaI/2 rounding again fit etaI.

The scalar tail comparisons need no function evaluation. For example, `3^5>2^7` gives `3^1025>2^1435`, while `5^10>2^23` gives `5^513>2^1179`; the old log and pi tails are thus below etaI/16. Also `513!>=128^386=2^2702`, so `2*4^513/513!<=2^-1675`. The remaining deltaI/etaI ratio is exactly 2^-24. These inequalities prove every displayed independent budget with room.

### Independent complete g coefficients

The independent job uses explicit normalized log powers, direct head summation in reverse n order, and separately implemented polynomial products for the rising factors and complete correction. No time-bin or residual formula is used. Exact rational grouping may differ from the producer, but the actual finite function is the same. Every signed Bernoulli coefficient is checked against its rational recurrence and every retained polynomial index against its mathematical degree convention.

Repeating the direct-g bounds with epsilonI gives full coefficient error below `2^84*epsilonI=2^-460`. Publish independent norm radii 2^-450. This radius is not an assumption about a 544-bit floating-point computation: it follows only after all the independent rational gates and remainder comparisons pass.

## 6. Required independent containment and exact images

The independent job must check all 1025 producer log records and phase records against its independently proved enclosures. For each real log, use endpoint containment. For a phase disk, a rational L1 distance of the centers plus the independent radius is a sufficient check against the producer's declared norm radius. It must also verify each of the producer's sixteen fresh G balls using its independent G enclosure. Overlap is never sufficient.

For each h, both jobs separately prove full containment in the old coordinate square. If q is a new center with proved norm radius r, require for each coordinate k

```
old_lo[k] <= q[k]-r <= q[k]+r <= old_hi[k].
```

The independent job must establish these inequalities from its own enclosure even if it has already checked the producer's fresh ball. These comparisons are finite claims about the actual immutable data; the scalar accuracy targets alone do not guarantee them.

Reconstruct each of the three target images from the unchanged old coefficient squares, not from a new narrow polynomial or a selected midpoint. For the panel use `z=i*[-1/16,1/16]`; for the endpoints use the singleton z=i/16 and z=-i/16. Perform exact rational rectangular Horner. Add exactly

```
E_EM=4*2003*33/(63/2)*(2034/(6*1025))^32,
E_Taylor=2^-33/15
```

once to each coordinate radius. Divide by the whole rectangle `s-1`, whose real part is 629/1250-1 and whose imaginary part is the panel height interval or endpoint singleton. Use the old four-corner rectangle multiplication and the unary square bound for the denominator norm. Its lower norm-square bound must be strictly positive. No optimized reciprocal, midpoint quotient or extra error pad is substituted.

Both independently implemented reconstructions must equal the literal target rectangles exactly. The scalar 2^-44 bound is a bound on error, not on the image's natural width. There is no additional 2^-64 pad in these exact rational reconstructed images, and coefficient uncertainty is not added twice.

The reviewed finite-EM identity and Cauchy result then imply actual zeta containment at every point of the closed panel and at both endpoints. This is a mathematical implication from the coefficient and exact interval checks, not an inference from sampled values. No pixel, screenshot or decimal agreement is an acceptance input.

## 7. Compact witnesses and deterministic reconstruction

Do not emit roughly a million redundant Horner gate objects. Use a fixed typed template and canonical deterministic signed nearest-grid rule. Record:

1. The independently fixed target manifest, source and design hashes, exact parameters, all sixteen old squares and all three old image rectangles. Reject duplicates, missing indices, alternate owners and malformed rationals.
2. Exact log reductions for every n, the shared internal log2 policy, elementary lengths, grids, tail comparisons, pi record and canonical log centers. Include every phase's exact input expression, canonical center, norm radius and period-reduction integer.
3. The exact Bernoulli table, normalized finite coefficient convention, sixteen fresh G centers/radii, and complete source-to-output error ledger. Lists of phase values without their input labels are invalid.
4. Every coefficient and leaf containment result with exact rational witnesses or distances, and the exact three image reconstructions. Store failures as failures; do not drop them from a summary.
5. Attempt status, operation counters, verified reconstruction digests, peak-resource telemetry and logs within the output cap.

A deterministic replay must reconstruct every omitted producer gate and check its exact rounding/error rule, either directly or by executing a separately implemented typed template whose soundness conditions are all verified. A digest detects changed reconstructions but is not the proof of their arithmetic validity. The independent forward calculation is additional to this replay and cannot be replaced by hashing the producer result.

This compact receipt is not a standalone Lean proof trace. A future formal checker needs a proved interpretation of the templates and rounding rules and a closed kernel-checked acceptance instance. The present experiment could supply checked rational evidence and test the design; it would not by itself establish a theorem in Lean or remove the source analytic proof obligations.

Rational input parsing rejects zero/negative denominators, duplicate JSON keys, noncanonical integer forms where the schema requires them, reversed intervals, invalid exponents and excessive integer sizes. Proposed per-integer magnitude limit is 65,536 bits; this is a fail-closed input/work bound, not a claim that every intermediate automatically fits. Any exceedance yields incomplete status. Intermediate rational normalization must not silently switch to floating point.

## 8. Fixed attempts, independence and negative controls

After source/code preflight and separate execution authorization, run one producer attempt with a total launch-to-exit deadline of 600 seconds, then one independent attempt with a total launch-to-exit deadline of 900 seconds. Each complete process tree has a 512 MiB peak working-set cap and a 16 MiB aggregate retained-output cap, including partial checkpoints and logs. The independent job reads the immutable target and producer receipt but does not call producer evaluator code. Both arithmetic jobs are single-process and use no numerical worker subprocesses.

An external supervisor enforces deadlines and monitors memory from launch through exit. Complete OS peak telemetry below the cap is required; missing or invalid telemetry is incomplete. Sampled monitoring does not prove that transient overshoot was physically prevented. Reserve output space for final status before beginning work. No automatic restart, higher precision, alternative truncation, relaxed enclosure, omitted input or resumed second attempt is authorized. Resource or accuracy failure preserves bounded partial evidence and reports incomplete status. These caps deliberately permit failure and imply no expectation of completion.

Within the same attempt, include bounded negative controls against the actual acceptance checks: changed center/index or endpoint owner; omitted n=1024 or B pole term; a changed signed Bernoulli coefficient; an elementary center shifted outside its certified radius; invalid rounding witness; an omitted analytic tail; and a changed immutable target endpoint. Controls may reuse already proved elementary enclosures, but each must reach the relevant checking rule. Altering the target manifest must be rejected even if the replacement box is wider. A test that merely parses a bad flag does not test arithmetic acceptance.

The code-review record must distinguish arithmetic code shared only for exact rational infrastructure from the two elementary algorithms and independently implemented finite-g/image assembly. Any shared evaluator logic is disclosed. No random sampling of leaves, coefficients or endpoints is permitted.

## 9. Completion boundary

PASS requires both jobs to finish within all caps, check every specified gate/leaf and all sixteen coefficients, and establish all three exact image reconstructions with the required independent full-containment comparisons. The result must be described as rational external acceptance evidence for this direct-g j7 slice, conditional on the reviewed analytic source plan and sound implementation. It is not a Lean theorem, a full eight-center certificate, a verification of old batching internals, or a zero-free result.

No missing precision estimate remains in this paper specification: producer estimates are inherited from the accepted inner-rounding plan, and the distinct independent forward-sum errors are derived above. Successful actual witness generation, immutable-target containment, resource compliance, code correctness and formal kernel acceptance remain unproved. This note is frozen for review before any implementation or execution step.
