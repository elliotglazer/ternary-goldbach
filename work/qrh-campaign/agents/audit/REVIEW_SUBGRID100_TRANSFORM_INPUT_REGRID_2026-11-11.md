# Independent review of sub-grid100 input conversion

2026-11-11. PASS for the base paper and error-magnitude companion together, at conditional paper/source scope. No correction is requested. Their new input error can be included within the unchanged complete R108 ceiling. The sharper error bound V_error=8828 and retained capacity bound V_width=16384 concern the same actual stored vector and are compatible. This review selects no conductor precisions, runs no inventory or price fold, and proves no sign, count, implementation or cost saving.

Frozen authors, under `work/qrh-campaign/agents/independent-feasibility/`:

|Artifact|SHA256|
|---|---|
|SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md|B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266|
|SUBGRID100_ERROR_MAGNITUDE_COMPANION_2026-11-11.md|39EC80DDC3388A9E470647CC4486D448108BB1FFD0D4CC58C13B61FBE3A4A761|
|subgrid100_transform_input_regrid_20261111.py|472687A9316E2727AB1A15A195829FCE0FDF5CACDA3AE0C8DF1E8AD0098FF3D3|
|subgrid100_transform_input_regrid_20261111.json|829D99B26395FA8C9D0D4B4C89A2D04AE193BF39BEED5E7C762654AF3BC33A28|
|subgrid100_error_magnitude_20261111.py|9B316F1718C4695D3B45B18E02D565009CB303F712A18021CBA4AAF15E45A9E6|
|subgrid100_error_magnitude_20261111.json|AE3AAD40AB7DE3D4D537D263AE3FA7F13C99968794B10A5C9F6550DB556FD6C8|

I read both papers and scalar sources, the actual input bridge, stored-coefficient magnitude argument, intrinsic CT/tensor theorem, normalized-cache and context proofs, and the complete downstream error split. All twelve source pins in the base paper and the six artifact pins above match. No author code was imported or rerun. No function values, roots, coefficients, spectra or primes were evaluated; no builds, declarations, proof emission or frozen edits occurred.

## Actual input and one conversion

The current source evaluates a finite polynomial for the shifted Hurwitz contribution and separately supplies the head `(a/c)^(-s)`, with s=1/2+it. The canonical actual identity is `L(s,chi)=c^(-s) sum_a chi(a) zeta(s,a/c)`. The admitted alpha error concerns this exact character operator applied to the supplied finite-polynomial approximations. It already includes the source, finite translation, Taylor and evaluator errors; regridding is a new representation error and does not alter that analytic decomposition. No stronger per-coefficient true-fine-jet premise is introduced.

The base paper requires the original assembled vector to be on coordinate grid100. Its head must actually have that encoding and its retained enclosure. A small mathematical head radius does not prove the encoding. The proposed schedule forms the head-plus-polynomial sum exactly on that grid, then rounds the assembled sum once. Independent rounding of the two summands would need two error charges. A post-transform head attachment would need a different source and cost adapter. These restrictions are explicit and sufficient.

For p<100, d=100-p, the supplied signed equality

    n + 2^(d-1) = Q*2^d + t,    0<=t<2^d

implies `2(n-Q*2^d)=2t-2^d`, hence `-2^d<=2(n-Q*2^d)<2^d`. This proves nearest rounding with ties toward positive infinity, including negative inputs. Two coordinate errors of magnitude at most u/2 give squared complex error at most u^2/2, strictly below u^2. Thus rho_p=1 is a valid Euclidean-complex error coefficient. For p>=100 exact left-shift embedding gives rho_p=0. That branch is needed to preserve the old fallback without a fictitious conversion error.

The stated raw witness capacities are safe before the equality is accepted. The independent source-coordinate range is |n|<2^114, the destination range is |Q|<2^(p+14), and d<=20. Each raw side is below2^115 in absolute value. The smaller accepted rounding residual is not used to justify these capacities. The output range and unsigned t range remain separate representation obligations, not consequences trusted before checking the witness.

## Magnitude and the two V bounds

`STORED_HURWITZ_DEGREE_MAGNITUDE`, sections5–6, bounds actual delivered coefficients including finite translation and numerical errors, then the rounded Horner accumulator. Its H0<8192 applies to the selected full P20 interface with the admitted coordinate grids. It is not an assertion only about ideal analytic jets. The source comparison and complete alpha admission remain separate from this magnitude recurrence.

For the selected raw-head contract, the true head has norm at most sqrt(c)<633, and its center error is at most1. Thus its center is below634 and the exact assembled center is below8826. Regridding gives

    max |z'_a|+1 < 8827+rho_p*2^-p < 8828 < 16384

for every p in80..108. This proves the margin afresh. Merely knowing the old weak bound M+1<=16384 would not suffice after perturbing the input.

The intrinsic theorem is quantified over an arbitrary augmented magnitude bound V>=1, not only powers of two. Applying it with8828 and applying the peak theorem to the same vector with16384 are separate valid upper bounds. The companion retains the latter in every context width. It therefore credits no unsupported reduction of integer capacities. The ratio2207/4096 improves the intrinsic coefficient but is greater than1/2, so it gives no universal extra bit.

