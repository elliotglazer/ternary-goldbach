# Full-family batching and symbolic workload

2026-11-11. This note counts arithmetic indices and describes a possible certificate producer. It evaluates no L-function and predicts no elapsed time, throughput, or proof-checker speed. All meshes and numerical precisions below are explicit parameters. The full spectral assertion remains unproved.

## 1. Exact family and height inputs

The selected manifest is `zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md`, SHA256 `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54`, independently reviewed in integration at SHA256 `EEE3BAE662500804EAEC0268A8612D0E01ED1C2FAF5D0208D442A97739794664`. Its coordinate bijection and conductor tests, not the totals alone, supply the proposed coverage argument.

In the pinned target source, `MinorArcs/LargeSieveWeights.lean:26` defines `qt(c)=c` for even c and `2c` for odd c. `LargeSieveArcs.lean:34` defines the permitted modulus set by `qt(c)<=2R`. The target revision is `23b2d68ca344203d4384e0aff7affa4ec034bef9`. At R=150000 the nonempty primitive conductor family is odd c<=150000 together with 4|c<=300000. This note excludes c=1, whose sole primitive character belongs to the separate principal task.

Write a(c) for the number of primitive characters and v(c)=phi(c). For all active c>1 every primitive character is nonprincipal. The multiplicative local count is a(p)=p-2 and a(p^e)=p^(e-2)(p-1)^2 for e>=2. The accompanying script instead computes a by divisor inversion of phi, then checks these local formulas for every active conductor.

The exact selected height is

`Hp(c)=200+max(1000,ceil(704*1200000/(7*qt(c))))`,

`H(c)=Hcert(c)=min(Hp(c),100000000/c)`.

The second argument of this minimum is rational and is not rounded upward. This is the profile in the manifest and in the reviewed common-height major calculation. The original and reduced alternative profiles are not substituted here.

For a simple strictly higher integer endpoint define `T0(c)=floor(H(c))+1`. Then H<T0<=H+1. T0 is only a workload reference. An actual zero-exclusion certificate extending to T0 must certify that extended rectangle; the height comparison alone proves nothing about its zeros. An implementation may choose different rational T(c)>H(c), recording and counting those actual choices.

| Family | Conductors | Primitive outputs sum a | Unit coefficients sum v |
| --- | ---: | ---: | ---: |
| Odd c>1 | 74,999 | 3,695,775,214 | 4,559,466,206 |
| 4 divides c | 75,000 | 1,847,864,973 | 4,559,475,642 |
| Total nonprincipal | 149,999 | 5,543,640,187 | 9,118,941,848 |

The exact integer height-weighted sums are

`sum a(c)T0(c) = 5,392,479,925,954`,

`sum v(c)T0(c) = 8,173,681,360,378`.

For the original rational H, exact directed arithmetic gives

`5,389,139,068,717 < sum a(c)H(c) < 5,389,139,068,718`,

`8,168,419,017,363 < sum v(c)H(c) < 8,168,419,017,364`.

The receipt records much tighter rational intervals of width less than 0.109, obtained by rounding each weighted term outward at scale 10^6. It also records conductor-parity and dyadic-conductor subtotals. No floating-point comparison is used.

The largest unit array has 149,992 entries, at c=149993. The largest primitive output set has 149,991 entries there. There are at most seven cyclic axes, attained at c=120120. The maximum selected H is 25,000,000 at c=4. These maxima do not imply equal evaluation difficulty across conductors.

These are counts of primitive spectral tasks. They must not be multiplied by the number of inducing ambient moduli. Downstream imprimitive Gauss weights remain exactly those in the analytic major-arc proof; this batching construction changes none of them.

## 2. One exact shared-sample identity

The following finite identity is enough to describe a sound, though potentially very slow, common-sample producer without assuming a new Hurwitz evaluator. For any integer N>=1, complex s, and unit residue u modulo c, set

`F[u,N](s)=sum_{1<=n<=N, n mod c=u} exp(-s*log n)`.

Use the manifest's specified CRT coordinates x(u) in a product of cyclic groups of orders m_i. Its positive-exponent character label r satisfies

`chi_r(u)=exp(2*pi*i*sum_i r_i*x_i(u)/m_i)`.

