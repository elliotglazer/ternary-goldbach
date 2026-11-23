# Reusing elementary certificates on the shared EM grid

2026-11-11. Paper derivation and integer/rational metadata only. No logarithm, square root, phase, L-function, transform or zero was evaluated. No build or modification of a frozen artifact occurred.

The shared seed circuit needs log(x) and x^(-1/2) on a nested rational grid, reused across heights. A block-anchor construction reduces independent elementary evaluations to about a thousand anchors. It replaces each remaining log by a short polynomial evaluated with small-rational multipliers. This is a concrete alternative to independent range-reduced logarithms, not a measured speedup. For inverse square roots, direct integer-square witnesses may be cheaper than the analogous polynomial construction.

## 1. Existing methods and precise domain

The frozen shared Hurwitz EM circuit uses x=1+j/D, from 1 through3389, on the finest old grid D=8192. Its union has27754497 points; D=16384 on the doubled mesh has55508993. The five earlier nested grids have D=512,1024,2048,4096,8192 and N=220,387,720,1720,3387. Evaluating the finest union covers all earlier inputs exactly. Reuse at a coarser precision is valid only if its certified error satisfies the current consumer's target.

The existing elementary and inner-rounding papers already provide independent range reduction, atanh logarithms, finite rational Horner gates, and certified final rounding. Their fixed 512-term/1024-bit choices are pilot parameters, not necessary costs for this grid. They do not already provide the geometric block sharing derived here. The shared seed paper also separates log/root setup from the potentially much larger height-dependent cis and recurrence work; this report preserves that separation.

Let E_L=2^(-p_L) and E_A=2^(-p_A), with integer p_L,p_A>=1, be required absolute errors in log and inverse square root. The consumer selects these targets. A proposed scaled-seed allocation currently uses p_L=135 and p_A=121 for B_x=x^(-1/2)cis(-t log x) error delta=2^-118, |t|<=10000. Those numbers are conditional examples, not adoption or evidence that any resulting seed boxes pass. All formulas below accept other targets.

## 2. Blocks with bounded relative width

Represent a grid point as x=n/D. Start a block at integer n0>=D and let its length be

    L=min(floor(n0/128), n_max-n0+1),    n_max=3389D.

Its points are x_j=(n0+j)/D, 0<=j<L; the next block starts at n0+L. Since D>=8192, every nonterminal block has positive length. The exact relative offset

    u_j=j/n0

satisfies 0<=u_j<=1/128. These disjoint integer intervals cover every required point, including x=3389. The anchor is a positive rational, not an interval-selected branch.

There are only O(128 log3389) anchors. An elementary bound without logarithm evaluation is enough: floor(n/128)>=n/256 when n>=256, and (1+1/256)^256>2 by its first three binomial terms. Consequently fewer than3073 blocks suffice because3389<2^12. The exact integer construction gives1046 anchors on the old grid and1045 on the doubled grid. A fixed64-point block would need433665 or867329 anchors, respectively.

Every point depends directly on its anchor. No certificate error propagates from the previous point or previous block.

## 3. Exact identities and polynomial tails

For a positive anchor a and real u>=0,

    log(a(1+u))=log(a)+log(1+u),
    (a(1+u))^(-1/2)=a^(-1/2)(1+u)^(-1/2).

Use the real positive inverse square root. Set

    L_K(u)=sum_(k=1..K) (-1)^(k+1) u^k/k,
    A_K(u)=sum_(k=0..K) (-1)^k binom(2k,k) u^k/4^k.

The log remainder follows by integrating the exact finite geometric identity for1/(1+u). Its absolute value is at most u^(K+1)/(K+1). For the inverse square root, its kth derivative divided by k! is (-1)^k binom(2k,k)(1+u)^(-k-1/2)/4^k. Taylor's integral or mean-value remainder on the real segment[0,u] is bounded by u^(K+1), since binom(2k,k)<=4^k. Thus both tails are bounded conservatively by

    T_K=2q^(K+1),    q=1/128.                            (1)

There is no complex branch, extrapolation outside the segment, or unproved power-series interchange in this argument. The stronger real tails above are not needed in the ledger.

For either target E=2^-p choose

    K=max(1,ceil((p+4)/7)-1).

Then T_K<=E/8. Degree19 suffices for p=135; degree17 for p=121. For p=64,128,192,256,512, the respective degrees are9,18,27,37,73. These are sufficient degrees for this explicit bound, not optimal approximation degrees.

## 4. Arithmetic and anchor errors

Each anchor has an independently certified log center with error<=E_L/4 and inverse-square-root center with error<=E_A/4. For a general target E, take every polynomial coefficient-rounding and Horner gate error at most e=E/32; take final output rounding error at most E/8. These are real absolute errors. Dyadic grid spacing e, with nearest rounding, is sufficient and leaves unused slack. Positive-width input boxes are not treated as refinable point inputs.

