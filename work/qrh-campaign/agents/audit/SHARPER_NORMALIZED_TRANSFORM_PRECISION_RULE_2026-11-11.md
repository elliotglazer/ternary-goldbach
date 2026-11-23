# Sharper normalized-transform precision through the ordered circuit

2026-11-11. Conditional mathematical successor, submitted for independent review. The sharper Bluestein constant already proved for the rounded normalized cache composes through the existing ordered CT and tensor arguments. It can replace the mixed-axis error sum in the reviewed conductor-local selector while preserving its exact complete p108 radius. The selected safety and peak guards remain unchanged. No inventory was parsed or folded, no plan or numerical value was generated, and no precision distribution, operation saving or runtime claim is made.

Paths below are relative to `work/qrh-campaign/agents` except the named blueprint paper. This note changes no frozen artifact, source declaration or accepted sample value.

## 1. Fixed circuit and local leaf theorem

The conductor-local preflight is `major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md`, hash `1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A`, reviewed at `independent-feasibility/REVIEW_CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md`, hash `15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2`. It retains one common p(c) for each conductor's whole transform, across its characters and sample heights. The selected full ordered plan, primitive-output pruning and exact labels are unchanged here.

For stored input centers x with sup norm at most M, write V=M+1. Every required root/chirp approximation has complex error at most u=2^-p, and every rounded complex gate has absolute complex arithmetic error at most u on its stored operands. Intrinsic error is measured against the exact DFT of those stored centers. Analytic/source uncertainty remains a separate exact-operator term. The computed DFT is unnormalized; division by its length in the error theorem is not a new runtime gate.

At a Bluestein leaf n>=2, put

    m=2n-1, P=2^k=nextPowerOfTwo(m), R=2k+4, A=1+3R,
    Q=3nPA+1,
    D_B=max(1,2k,PA,Q).

Thus 2n<=P<4n and R>=8. Use the actual rounded normalized cache

    Ktilde=Round_u(Khat/P)

on grid p, with the original kernel producer satisfying `|Khat-K|<=PAu`. Both kernel error and the new scaling round are retained: `|Ktilde-K/P|<=(A+1)u`. An exact scaled cache on grid p+k is a different representation and is not substituted.

The accepted normalization paper `independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md`, hash `FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9`, sections 1–3, and its review `integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md`, hash `09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA`, prove the following under 0<u<=1/D_B.

The data forward error is at most PAuV. Retaining both operand errors and their cross term gives point error at most q*uV, where q=3nA+n+2. The inequalities

    Q-P(A+1)=(3n-1)PA-P+1>0,
    Q-q=3nA(P-1)-n-1>0

give the required cache and point safety, including `|Ktilde|<2n/P<=1`. The unnormalized inverse amplifies point error by P, and its own radix error gives

    e_I <= [Pq+R(nm+2P)]uV.

There is no runtime division after this inverse. After the final chirp, the normalized output error is at most C_exact*uV, with

    C_exact=(3/2)[Pq+R(nm+2P)]/n+(n+1)/n.

Define the integer coefficient

    C_B_sharp=9PA/2+3P/2+3Rn+12R+14.                 (B)

P is even, so the halves introduce no rounding. Clearing denominators gives

    2n(C_B_sharp-C_exact)
      =R(27n-6P)+26n-6P-2>0.

The strict inequality follows from P<4n, n>=2 and R>=8. For the legacy Bluestein coefficient `C_B_old=6PA+2R(2n+1)+8`,

    C_B_old-C_B_sharp=R(9P/2+n-10)-6>=74.           (D)

Hence the sharper leaf satisfies the same intrinsic theorem under the same D_B. This is the explicit stronger conclusion of the existing proof, not a new cache producer or an inference from narrower widths. The weaker old C remains available for peak arguments.

## 2. Ordered CT induction, including safety

Define a new pair `(C_sharp,D_sharp)` on the SAME full plan. Identity, radix-two and direct leaves retain their reviewed pairs: `(0,1)`, `(2k+4,max(1,2k))` for nonidentity length 2^k, and `(2,1)` for a selected direct leaf. A Bluestein leaf uses `(C_B_sharp,D_B)`.

For an ordered split n=rm, with length m evaluated first and length r second, use

    C_sharp(n)=C_sharp(m)+C_sharp(r)+2,
    D_sharp(n)=max(D_sharp(m),D_sharp(r),1,
                  C_sharp(m)+C_sharp(r)*(2C_sharp(m)+1)).     (CT)

This is the actual orientation in the mixed proof, section 3, and in `zero-sum/mixed_radix_precision_metadata_20261111.py:88–107`. No source writer is imported or executed here.

For completeness, write a=C_sharp(m), b=C_sharp(r). After the first child and twiddle, its error divided by m is at most uV*d, with d=a(1+u)+1. The second child contributes at most b*uV*(1+u*d) after division by rm. Together the coefficient is bounded by

    a+b+1+u*(a+b*d).

