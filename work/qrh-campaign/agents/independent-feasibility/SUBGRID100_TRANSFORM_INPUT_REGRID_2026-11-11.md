# Checked input regridding below transform grid100

2026-11-11. Conditional paper and fixed-rational research. This note admits a changed-input transform candidate on the finite precision range 80 through 108. It scans no conductor, plan, precision assignment or event inventory and evaluates no coefficient, root, transform, L-function, zero or prime. No declarations, builds, proof emission or frozen edits occurred. Independent review is required before consumption.

The exact-grid100 constraint is a representation convenience, not an analytic lower precision bound. A single checked regrid of each assembled input contributes at most `phi(c)/sqrt(c)*2^-p` after the exact character transform. This term is separate from intrinsic transform error. Both can fit within the same old global-p108 allowance under the rational selector below. The existing explicit input-magnitude margin keeps the augmented bound `V=2^14`, so this particular input adapter does not force an additional integer bit. This is neither a precision distribution nor a net-cost result.

## 1. Actual input and theorem being preserved

Use the selected large primitive-nonprincipal family and its unchanged original-order character map, finite heights and all required guard samples. The relevant source domain is `|t|<=7000`, `c<=265800`; the current large subfamily has `c>10000` with the retained odd/divisible-by-four restrictions. Let `s=1/2+it`, `nu=1/sqrt(c)`, and let

    T_chi(z) = sum_(a unit modulo c) chi(a) z_a.

This is the exact positive unnormalized transform, with `|chi(a)|=1`. The actual function is `L(s,chi)=c^-s T_chi(zeta(s,a/c))`. The polynomial source supplies a stored approximation to the shifted Hurwitz contribution; the actual raw finite head is `(a/c)^-s`. No positive-cosine proxy replaces the completed samples used for interpolation.

Fix original assembled centers `z_a` on coordinate grid `2^-100`, with their exact unit labels and heights. The original error contracts are retained:

    conductor-scaled polynomial radius A_alpha < 2^-82,
    conductor-scaled finite-head radius H <= 2^-63,
    pre-existing new assembly/representation radius J0 <= 2^-63.

`A_alpha` already includes the admitted source, finite-shift, Taylor and evaluation errors. It is not multiplied by 633 again. `J0` excludes the new regrid introduced here. Exact common-grid addition can have zero assembly error, but that saving is not spent in this note. Keep the old four-term downstream allowance intact.

Grid100 is an actual encoding premise. A small head radius alone does not establish it. The chosen raw-head producer must supply a grid100 center and its enclosure, or provide a separately proved conversion to grid100 within H/J0. The polynomial output must use its exact grid100 export. Only then form the raw sum exactly and regrid it once. Rounding the two summands independently is a different two-round schedule. An alternative circuit attaching the head after the transform needs its own binding and cannot inherit this raw-input proof without an adapter.

A grid100 head is compatible with the stated tolerances: its coordinate nearest rounding has Euclidean error below `2^-100`, much smaller than the sufficient pointwise head allowance `2^-73`. This leaves room for the analytic producer, but is not a certificate that the producer has supplied its remaining radius. All source/head generation and proofs remain paid.

## 2. Exact converter, including negative ties

For `80<=p<100`, put `d=100-p`, so `1<=d<=20`. A scalar source coordinate is `z=n/2^100`, with n an exact signed integer. Supply signed Q and an unsigned d-bit t satisfying

    n + 2^(d-1) = Q*2^d + t,       0<=t<2^d.             (1)

The new center is `Q/2^p`. Ordinary integer algebra gives

    -2^d <= 2(n-Q*2^d) < 2^d.

Thus each coordinate error is at most `2^-p/2`, including negative ties. The Euclidean complex error is at most `sqrt(1/2)*2^-p < 2^-p`. Using the relaxed bound `u_p=2^-p` agrees with the intrinsic complex-gate convention. There is no assumption that one coordinate's full error u is already a complex norm bound.

For `100<=p<=108`, use the exact embedding `Q=n*2^(p-100)` and error zero. Define

    rho_p = 1 if p<100, and 0 otherwise,
    z'_a = the converted center,
    |z'_a-z_a| <= rho_p*u_p.                              (2)

