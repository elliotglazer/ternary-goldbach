# Independent review of the synthetic weak-strip checks

2026-11-11. **PASS for bounded polynomial method validation.** All 14 supplied contour records, comprising 225 complete panels, passed an independent exact rational replay. The argument uses whole-panel enclosures and exact winding, not a root plot or sampled zero count. The sign-count obstruction, multiplicities, real-boundary equality handling, and closed-height treatment are correct. No substantive correction is requested.

This supplies no spectral evidence for any actual Dirichlet character, no Lean theorem, no verified general-purpose parser, and no family-wide termination result. No actual L-function scan, Lean build, dependency change, canonical source edit, or producer-file mutation was performed.

## Frozen inputs and independent output

All producer files are under `work/qrh-campaign/agents/zero-sum/`.

| Producer file | SHA256 |
| --- | --- |
| `FAMILY_WEAK_STRIP_SYNTHETIC_CHECK_2026-11-11.md` | `78CA1AD1AB4A2FFEC1BF6B45730EE97632BC4ADCA08A1F413A5CF43A7BFB26F4` |
| `family_weak_strip_synthetic_20261111.py` | `CABE7EF7CE948C6F1784191264FB149C5D009AA9D4F59BD7ACD7C70FBFFCE296` |
| `family_weak_strip_synthetic_20261111.json` | `8BBDDA6E2F60AE21C77128F624910928841D509E79EA78BFE45805F66C54865C` |

I read the complete note and code and verified these hashes. The producer script was not imported or executed during independent replay. The reviewer program reads the frozen JSON, performs its own arithmetic, and checks the input bytes remain unchanged.

Reviewer artifacts beside this report:

| Reviewer file | SHA256 |
| --- | --- |
| `review_family_weak_strip_synthetic_20261111.py` | `52EFB2EE0D2E8D9339FB2823CD6B29703B24D8BA3CA5780D3E8F0877C741F33B` |
| `review_family_weak_strip_synthetic_20261111.json` | `2F6E9E7236B73823F80BDFAEE55BC9438A2670DF726414336662E130BFF29EB4` |

The command `python work/qrh-campaign/agents/audit/review_family_weak_strip_synthetic_20261111.py` completed with exit0 and `PASS_INDEPENDENT_RATIONAL_REPLAY`. All operations relevant to acceptance are rational/integer operations.

## 1. Whole-panel enclosures are genuine

For a polynomial of degree n restricted to an affine complex segment, the producer correctly computes its power coefficients and converts to degree-n Bernstein coefficients by

```
B_k=sum_(j<=k) q_j*binom(k,j)/binom(n,j).
```

The Bernstein basis weights on [0,1] are nonnegative and sum to1. A strictly positive common coordinate bound for every B_k therefore holds at every point of the analytic panel. The four coordinates Re,-Re,Im,-Im are exactly four rotated real half-planes. The positive minimum is recomputed during replay; it is not accepted as unverified receipt metadata.

The independent program uses a different construction. For each degree it builds the rational Bernstein evaluation matrix at n+1 distinct rational parameters, computes its inverse, and checks the exact matrix-inverse identity. It evaluates the polynomial directly by Horner's rule at those parameters and recovers the Bernstein coefficients through that inverse. These are coefficient-identifying evaluations: equality at n+1 distinct parameters identifies two polynomials of degree at most n. The acceptance argument remains the Bernstein convex-hull bound over the **entire** interval, not an inference from sampled positivity.

All independently reconstructed margins exactly match the receipt and are strictly positive. The exact polynomial endpoint images also match and lie in the same half-plane. Hence their chords avoid zero. Since here the image vertices equal the actual endpoint values exactly, analytic panels can be deformed to their chords inside the common convex half-plane with their endpoints fixed. This is a simpler special case of the accepted generic polygon connector proof.

## 2. Geometry and winding are independently checked

The replay requires the four sides in counterclockwise order, correct fixed coordinates, strictly monotone variable coordinates, exact adjacent endpoints, completion of every whole side, and cyclic closure. It rejects omitted or reordered panels. It verifies each stored endpoint image by direct polynomial evaluation.

For winding, the producer uses the accepted half-open determinant rule. The independent replay instead computes the rational real-axis intersection for each upward or downward crossing and tests whether its real coordinate is positive. The resulting integer sums match all supplied windings. The strict panel certificates preclude a chord crossing through zero, so the potentially ambiguous zero intersection cannot occur in an accepted edge.

