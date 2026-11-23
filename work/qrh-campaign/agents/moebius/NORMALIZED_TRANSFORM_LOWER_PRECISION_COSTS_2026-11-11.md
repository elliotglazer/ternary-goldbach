# Lower-precision prices for the saved normalized transform

2026-11-11. Bounded integer-metadata fold, submitted for independent review. The normalized circuit and original byte-event template are unchanged. This packet prices p106 and p108 against p112 and p134; it selects no precision and supplies no numerical transform, sign or zero evidence.

The main three-product arithmetic cores are 4302622878721057430 at p106 and 4369084390425909710 at p108, compared with 4752826652495743914 at p112. These are declared product/addition template events, not verifier instructions or runtime. Setup, source binding, cache lifetimes and all unaffected proof work remain separate.

## 1. Conditional arithmetic interface

The companion `work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md`, SHA256 `EEBC987DD386E2ED50CC7F56C82714FC1EF51C8A3DF22C2579FFC108C0C1BD39`, supplies the proposed complete m41 error allocation. Its independent review is pending at this packet's freeze. I read it but do not duplicate its scalar proof here.

That companion retains the actual endpoint-normalized Y, primitive nonprincipal domain through conductor265800, sample heights in [-7000,7000], source grid100 and all nontransform producer tolerances. It proves conditionally that p108 gives radius below0.653052762*2^-45, improving the old691/1024 ceiling, and p106 gives radius below0.837311263*2^-45. The sufficient intrinsic safety conditions still hold. These are conditional radius bounds, not actual signs or a claim that the old numerical centers survive a precision change.

Our width model also retains V<=2^14, the input augmented-magnitude condition, common-grid roots and rounded scaled kernels, exact compatible cached sums, old local safety and the global C/S safety needed for the postchirp norm. Kernel exponent0 means center norm below1 on gridp; root exponent1 means its separate center magnitude bound. Neither is an augmented data bound. The saved normalized factors and their ceiling logarithms are consumed without alteration.

The accepted structural author is `independent-feasibility/NORMALIZED_BLUESTEIN_STRUCTURAL_COST_FOLD_2026-11-11.md`, hash `F673EFE298538627F30DEAFD2C7F5AFF9606BA468D887A76677E14FF5C963B46`. Its independent review is `major-constants/REVIEW_NORMALIZED_BLUESTEIN_STRUCTURAL_COST_FOLD_2026-11-11.md`, hash `49D7AA3C7D292C9A6018B178480BE8E0213C2A0725D6042D8EDC0A8C65F3B86C`. Their analytic and source interfaces retain their prior scopes.

## 2. Exact bounded fold and old-result reconstruction

The only workload inputs are the saved normalized event histogram, 18684197 bytes, SHA256 `721050210472999DB469728A0426FECDADD4D82F404C6302CA2B635F3551B7B2`, and its89710-byte cost receipt, SHA256 `F91A9966E4905B187DA01583DD993257EA94591B483E148903216158672559C3`. Both are under `agents/independent-feasibility`; here agents means `work/qrh-campaign/agents`.

The coordinator approved at most125279 event classes,20 weights,133 folded width classes,24 MiB event input,90 KiB receipt and256 KiB output. An additional approved setup fold reads only the6004 saved kernel lengths. No manifest, conductor interval, factorization, requested-output DAG, unit residue or numerical value is regenerated.

The script verifies the pins, schema, sorted unique keys, all twenty nonnegative integer weights, coefficient-key meanings and absence of runtime scale events. Folding by category/data exponent/coefficient exponent/divisor exponent gives exactly133 width classes. All20 category dictionaries match the saved receipt. Roots, kernels, additions, quarter turns and negations retain their complete counts. Zero scale count does not erase the positive kernel-product count.

Before pricing new candidates, all16 p112/p134 product-choice/scenario dictionaries, their complete five-band component dictionaries and their setup amounts reproduce exactly. The four extra-prefix scenarios0/167/320/640 are alternatives, never summed as one campaign. Their spectral/repair sufficiency is outside this count.

The6004 saved lengths compress into14 coefficient-exponent classes weighted by the corresponding saved padded-length formula. They preserve337702368 entries. The old p112/p134 setup amounts match before lower-p setup is priced. No full-plan traversal occurs.

## 3. Matched byte-template prices

For a magnitude capacity b define A(b)=2*ceil(b/8)+1. For two capacities a,b, let m=max(ceil(a/8),ceil(b/8)), n=min(...), and M(a,b)=5mn+2n+1. These are the original conditional ordinary byte-event templates, with their separately required PA proof/binding producers. Named digits, zero-carry cell specializations and generalized radices are not substituted.

For a saved data exponent e and coefficient exponent f, set a=p+14+e and b=p+f. A three-product gate costs

    M(a+1,b)+2M(a,b+1)
    + A(a+1)+2A(a+b+2)+4A(a+b+4).

The four-product alternative costs

    4M(a,b)+2A(a+b+1)+4A(a+b+3).