Then, by partitioning the finite sum and using zero values on nonunits,

`S[N,r](s)=sum_{n=1}^N chi_r(n)n^(-s)`

`=sum_{u unit} F[u,N](s) exp(2*pi*i*sum_i r_i*x_i(u)/m_i)`.

This is the unnormalized positive-sign group transform of v(c) coefficients. It gives all v(c) character labels; the exact primitive predicate retains a(c) of them. A negative-sign library transform returns inverse labels, and a normalized inverse transform needs a factor v(c). Both the sign/permutation and scale require proof. The finite identity is valid at s=1 too. No individual totalized Hurwitz value or common-pole cancellation is needed for this fallback.

For primitive outputs, the independently reviewed direct-evaluator bound gives

`|L(s,chi_r)-S[N,r](s)| <= C_c*N^(-b)`,

where b=111/200 and `C_c=(c+1)(1+B_c/b)` on the chosen rectangle, with `B_c=2+T(c)` for the symmetric strip. The same N works for every primitive label at that conductor and point. Nonprimitive principal transform outputs may simply be discarded; no continuation or tail claim for them is used.

For output error e, one sufficient allocation is tail <e/3, each of the v(c) input coefficient errors <e/(3v(c)), and total transform arithmetic error <e/3 in each retained output. The exact transform has maximum row absolute sum v(c). Thus a normalized FFT error must not be substituted for an unnormalized L-value error without rescaling. The interval precisions needed for this allocation are part of the workload, not known constants.

Constructing the F array directly takes at most N exponential/power terms and N bucket additions, with v(c) stored buckets; terms at nonunits can be skipped. The N terms can be streamed. A faster EM or Hurwitz implementation can replace this construction, but its cost per coefficient and its common-pole semantics must be proved separately. Denote that actual coefficient-generation cost by G(c,s,N,p), or by v(c)E(c,s,p) when an implementation really evaluates v(c) coefficients separately. Neither E nor G is set to a fixed operation count here.

## 3. Costs that can and cannot be compared

Let J_c be the multiset of point-evaluation calls actually requested at conductor c, including repeats at tighter precision. Let p_cj denote the actual precision and N_cj the actual finite-sum cutoff if the fallback is used.

Three implementations have distinct arithmetic models.

1. Separate character evaluation computes each of the a(c) sums at a point. A literal implementation repeats N_cj power evaluations and roughly N_cj character multiplications for each character. Reusing the powers reduces their count to N_cj but still leaves character accumulation work. Its cost cannot be reduced to a(c) alone.
2. Group the common F array, then evaluate only the primitive rows by dense dot products. This has common generation cost G and a(c)v(c) complex multiplication terms, with a(c)(v(c)-1) additions. These are literal dense-loop counts, not complexity lower bounds; special roots and zero coefficients may reduce them.
3. Group F, then use a product-group transform. This has common generation cost G, transform work on all v(c) labels, and a(c) output checks. The transform does not remove the need to inspect and certify every retained label in this proposed per-character certificate protocol.

The manifest's cyclic axes are `(p-1)p^(e-1)` at odd p^e, one axis 2 at modulus 4, and axes 2 and 2^(e-2) at 2^e for e>=3. Their product is v(c). A literal tensor implementation of the cyclic DFT has `v(c)*sum_i m_i` multiplication terms at one point. This already differs from a primitive-row dense matrix.

For an arbitrary-length FFT, the operation count is conditional on an additional exact algorithm/rounding adapter. A possible choice is cyclic-axis Bluestein reduction: use a radix-two convolution of length `P_i=2^ceil(log2(2m_i-1))` with the required wrapped negative-index chirp. The phase identity is

`exp(2*pi*i*j*k/m)=exp(pi*i*j^2/m)*exp(pi*i*k^2/m)*exp(-pi*i*(j-k)^2/m)`.

The cyclic padding, requested output indices, inverse normalization, and interval propagation still require a proved adapter. Existing finite radix-two rounding plans do not alone supply that adapter. In particular, most axes are not powers of two, so the old 36-stage height example cannot be used here as a theorem about a unit-group transform.

Define a deliberately conservative arithmetic proxy using three radix-two FFTs per axis fiber, without caching the chirp transform:

