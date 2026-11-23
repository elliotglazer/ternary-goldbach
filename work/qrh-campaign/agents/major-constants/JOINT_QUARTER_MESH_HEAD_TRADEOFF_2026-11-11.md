# Joint shorter head and quarter-mesh seed construction

2026-11-11. This paper construction uses **V=7000, D=4096, N=1500, m=256 and P=28** in the final shared Hurwitz seed band. It delivers the same fine P20 interface with output normalization Q=8192 and fine-anchor denominator16384. The joint error proof below gives source error less than .107 eta, delivered numerical coefficient error less than .557 eta, and full isolated-alpha error less than .16 times2^-82, where eta=2^-100. These are sufficient upper bounds, not computed function errors.

The N1500/m256 and D4096/P28 components have independent paper reviews. Their conjunction is a new construction: the R and E error constants change simultaneously, the correction sum has256 terms, and the final argument set shrinks within the preceding grid. This report and its exact receipt require their own independent review. No analytic values, transforms, prime or zero tests, Lean declarations or builds were produced. Frozen predecessors remain unchanged.

## 1. Exact function, finite identity and remainder

Let s=1/2+it with |t|<=7000 and a in[0,1]. Put z=1+a and b=N+z, so1501<=b<=1502. The source coefficients are the actual continued-Hurwitz derivatives

    U_k(a)=f^(k)(a)/(D^k k!)
          =(-1)^k(s)_k zeta(s+k,1+a)/(D^k k!),
    f(a)=zeta(s,1+a), 0<=k<28.

Use all28 coefficients at every one of the4097 coarse endpoints, including a=1. Its last coefficients supply a negative-quarter translation. The finite Euler–Maclaurin identity is the reviewed shared-seed identity, with its actual remainder, for arbitrary positive integer m. Here Re(s+k)+2m>1 and |s+k-1|>=1/2, including k=t=0. No pole-type term is dropped.

Set W=V+32+2m=7544 and r=17/20. Every relevant rising factor has norm at most W. The periodic-Bernoulli bound gives

    |U_k-U_k^EM| <= 4 sqrt(b)/(k+511.5)
       * (W/(bD))^k/k! * (W/(6b))^512
       <= R := 4*1502/(511.5)*(17/20)^512 <2^-116.       (1)

Both W/[D(N+1)]<1 and W/[6(N+1)]<17/20 are checked rationally. The receipt also checks each of the28 actual k-dependent upper expressions. This is a bound on the finite EM remainder, not a claim that an asymptotic EM series converges. The smaller D does not invalidate (1); the first scaled ratio remains below1.

Retain the exact finite circuit

    R_k=(-1)^k(s)_k/(D^k k!),
    D_k=sum_(n=0)^(N-1) B_(n+z)*(n+z)^(-k),  B_x=x^(-s),
    E_l=(s)_l/(6b)^l,
    lambda_k=(-1)^k(6/D)^k/k!,
    gamma_j=6^(2j) B_(2j)/(2j)!, 1<=j<=256,
    S_k=sum_(j=1)^256 gamma_j E_(k+2j-1),
    Z_k=b E_k/(s+k-1)+E_k/2+S_k/6,
    F_k=lambda_k Z_k,
    U_k^EM=R_k D_k+B_b F_k.                            (2)

The exact identity lambda_k E_k=R_k/b^k checks the normalization of the pole, half and Bernoulli terms together. The largest E index is538. This is distinct from the longer rising product in the actual remainder. The gamma_j are signed normalized Bernoulli coefficients, with |gamma_j|<4 for every j used. Their rational construction through Bernoulli index512 and the general bound remain proof obligations inherited from the shared EM circuit, not from a numerical evaluation.

## 2. Joint source error, including both changed recurrences

Use absolute complex errors delta=2^-118 for B_x and u=2^-122 for each named inner rounding gate. Exact rational factors, divisions and aligned dyadic sums are allowed between those gates. A nearest coordinate grid of step u has Euclidean error below u. Every denominator retains its stated nonzero proof. A fixed hardware precision is not asserted sufficient merely from these error targets.

