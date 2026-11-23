# Original reciprocal edges: exact full-box diagnostic

2026-11-11. Of the 24 original exported reciprocal edges, **22 pass and two fail** the exact rectangle-containment test. All twelve `A=1/root` edges pass. Ten of twelve modular inversion edges pass. The two failures are imaginary upper bounds of `S_output=-1/input`, at zero-based `point0/step1` and `point1/step3`.

This resolves the previous coarse rule's inconclusive classification of these 24 edges. It does not prove an error in an intended analytic point value. The input and output boxes are unchanged, and full-box containment treats every point in the advertised input rectangle as admissible.

## Frozen files and scope

Paths are relative to `work/qrh-campaign/agents/prime-estimates/` unless stated otherwise.

| Item | File | SHA256 |
| --- | --- | --- |
| Original unchanged receipt | `principal_theta_modular_pilot_20261111.json` | `C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF` |
| Reviewed exact criterion | `COMPACT_RECIPROCAL_RECTANGLE_2026-11-11.md` | `53E2BCD126E06BCB280F579352BEB05BCB1C939AE4ACC97661F0525B3486434F` |
| Criterion implementation | `compact_reciprocal_rectangle_20261111.py` | `E32289AA8773520002804572C3F95B207850C41574A9BE45ECB178A8E632426F` |
| New diagnostic | `original_reciprocal_edges_20261111.py` | `1BF4CBF3EB3364FCABE7C19EB3B121228AF5F14884A005AFA944049B8449CF88` |
| New result and exact witnesses | `original_reciprocal_edges_20261111.json` | `12E011FD7F68CE6FFEC8BD8BF5659FD13A9EA804D0C8EFA35ECA7F70F27C6078` |

The criterion's independent review is `../independent-feasibility/REVIEW_COMPACT_RECIPROCAL_RECTANGLE_2026-11-11.md`, SHA `9E7C5548435232AA0660A568F0C6DEF5C0CB9F2DFD9184EDCCFAABDF8FE27675`.

The diagnostic hash-checks its unchanged receipt and criterion code. Its imports do not run producer main functions or write bytecode. It makes no analytic evaluations and does not regenerate lossless boxes. The independently accepted lossless seed supplement and two lossless reciprocal gates retain their separate status. Nothing here changes or reopens their seed proof. The older failed translation and root-component quotient checks are also unchanged.

## All 24 results

Indices are zero-based, matching JSON `points` and each point's `steps`. Only steps of kind S are listed. Each row contains two distinct gates.

| Point | T | r | Step | S_output = -1/input | A = 1/root |
| ---: | ---: | --- | ---: | --- | --- |
| 0 | 1000000 | 0 | 1 | FAIL: imaginary upper | PASS |
| 1 | 1000000 | 1/8 | 1 | PASS | PASS |
| 1 | 1000000 | 1/8 | 3 | FAIL: imaginary upper | PASS |
| 1 | 1000000 | 1/8 | 5 | PASS | PASS |
| 1 | 1000000 | 1/8 | 7 | PASS | PASS |
| 1 | 1000000 | 1/8 | 9 | PASS | PASS |
| 2 | 60343058 | 0 | 1 | PASS | PASS |
| 3 | 60343058 | 1/8 | 1 | PASS | PASS |
| 3 | 60343058 | 1/8 | 3 | PASS | PASS |
| 3 | 60343058 | 1/8 | 5 | PASS | PASS |
| 3 | 60343058 | 1/8 | 7 | PASS | PASS |
| 3 | 60343058 | 1/8 | 9 | PASS | PASS |

All input and output intervals are ordered, and all input rectangles exclude zero. Every edge is checked against the same four-residual criterion. The trace evaluates every residual row, even after an earlier row fails, then independently asserts agreement with the criterion's `accept` result. This duplicates some arithmetic intentionally.

## Exact violating witnesses

Write D(m,e)=m*2^e. For `S_output=-1/(x+iy)`, the imaginary coordinate is `y/(x²+y²)`. If U is the exported imaginary upper endpoint, its required inequality is

`U*(x²+y²)-y >= 0`.

The following actual corners have strictly negative residual. They therefore prove failure of full-box containment without division or approximate values.

### Point 0, step 1

Use both lower input endpoints, x=Lx and y=Ly:

```
x = D(31082640110290001034562265977759734291642114279939416787485936545745600507, -283)
y = D(60708342173671387607201965217808435159157101791576463842628617966873630781263, -274)
U = D(110428051976553759970936417665318956778545874191474027925765254722018971152823, -237)
```

The quadratic helper treats y as active and x as inactive. U>0, the inactive interval is positive so Lx is nearest zero, and both endpoint signs of `2*U*y-1` are +1. Thus the active minimum is Ly, the helper's `convex_left` branch. Its three exact terms `U*y²`, `U*x²`, `-y` have sum sign -1.

### Point 1, step 3

Use both upper input endpoints, x=Ux and y=Uy:

```
x = D(-27743109285744857869115102217620330334969303922818330930693089306727544297405, -255)
y = D(30196569266952301470394225329439219246883551791856912618742095887906936512573, -269)
U = D(65752932993384611641486981083925491019123649394980358720689780128433085060651, -268)
```

Here U>0, the inactive interval is negative so Ux is nearest zero, and both endpoint signs of `2*U*y-1` are -1. The active minimum is Uy, the helper's `convex_right` branch. Again the exact three-term residual has sign -1.

The result file retains all terms as signed-exponent dyadics, not a rounded sum, together with coefficients a,b, active axis, branch, endpoint-slope signs, positive clearing multiplier, and all tested candidates. It also stores a separate `violating_candidates` list. Neither actual failure needs an interior vertex or a rational witness. The generic schema supports such a vertex as numerator -b and positive denominator 2a, with a residual cleared by positive 4a.

For negative reciprocal gates the checker negates the output box before applying its 1/z rule. Each row records both `normalized_side` and `original_output_side`; the two failures are normalized imaginary lower bounds but **original imaginary upper bounds**. The table above uses original sides.

## Reproduction and resource evidence

From the repository root, run:

```
python work/qrh-campaign/agents/prime-estimates/original_reciprocal_edges_20261111.py
```

This writes only its new result file and prints a compact edge summary. For a read-only replay of the frozen result, import the diagnostic under a fresh module name, call `run()`, and compare with the saved JSON after omitting its `script_sha256` field. The result has no timing or nondeterministic fields.

The bounded run completed with exit 0. This means the diagnostic and its internal agreement checks completed, not that every edge passed. The status and two failures remain explicit.

The run used 948 at-most-three-term sign calls, 3084 products, and 288 comparisons, including trace/criterion duplication. Maximum working mantissa was 768 bits, maximum signed-exponent bit length 10, and maximum guarded left shift 533 bits. It used no Fraction evaluations, floating-point values, transcendental functions, Lean, or external process other than Python. Imported regression/oracle definitions were loaded but not called. These figures are external arithmetic observations, not Lean runtime predictions.

The useful distinction is now exact: the earlier coarse reciprocal rule overestimated enough to reject all 24 tests, whereas the exact rule accepts 22 and exhibits corners excluded by the remaining two output boxes. A producer may preserve correlations for its intended analytic point or may compute on different internal ball bounds. This diagnostic supplies no such dependency certificate and asserts no point-value contradiction.
