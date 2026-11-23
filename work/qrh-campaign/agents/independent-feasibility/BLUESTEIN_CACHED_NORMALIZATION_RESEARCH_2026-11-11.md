# Moving Bluestein normalization into its cached kernel

2026-11-11. Conditional paper design, pending independent review. No roots, transforms, L-values, zeros or prime candidates were evaluated. No conductor or unit inventory, build, declaration or source change was performed. Existing frozen artifacts remain unchanged.

There is a useful coarse-grid alternative. Construct the existing kernel cache, divide each entry by its padded length P, and round that scaled entry once onto the original grid p. Runtime point products and the inverse FFT then use grid p, with no final division by P. The proof below includes the added cache error and satisfies the OLD conservative Bluestein error and safety contracts at unchanged p. It gives a smaller local intermediate bound and a narrower kernel numerator. It does not preserve old computed centers or sign successes.

By contrast, keeping the exact scaled kernel and every inverse intermediate on grid p+log2(P), then re-encoding the output to grid p, is only an exact representation change. Its numerators and rounding work do not automatically shrink.

## 1. Fixed inputs and notation

The inputs are the accepted mixed-radix precision supplement `zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md`, SHA256 `4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4`; the intermediate-width proof `independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md`, `5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A`; and fixed-three-product refinement `zero-sum/FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md`, `087A3DF1B2DD49C5C0BB38E00DA9CD9830E41807C6F07A8BBB34502CFF65355D`. Paths in this note are relative to `work/qrh-campaign/agents`.

The ordinary-arithmetic comparator is `integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md`, `DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C`, reviewed at `1A0DE2B920A63B27D7E0AB8E6C0DF38F9DCD56872C290C9333783D99A461004E`. Its p112/134/152 rows remain candidate allocations, not selected spectral precision.

Use the existing positive forward DFT and negative inverse DFT, both unnormalized. For a Bluestein leaf n>=2, put

    m=2n-1, P=2^k=nextPowerOfTwo(m), R=2k+4, A=1+3R,
    Q=3nPA+1, D_old=max(1,2k,PA,Q),
    C_old=6PA+2R(2n+1)+8.

In particular 2n<=P<4n, P>=4, and R>=8. Let the exact stored input centers have sup norm at most M and set V=M+1. This is the intrinsic arithmetic problem. Analytic uncertainty in those inputs remains separately transported by the exact linear transform.

Set u=2^-p. All old root/chirp enclosures and complex-gate absolute-error assumptions are retained, with 0<u<=1/D_old. The existing data forward transform and cached kernel satisfy

    |F|<=nM, |K|<=m,
    |Fhat-F|<=e_F=PAuV, |Khat-K|<=e_K=PAu.

F and K here denote the exact chirped-data and kernel transforms. Hats denote stored centers. The old point products approximate F*K, its negative transform is divided by P, and the final chirp is applied. The proposed exact identity is

    D_minus(F*K)/P = D_minus(F*(K/P)).

This identity changes no normalization of the outer character DFT. The 1/n in normalized error statements remains an analysis device, not a new runtime scale.

## 2. Three representations that must not be conflated

**Exact scaling throughout.** If Khat has numerator K_int on grid p, then Khat/P has the SAME numerator on grid p+k. Form the point product on grid p+k and use that grid throughout the inverse. Keep the original grid-p root centers and the same deterministic rounding rule. Exact power-of-two rescaling commutes with each rounding: Round_(u/P)(z/P)=Round_u(z)/P. Induction gives every point/inverse center equal to the old center divided by P. Converting the final inverse result to grid p is exactly the old final division-rounding operation. The final chirp then agrees too. This statement requires corresponding rounding policies and the final regrid; it does not remove that work.

Integer products, sums and round numerators in this exact-scaled circuit are unchanged. A physical inverse value smaller by P carries k extra fractional bits. The exact kernel's integer coefficient also has its original width. There is no automatic memory or ordinary-proof saving.

**Exact cache, coarse runtime.** Keep Khat/P exactly on grid p+k, but round the point products and all inverse operations onto grid p. Its kernel numerator still has the old width. The point-product raw denominator is now 2^(2p+k), and the output round discards p+k bits. The inverse values can be narrower and the final runtime division disappears. The error proof below works with the smaller cache error Au, so the relaxed bound for the next variant also covers this case. It is a different computed circuit, not the bitwise-equivalent case above.

**Rounded cache, coarse runtime.** Define

    Ktilde = Round_u(Khat/P).

Both coefficient and runtime values use grid p. The two coordinate rounds give complex error at most sqrt(2)u/2<u, so

    |Ktilde-K/P| <= (A+1)u.                         (1)

This setup error must be included at every runtime use. It cannot be divided by the number of reuses. The remainder of the note analyzes this variant. The original kernel FFT is still constructed and certified; its setup is not replaced by an unexplained exact coefficient.

## 3. Same old error target at the same p

The old safety bound gives PAu<=1, Qu<=1 and u<1/2. Also

    P(A+1)<Q,

because Q-P(A+1)=(3n-1)PA-P+1>0. Thus (A+1)u<1/P, and

    |Ktilde| < m/P+1/P = 2n/P <=1.               (2)