For R, A=(V+32)/D<7/4. The first factor acts on exact R_0=1, and every subsequent factor has norm less than7/8. Therefore

    e_R,next <=(7/8)e_R+u,       e_R<=8u.

The actual magnitudes A^k/k! are below2 for all required k; thus the loose stored bound |Rhat|<=5 holds. For E the weaker contraction r=17/20 gives

    e_E<=u/(1-r)<7u,            |Ehat|<=2.

The lambda recurrence still has factors below1/2 and error at most2u. Neither the old R constant3u nor the old m64 E constant2u is reused.

Since |E_l|<=r^l, the complete correction satisfies |S_k|<=4r/(1-r^2)<13. Round each gamma_j once with error at most u. Each rounded gamma-E product then has error at most4*7u+2u+u=31u. Summing256 terms exactly gives7936u. The three separately rounded Z terms have errors at most(14b+1)u,5u and1324u. Their exact sum gives

    |Zhat-Z| <=(14b+1330)u,
    |Z|<=2b+3, |Zhat|<=2b+4,
    |Fhat-F| <=(18b+1339)u.

The endpoint B_b F_k error is at most

    (2b+3)delta+(36b+2679)u.                          (3)

For the head, reciprocal-power recurrences have factors at most1. With P28, R error8u, |Rhat|<=5 and true head magnitude at most N, the head contribution is bounded by

    5N delta+(5NP+8N+1)u.                            (4)

Adding (1), (3), (4) and the final addition gate gives the new joint source bound

    e_seed=10507delta+278753u+R <.107 eta<eta/4.       (5)

This covers every source slot, including the right endpoint. The head-only packet's263753u and the mesh-only packet's m64 endpoint allowance are not used in (5).

For stored magnitudes, factor E_k from each correction algebraically, without dividing by it. The same geometric sum proves

    |F_k| <=(2b+3)|R_k|/b^k,
    |U_k^EM| <=C A^k/k!, C=3N+7=4507.

The translated work magnitude is less than6C+1=27043<2^16. The extra1 pays rounding since2^28(e_seed+350*2^-110)<1. This is a stored complex-magnitude cap. It does not bound exact rational numerators, denominator products, phase-reduction integers or proof witnesses. E stored magnitudes stay below2; the correction sum stays below14.

## 3. Shift, output normalization and actual-alpha error

For each fine anchor b_out=l/(4D), select the left coarse endpoint for the quarter and midpoint, the right coarse endpoint for the three-quarter point, and itself for a coarse endpoint. In source units tau=D(b_out-a) is1/4,1/2,-1/4 or0. The finite output polynomial is

    V_k^fin(b_out)=2^-k sum_(j=k)^27 binom(j,k) U_j(a) tau^(j-k),
    0<=k<20.                                       (6)

Thus Q=2D=8192 is the output normalization, not4096. Run the actual pruned Pascal loop with descending outer index and increasing inner index,350 updates per nonzero shift. Its exact matrices are checked independently in this receipt at all three signed tau values.

For |tau|<=1/2 the postscaled absolute row sum is at most2. Any individual injected gate error passes through a suffix of the positive translation matrix; prefix>=identity shows that suffix is entrywise bounded by the full matrix. The postscaled entries are bounded by binom(j,k)/2^j<=1. Signed shifts use the absolute positive matrices. Hence, with u_T=u_C=2^-110,

    e_out <=2 e_seed+350u_T+u_C <.557 eta<eta.         (7)

The final scale2^-k is exact; u_C pays its subsequent rounding at all delivered slots. Coarse output anchors satisfy the same bound with no translation. There are20*(4D+1)=327700 delivered slots per height. The source and final errors in (5)–(7) concern normalized coefficients. Unscaled derivative errors would be multiplied by D^k k! or Q^k k!, respectively; no unchanged raw-derivative radius is claimed.

