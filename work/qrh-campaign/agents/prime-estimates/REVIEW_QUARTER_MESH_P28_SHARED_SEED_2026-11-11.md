# Independent review of the quarter-mesh P28 seed construction

2026-11-11. PASS for the conditional paper construction and exact arithmetic schedule. No correction requested. The final source mesh D4096 with P28, followed by three translations per interval and coefficient rescaling, supplies the same D_out8192-normalized P20 output mesh as the accepted D8192/P27 comparator. This conclusion includes the separately bounded analytic shift bias. It is not a claim that numerical-radius-only balls enclose the exact shifted derivatives.

## Frozen evidence and checks

Author objects are under `work/qrh-campaign/agents/zero-sum`.

| Object | SHA256 |
|---|---|
| QUARTER_MESH_P28_SHARED_SEED_2026-11-11.md | A0CD531E1FD20280E49B1EC0AE95E32809C7965222C40916BD4712F7F3A5EA19 |
| quarter_mesh_p28_seed_20261111.py | E16148F355192110DE6A339572F1982F40396FEAE250398041B25016B52F262D |
| quarter_mesh_p28_seed_20261111.json | B78FB6A57D6261EEC59D08D8EA4D0121489644C5D09A52E4BBC51E35DD99A9BE |

I read the complete note and script, then compared the function, derivative, scaled EM, translation, height and elementary domains with the six pinned input objects. All six input hashes and the three author hashes match. The D8192 comparator was independently reviewed in `REVIEW_RETUNED_FINAL_SHARED_SEED_BAND_2026-11-11.md`, SHA256 `6D5AA23A7050AC5C54E103AFD9C33BBAF5AF84836FCB7DD05FDD50CA9853BCFF`.

My independent script passed 72765 integer/Fraction checks. These include every fine-anchor/source choice, all three signed translation matrices reconstructed backwards, every rounding-error injection into each of the twenty outputs, all four work ledgers, setup blocks, actual-function remainder envelopes and error allocations. It imports no author code and evaluates no analytic function, seed, transform, prime or zero.

| Independent object in prime-estimates | SHA256 |
|---|---|
| review_quarter_mesh_p28_20261111.py | C7046F0A9E6A0934BE66AA58C56E7B1A252F097FD106E9E05A430E2470DE1743 |
| review_quarter_mesh_p28_20261111.json | A4C283ACBB82084708A7215ED78037D1D549FC05E05F74AF9A70BF4C5DDCF47F |

## Exact mixed normalization and boundaries

Source coefficients are `U_j=f^(j)(a)/(4096^j j!)`. A target output coefficient has normalization `8192^k`. Its finite source-polynomial approximation is therefore exactly

`2^-k sum_(j=k..27) binom(j,k) U_j tau^(j-k)`.

The factor `2^-k` is essential and is correctly retained both mathematically and in the work counts. The source-coordinate translations are `1/4,1/2,-1/4`; the third uses the right coarse endpoint. The pruned triangular loop remains algebraically valid for negative translation. Its inner order is increasing, so it uses the required prior-stage neighbor.

There are 4097 unshifted outputs and 4096 outputs at each of the three nonzero offsets. They partition all 16385 required fine anchors, including zero and one. The final negative-quarter translation consumes the high derivatives at source anchor one. Thus generating P28 at all 4097 source anchors is necessary for this schedule; the old P20-only right-endpoint shortcut would be invalid.

Nearest-anchor target cells satisfy `|8192(alpha-b)|<=1/4`. In source units this is `|4096(alpha-b)|<=1/8`, giving total source-shift plus target distance at most `5/(8*4096)`. Every source-to-output and output-to-target segment stays in `[0,1]`; no endpoint wrap is used.

## Analytic and numerical errors

The accepted continued-Hurwitz derivative identity applies to actual f. At derivative order P, the resulting series is absolutely convergent and gives `|f^(P)|<2(V+P)^P`. Taylor's remainder applied to each derivative, followed by the positive binomial sum, yields exactly the stated shift bound with the combined distance `5/(8D)`. It is valid for either sign of translation. The separate P20 target remainder uses the unchanged output scale 8192.