The zero indicator in the exact branch matters. Charging a fictitious positive conversion at p108 would unnecessarily perturb the exact old fallback ceiling.

Equation (1) uses shifts, not an arbitrary-denominator product. One ordinary implementation checks two signed additions per coordinate, exact concatenation/binding of `Q*2^d`, and the canonical unsigned range of t. It then applies a proved nearest-rounding lemma. Signed bridges, zero conventions, equality/header applications, digit-range evidence and input/output identity are separate costs. The producer still computes Q and t by signed splitting with the selected tie rule. The absence of long division does not make proof production free.

## 3. The stored-input margin retains V=2^14

The actual stored-degree argument and its independent review bound the consumed full polynomial center below 8192. The transform model's raw-head bridge uses

    |(a/c)^-s| = sqrt(c/a) <= sqrt(c) < 633,
    |head center - true head| <= 1.

The much tighter H requirement remains separate. Exact raw assembly therefore has `|z_a|<8826`. This note selects a producer with this bound, such as the admitted full P20 grid100 evaluator, rather than inferring it from an unrelated error radius. A shortened or differently encoded evaluator must supply its own admitted magnitude bound and source domain before joining.

By (2), for p in the declared range,

    |z'_a|+1 < 8827+u_p < 8828 < 16384 = V.               (3)

This is the new stored-center magnitude proof. It does not rely solely on the old weak statement `M_old+1<=16384`. That weak statement by itself would permit `M_new+1<=16384+u_p`, and a generic successor would need a larger V and freshly computed integer widths. The explicit raw-input margin is what prevents that extra width here.

For a converter capacity, `|n|<2^114` and the checked output may use `|Q|<2^(p+14)`. The two raw sides of (1) are each below `2^115` in absolute value before equality is accepted. Sufficient signed capacities are therefore 115 bits for the original source coordinate, p+15 for the destination coordinate, and 116 for either raw witness addition. The d-bit t is at most 20 bits. These are conservative capacities, not observed widths. Exact embedding instead shifts by at most eight bits. Independent range/encoding checks are required for supplied witnesses; small accepted residuals do not justify undersized raw additions.

## 4. Transport the new uncertainty once