The final numerical eta radius is relative to (6). The finite shift's analytic bias remains separate. A target alpha in[0,1] uses its nearest fine anchor with a fixed tie rule. Then |Q(alpha-b_out)|<=1/4 and |D(alpha-b_out)|<=1/8, while |b_out-a|+|alpha-b_out|<=5/(8D). All real interpolation segments remain in[0,1]. The continued-Hurwitz high-derivative bound from the shared shift proof gives

    E_target=1266*((V+20)/(4Q))^20/20!,
    E_shift=1266*(5(V+P)/(8D))^P/P!.

Retain the actual character amplification633, numerical coefficient contribution844eta and final Horner rounding1688u_H with u_H=2^-100. The complete character-summed isolated-alpha allowance is

    E_alpha <=E_target+E_shift+844eta+1688u_H
              <.16*2^-82<2^-82.                     (8)

The receipt proves (7) and (8) as exact rational comparisons. Shift rounding is already in (7) and is not counted again in (8). Conversely, the analytic E_shift is not silently folded into the numerical eta coefficient radius. Exact rational target displacements are used; additional input uncertainty would need a separate charge.

## 4. Retiring arguments rather than refining their grid

The preceding band has D4096,N1720 and the argument set x=1+j/4096,0<=j<=1721*4096. The new band has the same grid and0<=j<=1501*4096. Therefore:

| Argument-set quantity | Count |
|---|---:|
| Preceding band and total required union |7049217|
| Retained final-band arguments |6148097|
| Retired after their last preceding-band use |901120|
| Newly introduced arguments |0|

Earlier bands also lie in that preceding grid, with smaller endpoint. At the first final-band height, update each retained fine state from its immediately preceding height. Do not initialize it anew, feed its rounded EM copy back, or use any retired state after retirement. Each argument still has a consecutive active height interval shorter than128000 steps.

The accepted elementary allocation remains log error2^-144, initial B error2^-120, fine step and update errors2^-140, and independent EM-copy error2^-122. All arguments satisfy x<=1722 and final heights satisfy |t|<7000. These are subsets of the established domain. The altered D appears only in the scaled coefficient circuit and in exact grid indexing, not in a weakened elementary leaf guarantee.

For H final heights, final argument pairs and fine updates both equal6148097H. There are no final-band initial B, step-cis or step-grid certificates. Total required elementary inputs stop at7049217, rather than the baseline19562497, head-only13197313 or mesh-only9781249 union. This is a set identity, not an assumption about how quickly a cache can release storage.

Keep the preceding band's complete log grid rather than designing a sparse new log algorithm. Its relative-radius block recipe has960 anchors and148013397 degree21 nonanchor Horner stages. All of that work is already required before the final band; the new final band adds zero log blocks. The receipt reconstructs the rational block endpoints. The head-only packet's959 anchors belong to a different finer grid and are not imported here.

## 5. Four-way operation comparison

All columns below use the same requested final heights and fine P20 outputs. The baseline is the reviewed V7000/D8192/N2387/m64 retune, not the older V10000/N3387 inventory. The middle columns isolate the two reviewed components; the joint column is recomputed from the new circuit, not obtained by multiplying savings percentages.

| Per final height | Baseline | Head only | Mesh only | Joint |
|---|---:|---:|---:|---:|
| Source coefficient slots |221204|221204|114716|114716|
| Head reciprocal scales |508457257|319516500|264047553|165928500|
| Head additions |528013948|331806000|273827092|172074000|
| Bernoulli weighted terms |14157056|56628224|7341824|29367296|
| Bernoulli additions |14157056|56628224|7341824|29367296|
| E recurrence stages |1253522|4399634|630938|2204186|
| Translation updates |2703360|2703360|4300800|4300800|
| New final scales |0|0|327700|327700|
| New final rounding gates |0|0|327700|327700|
| Shared R recurrence stages |26|26|27|27|
| Coarse endpoint instances |8193|8193|4097|4097|

