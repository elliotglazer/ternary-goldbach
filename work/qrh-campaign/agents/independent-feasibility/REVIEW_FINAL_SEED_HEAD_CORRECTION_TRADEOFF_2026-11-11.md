# Independent review of the shorter-head, longer-correction seed band

2026-11-11. **PASS for the conditional paper construction and exact metadata, with no correction requested.** The final-band choice `(V,D,N,m)=(7000,8192,1500,256)` preserves the selected P27-to-P20 coefficient and isolated-alpha error contracts. The weaker E contraction, enlarged correction sum and nonnested argument transition are accounted for. This does not establish that the choice is faster or cheaper under a complete Lean/MM0 cost model.

## Frozen evidence and method

Author `../major-constants/FINAL_SEED_HEAD_CORRECTION_TRADEOFF_2026-11-11.md`, SHA256 `3B760B39986F6A80C1ADB71BCABDEFDE28947964225383AF1073E6601162DE4F`.

Author script `../major-constants/seed_head_correction_tradeoff_20261111.py`, SHA256 `F9EED5088D70655D6D3CB23DF70F76D6F80D3854F406CAB8EE058163A836C7B2`; its JSON, SHA256 `A430173E669CCD088931EF11E95D473BB5FBF96BA668EF5A3D3B337D2E4D9522`.

Independent script `review_seed_head_correction_20261111.py`, SHA256 `6F41E703AA020248362DED584C7D7BF0422FC5438E31183B6995146908B0F38E`; independent receipt, SHA256 `79C3D5ABB844D256417A924F2D5F42179C76BFEDBCC1BB4893D1005D2583F762`.

I read the complete frozen note and code, and compared them with the retained shared EM formula, scaled rounding construction, selected P27 output contract, height-recurrence construction and V7000/N2387 comparator. All three author pins and six predecessor pins match. My independent program imports no author code and passed 1143 checks. These include the complete coefficient envelopes for k=0,...,31, all rebuilt error constants, three output orders, costs derived separately for the D full-order anchors and one twenty-coefficient endpoint, all four height prefixes, the arithmetic-progression intersection and every conservative log block. No analytic or spectral value was evaluated; no build or frozen source change occurred.

## Actual formula and remainder

The actual target remains `(-1)^k(s)_k zeta(s+k,1+a)/(D^k k!)`, with `s=1/2+it`, `|t|<=7000` and `a in [0,1]`. With N=1500, the EM endpoint lies in `[1501,1502]`. Every denominator retains its domain: `Re(s+k)+512>1`, `|s+k-1|>=1/2`, b>0 and D>0. Central t=0 and k=0 are included.

The coefficient's rising factor and the EM remainder's rising factor join into `(s)_(k+512)`. The explicit scaled remainder has the factor `(W/(bD))^k/k!`, not the larger raw factor `(W/b)^k/k!`. With `W=7544`, the former is at most one. Also `W/(6b)<17/20`. Consequently

    error_k <= 4*1502/511.5 * (17/20)^512 < 2^-116

for all required k. I independently checked each k through 31 against this bound using the actual rational ratio `7544/(6*1501)` before replacing it by 17/20. This is a bound on the finite EM remainder, not a convergence claim for an infinite asymptotic expansion.

The general periodic-Bernoulli estimate in the retained source proof applies to m=256 as well as m=64. Its analytic justification remains required in the final formal implementation. Exact scalar success does not replace it. The 256 signed gamma constants must be constructed from their exact Bernoulli targets and certified; they are not supplied by the present metadata.

## Rebuilt finite-precision proof

The E recurrence is still contracting, but its bound is now 17/20 rather than 1/2. Thus its accumulated error is less than `u/(1-17/20)=20u/3<7u`. The author does not reuse the old 2u error. The R and lambda recurrences still satisfy their earlier 3u and 2u bounds, because their factors and D have not worsened. Head factors `1/x` remain at most one.

At P27 the largest stored E index is 537 and the final update uses index 536. At P20 they are 530 and 529. These are distinct from the remainder's complete rising-product length. All lie within the W bound.

I reconstructed the correction rounding explicitly:

