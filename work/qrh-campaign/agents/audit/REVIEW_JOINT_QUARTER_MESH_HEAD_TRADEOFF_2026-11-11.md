# Independent review of the joint quarter-mesh, shorter-head seed

2026-11-11. **PASS for the conditional paper construction and exact metadata. No correction requested.** The joint final-band parameters V7000, D4096, N1500, m256 and P28 satisfy the stated source and translated coefficient bounds. They supply the same Q8192-normalized P20 fine output, with the analytic translation bias charged separately. This is a new joint check, not an inference from two separate component approvals. It produces no seed values, successful spectral tests, implementation timing or kernel theorem.

## Frozen inputs and independent method

The three author objects are under `work/qrh-campaign/agents/major-constants`.

| Object | SHA256 |
|---|---|
| JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md | AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F |
| joint_quarter_mesh_head_tradeoff_20261111.py | EA607EE8DB1EE54168172D2D8057E770B25EEE8618DB23F26A98339AD98E4C4A |
| joint_quarter_mesh_head_tradeoff_20261111.json | F1686B1C1A3183082D9126F4FE680BE6DB42A88D31F82071B752759EE3DE9BD4 |

I read the complete author note and script, both component notes and their independent reviews, and the shared EM and scaled-coefficient source plans. The nine prerequisite pins in the author receipt match. They include the head-tradeoff review `7BB25BC96EE9C27FE03038968EFC9E9F52A4B3064D9F0986865CF68AC8E77365`, quarter-mesh review `8D50DDB6C7398D10930F8437ABE9B3E0C672F9AD1F85851D040EF1BD6D385B6A`, exact EM circuit `1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E`, scaled precision plan `251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231`, and height recurrence `8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413`. Full paths and pins are in the independent receipt.

The new independent script `work/qrh-campaign/agents/audit/review_joint_quarter_mesh_head_20261111.py` has SHA256 `818419015C6684407F0BF085F99C168E977512141BF5DCD4742FC0570345C771`. Its same-stem JSON has SHA256 `CE5528231B8478306B8B1703E0838F16086059577958C2C6C271567F298E930E`. It passed **72179 exact integer/Fraction checks**. It imports no producer or evaluator and checks every supplied error expression and work field. No analytic value, build or frozen-file modification was performed.

## Actual function and complete finite approximation

The source target is exactly `U_k=f^(k)(a)/(4096^k k!)`, where `f(a)=zeta(1/2+it,1+a)`, a lies in [0,1], and |t|<=7000. The continued-Hurwitz derivative identity, rather than a critical-line Dirichlet-series exchange, supplies that meaning. All 28 orders are required at all 4097 source anchors. In particular, the final right endpoint supplies high coefficients for a negative-quarter shift and cannot revert to a twenty-coefficient shortcut.

For b=N+1+a in [1501,1502], the EM domain is `Re(s+k)+512>1` and `|s+k-1|>=1/2`. This includes k=t=0. Multiplying the actual EM remainder by the source rising factor joins the products into `(s)_(k+512)` and retains the factor `4096^-k/k!`. With W7544, both `W/(4096*1501)<1` and `W/(6*1501)<17/20`. Hence all 28 remainder bounds are dominated by

`R = (4*1502/511.5)*(17/20)^512 < 2^-116`.

I independently checked the tighter k-dependent rational expressions before applying this common bound. The denominator 511.5 is positive. The proof uses a finite EM remainder and the all-order periodic-Bernoulli bound; it does not claim convergence of the formal infinite EM expansion.

The identity `lambda_k E_k=R_k/b^k` gives exactly the head, pole-type, half and 256 signed Bernoulli corrections in the displayed finite formula. For the rth correction, the extra E factors supply `(s+k)_(2r-1)/(6b)^(2r-1)`, while gamma and the factor 1/6 restore the original Bernoulli coefficient. No factor of D, b or 6 is missing. The largest stored E index is `27+2*256-1=538`, with final update index537. This is distinct from the rising product in the remainder.

## The simultaneous rounding changes

The coarser mesh gives A7032/4096<7/4. The first R update starts from an exact value; later factors are bounded by 7/8. The R error is therefore at most8u. The increased correction order has E factors below17/20, so the E error is less than `u/(1-17/20)<7u`. Lambda still has error at most2u. I checked finite recurrence bounds through every required R/lambda order and E index. Reusing either old R3u or E2u would be invalid; the joint proof uses neither.

With `|gamma|<4`, `|Ehat|<=2` and one rounded product, each correction term has error at most31u. All 256 terms give7936u. The correction's true norm is bounded by `4r/(1-r^2)<13`. The pole, half and correction pieces of Z have error bounds `(14b+1)u`, 5u and1324u. Their sum gives `(14b+1330)u`; after lambda multiplication and rounding, F has error `(18b+1339)u`. Multiplying by the imperfect base power and rounding yields endpoint error