Since u<=1, d<=2a+1. The last term in D_sharp ensures `u*(a+b*(2a+1))<=1`, yielding a+b+2. This retains child/coefficient cross terms and is valid for arbitrary stored inputs satisfying the local bound. No multiplicity or axis-length factor is discarded from an unnormalized computation; they cancel only in the normalized error statement.

Let `(C_mix,D_mix)` be the old mixed pair for that same full plan. Then

    C_sharp(n)<=C_mix(n),  D_sharp(n)<=D_mix(n)       (M)

by structural induction. The C claim uses (D) and addition. For the nontrivial safety expression f(a,b)=a+b(2a+1), increasing a,b by nonnegative x,y changes it by

    x(1+2b)+y(2a+1)+2xy>=0.

Children's maxima preserve the D inequality. This is a pointwise comparison against the SAME mixed plan. It does not assert the generally false pointwise comparison between mixed D and the whole-axis baseline D; the old n=598 qualification remains untouched.

The C reduction also has an exact symbolic description: a CT split adds the two child reductions, and an unchanged leaf adds zero. Thus each Bluestein leaf's positive reduction in (D) is summed along its ordered tree roles. Repeated child roles count twice where the error recurrence has two roles. This is not weighting by the number of runtime lines, characters, heights or operation occurrences. A future error fold must not import those workload multiplicities into C.

Exact same-grid additions have error zero, which satisfies the retained <=u assumption. This note does not reduce radix or CT constants for exact additions, alter a three-product circuit, or assign those additions zero proof or storage cost. No new exact-addition theorem is needed for this improvement.

## 3. Retained peak guards and the tensor bound

For the saved ordered outer axes n_i of conductor c, including repeated axes, put

    S_sharp(c)=sum_i C_sharp(n_i),
    S_mix(c)=sum_i C_mix(n_i),
    S_base(c)=sum_i C_whole_axis_baseline(n_i).

The tree proof gives S_sharp<=S_mix. The already reviewed selected-family comparison gives S_mix<=S_base. The latter is inherited from the pinned preflight, not newly asserted for arbitrary plans or conductor families.

The selected drop-in rule KEEPS the preflight guards:

    p>=100,
    2^p>=D_local_old(c),
    2^p>=2*S_base(c),                               (G)

where D_local_old is the maximum of one and the saved mixed and baseline axis D values. This covers D_sharp by (M) while keeping every old local denominator available. Alternatively retain the old global checks

    2^p>=29961461170177,
    2^p>=2*424706204.

Both hold for p>=100 on the admitted saved family. They remain explicit guards, not results of this no-inventory task. No smaller safety threshold is selected here even though D_sharp is a valid intrinsic recurrence.

The distinction matters for widths. The accepted peak proof uses semantic bounds `|computed D_n|+1<=n(1+C_mix(n)u)*aV`, and the normalized postchirp proof retains `C_B_old*u<=1/2`. The old S_base guard supplies those descendant bounds through the admitted axis comparisons. Keeping only D_sharp or silently replacing S_base by S_sharp would require a separately stated peak argument. We retain the old proof as written.

Consequently CT second children still receive at most 2m*aV, outer-axis contexts still use twice the full preceding-axis product, and normalized Bluestein inverse/postchirp factors remain `Z_s=nm/P+2` and 2n. The cache norm below one still requires D_B. P-specific internal radix safety is also inside D_B. Root coefficients, raw products, presums, exact sums and round witnesses keep their distinct capacities; smaller C is not itself a smaller magnitude bound.

For intrinsic tensor error, let E_i denote normalized error after the first i axes. The exact normalized operators have sup norm at most one. Applying a child bound to the stored intermediate and dividing its input scale by the full preceding-axis product gives

    E_(i+1)<=E_i+C_sharp(n_(i+1))*u*(V+E_i).

The extra unit term is safe because the preceding product is at least one. Induction yields

    E_final<=V*[product_i(1+C_sharp(n_i)u)-1]
           <=2*S_sharp(c)*V*u,                    (T)

using S_sharp*u<=S_base*u<=1/2. This is the same finite-product argument as the source. It does not normalize the runtime circuit. Restoring its full size phi(c), then multiplying by the EXACT conductor factor of magnitude 1/sqrt(c), gives

    epsilon_sharp(c,p)
      =2*phi(c)*S_sharp(c)*2^14*2^-p/sqrt(c),       (E)

under the unchanged stored-input condition V<=2^14. Primitive-output counts do not replace phi(c). Uncertain input, head/assembly error and approximation of the conductor factor remain separate.

## 4. Drop-in precision selector and complete radius

Set S_g=202305920 and C_g=1266*S_g*2^14=4196258524692480. Replace ONLY S_mix by S_sharp in the preflight's nine-candidate test:

    p in {100,...,108}, guards (G),
    (2*phi(c)*S_sharp(c))^2 * 2^(2*(108-p))
        <= c*(1266*S_g)^2.                         (P)

The two sides before squaring are nonnegative, so (P) is equivalent to `epsilon_sharp(c,p)<=C_g*2^-108`. No square-root evaluation is required. The case S_sharp=0 needs no division by S; the intrinsic transform is exact and the remaining interfaces still apply.