The last terms retain the complete two-coordinate round witnesses. Standalone complex addition costs2A(a+1), preserving the earlier conservative extra bit. Signed/canonical/range/shift/encoding/binding work is additional. Quarter turns and negations retain their counts even though this arithmetic core assigns them no product/addition fee.

|p|Main three-product core|Main four-product core|
|---:|---:|---:|
|106|4302622878721057430|5497947567811350526|
|108|4369084390425909710|5583351408270750462|
|112|4752826652495743914|6066519651827047594|
|134|6124737322160821530|7881643777228454202|

The three-product alternative scenarios are:

|Extra nodes|p106|p108|p112|p134|
|---:|---:|---:|---:|---:|
|0|4302622878721057430|4369084390425909710|4752826652495743914|6124737322160821530|
|167|4390693100273759084|4458497676372029028|4850073760624414758|6250018780057348826|
|320|4471380189480725270|4540415237747814990|4939168416574634154|6364797600764945690|
|640|4640137500240393110|4711746085069720270|5125510180653524394|6604857879369069850|

The receipt contains all32 precision/product-choice/scenario totals, all band-component dictionaries and the corresponding four-product alternatives. It preserves exact rational ratios rather than inferring a smooth precision scaling law across byte thresholds.

At p106 three-product data magnitude capacities range122..155, coefficient capacities106..107, raw capacities231..264 and round-witness capacities233..266. At p108 the corresponding ranges are124..157,108..109,235..268 and237..270. Signed storage needs its additional sign convention/bit. These capacities price the existing witness schedule; they are not actual operand measurements.

## 4. Setup and complete comparison

Let S_p be the scaled-cache rounding addition core and Q_p the two exact NEW coefficient-sum addition cores. For kernel exponent e and entry multiplicity E_e,

    S_p = sum_e E_e*4A(p+e+2),
    Q_p = 337702368*2A(p+1).

|p|S_p|Q_p|S_p+Q_p|
|---:|---:|---:|---:|
|106|44564363392|19586737344|64151100736|
|108|44575881344|19586737344|64162618688|
|112|47118457984|20937546816|68056004800|
|134|54173640064|23639165760|77812805824|

Three-product mode pays S_p+Q_p; four-product mode pays S_p. These are per construction/checking lifetime of the declared normalized cache. The old unscaled-sum amounts are retained in the receipt solely to reproduce predecessor setup diagnostics. They are not subtracted in this cross-precision normalized-to-normalized comparison.

Kernel FFT setup still has2244782056 general complex products,5502647200 additions and168845180 quarter turns. The337702368 kernel entries,140276846 chirp entries and other saved setup counts remain in the receipt. These counts stay fixed, but their arithmetic widths, certificates and generation/checking costs can change with p. They are not free or automatically equal costs. Root/chirp coefficient sums, enclosures and source objects outside Q_p remain additional work.

For one product mode and scenario write P_p,A_p for the runtime product/addition cores. With common declared event prices alpha,beta, cache lifetime count ell_p and U_p for all remaining costs, compare

    C_p = alpha*P_p + beta*A_p
          + beta*ell_p*(S_p + [three-product mode]*Q_p) + U_p.

Use a separate such functional for generation, proof production and ordinary checking. U_p includes kernel/root/chirp setup at the actual precision, signed and range witnesses, representation and source bindings, cache reconstruction/storage/imports, cheap-event proofs, unaffected numerical work and the full analytic foundation. If prices depend on operand widths or categories, replace the two common prices by a functional on the saved width/component classes. No omitted cost is set to zero.

For example, comparing p108 with p112 in the main three-product scenario with one newly constructed cache each gives the condition

    U_108-U_112
      < alpha*366515505176327696
        + beta*(17226756893506508+3893386112).

If the p112 cache is already paid and reusable, its future setup lifetime is zero. Then the right side instead pays the full64162618688 new p108 setup core, rather than claiming the3893386112 cold difference as a refund. Precision-specific caches are not interchangeable without a separately proved conversion/enclosure contract.

Three-versus-four comparisons at a fixed p must also pay Q_p and all differing proof/caching costs. Their smaller runtime subtotal alone cannot decide that comparison. The receipt records both modes rather than adopting one.

## 5. Evidence and limits

Owned `normalized_transform_precision_costs_20261111.py` has SHA256 `81983D037823346DA54553F7DF467A9139983C71DE6568DF9040BDA5677215C0`; its107410-byte receipt has SHA256 `C3AC1C06BFDCB2931FA24F8EF9AFC7E84A88FA00AF3D5500C7657CC665A219D4`. The run passed3360882 checks including the final output-cap check; the receipt records3360881 before that last check. Both files are under agents/moebius and were written exclusively. The script imports no earlier writer or evaluator.

The math companion is a separately pinned pending-review dependency. This fold supplies no additional arithmetic-error theorem and no successful endpoint or sign test. Complete interpolation, canonical/inverse phases, Turing counts, repairs, principal RH, finite binary coverage and final proof closure remain required. New precision means new compatible centers and strict-sign checks, even when its proved radius is smaller. No source or frozen artifact was edited, and no build, proof emission, analytic/prime/transform evaluation or production scan occurred.