`(2b+3)delta+(36b+2679)u`.

The head error independently uses R8u and is

`5N delta+(5NP+8N+1)u`.

At N1500, P28, b<=1502, adding one final rounding and the actual-function remainder gives precisely

`e_seed=10507delta+278753u+R < .107eta < eta/4`,

with delta=2^-118, u=2^-122 and eta=2^-100. This includes imperfections of both multiplicands where required. Common-grid additions are exact only with adequate integer capacity; the paper does not infer such capacity from a floating backend setting.

The factorial majorant has C4507. Factoring E_k out of the finite correction is polynomial algebra, not division by a possibly zero value. The positive translation bound gives magnitude below6C, and the checked perturbation allowance is below1, leaving the stated stored-center cap27043<2^16. This cap does not cover rational temporaries, phase-reduction integers or proof-object sizes.

## Output normalization, cells and error injections

At an output anchor l/16384, its finite coefficient is

`2^-k sum_(j=k)^27 binom(j,k) U_j tau^(j-k)`.

The factor2^-k converts source normalization4096 to output normalization8192. The three nonzero source-coordinate displacements are 1/4,1/2 and -1/4. I checked the ownership and closed nearest-anchor cells of all16385 fine anchors. There are4097 coarse outputs and4096 of each translated type. No output or endpoint is omitted; no segment leaves [0,1]. Every target cell has `|8192(alpha-b)|<=1/4`, and combined source-shift plus evaluation distance is at most5/(8*4096).

The independent check propagates each of the twenty postscaled output rows **backwards** through the actual 350-update loop at each signed shift. It verifies the binomial row formula, the row-sum bound2, and every individual rounding-injection amplification. The maximum injection factor is exactly1. This directly confirms the paper's positive-suffix argument without assuming a suffix equals a full translation.

Including the final coefficient conversion round gives

`e_out<=2e_seed+351*2^-110 < .557eta < eta`.

The eta radius is relative to the finite translated polynomial. It is not by itself an enclosure of the exact shifted derivative. The analytic shift bias and P20 target Taylor remainder must also be added. With the retained amplification633, the complete stated allowance is

`1266*((7020)/(4*8192))^20/20!`

`+1266*((5*7028)/(8*4096))^28/28! +844eta+1688eta < .16*2^-82`.

This comparison passes exactly. Translation rounding is already in e_out and is not charged twice; analytic translation bias is not omitted. Approximate target displacements would require a separate input-error term, as the author states.

## Shrinking argument sets and exact work

The previous band uses the same denominator4096 through x1722. The final set ends at x1502. It retains6148097 arguments, retires901120, and introduces none. Earlier grids embed in the previous grid. Thus the complete union is7049217, and every retained argument has an uninterrupted recurrence across the transition. Final-band updates, argument pairs and EM copies each number `6148097H`. Reinitializing at that boundary would be unnecessary extra work; omitting the first boundary update would be wrong. Retired arguments have no later consumers.

The height recurrence's domain and precision remain valid for all these consecutive lifetimes. For the current four scenarios, H is20199,20366,20519 or20839, and the maximum final ordinate424195/64 is below7000. Each lifetime is shorter than128000 updates. EM copies remain separate from fine states.

I reconstructed the complete baseline, head-only, mesh-only and joint rows by separately counting interior and endpoint orders. The joint per-height counts match:

| Category | Joint count |
|---|---:|
| Source slots |114716|
| Head scales |165928500|
| Head additions |172074000|
| Bernoulli terms and additions, each |29367296|
| E updates |2204186|
| Translation updates |4300800|
| Final dyadic scales and rounds, each |327700|
| Shared R stages |27|

All four columns deliver the same327700 fine coefficient slots. The four scenario multiplications and their argument-lifetime counts reproduce exactly. The unchanged earlier bands are excluded from these per-final-height comparisons consistently. No transform, contraction or interpolation saving is credited.

The previous complete log grid has960 anchors and148013397 nonanchor degree21 Horner stages. I checked every block and its strict relative-radius bound. It already covers the final argument set, so no final-band log setup is added. Gamma setup instead grows to256 constants, requiring192 additional exact rational targets and certified roundings through Bernoulli index512. The D4096 lambda table needs its new order27 entry. E storage through index538, endpoint assembly, exact rational factors and witnesses still require work.

The joint construction is therefore a sound conditional alternative at the stated parameter and error interface. Its fewer head operations are accompanied by the listed extra corrections, translations and normalization gates. These categories have different widths and costs. Actual elementary enclosures, arithmetic certificates, transformed values, sign and count evidence, full error composition and ordinary Lean/MM0 acceptance remain open. No overall speedup, memory peak or spectral success follows from this review.