Joint source slots equal P(D+1); head scales equal N(P-1)(D+1); E stages equal(P+2m-2)(D+1); each Bernoulli row equals mP(D+1). The three shifts per coarse interval give3D*350 updates. Endpoint assembly, denominator construction and associated gates remain required per source slot. They decrease with the slot count but are not hidden inside a numerical percentage. Their exact factor construction and rational witness costs still need an implementation price.

The receipt multiplies every row by the current combined-profile final-band lengths20199,20366,20519,20839 for main and+167/+320/+640, respectively. The earlier four bands, totaling64001 heights, are unchanged. These are the current combined-profile prefixes, not the older quarter-mesh component's21901-based prefixes. The maximum last height is424195/64<7000. Added auxiliary nodes are scenarios, not assertions that Turing closure succeeds there.

Relative to the baseline, per height the joint construction saves342528757 head scales and355939948 head additions, but adds15210240 Bernoulli terms and additions,950664 E stages,1597440 translation updates,327700 final scales and327700 final rounds. Relative to the head-only construction it halves much of the source work but still adds the extra translations and final normalization. Different gate types and intermediate widths have not been equated.

Setup uses256 gamma constants,192 more than the baseline, with exact Bernoulli construction through index512. The D4096 lambda table reuses its existing first27 entries and needs entry27. An E buffer has entries0 through538 per active anchor if fully retained. Final coefficient storage and the subsequent residue contractions, character transforms, sign checks and completeness certificates are unchanged. This packet gives no runtime or peak-memory conclusion; those require scheduling, widths, witness formats and actual implementation costs.

## 6. Evidence and remaining work

The companion joint_quarter_mesh_head_tradeoff_20261111.py and JSON contain1543 exact checks: recurrence and EM bounds, all28 source orders, signed translation matrices, output rows and gate amplification, final errors, grid retirement,960 log blocks, four fixed prefixes and nine input hashes. They do not evaluate an L-function, exponential, logarithm, gamma function, prime, zero or transform.

The source-level foundations remain the exact shared EM identity and Bernoulli bound, the continued-Hurwitz derivative estimate, the finite Pascal loop, and the certified elementary height recurrence. They are pinned through the reviewed source reports below. This note does not claim fresh Lean elaboration or reprove those foundations. Actual leaf/gate certificates and final enclosures still have to be generated and independently checked. No containment in older saved numerical centers is asserted.

| Frozen prerequisite | SHA256 |
|---|---|
| major-constants/FINAL_SEED_HEAD_CORRECTION_TRADEOFF_2026-11-11.md |3B760B39986F6A80C1ADB71BCABDEFDE28947964225383AF1073E6601162DE4F|
| independent-feasibility/REVIEW_FINAL_SEED_HEAD_CORRECTION_TRADEOFF_2026-11-11.md |7BB25BC96EE9C27FE03038968EFC9E9F52A4B3064D9F0986865CF68AC8E77365|
| zero-sum/QUARTER_MESH_P28_SHARED_SEED_2026-11-11.md |A0CD531E1FD20280E49B1EC0AE95E32809C7965222C40916BD4712F7F3A5EA19|
| prime-estimates/REVIEW_QUARTER_MESH_P28_SHARED_SEED_2026-11-11.md |8D50DDB6C7398D10930F8437ABE9B3E0C672F9AD1F85851D040EF1BD6D385B6A|
| prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md |251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231|
| integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md |1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E|
| integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md |861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895|
| work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md |8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413|
| major-constants/combined_odd_even_height_inventory_20261111.json |BCBAA29AE9A963A46170C5B7B355C0399EE6A622EDBE355ECD24BFE92042C2EE|

Paths in this table, except the explicit blueprint path, are under work/qrh-campaign/agents. The new script and receipt are frozen beside this note; their hashes are supplied with the handoff, avoiding a circular self-hash.