`Bfft(c)=sum_i (v(c)/m_i)*3*(P_i/2)*log2(P_i)` butterfly applications,

`Qfft(c)=sum_i (v(c)/m_i)*(P_i+2m_i)` convolution and pre/post-chirp products.

The proxy excludes coefficient construction, twiddle construction, scalar normalization details, interval operations, proof processing, data movement and output checks. Caching a kernel transform may improve it, but no such savings are assumed. A butterfly is not assigned the cost of a complex multiplication or a Lean inference.

| One common point at each conductor | Exact proxy total |
| --- | ---: |
| Primitive dense-row multiplication terms | 490,208,540,122,572 |
| Full tensor direct-DFT multiplication terms | 160,881,965,045,064 |
| Three-FFT butterfly applications Bfft | 760,838,324,652 |
| Additional products Qfft | 118,771,491,024 |

The largest padded axis P_i is 524,288. The smaller proxy totals are an algebraic opportunity, not a runtime ratio. At the unknown required precision, coefficient construction or interval proof processing could dominate all four totals.

The general workload is a sum over the actual calls: `sum_c sum_{j in J_c} [G(c,j)+Transform(c,p_cj,e_cj)+OutputChecks(c,j)]`. Per-character adaptive calls need not coincide; common batching benefits only calls with the same exact s and compatible error targets. Replacing the union of those calls by one nominal height density without checking this compatibility would undercount work.

## 4. Explicit sample-density parameters

To expose geometric factors, consider one reference stage on `[b,2] x [-T0(c),T0(c)]`, with nx>=1 horizontal cells and ny=2*rho*T0(c) vertical cells, for integer rho>=1. The stage requests every vertex and every edge midpoint exactly once. Their counts are

`V=(nx+1)(ny+1)`, `E=nx(ny+1)+(nx+1)ny`,

`S=V+E=(3nx+2)ny+2nx+1`.

Consequently, for any per-point weight w(c), the exact reference-stage total is

`sum w(c)S(c)=2*rho*(3nx+2)*sum w(c)T0(c)+(2nx+1)*sum w(c)`.

This counts the full signed ordinate range for every character. No unproved conjugate-height halving is applied. The receipt gives exact T0-weighted sums for all four arithmetic proxies, as well as a and v, so any such integer nx,rho choice can be evaluated without a new conductor scan.

For example, nx=1 and rho=1 would request 53,941,430,180,101 primitive output values and 81,764,170,429,324 unit coefficients in one stage. At nx=1 and rho=16 those counts become 862,813,419,073,201 and 1,307,816,374,486,024. These grids are **not certified sufficient**. They do not bound the true task's sample count. Vertical density alone also does not control the horizontal panels of width 2-b.

An adaptive implementation must count all evaluated stages and precision upgrades. Distinct geometric locations are not enough: reevaluating a fixed location at higher precision has a new cost. The elementary fallback's N can grow sharply as the requested error decreases. No upper bound on that growth for the actual family follows merely from the Hcert profile.

## 5. A complete batching design with no assumed numerical margin

Use the actual manifest to schedule every conductor, every primitive tuple, and the full closed signed strip. For each conductor pick and record rational T>Hcert. Start from a finite rational rectangular grid and refine it dyadically in both directions. At stage j request a common point tolerance tending to zero, compute the common coefficient arrays at each distinct midpoint and vertex, transform, and retain every primitive label. A direct dense transform remains an exact fallback if no arbitrary-axis FFT adapter has been completed.

Within a stage, key every image vertex by `(c, primitive tuple, exact rational input vertex, stage)`. Generate its rational center once and use that same value on all incident edges. The midpoint value and the common derivative bound

`L_c=(c+1)(1/b+B_c/b^2)`

give a whole-panel enclosure. Test a strict signed coordinate half-plane for the whole panel and both stored endpoints. Compute each cell's exact rational polygon crossing sum. Accept a conductor only if every primitive tuple has a closed cell cover with all counts zero and every geometric and label check passes. Validate the finite Cartesian tuple ranges and primitive filter, rather than comparing only a total number of successful records.

