# Shared Hurwitz jets for the doubled alpha mesh

2026-11-11. Paper derivation and exact integer/rational metadata checks only. No Hurwitz values, zeros, roots, transforms or other analytic values were evaluated. The conditional R138000 family, heights and P20 target mesh are those of the pinned input below. This note reduces the number of independently generated seed coefficients; it does not establish a runtime improvement or spectral evidence.

**Result.** At each old anchor, P28 actual normalized alpha coefficients suffice to generate the first20 coefficients at the new midpoint anchor. The additional character-summed analytic error is below2^-90. It adds to the existing P20 target-cell tail below2^-84, rather than replacing it. P32 gives more margin; P27 also suffices by the same proof. The construction uses a finite triangular shift with no special-function calls at the midpoint.

## 1. Functions, mesh and domains

Fix s=1/2+it, |t|<=V, and f(alpha)=zeta(s,1+alpha). Use the actual continued Hurwitz function and its coefficients

    C_j(a)=f^(j)(a)/j!=(-1)^j (s)_j zeta(s+j,1+a)/j!.

The differentiated identities are continued-function identities, not termwise differentiation of a conditionally convergent critical-line series. As in the input plan, the absolute series bound is applied only after enough alpha derivatives make it absolutely convergent.

The five (V,D) pairs are (500,512), (1000,1024), (2000,2048), (5000,4096), (10000,8192). The fine mesh has denominator2D. Even fine anchors reuse C_0,...,C_19 at the old anchor. For an odd fine anchor b=(2j+1)/(2D), choose its left old anchor a=j/D and delta=b-a=1/(2D), with 0<=j<D. Choose a nearest fine anchor for the target alpha in[0,1], using an exact tie rule, and put d=alpha-b. Then

    |d|<=1/(4D),   |delta|+|d|<=3/(4D).

Both real segments a to b and b to alpha stay in[0,1]. At an even anchor the first segment is absent; endpoint cells are simply restricted to[0,1]. No periodic wrap or extrapolation beyond the domain is used. Negative ordinates t obey the same absolute bounds. The proposal concerns these point heights, not a complex s-panel or the pole s=1.

## 2. Differentiated shift remainder

Given P>=20, define finite translated coefficients

    Ctilde_k(b)=sum_(j=k)^(P-1) binom(j,k) C_j(a) delta^(j-k),
    0<=k<20.

For alpha in the shift segment, the genuine P-th derivative satisfies

    |f^(P)(alpha)|
      <= |(s)_P| [1+1/(P-1/2)]
      < 2(V+P)^P =: M_P.

This follows from the first term plus decreasing integral for zeta(s+P,1+alpha), whose real part is P+1/2>1. Apply the real Taylor integral remainder to f^(k), then divide by k!. It gives every coefficient error, not only k=0:

    |C_k(b)-Ctilde_k(b)|
      <= M_P |delta|^(P-k)/(k!(P-k)!).                     (1)

After evaluation at d, sum (1) with weights |d|^k. The binomial theorem bounds the truncated sum by the full positive sum:

    sum_(k<20) |d|^k |C_k(b)-Ctilde_k(b)|
      <= M_P/P! (|delta|+|d|)^P.

The exact L-function normalization multiplies the residue sum by c^-s. Thus the amplification is at most phi(c)/sqrt(c)<=sqrt(c)<633 on the retained domain (633 is deliberately inherited from the larger old c<=400000 bound). Consequently

    E_shift <= 1266/P! * [3(V+P)/(4D)]^P.                 (2)

For P=27,28,32 every one of the five bands has 3(V+P)/(4D)<15/16. Exact rational/factorial comparisons give

| P | Uniform character-summed shift bound |
|---:|---:|
|27|1266(15/16)^27/27! <2^-85|
|28|1266(15/16)^28/28! <2^-90|
|32|1266(15/16)^32/32! <2^-110|

The independent target expansion about b still has length20, so its own omitted Taylor tail remains

    E_target <1266(5/16)^20/20! <2^-84.