The entire polynomial and nonzero boundary satisfy the mathematical argument-principle hypotheses. Consequently the winding counts actual interior zeros with their full analytic multiplicities. Because the boundary is certified nonzero, there is no hidden boundary contribution. The stored expected winding is compared against a newly computed sum; it is not itself the evidence for the count.

## 3. Results and multiplicity cross-checks

Write q_a(s)=(s-a)^2+1. The independent program also expands products of the exact linear factors and matches the full stored coefficient arrays. This separately verifies every asserted root and multiplicity, without using approximate root solvers.

| Polynomial fixture | Full winding | Forbidden-right winding | Upper/lower cluster windings | Ordinary sign count |
| --- | ---: | ---: | ---: | ---: |
| q_(27/50) q_(23/50) | 4 | 0 | 2,2 | 0 |
| q_(1/2)^2 | 4 | 0 | 2,2 | 0 |
| q_(1/2)^3 | 6 | 0 | 3,3 | 2 |
| q_(111/200) q_(89/200) | 4 | strict original contour inapplicable | deflated-right winding0 | not used |

The first three rows give the 12 principal contour records. The fourth adds the full count and deflated-right count, making 14 records total. Their 225 panels all pass.

The upper and lower cluster rectangles are disjoint, are contained in the enclosing rectangle, and have right edge11/20<111/200. Their counts sum to the enclosing count. Count additivity and nonnegativity therefore exclude any unaccounted zero in that enclosing region without requiring simple roots. The separate exact global factorization checks establish that these constructed polynomials have no additional roots elsewhere; the cluster completeness argument itself only needs the specified enclosing count.

The ordinary sign counts are established analytically, not by the replay's sample values. On s=1/2+it the first polynomial equals

```
(1+delta^2-t^2)^2+4*delta^2*t^2, delta=1/25,
```

which is strictly positive: simultaneous vanishing would force t=0 and then a positive first term. The second polynomial is (1-t^2)^2 and never changes sign. The third is (1-t^2)^3 and changes sign exactly at t=+-1; its actual multiplicity at each point is3. Thus each fixture has a structural missing multiplicity4 for ordinary disjoint strict sign brackets. No precision increase can make a sound upper count U satisfy U<K+1 for those ordinary lower counts. This does not contradict the soundness of the sign method; it demonstrates its stronger requirements.

## 4. Exact real-boundary equality and target-height endpoints

For b=111/200, the fourth polynomial has zeros b+-i on the left edge of its forbidden-right rectangle. The receipt records exact zero values and edge membership. It does not falsely supply positive whole-panel margins there. The independent program rechecks both statements. This is a mathematical witness that strict boundary certification is impossible, not merely an adaptive algorithm timing out.

The extra algebraic remedy is valid for this constructed fixture: q_b has the exact complete factors s-(b+i) and s-(b-i), and the remainder is q_(1-b). The removed zeros satisfy the allowed equality Re=b. The remaining factor has a certified zero-winding forbidden-right contour. Together they establish the weak inequality. This relies on the exact factorization; shrinking intervals toward b, or shifting the contour right, would not prove the same fact for an unknown analytic zero.

Every listed root has imaginary part+-1, exactly the closed target height H=1. The accepted enclosing contour uses T=3/2>H, so these roots are interior and are retained in the count. The cluster boxes straddle those ordinates inside the larger enclosing rectangle. Their temporary extension beyond H is harmless because the certified conclusion on the larger domain implies the requested closed-height conclusion.

The separate H=1 contour-failure record supplies actual boundary-zero witnesses and is rechecked. It is not necessary for that record to list every boundary zero: one verified boundary zero already disproves the strict nonvanishing premise. No downward rounding of the target height occurs.

## 5. Rejection checks and limits

The independent replay rejects six modified copies of an otherwise valid record: zero stored margin, missing panel, wrong winding, wrong endpoint image, reversed panel order, and invalid coordinate index. These are bounded controls for the implemented checks, not a proof of arbitrary malformed-input safety. The producer uses Python assertions and is not claimed to be a hardened or formally verified parser; its ordinary invocation and exact finite records are the scope here.

The generic polygon/argument-principle implication remains the previously reviewed paper theorem. The new experiment validates its finite polynomial inputs, whole-panel and geometry obligations, and the distinction between sign counting and multiplicity-aware strip certification. It creates no new mathematical premise for Goldbach and no evidence for an actual L-function row. Full Dirichlet application still needs the exact analytic-function adapter, convergent whole-panel evaluator, complete domain coverage, arithmetic character bookkeeping, and formal replay.

**Final verdict:** accepted as a sound external rational regression suite for the weak-strip alternatives, including the intended failure modes. No actual family spectral or Lean closure claim follows.
