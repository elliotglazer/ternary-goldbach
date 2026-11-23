# Independent review of the family workload model

2026-11-11. Verdict: PASS for the arithmetic totals, finite batching identities, and explicitly conditional producer design. No mathematical correction is requested. This is not a prediction of runtime or a certificate of spectral coverage. The frozen report's statement that an arbitrary-axis transform proof is missing has since been superseded at paper level by a separately reviewed supplement, identified below; the implementation remains missing.

The target is `major-constants/FAMILY_BATCH_WORKLOAD_MODEL_2026-11-11.md`, SHA256 `3A5444AB295112E86DF0740DB8F4533EC37510A66E41EB0DF0340D16CF82A4E1`. Its script is `F6B182D6DF34756385CDAC690D8EE3AAF7E755DA3A69583B125FEB61464C6D82`, and its receipt is `CC223B05E14E0DEF2B8DD5DB9567F638B9328D97D5A555D6B86B3D263597D543`. Paths are relative to `work/qrh-campaign/agents/` except where stated. No original source, report, or receipt was changed; no Lean/Lake build, L-value evaluation, transform, or spectral scan occurred.

## Independent full arithmetic replay

I read the report and complete script, the selected manifest and its height formula, the source `qt` and `Qset` definitions, the accepted slab assembly, and the direct evaluator proof/review. I reconstructed the full receipt without importing or executing the producer.

The independent script uses a linear least-prime/totient sieve, derives primitive counts multiplicatively from local prime powers, and then checks their divisor convolution against phi for every integer from 1 through 300000. This reverses the producer's approach, which obtains primitive counts by divisor inversion. It reconstructs all 149999 active rows, axis dimensions and padding, six arithmetic weights, all directed rational height bounds, all maxima, all parity/dyadic subtotals, and all grid examples. Every receipt field matches.

Reviewer artifacts:

* `mellin/review_family_batch_workload_20261111.py`, SHA256 `AAD5FC17046B810086F056B39D57AA79D99BA8D9B2DEEB30C809BEFD560C86B3`.
* `mellin/review_family_batch_workload_20261111.json`, SHA256 `95F1268CCD2199AE4FB52D50149F41E0277035549CCC5C8DEA646F74EC1736F6`.

The run exited 0 with `PASS_FULL_ARITHMETIC_RECEIPT_RECONSTRUCTION`. Its canonical row digest is exactly `FED5ABB8B36C4444588D94A6F137872B401457D7D9A699E450938EBAEA335C7A`. This is evidence for the arithmetic model only; it evaluates no character or spectral function and supplies no production timing estimate.

## Family, local counts, and selected heights

The actual source `MinorArcs/LargeSieveWeights.lean:26` defines qt(c)=c for even c and 2c for odd c. `LargeSieveArcs.lean:34` restricts ambient moduli by qt(c)<=2R and positivity. The manifest's conductor argument therefore yields odd c<=150000 and c divisible by four with c<=300000; conductors congruent to 2 modulo 4 carry no primitive characters. Removing conductor one leaves exactly 149999 conductor rows.

The local primitive formulas are a(p)=p-2 and a(p^e)=p^(e-2)(p-1)^2 for e>=2, including p=2. These count the manifest's primitive coordinate predicates. CRT makes the counts multiplicative. The independent divisor-convolution check supports, but does not replace, the manifest's proof that the coordinates cover the actual source characters uniquely.

The replay confirms the reported totals 5543640187 primitive outputs and 9118941848 unit coefficients. Their difference matters: a common transform consumes phi(c) input coefficients and produces all phi(c) character labels, even when only a(c) primitive outputs are retained. No factor for inducing ambient moduli belongs in this count.

The height remains exactly

    H=min(200+max(1000,ceil(704*1200000/(7*qt(c)))),100000000/c).

The second branch remains rational. T0=floor(H)+1 satisfies H<T0<=H+1, including when H is already integral. This is a design height, not an established extension of any spectral theorem. All reported weighted sums, directed H intervals and maxima match the independent reconstruction. Each rational-height summand is rounded outward at scale 10^6; summing those directed bounds proves the aggregate interval. Their widths below .109 are arithmetic rounding widths, not spectral errors.

## Finite transform identity and its error contract

Partitioning the exact finite sum by unit residue gives

    sum_(n=1)^N chi_r(n)n^(-s)
      = sum_(u unit) F[u,N](s) exp(2*pi*i*sum_i r_i*x_i(u)/m_i).

The omitted nonunits have character value zero. This is the unnormalized positive-sign group transform in the specified CRT coordinates. A negative-sign transform gives inverse labels; a normalized inverse needs the full phi(c) multiplier. The identity uses buckets of n^(-s) itself, so it has no additional c^(-s) factor. Such a factor belongs to the separate Hurwitz-coefficient representation and must not be copied into this fallback.

The common finite-sum remainder C_c*N^(-b), with C_c=(c+1)(1+B_c/b) and B_c=2+T(c), agrees with the accepted direct-evaluator proof. That proof includes the Abel boundary term A(N)N^(-s); it does not assume N is a multiple of c. The same uniform bound applies to every primitive output at that conductor. No remainder claim is made for a discarded principal output.