The coefficient is fixed with respect to the data, but remains uncertain. Let Zhat be the rounded point product Fhat*Ktilde. Comparing with Z=F*K/P retains both operand errors and their cross term:

    e_Z <= nM(A+1)u + (m/P)e_F + e_F(A+1)u + u
        <= [n(A+1)+mA+(A+1)+1]uV
        = q*uV,  q=3nA+n+2.                    (3)

The third term uses PAu<=1. Since Q-q=3nA(P-1)-n-1>0, q*u<=1. Consequently

    |Zhat|+1 <= Z_s V,  Z_s=nm/P+2.           (4)

Apply the existing length-P radix theorem to these stored inputs. Its normalized intrinsic error is at most R*u*(|Zhat|+1), and the exact unnormalized negative transform transports point error with sup norm P. With NO final division, its output error against the exact convolution is therefore

    e_I <= P[q+R Z_s]uV.                       (5)

This P factor is essential. Charging only q*uV here would falsely treat the inverse as normalized. Moving normalization into the cache does not eliminate the amplification of new coarse-grid point or inverse round errors.

The selected exact convolution coordinates have norm at most nM. The final approximate chirp and product round give

    e_out <= (1+u)e_I+u*nM+u.

Using 1+u<=3/2, the normalized error coefficient is at most

    C_exact = (3/2)[Pq+R(nm+2P)]/n+(n+1)/n.

Now P/n<4, m<2n and n>=2 imply

    C_exact <= C_new,
    C_new = 9PA/2 + 3P/2 + 3Rn + 12R + 14.       (6)

All halves are integers because P is even. For example, the two terms from 2P/n and the final constant total less than 12+3/2, which is at most14. Direct subtraction gives the uniform comparison

    C_old-C_new = R(9P/2+n-10)-6 >=74.           (7)

Thus the rounded-cache, coarse-runtime circuit meets the OLD local bound

    |computed_D_n/n - exact_D_n/n| <= C_old*u*V

under the OLD local safety condition. No extra fractional bit is required by that conservative sufficient contract. This is not a comparison against an optimized old error analysis or against observed errors.

The new local proof uses only D_old. The whole CT and product-axis arguments can consume the unchanged pair C_old,D_old, so their old safety conditions and S bounds remain valid without a new inventory. Pruned Bluestein still computes the full padded convolution and selects the same outputs. Exact input/output labels and chirp signs are unchanged. A future sharper global error inventory could use C_new, but none is adopted here.

The centers in the coarse variants generally differ from the old circuit. Old individual interval boxes or strict sign successes cannot be transferred just because both circuits satisfy the same sufficient theorem. The input E0 and final scaling/phase/interpolation allocations remain separate; no full sign-radius assertion follows from this local result.

## 4. Stored widths and raw product widths

For the following peak comparison also retain the inherited global condition S_old*u<=1/2, or explicitly require C_old*u<=1/2 at this node. The local D_old condition alone is not the semantic-output premise.

The inverse receives augmented norm Z_s V. The existing radix stage proof gives an inverse peak at most 2P Z_s V. The unchanged forward data peak is at most 2P(1+u)V<=3PV. The unchanged kernel construction peak is at most 2P(2+u)<=5P. Since Z_s>5/2, both fit 2P Z_s V. The final chirp also fits: (5) is bounded by n*C_new*uV, so its incoming augmented norm is at most n(1+C_old*u)V<=3nV/2. Multiplication by its approximate unit coefficient and rounding cost at most a factor1+u<=3/2. This is below3nV, whereas 2P Z_s>5P>=10n.

A sufficient new local stored-center peak is therefore

    K_new = 2P Z_s = 2nm+4P,

versus the old K_old=4P(n^2+n+1). This includes unchanged kernel construction, not root-enclosure generation. It does not say every gate realizes that maximum. An old whole-circuit peak remains valid because K_new<K_old; using the smaller node bound in a stage-sensitive cost fold requires a new bound association, not silent substitution into a frozen ledger.

If V<=2^b, and every stored coordinate has denominator 2^p, magnitude bits p+b+ceil(log2 K_new) suffice. A sign and representation overhead are separate. In the rounded-cache variant (2) gives kernel integer magnitude below2^p, so its coefficient capacity is p bits. In the exact p+k cache its numerator instead remains below2^(p+ceil(log2(2n))). The latter width is unchanged by dividing the physical coefficient by P.

Raw complex products must use the grids of BOTH operands. Exact-cache/coarse-runtime products have raw grid2p+k and round by p+k bits; rounded-cache/coarse-runtime products have raw grid2p and round by p. For data and coefficient magnitude capacities a,bK, the fixed-three-product implementation still needs presums a+1,bK+1 and raw output capacity a+bK+2. Its output-addition and round-witness widths cannot be replaced by the smaller stored output width before checking the relevant equalities.

All cached C+D and D-C must be exact sums of the NEW Ktilde centers. Reusing the old unscaled sums would compute the wrong product. Reusing exact old sums followed by independent rounding also needs an equality proof to the required new sums; it is not assumed. The original analytic cache error and the scaling-round error enter (1), once, with their actual correlation intact.