Add E_target and E_shift. They are different remainders. This closes the old2^-82 isolated alpha allocation with finite-precision room for all three choices; the existing P24 source alone was not assumed sufficient. Indeed at (V,D)=(5000,4096), the exact positive sum in (1) over k<20 for P24 exceeds2^-82 after amplification. This is failure of that sufficient derivative envelope, not a lower bound on the true shift error or proof that every possible P24 method fails.

## 3. A cheap finite shift, without binomial multiplications

Initialize a work vector A_j=C_j(a), 0<=j<P. Process i=P-2,P-3,...,0. Within each i, process j in increasing order from i through min(P-2,i+19), applying

    A_j <- A_j + delta*A_(j+1).

The first20 final entries are exactly Ctilde_k(b). The unpruned triangular shift is Pascal's recurrence for binomial translation. A node with j>i+19 cannot reach any final entry below20 in its remaining i stages, so omitting it changes none of the consumed entries. The increasing inner order is essential: it reads A_(j+1) before that entry's update in the same stage.

The number of stages is

    L_P = sum_(i=0)^(P-2) min(20,P-1-i) =20P-210.

This is330,350,430 for P27,P28,P32. Each stage has one real scaling and one complex addition. Here delta is exactly a positive power of two, so a signed-exponent dyadic representation can implement the scaling as an exact exponent change. That does not make the addition, rounding, proof or memory access free. With another arithmetic representation, count its actual scaling cost. A direct binomial/Horner translation would require extra integer-coefficient operations that this schedule avoids.

Exact symbolic coefficient dictionaries were checked for all three P: the final coefficient of C_j(a) in row k is precisely binom(j,k)*delta^(j-k). This is a finite algebra check, not a seed-value evaluation. A future generic proof must establish the same loop invariant and pruning property; a trace of successful numerical outputs alone would not prove it.

## 4. Seed and arithmetic errors stay explicit

Suppose each supplied coarse C_j ball has complex absolute radius eta_j. Its contribution to a consumed odd-cell value is bounded by

    sum_(j<P) eta_j (|delta|+|d|)^j.

For eta_j<=eta, D>=512 and |delta|+|d|<=3/(4D), this is below2eta. After the character sum it is below1266eta. The even-cell bound is smaller. These are deterministic triangle inequalities and require no independence of errors.

For a simple conservative rounding rule, let u_T bound the total complex absolute rounding error of each shift stage. The exact dyadic scaling incurs no error when its exponent is retained. In max norm a stage amplifies the previous error by at most1+delta. Since delta<=1/1024 and L_P<=430,

    (1+delta)^L_P <=1/(1-L_P/1024)<2.

Thus the final coefficient error from all shift stages is below2L_P u_T. Evaluation over |d|<=1/(4D) costs at most another factor2 and the character sum another633. A sufficient aggregate shift-rounding allowance is2532L_P u_T.

Retaining the input report's Horner convention, with complex absolute error u_H per multiplication and per addition, gives at most2532u_H after the character sum. Therefore the full alpha component obeys

    E_alpha < E_target+E_shift
              +1266eta+2532L_P u_T+2532u_H.              (3)

For example eta=2^-100, u_T=2^-110 and u_H=2^-100 make (3)<2^-82 for P27,P28,P32, as checked by exact rational arithmetic. These are sufficient absolute-error contracts, not claims that any existing precision satisfies them. Coordinate-square radii must be converted to complex norm; an unspecified halfwidth cannot be substituted for u_T or eta.

The displacement d=alpha-b is usually rational, not dyadic. Equation (3) assumes exact rational d in each rounded Horner multiplication. If an approximate d_hat is used, the separate derivative-weighted argument error from the input report is still required; it is not hidden in the shift tail. The dyadic delta and generally non-dyadic d are different operands.

Unscaled high-order C_j may have large magnitudes. Absolute2^-100 accuracy is therefore not equivalent to100-bit relative precision. Rescaling coefficients by powers of D could reduce magnitudes, but would require transforming all error and loop bounds; it is not priced as an already proved alternative here. The actual Hurwitz producer, elementary leaves and prefactor errors remain required. Finite heads, conductor phases/scaling, transforms, interpolation, exceptional repairs and completeness have separate budgets outside (3).

## 5. Exact slot and arithmetic comparison

The pinned R138000 metadata has H=127989 shared heights and

    A=sum_(bands) D*number_of_heights =717521408