I independently obtained the same target and shift fractions. P28 closes the complete value budget. The P27 shift envelope alone exceeds `2^-82`, as does the deliberately tested naive coarse P20 envelope. Neither failed bound proves that the corresponding actual error is large. The disclosed failed stronger `2^-85` check is irrelevant to the actual required allocation and is not silently credited.

The complete EM expression, all 64 signed corrections and the pole-type term are preserved. At `s=1/2+it`, `|s+k-1|>=1/2`, including t=0. N2387 still bounds every required rising factor by W7160, including the additional P28 order and E index154. The E and lambda recurrences retain their old contraction bounds. The R recurrence changes: its true magnitude is below two and its later factor is below 7/8. The updated 8u error invariant is sufficient. The initial factor acts on an exact initial value, so it does not amplify an earlier error.

The recalculated source error, including head, endpoint, final rounding and actual-function remainder, is

`(448264581/2852126720) eta < eta/4`.

For the translated numerical error, the final scaled row has absolute sum at most two. More sharply, each single suffix entry after rescaling is bounded by `binom(j,k)/2^j<=1`. I independently verified every injection by reverse propagation from each consumed output; the maximum is exactly one. This justifies charging 350u_T rather than an unproved small operator norm for the entire loop. The one final conversion round is included. The output numerical error is

`(937081221/1426063360) eta < eta`.

This radius is relative to the finite translated polynomial formed from the actual source derivatives. The exact shifted derivative can differ by the separately retained analytic bias. The note states this distinction explicitly. After the target Horner evaluation and character normalization, coefficient error costs at most844eta and its product/add rounding at most1688u_H. Adding both analytic remainders gives less than .16 of `2^-82`. There is no double charge or omission of translation rounding.

The magnitude argument uses `C A^k/k!`, A<7/4, and the positive translation matrix. It gives all intermediate ideal coordinates below6C. The coarse `2^28` perturbation estimate is less than one, leaving `6C+1<2^16`. Signed shifts obey the same absolute majorant. This is a stored-center bound, not a bound on exact arithmetic temporaries.

## Argument reuse, height recurrence and work

The final source argument union is `1+j/4096`, with `0<=j<=2388*4096`, hence 9781249 points. It contains the earlier D4096 grid through1722 exactly. No source argument at an intermediate output anchor is required: those outputs are produced by polynomial translation. The finer output mesh therefore does not force the source elementary grid back to D8192.

All four requested height prefixes and their auxiliary extensions are unchanged. The maximum height remains `432705/64<7000`; initialization, log accuracy and step propagation remain within the accepted leaf domains. The fine-state recurrence must still retain its own grid and copy separately into EM. The argument-count reduction does not justify changing that rule or its precision.

The new elementary block partition has1002 anchors. This is correctly charged as one more anchor than the comparator, despite having fewer points. Degree21 log work is205385187 stages. Raw state-plus-step storage is704249928 bytes, with the same exclusions as before. Neither number includes proof-object memory or complete generation/checking cost.

Every final-band height generates28 coefficients at4097 anchors. The ledgers correctly charge154 E stages per anchor, all correction terms, three350-stage translations per interval, and20 rescaling/rounding operations at each of16385 output anchors. Lower bands remain unchanged. The final output count exactly matches the comparator in all four scenarios.

The main schedule saves5352816927304 head reciprocal scales while adding34985533440 translation updates and7176957700 final scales plus the same number of final rounds. Its shared R recurrence gains one step per final-band height. These are separate operation categories, not interchangeable time units. The report does not claim exactly half of every category or a measured total speedup.

## Acceptance scope

The proposal is a valid alternative computation for the stated finite targets and error budgets. Actual elementary and seed enclosures, exact arithmetic/rounding proofs, transform errors, signs, auxiliary success and zero-count completeness remain outside this review. Old immutable boxes are not asserted to contain the changed centers. No Lean/MM0 implementation, build, runtime or spectral certificate has been accepted by this paper/metadata review.