The exact character operator gives

    nu*|T_chi(z')-T_chi(z)|
       <= nu*sum_a |z'_a-z_a|
       <= [phi(c)/sqrt(c)] rho_p u_p.                    (4)

There is no factor S in (4), no extra factor two, and no second normalization by phi. Input perturbation is propagated by the exact operator. Intrinsic error concerns the new stored vector z', so it uses (3).

Let `S=S_mixed(c)` be the sum of the accepted FULL-plan axis constants, with repeated axes counted repeatedly. Retain the actual local safety and old peak conditions

    2^p >= D_local(c),       2^p >= 2 S_old(c).            (5)

The old global fallback bounds are `D_global=29961461170177<2^45` and `2*S_old_global=849412408<2^30`. Hence every p>=80 satisfies them for the already bounded family, without a new inventory. The recurrence proof still needs (5) as acceptance premises. The lower endpoint 80 is a declared research range, not the mathematical minimum forced by safety.

The reviewed product-axis theorem, using its original factor two, bounds intrinsic conductor-scaled error by

    [phi(c)/sqrt(c)] 2 S V u_p.

The rounded normalized Bluestein cache preserves the same old C and D. Its uncertainty and scaling round are already included in this intrinsic term under its exact coefficient enclosure contract. Combining this term with (4) gives the selected allowance

    E_c(p) = [phi(c)/sqrt(c)] (2 S V + rho_p) 2^-p.        (6)

This note does not use pending sharper local C, tighter tensor products, shared-high-cache adapters or altered gate contracts. Those require separate reviewed composition. In particular the floor80 range must not silently inherit a tensor factor proved only for another floor.

## 5. Preserve the exact old R108 ceiling

Keep `Sg=202305920`, `V=16384`, and

    Cg = 1266*Sg*V = 4196258524692480,
    E108 = Cg*2^-108.

Require `E_c(p)<=E108`. All quantities are nonnegative, so a rational squared selector is exactly

    [phi(c)*(2 S V+rho_p)]^2 * 2^(2*(108-p))
         <= c * Cg^2.                                   (7)

Select the least p in the declared set `{80,...,108}` satisfying (5) and (7), only after the new converter, source and cache interfaces have been supplied. At p>=100, cancellation of `(2V)^2` recovers the previous exact-grid selector. At p108, rho=0, `S<=Sg` and `phi(c)/sqrt(c)<=633` ensure fallback availability under the unchanged family bounds. Thus this candidate does not lose old admissibility merely by extending the range.

No assignment scan is performed. For orientation only, replacing the exact conductor factor by 633 proves these conditional statements by fixed rational arithmetic: S<=2 admits p82; S<=12 admits p84; S<=771 admits p90. These are sufficient implications about hypothetical qualifying rows, not claims that any particular conductor or cost weight qualifies. The p80 test can fail for many plans. Its failure is not a lower bound on true rounding error.

In the actual L comparison split, replace the old intrinsic term by (6) while retaining the original source terms. Equivalently use `J=J0+nu*sum e_regrid` and the new intrinsic term, but do not add both that J increment and all of (6). The final sufficient L radius is

    rL <= E_c(p) + 2^-82 + 4*2^-63.                       (8)

The four terms retain head, original assembly, conductor-factor error against the final transform center, and final scaling. The usual preliminary comparison before approximating `c^-s` gives `|Shat_new|<516*4033<2^21`, and then `|Lhat_new|<4033`. This is not an internal FFT bound. Under (7) the identical old bootstrap applies. Even the deliberately looser global expression `(Cg+633)*2^-80` is below one and supplies the same intermediate magnitude bootstrap; the scalar receipt checks this separately without calling it precision admission.

Retain actual completion magnitude below 27, multiplier radius `2^-66`, formation radius `2^-54`, negative inverse-character damping radius `2^-72`, adapter round `2^-55`, 83 kernel radii `2^-72`, and accumulation `2^-51`. Their grids and producer costs are not lowered to p automatically. Let

    T = (927193523/10^9)*2^-46,
    Rfixed = T + 135*(2^-82+4*2^-63)
               +10*2^-54+93*2^-55+2^-51.

The same exact-kernel split and sample bounds give the complete interpolation radius

    Rnew <= Rfixed + 135 E_c(p)
          <= Rfixed + 135 E108 = R108.                   (9)

Its ratio to `2^-45` is exactly

    2804840254168152529 / 4294967296000000000
       < 0.653052762 < 691/1024.

Thus the regrid is paid within the replaced allowance, rather than silently weakening A_alpha or borrowing an unspecified sign margin. All guards still need actual samples. Equation (9) does not transfer any previous centers, strict signs, brackets, counts or Turing margins. New centers and their certified radii must pass the actual downstream tests.

## 6. Width, cache and cost consequences

Because (3) and (5) were re-established, the old augmented norm recurrences remain valid at the new p. At an exact local data factor aH, a sufficient magnitude capacity is

    p + ceil(log2(aH*16384)).                             (10)

The source margin justifies using 16384 in (10); it is not a subtraction from an old rounded width. Root coefficient capacity remains p+1. The reviewed rounded normalized-kernel coefficient has norm below one and capacity p, while its exact cached real sums require their additional bit. Presums, exact products, one-final-round witnesses and signed bridges retain the full width formulas of the chosen three- or four-product schedule. The postchirp bound still needs the inherited old semantic peak condition, not local D alone.

For example the normalized local contexts retain point data `(n+2)aV`, inverse input `(n(2n-1)/P+2)aV`, the exact radix-stage factors, and postchirp `2naV`. Their proof depends on u and the guards above, not on the arbitrary numeral 100. No phase multiplicities or width histogram is computed here. A future allowed fold must bind p to each saved context and its exact V/type/grid before pricing.

The converter is paid once per actual assembled residue input for each conductor and sample height, before sharing the transform across all output characters. It is not charged once per character output and is not a reusable numerical constant across heights. A cold schedule with selected precisions would have

    N_regrid = sum_(c with p(c)<100) phi(c)*J_actual(c)

complex conversions, where J_actual counts the actual source sample union, including applicable guards and auxiliary ranges, without duplicating shared samples. This is symbolic; no J values or total are asserted. Its checking cost includes four signed witness additions per complex input under (1), shift/range/term bindings, storage/traffic and theorem applications. Its generation cost includes constructing the quotient/remainder witnesses. Grid100 polynomial/head production and exact assembly remain unchanged bills. Savings in transform byte widths do not automatically pay this new cost.

At p>=100 the exact embedding is still charged as its actual shift/copy/proof schedule. A common input cache must identify conductor, exact height, unit order, original source object, destination p, rounding convention, radius and lifetime. An actual input vector can be shared only through checked identity. A hash or an assumed same numerical value is insufficient.

Roots and Bluestein caches must likewise satisfy the selected lower-p contract. Cache keys include the full plan, n/P, sign and angle identities, normalized variant, p, exact enclosure/rounding contract and lifetime. A p100 or p108 object cannot be relabeled as a lower-p object without a proved exact-finer-grid or rounded-cache adapter with its width/error costs. The selected contract here uses actual p-grid objects, including the two exact REAL sums of the newly stored normalized coefficients. Kernel FFT construction, scaled-cache rounds, sums, root generation and per-lifetime import costs remain paid. No cross-precision refund or cache-success claim is made.

A conditional decision inequality is therefore

    saved matched runtime proof/arithmetic cost
      > new input conversion cost + net new cache/setup cost
        + changed binding/traffic/generation cost.

Every term must use the same backend and cold or sunk convention. This note supplies no values for these terms. Neither a smaller selector p nor a sufficient full-error bound is an end-to-end performance result.

## 7. Fixed evidence and source pins

Owned companion `subgrid100_transform_input_regrid_20261111.py`, SHA256 `472687A9316E2727AB1A15A195829FCE0FDF5CACDA3AE0C8DF1E8AD0098FF3D3`, performs 391 checks. It hashes the twelve inputs below, checks the 29 fixed p cases, global safety and magnitude bootstraps, three conditional S implications, the exact R108 ratio, and signed synthetic rounding/tie identities for d1 through20. These are integer fixtures, not source values. Its first run succeeded. The exclusive 5064-byte receipt `subgrid100_transform_input_regrid_20261111.json` has SHA256 `829D99B26395FA8C9D0D4B4C89A2D04AE193BF39BEED5E7C762654AF3BC33A28`. No writer is imported. Fixed scalar checks supplement the paper proof; they do not prove the quantified theorem or a compiled implementation.

Paths are relative to `work/qrh-campaign/agents`, except the explicit blueprint row. The relevant sections were read directly.

|Source and consumed sections|SHA256|
|---|---|
|integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md, sections1–4: raw input, V, common grid and signed dyadic witness|DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C|
|audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md, sections2–4: actual L and exact input/operator split|96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D|
|audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md, sections2–5: source, scale, completion and kernel budgets|6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA|
|prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md, sections5–6: actual finite polynomial H0<8192|9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2|
|major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md: finite-source and numerical-error qualifications|1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6|
|zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md, sections1,3–5,7: stored-center theorem and exact operator transport|4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4|
|independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md, sections2–4: old C/D retained and peak guard|FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9|
|independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md: exact augmented local norm factors|412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7|
|integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md: error and context scope|09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA|
|major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md, sections1–4: old selector and cache contracts|1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A|
|independent-feasibility/REVIEW_CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md: prior mathematical review|15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2|
|work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md: complete R108 allocation and bootstraps|EEBC987DD386E2ED50CC7F56C82714FC1EF51C8A3DF22C2579FFC108C0C1BD39|

This establishes a source-compatible sufficient candidate with explicit new representation and error obligations. It does not lower source accuracy, select actual p assignments, produce inputs or roots, establish spectral success, alter principal/finite-coverage consumers, or estimate runtime. The next gate is independent paper review. Any metadata or price fold needs its own authorization and bounded saved-input design.