At any failed stage retain the failure as unresolved, refine, and do not claim the conductor complete. A fair scheduler interleaves unresolved conductors. A later stage is a new coherent certificate; it does not combine incompatible rational vertex approximations from different stages. This avoids relying on hashes or approximate agreement as proofs of shared vertices. The checker checks exact rational equality and identifiers; hashes may serve only transport/integrity bookkeeping.

This construction is conditionally complete for any fixed family of chosen rectangles that is actually zero-free on its full closed region. Indeed there are finitely many characters per conductor; continuity gives a positive minimum over their compact rectangles, although its value need not be known. Refinement and decreasing error eventually produce strict panel half-planes everywhere. Exact zero counts then follow. No numerical lower bound on this minimum is accepted as input to the finite checker.

This conditional argument does not establish that the rectangles are zero-free. The selected spectral goal beta<=b permits a zero exactly at beta=b, whereas this closed-strip method excludes one. Such a boundary zero could make this producer fail even if the selected spectral assertion were true. The proposal does not change the final assertion to assume that no such zero exists. Likewise choosing T>Hcert creates a stronger finite region to certify, not an automatic extension of known zero information. A separate method would be needed if either obstruction occurred.

The accepted slab assembly supplies the final union step, including seams: `FAMILY_STRIP_SLAB_ASSEMBLY_2026-11-11.md`, SHA256 `5064865E9CE249A896B6B083278938E0E77762B88DE4539E038E624AC011FF93`, reviewed at SHA256 `C4A41C85540F6B64E53FD04B485AA879F326D98AD5B049A0CFD5FEC634CA6BC7`. Isolated passing slabs or a subset of character labels never satisfy the stated completion check.

## 6. Sharding, memory and unknown quantities

Conductor-level shards are independent once their exact manifests and height choices are fixed. At one point, the finite grouped-sum fallback stores v(c) coefficient buckets and streams n. A tensor transform needs an array of v(c) complex enclosures and work buffers for a padded axis; a straightforward implementation has working storage `O(v(c)+max_i P_i)` complex enclosure entries, with a fixed number of such buffers. The number of bits per entry and exponent/index overhead remain parameters.

For streaming a strip stage, two adjacent rows of image vertices plus the current midpoint/output data and per-cell crossing accumulators suffice geometrically. Keeping these in memory costs additionally `O(a(c)(nx+1))` entries, or they can be stored and reread as exact external records. The output proof data scale with primitive edge/cell records and their rational precision. All 5.54 billion character outputs across all conductors need not reside in memory at once. Conversely, sharding labels does not make a common transform intrinsically smaller: each transform still uses its v(c)-entry coefficient array unless a separate blocked/pruned algorithm is proved and counted.

The following are not provided by the arithmetic model: actual minimum distances from zero on candidate edges; successful rational top endpoints; required vertical and horizontal mesh sizes; successful point error targets; interval precision and cancellation losses; EM/Taylor degrees or direct-sum N; arbitrary-axis transform proof/rounding costs; storage/recheck costs; and the volume of unsuccessful refinement. Without these there is no finite numerical throughput estimate or guaranteed production volume. The arithmetic totals identify where batching can remove repetition, while keeping those missing inputs visible.

## 7. Reproduction and status

Run `work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/major-constants/family_batch_workload_20261111.py`. It sieves phi through 300000, obtains a by divisor inversion, checks the local primitive counts and axis products, and evaluates the exact profile and arithmetic proxies. It performs no transform and constructs no character value table. The JSON includes all parity/dyadic subtotals and a digest of the canonical arithmetic rows.

- Script SHA256: `F6B182D6DF34756385CDAC690D8EE3AAF7E755DA3A69583B125FEB61464C6D82`.
- Receipt `family_batch_workload_20261111.json` SHA256: `CC223B05E14E0DEF2B8DD5DB9567F638B9328D97D5A555D6B86B3D263597D543`.
- Arithmetic row digest: `FED5ABB8B36C4444588D94A6F137872B401457D7D9A699E450938EBAEA335C7A`.

The new finite grouping identity and the workload formulas are paper derivations, not approved Lean declarations. The radix-two extension supplies a possible rounding component, but the arbitrary-axis convolution adapter and actual production data are still missing. No numerical spectral assertion, Gauss-weight change, new final premise, or performance guarantee is introduced.