old mesh intervals. Independently generating20 coefficients at all fine anchors needs20(2A+H)=28703416100 coefficient slots.

For shifting, only the D left endpoints per height need order P. The right endpoint alpha=1 needs its first20 coefficients only. Thus actual independently generated slots can be P*A+20H. The right-endpoint omission is a specified exact dependency removal, not sampling. Generating P coefficients there too gives the slightly larger alternative P(A+H).

| Coarse order | Necessary independent slots | Slots avoided vs independent fine P20 | Shift stages over all odd anchors |
|---:|---:|---:|---:|
|27|19375637796|9327778304|236782064640|
|28|20093159204|8610256896|251132492800|
|32|22963244836|5740171264|308534205440|

The complete-P alternatives are19376533719,20094183116,22964780704 slots respectively. The downstream P20 residue Horner count stays1973500343706474 stages. Character transforms and the shared height grid do not change.

These are normalized coefficient slots, not independent oracle calls or predicted times. A shared Hurwitz algorithm may generate many orders together, and higher orders can have different generation/checking costs. Let C_even20 be the cost of the common old-anchor first20 jets, C_extra(P) the extra higher orders at left endpoints, C_odd20 the complete independent midpoint-jet cost, and C_shift(P) the full arithmetic/proof/storage cost of the shift. The exact decision is

    C_extra(P)+C_shift(P) < C_odd20.

Only under a uniform slot-cost sensitivity model does this reduce to

    c_seed/c_shift_stage > L_P/(40-P),

namely330/13,175/6,215/4 for P27,P28,P32. This is not a measured threshold. P27 uses fewer slots and stages among these three demonstrated choices; P28/P32 purchase more analytic tail margin. No minimum feasible P or globally optimal seed method is proved.

Relative to the original P24/old-mesh plan, P28 adds higher-order seed work but retains the P20 plan's415473756569784 saved residue Horner stages. The new251132492800 shift stages are dyadic-scale/add stages and cannot simply be subtracted as equal-cost generic Horner stages. The comparison must use the actual arithmetic widths and both generation and verification costs.

## 6. Storage and acceptance boundary

Persisting all translated midpoint jets is optional. One can retain the coarse certified jets plus the fixed shift recipe, reconstruct each midpoint once per height and share it across every consuming residue/conductor. An indexed schedule or DAG must ensure it is not needlessly reconstructed per consumer. Streaming needs only P temporary coefficients per active anchor in addition to the live consumer arrays; this does not claim the whole character/height computation has constant memory.

Acceptance binds s, band D, old/fine anchor indices, tie choice, normalization and all coarse coefficient balls. It must prove the finite shift and propagated radii, the actual Hurwitz coefficient identities, both analytic remainders, and the exact c^-s character normalization. Hashes and midpoint labels do not substitute for those proofs. The first20 coefficients at even anchors are literal reuse; midpoint coefficients are newly proved enclosures, not asserted equality to old values.

A concrete next implementation decision is whether the actual high-order seed producer can supply C_extra(P) cheaply enough. This proposal isolates that question and avoids treating every new midpoint as a new special-function evaluation. It does not solve the seed producer itself or predict end-to-end Lean/MM0 performance.

## Input pins

Paths are relative to `work/qrh-campaign/agents/zero-sum`.

| Artifact | SHA256 |
|---|---|
| `R138000_HURWITZ_SEED_CONTRACTION_EFFICIENCY_2026-11-11.md` | `3151FEBCBE953FA458CBFE437222B810468B2E4F173C723F159F67285601D853` |
| `r138000_p20_alpha_tradeoff_20261111.json` | `F7D5E9CC9AE271B5DA2FC60A33CE8DFC23C9EED5F05999B442C20182573A8323` |
| `REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md` | `B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC` |
| `CONDITIONAL_R138000_SPECTRAL_INVENTORY_2026-11-11.md` | `C14E47FBD3EFBC67C541076B99CCF2949FA2BEDFA9217EFD3C87B9AA8617E78B` |

All four hashes were checked. New checks were finite rational factorial inequalities, five-band ratios, symbolic coefficient identities, rounding-budget inequalities and exact metadata sums only. No numerical seed evaluator or production schedule was executed.