## 5. Typed local costs and a usable decision inequality

The old and new runtime circuits have the same number of forward FFTs, kernel point products, inverse butterflies and final chirps. Each use of a length-P kernel removes P complex final dyadic-division gates. The new cache adds P complex dyadic-round gates once per actual cache lifetime. Existing root/kernel FFT setup remains shared. Cached-sum construction now uses the new coefficient width.

Let U be the number of data lines served by one checked scaled cache before it is discarded. Let R_old and R_new be COMPLETE per-line prices under one fixed backend model, including their actual grids, widths, signed witnesses, root applications, permutations, references and output bindings. Let S_extra be the difference in setup and cache-lifetime prices, including the new scaling rounds, enclosures, cache sums, storage, loading and proof construction. Then

    new is cheaper iff U*(R_old-R_new)>S_extra.                (8)

For an already-built old cache, its construction is sunk and must not be credited as a refund. For a cold comparison, unchanged kernel FFT work cancels, and the old versus new cached-sum construction difference may be included in S_extra. Failed cache reuse or rebuilding resets U. Distinct p, P, signs, normalizations and kernel identities require distinct checked keys. Generation, proof production and ordinary checking each need their own prices.

The existing model supplies M(a,b)=5mn+2min(m,n)+1 with m,n the byte lengths, and A(w)=2ceil(w/8)+1 for an unsigned addition core. Three-product core prices are

    product = M(a+1,bK)+2M(a,bK+1),
    addition = A(a+1)+2A(a+bK+2)+4A(a+bK+4).

The four last additions prove two coordinate rounds. Their remainder width is p or p+k as appropriate; range, shifts, numeral equality and signed bridges remain extra. A complex power-of-two division has four analogous addition cores, without a general quotient multiplication.

The companion gives illustrative LOCAL stage prices, not a new active-leaf inventory. At inverse stage j=0,...,k-1 it allocates a common augmented factor 2^(j+2)Z, covering input, root-product and output magnitudes. The general-root count is P/2-(1+1_(j>=1))*P/2^(j+1), and each stage has P complex additions. Summing gives Pk/2-3P/2+2 general products. Use Z=2n(n+1)+2 for the old allocation and Z=nm/P+2 for the new one. Both schedules use the same declared conservative allocation rule. Actual stage refinement could change either price.

At p134 and local V<=2^14, the separate event coordinates are:

|Illustrative n, P|Per-use product cores saved|Per-use addition cores saved|New scale setup addition cores|Cold cached-sum addition difference|
|---|---:|---:|---:|---:|
|13, 32|18142|6508|4736|-128|
|257, 1024|1653420|334648|159744|-8192|
|4097, 16384|52364028|7420264|2555904|-131072|
|65537, 262144|1349387434|170335060|42991616|-3145728|

These sizes are examples only; no assertion of their occurrence or multiplicity is made. For product price alpha, addition price beta, and the remaining complete per-use difference Delta_other, insert

    R_old-R_new = alpha*saved_products + beta*saved_additions + Delta_other

in (8). Setup has its own signed/range/round/enclosure and memory terms in addition to the displayed core. The positive core differences do not prove an actual runtime or proof-size winner. They do give a concrete break-even test rather than treating normalization as a free width reduction.

Under the existing single-precision cache design, the saved main ledger has 88576420247296 runtime complex divisions and 337702368 kernel cache entries. If ALL those existing caches and runtime uses are converted under this proof, those runtime divisions disappear and one scaling-round per existing cache entry is added. These are conditional projections of the already pinned comparator, not new occurrence counts, a new global cost fold or an adoption. Precision/lifetime duplication must be charged before using the setup figure.

## 6. Evidence and remaining implementation work

`independent-feasibility/bluestein_cached_normalization_20261111.py` has SHA256 `A0A26A3B03297871BE12B2DC4FC5F37006B071FED113CB325ACBDC6EFC0001F3`. Its final receipt `bluestein_cached_normalization_20261111_v2.json` has SHA256 `E8403465E72AB99A94F7F210801CE6FE17CE6679E9AEF29EEFBC3492B642B793`. The 1708 checks verify five input pins, finite structural examples of every scalar inequality, all local stage counts/prices for the displayed sizes at p112/134/152, integer tie rules, rational grid-rounding commutation and the cancellation of width changes in the exact fine-grid representation. The general result is the algebraic proof in sections 2-4, not extrapolation from the examples. No author program or inventory was imported. The draft receipt without the v2 suffix is retained but is not the selected execution evidence; the final script replaces its redundant rescaling assertion by an explicit rational rounding comparison. Its numeric output is unchanged.

The candidate requires ordinary proofs of the new cache binding and dyadic rounds, the intrinsic error composition, sufficient finite capacities, and the exact DFT normalization identity. Setup and coefficient enclosures remain certified inputs. Any actual output test must use the new centers and complete error radius. The scaled-kernel proof can preserve the old conservative CT/tensor error target while reducing the selected runtime arithmetic, but selecting an implementation still requires (8) with full prices and independently reviewed input/output bindings.