* `|S_k| <=4r/(1-r^2)<13`, with r=17/20.
* A gamma/E product has error at most `4*7u+2u+u=31u`; 256 products give 7936u.
* The pole-type, half and correction components of Z have respective errors bounded by `(14b+1)u`, `5u`, `1324u`.
* Hence Z error is `(14b+1330)u`, with `|Z|<2b+3` and `|Zhat|<2b+4`.
* The lambda product gives F error `(18b+1339)u`.
* The final endpoint contributes `(2b+3)delta+(36b+2679)u`.

These calculations retain the base-power error and do not treat a rounded factor as exact. The head bound is unchanged in form, `5N delta+(5NP+3N+1)u`. Adding one final rounding and the remainder gives `10507delta+263753u+R<eta/4` at P27. The P32 coefficient is 301253 instead of 263753 and still passes, so the P20 endpoint is safely covered. Here delta=`2^-118`, u=`2^-122` and eta=`2^-100`, exactly as before.

Factoring the common E_k from the finite correction products is an algebraic identity; it does not divide by E_k. Therefore it remains valid if a factor vanishes. The resulting majorant has `C=3N+7=4507`, which gives the quoted shifted-center cap `4C+1=18029<2^16`. The proof does not claim this bound for exact rational numerators, division temporaries or phase arguments.

## Consumer and lifetime fidelity

D=8192, P27, the twenty-coefficient fine output, the scaled displacement and all shift/Horner precisions are unchanged. Both actual Taylor remainders, the seed perturbation, 330 shift updates and final Horner error still fit the original isolated `2^-82` alpha allocation. This is not a complete sign-error allocation.

The prior height recurrence still supplies delta: each used argument has a consecutive lifetime shorter than 128000 steps, its initial value is certified at its actual first height, and each EM-grid copy remains separate from the fine state. Retiring an argument ends its lifetime; it is not an uncharged reset or permission to discard an obligation needed by a later output. The preceding four bands are unchanged.

The set transition requires a new rule because N1500 is below N1720. In final-grid integer coordinates, preceding arguments have even indices through `1721*8192`, while final arguments have all indices through `1501*8192`. Their exact intersection and differences are:

| Set | Count |
|---|---:|
| Preceding active set | 7049217 |
| Final active set | 12296193 |
| Retained intersection | 6148097 |
| Retired after preceding band | 901120 |
| Newly introduced | 6148096 |
| Complete required union | 13197313 |

Each retained state is updated at the boundary, and each newly introduced state initializes there. For H final heights, the update count is equivalently `(H-1)*12296193+6148097`, which matches the author's `H*12296193-6148096`. This avoids the invalid subtraction of final set size minus preceding set size. Relative to the N2387 comparator, pair savings are `7266304H`; update savings are `7266304H-6365184`; total initialization savings are 6365184.

The log implementation deliberately covers the full fine grid through 1722, with 14098433 outputs. That exceeds the actual argument union by 901120 unused fine points. It is a valid conservative charge, and it must not be reported as the smaller phase/state union. The 959 blocks and 296046954 degree-21 nonanchor stages reproduce exactly. No sparse-log omission proof is presumed.

## Cost result and limits

At each final-band height, head scales fall from 508457257 to 319516500 and head additions from 528013948 to 331806000. Bernoulli terms and additions each rise from 14157056 to 56628224. E recurrence stages rise from 1253522 to 4399634. Counting the two real-scaling categories together leaves 146469589 fewer scales, and the two addition categories leave 153736780 fewer additions. There are also 3146112 additional E complex stages per height. The receipt reproduces these costs at H=20199,20366,20519,20839.

These are different operation families. A net reduction in two families is not proof of less total bit work or faster checking. The extra 192 exact gamma constants, their precision-certified versions, larger E buffers, index maps, proof witnesses and rational factor construction remain real costs. The correction depth changes but source slots, endpoint assembly counts, R/lambda lengths, fine output and midpoint work do not. No transform or conductor-contraction saving is credited.

The comparator is the same D8192 schedule with N2387/m64, at the same combined-profile prefixes. The separately proposed D4096/source-order construction is not part of this review and cannot be stacked without a fresh error and cost proof. Actual finite coefficient certificates, analytic formalization, spectral completeness and end-to-end runtime remain open.