The old preflight's passing p also passes (P), with the same guards, because S_sharp<=S_mix. Thus the least admitted p cannot increase. p108 remains a fallback on the same valid rows. A plan containing a Bluestein leaf has a strictly smaller symbolic S, but that does not guarantee a lower integer p or a lower total price. No saved row or frequency was tested here.

The simple old sufficient class S<=790257 still admits p100 since `256*790257<202305920`. It now applies to S_sharp. The exact conductor-factor test can be stronger, but no new qualifying-conductor count is asserted.

Keep all nontransform producer tolerances and actual endpoint-normalized Y from `work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md`. Its fixed radius allocation is

    T=(927193523/10^9)*2^-46,
    R_fixed=T+135*(2^-82+4*2^-63)
              +10*2^-54+93*2^-55+2^-51.

The same complete bound is

    R_sharp(c,p)=R_fixed+135*epsilon_sharp(c,p)
        <= R_fixed+135*C_g*2^-108.

Its ratio to 2^-45 is exactly

    2804840254168152529/4294967296000000000
       <0.653052762<691/1024.

This preserves the stronger p108 complete ceiling, not only an isolated transform allowance. The full alpha bound remains 2^-82 and is charged once. Head, assembly, conductor factor, actual phase/Gamma completion, negative inverse-character damping, sample/kernel uncertainty and finite accumulation retain their separate source contracts. The previous common 2^-51 sample bound is not silently reused at a lower p. The ordered magnitude proof remains valid because the new intrinsic allowance never exceeds the same global-p108 allowance.

The domain is the preflight's actual primitive nonprincipal large branch through c<=265800, with the unchanged selected axes, actual input centers and all required sample heights in [-7000,7000]. The +41 guard maximum 26525/4 is compatible, but this note produces no guards and folds no guard weights. One p(c) covers all relevant positive samples and inverse-character samples of that conductor. Each interpolation query therefore consumes the same uniform bound without a heterogeneous-within-transform theorem. The exact source grid100 export embeds for p>=100; lowering p below100 is outside this rule.

## 5. Cache binding, future metadata and limits

The new error coefficient is available only for occurrences that actually use the normalized rounded-cache variant. A mixed implementation must attach the applicable leaf coefficient to each occurrence. Applying C_B_sharp to an old unnormalized leaf or an unproved cache import would be unsound. This note selects the uniform normalized variant already covered by the accepted structural fold.

Every cache key must retain the exact plan, n, P, chirp/direction, normalization variant, p, rounding policy, enclosure contract and lifetime. The supplied kernel producer must satisfy its PAu error at that p; the scaled round and exact sums of the NEW centers must be bound. A lower-precision cache cannot be relabeled, and an exact finer-grid cache cannot be priced as the rounded grid-p cache. Kernel setup errors are charged at each use, while production/checking costs follow actual cache lifetimes. Smaller C does not weaken these premises.

A future authorized saved-data pass could derive the new pair once per saved full-plan node, using (B) and the ordered recurrence (CT), check (M) against the saved legacy pair, then sum the repeated outer axes and apply (P). It must retain the old baseline safety/peak fields, exact plan association and p-specific caches. The old axis record field called `new_C` means the previous mixed C, not this successor. No mutation or silent reinterpretation of that field is permitted. Updated widths, cache duplication, setup and all original/guard scenario associations require their own bounded price fold. None occurred here.

The conclusion is a sound derived recurrence and symbolic selector improvement. Actual numerical centers will depend on the chosen p and certified cache. Their strict signs, central/multiple-zero handling, Turing closure and final proof implementation remain unestablished. No bit savings, gate counts, proof volume or runtime savings are inferred.

## 6. Exact evidence and source pins

The companion `audit/sharper_normalized_transform_precision_20261111.py`, SHA256 `3DC029F54A98735C1B5491DA9EF62B879F0085AF5CF62898418D5B40ADCA70E4`, checks five formal polynomial identities, the fixed radius and scalar guards, and nine source hashes. Its 23 assertions pass. The exclusive 1,808-byte receipt `audit/sharper_normalized_transform_precision_20261111.json` has SHA256 `0A1D5A6E57A6D1036CD7916422AE4C51D83ED6C8F642C5C2C7BB65871BC87B30`. It reads no metadata inventory and imports no author program. The general induction and inequalities are proved above, not extrapolated from numerical examples.

|Source|SHA256|
|---|---|
|zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md, sections 1–5|4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4|
|zero-sum/mixed_radix_precision_metadata_20261111.py, coefficient definitions only|3750A9C8FD77163C878694959158762D183F1425E4F85F983230A841BAEBDC42|
|independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md, sections 1–3|5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A|
|independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md|FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9|
|independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md|412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7|
|integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md|09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA|
|major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md|1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A|
|independent-feasibility/REVIEW_CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md|15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2|
|work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md|EEBC987DD386E2ED50CC7F56C82714FC1EF51C8A3DF22C2579FFC108C0C1BD39|