If every input coefficient has complex-norm error below e/(3phi(c)), the exact transform's row absolute sum phi(c) bounds input perturbation by e/3. Tail below e/3 and total transform arithmetic error below e/3 then give output error below e. Arithmetic error must include approximate roots and the correct normalization. The report leaves that requirement explicit rather than treating an FFT call as an exact transform.

The literal dense-row count a(c)phi(c) and addition count a(c)(phi(c)-1) are correct. The tensor direct count phi(c)sum_i m_i follows because each axis has phi(c)/m_i fibers and m_i squared multiplication terms per fiber. Coefficient generation G remains separate and may dominate either count.

For each axis, the proposed padding is the least power of two P_i>=2m_i-1. Three length-P_i transforms have 3(P_i/2)log2(P_i) butterfly applications per fiber. The additional P_i+2m_i products represent the convolution and two chirp multiplications. The replay confirms the four reported aggregate proxies and maximum padding 524288. Normalization operations, twiddle construction, interval work, output checks and data movement are expressly excluded. These are not comparable wall-time units or complexity lower bounds.

## Exact grid counts and shared scheduling

For nx by ny cells, there are (nx+1)(ny+1) vertices, nx(ny+1) horizontal edges, and (nx+1)ny vertical edges. Each edge has one midpoint distinct from all vertices and other edge midpoints on this strict Cartesian grid. Thus

    S=(nx+1)(ny+1)+nx(ny+1)+(nx+1)ny
      =3nx*ny+2nx+2ny+1
      =(3nx+2)ny+2nx+1.

With ny=2rho*T0 for integer rho>=1, this gives exactly the report's weighted-stage formula. The examples count the entire signed ordinate range. They apply no unsupported conjugation halving and make no claim that the selected grid is sufficient.

Common batching is legitimate only for evaluations at the same exact point with compatible accuracy requirements. A union of adaptive calls, including reevaluations at finer precision, cannot be replaced by a single nominal density without further evidence. The use of a call multiset and parameterized G, precision and cutoff correctly retains these costs.

The proposed shared-vertex key includes the conductor, primitive tuple, exact input vertex and stage. Reusing that value on all incident edges supports the accepted polygon connector proof and closed-seam assembly. A later stage is a new coherent certificate; incompatible vertex approximations from unrelated stages cannot be canceled as identical data. One may instead transport independently proved closed-cell propositions, but that is the separate cover route described by the slab theorem.

## Conditional convergence is not spectral truth

The refinement argument assumes, solely to prove eventual producer success, that every chosen full closed rectangle is actually zero-free for the relevant finite family. Continuity and compactness then give a positive minimum modulus, uniform over that finite family, though it need not be numerically known. The accepted derivative bound is uniform in the conductor rectangle. As both grid spacings and point-error targets tend to zero, the midpoint whole-panel bounds and the shared endpoint centers eventually fit strict coordinate half-planes. Each cell then has zero actual count, so the entire finite cover can pass.

This conclusion needs zero-freeness of the full region, not merely its outer boundary. Boundary-only nonvanishing permits a sound winding calculation with a positive count; it would not make the all-zero cell acceptance condition succeed. A zero on an internal seam would prevent its strict boundary packet from passing. The report correctly distinguishes these cases.

The target beta<=b permits a zero exactly on beta=b, whereas the closed exclusion protocol does not. Similarly T0>H creates a larger region that may contain a zero even if the requested height does not. Neither a strict spectral margin nor zero-freeness of that larger region is inferred from the height choice. The fair scheduling argument concerns finitely many conditionally successful tasks; it supplies no numerical stage bound or throughput estimate.

## Subsequent arbitrary-axis supplement and remaining work

Since the workload report was frozen, the arbitrary-length algorithm has been supplied at paper level in `integration/ARBITRARY_LENGTH_CHARACTER_DFT_2026-11-11.md`, SHA256 `FFF8C45E75DA6EF89D13E657C0E7C05713F861FCF7FFE47E87497C7ED624F5F1`, independently reviewed in `audit/REVIEW_ARBITRARY_LENGTH_CHARACTER_DFT_2026-11-11.md`, SHA256 `7DFADC932B61242CB39C8F840948ACCE8BED43A6F01D58860805A19B691BCA37`.

That supplement provides signed-kernel Bluestein padding, the three normalized-transform convolution identity with its required scale, deterministic error propagation, and a precision-refinement argument. It resolves the frozen report's stated missing paper bridge. It does not implement or measure the transform. Its normalization and actual-input error contract must still be applied when realizing the workload's proxy. The frozen report need not be edited to preserve this historical distinction.

The direct-evaluator input is independently reviewed at `major-constants/REVIEW_DIRECT_STRIP_EVALUATOR_CONVERGENCE_2026-11-11.md`, SHA256 `B357FCAC4F2FFFE9349A7872DB0EC0B86B02870EDA29FA5379C1749D98C4BD5E`. Its proof supplies a convergent fallback, not practical coefficients or a spectral margin.

Remaining work includes the actual function enclosures, required adaptive meshes and precisions, all complete per-character closed covers and counts, certified transforms and normalization, label/carrier adapters, storage and replay design, and Lean implementation. The arithmetic model correctly identifies batching opportunities without turning them into a performance or full-family proof claim.