For the log, evaluate L_K at the exact rational u=j/n0 by Horner, then add the anchor center. Its exact rational coefficients are1/k with alternating signs. With K Horner gates the rounding error is at most

    e sum_(r=0..K-1) q^r <=2e.

The complete error is bounded by

    E/4 + E/8 + 2e + E/8 =9E/16 < E.                   (2)

For the inverse square root, avoid a general full-precision product at every point. At each anchor precompute and round the K+1 coefficients

    b_k = ahat * (-1)^k binom(2k,k)/4^k,

with individual error<=e. Here ahat approximates a^(-1/2). These coefficients are computed from the same ahat, so the anchor error remains correlated in the proof. Since E<=1 and a>=1, |ahat|<=5/4. Evaluate the resulting polynomial by K Horner gates. Compared with the true inverse square root, its error is at most

    E/4 + (5/4)(E/8) + 2e + 2e + E/8 =21E/32 < E.     (3)

The two2e terms are coefficient and Horner errors. Equation(3) uses the exact factor (1+u)^(-1/2)<=1 to propagate the common anchor error, then pays the polynomial tail multiplied by |ahat|. Treating the b_k as independent approximations of unrelated functions would lose this useful structure, but the displayed bound already accounts for their individual rounding.

One may construct each b_k directly from ahat and its exact rational binomial coefficient. A rounded recurrence between b_k needs its own propagated-error allocation and is not assumed here. At the anchor point j=0, return the anchor certificate directly; there is no need to run Horner.

## 5. Bit sizes and checked operations

On the old grid, n0<=27762688 has at most25 bits; on the doubled grid it has at most26 bits. Therefore each Horner scale is multiplication by the exact small rational j/n0, followed by a dyadic rounding gate. It is not multiplication of two arbitrary p-bit values. For log coefficients, the exact expression before a gate has denominator dividing

    n0 * 2^g * k,    1<=k<=K,

when the incoming state is on grid2^-g. For the rounded amplitude coefficients it divides n0*2^g, provided all coefficients use that same grid. Every gate resets the denominator. There is no n0^K or K! denominator carried through the loop.

The direct anchor coefficient setup uses binom(2k,k) with at most2k+1 bits and denominator4^k. Its pre-rounding size is O(p+K); it is paid O(K) times per anchor, not per grid point. The polynomial suffixes are bounded by a fixed constant because q<=1/128 and coefficient magnitudes<=5/4+e. The final log adds an anchor bounded by log3389<12. Thus no height-dependent integer part is introduced by this setup. Phase multiplication by height is a later operation.

In bit-cost notation, a concrete schoolbook small-integer multiply/divide gate costs O(g*(log n0+log K)) bit operations, with a checked quotient/remainder or rounding inequality. This is a stated implementation model, not a universal lower bound. An optimized multiprecision division or batching implementation may differ. The number of gates alone does not determine Lean elaboration, MM0 checking, serialization or native generation costs.

Mandatory acceptance inputs are exact grid/block indices, independent anchor enclosures, exact coefficient identities, all named rounding inequalities, and the analytic error ledger. A checker may reconstruct deterministic intermediate gates instead of storing a full trace, but that still incurs their arithmetic. Native proposed centers cannot replace these checks. Common radii may be stored once; exact grid indexing avoids repeating rational x values. Streaming changes memory and I/O, not the certificate semantics.

## 6. Counts and comparison with independent leaves

| Quantity | D8192 | D16384 |
|---|---:|---:|
| Required grid points | 27754497 | 55508993 |
| Independent anchors | 1046 | 1045 |
| Nonanchor points | 27753451 | 55507948 |
| Maximum block length | 214438 | 427281 |
| Log degree19 Horner stages | 527315569 | 1054651012 |
| Amplitude degree17 Horner stages | 471808667 | 943635116 |
| Combined Horner stages | 999124236 | 1998286128 |
| Amplitude coefficient slots, degree17 | 18828 | 18810 |

Add one anchor addition/final round per log point, amplitude final rounding, O(K) coefficient setup per anchor, and the independent anchor certificates. The two grid columns are alternative complete schedules; no claim is made that running both is necessary. Existing certified coarse-grid points can be reused when computing the fine grid, but that additional pruning is not credited in these totals.

For a comparable elementary log baseline, write x=2^k v, 0<=k<=11, 1<=v<2 and t=(v-1)/(v+1)<=1/3. With Q atanh terms, the total analytic tail including a shared log2 certificate is at most

    12 * 2 * 3^(-(2Q+1)) / ((2Q+1)(1-1/9)).             (4)