Full P20 is the sufficient selected source scope here. A shortened prefix, alternate FD output or other evaluator must separately provide its complete source-error, sample/guard domain, magnitude and grid100 export contracts. This review does not admit them just because an unrelated error radius is small.

## Exact transport and complete radius

Let T be the positive unnormalized character transform on all phi(c) unit inputs. Since every coefficient has modulus one,

    |T(z')-T(z)| <= sum_a |z'_a-z_a| <= phi(c)*rho_p*2^-p.

Multiplication by the exact conductor factor gives phi(c)/sqrt(c), with neither an extra tensor factor nor another normalization by phi. Primitive-output pruning does not reduce this input factor.

The intrinsic theorem is applied to the new stored vector z', so it adds `2*phi(c)*S*V_error*2^-p/sqrt(c)`. Uncertainty in the rounded normalized cache is already included under its stated cache contract. The total new allocation is therefore exactly the sufficient expression

    E_c = phi(c)/sqrt(c) * (17656*S+rho_p)*2^-p.

S is the complete ordered-plan axis sum, with repeated axes retained. This review consumes the old mixed constants and factor two. It does not automatically compose the separate sharper-C or sharper-tensor successors.

The companion's squared selector is equivalent to E_c<=Cg*2^-108 because all terms are nonnegative and c>0. Cg remains4196258524692480, using the old global Sg and16384. The larger bound on the right is intentional; replacing it by8828 would define a different target. With rho108=0 and V_error<=16384, the old p108 fallback survives. S=0 causes no division issue and leaves only the input conversion term when applicable.

The split at the exact transformed centers charges conversion once. It may be written as an increment to J or included in E_c, but not both. The retained A_alpha, head, pre-existing representation and conductor/formation terms then give

    rL <= E_c + 2^-82 + 4*2^-63.

The same preliminary exact-factor comparison bounds the new final transform center and supports the subsequent factor-error charge. It does not use an internal FFT peak as the final center bound. The independent inequalities `sqrt(c)<516`, `516*4033<2^21` and the old allowance bootstrap close that ordering.

Actual completion, inverse-character negative-height conversion, kernel errors and accumulation keep their separate tolerances and grids. With the exact-kernel split, their unchanged contribution is Rfixed and the input/transform contribution is135*E_c. I independently reconstructed

    (Rfixed+135*Cg*2^-108)/2^-45
      = 2804840254168152529/4294967296000000000
      < .653052762 < 691/1024.

The regrid therefore spends part of the old transform allocation, not an unknown sign margin. Every retained sample must remain in the admitted |t|<=7000 domain, with actual guard production and inverse-channel bindings. No previous center, sign bracket, central multiplicity or Turing surplus transfers to the new circuit automatically.

## Safety, caches and costs remain prerequisites

The intrinsic and peak proofs use u and explicit inequalities, not the numeral100. The old global D is below2^45 and twice the old global S is below2^30; hence the declared p80 floor satisfies those sufficient guards. The local guards remain part of acceptance. This establishes a valid research candidate range, not a mathematically minimal precision or an observed passing conductor.

The original semantic peak guard must remain alongside local D. In particular, normalized-kernel norm below one, point and inverse magnitudes, selected inverse output and final chirp all use the existing hypotheses. V_width stays16384. Coefficient grids, exact presums, raw products and final-round witnesses retain their separate widths. Subtracting bits from a historical rounded histogram is not a valid substitute for matching the saved context and new p.

A selected p requires root and rounded normalized-kernel records satisfying that p-specific enclosure contract, with the exact sums of the new centers. Higher-precision objects are not freely relabelled. The converter is paid per assembled residue input and source height, before sharing outputs across characters. Four signed witness additions per complex converter are only a core count; shifts, ranges, binding, allocation/traffic, producer splitting and theorem applications remain charged. Source/grid100 generation continues unchanged. A cost comparison also needs the actual sample union and cache lifetimes. None is enumerated or priced here.

The author correctly leaves this a conditional selector and source adapter. No cheaper complete schedule follows solely from a lower passing p. The review grants no fold or implementation authorization.

## Independent fixed checks

New checker `audit/review_subgrid100_regrid_20261111.py`, SHA256 `09A2EFA71744B03E5E2C59B2A4550AEA9665402E1E1E2DC2C7925398C7665DCB`, performs194 recorded fixed checks. They verify eighteen pins, all29 fixed p capacity/safety cases, the magnitude margin, six conditional scalar examples and the exact complete radius. The quantified signed converter and operator proofs are given above; finite checks do not replace them. No conductor, gate, coefficient or function-value inventory is read.

Its exclusive2908-byte receipt `audit/review_subgrid100_regrid_20261111.json` has SHA256 `2D1C1371FAD36BF6C8C682AB71AFDB9F8DFEA0C8A93C6BBBB35FCEC4705C95A0`. The checker also verifies its receipt-size cap before writing. All frozen authors and inputs remain unchanged. Ordinary-rule library implementation, source formalization and kernel validation remain open.