The metadata search finds Q=43 enough to put (4) below E_L/8 at p_L=135. The inner-rounding proof carries over with variable Q: each polynomial contributes at most7e0/4, so choose e0<=E_L/64 and retain the unfinalized internal log2 cache. Twelve such errors plus the analytic tail and final E_L/8 rounding are below E_L. This compares19 small-rational Horner stages per nonanchor with43 atanh stages plus reduction/assembly, for these two explicit methods. It does not rule out faster logarithm algorithms or prove a wall-time factor.

For inverse square root there is an important cheaper comparator. Given x=A/D>0 and target grid2^-b, a nonnegative integer m satisfying

    m^2 A <= D 2^(2b) < (m+1)^2 A                       (5)

certifies m/2^b <= x^(-1/2) < (m+1)/2^b. A native integer-square-root calculation can propose m; the checker needs only the two exact inequalities. At b>=p_A this gives the requested error using no binomial polynomial. Each integer square is a larger-width product, whereas the block method uses17 small-rational stages. No common operation price makes one automatically better. A plausible hybrid is anchored logs and independent square witnesses; its superiority still needs an implementation cost comparison.

## 7. Sequential recurrences and why resets matter

The alternative adjacent-point identities are log(x+h)=log x+log1p(h/x) and (x+h)^(-1/2)=x^(-1/2)(1+h/x)^(-1/2), with h=1/D. If each log increment has error at most tau and its update round at most e, after B steps the error is at most E_anchor+B(tau+e). It cannot be bounded independently of B by merely increasing arithmetic precision at the final step.

For the amplitude recurrence, let each factor error be at most epsilon and update rounding at most e. Since the true factors and amplitudes are at most1,

    E_(j+1) <= (1+epsilon)E_j + epsilon + e,
    E_B <= (1+epsilon)^B [E_anchor+B(epsilon+e)].         (6)

If B epsilon<=1/2, the leading factor is below2. E_anchor<=E/4 and epsilon,e<=E/(16B) give E_B<3E/4. This needs about log2 B extra fractional bits at each update, as well as enough increment-polynomial degree for its smaller target. Periodic independent anchors reset this growth. The direct-anchor method in sections2–4 avoids the B factor entirely and is therefore the chosen schedule here. Sequential updates remain a separately priced option.

## 8. Consumer join and remaining obligations

For direct B_x evaluation, choose E_L<=delta/(8 max(1,V)), E_A<=delta/8, a cis error<=delta/8 at the exact rational approximate phase, and the consumer's final product rounding allocation. Real-phase Lipschitz continuity bounds the log contribution by |t|E_L. The proposed p_L135/p_A121 targets satisfy these inequalities for delta=2^-118 and V<=10000; the metadata verifies this with rational arithmetic.

The optional height recurrence in the shared seed paper has its own step and initialization budgets. In particular, h E_L plus the step-cis error must fit its much smaller step allowance, and a nonzero starting height multiplies the log error again. The direct-leaf numbers are not silently reused for that recurrence. The consumer must send its final targets before a combined schedule is fixed.

All elementary setup can be shared across characters and heights, but stored log/amplitude centers, phase states, cache reads, or regeneration remain real costs. This report reduces one setup mechanism and does not reduce the shared seed head recurrences, character contractions, sign tests, exceptional repairs or Turing/completeness obligations. It makes no spectral or runtime claim.

The formal work left is to package the real log/product and positive-square-root identities, their finite Taylor bounds, anchor certificates, finite Horner error induction, and small-rational rounding semantics in the chosen checker. The existing source plans supply nearby primitives; this exact block circuit is new and has no implemented or kernel-checked evaluation data.

## 9. Evidence and pins

The script `grid_elementary_anchor_metadata_20261111.py` performs only integer/Fraction arithmetic. It reconstructs every block, verifies exact coverage, checks degree/tail/error allocations, and reports the two grids and seven precision examples. Its successful status is `PASS_EXACT_GRID_AND_ERROR_METADATA`. It creates no elementary centers.

Paths are relative to `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
| integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md | 1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E |
| major-constants/FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md | 60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9 |
| zero-sum/REVIEW_FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md | E2AFC3467382506F4D68CDB9E7AA0307C911B0F2195032E505C4EC8E69D6401B |
| zero-sum/grid_elementary_anchor_metadata_20261111.py | 10AB9F92831A32605FD89F37C9BBD385A9B580D53B382D22D7F0FC72D7B1DC54 |
| zero-sum/grid_elementary_anchor_metadata_20261111.json | 3F9CDE0D49019291509B8382133085CCD6B02F9E496D17C1CB70A4F4C01AABED |

Exact metadata replay from the repository root:

```powershell
& 'work/qrh-campaign/interval-env/Scripts/python.exe' 'work/qrh-campaign/agents/zero-sum/grid_elementary_anchor_metadata_20261111.py'
```
